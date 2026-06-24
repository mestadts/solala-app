import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/age_class_data.dart';
import '../../../../core/constants/animal_status.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_providers.dart'; // for DashboardStats class
import '../../../../core/providers/prefs_provider.dart';
import '../../../animals/presentation/providers/animal_provider.dart';

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  final all = ref.watch(animalsStreamProvider).valueOrNull ?? [];
  final preferredSpecies = ref.watch(preferredSpeciesProvider);

  // Scope to preferred species when set (herd focus)
  final animals = preferredSpecies.isEmpty
      ? all
      : all.where((a) => preferredSpecies.contains(a.species.name)).toList();

  final bySpecies = <LivestockSpecies, int>{};
  for (final s in LivestockSpecies.values) {
    bySpecies[s] = animals.where((a) => a.species == s).length;
  }

  // Gender split
  final males   = animals.where((a) => a.gender == 'Male').length;
  final females = animals.where((a) => a.gender == 'Female').length;

  // Age class distribution (computed from DOB)
  final byAgeClass = <String, int>{};
  for (final ac in ageClasses) {
    byAgeClass[ac.id] = 0;
  }
  for (final a in animals) {
    final ac = ageClassFromDob(a.dateOfBirth);
    if (ac != null) {
      byAgeClass[ac.id] = (byAgeClass[ac.id] ?? 0) + 1;
    }
  }

  // Breed distribution (top breeds)
  final byBreed = <String, int>{};
  for (final a in animals) {
    if (a.breed.isNotEmpty) {
      byBreed[a.breed] = (byBreed[a.breed] ?? 0) + 1;
    }
  }

  return DashboardStats(
    total: animals.length,
    bySpecies: bySpecies,
    active: animals.where((a) => a.status == AnimalStatus.active).length,
    sold: animals.where((a) => a.status == AnimalStatus.sold).length,
    deceased: animals.where((a) => a.status == AnimalStatus.deceased).length,
    males: males,
    females: females,
    byAgeClass: byAgeClass,
    byBreed: byBreed,
  );
});
