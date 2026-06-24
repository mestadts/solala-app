import 'package:isar/isar.dart';

part 'animal_local_model.g.dart';

/// Isar schema for a livestock animal.
/// Mirrors [MockAnimal] fields; extended with sync metadata.
@collection
class AnimalLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;             // UUID generated on creation

  @Index()
  late String orgId;          // organisation this animal belongs to

  String systemAnimalId = '';
  String name           = '';

  @Index()
  String species        = '';  // LivestockSpecies.name

  String gender         = '';
  String breed          = '';  // breed id from breed_data
  String dateOfBirth    = '';  // ISO 8601 YYYY-MM-DD
  double weight         = 0;
  String status         = 'active'; // AnimalStatus.name
  String breederTag     = '';
  String colorId        = '';
  String tagColorId     = '';  // color of the ear/ID tag
  int    tagNumber      = 0;
  String photoUrl       = '';

  // species-specific attributes — stored as JSON string
  String speciesAttributesJson = '{}';

  // Mqane-derived fields
  String? penId;
  String? ageClassId;
  String? purpose;           // AnimalPurpose.name or null
  double? price;
  int?    weaningFromDays;
  int?    weaningToDays;
  String? officialTagNumber;

  // Parent links
  String? damId;
  String? sireId;

  // Phase 16 — custom field values (JSON map {fieldId: value})
  String? customValuesJson;

  // Sync metadata
  bool   isSynced        = false;
  String? pendingOperation; // 'create' | 'update' | 'delete' | null
  DateTime updatedAt     = DateTime.now();
  DateTime createdAt     = DateTime.now();
}
