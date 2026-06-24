import 'package:isar/isar.dart';

part 'breeding_record_local_model.g.dart';

/// Isar schema for a breeding (mating → birth) record.
/// Append-only — no delete allowed once created.
@collection
class BreedingRecordLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  @Index()
  late String orgId;

  // Dam (mother)
  @Index()
  late String damAnimalId;
  String damSystemId   = '';
  String damTagDisplay = '';   // "{tagNumber} {colorName}" for UI

  // Sire (father)
  String? sireAnimalId;
  String? sireSystemId;
  String? sireTagDisplay;

  // Mating
  String matingDate = '';       // ISO 8601

  // Delivery
  String? deliveryDate;         // ISO 8601 (filled when birth outcome is recorded)
  int?    offspringCount;
  int?    survivingCount;
  int?    malesBorn;
  int?    femalesBorn;

  String? notes;

  // Sync metadata
  bool    isSynced         = false;
  String? pendingOperation;
  DateTime updatedAt       = DateTime.now();
  DateTime createdAt       = DateTime.now();
}
