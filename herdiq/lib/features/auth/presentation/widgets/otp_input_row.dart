import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

/// Six-box OTP input row used in Register and OTP Verify screens.
class OtpInputRow extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const OtpInputRow({super.key, required this.onChanged});

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  final List<TextEditingController> _ctrs =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _ctrs) { c.dispose(); }
    for (final n in _nodes) { n.dispose(); }
    super.dispose();
  }

  String get _value => _ctrs.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, _buildBox),
    );
  }

  Widget _buildBox(int i) {
    return SizedBox(
      width: 48,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          boxShadow: AppShadows.input,
        ),
        child: TextFormField(
          controller: _ctrs[i],
          focusNode: _nodes[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: AppTypography.titleMedium,
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (val) {
            if (val.length == 1 && i < 5) {
              _nodes[i + 1].requestFocus();
            }
            if (val.isEmpty && i > 0) {
              _nodes[i - 1].requestFocus();
            }
            widget.onChanged(_value);
          },
        ),
      ),
    );
  }
}
