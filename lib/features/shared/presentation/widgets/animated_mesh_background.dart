import 'package:flutter/material.dart';

/// Compatibility wrapper for screens migrating from the old mesh background.
class AnimatedMeshBackground extends StatelessWidget {
  const AnimatedMeshBackground({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.scaffoldBackgroundColor,
            theme.colorScheme.surfaceContainerLow,
          ],
        ),
      ),
      child: const SizedBox.expand(),
    );
  }
}
