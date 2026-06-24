// Extended animal status — confirmed from Mqane screenshots + HerdIQ competitive analysis.
// Mqane statuses: نشط | ذبح | صدقة | عارية
// HerdIQ extends to 8 statuses for richer lifecycle tracking.
// Admin-controlled labels in Phase 15 — hardcoded here for UI prototype.

import 'package:flutter/material.dart';
import 'livestock_species.dart';

enum AnimalStatus {
  active,    // نشط     — normal, in herd
  forSale,   // للبيع   — listed for sale
  reserved,  // محجوز   — reserved/hold
  charity,   // صدقة    — given as charity
  loaned,    // معار    — temporarily loaned out
  sold,      // مباع    — sold and transferred
  deceased,  // نافق    — died
  missing,   // مفقود   — cannot be located
  injured,   // مصاب    — horse: injured
  inHeat,    // شياع    — horse: mare in heat (requesting mating)
}

extension AnimalStatusX on AnimalStatus {
  String get id {
    switch (this) {
      case AnimalStatus.active:   return 'active';
      case AnimalStatus.forSale:  return 'for_sale';
      case AnimalStatus.reserved: return 'reserved';
      case AnimalStatus.charity:  return 'charity';
      case AnimalStatus.loaned:   return 'loaned';
      case AnimalStatus.sold:     return 'sold';
      case AnimalStatus.deceased: return 'deceased';
      case AnimalStatus.missing:  return 'missing';
      case AnimalStatus.injured:  return 'injured';
      case AnimalStatus.inHeat:   return 'in_heat';
    }
  }

  String get nameAr {
    switch (this) {
      case AnimalStatus.active:   return 'نشط';
      case AnimalStatus.forSale:  return 'للبيع';
      case AnimalStatus.reserved: return 'محجوز';
      case AnimalStatus.charity:  return 'صدقة';
      case AnimalStatus.loaned:   return 'معار';
      case AnimalStatus.sold:     return 'مباع';
      case AnimalStatus.deceased: return 'نافق';
      case AnimalStatus.missing:  return 'مفقود';
      case AnimalStatus.injured:  return 'مصاب';
      case AnimalStatus.inHeat:   return 'شياع';
    }
  }

  String get nameEn {
    switch (this) {
      case AnimalStatus.active:   return 'Active';
      case AnimalStatus.forSale:  return 'For Sale';
      case AnimalStatus.reserved: return 'Reserved';
      case AnimalStatus.charity:  return 'Charity';
      case AnimalStatus.loaned:   return 'Loaned';
      case AnimalStatus.sold:     return 'Sold';
      case AnimalStatus.deceased: return 'Deceased';
      case AnimalStatus.missing:  return 'Missing';
      case AnimalStatus.injured:  return 'Injured';
      case AnimalStatus.inHeat:   return 'In Heat';
    }
  }

  Color get color {
    switch (this) {
      case AnimalStatus.active:   return const Color(0xFF4CAF50); // green
      case AnimalStatus.forSale:  return const Color(0xFF2196F3); // blue
      case AnimalStatus.reserved: return const Color(0xFFFF9800); // orange
      case AnimalStatus.charity:  return const Color(0xFF9C27B0); // purple
      case AnimalStatus.loaned:   return const Color(0xFF00BCD4); // cyan
      case AnimalStatus.sold:     return const Color(0xFF795548); // brown
      case AnimalStatus.deceased: return const Color(0xFF9E9E9E); // grey
      case AnimalStatus.missing:  return const Color(0xFFE53935); // red
      case AnimalStatus.injured:  return const Color(0xFFFF5722); // deep orange
      case AnimalStatus.inHeat:   return const Color(0xFFE91E8C); // pink
    }
  }

  /// Whether this status means the animal is no longer in active herd.
  bool get isInactive =>
      this == AnimalStatus.sold ||
      this == AnimalStatus.deceased ||
      this == AnimalStatus.missing;

  /// Whether this status is horse-specific.
  bool get isHorseOnly =>
      this == AnimalStatus.injured || this == AnimalStatus.inHeat;
}

AnimalStatus? animalStatusFromId(String? id) {
  for (final s in AnimalStatus.values) {
    if (s.id == id) return s;
  }
  return null;
}

/// All statuses available for selection in UI dropdowns/filters.
const List<AnimalStatus> allAnimalStatuses = AnimalStatus.values;

/// Returns the statuses applicable to a given species.
/// Horse-only statuses (injured, inHeat) are excluded for other species.
List<AnimalStatus> statusesForSpecies(LivestockSpecies? species) {
  if (species == LivestockSpecies.horse) return AnimalStatus.values;
  return AnimalStatus.values.where((s) => !s.isHorseOnly).toList();
}
