/// Environment configuration for the HUE application.
/// Supabase credentials and feature flags are stored here.
///
/// IMPORTANT: In production, use --dart-define to inject secrets
/// at build time. Never hardcode production keys.
class EnvConfig {
  EnvConfig._();

  // ── Supabase ──────────────────────────────────────
  static const String supabaseUrl = 'https://rabloiisnvnihapomjle.supabase.co';
  static const String supabaseAnonKey =
      'sb_publishable_uXhMqnwTZNKtwT6lH-JBMA_adg3E9z6';

  // ── API (Legacy / External) ───────────────────────
  static const String apiUrl = String.fromEnvironment('API_URL');
  static const String apiKey = String.fromEnvironment('API_KEY');

  // ── Images ────────────────────────────────────────
  static const String defaultProfileImage = '';
  static const String mockDeanImage = '';
  static const String mockStaffImageBase = '';

  // ── Feature Flags ─────────────────────────────────
  static const bool enableAnalytics = true;
  static const bool enableOfflineCache = false;
}
