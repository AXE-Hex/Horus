import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/shared_styles.dart';

class AppTheme {
  static const Color primaryLight = SharedStyles.primaryLight;
  static const Color primaryDark = SharedStyles.primaryDark;
  static const Color secondaryColor = SharedStyles.secondary;

  static const Color bgLight = SharedStyles.bgLight;
  static const Color bgDark = SharedStyles.bgDark;
  static const Color surfaceLight = SharedStyles.surfaceLight;
  static const Color surfaceDark = SharedStyles.surfaceDark;

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        brightness: Brightness.light,
        primary: primaryLight,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        surface: bgLight,
        onSurface: const Color(0xFF020617),
        surfaceContainer: surfaceLight,
      ),
      scaffoldBackgroundColor: bgLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF020617),
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: SharedStyles.cardRadius,
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: SharedStyles.buttonRadius,
          ),
          padding: SharedStyles.buttonPadding,
          elevation: 8,
          shadowColor: primaryLight.withValues(alpha: 0.3),
        ),
      ),
      textTheme: GoogleFonts.tajawalTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF0F172A),
        ),
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0F172A),
        ),
        bodyMedium: const TextStyle(color: Color(0xFF334155)),
        bodySmall: const TextStyle(color: Color(0xFF64748B)),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        brightness: Brightness.dark,
        primary: primaryDark,
        onPrimary: bgDark,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        surface: bgDark,
        onSurface: Colors.white,
        surfaceContainer: surfaceDark,
      ),
      scaffoldBackgroundColor: bgDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: SharedStyles.cardRadius,
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryDark,
          foregroundColor: bgDark,
          shape: RoundedRectangleBorder(
            borderRadius: SharedStyles.buttonRadius,
          ),
          padding: SharedStyles.buttonPadding,
          elevation: 12,
          shadowColor: primaryDark.withValues(alpha: 0.4),
        ),
      ),
      textTheme: GoogleFonts.tajawalTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyMedium: const TextStyle(color: Color(0xFFE2E8F0)),
        bodySmall: const TextStyle(color: Color(0xFF94A3B8)),
      ),
    );
  }
}
