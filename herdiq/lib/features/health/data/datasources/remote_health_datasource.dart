import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/health_record_local_model.dart';
import '../../../../core/providers/firebase_provider.dart';

class RemoteHealthDatasource {
  RemoteHealthDatasource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String orgId) =>
      _firestore
          .collection('organizations')
          .doc(orgId)
          .collection('healthRecords');

  Future<void> create(HealthRecordLocalModel m) =>
      _col(m.orgId).doc(m.id).set(_toMap(m));

  Future<void> delete(String orgId, String id) =>
      _col(orgId).doc(id).delete();

  Map<String, dynamic> _toMap(HealthRecordLocalModel m) => {
        'id': m.id,
        'animalId': m.animalId,
        'orgId': m.orgId,
        'recordType': m.recordType,
        'date': m.date,
        'nextDue': m.nextDue,
        'notes': m.notes,
        'vetName': m.vetName,
        'vaccineName': m.vaccineName,
        'treatmentType': m.treatmentType,
        'medications': m.medications,
        'matingDate': m.matingDate,
        'expectedDelivery': m.expectedDelivery,
        'sireAnimalId': m.sireAnimalId,
        'dewormingProduct': m.dewormingProduct,
        'dewormingDose': m.dewormingDose,
        'updatedAt': m.updatedAt.toIso8601String(),
        'createdAt': m.createdAt.toIso8601String(),
      };
}

final remoteHealthDatasourceProvider = Provider<RemoteHealthDatasource>((ref) {
  return RemoteHealthDatasource(ref.watch(firestoreProvider));
});
