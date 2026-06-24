import 'package:isar/isar.dart';

part 'ownership_record_local_model.g.dart';

/// Isar schema for an ownership transfer record.
/// Immutable once created (no update / delete operations).
@collection
class OwnershipRecordLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  @Index()
  late String animalId;

  @Index()
  late String orgId;

  /// 'sale' | 'gift' | 'internal'
  String transferType  = 'sale';

  String fromOwnerId   = '';
  String toOwnerId     = '';
  String toOwnerName   = '';
  String toOwnerPhone  = '';

  double? salePrice;
  String? currency;       // 'SAR' | 'AED' | …
  String? documentUrl;    // optional attachment (Storage URL)
  String transferDate  = '';   // ISO 8601
  String? notes;

  // Sync metadata (append-only — pendingOperation is always 'create')
  bool    isSynced         = false;
  String? pendingOperation = 'create';
  DateTime updatedAt       = DateTime.now();
  DateTime createdAt       = DateTime.now();
}
