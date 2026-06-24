import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/livestock_species.dart';
import '../providers/firebase_provider.dart';

typedef SpeciesTermsMap = Map<String, Map<String, String>>;

/// Default (hardcoded) gender terms — used as fallback when Firestore
/// is unavailable or the document has no overrides.
/// Horse has extra young-animal keys: maleYoungAr/femaleYoungAr/maleYoungEn/femaleYoungEn
const defaultSpeciesTerms = <String, Map<String, String>>{
  'sheep': {'maleAr': 'طلي',   'femaleAr': 'رخلة',  'maleEn': 'Ram',        'femaleEn': 'Ewe'},
  'goat':  {'maleAr': 'تيس',   'femaleAr': 'عنزة',  'maleEn': 'Buck',       'femaleEn': 'Doe'},
  'camel': {'maleAr': 'جمل',   'femaleAr': 'ناقة',  'maleEn': 'Bull Camel', 'femaleEn': 'Cow Camel'},
  'cow':   {'maleAr': 'ثور',   'femaleAr': 'بقرة',  'maleEn': 'Bull',       'femaleEn': 'Cow'},
  'horse': {
    'maleAr': 'حصان',   'femaleAr': 'فرس',    'maleEn': 'Stallion',   'femaleEn': 'Mare',
    'maleYoungAr': 'مهر', 'femaleYoungAr': 'مهرة', 'maleYoungEn': 'Foal', 'femaleYoungEn': 'Filly',
    'matingAr': 'تشبيه', 'heatAr': 'شياع',
  },
};

/// Streams configurable species gender terms from Firestore
/// (`global/speciesTerms`). Falls back to [defaultSpeciesTerms] on error
/// or when the document is absent.
final speciesTermsProvider = StreamProvider<SpeciesTermsMap>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('global')
      .doc('speciesTerms')
      .snapshots()
      .map((snap) {
    // Start with a deep-copy of defaults
    final result = <String, Map<String, String>>{
      for (final e in defaultSpeciesTerms.entries)
        e.key: Map<String, String>.from(e.value),
    };
    if (!snap.exists || snap.data() == null) return result;
    final data = snap.data()!;
    for (final species in LivestockSpecies.values) {
      final overrides = data[species.name];
      if (overrides is! Map) continue;
      final defaults = result[species.name]!;
      result[species.name] = {
        for (final key in defaults.keys)
          key: (overrides[key] as String?) ?? defaults[key]!,
      };
    }
    return result;
  });
});

/// Resolves the locale-appropriate gender term, preferring Firestore overrides.
/// For horses, uses young terms (مهر/مهرة) if DOB indicates age < 1 year.
String resolveGenderTerm(
    LivestockSpecies species, String gender, bool isAr, SpeciesTermsMap terms,
    {String? dateOfBirth}) {
  final st = terms[species.name];
  if (st == null) return species.genderTerm(gender, isAr);

  // Horse age-aware: use young terms for animals under 1 year old
  if (species == LivestockSpecies.horse && dateOfBirth != null && dateOfBirth.isNotEmpty) {
    final dob = DateTime.tryParse(dateOfBirth);
    if (dob != null && DateTime.now().difference(dob).inDays < 365) {
      if (gender == 'male') {
        return isAr
            ? (st['maleYoungAr'] ?? st['maleAr'] ?? species.maleTermAr)
            : (st['maleYoungEn'] ?? st['maleEn'] ?? species.maleTermEn);
      }
      return isAr
          ? (st['femaleYoungAr'] ?? st['femaleAr'] ?? species.femaleTermAr)
          : (st['femaleYoungEn'] ?? st['femaleEn'] ?? species.femaleTermEn);
    }
  }

  if (gender == 'male') {
    return isAr
        ? (st['maleAr'] ?? species.maleTermAr)
        : (st['maleEn'] ?? species.maleTermEn);
  }
  return isAr
      ? (st['femaleAr'] ?? species.femaleTermAr)
      : (st['femaleEn'] ?? species.femaleTermEn);
}

/// Returns the breeding-specific term for horses (تشبيه / Mating).
String horseMatingTerm(bool isAr, SpeciesTermsMap terms) {
  final st = terms['horse'];
  return isAr ? (st?['matingAr'] ?? 'تشبيه') : 'Mating (Tashbeeh)';
}

/// Returns the heat term for horses (شياع / In Heat).
String horseHeatTerm(bool isAr, SpeciesTermsMap terms) {
  final st = terms['horse'];
  return isAr ? (st?['heatAr'] ?? 'شياع') : 'In Heat (Shiyaa\')';
}
