import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class OrgSettingsPage extends ConsumerStatefulWidget {
  const OrgSettingsPage({super.key});

  @override
  ConsumerState<OrgSettingsPage> createState() => _OrgSettingsPageState();
}

class _OrgSettingsPageState extends ConsumerState<OrgSettingsPage> {
  late TextEditingController _nameCt;
  late TextEditingController _locationCt;
  bool _isLoading = false;
  bool _initialized = false;

  @override
  void dispose() {
    _nameCt.dispose();
    _locationCt.dispose();
    super.dispose();
  }

  void _initControllers() {
    if (_initialized) return;
    _nameCt     = TextEditingController(text: ref.read(farmNameProvider));
    _locationCt = TextEditingController(text: ref.read(farmLocationProvider));
    _initialized = true;
  }

  Future<void> _save() async {
    final name     = _nameCt.text.trim();
    final location = _locationCt.text.trim();
    if (name.isEmpty) return;

    setState(() => _isLoading = true);

    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(PrefsKeys.farmName, name);
    await prefs.setString(PrefsKeys.farmLocation, location);
    ref.read(farmNameProvider.notifier).state     = name;
    ref.read(farmLocationProvider.notifier).state = location;

    if (!mounted) return;
    setState(() => _isLoading = false);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    _initControllers();
    final l   = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

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
                    l.settingsOrgSettings,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    HerdTextField(
                      label: l.orgSetupName,
                      hint: l.orgSetupNameHint,
                      controller: _nameCt,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.business_outlined,
                          color: AppColors.textMuted, size: 20),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty)
                              ? l.orgSetupNameValidation
                              : null,
                    ),
                    const SizedBox(height: AppSpacing.itemGap),

                    HerdTextField(
                      label: l.orgSetupLocation,
                      hint: l.orgSetupLocationHint,
                      controller: _locationCt,
                      textInputAction: TextInputAction.done,
                      prefixIcon: const Icon(Icons.location_on_outlined,
                          color: AppColors.textMuted, size: 20),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),

                    HerdPrimaryButton(
                      label: isAr ? 'حفظ التغييرات' : 'Save Changes',
                      onPressed: _save,
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
