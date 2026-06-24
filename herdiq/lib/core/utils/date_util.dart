// date_util.dart — Hijri / Gregorian date formatting helper.
// All date displays in the app go through this helper so the
// Hijri toggle in Settings propagates everywhere automatically.
//
// Usage:
//   DateUtil.format('2025-03-15', hijriEnabled: true)
//   → "15/6/1446هـ"
//
//   DateUtil.format('2025-03-15', hijriEnabled: false)
//   → "15/3/2025"
//
// Returns '' for null/empty/invalid input (safe for optional fields).

import 'package:hijri/hijri_calendar.dart';

class DateUtil {
  DateUtil._();

  /// Format an ISO date string (YYYY-MM-DD) for display.
  /// Returns Hijri format when [hijriEnabled] is true, Gregorian otherwise.
  /// Returns '' for null, empty, or unparseable input.
  static String format(String? isoDate, {required bool hijriEnabled}) {
    if (isoDate == null || isoDate.isEmpty) return '';
    final dt = DateTime.tryParse(isoDate);
    if (dt == null) return '';

    if (hijriEnabled) {
      final h = HijriCalendar.fromDate(dt);
      return '${h.hDay}/${h.hMonth}/${h.hYear}هـ';
    } else {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  /// Format a DateTime directly (for pickers that return DateTime, not a string).
  static String formatDate(DateTime? date, {required bool hijriEnabled}) {
    if (date == null) return '';
    if (hijriEnabled) {
      final h = HijriCalendar.fromDate(date);
      return '${h.hDay}/${h.hMonth}/${h.hYear}هـ';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
