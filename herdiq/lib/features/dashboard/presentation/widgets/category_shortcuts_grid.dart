import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/animal_purpose.dart';
import '../../../../core/providers/date_format_provider.dart';
import '../../../../core/routing/animal_filter_extra.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

// ── Shortcut data model ───────────────────────────────────────────────────────

class _Shortcut {
  final IconData icon;
  final String label;
  final String route;
  final AnimalFilterExtra? filter;
  final bool isUdhiya;

  const _Shortcut({
    required this.icon,
    required this.label,
    required this.route,
    this.filter,
    this.isUdhiya = false,
  });
}

// ── Widget ────────────────────────────────────────────────────────────────────

class CategoryShortcutsGrid extends ConsumerWidget {
  const CategoryShortcutsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final showUdhiya = ref.watch(udhiyaShowProvider);

    final allShortcuts = [
      _Shortcut(
        icon: Icons.child_care,
        label: l.dashboardShortcutBahm,
        route: Routes.animals,
        filter: const AnimalFilterExtra(ageClassId: 'bahm'),
      ),
      _Shortcut(
        icon: Icons.vaccines,
        label: l.dashboardShortcutVaccination,
        route: Routes.health,
      ),
      _Shortcut(
        icon: Icons.pregnant_woman,
        label: l.dashboardShortcutNearBirth,
        route: Routes.health,
      ),
      _Shortcut(
        icon: Icons.male,
        label: l.dashboardShortcutMales,
        route: Routes.animals,
        filter: const AnimalFilterExtra(gender: 'Male'),
      ),
      _Shortcut(
        icon: Icons.female,
        label: l.dashboardShortcutFemales,
        route: Routes.animals,
        filter: const AnimalFilterExtra(gender: 'Female'),
      ),
      _Shortcut(
        icon: Icons.favorite,
        label: l.dashboardShortcutBreeding,
        route: Routes.animals,
        filter: const AnimalFilterExtra(purpose: AnimalPurpose.breeding),
      ),
      _Shortcut(
        icon: Icons.sentiment_very_dissatisfied,
        label: l.dashboardShortcutDeceased,
        route: Routes.animals,
        filter: const AnimalFilterExtra(status: 'deceased'),
      ),
      _Shortcut(
        icon: Icons.restaurant,
        label: l.dashboardShortcutFattening,
        route: Routes.animals,
        filter: const AnimalFilterExtra(purpose: AnimalPurpose.fattening),
      ),
      _Shortcut(
        icon: Icons.health_and_safety,
        label: l.dashboardShortcutCheckups,
        route: Routes.health,
      ),
      _Shortcut(
        icon: Icons.cruelty_free,
        label: l.dashboardShortcutUdhiya,
        route: Routes.animals,
        filter: const AnimalFilterExtra(udhiyaOnly: true),
        isUdhiya: true,
      ),
    ];

    final visibleShortcuts = allShortcuts
        .where((s) => !s.isUdhiya || showUdhiya)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemCount: visibleShortcuts.length,
      itemBuilder: (context, i) {
        final shortcut = visibleShortcuts[i];
        return _ShortcutCard(shortcut: shortcut);
      },
    );
  }
}

// ── Shortcut card ─────────────────────────────────────────────────────────────

class _ShortcutCard extends StatelessWidget {
  final _Shortcut shortcut;
  const _ShortcutCard({required this.shortcut});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (shortcut.filter != null) {
          context.go(shortcut.route, extra: shortcut.filter);
        } else {
          context.go(shortcut.route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.tan.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(
                shortcut.icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                shortcut.label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
