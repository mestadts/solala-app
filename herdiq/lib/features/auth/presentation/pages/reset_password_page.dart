import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String phone;

  const ResetPasswordPage({super.key, required this.phone});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey      = GlobalKey<FormState>();
  final _passCt       = TextEditingController();
  final _confirmPassCt = TextEditingController();
  bool _isLoading     = false;

  @override
  void dispose() {
    _passCt.dispose();
    _confirmPassCt.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final success = await ref.read(authActionsProvider).resetPassword(
      newPassword: _passCt.text,
      onError: (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e), backgroundColor: Colors.red),
          );
        }
      },
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!success) return; // Error shown by onError above.

    final l = AppL.of(context);
    // Sign out BEFORE clearing the flag. If we clear the flag while still
    // signed in, the router redirects to dashboard instead of login.
    await ref.read(authActionsProvider).signOut();
    if (!mounted) return;
    ref.read(passwordResetInProgressProvider.notifier).state = false;
    context.go(Routes.login);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.resetSuccess),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Back button ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: IconButton(
                icon: Icon(
                  isRtl
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                onPressed: () => context.pop(),
              ),
            ),

            // ── Content ──────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Shield icon in circle
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.tan.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(l.resetTitle, style: AppTypography.displayMedium),
                      const SizedBox(height: 8),
                      Text(
                        l.resetSubtitle,
                        style: AppTypography.bodyMedium,
                      ),

                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdTextField(
                        label: l.resetNewPassword,
                        hint: l.resetNewPasswordHint,
                        controller: _passCt,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.length < 8) {
                            return l.resetPasswordMinLength;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.resetConfirmPassword,
                        hint: l.resetConfirmHint,
                        controller: _confirmPassCt,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _resetPassword(),
                        validator: (v) {
                          if (v != _passCt.text) {
                            return l.resetPasswordMismatch;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdPrimaryButton(
                        label: l.resetBtn,
                        onPressed: _resetPassword,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
