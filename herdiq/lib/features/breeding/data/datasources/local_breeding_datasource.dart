import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/local/schemas/breeding_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/isar_provider.dart';

class LocalBreedingDatasource {
  LocalBreedingDatasource(this._isar);
  final Isar _isar;

  /// Watch breeding records for a specific dam animal (sorted newest first).
  Stream<List<MockBreedingRecord>> watchByAnimal(
      String orgId, String animalId) {
    return _isar.breedingRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.breedingRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) => m.damAnimalId == animalId)
            .map(MockBreedingRecord.fromLocalModel)
            .toList()
          ..sort((a, b) =>
              (b.deliveryDate ?? '').compareTo(a.deliveryDate ?? '')));
  }

  /// Watch all breeding records for the org (for upcoming births widget).
  Stream<List<MockBreedingRecord>> watchAll(String orgId) {
    return _isar.breedingRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.breedingRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) =>
            list.map(MockBreedingRecord.fromLocalModel).toList());
  }

  Future<void> saveModel(BreedingRecordLocalModel model) async {
    await _isar.writeTxn(() => _isar.breedingRecordLocalModels.put(model));
  }

  Future<void> markSynced(String id) async {
    await _isar.writeTxn(() async {
      final m = await _isar.breedingRecordLocalModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (m != null) {
        m.isSynced = true;
        m.pendingOperation = null;
        await _isar.breedingRecordLocalModels.put(m);
      }
    });
  }
}

final localBreedingDatasourceProvider =
    Provider<LocalBreedingDatasource>((ref) {
  return LocalBreedingDatasource(ref.watch(isarProvider));
});
