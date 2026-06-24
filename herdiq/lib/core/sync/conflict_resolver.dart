/// Last-Write-Wins conflict resolver.
///
/// When a local record is about to be written to Firestore, this class
/// compares the local [updatedAt] timestamp against the remote document's
/// `updatedAt` field.  If the remote is newer, the local write is skipped
/// and the remote version is returned so the local cache can be refreshed.
///
/// This is used in Phase 10 (animal repository) and Phase 11 (health repo)
/// when merging Firestore snapshots with local Isar records.
class ConflictResolver {
  /// Returns `true` if the local record should win (i.e. local is newer).
  static bool localWins({
    required DateTime localUpdatedAt,
    required DateTime? remoteUpdatedAt,
  }) {
    if (remoteUpdatedAt == null) return true;
    return localUpdatedAt.isAfter(remoteUpdatedAt) ||
        localUpdatedAt.isAtSameMomentAs(remoteUpdatedAt);
  }

  /// Merges a Firestore document map with a local model's [updatedAt].
  /// Returns the map that should be persisted locally.
  ///
  /// - If local is newer  → keep local, update Firestore.
  /// - If remote is newer → keep remote, update local cache.
  static Map<String, dynamic> resolve({
    required Map<String, dynamic> localMap,
    required Map<String, dynamic> remoteMap,
  }) {
    final localTs  = _parseTs(localMap['updatedAt']);
    final remoteTs = _parseTs(remoteMap['updatedAt']);

    if (localWins(localUpdatedAt: localTs, remoteUpdatedAt: remoteTs)) {
      return localMap;
    }
    return remoteMap;
  }

  static DateTime _parseTs(dynamic raw) {
    if (raw is DateTime) return raw;
    if (raw is String) return DateTime.tryParse(raw) ?? DateTime(0);
    // Firestore Timestamp (arrives as dynamic from cloud_firestore)
    try {
      return (raw as dynamic).toDate() as DateTime;
    } catch (_) {
      return DateTime(0);
    }
  }
}
