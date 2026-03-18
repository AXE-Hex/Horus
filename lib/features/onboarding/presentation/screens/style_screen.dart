import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/animated_mesh_background.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StyleScreen extends ConsumerStatefulWidget {
  const StyleScreen({super.key});

  @override
  ConsumerState<StyleScreen> createState() => _StyleScreenState();
}

class _StyleScreenState extends ConsumerState<StyleScreen> {
  Future<void> _selectStyle(AppStyle style, String message) async {
    await ref.read(styleControllerProvider.notifier).setStyle(style);

    if (!mounted) return;

    context.go(
      '/transition',
      extra: {
        'nextPath': '/theme-selection',
        'message': message,
        'onComplete': null,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStyle = ref.watch(styleControllerProvider);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.go('/language-selection');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.arrowLeft,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ).animate().fadeIn().slideX(begin: -0.5, end: 0),

                  const SizedBox(height: 48),

                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [isDark ? Colors.white : Colors.black87, primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      t.onboarding.choose_app_style,
                      style: GoogleFonts.outfit(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.1,
                        letterSpacing: -1,
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 16),

                  Text(
                    t.onboarding.you_can_switch_styles_later_in,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 48),

                  _StyleCard(
                    title: t.onboarding.classic_solid,
                    description: t.onboarding.high_performance_flat_solid_co,
                    icon: LucideIcons.layers,
                    isActive: currentStyle.value == AppStyle.classic,
                    onTap: () async {
                      HapticFeedback.selectionClick();
                      await _selectStyle(
                        AppStyle.classic,
                        'Applying Classic Style...',
                      );
                    },
                  ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2, end: 0),

                  const SizedBox(height: 20),

                  _StyleCard(
                    title: t.onboarding.modern_glass,
                    description: t.onboarding.premium_frosted_glass_blur_eff,
                    icon: LucideIcons.droplets,
                    isActive: currentStyle.value == AppStyle.glass,
                    isPremium: true,
                    onTap: () async {
                      HapticFeedback.selectionClick();
                      await _selectStyle(
                        AppStyle.glass,
                        'Applying Glass Style...',
                      );
                    },
                  ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.2, end: 0),

                  const Spacer(),

                  Center(
                    child: Text(
                      t.onboarding.almost_there_just_one_more_ste,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1.2.seconds),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StyleCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isActive;
  final bool isPremium;
  final Future<void> Function() onTap;

  const _StyleCard({
    required this.title,
    required this.description,
    required this.icon,
    this.isActive = false,
    this.isPremium = false,
    required this.onTap,
  });

  @override
  State<_StyleCard> createState() => _StyleCardState();
}

class _StyleCardState extends State<_StyleCard>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.96,
      upperBound: 1.0,
    );
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return GestureDetector(
      onTapDown: (_) => _animationController.reverse(),
      onTapUp: (_) async {
        _animationController.forward();
        if (_isLoading) return;

        setState(() => _isLoading = true);
        try {
          await widget.onTap();
        } finally {
          if (mounted) setState(() => _isLoading = false);
        }
      },
      onTapCancel: () => _animationController.forward(),
      child: ScaleTransition(
        scale: _animationController,
        child: GlassContainer(
          borderRadius: BorderRadius.circular(28),
          blur: 20,
          border: Border.all(
            color: widget.isActive
                ? primary.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            width: widget.isActive ? 2 : 1.5,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.isActive
                ? [
                    primary.withValues(alpha: 0.25),
                    primary.withValues(alpha: 0.05),
                  ]
                : widget.isPremium
                ? [
                    Colors.blueAccent.withValues(alpha: 0.15),
                    Colors.purpleAccent.withValues(alpha: 0.08),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.white.withValues(alpha: 0.03),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? primary.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                    boxShadow: widget.isActive
                        ? [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          ),
                        )
                      : Icon(
                          widget.icon,
                          size: 28,
                          color: widget.isActive
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.5),
                        ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (widget.isPremium) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.amber.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Text(
                                t.onboarding.recommended,
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.amber,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.6),
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isActive && !_isLoading)
                  const Icon(LucideIcons.check, color: Colors.white, size: 24)
                      .animate()
                      .scale(curve: Curves.easeOutBack, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
