import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/local/schemas/ownership_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/isar_provider.dart';

class LocalOwnershipDatasource {
  final Isar _isar;
  const LocalOwnershipDatasource(this._isar);

  Stream<List<MockOwnershipRecord>> watchByAnimal(
      String orgId, String animalId) {
    return _isar.ownershipRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.ownershipRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) => m.animalId == animalId)
            .map(MockOwnershipRecord.fromLocalModel)
            .toList()
          ..sort((a, b) => b.transferDate.compareTo(a.transferDate)));
  }

  Future<void> saveModel(OwnershipRecordLocalModel model) async {
    await _isar.writeTxn(() async {
      await _isar.ownershipRecordLocalModels.put(model);
    });
  }

  Future<void> markSynced(String id) async {
    final existing = await _isar.ownershipRecordLocalModels
        .filter()
        .idEqualTo(id)
        .findFirst();
    if (existing == null) return;
    existing.isSynced = true;
    existing.pendingOperation = null;
    await _isar.writeTxn(() async {
      await _isar.ownershipRecordLocalModels.put(existing);
    });
  }
}

final localOwnershipDatasourceProvider =
    Provider<LocalOwnershipDatasource>((ref) =>
        LocalOwnershipDatasource(ref.watch(isarProvider)));
