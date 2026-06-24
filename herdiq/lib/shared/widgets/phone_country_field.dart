import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

// ── Country data ─────────────────────────────────────────────────────────────

class CountryInfo {
  final String name;
  final String nameAr;
  final String dialCode;
  final String flag;

  const CountryInfo({
    required this.name,
    required this.nameAr,
    required this.dialCode,
    required this.flag,
  });
}

const List<CountryInfo> kCountries = [
  // Middle East
  CountryInfo(name: 'Saudi Arabia',   nameAr: 'المملكة العربية السعودية', dialCode: '+966', flag: '🇸🇦'),
  CountryInfo(name: 'UAE',            nameAr: 'الإمارات العربية المتحدة', dialCode: '+971', flag: '🇦🇪'),
  CountryInfo(name: 'Kuwait',         nameAr: 'الكويت',                   dialCode: '+965', flag: '🇰🇼'),
  CountryInfo(name: 'Qatar',          nameAr: 'قطر',                      dialCode: '+974', flag: '🇶🇦'),
  CountryInfo(name: 'Bahrain',        nameAr: 'البحرين',                  dialCode: '+973', flag: '🇧🇭'),
  CountryInfo(name: 'Oman',           nameAr: 'عُمان',                    dialCode: '+968', flag: '🇴🇲'),
  CountryInfo(name: 'Jordan',         nameAr: 'الأردن',                   dialCode: '+962', flag: '🇯🇴'),
  CountryInfo(name: 'Egypt',          nameAr: 'مصر',                      dialCode: '+20',  flag: '🇪🇬'),
  CountryInfo(name: 'Iraq',           nameAr: 'العراق',                   dialCode: '+964', flag: '🇮🇶'),
  CountryInfo(name: 'Syria',          nameAr: 'سوريا',                    dialCode: '+963', flag: '🇸🇾'),
  CountryInfo(name: 'Lebanon',        nameAr: 'لبنان',                    dialCode: '+961', flag: '🇱🇧'),
  CountryInfo(name: 'Yemen',          nameAr: 'اليمن',                    dialCode: '+967', flag: '🇾🇪'),
  CountryInfo(name: 'Palestine',      nameAr: 'فلسطين',                   dialCode: '+970', flag: '🇵🇸'),
  CountryInfo(name: 'Libya',          nameAr: 'ليبيا',                    dialCode: '+218', flag: '🇱🇾'),
  CountryInfo(name: 'Sudan',          nameAr: 'السودان',                  dialCode: '+249', flag: '🇸🇩'),
  CountryInfo(name: 'Tunisia',        nameAr: 'تونس',                     dialCode: '+216', flag: '🇹🇳'),
  CountryInfo(name: 'Algeria',        nameAr: 'الجزائر',                  dialCode: '+213', flag: '🇩🇿'),
  CountryInfo(name: 'Morocco',        nameAr: 'المغرب',                   dialCode: '+212', flag: '🇲🇦'),
  CountryInfo(name: 'Mauritania',     nameAr: 'موريتانيا',                dialCode: '+222', flag: '🇲🇷'),
  CountryInfo(name: 'Somalia',        nameAr: 'الصومال',                  dialCode: '+252', flag: '🇸🇴'),
  CountryInfo(name: 'Iran',           nameAr: 'إيران',                    dialCode: '+98',  flag: '🇮🇷'),
  CountryInfo(name: 'Turkey',         nameAr: 'تركيا',                    dialCode: '+90',  flag: '🇹🇷'),
  // Africa
  CountryInfo(name: 'Ethiopia',       nameAr: 'إثيوبيا',                  dialCode: '+251', flag: '🇪🇹'),
  CountryInfo(name: 'Kenya',          nameAr: 'كينيا',                    dialCode: '+254', flag: '🇰🇪'),
  CountryInfo(name: 'Nigeria',        nameAr: 'نيجيريا',                  dialCode: '+234', flag: '🇳🇬'),
  CountryInfo(name: 'South Africa',   nameAr: 'جنوب أفريقيا',             dialCode: '+27',  flag: '🇿🇦'),
  CountryInfo(name: 'Ghana',          nameAr: 'غانا',                     dialCode: '+233', flag: '🇬🇭'),
  // Asia
  CountryInfo(name: 'Pakistan',       nameAr: 'باكستان',                  dialCode: '+92',  flag: '🇵🇰'),
  CountryInfo(name: 'India',          nameAr: 'الهند',                    dialCode: '+91',  flag: '🇮🇳'),
  CountryInfo(name: 'Bangladesh',     nameAr: 'بنغلاديش',                 dialCode: '+880', flag: '🇧🇩'),
  CountryInfo(name: 'Philippines',    nameAr: 'الفلبين',                  dialCode: '+63',  flag: '🇵🇭'),
  CountryInfo(name: 'Indonesia',      nameAr: 'إندونيسيا',                dialCode: '+62',  flag: '🇮🇩'),
  CountryInfo(name: 'Malaysia',       nameAr: 'ماليزيا',                  dialCode: '+60',  flag: '🇲🇾'),
  CountryInfo(name: 'Sri Lanka',      nameAr: 'سريلانكا',                 dialCode: '+94',  flag: '🇱🇰'),
  CountryInfo(name: 'Nepal',          nameAr: 'نيبال',                    dialCode: '+977', flag: '🇳🇵'),
  CountryInfo(name: 'China',          nameAr: 'الصين',                    dialCode: '+86',  flag: '🇨🇳'),
  // Europe
  CountryInfo(name: 'United Kingdom', nameAr: 'المملكة المتحدة',          dialCode: '+44',  flag: '🇬🇧'),
  CountryInfo(name: 'France',         nameAr: 'فرنسا',                    dialCode: '+33',  flag: '🇫🇷'),
  CountryInfo(name: 'Germany',        nameAr: 'ألمانيا',                  dialCode: '+49',  flag: '🇩🇪'),
  CountryInfo(name: 'Spain',          nameAr: 'إسبانيا',                  dialCode: '+34',  flag: '🇪🇸'),
  CountryInfo(name: 'Italy',          nameAr: 'إيطاليا',                  dialCode: '+39',  flag: '🇮🇹'),
  CountryInfo(name: 'Russia',         nameAr: 'روسيا',                    dialCode: '+7',   flag: '🇷🇺'),
  // Americas + Oceania
  CountryInfo(name: 'United States',  nameAr: 'الولايات المتحدة',         dialCode: '+1',   flag: '🇺🇸'),
  CountryInfo(name: 'Canada',         nameAr: 'كندا',                     dialCode: '+1',   flag: '🇨🇦'),
  CountryInfo(name: 'Australia',      nameAr: 'أستراليا',                 dialCode: '+61',  flag: '🇦🇺'),
  CountryInfo(name: 'Brazil',         nameAr: 'البرازيل',                 dialCode: '+55',  flag: '🇧🇷'),
];

// ── Controller ───────────────────────────────────────────────────────────────

/// Holds the selected country + local phone number.
/// Call [fullNumber] to get the E.164 formatted number (e.g. +966501234567).
class PhoneCountryController {
  CountryInfo country;
  final TextEditingController textController;

  PhoneCountryController({
    CountryInfo? initialCountry,
    String initialText = '',
  })  : country = initialCountry ?? kCountries.first, // Saudi Arabia
        textController = TextEditingController(text: initialText);

  /// Returns the E.164 number: dialCode + digits (leading zero stripped).
  /// Saudi users often type 0501234567; stripping the leading 0 gives
  /// +966501234567 which matches Firebase's stored E.164 format.
  String get fullNumber {
    final local = textController.text.trim();
    String digits = local.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.startsWith('0')) digits = digits.substring(1);
    return '${country.dialCode}$digits';
  }

  /// True if the field has any input.
  bool get hasInput => textController.text.trim().isNotEmpty;

  void dispose() => textController.dispose();
}

// ── Main widget ───────────────────────────────────────────────────────────────

class PhoneCountryField extends StatefulWidget {
  final PhoneCountryController controller;
  final String label;
  final String? hint;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const PhoneCountryField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  State<PhoneCountryField> createState() => _PhoneCountryFieldState();
}

class _PhoneCountryFieldState extends State<PhoneCountryField> {
  void _pickCountry() async {
    final picked = await showModalBottomSheet<CountryInfo>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CountryPickerSheet(
        selected: widget.controller.country,
      ),
    );
    if (picked != null && mounted) {
      setState(() => widget.controller.country = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            boxShadow: AppShadows.input,
          ),
          child: Row(
            children: [
              // ── Country button ──────────────────────────────────────────
              GestureDetector(
                onTap: _pickCountry,
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: isRtl
                          ? Radius.zero
                          : Radius.circular(AppSpacing.radiusMedium),
                      bottomLeft: isRtl
                          ? Radius.zero
                          : Radius.circular(AppSpacing.radiusMedium),
                      topRight: isRtl
                          ? Radius.circular(AppSpacing.radiusMedium)
                          : Radius.zero,
                      bottomRight: isRtl
                          ? Radius.circular(AppSpacing.radiusMedium)
                          : Radius.zero,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.controller.country.flag,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.controller.country.dialCode,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
              // ── Divider ─────────────────────────────────────────────────
              Container(
                width: 1,
                height: 32,
                color: AppColors.tan,
              ),
              // ── Phone number input ───────────────────────────────────────
              Expanded(
                child: TextFormField(
                  controller: widget.controller.textController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-\(\)]')),
                  ],
                  textInputAction: widget.textInputAction,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  validator: widget.validator,
                  style:
                      AppTypography.bodyMedium.copyWith(color: AppColors.primary),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        bottomLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        topRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                        bottomRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        bottomLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        topRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                        bottomRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        bottomLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        topRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                        bottomRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                      ),
                      borderSide:
                          const BorderSide(color: AppColors.primary, width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        bottomLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        topRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                        bottomRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                      ),
                      borderSide: const BorderSide(
                          color: AppColors.statusError, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        bottomLeft: isRtl
                            ? Radius.circular(AppSpacing.radiusMedium)
                            : Radius.zero,
                        topRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                        bottomRight: isRtl
                            ? Radius.zero
                            : Radius.circular(AppSpacing.radiusMedium),
                      ),
                      borderSide: const BorderSide(
                          color: AppColors.statusError, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Country picker bottom sheet ───────────────────────────────────────────────

class _CountryPickerSheet extends StatefulWidget {
  final CountryInfo selected;

  const _CountryPickerSheet({required this.selected});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  List<CountryInfo> _filtered = kCountries;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(_onSearch);
  }

  void _onSearch() {
    final q = _searchCtrl.text.toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? kCountries
          : kCountries
              .where((c) =>
                  c.name.toLowerCase().contains(q) ||
                  c.nameAr.contains(q) ||
                  c.dialCode.contains(q))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // ── Handle ────────────────────────────────────────────────────
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.tan,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // ── Search field ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchCtrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: isRtl ? 'ابحث عن الدولة' : 'Search country',
                prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ── Country list ──────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (_, i) {
                final country = _filtered[i];
                final isSelected =
                    country.dialCode == widget.selected.dialCode &&
                        country.name == widget.selected.name;
                return ListTile(
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    isRtl ? country.nameAr : country.name,
                    style: AppTypography.bodyMedium.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.brown,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    country.dialCode,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  onTap: () => Navigator.of(context).pop(country),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
