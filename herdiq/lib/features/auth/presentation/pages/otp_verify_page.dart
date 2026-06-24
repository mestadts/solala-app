import 'dart:async';
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
import '../widgets/otp_input_row.dart';

/// Standalone OTP verify screen — used only for the forgot-password flow.
/// [phone] is the number OTP was sent to.
class OtpVerifyPage extends ConsumerStatefulWidget {
  final String phone;

  const OtpVerifyPage({super.key, required this.phone});

  @override
  ConsumerState<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends ConsumerState<OtpVerifyPage> {
  String _otp          = '';
  int _resendSeconds   = 60;
  bool _isLoading      = false;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _resendSeconds = 60);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) { timer.cancel(); return; }
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  Future<void> _resendOtp() async {
    setState(() => _isLoading = true);
    String? errorMessage;
    await ref.read(authActionsProvider).sendOtp(
      phone: widget.phone,
      onError: (e) => errorMessage = e,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage!), backgroundColor: Colors.red),
      );
    } else {
      _startResendTimer();
    }
  }

  Future<void> _verify() async {
    if (_otp.length < 6) return;
    setState(() => _isLoading = true);
    final success = await ref.read(authActionsProvider).verifyOtp(
      smsCode: _otp,
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
    if (success) {
      context.push(Routes.resetPassword, extra: {'phone': widget.phone});
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
            // ── Back button ────────────────────────────────────────────────
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

            // ── Content ────────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(l.otpTitle, style: AppTypography.displayMedium),
                    const SizedBox(height: 8),
                    RichText(
                      textDirection: Directionality.of(context),
                      text: TextSpan(
                        text: l.otpSubtitle,
                        style: AppTypography.bodyMedium,
                        children: [
                          TextSpan(
                            text: widget.phone.isEmpty
                                ? l.otpYourNumber
                                : widget.phone,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    OtpInputRow(onChanged: (v) => _otp = v),

                    const SizedBox(height: 16),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: _resendSeconds == 0 ? _resendOtp : null,
                        child: Text(
                          _resendSeconds > 0
                              ? l.otpResendIn(_resendSeconds)
                              : l.otpResend,
                          style: AppTypography.bodyMedium.copyWith(
                            color: _resendSeconds > 0
                                ? AppColors.textMuted
                                : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    HerdPrimaryButton(
                      label: l.otpVerifyBtn,
                      onPressed: _verify,
                      isLoading: _isLoading,
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
