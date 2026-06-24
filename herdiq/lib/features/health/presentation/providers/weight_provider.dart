import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/weight_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../data/datasources/local_weight_datasource.dart';
import '../../data/datasources/remote_weight_datasource.dart';

// ── All weight records for org ────────────────────────────────────────────────

final allWeightStreamProvider = StreamProvider<List<MockWeightRecord>>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref.watch(localWeightDatasourceProvider).watchAll(orgId);
});

// ── Weight records by animal ──────────────────────────────────────────────────

final weightByAnimalProvider =
    StreamProvider.family<List<MockWeightRecord>, String>((ref, animalId) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref
      .watch(localWeightDatasourceProvider)
      .watchByAnimal(orgId, animalId);
});

// ── WeightActions ─────────────────────────────────────────────────────────────

class WeightActions {
  WeightActions({
    required LocalWeightDatasource local,
    required RemoteWeightDatasource remote,
    required SyncQueueManager syncQueue,
    required String orgId,
    required bool isOnline,
  })  : _local     = local,
        _remote    = remote,
        _syncQueue = syncQueue,
        _orgId     = orgId,
        _isOnline  = isOnline;

  final LocalWeightDatasource _local;
  final RemoteWeightDatasource _remote;
  final SyncQueueManager _syncQueue;
  final String _orgId;
  final bool _isOnline;

  Future<void> addRecord(MockWeightRecord record) async {
    final model = record.toLocalModel(_orgId);
    await _local.saveModel(model);

    if (_isOnline) {
      try {
        await _remote.create(_orgId, model);
        await _local.markSynced(model.id);
      } catch (_) {
        await _enqueue(model);
      }
    } else {
      await _enqueue(model);
    }
  }

  Future<void> _enqueue(WeightRecordLocalModel m) =>
      _syncQueue.enqueue(
        entityType: 'weightRecords',
        entityId:   m.id,
        operation:  'create',
        payload: {
          'id':         m.id,
          'animalId':   m.animalId,
          'orgId':      m.orgId,
          'value':      m.value,
          'unit':       m.unit,
          'recordedAt': m.recordedAt,
          'isOfficial': m.isOfficial,
          'notes':      m.notes,
        },
      );
}

final weightActionsProvider = Provider<WeightActions>((ref) {
  return WeightActions(
    local:     ref.watch(localWeightDatasourceProvider),
    remote:    ref.watch(remoteWeightDatasourceProvider),
    syncQueue: ref.watch(syncQueueManagerProvider),
    orgId:     ref.watch(currentOrgIdProvider) ?? '',
    isOnline:  ref.watch(isOnlineProvider),
  );
});
