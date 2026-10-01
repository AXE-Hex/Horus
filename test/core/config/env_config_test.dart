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

  group('EnvConfig.isClientSafeKey', () {
    test('accepts a publishable API key', () {
      expect(EnvConfig.isClientSafeKey('sb_publishable_test-value'), isTrue);
    });

    test('accepts a legacy anon JWT but rejects privileged credentials', () {
      const anonKey = 'eyJhbGciOiJub25lIn0.eyJyb2xlIjoiYW5vbiJ9.signature';
      const serviceRoleKey =
          'eyJhbGciOiJub25lIn0.eyJyb2xlIjoic2VydmljZV9yb2xlIn0.signature';

      expect(EnvConfig.isClientSafeKey(anonKey), isTrue);
      expect(EnvConfig.isClientSafeKey(serviceRoleKey), isFalse);
      expect(EnvConfig.isClientSafeKey('sb_secret_test-value'), isFalse);
      expect(EnvConfig.isClientSafeKey('not-a-key'), isFalse);
    });
  });
}
