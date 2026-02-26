import 'package:hue/core/auth/roles.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'users_repository.g.dart';

class UsersRepository {
  final SupabaseClient _client;

  UsersRepository(this._client);

  Future<List<UserProfileModel>> getUsers({
    RoleCategory? category,
    UserRole? role,
    String? searchQuery,
  }) async {
    var query = _client.from('profiles').select();

    if (role != null) {
      query = query.eq('role', role.toDbString());
    } else if (category != null) {
      final roles = category.roles.map((r) => r.toDbString()).toList();
      query = query.inFilter('role', roles);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.or(
        'full_name.ilike.%$searchQuery%,'
        'email.ilike.%$searchQuery%,'
        'student_id.ilike.%$searchQuery%,'
        'phone.ilike.%$searchQuery%,'
        'tags.cs.{"$searchQuery"}',
      );
    }

    final response = await query.order('created_at', ascending: false);
    return (response as List)
        .map((json) => UserProfileModel.fromJson(json))
        .toList();
  }

  Future<String> createAccount({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    final response = await _client.rpc(
      'admin_create_user',
      params: {
        'email': email,
        'password': password,
        'full_name': fullName,
        'role': role.toDbString(),
      },
    );
    return response as String;
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    await _client.rpc(
      'admin_toggle_user_status',
      params: {'user_id': userId, 'is_active': isActive},
    );
  }

  Future<void> updateProfile(String userId, Map<String, dynamic> data) async {
    await _client.from('profiles').update(data).eq('id', userId);
  }

  Future<void> deleteUser(String userId, {bool hardDelete = false}) async {
    await _client.rpc(
      'admin_delete_user',
      params: {'target_user_id': userId, 'hard_delete': hardDelete},
    );
  }

  Future<void> updateWarningLevel(String userId, int level) async {
    await updateProfile(userId, {'warning_level': level});
  }

  Future<void> toggleVerification(String userId, bool isVerified) async {
    await updateProfile(userId, {'is_verified': isVerified});
  }

  Future<void> updateTags(String userId, List<String> tags) async {
    await updateProfile(userId, {'tags': tags});
  }

  Future<void> toggleBan(String userId, bool isBanned) async {
    await updateProfile(userId, {'is_banned': isBanned});
  }

  Future<void> enableMFA(String userId, bool enabled) async {
    await updateProfile(userId, {'mfa_enabled': enabled});
  }

  Future<void> trackLogin(String userId) async {
    await updateProfile(userId, {
      'last_login': DateTime.now().toIso8601String(),
    });
  }

  Future<int> getCategoryCount(RoleCategory category) async {
    final roles = category.roles.map((r) => r.toDbString()).toList();
    final response = await _client
        .from('profiles')
        .select('id')
        .inFilter('role', roles);
    return (response as List).length;
  }
}

@Riverpod(keepAlive: true)
UsersRepository usersRepository(Ref ref) {
  return UsersRepository(Supabase.instance.client);
}
