import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum LivestockSpecies {
  sheep,
  goat,
  camel,
  cow,
  horse,
}

extension LivestockSpeciesX on LivestockSpecies {
  String get displayName {
    switch (this) {
      case LivestockSpecies.sheep: return 'Sheep';
      case LivestockSpecies.goat:  return 'Goat';
      case LivestockSpecies.camel: return 'Camel';
      case LivestockSpecies.cow:   return 'Cow';
      case LivestockSpecies.horse: return 'Horse';
    }
  }

  String get nameAr {
    switch (this) {
      case LivestockSpecies.sheep: return 'أغنام';
      case LivestockSpecies.goat:  return 'ماعز';
      case LivestockSpecies.camel: return 'إبل';
      case LivestockSpecies.cow:   return 'أبقار';
      case LivestockSpecies.horse: return 'خيول';
    }
  }

  /// 2-letter prefix for the short animal ID format (e.g. SH-26-1)
  String get idPrefix {
    switch (this) {
      case LivestockSpecies.sheep: return 'SH';
      case LivestockSpecies.goat:  return 'GT';
      case LivestockSpecies.camel: return 'CM';
      case LivestockSpecies.cow:   return 'CW';
      case LivestockSpecies.horse: return 'HR';
    }
  }

  String get maleTermAr {
    switch (this) {
      case LivestockSpecies.sheep: return 'طلي';
      case LivestockSpecies.goat:  return 'تيس';
      case LivestockSpecies.camel: return 'جمل';
      case LivestockSpecies.cow:   return 'ثور';
      case LivestockSpecies.horse: return 'حصان';
    }
  }

  String get femaleTermAr {
    switch (this) {
      case LivestockSpecies.sheep: return 'رخلة';
      case LivestockSpecies.goat:  return 'عنزة';
      case LivestockSpecies.camel: return 'ناقة';
      case LivestockSpecies.cow:   return 'بقرة';
      case LivestockSpecies.horse: return 'فرسة';
    }
  }

  String get maleTermEn {
    switch (this) {
      case LivestockSpecies.sheep: return 'Ram';
      case LivestockSpecies.goat:  return 'Buck';
      case LivestockSpecies.camel: return 'Bull Camel';
      case LivestockSpecies.cow:   return 'Bull';
      case LivestockSpecies.horse: return 'Stallion';
    }
  }

  String get femaleTermEn {
    switch (this) {
      case LivestockSpecies.sheep: return 'Ewe';
      case LivestockSpecies.goat:  return 'Doe';
      case LivestockSpecies.camel: return 'Cow Camel';
      case LivestockSpecies.cow:   return 'Cow';
      case LivestockSpecies.horse: return 'Mare';
    }
  }

  /// Returns the locale-appropriate species-specific gender term
  String genderTerm(String gender, bool isAr) {
    if (gender == 'male') return isAr ? maleTermAr : maleTermEn;
    return isAr ? femaleTermAr : femaleTermEn;
  }

  Color get color {
    switch (this) {
      case LivestockSpecies.sheep: return AppColors.sheep;
      case LivestockSpecies.goat:  return AppColors.goat;
      case LivestockSpecies.camel: return AppColors.camel;
      case LivestockSpecies.cow:   return AppColors.cow;
      case LivestockSpecies.horse: return AppColors.horse;
    }
  }

  IconData get icon {
    switch (this) {
      case LivestockSpecies.sheep: return Icons.cruelty_free;
      case LivestockSpecies.goat:  return Icons.cruelty_free;
      case LivestockSpecies.camel: return Icons.cruelty_free;
      case LivestockSpecies.cow:   return Icons.cruelty_free;
      case LivestockSpecies.horse: return Icons.cruelty_free;
    }
  }

  String get emoji {
    switch (this) {
      case LivestockSpecies.sheep: return '🐑';
      case LivestockSpecies.goat:  return '🐐';
      case LivestockSpecies.camel: return '🐪';
      case LivestockSpecies.cow:   return '🐄';
      case LivestockSpecies.horse: return '🐴';
    }
  }
}
