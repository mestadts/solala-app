import 'package:isar/isar.dart';

part 'sync_queue_model.g.dart';

/// An entry in the offline sync queue.
/// When a write happens offline it is enqueued here.
/// [SyncQueueManager] processes the queue when connectivity is restored.
@collection
class SyncQueueModel {
  Id isarId = Isar.autoIncrement;

  /// Firestore collection name, e.g. 'animals', 'healthRecords'.
  @Index()
  String entityType = '';

  /// The local UUID of the entity being synced.
  String entityId = '';

  /// 'create' | 'update' | 'delete'
  String operation = '';

  /// JSON-encoded payload (the full document or diff to write to Firestore).
  String payloadJson = '{}';

  /// How many times this entry has been retried and failed.
  int retryCount = 0;

  /// Timestamp of the last failed attempt (used for exponential back-off).
  DateTime? lastAttemptAt;

  DateTime createdAt = DateTime.now();
}
