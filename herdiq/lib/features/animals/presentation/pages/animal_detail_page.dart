import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/species_terms_provider.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/constants/udhiya_rules.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/date_format_provider.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../providers/animal_provider.dart';
import '../../../health/presentation/providers/health_provider.dart';
import '../../../health/presentation/providers/weight_provider.dart';
import '../../../ownership/presentation/providers/ownership_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/species_badge.dart';
import '../../../../shared/widgets/status_badge.dart';
import '../widgets/qr_code_display.dart';
import '../../../../features/breeding/presentation/widgets/breeding_tab.dart';
import '../providers/custom_fields_provider.dart';
import '../widgets/custom_fields_widget.dart';
import '../../../health/presentation/widgets/horse_weight_estimator.dart';

class AnimalDetailPage extends ConsumerStatefulWidget {
  final String animalId;
  const AnimalDetailPage({super.key, required this.animalId});

  @override
  ConsumerState<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends ConsumerState<AnimalDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  // ── Color name helper ──────────────────────────────────────────────────────
  String _colorName(String colorId, BuildContext context) {
    final locale = Localizations.localeOf(context);
    final color = animalColors.where((c) => c.id == colorId).firstOrNull;
    if (locale.languageCode == 'ar') return color?.nameAr ?? colorId;
    return color?.nameEn ?? colorId;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final animal = ref.watch(animalByIdProvider(widget.animalId));
    final showUdhiya = ref.watch(udhiyaShowProvider);

    if (animal == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          elevation: 0,
        ),
        body: Center(child: Text(l.animalDetailNotFound)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar ──────────────────────────────────────────────────
            _buildAppBar(context, animal, l),

            // ── Header card ─────────────────────────────────────────────
            _buildHeader(animal, l, showUdhiya),

            // ── Tab bar ─────────────────────────────────────────────────
            Container(
              color: AppColors.background,
              child: TabBar(
                controller: _tab,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textMuted,
                indicatorColor: AppColors.primary,
                labelStyle: AppTypography.bodyMedium
                    .copyWith(fontWeight: FontWeight.w600),
                tabs: [
                  Tab(text: l.animalDetailTabHealth),
                  Tab(text: l.animalDetailTabWeight),
                  Tab(text: l.animalDetailTabOwnership),
                  Tab(text: l.animalDetailTabBreeding),
                ],
              ),
            ),

            // ── Tab content ─────────────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  _HealthTab(animalId: animal.id),
                  _WeightTab(animalId: animal.id, species: animal.species),
                  _OwnershipTab(animalId: animal.id),
                  BreedingTab(animalId: animal.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, MockAnimal animal, AppL l) {
    final colorName = _colorName(animal.colorId, context);
    final primaryIdentity =
        l.animalIdentity(animal.tagNumber.toString(), colorName);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
          Expanded(
            child: Text(
              primaryIdentity,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Edit
          IconButton(
            icon: const Icon(Icons.edit_outlined,
                size: 20, color: AppColors.primary),
            onPressed: () =>
                context.push('/home/animals/${animal.id}/edit'),
          ),
          // QR
          IconButton(
            icon: const Icon(Icons.qr_code_rounded,
                size: 20, color: AppColors.primary),
            onPressed: () => _showQr(context, animal, l),
          ),
          // More (Duplicate + Delete)
          PopupMenuButton<_DetailAction>(
            icon: const Icon(Icons.more_vert_rounded,
                size: 20, color: AppColors.primary),
            onSelected: (action) {
              if (action == _DetailAction.duplicate) {
                context.push(Routes.addAnimal, extra: animal);
              } else if (action == _DetailAction.delete) {
                _confirmDelete(context, animal, l);
              }
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: _DetailAction.duplicate,
                child: Row(
                  children: [
                    const Icon(Icons.copy_rounded,
                        size: 18, color: AppColors.primary),
                    const SizedBox(width: 10),
                    Text(l.animalDuplicate,
                        style: AppTypography.bodyMedium),
                  ],
                ),
              ),
              PopupMenuItem(
                value: _DetailAction.delete,
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline,
                        size: 18, color: AppColors.statusError),
                    const SizedBox(width: 10),
                    Text(l.btnDelete,
                        style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.statusError)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(MockAnimal animal, AppL l, bool showUdhiya) {
    final colorName = _colorName(animal.colorId, context);
    final primaryIdentity =
        l.animalIdentity(animal.tagNumber.toString(), colorName);

    final eligible = isUdhiyaEligible(
      species: animal.species,
      dateOfBirth: animal.dateOfBirth,
      status: animal.status,
    );

    // Determine ineligibility reason
    String? ineligibleReason;
    if (showUdhiya && !eligible) {
      final minAge = udhiyaMinAgeMonths[animal.species] ?? -1;
      if (minAge < 0) {
        ineligibleReason = l.udhiyaSpeciesIneligible;
      } else {
        final dob = DateTime.tryParse(animal.dateOfBirth);
        final now = DateTime.now();
        final ageMonths = dob != null
            ? (now.year - dob.year) * 12 + (now.month - dob.month)
            : 0;
        if (ageMonths < minAge) {
          ineligibleReason =
              '${l.udhiyaMinAgeRequired(udhiyaMinAgeEn(animal.species))} • '
              '${l.udhiyaCurrentAge('$ageMonths months')}';
        } else {
          ineligibleReason =
              l.udhiyaStatusIneligible(animal.status.nameAr);
        }
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        8,
        AppSpacing.screenPadding,
        0,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Species avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: animal.species.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                child: Center(
                  child: Text(
                    animal.species.emoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // H1: primary identity
                    Text(
                      primaryIdentity,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // systemAnimalId — small internal ref with lock icon
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.lock_outline,
                            size: 11, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          animal.systemAnimalId,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 11,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SpeciesBadge(species: animal.species),
                        const SizedBox(width: 6),
                        StatusBadge(status: animal.status),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Stats row
          Row(
            children: [
              _Stat(
                label: l.animalDetailGender,
                value: resolveGenderTerm(
                  animal.species,
                  animal.gender,
                  Localizations.localeOf(context).languageCode == 'ar',
                  ref.watch(speciesTermsProvider).valueOrNull ??
                      defaultSpeciesTerms,
                  dateOfBirth: animal.dateOfBirth,
                ),
              ),
              _Stat(label: l.animalDetailBreed, value: animal.breed),
              _Stat(label: l.animalDetailDob, value: animal.dateOfBirth),
              _Stat(
                label: l.animalDetailWeight,
                value: '${animal.weight} kg',
              ),
            ],
          ),

          // Breeder tag row
          if (animal.breederTag.isNotEmpty) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(Icons.label_outline,
                      size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    '${l.animalDetailTag}${animal.breederTag}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.brown,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // officialTagNumber row
          if (animal.officialTagNumber != null &&
              animal.officialTagNumber!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(Icons.verified_outlined,
                      size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    '${l.animalOfficialTag}: ',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      animal.officialTagNumber!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Udhiya section
          if (showUdhiya) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l.udhiyaSection,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Eligibility chip
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: eligible
                        ? const Color(0xFF34C759).withValues(alpha: 0.12)
                        : AppColors.statusError.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: eligible
                          ? const Color(0xFF34C759).withValues(alpha: 0.5)
                          : AppColors.statusError.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        eligible
                            ? Icons.check_circle_outline_rounded
                            : Icons.cancel_outlined,
                        size: 14,
                        color: eligible
                            ? const Color(0xFF34C759)
                            : AppColors.statusError,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        eligible ? l.udhiyaEligible : l.udhiyaNotEligible,
                        style: AppTypography.bodySmall.copyWith(
                          color: eligible
                              ? const Color(0xFF34C759)
                              : AppColors.statusError,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Ineligibility reason text
                if (!eligible && ineligibleReason != null) ...[
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      ineligibleReason,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],

          // ── Custom fields display ─────────────────────────────────────
          _CustomFieldsSection(animal: animal),
        ],
      ),
    );
  }

  void _showQr(BuildContext context, MockAnimal animal, AppL l) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l.animalDetailQrTitle, style: AppTypography.displayMedium),
            const SizedBox(height: 4),
            Text(
              l.animalIdentity(
                animal.tagNumber.toString(),
                _colorName(animal.colorId, context),
              ),
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 24),
            QrCodeDisplay(systemAnimalId: animal.systemAnimalId),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, MockAnimal animal, AppL l) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          l.animalDetailDeleteTitle(animal.name.isNotEmpty
              ? animal.name
              : animal.systemAnimalId),
          style: AppTypography.bodyMedium
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: Text(
          l.animalDetailDeleteMsg(animal.name.isNotEmpty
              ? animal.name
              : animal.systemAnimalId),
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l.btnCancel,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.brown)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(animalActionsProvider)
                  .deleteAnimal(animal.id);
              Navigator.pop(context);
              context.pop();
            },
            child: Text(l.btnDelete,
                style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.statusError,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ── App bar action enum ────────────────────────────────────────────────────────

enum _DetailAction { duplicate, delete }

// ── Stat cell ──────────────────────────────────────────────────────────────────

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Health tab ─────────────────────────────────────────────────────────────────

class _HealthTab extends ConsumerWidget {
  final String animalId;
  const _HealthTab({required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final records = ref.watch(healthByAnimalProvider(animalId)).valueOrNull ?? [];

    if (records.isEmpty) {
      return _emptyState(l.animalDetailNoHealth, '💉');
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, 12,
          AppSpacing.screenPadding, 80),
      itemCount: records.length,
      itemBuilder: (context, i) => _HealthRecordTile(record: records[i]),
    );
  }
}

class _HealthRecordTile extends StatelessWidget {
  final MockHealthRecord record;
  const _HealthRecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    final isVacc = record.recordType == 'vaccination';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(isVacc ? '💉' : '💊', style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.title,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${record.date} • ${record.vetName}',
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                ),
                if (record.nextDueDate != null)
                  Text(
                    'Next due: ${record.nextDueDate}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.statusSold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Weight tab ─────────────────────────────────────────────────────────────────

class _WeightTab extends ConsumerWidget {
  final String animalId;
  final LivestockSpecies species;
  const _WeightTab({required this.animalId, required this.species});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final records = ref.watch(weightByAnimalProvider(animalId)).valueOrNull ?? [];
    final isHorse = species == LivestockSpecies.horse;

    return CustomScrollView(
      slivers: [
        if (isHorse)
          SliverToBoxAdapter(
            child: HorseWeightEstimator(animalId: animalId),
          ),
        if (records.isEmpty)
          SliverFillRemaining(
            child: _emptyState(l.animalDetailNoWeight, '⚖️'),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding, 12, AppSpacing.screenPadding, 80),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _WeightTile(record: records[i]),
                childCount: records.length,
              ),
            ),
          ),
      ],
    );
  }
}

class _WeightTile extends StatelessWidget {
  final MockWeightRecord record;
  const _WeightTile({required this.record});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text('⚖️', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              record.recordedAt,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.brown,
              ),
            ),
          ),
          Text(
            '${record.weight} ${record.unit}',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          if (record.isOfficial) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.statusActive.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                l.animalDetailOfficial,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.statusActive,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Ownership tab ──────────────────────────────────────────────────────────────

class _OwnershipTab extends ConsumerWidget {
  final String animalId;
  const _OwnershipTab({required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final records =
        ref.watch(ownershipByAnimalProvider(animalId)).valueOrNull ?? [];

    return ListView(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding, 12, AppSpacing.screenPadding, 80),
      children: [
        // Current owner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.person_rounded,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.animalDetailCurrentOwner,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  Text(
                    ref.watch(authStateProvider).valueOrNull?.displayName
                        ?? ref.watch(farmNameProvider),
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Transfer button
        OutlinedButton.icon(
          onPressed: () =>
              context.push('/home/animals/$animalId/transfer'),
          icon: const Icon(Icons.swap_horiz_rounded, size: 18),
          label: Text(l.animalDetailTransferOwnership),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
            ),
          ),
        ),

        const SizedBox(height: 20),

        if (records.isNotEmpty) ...[
          Text(
            l.animalDetailTransferHistory,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
          ...records.map((r) => _OwnershipTile(record: r)),
        ] else
          _emptyState(l.animalDetailNoTransfers, '🔄'),
      ],
    );
  }
}

class _OwnershipTile extends StatelessWidget {
  final MockOwnershipRecord record;
  const _OwnershipTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔄', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                record.transferType,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              Text(
                record.transferDate,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${record.fromOwner} → ${record.toOwner}',
            style: AppTypography.bodyMedium
                .copyWith(color: AppColors.brown),
          ),
          if (record.price != null)
            Text(
              '${record.price} ${record.currency}',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
              ),
            ),
        ],
      ),
    );
  }
}

// ── Shared empty state ─────────────────────────────────────────────────────────

Widget _emptyState(String message, String emoji) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 44)),
        const SizedBox(height: 12),
        Text(
          message,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textMuted,
          ),
        ),
      ],
    ),
  );
}

// ── Phase 16: Custom fields display in header ─────────────────────────────────

class _CustomFieldsSection extends ConsumerWidget {
  final MockAnimal animal;
  const _CustomFieldsSection({required this.animal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = ref.watch(customFieldsForSpeciesProvider(animal.species.name));
    if (fields.isEmpty || animal.customValues.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CustomFieldsDisplay(
        fields: fields,
        values: animal.customValues,
      ),
    );
  }
}
