// Comprehensive breed lists confirmed from Mqane app screenshots.
// Admin-controlled in Phase 15 (Firestore global/lists/breeds).
// Hardcoded here for UI prototype phases 0–7.
// Users can add custom breeds per org ("اضافة نوع جديد").

import 'livestock_species.dart';

class BreedEntry {
  final String id;
  final String nameAr;
  final String nameEn;
  const BreedEntry({required this.id, required this.nameAr, required this.nameEn});
}

const Map<LivestockSpecies, List<BreedEntry>> breedsBySpecies = {

  // ── Sheep (أغنام) ─────────────────────────────────────────────────────────
  LivestockSpecies.sheep: [
    BreedEntry(id: 'sh_najdi',       nameAr: 'نجدي',         nameEn: 'Najdi'),
    BreedEntry(id: 'sh_harri',       nameAr: 'حري',          nameEn: 'Harri'),
    BreedEntry(id: 'sh_naeimi',      nameAr: 'نعيمي',        nameEn: 'Naeimi'),
    BreedEntry(id: 'sh_aradi',       nameAr: 'عارضي',        nameEn: 'Aradi'),
    BreedEntry(id: 'sh_gazel',       nameAr: 'غزال',         nameEn: 'Gazel'),
    BreedEntry(id: 'sh_sardi',       nameAr: 'صردي',         nameEn: 'Sardi'),
    BreedEntry(id: 'sh_awlad_jalal', nameAr: 'اولاد جلال',   nameEn: 'Awlad Jalal'),
    BreedEntry(id: 'sh_awlad_nayel', nameAr: 'اولاد نايل',   nameEn: 'Awlad Nayel'),
    BreedEntry(id: 'sh_dhan_samaa',  nameAr: 'ضان صمع',      nameEn: 'Dhan Samaa'),
    BreedEntry(id: 'sh_rakhm',       nameAr: 'رخم',          nameEn: 'Rakhm'),
    BreedEntry(id: 'sh_ayni',        nameAr: 'عيني',         nameEn: 'Ayni'),
    BreedEntry(id: 'sh_khaliji',     nameAr: 'خليجي',        nameEn: 'Khaliji'),
    BreedEntry(id: 'sh_hejazi',      nameAr: 'حجازي',        nameEn: 'Hejazi'),
    BreedEntry(id: 'sh_hijeen',      nameAr: 'هجين',         nameEn: 'Hijeen'),
    BreedEntry(id: 'sh_other',       nameAr: 'أخرى',         nameEn: 'Other'),
  ],

  // ── Goat (ماعز) ───────────────────────────────────────────────────────────
  // Breeds confirmed from Mqane screenshot breed picker
  LivestockSpecies.goat: [
    BreedEntry(id: 'gt_bishi',       nameAr: 'ماعز بيشي',    nameEn: 'Bishi Goat'),
    BreedEntry(id: 'gt_shami',       nameAr: 'شامي',         nameEn: 'Shami'),
    BreedEntry(id: 'gt_salali',      nameAr: 'صلالي',        nameEn: 'Salali'),
    BreedEntry(id: 'gt_arab',        nameAr: 'عرب',          nameEn: 'Arab'),
    BreedEntry(id: 'gt_aradi',       nameAr: 'عارضي',        nameEn: 'Aradi'),
    BreedEntry(id: 'gt_souri',       nameAr: 'معزا سوري',    nameEn: 'Syrian Goat'),
    BreedEntry(id: 'gt_suakin',      nameAr: 'سواكن',        nameEn: 'Suakin'),
    BreedEntry(id: 'gt_naeimi',      nameAr: 'نعيمي',        nameEn: 'Naeimi'),
    BreedEntry(id: 'gt_harri',       nameAr: 'حري',          nameEn: 'Harri'),
    BreedEntry(id: 'gt_najdi',       nameAr: 'نجدي',         nameEn: 'Najdi'),
    BreedEntry(id: 'gt_masri',       nameAr: 'معزا مصرية',   nameEn: 'Egyptian Goat'),
    BreedEntry(id: 'gt_mutawwar',    nameAr: 'ماعز مطور',    nameEn: 'Improved Goat'),
    BreedEntry(id: 'gt_habasi',      nameAr: 'حباصي',        nameEn: 'Habasi'),
    BreedEntry(id: 'gt_rufaidi',     nameAr: 'رفيدي',        nameEn: 'Rufaidi'),
    BreedEntry(id: 'gt_daman',       nameAr: 'دمان',         nameEn: 'Daman'),
    BreedEntry(id: 'gt_abin',        nameAr: 'البين',        nameEn: 'Al-Bin'),
    BreedEntry(id: 'gt_saneen',      nameAr: 'سانين',        nameEn: 'Saneen'),
    BreedEntry(id: 'gt_mursiano',    nameAr: 'مورسيانو',     nameEn: 'Murciano'),
    BreedEntry(id: 'gt_qobrosi',     nameAr: 'قبرصي',        nameEn: 'Cypriot'),
    BreedEntry(id: 'gt_najd_dagham', nameAr: 'نجد دغم',      nameEn: 'Najd Dagham'),
    BreedEntry(id: 'gt_rahi',        nameAr: 'ماعز رحي',     nameEn: 'Rahi Goat'),
    BreedEntry(id: 'gt_other',       nameAr: 'أخرى',         nameEn: 'Other'),
  ],

  // ── Camel (إبل) ───────────────────────────────────────────────────────────
  LivestockSpecies.camel: [
    BreedEntry(id: 'cm_majaheem',    nameAr: 'مجاهيم',       nameEn: 'Majaheem'),
    BreedEntry(id: 'cm_waddah',      nameAr: 'وضّاح',        nameEn: 'Waddah'),
    BreedEntry(id: 'cm_hamra',       nameAr: 'حمراء',        nameEn: 'Hamra'),
    BreedEntry(id: 'cm_zarga',       nameAr: 'زرقاء',        nameEn: 'Zarga'),
    BreedEntry(id: 'cm_sufr',        nameAr: 'صفر',          nameEn: 'Sufr'),
    BreedEntry(id: 'cm_shaal',       nameAr: 'شعل',          nameEn: 'Shaal'),
    BreedEntry(id: 'cm_omani',       nameAr: 'عماني',        nameEn: 'Omani'),
    BreedEntry(id: 'cm_other',       nameAr: 'أخرى',         nameEn: 'Other'),
  ],

  // ── Cow (أبقار) ───────────────────────────────────────────────────────────
  LivestockSpecies.cow: [
    BreedEntry(id: 'cw_friesian',    nameAr: 'فريزيان',      nameEn: 'Friesian'),
    BreedEntry(id: 'cw_angus',       nameAr: 'أنجوس',        nameEn: 'Angus'),
    BreedEntry(id: 'cw_limousin',    nameAr: 'ليموزين',      nameEn: 'Limousin'),
    BreedEntry(id: 'cw_hereford',    nameAr: 'هيرفورد',      nameEn: 'Hereford'),
    BreedEntry(id: 'cw_local',       nameAr: 'محلي',         nameEn: 'Local'),
    BreedEntry(id: 'cw_other',       nameAr: 'أخرى',         nameEn: 'Other'),
  ],

  // ── Horse (خيول) ──────────────────────────────────────────────────────────
  LivestockSpecies.horse: [
    BreedEntry(id: 'hr_arabian',     nameAr: 'عربي أصيل',    nameEn: 'Arabian'),
    BreedEntry(id: 'hr_thorough',    nameAr: 'ثوروبريد',     nameEn: 'Thoroughbred'),
    BreedEntry(id: 'hr_barb',        nameAr: 'بربري',        nameEn: 'Barb'),
    BreedEntry(id: 'hr_warmblood',   nameAr: 'وارم بلود',    nameEn: 'Warmblood'),
    BreedEntry(id: 'hr_quarter',     nameAr: 'كوارتر هورس',  nameEn: 'Quarter Horse'),
    BreedEntry(id: 'hr_other',       nameAr: 'أخرى',         nameEn: 'Other'),
  ],
};

List<BreedEntry> breedsFor(LivestockSpecies species) =>
    breedsBySpecies[species] ?? [];

BreedEntry? breedById(LivestockSpecies species, String id) {
  try {
    return breedsFor(species).firstWhere((b) => b.id == id);
  } catch (_) {
    return null;
  }
}
