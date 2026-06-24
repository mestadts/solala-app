import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/livestock_species.dart';
import '../constants/animal_status.dart';
import 'mock_data.dart';

// ── Animals ───────────────────────────────────────────────────────────────────

class MockAnimalsNotifier extends Notifier<List<MockAnimal>> {
  @override
  List<MockAnimal> build() => List.from(mockAnimals);

  void addAnimal(MockAnimal a)  => state = [...state, a];
  void removeAnimal(String id) => state = state.where((a) => a.id != id).toList();
  void updateAnimal(MockAnimal u) =>
      state = [for (final a in state) if (a.id == u.id) u else a];
}

final mockAnimalsProvider =
    NotifierProvider<MockAnimalsNotifier, List<MockAnimal>>(MockAnimalsNotifier.new);

final mockAnimalsFilteredProvider =
    Provider.family<List<MockAnimal>, LivestockSpecies?>((ref, species) {
  final all = ref.watch(mockAnimalsProvider);
  if (species == null) return all;
  return all.where((a) => a.species == species).toList();
});

final mockAnimalByIdProvider =
    Provider.family<MockAnimal?, String>((ref, id) {
  final all = ref.watch(mockAnimalsProvider);
  try {
    return all.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
});

// ── Health records ────────────────────────────────────────────────────────────

class MockHealthRecordsNotifier extends Notifier<List<MockHealthRecord>> {
  @override
  List<MockHealthRecord> build() => List.from(mockHealthRecords);

  void addRecord(MockHealthRecord r) => state = [...state, r];
}

final mockHealthRecordsProvider =
    NotifierProvider<MockHealthRecordsNotifier, List<MockHealthRecord>>(
        MockHealthRecordsNotifier.new);

final mockHealthByAnimalProvider =
    Provider.family<List<MockHealthRecord>, String>((ref, animalId) {
  final all = ref.watch(mockHealthRecordsProvider);
  return all.where((h) => h.animalId == animalId).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

// Upcoming vaccinations (any with nextDueDate set — prototype)
final mockUpcomingVaccinationsProvider =
    Provider<List<MockHealthRecord>>((ref) {
  final all = ref.watch(mockHealthRecordsProvider);
  return all
      .where((h) => h.recordType == 'vaccination' && h.nextDueDate != null)
      .toList()
    ..sort((a, b) => (a.nextDueDate ?? '').compareTo(b.nextDueDate ?? ''));
});

// Unified upcoming events: vaccinations + deworming + expected births
class MockUpcomingEvent {
  final String type; // 'vaccination' | 'deworming' | 'birth'
  final String title;
  final String animalSystemId;
  final String dueDate;

  const MockUpcomingEvent({
    required this.type,
    required this.title,
    required this.animalSystemId,
    required this.dueDate,
  });
}

final mockUpcomingAllEventsProvider =
    Provider<List<MockUpcomingEvent>>((ref) {
  final healthRecords = ref.watch(mockHealthRecordsProvider);
  final breedingRecords = ref.watch(mockBreedingProvider);
  final now = DateTime.now();

  final events = <MockUpcomingEvent>[];

  // Vaccinations and deworming with nextDueDate
  for (final r in healthRecords) {
    if (r.nextDueDate != null &&
        (r.recordType == 'vaccination' || r.recordType == 'deworming')) {
      events.add(MockUpcomingEvent(
        type: r.recordType,
        title: r.title,
        animalSystemId: r.animalSystemId,
        dueDate: r.nextDueDate!,
      ));
    }
  }

  // Active pregnancies (future deliveryDate, no offspring yet)
  for (final r in breedingRecords) {
    final d = DateTime.tryParse(r.deliveryDate);
    if (d != null && d.isAfter(now) && r.offspringCount == 0) {
      events.add(MockUpcomingEvent(
        type: 'birth',
        title: r.damName ?? '',
        animalSystemId: r.damSystemId ?? '',
        dueDate: r.deliveryDate,
      ));
    }
  }

  events.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  return events;
});

// ── Weight records ────────────────────────────────────────────────────────────

class MockWeightRecordsNotifier extends Notifier<List<MockWeightRecord>> {
  @override
  List<MockWeightRecord> build() => List.from(mockWeightRecords);

  void addRecord(MockWeightRecord r) => state = [...state, r];
}

final mockWeightRecordsProvider =
    NotifierProvider<MockWeightRecordsNotifier, List<MockWeightRecord>>(
        MockWeightRecordsNotifier.new);

final mockWeightByAnimalProvider =
    Provider.family<List<MockWeightRecord>, String>((ref, animalId) {
  final all = ref.watch(mockWeightRecordsProvider);
  return all.where((w) => w.animalId == animalId).toList()
    ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
});

// ── Breeding records ──────────────────────────────────────────────────────────

class MockBreedingNotifier extends Notifier<List<MockBreedingRecord>> {
  @override
  List<MockBreedingRecord> build() => List.from(mockBreedingRecords);

  void addRecord(MockBreedingRecord r) => state = [...state, r];
}

final mockBreedingProvider =
    NotifierProvider<MockBreedingNotifier, List<MockBreedingRecord>>(
        MockBreedingNotifier.new);

final mockBreedingByAnimalProvider =
    Provider.family<List<MockBreedingRecord>, String>((ref, animalId) {
  final all = ref.watch(mockBreedingProvider);
  return all.where((b) => b.animalId == animalId).toList()
    ..sort((a, b) => b.deliveryDate.compareTo(a.deliveryDate));
});

// ── Ownership records ─────────────────────────────────────────────────────────

class MockOwnershipNotifier extends Notifier<List<MockOwnershipRecord>> {
  @override
  List<MockOwnershipRecord> build() => List.from(mockOwnershipRecords);

  void addRecord(MockOwnershipRecord r) => state = [...state, r];
}

final mockOwnershipProvider =
    NotifierProvider<MockOwnershipNotifier, List<MockOwnershipRecord>>(
        MockOwnershipNotifier.new);

final mockOwnershipByAnimalProvider =
    Provider.family<List<MockOwnershipRecord>, String>((ref, animalId) {
  return ref.watch(mockOwnershipProvider)
      .where((o) => o.animalId == animalId)
      .toList()
    ..sort((a, b) => b.transferDate.compareTo(a.transferDate));
});

// ── Dashboard stats ───────────────────────────────────────────────────────────

class DashboardStats {
  final int total;
  final Map<LivestockSpecies, int> bySpecies;
  final int active;
  final int sold;
  final int deceased;
  final int males;
  final int females;
  final Map<String, int> byAgeClass;  // ageClass.id -> count
  final Map<String, int> byBreed;     // breed name  -> count

  const DashboardStats({
    required this.total,
    required this.bySpecies,
    required this.active,
    required this.sold,
    required this.deceased,
    this.males = 0,
    this.females = 0,
    this.byAgeClass = const {},
    this.byBreed = const {},
  });
}

final mockDashboardStatsProvider = Provider<DashboardStats>((ref) {
  final animals = ref.watch(mockAnimalsProvider);
  final bySpecies = <LivestockSpecies, int>{};
  for (final s in LivestockSpecies.values) {
    bySpecies[s] = animals.where((a) => a.species == s).length;
  }
  return DashboardStats(
    total: animals.length,
    bySpecies: bySpecies,
    active: animals.where((a) => a.status == AnimalStatus.active).length,
    sold: animals.where((a) => a.status == AnimalStatus.sold).length,
    deceased: animals.where((a) => a.status == AnimalStatus.deceased).length,
  );
});

// ── Activity feed ─────────────────────────────────────────────────────────────

final mockActivitiesProvider = Provider<List<MockActivity>>((ref) => mockActivities);
