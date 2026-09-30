import 'package:flutter/material.dart';

/// Canonical Horus palette. Feature screens should use theme roles first and
/// these scale values only for branded or semantic accents.
abstract final class AppColors {
  static const navy950 = Color(0xFF07111F);
  static const navy900 = Color(0xFF0A1730);
  static const navy800 = Color(0xFF10213A);
  static const navy700 = Color(0xFF17365F);
  static const navy600 = Color(0xFF214A80);
  static const navy500 = Color(0xFF2E5D9A);
  static const navy400 = Color(0xFF5B83B8);
  static const navy300 = Color(0xFF91ADD0);
  static const navy200 = Color(0xFFC5D3E5);
  static const navy100 = Color(0xFFE7EDF5);

  static const gold900 = Color(0xFF725514);
  static const gold700 = Color(0xFF987421);
  static const gold600 = Color(0xFFB08A2E);
  static const gold500 = Color(0xFFC5A044);
  static const gold400 = Color(0xFFD9B75F);
  static const gold300 = Color(0xFFE8D08A);

  static const white = Color(0xFFFFFFFF);
  static const warmWhite = Color(0xFFFFFEFC);
  static const neutral050 = Color(0xFFF7F8FA);
  static const neutral100 = Color(0xFFF0F2F5);
  static const neutral200 = Color(0xFFE1E5EB);
  static const neutral300 = Color(0xFFCDD3DC);
  static const neutral400 = Color(0xFFA5AEBB);
  static const neutral500 = Color(0xFF778293);
  static const neutral600 = Color(0xFF5D6878);
  static const neutral700 = Color(0xFF414B5A);
  static const neutral800 = Color(0xFF293342);
  static const neutral900 = Color(0xFF172130);

  static const success = Color(0xFF24845A);
  static const successContainer = Color(0xFFE5F4EC);
  static const warning = Color(0xFFAD7217);
  static const warningContainer = Color(0xFFFFF3D9);
  static const danger = Color(0xFFB64242);
  static const dangerContainer = Color(0xFFFCE9E7);
  static const info = Color(0xFF3375A5);
  static const infoContainer = Color(0xFFE6F1F8);

  static const lightBackground = Color(0xFFF6F7F9);
  static const lightSurface = white;
  static const darkBackground = Color(0xFF081421);
  static const darkSurface = navy900;
  static const darkSurfaceElevated = navy800;

  // Compatibility gradients for legacy surfaces while they are migrated.
  static const goldGradient = LinearGradient(
    colors: [gold400, gold600],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const universityCardGradient = LinearGradient(
    colors: [navy700, navy900],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
