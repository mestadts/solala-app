import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/local/schemas/health_record_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/isar_provider.dart';

class LocalHealthDatasource {
  LocalHealthDatasource(this._isar);
  final Isar _isar;

  /// Watch health records for a specific animal (sorted newest first).
  Stream<List<MockHealthRecord>> watchByAnimal(String orgId, String animalId) {
    return _isar.healthRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.healthRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) =>
                m.animalId == animalId && m.pendingOperation != 'delete')
            .map(MockHealthRecord.fromLocalModel)
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date)));
  }

  /// Watch all health records for the org (for health overview page).
  Stream<List<MockHealthRecord>> watchAll(String orgId) {
    return _isar.healthRecordLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.healthRecordLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) => m.pendingOperation != 'delete')
            .map(MockHealthRecord.fromLocalModel)
            .toList());
  }

  Future<HealthRecordLocalModel?> findById(String id) =>
      _isar.healthRecordLocalModels.filter().idEqualTo(id).findFirst();

  Future<void> saveModel(HealthRecordLocalModel model) async {
    await _isar.writeTxn(() => _isar.healthRecordLocalModels.put(model));
  }

  Future<void> markSynced(String id) async {
    await _isar.writeTxn(() async {
      final m = await _isar.healthRecordLocalModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (m != null) {
        m.isSynced = true;
        m.pendingOperation = null;
        await _isar.healthRecordLocalModels.put(m);
      }
    });
  }
}

final localHealthDatasourceProvider = Provider<LocalHealthDatasource>((ref) {
  return LocalHealthDatasource(ref.watch(isarProvider));
});
