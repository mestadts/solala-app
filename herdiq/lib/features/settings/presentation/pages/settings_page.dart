import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/providers/date_format_provider.dart';
import '../../../../core/providers/locale_provider.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppL.of(context);
    final hijriEnabled = ref.watch(hijriEnabledProvider);
    final udhiyaShow = ref.watch(udhiyaShowProvider);
    final locale = ref.watch(localeProvider);
    final prefs = ref.read(sharedPreferencesProvider);
    final isAr = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 20,
              AppSpacing.screenPadding, 40),
          children: [
            Text(
              l.settingsTitle,
              style: AppTypography.displayMedium,
            ),
            const SizedBox(height: 20),

            // ── Profile section ──────────────────────────────────────────────
            _ProfileCard(onTap: () => context.push(Routes.profileEdit)),
            const SizedBox(height: 20),

            // ── Organization ─────────────────────────────────────────────────
            _SectionHeader(title: l.settingsSectionOrg),
            _SettingsTile(
              icon: Icons.business_rounded,
              label: l.settingsOrgSettings,
              subtitle: ref.watch(farmNameProvider).isNotEmpty
                  ? ref.watch(farmNameProvider)
                  : l.settingsOrgSettingsDesc,
              onTap: () => context.push(Routes.orgSettings),
            ),
            _SettingsTile(
              icon: Icons.group_rounded,
              label: l.settingsWorkerMgmt,
              subtitle: l.settingsWorkerMgmtDesc,
              onTap: () => context.push(Routes.workerManagement),
            ),

            const SizedBox(height: 20),
            _SectionHeader(title: l.settingsSectionData),
            _SettingsTile(
              icon: Icons.upload_file_rounded,
              label: l.settingsImport,
              subtitle: l.settingsImportDesc,
              onTap: () => context.push(Routes.csvImport),
              badge: l.settingsImportBadge,
            ),
            _SettingsTile(
              icon: Icons.download_rounded,
              label: l.settingsExport,
              subtitle: l.settingsExportDesc,
              onTap: () {},
              disabled: true,
            ),

            const SizedBox(height: 20),
            _SectionHeader(title: l.settingsSectionPref),
            _SettingsTile(
              icon: Icons.notifications_rounded,
              label: l.settingsNotifications,
              subtitle: l.settingsNotificationsDesc,
              onTap: () => context.push(Routes.notificationSettings),
            ),
            _SettingsTile(
              icon: Icons.calendar_month_rounded,
              label: l.settingsHijriCalendar,
              subtitle: l.settingsHijriCalendarDesc,
              trailing: Switch(
                value: hijriEnabled,
                onChanged: (v) {
                  ref.read(hijriEnabledProvider.notifier).state = v;
                  prefs.setBool(PrefsKeys.hijriEnabled, v);
                },
                activeColor: AppColors.primary,
              ),
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.star_rounded,
              label: l.settingsUdhiyaIndicator,
              subtitle: l.settingsUdhiyaIndicatorDesc,
              trailing: Switch(
                value: udhiyaShow,
                onChanged: (v) {
                  ref.read(udhiyaShowProvider.notifier).state = v;
                  prefs.setBool(PrefsKeys.udhiyaShow, v);
                },
                activeColor: AppColors.primary,
              ),
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.fence_rounded,
              label: l.settingsPens,
              subtitle: l.settingsPensDesc,
              onTap: () => context.push(Routes.penManagement),
            ),
            _SettingsTile(
              icon: Icons.label_outline_rounded,
              label: l.settingsFieldLabels,
              subtitle: l.settingsFieldLabelsDesc,
              onTap: () => context.push(Routes.fieldLabels),
            ),
            _SettingsTile(
              icon: Icons.language_rounded,
              label: l.settingsLanguage,
              subtitle: isAr ? 'العربية' : 'English',
              onTap: () => _showLanguagePicker(context, ref, prefs, isAr, l),
            ),

            const SizedBox(height: 20),
            _SectionHeader(title: l.settingsSectionAccount),
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              label: l.settingsHelp,
              subtitle: l.settingsHelpDesc,
              onTap: () {},
            ),
            _SettingsTile(
              icon: Icons.logout_rounded,
              label: l.settingsLogout,
              subtitle: l.settingsLogoutDesc,
              iconColor: AppColors.statusError,
              labelColor: AppColors.statusError,
              onTap: () => _confirmLogout(context, ref, l),
            ),

            const SizedBox(height: 32),
            Center(
              child: Text(
                'سلالة  v1.0.0',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    SharedPreferences prefs,
    bool isAr,
    AppL l,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.settingsLanguage,
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              _LangOption(
                label: 'العربية',
                sublabel: 'Arabic',
                selected: isAr,
                onTap: () {
                  ref.read(localeProvider.notifier).state = const Locale('ar');
                  prefs.setString(PrefsKeys.locale, 'ar');
                  Navigator.pop(sheetCtx);
                },
              ),
              const SizedBox(height: 10),
              _LangOption(
                label: 'English',
                sublabel: 'الإنجليزية',
                selected: !isAr,
                onTap: () {
                  ref.read(localeProvider.notifier).state = const Locale('en');
                  prefs.setString(PrefsKeys.locale, 'en');
                  Navigator.pop(sheetCtx);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref, AppL l) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          l.settingsLogoutTitle,
          style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700, fontSize: 16),
        ),
        content: Text(
          l.settingsLogoutMsg,
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(l.btnCancel,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.brown)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              // Clear user-specific prefs so the next user who logs in
              // starts with a clean state (fresh onboarding, no stale farm data).
              final prefs = ref.read(sharedPreferencesProvider);
              await prefs.remove(PrefsKeys.farmName);
              await prefs.remove(PrefsKeys.farmLocation);
              await prefs.setBool(PrefsKeys.onboardingDone, false);
              await prefs.remove(PrefsKeys.currentUserUid);
              // Reset in-memory providers immediately so the UI clears
              // before the router redirects to login.
              ref.read(farmNameProvider.notifier).state     = '';
              ref.read(farmLocationProvider.notifier).state = '';
              ref.read(onboardingDoneProvider.notifier).state = false;
              await ref.read(authActionsProvider).signOut();
            },
            child: Text(l.settingsLogout,
                style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.statusError,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

// ── Profile card ───────────────────────────────────────────────────────────────

class _ProfileCard extends ConsumerWidget {
  final VoidCallback onTap;
  const _ProfileCard({required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final l = AppL.of(context);
    final displayName = (user?.displayName?.isNotEmpty == true)
        ? user!.displayName!
        : l.profileUnnamed;
    final phone = user?.phoneNumber ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.onPrimary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('👤', style: TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimary,
                      fontSize: 16,
                    ),
                  ),
                  if (phone.isNotEmpty)
                    Text(
                      phone,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.7),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.onPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '🏆 ${l.roleOwner}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit_rounded,
                color: AppColors.onPrimary.withValues(alpha: 0.7), size: 18),
          ],
        ),
      ),
    );
  }
}

// ── Section header ─────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          fontSize: 11,
        ),
      ),
    );
  }
}

// ── Settings tile ─────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final String? badge;
  final bool disabled;
  final Color iconColor;
  final Color labelColor;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.badge,
    this.disabled = false,
    this.iconColor = AppColors.primary,
    this.labelColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.45 : 1.0,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: labelColor,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.statusActive.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              badge!,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.statusActive,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              trailing ??
                  (disabled
                      ? const SizedBox.shrink()
                      : const Icon(Icons.chevron_right_rounded,
                          color: AppColors.textMuted, size: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Language option tile (used in language picker sheet) ───────────────────────

class _LangOption extends StatelessWidget {
  final String label;
  final String sublabel;
  final bool selected;
  final VoidCallback onTap;
  const _LangOption({
    required this.label,
    required this.sublabel,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.07)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.4)
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    sublabel,
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded,
                  color: AppColors.primary, size: 20)
            else
              const Icon(Icons.circle_outlined,
                  color: AppColors.tan, size: 20),
          ],
        ),
      ),
    );
  }
}
