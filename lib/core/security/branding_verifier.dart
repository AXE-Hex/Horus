import 'axe_fingerprint.dart';

class BrandingVerifier {
  static bool verify() {
    try {
      final isVerified =
          AxeFingerprint.axeSignature != 'AXE_UNVERIFIED' &&
          AxeFingerprint.axeSignature.length >= 64;
      return isVerified;
    } catch (e) {
      return false;
    }
  }
}
