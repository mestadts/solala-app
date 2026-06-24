import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/config/field_labels_provider.dart';
import '../../../../../core/constants/color_data.dart';
import '../../../../../core/constants/livestock_species.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../l10n/app_localizations.dart';

// Standard ear tag colors
const _kTagColors = [
  (id: 'yellow',  nameAr: 'أصفر',   nameEn: 'Yellow',  swatch: Color(0xFFFDD835)),
  (id: 'orange',  nameAr: 'برتقالي', nameEn: 'Orange',  swatch: Color(0xFFFB8C00)),
  (id: 'red',     nameAr: 'أحمر',    nameEn: 'Red',     swatch: Color(0xFFE53935)),
  (id: 'green',   nameAr: 'أخضر',   nameEn: 'Green',   swatch: Color(0xFF43A047)),
  (id: 'blue',    nameAr: 'أزرق',   nameEn: 'Blue',    swatch: Color(0xFF1E88E5)),
  (id: 'white',   nameAr: 'أبيض',   nameEn: 'White',   swatch: Color(0xFFF5F5F5)),
  (id: 'black',   nameAr: 'أسود',   nameEn: 'Black',   swatch: Color(0xFF212121)),
  (id: 'purple',  nameAr: 'بنفسجي', nameEn: 'Purple',  swatch: Color(0xFF8E24AA)),
  (id: 'pink',    nameAr: 'وردي',   nameEn: 'Pink',    swatch: Color(0xFFE91E63)),
];

/// Color palette grid + tag color picker + numeric tag stepper (0–500).
class HerdColorPicker extends ConsumerWidget {
  final String? selectedColorId;
  final String tagColorId;
  final int tagNumber;
  final LivestockSpecies? species;
  final ValueChanged<String> onColorSelected;
  final ValueChanged<String> onTagColorSelected;
  final ValueChanged<int> onTagChanged;

  const HerdColorPicker({
    super.key,
    required this.selectedColorId,
    this.tagColorId = '',
    required this.tagNumber,
    this.species,
    required this.onColorSelected,
    required this.onTagColorSelected,
    required this.onTagChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final labels = ref.watch(fieldLabelsProvider).valueOrNull ?? FieldLabels.empty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Color palette ────────────────────────────────────────────────────
        Text(labels.animalColorLabel(isAr) ?? l.colorPickerColorLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: colorsForSpecies(species).map((c) {
            final selected = selectedColorId == c.id;
            final colorName = isAr ? c.nameAr : c.nameEn;
            return GestureDetector(
              onTap: () => onColorSelected(c.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: c.swatch,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color:
                                    AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: selected
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 20)
                        : null,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 52,
                    child: Text(
                      colorName,
                      style: AppTypography.bodySmall.copyWith(
                        color: selected
                            ? AppColors.primary
                            : AppColors.textMuted,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // ── Tag (ear tag) color ───────────────────────────────────────────────
        Text(labels.tagColorLabel(isAr) ?? l.tagColorLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _kTagColors.map((c) {
            final selected = tagColorId == c.id;
            final colorName = isAr ? c.nameAr : c.nameEn;
            return GestureDetector(
              onTap: () => onTagColorSelected(c.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: c.swatch,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected ? AppColors.primary : AppColors.tan,
                        width: selected ? 3 : 1,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: selected
                        ? Icon(
                            Icons.check_rounded,
                            color: c.swatch == const Color(0xFFF5F5F5)
                                ? Colors.black
                                : Colors.white,
                            size: 18,
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 46,
                    child: Text(
                      colorName,
                      style: AppTypography.bodySmall.copyWith(
                        color: selected ? AppColors.primary : AppColors.textMuted,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 24),

        // ── Numeric tag scale ─────────────────────────────────────────────────
        Text(labels.tagLabel(isAr) ?? l.tagNumberLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
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
              // Decrement
              IconButton(
                onPressed: tagNumber > 0
                    ? () => onTagChanged(tagNumber - 1)
                    : null,
                icon: const Icon(Icons.remove_rounded),
                color: AppColors.primary,
                disabledColor: AppColors.textMuted,
              ),

              // Value
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '$tagNumber',
                      style: AppTypography.displayMedium.copyWith(
                        fontSize: 28,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Progress bar
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: tagNumber / 500,
                      backgroundColor: AppColors.tan.withValues(alpha: 0.3),
                      valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ],
                ),
              ),

              // Increment
              IconButton(
                onPressed: tagNumber < 500
                    ? () => onTagChanged(tagNumber + 1)
                    : null,
                icon: const Icon(Icons.add_rounded),
                color: AppColors.primary,
                disabledColor: AppColors.textMuted,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Quick-tap presets: +10, +50, +100
        Row(
          children: [10, 50, 100].map((delta) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: OutlinedButton(
                onPressed: tagNumber + delta <= 500
                    ? () => onTagChanged(tagNumber + delta)
                    : null,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.brown,
                  side: const BorderSide(color: AppColors.tan),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                ),
                child: Text('+$delta',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.brown)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
