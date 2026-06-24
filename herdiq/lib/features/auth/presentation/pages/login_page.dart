import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_social_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';
import '../../../../shared/widgets/phone_country_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey      = GlobalKey<FormState>();
  final _phoneCt      = PhoneCountryController();
  final _passCt       = TextEditingController();
  bool _isLoading     = false;
  bool _googleLoading = false;
  bool _appleLoading  = false;

  @override
  void dispose() {
    _phoneCt.dispose();
    _passCt.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await ref.read(authActionsProvider).signIn(
        _phoneCt.fullNumber,
        _passCt.text,
      );
      // Router auto-redirects when authStateProvider emits user
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _googleLoading = true);
    await ref.read(authActionsProvider).signInWithGoogle(
      onError: (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e), backgroundColor: Colors.red),
          );
        }
      },
    );
    if (mounted) setState(() => _googleLoading = false);
  }

  Future<void> _signInWithApple() async {
    setState(() => _appleLoading = true);
    await ref.read(authActionsProvider).signInWithApple(
      onError: (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e), backgroundColor: Colors.red),
          );
        }
      },
    );
    if (mounted) setState(() => _appleLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final showApple = Platform.isIOS || Platform.isMacOS;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 56),

                // ── Header ──────────────────────────────────────────────────
                Text(l.loginTitle, style: AppTypography.displayLarge),
                const SizedBox(height: 8),
                Text(
                  l.loginSubtitle,
                  style: AppTypography.bodyMedium,
                ),

                const SizedBox(height: AppSpacing.sectionGap),

                // ── Phone field ──────────────────────────────────────────────
                PhoneCountryField(
                  controller: _phoneCt,
                  label: l.loginPhone,
                  hint: l.loginPhoneHint,
                  textInputAction: TextInputAction.next,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return l.loginPhoneValidation;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.itemGap),

                // ── Password field ───────────────────────────────────────────
                HerdTextField(
                  label: l.loginPassword,
                  hint: l.loginPasswordHint,
                  controller: _passCt,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _signIn(),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l.loginPasswordValidation;
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // ── Forgot password ──────────────────────────────────────────
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () => context.push(Routes.forgotPassword),
                    child: Text(
                      l.loginForgotPassword,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.sectionGap),

                // ── Sign In button ───────────────────────────────────────────
                HerdPrimaryButton(
                  label: l.loginBtn,
                  onPressed: _signIn,
                  isLoading: _isLoading,
                ),

                const SizedBox(height: 24),

                // ── Divider ──────────────────────────────────────────────────
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.tan)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        l.loginOrWith,
                        style: AppTypography.bodySmall,
                      ),
                    ),
                    const Expanded(child: Divider(color: AppColors.tan)),
                  ],
                ),

                const SizedBox(height: 16),

                // ── Social buttons ───────────────────────────────────────────
                if (showApple)
                  // iOS: side-by-side Google + Apple
                  Row(
                    children: [
                      Expanded(
                        child: HerdSocialButton(
                          label: 'Google',
                          icon: const _GoogleIcon(),
                          onPressed: _signInWithGoogle,
                          isLoading: _googleLoading,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: HerdSocialButton(
                          label: 'Apple',
                          icon: const Icon(
                            Icons.apple,
                            color: Colors.black87,
                            size: 20,
                          ),
                          onPressed: _signInWithApple,
                          isLoading: _appleLoading,
                        ),
                      ),
                    ],
                  )
                else
                  // Android: Google only (full width)
                  HerdSocialButton(
                    label: 'Google',
                    icon: const _GoogleIcon(),
                    onPressed: _signInWithGoogle,
                    isLoading: _googleLoading,
                  ),

                const SizedBox(height: 36),

                // ── Register link ────────────────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: () => context.push(Routes.register),
                    child: RichText(
                      textDirection: Directionality.of(context),
                      text: TextSpan(
                        text: l.loginNoAccount,
                        style: AppTypography.bodyMedium,
                        children: [
                          TextSpan(
                            text: l.loginRegisterLink,
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
      ),
    );
  }
}

// ── Google icon ───────────────────────────────────────────────────────────────
class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: Color(0xFF4285F4),
        height: 1,
      ),
    );
  }
}
