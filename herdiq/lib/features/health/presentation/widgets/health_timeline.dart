import 'package:flutter/material.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class HealthTimeline extends StatelessWidget {
  final List<MockHealthRecord> records;
  const HealthTimeline({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < records.length; i++)
          _TimelineItem(
            record: records[i],
            isLast: i == records.length - 1,
          ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final MockHealthRecord record;
  final bool isLast;
  const _TimelineItem({required this.record, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isVacc = record.recordType == 'vaccination';
    final dotColor = isVacc ? AppColors.statusActive : AppColors.cow;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 28,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                ),
                // Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: AppColors.tan.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Card
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        isVacc ? '💉' : '💊',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          record.title,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: dotColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isVacc ? 'Vaccine' : 'Treatment',
                          style: AppTypography.bodySmall.copyWith(
                            color: dotColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    record.date,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  if (record.vetName.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.medical_services_outlined,
                            size: 12, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          record.vetName,
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ],
                  if (record.nextDueDate != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.event_rounded,
                            size: 12, color: AppColors.statusSold),
                        const SizedBox(width: 4),
                        Text(
                          'Next due: ${record.nextDueDate}',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.statusSold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (record.notes.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      record.notes,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.brown),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
