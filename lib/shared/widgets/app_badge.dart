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
      backgroundColor: const Color(0xFFF0FDF4),
      textColor: const Color(0xFF16A34A),
    );
  }

  factory AppBadge.warning({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: const Color(0xFFFBF1D8),
      textColor: const Color(0xFF8A6A12),
    );
  }

  factory AppBadge.danger({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: const Color(0xFFFEF2F2),
      textColor: const Color(0xFFDC2626),
    );
  }

  factory AppBadge.gold({required String label, Key? key}) {
    return AppBadge(
      key: key,
      label: label,
      backgroundColor: const Color(0xFFFBF1D8),
      textColor: const Color(0xFF8A6A12),
      border: Border.all(color: const Color(0xFFD4AF37), width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // In dark mode, adjust background opacities/colors to be softer on dark theme
    Color resolvedBg = backgroundColor;
    Color resolvedText = textColor;
    BoxBorder? resolvedBorder = border;

    if (isDark) {
      if (backgroundColor == const Color(0xFFFBF1D8)) {
        // Gold icon/badge background in dark mode
        resolvedBg = const Color(0xFF2A2110);
        resolvedText = const Color(0xFFE8C766);
      } else if (backgroundColor == const Color(0xFFF0FDF4)) {
        resolvedBg = const Color(0xFF14532D).withValues(alpha: 0.4);
        resolvedText = const Color(0xFF4ADE80);
      } else if (backgroundColor == const Color(0xFFFEF2F2)) {
        resolvedBg = const Color(0xFF7F1D1D).withValues(alpha: 0.4);
        resolvedText = const Color(0xFFFCA5A5);
      }
      
      if (resolvedBorder != null) {
        resolvedBorder = Border.all(color: AppColors.gold500.withValues(alpha: 0.6), width: 1.0);
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
