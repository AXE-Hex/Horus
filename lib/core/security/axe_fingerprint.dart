class AxeFingerprint {
  static const String axeSignature = String.fromEnvironment(
    'AXE_SIG',
    defaultValue: 'AXE_UNVERIFIED',
  );

  static const String identifier = 'GT-AXE::HUE::INTERNAL::METADATA';
}
