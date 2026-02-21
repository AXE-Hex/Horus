// ╔══════════════════════════════════════════════════════════════════╗
// ║            GlassSliverAppBar — Premium Frosted Glass Widget      ║
// ╚══════════════════════════════════════════════════════════════════╝
//
// A drop-in replacement for [SliverAppBar] that renders three visual
// modes depending on the user's selected app style:
//
//   1. **Glass**  — Frosted blur + gradient tint + luminous border
//   2. **Classic** — Solid theme-colored background (no blur)
//   3. **Low-perf** — Semi-transparent fill (blur disabled for perf)
//
// The widget's public API is a strict superset of [SliverAppBar], so
// it can be swapped in without changing call-sites.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';

// ─────────────────────────────────────────────────
// CONFIGURATION
// ─────────────────────────────────────────────────

/// Visual tuning knobs for the glass effect.
/// Change these to tweak the look without touching the widget tree.
abstract final class _GlassConfig {
  // Blur
  static const double blurSigma = 24.0;

  // Tint opacity
  static const double darkTintOpacity = 0.40;
  static const double lightTintOpacity = 0.50;

  // Low-perf fallback opacity
  static const double darkFallbackOpacity = 0.92;
  static const double lightFallbackOpacity = 0.96;

  // Border
  static const double borderWidth = 0.5;
  static const double darkBorderOpacity = 0.10;
  static const double lightBorderOpacity = 0.18;

  // Gradient overlay (subtle top-to-bottom shimmer)
  static const double gradientStartOpacity = 0.06;
  static const double gradientEndOpacity = 0.0;
}

// ─────────────────────────────────────────────────
// WIDGET
// ─────────────────────────────────────────────────

/// A premium glass-styled [SliverAppBar].
///
/// ### Usage
/// ```dart
/// GlassSliverAppBar(
///   title: Text('Home'),
///   actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
/// )
/// ```
///
/// ### Custom Flexible Space
/// When you pass your own [flexibleSpace] (e.g. a [FlexibleSpaceBar]
/// with a hero image), the glass effect is **not** applied — the widget
/// behaves exactly like a stock [SliverAppBar].
class GlassSliverAppBar extends ConsumerWidget {
  // ── Content ───────────────────────────────────
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;

  // ── Behaviour ─────────────────────────────────
  final bool pinned;
  final bool floating;
  final bool snap;
  final bool stretch;
  final bool centerTitle;
  final bool forceElevated;
  final bool automaticallyImplyLeading;

  // ── Dimensions ────────────────────────────────
  final double expandedHeight;
  final double elevation;
  final double? scrolledUnderElevation;
  final double? collapsedHeight;
  final double? leadingWidth;
  final double? toolbarHeight;

  // ── Styling ───────────────────────────────────
  final Color? backgroundColor;
  final IconThemeData? iconTheme;

  const GlassSliverAppBar({
    super.key,
    // Content
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.flexibleSpace,
    // Behaviour
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.stretch = false,
    this.centerTitle = true,
    this.forceElevated = false,
    this.automaticallyImplyLeading = true,
    // Dimensions
    this.expandedHeight = kToolbarHeight,
    this.elevation = 0,
    this.scrolledUnderElevation,
    this.collapsedHeight,
    this.leadingWidth,
    this.toolbarHeight,
    // Styling
    this.backgroundColor,
    this.iconTheme,
  });

  // ── Build ─────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerf = ref.watch(lowPerformanceControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // ─── Case 1: Custom flexibleSpace → pass-through ───
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

    // ─── Case 2: Classic mode → solid background ───
    if (!isGlass) {
      return _buildSliverAppBar(
        backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: elevation,
        scrolledUnderElevation: scrolledUnderElevation,
      );
    }

    // ─── Case 3: Glass mode ───
    final tintColor = backgroundColor ?? (isDark ? Colors.black : Colors.white);

    final Widget glassBackground;

    if (isLowPerf) {
      // Low-performance: simple tinted fill, no blur
      glassBackground = _LowPerfBackground(color: tintColor, isDark: isDark);
    } else {
      // Full glass: blur + tint + gradient + border
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

  // ── Private factory ───────────────────────────

  /// Constructs the underlying [SliverAppBar] with all forwarded params.
  SliverAppBar _buildSliverAppBar({
    required Color backgroundColor,
    required double elevation,
    double? scrolledUnderElevation,
    Widget? flexibleSpace,
  }) {
    return SliverAppBar(
      // Content
      title: title,
      leading: leading,
      actions: actions,
      bottom: bottom,
      // Behaviour
      pinned: pinned,
      floating: floating,
      snap: snap,
      stretch: stretch,
      centerTitle: centerTitle,
      forceElevated: forceElevated,
      automaticallyImplyLeading: automaticallyImplyLeading,
      // Dimensions
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      leadingWidth: leadingWidth,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      // Styling
      backgroundColor: backgroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      iconTheme: iconTheme,
      // Flexible
      flexibleSpace: flexibleSpace ?? this.flexibleSpace,
    );
  }
}

// ─────────────────────────────────────────────────
// INTERNAL WIDGETS
// ─────────────────────────────────────────────────

/// Full frosted glass background with:
///   • BackdropFilter blur
///   • Semi-transparent colour tint
///   • Subtle top-to-bottom luminous gradient
///   • Thin bottom border with white/dark glow
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
            // Base tint
            color: tintColor.withValues(alpha: tintOpacity),
            // Luminous gradient overlay
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
            // Bottom border glow
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

/// Low-performance fallback: a simple semi-transparent fill.
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
