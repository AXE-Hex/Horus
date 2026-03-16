
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/theme_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
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
      extra: {
        'nextPath': '/login',
        'message': message,
        'onComplete': null,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeControllerProvider);

    return GlassScaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () => context.go('/ui-style-selection'),
                  ).animate().fadeIn().slideX(begin: -0.5, end: 0),

                  const SizedBox(height: 30),

                  Text(
                    t.onboarding.choose_app_theme,
                    style: GoogleFonts.outfit(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 12),

                  Text(
                    t.onboarding.select_the_lighting_that_suits,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.5,
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
                                    await _selectTheme(
                                      ThemeMode.light,
                                      'Applying Light Theme...',
                                    );
                                  },
                                )
                                .animate()
                                .fadeIn(delay: 600.ms)
                                .scale(begin: const Offset(0.8, 0.8)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child:
                            _ThemeCard(
                                  title: t.onboarding.dark_mode,
                                  icon: LucideIcons.moon,
                                  isDark: true,
                                  isActive:
                                      currentTheme.value == ThemeMode.dark,
                                  onTap: () async {
                                    await _selectTheme(
                                      ThemeMode.dark,
                                      'Applying Dark Theme...',
                                    );
                                  },
                                )
                                .animate()
                                .fadeIn(delay: 800.ms)
                                .scale(begin: const Offset(0.8, 0.8)),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: index == 2 ? 24 : 8,
                            height: 8,
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: index == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1.seconds),

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

class _ThemeCardState extends State<_ThemeCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              try {
                await widget.onTap();
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        blur: 15,
        border: Border.all(
          color: widget.isActive
              ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
          width: widget.isActive ? 2 : 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.isDark
                ? Colors.black.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.1),
            widget.isDark
                ? Colors.black.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.05),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                      : widget.isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                            blurRadius: 20,
                          ),
                        ]
                      : null,
                ),
                child: _isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : Icon(
                        widget.icon,
                        size: 32,
                        color: widget.isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                      ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (widget.isActive && !_isLoading) ...[
                const SizedBox(height: 8),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                ).animate().scale().shake(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
