import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/mock/mock_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/health_timeline.dart';
import '../../../weight/presentation/widgets/weight_chart.dart';

class AnimalHealthHistoryPage extends ConsumerWidget {
  final String animalId;
  const AnimalHealthHistoryPage({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final animal = ref.watch(mockAnimalByIdProvider(animalId));
    final healthRecords = ref.watch(mockHealthByAnimalProvider(animalId));
    final weightRecords = ref.watch(mockWeightByAnimalProvider(animalId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── App bar ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animal?.name ?? '',
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (animal != null)
                          Text(
                            animal.systemAnimalId,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.brown),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Content ──────────────────────────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 16,
                    AppSpacing.screenPadding, 40),
                children: [
                  // Weight chart (if records exist)
                  if (weightRecords.isNotEmpty) ...[
                    Text(
                      l.healthHistoryWeightTrend,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    WeightChart(records: weightRecords),
                    const SizedBox(height: AppSpacing.sectionGap),
                  ],

                  // Health timeline
                  Text(
                    l.healthHistoryTimeline,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (healthRecords.isEmpty)
                    _EmptyState(
                      message: l.healthHistoryNoRecords,
                      emoji: '💉',
                    )
                  else
                    HealthTimeline(records: healthRecords),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;
  final String emoji;
  const _EmptyState({required this.message, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Center(
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 10),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
