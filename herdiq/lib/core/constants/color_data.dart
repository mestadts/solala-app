import 'package:flutter/material.dart';
import 'livestock_species.dart';

class AnimalColor {
  final String id;
  final String nameAr;
  final String nameEn;
  final Color swatch;
  const AnimalColor({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.swatch,
  });
}

/// 16 general animal colors (sheep, goat, camel, cow).
const List<AnimalColor> animalColors = [
  AnimalColor(id: 'red',          nameAr: 'احمر',          nameEn: 'Red',          swatch: Color(0xFFFF3B30)),
  AnimalColor(id: 'yellow',       nameAr: 'اصفر',          nameEn: 'Yellow',       swatch: Color(0xFFFFD60A)),
  AnimalColor(id: 'blue',         nameAr: 'ازرق',          nameEn: 'Blue',         swatch: Color(0xFF00C7BE)),
  AnimalColor(id: 'white',        nameAr: 'ابيض',          nameEn: 'White',        swatch: Color(0xFFF5F5F5)),
  AnimalColor(id: 'green',        nameAr: 'اخضر',          nameEn: 'Green',        swatch: Color(0xFF30D158)),
  AnimalColor(id: 'orange',       nameAr: 'برتقالي',       nameEn: 'Orange',       swatch: Color(0xFFFF9F0A)),
  AnimalColor(id: 'purple',       nameAr: 'بنفسجي',        nameEn: 'Purple',       swatch: Color(0xFFBF5AF2)),
  AnimalColor(id: 'pink',         nameAr: 'وردي',          nameEn: 'Pink',         swatch: Color(0xFFFF375F)),
  AnimalColor(id: 'black',        nameAr: 'اسود',          nameEn: 'Black',        swatch: Color(0xFF1C1C1E)),
  AnimalColor(id: 'grey',         nameAr: 'رمادي',         nameEn: 'Grey',         swatch: Color(0xFF8E8E93)),
  AnimalColor(id: 'light_pink',   nameAr: 'وردي فاتح',     nameEn: 'Light Pink',   swatch: Color(0xFFFFB3C6)),
  AnimalColor(id: 'light_red',    nameAr: 'احمر فاتح',     nameEn: 'Light Red',    swatch: Color(0xFFFF6B6B)),
  AnimalColor(id: 'light_purple', nameAr: 'بنفسجي فاتح',   nameEn: 'Light Purple', swatch: Color(0xFFDDA0DD)),
  AnimalColor(id: 'light_green',  nameAr: 'اخضر فاتح',     nameEn: 'Light Green',  swatch: Color(0xFF90EE90)),
  AnimalColor(id: 'apple',        nameAr: 'تفاحي',         nameEn: 'Apple Green',  swatch: Color(0xFFBFFF00)),
  AnimalColor(id: 'light_blue',   nameAr: 'ازرق فاتح',     nameEn: 'Light Blue',   swatch: Color(0xFFAEF0F0)),
];

/// 12 traditional Arabic horse coat colors.
const List<AnimalColor> horseColors = [
  AnimalColor(id: 'horse_ashqar',       nameAr: 'الأشقر',              nameEn: 'Chestnut',         swatch: Color(0xFFC0622F)),
  AnimalColor(id: 'horse_ahmar',        nameAr: 'الأحمر',              nameEn: 'Bay',              swatch: Color(0xFF8B3A2A)),
  AnimalColor(id: 'horse_adham',        nameAr: 'الأدهم',              nameEn: 'Black',            swatch: Color(0xFF1C1C1E)),
  AnimalColor(id: 'horse_asfar',        nameAr: 'الأصفر',              nameEn: 'Gray/White',       swatch: Color(0xFFE8E4D9)),
  AnimalColor(id: 'horse_ashqar_muzahab', nameAr: 'الأشقر المذهب',     nameEn: 'Palomino',         swatch: Color(0xFFD4A017)),
  AnimalColor(id: 'horse_kumayt',       nameAr: 'الكميت',              nameEn: 'Dark Bay',         swatch: Color(0xFF4A1C0A)),
  AnimalColor(id: 'horse_azraq',        nameAr: 'الأزرق',              nameEn: 'Blue Roan',        swatch: Color(0xFF7A8C9A)),
  AnimalColor(id: 'horse_asfar_marshoush', nameAr: 'الأصفر المرشوش',   nameEn: 'Dapple Gray',      swatch: Color(0xFFB0B8B8)),
  AnimalColor(id: 'horse_ashqar_mahrouq', nameAr: 'الأشقر المحروق',    nameEn: 'Dark Chestnut',    swatch: Color(0xFF7B3A1E)),
  AnimalColor(id: 'horse_ahmar_ward',   nameAr: 'الأحمر ورد',          nameEn: 'Rose Bay',         swatch: Color(0xFFB5664E)),
  AnimalColor(id: 'horse_ablaq',        nameAr: 'الأبلق',              nameEn: 'Piebald',          swatch: Color(0xFFAAAAAA)),
  AnimalColor(id: 'horse_asha3al',      nameAr: 'الأشعل',              nameEn: 'Flea-bitten Gray', swatch: Color(0xFF9E9E9E)),
];

/// Returns the appropriate color palette for a species.
/// Horses get horse-specific coat colors; all others get the general palette.
List<AnimalColor> colorsForSpecies(LivestockSpecies? species) {
  if (species == LivestockSpecies.horse) return horseColors;
  return animalColors;
}

AnimalColor? colorById(String id) {
  final allColors = [...animalColors, ...horseColors];
  try {
    return allColors.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
}
