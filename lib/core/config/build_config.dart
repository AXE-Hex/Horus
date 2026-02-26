class BuildConfig {
  static const String buildFingerprint = String.fromEnvironment(
    'BUILD_FINGERPRINT',
    defaultValue: 'DEV_UNSET',
  );

  static const String commitHash = String.fromEnvironment(
    'COMMIT_HASH',
    defaultValue: 'local',
  );

  static const String buildTimestamp = String.fromEnvironment(
    'BUILD_TIMESTAMP',
    defaultValue: 'unknown',
  );

  static String get traceabilityKey =>
      'AXE-${commitHash.length > 7 ? commitHash.substring(0, 7) : commitHash}-$buildFingerprint';
}
