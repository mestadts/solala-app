import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/prefs_provider.dart';

// ── Country Template model ────────────────────────────────────────────────────
//
// Stored in Firestore: global/lists/countryTemplates/{countryId}
// Managed in admin panel CountriesPage.
// Defines which fields are REQUIRED for animal registration in each country.

class CountryTemplate {
  final String id;           // e.g. 'SA', 'AE', 'EU', 'US'
  final String nameEn;
  final String nameAr;
  final List<String> requiredFields; // field names: 'officialTagNumber', 'breed', 'dateOfBirth', etc.
  final String notes;

  const CountryTemplate({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.requiredFields = const [],
    this.notes = '',
  });

  factory CountryTemplate.fromFirestore(String id, Map<String, dynamic> data) {
    return CountryTemplate(
      id: id,
      nameEn: data['nameEn'] as String? ?? id,
      nameAr: data['nameAr'] as String? ?? id,
      requiredFields: List<String>.from(data['requiredFields'] as List? ?? []),
      notes: data['notes'] as String? ?? '',
    );
  }

  bool isRequired(String fieldName) => requiredFields.contains(fieldName);
}

// ── Provider ──────────────────────────────────────────────────────────────────

/// The country template for the current organization's country.
/// Returns null if no template is defined for the country (all fields optional).
final countryTemplateProvider = FutureProvider<CountryTemplate?>((ref) async {
  final prefs = ref.watch(sharedPreferencesProvider);
  // Country is stored in prefs by org_setup_page
  final country = prefs.getString(PrefsKeys.farmLocation) ?? '';
  if (country.isEmpty) return null;

  final firestore = ref.watch(firestoreProvider);
  try {
    final snap = await firestore
        .collection('global')
        .doc('lists')
        .collection('countryTemplates')
        .get();

    // Match by country name or code (case-insensitive)
    final countryLower = country.toLowerCase();
    for (final doc in snap.docs) {
      final data = doc.data();
      final nameEn = (data['nameEn'] as String? ?? '').toLowerCase();
      final nameAr = (data['nameAr'] as String? ?? '').toLowerCase();
      if (nameEn.contains(countryLower) || countryLower.contains(nameEn) ||
          nameAr.contains(countryLower) || doc.id.toLowerCase() == countryLower) {
        return CountryTemplate.fromFirestore(doc.id, data);
      }
    }
    return null;
  } catch (_) {
    return null;
  }
});

/// Quick boolean: is a given field required by country template?
/// Returns false if template not loaded or field not in requirements.
final isFieldRequiredProvider =
    Provider.family<bool, String>((ref, fieldName) {
  return ref.watch(countryTemplateProvider).whenOrNull(
        data: (t) => t?.isRequired(fieldName) ?? false,
      ) ??
      false;
});
