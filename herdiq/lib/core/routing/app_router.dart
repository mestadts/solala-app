import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verify_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/country_selector_page.dart';
import '../../features/onboarding/presentation/pages/org_type_page.dart';
import '../../features/onboarding/presentation/pages/org_setup_page.dart';
import '../../core/mock/mock_data.dart';
import '../../core/routing/newborn_extra.dart';
import '../../features/animals/presentation/pages/animals_list_page.dart';
import '../../features/animals/presentation/pages/add_animal_page.dart';
import '../../features/animals/presentation/pages/animal_detail_page.dart';
import '../../features/animals/presentation/pages/edit_animal_page.dart';
import '../../features/animals/presentation/pages/qr_scanner_page.dart';
import '../../features/health/presentation/pages/health_overview_page.dart';
import '../../features/health/presentation/pages/animal_health_history_page.dart';
import '../../features/health/presentation/pages/add_vaccination_page.dart';
import '../../features/health/presentation/pages/add_treatment_page.dart';
import '../../features/health/presentation/pages/add_weight_page.dart';
import '../../features/health/presentation/pages/add_pregnancy_page.dart';
import '../../features/health/presentation/pages/add_deworming_page.dart';
import '../../features/health/presentation/pages/register_birth_page.dart';
import '../../features/breeding/presentation/pages/add_breeding_record_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/ownership/presentation/pages/transfer_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/profile_edit_page.dart';
import '../../features/settings/presentation/pages/org_settings_page.dart';
import '../../features/settings/presentation/pages/worker_management_page.dart';
import '../../features/settings/presentation/pages/pen_management_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/import/presentation/pages/csv_import_page.dart';
import '../../features/animals/presentation/pages/pedigree_page.dart';
import '../../features/settings/presentation/pages/field_labels_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../shared/widgets/main_shell.dart';
import '../providers/prefs_provider.dart';

// ── Route names ────────────────────────────────────────────────────────────
class Routes {
  Routes._();

  static const splash           = '/';
  static const login            = '/login';
  static const register         = '/register';
  static const otpVerify        = '/otp-verify';
  static const forgotPassword   = '/forgot-password';
  static const resetPassword    = '/reset-password';
  static const onboarding       = '/onboarding';
  static const countrySelector  = '/country-selector';
  static const orgType          = '/org-type';
  static const orgSetup         = '/org-setup';

  static const home             = '/home';
  static const dashboard        = '/home/dashboard';
  static const animals          = '/home/animals';
  static const health           = '/home/health';
  static const qrScanner        = '/home/qr';
  static const settings         = '/home/settings';

  static const addAnimal        = '/home/animals/add';

  static const addVaccination   = '/home/health/add-vaccination';
  static const addTreatment     = '/home/health/add-treatment';
  static const addWeight        = '/home/health/add-weight';
  static const addPregnancy     = '/home/health/add-pregnancy';
  static const addDeworming     = '/home/health/add-deworming';
  static const registerBirth   = '/home/health/register-birth';

  static const profileEdit            = '/home/settings/profile';
  static const orgSettings            = '/home/settings/organization';
  static const workerManagement       = '/home/settings/workers';
  static const csvImport              = '/home/settings/import';
  static const penManagement          = '/home/settings/pens';
  static const notificationSettings   = '/home/settings/notifications';
  static const fieldLabels             = '/home/settings/field-labels';

  static const notifications = '/home/notifications';

  // Phase 16
  static String pedigree(String animalId) => '/home/animals/$animalId/pedigree';
}

// ── Router provider ────────────────────────────────────────────────────────
//
// IMPORTANT: We read initial values once and then use ref.listen to update
// local variables + call router.refresh(). This avoids recreating the GoRouter
// instance when auth state changes, which would reset navigation to the
// initial route (splash → login) mid-flow.
final appRouterProvider = Provider<GoRouter>((ref) {
  bool isLoggedIn              = ref.read(isAuthenticatedProvider);
  bool authLoading             = ref.read(isAuthLoadingProvider);
  bool onboardingDone          = ref.read(onboardingDoneProvider);
  bool registrationInProgress  = ref.read(registrationInProgressProvider);
  bool passwordResetInProgress = ref.read(passwordResetInProgressProvider);

  final router = GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      if (authLoading) return Routes.splash;

      final loc = state.matchedLocation;

      final onSplash = loc == Routes.splash;
      final onAuth   = [
        Routes.login,
        Routes.register,
        Routes.otpVerify,
        Routes.forgotPassword,
        Routes.resetPassword,
      ].contains(loc);
      final onOnboarding = [
        Routes.onboarding,
        Routes.countrySelector,
        Routes.orgType,
        Routes.orgSetup,
      ].contains(loc);

      if (onSplash) return null;

      if (!isLoggedIn) {
        if (onAuth) return null;
        return Routes.login;
      }

      // Mid-registration: user is signed in (phone OTP) but hasn't set a
      // password yet. Stay on the register page until the flag clears.
      if (registrationInProgress) return null;

      // Mid-password-reset: user signed in via OTP but is still on the
      // OTP or reset-password screens. Don't redirect to dashboard yet.
      if (passwordResetInProgress) return null;

      if (isLoggedIn && !onboardingDone) {
        if (onOnboarding) return null;
        return Routes.onboarding;
      }

      if (isLoggedIn && onboardingDone) {
        if (onAuth || onOnboarding) return Routes.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashPage()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
      GoRoute(path: Routes.register, builder: (context, state) => const RegisterPage()),
      GoRoute(
        path: Routes.otpVerify,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return OtpVerifyPage(phone: extra['phone'] as String? ?? '');
        },
      ),
      GoRoute(path: Routes.forgotPassword, builder: (context, state) => const ForgotPasswordPage()),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          return ResetPasswordPage(phone: extra['phone'] as String? ?? '');
        },
      ),
      GoRoute(path: Routes.onboarding, builder: (context, state) => const OnboardingPage()),
      GoRoute(path: Routes.countrySelector, builder: (context, state) => const CountrySelectorPage()),
      GoRoute(path: Routes.orgType, builder: (context, state) => const OrgTypePage()),
      GoRoute(path: Routes.orgSetup, builder: (context, state) => const OrgSetupPage()),
      GoRoute(path: Routes.home, redirect: (context, state) => Routes.dashboard),
      ShellRoute(
        builder: (context, state, child) => MainShell(
          location: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(path: Routes.dashboard, builder: (context, state) => const DashboardPage()),
          GoRoute(path: Routes.animals, builder: (context, state) => const AnimalsListPage()),
          GoRoute(path: Routes.health, builder: (context, state) => const HealthOverviewPage()),
          GoRoute(path: Routes.settings, builder: (context, state) => const SettingsPage()),
        ],
      ),
      GoRoute(path: Routes.qrScanner, builder: (context, state) => const QrScannerPage()),
      GoRoute(path: Routes.notifications, builder: (context, state) => const NotificationsPage()),
      GoRoute(
        path: Routes.addAnimal,
        builder: (context, state) {
          final extra = state.extra;
          return AddAnimalPage(
            sourceAnimal: extra is MockAnimal ? extra : null,
            newbornExtra: extra is NewbornExtra ? extra : null,
          );
        },
      ),
      GoRoute(
        path: '/home/animals/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return AnimalDetailPage(animalId: id);
        },
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return EditAnimalPage(animalId: id);
            },
          ),
          GoRoute(
            path: 'transfer',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return TransferPage(animalId: id);
            },
          ),
          GoRoute(
            path: 'add-breeding',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return AddBreedingRecordPage(animalId: id);
            },
          ),
          GoRoute(
            path: 'pedigree',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return PedigreePage(animalId: id);
            },
          ),
          GoRoute(
            path: 'register-birth',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return RegisterBirthPage(damId: id);
            },
          ),
        ],
      ),
      GoRoute(path: Routes.addVaccination, builder: (context, state) => const AddVaccinationPage()),
      GoRoute(path: Routes.addTreatment, builder: (context, state) => const AddTreatmentPage()),
      GoRoute(path: Routes.addWeight, builder: (context, state) => const AddWeightPage()),
      GoRoute(path: Routes.addPregnancy, builder: (context, state) => const AddPregnancyPage()),
      GoRoute(path: Routes.addDeworming, builder: (context, state) => const AddDewormingPage()),
      GoRoute(path: Routes.registerBirth, builder: (context, state) => const RegisterBirthPage()),
      GoRoute(
        path: '/home/health/:animalId',
        builder: (context, state) {
          final id = state.pathParameters['animalId']!;
          return AnimalHealthHistoryPage(animalId: id);
        },
      ),
      GoRoute(path: Routes.profileEdit, builder: (context, state) => const ProfileEditPage()),
      GoRoute(path: Routes.orgSettings, builder: (context, state) => const OrgSettingsPage()),
      GoRoute(path: Routes.workerManagement, builder: (context, state) => const WorkerManagementPage()),
      GoRoute(path: Routes.csvImport, builder: (context, state) => const CsvImportPage()),
      GoRoute(path: Routes.penManagement, builder: (context, state) => const PenManagementPage()),
      GoRoute(path: Routes.notificationSettings, builder: (context, state) => const NotificationSettingsPage()),
      GoRoute(path: Routes.fieldLabels, builder: (context, state) => const FieldLabelsPage()),
    ],
  );

  // Update local variables and refresh redirect without recreating the router.
  // ref.listen does NOT cause this provider to rebuild (unlike ref.watch).
  ref.listen<bool>(isAuthenticatedProvider, (_, v) { isLoggedIn = v; router.refresh(); });
  ref.listen<bool>(isAuthLoadingProvider, (_, v) { authLoading = v; router.refresh(); });
  ref.listen<bool>(onboardingDoneProvider, (_, v) { onboardingDone = v; router.refresh(); });
  ref.listen<bool>(registrationInProgressProvider, (_, v) { registrationInProgress = v; router.refresh(); });
  ref.listen<bool>(passwordResetInProgressProvider, (_, v) { passwordResetInProgress = v; router.refresh(); });

  ref.onDispose(router.dispose);
  return router;
});
