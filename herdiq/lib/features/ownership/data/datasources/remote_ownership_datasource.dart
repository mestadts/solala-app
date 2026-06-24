import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local/schemas/ownership_record_local_model.dart';
import '../../../../core/providers/firebase_provider.dart';

class RemoteOwnershipDatasource {
  final FirebaseFirestore _db;
  const RemoteOwnershipDatasource(this._db);

  Future<void> create(String orgId, OwnershipRecordLocalModel m) async {
    await _db
        .collection('organizations')
        .doc(orgId)
        .collection('ownershipRecords')
        .doc(m.id)
        .set(_toMap(m));
  }

  Map<String, dynamic> _toMap(OwnershipRecordLocalModel m) => {
        'id': m.id,
        'animalId': m.animalId,
        'orgId': m.orgId,
        'transferType': m.transferType,
        'fromOwnerId': m.fromOwnerId,
        'toOwnerId': m.toOwnerId,
        'toOwnerName': m.toOwnerName,
        'toOwnerPhone': m.toOwnerPhone,
        'salePrice': m.salePrice,
        'currency': m.currency,
        'documentUrl': m.documentUrl,
        'transferDate': m.transferDate,
        'notes': m.notes,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}

final remoteOwnershipDatasourceProvider =
    Provider<RemoteOwnershipDatasource>((ref) =>
        RemoteOwnershipDatasource(ref.watch(firestoreProvider)));
