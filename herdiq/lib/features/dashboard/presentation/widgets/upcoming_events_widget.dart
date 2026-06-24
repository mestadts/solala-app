import 'package:flutter/material.dart';
import '../../../../core/mock/mock_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class UpcomingEventsWidget extends StatelessWidget {
  final List<MockUpcomingEvent> events;
  const UpcomingEventsWidget({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    if (events.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        child: Center(
          child: Column(
            children: [
              const Text('✅', style: TextStyle(fontSize: 28)),
              const SizedBox(height: 6),
              Text(
                l.healthNoUpcoming,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: events.map((e) => _EventTile(event: e, l: l)).toList(),
    );
  }
}

String _emojiForType(String type) {
  switch (type) {
    case 'vaccination': return '💉';
    case 'deworming':   return '🐛';
    case 'birth':       return '🤰';
    default:            return '📋';
  }
}

Color _accentForType(String type) {
  switch (type) {
    case 'vaccination': return AppColors.statusSold;
    case 'deworming':   return AppColors.brown;
    case 'birth':       return AppColors.statusActive;
    default:            return AppColors.textMuted;
  }
}

class _EventTile extends StatelessWidget {
  final MockUpcomingEvent event;
  final AppL l;
  const _EventTile({required this.event, required this.l});

  @override
  Widget build(BuildContext context) {
    final emoji = _emojiForType(event.type);
    final accent = _accentForType(event.type);
    final now = DateTime.now().toIso8601String().substring(0, 10);
    final isOverdue = event.dueDate.isNotEmpty &&
        event.dueDate.compareTo(now) < 0;

    final typeLabel = event.type == 'birth'
        ? l.upcomingBirthLabel
        : event.type == 'deworming'
            ? l.healthOptionDeworming
            : l.healthOptionVaccination;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border(
          left: BorderSide(color: accent, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title.isNotEmpty ? event.title : typeLabel,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  event.animalSystemId,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isOverdue)
                _Tag(label: l.healthOverdue, color: AppColors.statusError)
              else
                _Tag(label: l.healthDue, color: accent),
              const SizedBox(height: 2),
              Text(
                event.dueDate,
                style: AppTypography.bodySmall.copyWith(
                  color: isOverdue ? AppColors.statusError : accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTypography.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }
}
