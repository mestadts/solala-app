import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/mock/mock_data.dart';
import '../../../../core/providers/prefs_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../animals/presentation/providers/animal_provider.dart';
import '../providers/ownership_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class TransferPage extends ConsumerStatefulWidget {
  final String animalId;
  const TransferPage({super.key, required this.animalId});

  @override
  ConsumerState<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends ConsumerState<TransferPage> {
  int _step = 0;
  String _transferType = 'Sale'; // Sale / Gift / Internal
  final _priceCt = TextEditingController();
  String _currency = 'SAR';
  final _phoneCt = TextEditingController();
  bool _documentAttached = false;
  bool _isLoading = false;

  static const _currencies = ['SAR', 'USD', 'AED', 'EUR', 'GBP'];

  @override
  void dispose() {
    _priceCt.dispose();
    _phoneCt.dispose();
    super.dispose();
  }

  void _next() {
    // Skip price step if not Sale
    if (_step == 0 && _transferType != 'Sale') {
      setState(() => _step = 2);
    } else {
      setState(() => _step++);
    }
  }

  void _back() {
    if (_step == 2 && _transferType != 'Sale') {
      setState(() => _step = 0);
    } else if (_step > 0) {
      setState(() => _step--);
    } else {
      context.pop();
    }
  }

  Future<void> _confirm(MockAnimal animal) async {
    setState(() => _isLoading = true);
    final record = MockOwnershipRecord(
      id: 'o-${DateTime.now().millisecondsSinceEpoch}',
      animalId: animal.id,
      animalSystemId: animal.systemAnimalId,
      fromOwner: ref.read(authStateProvider).valueOrNull?.displayName
          ?? ref.read(farmNameProvider),
      toOwner: _phoneCt.text.trim(),
      transferType: _transferType,
      transferDate: DateTime.now().toIso8601String().substring(0, 10),
      price: _transferType == 'Sale'
          ? double.tryParse(_priceCt.text.trim())
          : null,
      currency: _transferType == 'Sale' ? _currency : null,
      notes: _documentAttached ? 'Document attached' : '',
    );

    await ref.read(ownershipActionsProvider).addRecord(record);
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (!mounted) return;
    context.pop();
    context.pop(); // go back to animal detail
  }

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final animal = ref.watch(animalByIdProvider(widget.animalId));

    if (animal == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.background, elevation: 0),
        body: const Center(child: Text('Animal not found')),
      );
    }

    return PopScope(
      canPop: _step == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // ── App bar ────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      onPressed: _back,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.transferTitle,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            animal.name,
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.brown),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      l.stepLabel(_step + 1, 5),
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),

              // ── Step indicator ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding, 16,
                    AppSpacing.screenPadding, 0),
                child: _StepIndicator(current: _step, total: 5),
              ),

              // ── Step content ───────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  child: _buildStep(animal, l),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(MockAnimal animal, AppL l) {
    switch (_step) {
      case 0:
        return _Step1TypeSelector(
          selected: _transferType,
          onChanged: (t) => setState(() => _transferType = t),
          onNext: _next,
          l: l,
        );
      case 1:
        return _Step2Price(
          priceCt: _priceCt,
          currency: _currency,
          currencies: _currencies,
          onCurrencyChanged: (c) => setState(() => _currency = c!),
          onNext: _next,
          l: l,
        );
      case 2:
        return _Step3NewOwner(
          phoneCt: _phoneCt,
          onNext: _next,
          l: l,
        );
      case 3:
        return _Step4Document(
          attached: _documentAttached,
          onAttach: () => setState(() => _documentAttached = true),
          onSkip: _next,
          onNext: _next,
          l: l,
        );
      case 4:
        return _Step5Review(
          animal: animal,
          transferType: _transferType,
          price: double.tryParse(_priceCt.text),
          currency: _currency,
          newOwner: _phoneCt.text.trim(),
          fromOwner: ref.read(authStateProvider).valueOrNull?.displayName
              ?? ref.read(farmNameProvider),
          documentAttached: _documentAttached,
          isLoading: _isLoading,
          onConfirm: () => _confirm(animal),
          l: l,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ── Step indicator ────────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  final int current;
  final int total;
  const _StepIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final done = i < current;
        final active = i == current;
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 4,
                  decoration: BoxDecoration(
                    color: done || active
                        ? AppColors.primary
                        : AppColors.tan.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (i < total - 1) const SizedBox(width: 4),
            ],
          ),
        );
      }),
    );
  }
}

// ── Step 1: Transfer type ─────────────────────────────────────────────────────

class _Step1TypeSelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  final VoidCallback onNext;
  final AppL l;
  const _Step1TypeSelector({
    required this.selected,
    required this.onChanged,
    required this.onNext,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      {'id': 'Sale',     'emoji': '💰', 'title': l.transferTypeSale,     'subtitle': l.transferTypeSaleDesc},
      {'id': 'Gift',     'emoji': '🎁', 'title': l.transferTypeGift,     'subtitle': l.transferTypeGiftDesc},
      {'id': 'Internal', 'emoji': '🔄', 'title': l.transferTypeInternal, 'subtitle': l.transferTypeInternalDesc},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          l.transferTypeTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.transferTypeSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        ...types.map((t) {
          final active = selected == t['id'];
          return GestureDetector(
            onTap: () => onChanged(t['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.primary.withValues(alpha: 0.06)
                    : AppColors.surface,
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusLarge),
                border: Border.all(
                  color: active
                      ? AppColors.primary
                      : AppColors.tan.withValues(alpha: 0.5),
                  width: active ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Text(t['emoji']!, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['title']!,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          t['subtitle']!,
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  if (active)
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.primary, size: 22),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 24),
        HerdPrimaryButton(label: l.btnContinue, onPressed: onNext),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 2: Price ─────────────────────────────────────────────────────────────

class _Step2Price extends StatelessWidget {
  final TextEditingController priceCt;
  final String currency;
  final List<String> currencies;
  final ValueChanged<String?> onCurrencyChanged;
  final VoidCallback onNext;
  final AppL l;
  const _Step2Price({
    required this.priceCt,
    required this.currency,
    required this.currencies,
    required this.onCurrencyChanged,
    required this.onNext,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          l.transferPriceTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.transferPriceSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: HerdTextField(
                label: l.transferPriceLabel,
                hint: l.transferPriceHint,
                controller: priceCt,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.transferCurrencyLabel, style: AppTypography.labelMedium),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currency,
                      items: currencies
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: onCurrencyChanged,
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.primary),
                      dropdownColor: AppColors.surface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        HerdPrimaryButton(label: l.btnContinue, onPressed: onNext),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 3: New owner ─────────────────────────────────────────────────────────

class _Step3NewOwner extends StatefulWidget {
  final TextEditingController phoneCt;
  final VoidCallback onNext;
  final AppL l;
  const _Step3NewOwner({
    required this.phoneCt,
    required this.onNext,
    required this.l,
  });

  @override
  State<_Step3NewOwner> createState() => _Step3NewOwnerState();
}

class _Step3NewOwnerState extends State<_Step3NewOwner> {
  Timer? _debounce;
  List<Map<String, String>> _results = []; // [{name, phone}]
  bool _searching = false;
  String? _selectedName;

  @override
  void initState() {
    super.initState();
    widget.phoneCt.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.phoneCt.removeListener(_onPhoneChanged);
    super.dispose();
  }

  void _onPhoneChanged() {
    final q = widget.phoneCt.text.trim();
    // Clear selection if user edits after picking
    if (_selectedName != null) setState(() => _selectedName = null);
    _debounce?.cancel();
    if (q.length < 7) {
      setState(() { _results = []; _searching = false; });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () => _search(q));
  }

  Future<void> _search(String query) async {
    setState(() => _searching = true);
    try {
      // Normalize: strip leading zero and add +966 if needed for SA numbers
      String normalized = query;
      if (query.startsWith('0') && query.length == 10) {
        normalized = '+966${query.substring(1)}';
      }

      final snap = await FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: normalized)
          .limit(5)
          .get();

      // Also try with the raw input if different
      QuerySnapshot? snap2;
      if (normalized != query) {
        snap2 = await FirebaseFirestore.instance
            .collection('users')
            .where('phone', isEqualTo: query)
            .limit(5)
            .get();
      }

      final all = [
        ...snap.docs,
        if (snap2 != null) ...snap2.docs,
      ];

      if (!mounted) return;
      setState(() {
        _results = all.map((d) {
          final data = d.data() as Map<String, dynamic>;
          return {
            'name': (data['displayName'] as String? ?? '').trim(),
            'phone': (data['phone'] as String? ?? query).trim(),
          };
        }).toList();
        _searching = false;
      });
    } catch (_) {
      if (mounted) setState(() => _searching = false);
    }
  }

  Future<void> _pickFromContacts() async {
    final status = await FlutterContacts.permissions.request(PermissionType.read);
    final granted = status == PermissionStatus.granted || status == PermissionStatus.limited;
    if (!granted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.l.permissionContactsDenied),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    final contactId = await FlutterContacts.native.showPicker();
    if (contactId == null || !mounted) return;

    // Get full contact with phone numbers
    final full = await FlutterContacts.get(contactId, properties: {ContactProperty.phone});
    if (full == null || full.phones.isEmpty) return;

    // Use first phone number, normalize
    String phone = full.phones.first.number.replaceAll(RegExp(r'[\s\-()]'), '');
    if (phone.startsWith('0') && phone.length == 10) {
      phone = '+966${phone.substring(1)}';
    }

    setState(() {
      _selectedName = full.displayName;
      _results = [];
    });
    widget.phoneCt.text = phone;
  }

  void _selectUser(Map<String, String> user) {
    setState(() {
      _selectedName = user['name'];
      _results = [];
    });
    widget.phoneCt.text = user['phone']!;
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.l;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          l.transferNewOwnerTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.transferNewOwnerSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),

        // ── Phone search field ──────────────────────────────────────────────
        HerdTextField(
          label: l.transferPhoneLabel,
          hint: l.transferPhoneHint,
          controller: widget.phoneCt,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          prefixIcon: _searching
              ? const SizedBox(
                  width: 18, height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.textMuted,
                  ),
                )
              : const Icon(Icons.search_rounded,
                  size: 18, color: AppColors.textMuted),
        ),

        // ── Selected user chip ──────────────────────────────────────────────
        if (_selectedName != null && _selectedName!.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.person_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _selectedName!,
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.statusActive, size: 18),
              ],
            ),
          ),
        ],

        // ── Search results ──────────────────────────────────────────────────
        if (_results.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(color: AppColors.tan.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: _results.map((u) {
                final name = u['name'] ?? '';
                final phone = u['phone'] ?? '';
                return InkWell(
                  onTap: () => _selectUser(u),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (name.isNotEmpty)
                                Text(name,
                                    style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600)),
                              Text(phone,
                                  style: AppTypography.bodySmall
                                      .copyWith(color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 14, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],

        // ── Divider + Pick from contacts ────────────────────────────────────
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(l.orLabel,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted)),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _pickFromContacts,
            icon: const Icon(Icons.contacts_rounded, size: 18),
            label: Text(l.transferPickContact),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              textStyle: AppTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 24),
        HerdPrimaryButton(label: l.btnContinue, onPressed: widget.onNext),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 4: Document ──────────────────────────────────────────────────────────

class _Step4Document extends StatelessWidget {
  final bool attached;
  final VoidCallback onAttach;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final AppL l;
  const _Step4Document({
    required this.attached,
    required this.onAttach,
    required this.onSkip,
    required this.onNext,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          l.transferDocTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.transferDocSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: onAttach,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: attached
                  ? AppColors.statusActive.withValues(alpha: 0.08)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                color: attached
                    ? AppColors.statusActive
                    : AppColors.tan.withValues(alpha: 0.5),
                width: attached ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  attached ? '✅' : '📄',
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 10),
                Text(
                  attached ? l.transferDocAttached : l.transferDocTap,
                  style: AppTypography.bodyMedium.copyWith(
                    color: attached
                        ? AppColors.statusActive
                        : AppColors.brown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  attached
                      ? 'transfer_agreement.pdf'
                      : l.transferDocTypes,
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        HerdPrimaryButton(
          label: attached ? l.btnContinue : l.transferDocSkip,
          onPressed: onNext,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

// ── Step 5: Review + Confirm ──────────────────────────────────────────────────

class _Step5Review extends StatelessWidget {
  final MockAnimal animal;
  final String transferType;
  final double? price;
  final String currency;
  final String newOwner;
  final String fromOwner;
  final bool documentAttached;
  final bool isLoading;
  final VoidCallback onConfirm;
  final AppL l;
  const _Step5Review({
    required this.animal,
    required this.transferType,
    required this.price,
    required this.currency,
    required this.newOwner,
    this.fromOwner = '',
    required this.documentAttached,
    required this.isLoading,
    required this.onConfirm,
    required this.l,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          l.transferReviewTitle,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.transferReviewSubtitle,
          style: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),

        // Summary card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _ReviewRow(label: l.transferAnimalLabel, value: '${animal.name} (${animal.systemAnimalId})'),
              _ReviewRow(label: l.transferTypeLabel, value: transferType),
              _ReviewRow(label: l.transferFromLabel, value: fromOwner),
              _ReviewRow(label: l.transferToLabel, value: newOwner.isEmpty ? '—' : newOwner),
              if (price != null)
                _ReviewRow(label: l.transferPriceReview, value: '$price $currency'),
              _ReviewRow(
                  label: l.transferDocLabel,
                  value: documentAttached ? l.transferDocAttachedVal : l.transferDocNone),
              _ReviewRow(
                  label: l.transferDateLabel,
                  value: DateTime.now().toIso8601String().substring(0, 10)),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Warning banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.statusError.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: AppColors.statusError.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.statusError, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l.transferWarning,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.statusError,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        HerdPrimaryButton(
          label: l.transferConfirmBtn,
          onPressed: onConfirm,
          isLoading: isLoading,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  const _ReviewRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
