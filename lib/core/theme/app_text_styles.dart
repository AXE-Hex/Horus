import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // ━━ Arabic Font (Cairo) ━━
  static TextStyle get displayLarge => GoogleFonts.cairo(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.25,
        // Negative letterSpacing is allowed on Inter but not Cairo as per rule 289
      );

  static TextStyle get headlineLarge => GoogleFonts.cairo(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
      );

  static TextStyle get headlineMedium => GoogleFonts.cairo(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.35,
      );

  static TextStyle get headlineSmall => GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  // ━━ Body Texts ━━
  static TextStyle get bodyLarge => GoogleFonts.cairo(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.cairo(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodySmall => GoogleFonts.cairo(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  // ━━ Labels and Badges ━━
  static TextStyle get labelLarge => GoogleFonts.cairo(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get labelMedium => GoogleFonts.cairo(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get labelSmall => GoogleFonts.cairo(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  // ━━ English Font & Numbers (Inter) ━━
  static TextStyle get monoLarge => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
      );

  static TextStyle get monoMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get monoSmall => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );
}
