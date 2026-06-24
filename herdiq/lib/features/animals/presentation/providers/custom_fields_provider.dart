import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_provider.dart';

// ── Custom field model ────────────────────────────────────────────────────────

enum CustomFieldType { text, number, select, boolean }

class CustomFieldDef {
  final String id;
  final String nameAr;
  final String nameEn;
  final CustomFieldType fieldType;
  final List<String> options;
  final List<String>? species; // null = all species
  final bool required;
  final bool isArchived;
  final int order;

  const CustomFieldDef({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.fieldType,
    this.options = const [],
    this.species,
    this.required = false,
    this.isArchived = false,
    this.order = 0,
  });

  factory CustomFieldDef.fromFirestore(String id, Map<String, dynamic> data) {
    return CustomFieldDef(
      id: id,
      nameAr: data['nameAr'] as String? ?? '',
      nameEn: data['nameEn'] as String? ?? '',
      fieldType: _parseType(data['fieldType'] as String? ?? 'text'),
      options: List<String>.from(data['options'] as List? ?? []),
      species: data['species'] == null
          ? null
          : List<String>.from(data['species'] as List),
      required: data['required'] as bool? ?? false,
      isArchived: data['isArchived'] as bool? ?? false,
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }

  static CustomFieldType _parseType(String v) {
    switch (v) {
      case 'number':  return CustomFieldType.number;
      case 'select':  return CustomFieldType.select;
      case 'boolean': return CustomFieldType.boolean;
      default:        return CustomFieldType.text;
    }
  }

  String label(String languageCode) =>
      languageCode == 'ar' ? nameAr : nameEn;
}

// ── Provider ──────────────────────────────────────────────────────────────────

/// Streams all active custom fields from Firestore global/lists/customFields.
/// Falls back to empty list on error (e.g. no internet, no permission).
final customFieldsProvider = StreamProvider<List<CustomFieldDef>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('global')
      .doc('lists')
      .collection('customFields')
      .orderBy('order')
      .snapshots()
      .map((snap) => snap.docs
          .map((d) => CustomFieldDef.fromFirestore(d.id, d.data()))
          .where((f) => !f.isArchived)
          .toList())
      .handleError((_) => <CustomFieldDef>[]);
});

/// Filtered custom fields for a given species name (e.g. 'sheep').
final customFieldsForSpeciesProvider =
    Provider.family<List<CustomFieldDef>, String>((ref, species) {
  final all = ref.watch(customFieldsProvider).valueOrNull ?? [];
  return all
      .where((f) => f.species == null || f.species!.contains(species))
      .toList();
});
