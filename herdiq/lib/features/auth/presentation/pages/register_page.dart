import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/phone_country_field.dart';
import '../widgets/otp_input_row.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  int _step = 0; // 0=phone, 1=otp, 2=profile

  // Step 0 — Phone
  final _phoneCt = PhoneCountryController();

  // Step 1 — OTP
  String _otp = '';
  int _resendSeconds = 60;
  Timer? _resendTimer;

  // Step 2 — Profile
  final _formKeyProfile = GlobalKey<FormState>();
  final _nameCt         = TextEditingController();
  final _passCt         = TextEditingController();
  final _confirmPassCt  = TextEditingController();
  bool _isLoading       = false;
  bool _browserVerifying = false; // true when reCAPTCHA is in progress in Chrome

  @override
  void dispose() {
    _phoneCt.dispose();
    _nameCt.dispose();
    _passCt.dispose();
    _confirmPassCt.dispose();
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

  void _goToStep(int step) => setState(() => _step = step);

  Future<void> _sendOtp() async {
    if (!_phoneCt.hasInput) return;
    setState(() { _isLoading = true; _browserVerifying = false; });
    // Block router redirect — auto-verify on Android signs the user in
    // immediately, which would otherwise navigate away before step 2.
    ref.read(registrationInProgressProvider.notifier).state = true;
    String? errorMessage;
    final autoVerified = await ref.read(authActionsProvider).sendOtp(
      phone: _phoneCt.fullNumber,
      onError: (e) => errorMessage = e,
      onBrowserVerification: () {
        if (mounted) setState(() => _browserVerifying = true);
      },
    );
    if (!mounted) return;
    setState(() { _isLoading = false; _browserVerifying = false; });

    if (errorMessage != null) {
      // Clear flag AFTER stopping loading so the router doesn't navigate
      // away while the snackbar is being shown (avoids leak to splash).
      ref.read(registrationInProgressProvider.notifier).state = false;
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
      // Firebase auto-verified — already signed in, skip OTP step.
      _goToStep(2);
    } else {
      _startResendTimer();
      _goToStep(1);
    }
  }

  Future<void> _createAccount() async {
    if (!_formKeyProfile.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await ref.read(authActionsProvider).completeRegistration(
      phone: _phoneCt.fullNumber,
      password: _passCt.text,
      displayName: _nameCt.text.trim(),
      onError: (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e), backgroundColor: Colors.red),
          );
        }
      },
    );
    if (mounted) setState(() => _isLoading = false);
    // authStateProvider emits user → router redirects to /onboarding
  }

  // ── Back handling ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _step > 0) setState(() => _step--);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding,
                  ),
                  child: _buildCurrentStep(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top bar with back + step dots ──────────────────────────────────────────

  Widget _buildTopBar(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isRtl
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
            color: AppColors.primary,
            onPressed: () {
              if (_step > 0) {
                setState(() => _step--);
              } else {
                context.pop();
              }
            },
          ),
          const Spacer(),
          _StepDots(current: _step, total: 3),
        ],
      ),
    );
  }

  // ── Step content ───────────────────────────────────────────────────────────

  Widget _buildCurrentStep() {
    return switch (_step) {
      0 => _StepPhone(
          controller: _phoneCt,
          onNext: _sendOtp,
          onSignIn: () => context.pop(),
          isLoading: _isLoading,
          browserVerifying: _browserVerifying,
        ),
      1 => _StepOtp(
          phone: _phoneCt.fullNumber,
          resendSeconds: _resendSeconds,
          onOtpChanged: (v) => _otp = v,
          onVerify: () async {
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
            if (mounted) {
              setState(() => _isLoading = false);
              if (success) _goToStep(2);
            }
          },
          onResend: _resendSeconds == 0 ? _sendOtp : null,
        ),
      _ => _StepProfile(
          formKey: _formKeyProfile,
          nameController: _nameCt,
          passController: _passCt,
          confirmPassController: _confirmPassCt,
          isLoading: _isLoading,
          onSubmit: _createAccount,
        ),
    };
  }
}

// ── Step dot indicator ────────────────────────────────────────────────────────

class _StepDots extends StatelessWidget {
  final int current;
  final int total;

  const _StepDots({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: active ? 22 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: i <= current ? AppColors.primary : AppColors.tan,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ── Step 0: Phone ─────────────────────────────────────────────────────────────

class _StepPhone extends StatelessWidget {
  final PhoneCountryController controller;
  final VoidCallback onNext;
  final VoidCallback onSignIn;
  final bool isLoading;
  final bool browserVerifying;

  const _StepPhone({
    required this.controller,
    required this.onNext,
    required this.onSignIn,
    required this.isLoading,
    this.browserVerifying = false,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(l.registerStep0Title, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        Text(
          l.registerStep0Subtitle,
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        PhoneCountryField(
          controller: controller,
          label: l.loginPhone,
          hint: l.loginPhoneHint,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onNext(),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(label: l.registerSendOtp, onPressed: onNext, isLoading: isLoading),
        if (browserVerifying) ...[
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
            onTap: onSignIn,
            child: RichText(
              textDirection: Directionality.of(context),
              text: TextSpan(
                text: l.registerHaveAccount,
                style: AppTypography.bodyMedium,
                children: [
                  TextSpan(
                    text: l.registerSignInLink,
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
    );
  }
}

// ── Step 1: OTP ───────────────────────────────────────────────────────────────

class _StepOtp extends StatelessWidget {
  final String phone;
  final int resendSeconds;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerify;
  final VoidCallback? onResend;

  const _StepOtp({
    required this.phone,
    required this.resendSeconds,
    required this.onOtpChanged,
    required this.onVerify,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(l.otpTitle, style: AppTypography.displayMedium),
        const SizedBox(height: 8),
        RichText(
          textDirection: Directionality.of(context),
          text: TextSpan(
            text: l.otpSubtitle,
            style: AppTypography.bodyMedium,
            children: [
              TextSpan(
                text: phone.isEmpty ? l.otpYourNumber : phone,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        OtpInputRow(onChanged: onOtpChanged),
        const SizedBox(height: 16),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: GestureDetector(
            onTap: onResend,
            child: Text(
              resendSeconds > 0
                  ? l.otpResendIn(resendSeconds)
                  : l.otpResend,
              style: AppTypography.bodyMedium.copyWith(
                color: resendSeconds > 0 ? AppColors.textMuted : AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        HerdPrimaryButton(label: l.otpVerifyBtn, onPressed: onVerify),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 2: Profile ───────────────────────────────────────────────────────────

class _StepProfile extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController passController;
  final TextEditingController confirmPassController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _StepProfile({
    required this.formKey,
    required this.nameController,
    required this.passController,
    required this.confirmPassController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Text(l.registerStep2Title, style: AppTypography.displayMedium),
          const SizedBox(height: 8),
          Text(l.registerStep2Subtitle, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.sectionGap),
          HerdTextField(
            label: l.registerFullName,
            hint: l.registerFullNameHint,
            controller: nameController,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l.registerFullNameValidation;
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.itemGap),
          HerdTextField(
            label: l.loginPassword,
            hint: l.registerPasswordHint,
            controller: passController,
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
            label: l.registerConfirmPassword,
            hint: l.registerConfirmHint,
            controller: confirmPassController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => onSubmit(),
            validator: (v) {
              if (v != passController.text) return l.resetPasswordMismatch;
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          HerdPrimaryButton(
            label: l.registerCreateBtn,
            onPressed: onSubmit,
            isLoading: isLoading,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
