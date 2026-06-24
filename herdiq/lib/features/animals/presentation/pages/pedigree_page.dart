import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/animal_provider.dart';

// ── Pedigree Page ─────────────────────────────────────────────────────────────
class PedigreePage extends ConsumerWidget {
  final String animalId;
  const PedigreePage({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final animal = ref.watch(animalByIdProvider(animalId));

    if (animal == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          elevation: 0,
          title: Text(l.pedigreeTitle),
        ),
        body: Center(child: Text(l.animalDetailNotFound)),
      );
    }

    // Fetch parents
    final dam  = animal.damId  != null ? ref.watch(animalByIdProvider(animal.damId!))  : null;
    final sire = animal.sireId != null ? ref.watch(animalByIdProvider(animal.sireId!)) : null;

    // Fetch grandparents
    final damDam   = dam?.damId   != null ? ref.watch(animalByIdProvider(dam!.damId!))   : null;
    final damSire  = dam?.sireId  != null ? ref.watch(animalByIdProvider(dam!.sireId!))  : null;
    final sireDam  = sire?.damId  != null ? ref.watch(animalByIdProvider(sire!.damId!))  : null;
    final sireSire = sire?.sireId != null ? ref.watch(animalByIdProvider(sire!.sireId!)) : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
        title: Text(l.pedigreeTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Subject animal ──────────────────────────────────────────
              _SectionLabel(label: l.pedigreeSubject),
              const SizedBox(height: 8),
              _PedigreeNode(animal: animal, isRoot: true, ref: ref),

              const SizedBox(height: 24),

              // ── Parents row ─────────────────────────────────────────────
              _SectionLabel(label: l.pedigreeParents),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ParentColumn(
                      label: l.pedigreeDam,
                      animal: dam,
                      onTap: dam != null
                          ? () => context.push('/home/animals/${dam.id}')
                          : null,
                      ref: ref,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ParentColumn(
                      label: l.pedigreeSire,
                      animal: sire,
                      onTap: sire != null
                          ? () => context.push('/home/animals/${sire.id}')
                          : null,
                      ref: ref,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── Grandparents row ─────────────────────────────────────────
              _SectionLabel(label: l.pedigreeGrandparents),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _GrandparentColumn(
                      maternalLabel: l.pedigreeMaternalDam,
                      paternalLabel: l.pedigreeMaternalSire,
                      maternal: damDam,
                      paternal: damSire,
                      ref: ref,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GrandparentColumn(
                      maternalLabel: l.pedigreePaternaldDam,
                      paternalLabel: l.pedigreePaternaldSire,
                      maternal: sireDam,
                      paternal: sireSire,
                      ref: ref,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w700, color: AppColors.primary)),
      ],
    );
  }
}

// ── Single pedigree node card ─────────────────────────────────────────────────
class _PedigreeNode extends StatelessWidget {
  final MockAnimal? animal;
  final bool isRoot;
  final WidgetRef ref;
  final VoidCallback? onTap;

  const _PedigreeNode({
    required this.animal,
    this.isRoot = false,
    required this.ref,
    this.onTap,
  });

  String _colorName(String colorId, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final c = animalColors.where((c) => c.id == colorId).firstOrNull;
    return locale.languageCode == 'ar' ? (c?.nameAr ?? colorId) : (c?.nameEn ?? colorId);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    if (animal == null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(color: AppColors.tan.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.tan.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.question_mark_rounded, size: 16,
                  color: AppColors.textMuted),
            ),
            const SizedBox(width: 10),
            Text(l.pedigreeUnknown,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted)),
          ],
        ),
      );
    }

    final identity =
        '${animal!.tagNumber} ${_colorName(animal!.colorId, context)}';
    final speciesEmoji = _speciesEmoji(animal!.species);

    return GestureDetector(
      onTap: onTap ?? () => context.push('/home/animals/${animal!.id}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRoot ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: isRoot
                ? AppColors.primary
                : AppColors.tan.withValues(alpha: 0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Species avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isRoot
                    ? Colors.white.withValues(alpha: 0.15)
                    : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(speciesEmoji, style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    identity,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isRoot ? Colors.white : AppColors.primary,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (animal!.name.isNotEmpty)
                    Text(
                      animal!.name,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isRoot
                            ? Colors.white.withValues(alpha: 0.7)
                            : AppColors.textMuted,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    _genderLabel(animal!.gender, context),
                    style: AppTypography.bodyMedium.copyWith(
                      color: isRoot
                          ? Colors.white.withValues(alpha: 0.6)
                          : AppColors.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (!isRoot)
              Icon(Icons.chevron_right_rounded,
                  size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  String _genderLabel(String gender, BuildContext context) {
    final l = AppL.of(context);
    return gender == 'male' ? l.genderMale : l.genderFemale;
  }

  String _speciesEmoji(LivestockSpecies species) {
    switch (species) {
      case LivestockSpecies.sheep:  return '🐑';
      case LivestockSpecies.goat:   return '🐐';
      case LivestockSpecies.camel:  return '🐪';
      case LivestockSpecies.cow:    return '🐄';
      case LivestockSpecies.horse:  return '🐴';
    }
  }
}

// ── Parent column ─────────────────────────────────────────────────────────────
class _ParentColumn extends StatelessWidget {
  final String label;
  final MockAnimal? animal;
  final VoidCallback? onTap;
  final WidgetRef ref;

  const _ParentColumn({
    required this.label,
    required this.animal,
    required this.ref,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: animal != null
                ? AppColors.brown.withValues(alpha: 0.12)
                : AppColors.tan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.brown,
            ),
          ),
        ),
        const SizedBox(height: 6),
        _PedigreeNode(animal: animal, ref: ref, onTap: onTap),
      ],
    );
  }
}

// ── Grandparent column (two stacked nodes) ────────────────────────────────────
class _GrandparentColumn extends StatelessWidget {
  final String maternalLabel;
  final String paternalLabel;
  final MockAnimal? maternal;
  final MockAnimal? paternal;
  final WidgetRef ref;

  const _GrandparentColumn({
    required this.maternalLabel,
    required this.paternalLabel,
    required this.maternal,
    required this.paternal,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _MiniParentEntry(label: maternalLabel, animal: maternal, ref: ref),
        const SizedBox(height: 8),
        _MiniParentEntry(label: paternalLabel, animal: paternal, ref: ref),
      ],
    );
  }
}

// ── Small grandparent node ────────────────────────────────────────────────────
class _MiniParentEntry extends StatelessWidget {
  final String label;
  final MockAnimal? animal;
  final WidgetRef ref;

  const _MiniParentEntry({
    required this.label,
    required this.animal,
    required this.ref,
  });

  String _colorName(String colorId, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final c = animalColors.where((c) => c.id == colorId).firstOrNull;
    return locale.languageCode == 'ar' ? (c?.nameAr ?? colorId) : (c?.nameEn ?? colorId);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    return GestureDetector(
      onTap: animal != null
          ? () => context.push('/home/animals/${animal!.id}')
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.tan.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.brown,
              ),
            ),
            const SizedBox(height: 2),
            if (animal == null)
              Text(l.pedigreeUnknown,
                  style: AppTypography.bodyMedium
                      .copyWith(fontSize: 11, color: AppColors.textMuted))
            else
              Text(
                '${animal!.tagNumber} ${_colorName(animal!.colorId, context)}',
                style: AppTypography.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
