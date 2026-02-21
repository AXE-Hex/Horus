// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';
import 'package:hue/features/shared/presentation/widgets/liquid_background.dart';

class GlassScaffold extends ConsumerWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final List<Color>? backgroundColors;

  const GlassScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.backgroundColors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerformance = ref.watch(lowPerformanceControllerProvider);

    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);

    Widget scaffold = Scaffold(
      backgroundColor: isGlass
          ? Colors.transparent
          : theme.scaffoldBackgroundColor,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      extendBody: isGlass ? true : extendBody,
      extendBodyBehindAppBar: isGlass ? true : extendBodyBehindAppBar,
    );

    if (!isGlass || isLowPerformance) return scaffold;

    return Stack(
      children: [
        Positioned.fill(child: LiquidBackground(colors: backgroundColors)),
        scaffold,
      ],
    );
  }
}
