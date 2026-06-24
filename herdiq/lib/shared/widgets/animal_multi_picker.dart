import 'package:flutter/material.dart';
import '../../core/constants/color_data.dart';
import '../../core/constants/livestock_species.dart';
import '../../core/mock/mock_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

/// Returns the localized label for an animal: "tagNumber colorName" (e.g. "50 احمر")
String animalLabel(MockAnimal animal, {required bool isAr}) {
  final color = animalColors.firstWhere(
    (c) => c.id == animal.colorId,
    orElse: () => animalColors.first,
  );
  final colorName = isAr ? color.nameAr : color.nameEn;
  final tag = animal.tagNumber > 0 ? '${animal.tagNumber}' : animal.breederTag;
  return '$tag $colorName';
}

/// A tappable field that opens a bottom sheet for selecting one or more animals.
/// Shows animals identified by "tagNumber colorName" format.
class AnimalMultiPicker extends StatelessWidget {
  final List<MockAnimal> animals;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onChanged;

  /// Optionally restrict picker to a subset (e.g., females only for pregnancy)
  final String? filterGender;

  const AnimalMultiPicker({
    super.key,
    required this.animals,
    required this.selectedIds,
    required this.onChanged,
    this.filterGender,
  });

  List<MockAnimal> get _filtered =>
      filterGender == null
          ? animals
          : animals.where((a) => a.gender == filterGender).toList();

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final filtered = _filtered;

    String label;
    if (selectedIds.isEmpty) {
      label = l.animalPickerTap;
    } else if (selectedIds.length == 1) {
      final a = filtered.firstWhere(
        (a) => a.id == selectedIds.first,
        orElse: () => animals.firstWhere(
          (a) => a.id == selectedIds.first,
          orElse: () => animals.first,
        ),
      );
      label = animalLabel(a, isAr: isAr);
    } else {
      label = l.animalPickerSelectedLabel(selectedIds.length);
    }

    return GestureDetector(
      onTap: () async {
        final result = await showModalBottomSheet<List<String>>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _AnimalPickerSheet(
            animals: filtered,
            initialSelected: selectedIds,
          ),
        );
        if (result != null) onChanged(result);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: selectedIds.isEmpty
                      ? AppColors.textMuted
                      : AppColors.primary,
                  fontWeight: selectedIds.isEmpty
                      ? FontWeight.w400
                      : FontWeight.w600,
                ),
              ),
            ),
            // Color swatch dots for selected animals (up to 3)
            if (selectedIds.isNotEmpty) ...[
              ...selectedIds.take(3).map((id) {
                final a = animals.firstWhere((a) => a.id == id,
                    orElse: () => animals.first);
                final color = animalColors.firstWhere(
                  (c) => c.id == a.colorId,
                  orElse: () => animalColors.first,
                );
                return Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsetsDirectional.only(end: 4),
                  decoration: BoxDecoration(
                    color: color.swatch,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                );
              }),
              if (selectedIds.length > 3)
                Text(
                  '+${selectedIds.length - 3}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
            ],
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 20, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

// ── Bottom sheet ────────────────────────────────────────────────────────────

class _AnimalPickerSheet extends StatefulWidget {
  final List<MockAnimal> animals;
  final List<String> initialSelected;
  const _AnimalPickerSheet({
    required this.animals,
    required this.initialSelected,
  });

  @override
  State<_AnimalPickerSheet> createState() => _AnimalPickerSheetState();
}

class _AnimalPickerSheetState extends State<_AnimalPickerSheet> {
  late Set<String> _selected;
  String _search = '';

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelected);
  }

  List<MockAnimal> get _filtered {
    if (_search.isEmpty) return widget.animals;
    final q = _search.toLowerCase();
    return widget.animals.where((a) {
      final label = animalLabel(a, isAr: true).toLowerCase();
      final labelEn = animalLabel(a, isAr: false).toLowerCase();
      final tag = '${a.tagNumber}'.toLowerCase();
      return label.contains(q) || labelEn.contains(q) || tag.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final filtered = _filtered;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.tan.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                children: [
                  Text(
                    l.animalPickerTitle,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  if (_selected.isNotEmpty)
                    GestureDetector(
                      onTap: () => setState(() => _selected.clear()),
                      child: Text(
                        l.btnClear,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: TextField(
                  autofocus: false,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: l.animalPickerSearch,
                    hintStyle: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: AppColors.textMuted),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Animal list
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        l.animalPickerNone,
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textMuted),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollCtrl,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final a = filtered[i];
                        final selected = _selected.contains(a.id);
                        final color = animalColors.firstWhere(
                          (c) => c.id == a.colorId,
                          orElse: () => animalColors.first,
                        );
                        return GestureDetector(
                          onTap: () => setState(() {
                            if (selected) {
                              _selected.remove(a.id);
                            } else {
                              _selected.add(a.id);
                            }
                          }),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary.withValues(alpha: 0.06)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : Colors.transparent,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Color swatch
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: color.swatch,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black
                                          .withValues(alpha: 0.08),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Label
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        animalLabel(a, isAr: isAr),
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${a.species.emoji} ${isAr ? a.species.nameAr : a.species.displayName}',
                                        style: AppTypography.bodySmall
                                            .copyWith(
                                                color: AppColors.textMuted),
                                      ),
                                    ],
                                  ),
                                ),

                                // Checkbox
                                AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 150),
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? AppColors.primary
                                        : AppColors.surface,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: selected
                                          ? AppColors.primary
                                          : AppColors.tan,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: selected
                                      ? const Icon(Icons.check_rounded,
                                          size: 14,
                                          color: AppColors.onPrimary)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Apply button
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, 8, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected.isEmpty
                      ? null
                      : () => Navigator.pop(context, _selected.toList()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    disabledBackgroundColor:
                        AppColors.tan.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMedium),
                    ),
                  ),
                  child: Text(
                    l.animalPickerApply(_selected.length),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
