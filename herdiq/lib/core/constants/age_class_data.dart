// Traditional Arabic livestock age classification system.
// Breeders identify animals by these terms, not birth years.
// Auto-calculated from DOB but manually overridable.
// Admin-controlled in Phase 15 — hardcoded here for UI prototype.

class AgeClass {
  final String id;
  final String nameAr;
  final String nameEn;
  final int minMonths;  // inclusive lower bound
  final int maxMonths;  // inclusive upper bound, -1 = no limit

  const AgeClass({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.minMonths,
    required this.maxMonths,
  });
}

const List<AgeClass> ageClasses = [
  AgeClass(id: 'bahm',  nameAr: 'بهم',  nameEn: 'Bahm',   minMonths: 0,  maxMonths: 11),
  AgeClass(id: 'jadh',  nameAr: 'جذع',  nameEn: 'Jadh',   minMonths: 12, maxMonths: 23),
  AgeClass(id: 'thani', nameAr: 'ثني',  nameEn: 'Thani',  minMonths: 24, maxMonths: 35),
  AgeClass(id: 'rubaa', nameAr: 'رباع', nameEn: 'Rubaa',  minMonths: 36, maxMonths: 47),
  AgeClass(id: 'sudas', nameAr: 'سديس', nameEn: 'Sudas',  minMonths: 48, maxMonths: 59),
  AgeClass(id: 'tam',   nameAr: 'تام',  nameEn: 'Tam',    minMonths: 60, maxMonths: -1),
];

/// Auto-select age class based on age in months.
AgeClass ageClassFromMonths(int months) {
  for (final ac in ageClasses) {
    if (months >= ac.minMonths && (ac.maxMonths == -1 || months <= ac.maxMonths)) {
      return ac;
    }
  }
  return ageClasses.last;
}

/// Compute age class from date of birth string (yyyy-MM-dd).
AgeClass? ageClassFromDob(String? dob) {
  if (dob == null || dob.isEmpty) return null;
  try {
    final birth = DateTime.parse(dob);
    final now = DateTime.now();
    final months = (now.year - birth.year) * 12 + (now.month - birth.month);
    return ageClassFromMonths(months.clamp(0, 9999));
  } catch (_) {
    return null;
  }
}

AgeClass? ageClassById(String id) {
  try {
    return ageClasses.firstWhere((a) => a.id == id);
  } catch (_) {
    return null;
  }
}

/// Estimate a birth date (yyyy-MM-dd) from an age class.
/// Uses the midpoint of the range; unbounded classes use minMonths + 12.
String estimateDobFromAgeClass(AgeClass ac) {
  final midMonths = ac.maxMonths == -1
      ? ac.minMonths + 12
      : (ac.minMonths + ac.maxMonths) ~/ 2;
  final estimated = DateTime.now().subtract(
    Duration(days: (midMonths * 30.44).round()),
  );
  return '${estimated.year.toString().padLeft(4, '0')}-'
      '${estimated.month.toString().padLeft(2, '0')}-'
      '${estimated.day.toString().padLeft(2, '0')}';
}
