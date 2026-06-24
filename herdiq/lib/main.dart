import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/config/firebase_config.dart';
import 'core/notifications/fcm_service.dart';
import 'core/config/isar_config.dart';
import 'core/providers/date_format_provider.dart';
import 'core/providers/isar_provider.dart';
import 'core/providers/locale_provider.dart';
import 'core/sync/sync_service.dart';
import 'core/providers/prefs_provider.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/pages/org_setup_page.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (uses google-services.json / GoogleService-Info.plist)
  await initFirebase();

  // Register FCM background handler before any other Firebase call
  try {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await fcmService.init();
  } catch (_) {}

  // Open Isar local database (all schemas registered in isar_config.dart)
  final isar = await openIsar();

  final prefs = await SharedPreferences.getInstance();

  String? currentUid;
  try { currentUid = FirebaseAuth.instance.currentUser?.uid; } catch (_) {}
  final storedUid  = prefs.getString(PrefsKeys.currentUserUid);

  if (currentUid != null && storedUid != null && currentUid != storedUid) {
    // ── Different user signed in: clear previous user's local farm data.
    await prefs.remove(PrefsKeys.farmName);
    await prefs.remove(PrefsKeys.farmLocation);
    await prefs.setBool(PrefsKeys.onboardingDone, false);
    await prefs.setString(PrefsKeys.currentUserUid, currentUid);
  } else if (currentUid != null && storedUid == null) {
    // ── Reinstall: Firebase Auth persists but SharedPreferences was cleared.
    // Check Firestore to see if this user already completed onboarding.
    await prefs.setString(PrefsKeys.currentUserUid, currentUid);
    try {
      final orgDoc = await FirebaseFirestore.instance
          .collection('organizations')
          .doc(currentUid)
          .get();
      if (orgDoc.exists) {
        final data = orgDoc.data() ?? {};
        await prefs.setBool(PrefsKeys.onboardingDone, true);
        await prefs.setString(PrefsKeys.farmName, data['name'] as String? ?? '');
        await prefs.setString(PrefsKeys.farmLocation, data['location'] as String? ?? '');
      }
    } catch (_) {
      // Offline or Firestore unreachable — user will go through onboarding
      // again but their actual animal/health data is safe in Firestore.
    }
  } else if (currentUid == null) {
    await prefs.remove(PrefsKeys.currentUserUid);
  }

  // ── Backfill Firestore docs for users who completed onboarding before
  // the fix that writes org/user documents was deployed.
  // Uses SetOptions(merge:true) so it's safe to run every startup.
  final onboardingDone = prefs.getBool(PrefsKeys.onboardingDone) ?? false;
  if (onboardingDone && currentUid != null) {
    try {
      await OrgSetupPage.bootstrapFirestoreDocs(
        uid: currentUid,
        farmName: prefs.getString(PrefsKeys.farmName) ?? '',
        farmLocation: prefs.getString(PrefsKeys.farmLocation) ?? '',
        displayName: FirebaseAuth.instance.currentUser?.displayName,
        phone: FirebaseAuth.instance.currentUser?.phoneNumber,
      );
    } catch (_) {
      // Non-fatal — will retry on next startup or when user re-opens app.
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        // Make the Isar instance available to all providers
        isarProvider.overrideWithValue(isar),
        // Make the SharedPreferences instance available to all providers
        sharedPreferencesProvider.overrideWithValue(prefs),
        // Restore saved toggle states (fall back to defaults if first launch)
        hijriEnabledProvider.overrideWith(
          (ref) => prefs.getBool(PrefsKeys.hijriEnabled) ?? true,
        ),
        udhiyaShowProvider.overrideWith(
          (ref) => prefs.getBool(PrefsKeys.udhiyaShow) ?? false,
        ),
        localeProvider.overrideWith(
          (ref) => Locale(prefs.getString(PrefsKeys.locale) ?? 'ar'),
        ),
        farmNameProvider.overrideWith(
          (ref) => prefs.getString(PrefsKeys.farmName) ?? '',
        ),
        farmLocationProvider.overrideWith(
          (ref) => prefs.getString(PrefsKeys.farmLocation) ?? '',
        ),
        onboardingDoneProvider.overrideWith(
          (ref) => prefs.getBool(PrefsKeys.onboardingDone) ?? false,
        ),
        preferredSpeciesProvider.overrideWith((ref) {
          final raw = prefs.getString(PrefsKeys.preferredSpecies) ?? '';
          return raw.isEmpty
              ? <String>[]
              : raw.split(',').where((s) => s.isNotEmpty).toList();
        }),
      ],
      child: const HerdIQApp(),
    ),
  );
}

class HerdIQApp extends ConsumerWidget {
  const HerdIQApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    // Keep SyncService alive for the app lifetime — it watches connectivity
    // and drains the offline queue whenever the device comes back online.
    ref.watch(syncServiceProvider);

    return MaterialApp.router(
      title: 'سلالة',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,

      // ── Localisation ────────────────────────────────────────────────────────
      locale: locale,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        AppL.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
