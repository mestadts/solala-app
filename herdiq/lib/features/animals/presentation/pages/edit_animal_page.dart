import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/animal_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/constants/animal_status.dart';
import '../../../../core/constants/breed_data.dart';
import '../../../../core/config/species_terms_provider.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../providers/custom_fields_provider.dart';
import '../widgets/custom_fields_widget.dart';
import '../widgets/herd_breed_picker.dart';

class EditAnimalPage extends ConsumerStatefulWidget {
  final String animalId;
  const EditAnimalPage({super.key, required this.animalId});

  @override
  ConsumerState<EditAnimalPage> createState() => _EditAnimalPageState();
}

class _EditAnimalPageState extends ConsumerState<EditAnimalPage> {
  final _formKey   = GlobalKey<FormState>();
  late TextEditingController _nameCt;
  late TextEditingController _weightCt;
  late TextEditingController _dobCt;
  late TextEditingController _tagCt;
  String _gender       = 'male';
  AnimalStatus _status = AnimalStatus.active;
  late LivestockSpecies _selectedSpecies;
  String? _selectedBreedId;
  String? _customBreed;
  bool _isLoading    = false;
  bool _initialized  = false;
  final Map<String, dynamic> _customValues = {};

  @override
  void dispose() {
    _nameCt.dispose();
    _weightCt.dispose();
    _dobCt.dispose();
    _tagCt.dispose();
    super.dispose();
  }

  void _init(MockAnimal animal) {
    if (_initialized) return;
    _nameCt   = TextEditingController(text: animal.name);
    _weightCt = TextEditingController(text: animal.weight.toString());
    _dobCt    = TextEditingController(text: animal.dateOfBirth);
    _tagCt    = TextEditingController(text: animal.breederTag);
    _gender   = animal.gender;
    _status   = animal.status;
    _selectedSpecies = animal.species;
    _customValues.addAll(animal.customValues);

    // Determine if the saved breed is a preset id or custom text
    final presets = breedsFor(animal.species);
    final isPreset = presets.any((b) => b.id == animal.breed);
    if (isPreset) {
      _selectedBreedId = animal.breed;
      _customBreed = null;
    } else {
      _selectedBreedId = null;
      _customBreed = animal.breed.isNotEmpty ? animal.breed : null;
    }

    _initialized = true;
  }

  Future<void> _save(MockAnimal original) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final updated = MockAnimal(
      id: original.id,
      systemAnimalId: original.systemAnimalId,
      name: _nameCt.text.trim(),
      species: _selectedSpecies,
      gender: _gender,
      breed: _selectedBreedId ?? _customBreed ?? '',
      dateOfBirth: _dobCt.text.trim(),
      weight: double.tryParse(_weightCt.text.trim()) ?? original.weight,
      status: _status,
      breederTag: _tagCt.text.trim(),
      photoUrl: original.photoUrl,
      speciesAttributes: original.speciesAttributes,
      customValues: Map<String, dynamic>.from(_customValues),
      damId: original.damId,
      sireId: original.sireId,
    );

    try {
      await ref.read(animalActionsProvider).updateAnimal(updated);
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.pop();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final terms =
        ref.watch(speciesTermsProvider).valueOrNull ?? defaultSpeciesTerms;
    final animal = ref.watch(animalByIdProvider(widget.animalId));

    if (animal == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          elevation: 0,
        ),
        body: Center(child: Text(l.editAnimalNotFound)),
      );
    }

    _init(animal);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────────────────
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
                    l.editAnimalTitle(animal.name),
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    animal.systemAnimalId,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.brown,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // ── Form ──────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      // Species selector
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isAr ? 'النوع' : 'Species',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: LivestockSpecies.values.map((s) {
                              final selected = _selectedSpecies == s;
                              return GestureDetector(
                                onTap: () => setState(() {
                                  _selectedSpecies = s;
                                  _selectedBreedId = null;
                                  _customBreed = null;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? AppColors.primary.withValues(alpha: 0.1)
                                        : AppColors.background,
                                    borderRadius: BorderRadius.circular(
                                        AppSpacing.radiusCircle),
                                    border: Border.all(
                                      color: selected
                                          ? AppColors.primary
                                          : AppColors.tan.withValues(alpha: 0.5),
                                      width: 1.2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(s.emoji,
                                          style:
                                              const TextStyle(fontSize: 14)),
                                      const SizedBox(width: 5),
                                      Text(
                                        isAr ? s.nameAr : s.displayName,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: selected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: selected
                                              ? AppColors.primary
                                              : AppColors.brown,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.editAnimalNameLabel,
                        hint: l.editAnimalNameHint,
                        controller: _nameCt,
                        textInputAction: TextInputAction.next,
                        validator: null,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      // Breed picker
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.editAnimalBreedLabel,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          HerdBreedPicker(
                            species: _selectedSpecies,
                            selectedId: _selectedBreedId,
                            customBreed: _customBreed,
                            onIdSelected: (id) => setState(() {
                              _selectedBreedId = id;
                              _customBreed = null;
                            }),
                            onCustomEntered: (text) => setState(() {
                              _customBreed = text;
                              _selectedBreedId = null;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      // Gender toggle
                      _buildGenderToggle(l, isAr, terms),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.editAnimalDobLabel,
                        hint: l.dateHint,
                        controller: _dobCt,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.editAnimalWeightLabel,
                        hint: l.editAnimalWeightHint,
                        controller: _weightCt,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.editAnimalTagLabel,
                        hint: l.editAnimalTagHint,
                        controller: _tagCt,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      // Status selector
                      _buildStatusSelector(l),
                      const SizedBox(height: AppSpacing.sectionGap),

                      // Custom fields
                      Consumer(
                        builder: (ctx, r, _) {
                          final fields = r.watch(
                              customFieldsForSpeciesProvider(
                                  _selectedSpecies.name));
                          if (fields.isEmpty) return const SizedBox.shrink();
                          return Column(
                            children: [
                              CustomFieldsForm(
                                fields: fields,
                                values: _customValues,
                                onChanged: (id, v) =>
                                    setState(() => _customValues[id] = v),
                              ),
                              const SizedBox(height: AppSpacing.sectionGap),
                            ],
                          );
                        },
                      ),

                      HerdPrimaryButton(
                        label: l.editAnimalSaveBtn,
                        onPressed: () => _save(animal),
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

  Widget _buildGenderToggle(AppL l, bool isAr, SpeciesTermsMap terms) {
    final options = [
      ('male', '♂ ${resolveGenderTerm(_selectedSpecies, 'male', isAr, terms, dateOfBirth: _dobCt.text)}'),
      ('female', '♀ ${resolveGenderTerm(_selectedSpecies, 'female', isAr, terms, dateOfBirth: _dobCt.text)}'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.editAnimalGenderLabel,
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          children: options.map((entry) {
            final (value, label) = entry;
            final active = _gender == value;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _gender = value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  margin: const EdgeInsets.only(right: 10),
                  height: 44,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                    border: Border.all(
                      color: active ? AppColors.primary : AppColors.tan,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: AppTypography.bodyMedium.copyWith(
                        color: active ? Colors.white : AppColors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatusSelector(AppL l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.editAnimalStatusLabel,
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w500, fontSize: 13)),
        const SizedBox(height: 8),
        Row(
          children: statusesForSpecies(_selectedSpecies).map((s) {
            final active = _status == s;
            final color = s.color;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _status = s),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  margin: const EdgeInsets.only(right: 8),
                  height: 40,
                  decoration: BoxDecoration(
                    color: active
                        ? color.withValues(alpha: 0.12)
                        : AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                    border: Border.all(
                      color: active ? color : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      s.nameAr,
                      style: AppTypography.bodySmall.copyWith(
                        color: active ? color : AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
