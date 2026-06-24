import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/custom_fields_provider.dart';

// ── Custom Fields Form Widget ─────────────────────────────────────────────────
//
// Renders a list of custom field inputs based on [CustomFieldDef] definitions.
// Values are stored in a mutable [Map<String, dynamic>] passed via [values].
// Parent widget calls [onChanged] whenever any value changes.

class CustomFieldsForm extends StatelessWidget {
  final List<CustomFieldDef> fields;
  final Map<String, dynamic> values;
  final void Function(String fieldId, dynamic value) onChanged;

  const CustomFieldsForm({
    super.key,
    required this.fields,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty) return const SizedBox.shrink();

    final l    = AppL.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...fields.map((field) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _FieldInput(
                field: field,
                value: values[field.id],
                lang: lang,
                onChanged: (v) => onChanged(field.id, v),
                l: l,
              ),
            )),
      ],
    );
  }
}

// ── Individual field input ────────────────────────────────────────────────────

class _FieldInput extends StatelessWidget {
  final CustomFieldDef field;
  final dynamic value;
  final String lang;
  final void Function(dynamic) onChanged;
  final AppL l;

  const _FieldInput({
    required this.field,
    required this.value,
    required this.lang,
    required this.onChanged,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    final label = field.label(lang);
    final required = field.required;

    Widget input;

    switch (field.fieldType) {
      case CustomFieldType.text:
        input = _textField(label, required);
        break;
      case CustomFieldType.number:
        input = _numberField(label, required);
        break;
      case CustomFieldType.select:
        input = _selectField(label, required);
        break;
      case CustomFieldType.boolean:
        input = _boolField(label);
        break;
    }

    return input;
  }

  Widget _labelWidget(String label, bool isRequired) {
    return Row(
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: AppColors.brown,
          ),
        ),
        if (isRequired)
          const Text(' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _textField(String label, bool required) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(label, required),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value as String? ?? '',
          onChanged: onChanged,
          validator: required
              ? (v) => (v == null || v.isEmpty) ? l.customFieldRequired : null
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: l.customFieldValue,
            hintStyle:
                AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: BorderSide(
                  color: AppColors.tan.withValues(alpha: 0.4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _numberField(String label, bool required) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(label, required),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value?.toString() ?? '',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (s) => onChanged(double.tryParse(s) ?? s),
          validator: required
              ? (v) => (v == null || v.isEmpty) ? l.customFieldRequired : null
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: l.customFieldValue,
            hintStyle:
                AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: BorderSide(
                  color: AppColors.tan.withValues(alpha: 0.4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectField(String label, bool required) {
    final current = value as String?;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(label, required),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border:
                Border.all(color: AppColors.tan.withValues(alpha: 0.4)),
          ),
          child: DropdownButtonFormField<String>(
            value: field.options.contains(current) ? current : null,
            items: field.options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: onChanged,
            validator: required
                ? (v) => v == null ? l.customFieldRequired : null
                : null,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
            ),
            hint: Text(l.customFieldValue,
                style: AppTypography.bodyMedium
                    .copyWith(color: AppColors.textMuted)),
          ),
        ),
      ],
    );
  }

  Widget _boolField(String label) {
    final current = value as bool? ?? false;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: AppColors.brown,
            ),
          ),
        ),
        Switch(
          value: current,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ── Read-only display (for animal_detail_page) ────────────────────────────────

class CustomFieldsDisplay extends StatelessWidget {
  final List<CustomFieldDef> fields;
  final Map<String, dynamic> values;

  const CustomFieldsDisplay({
    super.key,
    required this.fields,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final nonEmpty =
        fields.where((f) => values[f.id] != null).toList();

    if (nonEmpty.isEmpty) return const SizedBox.shrink();

    final l = AppL.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border:
                Border.all(color: AppColors.tan.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: nonEmpty.mapIndexed((i, field) {
              final v = values[field.id];
              final display = _format(v, field.fieldType);
              return Column(
                children: [
                  if (i > 0)
                    Divider(
                        height: 1,
                        color: AppColors.tan.withValues(alpha: 0.2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            field.label(lang),
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.brown,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            display,
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  String _format(dynamic v, CustomFieldType type) {
    if (v == null) return '—';
    if (type == CustomFieldType.boolean) return (v as bool) ? '✓' : '✗';
    return v.toString();
  }
}

// Tiny helper — Dart doesn't have built-in mapIndexed
extension _ListIndexed<T> on List<T> {
  List<R> mapIndexed<R>(R Function(int i, T e) f) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(f(i, this[i]));
    }
    return result;
  }
}
