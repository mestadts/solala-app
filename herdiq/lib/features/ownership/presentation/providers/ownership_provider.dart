import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/ownership_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/network/connectivity_service.dart';
import '../../../../core/sync/sync_queue_manager.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../data/datasources/local_ownership_datasource.dart';
import '../../data/datasources/remote_ownership_datasource.dart';

// ── Ownership records by animal ───────────────────────────────────────────────

final ownershipByAnimalProvider =
    StreamProvider.family<List<MockOwnershipRecord>, String>((ref, animalId) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return const Stream.empty();
  return ref
      .watch(localOwnershipDatasourceProvider)
      .watchByAnimal(orgId, animalId);
});

// ── OwnershipActions ──────────────────────────────────────────────────────────

class OwnershipActions {
  OwnershipActions({
    required LocalOwnershipDatasource local,
    required RemoteOwnershipDatasource remote,
    required SyncQueueManager syncQueue,
    required String orgId,
    required bool isOnline,
  })  : _local     = local,
        _remote    = remote,
        _syncQueue = syncQueue,
        _orgId     = orgId,
        _isOnline  = isOnline;

  final LocalOwnershipDatasource _local;
  final RemoteOwnershipDatasource _remote;
  final SyncQueueManager _syncQueue;
  final String _orgId;
  final bool _isOnline;

  Future<void> addRecord(MockOwnershipRecord record) async {
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

  Future<void> _enqueue(OwnershipRecordLocalModel m) =>
      _syncQueue.enqueue(
        entityType: 'ownershipRecords',
        entityId:   m.id,
        operation:  'create',
        payload: {
          'id':           m.id,
          'animalId':     m.animalId,
          'orgId':        m.orgId,
          'transferType': m.transferType,
          'fromOwnerId':  m.fromOwnerId,
          'toOwnerId':    m.toOwnerId,
          'toOwnerName':  m.toOwnerName,
          'toOwnerPhone': m.toOwnerPhone,
          'salePrice':    m.salePrice,
          'currency':     m.currency,
          'transferDate': m.transferDate,
          'notes':        m.notes,
        },
      );
}

final ownershipActionsProvider = Provider<OwnershipActions>((ref) {
  return OwnershipActions(
    local:     ref.watch(localOwnershipDatasourceProvider),
    remote:    ref.watch(remoteOwnershipDatasourceProvider),
    syncQueue: ref.watch(syncQueueManagerProvider),
    orgId:     ref.watch(currentOrgIdProvider) ?? '',
    isOnline:  ref.watch(isOnlineProvider),
  );
});
