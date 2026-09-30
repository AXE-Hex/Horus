import 'package:flutter/material.dart';

/// Shared type scale using the platform font stack so theme construction and
/// initial rendering never wait for a remote font download.
class AppTextStyles {
  static TextStyle get displayLarge =>
      const TextStyle(fontSize: 40, fontWeight: FontWeight.w700, height: 1.25);

  static TextStyle get displayMedium =>
      const TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.25);

  static TextStyle get headlineLarge =>
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get headlineMedium =>
      const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.35);

  static TextStyle get headlineSmall =>
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get titleLarge =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get titleMedium =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.45);

  static TextStyle get titleSmall =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get bodyLarge =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6);

  static TextStyle get bodyMedium =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.6);

  static TextStyle get bodySmall =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get labelLarge =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get labelMedium =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get labelSmall =>
      const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.3);

  static TextStyle get monoLarge => const TextStyle(
    fontFamily: 'monospace',
    fontSize: 28,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5,
  );

  static TextStyle get monoMedium => const TextStyle(
    fontFamily: 'monospace',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get monoSmall => const TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
}
