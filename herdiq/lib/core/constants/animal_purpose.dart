// Animal purpose — top-level classification for every animal.
// Drives dashboard filters and reporting.
// Confirmed from Mqane: تربية (Breeding) | تسمين (Fattening)

enum AnimalPurpose { breeding, fattening }

extension AnimalPurposeX on AnimalPurpose {
  String get id {
    switch (this) {
      case AnimalPurpose.breeding:  return 'breeding';
      case AnimalPurpose.fattening: return 'fattening';
    }
  }

  String get nameAr {
    switch (this) {
      case AnimalPurpose.breeding:  return 'تربية';
      case AnimalPurpose.fattening: return 'تسمين';
    }
  }

  String get nameEn {
    switch (this) {
      case AnimalPurpose.breeding:  return 'Breeding';
      case AnimalPurpose.fattening: return 'Fattening';
    }
  }
}

AnimalPurpose? purposeFromId(String? id) {
  switch (id) {
    case 'breeding':  return AnimalPurpose.breeding;
    case 'fattening': return AnimalPurpose.fattening;
    default:          return null;
  }
}
