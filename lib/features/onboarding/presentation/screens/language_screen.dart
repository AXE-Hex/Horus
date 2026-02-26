
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/services.dart';

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
    final isArabic = t.$meta.locale.languageCode == 'ar';
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
                    onPressed: () => context.go('/welcome'),
                  ).animate().fadeIn().slideX(begin: -0.5, end: 0),

                  const SizedBox(height: 30),

                  Text(
                    isArabic ? "اختر لغتك" : "Choose Language",
                    style: GoogleFonts.outfit(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 12),

                  Text(
                    isArabic
                        ? "يمكنك تغيير هذا لاحقاً من الإعدادات"
                        : "You can change this later in settings",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 48),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _LanguageCard(
                          title: 'العربية',
                          subtitle: 'Arabic',
                          fontFamily: GoogleFonts.cairo().fontFamily,
                          isActive:
                              LocaleSettings.currentLocale == AppLocale.ar,
                          delay: 100.ms,
                          onTap: () async {
                            HapticFeedback.lightImpact();
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
                            HapticFeedback.lightImpact();
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
                            HapticFeedback.lightImpact();
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
                            HapticFeedback.lightImpact();
                            await _navigateToNext(
                              newLocale: const Locale('zh'),
                            );
                          },
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 600.ms),
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

class _LanguageCardState extends State<_LanguageCard> {
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
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.05),
              width: widget.isActive ? 2 : 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.isActive
                  ? [
                      Theme.of(context).primaryColor.withValues(alpha: 0.2),
                      Theme.of(context).primaryColor.withValues(alpha: 0.05),
                    ]
                  : [
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.02),
                    ],
            ),
            child: Stack(
              children: [
                if (widget.isActive && !_isLoading)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Icon(
                        LucideIcons.check,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ).animate().scale(),

                if (_isLoading)
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: widget.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.4),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms + widget.delay)
        .scale(begin: const Offset(0.9, 0.9));
  }
}
