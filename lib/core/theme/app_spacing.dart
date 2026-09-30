import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double huge = 40.0;
  static const double maximum = 48.0;

  // Screen layout constants
  static const double screenHorizontalPadding = 20.0;
  static const double screenTopPadding = 16.0;
  static const double sectionSpacing = 24.0;
  static const double itemSpacing = 12.0;
}

class AppRadius {
  static const double xs = 8.0; // Small chips, badges
  static const double sm = 10.0; // Tabs, small buttons
  static const double md = 12.0; // Input fields, standard buttons
  static const double lg = 14.0; // Small cards
  static const double xl = 16.0; // Medium cards (most common)
  static const double xxl = 18.0; // Large cards
  static const double xxxl = 20.0;
  static const double card = 20.0; // University card
  static const double full = 999.0; // Circular (avatars, dots)
}

class AppBorders {
  static const standard = BorderSide(color: AppColors.neutral200, width: 1.0);

  static const navy = BorderSide(color: AppColors.navy200, width: 1.0);

  static const gold = BorderSide(color: AppColors.gold500, width: 1.0);

  static const goldSubtle = BorderSide(
    color: Color(0x26C5A044), // 15% opacity
    width: 1.0,
  );
}
