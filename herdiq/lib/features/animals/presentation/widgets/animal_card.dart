import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/config/species_terms_provider.dart';
import '../../../../../core/constants/color_data.dart';
import '../../../../../core/constants/livestock_species.dart';
import '../../../../../core/constants/udhiya_rules.dart';
import '../../../../../core/mock/mock_data.dart';
import '../../../../../core/providers/date_format_provider.dart';
import '../../../../../core/routing/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../l10n/app_localizations.dart';
import '../providers/animal_provider.dart';
import '../../../../../shared/widgets/species_badge.dart';
import '../../../../../shared/widgets/status_badge.dart';

enum _CardAction { edit, duplicate, sell, slaughter, dead, delete }

class AnimalCard extends ConsumerWidget {
  final MockAnimal animal;

  const AnimalCard({super.key, required this.animal});

  String _colorName(String colorId, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final color = animalColors.where((c) => c.id == colorId).firstOrNull;
    if (locale.languageCode == 'ar') return color?.nameAr ?? colorId;
    return color?.nameEn ?? colorId;
  }

  String _ageText(String dob, bool isAr) {
    final d = DateTime.tryParse(dob);
    if (d == null) return '';
    final days = DateTime.now().difference(d).inDays;
    if (days < 0) return '';
    if (days < 31) return isAr ? '$days يوم' : '${days}d';
    final months = days ~/ 30;
    if (months < 24) return isAr ? '$months شهر' : '${months}mo';
    return isAr ? '${days ~/ 365} سنة' : '${days ~/ 365}y';
  }

  bool _isWeaningActive(MockAnimal a) {
    if (a.weaningFromDays == null || a.weaningToDays == null) return false;
    final dob = DateTime.tryParse(a.dateOfBirth);
    if (dob == null) return false;
    final age = DateTime.now().difference(dob).inDays;
    return age >= a.weaningFromDays! && age <= a.weaningToDays!;
  }

  void _handleAction(
      BuildContext context, WidgetRef ref, _CardAction action, AppL l) {
    switch (action) {
      case _CardAction.edit:
        context.push('/home/animals/${animal.id}/edit');
      case _CardAction.duplicate:
        context.push(Routes.addAnimal, extra: animal);
      case _CardAction.sell:
        ref
            .read(animalActionsProvider)
            .updateAnimal(animal.copyWith(status: AnimalStatus.sold));
      case _CardAction.slaughter:
        _confirmStatus(context, ref, AnimalStatus.deceased,
            l.animalActionSlaughterConfirm, l);
      case _CardAction.dead:
        _confirmStatus(context, ref, AnimalStatus.deceased,
            l.animalActionDeadConfirm, l);
      case _CardAction.delete:
        _confirmDelete(context, ref, l);
    }
  }

  void _confirmStatus(BuildContext context, WidgetRef ref,
      AnimalStatus newStatus, String message, AppL l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.background,
        content:
            Text(message, style: AppTypography.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.btnCancel,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.brown)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(animalActionsProvider)
                  .updateAnimal(animal.copyWith(status: newStatus));
              Navigator.pop(context);
            },
            child: Text(l.btnConfirm,
                style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.statusError,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, AppL l) {
    final displayName =
        animal.name.isNotEmpty ? animal.name : animal.systemAnimalId;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          l.animalDetailDeleteTitle(displayName),
          style: AppTypography.bodyMedium
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: Text(l.animalDetailDeleteMsg(displayName),
            style: AppTypography.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.btnCancel,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.brown)),
          ),
          TextButton(
            onPressed: () {
              ref.read(animalActionsProvider).deleteAnimal(animal.id);
              Navigator.pop(context);
            },
            child: Text(l.btnDelete,
                style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.statusError,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<_CardAction> _menuItem(
      _CardAction value, IconData icon, String label, Color color) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Text(label,
              style: AppTypography.bodyMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final showUdhiya = ref.watch(udhiyaShowProvider);
    final terms =
        ref.watch(speciesTermsProvider).valueOrNull ?? defaultSpeciesTerms;
    final colorName = _colorName(animal.colorId, context);
    final primaryIdentity =
        l.animalIdentity(animal.tagNumber.toString(), colorName);
    final weaningActive = _isWeaningActive(animal);
    final genderTerm =
        resolveGenderTerm(animal.species, animal.gender, isAr, terms,
            dateOfBirth: animal.dateOfBirth);

    bool? udhiyaEligible;
    if (showUdhiya) {
      udhiyaEligible = isUdhiyaEligible(
        species: animal.species,
        dateOfBirth: animal.dateOfBirth,
        status: animal.status,
      );
    }

    final tagCol = colorById(animal.tagColorId);
    final tagSwatch = tagCol?.swatch ?? AppColors.tan;
    final bodyCol = colorById(animal.colorId);

    return GestureDetector(
      onTap: () => context.push('/home/animals/${animal.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ── Tag color stripe ───────────────────────────────────
                Container(width: 5, color: tagSwatch),

                // ── Card content ───────────────────────────────────────
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 4, 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Species avatar ─────────────────────────────
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: animal.species.color
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMedium),
                          ),
                          child: Center(
                            child: Text(
                              animal.species.emoji,
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // ── Info column ────────────────────────────────
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ① Primary identity — largest, boldest
                              Text(
                                primaryIdentity,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              // System ID — subtle secondary line
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.lock_outline,
                                      size: 10,
                                      color: AppColors.textMuted),
                                  const SizedBox(width: 3),
                                  Text(
                                    animal.systemAnimalId,
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                      color: AppColors.textMuted,
                                      fontSize: 10,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // Age badge
                              Builder(builder: (ctx) {
                                final ageStr = _ageText(animal.dateOfBirth, isAr);
                                if (ageStr.isEmpty) return const SizedBox.shrink();
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.tan.withValues(alpha: 0.45),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.cake_outlined, size: 10, color: AppColors.brown),
                                      const SizedBox(width: 3),
                                      Text(ageStr, style: AppTypography.bodySmall.copyWith(
                                        fontSize: 10,
                                        color: AppColors.brown,
                                        fontWeight: FontWeight.w600,
                                      )),
                                    ],
                                  ),
                                );
                              }),
                              const SizedBox(height: 5),
                              // ② Status — dedicated row, most scannable
                              StatusBadge(status: animal.status),
                              const SizedBox(height: 6),
                              // ③ Details — species badge + body color dot
                              Row(
                                children: [
                                  SpeciesBadge(species: animal.species),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: bodyCol?.swatch ??
                                          AppColors.tan,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                              // Weaning badge
                              if (weaningActive) ...[
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.statusError
                                        .withValues(alpha: 0.12),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColors.statusError
                                            .withValues(alpha: 0.4)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                          Icons.child_care_rounded,
                                          size: 11,
                                          color: AppColors.statusError),
                                      const SizedBox(width: 4),
                                      Text(
                                        l.animalWeaningBadge,
                                        style: AppTypography.bodySmall
                                            .copyWith(
                                          color: AppColors.statusError,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              // Udhiya badge
                              if (showUdhiya &&
                                  udhiyaEligible != null) ...[
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: udhiyaEligible
                                        ? const Color(0xFF34C759)
                                            .withValues(alpha: 0.12)
                                        : const Color(0xFFFF9F0A)
                                            .withValues(alpha: 0.12),
                                    borderRadius:
                                        BorderRadius.circular(20),
                                    border: Border.all(
                                      color: udhiyaEligible
                                          ? const Color(0xFF34C759)
                                              .withValues(alpha: 0.4)
                                          : const Color(0xFFFF9F0A)
                                              .withValues(alpha: 0.4),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '\u{1F319}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: udhiyaEligible
                                              ? const Color(0xFF34C759)
                                              : const Color(0xFFFF9F0A),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        udhiyaEligible
                                            ? l.udhiyaEligible
                                            : l.udhiyaNotEligible,
                                        style: AppTypography.bodySmall
                                            .copyWith(
                                          color: udhiyaEligible
                                              ? const Color(0xFF34C759)
                                              : const Color(0xFFFF9F0A),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),

                        // ── Right column: ⋮ menu + weight + gender ─────
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            // Three-dots actions menu
                            PopupMenuButton<_CardAction>(
                              padding: EdgeInsets.zero,
                              iconSize: 18,
                              icon: const Icon(Icons.more_vert_rounded,
                                  color: AppColors.textMuted),
                              onSelected: (action) =>
                                  _handleAction(context, ref, action, l),
                              itemBuilder: (ctx) => [
                                _menuItem(
                                    _CardAction.edit,
                                    Icons.edit_rounded,
                                    l.animalActionEdit,
                                    AppColors.primary),
                                _menuItem(
                                    _CardAction.duplicate,
                                    Icons.copy_rounded,
                                    l.animalDuplicate,
                                    AppColors.primary),
                                const PopupMenuDivider(),
                                _menuItem(
                                    _CardAction.sell,
                                    Icons.attach_money,
                                    l.animalActionSell,
                                    const Color(0xFF2196F3)),
                                _menuItem(
                                    _CardAction.slaughter,
                                    Icons.content_cut,
                                    l.animalActionSlaughter,
                                    const Color(0xFFE65100)),
                                _menuItem(
                                    _CardAction.dead,
                                    Icons.cancel_outlined,
                                    l.animalActionMarkDead,
                                    AppColors.textMuted),
                                const PopupMenuDivider(),
                                _menuItem(
                                    _CardAction.delete,
                                    Icons.delete_outline,
                                    l.btnDelete,
                                    AppColors.statusError),
                              ],
                            ),
                            // Weight + gender
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${animal.weight} kg',
                                  style: AppTypography.bodyMedium
                                      .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brown,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  genderTerm,
                                  style: AppTypography.bodySmall
                                      .copyWith(
                                          color: AppColors.textMuted),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
