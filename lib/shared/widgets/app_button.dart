import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

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
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => AppButton(
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    icon: icon,
  );
}

class GoldButton extends StatelessWidget {
  const GoldButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => AppButton(
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    variant: AppButtonVariant.secondary,
  );
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => AppButton(
    text: text,
    onPressed: onPressed,
    isLoading: isLoading,
    icon: icon,
    variant: AppButtonVariant.secondary,
  );
}
