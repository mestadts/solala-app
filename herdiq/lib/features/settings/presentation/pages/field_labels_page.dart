import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/field_labels_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/herd_primary_button.dart';

class FieldLabelsPage extends ConsumerStatefulWidget {
  const FieldLabelsPage({super.key});

  @override
  ConsumerState<FieldLabelsPage> createState() => _FieldLabelsPageState();
}

class _FieldLabelsPageState extends ConsumerState<FieldLabelsPage> {
  // One pair of controllers per field
  final _tagArCt         = TextEditingController();
  final _tagEnCt         = TextEditingController();
  final _tagColorArCt    = TextEditingController();
  final _tagColorEnCt    = TextEditingController();
  final _colorArCt       = TextEditingController();
  final _colorEnCt       = TextEditingController();
  final _breedArCt       = TextEditingController();
  final _breedEnCt       = TextEditingController();
  final _penArCt         = TextEditingController();
  final _penEnCt         = TextEditingController();

  bool _loaded  = false;
  bool _saving  = false;
  String _savedMsg = '';

  @override
  void initState() {
    super.initState();
    // Populate from current Firestore values after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _populate());
  }

  void _populate() {
    if (_loaded) return;
    final labels = ref.read(fieldLabelsProvider).valueOrNull;
    if (labels == null) return;
    _tagArCt.text         = labels.tagLabelAr         ?? '';
    _tagEnCt.text         = labels.tagLabelEn         ?? '';
    _tagColorArCt.text    = labels.tagColorLabelAr    ?? '';
    _tagColorEnCt.text    = labels.tagColorLabelEn    ?? '';
    _colorArCt.text       = labels.animalColorLabelAr ?? '';
    _colorEnCt.text       = labels.animalColorLabelEn ?? '';
    _breedArCt.text       = labels.breedLabelAr       ?? '';
    _breedEnCt.text       = labels.breedLabelEn       ?? '';
    _penArCt.text         = labels.penLabelAr         ?? '';
    _penEnCt.text         = labels.penLabelEn         ?? '';
    _loaded = true;
  }

  @override
  void dispose() {
    _tagArCt.dispose(); _tagEnCt.dispose();
    _tagColorArCt.dispose(); _tagColorEnCt.dispose();
    _colorArCt.dispose(); _colorEnCt.dispose();
    _breedArCt.dispose(); _breedEnCt.dispose();
    _penArCt.dispose(); _penEnCt.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    final actions = ref.read(fieldLabelsActionsProvider);
    if (actions == null) return;
    setState(() => _saving = true);
    try {
      final labels = FieldLabels(
        tagLabelAr:         _tagArCt.text.trim().isNotEmpty      ? _tagArCt.text.trim()      : null,
        tagLabelEn:         _tagEnCt.text.trim().isNotEmpty      ? _tagEnCt.text.trim()      : null,
        tagColorLabelAr:    _tagColorArCt.text.trim().isNotEmpty ? _tagColorArCt.text.trim() : null,
        tagColorLabelEn:    _tagColorEnCt.text.trim().isNotEmpty ? _tagColorEnCt.text.trim() : null,
        animalColorLabelAr: _colorArCt.text.trim().isNotEmpty    ? _colorArCt.text.trim()    : null,
        animalColorLabelEn: _colorEnCt.text.trim().isNotEmpty    ? _colorEnCt.text.trim()    : null,
        breedLabelAr:       _breedArCt.text.trim().isNotEmpty    ? _breedArCt.text.trim()    : null,
        breedLabelEn:       _breedEnCt.text.trim().isNotEmpty    ? _breedEnCt.text.trim()    : null,
        penLabelAr:         _penArCt.text.trim().isNotEmpty      ? _penArCt.text.trim()      : null,
        penLabelEn:         _penEnCt.text.trim().isNotEmpty      ? _penEnCt.text.trim()      : null,
      );
      await actions.save(labels);
      if (mounted) {
        setState(() { _savedMsg = AppL.of(context).fieldLabelsSaved; });
        Future.delayed(const Duration(seconds: 2),
            () { if (mounted) setState(() => _savedMsg = ''); });
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _resetAll() {
    _tagArCt.clear(); _tagEnCt.clear();
    _tagColorArCt.clear(); _tagColorEnCt.clear();
    _colorArCt.clear(); _colorEnCt.clear();
    _breedArCt.clear(); _breedEnCt.clear();
    _penArCt.clear(); _penEnCt.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l   = AppL.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    // Populate once labels stream arrives
    ref.listen(fieldLabelsProvider, (_, next) {
      if (!_loaded && next.hasValue) _populate();
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          l.fieldLabelsPageTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _resetAll,
            child: Text(
              l.fieldLabelsResetAll,
              style: AppTypography.bodySmall.copyWith(color: AppColors.brown),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 8,
              AppSpacing.screenPadding, 120),
          children: [
            // Subtitle
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                l.fieldLabelsPageSubtitle,
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.primary),
              ),
            ),

            _LabelRow(
              title: l.fieldLabelsTagLabel,
              icon: '🏷️',
              arCt: _tagArCt,
              enCt: _tagEnCt,
              arHint: l.fieldLabelsArPlaceholder,
              enHint: l.fieldLabelsEnPlaceholder,
              isAr: isAr,
              onClear: () { _tagArCt.clear(); _tagEnCt.clear(); setState(() {}); },
            ),
            const SizedBox(height: 14),

            _LabelRow(
              title: l.fieldLabelsTagColorLabel,
              icon: '🎨',
              arCt: _tagColorArCt,
              enCt: _tagColorEnCt,
              arHint: l.fieldLabelsArPlaceholder,
              enHint: l.fieldLabelsEnPlaceholder,
              isAr: isAr,
              onClear: () { _tagColorArCt.clear(); _tagColorEnCt.clear(); setState(() {}); },
            ),
            const SizedBox(height: 14),

            _LabelRow(
              title: l.fieldLabelsAnimalColorLabel,
              icon: '🔵',
              arCt: _colorArCt,
              enCt: _colorEnCt,
              arHint: l.fieldLabelsArPlaceholder,
              enHint: l.fieldLabelsEnPlaceholder,
              isAr: isAr,
              onClear: () { _colorArCt.clear(); _colorEnCt.clear(); setState(() {}); },
            ),
            const SizedBox(height: 14),

            _LabelRow(
              title: l.fieldLabelsBreedLabel,
              icon: '🐑',
              arCt: _breedArCt,
              enCt: _breedEnCt,
              arHint: l.fieldLabelsArPlaceholder,
              enHint: l.fieldLabelsEnPlaceholder,
              isAr: isAr,
              onClear: () { _breedArCt.clear(); _breedEnCt.clear(); setState(() {}); },
            ),
            const SizedBox(height: 14),

            _LabelRow(
              title: l.fieldLabelsPenLabel,
              icon: '🏠',
              arCt: _penArCt,
              enCt: _penEnCt,
              arHint: l.fieldLabelsArPlaceholder,
              enHint: l.fieldLabelsEnPlaceholder,
              isAr: isAr,
              onClear: () { _penArCt.clear(); _penEnCt.clear(); setState(() {}); },
            ),
            const SizedBox(height: 32),

            HerdPrimaryButton(
              label: _saving ? '...' : l.fieldLabelsSaveBtn,
              isLoading: _saving,
              onPressed: _save,
            ),

            if (_savedMsg.isNotEmpty) ...[
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _savedMsg,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.statusActive),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Label row widget ──────────────────────────────────────────────────────────

class _LabelRow extends StatelessWidget {
  final String title;
  final String icon;
  final TextEditingController arCt;
  final TextEditingController enCt;
  final String arHint;
  final String enHint;
  final bool isAr;
  final VoidCallback onClear;

  const _LabelRow({
    required this.title,
    required this.icon,
    required this.arCt,
    required this.enCt,
    required this.arHint,
    required this.enHint,
    required this.isAr,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = arCt.text.isNotEmpty || enCt.text.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              if (hasValue)
                GestureDetector(
                  onTap: onClear,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.tan.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isAr ? 'مسح' : 'Clear',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.brown, fontSize: 11),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Arabic field
          Row(
            children: [
              Container(
                width: 28,
                alignment: Alignment.center,
                child: Text('ع',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: arCt,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: arHint,
                    hintTextDirection: TextDirection.rtl,
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // English field
          Row(
            children: [
              Container(
                width: 28,
                alignment: Alignment.center,
                child: Text('EN',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    )),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: enCt,
                  decoration: InputDecoration(
                    hintText: enHint,
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
