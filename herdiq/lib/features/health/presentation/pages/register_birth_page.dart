import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/animal_status.dart';
import '../../../../core/constants/breed_data.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/animal_id_generator.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../../animals/presentation/widgets/herd_breed_picker.dart';
import '../../../breeding/presentation/providers/breeding_provider.dart';

// ── Helpers ────────────────────────────────────────────────────────────────────

String _colorName(String colorId, bool isAr) {
  final c = colorById(colorId);
  return isAr ? (c?.nameAr ?? colorId) : (c?.nameEn ?? colorId);
}

// ── Per-offspring draft ────────────────────────────────────────────────────────

class _OffspringDraft {
  String gender = 'Female';
  String colorId = '';
  String? breedId;
  String? customBreed;
  final tagCt = TextEditingController();
  final nameCt = TextEditingController();

  int get tagNumber => int.tryParse(tagCt.text.trim()) ?? 0;

  void dispose() {
    tagCt.dispose();
    nameCt.dispose();
  }
}

// ── Page ───────────────────────────────────────────────────────────────────────

class RegisterBirthPage extends ConsumerStatefulWidget {
  /// When null the page shows a mother-selection step first.
  final String? damId;
  const RegisterBirthPage({super.key, this.damId});

  @override
  ConsumerState<RegisterBirthPage> createState() => _RegisterBirthPageState();
}

class _RegisterBirthPageState extends ConsumerState<RegisterBirthPage> {
  String? _resolvedDamId;
  bool get _needsMotherSelection => _resolvedDamId == null;

  // Birth details
  final _dateCt = TextEditingController();
  int _total = 1;
  int _dead = 0;
  final _weanFromCt = TextEditingController();
  final _weanToCt = TextEditingController();
  MockAnimal? _sire;
  final _notesCt = TextEditingController();

  // Offspring drafts
  late List<_OffspringDraft> _drafts;
  bool _saving = false;

  int get _liveCount => (_total - _dead).clamp(0, 99);

  void _rebuildDrafts() {
    final needed = _liveCount;
    while (_drafts.length < needed) {
      _drafts.add(_OffspringDraft());
    }
    while (_drafts.length > needed) {
      _drafts.removeLast().dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _resolvedDamId = widget.damId;
    _drafts = [_OffspringDraft()];
    final now = DateTime.now();
    _dateCt.text =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _dateCt.dispose();
    _weanFromCt.dispose();
    _weanToCt.dispose();
    _notesCt.dispose();
    for (final d in _drafts) {
      d.dispose();
    }
    super.dispose();
  }

  Future<void> _save(MockAnimal dam) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final birthDate = _dateCt.text.trim();
      final weanFrom = int.tryParse(_weanFromCt.text.trim());
      final weanTo = int.tryParse(_weanToCt.text.trim());

      final actions = ref.read(animalActionsProvider);
      for (final d in _drafts) {
        final offspringId = AnimalIdGenerator.generateLocal();
        final colorId = d.colorId.isNotEmpty ? d.colorId : dam.colorId;
        final breed = d.breedId ?? d.customBreed ?? dam.breed;
        final newborn = MockAnimal(
          id: offspringId,
          systemAnimalId: AnimalIdGenerator.generateLocal(),
          name: d.nameCt.text.trim(),
          species: dam.species,
          gender: d.gender,
          breed: breed,
          dateOfBirth: birthDate,
          weight: 0,
          status: AnimalStatus.active,
          breederTag: '',
          colorId: colorId,
          tagNumber: d.tagNumber,
          weaningFromDays: weanFrom,
          weaningToDays: weanTo,
          damId: dam.id,
          sireId: _sire?.id,
        );
        await actions.createAnimal(newborn);
      }

      final recordId = AnimalIdGenerator.generateLocal();
      final damDisplay = _damDisplay(dam, true);
      final sireDisplay = _sire != null
          ? '${_sire!.tagNumber} ${_colorName(_sire!.colorId, true)}'
          : null;
      final record = MockBreedingRecord(
        id: recordId,
        animalId: dam.id,
        damId: dam.id,
        damName: damDisplay,
        damSystemId: dam.systemAnimalId,
        sireId: _sire?.id,
        sireName: sireDisplay,
        sireSystemId: _sire?.systemAnimalId,
        deliveryDate: birthDate,
        offspringCount: _total,
        survivingCount: _liveCount,
        notes: _notesCt.text.trim(),
      );
      await ref.read(breedingActionsProvider).addRecord(record);

      if (mounted) {
        final isAr = Localizations.localeOf(context).languageCode == 'ar';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isAr
              ? 'تم تسجيل الولادة وإنشاء ${_liveCount} ملف مولود'
              : 'Birth registered. ${_liveCount} newborn profile(s) created.'),
          backgroundColor: AppColors.primary,
        ));
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String _damDisplay(MockAnimal dam, bool isAr) =>
      '${dam.tagNumber} ${_colorName(dam.colorId, isAr)}';

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    if (_needsMotherSelection) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: Text(
            l.registerBirthTitle,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: _SelectMotherStep(
            onSelected: (a) => setState(() => _resolvedDamId = a.id),
          ),
        ),
      );
    }

    final dam = ref.watch(animalByIdProvider(_resolvedDamId!));
    if (dam == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return _buildForm(context, l, dam);
  }

  Widget _buildForm(BuildContext context, AppL l, MockAnimal dam) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final liveCount = _liveCount;
    final canSave = _dateCt.text.isNotEmpty && _total >= 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l.registerBirthTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 8, AppSpacing.screenPadding, 100),
          children: [
            // ── Mother card ─────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Row(
                children: [
                  Text(dam.species.emoji,
                      style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.registerBirthMotherLabel,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textMuted)),
                        Text(
                          _damDisplay(dam, isAr),
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(dam.systemAnimalId,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                  // Allow changing mother if opened without damId
                  if (widget.damId == null)
                    IconButton(
                      icon: const Icon(Icons.swap_vert_rounded,
                          color: AppColors.textMuted, size: 18),
                      onPressed: () => setState(() => _resolvedDamId = null),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Birth date ──────────────────────────────────────────────────
            Text(l.registerBirthDate,
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: now,
                  firstDate: DateTime(now.year - 5),
                  lastDate: now,
                );
                if (picked != null) {
                  setState(() {
                    _dateCt.text =
                        '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateCt,
                  decoration: InputDecoration(
                    hintText: l.dateHint,
                    prefixIcon: const Icon(Icons.calendar_today_outlined,
                        size: 18, color: AppColors.textMuted),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Total / Dead ────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.registerBirthTotal,
                          style: AppTypography.labelMedium
                              .copyWith(color: AppColors.textMuted)),
                      const SizedBox(height: 6),
                      _CounterRow(
                        value: _total,
                        min: 1,
                        max: 30,
                        onChanged: (v) => setState(() {
                          _total = v;
                          _rebuildDrafts();
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.registerBirthDead,
                          style: AppTypography.labelMedium
                              .copyWith(color: AppColors.textMuted)),
                      const SizedBox(height: 6),
                      _CounterRow(
                        value: _dead,
                        min: 0,
                        max: _total,
                        onChanged: (v) => setState(() {
                          _dead = v;
                          _rebuildDrafts();
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            if (liveCount > 0) ...[
              const SizedBox(height: 8),
              Text(
                isAr
                    ? '← سيتم إنشاء $liveCount ملف مولود'
                    : '← $liveCount newborn profile(s) will be created',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.statusActive),
              ),
            ],
            const SizedBox(height: 20),

            // ── Sire (optional) ─────────────────────────────────────────────
            Text(l.registerBirthSire,
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: () {
                final allAnimals =
                    ref.read(animalsStreamProvider).valueOrNull ?? [];
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: AppColors.background,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.7,
                    minChildSize: 0.4,
                    maxChildSize: 0.9,
                    builder: (_, sc) => _SireSearchSheet(
                      scrollController: sc,
                      animals: allAnimals,
                      isAr: isAr,
                      onSelected: (a) {
                        Navigator.pop(context);
                        setState(() => _sire = a);
                      },
                      onClear: () {
                        Navigator.pop(context);
                        setState(() => _sire = null);
                      },
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _sire != null
                            ? '${_sire!.tagNumber} ${_colorName(_sire!.colorId, isAr)}'
                            : l.registerBirthSireUnknown,
                        style: AppTypography.bodyMedium.copyWith(
                          color: _sire != null
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                    const Icon(Icons.search_rounded,
                        size: 16, color: AppColors.textMuted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Offspring sections ──────────────────────────────────────────
            if (liveCount > 0) ...[
              ...List.generate(liveCount, (i) {
                final draft = _drafts[i];
                return _OffspringCard(
                  key: ValueKey('draft_$i'),
                  index: i,
                  total: liveCount,
                  draft: draft,
                  dam: dam,
                  isAr: isAr,
                  l: l,
                  onChanged: () => setState(() {}),
                );
              }),
            ],

            // ── Weaning (optional, collapsed in a disclosure) ───────────────
            const SizedBox(height: 8),
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  isAr ? 'الفطام (اختياري)' : 'Weaning (optional)',
                  style: AppTypography.labelMedium
                      .copyWith(color: AppColors.textMuted),
                ),
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _weanFromCt,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: l.registerBirthWeanFrom,
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _weanToCt,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            hintText: l.registerBirthWeanTo,
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
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // ── Notes ────────────────────────────────────────────────────────
            const SizedBox(height: 8),
            Text(l.breedingWizardNotes,
                style: AppTypography.labelMedium
                    .copyWith(color: AppColors.textMuted)),
            const SizedBox(height: 6),
            TextField(
              controller: _notesCt,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l.breedingWizardNotesHint,
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 32),

            HerdPrimaryButton(
              label: canSave ? l.registerBirthSave : l.registerBirthDate,
              isLoading: _saving,
              onPressed: canSave ? () => _save(dam) : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Offspring card (inline, single page) ──────────────────────────────────────

class _OffspringCard extends StatefulWidget {
  final int index;
  final int total;
  final _OffspringDraft draft;
  final MockAnimal dam;
  final bool isAr;
  final AppL l;
  final VoidCallback onChanged;

  const _OffspringCard({
    super.key,
    required this.index,
    required this.total,
    required this.draft,
    required this.dam,
    required this.isAr,
    required this.l,
    required this.onChanged,
  });

  @override
  State<_OffspringCard> createState() => _OffspringCardState();
}

class _OffspringCardState extends State<_OffspringCard> {
  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final isAr = widget.isAr;
    final colors = colorsForSpecies(widget.dam.species);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: AppColors.tan.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text('🐣', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                isAr
                    ? 'المولود ${widget.index + 1} / ${widget.total}'
                    : 'Newborn ${widget.index + 1} / ${widget.total}',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  widget.total,
                  (i) => Container(
                    width: 7,
                    height: 7,
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: i <= widget.index
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Gender
          Text(widget.l.registerBirthOffspringGender,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _GenderChip(
                  label: isAr ? 'ذكر' : 'Male',
                  icon: '♂',
                  selected: draft.gender == 'Male',
                  onTap: () => setState(() {
                    draft.gender = 'Male';
                    widget.onChanged();
                  }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _GenderChip(
                  label: isAr ? 'أنثى' : 'Female',
                  icon: '♀',
                  selected: draft.gender == 'Female',
                  onTap: () => setState(() {
                    draft.gender = 'Female';
                    widget.onChanged();
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Breed
          Text(
            isAr ? 'السلالة' : 'Breed',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          HerdBreedPicker(
            species: widget.dam.species,
            selectedId: draft.breedId,
            customBreed: draft.customBreed,
            onIdSelected: (id) => setState(() {
              draft.breedId = id;
              draft.customBreed = null;
              widget.onChanged();
            }),
            onCustomEntered: (text) => setState(() {
              draft.customBreed = text;
              draft.breedId = null;
              widget.onChanged();
            }),
          ),
          const SizedBox(height: 14),

          // Color
          Text(widget.l.registerBirthOffspringColor,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: colors.map((c) {
              final sel = draft.colorId == c.id;
              return GestureDetector(
                onTap: () => setState(() {
                  draft.colorId = c.id;
                  widget.onChanged();
                }),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 140),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: c.swatch,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: sel ? AppColors.primary : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: sel
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 17)
                          : null,
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: 44,
                      child: Text(
                        isAr ? c.nameAr : c.nameEn,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 9,
                          color: sel ? AppColors.primary : AppColors.textMuted,
                          fontWeight:
                              sel ? FontWeight.w700 : FontWeight.w400,
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
          const SizedBox(height: 14),

          // Tag number / new ID
          Text(widget.l.registerBirthOffspringTagNumber,
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          TextField(
            controller: draft.tagCt,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (_) => widget.onChanged(),
            decoration: InputDecoration(
              hintText: '0',
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMedium),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
          const SizedBox(height: 14),

          // Name (optional)
          Text(
            isAr ? 'الاسم (اختياري)' : 'Name (optional)',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textMuted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: draft.nameCt,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: isAr ? 'اسم المولود' : 'Newborn name',
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Select mother step ─────────────────────────────────────────────────────────

class _SelectMotherStep extends ConsumerStatefulWidget {
  final void Function(MockAnimal) onSelected;
  const _SelectMotherStep({required this.onSelected});

  @override
  ConsumerState<_SelectMotherStep> createState() => _SelectMotherStepState();
}

class _SelectMotherStepState extends ConsumerState<_SelectMotherStep> {
  final _searchCt = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final allAnimals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
    final females = allAnimals.where((a) => a.gender == 'Female').toList();
    final filtered = females.where((a) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return a.tagNumber.toString().startsWith(q) ||
          _colorName(a.colorId, isAr).toLowerCase().contains(q) ||
          a.systemAnimalId.toLowerCase().startsWith(q);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 8, AppSpacing.screenPadding, 0),
          child: Text(l.registerBirthSelectMother,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              )),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 12, AppSpacing.screenPadding, 0),
          child: TextField(
            controller: _searchCt,
            decoration: InputDecoration(
              hintText: l.animalsSearch,
              prefixIcon: const Icon(Icons.search_rounded,
                  color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMedium),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Text(l.animalsEmpty,
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding, 0,
                      AppSpacing.screenPadding, 20),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final a = filtered[i];
                    final display =
                        '${a.tagNumber} ${_colorName(a.colorId, isAr)}';
                    return GestureDetector(
                      onTap: () => widget.onSelected(a),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: a.species.color
                                    .withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(a.species.emoji,
                                    style:
                                        const TextStyle(fontSize: 18)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(display,
                                      style:
                                          AppTypography.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      )),
                                  Text(a.systemAnimalId,
                                      style: AppTypography.bodySmall
                                          .copyWith(
                                              color: AppColors.textMuted)),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right_rounded,
                                color: AppColors.textMuted, size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ── Counter row ────────────────────────────────────────────────────────────────

class _CounterRow extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final void Function(int) onChanged;

  const _CounterRow({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove_rounded),
            color: AppColors.primary,
            onPressed: value > min ? () => onChanged(value - 1) : null,
          ),
          Expanded(
            child: Center(
              child: Text(
                '$value',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            color: AppColors.primary,
            onPressed: value < max ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

// ── Gender chip ────────────────────────────────────────────────────────────────

class _GenderChip extends StatelessWidget {
  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? AppColors.primary : AppColors.textMuted,
                )),
            const SizedBox(width: 6),
            Text(label,
                style: AppTypography.bodyMedium.copyWith(
                  color: selected ? AppColors.primary : AppColors.textMuted,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }
}

// ── Sire search sheet ──────────────────────────────────────────────────────────

class _SireSearchSheet extends StatefulWidget {
  final ScrollController scrollController;
  final List<MockAnimal> animals;
  final bool isAr;
  final void Function(MockAnimal) onSelected;
  final VoidCallback onClear;

  const _SireSearchSheet({
    required this.scrollController,
    required this.animals,
    required this.isAr,
    required this.onSelected,
    required this.onClear,
  });

  @override
  State<_SireSearchSheet> createState() => _SireSearchSheetState();
}

class _SireSearchSheetState extends State<_SireSearchSheet> {
  final _searchCt = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.animals.where((a) {
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      return a.tagNumber.toString().startsWith(q) ||
          _colorName(a.colorId, widget.isAr).toLowerCase().contains(q) ||
          a.name.toLowerCase().contains(q) ||
          a.systemAnimalId.toLowerCase().startsWith(q);
    }).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.isAr ? 'الأب (اختياري)' : 'Father (optional)',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onClear,
                child: Text(
                  widget.isAr ? 'غير معروف' : 'Unknown',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.brown),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _searchCt,
            decoration: InputDecoration(
              hintText: widget.isAr ? 'بحث…' : 'Search…',
              prefixIcon: const Icon(Icons.search_rounded,
                  color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMedium),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final a = filtered[i];
                final colorName = _colorName(a.colorId, widget.isAr);
                final display = '${a.tagNumber} $colorName';
                return ListTile(
                  leading: Text(a.species.emoji,
                      style: const TextStyle(fontSize: 20)),
                  title: Text(display,
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.primary)),
                  subtitle: Text(a.systemAnimalId,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textMuted)),
                  onTap: () => widget.onSelected(a),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
