import 'package:isar/isar.dart';

part 'weight_record_local_model.g.dart';

/// Isar schema for a standalone weight record.
/// Weight data is also stored inside [HealthRecordLocalModel] (type=weight),
/// but this collection gives us quick time-series queries per animal.
@collection
class WeightRecordLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  @Index()
  late String animalId;

  @Index()
  late String orgId;

  double value       = 0;
  String unit        = 'kg';    // 'kg' | 'lbs'
  String recordedAt  = '';      // ISO 8601
  bool   isOfficial  = false;
  String? notes;

  // Sync metadata
  bool    isSynced         = false;
  String? pendingOperation;
  DateTime updatedAt       = DateTime.now();
  DateTime createdAt       = DateTime.now();
}
