import 'package:isar/isar.dart';

part 'user_local_model.g.dart';

/// Isar schema for the authenticated user profile.
@collection
class UserLocalModel {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  String displayName   = '';
  String phone         = '';
  String? email;
  String? photoUrl;
  String? country;

  // Organisation memberships (list of orgIds)
  List<String> organizationIds = [];

  // Sync metadata
  bool    isSynced         = false;
  String? pendingOperation;
  DateTime updatedAt       = DateTime.now();
  DateTime createdAt       = DateTime.now();
}
