import 'package:flutter/material.dart';
import '../../../../core/constants/pen_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

class PenManagementPage extends StatefulWidget {
  const PenManagementPage({super.key});

  @override
  State<PenManagementPage> createState() => _PenManagementPageState();
}

class _PenManagementPageState extends State<PenManagementPage> {
  late List<PenGroup> _pens;

  @override
  void initState() {
    super.initState();
    _pens = List.from(mockPens);
  }

  void _showAddEditSheet({PenGroup? existing}) {
    final l = AppL.of(context);
    final controller = TextEditingController(text: existing?.name ?? '');
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusLarge)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  existing == null ? l.pensAddTitle : l.pensEditTitle,
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    labelText: l.pensNameLabel,
                    hintText: l.pensNameHint,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l.pensNameRequired : null,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(l.btnCancel),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        setState(() {
                          if (existing == null) {
                            _pens.add(PenGroup(
                              id: 'pen_${_pens.length + 1}',
                              name: controller.text.trim(),
                            ));
                          } else {
                            final idx = _pens.indexWhere((p) => p.id == existing.id);
                            if (idx >= 0) {
                              _pens[idx] = PenGroup(
                                id: existing.id,
                                name: controller.text.trim(),
                              );
                            }
                          }
                        });
                        Navigator.of(ctx).pop();
                      },
                      child: Text(l.btnSave),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(PenGroup pen) {
    final l = AppL.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.pensDeleteTitle),
        content: Text(l.pensDeleteMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l.btnCancel),
          ),
          TextButton(
            onPressed: () {
              setState(() => _pens.removeWhere((p) => p.id == pen.id));
              Navigator.of(ctx).pop();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.statusError),
            child: Text(l.btnDelete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.pensTitle, style: AppTypography.titleMedium),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textMuted,
        elevation: 0,
      ),
      body: _pens.isEmpty
          ? Center(
              child: Text(
                l.pensEmpty,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _pens.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (ctx, i) {
                final pen = _pens[i];
                return ListTile(
                  leading: const Icon(Icons.fence_rounded, color: AppColors.primary),
                  title: Text(pen.name, style: AppTypography.bodyMedium),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_rounded, size: 20),
                        onPressed: () => _showAddEditSheet(existing: pen),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 20),
                        color: AppColors.statusError,
                        onPressed: () => _confirmDelete(pen),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditSheet(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: Text(l.pensAddBtn),
      ),
    );
  }
}
