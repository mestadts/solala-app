enum AlertType { vaccination, deworming, treatment, birthExpected, weaningDue }

enum AlertSeverity { info, warning, critical }

class AppAlert {
  final String id;
  final AlertType type;
  final String animalId;
  final String animalDisplay; // e.g. "12 بني"
  final String titleAr;
  final String titleEn;
  final String bodyAr;
  final String bodyEn;
  final DateTime? dueDate;
  final int daysUntilDue; // negative = overdue
  final AlertSeverity severity;

  const AppAlert({
    required this.id,
    required this.type,
    required this.animalId,
    required this.animalDisplay,
    required this.titleAr,
    required this.titleEn,
    required this.bodyAr,
    required this.bodyEn,
    this.dueDate,
    required this.daysUntilDue,
    required this.severity,
  });
}
