import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/dashboard_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/activity_feed.dart';
import '../widgets/category_shortcuts_grid.dart';
import '../widgets/species_breakdown_chart.dart';
import '../widgets/summary_card.dart';
import '../widgets/upcoming_events_widget.dart';
import '../../../health/presentation/providers/health_provider.dart';
import '../providers/activity_provider.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final stats = ref.watch(dashboardStatsProvider);
    final upcoming = ref.watch(upcomingEventsProvider);
    final activities = ref.watch(activitiesProvider);
    final farmName       = ref.watch(farmNameProvider);
    final farmLocation   = ref.watch(farmLocationProvider);
    final preferredSpecies = ref.watch(preferredSpeciesProvider);
    final alertCount     = ref.watch(alertsCountProvider);

    // Events due within the next 7 days
    final now = DateTime.now();
    final sevenDaysLater = now.add(const Duration(days: 7));
    final soonCount = upcoming.where((e) {
      final d = DateTime.tryParse(e.dueDate);
      return d != null && !d.isBefore(now) && !d.isAfter(sevenDaysLater);
    }).length;
    final visibleSpecies = preferredSpecies.isEmpty
        ? LivestockSpecies.values.toList()
        : LivestockSpecies.values
            .where((s) => preferredSpecies.contains(s.name))
            .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Greeting header ─────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 20,
                    AppSpacing.screenPadding, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.dashboardGreeting,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            farmName.isNotEmpty ? farmName : l.dashboardDefaultFarmName,
                            style: AppTypography.displayMedium.copyWith(
                              fontSize: 22,
                            ),
                          ),
                          if (farmLocation.isNotEmpty)
                            Text(
                              farmLocation,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.brown,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Bell icon with badge
                    GestureDetector(
                      onTap: () => context.push(Routes.notifications),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.tan.withValues(alpha: 0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: AppColors.primary,
                              size: 22,
                            ),
                          ),
                          if (alertCount > 0)
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  alertCount > 99 ? '99+' : '$alertCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Herd summary cards (2 × 2 grid) ────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 20,
                    AppSpacing.screenPadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.dashboardHerdOverview,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Row 1: Total + Active
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            emoji: '🐄',
                            label: l.dashboardTotalAnimals,
                            value: '${stats.total}',
                            color: AppColors.primary,
                            onTap: () => context.go(Routes.animals),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SummaryCard(
                            emoji: '✅',
                            label: l.statusActive,
                            value: '${stats.active}',
                            color: AppColors.statusActive,
                            onTap: () => context.go(Routes.animals),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Row 2: Sold + Upcoming Events
                    Row(
                      children: [
                        Expanded(
                          child: SummaryCard(
                            emoji: '💰',
                            label: l.statusSold,
                            value: '${stats.sold}',
                            color: AppColors.statusSold,
                            onTap: () => context.go(Routes.animals),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SummaryCard(
                            emoji: '📅',
                            label: l.dashboardEventsThisWeek,
                            value: '$soonCount',
                            color: const Color(0xFF5C6BC0),
                            onTap: () => context.go(Routes.health),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Category shortcuts grid ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, AppSpacing.sectionGap,
                    AppSpacing.screenPadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.dashboardCategories,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CategoryShortcutsGrid(),
                  ],
                ),
              ),
            ),

            // ── Species breakdown chart ──────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, AppSpacing.sectionGap,
                    AppSpacing.screenPadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.dashboardSpeciesBreakdown,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SpeciesBreakdownChart(stats: stats),
                  ],
                ),
              ),
            ),

            // ── Species quick-filter bar (hidden when single-herd mode) ─────
            if (visibleSpecies.length > 1)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding, 12,
                      AppSpacing.screenPadding, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: visibleSpecies.map((s) {
                        final count = stats.bySpecies[s] ?? 0;
                        return GestureDetector(
                          onTap: () => context.go(Routes.animals),
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(end: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMedium),
                              border: Border.all(
                                  color: s.color.withValues(alpha: 0.4)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(s.emoji,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 6),
                                Text(
                                  '${s.displayName} ($count)',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

            // ── Upcoming vaccinations ────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, AppSpacing.sectionGap,
                    AppSpacing.screenPadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          l.dashboardUpcomingEvents,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.go(Routes.health),
                          child: Text(
                            l.dashboardSeeAll,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.brown,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    UpcomingEventsWidget(events: upcoming),
                  ],
                ),
              ),
            ),

            // ── Activity feed ────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, AppSpacing.sectionGap,
                    AppSpacing.screenPadding, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.dashboardRecentActivity,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ActivityFeed(activities: activities),
                  ],
                ),
              ),
            ),

            // ── FAB spacer ───────────────────────────────────────────────────
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),

      // ── FAB ─────────────────────────────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.addAnimal),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          l.dashboardAddAnimal,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
