import '../constants/animal_purpose.dart';

/// Passed via GoRouter `extra` when navigating to [AnimalsListPage]
/// from a dashboard category shortcut.
class AnimalFilterExtra {
  final String? gender;       // 'Male' | 'Female'
  final String? status;       // AnimalStatus.name e.g. 'deceased'
  final String? ageClassId;   // 'bahm' | 'jadh' | 'thani' | 'rubaa' | 'sudas' | 'tam'
  final AnimalPurpose? purpose;
  final bool udhiyaOnly;

  const AnimalFilterExtra({
    this.gender,
    this.status,
    this.ageClassId,
    this.purpose,
    this.udhiyaOnly = false,
  });
}
