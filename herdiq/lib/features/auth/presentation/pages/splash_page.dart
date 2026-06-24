import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      // If auth state is still resolving, the router's refresh listener will
      // trigger once it settles — no manual navigation needed in that case.
      if (ref.read(isAuthLoadingProvider)) return;
      final isLoggedIn     = ref.read(isAuthenticatedProvider);
      final onboardingDone = ref.read(onboardingDoneProvider);
      if (!isLoggedIn) {
        context.go(Routes.login);
      } else if (!onboardingDone) {
        context.go(Routes.onboarding);
      } else {
        context.go(Routes.dashboard);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _scale,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 28),
              Text(l.appTitle, style: AppTypography.displayLarge),
              const SizedBox(height: 8),
              Text(l.appTagline, style: AppTypography.bodyMedium),
              const SizedBox(height: 52),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.tan.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
