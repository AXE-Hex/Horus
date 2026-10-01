import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_shadows.dart';
import 'press_feedback.dart';

enum AppCardVariant { standard, academic, premium }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final AppCardVariant variant;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderSide,
    this.variant = AppCardVariant.standard,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final resolvedBg = backgroundColor ??
        switch (variant) {
          AppCardVariant.standard => scheme.surface,
          AppCardVariant.academic => isDark ? AppColors.navy800 : AppColors.navy100,
          AppCardVariant.premium => isDark ? AppColors.navy900 : AppColors.warmWhite,
        };
    final resolvedBorder = borderSide ??
        switch (variant) {
          AppCardVariant.standard => BorderSide(color: isDark ? AppColors.navy700 : AppColors.neutral200),
          AppCardVariant.academic => BorderSide(color: isDark ? AppColors.navy600 : AppColors.navy200),
          AppCardVariant.premium => AppBorders.goldSubtle,
        };
    final cardWidget = Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.fromBorderSide(resolvedBorder),
        boxShadow: AppShadows.forLevel(variant == AppCardVariant.premium ? 2 : 1, dark: isDark),
      ),
      child: child,
    );
    if (onTap != null) {
      return PressFeedback(onTap: onTap, hapticType: HapticFeedbackType.light, child: cardWidget);
    }
    return cardWidget;
  }
}

class UniversityCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  const UniversityCard({super.key, required this.child, this.padding, this.margin, this.onTap});
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
      return PressFeedback(onTap: onTap, hapticType: HapticFeedbackType.light, child: cardWidget);
    }
    return cardWidget;
  }
}
