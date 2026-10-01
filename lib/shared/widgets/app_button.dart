import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import 'press_feedback.dart';

enum AppButtonVariant { primary, secondary, tertiary, destructive }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.expandToFill = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final bool expandToFill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = variant == AppButtonVariant.destructive
        ? theme.colorScheme.error
        : theme.colorScheme.primary;
    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == AppButtonVariant.primary
                  ? theme.colorScheme.onPrimary
                  : foreground,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(text, style: AppTextStyles.labelLarge),
            ],
          );
    final minimumSize = Size(expandToFill ? double.infinity : 44, 48);

    return switch (variant) {
      AppButtonVariant.primary => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(minimumSize: minimumSize),
        child: child,
      ),
      AppButtonVariant.secondary ||
      AppButtonVariant.destructive => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: minimumSize,
          foregroundColor: foreground,
          side: BorderSide(color: foreground),
        ),
        child: child,
      ),
      AppButtonVariant.tertiary => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(minimumSize: minimumSize),
        child: child,
      ),
    };
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.navy400 : AppColors.navy600;
    final fg = isDark ? AppColors.navy950 : AppColors.white;

    final buttonWidget = ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        minimumSize: const Size(double.infinity, 50),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: fg),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(text, style: AppTextStyles.labelLarge.copyWith(color: fg)),
              ],
            ),
    );

    if (onPressed != null && !isLoading) {
      return PressFeedback(
        onTap: onPressed,
        hapticType: HapticFeedbackType.medium,
        child: AbsorbPointer(child: buttonWidget),
      );
    }

    return buttonWidget;
  }
}

class GoldButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const GoldButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.md)),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.navy900,
                  ),
                )
              : Text(
                  text,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.navy900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );

    if (onPressed != null && !isLoading) {
      return PressFeedback(
        onTap: onPressed,
        hapticType: HapticFeedbackType.medium,
        child: AbsorbPointer(child: buttonWidget),
      );
    }

    return buttonWidget;
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? AppColors.navy400 : AppColors.navy600;
    final borderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFCDD7EF);

    final buttonWidget = OutlinedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: fg,
        minimumSize: const Size(double.infinity, 48),
        side: BorderSide(color: borderColor, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: fg),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(text, style: AppTextStyles.labelLarge.copyWith(color: fg)),
              ],
            ),
    );

    if (onPressed != null && !isLoading) {
      return PressFeedback(
        onTap: onPressed,
        hapticType: HapticFeedbackType.medium,
        child: AbsorbPointer(child: buttonWidget),
      );
    }

    return buttonWidget;
  }
}
