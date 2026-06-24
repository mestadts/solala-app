import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/animal_local_model.dart';
import '../../../../core/providers/firebase_provider.dart';

class RemoteAnimalDatasource {
  RemoteAnimalDatasource(this._firestore);
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _col(String orgId) =>
      _firestore
          .collection('organizations')
          .doc(orgId)
          .collection('animals');

  Future<void> create(AnimalLocalModel m) =>
      _col(m.orgId).doc(m.id).set(_toMap(m));

  Future<void> update(AnimalLocalModel m) =>
      _col(m.orgId).doc(m.id).set(_toMap(m), SetOptions(merge: true));

  Future<void> delete(String orgId, String id) =>
      _col(orgId).doc(id).delete();

  Map<String, dynamic> _toMap(AnimalLocalModel m) => {
        'id': m.id,
        'orgId': m.orgId,
        'systemAnimalId': m.systemAnimalId,
        'name': m.name,
        'species': m.species,
        'gender': m.gender,
        'breed': m.breed,
        'dateOfBirth': m.dateOfBirth,
        'weight': m.weight,
        'status': m.status,
        'breederTag': m.breederTag,
        'colorId': m.colorId,
        'tagColorId': m.tagColorId,
        'tagNumber': m.tagNumber,
        'photoUrl': m.photoUrl,
        'speciesAttributesJson': m.speciesAttributesJson,
        'penId': m.penId,
        'ageClassId': m.ageClassId,
        'purpose': m.purpose,
        'price': m.price,
        'weaningFromDays': m.weaningFromDays,
        'weaningToDays': m.weaningToDays,
        'officialTagNumber': m.officialTagNumber,
        'damId': m.damId,
        'sireId': m.sireId,
        'createdAt': m.createdAt.toIso8601String(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}

final remoteAnimalDatasourceProvider = Provider<RemoteAnimalDatasource>((ref) {
  return RemoteAnimalDatasource(ref.watch(firestoreProvider));
});
