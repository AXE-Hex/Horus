import 'axe_fingerprint.dart';

class BrandingVerifier {
  static bool verify() {
    try {
      final isVerified =
          Axe.axeSignature != 'AXE_UNVERIFIED' && Axe.axeSignature.length >= 64;
      return isVerified;
    } catch (e) {
      return false;
    }
  }
}
