import 'package:flutter/material.dart';

class AppDurations {
  static const micro = Duration(milliseconds: 100); // hover, press
  static const fast = Duration(milliseconds: 150); // toggle, badge
  static const normal = Duration(milliseconds: 250); // card entrance
  static const medium = Duration(milliseconds: 350); // page transition
  static const slow = Duration(milliseconds: 500); // shimmer entrance
  static const shimmer = Duration(milliseconds: 2000); // complete shimmer cycle
  static const pulse = Duration(milliseconds: 1400); // pulsing dot
}

class AppCurves {
  static const enter = Curves.easeOut; // element entering screen
  static const exit = Curves.easeIn; // element leaving screen
  static const spring = Curves.easeOutBack; // confident bounce/spring
  static const smooth = Curves.easeInOut; // smooth transitions (pulse, shimmer)
}
