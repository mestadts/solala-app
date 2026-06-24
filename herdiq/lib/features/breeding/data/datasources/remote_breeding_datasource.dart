import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/breeding_record_local_model.dart';
import '../../../../core/providers/firebase_provider.dart';

class RemoteBreedingDatasource {
  RemoteBreedingDatasource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String orgId) =>
      _firestore
          .collection('organizations')
          .doc(orgId)
          .collection('breedingRecords');

  Future<void> create(BreedingRecordLocalModel m) =>
      _col(m.orgId).doc(m.id).set(_toMap(m));

  Map<String, dynamic> _toMap(BreedingRecordLocalModel m) => {
        'id': m.id,
        'orgId': m.orgId,
        'damAnimalId': m.damAnimalId,
        'damSystemId': m.damSystemId,
        'damTagDisplay': m.damTagDisplay,
        'sireAnimalId': m.sireAnimalId,
        'sireSystemId': m.sireSystemId,
        'sireTagDisplay': m.sireTagDisplay,
        'matingDate': m.matingDate,
        'deliveryDate': m.deliveryDate,
        'offspringCount': m.offspringCount,
        'survivingCount': m.survivingCount,
        'malesBorn': m.malesBorn,
        'femalesBorn': m.femalesBorn,
        'notes': m.notes,
        'updatedAt': m.updatedAt.toIso8601String(),
        'createdAt': m.createdAt.toIso8601String(),
      };
}

final remoteBreedingDatasourceProvider =
    Provider<RemoteBreedingDatasource>((ref) {
  return RemoteBreedingDatasource(ref.watch(firestoreProvider));
});
