import 'package:flutter/material.dart';
import '../../../../../core/constants/breed_data.dart';
import '../../../../../core/constants/livestock_species.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../l10n/app_localizations.dart';

/// Searchable breed dropdown for a given species.
/// Shows a bottom sheet with all breeds + search + "Add custom" option.
class HerdBreedPicker extends StatefulWidget {
  final LivestockSpecies species;
  final String? selectedId;     // current breedEntry.id
  final String? customBreed;    // free-text if user typed a custom breed
  final ValueChanged<String> onIdSelected;   // existing breed selected
  final ValueChanged<String> onCustomEntered; // custom breed text

  const HerdBreedPicker({
    super.key,
    required this.species,
    required this.selectedId,
    required this.customBreed,
    required this.onIdSelected,
    required this.onCustomEntered,
  });

  @override
  State<HerdBreedPicker> createState() => _HerdBreedPickerState();
}

class _HerdBreedPickerState extends State<HerdBreedPicker> {
  void _open() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => _BreedSheet(
        species: widget.species,
        currentId: widget.selectedId,
        onIdSelected: (id) {
          widget.onIdSelected(id);
          Navigator.pop(sheetCtx);
        },
        onCustomEntered: (text) {
          widget.onCustomEntered(text);
          Navigator.pop(sheetCtx);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final hasValue = (widget.selectedId != null) ||
        (widget.customBreed != null && widget.customBreed!.isNotEmpty);

    String displayLabel;
    if (widget.customBreed != null && widget.customBreed!.isNotEmpty) {
      displayLabel = widget.customBreed!;
    } else if (widget.selectedId == null) {
      displayLabel = l.breedPickerNoneSelected;
    } else {
      final breeds = breedsFor(widget.species);
      try {
        final breed = breeds.firstWhere((b) => b.id == widget.selectedId);
        displayLabel = isAr ? breed.nameAr : breed.nameEn;
      } catch (_) {
        displayLabel = widget.selectedId!;
      }
    }

    return GestureDetector(
      onTap: _open,
      child: Container(
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
            const Icon(Icons.category_outlined,
                color: AppColors.textMuted, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                displayLabel,
                style: AppTypography.bodyMedium.copyWith(
                  color: hasValue ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Bottom sheet ──────────────────────────────────────────────────────────────

class _BreedSheet extends StatefulWidget {
  final LivestockSpecies species;
  final String? currentId;
  final ValueChanged<String> onIdSelected;
  final ValueChanged<String> onCustomEntered;

  const _BreedSheet({
    required this.species,
    required this.currentId,
    required this.onIdSelected,
    required this.onCustomEntered,
  });

  @override
  State<_BreedSheet> createState() => _BreedSheetState();
}

class _BreedSheetState extends State<_BreedSheet> {
  final _searchCt = TextEditingController();
  final _customCt = TextEditingController();
  bool _showCustom = false;
  String _query = '';

  @override
  void dispose() {
    _searchCt.dispose();
    _customCt.dispose();
    super.dispose();
  }

  List<BreedEntry> get _filtered {
    final q = _query.toLowerCase();
    final breeds = breedsFor(widget.species);
    if (q.isEmpty) return breeds;
    return breeds
        .where((b) =>
            b.nameEn.toLowerCase().contains(q) ||
            b.nameAr.contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, ctrl) => Column(
        children: [
          // Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.tan,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              l.breedPickerTitle,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCt,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: l.breedPickerSearch,
                hintStyle: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // List
          Expanded(
            child: ListView.builder(
              controller: ctrl,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: _filtered.length + 1, // +1 for "Add custom"
              itemBuilder: (_, i) {
                if (i == _filtered.length) {
                  // Add custom breed option
                  return _showCustom
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _customCt,
                                  autofocus: true,
                                  textDirection: isAr
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  decoration: InputDecoration(
                                    hintText: l.breedPickerCustomHint,
                                    filled: true,
                                    fillColor: AppColors.surface,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSpacing.radiusMedium),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (_customCt.text.trim().isNotEmpty) {
                                    widget.onCustomEntered(
                                        _customCt.text.trim());
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusMedium),
                                  ),
                                ),
                                child: Text(l.breedPickerCustomSave,
                                    style:
                                        const TextStyle(color: AppColors.onPrimary)),
                              ),
                            ],
                          ),
                        )
                      : TextButton.icon(
                          onPressed: () =>
                              setState(() => _showCustom = true),
                          icon: const Icon(Icons.add_rounded,
                              color: AppColors.brown, size: 18),
                          label: Text(
                            l.breedPickerAddCustom,
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.brown),
                          ),
                        );
                }
                final breed = _filtered[i];
                final selected = widget.currentId == breed.id;
                final primaryName = isAr ? breed.nameAr : breed.nameEn;
                final secondaryName = isAr ? breed.nameEn : breed.nameAr;
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 4),
                  leading: selected
                      ? const Icon(Icons.check_circle_rounded,
                          color: AppColors.primary, size: 20)
                      : const Icon(Icons.circle_outlined,
                          color: AppColors.tan, size: 20),
                  title: Text(
                    primaryName,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  subtitle: Text(
                    secondaryName,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  onTap: () => widget.onIdSelected(breed.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
