import 'dart:math' as math;
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/students/data/digital_id_theme_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DigitalIDScreen extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const DigitalIDScreen({
    super.key,
    this.studentData = const {
      'name': 'Ahmed Mohamed',
      'id': '20230001',
      'college': 'ai',
      'specialization': 'artificial_cybersecurity',
      'gpa': '3.85',
      'level': '4',
    },
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return GlassScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.x, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          isArabic ? "الهوية الجامعية" : "Digital ID",
          style: GoogleFonts.outfit(
            color: Colors.white,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.share2, color: Colors.white),
            onPressed: () => _showShareDialog(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              // Redesigned Flippable Card
              _FlippableDigitalIDCard(studentData: studentData),

              const SizedBox(height: 40),

              _buildVerificationBadge(context, isArabic),

              const SizedBox(height: 30),
              _buildNFCHint(isArabic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNFCHint(bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.nfc, size: 16, color: Colors.white54),
          const SizedBox(width: 10),
          Text(
            isArabic
                ? 'جاهز للتحقق اللاسلكي'
                : 'Ready for contactless validation',
            style: GoogleFonts.outfit(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildVerificationBadge(BuildContext context, bool isArabic) {
    return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.2),
                blurRadius: 40,
                spreadRadius: -10,
              ),
            ],
          ),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(50),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            blur: 25,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF10B981).withValues(alpha: 0.25),
                const Color(0xFF10B981).withValues(alpha: 0.05),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.5),
              width: 1.5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.shieldCheck,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  isArabic ? 'هوية رقمية آمنة' : 'SECURE DIGITAL PASS',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .scale(delay: 500.ms, duration: 800.ms, curve: Curves.elasticOut)
        .shimmer(duration: 2.seconds, color: Colors.white30);
  }

  void _showShareDialog(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isArabic ? 'مشاركة الهوية الرقمية' : 'Share Digital Identity',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isArabic
                  ? 'تَم إنشاؤها بأمان عبر الجامعة'
                  : 'Generated securely via University Hub',
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: LucideIcons.download,
                  label: isArabic ? 'تنزيل' : 'Download',
                  color: Colors.blueAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.copy,
                  label: isArabic ? 'نسخ المُعرف' : 'Copy ID',
                  color: Colors.orangeAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.send,
                  label: isArabic ? 'مشاركة' : 'Direct Share',
                  color: Colors.greenAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: color.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 32),
            )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(delay: 1.seconds, duration: 2.seconds),
        const SizedBox(height: 14),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _FrontCard extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const _FrontCard({required this.studentData});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college'],
      specializationId: studentData['specialization'],
    );

    return GlassContainer(
      height: 240, // Reduced height to avoid overflow
      width: double.infinity,
      borderRadius: BorderRadius.circular(32),
      padding: EdgeInsets.zero,
      blur: 25, // Adjusted blur
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.1),
        width: 1.5,
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          theme.primaryColor.withValues(alpha: 0.25),
          const Color(0xFF0F172A).withValues(alpha: 0.4),
        ],
      ),
      child: Stack(
        children: [
          // 💎 Refractive Edges
          _buildRefractiveEdges(),

          // Deep Pattern (Watermark)
          Positioned(
            right: -40,
            top: -40,
            child: Icon(
              theme.patternIcon,
              size: 240,
              color: Colors.white.withValues(alpha: 0.03),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          LucideIcons.graduationCap,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic ? 'جامعة حورس' : 'Horus University',
                              style: GoogleFonts.cinzel(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 2.5,
                              ),
                            ),
                            Text(
                              isArabic
                                  ? 'بِطاقة أكاديمية'
                                  : 'ACADEMIC CREDENTIAL',
                              style: GoogleFonts.outfit(
                                color: Colors.white24,
                                fontSize: 7,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.secondaryColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Icon(
                        theme.patternIcon,
                        color: theme.secondaryColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            theme.primaryColor,
                            theme.secondaryColor,
                            theme.primaryColor,
                          ],
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 38,
                        backgroundColor: Color(0xFF0F172A),
                        child: Icon(
                          LucideIcons.user,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentData['name'] ?? 'Ahmed Mohamed',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.secondaryColor.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: theme.secondaryColor.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                            child: Text(
                              isArabic
                                  ? theme.name.toUpperCase()
                                  : theme.name.toUpperCase(),
                              style: GoogleFonts.outfit(
                                color: theme.secondaryColor.withValues(
                                  alpha: 0.8,
                                ),
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.03),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat(
                        isArabic ? 'الرقم الجامعي' : 'STUDENT ID',
                        studentData['id'],
                      ),
                      _buildStat(
                        isArabic ? 'الفصل الدراسي' : 'SEMESTER',
                        studentData['level'],
                      ),
                      _buildStat(
                        isArabic ? 'المعدل التراكمي' : 'GPA UNIT',
                        studentData['gpa'],
                      ),
                      _buildStat(isArabic ? 'صالح حتى' : 'VALID TO', '09/2026'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefractiveEdges() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.3),
            fontSize: 7,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _FlippableDigitalIDCard extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const _FlippableDigitalIDCard({required this.studentData});

  @override
  State<_FlippableDigitalIDCard> createState() =>
      _FlippableDigitalIDCardState();
}

class _FlippableDigitalIDCardState extends State<_FlippableDigitalIDCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  void _toggleCard() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _showFront = !_showFront;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * math.pi;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: angle < math.pi / 2
                ? _FrontCard(studentData: widget.studentData)
                : Transform(
                    transform: Matrix4.identity()..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: _BackCard(studentData: widget.studentData),
                  ),
          );
        },
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final Map<String, dynamic> studentData;

  const _BackCard({required this.studentData});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college'],
      specializationId: studentData['specialization'],
    );

    return GlassContainer(
      height: 240,
      width: double.infinity,
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(28),
      blur: 25,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.1),
        width: 1.5,
      ),
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          const Color(0xFF0F172A).withValues(alpha: 0.8),
          theme.primaryColor.withValues(alpha: 0.3),
        ],
      ),
      child: Stack(
        children: [
          // 💎 Refractive Edges
          _buildRefractiveEdges(),

          // Centered QR Code
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: theme.secondaryColor.withValues(alpha: 0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    LucideIcons.qrCode,
                    size: 100,
                    color: Colors.black.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isArabic
                      ? 'امسح للتحقق من الهوية'
                      : 'SCAN FOR IDENTITY VERIFICATION',
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? 'نظام HUE الأمني' : 'HUE SECURITY SYSTEM',
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Icon(
                  LucideIcons.shieldCheck,
                  color: Colors.white12,
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefractiveEdges() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
    );
  }
}
