import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/mock/mock_providers.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/health_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class HealthOverviewPage extends ConsumerWidget {
  const HealthOverviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final upcoming = ref.watch(upcomingEventsProvider);
    final all = ref.watch(allHealthStreamProvider).valueOrNull ?? [];
    // Most recent 5 records across all animals
    final recent = [...all]..sort((a, b) => b.date.compareTo(a.date));
    final recentSlice = recent.take(5).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding, 16, AppSpacing.screenPadding, 0),
              child: Text(
                l.healthTitle,
                style: AppTypography.displayMedium,
              ),
            ),

            // ── Content ─────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 16,
                    AppSpacing.screenPadding, 100),
                children: [
                  // ── Upcoming events (all types) ───────────────────────────
                  _SectionHeader(
                    title: l.healthUpcomingEvents,
                    count: upcoming.length,
                  ),
                  const SizedBox(height: 10),
                  if (upcoming.isEmpty)
                    _EmptyCard(message: l.healthNoUpcoming, emoji: '✅')
                  else
                    ...upcoming.map((e) => _UpcomingEventCard(event: e, l: l)),

                  const SizedBox(height: AppSpacing.sectionGap),

                  // ── Recent health records ─────────────────────────────────
                  _SectionHeader(
                    title: l.healthRecentRecords,
                    count: all.length,
                  ),
                  const SizedBox(height: 10),
                  if (recentSlice.isEmpty)
                    _EmptyCard(message: l.healthNoRecords, emoji: '💉')
                  else
                    ...recentSlice.map((r) => _RecentRecordTile(
                          record: r,
                          onTap: () =>
                              context.push('/home/health/${r.animalId}'),
                        )),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── FAB ─────────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOptions(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          l.healthAddRecord,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context) {
    final l = AppL.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.healthAddRecord,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              _AddOption(
                emoji: '💉',
                label: l.healthOptionVaccination,
                subtitle: l.healthOptionVaccinationDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.addVaccination);
                },
              ),
              const SizedBox(height: 10),
              _AddOption(
                emoji: '💊',
                label: l.healthOptionTreatment,
                subtitle: l.healthOptionTreatmentDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.addTreatment);
                },
              ),
              const SizedBox(height: 10),
              _AddOption(
                emoji: '⚖️',
                label: l.healthOptionWeight,
                subtitle: l.healthOptionWeightDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.addWeight);
                },
              ),
              const SizedBox(height: 10),
              _AddOption(
                emoji: '🤰',
                label: l.healthOptionPregnancy,
                subtitle: l.healthOptionPregnancyDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.addPregnancy);
                },
              ),
              const SizedBox(height: 10),
              _AddOption(
                emoji: '🐛',
                label: l.healthOptionDeworming,
                subtitle: l.healthOptionDewormingDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.addDeworming);
                },
              ),
              const SizedBox(height: 10),
              _AddOption(
                emoji: '🐣',
                label: l.healthOptionBirth,
                subtitle: l.healthOptionBirthDesc,
                onTap: () {
                  Navigator.pop(sheetCtx);
                  context.push(Routes.registerBirth);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 15,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$count',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Upcoming event card (all types: vaccination, deworming, birth) ─────────────

String _emojiForEventType(String type) {
  switch (type) {
    case 'vaccination': return '💉';
    case 'deworming':   return '🐛';
    case 'birth':       return '🤰';
    default:            return '📋';
  }
}

Color _colorForEventType(String type) {
  switch (type) {
    case 'vaccination': return AppColors.statusSold;
    case 'deworming':   return AppColors.brown;
    case 'birth':       return AppColors.statusActive;
    default:            return AppColors.textMuted;
  }
}

class _UpcomingEventCard extends StatelessWidget {
  final MockUpcomingEvent event;
  final AppL l;
  const _UpcomingEventCard({required this.event, required this.l});

  @override
  Widget build(BuildContext context) {
    final emoji = _emojiForEventType(event.type);
    final accent = _colorForEventType(event.type);
    final typeLabel = event.type == 'birth'
        ? l.upcomingBirthLabel
        : event.type == 'deworming'
            ? l.healthOptionDeworming
            : l.healthOptionVaccination;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title.isNotEmpty ? event.title : typeLabel,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  event.animalSystemId,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                l.healthDue,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted),
              ),
              Text(
                event.dueDate,
                style: AppTypography.bodySmall.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _emojiForType(String type) {
  switch (type) {
    case 'vaccination': return '💉';
    case 'treatment':   return '💊';
    case 'weight':      return '⚖️';
    case 'pregnancy':   return '🤰';
    case 'deworming':   return '🐛';
    default:            return '📋';
  }
}

// ── Recent record tile ─────────────────────────────────────────────────────────

class _RecentRecordTile extends StatelessWidget {
  final MockHealthRecord record;
  final VoidCallback onTap;
  const _RecentRecordTile({required this.record, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final emoji = _emojiForType(record.recordType);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 22),
            ),
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
                    '${record.animalSystemId} • ${record.date}',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty card ────────────────────────────────────────────────────────────────

class _EmptyCard extends StatelessWidget {
  final String message;
  final String emoji;
  const _EmptyCard({required this.message, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Center(
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Add option tile ────────────────────────────────────────────────────────────

class _AddOption extends StatelessWidget {
  final String emoji;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  const _AddOption({
    required this.emoji,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
