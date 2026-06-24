import 'package:isar/isar.dart';

part 'organization_local_model.g.dart';

/// Isar schema for an organisation (farm).
@collection
class OrganizationLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id;

  String name          = '';
  String type          = 'Farm';   // 'Individual' | 'Farm'
  String? country;
  String ownerUserId   = '';
  List<String> workerIds = [];

  // Sync metadata
  bool    isSynced         = false;
  String? pendingOperation;
  DateTime updatedAt       = DateTime.now();
  DateTime createdAt       = DateTime.now();
}
