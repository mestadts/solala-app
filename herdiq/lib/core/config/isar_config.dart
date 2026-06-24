import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../local/schemas/animal_local_model.dart';
import '../local/schemas/health_record_local_model.dart';
import '../local/schemas/weight_record_local_model.dart';
import '../local/schemas/breeding_record_local_model.dart';
import '../local/schemas/ownership_record_local_model.dart';
import '../local/schemas/user_local_model.dart';
import '../local/schemas/organization_local_model.dart';
import '../local/schemas/sync_queue_model.dart';

/// Opens (or re-opens) the Isar database with all registered schemas.
/// Called once from [main] before [runApp].
Future<Isar> openIsar() async {
  final dir = await getApplicationDocumentsDirectory();

  return Isar.open(
    [
      AnimalLocalModelSchema,
      HealthRecordLocalModelSchema,
      WeightRecordLocalModelSchema,
      BreedingRecordLocalModelSchema,
      OwnershipRecordLocalModelSchema,
      UserLocalModelSchema,
      OrganizationLocalModelSchema,
      SyncQueueModelSchema,
    ],
    directory: dir.path,
    name: 'herdiq',
  );
}
