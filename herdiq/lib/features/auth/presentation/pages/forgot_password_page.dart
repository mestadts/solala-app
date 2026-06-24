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
import '../../../../shared/widgets/phone_country_field.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _phoneCt  = PhoneCountryController();
  bool _isLoading = false;
  bool _browserVerifying = false;

  @override
  void dispose() {
    _phoneCt.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_phoneCt.hasInput) return;
    final phone = _phoneCt.fullNumber;
    setState(() { _isLoading = true; _browserVerifying = false; });
    // Set flag so router won't redirect to dashboard when OTP signs user in.
    ref.read(passwordResetInProgressProvider.notifier).state = true;
    String? errorMessage;
    final autoVerified = await ref.read(authActionsProvider).sendOtp(
      phone: phone,
      onError: (e) => errorMessage = e,
      onBrowserVerification: () {
        if (mounted) setState(() => _browserVerifying = true);
      },
    );
    if (!mounted) return;
    setState(() { _isLoading = false; _browserVerifying = false; });

    if (errorMessage != null) {
      // Clear flag AFTER stopping loading, so the router doesn't redirect
      // while the snackbar is being shown (which causes it to leak to splash).
      ref.read(passwordResetInProgressProvider.notifier).state = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage!),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 6),
        ),
      );
      return;
    }

    if (autoVerified) {
      // Firebase auto-verified — user is already signed in.
      // Skip OTP screen and go directly to reset password.
      context.push(Routes.resetPassword, extra: {'phone': phone});
    } else {
      context.push(Routes.otpVerify, extra: {'phone': phone});
    }
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Lock icon in circle
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.tan.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(l.forgotTitle, style: AppTypography.displayMedium),
                    const SizedBox(height: 8),
                    Text(
                      l.forgotSubtitle,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    PhoneCountryField(
                      controller: _phoneCt,
                      label: l.loginPhone,
                      hint: l.loginPhoneHint,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _sendOtp(),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    HerdPrimaryButton(
                      label: l.forgotSendBtn,
                      onPressed: _sendOtp,
                      isLoading: _isLoading,
                    ),
                    if (_browserVerifying) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.open_in_browser_rounded, size: 18, color: Color(0xFF856404)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                Localizations.localeOf(context).languageCode == 'ar'
                                    ? 'تحقق مفتوح في المتصفح — أكمل التحقق ثم عد للتطبيق'
                                    : 'Browser verification open — complete it then return to the app',
                                style: const TextStyle(fontSize: 12, color: Color(0xFF856404)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 28),

                    Center(
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: RichText(
                          textDirection: Directionality.of(context),
                          text: TextSpan(
                            text: l.forgotRemember,
                            style: AppTypography.bodyMedium,
                            children: [
                              TextSpan(
                                text: l.forgotSignInLink,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
