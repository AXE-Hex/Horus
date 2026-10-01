import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Widget build(BuildContext context, WidgetRef ref) => SliverAppBar(
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
    backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
    elevation: elevation,
    scrolledUnderElevation: scrolledUnderElevation,
    iconTheme: iconTheme,
    flexibleSpace: flexibleSpace,
  );
}
