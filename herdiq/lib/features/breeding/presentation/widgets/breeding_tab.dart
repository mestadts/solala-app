import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../features/animals/presentation/providers/animal_provider.dart';
import '../providers/breeding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class BreedingTab extends ConsumerWidget {
  final String animalId;
  const BreedingTab({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final records = ref.watch(breedingByAnimalProvider(animalId)).valueOrNull ?? [];
    final animal  = ref.watch(animalByIdProvider(animalId));
    final offspring = ref.watch(offspringByAnimalProvider(animalId));

    // Detect active pregnancy: future deliveryDate with no offspring yet
    final now = DateTime.now();
    MockBreedingRecord? activePregnancy;
    for (final r in records) {
      final d = DateTime.tryParse(r.deliveryDate);
      if (d != null && d.isAfter(now) && r.offspringCount == 0) {
        activePregnancy = r;
        break;
      }
    }

    // Past records (completed deliveries)
    final pastRecords = records.where((r) {
      final d = DateTime.tryParse(r.deliveryDate);
      return d == null || d.isBefore(now) || r.offspringCount > 0;
    }).toList();

    // "Add Newborn" is only for females
    final isFemale = animal?.gender == 'Female';

    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding, 12, AppSpacing.screenPadding, 80),
      children: [
        // ── Active pregnancy banner ─────────────────────────────────────────
        if (activePregnancy != null) ...[
          _PregnancyBanner(record: activePregnancy),
          const SizedBox(height: 16),
        ],

        // ── Action buttons row ─────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.push('/home/animals/$animalId/add-breeding'),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(l.breedingAddRecord),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    context.push('/home/animals/$animalId/pedigree'),
                icon: const Icon(Icons.account_tree_rounded, size: 18),
                label: Text(l.pedigreeViewBtn),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.brown,
                  side: const BorderSide(color: AppColors.brown),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Register Birth button (females only) ──────────────────────────
        if (isFemale && animal != null) ...[
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () =>
                context.push('/home/animals/$animalId/register-birth'),
            icon: const Icon(Icons.child_care_rounded, size: 18),
            label: Text(isAr ? 'إضافة ولادة' : 'Register Birth'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
            ),
          ),
        ],

        const SizedBox(height: 20),

        if (pastRecords.isEmpty && activePregnancy == null && offspring.isEmpty)
          _EmptyState(l: l)
        else ...[
          if (pastRecords.isNotEmpty) ...[
            Text(
              l.breedingRecordsTitle,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ...pastRecords.map((r) => _BreedingRecordCard(record: r, l: l)),
            const SizedBox(height: 8),
          ],

          // ── Offspring list ───────────────────────────────────────────────
          if (offspring.isNotEmpty) ...[
            Text(
              isAr ? 'المواليد (${offspring.length})' : 'Offspring (${offspring.length})',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ...offspring.map((o) => _OffspringCard(animal: o, isAr: isAr)),
          ],
        ],
      ],
    );
  }
}

// ── Active pregnancy banner ────────────────────────────────────────────────────

class _PregnancyBanner extends StatelessWidget {
  final MockBreedingRecord record;
  const _PregnancyBanner({required this.record});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final delivery = DateTime.tryParse(record.deliveryDate);
    final daysLeft = delivery != null
        ? delivery.difference(DateTime.now()).inDays
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.statusActive.withValues(alpha: 0.15),
            AppColors.statusActive.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.statusActive.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.statusActive.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('🤰', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.breedingActivePregnancy,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.statusActive,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l.breedingExpectedDeliveryIn(daysLeft),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                if (record.sireName != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${l.breedingSire}: ${record.sireName}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ],
            ),
          ),
          // Days pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.statusActive,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$daysLeft',
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final AppL l;
  const _EmptyState({required this.l});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Column(
        children: [
          const Text('🐣', style: TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            l.breedingNoRecords,
            style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            l.breedingNoRecordsHint,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Breeding record card ───────────────────────────────────────────────────────

class _BreedingRecordCard extends StatelessWidget {
  final MockBreedingRecord record;
  final AppL l;
  const _BreedingRecordCard({required this.record, required this.l});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──────────────────────────────────────────────────
          Row(
            children: [
              const Text('🐣', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l.breedingDeliveryOn(record.deliveryDate),
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
              // Offspring count badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusActive.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${record.survivingCount}/${record.offspringCount}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.statusActive,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // ── Dam / Sire info ─────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _ParentInfo(
                  role: l.breedingDam,
                  name: record.damName,
                  systemId: record.damSystemId,
                  l: l,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ParentInfo(
                  role: l.breedingSire,
                  name: record.sireName,
                  systemId: record.sireSystemId,
                  l: l,
                ),
              ),
            ],
          ),

          if (record.notes.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              record.notes,
              style:
                  AppTypography.bodySmall.copyWith(color: AppColors.brown),
            ),
          ],

          const SizedBox(height: 8),

          // ── Offspring summary ───────────────────────────────────────────
          Row(
            children: [
              const Icon(Icons.child_care_rounded,
                  size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                l.breedingOffspringInfo(record.offspringCount, record.survivingCount),
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Offspring card ─────────────────────────────────────────────────────────────

class _OffspringCard extends StatelessWidget {
  final MockAnimal animal;
  final bool isAr;
  const _OffspringCard({required this.animal, required this.isAr});

  @override
  Widget build(BuildContext context) {
    final colorEntry = animalColors
        .where((c) => c.id == animal.colorId)
        .firstOrNull;
    final colorName = isAr ? (colorEntry?.nameAr ?? '') : (colorEntry?.nameEn ?? '');
    final identity  = '${animal.tagNumber} $colorName'.trim();

    return GestureDetector(
      onTap: () => context.push('/home/animals/${animal.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(color: AppColors.tan.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            // Color swatch
            if (colorEntry != null)
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsetsDirectional.only(end: 10),
                decoration: BoxDecoration(
                  color: colorEntry.swatch,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
              ),
            // Identity + species
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    identity,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${animal.species.emoji}  '
                    '${isAr ? animal.species.nameAr : animal.species.displayName}'
                    '  ·  '
                    '${animal.gender == 'Male' ? (isAr ? 'ذكر' : 'Male') : (isAr ? 'أنثى' : 'Female')}',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _ParentInfo extends StatelessWidget {
  final String role;
  final String? name;
  final String? systemId;
  final AppL l;
  const _ParentInfo({required this.role, this.name, this.systemId, required this.l});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role,
          style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 2),
        Text(
          name ?? l.breedingUnknown,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        if (systemId != null)
          Text(
            systemId!,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.brown,
              fontSize: 10,
            ),
          ),
      ],
    );
  }
}
