import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';

abstract final class _GlassConfig {
  static const double blurSigma = 24.0;

  static const double darkTintOpacity = 0.40;
  static const double lightTintOpacity = 0.50;

  static const double darkFallbackOpacity = 0.92;
  static const double lightFallbackOpacity = 0.96;

  static const double borderWidth = 0.5;
  static const double darkBorderOpacity = 0.10;
  static const double lightBorderOpacity = 0.18;

  static const double gradientStartOpacity = 0.06;
  static const double gradientEndOpacity = 0.0;
}

class GlassSliverAppBar extends ConsumerWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;

  final bool pinned;
  final bool floating;
  final bool snap;
  final bool stretch;
  final bool centerTitle;
  final bool forceElevated;
  final bool automaticallyImplyLeading;

  final double expandedHeight;
  final double elevation;
  final double? scrolledUnderElevation;
  final double? collapsedHeight;
  final double? leadingWidth;
  final double? toolbarHeight;

  final Color? backgroundColor;
  final IconThemeData? iconTheme;

  const GlassSliverAppBar({
    super.key,

    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.flexibleSpace,

    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.stretch = false,
    this.centerTitle = true,
    this.forceElevated = false,
    this.automaticallyImplyLeading = true,

    this.expandedHeight = kToolbarHeight,
    this.elevation = 0,
    this.scrolledUnderElevation,
    this.collapsedHeight,
    this.leadingWidth,
    this.toolbarHeight,

    this.backgroundColor,
    this.iconTheme,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerf = ref.watch(lowPerformanceControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (flexibleSpace != null) {
      return _buildSliverAppBar(
        backgroundColor: isGlass
            ? Colors.transparent
            : (backgroundColor ?? theme.scaffoldBackgroundColor),
        elevation: elevation,
        scrolledUnderElevation: scrolledUnderElevation,
        flexibleSpace: flexibleSpace,
      );
    }

    if (!isGlass) {
      return _buildSliverAppBar(
        backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: elevation,
        scrolledUnderElevation: scrolledUnderElevation,
      );
    }

    final tintColor = backgroundColor ?? (isDark ? Colors.black : Colors.white);

    final Widget glassBackground;

    if (isLowPerf) {
      glassBackground = _LowPerfBackground(color: tintColor, isDark: isDark);
    } else {
      glassBackground = _FrostedGlassBackground(
        tintColor: tintColor,
        isDark: isDark,
      );
    }

    return _buildSliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: FlexibleSpaceBar(background: glassBackground),
    );
  }

  SliverAppBar _buildSliverAppBar({
    required Color backgroundColor,
    required double elevation,
    double? scrolledUnderElevation,
    Widget? flexibleSpace,
  }) {
    return SliverAppBar(
      title: title,
      leading: leading,
      actions: actions,
      bottom: bottom,

      pinned: pinned,
      floating: floating,
      snap: snap,
      stretch: stretch,
      centerTitle: centerTitle,
      forceElevated: forceElevated,
      automaticallyImplyLeading: automaticallyImplyLeading,

      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      leadingWidth: leadingWidth,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,

      backgroundColor: backgroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      iconTheme: iconTheme,

      flexibleSpace: flexibleSpace ?? this.flexibleSpace,
    );
  }
}

class _FrostedGlassBackground extends StatelessWidget {
  final Color tintColor;
  final bool isDark;

  const _FrostedGlassBackground({
    required this.tintColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final tintOpacity = isDark
        ? _GlassConfig.darkTintOpacity
        : _GlassConfig.lightTintOpacity;

    final borderOpacity = isDark
        ? _GlassConfig.darkBorderOpacity
        : _GlassConfig.lightBorderOpacity;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _GlassConfig.blurSigma,
          sigmaY: _GlassConfig.blurSigma,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tintColor.withValues(alpha: tintOpacity),

            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(
                  alpha: _GlassConfig.gradientStartOpacity,
                ),
                Colors.white.withValues(alpha: _GlassConfig.gradientEndOpacity),
              ],
            ),

            border: Border(
              bottom: BorderSide(
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: borderOpacity,
                ),
                width: _GlassConfig.borderWidth,
              ),
            ),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _LowPerfBackground extends StatelessWidget {
  final Color color;
  final bool isDark;

  const _LowPerfBackground({required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color.withValues(
        alpha: isDark
            ? _GlassConfig.darkFallbackOpacity
            : _GlassConfig.lightFallbackOpacity,
      ),
      child: const SizedBox.expand(),
    );
  }
}
