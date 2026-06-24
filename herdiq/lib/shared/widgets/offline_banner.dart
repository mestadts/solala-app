import 'package:flutter/material.dart';
import '../../core/theme/app_typography.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color(0xFFE53935),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            'No internet — changes will sync when reconnected',
            style: AppTypography.bodySmall.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
