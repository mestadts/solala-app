// Udhiya (Sacrifice / أضحية) eligibility rules per species.
// Based on Islamic jurisprudence (majority opinion across madhabs).
// Eligibility is AUTO-COMPUTED from species + dateOfBirth + status.
// No new fields needed on MockAnimal — computed on-the-fly.
//
// Minimum age rules:
//   Sheep  (ضأن)  : 6 months  — جذع الضأن (Sharia exception for robust 6-month sheep)
//   Goat   (ماعز) : 12 months — 1 full year required
//   Cow    (بقر)  : 24 months — 2 full years required
//   Camel  (إبل)  : 60 months — 5 full years required
//   Horse          : Not eligible (default majority Islamic opinion)
//
// Additional condition: animal must be in an active/available status.
// Admin can adjust these rules per organization in Phase 15 (Firestore global/lists/udhiyaRules).

import '../constants/livestock_species.dart';
import '../constants/animal_status.dart';

/// Minimum age in months for Udhiya eligibility, by species.
/// -1 means the species is never eligible.
const Map<LivestockSpecies, int> udhiyaMinAgeMonths = {
  LivestockSpecies.sheep:  6,
  LivestockSpecies.goat:   12,
  LivestockSpecies.cow:    24,
  LivestockSpecies.camel:  60,
  LivestockSpecies.horse:  -1, // not eligible
};

/// Statuses that disqualify an animal from Udhiya.
const Set<AnimalStatus> _udhiyaIneligibleStatuses = {
  AnimalStatus.sold,
  AnimalStatus.deceased,
  AnimalStatus.missing,
  AnimalStatus.loaned,
  AnimalStatus.charity,
};

/// Returns true if the animal meets the basic Udhiya eligibility criteria.
/// Checks: (1) species is eligible, (2) age meets minimum, (3) status is valid.
bool isUdhiyaEligible({
  required LivestockSpecies species,
  required String dateOfBirth,   // ISO format YYYY-MM-DD
  required AnimalStatus status,
}) {
  // Horse is never eligible
  final minAge = udhiyaMinAgeMonths[species] ?? -1;
  if (minAge < 0) return false;

  // Status must be active/for_sale/reserved (not sold/deceased/missing/loaned/charity)
  if (_udhiyaIneligibleStatuses.contains(status)) return false;

  // Check age
  final dob = DateTime.tryParse(dateOfBirth);
  if (dob == null) return false;
  final now = DateTime.now();
  final ageMonths = (now.year - dob.year) * 12 + (now.month - dob.month);
  return ageMonths >= minAge;
}

/// Returns the age in months for a given date of birth string.
int ageInMonthsFromDob(String dateOfBirth) {
  final dob = DateTime.tryParse(dateOfBirth);
  if (dob == null) return 0;
  final now = DateTime.now();
  return ((now.year - dob.year) * 12 + (now.month - dob.month)).clamp(0, 9999);
}

/// Human-readable Udhiya eligibility requirement for display in UI.
/// Returns the minimum age string in Arabic.
String udhiyaMinAgeAr(LivestockSpecies species) {
  final months = udhiyaMinAgeMonths[species] ?? -1;
  if (months < 0) return 'غير مؤهل';
  if (months < 12) return '$months أشهر';
  final years = months ~/ 12;
  return '$years ${years == 1 ? 'سنة' : 'سنوات'}';
}

/// Human-readable Udhiya eligibility requirement in English.
String udhiyaMinAgeEn(LivestockSpecies species) {
  final months = udhiyaMinAgeMonths[species] ?? -1;
  if (months < 0) return 'Not eligible';
  if (months < 12) return '$months months';
  final years = months ~/ 12;
  return '$years ${years == 1 ? 'year' : 'years'}';
}
