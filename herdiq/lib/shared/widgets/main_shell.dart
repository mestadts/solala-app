import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final String location;

  const MainShell({super.key, required this.child, required this.location});

  int get _activeIndex {
    if (location.startsWith(Routes.animals)) return 1;
    if (location.startsWith(Routes.health))  return 2;
    if (location.startsWith(Routes.settings)) return 3;
    return 0; // dashboard
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (_activeIndex != 0) {
          // On a non-home tab → go to dashboard instead of exiting
          context.go(Routes.dashboard);
        } else {
          // Already on home → exit the app
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: child,
        // QR scanner FAB hidden on the animals tab — filters are more useful there
        floatingActionButton: _activeIndex == 1
            ? null
            : FloatingActionButton(
                onPressed: () => context.push(Routes.qrScanner),
                backgroundColor: AppColors.primary,
                elevation: 4,
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: AppColors.onPrimary,
                  size: 26,
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: _activeIndex == 1
              ? const AutomaticNotchedShape(RoundedRectangleBorder())
              : const CircularNotchedRectangle(),
          notchMargin: 8,
          color: AppColors.surface,
          padding: EdgeInsets.zero,
          height: 64,
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: l.navHome,
                active: _activeIndex == 0,
                onTap: () => context.go(Routes.dashboard),
              ),
              _NavItem(
                icon: Icons.pets_rounded,
                label: l.navAnimals,
                active: _activeIndex == 1,
                onTap: () => context.go(Routes.animals),
              ),
              const Expanded(child: SizedBox()), // FAB spacer
              _NavItem(
                icon: Icons.health_and_safety_rounded,
                label: l.navHealth,
                active: _activeIndex == 2,
                onTap: () => context.go(Routes.health),
              ),
              _NavItem(
                icon: Icons.settings_rounded,
                label: l.navSettings,
                active: _activeIndex == 3,
                onTap: () => context.go(Routes.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.textMuted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
