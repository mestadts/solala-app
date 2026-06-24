// date_format_provider.dart
// Global feature-flag providers for:
//   • Hijri calendar toggle (ON by default for SA/GCC breeders)
//   • Udhiya eligibility indicator toggle (OFF by default, enabled for Eid season)
//
// Both are simple StateProviders so any widget can watch/mutate them.
// Persistence to SharedPreferences is wired in Phase 7.5 Settings screen.

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether to display dates in Hijri format.
/// Default: true — Saudi/GCC breeders use Hijri as the primary calendar.
final hijriEnabledProvider = StateProvider<bool>((ref) => true);

/// Whether to show the Udhiya (أضحية) eligibility indicator on animal cards
/// and the "الأضحية" shortcut on the dashboard.
/// Default: false — breeders activate for Eid al-Adha season.
final udhiyaShowProvider = StateProvider<bool>((ref) => false);
