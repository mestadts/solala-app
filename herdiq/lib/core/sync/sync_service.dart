import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/connectivity_service.dart';
import '../providers/firebase_provider.dart';
import 'sync_queue_manager.dart';

/// Watches connectivity and triggers [SyncQueueManager.processPending]
/// whenever the device comes back online.
///
/// Kept alive for the app's lifetime via `ref.watch(syncServiceProvider)`
/// in [HerdIQApp].
class SyncService {
  SyncService(this._ref);
  final Ref _ref;
  bool _wasSyncing = false;

  Future<void> triggerSync() async {
    if (_wasSyncing) return;
    if (Firebase.apps.isEmpty) return; // Firebase not initialized — skip sync
    _wasSyncing = true;
    try {
      final uid = _ref.read(firebaseAuthProvider).currentUser?.uid;
      if (uid == null) return;

      final manager = _ref.read(syncQueueManagerProvider);
      final pending = await manager.pendingCount();
      if (pending == 0) return;

      // Use uid as placeholder orgId until Phase 10 wires the real org.
      await manager.processPending(uid);
    } finally {
      _wasSyncing = false;
    }
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(ref);

  // Listen to connectivity changes — trigger sync when device comes back online.
  ref.listen<AsyncValue<bool>>(connectivityProvider, (prev, next) {
    next.whenData((isOnline) {
      if (isOnline) service.triggerSync();
    });
  });

  return service;
});
