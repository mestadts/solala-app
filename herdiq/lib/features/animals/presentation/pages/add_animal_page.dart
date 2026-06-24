import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/age_class_data.dart';
import '../../../../core/constants/animal_purpose.dart';
import '../../../../core/constants/breed_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/constants/pen_data.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/routing/newborn_extra.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/animal_provider.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/config/species_terms_provider.dart';
import '../../../../core/config/field_labels_provider.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../widgets/herd_breed_picker.dart';
import '../widgets/herd_color_picker.dart';
import '../providers/custom_fields_provider.dart';
import '../providers/country_template_provider.dart';
import '../widgets/custom_fields_widget.dart';


class AddAnimalPage extends ConsumerStatefulWidget {
  /// When provided, the form is pre-filled from this animal (Duplicate flow).
  final MockAnimal? sourceAnimal;
  /// When provided, the dam (mother) is pre-linked (Add Newborn flow).
  final NewbornExtra? newbornExtra;
  const AddAnimalPage({super.key, this.sourceAnimal, this.newbornExtra});

  @override
  ConsumerState<AddAnimalPage> createState() => _AddAnimalPageState();
}

class _AddAnimalPageState extends ConsumerState<AddAnimalPage> {
  // 0=species, 1=basic, 2=breed, 3=color+tag, 4=photo, 5=success
  int _step = 0;

  // Step 0 — species
  LivestockSpecies? _species;

  // Step 1 — basic info
  final _nameCt = TextEditingController();
  final _dobCt  = TextEditingController();
  String _gender = 'male';

  // Step 2 — breed
  String? _breedId;
  String? _customBreed;

  // Step 3 — color + tag
  String? _colorId;
  String _tagColorId = '';
  int _tagNumber = 0;
  final _officialTagCt = TextEditingController();

  // Step 1 extras
  AnimalPurpose? _purpose;
  String? _ageClassId;

  // Parent tracking (optional)
  String? _damId;       // mother UUID
  String? _sireId;      // father UUID
  String  _damDisplay  = '';  // human-readable for display
  String  _sireDisplay = '';

  // Step 3 extras
  String? _penId;
  final _weightCt = TextEditingController();

  // Step 4 — species fields
  final _speciesCtrls = <String, TextEditingController>{};

  // Phase 16 — custom field values
  final Map<String, dynamic> _customValues = {};

  // Step 5 outcome
  String _savedSystemId = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final src = widget.sourceAnimal;
    if (src != null) {
      // Pre-fill all fields from the source animal (duplicate flow).
      // Start at step 1 since species is already set.
      _species   = src.species;
      _step      = 1;
      _gender    = src.gender;
      _breedId   = src.breed.startsWith('custom_') ? null : src.breed;
      _customBreed = src.breed.startsWith('custom_') ? src.breed : null;
      _colorId   = src.colorId;
      _tagNumber = 0; // tag must differ — reset to 0
      _purpose   = src.purpose;
      _ageClassId = src.ageClassId;
      _penId      = src.penId;
      _nameCt.text      = '';          // name should differ
      _dobCt.text       = src.dateOfBirth;
      _weightCt.text    = src.weight > 0 ? src.weight.toString() : '';
    }

    final nb = widget.newbornExtra;
    if (nb != null) {
      // Pre-link the dam and pre-select species (Add Newborn flow).
      _damId      = nb.damId;
      _damDisplay = nb.damDisplay;
      try {
        _species = LivestockSpecies.values.firstWhere((s) => s.name == nb.damSpecies);
        _step = 1; // skip species selection — already known from dam
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _nameCt.dispose();
    _dobCt.dispose();
    _officialTagCt.dispose();
    _weightCt.dispose();
    for (final c in _speciesCtrls.values) { c.dispose(); }
    super.dispose();
  }

  String get _breedLabel {
    if (_customBreed != null && _customBreed!.isNotEmpty) return _customBreed!;
    if (_breedId == null) return 'Not selected';
    try {
      return breedsFor(_species!).firstWhere((b) => b.id == _breedId).nameEn;
    } catch (_) {
      return _breedId!;
    }
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);

    final specAttrs = <String, dynamic>{};
    for (final e in _speciesCtrls.entries) {
      if (e.value.text.trim().isNotEmpty) {
        specAttrs[e.key] = e.value.text.trim();
      }
    }

    final officialTag = _officialTagCt.text.trim();
    final localId = 'a-${DateTime.now().millisecondsSinceEpoch}';

    final animal = MockAnimal(
      id: localId,
      systemAnimalId: '',       // assigned by AnimalActions.createAnimal
      name: _nameCt.text.trim().isEmpty ? _breedLabel : _nameCt.text.trim(),
      species: _species!,
      gender: _gender,
      breed: _breedId ?? _customBreed ?? 'Unknown',
      dateOfBirth: _dobCt.text.trim().isEmpty
          ? DateTime.now().toString().substring(0, 10)
          : _dobCt.text.trim(),
      weight: double.tryParse(_weightCt.text.trim()) ?? 0,
      status: AnimalStatus.active,
      breederTag: '',
      colorId: _colorId ?? 'brown',
      tagColorId: _tagColorId,
      tagNumber: _tagNumber,
      officialTagNumber: officialTag.isNotEmpty ? officialTag : null,
      purpose: _purpose,
      ageClassId: _ageClassId,
      penId: _penId,
      speciesAttributes: specAttrs,
      customValues: Map<String, dynamic>.from(_customValues),
      damId: _damId,
      sireId: _sireId,
    );

    try {
      final systemId = await ref.read(animalActionsProvider).createAnimal(animal);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _savedSystemId = systemId;
        _step = 5;
      });
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

    // Auto-select preferred species (step 0 skip) when exactly one preferred
    if (_step == 0 && widget.sourceAnimal == null) {
      final preferred = ref.read(preferredSpeciesProvider);
      if (preferred.length == 1 && _species == null) {
        final match = LivestockSpecies.values.where(
            (s) => s.name == preferred.first).firstOrNull;
        if (match != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() { _species = match; _step = 1; });
          });
        }
      }
    }

    // Success screen — no back navigation
    if (_step == 5) return _SuccessScreen(systemId: _savedSystemId);

    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step > 0) setState(() => _step--);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(l),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  child: _buildStep(l),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(AppL l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: AppColors.primary),
            onPressed: () {
              if (_step > 0) {
                setState(() => _step--);
              } else {
                context.pop();
              }
            },
          ),
          const Spacer(),
          _StepIndicator(current: _step, total: 5),
        ],
      ),
    );
  }

  Widget _buildStep(AppL l) {
    final fieldLabels = ref.watch(fieldLabelsProvider).valueOrNull ?? FieldLabels.empty;
    switch (_step) {
      case 0:
        return _StepSpecies(
          selected: _species,
          onSelect: (s) => setState(() {
            _species = s;
            _breedId = null;
            _customBreed = null;
            _speciesCtrls.clear();
          }),
          onNext: () {
            if (_species != null) setState(() => _step = 1);
          },
          l: l,
        );
      case 1:
        return _StepBasicInfo(
          nameCt: _nameCt,
          dobCt: _dobCt,
          gender: _gender,
          species: _species!,
          purpose: _purpose,
          ageClassId: _ageClassId,
          damDisplay: _damDisplay,
          sireDisplay: _sireDisplay,
          onGenderChanged: (g) => setState(() => _gender = g),
          onDobChanged: (dob) => setState(() {
            _ageClassId = ageClassFromDob(dob)?.id;
          }),
          onPurposeChanged: (p) => setState(() => _purpose = p),
          onAgeClassChanged: (id) => setState(() {
            _ageClassId = id;
            // Reverse: selecting a chip estimates & fills the DOB field
            if (id != null) {
              final ac = ageClassById(id);
              if (ac != null) _dobCt.text = estimateDobFromAgeClass(ac);
            }
          }),
          onDamSelected: (id, display) => setState(() {
            _damId = id;
            _damDisplay = display;
          }),
          onSireSelected: (id, display) => setState(() {
            _sireId = id;
            _sireDisplay = display;
          }),
          onNext: () => setState(() => _step = 2),
          l: l,
        );
      case 2:
        return _StepBreed(
          species: _species!,
          selectedId: _breedId,
          customBreed: _customBreed,
          fieldLabels: fieldLabels,
          onIdSelected: (id) => setState(() {
            _breedId = id;
            _customBreed = null;
          }),
          onCustomEntered: (text) => setState(() {
            _customBreed = text;
            _breedId = null;
          }),
          onNext: () => setState(() => _step = 3),
          l: l,
        );
      case 3:
        final customFieldDefs = ref.watch(
            customFieldsForSpeciesProvider(_species!.name));
        final countryTemplate =
            ref.watch(countryTemplateProvider).valueOrNull;
        return _StepColorTag(
          colorId: _colorId,
          tagColorId: _tagColorId,
          tagNumber: _tagNumber,
          officialTagCt: _officialTagCt,
          penId: _penId,
          weightCt: _weightCt,
          customFields: customFieldDefs,
          customValues: _customValues,
          countryRequiredFields: countryTemplate?.requiredFields ?? [],
          onCustomValueChanged: (id, v) =>
              setState(() => _customValues[id] = v),
          onColorSelected: (id) => setState(() => _colorId = id),
          onTagColorSelected: (id) => setState(() => _tagColorId = id),
          onTagChanged: (n) => setState(() => _tagNumber = n),
          onPenChanged: (id) => setState(() => _penId = id),
          onNext: () => setState(() => _step = 4),
          l: l,
          species: _species,
          fieldLabels: fieldLabels,
        );
      default:
        return _StepPhoto(
          species: _species!,
          isLoading: _isLoading,
          onSave: _save,
          l: l,
        );
    }
  }
}

// ── Step indicator ─────────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int current;
  final int total;
  const _StepIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: active ? 22 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: i <= current ? AppColors.primary : AppColors.tan,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ── Step 0: Species ────────────────────────────────────────────────────────────

class _StepSpecies extends StatelessWidget {
  final LivestockSpecies? selected;
  final ValueChanged<LivestockSpecies> onSelect;
  final VoidCallback onNext;
  final AppL l;

  const _StepSpecies({
    required this.selected,
    required this.onSelect,
    required this.onNext,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.addAnimalStep0Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.addAnimalStep0Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: AppSpacing.sectionGap),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: LivestockSpecies.values
              .map((s) => _SpeciesCard(
                    species: s,
                    selected: selected == s,
                    onTap: () => onSelect(s),
                  ))
              .toList(),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(
          label: l.btnNext,
          onPressed: selected != null ? onNext : null,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final LivestockSpecies species;
  final bool selected;
  final VoidCallback onTap;

  const _SpeciesCard({
    required this.species,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = species.color;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: selected ? c : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(species.emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(
              isAr ? species.nameAr : species.displayName,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? c : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Step 1: Basic Info ─────────────────────────────────────────────────────────

class _StepBasicInfo extends ConsumerWidget {
  final TextEditingController nameCt;
  final TextEditingController dobCt;
  final String gender;
  final LivestockSpecies species;
  final AnimalPurpose? purpose;
  final String? ageClassId;
  final String damDisplay;
  final String sireDisplay;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String> onDobChanged;
  final ValueChanged<AnimalPurpose?> onPurposeChanged;
  final ValueChanged<String?> onAgeClassChanged;
  final void Function(String id, String display) onDamSelected;
  final void Function(String id, String display) onSireSelected;
  final VoidCallback onNext;
  final AppL l;

  const _StepBasicInfo({
    required this.nameCt,
    required this.dobCt,
    required this.gender,
    required this.species,
    required this.purpose,
    required this.ageClassId,
    required this.damDisplay,
    required this.sireDisplay,
    required this.onGenderChanged,
    required this.onDobChanged,
    required this.onPurposeChanged,
    required this.onAgeClassChanged,
    required this.onDamSelected,
    required this.onSireSelected,
    required this.onNext,
    required this.l,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final terms =
        ref.watch(speciesTermsProvider).valueOrNull ?? defaultSpeciesTerms;
    final allAnimals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Text(species.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 10),
            Text(l.addAnimalStep1Title, style: AppTypography.displayMedium),
          ],
        ),
        const SizedBox(height: 8),
        Text(l.addAnimalStep1Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: AppSpacing.sectionGap),

        HerdTextField(
          label: l.addAnimalNameLabel,
          hint: l.addAnimalNameHint,
          controller: nameCt,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.badge_outlined,
              color: AppColors.textMuted, size: 20),
        ),
        const SizedBox(height: AppSpacing.itemGap),

        // Gender toggle
        _buildGenderToggle(onGenderChanged, gender, l, isAr, terms),
        const SizedBox(height: AppSpacing.itemGap),

        HerdTextField(
          label: l.addAnimalDobLabel,
          hint: l.addAnimalDobHint,
          controller: dobCt,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          onChanged: onDobChanged,
          prefixIcon: const Icon(Icons.cake_outlined,
              color: AppColors.textMuted, size: 20),
        ),
        const SizedBox(height: AppSpacing.itemGap),

        // Age class chips
        _buildAgeClassRow(l, isAr),
        const SizedBox(height: AppSpacing.itemGap),

        // Purpose toggle
        _buildPurposeToggle(l, isAr),
        const SizedBox(height: AppSpacing.itemGap),

        // Parent tracking
        _buildParentPicker(
          context,
          label: isAr ? 'الأم (اختياري)' : 'Mother (optional)',
          icon: Icons.female_rounded,
          display: damDisplay,
          allAnimals: allAnimals,
          isAr: isAr,
          onSelected: onDamSelected,
        ),
        const SizedBox(height: AppSpacing.itemGap),
        _buildParentPicker(
          context,
          label: isAr ? 'الأب (اختياري)' : 'Father (optional)',
          icon: Icons.male_rounded,
          display: sireDisplay,
          allAnimals: allAnimals,
          isAr: isAr,
          onSelected: onSireSelected,
        ),
        const SizedBox(height: AppSpacing.sectionGap),

        HerdPrimaryButton(label: l.btnNext, onPressed: onNext),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildParentPicker(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String display,
    required List<MockAnimal> allAnimals,
    required bool isAr,
    required void Function(String id, String display) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showAnimalSearchSheet(
            context,
            label: label,
            allAnimals: allAnimals,
            isAr: isAr,
            onSelected: onSelected,
          ),
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
                Icon(icon, color: AppColors.textMuted, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    display.isEmpty
                        ? (isAr ? 'اضغط للاختيار...' : 'Tap to select...')
                        : display,
                    style: AppTypography.bodyMedium.copyWith(
                      color: display.isEmpty
                          ? AppColors.textMuted
                          : AppColors.primary,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAnimalSearchSheet(
    BuildContext context, {
    required String label,
    required List<MockAnimal> allAnimals,
    required bool isAr,
    required void Function(String id, String display) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AnimalSearchSheet(
        title: label,
        animals: allAnimals,
        isAr: isAr,
        onSelected: onSelected,
      ),
    );
  }

  Widget _buildAgeClassRow(AppL l, bool isAr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.addAnimalAgeClassLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ageClasses.map((ac) {
              final selected = ageClassId == ac.id;
              return GestureDetector(
                onTap: () => onAgeClassChanged(selected ? null : ac.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? AppColors.primary
                          : AppColors.tan,
                    ),
                    boxShadow: selected
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 4,
                            ),
                          ],
                  ),
                  child: Text(
                    isAr ? ac.nameAr : ac.nameEn,
                    style: AppTypography.bodySmall.copyWith(
                      color: selected ? Colors.white : AppColors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        if (ageClassId == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l.addAnimalAgeClassAuto,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textMuted, fontSize: 11),
            ),
          ),
      ],
    );
  }

  Widget _buildPurposeToggle(AppL l, bool isAr) {
    final options = [
      (AnimalPurpose.breeding, isAr ? AnimalPurpose.breeding.nameAr : AnimalPurpose.breeding.nameEn, Icons.favorite_outline_rounded),
      (AnimalPurpose.fattening, isAr ? AnimalPurpose.fattening.nameAr : AnimalPurpose.fattening.nameEn, Icons.restaurant_rounded),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.addAnimalPurposeLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        Row(
          children: options.map((entry) {
            final (value, label, icon) = entry;
            final active = purpose == value;
            return Expanded(
              child: GestureDetector(
                onTap: () => onPurposeChanged(active ? null : value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  margin: const EdgeInsets.only(right: 10),
                  height: 48,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                    border: Border.all(
                      color: active ? AppColors.primary : AppColors.tan,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon,
                          size: 16,
                          color: active ? Colors.white : AppColors.brown),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: AppTypography.bodyMedium.copyWith(
                          color: active ? Colors.white : AppColors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGenderToggle(ValueChanged<String> onChange, String current,
      AppL l, bool isAr, SpeciesTermsMap terms) {
    final options = [
      ('male', resolveGenderTerm(species, 'male', isAr, terms), '♂'),
      ('female', resolveGenderTerm(species, 'female', isAr, terms), '♀'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l.addAnimalGenderLabel, style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        Row(
          children: options.map((entry) {
            final (value, label, symbol) = entry;
            final active = current == value;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChange(value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  margin: const EdgeInsets.only(right: 10),
                  height: 48,
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
                      '$symbol $label',
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
}

// ── Step 2: Breed ──────────────────────────────────────────────────────────────

class _StepBreed extends StatelessWidget {
  final LivestockSpecies species;
  final String? selectedId;
  final String? customBreed;
  final ValueChanged<String> onIdSelected;
  final ValueChanged<String> onCustomEntered;
  final VoidCallback onNext;
  final AppL l;
  final FieldLabels fieldLabels;

  const _StepBreed({
    required this.species,
    required this.selectedId,
    required this.customBreed,
    required this.onIdSelected,
    required this.onCustomEntered,
    required this.onNext,
    required this.l,
    this.fieldLabels = FieldLabels.empty,
  });

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final hasBreed = selectedId != null ||
        (customBreed != null && customBreed!.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Text(species.emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 10),
            Text(l.addAnimalStep2Title, style: AppTypography.displayMedium),
          ],
        ),
        const SizedBox(height: 8),
        Text(l.addAnimalStep2Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: AppSpacing.sectionGap),

        Text(fieldLabels.breedLabel(isAr) ?? l.addAnimalBreedLabel,
            style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        HerdBreedPicker(
          species: species,
          selectedId: selectedId,
          customBreed: customBreed,
          onIdSelected: onIdSelected,
          onCustomEntered: onCustomEntered,
        ),
        const SizedBox(height: AppSpacing.sectionGap),

        // Species-specific details note
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.tan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline_rounded,
                  color: AppColors.brown, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Builder(builder: (ctx) {
                  final isAr = Localizations.localeOf(ctx).languageCode == 'ar';
                  final name = isAr ? species.nameAr : species.displayName;
                  return Text(
                    isAr
                        ? 'يمكنك إضافة تفاصيل خاصة بـ $name في الخطوات التالية.'
                        : 'You can add more $name-specific details in the next steps.',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.brown),
                  );
                }),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(
          label: l.btnNext,
          onPressed: hasBreed ? onNext : null,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 3: Color + Tag ────────────────────────────────────────────────────────

class _StepColorTag extends StatelessWidget {
  final String? colorId;
  final String tagColorId;
  final int tagNumber;
  final TextEditingController officialTagCt;
  final String? penId;
  final TextEditingController weightCt;
  final List<CustomFieldDef> customFields;
  final Map<String, dynamic> customValues;
  final List<String> countryRequiredFields;
  final void Function(String, dynamic) onCustomValueChanged;
  final ValueChanged<String> onColorSelected;
  final ValueChanged<String> onTagColorSelected;
  final ValueChanged<int> onTagChanged;
  final ValueChanged<String?> onPenChanged;
  final VoidCallback onNext;
  final AppL l;
  final LivestockSpecies? species;
  final FieldLabels fieldLabels;

  const _StepColorTag({
    required this.colorId,
    this.tagColorId = '',
    required this.tagNumber,
    required this.officialTagCt,
    required this.penId,
    required this.weightCt,
    required this.customFields,
    required this.customValues,
    required this.countryRequiredFields,
    required this.onCustomValueChanged,
    required this.onColorSelected,
    required this.onTagColorSelected,
    required this.onTagChanged,
    required this.onPenChanged,
    required this.onNext,
    required this.l,
    this.species,
    this.fieldLabels = FieldLabels.empty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.addAnimalStep3Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.addAnimalStep3Subtitle, style: AppTypography.bodyMedium),

        // Country template required fields notice
        if (countryRequiredFields.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.tan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.tan.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    size: 14, color: AppColors.brown),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.countryTemplateRequired,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.brown, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.sectionGap),

        HerdColorPicker(
          selectedColorId: colorId,
          tagColorId: tagColorId,
          tagNumber: tagNumber,
          species: species,
          onColorSelected: onColorSelected,
          onTagColorSelected: onTagColorSelected,
          onTagChanged: onTagChanged,
        ),

        const SizedBox(height: AppSpacing.sectionGap),

        // Official tag number (optional)
        HerdTextField(
          label: l.animalOfficialTag,
          hint: l.animalOfficialTagHint,
          controller: officialTagCt,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.verified_outlined,
              color: AppColors.textMuted, size: 20),
        ),

        const SizedBox(height: AppSpacing.itemGap),

        // Pen / Group dropdown
        _buildPenDropdown(context, l),

        const SizedBox(height: AppSpacing.itemGap),

        // Weight
        HerdTextField(
          label: l.addAnimalWeightLabel,
          hint: l.addAnimalWeightHint,
          controller: weightCt,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.monitor_weight_outlined,
              color: AppColors.textMuted, size: 20),
        ),

        if (customFields.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sectionGap),
          CustomFieldsForm(
            fields: customFields,
            values: customValues,
            onChanged: onCustomValueChanged,
          ),
        ],

        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(label: l.btnNext, onPressed: onNext),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildPenDropdown(BuildContext context, AppL l) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fieldLabels.penLabel(isAr) ?? l.addAnimalPenLabel,
            style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showPenSheet(context, l, isAr),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            child: Row(
              children: [
                const Icon(Icons.home_work_outlined,
                    color: AppColors.textMuted, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    penId != null
                        ? (mockPens
                                .where((p) => p.id == penId)
                                .firstOrNull
                                ?.name ??
                            penId!)
                        : l.addAnimalPenNone,
                    style: AppTypography.bodyMedium.copyWith(
                      color: penId != null
                          ? AppColors.primary
                          : AppColors.textMuted,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showPenSheet(BuildContext context, AppL l, bool isAr) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fieldLabels.penLabel(isAr) ?? l.addAnimalPenLabel,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              // No pen option
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  penId == null
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  color: penId == null
                      ? AppColors.primary
                      : AppColors.tan,
                  size: 20,
                ),
                title: Text(
                  l.addAnimalPenNone,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                onTap: () {
                  onPenChanged(null);
                  Navigator.pop(sheetCtx);
                },
              ),
              const Divider(height: 1),
              ...mockPens.map((pen) {
                final selected = penId == pen.id;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    selected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    color:
                        selected ? AppColors.primary : AppColors.tan,
                    size: 20,
                  ),
                  title: Text(
                    pen.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  subtitle: pen.description != null
                      ? Text(
                          pen.description!,
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textMuted),
                        )
                      : null,
                  onTap: () {
                    onPenChanged(pen.id);
                    Navigator.pop(sheetCtx);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Step 4: Photo ──────────────────────────────────────────────────────────────

class _StepPhoto extends StatefulWidget {
  final LivestockSpecies species;
  final bool isLoading;
  final VoidCallback onSave;
  final AppL l;

  const _StepPhoto({
    required this.species,
    required this.isLoading,
    required this.onSave,
    required this.l,
  });

  @override
  State<_StepPhoto> createState() => _StepPhotoState();
}

class _StepPhotoState extends State<_StepPhoto> {
  File? _picked;
  final _picker = ImagePicker();

  Future<void> _pickFrom(ImageSource source) async {
    try {
      final xf = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (xf != null && mounted) {
        setState(() => _picked = File(xf.path));
      }
    } catch (_) {
      // permission denied or no camera — silently ignore
    }
  }

  void _showSourceSheet(BuildContext context) {
    final l = widget.l;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.camera_alt_rounded,
                    color: AppColors.primary),
                title: Text(l.addAnimalPhotoCamera,
                    style: AppTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickFrom(ImageSource.camera);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.photo_library_outlined,
                    color: AppColors.primary),
                title: Text(l.addAnimalPhotoGallery,
                    style: AppTypography.bodyMedium
                        .copyWith(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickFrom(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.addAnimalStep4Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.addAnimalStep4Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: AppSpacing.sectionGap),

        // Photo preview / placeholder
        Center(
          child: GestureDetector(
            onTap: () => _showSourceSheet(context),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: widget.species.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                border: Border.all(
                  color: widget.species.color.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: _picked != null
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusLarge),
                      child: Image.file(_picked!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.species.emoji,
                            style: const TextStyle(fontSize: 56)),
                        const SizedBox(height: 12),
                        Text(
                          l.addAnimalPhotoTap,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Camera / Gallery buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () => _pickFrom(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: Text(l.addAnimalPhotoCamera),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => _pickFrom(ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              label: Text(l.addAnimalPhotoGallery),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(
          label: l.addAnimalSaveBtn,
          onPressed: widget.onSave,
          isLoading: widget.isLoading,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Success Screen ─────────────────────────────────────────────────────────────

class _SuccessScreen extends ConsumerWidget {
  final String systemId;
  const _SuccessScreen({required this.systemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding),
          child: Column(
            children: [
              const Spacer(),

              // Success icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.statusActive.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.check_rounded,
                      color: AppColors.statusActive, size: 48),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                l.addAnimalSuccessTitle,
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l.addAnimalSuccessMsg,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textMuted),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // System ID card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                child: Column(
                  children: [
                    Text(
                      l.addAnimalSystemIdLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      systemId,
                      style: AppTypography.displayMedium.copyWith(
                        color: AppColors.onPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: systemId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l.btnCopyId),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded,
                          size: 16, color: AppColors.onPrimary),
                      label: Text(l.btnCopyId,
                          style:
                              const TextStyle(color: AppColors.onPrimary)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.onPrimary
                                .withValues(alpha: 0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMedium),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Info note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline_rounded,
                      color: AppColors.textMuted, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    l.addAnimalIdPermanent,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),

              const Spacer(),

              HerdPrimaryButton(
                label: l.addAnimalBackToList,
                onPressed: () => context.pop(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Animal search sheet (parent picker) ────────────────────────────────────────

class _AnimalSearchSheet extends StatefulWidget {
  final String title;
  final List<MockAnimal> animals;
  final bool isAr;
  final void Function(String id, String display) onSelected;

  const _AnimalSearchSheet({
    required this.title,
    required this.animals,
    required this.isAr,
    required this.onSelected,
  });

  @override
  State<_AnimalSearchSheet> createState() => _AnimalSearchSheetState();
}

class _AnimalSearchSheetState extends State<_AnimalSearchSheet> {
  final _searchCt = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCt.dispose();
    super.dispose();
  }

  List<MockAnimal> get _filtered {
    if (_query.isEmpty) return widget.animals;
    final q = _query.toLowerCase();
    return widget.animals.where((a) {
      return a.name.toLowerCase().contains(q) ||
          a.systemAnimalId.toLowerCase().contains(q) ||
          a.tagNumber.toString().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.92,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.tan,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            // Search field
            TextField(
              controller: _searchCt,
              textDirection: widget.isAr ? TextDirection.rtl : TextDirection.ltr,
              decoration: InputDecoration(
                hintText: widget.isAr
                    ? 'بحث بالاسم أو رقم الوسم...'
                    : 'Search by name or tag...',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppColors.textMuted, size: 20),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 8),
            // Clear selection
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.cancel_outlined,
                  color: AppColors.textMuted, size: 20),
              title: Text(
                widget.isAr ? 'بدون تحديد' : 'None',
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textMuted),
              ),
              onTap: () {
                widget.onSelected('', '');
                Navigator.pop(context);
              },
            ),
            const Divider(height: 1),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        widget.isAr ? 'لا توجد نتائج' : 'No results',
                        style: AppTypography.bodyMedium
                            .copyWith(color: AppColors.textMuted),
                      ),
                    )
                  : ListView.builder(
                      controller: ctrl,
                      itemCount: filtered.length,
                      itemBuilder: (_, i) {
                        final a = filtered[i];
                        final display =
                            '${a.systemAnimalId} • ${a.name}';
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: a.species.color.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(a.species.emoji,
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          title: Text(
                            a.name,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${a.systemAnimalId}  •  وسم ${a.tagNumber}',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textMuted),
                          ),
                          onTap: () {
                            widget.onSelected(a.id, display);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
