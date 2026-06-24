import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/app_alert.dart';
import '../providers/notifications_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final alerts = ref.watch(notificationsProvider);

    final critical  = alerts.where((a) => a.severity == AlertSeverity.critical).toList();
    final warning   = alerts.where((a) => a.severity == AlertSeverity.warning).toList();
    final info      = alerts.where((a) => a.severity == AlertSeverity.info).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isAr ? 'التنبيهات' : 'Alerts',
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: alerts.isEmpty
          ? _EmptyState(isAr: isAr)
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: 12,
              ),
              children: [
                if (critical.isNotEmpty) ...[
                  _SectionHeader(
                    label: isAr ? 'متأخرة' : 'Overdue',
                    color: Colors.red.shade700,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 8),
                  ...critical.map((a) => _AlertTile(alert: a, isAr: isAr)),
                  const SizedBox(height: 16),
                ],
                if (warning.isNotEmpty) ...[
                  _SectionHeader(
                    label: isAr ? 'عاجل' : 'Urgent',
                    color: Colors.orange.shade700,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 8),
                  ...warning.map((a) => _AlertTile(alert: a, isAr: isAr)),
                  const SizedBox(height: 16),
                ],
                if (info.isNotEmpty) ...[
                  _SectionHeader(
                    label: isAr ? 'قادمة' : 'Upcoming',
                    color: AppColors.primary,
                    isAr: isAr,
                  ),
                  const SizedBox(height: 8),
                  ...info.map((a) => _AlertTile(alert: a, isAr: isAr)),
                  const SizedBox(height: 16),
                ],
              ],
            ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final Color color;
  final bool isAr;

  const _SectionHeader({required this.label, required this.color, required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 16, color: color,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(label,
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.w700, color: color, fontSize: 13)),
      ],
    );
  }
}

// ── Alert tile ─────────────────────────────────────────────────────────────────

class _AlertTile extends StatelessWidget {
  final AppAlert alert;
  final bool isAr;

  const _AlertTile({required this.alert, required this.isAr});

  IconData get _icon {
    return switch (alert.type) {
      AlertType.vaccination   => Icons.vaccines_rounded,
      AlertType.deworming     => Icons.pest_control_rounded,
      AlertType.treatment     => Icons.medical_services_rounded,
      AlertType.birthExpected => Icons.child_friendly_rounded,
      AlertType.weaningDue    => Icons.grass_rounded,
    };
  }

  Color get _color {
    return switch (alert.severity) {
      AlertSeverity.critical => Colors.red.shade700,
      AlertSeverity.warning  => Colors.orange.shade700,
      AlertSeverity.info     => AppColors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/animals/${alert.animalId}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: _color.withValues(alpha: 0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, color: _color, size: 20),
            ),
            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          isAr ? alert.titleAr : alert.titleEn,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.brown,
                          ),
                        ),
                      ),
                      // Days chip
                      _DaysChip(days: alert.daysUntilDue, color: _color, isAr: isAr),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alert.animalDisplay,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isAr ? alert.bodyAr : alert.bodyEn,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Days chip ──────────────────────────────────────────────────────────────────

class _DaysChip extends StatelessWidget {
  final int days;
  final Color color;
  final bool isAr;

  const _DaysChip({required this.days, required this.color, required this.isAr});

  @override
  Widget build(BuildContext context) {
    final String label;
    if (days < 0) {
      label = isAr ? '${-days} يوم' : '${-days}d late';
    } else if (days == 0) {
      label = isAr ? 'اليوم' : 'Today';
    } else {
      label = isAr ? 'بعد $days يوم' : 'In ${days}d';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final bool isAr;
  const _EmptyState({required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('✅', style: TextStyle(fontSize: 56)),
          const SizedBox(height: 16),
          Text(
            isAr ? 'لا توجد تنبيهات حالياً' : 'No alerts right now',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.brown,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isAr
                ? 'كل شيء على ما يرام في المزرعة'
                : 'Everything is on track at the farm',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
