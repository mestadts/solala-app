import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/age_class_data.dart';
import '../../../../core/constants/animal_purpose.dart';
import '../../../../core/constants/animal_status.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/constants/udhiya_rules.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/routing/animal_filter_extra.dart';
import '../providers/animal_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/animal_card.dart';

enum _SortOption { none, ageAsc, ageDesc, weightDesc, weightAsc }

extension _SortOptionLabel on _SortOption {
  String label(bool isAr) => switch (this) {
    _SortOption.none      => isAr ? 'الافتراضي'      : 'Default',
    _SortOption.ageAsc    => isAr ? 'الأصغر أولاً'   : 'Youngest first',
    _SortOption.ageDesc   => isAr ? 'الأكبر أولاً'   : 'Oldest first',
    _SortOption.weightDesc=> isAr ? 'الأثقل أولاً'   : 'Heaviest first',
    _SortOption.weightAsc => isAr ? 'الأخف أولاً'    : 'Lightest first',
  };
}

class AnimalsListPage extends ConsumerStatefulWidget {
  const AnimalsListPage({super.key});

  @override
  ConsumerState<AnimalsListPage> createState() => _AnimalsListPageState();
}

class _AnimalsListPageState extends ConsumerState<AnimalsListPage> {
  final _searchCt = TextEditingController();
  LivestockSpecies? _selectedSpecies;
  String _query = '';

  // Filters
  String? _filterGender;      // 'Male' | 'Female'
  String? _filterStatus;      // AnimalStatus.name e.g. 'active'
  String? _filterAgeClassId;  // 'bahm' | 'jadh' | ...
  AnimalPurpose? _filterPurpose;
  bool _filterUdhiyaOnly = false;
  _SortOption _sortOption = _SortOption.none;

  AnimalFilterExtra? _lastAppliedExtra;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra as AnimalFilterExtra?;
    if (extra != null && !identical(extra, _lastAppliedExtra)) {
      _lastAppliedExtra = extra;
      _filterGender = extra.gender;
      _filterStatus = extra.status;
      _filterAgeClassId = extra.ageClassId;
      _filterPurpose = extra.purpose;
      _filterUdhiyaOnly = extra.udhiyaOnly;
      _selectedSpecies = null;
      _query = '';
      _searchCt.clear();
    }
  }

  @override
  void dispose() {
    _searchCt.dispose();
    super.dispose();
  }

  bool get _hasActiveFilter =>
      _filterGender != null ||
      _filterStatus != null ||
      _filterAgeClassId != null ||
      _filterPurpose != null ||
      _filterUdhiyaOnly ||
      _sortOption != _SortOption.none;

  int get _activeFilterCount =>
      (_filterGender != null ? 1 : 0) +
      (_filterAgeClassId != null ? 1 : 0) +
      (_filterStatus != null ? 1 : 0) +
      (_filterPurpose != null ? 1 : 0) +
      (_filterUdhiyaOnly ? 1 : 0) +
      (_sortOption != _SortOption.none ? 1 : 0);

  List<MockAnimal> _apply(List<MockAnimal> all, List<String> preferredSpecies) {
    return all
        .where((a) =>
            preferredSpecies.isEmpty ||
            preferredSpecies.contains(a.species.name))
        .where((a) =>
            _selectedSpecies == null || a.species == _selectedSpecies)
        .where((a) =>
            _filterGender == null || a.gender == _filterGender)
        .where((a) =>
            _filterStatus == null || a.status.name == _filterStatus)
        .where((a) =>
            _filterAgeClassId == null || a.ageClassId == _filterAgeClassId)
        .where((a) =>
            _filterPurpose == null || a.purpose == _filterPurpose)
        .where((a) {
          if (!_filterUdhiyaOnly) return true;
          return isUdhiyaEligible(
            species: a.species,
            dateOfBirth: a.dateOfBirth,
            status: a.status,
          );
        })
        .where((a) =>
            _query.isEmpty ||
            a.name.toLowerCase().contains(_query.toLowerCase()) ||
            a.tagNumber.toString().startsWith(_query) ||
            a.systemAnimalId.toLowerCase().startsWith(_query.toLowerCase()) ||
            a.breederTag.toLowerCase().startsWith(_query.toLowerCase()))
        .toList()
      ..sort(_comparator);
  }

  int _comparator(MockAnimal a, MockAnimal b) {
    switch (_sortOption) {
      case _SortOption.ageAsc:
        return b.dateOfBirth.compareTo(a.dateOfBirth); // newest DOB = youngest
      case _SortOption.ageDesc:
        return a.dateOfBirth.compareTo(b.dateOfBirth); // oldest DOB = eldest
      case _SortOption.weightDesc:
        return b.weight.compareTo(a.weight);
      case _SortOption.weightAsc:
        return a.weight.compareTo(b.weight);
      case _SortOption.none:
        return 0;
    }
  }

  void _showBulkEditSheet(BuildContext context, List<MockAnimal> allAnimals) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BulkEditSheet(
        isAr: isAr,
        animals: allAnimals,
        onApply: (fromSpecies, toSpecies) async {
          final matching = allAnimals.where((a) => a.species == fromSpecies).toList();
          if (matching.isEmpty) return;
          final actions = ref.read(animalActionsProvider);
          for (final a in matching) {
            await actions.updateAnimal(MockAnimal(
              id: a.id,
              systemAnimalId: a.systemAnimalId,
              name: a.name,
              species: toSpecies,
              gender: a.gender,
              breed: a.breed,
              dateOfBirth: a.dateOfBirth,
              weight: a.weight,
              status: a.status,
              breederTag: a.breederTag,
              photoUrl: a.photoUrl,
              colorId: a.colorId,
              tagNumber: a.tagNumber,
              tagColorId: a.tagColorId,
              penId: a.penId,
              weaningFromDays: a.weaningFromDays,
              weaningToDays: a.weaningToDays,
              damId: a.damId,
              sireId: a.sireId,
              speciesAttributes: a.speciesAttributes,
              customValues: a.customValues,
            ));
          }
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(isAr
                  ? 'تم تحديث ${matching.length} حيوان'
                  : '${matching.length} animals updated'),
              backgroundColor: AppColors.primary,
            ));
          }
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterSheet(
        isAr: isAr,
        currentGender: _filterGender,
        currentAgeClassId: _filterAgeClassId,
        currentStatus: _filterStatus,
        currentPurpose: _filterPurpose,
        currentSort: _sortOption,
        onApply: (gender, ageClassId, status, purpose, sort) {
          setState(() {
            _filterGender = gender;
            _filterAgeClassId = ageClassId;
            _filterStatus = status;
            _filterPurpose = purpose;
            _sortOption = sort;
            _lastAppliedExtra = null;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
    final preferredSpecies = ref.watch(preferredSpeciesProvider);
    final filtered = _apply(animals, preferredSpecies);

    final visibleSpecies = preferredSpecies.isEmpty
        ? LivestockSpecies.values.toList()
        : LivestockSpecies.values
            .where((s) => preferredSpecies.contains(s.name))
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding, 16,
                AppSpacing.screenPadding, 0,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.animalsTitle, style: AppTypography.displayMedium),
                      Text(
                        l.animalsTotal(filtered.length),
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, color: AppColors.textMuted, size: 22),
                    onSelected: (v) {
                      if (v == 'bulk') _showBulkEditSheet(context, animals);
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'bulk',
                        child: Row(children: [
                          const Icon(Icons.swap_horiz_rounded, size: 18, color: AppColors.brown),
                          const SizedBox(width: 10),
                          Text(isAr ? 'تعديل جماعي للنوع' : 'Bulk species edit',
                              style: AppTypography.bodyMedium.copyWith(color: AppColors.brown)),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => context.push(Routes.addAnimal),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            l.animalsAdd,
                            style: AppTypography.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Search bar ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMedium),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchCt,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: l.animalsSearch,
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppColors.textMuted, size: 20),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: AppColors.textMuted, size: 18),
                            onPressed: () {
                              _searchCt.clear();
                              setState(() => _query = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ── Filter bar: button + active chips ──────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Row(
                children: [
                  // Filter button
                  GestureDetector(
                    onTap: () => _showFilterSheet(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: _activeFilterCount > 0
                            ? AppColors.primary.withValues(alpha: 0.1)
                            : AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusCircle),
                        border: Border.all(
                          color: _activeFilterCount > 0
                              ? AppColors.primary
                              : AppColors.tan.withValues(alpha: 0.5),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.tune_rounded,
                              size: 16,
                              color: _activeFilterCount > 0
                                  ? AppColors.primary
                                  : AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            isAr ? 'فلتر' : 'Filter',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _activeFilterCount > 0
                                  ? AppColors.primary
                                  : AppColors.textMuted,
                            ),
                          ),
                          if (_activeFilterCount > 0) ...[
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$_activeFilterCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Scrollable active filter chips
                  Expanded(
                    child: _activeFilterCount > 0
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (_filterGender != null)
                                  _ActiveChip(
                                    label: _filterGender == 'Male'
                                        ? (isAr ? 'ذكور' : 'Males')
                                        : (isAr ? 'إناث' : 'Females'),
                                    onRemove: () =>
                                        setState(() => _filterGender = null),
                                  ),
                                if (_filterAgeClassId != null)
                                  _ActiveChip(
                                    label: isAr
                                        ? (ageClassById(_filterAgeClassId!)
                                                ?.nameAr ??
                                            _filterAgeClassId!)
                                        : (ageClassById(_filterAgeClassId!)
                                                ?.nameEn ??
                                            _filterAgeClassId!),
                                    onRemove: () => setState(
                                        () => _filterAgeClassId = null),
                                  ),
                                if (_filterStatus != null)
                                  _ActiveChip(
                                    label: () {
                                      try {
                                        final st =
                                            AnimalStatus.values.firstWhere(
                                                (s) => s.name == _filterStatus);
                                        return isAr ? st.nameAr : st.nameEn;
                                      } catch (_) {
                                        return _filterStatus!;
                                      }
                                    }(),
                                    onRemove: () =>
                                        setState(() => _filterStatus = null),
                                  ),
                                if (_filterPurpose != null)
                                  _ActiveChip(
                                    label: isAr
                                        ? _filterPurpose!.nameAr
                                        : _filterPurpose!.nameEn,
                                    onRemove: () =>
                                        setState(() => _filterPurpose = null),
                                  ),
                                if (_filterUdhiyaOnly)
                                  _ActiveChip(
                                    label: isAr ? 'الأضحية' : 'Udhiya',
                                    onRemove: () => setState(
                                        () => _filterUdhiyaOnly = false),
                                  ),
                                if (_sortOption != _SortOption.none)
                                  _ActiveChip(
                                    label: _sortOption.label(isAr),
                                    onRemove: () => setState(
                                        () => _sortOption = _SortOption.none),
                                  ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ── Species filter chips (hidden when only 1 species) ──────────
            if (visibleSpecies.length > 1) ...[
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  children: [
                    _SpeciesChip(
                      label: l.animalsFilterAll,
                      emoji: '🐾',
                      selected: _selectedSpecies == null,
                      onTap: () => setState(() => _selectedSpecies = null),
                    ),
                    ...visibleSpecies.map(
                      (s) => _SpeciesChip(
                        label: isAr ? s.nameAr : s.displayName,
                        emoji: s.emoji,
                        color: s.color,
                        selected: _selectedSpecies == s,
                        onTap: () => setState(() => _selectedSpecies = s),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ] else
              const SizedBox(height: 2),

            // ── Animal list ────────────────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? _EmptyState(
                      hasSearch: _query.isNotEmpty ||
                          _selectedSpecies != null ||
                          _hasActiveFilter)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.screenPadding, 0,
                        AppSpacing.screenPadding, 100,
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) =>
                          AnimalCard(animal: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filter bottom sheet ─────────────────────────────────────────────────────

class _FilterSheet extends StatefulWidget {
  final bool isAr;
  final String? currentGender;
  final String? currentAgeClassId;
  final String? currentStatus;
  final AnimalPurpose? currentPurpose;
  final _SortOption currentSort;
  final void Function(
    String? gender,
    String? ageClassId,
    String? status,
    AnimalPurpose? purpose,
    _SortOption sort,
  ) onApply;

  const _FilterSheet({
    required this.isAr,
    required this.currentGender,
    required this.currentAgeClassId,
    required this.currentStatus,
    required this.currentPurpose,
    required this.currentSort,
    required this.onApply,
  });

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late String? _gender;
  late String? _ageClassId;
  late String? _status;
  late AnimalPurpose? _purpose;
  late _SortOption _sort;

  @override
  void initState() {
    super.initState();
    _gender = widget.currentGender;
    _ageClassId = widget.currentAgeClassId;
    _status = widget.currentStatus;
    _purpose = widget.currentPurpose;
    _sort = widget.currentSort;
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.isAr;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
        20, 16, 20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.tan.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Title + clear all
            Row(
              children: [
                Text(
                  isAr ? 'تصفية الحيوانات' : 'Filter Animals',
                  style: AppTypography.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() {
                    _gender = null;
                    _ageClassId = null;
                    _status = null;
                    _purpose = null;
                    _sort = _SortOption.none;
                  }),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    isAr ? 'مسح الكل' : 'Clear all',
                    style: const TextStyle(
                        color: AppColors.brown, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // ── Gender ──────────────────────────────────────────────
            _SheetSection(
              title: isAr ? 'الجنس' : 'Gender',
              children: [
                _SheetChip(
                  label: isAr ? 'الكل' : 'All',
                  selected: _gender == null,
                  onTap: () => setState(() => _gender = null),
                ),
                _SheetChip(
                  label: isAr ? 'ذكور' : 'Males',
                  icon: Icons.male_rounded,
                  selected: _gender == 'Male',
                  onTap: () => setState(
                      () => _gender = _gender == 'Male' ? null : 'Male'),
                ),
                _SheetChip(
                  label: isAr ? 'إناث' : 'Females',
                  icon: Icons.female_rounded,
                  selected: _gender == 'Female',
                  onTap: () => setState(() =>
                      _gender = _gender == 'Female' ? null : 'Female'),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // ── Age Group ───────────────────────────────────────────
            _SheetSection(
              title: isAr ? 'الفئة العمرية' : 'Age Group',
              children: [
                _SheetChip(
                  label: isAr ? 'الكل' : 'All',
                  selected: _ageClassId == null,
                  onTap: () => setState(() => _ageClassId = null),
                ),
                ...ageClasses.map((ac) => _SheetChip(
                      label: isAr ? ac.nameAr : ac.nameEn,
                      selected: _ageClassId == ac.id,
                      onTap: () => setState(() =>
                          _ageClassId =
                              _ageClassId == ac.id ? null : ac.id),
                    )),
              ],
            ),

            const SizedBox(height: 18),

            // ── Status ──────────────────────────────────────────────
            _SheetSection(
              title: isAr ? 'الحالة' : 'Status',
              children: [
                _SheetChip(
                  label: isAr ? 'الكل' : 'All',
                  selected: _status == null,
                  onTap: () => setState(() => _status = null),
                ),
                ...AnimalStatus.values.map((st) => _SheetChip(
                      label: isAr ? st.nameAr : st.nameEn,
                      dotColor: st.color,
                      selected: _status == st.name,
                      onTap: () => setState(() =>
                          _status = _status == st.name ? null : st.name),
                    )),
              ],
            ),

            const SizedBox(height: 18),

            // ── Purpose ─────────────────────────────────────────────
            _SheetSection(
              title: isAr ? 'الغرض' : 'Purpose',
              children: [
                _SheetChip(
                  label: isAr ? 'الكل' : 'All',
                  selected: _purpose == null,
                  onTap: () => setState(() => _purpose = null),
                ),
                ...AnimalPurpose.values.map((p) => _SheetChip(
                      label: isAr ? p.nameAr : p.nameEn,
                      selected: _purpose == p,
                      onTap: () => setState(
                          () => _purpose = _purpose == p ? null : p),
                    )),
              ],
            ),

            const SizedBox(height: 18),

            // ── Sort ────────────────────────────────────────────────
            _SheetSection(
              title: isAr ? 'الترتيب' : 'Sort By',
              children: _SortOption.values.map((opt) => _SheetChip(
                label: opt.label(isAr),
                selected: _sort == opt,
                onTap: () => setState(() => _sort = opt),
              )).toList(),
            ),

            const SizedBox(height: 24),

            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(_gender, _ageClassId, _status, _purpose, _sort);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  isAr ? 'تطبيق الفلتر' : 'Apply Filter',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Sheet section ───────────────────────────────────────────────────────────

class _SheetSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SheetSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: children),
      ],
    );
  }
}

// ── Sheet chip ──────────────────────────────────────────────────────────────

class _SheetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? dotColor;

  const _SheetChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
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
            if (dotColor != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
            ],
            if (icon != null) ...[
              Icon(icon,
                  size: 14,
                  color: selected ? AppColors.primary : AppColors.textMuted),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? AppColors.primary : AppColors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Active filter chip (shown in filter bar) ────────────────────────────────

class _ActiveChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _ActiveChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.fromLTRB(10, 5, 6, 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close_rounded,
                size: 14, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

// ── Species chip ────────────────────────────────────────────────────────────

class _SpeciesChip extends StatelessWidget {
  final String label;
  final String emoji;
  final Color? color;
  final bool selected;
  final VoidCallback onTap;

  const _SpeciesChip({
    required this.label,
    required this.emoji,
    this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.12) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCircle),
          border: Border.all(
            color: selected ? c : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: selected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: selected ? c : AppColors.brown,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bulk edit sheet ─────────────────────────────────────────────────────────

class _BulkEditSheet extends StatefulWidget {
  final bool isAr;
  final List<MockAnimal> animals;
  final Future<void> Function(LivestockSpecies from, LivestockSpecies to) onApply;

  const _BulkEditSheet({
    required this.isAr,
    required this.animals,
    required this.onApply,
  });

  @override
  State<_BulkEditSheet> createState() => _BulkEditSheetState();
}

class _BulkEditSheetState extends State<_BulkEditSheet> {
  LivestockSpecies? _from;
  LivestockSpecies? _to;
  bool _loading = false;

  int get _matchCount => _from == null
      ? 0
      : widget.animals.where((a) => a.species == _from).length;

  @override
  Widget build(BuildContext context) {
    final isAr = widget.isAr;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
        20, 16, 20, MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: AppColors.tan.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isAr ? 'تعديل جماعي للنوع' : 'Bulk Species Update',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            isAr
                ? 'حدّد النوع الحالي الخاطئ ثم النوع الصحيح'
                : 'Select the incorrect species and the correct one',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 18),
          Text(isAr ? 'من النوع:' : 'From species:',
              style: AppTypography.labelMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: LivestockSpecies.values.map((s) {
              final sel = _from == s;
              return GestureDetector(
                onTap: () => setState(() { _from = s; if (_to == s) _to = null; }),
                child: _SpeciesChip(
                  label: isAr ? s.nameAr : s.displayName,
                  emoji: s.emoji,
                  color: s.color,
                  selected: sel,
                  onTap: () => setState(() { _from = s; if (_to == s) _to = null; }),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          Text(isAr ? 'إلى النوع:' : 'To species:',
              style: AppTypography.labelMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: LivestockSpecies.values
                .where((s) => s != _from)
                .map((s) {
              final sel = _to == s;
              return _SpeciesChip(
                label: isAr ? s.nameAr : s.displayName,
                emoji: s.emoji,
                color: s.color,
                selected: sel,
                onTap: () => setState(() => _to = s),
              );
            }).toList(),
          ),
          if (_from != null && _matchCount >= 0) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isAr
                    ? '$_matchCount حيوان سيتم تحديثه'
                    : '$_matchCount animals will be updated',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (_from != null && _to != null && _matchCount > 0 && !_loading)
                  ? () async {
                      setState(() => _loading = true);
                      await widget.onApply(_from!, _to!);
                      if (mounted) Navigator.of(context).pop();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                elevation: 0,
              ),
              child: _loading
                  ? const SizedBox(
                      width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      isAr ? 'تطبيق التعديل' : 'Apply Update',
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final bool hasSearch;
  const _EmptyState({required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🐾', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(
            hasSearch ? l.animalsNoMatch : l.animalsEmpty,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            hasSearch ? l.animalsNoMatchHint : l.animalsEmptyHint,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
