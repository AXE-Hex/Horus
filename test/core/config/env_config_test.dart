import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/config/env_config.dart';

void main() {
  group('EnvConfig.isLocalSupabaseUrl', () {
    test('recognizes IPv4, IPv6, and localhost loopback URLs', () {
      expect(EnvConfig.isLocalSupabaseUrl('http://127.0.0.1:55321'), isTrue);
      expect(EnvConfig.isLocalSupabaseUrl('http://localhost:55321'), isTrue);
      expect(EnvConfig.isLocalSupabaseUrl('http://[::1]:55321'), isTrue);
    });

    test('does not classify a hosted Supabase URL as local', () {
      expect(
        EnvConfig.isLocalSupabaseUrl('https://project.supabase.co'),
        isFalse,
      );
    });
  });
}
