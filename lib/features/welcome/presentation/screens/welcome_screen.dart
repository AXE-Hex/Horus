import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/shared/presentation/widgets/animated_mesh_background.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          const AnimatedMeshBackground(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  _buildLogoCenterpiece(context, isDark)
                      .animate()
                      .fadeIn(duration: 1000.ms, curve: Curves.easeOut)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),

                  const SizedBox(height: 50),

                  _buildHeroText(context, primary)
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 800.ms)
                      .slideY(begin: 0.3, end: 0, curve: Curves.easeOutQuart),

                  const Spacer(flex: 4),

                  _buildActionButtons(context, primary)
                      .animate()
                      .fadeIn(delay: 900.ms, duration: 800.ms)
                      .slideY(begin: 0.4, end: 0, curve: Curves.easeOutQuart),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoCenterpiece(BuildContext context, bool isDark) {
    return Center(
      child:
          Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.25),
                      blurRadius: 50,
                      spreadRadius: 10,
                    ),
                    if (!isDark)
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                  ],
                ),
                child: Image.asset(
                  isDark
                      ? 'assets/images/Logo_dark.png'
                      : 'assets/images/Logo_light.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .moveY(
                begin: -10,
                end: 10,
                duration: 3.seconds,
                curve: Curves.easeInOutSine,
              ),
    );
  }

  Widget _buildHeroText(BuildContext context, Color primary) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [isDark ? Colors.white : Colors.black87, primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            t.welcome.student_portal,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1.5,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          t.welcome.welcome_to_the_smart_universit,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
            height: 1.5,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, Color primary) {
    return Column(
      children: [
        GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                context.go('/language-selection');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      primary,
                      Color.fromRGBO(
                        (primary.r * 255.0).round(),
                        (primary.g * 255.0).round(),
                        ((primary.b * 255.0).round() < 200)
                            ? (primary.b * 255.0).round() + 50
                            : 255,
                        primary.a,
                      ),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.welcome.get_started,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
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
              curve: Curves.easeInOutSine,
            ),

        const SizedBox(height: 24),

        TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            context.push('/login');
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            t.welcome.i_already_have_an_account,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.8),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
