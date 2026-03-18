class EnvConfig {
  EnvConfig._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static const String apiUrl = String.fromEnvironment('API_URL');
  static const String apiKey = String.fromEnvironment('API_KEY');

  static const String defaultProfileImage =
      'https://ui-avatars.com/api/?name=User&background=6366f1&color=fff';
  static const String mockDeanImage = 'https://i.pravatar.cc/300?img=68';
  static const String mockStaffImageBase = 'https://i.pravatar.cc/300?img=';

  static const bool enableAnalytics = true;
  static const bool enableOfflineCache = false;

  static void validate() {
    assert(
      supabaseUrl.isNotEmpty,
      'SUPABASE_URL is missing! Run with --dart-define-from-file=.env',
    );
    assert(
      supabaseAnonKey.isNotEmpty,
      'SUPABASE_ANON_KEY is missing! Run with --dart-define-from-file=.env',
    );
  }
}
