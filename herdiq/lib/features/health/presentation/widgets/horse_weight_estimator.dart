import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/weight_provider.dart';

/// Horse weight estimator using the standard heart-girth formula:
///   Weight (kg)  = (girth_cm² × length_cm) / 11877
///   Weight (lbs) = (girth_in² × length_in) / 330
class HorseWeightEstimator extends ConsumerStatefulWidget {
  final String animalId;
  const HorseWeightEstimator({super.key, required this.animalId});

  @override
  ConsumerState<HorseWeightEstimator> createState() =>
      _HorseWeightEstimatorState();
}

class _HorseWeightEstimatorState extends ConsumerState<HorseWeightEstimator> {
  final _girthCt = TextEditingController();
  final _lengthCt = TextEditingController();
  bool _useCm = true;
  double? _estimatedWeight;
  bool _isSaving = false;

  @override
  void dispose() {
    _girthCt.dispose();
    _lengthCt.dispose();
    super.dispose();
  }

  void _calculate() {
    final girth = double.tryParse(_girthCt.text.trim());
    final length = double.tryParse(_lengthCt.text.trim());
    if (girth == null || length == null || girth <= 0 || length <= 0) {
      setState(() => _estimatedWeight = null);
      return;
    }
    final weight = _useCm
        ? (girth * girth * length) / 11877
        : (girth * girth * length) / 330;
    setState(() => _estimatedWeight = weight);
  }

  Future<void> _saveAsRecord() async {
    if (_estimatedWeight == null) return;
    setState(() => _isSaving = true);
    final unit = _useCm ? 'kg' : 'lbs';
    final record = MockWeightRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      animalId: widget.animalId,
      weight: double.parse(_estimatedWeight!.toStringAsFixed(1)),
      unit: unit,
      recordedAt: DateTime.now().toIso8601String().substring(0, 10),
      isOfficial: false,
    );
    try {
      await ref.read(weightActionsProvider).addRecord(record);
      if (!mounted) return;
      _girthCt.clear();
      _lengthCt.clear();
      setState(() {
        _estimatedWeight = null;
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Localizations.localeOf(context).languageCode == 'ar'
                ? 'تم حفظ الوزن المُقدَّر'
                : 'Estimated weight saved',
          ),
          backgroundColor: AppColors.statusActive,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Container(
      margin: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding, 12, AppSpacing.screenPadding, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.horse.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
            color: AppColors.horse.withValues(alpha: 0.25), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text('📏', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                isAr ? 'حساب الوزن التقديري' : 'Estimate Weight',
                style: AppTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.horse,
                ),
              ),
              const Spacer(),
              // Unit toggle
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusCircle),
                  border: Border.all(
                      color: AppColors.tan.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _UnitBtn(
                        label: 'cm/kg',
                        active: _useCm,
                        onTap: () {
                          setState(() => _useCm = true);
                          _calculate();
                        }),
                    _UnitBtn(
                        label: 'in/lbs',
                        active: !_useCm,
                        onTap: () {
                          setState(() => _useCm = false);
                          _calculate();
                        }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isAr
                ? 'المعادلة: (محيط البطن² × الطول) ÷ ${_useCm ? '11877' : '330'}'
                : 'Formula: (Girth² × Length) ÷ ${_useCm ? '11877' : '330'}',
            style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 12),

          // Inputs row
          Row(
            children: [
              Expanded(
                child: _MeasureField(
                  label: isAr
                      ? 'محيط البطن (${_useCm ? 'cm' : 'in'})'
                      : 'Girth (${_useCm ? 'cm' : 'in'})',
                  controller: _girthCt,
                  onChanged: (_) => _calculate(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MeasureField(
                  label: isAr
                      ? 'طول الجسم (${_useCm ? 'cm' : 'in'})'
                      : 'Body Length (${_useCm ? 'cm' : 'in'})',
                  controller: _lengthCt,
                  onChanged: (_) => _calculate(),
                ),
              ),
            ],
          ),

          // Result
          if (_estimatedWeight != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.horse.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isAr ? 'الوزن التقديري' : 'Estimated Weight',
                          style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMuted),
                        ),
                        Text(
                          '${_estimatedWeight!.toStringAsFixed(1)} ${_useCm ? 'kg' : 'lbs'}',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.horse,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _isSaving ? null : _saveAsRecord,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_alt_rounded, size: 16),
                    label: Text(isAr ? 'حفظ' : 'Save'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.horse,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MeasureField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _MeasureField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
                fontSize: 11)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          onChanged: onChanged,
          style: AppTypography.bodyMedium,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide:
                  BorderSide(color: AppColors.tan.withValues(alpha: 0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide:
                  BorderSide(color: AppColors.tan.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMedium),
              borderSide: const BorderSide(color: AppColors.horse),
            ),
            filled: true,
            fillColor: AppColors.surface,
          ),
        ),
      ],
    );
  }
}

class _UnitBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _UnitBtn(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: active ? AppColors.horse : Colors.transparent,
          borderRadius:
              BorderRadius.circular(AppSpacing.radiusCircle),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
