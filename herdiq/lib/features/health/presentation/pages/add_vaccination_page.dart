import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../providers/health_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/animal_multi_picker.dart';

class AddVaccinationPage extends ConsumerStatefulWidget {
  const AddVaccinationPage({super.key});

  @override
  ConsumerState<AddVaccinationPage> createState() => _AddVaccinationPageState();
}

class _AddVaccinationPageState extends ConsumerState<AddVaccinationPage> {
  final _formKey = GlobalKey<FormState>();
  final _vaccineCt = TextEditingController();
  final _dateCt = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10));
  final _nextDueCt = TextEditingController();
  final _vetCt = TextEditingController();
  final _notesCt = TextEditingController();
  List<String> _selectedAnimalIds = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _vaccineCt.dispose();
    _dateCt.dispose();
    _nextDueCt.dispose();
    _vetCt.dispose();
    _notesCt.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppL.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAnimalIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.addVaccinationSelectFirst)),
      );
      return;
    }
    setState(() => _isLoading = true);
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    final ts = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < _selectedAnimalIds.length; i++) {
      final id = _selectedAnimalIds[i];
      final animal = animals.firstWhere((a) => a.id == id,
          orElse: () => animals.first);
      final record = MockHealthRecord(
        id: 'h-$ts-$i',
        animalId: id,
        animalSystemId: animal.systemAnimalId,
        recordType: 'vaccination',
        date: _dateCt.text.trim(),
        nextDueDate:
            _nextDueCt.text.trim().isEmpty ? null : _nextDueCt.text.trim(),
        vetName: _vetCt.text.trim(),
        notes: _notesCt.text.trim(),
        title: _vaccineCt.text.trim(),
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
            // ── App bar ──────────────────────────────────────────────────────
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
                    l.addVaccinationTitle,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // ── Form ─────────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Animal multi-picker
                      Text(l.addVaccinationAnimal,
                          style: AppTypography.labelMedium),
                      const SizedBox(height: 8),
                      AnimalMultiPicker(
                        animals: animals,
                        selectedIds: _selectedAnimalIds,
                        onChanged: (ids) =>
                            setState(() => _selectedAnimalIds = ids),
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addVaccinationVaccineName,
                        hint: l.addVaccinationVaccineHint,
                        controller: _vaccineCt,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty)
                                ? l.addVaccinationRequired
                                : null,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addVaccinationDateGiven,
                        hint: l.dateHint,
                        controller: _dateCt,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty)
                                ? l.addVaccinationRequired
                                : null,
                        suffixIcon: const Icon(Icons.calendar_today_rounded,
                            size: 18, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addVaccinationNextDue,
                        hint: l.dateHint,
                        controller: _nextDueCt,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        suffixIcon: const Icon(Icons.event_rounded,
                            size: 18, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addVaccinationVet,
                        hint: l.addVaccinationVetHint,
                        controller: _vetCt,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addVaccinationNotes,
                        hint: l.addVaccinationNotesHint,
                        controller: _notesCt,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdPrimaryButton(
                        label: l.addVaccinationSaveBtn,
                        onPressed: _save,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 32),
                    ],
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
