import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/local/schemas/weight_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/isar_provider.dart';

class LocalWeightDatasource {
  final Isar _isar;
  const LocalWeightDatasource(this._isar);

  Stream<List<MockWeightRecord>> watchAll(String orgId) {
    return _isar.weightRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.weightRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .map(MockWeightRecord.fromLocalModel)
            .toList());
  }

  Stream<List<MockWeightRecord>> watchByAnimal(String orgId, String animalId) {
    return _isar.weightRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.weightRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) => m.animalId == animalId)
            .map(MockWeightRecord.fromLocalModel)
            .toList()
          ..sort((a, b) => b.recordedAt.compareTo(a.recordedAt)));
  }

  Future<void> saveModel(WeightRecordLocalModel model) async {
    await _isar.writeTxn(() async {
      await _isar.weightRecordLocalModels.put(model);
    });
  }

  Future<void> markSynced(String id) async {
    final existing = await _isar.weightRecordLocalModels
        .filter()
        .idEqualTo(id)
        .findFirst();
    if (existing == null) return;
    existing.isSynced = true;
    existing.pendingOperation = null;
    await _isar.writeTxn(() async {
      await _isar.weightRecordLocalModels.put(existing);
    });
  }
}

final localWeightDatasourceProvider =
    Provider<LocalWeightDatasource>((ref) =>
        LocalWeightDatasource(ref.watch(isarProvider)));
