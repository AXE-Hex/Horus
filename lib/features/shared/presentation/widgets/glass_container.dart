import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';

class GlassContainer extends ConsumerWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
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
    this.color,
    this.gradient,
    this.border,
    this.boxShadow,
    this.blur = 30.0,
    this.opacity = 0.06,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerformance = ref.watch(lowPerformanceControllerProvider);

    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final BorderRadius radius = borderRadius ?? BorderRadius.circular(28);

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
        (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9F9F9)).withValues(
          alpha: 0.95,
        );

    final container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: radius,
        border:
            border ?? Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: child,
    );

    if (onTap != null) return GestureDetector(onTap: onTap, child: container);
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
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? theme.cardColor,
        borderRadius: radius,
        border:
            border ??
            Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) return GestureDetector(onTap: onTap, child: container);
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

    // Optimized Refractive Fluid Gradient
    final glassGradient =
        gradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: isDark ? 0.1 : 0.22), // Shine
            Colors.white.withValues(alpha: 0.01), // Clear
            Colors.black.withValues(alpha: isDark ? 0.04 : 0.02), // Depth
          ],
          stops: const [0.0, 0.45, 1.0],
        );

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.08),
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
              // Liquid Tint Layer
              Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: radius,
                ),
              ),

              // Refraction Layer
              Container(
                decoration: BoxDecoration(
                  gradient: glassGradient,
                  borderRadius: radius,
                ),
              ),

              // Specular Rim (Refractive Edge)
              Container(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border:
                      border ??
                      Border.all(
                        color: Colors.white.withValues(
                          alpha: isDark ? 0.08 : 0.2,
                        ),
                        width: 1.2,
                      ),
                ),
              ),

              // Inner Glow (Liquid Depth)
              _buildInnerGlow(radius, isDark),

              // Content
              Padding(padding: padding ?? EdgeInsets.zero, child: child),

              if (onTap != null)
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: radius,
                      onTap: onTap,
                      splashColor: Colors.white.withValues(alpha: 0.1),
                      highlightColor: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                ),
            ],
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
