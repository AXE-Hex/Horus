
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

  DigitalIDTheme mergeWith(DigitalIDTheme? overlay) {
    if (overlay == null) return this;

    return DigitalIDTheme(
      id: '$id-${overlay.id}',
      name: '$name - ${overlay.name}',
      primaryColor: primaryColor,
      secondaryColor: overlay.primaryColor,
      accentColor: overlay.accentColor,
      gradientColors: [
        gradientColors.first,
        overlay.primaryColor.withValues(alpha: 0.8),
        gradientColors.last,
      ],
      patternIcon: patternIcon,
      hologramAsset: hologramAsset,
    );
  }
}
