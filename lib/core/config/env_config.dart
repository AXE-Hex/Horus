
class EnvConfig {
  EnvConfig._();

  static const String supabaseUrl = 'https://jwfbyyldluzrodajmqkd.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_v4SaWol5v7EQrduk1tmYYw_B1c7Fjic';

  static const String apiUrl = String.fromEnvironment('API_URL');
  static const String apiKey = String.fromEnvironment('API_KEY');

  static const String defaultProfileImage = '';
  static const String mockDeanImage = '';
  static const String mockStaffImageBase = '';

  static const bool enableAnalytics = true;
  static const bool enableOfflineCache = false;
}
