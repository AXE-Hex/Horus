import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class PulsingDot extends StatelessWidget {
  const PulsingDot({super.key, required this.color, this.size = 8});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class LiveAlertBanner extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;

  const LiveAlertBanner({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // In dark mode: gold-050 background -> gold-500/accent backgrounds or darker
    final bg = isDark ? const Color(0xFF2A2110) : const Color(0xFFFEF9EC);
    final borderCol = AppColors.gold500.withValues(alpha: isDark ? 0.3 : 0.5);
    final textColor = isDark ? const Color(0xFFF4E5A8) : AppColors.neutral900;
    final iconColor = isDark ? AppColors.gold400 : const Color(0xFF8A6A12);

    final bannerWidget = Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: borderCol, width: 1.0),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      child: Row(
        children: [
          const PulsingDot(color: AppColors.gold500),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.labelMedium.copyWith(color: textColor),
            ),
          ),
          Icon(LucideIcons.chevronLeft, size: 16, color: iconColor),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: bannerWidget);
    }

    return bannerWidget;
  }
}
