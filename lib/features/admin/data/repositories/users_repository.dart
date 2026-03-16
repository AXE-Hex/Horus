import 'package:flutter/foundation.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'users_repository.g.dart';

class UsersRepository {
  final SupabaseClient _client;

  UsersRepository(this._client);

  // ── Read Operations ─────────────────────────────────────────────────

  Future<List<UserProfileModel>> getUsers({
    RoleCategory? category,
    UserRole? role,
    String? searchQuery,
  }) async {
    var query = _client.from('profiles').select();

    if (role != null) {
      query = query.contains('roles', [role.toDbString()]);
    } else if (category != null) {
      final roles = category.roles.map((r) => r.toDbString()).toList();
      query = query.overlaps('roles', roles);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.or(
        'full_name.ilike.%$searchQuery%,'
        'email.ilike.%$searchQuery%,'
        'student_id.ilike.%$searchQuery%',
      );
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List)
        .map((json) => UserProfileModel.fromJson(json))
        .toList();
  }

  Stream<List<UserProfileModel>> watchUsers({
    RoleCategory? category,
    UserRole? role,
    String? searchQuery,
  }) {
    SupabaseStreamBuilder stream = _client
        .from('profiles')
        .stream(primaryKey: ['id']);

    return stream.order('created_at', ascending: false).map((list) {
      var profiles = list
          .map((json) => UserProfileModel.fromJson(json))
          .toList();

      if (role != null) {
        profiles = profiles.where((p) => p.roles.contains(role)).toList();
      } else if (category != null) {
        profiles = profiles
            .where((p) => p.roles.any((r) => category.roles.contains(r)))
            .toList();
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final lowerQuery = searchQuery.toLowerCase();
        profiles = profiles.where((p) {
          return (p.fullName.toLowerCase().contains(lowerQuery)) ||
              (p.fullNameAr?.toLowerCase().contains(lowerQuery) ?? false) ||
              (p.email.toLowerCase().contains(lowerQuery)) ||
              (p.studentId?.toLowerCase().contains(lowerQuery) ?? false) ||
              (p.nationalId?.toLowerCase().contains(lowerQuery) ?? false);
        }).toList();
      }

      return profiles;
    });
  }

  // ── Create User ─────────────────────────────────────────────────────

  /// Creates a new user via Supabase Auth + profiles table upsert.
  /// Uses auth.admin.createUser when service_role key is available,
  /// otherwise falls back to auth.signUp + profile upsert.
  Future<String> createAccount({
    required String email,
    required String password,
    required String fullName,
    required List<UserRole> roles,
    String? studentId,
    String? nationalId,
    String? nationality,
    String? phone,
    String? collegeId,
    String? departmentId,
  }) async {
    try {
      // Try using Auth Admin API first (requires service_role key)
      final response = await _client.auth.admin.createUser(
        AdminUserAttributes(
          email: email,
          password: password,
          emailConfirm: true,
          userMetadata: {
            'full_name': fullName,
            'roles': roles.map((r) => r.toDbString()).toList(),
          },
        ),
      );

      final userId = response.user!.id;

      // Upsert into profiles table
      await _client.from('profiles').upsert({
        'id': userId,
        'email': email,
        'full_name': fullName,
        'roles': roles.map((r) => r.toDbString()).toList(),
        'student_id': studentId?.isNotEmpty == true ? studentId : null,
        'national_id': nationalId?.isNotEmpty == true ? nationalId : null,
        'nationality': nationality?.isNotEmpty == true ? nationality : null,
        'phone': phone?.isNotEmpty == true ? phone : null,
        'college_id': collegeId,
        'department_id': departmentId,
        'is_active': true,
        'is_verified': false,
      });

      return userId;
    } catch (e) {
      debugPrint('Admin createUser failed, trying signUp fallback: $e');

      // Fallback: use signUp (works without service_role)
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'roles': roles.map((r) => r.toDbString()).toList(),
        },
      );

      if (response.user == null) {
        throw Exception('Failed to create user account');
      }

      final userId = response.user!.id;

      await _client.from('profiles').upsert({
        'id': userId,
        'email': email,
        'full_name': fullName,
        'roles': roles.map((r) => r.toDbString()).toList(),
        'student_id': studentId?.isNotEmpty == true ? studentId : null,
        'national_id': nationalId?.isNotEmpty == true ? nationalId : null,
        'nationality': nationality?.isNotEmpty == true ? nationality : null,
        'phone': phone?.isNotEmpty == true ? phone : null,
        'college_id': collegeId,
        'department_id': departmentId,
        'is_active': true,
        'is_verified': false,
      });

      return userId;
    }
  }

  // ── Update Operations ───────────────────────────────────────────────

  /// Update specific profile fields — only sends columns that exist
  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    // Filter to only known columns that exist in the profiles table
    final knownColumns = {
      'full_name',
      'full_name_ar',
      'avatar_url',
      'roles',
      'student_id',
      'national_id',
      'nationality',
      'phone',
      'college_id',
      'department_id',
      'is_active',
      'is_verified',
    };

    final safeData = Map<String, dynamic>.fromEntries(
      data.entries.where((e) => knownColumns.contains(e.key)),
    );

    if (safeData.isEmpty) return;
    await _client.from('profiles').update(safeData).eq('id', userId);
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    await _client
        .from('profiles')
        .update({'is_active': isActive})
        .eq('id', userId);
  }

  Future<void> toggleVerification(String userId, bool isVerified) async {
    await _safeColumnUpdate(userId, 'is_verified', isVerified);
  }

  Future<void> toggleBan(String userId, bool isBanned) async {
    await _safeColumnUpdate(userId, 'is_banned', isBanned);
  }

  Future<void> updateWarningLevel(String userId, int level) async {
    await _safeColumnUpdate(userId, 'warning_level', level);
  }

  Future<void> updateTags(String userId, List<String> tags) async {
    await _safeColumnUpdate(userId, 'tags', tags);
  }

  Future<void> enableMFA(String userId, bool enabled) async {
    await _safeColumnUpdate(userId, 'mfa_enabled', enabled);
  }

  Future<void> trackLogin(String userId) async {
    await _safeColumnUpdate(
      userId,
      'last_login',
      DateTime.now().toIso8601String(),
    );
  }

  /// Safely updates a single column — if the column doesn't exist,
  /// the error is caught and logged instead of crashing the app.
  Future<void> _safeColumnUpdate(
    String userId,
    String column,
    dynamic value,
  ) async {
    try {
      await _client.from('profiles').update({column: value}).eq('id', userId);
    } catch (e) {
      final errorStr = e.toString();
      if (errorStr.contains('42703') || errorStr.contains('does not exist')) {
        debugPrint(
          '⚠️ Column "$column" does not exist in profiles table. '
          'Add it via Supabase Dashboard → Table Editor → profiles → Add Column.',
        );
      } else {
        rethrow;
      }
    }
  }

  // ── Delete Operations ───────────────────────────────────────────────

  Future<void> deleteUser(String userId, {bool hardDelete = false}) async {
    if (hardDelete) {
      // Try admin delete first (requires service_role)
      try {
        await _client.auth.admin.deleteUser(userId);
      } catch (e) {
        debugPrint('Admin delete failed: $e');
      }
      // Also remove from profiles
      await _client.from('profiles').delete().eq('id', userId);
    } else {
      // Soft delete: just deactivate
      await _client
          .from('profiles')
          .update({'is_active': false})
          .eq('id', userId);
    }
  }

  // ── Stats ──────────────────────────────────────────────────────────

  Future<int> getCategoryCount(RoleCategory category) async {
    final roles = category.roles.map((r) => r.toDbString()).toList();
    final response = await _client
        .from('profiles')
        .select('id')
        .overlaps('roles', roles);
    return (response as List).length;
  }
}

@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) {
  return UsersRepository(Supabase.instance.client);
}
