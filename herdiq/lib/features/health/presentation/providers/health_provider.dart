import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/health_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/mock/mock_providers.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../../breeding/presentation/providers/breeding_provider.dart';
import '../../data/datasources/local_health_datasource.dart';
import '../../data/datasources/remote_health_datasource.dart';

// ── Live health records by animal ─────────────────────────────────────────────

final healthByAnimalProvider =
    StreamProvider.family<List<MockHealthRecord>, String>((ref, animalId) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref
      .watch(localHealthDatasourceProvider)
      .watchByAnimal(orgId, animalId);
});

// ── All health records for org (health overview) ──────────────────────────────

final allHealthStreamProvider = StreamProvider<List<MockHealthRecord>>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref.watch(localHealthDatasourceProvider).watchAll(orgId);
});

// ── Unified upcoming events (replaces mockUpcomingAllEventsProvider) ──────────

final upcomingEventsProvider = Provider<List<MockUpcomingEvent>>((ref) {
  final healthRecords =
      ref.watch(allHealthStreamProvider).valueOrNull ?? [];
  final breedingRecords =
      ref.watch(allBreedingStreamProvider).valueOrNull ?? [];
  final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
  final animalById = {for (final a in animals) a.id: a};
  final now = DateTime.now();
  final events = <MockUpcomingEvent>[];

  for (final r in healthRecords) {
    if (r.nextDueDate != null &&
        (r.recordType == 'vaccination' || r.recordType == 'deworming')) {
      final animal = animalById[r.animalId];
      events.add(MockUpcomingEvent(
        type:           r.recordType,
        title:          r.title,
        animalSystemId: animal?.systemAnimalId ?? '',
        dueDate:        r.nextDueDate!,
      ));
    }
  }

  for (final r in breedingRecords) {
    final d = DateTime.tryParse(r.deliveryDate);
    if (d != null && d.isAfter(now) && r.offspringCount == 0) {
      events.add(MockUpcomingEvent(
        type:           'birth',
        title:          r.damName ?? '',
        animalSystemId: r.damSystemId ?? '',
        dueDate:        r.deliveryDate,
      ));
    }
  }

  events.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  return events;
});

// ── HealthActions ─────────────────────────────────────────────────────────────

class HealthActions {
  HealthActions({
    required LocalHealthDatasource local,
    required RemoteHealthDatasource remote,
    required SyncQueueManager syncQueue,
    required String orgId,
    required bool isOnline,
  })  : _local     = local,
        _remote    = remote,
        _syncQueue = syncQueue,
        _orgId     = orgId,
        _isOnline  = isOnline;

  final LocalHealthDatasource _local;
  final RemoteHealthDatasource _remote;
  final SyncQueueManager _syncQueue;
  final String _orgId;
  final bool _isOnline;

  Future<void> addRecord(MockHealthRecord record) async {
    final model = record.toLocalModel(_orgId)
      ..isSynced         = false
      ..pendingOperation = 'create';
    await _local.saveModel(model);

    if (_isOnline) {
      try {
        await _remote.create(model);
        await _local.markSynced(record.id);
      } catch (_) {
        await _enqueue(model);
      }
    } else {
      await _enqueue(model);
    }
  }

  Future<void> _enqueue(HealthRecordLocalModel model) =>
      _syncQueue.enqueue(
        entityType: 'healthRecords',
        entityId:   model.id,
        operation:  'create',
        payload: {
          'id':              model.id,
          'animalId':        model.animalId,
          'orgId':           model.orgId,
          'recordType':      model.recordType,
          'date':            model.date,
          'nextDue':         model.nextDue,
          'notes':           model.notes,
          'vetName':         model.vetName,
          'vaccineName':     model.vaccineName,
          'treatmentType':   model.treatmentType,
          'dewormingProduct':model.dewormingProduct,
          'dewormingDose':   model.dewormingDose,
          'matingDate':      model.matingDate,
          'expectedDelivery':model.expectedDelivery,
        },
      );
}

final healthActionsProvider = Provider<HealthActions>((ref) {
  return HealthActions(
    local:     ref.watch(localHealthDatasourceProvider),
    remote:    ref.watch(remoteHealthDatasourceProvider),
    syncQueue: ref.watch(syncQueueManagerProvider),
    orgId:     ref.watch(currentOrgIdProvider) ?? '',
    isOnline:  ref.watch(isOnlineProvider),
  );
});
