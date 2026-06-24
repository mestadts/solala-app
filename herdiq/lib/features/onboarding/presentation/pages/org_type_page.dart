import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

// ── Org type value constants ───────────────────────────────────────────────────

enum _OrgTypeValue { individual, smallFarm, commercial, government }

// ── Page ─────────────────────────────────────────────────────────────────────

class OrgTypePage extends StatefulWidget {
  const OrgTypePage({super.key});

  @override
  State<OrgTypePage> createState() => _OrgTypePageState();
}

class _OrgTypePageState extends State<OrgTypePage> {
  _OrgTypeValue? _selected;

  void _pick(_OrgTypeValue value) {
    setState(() => _selected = value);
    Future.delayed(const Duration(milliseconds: 220), () {
      if (mounted) context.go(Routes.orgSetup);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    final orgTypes = [
      _OrgTypeData(
        emoji: '🧑‍🌾',
        title: l.orgTypeIndividual,
        description: l.orgTypeIndividualDesc,
        value: _OrgTypeValue.individual,
      ),
      _OrgTypeData(
        emoji: '🏡',
        title: l.orgTypeSmallFarm,
        description: l.orgTypeSmallFarmDesc,
        value: _OrgTypeValue.smallFarm,
      ),
      _OrgTypeData(
        emoji: '🏭',
        title: l.orgTypeCommercial,
        description: l.orgTypeCommercialDesc,
        value: _OrgTypeValue.commercial,
      ),
      _OrgTypeData(
        emoji: '🏛️',
        title: l.orgTypeGovt,
        description: l.orgTypeGovtDesc,
        value: _OrgTypeValue.government,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Back ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                onPressed: () => context.pop(),
              ),
            ),

            // ── Content ──────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(l.orgTypeTitle, style: AppTypography.displayMedium),
                    const SizedBox(height: 8),
                    Text(
                      l.orgTypeSubtitle,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    ...List.generate(orgTypes.length, (i) {
                      final t = orgTypes[i];
                      final isSelected = _selected == t.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _OrgTypeCard(
                          type: t,
                          isSelected: isSelected,
                          onTap: () => _pick(t.value),
                        ),
                      );
                    }),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Org type data model ────────────────────────────────────────────────────────

class _OrgTypeData {
  final String emoji;
  final String title;
  final String description;
  final _OrgTypeValue value;

  const _OrgTypeData({
    required this.emoji,
    required this.title,
    required this.description,
    required this.value,
  });
}

// ── Org type card ─────────────────────────────────────────────────────────────

class _OrgTypeCard extends StatelessWidget {
  final _OrgTypeData type;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrgTypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emoji container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.tan.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Center(
                child: Text(type.emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.description,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),

            // Check
            if (isSelected) ...[
              const SizedBox(width: 8),
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
