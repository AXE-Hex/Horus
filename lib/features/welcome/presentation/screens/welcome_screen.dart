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
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassScaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  _buildHolographicCenterpiece(context)
                      .animate()
                      .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 40),

                  _buildHeroText(context)
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 800.ms)
                      .moveY(begin: 30, end: 0, curve: Curves.easeOutQuart),

                  const Spacer(flex: 4),

                  _buildActionButtons(context)
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 800.ms)
                      .moveY(begin: 50, end: 0, curve: Curves.easeOutQuart),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolographicCenterpiece(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).primaryColor.withValues(alpha: 0.3),
                      Theme.of(context).primaryColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
                duration: 4.seconds,
                curve: Curves.easeInOut,
              ),

          GlassContainer(
            width: 160,
            height: 160,
            borderRadius: BorderRadius.circular(40),
            blur: 20,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.15),
                Colors.white.withValues(alpha: 0.05),
              ],
            ),
            child: Center(
              child:
                  Image.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/images/Logo_dark.png'
                            : 'assets/images/Logo_light.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(
                        begin: 0,
                        end: -10,
                        duration: 2.seconds,
                        curve: Curves.easeInOut,
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Column(
      children: [
        Text(
          isArabic ? "بوابة الطالب" : "STUDENT PORTAL",
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -1,
            height: 0.9,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isArabic
              ? "مرحباً بك في نظام الجامعة الذكي. راقب علاماتك، وسجل في موادك، وتواصل مع زملائك."
              : "Welcome to the smart university system. Track grades, register courses, and connect.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Column(
      children: [
        GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                context.go('/language-selection');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 32,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withBlue(255),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isArabic ? "لنبدأ 🚀" : "Get Started 🚀",
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      LucideIcons.arrowRight,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.02, 1.02),
              duration: 2.seconds,
              curve: Curves.easeInOut,
            ),

        const SizedBox(height: 16),

        TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            context.push('/login');
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: Text(
            isArabic ? "لدي حساب بالفعل" : "I already have an account",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
