import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class ActivityFeed extends StatelessWidget {
  final List<MockActivity> activities;
  const ActivityFeed({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    if (activities.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        child: Center(
          child: Text(
            l.dashboardNoActivity,
            style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted),
          ),
        ),
      );
    }

    return Column(
      children: activities
          .take(10)
          .map((a) => _ActivityTile(activity: a))
          .toList(),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final MockActivity activity;
  const _ActivityTile({required this.activity});

  String _timeAgo(BuildContext context) {
    final createdAt = activity.createdAt;
    if (createdAt == null) return activity.timeAgo;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final diff = DateTime.now().difference(createdAt);
    if (isAr) {
      if (diff.inMinutes < 1) return 'الآن';
      if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
      if (diff.inHours < 24) return 'منذ ${diff.inHours} س';
      if (diff.inDays < 7) return 'منذ ${diff.inDays} ي';
      if (diff.inDays < 30) return 'منذ ${(diff.inDays / 7).floor()} أسبوع';
      return 'منذ ${(diff.inDays / 30).floor()} شهر';
    }
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return '${(diff.inDays / 30).floor()}mo ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
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
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.tan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child:
                  Text(activity.icon, style: const TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  activity.subtitle,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Text(
            _timeAgo(context),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
