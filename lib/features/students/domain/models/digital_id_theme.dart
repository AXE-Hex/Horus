// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DigitalIDTheme {
  final String id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final List<Color> gradientColors;
  final IconData patternIcon;
  final String? hologramAsset;

  const DigitalIDTheme({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    required this.gradientColors,
    this.patternIcon = LucideIcons.school,
    this.hologramAsset,
  });

  /// Merges this theme (Base/College) with an overlay theme (Specialization).
  /// The specialization overrides specific accents and adds to the gradient.
  DigitalIDTheme mergeWith(DigitalIDTheme? overlay) {
    if (overlay == null) return this;

    return DigitalIDTheme(
      id: '$id-${overlay.id}',
      name: '$name - ${overlay.name}',
      primaryColor: primaryColor, // Keep base primary
      secondaryColor: overlay.primaryColor, // Use overlay primary as secondary
      accentColor: overlay.accentColor, // Use overlay accent
      gradientColors: [
        gradientColors.first,
        overlay.primaryColor.withValues(alpha: 0.8),
        gradientColors.last,
      ],
      patternIcon: patternIcon, // Keep base icon
      hologramAsset: hologramAsset,
    );
  }
}
