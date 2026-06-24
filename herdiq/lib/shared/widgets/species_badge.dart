import 'package:flutter/material.dart';
import '../../core/constants/livestock_species.dart';
import '../../core/theme/app_typography.dart';

class SpeciesBadge extends StatelessWidget {
  final LivestockSpecies species;
  final bool showEmoji;

  const SpeciesBadge({
    super.key,
    required this.species,
    this.showEmoji = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = species.color;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showEmoji) ...[
            Text(species.emoji, style: const TextStyle(fontSize: 12)),
            const SizedBox(width: 4),
          ],
          Text(
            isAr ? species.nameAr : species.displayName,
            style: AppTypography.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
