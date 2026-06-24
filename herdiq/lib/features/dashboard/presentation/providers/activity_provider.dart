import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../../breeding/presentation/providers/breeding_provider.dart';
import '../../../health/presentation/providers/health_provider.dart';
import '../../../health/presentation/providers/weight_provider.dart';

/// Combines health, weight, and breeding records into a unified
/// activity feed sorted by most recent first (up to 20 items).
final activitiesProvider = Provider<List<MockActivity>>((ref) {
  final healthRecords =
      ref.watch(allHealthStreamProvider).valueOrNull ?? [];
  final weightRecords =
      ref.watch(allWeightStreamProvider).valueOrNull ?? [];
  final breedingRecords =
      ref.watch(allBreedingStreamProvider).valueOrNull ?? [];
  final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
  final animalById = {for (final a in animals) a.id: a};

  final activities = <MockActivity>[];

  // ── Health records ──────────────────────────────────────────────
  for (final r in healthRecords) {
    String icon;
    String title;
    switch (r.recordType) {
      case 'vaccination':
        icon = '💉';
        title = 'تطعيم مسجل';
      case 'treatment':
        icon = '💊';
        title = 'علاج مسجل';
      case 'deworming':
        icon = '🔬';
        title = 'تطهير مسجل';
      case 'checkup':
        icon = '🩺';
        title = 'فحص طبي';
      default:
        icon = '📋';
        title = 'سجل صحي';
    }
    activities.add(MockActivity(
      id: 'h_${r.id}',
      title: title,
      subtitle: '${r.animalSystemId} — ${r.title}',
      timeAgo: '',
      icon: icon,
      createdAt: DateTime.tryParse(r.date),
    ));
  }

  // ── Weight records ──────────────────────────────────────────────
  for (final r in weightRecords) {
    final animal = animalById[r.animalId];
    final systemId = animal?.systemAnimalId ?? '';
    activities.add(MockActivity(
      id: 'w_${r.id}',
      title: 'وزن مسجل',
      subtitle: systemId.isNotEmpty
          ? '$systemId — ${r.weight} ${r.unit}'
          : '${r.weight} ${r.unit}',
      timeAgo: '',
      icon: '⚖️',
      createdAt: DateTime.tryParse(r.recordedAt),
    ));
  }

  // ── Breeding records (past deliveries only) ─────────────────────
  final now = DateTime.now();
  for (final r in breedingRecords) {
    final date = DateTime.tryParse(r.deliveryDate);
    if (date == null || date.isAfter(now)) continue;
    final parts = [r.damSystemId, r.damName]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .toList();
    activities.add(MockActivity(
      id: 'b_${r.id}',
      title: r.offspringCount > 0 ? 'ولادة مسجلة' : 'حمل مسجل',
      subtitle: parts.isEmpty ? '' : parts.join(' — '),
      timeAgo: '',
      icon: r.offspringCount > 0 ? '🐣' : '📅',
      createdAt: date,
    ));
  }

  // Sort newest first, cap at 20
  activities.sort((a, b) {
    final aDate = a.createdAt ?? DateTime(2000);
    final bDate = b.createdAt ?? DateTime(2000);
    return bDate.compareTo(aDate);
  });

  return activities.take(20).toList();
});
