import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/auth_provider.dart';

void main() {
  group('signInFailureCode', () {
    test('maps unconfirmed email and rate limiting to safe categories', () {
      expect(
        signInFailureCode('email_not_confirmed', '400'),
        'email_not_confirmed',
      );
      expect(
        signInFailureCode('over_request_rate_limit', '429'),
        'too_many_attempts',
      );
    });

    test('maps connection failures without exposing backend details', () {
      expect(signInFailureCode(null, null), 'network_error');
      expect(signInFailureCode('request_timeout', '504'), 'network_error');
    });

    test('keeps credential and unknown server errors generic', () {
      expect(signInFailureCode('invalid_credentials', '400'), 'sign_in_failed');
      expect(signInFailureCode('unexpected_failure', '500'), 'sign_in_failed');
      expect(signInFailureCode('user_banned', '403'), 'account_unavailable');
    });
  });
}
