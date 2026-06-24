import 'package:flutter/material.dart';
import '../../../../core/constants/age_class_data.dart';
import '../../../../core/constants/livestock_species.dart';
import '../../../../core/mock/mock_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// Replaces the old species-only donut chart with meaningful herd stats:
/// 1. Gender split (Males / Females)
/// 2. Age class distribution (بهم / جذع / رباع / سديس / ثني)
/// 3. Breed distribution (top 5 breeds)
/// 4. Species breakdown — shown only when multiple species are present
class SpeciesBreakdownChart extends StatelessWidget {
  final DashboardStats stats;
  const SpeciesBreakdownChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    if (stats.total == 0) return const SizedBox.shrink();

    return Column(
      children: [
        // ── 1. Gender split ───────────────────────────────────────────────
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(isAr ? 'توزيع الجنس' : 'Gender Split'),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _GenderTile(
                      emoji: '♂',
                      label: l.genderMale,
                      count: stats.males,
                      total: stats.total,
                      color: const Color(0xFF0A84FF),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _GenderTile(
                      emoji: '♀',
                      label: l.genderFemale,
                      count: stats.females,
                      total: stats.total,
                      color: const Color(0xFFFF375F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ── 2. Age class distribution ─────────────────────────────────────
        if (stats.byAgeClass.values.any((v) => v > 0))
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(isAr ? 'توزيع الأعمار' : 'Age Distribution'),
                const SizedBox(height: 14),
                ...ageClasses.map((ac) {
                  final count = stats.byAgeClass[ac.id] ?? 0;
                  if (count == 0) return const SizedBox.shrink();
                  return _BarRow(
                    label: isAr ? ac.nameAr : ac.nameEn,
                    count: count,
                    total: stats.total,
                    color: AppColors.primary.withValues(alpha: 0.75),
                  );
                }),
              ],
            ),
          ),

        const SizedBox(height: 12),

        // ── 3. Breed distribution (top 5) ─────────────────────────────────
        if (stats.byBreed.isNotEmpty)
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(isAr ? 'توزيع السلالات' : 'Breed Distribution'),
                const SizedBox(height: 14),
                ...(() {
                  final sorted = stats.byBreed.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));
                  return sorted.take(5).map((e) => _BarRow(
                        label: e.key,
                        count: e.value,
                        total: stats.total,
                        color: AppColors.brown.withValues(alpha: 0.65),
                      ));
                })(),
              ],
            ),
          ),

        const SizedBox(height: 12),

        // ── 4. Species breakdown (multi-species only) ─────────────────────
        Builder(builder: (_) {
          final nonZero = LivestockSpecies.values
              .where((s) => (stats.bySpecies[s] ?? 0) > 0)
              .toList();
          if (nonZero.length <= 1) return const SizedBox.shrink();
          return _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(isAr ? 'توزيع الأنواع' : 'Species Breakdown'),
                const SizedBox(height: 14),
                ...nonZero.map((s) {
                  final count = stats.bySpecies[s] ?? 0;
                  return _BarRow(
                    label: '${s.emoji}  ${isAr ? s.nameAr : s.displayName}',
                    count: count,
                    total: stats.total,
                    color: s.color,
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }
}

// ── Section card wrapper ──────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ── Section title ─────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.bodySmall.copyWith(
        color: AppColors.brown,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.3,
      ),
    );
  }
}

// ── Gender tile ───────────────────────────────────────────────────────────────

class _GenderTile extends StatelessWidget {
  final String emoji;
  final String label;
  final int count;
  final int total;
  final Color color;

  const _GenderTile({
    required this.emoji,
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (count / total * 100).round() : 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 16, color: color)),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '$count',
            style: AppTypography.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          Text(
            '$pct%',
            style: AppTypography.bodySmall.copyWith(
              color: color.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Horizontal bar row ────────────────────────────────────────────────────────

class _BarRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const _BarRow({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = total > 0 ? count / total : 0.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '$count',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.brown,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: AppColors.tan.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
