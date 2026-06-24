import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the [SharedPreferences] instance.
/// Overridden in [main] with the awaited singleton before [runApp].
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('SharedPreferences not yet initialised'),
);

// ── Preference keys ────────────────────────────────────────────────────────────

abstract class PrefsKeys {
  static const hijriEnabled    = 'hijri_enabled';
  static const udhiyaShow      = 'udhiya_show';
  static const locale          = 'locale';
  static const farmName        = 'farm_name';
  static const farmLocation    = 'farm_location';
  static const onboardingDone  = 'onboarding_done';
  /// UID of the user whose farm data is stored. Used to detect user switches
  /// so stale data from a previous account is cleared on login.
  static const currentUserUid  = 'current_user_uid';
  /// Comma-separated list of preferred species names (e.g. "sheep,goat").
  static const preferredSpecies = 'preferred_species';
}

// ── Farm identity providers ────────────────────────────────────────────────────

/// Farm name entered during onboarding, displayed on the dashboard.
final farmNameProvider = StateProvider<String>((ref) => '');

/// Farm location entered during onboarding, displayed on the dashboard.
final farmLocationProvider = StateProvider<String>((ref) => '');

/// Whether the user has completed onboarding. Persisted to SharedPreferences
/// so the splash screen skips onboarding on subsequent launches.
final onboardingDoneProvider = StateProvider<bool>((ref) => false);

/// Preferred species selected during onboarding.
/// Empty list means all species are shown (no filter).
final preferredSpeciesProvider = StateProvider<List<String>>((ref) => []);
