import 'package:flutter/material.dart';

abstract final class AppShadows {
  static const List<BoxShadow> level0 = [];
  static const level1 = [
    BoxShadow(color: Color(0x0A101B2A), blurRadius: 4, offset: Offset(0, 1)),
  ];
  static const level2 = [
    BoxShadow(color: Color(0x10101B2A), blurRadius: 10, offset: Offset(0, 3)),
  ];
  static const level3 = [
    BoxShadow(color: Color(0x14101B2A), blurRadius: 18, offset: Offset(0, 6)),
  ];
  static const level4 = [
    BoxShadow(color: Color(0x1A101B2A), blurRadius: 28, offset: Offset(0, 10)),
  ];

  static List<BoxShadow> forLevel(int level, {bool dark = false}) {
    final shadows = switch (level.clamp(0, 4)) {
      0 => level0,
      1 => level1,
      2 => level2,
      3 => level3,
      _ => level4,
    };
    if (!dark) return shadows;
    return shadows
        .map((shadow) => shadow.copyWith(color: const Color(0x50000000)))
        .toList(growable: false);
  }
}
