import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class HerdAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final Widget? leading;
  final Color? backgroundColor;
  final VoidCallback? onBack;

  const HerdAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.leading,
    this.backgroundColor,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.background,
      elevation: 0,
      centerTitle: false,
      title: Text(title, style: AppTypography.titleLarge),
      leading: leading ??
          (showBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  color: AppColors.primary,
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                )
              : null),
      actions: actions,
    );
  }
}
