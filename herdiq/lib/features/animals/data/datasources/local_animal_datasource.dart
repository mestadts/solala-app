import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../../core/local/schemas/animal_local_model.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/isar_provider.dart';

class LocalAnimalDatasource {
  LocalAnimalDatasource(this._isar);
  final Isar _isar;

  Stream<List<MockAnimal>> watchAll(String orgId) {
    return _isar.animalLocalModels
        .watchLazy(fireImmediately: true)
        .asyncMap((_) => _isar.animalLocalModels
            .filter()
            .orgIdEqualTo(orgId)
            .findAll())
        .map((list) => list
            .where((m) => m.pendingOperation != 'delete')
            .map(MockAnimal.fromLocalModel)
            .toList());
  }

  Future<AnimalLocalModel?> findById(String id) =>
      _isar.animalLocalModels.filter().idEqualTo(id).findFirst();

  Future<void> saveAnimal(MockAnimal animal, String orgId) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.animalLocalModels
          .filter()
          .idEqualTo(animal.id)
          .findFirst();
      final model = animal.toLocalModel(orgId);
      if (existing != null) {
        model.isarId   = existing.isarId;
        model.createdAt = existing.createdAt;
      }
      await _isar.animalLocalModels.put(model);
    });
  }

  Future<void> saveModel(AnimalLocalModel model) async {
    await _isar.writeTxn(() => _isar.animalLocalModels.put(model));
  }

  /// Soft-delete: marks pendingOperation='delete' so sync queue can remove from Firestore.
  Future<void> markDeleted(String id) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.animalLocalModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (existing != null) {
        existing.pendingOperation = 'delete';
        existing.isSynced = false;
        await _isar.animalLocalModels.put(existing);
      }
    });
  }

  /// Hard delete — called after Firestore confirms deletion.
  Future<void> hardDelete(String id) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.animalLocalModels
          .filter()
          .idEqualTo(id)
          .findFirst();
      if (existing != null) {
        await _isar.animalLocalModels.delete(existing.isarId);
      }
    });
  }
}

final localAnimalDatasourceProvider = Provider<LocalAnimalDatasource>((ref) {
  return LocalAnimalDatasource(ref.watch(isarProvider));
});
