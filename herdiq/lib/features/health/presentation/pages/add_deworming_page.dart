import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

class AddDewormingPage extends ConsumerStatefulWidget {
  const AddDewormingPage({super.key});

  @override
  ConsumerState<AddDewormingPage> createState() => _AddDewormingPageState();
}

class _AddDewormingPageState extends ConsumerState<AddDewormingPage> {
  List<String> _selectedAnimalIds = [];
  String _product = 'Ivermectin';
  final _dateCt    = TextEditingController();
  final _nextCt    = TextEditingController();
  final _doseCt    = TextEditingController();
  final _notesCt   = TextEditingController();
  bool _isLoading  = false;

  // Product names are intentionally kept in English — international drug names
  static const _products = [
    'Ivermectin',
    'Albendazole',
    'Levamisole',
    'Fenbendazole',
    'Moxidectin',
    'Other',
  ];

  @override
  void dispose() {
    _dateCt.dispose();
    _nextCt.dispose();
    _doseCt.dispose();
    _notesCt.dispose();
    super.dispose();
  }

  void _onDateChanged(String val) {
    try {
      final d = DateTime.parse(val);
      final next = DateTime(d.year, d.month + 3, d.day);
      setState(() {
        _nextCt.text = next.toString().substring(0, 10);
      });
    } catch (_) {}
  }

  Future<void> _save() async {
    final l = AppL.of(context);
    if (_selectedAnimalIds.isEmpty || _dateCt.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    final ts = DateTime.now().millisecondsSinceEpoch;

    for (var i = 0; i < _selectedAnimalIds.length; i++) {
      final id = _selectedAnimalIds[i];
      final animal = animals.firstWhere((a) => a.id == id,
          orElse: () => animals.first);
      final record = MockHealthRecord(
        id: 'dw-$ts-$i',
        animalId: id,
        animalSystemId: animal.systemAnimalId,
        recordType: 'deworming',
        title: 'Deworming — $_product',
        date: _dateCt.text.trim(),
        nextDueDate:
            _nextCt.text.trim().isEmpty ? null : _nextCt.text.trim(),
        notes: _notesCt.text.trim().isEmpty
            ? 'Dose: ${_doseCt.text.trim()}'
            : 'Dose: ${_doseCt.text.trim()} · ${_notesCt.text.trim()}',
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
                    l.addDewormingTitle,
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
                    // Animal multi-picker
                    Text(l.addDewormingAnimal,
                        style: AppTypography.labelMedium),
                    const SizedBox(height: 8),
                    AnimalMultiPicker(
                      animals: animals,
                      selectedIds: _selectedAnimalIds,
                      onChanged: (ids) =>
                          setState(() => _selectedAnimalIds = ids),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    // Product dropdown (drug names stay in English)
                    Text(l.addDewormingProduct,
                        style: AppTypography.labelMedium),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _product,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        dropdownColor: AppColors.surface,
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.primary),
                        items: _products
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _product = v ?? _product),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addDewormingDateGiven,
                      hint: l.dateHint,
                      controller: _dateCt,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.calendar_today_rounded,
                          color: AppColors.textMuted, size: 20),
                      onChanged: _onDateChanged,
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addDewormingNextDue,
                      hint: l.dateHint,
                      controller: _nextCt,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.event_repeat_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addDewormingDose,
                      hint: l.addDewormingDoseHint,
                      controller: _doseCt,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.medication_liquid_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.addDewormingNotes,
                      hint: l.addDewormingNotesHint,
                      controller: _notesCt,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.notes_rounded,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    HerdPrimaryButton(
                      label: l.addDewormingSaveBtn,
                      onPressed:
                          _selectedAnimalIds.isNotEmpty && _dateCt.text.isNotEmpty
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
