import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/shared/presentation/widgets/animated_mesh_background.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  Future<void> _navigateToNext({Locale? newLocale}) async {
    if (newLocale != null) {
      LocaleSettings.setLocale(
        AppLocale.values.firstWhere(
          (l) => l.languageCode == newLocale.languageCode,
        ),
      );
    }

    if (!mounted) return;

    String message;
    switch (newLocale?.languageCode ??
        LocaleSettings.currentLocale.languageCode) {
      case 'ar':
        message = 'جاري التحويل للعربية...';
        break;
      case 'de':
        message = 'Wechsel zu Deutsch...';
        break;
      case 'zh':
        message = '正在切换到中文...';
        break;
      default:
        message = 'Switching to English...';
    }

    context.go(
      '/transition',
      extra: {
        'nextPath': '/ui-style-selection',
        'message': message,
        'newLocale': null,
        'onComplete': null,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).primaryColor;

    return Scaffold(
      body: Stack(
        children: [
          // Premium Background
          const AnimatedMeshBackground(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Back Button High-End Variant
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.go('/welcome');
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

                  // ShaderMask Typography Hero
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [isDark ? Colors.white : Colors.black87, primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      t.onboarding.choose_language,
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
                    t.onboarding.you_can_change_this_later_in_s,
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

                  // Language Selection Grid
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.3,
                      children: [
                        _LanguageCard(
                          title: 'العربية',
                          subtitle: 'Arabic',
                          fontFamily: GoogleFonts.cairo().fontFamily,
                          isActive:
                              LocaleSettings.currentLocale == AppLocale.ar,
                          delay: 100.ms,
                          onTap: () async {
                            HapticFeedback.selectionClick();
                            await _navigateToNext(
                              newLocale: const Locale('ar'),
                            );
                          },
                        ),
                        _LanguageCard(
                          title: 'English',
                          subtitle: 'English',
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          isActive:
                              LocaleSettings.currentLocale == AppLocale.en,
                          delay: 200.ms,
                          onTap: () async {
                            HapticFeedback.selectionClick();
                            await _navigateToNext(
                              newLocale: const Locale('en'),
                            );
                          },
                        ),
                        _LanguageCard(
                          title: 'Deutsch',
                          subtitle: 'German',
                          fontFamily: GoogleFonts.outfit().fontFamily,
                          isActive:
                              LocaleSettings.currentLocale == AppLocale.de,
                          delay: 300.ms,
                          onTap: () async {
                            HapticFeedback.selectionClick();
                            await _navigateToNext(
                              newLocale: const Locale('de'),
                            );
                          },
                        ),
                        _LanguageCard(
                          title: '中文',
                          subtitle: 'Chinese',
                          fontFamily: GoogleFonts.notoSansSc().fontFamily,
                          isActive:
                              LocaleSettings.currentLocale == AppLocale.zh,
                          delay: 400.ms,
                          onTap: () async {
                            HapticFeedback.selectionClick();
                            await _navigateToNext(
                              newLocale: const Locale('zh'),
                            );
                          },
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? fontFamily;
  final bool isActive;
  final Future<void> Function() onTap;
  final Duration delay;

  const _LanguageCard({
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.onTap,
    required this.delay,
    this.fontFamily,
  });

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
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
                    : [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
                      ],
              ),
              child: Stack(
                children: [
                  if (widget.isActive && !_isLoading)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          LucideIcons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ).animate().scale(
                      curve: Curves.easeOutBack,
                      duration: 400.ms,
                    ),

                  if (_isLoading)
                    Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    ),

                  if (!_isLoading)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: widget.fontFamily,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 300.ms + widget.delay)
        .slideY(
          begin: 0.2,
          end: 0,
          curve: Curves.easeOutCubic,
          duration: 600.ms,
        );
  }
}
