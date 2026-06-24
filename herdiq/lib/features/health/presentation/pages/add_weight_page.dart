import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../providers/weight_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class AddWeightPage extends ConsumerStatefulWidget {
  const AddWeightPage({super.key});

  @override
  ConsumerState<AddWeightPage> createState() => _AddWeightPageState();
}

class _AddWeightPageState extends ConsumerState<AddWeightPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightCt = TextEditingController();
  final _dateCt = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10));
  String? _selectedAnimalId;
  String _unit = 'kg';
  bool _isOfficial = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _weightCt.dispose();
    _dateCt.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppL.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAnimalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.addWeightSelectFirst)),
      );
      return;
    }
    setState(() => _isLoading = true);

    final record = MockWeightRecord(
      id: 'w-${DateTime.now().millisecondsSinceEpoch}',
      animalId: _selectedAnimalId!,
      weight: double.tryParse(_weightCt.text.trim()) ?? 0,
      unit: _unit,
      recordedAt: _dateCt.text.trim(),
      isOfficial: _isOfficial,
    );

    await ref.read(weightActionsProvider).addRecord(record);
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
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
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    l.addWeightTitle,
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

                      Text(l.addVaccinationAnimal, style: AppTypography.labelMedium),
                      const SizedBox(height: 8),
                      _AnimalDropdown(
                        animals: animals,
                        selectedId: _selectedAnimalId,
                        hint: l.addVaccinationSelectAnimal,
                        onChanged: (id) =>
                            setState(() => _selectedAnimalId = id),
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      // Weight + unit row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: HerdTextField(
                              label: l.addWeightLabel,
                              hint: l.addWeightHint,
                              controller: _weightCt,
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              textInputAction: TextInputAction.next,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return l.addWeightRequired;
                                }
                                if (double.tryParse(v.trim()) == null) {
                                  return l.addWeightInvalid;
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l.addWeightUnit,
                                  style: AppTypography.labelMedium),
                              const SizedBox(height: 8),
                              _UnitToggle(
                                selected: _unit,
                                onChanged: (u) => setState(() => _unit = u),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.addWeightDateLabel,
                        hint: l.dateHint,
                        controller: _dateCt,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.done,
                        validator: (v) =>
                            (v == null || v.trim().isEmpty)
                                ? l.addWeightRequired
                                : null,
                        suffixIcon: const Icon(Icons.calendar_today_rounded,
                            size: 18, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      // Official toggle
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium),
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
                            const Icon(Icons.verified_rounded,
                                size: 18, color: AppColors.statusActive),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l.addWeightOfficial,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    l.addWeightOfficialDesc,
                                    style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textMuted),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _isOfficial,
                              onChanged: (v) =>
                                  setState(() => _isOfficial = v),
                              activeThumbColor: AppColors.statusActive,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdPrimaryButton(
                        label: l.addWeightSaveBtn,
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

// ── Unit toggle ────────────────────────────────────────────────────────────────

class _UnitToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  const _UnitToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['kg', 'lbs'].map((u) {
        final active = selected == u;
        return GestureDetector(
          onTap: () => onChanged(u),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 52,
            height: 50,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.surface,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(
                color: active ? AppColors.primary : AppColors.tan,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                u,
                style: AppTypography.bodyMedium.copyWith(
                  color: active ? AppColors.onPrimary : AppColors.brown,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Animal dropdown ────────────────────────────────────────────────────────────

class _AnimalDropdown extends StatelessWidget {
  final List<MockAnimal> animals;
  final String? selectedId;
  final String hint;
  final ValueChanged<String?> onChanged;
  const _AnimalDropdown({
    required this.animals,
    required this.selectedId,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: DropdownButtonFormField<String>(
        initialValue: selectedId,
        hint: Text(
          hint,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        dropdownColor: AppColors.surface,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        items: animals
            .map((a) => DropdownMenuItem(
                  value: a.id,
                  child: Text(
                      '${a.species.emoji}  ${a.name.isEmpty ? a.systemAnimalId : a.name}'),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
