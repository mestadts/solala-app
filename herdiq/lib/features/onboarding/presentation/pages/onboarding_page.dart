import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/herd_primary_button.dart';

// ── Slide index constants ─────────────────────────────────────────────────────

const _kSlideCount = 4;

// ── Page ─────────────────────────────────────────────────────────────────────

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _ctrl = PageController();
  int _page = 0;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < _kSlideCount - 1) {
      _ctrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(Routes.countrySelector);
    }
  }

  void _skip() => context.go(Routes.countrySelector);

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);
    final isLast = _page == _kSlideCount - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Skip button ────────────────────────────────────────────────
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 20, 0),
                child: AnimatedOpacity(
                  opacity: isLast ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: isLast ? null : _skip,
                    child: Text(
                      l.btnSkip,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Slides ────────────────────────────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemCount: _kSlideCount,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => _SlideView(slideIndex: i),
              ),
            ),

            // ── Dots + button ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                0,
                AppSpacing.screenPadding,
                32,
              ),
              child: Column(
                children: [
                  _DotIndicator(count: _kSlideCount, current: _page),
                  const SizedBox(height: 28),
                  HerdPrimaryButton(
                    label: isLast ? l.onboardingGetStarted : l.btnNext,
                    onPressed: _next,
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

// ── Single slide ──────────────────────────────────────────────────────────────

class _SlideView extends StatelessWidget {
  final int slideIndex;
  const _SlideView({required this.slideIndex});

  @override
  Widget build(BuildContext context) {
    final l = AppL.of(context);

    final slides = [
      _SlideData(
        emoji: '🐄',
        title: l.onboardingSlide1Title,
        body: l.onboardingSlide1Desc,
      ),
      _SlideData(
        emoji: '💉',
        title: l.onboardingSlide2Title,
        body: l.onboardingSlide2Desc,
      ),
      _SlideData(
        emoji: '📲',
        title: l.onboardingSlide3Title,
        body: l.onboardingSlide3Desc,
      ),
      _SlideData(
        emoji: '🔒',
        title: l.onboardingSlide4Title,
        body: l.onboardingSlide4Desc,
      ),
    ];

    final slide = slides[slideIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Big emoji in circle
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.tan.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(slide.emoji,
                  style: const TextStyle(fontSize: 64)),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            slide.title,
            style: AppTypography.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            slide.body,
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  final String emoji;
  final String title;
  final String body;
  const _SlideData({
    required this.emoji,
    required this.title,
    required this.body,
  });
}

// ── Dot indicator ─────────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int count;
  final int current;
  const _DotIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: active ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.tan,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
