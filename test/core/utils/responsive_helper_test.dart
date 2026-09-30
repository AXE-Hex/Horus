import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/utils/responsive_helper.dart';

void main() {
  testWidgets('shell breakpoint helpers classify the documented widths', (
    tester,
  ) async {
    final sizes = <double, List<bool>>{};
    for (final width in [599.0, 600.0, 1023.0, 1024.0, 1439.0, 1440.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(width, 900)),
            child: Builder(
              builder: (context) {
                sizes[width] = [
                  ResponsiveHelper.isCompact(context),
                  ResponsiveHelper.isMedium(context),
                  ResponsiveHelper.isExpanded(context),
                  ResponsiveHelper.isLarge(context),
                ];
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    }
    expect(sizes[599], [true, false, false, false]);
    expect(sizes[600], [false, true, false, false]);
    expect(sizes[1023], [false, true, false, false]);
    expect(sizes[1024], [false, false, true, false]);
    expect(sizes[1439], [false, false, true, false]);
    expect(sizes[1440], [false, false, false, true]);
  });
}
