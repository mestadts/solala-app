import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/animal_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../../core/utils/animal_id_generator.dart';
import '../../data/datasources/local_animal_datasource.dart';
import '../../data/datasources/remote_animal_datasource.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

// ── Current org (= Firebase UID for Phase 10 — Phase 12 adds multi-org) ───────

final currentOrgIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).valueOrNull?.uid;
});

// ── AnimalIdGenerator ─────────────────────────────────────────────────────────

final animalIdGeneratorProvider = Provider<AnimalIdGenerator>((ref) {
  return AnimalIdGenerator(ref.watch(firestoreProvider));
});

// ── Live animals stream (from Isar) ──────────────────────────────────────────

final animalsStreamProvider = StreamProvider<List<MockAnimal>>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref.watch(localAnimalDatasourceProvider).watchAll(orgId);
});

// ── Single animal by string id ────────────────────────────────────────────────

final animalByIdProvider = Provider.family<MockAnimal?, String>((ref, id) {
  final list = ref.watch(animalsStreamProvider).valueOrNull;
  if (list == null) return null;
  try {
    return list.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
});

// ── Offspring (animals whose damId matches the given animal id) ───────────────

final offspringByAnimalProvider = Provider.family<List<MockAnimal>, String>((ref, damId) {
  final list = ref.watch(animalsStreamProvider).valueOrNull ?? [];
  return list.where((a) => a.damId == damId).toList()
    ..sort((a, b) => b.dateOfBirth.compareTo(a.dateOfBirth));
});

// ── Animal CRUD actions ───────────────────────────────────────────────────────

class AnimalActions {
  AnimalActions({
    required LocalAnimalDatasource local,
    required RemoteAnimalDatasource remote,
    required SyncQueueManager syncQueue,
    required AnimalIdGenerator idGen,
    required String orgId,
    required bool isOnline,
  })  : _local    = local,
        _remote   = remote,
        _syncQueue = syncQueue,
        _idGen    = idGen,
        _orgId    = orgId,
        _isOnline = isOnline;

  final LocalAnimalDatasource _local;
  final RemoteAnimalDatasource _remote;
  final SyncQueueManager _syncQueue;
  final AnimalIdGenerator _idGen;
  final String _orgId;
  final bool _isOnline;

  /// Creates a new animal. Returns the generated systemAnimalId.
  Future<String> createAnimal(MockAnimal animal) async {
    // 1. Generate systemAnimalId
    String systemId;
    if (_isOnline) {
      try {
        systemId = await _idGen.generate();
      } catch (_) {
        systemId = AnimalIdGenerator.generateLocal();
      }
    } else {
      systemId = AnimalIdGenerator.generateLocal();
    }

    // 2. Build the local model
    final model = animal.toLocalModel(_orgId)
      ..systemAnimalId = systemId
      ..isSynced = false
      ..pendingOperation = 'create';

    // 3. Save to Isar
    await _local.saveModel(model);

    // 4. Sync to Firestore (or enqueue)
    if (_isOnline) {
      // If we fell back to a LOCAL id (e.g. Firestore txn failed on first try),
      // make one more attempt to get a proper id before writing to Firestore.
      if (systemId.startsWith('HQ-LOCAL-')) {
        try {
          final realId = await _idGen.generate();
          systemId = realId;
          model.systemAnimalId = realId;
          await _local.saveModel(model);
        } catch (_) {
          // Keep the LOCAL id — sync queue will upgrade it later.
        }
      }
      try {
        await _remote.create(model);
        model
          ..isSynced = true
          ..pendingOperation = null;
        await _local.saveModel(model);
      } catch (_) {
        await _enqueue('create', model);
      }
    } else {
      await _enqueue('create', model);
    }

    return systemId;
  }

  /// Updates an existing animal.
  Future<void> updateAnimal(MockAnimal animal) async {
    final existing = await _local.findById(animal.id);
    final model = animal.toLocalModel(_orgId)
      ..isSynced = false
      ..pendingOperation = 'update';
    if (existing != null) {
      model
        ..isarId   = existing.isarId
        ..createdAt = existing.createdAt
        ..systemAnimalId = existing.systemAnimalId;
    }

    await _local.saveModel(model);

    if (_isOnline) {
      try {
        await _remote.update(model);
        model
          ..isSynced = true
          ..pendingOperation = null;
        await _local.saveModel(model);
      } catch (_) {
        await _enqueue('update', model);
      }
    } else {
      await _enqueue('update', model);
    }
  }

  /// Deletes an animal (soft-delete locally, hard-delete on Firestore).
  Future<void> deleteAnimal(String id) async {
    await _local.markDeleted(id);

    if (_isOnline) {
      try {
        await _remote.delete(_orgId, id);
        await _local.hardDelete(id);
      } catch (_) {
        await _syncQueue.enqueue(
          entityType: 'animals',
          entityId: id,
          operation: 'delete',
          payload: {'orgId': _orgId},
        );
      }
    } else {
      await _syncQueue.enqueue(
        entityType: 'animals',
        entityId: id,
        operation: 'delete',
        payload: {'orgId': _orgId},
      );
    }
  }

  Future<void> _enqueue(String operation, AnimalLocalModel model) =>
      _syncQueue.enqueue(
        entityType: 'animals',
        entityId: model.id,
        operation: operation,
        payload: _modelToPayload(model),
      );

  Map<String, dynamic> _modelToPayload(AnimalLocalModel m) => {
        'id': m.id,
        'orgId': m.orgId,
        'systemAnimalId': m.systemAnimalId,
        'name': m.name,
        'species': m.species,
        'gender': m.gender,
        'breed': m.breed,
        'dateOfBirth': m.dateOfBirth,
        'weight': m.weight,
        'status': m.status,
        'breederTag': m.breederTag,
        'colorId': m.colorId,
        'tagNumber': m.tagNumber,
        'photoUrl': m.photoUrl,
        'speciesAttributesJson': m.speciesAttributesJson,
        'penId': m.penId,
        'ageClassId': m.ageClassId,
        'purpose': m.purpose,
        'price': m.price,
        'weaningFromDays': m.weaningFromDays,
        'weaningToDays': m.weaningToDays,
        'officialTagNumber': m.officialTagNumber,
        'createdAt': m.createdAt.toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
}

final animalActionsProvider = Provider<AnimalActions>((ref) {
  return AnimalActions(
    local: ref.watch(localAnimalDatasourceProvider),
    remote: ref.watch(remoteAnimalDatasourceProvider),
    syncQueue: ref.watch(syncQueueManagerProvider),
    idGen: ref.watch(animalIdGeneratorProvider),
    orgId: ref.watch(currentOrgIdProvider) ?? '',
    isOnline: ref.watch(isOnlineProvider),
  );
});
