import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class WorkerManagementPage extends StatefulWidget {
  const WorkerManagementPage({super.key});

  @override
  State<WorkerManagementPage> createState() => _WorkerManagementPageState();
}

class _WorkerManagementPageState extends State<WorkerManagementPage> {
  final _workers = <_Worker>[
    _Worker(name: 'Faisal Al-Dosari', phone: '+966505555555', role: 'Worker'),
    _Worker(name: 'Nasser Al-Ghamdi', phone: '+966506666666', role: 'Supervisor'),
  ];

  void _showInviteSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => _InviteSheet(
        onInvite: (name, phone, role) {
          setState(() {
            _workers.add(_Worker(name: name, phone: phone, role: role));
          });
          Navigator.pop(sheetCtx);
        },
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
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isRtl
                          ? Icons.arrow_forward_ios_rounded
                          : Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    l.workersTitle,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.person_add_rounded,
                        color: AppColors.primary, size: 22),
                    onPressed: _showInviteSheet,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 16,
                    AppSpacing.screenPadding, 40),
                children: [
                  Text(
                    l.workersCount(_workers.length),
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                  ..._workers.asMap().entries.map((e) => _WorkerTile(
                        worker: e.value,
                        onRemove: () =>
                            setState(() => _workers.removeAt(e.key)),
                      )),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _showInviteSheet,
                    icon: const Icon(Icons.person_add_rounded, size: 18),
                    label: Text(l.workersInviteBtn),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Worker model ───────────────────────────────────────────────────────────────

class _Worker {
  final String name;
  final String phone;
  final String role; // internal value: 'Worker' | 'Supervisor'
  _Worker({required this.name, required this.phone, required this.role});
}

// ── Worker tile ───────────────────────────────────────────────────────────────

class _WorkerTile extends StatelessWidget {
  final _Worker worker;
  final VoidCallback onRemove;
  const _WorkerTile({required this.worker, required this.onRemove});

  String _localizedRole(AppL l) =>
      worker.role == 'Supervisor' ? l.workersRoleSupervisor : l.workersRoleWorker;

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.tan.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
                child: Text('👤', style: TextStyle(fontSize: 20))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.name,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  worker.phone,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _localizedRole(l),
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline,
                color: AppColors.statusError, size: 20),
            onPressed: onRemove,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

// ── Invite sheet ──────────────────────────────────────────────────────────────

class _InviteSheet extends StatefulWidget {
  final Function(String name, String phone, String role) onInvite;
  const _InviteSheet({required this.onInvite});

  @override
  State<_InviteSheet> createState() => _InviteSheetState();
}

class _InviteSheetState extends State<_InviteSheet> {
  final _nameCt = TextEditingController();
  final _phoneCt = TextEditingController();
  String _role = 'Worker'; // internal value
  bool _isLoading = false;

  @override
  void dispose() {
    _nameCt.dispose();
    _phoneCt.dispose();
    super.dispose();
  }

  Future<void> _invite() async {
    if (_nameCt.text.trim().isEmpty || _phoneCt.text.trim().isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    widget.onInvite(_nameCt.text.trim(), _phoneCt.text.trim(), _role);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    // Role options: internal value → localized label
    final roles = [
      ('Worker', l.workersRoleWorker),
      ('Supervisor', l.workersRoleSupervisor),
    ];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.workersInviteTitle,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            HerdTextField(
              label: l.workersInviteNameLabel,
              hint: l.workersInviteNameHint,
              controller: _nameCt,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            HerdTextField(
              label: l.workersInvitePhoneLabel,
              hint: l.workersInvitePhoneHint,
              controller: _phoneCt,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 12),
            Text(l.workersInviteRoleLabel, style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            Row(
              children: roles.map(((String, String) entry) {
                final (value, label) = entry;
                final active = _role == value;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _role = value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsetsDirectional.only(end: 8),
                      height: 44,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMedium),
                        border: Border.all(
                          color:
                              active ? AppColors.primary : AppColors.tan,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: AppTypography.bodyMedium.copyWith(
                            color: active
                                ? AppColors.onPrimary
                                : AppColors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            HerdPrimaryButton(
              label: l.workersInviteSendBtn,
              onPressed: _invite,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
