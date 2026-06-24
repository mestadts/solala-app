import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/color_data.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../../../breeding/presentation/providers/breeding_provider.dart';
import '../../../health/presentation/providers/health_provider.dart';
import '../../domain/app_alert.dart';

// ── Helpers ────────────────────────────────────────────────────────────────────

String _animalDisplay(MockAnimal a) {
  final c = colorById(a.colorId);
  final colorAr = c?.nameAr ?? '';
  return '${a.tagNumber} $colorAr'.trim();
}

String _daysBodyAr(int days, String detail) {
  if (days < 0) return 'متأخر ${-days} يوم${detail.isNotEmpty ? ' — $detail' : ''}';
  if (days == 0) return 'اليوم${detail.isNotEmpty ? ' — $detail' : ''}';
  return 'بعد $days يوم${detail.isNotEmpty ? ' — $detail' : ''}';
}

String _daysBodyEn(int days, String detail) {
  if (days < 0) return '${-days}d overdue${detail.isNotEmpty ? ' — $detail' : ''}';
  if (days == 0) return 'Today${detail.isNotEmpty ? ' — $detail' : ''}';
  return 'In ${days}d${detail.isNotEmpty ? ' — $detail' : ''}';
}

AlertSeverity _severity(int days) {
  if (days < 0) return AlertSeverity.critical;
  if (days <= 2) return AlertSeverity.warning;
  return AlertSeverity.info;
}

// ── Main provider ──────────────────────────────────────────────────────────────

/// Computes all current alerts from existing animal, health, and breeding data.
/// No additional storage required — derived purely from live streams.
final notificationsProvider = Provider<List<AppAlert>>((ref) {
  final animals  = ref.watch(animalsStreamProvider).valueOrNull ?? [];
  final health   = ref.watch(allHealthStreamProvider).valueOrNull ?? [];

  final alerts   = <AppAlert>[];
  final now      = DateTime.now();
  final today    = DateTime(now.year, now.month, now.day);

  final animalMap = {for (final a in animals) a.id: a};

  // ── Health-based alerts (vaccination, deworming, treatment, pregnancy) ───────
  for (final r in health) {
    if (r.nextDueDate == null || r.nextDueDate!.isEmpty) continue;
    final due = DateTime.tryParse(r.nextDueDate!);
    if (due == null) continue;
    final dueDay  = DateTime(due.year, due.month, due.day);
    final days    = dueDay.difference(today).inDays;
    if (days > 7) continue; // not imminent

    final animal  = animalMap[r.animalId];
    final display = animal != null ? _animalDisplay(animal) : r.animalSystemId;

    switch (r.recordType) {
      case 'vaccination':
        alerts.add(AppAlert(
          id: 'health_${r.id}',
          type: AlertType.vaccination,
          animalId: r.animalId,
          animalDisplay: display,
          titleAr: 'موعد تطعيم',
          titleEn: 'Vaccination Due',
          bodyAr: _daysBodyAr(days, r.title),
          bodyEn: _daysBodyEn(days, r.title),
          dueDate: due,
          daysUntilDue: days,
          severity: _severity(days),
        ));

      case 'deworming':
        alerts.add(AppAlert(
          id: 'health_${r.id}',
          type: AlertType.deworming,
          animalId: r.animalId,
          animalDisplay: display,
          titleAr: 'موعد تطهير',
          titleEn: 'Deworming Due',
          bodyAr: _daysBodyAr(days, r.title),
          bodyEn: _daysBodyEn(days, r.title),
          dueDate: due,
          daysUntilDue: days,
          severity: _severity(days),
        ));

      case 'treatment':
        alerts.add(AppAlert(
          id: 'health_${r.id}',
          type: AlertType.treatment,
          animalId: r.animalId,
          animalDisplay: display,
          titleAr: 'متابعة علاج',
          titleEn: 'Treatment Follow-up',
          bodyAr: _daysBodyAr(days, r.title),
          bodyEn: _daysBodyEn(days, r.title),
          dueDate: due,
          daysUntilDue: days,
          severity: _severity(days),
        ));

      case 'pregnancy':
        alerts.add(AppAlert(
          id: 'health_${r.id}',
          type: AlertType.birthExpected,
          animalId: r.animalId,
          animalDisplay: display,
          titleAr: 'موعد ولادة متوقع',
          titleEn: 'Birth Expected',
          bodyAr: _daysBodyAr(days, ''),
          bodyEn: _daysBodyEn(days, ''),
          dueDate: due,
          daysUntilDue: days,
          severity: _severity(days),
        ));
    }
  }

  // ── Weaning alerts ────────────────────────────────────────────────────────────
  for (final animal in animals) {
    if (animal.weaningFromDays == null) continue;
    if (animal.dateOfBirth.isEmpty) continue;
    final dob = DateTime.tryParse(animal.dateOfBirth);
    if (dob == null) continue;
    final dobDay   = DateTime(dob.year, dob.month, dob.day);
    final ageInDays = today.difference(dobDay).inDays;
    final weanStart = animal.weaningFromDays!;
    final weanEnd   = animal.weaningToDays ?? (weanStart + 30);

    if (ageInDays < weanStart || ageInDays > weanEnd) continue;

    final daysLeft = weanEnd - ageInDays;
    alerts.add(AppAlert(
      id: 'wean_${animal.id}',
      type: AlertType.weaningDue,
      animalId: animal.id,
      animalDisplay: _animalDisplay(animal),
      titleAr: 'نافذة الفطام',
      titleEn: 'Weaning Window',
      bodyAr: daysLeft == 0 ? 'آخر يوم للفطام' : 'متبقي $daysLeft يوم',
      bodyEn: daysLeft == 0 ? 'Last day to wean' : '$daysLeft days remaining',
      dueDate: today.add(Duration(days: daysLeft)),
      daysUntilDue: daysLeft,
      severity: daysLeft <= 2 ? AlertSeverity.warning : AlertSeverity.info,
    ));
  }

  // Sort: overdue first (most negative), then soonest first
  alerts.sort((a, b) => a.daysUntilDue.compareTo(b.daysUntilDue));
  return alerts;
});

/// Count of active alerts — used for the bell badge.
final alertsCountProvider = Provider<int>((ref) {
  return ref.watch(notificationsProvider).length;
});
