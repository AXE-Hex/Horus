import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';
import 'package:hue/core/utils/responsive_helper.dart';

class GlassContainer extends ConsumerWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final double blur;
  final double opacity;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.color,
    this.gradient,
    this.border,
    this.boxShadow,
    this.blur = 30.0,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerformance = ref.watch(lowPerformanceControllerProvider);

    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isMobile = ResponsiveHelper.isMobile(context);
    final defaultRadius = isMobile ? 24.0 : 32.0;
    final BorderRadius radius =
        borderRadius ?? BorderRadius.circular(defaultRadius);

    if (!isGlass) {
      return _buildClassic(context, radius, theme);
    }

    if (isLowPerformance) {
      return _buildFlat(context, radius, isDark);
    }

    return _buildLiquidGlass(context, radius, isDark);
  }

  Widget _buildFlat(BuildContext context, BorderRadius radius, bool isDark) {
    final baseColor =
        color ??
        (isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9)).withValues(
          alpha: 0.95,
        );

    final container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: radius,
        border:
            border ??
            Border.all(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.1,
              ),
            ),
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: radius,
        child: container,
      );
    }
    return container;
  }

  Widget _buildClassic(
    BuildContext context,
    BorderRadius radius,
    ThemeData theme,
  ) {
    final container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color ?? theme.cardTheme.color ?? theme.cardColor,
        borderRadius: radius,
        border:
            border ??
            (theme.cardTheme.shape is RoundedRectangleBorder
                ? Border.fromBorderSide(
                    (theme.cardTheme.shape as RoundedRectangleBorder).side,
                  )
                : Border.all(color: theme.dividerColor.withValues(alpha: 0.1))),
        boxShadow:
            boxShadow ??
            (theme.cardTheme.elevation != null && theme.cardTheme.elevation! > 0
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : []),
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: radius,
          child: container,
        ),
      );
    }
    return container;
  }

  Widget _buildLiquidGlass(
    BuildContext context,
    BorderRadius radius,
    bool isDark,
  ) {
    final baseColor =
        color ??
        (isDark ? Colors.black : Colors.white).withValues(alpha: opacity);

    final glassGradient =
        gradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: isDark ? 0.12 : 0.22),
            Colors.white.withValues(alpha: 0.01),
            Colors.black.withValues(alpha: isDark ? 0.06 : 0.02),
          ],
          stops: const [0.0, 0.45, 1.0],
        );

    final isMobile = ResponsiveHelper.isMobile(context);
    final responsivePadding = padding ?? EdgeInsets.all(isMobile ? 16 : 24);

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow:
              boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                  spreadRadius: -5,
                ),
              ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: radius,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: glassGradient,
                    borderRadius: radius,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border:
                        border ??
                        Border.all(
                          color: Colors.white.withValues(
                            alpha: isDark ? 0.12 : 0.2,
                          ),
                          width: 1.5,
                        ),
                  ),
                ),

                _buildInnerGlow(radius, isDark),

                Padding(padding: responsivePadding, child: child),

                if (onTap != null)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: radius,
                        onTap: onTap,
                        onLongPress: onLongPress,
                        splashColor: Colors.white.withValues(alpha: 0.1),
                        highlightColor: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInnerGlow(BorderRadius radius, bool isDark) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: RadialGradient(
            center: const Alignment(-0.6, -0.6),
            radius: 1.2,
            colors: [
              Colors.white.withValues(alpha: isDark ? 0.05 : 0.1),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
