import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final BoxBorder? border;

  const AppBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.border,
  });

  factory AppBadge.success({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: AppColors.successContainer,
      textColor: AppColors.success,
    );
  }

  factory AppBadge.warning({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: AppColors.warningContainer,
      textColor: AppColors.warning,
    );
  }

  factory AppBadge.danger({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: AppColors.dangerContainer,
      textColor: AppColors.danger,
    );
  }

  factory AppBadge.gold({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: AppColors.warningContainer,
      textColor: AppColors.gold900,
      border: Border.all(color: AppColors.gold500, width: 1.0),
    );
  }

  factory AppBadge.info({required String label, Key? key}) => AppBadge(
    key: key,
    label: label,
    backgroundColor: AppColors.infoContainer,
    textColor: AppColors.info,
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // In dark mode, adjust background opacities/colors to be softer on dark theme
    Color resolvedBg = backgroundColor;
    Color resolvedText = textColor;
    BoxBorder? resolvedBorder = border;

    if (isDark) {
      if (backgroundColor == AppColors.warningContainer) {
        resolvedBg = AppColors.gold900.withValues(alpha: 0.35);
        resolvedText = AppColors.gold300;
      } else if (backgroundColor == AppColors.successContainer) {
        resolvedBg = AppColors.success.withValues(alpha: 0.25);
        resolvedText = const Color(0xFF7BD3A5);
      } else if (backgroundColor == AppColors.dangerContainer) {
        resolvedBg = AppColors.danger.withValues(alpha: 0.25);
        resolvedText = const Color(0xFFFFA6A0);
      } else if (backgroundColor == AppColors.infoContainer) {
        resolvedBg = AppColors.info.withValues(alpha: 0.25);
        resolvedText = AppColors.navy300;
      }

      if (resolvedBorder != null) {
        resolvedBorder = Border.all(
          color: AppColors.gold500.withValues(alpha: 0.6),
          width: 1.0,
        );
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: resolvedBg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: resolvedBorder,
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: resolvedText,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
