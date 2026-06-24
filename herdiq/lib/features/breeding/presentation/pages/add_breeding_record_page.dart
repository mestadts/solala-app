import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../providers/breeding_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

/// 5-step guided breeding/reproduction wizard.
/// Steps: 1=Confirm dam → 2=Select sire → 3=Mating+expected date →
///        4=Birth outcome → 5=Review + confirm
class AddBreedingRecordPage extends ConsumerStatefulWidget {
  final String animalId;
  const AddBreedingRecordPage({super.key, required this.animalId});

  @override
  ConsumerState<AddBreedingRecordPage> createState() =>
      _AddBreedingRecordPageState();
}

// Gestation months by species
const Map<LivestockSpecies, int> _gestationMonths = {
  LivestockSpecies.sheep: 5,
  LivestockSpecies.goat:  5,
  LivestockSpecies.cow:   9,
  LivestockSpecies.camel: 13,
  LivestockSpecies.horse: 11,
};

class _AddBreedingRecordPageState
    extends ConsumerState<AddBreedingRecordPage> {
  int _step = 0; // 0..4

  // Step 1 — Sire selection
  String? _sireAnimalId;
  bool _sireUnknown = false;
  final _sireNameCt = TextEditingController();

  // Step 2 — Dates
  final _matingDateCt   = TextEditingController(
      text: DateTime.now().toIso8601String().substring(0, 10));
  final _expectedDateCt = TextEditingController();

  // Step 3 — Birth outcome
  int _offspringCount  = 1;
  int _survivingCount  = 1;
  int _maleCount       = 0;
  int _femaleCount     = 1;
  final _notesCt = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _recalcExpected(_matingDateCt.text);
  }

  @override
  void dispose() {
    _sireNameCt.dispose();
    _matingDateCt.dispose();
    _expectedDateCt.dispose();
    _notesCt.dispose();
    super.dispose();
  }

  void _recalcExpected(String matingVal) {
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    MockAnimal? dam;
    try {
      dam = animals.firstWhere((a) => a.id == widget.animalId);
    } catch (_) {}
    final months = dam != null ? (_gestationMonths[dam.species] ?? 5) : 5;
    try {
      final d = DateTime.parse(matingVal);
      final expected = DateTime(d.year, d.month + months, d.day);
      setState(() {
        _expectedDateCt.text = expected.toString().substring(0, 10);
      });
    } catch (_) {}
  }

  Future<void> _save() async {
    setState(() => _isLoading = true);
    final animals = ref.read(animalsStreamProvider).valueOrNull ?? [];
    MockAnimal? sireAnimal;
    if (_sireAnimalId != null) {
      try {
        sireAnimal = animals.firstWhere((a) => a.id == _sireAnimalId);
      } catch (_) {}
    }

    final record = MockBreedingRecord(
      id: 'b-${DateTime.now().millisecondsSinceEpoch}',
      animalId: widget.animalId,
      damId: widget.animalId,
      damName: null,
      damSystemId: null,
      sireId: sireAnimal?.id,
      sireName: _sireUnknown
          ? 'Unknown'
          : (sireAnimal?.name ?? _sireNameCt.text.trim()),
      sireSystemId: sireAnimal?.systemAnimalId,
      deliveryDate: _expectedDateCt.text.trim().isEmpty
          ? _matingDateCt.text.trim()
          : _expectedDateCt.text.trim(),
      offspringCount: _offspringCount,
      survivingCount: _survivingCount,
      notes: _notesCt.text.trim(),
    );

    await ref.read(breedingActionsProvider).addRecord(record);
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
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
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  child: _buildStep(l, isAr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
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
          _WizardStepIndicator(current: _step, total: 5),
        ],
      ),
    );
  }

  Widget _buildStep(AppL l, bool isAr) {
    final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
    MockAnimal? dam;
    try {
      dam = animals.firstWhere((a) => a.id == widget.animalId);
    } catch (_) {}

    switch (_step) {
      case 0:
        return _buildConfirmDam(dam, l, isAr);
      case 1:
        final males = animals.where((a) => a.gender == 'Male').toList();
        return _buildSelectSire(males, l);
      case 2:
        return _buildDates(l);
      case 3:
        return _buildBirthOutcome(l);
      default:
        return _buildReview(dam, l);
    }
  }

  // ── Step 0 ─────────────────────────────────────────────────────────────────
  Widget _buildConfirmDam(MockAnimal? dam, AppL l, bool isAr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.stepLabel(_step + 1, 5), style: _stepLabelStyle),
        Text(l.breedingWizardStep0Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.breedingWizardStep0Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 32),

        if (dam != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Text(dam.species.emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dam.name.isEmpty ? l.breedingWizardUnnamed : dam.name,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        dam.systemAnimalId,
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.brown),
                      ),
                      Text(
                        isAr
                            ? '${dam.species.nameAr} · ♀ ${l.breedingWizardFemale}'
                            : '${dam.species.displayName} · ♀ Female',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.statusActive, size: 24),
              ],
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Text(l.breedingWizardUnnamed,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textMuted)),
          ),

        const SizedBox(height: 32),
        HerdPrimaryButton(
          label: l.breedingWizardStep0ConfirmBtn,
          onPressed: () => setState(() => _step = 1),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 1 ─────────────────────────────────────────────────────────────────
  Widget _buildSelectSire(List<MockAnimal> males, AppL l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.stepLabel(_step + 1, 5), style: _stepLabelStyle),
        Text(l.breedingWizardStep1Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.breedingWizardStep1Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 32),

        // Unknown toggle
        GestureDetector(
          onTap: () => setState(() {
            _sireUnknown = !_sireUnknown;
            if (_sireUnknown) _sireAnimalId = null;
          }),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _sireUnknown
                  ? AppColors.tan.withValues(alpha: 0.2)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(
                color: _sireUnknown ? AppColors.tan : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _sireUnknown
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: _sireUnknown ? AppColors.brown : AppColors.textMuted,
                ),
                const SizedBox(width: 12),
                Text(l.breedingWizardSireUnknown,
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.brown)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        if (!_sireUnknown) ...[
          Text(l.breedingWizardSelectMale, style: AppTypography.labelMedium),
          const SizedBox(height: 8),
          Container(
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
              value: _sireAnimalId,
              hint: Text(l.breedingWizardSelectMaleHint,
                  style: AppTypography.bodyMedium
                      .copyWith(color: AppColors.textMuted)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              dropdownColor: AppColors.surface,
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.primary),
              items: males
                  .map((a) => DropdownMenuItem(
                        value: a.id,
                        child: Text(
                            '${a.species.emoji} ${a.name.isEmpty ? a.systemAnimalId : a.name}'),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _sireAnimalId = v),
            ),
          ),
          const SizedBox(height: 12),
          Text(l.breedingWizardOrManual, style: AppTypography.labelMedium),
          const SizedBox(height: 8),
          HerdTextField(
            label: '',
            hint: l.breedingWizardSireHint,
            controller: _sireNameCt,
            textInputAction: TextInputAction.done,
          ),
        ],

        const SizedBox(height: 32),
        HerdPrimaryButton(
          label: l.btnNext,
          onPressed: () => setState(() => _step = 2),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 2 ─────────────────────────────────────────────────────────────────
  Widget _buildDates(AppL l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.stepLabel(_step + 1, 5), style: _stepLabelStyle),
        Text(l.breedingWizardStep2Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.breedingWizardStep2Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 32),

        HerdTextField(
          label: l.breedingWizardMatingDate,
          hint: l.dateHint,
          controller: _matingDateCt,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.favorite_border_rounded,
              color: AppColors.textMuted, size: 20),
          onChanged: _recalcExpected,
        ),
        const SizedBox(height: AppSpacing.itemGap),

        HerdTextField(
          label: l.breedingWizardExpectedDelivery,
          hint: l.dateHint,
          controller: _expectedDateCt,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.child_friendly_rounded,
              color: AppColors.textMuted, size: 20),
        ),

        const SizedBox(height: 32),
        HerdPrimaryButton(
          label: l.btnNext,
          onPressed: () => setState(() => _step = 3),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 3 ─────────────────────────────────────────────────────────────────
  Widget _buildBirthOutcome(AppL l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.stepLabel(_step + 1, 5), style: _stepLabelStyle),
        Text(l.breedingWizardStep3Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.breedingWizardStep3Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 32),

        _CounterRow(
          label: l.breedingWizardTotalOffspring,
          value: _offspringCount,
          min: 1,
          max: 20,
          onChanged: (v) => setState(() => _offspringCount = v),
        ),
        const SizedBox(height: 16),
        _CounterRow(
          label: l.breedingWizardSurviving,
          value: _survivingCount,
          min: 0,
          max: _offspringCount,
          onChanged: (v) => setState(() => _survivingCount = v),
        ),
        const SizedBox(height: 16),
        _CounterRow(
          label: l.breedingWizardMalesBorn,
          value: _maleCount,
          min: 0,
          max: _offspringCount,
          onChanged: (v) => setState(() {
            _maleCount = v;
            _femaleCount = _offspringCount - v;
          }),
        ),
        const SizedBox(height: 16),
        _CounterRow(
          label: l.breedingWizardFemalesBorn,
          value: _femaleCount,
          min: 0,
          max: _offspringCount,
          onChanged: (v) => setState(() {
            _femaleCount = v;
            _maleCount = _offspringCount - v;
          }),
        ),
        const SizedBox(height: AppSpacing.itemGap),

        HerdTextField(
          label: l.breedingWizardNotes,
          hint: l.breedingWizardNotesHint,
          controller: _notesCt,
          textInputAction: TextInputAction.done,
          prefixIcon: const Icon(Icons.notes_rounded,
              color: AppColors.textMuted, size: 20),
        ),

        const SizedBox(height: 32),
        HerdPrimaryButton(
          label: l.breedingWizardStep4Title,
          onPressed: () => setState(() => _step = 4),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  // ── Step 4: Review ─────────────────────────────────────────────────────────
  Widget _buildReview(MockAnimal? dam, AppL l) {
    final sireLabel = _sireUnknown
        ? l.breedingUnknown
        : (_sireAnimalId != null
            ? (ref.read(animalsStreamProvider).valueOrNull ?? [])
                .firstWhere((a) => a.id == _sireAnimalId,
                    orElse: () => (ref.read(animalsStreamProvider).valueOrNull ?? []).first)
                .name
            : _sireNameCt.text.trim().isEmpty
                ? '—'
                : _sireNameCt.text.trim());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(l.stepLabel(_step + 1, 5), style: _stepLabelStyle),
        Text(l.breedingWizardStep4Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(l.breedingWizardStep4Subtitle, style: AppTypography.bodyMedium),
        const SizedBox(height: 24),

        _ReviewRow(l.breedingWizardMother,
            dam?.name.isEmpty ?? true ? dam?.systemAnimalId ?? '—' : dam!.name),
        _ReviewRow(l.breedingWizardFather, sireLabel),
        _ReviewRow(l.breedingWizardMatingDate, _matingDateCt.text),
        _ReviewRow(l.breedingWizardExpectedDelivery, _expectedDateCt.text),
        _ReviewRow(l.breedingWizardTotalOffspring, '$_offspringCount'),
        _ReviewRow(l.breedingWizardSurviving, '$_survivingCount'),
        _ReviewRow(l.breedingWizardGenderSplit, '$_maleCount ♂  ·  $_femaleCount ♀'),
        if (_notesCt.text.trim().isNotEmpty)
          _ReviewRow(l.breedingWizardNotes, _notesCt.text.trim()),

        const SizedBox(height: 32),
        HerdPrimaryButton(
          label: l.breedingWizardSaveBtn,
          onPressed: _save,
          isLoading: _isLoading,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  TextStyle get _stepLabelStyle => AppTypography.bodySmall.copyWith(
        color: AppColors.textMuted,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );
}

// ── Wizard step indicator ──────────────────────────────────────────────────────

class _WizardStepIndicator extends StatelessWidget {
  final int current;
  final int total;
  const _WizardStepIndicator({required this.current, required this.total});

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

// ── Counter row ────────────────────────────────────────────────────────────────

class _CounterRow extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _CounterRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(label,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: value > min ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove_rounded, size: 18),
                color: AppColors.primary,
                disabledColor: AppColors.textMuted,
                visualDensity: VisualDensity.compact,
              ),
              SizedBox(
                width: 32,
                child: Text(
                  '$value',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: value < max ? () => onChanged(value + 1) : null,
                icon: const Icon(Icons.add_rounded, size: 18),
                color: AppColors.primary,
                disabledColor: AppColors.textMuted,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Review row ────────────────────────────────────────────────────────────────

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  const _ReviewRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted)),
          ),
          Text(value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
