import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'press_feedback.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderSide? borderSide;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final resolvedBg =
        backgroundColor ?? (isDark ? const Color(0xFF1E293B) : AppColors.white);

    final resolvedBorder =
        borderSide ??
        (isDark
            ? const BorderSide(color: Color(0xFF334155), width: 0.5)
            : AppBorders.standard);

    final cardWidget = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.fromBorderSide(resolvedBorder),
      ),
      child: child,
    );

    if (onTap != null) {
      return PressFeedback(
        onTap: onTap,
        hapticType: HapticFeedbackType.light,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}

class UniversityCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const UniversityCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.universityCardGradient,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.fromBorderSide(AppBorders.goldSubtle),
      ),
      child: child,
    );

    if (onTap != null) {
      return PressFeedback(
        onTap: onTap,
        hapticType: HapticFeedbackType.light,
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
