import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class ProfileEditPage extends ConsumerStatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ConsumerState<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends ConsumerState<ProfileEditPage> {
  final _nameCt  = TextEditingController();
  final _phoneCt = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authStateProvider).valueOrNull;
    _nameCt.text  = user?.displayName ?? '';
    _phoneCt.text = user?.phoneNumber ?? '';
  }

  @override
  void dispose() {
    _nameCt.dispose();
    _phoneCt.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameCt.text.trim();
    if (name.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    } catch (_) {}
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: AppColors.primary),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    l.profileEditTitle,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Avatar
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: AppColors.tan.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.tan, width: 2),
                            ),
                            child: const Center(
                              child: Text('👤',
                                  style: TextStyle(fontSize: 42)),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.camera_alt_rounded,
                                  size: 14, color: AppColors.onPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    HerdTextField(
                      label: l.profileFullName,
                      controller: _nameCt,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.itemGap),
                    HerdTextField(
                      label: l.profilePhone,
                      controller: _phoneCt,
                      keyboardType: TextInputType.phone,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.lock_outline,
                          size: 16, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    HerdPrimaryButton(
                        label: l.profileSaveBtn,
                        onPressed: _save,
                        isLoading: _isLoading),
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
