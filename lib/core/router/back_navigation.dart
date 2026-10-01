import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension HorusBackNavigation on BuildContext {
  /// Deep links may enter an old screen without a preceding Navigator page.
  /// The fallback still goes through the current authorization redirect.
  void backToHorus() {
    if (canPop()) {
      pop();
    } else {
      go('/home');
    }
  }
}
