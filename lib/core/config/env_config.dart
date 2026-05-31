class EnvConfig {
  EnvConfig._();

  // ── Supabase Configuration ──────────────────────────────────────────────
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your_supabase_anon_key_here',
  );

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

  // ── Profile Images ─────────────────────────────────────────────────────
  static const String defaultProfileImage =
      'https://ui-avatars.com/api/?name=User&background=6366f1&color=fff';
  static const String mockDeanImage = 'https://i.pravatar.cc/300?img=68';
  static const String mockStaffImageBase = 'https://i.pravatar.cc/300?img=';

  // ── Feature Flags ──────────────────────────────────────────────────────
  static const bool enableAnalytics = true;
  static const bool enableOfflineCache = false;

  // ── Validation ─────────────────────────────────────────────────────────
  static bool get isDevelopment =>
      supabaseUrl == 'https://your-project.supabase.co' ||
      supabaseAnonKey == 'your_supabase_anon_key_here';

  static bool get isProduction =>
      !isDevelopment && supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  static void validate() {
    // Allow development mode without actual Supabase credentials
    if (isDevelopment) {
      return; // Skip validation in development
    }

    // Validate production credentials
    assert(
      supabaseUrl.isNotEmpty &&
          supabaseUrl != 'https://your-project.supabase.co',
      'SUPABASE_URL is missing or invalid! '
      'Set a real Supabase URL or run with --dart-define-from-file=.env',
    );

    assert(
      supabaseAnonKey.isNotEmpty &&
          supabaseAnonKey != 'your_supabase_anon_key_here',
      'SUPABASE_ANON_KEY is missing or invalid! '
      'Set a real Supabase key or run with --dart-define-from-file=.env',
    );
  }

  // ── Debug Info ─────────────────────────────────────────────────────────
  static String getDebugInfo() {
    return '''
╔═══════════════════════════════════════════════════════════╗
║           Horus Environment Configuration                 ║
╠═══════════════════════════════════════════════════════════╣
║ Environment: ${isDevelopment ? 'DEVELOPMENT' : 'PRODUCTION'}
║ Supabase URL: ${supabaseUrl.substring(0, (supabaseUrl.length ~/ 2).clamp(0, supabaseUrl.length))}***
║ API URL: $apiUrl
║ Build: $buildFingerprint
║ Commit: $commitHash
║ Version: $appVersion
╚═══════════════════════════════════════════════════════════╝
    ''';
  }
}
