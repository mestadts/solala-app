import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _vaccination = true;
  bool _deworming   = true;
  bool _birth       = true;
  bool _weaning     = true;

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.notificationSettingsTitle, style: AppTypography.titleMedium),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textMuted,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _NotifTile(
            icon: Icons.vaccines_rounded,
            label: l.notificationVaccination,
            subtitle: l.notificationVaccinationDesc,
            value: _vaccination,
            onChanged: (v) => setState(() => _vaccination = v),
          ),
          _NotifTile(
            icon: Icons.bug_report_rounded,
            label: l.notificationDeworming,
            subtitle: l.notificationDewormingDesc,
            value: _deworming,
            onChanged: (v) => setState(() => _deworming = v),
          ),
          _NotifTile(
            icon: Icons.pregnant_woman_rounded,
            label: l.notificationBirth,
            subtitle: l.notificationBirthDesc,
            value: _birth,
            onChanged: (v) => setState(() => _birth = v),
          ),
          _NotifTile(
            icon: Icons.child_care_rounded,
            label: l.notificationWeaning,
            subtitle: l.notificationWeaningDesc,
            value: _weaning,
            onChanged: (v) => setState(() => _weaning = v),
          ),
        ],
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotifTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTypography.bodyMedium),
      subtitle: Text(subtitle, style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
    );
  }
}
