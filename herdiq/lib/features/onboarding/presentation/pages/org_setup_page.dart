import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
// mock_auth_provider no longer needed — onboarding uses prefs_provider directly
import '../../../../core/providers/prefs_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';
import '../../../../shared/widgets/herd_text_field.dart';

class OrgSetupPage extends ConsumerStatefulWidget {
  const OrgSetupPage({super.key});

  @override
  ConsumerState<OrgSetupPage> createState() => _OrgSetupPageState();

  /// Creates (or merges) the organization and user documents in Firestore.
  /// Called at the end of onboarding AND at startup for users who completed
  /// onboarding before this fix was deployed.
  /// SetOptions(merge:true) makes it safe to run on every startup.
  static Future<void> bootstrapFirestoreDocs({
    required String uid,
    required String farmName,
    required String farmLocation,
    String? displayName,
    String? phone,
  }) async {
    final db = FirebaseFirestore.instance;

    // Organization document — required by isOrgMember() security rule.
    await db.collection('organizations').doc(uid).set({
      'ownerUserId': uid,
      'workerIds': [],
      'name': farmName,
      'location': farmLocation,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // User profile document — shown in admin panel Users page.
    await db.collection('users').doc(uid).set({
      'displayName': displayName ?? '',
      'phone': phone ?? '',
      'organizationIds': [uid],
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

class _OrgSetupPageState extends ConsumerState<OrgSetupPage> {
  final _formKey    = GlobalKey<FormState>();
  final _orgNameCt  = TextEditingController();
  final _locationCt = TextEditingController();
  final _sizeCt     = TextEditingController();
  bool _isLoading   = false;
  final Set<String> _selectedSpecies = {};

  @override
  void dispose() {
    _orgNameCt.dispose();
    _locationCt.dispose();
    _sizeCt.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // Persist farm name + location so the dashboard can display them
    final prefs = ref.read(sharedPreferencesProvider);
    final name     = _orgNameCt.text.trim();
    final location = _locationCt.text.trim();
    await prefs.setString(PrefsKeys.farmName, name);
    await prefs.setString(PrefsKeys.farmLocation, location);
    ref.read(farmNameProvider.notifier).state     = name;
    ref.read(farmLocationProvider.notifier).state = location;

    // Save preferred species
    final speciesList = _selectedSpecies.toList();
    await prefs.setString(PrefsKeys.preferredSpecies, speciesList.join(','));
    ref.read(preferredSpeciesProvider.notifier).state = speciesList;

    // Tag these prefs with the current user's UID so a future login by a
    // different account can detect and clear stale data.
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) await prefs.setString(PrefsKeys.currentUserUid, uid);

    // Write org + user documents to Firestore so that security rules allow
    // all subsequent data writes (animals, health records, etc.).
    if (uid != null) {
      await OrgSetupPage.bootstrapFirestoreDocs(
        uid: uid,
        farmName: name,
        farmLocation: location,
        displayName: FirebaseAuth.instance.currentUser?.displayName,
        phone: FirebaseAuth.instance.currentUser?.phoneNumber,
      );
    }

    // Mark onboarding complete (persisted) → router auto-redirects to /home/dashboard
    await prefs.setBool(PrefsKeys.onboardingDone, true);
    ref.read(onboardingDoneProvider.notifier).state = true;
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
            // ── Back ─────────────────────────────────────────────────────
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

            // ── Content ──────────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Icon
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.tan.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text('🏡', style: TextStyle(fontSize: 34)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(l.orgSetupTitle, style: AppTypography.displayMedium),
                      const SizedBox(height: 8),
                      Text(
                        l.orgSetupSubtitle,
                        style: AppTypography.bodyMedium,
                      ),

                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdTextField(
                        label: l.orgSetupName,
                        hint: l.orgSetupNameHint,
                        controller: _orgNameCt,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(
                          Icons.business_outlined,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return l.orgSetupNameValidation;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.orgSetupLocation,
                        hint: l.orgSetupLocationHint,
                        controller: _locationCt,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return l.orgSetupLocationValidation;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.itemGap),

                      HerdTextField(
                        label: l.orgSetupHerdSize,
                        hint: l.orgSetupHerdSizeHint,
                        controller: _sizeCt,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _finish(),
                        prefixIcon: const Icon(
                          Icons.pets_outlined,
                          color: AppColors.textMuted,
                          size: 20,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.sectionGap),

                      // Species selection
                      Builder(builder: (ctx) {
                        final isAr = Localizations.localeOf(ctx).languageCode == 'ar';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isAr
                                  ? 'الحيوانات التي تربيها (اختر واحداً أو أكثر)'
                                  : 'Animals you raise (select one or more)',
                              style: AppTypography.labelMedium,
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: LivestockSpecies.values.map((s) {
                                final selected = _selectedSpecies.contains(s.name);
                                final c = s.color;
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    if (selected) {
                                      _selectedSpecies.remove(s.name);
                                    } else {
                                      _selectedSpecies.add(s.name);
                                    }
                                  }),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: selected
                                          ? c.withValues(alpha: 0.12)
                                          : AppColors.surface,
                                      borderRadius:
                                          BorderRadius.circular(AppSpacing.radiusMedium),
                                      border: Border.all(
                                        color: selected ? c : AppColors.tan,
                                        width: selected ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(s.emoji,
                                            style: const TextStyle(fontSize: 20)),
                                        const SizedBox(width: 8),
                                        Text(
                                          isAr ? s.nameAr : s.displayName,
                                          style: AppTypography.bodyMedium.copyWith(
                                            color: selected ? c : AppColors.brown,
                                            fontWeight: selected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      }),

                      const SizedBox(height: AppSpacing.sectionGap),

                      HerdPrimaryButton(
                        label: l.orgSetupFinish,
                        onPressed: _finish,
                        isLoading: _isLoading,
                      ),

                      const SizedBox(height: 20),

                      // Terms note
                      Center(
                        child: Text(
                          l.orgSetupLegal,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
