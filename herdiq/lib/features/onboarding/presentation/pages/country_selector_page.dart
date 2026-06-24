import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

// ── Country data ──────────────────────────────────────────────────────────────

class _Country {
  final String flag;
  final String name;
  final String code;
  const _Country(this.flag, this.name, this.code);
}

const _countries = [
  _Country('🇸🇦', 'Saudi Arabia', 'SA'),
  _Country('🇦🇪', 'United Arab Emirates', 'AE'),
  _Country('🇰🇼', 'Kuwait', 'KW'),
  _Country('🇶🇦', 'Qatar', 'QA'),
  _Country('🇧🇭', 'Bahrain', 'BH'),
  _Country('🇴🇲', 'Oman', 'OM'),
  _Country('🇯🇴', 'Jordan', 'JO'),
  _Country('🇪🇬', 'Egypt', 'EG'),
  _Country('🇲🇦', 'Morocco', 'MA'),
  _Country('🇩🇿', 'Algeria', 'DZ'),
  _Country('🇹🇳', 'Tunisia', 'TN'),
  _Country('🇱🇾', 'Libya', 'LY'),
  _Country('🇸🇩', 'Sudan', 'SD'),
  _Country('🇮🇶', 'Iraq', 'IQ'),
  _Country('🇵🇰', 'Pakistan', 'PK'),
  _Country('🇹🇷', 'Turkey', 'TR'),
  _Country('🇺🇸', 'United States', 'US'),
  _Country('🇬🇧', 'United Kingdom', 'GB'),
  _Country('🇩🇪', 'Germany', 'DE'),
  _Country('🇫🇷', 'France', 'FR'),
  _Country('🇦🇺', 'Australia', 'AU'),
  _Country('🇧🇷', 'Brazil', 'BR'),
  _Country('🇮🇳', 'India', 'IN'),
  _Country('🇿🇦', 'South Africa', 'ZA'),
];

// ── Page ─────────────────────────────────────────────────────────────────────

class CountrySelectorPage extends StatefulWidget {
  const CountrySelectorPage({super.key});

  @override
  State<CountrySelectorPage> createState() => _CountrySelectorPageState();
}

class _CountrySelectorPageState extends State<CountrySelectorPage> {
  final _searchCt = TextEditingController();
  String _query = '';
  String? _selected;

  @override
  void dispose() {
    _searchCt.dispose();
    super.dispose();
  }

  List<_Country> get _filtered => _query.isEmpty
      ? _countries
      : _countries
          .where((c) =>
              c.name.toLowerCase().contains(_query.toLowerCase()) ||
              c.code.toLowerCase().contains(_query.toLowerCase()))
          .toList();

  void _pick(_Country country) {
    setState(() => _selected = country.code);
    Future.delayed(const Duration(milliseconds: 220), () {
      if (mounted) context.go(Routes.orgType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top bar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 16, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                onPressed: () => context.pop(),
              ),
            ),

            // ── Heading ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                8,
                AppSpacing.screenPadding,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.countryTitle, style: AppTypography.displayMedium),
                  const SizedBox(height: 6),
                  Text(
                    l.countrySubtitle,
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: 20),

                  // Search field
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchCt,
                      onChanged: (v) => setState(() => _query = v),
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: l.countrySearch,
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textMuted,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // ── List ──────────────────────────────────────────────────────
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                itemCount: _filtered.length,
                itemBuilder: (context, i) {
                  final c = _filtered[i];
                  final isSelected = _selected == c.code;
                  return _CountryTile(
                    country: c,
                    isSelected: isSelected,
                    onTap: () => _pick(c),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Country tile ──────────────────────────────────────────────────────────────

class _CountryTile extends StatelessWidget {
  final _Country country;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountryTile({
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),
        child: Row(
          children: [
            Text(country.flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                country.name,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
