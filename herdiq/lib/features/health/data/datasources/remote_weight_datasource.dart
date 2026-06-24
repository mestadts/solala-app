import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/weight_record_local_model.dart';
import '../../../../core/providers/firebase_provider.dart';

class RemoteWeightDatasource {
  final FirebaseFirestore _db;
  const RemoteWeightDatasource(this._db);

  Future<void> create(String orgId, WeightRecordLocalModel m) async {
    await _db
        .collection('organizations')
        .doc(orgId)
        .collection('weightRecords')
        .doc(m.id)
        .set(_toMap(m));
  }

  Map<String, dynamic> _toMap(WeightRecordLocalModel m) => {
        'id': m.id,
        'animalId': m.animalId,
        'orgId': m.orgId,
        'value': m.value,
        'unit': m.unit,
        'recordedAt': m.recordedAt,
        'isOfficial': m.isOfficial,
        'notes': m.notes,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}

final remoteWeightDatasourceProvider =
    Provider<RemoteWeightDatasource>((ref) =>
        RemoteWeightDatasource(ref.watch(firestoreProvider)));
