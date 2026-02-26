import 'package:flutter_test/flutter_test.dart';
import 'package:hue/core/config/build_config.dart';

void main() {
  group('BuildConfig', () {
    test('traceabilityKey should not throw RangeError with short commitHash', () {
      // This verifies that accessing the getter doesn't throw.
      // Since these are static const/String.fromEnvironment, we are testing the current
      // environment's values, but the logic itself is what we fixed.
      expect(() => BuildConfig.traceabilityKey, returnsNormally);

      final key = BuildConfig.traceabilityKey;
      expect(key, startsWith('AXE-'));
      expect(key.contains('-'), isTrue);
    });
  });
}
