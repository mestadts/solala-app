import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../providers/health_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/animal_multi_picker.dart';

class AddPregnancyPage extends ConsumerStatefulWidget {
  const AddPregnancyPage({super.key});

  @override
  ConsumerState<AddPregnancyPage> createState() => _AddPregnancyPageState();
}

class _AddPregnancyPageState extends ConsumerState<AddPregnancyPage> {
  List<String> _selectedAnimalIds = [];
  final _matingDateCt     = TextEditingController();
  final _expectedDateCt   = TextEditingController();
  final _sireCt           = TextEditingController();
  final _notesCt          = TextEditingController();
  bool _isLoading = false;

  static const Map<LivestockSpecies, int> _gestationMonths = {
    LivestockSpecies.sheep:  5,
    LivestockSpecies.goat:   5,
    LivestockSpecies.cow:    9,
    LivestockSpecies.camel: 13,
    LivestockSpecies.horse: 11,
  };

  @override
  void dispose() {
    _matingDateCt.dispose();
    _expectedDateCt.dispose();
    _sireCt.dispose();
    _notesCt.dispose();
    super.dispose();
  }

  void _onMatingDateChanged(String val) {
    // Use first selected animal's species for gestation calculation
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    if (_selectedAnimalIds.isEmpty) return;
    final animal = animals.firstWhere(
      (a) => a.id == _selectedAnimalIds.first,
      orElse: () => animals.first,
    );
    try {
      final mating = DateTime.parse(val);
      final months = _gestationMonths[animal.species] ?? 5;
      final expected = DateTime(mating.year, mating.month + months, mating.day);
      setState(() {
        _expectedDateCt.text = expected.toString().substring(0, 10);
      });
    } catch (_) {}
  }

  Future<void> _save() async {
    final l = AppL.of(context);
    if (_selectedAnimalIds.isEmpty || _matingDateCt.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    final ts = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < _selectedAnimalIds.length; i++) {
      final id = _selectedAnimalIds[i];
      final animal = animals.firstWhere((a) => a.id == id,
          orElse: () => animals.first);

      // Compute expected date per animal (species-specific)
      String expectedDate = _expectedDateCt.text.trim();
      if (_matingDateCt.text.trim().isNotEmpty) {
        try {
          final mating = DateTime.parse(_matingDateCt.text.trim());
          final months = _gestationMonths[animal.species] ?? 5;
          final exp = DateTime(mating.year, mating.month + months, mating.day);
          expectedDate = exp.toString().substring(0, 10);
        } catch (_) {}
      }

      final record = MockHealthRecord(
        id: 'pr-$ts-$i',
        animalId: id,
        animalSystemId: animal.systemAnimalId,
        recordType: 'pregnancy',
        title: 'Pregnancy — Expected $expectedDate',
        date: _matingDateCt.text.trim(),
        nextDueDate: expectedDate.isEmpty ? null : expectedDate,
        notes: _notesCt.text.trim(),
        vetName: '',
      );
      await ref.read(healthActionsProvider).addRecord(record);
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.healthSavedForAnimals(_selectedAnimalIds.length)),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isRtl
                          ? Icons.arrow_forward_ios_rounded
                          : Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    l.addPregnancyTitle,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 20,
                    AppSpacing.screenPadding, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gestation info banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE4EC).withValues(alpha: 0.6),
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          const Text('ℹ️', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l.addPregnancyInfo,
                              style: AppTypography.bodySmall
                                  .copyWith(color: AppColors.brown),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Animal multi-picker (females only)
                    Text(l.addPregnancyDamLabel,
                        style: AppTypography.labelMedium),
                    const SizedBox(height: 8),
                    AnimalMultiPicker(
                      animals: animals,
                      selectedIds: _selectedAnimalIds,
                      filterGender: 'Female',
                      onChanged: (ids) {
                        setState(() => _selectedAnimalIds = ids);
                        // Recalculate expected date when selection changes
                        if (ids.isNotEmpty &&
                            _matingDateCt.text.trim().isNotEmpty) {
                          _onMatingDateChanged(_matingDateCt.text.trim());
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addPregnancyMatingDate,
                      hint: l.dateHint,
                      controller: _matingDateCt,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.favorite_border_rounded,
                          color: AppColors.textMuted, size: 20),
                      onChanged: _onMatingDateChanged,
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addPregnancyExpected,
                      hint: l.dateHint,
                      controller: _expectedDateCt,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.child_friendly_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addPregnancySireLabel,
                      hint: l.addPregnancySireHint,
                      controller: _sireCt,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.male_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addPregnancyNotes,
                      hint: l.addPregnancyNotesHint,
                      controller: _notesCt,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.notes_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    HerdPrimaryButton(
                      label: l.addPregnancySaveBtn,
                      onPressed:
                          _selectedAnimalIds.isNotEmpty &&
                                  _matingDateCt.text.isNotEmpty
                              ? _save
                              : null,
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
