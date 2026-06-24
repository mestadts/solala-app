import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/firebase_provider.dart';
import '../../features/animals/presentation/providers/animal_provider.dart';

// ── Model ─────────────────────────────────────────────────────────────────────

class FieldLabels {
  final String? tagLabelAr;
  final String? tagLabelEn;
  final String? tagColorLabelAr;
  final String? tagColorLabelEn;
  final String? animalColorLabelAr;
  final String? animalColorLabelEn;
  final String? breedLabelAr;
  final String? breedLabelEn;
  final String? penLabelAr;
  final String? penLabelEn;

  const FieldLabels({
    this.tagLabelAr,
    this.tagLabelEn,
    this.tagColorLabelAr,
    this.tagColorLabelEn,
    this.animalColorLabelAr,
    this.animalColorLabelEn,
    this.breedLabelAr,
    this.breedLabelEn,
    this.penLabelAr,
    this.penLabelEn,
  });

  static const empty = FieldLabels();

  // Returns custom value if set, null otherwise (caller falls back to l10n default)
  String? tagLabel(bool isAr)         => isAr ? tagLabelAr         : tagLabelEn;
  String? tagColorLabel(bool isAr)    => isAr ? tagColorLabelAr    : tagColorLabelEn;
  String? animalColorLabel(bool isAr) => isAr ? animalColorLabelAr : animalColorLabelEn;
  String? breedLabel(bool isAr)       => isAr ? breedLabelAr       : breedLabelEn;
  String? penLabel(bool isAr)         => isAr ? penLabelAr         : penLabelEn;

  factory FieldLabels.fromMap(Map<String, dynamic> m) => FieldLabels(
    tagLabelAr:         _str(m['tagLabelAr']),
    tagLabelEn:         _str(m['tagLabelEn']),
    tagColorLabelAr:    _str(m['tagColorLabelAr']),
    tagColorLabelEn:    _str(m['tagColorLabelEn']),
    animalColorLabelAr: _str(m['animalColorLabelAr']),
    animalColorLabelEn: _str(m['animalColorLabelEn']),
    breedLabelAr:       _str(m['breedLabelAr']),
    breedLabelEn:       _str(m['breedLabelEn']),
    penLabelAr:         _str(m['penLabelAr']),
    penLabelEn:         _str(m['penLabelEn']),
  );

  Map<String, dynamic> toMap() => {
    'tagLabelAr':         tagLabelAr,
    'tagLabelEn':         tagLabelEn,
    'tagColorLabelAr':    tagColorLabelAr,
    'tagColorLabelEn':    tagColorLabelEn,
    'animalColorLabelAr': animalColorLabelAr,
    'animalColorLabelEn': animalColorLabelEn,
    'breedLabelAr':       breedLabelAr,
    'breedLabelEn':       breedLabelEn,
    'penLabelAr':         penLabelAr,
    'penLabelEn':         penLabelEn,
  };

  static String? _str(dynamic v) {
    if (v is String && v.isNotEmpty) return v;
    return null;
  }
}

// ── Firestore helper ──────────────────────────────────────────────────────────

DocumentReference<Map<String, dynamic>> _labelsDoc(
    FirebaseFirestore db, String orgId) =>
    db.collection('organizations').doc(orgId).collection('config').doc('fieldLabels');

// ── Stream provider ───────────────────────────────────────────────────────────

final fieldLabelsProvider = StreamProvider<FieldLabels>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return Stream.value(FieldLabels.empty);
  final db = ref.watch(firestoreProvider);
  return _labelsDoc(db, orgId).snapshots().map((snap) =>
      snap.exists ? FieldLabels.fromMap(snap.data()!) : FieldLabels.empty);
});

// ── Write helper ──────────────────────────────────────────────────────────────

class FieldLabelsActions {
  FieldLabelsActions({required FirebaseFirestore db, required String orgId})
      : _db = db,
        _orgId = orgId;

  final FirebaseFirestore _db;
  final String _orgId;

  Future<void> save(FieldLabels labels) =>
      _labelsDoc(_db, _orgId).set(labels.toMap());

  Future<void> reset() =>
      _labelsDoc(_db, _orgId).delete();
}

final fieldLabelsActionsProvider = Provider<FieldLabelsActions?>((ref) {
  final orgId = ref.watch(currentOrgIdProvider);
  if (orgId == null) return null;
  return FieldLabelsActions(
    db: ref.watch(firestoreProvider),
    orgId: orgId,
  );
});
