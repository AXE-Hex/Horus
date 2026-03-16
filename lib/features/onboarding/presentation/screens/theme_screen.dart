import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/theme_provider.dart';
import 'package:hue/features/shared/presentation/widgets/animated_mesh_background.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ThemeScreen extends ConsumerStatefulWidget {
  const ThemeScreen({super.key});

  @override
  ConsumerState<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends ConsumerState<ThemeScreen> {
  Future<void> _selectTheme(ThemeMode mode, String message) async {
    await ref.read(themeControllerProvider.notifier).setTheme(mode);

    if (!mounted) return;

    context.go(
      '/transition',
      extra: {'nextPath': '/login', 'message': message, 'onComplete': null},
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeControllerProvider);
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
                      context.go('/ui-style-selection');
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
                      t.onboarding.choose_app_theme,
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
                    t.onboarding.select_the_lighting_that_suits,
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

                  Row(
                    children: [
                      Expanded(
                        child:
                            _ThemeCard(
                                  title: t.onboarding.light_mode,
                                  icon: LucideIcons.sun,
                                  isDark: false,
                                  isActive:
                                      currentTheme.value == ThemeMode.light,
                                  onTap: () async {
                                    HapticFeedback.selectionClick();
                                    await _selectTheme(
                                      ThemeMode.light,
                                      'Applying Light Theme...',
                                    );
                                  },
                                )
                                .animate()
                                .fadeIn(delay: 600.ms)
                                .scale(begin: const Offset(0.9, 0.9)),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child:
                            _ThemeCard(
                                  title: t.onboarding.dark_mode,
                                  icon: LucideIcons.moon,
                                  isDark: true,
                                  isActive:
                                      currentTheme.value == ThemeMode.dark,
                                  onTap: () async {
                                    HapticFeedback.selectionClick();
                                    await _selectTheme(
                                      ThemeMode.dark,
                                      'Applying Dark Theme...',
                                    );
                                  },
                                )
                                .animate()
                                .fadeIn(delay: 800.ms)
                                .scale(begin: const Offset(0.9, 0.9)),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: index == 2 ? 30 : 8,
                            height: 8,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: index == 2
                                  ? primary
                                  : Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: index == 2
                                  ? [
                                      BoxShadow(
                                        color: primary.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
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

class _ThemeCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isDark;
  final bool isActive;
  final Future<void> Function() onTap;

  const _ThemeCard({
    required this.title,
    required this.icon,
    required this.isDark,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<_ThemeCard>
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
            colors: [
              widget.isDark
                  ? Colors.black.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.15),
              widget.isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? primary.withValues(alpha: 0.25)
                        : widget.isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                    boxShadow: widget.isActive
                        ? [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.3),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(primary),
                          ),
                        )
                      : Icon(
                          widget.icon,
                          size: 36,
                          color: widget.isActive
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.5),
                        ),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.title,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                if (widget.isActive && !_isLoading) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primary.withValues(alpha: 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ).animate().scale(
                    curve: Curves.easeOutBack,
                    duration: 400.ms,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
