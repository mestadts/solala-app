import 'package:cloud_firestore/cloud_firestore.dart';

/// Generates collision-safe `HQ-YYYY-NNNNNN` system animal IDs.
///
/// **How it works (Phase 10 — Firestore counter):**
/// A Firestore document `counters/animals` stores a per-year integer counter
/// protected by a transaction.  Each call atomically increments it and
/// returns the next padded ID.
///
/// **Phase 9 (offline / mock):**
/// [generateLocal] returns a temporary local ID using a millisecond timestamp.
/// This is replaced by the real Firestore ID in [generate] once the animal
/// syncs to the backend.
class AnimalIdGenerator {
  AnimalIdGenerator(this._firestore);

  final FirebaseFirestore _firestore;

  static const _counterDoc = 'counters/animals';

  /// Generates the next `HQ-YY-NNNNNN` ID using a Firestore transaction.
  /// Requires network connectivity — call only when online.
  Future<String> generate() async {
    final year = DateTime.now().year.toString();
    final shortYear = year.substring(2); // 2-digit year e.g. "26"
    final counterRef = _firestore.doc(_counterDoc);

    return _firestore.runTransaction<String>((txn) async {
      final snap = await txn.get(counterRef);
      final data = snap.data() ?? {};
      final current = (data[year] as int?) ?? 0;
      final next = current + 1;
      txn.set(counterRef, {year: next}, SetOptions(merge: true));
      return 'HQ-$shortYear-${next.toString().padLeft(6, '0')}';
    });
  }

  /// Generates a temporary local ID for offline-created animals.
  /// Format: `HQ-LOCAL-{millis}`.
  /// Replaced with a real ID when [processPending] runs after reconnect.
  static String generateLocal() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'HQ-LOCAL-$ts';
  }

  /// Derives the species prefix from the species name (for legacy records).
  /// e.g. 'sheep' → 'SH', 'camel' → 'CM', etc.
  static String speciesPrefix(String species) {
    return switch (species.toLowerCase()) {
      'sheep' => 'SH',
      'goat'  => 'GT',
      'camel' => 'CM',
      'cow'   => 'CW',
      'horse' => 'HR',
      _       => 'AN',
    };
  }
}
