import 'package:flutter/material.dart';
import 'package:horus/core/theme/app_layout.dart';

class HorusPageBody extends StatelessWidget {
  const HorusPageBody({
    super.key,
    required this.child,
    this.maxWidth = AppLayout.readingWidth,
  });
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
