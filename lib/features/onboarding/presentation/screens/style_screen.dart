import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StyleScreen extends ConsumerStatefulWidget {
  const StyleScreen({super.key});

  @override
  ConsumerState<StyleScreen> createState() => _StyleScreenState();
}

class _StyleScreenState extends ConsumerState<StyleScreen> {
  Future<void> _selectStyle(AppStyle style, String message) async {
    // Apply style immediately for visual feedback
    await ref.read(styleControllerProvider.notifier).setStyle(style);

    if (!mounted) return;

    context.go(
      '/transition',
      extra: {
        'nextPath': '/theme-selection',
        'message': message,
        'onComplete': null, // No longer needed in transition
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStyle = ref.watch(styleControllerProvider);
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
                    onPressed: () => context.go('/language-selection'),
                  ).animate().fadeIn().slideX(begin: -0.5, end: 0),

                  const SizedBox(height: 30),

                  Text(
                    isArabic ? "اختر النمط البصري" : "Choose App Style",
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
                        ? "يمكنك التبديل بين الأنماط في الإعدادات"
                        : "You can switch styles later in settings",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 48),

                  _StyleCard(
                    title: isArabic ? "كلاسيكي ومستقر" : "Classic Solid",
                    description: isArabic
                        ? "أداء عالي وثابت للأجهزة القديمة"
                        : "High performance, flat & solid colors",
                    icon: LucideIcons.layers,
                    isActive: currentStyle.value == AppStyle.classic,
                    onTap: () async {
                      await _selectStyle(
                        AppStyle.classic,
                        'Applying Classic Style...',
                      );
                    },
                  ).animate().fadeIn(delay: 600.ms).slideX(begin: 0.2, end: 0),

                  const SizedBox(height: 12),

                  _StyleCard(
                    title: isArabic ? "حديث ولامع" : "Modern Glass",
                    description: isArabic
                        ? "مؤثرات ضبابية شفافة وتجربة فاخرة"
                        : "Premium frosted glass blur effects",
                    icon: LucideIcons.droplets,
                    isActive: currentStyle.value == AppStyle.glass,
                    isPremium: true,
                    onTap: () async {
                      await _selectStyle(
                        AppStyle.glass,
                        'Applying Glass Style...',
                      );
                    },
                  ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.2, end: 0),

                  const Spacer(),

                  Center(
                    child: Text(
                      isArabic
                          ? 'اقتربنا! خطوة واحدة فقط.'
                          : 'Almost there! Just one more step.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 12,
                        letterSpacing: 1,
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

class _StyleCardState extends State<_StyleCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
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
          colors: widget.isActive
              ? [
                  Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  Theme.of(context).primaryColor.withValues(alpha: 0.05),
                ]
              : widget.isPremium
              ? [
                  Colors.blueAccent.withValues(alpha: 0.1),
                  Colors.purpleAccent.withValues(alpha: 0.1),
                ]
              : [
                  Colors.white.withValues(alpha: 0.05),
                  Colors.white.withValues(alpha: 0.02),
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
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
                        size: 24,
                        color: widget.isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.4),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.title,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (widget.isPremium) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.amber.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              isArabic ? 'مُوصى به' : 'RECOMMENDED',
                              style: GoogleFonts.outfit(
                                fontSize: 7,
                                fontWeight: FontWeight.w900,
                                color: Colors.amber,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.5),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.isActive && !_isLoading)
                const Icon(
                  LucideIcons.check,
                  color: Colors.white,
                  size: 20,
                ).animate().scale().shake(),
            ],
          ),
        ),
      ),
    );
  }
}
