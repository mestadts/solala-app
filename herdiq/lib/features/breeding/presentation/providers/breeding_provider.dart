import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/breeding_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../data/datasources/local_breeding_datasource.dart';
import '../../data/datasources/remote_breeding_datasource.dart';

// ── Live breeding records by dam animal ───────────────────────────────────────

final breedingByAnimalProvider =
    StreamProvider.family<List<MockBreedingRecord>, String>((ref, animalId) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref
      .watch(localBreedingDatasourceProvider)
      .watchByAnimal(orgId, animalId);
});

// ── All breeding records for org (used by upcomingEventsProvider) ─────────────

final allBreedingStreamProvider =
    StreamProvider<List<MockBreedingRecord>>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref.watch(localBreedingDatasourceProvider).watchAll(orgId);
});

// ── BreedingActions ───────────────────────────────────────────────────────────

class BreedingActions {
  BreedingActions({
    required LocalBreedingDatasource local,
    required RemoteBreedingDatasource remote,
    required SyncQueueManager syncQueue,
    required String orgId,
    required bool isOnline,
  })  : _local     = local,
        _remote    = remote,
        _syncQueue = syncQueue,
        _orgId     = orgId,
        _isOnline  = isOnline;

  final LocalBreedingDatasource _local;
  final RemoteBreedingDatasource _remote;
  final SyncQueueManager _syncQueue;
  final String _orgId;
  final bool _isOnline;

  Future<void> addRecord(MockBreedingRecord record) async {
    final model = record.toLocalModel(_orgId);
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

  Future<void> _enqueue(BreedingRecordLocalModel model) =>
      _syncQueue.enqueue(
        entityType: 'breedingRecords',
        entityId:   model.id,
        operation:  'create',
        payload: {
          'id':            model.id,
          'orgId':         model.orgId,
          'damAnimalId':   model.damAnimalId,
          'damSystemId':   model.damSystemId,
          'damTagDisplay': model.damTagDisplay,
          'sireAnimalId':  model.sireAnimalId,
          'sireSystemId':  model.sireSystemId,
          'sireTagDisplay':model.sireTagDisplay,
          'matingDate':    model.matingDate,
          'deliveryDate':  model.deliveryDate,
          'offspringCount':model.offspringCount,
          'survivingCount':model.survivingCount,
          'notes':         model.notes,
        },
      );
}

final breedingActionsProvider = Provider<BreedingActions>((ref) {
  return BreedingActions(
    local:     ref.watch(localBreedingDatasourceProvider),
    remote:    ref.watch(remoteBreedingDatasourceProvider),
    syncQueue: ref.watch(syncQueueManagerProvider),
    orgId:     ref.watch(currentOrgIdProvider) ?? '',
    isOnline:  ref.watch(isOnlineProvider),
  );
});
