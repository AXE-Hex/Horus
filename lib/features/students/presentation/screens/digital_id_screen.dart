import 'dart:math' as math;
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/students/data/digital_id_theme_repository.dart';
import 'package:hue/features/students/domain/models/digital_id_theme.dart';
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
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
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
            style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                .copyWith(
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
                  style:
                      (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                          .copyWith(
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
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
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
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(fontSize: 14, color: Colors.white70),
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
    final isArabic = t.$meta.locale.languageCode == 'ar';
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
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
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
      collegeId: studentData['college']?.toString() ?? '',
      specializationId: studentData['specialization']?.toString(),
    );

    return GlassContainer(
      height: 260,
      width: double.infinity,
      borderRadius: BorderRadius.circular(32),
      padding: EdgeInsets.zero,
      blur: 35,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: theme.gradientColors.isNotEmpty
            ? theme.gradientColors
            : [
                theme.primaryColor.withValues(alpha: 0.3),
                const Color(0xFF0F172A).withValues(alpha: 0.6),
              ],
      ),
      child: Stack(
        children: [
          _buildRefractiveEdges(),
          _buildHolographicLayer(theme),
          Positioned(
            right: isArabic ? null : -40,
            left: isArabic ? -40 : null,
            top: -40,
            child: Icon(
              theme.patternIcon,
              size: 240,
              color: Colors.white.withValues(alpha: 0.04),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: SizedBox(
                width:
                    462, // Using a reference width to maintain relative scaling
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
                              color: Colors.white.withValues(alpha: 0.9),
                              size: 22,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isArabic ? 'جامعة حورس' : 'Horus University',
                                  style:
                                      (isArabic
                                              ? GoogleFonts.tajawal()
                                              : GoogleFonts.cinzel())
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 14,
                                            letterSpacing: isArabic ? 0 : 2.5,
                                          ),
                                ),
                                Text(
                                  isArabic
                                      ? 'بِطاقة أكاديمية رقمية'
                                      : 'DIGITAL ACADEMIC CREDENTIAL',
                                  style:
                                      (isArabic
                                              ? GoogleFonts.tajawal()
                                              : GoogleFonts.outfit())
                                          .copyWith(
                                            color: Colors.white30,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 1.5,
                                          ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _buildSecurityChip(theme),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildProfileAvatar(theme),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                studentData['name'] ?? 'Ahmed Mohamed',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    (isArabic
                                            ? GoogleFonts.tajawal()
                                            : GoogleFonts.outfit())
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                          height: 1.1,
                                        ),
                              ),
                              const SizedBox(height: 10),
                              _buildDepartmentTag(theme, isArabic),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDetailsRow(studentData, isArabic),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolographicLayer(DigitalIDTheme theme) {
    return Positioned.fill(
      child:
          Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.0),
                      theme.primaryColor.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.1),
                      theme.secondaryColor.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(duration: 3.seconds, color: Colors.white10),
    );
  }

  Widget _buildSecurityChip(DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(theme.patternIcon, color: theme.secondaryColor, size: 20),
    );
  }

  Widget _buildProfileAvatar(DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.secondaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 42,
        backgroundColor: Color(0xFF0F172A),
        child: Icon(LucideIcons.user, size: 44, color: Colors.white),
      ),
    );
  }

  Widget _buildDepartmentTag(DigitalIDTheme theme, bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.secondaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        theme.name.toUpperCase(),
        style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
            .copyWith(
              color: theme.secondaryColor.withValues(alpha: 0.9),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: isArabic ? 0 : 1.5,
            ),
      ),
    );
  }

  Widget _buildDetailsRow(Map<String, dynamic> studentData, bool isArabic) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStat(
            isArabic ? 'المُعرف' : 'ID NO',
            studentData['id']?.toString() ?? '',
            isArabic,
          ),
          _buildStat(
            isArabic ? 'المستوى' : 'LEVEL',
            studentData['level']?.toString() ?? '',
            isArabic,
          ),
          _buildStat(
            isArabic ? 'المعدل' : 'GPA',
            studentData['gpa']?.toString() ?? '',
            isArabic,
          ),
          _buildStat(isArabic ? 'صلاحية' : 'EXPIRY', '09/2026', isArabic),
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
            color: Colors.white.withValues(alpha: 0.08),
            width: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.inter())
              .copyWith(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 8,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w800,
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
      duration: const Duration(milliseconds: 800),
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
      collegeId: studentData['college']?.toString() ?? '',
      specializationId: studentData['specialization']?.toString(),
    );

    return GlassContainer(
      height: 260,
      width: double.infinity,
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(24),
      blur: 35,
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.15),
        width: 1.5,
      ),
      gradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          const Color(0xFF0F172A).withValues(alpha: 0.9),
          theme.primaryColor.withValues(alpha: 0.4),
        ],
      ),
      child: Stack(
        children: [
          _buildRefractiveEdges(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: theme.secondaryColor.withValues(alpha: 0.4),
                        blurRadius: 40,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.qrCode,
                    size: 110,
                    color: Colors.black,
                  ),
                ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                const SizedBox(height: 24),
                Text(
                  isArabic
                      ? 'امسح للتحقق الرقمي'
                      : 'SCAN FOR ENCRYPTED VERIFICATION',
                  style:
                      (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                          .copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: isArabic ? 0 : 2,
                          ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic
                      ? 'نظام HUE الأمني المتطور'
                      : 'HUE ADVANCED SECURITY',
                  style:
                      (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                          .copyWith(
                            color: Colors.white24,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                ),
                const Icon(
                  LucideIcons.shieldCheck,
                  color: Colors.white24,
                  size: 18,
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
            color: Colors.white.withValues(alpha: 0.08),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
