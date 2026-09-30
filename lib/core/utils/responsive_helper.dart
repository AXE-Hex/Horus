import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const compactBreakpoint = 600.0;
  static const mediumBreakpoint = 1024.0;
  static const expandedBreakpoint = 1440.0;

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compactBreakpoint;

  static bool isMedium(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= compactBreakpoint && width < mediumBreakpoint;
  }

  static bool isExpanded(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mediumBreakpoint && width < expandedBreakpoint;
  }

  static bool isLarge(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expandedBreakpoint;

  static bool isMobile(BuildContext context) => isCompact(context);

  static bool isTablet(BuildContext context) => isMedium(context);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mediumBreakpoint;

  static T select<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= mediumBreakpoint) return desktop ?? tablet ?? mobile;
    if (width >= compactBreakpoint) return tablet ?? mobile;
    return mobile;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveHelper.mediumBreakpoint) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= ResponsiveHelper.compactBreakpoint) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}
