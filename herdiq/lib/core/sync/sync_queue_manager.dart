import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../local/schemas/sync_queue_model.dart';
import '../local/schemas/animal_local_model.dart';
import '../providers/isar_provider.dart';
import '../providers/firebase_provider.dart';
import '../utils/animal_id_generator.dart';

/// Manages the offline sync queue.
///
/// When the app writes data while offline it calls [enqueue].
/// When connectivity is restored [SyncService] calls [processPending].
///
/// Retry strategy: exponential back-off — max [_maxRetries] attempts.
/// Failed entries beyond the limit are left in the queue with a high
/// retryCount so operators can inspect them.
class SyncQueueManager {
  SyncQueueManager(this._isar, this._firestore);

  final Isar _isar;
  final FirebaseFirestore _firestore;

  static const int _maxRetries = 5;

  // ── Enqueue ────────────────────────────────────────────────────────────────

  /// Adds a sync task to the queue.
  /// [entityType] — Firestore collection name (e.g. 'animals').
  /// [entityId]   — local UUID of the entity.
  /// [operation]  — 'create' | 'update' | 'delete'.
  /// [payload]    — the data map to write to Firestore.
  Future<void> enqueue({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    final entry = SyncQueueModel()
      ..entityType  = entityType
      ..entityId    = entityId
      ..operation   = operation
      ..payloadJson = jsonEncode(payload)
      ..retryCount  = 0
      ..createdAt   = DateTime.now();

    await _isar.writeTxn(() => _isar.syncQueueModels.put(entry));
  }

  // ── Process ────────────────────────────────────────────────────────────────

  /// Processes all pending entries in the queue (oldest first).
  /// Called by [SyncService] whenever connectivity is restored.
  Future<void> processPending(String orgId) async {
    final entries = await _isar.syncQueueModels
        .filter()
        .retryCountLessThan(_maxRetries)
        .sortByCreatedAt()
        .findAll();

    for (final entry in entries) {
      await _process(entry, orgId);
    }
  }

  Future<void> _process(SyncQueueModel entry, String orgId) async {
    try {
      var payload = jsonDecode(entry.payloadJson) as Map<String, dynamic>;

      // If this is an offline-created animal with a LOCAL id, upgrade it to a
      // proper HQ-YY-NNNNNN id before writing to Firestore.
      if (entry.entityType == 'animals' &&
          entry.operation == 'create' &&
          (payload['systemAnimalId'] as String? ?? '').startsWith('HQ-LOCAL-')) {
        final realId = await AnimalIdGenerator(_firestore).generate();
        payload = Map<String, dynamic>.from(payload)
          ..['systemAnimalId'] = realId;

        // Update the Isar record so the UI reflects the proper id.
        await _isar.writeTxn(() async {
          final animal = await _isar.animalLocalModels
              .filter()
              .idEqualTo(entry.entityId)
              .findFirst();
          if (animal != null) {
            animal.systemAnimalId = realId;
            await _isar.animalLocalModels.put(animal);
          }
        });
      }

      final collection = _firestore
          .collection('organizations')
          .doc(orgId)
          .collection(entry.entityType);
      final docRef = collection.doc(entry.entityId);

      switch (entry.operation) {
        case 'create':
          await docRef.set(payload);
        case 'update':
          await docRef.update(payload);
        case 'delete':
          await docRef.delete();
      }

      // Success — remove from queue
      await _isar.writeTxn(() => _isar.syncQueueModels.delete(entry.isarId));
    } catch (_) {
      // Failure — increment retry count + record last attempt time
      await _isar.writeTxn(() async {
        final fresh = await _isar.syncQueueModels.get(entry.isarId);
        if (fresh != null) {
          fresh.retryCount++;
          fresh.lastAttemptAt = DateTime.now();
          await _isar.syncQueueModels.put(fresh);
        }
      });
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Returns the number of entries still pending in the queue.
  Future<int> pendingCount() =>
      _isar.syncQueueModels.filter().retryCountLessThan(_maxRetries).count();
}

// ── Provider ──────────────────────────────────────────────────────────────────

final syncQueueManagerProvider = Provider<SyncQueueManager>((ref) {
  final isar      = ref.watch(isarProvider);
  final firestore = ref.watch(firestoreProvider);
  return SyncQueueManager(isar, firestore);
});
