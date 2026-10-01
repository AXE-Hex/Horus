import 'dart:convert';

class EnvConfig {
  EnvConfig._();

  // ── Supabase Configuration ──────────────────────────────────────────────
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://reyvrbvdgojpnbecvzwn.supabase.co',
  );

  static const String supabasePublishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  /// Compatibility alias for the older Supabase Dart client parameter name.
  static const String supabaseAnonKey = supabasePublishableKey;

  // ── External API Configuration ──────────────────────────────────────────
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.example.com',
  );

  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'your_api_key_here',
  );

  // ── Security Configuration ──────────────────────────────────────────────
  static const String axeSignature = String.fromEnvironment(
    'AXE_SIG',
    defaultValue: 'AXE_UNVERIFIED',
  );

  // ── Build Information ───────────────────────────────────────────────────
  static const String buildFingerprint = String.fromEnvironment(
    'BUILD_FINGERPRINT',
    defaultValue: 'DEV_LOCAL',
  );

  static const String commitHash = String.fromEnvironment(
    'COMMIT_HASH',
    defaultValue: 'local_dev',
  );

  static const String buildTimestamp = String.fromEnvironment(
    'BUILD_TIMESTAMP',
    defaultValue: 'dev',
  );

  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0',
  );

  // ── Feature Flags ──────────────────────────────────────────────────────
  static const bool enableAnalytics = true;
  static const bool enableOfflineCache = false;

  // ── Validation ─────────────────────────────────────────────────────────
  static bool get isDevelopment => isLocalSupabaseUrl(supabaseUrl);

  static bool isLocalSupabaseUrl(String value) {
    final host = Uri.tryParse(value.trim())?.host.toLowerCase();
    return host == 'localhost' || host == '127.0.0.1' || host == '::1';
  }

  static bool get isProduction =>
      !isDevelopment &&
      supabaseUrl.isNotEmpty &&
      supabasePublishableKey.isNotEmpty;

  static void validate() {
    final uri = Uri.tryParse(supabaseUrl);
    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != 'https' && !isLocalSupabaseUrl(supabaseUrl))) {
      throw StateError('SUPABASE_URL is missing or invalid.');
    }

    if (!isClientSafeKey(supabasePublishableKey)) {
      throw StateError(
        'A Supabase publishable key or legacy anon key is required. '
        'Secret and service_role keys are not allowed in the Flutter client.',
      );
    }
  }

  static bool isClientSafeKey(String value) {
    final key = value.trim();
    if (key.startsWith('sb_publishable_')) return true;
    if (key.isEmpty || key.startsWith('sb_secret_')) return false;

    final segments = key.split('.');
    if (segments.length != 3) return false;
    try {
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
      );
      return payload is Map<String, dynamic> && payload['role'] == 'anon';
    } on FormatException {
      return false;
    }
  }

  // ── Debug Info ─────────────────────────────────────────────────────────
  static String getDebugInfo() {
    return '''
╔═══════════════════════════════════════════════════════════╗
║           Horus Environment Configuration                 ║
╠═══════════════════════════════════════════════════════════╣
║ Environment: ${isDevelopment ? 'LOCAL' : 'REMOTE'}
║ Supabase URL: ${supabaseUrl.substring(0, (supabaseUrl.length ~/ 2).clamp(0, supabaseUrl.length))}***
║ API URL: $apiUrl
║ Build: $buildFingerprint
║ Commit: $commitHash
║ Version: $appVersion
╚═══════════════════════════════════════════════════════════╝
    ''';
  }
}
