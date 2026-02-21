// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/students/data/digital_id_theme_repository.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StudentDashboardScreen extends ConsumerWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final auth = ref.watch(authControllerProvider);
    const staggerDelay = Duration(milliseconds: 100);

    return GlassScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildDigitalIDCard(context, isArabic, auth)
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOut)
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withValues(alpha: 0.2),
                ),

            const SizedBox(height: 32),

            _buildSectionHeader(context, isArabic ? "أكاديمي" : "Academic")
                .animate()
                .fadeIn(delay: staggerDelay)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  padding: EdgeInsets.zero,
                  children: [
                    _buildGridItem(
                      context,
                      LucideIcons.fileText,
                      isArabic ? "السجل الأكاديمي" : "Transcript",
                      () => context.push('/transcript'),
                      Colors.blueAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.trendingUp,
                      isArabic ? "المقررات" : "Courses",
                      () => context.push('/progress'),
                      Colors.greenAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.target,
                      isArabic ? "خطة العمل" : "Action Plan",
                      () => context.push('/action-plan'),
                      Colors.purpleAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.award,
                      isArabic ? "نتائج المقررات" : "Subject Results",
                      () => context.push('/subject-result'),
                      Colors.orangeAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.graduationCap,
                      isArabic ? "الهوية الجامعية" : "Digital ID",
                      () => context.push('/digital-id'),
                      Colors.indigoAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.calendar,
                      isArabic ? "الجدول اليومي" : "Daily Schedule",
                      () => context.push('/schedule'),
                      Colors.deepPurpleAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.clipboardCheck,
                      isArabic ? "الغياب والحضور" : "Attendance",
                      () => context.push('/attendance'),
                      Colors.redAccent,
                    ),
                    _buildGridItem(
                      context,
                      LucideIcons.fileSpreadsheet,
                      isArabic ? "جدول الامتحانات" : "Exam Schedule",
                      () => context.push('/exam-schedule'),
                      Colors.amberAccent,
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: staggerDelay * 2)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 24),

            _buildSectionHeader(
                  context,
                  isArabic ? "التسجيل والمالية" : "Enrollment & Finance",
                )
                .animate()
                .fadeIn(delay: staggerDelay * 3)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  padding: EdgeInsets.zero,
                  children: [
                    _buildHorizontalItem(
                      context,
                      LucideIcons.fileText,
                      isArabic ? "التسجيل" : "Registration",
                      () => context.push('/registration'),
                      Colors.tealAccent,
                    ),
                    _buildHorizontalItem(
                      context,
                      LucideIcons.alertCircle,
                      isArabic ? "الفواتير" : "Invoices",
                      () => context.push('/invoices'),
                      Colors.deepOrangeAccent,
                    ),
                    _buildHorizontalItem(
                      context,
                      LucideIcons.creditCard,
                      isArabic ? "الدفع الإلكتروني" : "Payment",
                      () => context.push('/payment'),
                      Colors.pinkAccent,
                    ),
                  ],
                )
                .animate()
                .fadeIn(delay: staggerDelay * 4)
                .slideY(begin: 0.2, end: 0),

            const SizedBox(height: 24),

            _buildSectionHeader(context, isArabic ? "خدمات أخرى" : "Utilities")
                .animate()
                .fadeIn(delay: staggerDelay * 5)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            SizedBox(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    children: [
                      _buildSquareItem(
                        context,
                        LucideIcons.helpCircle,
                        isArabic ? "الشروحات" : "Tutorials",
                        () => context.push('/tutorials'),
                        Colors.blueGrey,
                      ),
                      const SizedBox(width: 12),
                      _buildSquareItem(
                        context,
                        LucideIcons.fingerprint,
                        isArabic ? "الأمان" : "Security",
                        () => context.push('/biometrics'),
                        Colors.redAccent,
                      ),
                      const SizedBox(width: 12),
                      _buildSquareItem(
                        context,
                        LucideIcons.bell,
                        isArabic ? "الإشعارات" : "Notifications",
                        () => context.push('/notifications'),
                        Colors.amberAccent,
                      ),
                      const SizedBox(width: 12),
                      _buildSquareItem(
                        context,
                        LucideIcons.messageSquare,
                        isArabic ? "المنتديات" : "Forums",
                        () => context.push('/forums'),
                        Colors.cyanAccent,
                      ),
                      const SizedBox(width: 12),
                      _buildSquareItem(
                        context,
                        LucideIcons.lifeBuoy,
                        isArabic ? "الدعم الفني" : "Support",
                        () => context.push('/support'),
                        Colors.indigoAccent,
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: staggerDelay * 6)
                .slideX(begin: 0.2, end: 0),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildDigitalIDCard(
    BuildContext context,
    bool isArabic,
    AuthState auth,
  ) {
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: 'ai',
      specializationId: 'artificial_cybersecurity',
    );

    return GestureDetector(
      onTap: () {
        context.push(
          '/digital-id',
          extra: {
            'name': auth.fullName ?? (isArabic ? 'طالب' : 'Student'),
            'id': auth.user?.id ?? '',
            'college': 'ai',
            'specialization': 'artificial_cybersecurity',
            'gpa': '—',
            'level': '—',
          },
        );
      },
      child: Hero(
        tag: 'digital_id_card',
        child: GlassContainer(
          height: 250,
          borderRadius: BorderRadius.circular(32),
          padding: const EdgeInsets.all(28),
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
                      Text(
                        isArabic ? "جامعة حورس" : "Horus University",
                        style: GoogleFonts.cinzel(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      theme.patternIcon,
                      color: theme.secondaryColor,
                      size: 16,
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
                      gradient: LinearGradient(
                        colors: [theme.primaryColor, theme.secondaryColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColor.withValues(alpha: 0.5),
                          blurRadius: 20,
                        ),
                      ],
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
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.fullName ?? (isArabic ? 'طالب' : 'Student'),
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: theme.secondaryColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.secondaryColor.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          child: Text(
                            isArabic
                                ? "الذكاء الاصطناعي"
                                : "ARTIFICIAL INTELLIGENCE",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: theme.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCardStat(
                    'ID',
                    auth.user?.email?.split('@').first ?? '—',
                  ),
                  _buildCardStat('GPA', '—'),
                  _buildCardStat('TERM', '—'),
                  _buildCardStat('EXPIRY', '—'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.4),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.all(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.2),
            accentColor.withValues(alpha: 0.05),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      maxLines: 2,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    LucideIcons.chevronRight,
                    size: 14,
                    color: Theme.of(context).hintColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: EdgeInsets.zero,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.15),
            accentColor.withValues(alpha: 0.05),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                icon,
                size: 100,
                color: accentColor.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: accentColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.arrowRight,
                      size: 14,
                      color: Theme.of(context).hintColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color accentColor,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 100,
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
