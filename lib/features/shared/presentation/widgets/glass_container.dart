import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/utils/responsive_helper.dart';

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
    final theme = Theme.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final defaultRadius = isMobile ? 24.0 : 32.0;
    final BorderRadius radius =
        borderRadius ?? BorderRadius.circular(defaultRadius);

    return _buildClassic(context, radius, theme);
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
        gradient: gradient,
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
}
