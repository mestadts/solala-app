import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/livestock_species.dart';
import '../providers/animal_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class QrScannerPage extends ConsumerStatefulWidget {
  const QrScannerPage({super.key});

  @override
  ConsumerState<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends ConsumerState<QrScannerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanAnim;
  late Animation<double> _scanLine;
  bool _showDemoPanel = false;

  @override
  void initState() {
    super.initState();
    _scanAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanLine = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scanAnim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animals = ref.watch(animalsStreamProvider).valueOrNull ?? [];
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Dark camera simulation ────────────────────────────────────
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF0A0A0A),
            child: const Center(
              child: Text(
                '📷',
                style: TextStyle(fontSize: 80, color: Color(0xFF1A1A1A)),
              ),
            ),
          ),

          // ── Scan frame overlay ────────────────────────────────────────
          Center(
            child: SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                children: [
                  // Corner brackets
                  CustomPaint(
                    painter: _ScanFramePainter(),
                    child: const SizedBox.expand(),
                  ),
                  // Animated scan line
                  AnimatedBuilder(
                    animation: _scanLine,
                    builder: (context, _) => Positioned(
                      top: _scanLine.value * 240,
                      left: 20,
                      right: 20,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.primary.withValues(alpha: 0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Top bar ───────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_rounded,
                        color: Colors.white, size: 24),
                    onPressed: () => context.pop(),
                  ),
                  const Spacer(),
                  const Text(
                    'Scan QR Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // ── Label below frame ─────────────────────────────────────────
          Center(
            child: Transform.translate(
              offset: Offset(0, 160),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Point at a Solala QR code',
                    style: AppTypography.bodyMedium.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => setState(() => _showDemoPanel = !_showDemoPanel),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.list_alt_rounded,
                              color: Colors.white, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'Demo: Pick Animal',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Demo animal list ──────────────────────────────────────────
          if (_showDemoPanel)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                constraints: BoxConstraints(maxHeight: screenH * 0.45),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF6EF),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Select animal to simulate scan',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                        itemCount: animals.length,
                        itemBuilder: (context, i) {
                          final a = animals[i];
                          return ListTile(
                            leading: Text(a.species.emoji,
                                style: const TextStyle(fontSize: 26)),
                            title: Text(
                              a.name,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            subtitle: Text(
                              a.systemAnimalId,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.brown,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onTap: () {
                              context.pop();
                              context.push('/home/animals/${a.id}');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Scan frame painter ────────────────────────────────────────────────────────

class _ScanFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const corner = 30.0;
    const r = 6.0;

    // Top-left
    canvas.drawLine(
        Offset(r, corner), Offset(r, r), paint); // vertical
    canvas.drawLine(
        Offset(r, r), Offset(corner, r), paint); // horizontal

    // Top-right
    canvas.drawLine(
        Offset(size.width - r, corner), Offset(size.width - r, r), paint);
    canvas.drawLine(
        Offset(size.width - r, r), Offset(size.width - corner, r), paint);

    // Bottom-left
    canvas.drawLine(Offset(r, size.height - corner),
        Offset(r, size.height - r), paint);
    canvas.drawLine(Offset(r, size.height - r),
        Offset(corner, size.height - r), paint);

    // Bottom-right
    canvas.drawLine(Offset(size.width - r, size.height - corner),
        Offset(size.width - r, size.height - r), paint);
    canvas.drawLine(Offset(size.width - r, size.height - r),
        Offset(size.width - corner, size.height - r), paint);
  }

  @override
  bool shouldRepaint(_ScanFramePainter old) => false;
}
