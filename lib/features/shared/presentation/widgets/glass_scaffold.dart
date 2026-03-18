import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/core/theme/low_performance_provider.dart';
import 'package:hue/features/shared/presentation/widgets/liquid_background.dart';
import 'package:hue/core/utils/responsive_helper.dart';

class GlassScaffold extends ConsumerWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final List<Color>? backgroundColors;
  final bool maxWidth;
  final bool? resizeToAvoidBottomInset;

  const GlassScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColors,
    this.maxWidth = true,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isLowPerformance = ref.watch(lowPerformanceControllerProvider);

    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);

    final isDesktop = ResponsiveHelper.isDesktop(context);

    Widget content = body;
    if (maxWidth && isDesktop) {
      content = Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: content,
        ),
      );
    }

    Widget scaffold = Scaffold(
      backgroundColor: isGlass
          ? Colors.transparent
          : theme.scaffoldBackgroundColor,
      appBar: appBar,
      drawer: drawer,
      body: content,
      bottomNavigationBar: isDesktop ? null : bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
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
