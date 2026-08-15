import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A central class containing all shared design tokens, colors, gradients,
/// decorations, padding, and corner radius configurations for the Horus app.
class SharedStyles {
  SharedStyles._();

  // ==========================================
  // 1. Shared Colors
  // ==========================================
  static const Color primaryLight = Color(0xFF0EA5E9);
  static const Color primaryDark = Color(0xFF38BDF8);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFFF43F5E); // Rose/Coral accent

  static const Color bgLight = Color(0xFFE2E8F0);
  static const Color bgDark = Color(0xFF0A0A1A);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E3A);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glassmorphic Specific Opacities/Colors
  static Color glassWhiteBorder(double opacity) =>
      Colors.white.withValues(alpha: opacity);
  static Color glassBlackBorder(double opacity) =>
      Colors.black.withValues(alpha: opacity);
  static Color glassOverlayColor(bool isDark, double opacity) {
    return (isDark ? const Color(0xFF0F172A) : Colors.white).withValues(
      alpha: opacity,
    );
  }

  // ==========================================
  // 2. Shared Gradients
  // ==========================================
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryLight, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFFB923C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient oceanGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient forestGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient glassBorderGradient = LinearGradient(
    colors: [Colors.white30, Colors.white10, Colors.white30],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ==========================================
  // 3. Shared Shadows & Glows
  // ==========================================
  static List<BoxShadow> subtleShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return [
      BoxShadow(
        color: isDark ? Colors.black45 : Colors.black12,
        blurRadius: 16,
        offset: const Offset(0, 8),
        spreadRadius: -4,
      ),
    ];
  }

  static List<BoxShadow> primaryGlow(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: 20,
        spreadRadius: 2,
        offset: const Offset(0, 4),
      ),
    ];
  }

  // ==========================================
  // 4. Shared Corner Radii
  // ==========================================
  static const double cardRadiusValue = 20.0;
  static const double buttonRadiusValue = 16.0;
  static const double badgeRadiusValue = 8.0;
  static const double glassRadiusValue = 24.0;

  static BorderRadius get cardRadius => BorderRadius.circular(cardRadiusValue);
  static BorderRadius get buttonRadius =>
      BorderRadius.circular(buttonRadiusValue);
  static BorderRadius get badgeRadius =>
      BorderRadius.circular(badgeRadiusValue);
  static BorderRadius get glassRadius =>
      BorderRadius.circular(glassRadiusValue);

  // ==========================================
  // 5. Shared Paddings
  // ==========================================
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  );
  static const EdgeInsets cardPadding = EdgeInsets.all(20.0);
  static const EdgeInsets itemPadding = EdgeInsets.all(12.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 28.0,
    vertical: 16.0,
  );

  // ==========================================
  // 6. Common BoxDecorations
  // ==========================================
  static BoxDecoration cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? surfaceDark : surfaceLight,
      borderRadius: cardRadius,
      border: Border.all(
        color: isDark ? Colors.white12 : const Color(0xFFE2E8F0),
        width: 1,
      ),
      boxShadow: subtleShadow(context),
    );
  }

  static BoxDecoration glassCardDecoration({
    required bool isDark,
    double opacity = 0.08,
  }) {
    return BoxDecoration(
      color: glassOverlayColor(isDark, opacity),
      borderRadius: glassRadius,
      border: Border.all(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.12),
        width: 1.2,
      ),
    );
  }

  // ==========================================
  // 7. Common TextStyles Helper
  // ==========================================
  static TextStyle headingStyle(
    BuildContext context, {
    double fontSize = 24,
    Color? color,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color ?? Theme.of(context).textTheme.titleLarge?.color,
    );
  }

  static TextStyle subtitleStyle(
    BuildContext context, {
    double fontSize = 16,
    Color? color,
  }) {
    return GoogleFonts.outfit(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color:
          color ??
          Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
    );
  }
}
