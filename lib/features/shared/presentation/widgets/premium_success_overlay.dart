import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PremiumSuccessOverlay extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onFinished;

  const PremiumSuccessOverlay({
    super.key,
    required this.title,
    required this.message,
    required this.onFinished,
  });

  static void show(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    final overlay = OverlayEntry(
      builder: (context) => PremiumSuccessOverlay(
        title: title,
        message: message,
        onFinished: () {
          // This will be called by the widget itself after animation
        },
      ),
    );

    Overlay.of(context).insert(overlay);
    Future.delayed(const Duration(milliseconds: 2500), () {
      overlay.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.black54,
      child: Center(
        child: GlassContainer(
          width: 300,
          padding: const EdgeInsets.all(32),
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  LucideIcons.check,
                  color: theme.primaryColor,
                  size: 48,
                ),
              )
              .animate()
              .scale(
                duration: 600.ms,
                curve: Curves.elasticOut,
                begin: const Offset(0.5, 0.5),
              )
              .shimmer(delay: 600.ms, duration: 1000.ms),
              
              const SizedBox(height: 24),
              
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              
              const SizedBox(height: 12),
              
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
            ],
          ),
        ).animate().scale(
          duration: 400.ms,
          curve: Curves.easeOutBack,
        ).fadeIn(),
      ),
    );
  }
}
