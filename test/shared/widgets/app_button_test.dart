import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horus/shared/widgets/app_button.dart';

void main() {
  testWidgets(
    'button variants invoke the provided action and loading disables it',
    (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppButton(
                  text: 'Continue',
                  onPressed: () => calls++,
                  variant: AppButtonVariant.primary,
                ),
                AppButton(
                  text: 'Working',
                  onPressed: () => calls++,
                  isLoading: true,
                  variant: AppButtonVariant.secondary,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.text('Continue'));
      await tester.tap(find.byType(OutlinedButton));
      expect(calls, 1);
    },
  );
}
