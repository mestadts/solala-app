import 'package:isar/isar.dart';

part 'health_record_local_model.g.dart';

/// Isar schema for a health record (vaccination, treatment, weight, pregnancy, deworming).
@collection
class HealthRecordLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  @Index()
  late String animalId;

  @Index()
  late String orgId;

  /// 'vaccination' | 'treatment' | 'weight' | 'pregnancy' | 'deworming'
  String recordType = '';

  String date      = '';  // ISO 8601
  String? nextDue  = '';  // ISO 8601 — vaccinations / deworming only

  // Common optional fields
  String? notes;
  String? vetName;

  // Vaccination
  String? vaccineName;

  // Treatment
  String? treatmentType;
  String? medications;    // JSON list of medication names

  // Weight
  double? weightValue;
  String? weightUnit;     // 'kg' | 'lbs'
  bool    isOfficialWeight = false;

  // Pregnancy
  String? matingDate;
  String? expectedDelivery;
  String? sireAnimalId;

  // Deworming
  String? dewormingProduct;
  String? dewormingDose;

  // Sync metadata
  bool   isSynced         = false;
  String? pendingOperation;
  DateTime updatedAt      = DateTime.now();
  DateTime createdAt      = DateTime.now();
}
