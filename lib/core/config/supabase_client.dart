import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Global Riverpod provider for the Supabase client singleton.
///
/// Usage:
/// ```dart
/// final supabase = ref.watch(supabaseClientProvider);
/// final data = await supabase.from('profiles').select();
/// ```
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Convenience provider for the current authenticated user.
/// Returns `null` if no user is signed in.
final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

/// Stream provider that emits auth state changes (sign in, sign out, token refresh).
final authStateChangesProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});
