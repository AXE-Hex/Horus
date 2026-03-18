import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/data/repositories/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

export 'package:hue/core/auth/roles.dart' show UserRole, RoleCategory;

part 'users_provider.g.dart';

@Riverpod(keepAlive: true)
class UsersController extends _$UsersController {
  @override
  Stream<List<UserProfileModel>> build({
    RoleCategory? category,
    UserRole? role,
  }) {
    return ref
        .watch(usersRepositoryProvider)
        .watchUsers(category: category, role: role);
  }

  Future<void> createUser({
    required String email,
    required String password,
    required String fullName,
    required List<UserRole> roles,
    String? gender,
    String? studentId,
    String? nationalId,
    String? nationality,
    String? phone,
    String? collegeId,
    String? departmentId,
  }) async {
    final repo = ref.read(usersRepositoryProvider);
    await repo.createAccount(
      email: email,
      password: password,
      fullName: fullName,
      roles: roles,
      gender: gender,
      studentId: studentId,
      nationalId: nationalId,
      nationality: nationality,
      phone: phone,
      collegeId: collegeId,
      departmentId: departmentId,
    );
  }

  Future<void> _handleModification(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await Supabase.instance.client.from('audit_logs').insert({
        'performed_by': ref.read(authControllerProvider).user?.id,
        'target_user': userId,
        'action': 'update',
        'notes': 'Pending approval: ${data.toString()}',
      });
    } catch (_) {}
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref
          .read(usersRepositoryProvider)
          .toggleUserStatus(userId, isActive);
    } else {
      await _handleModification(userId, {'is_active': isActive});
    }
  }

  Future<void> updateWarningLevel(String userId, int level) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref.read(usersRepositoryProvider).updateWarningLevel(userId, level);
    } else {
      await _handleModification(userId, {'warning_level': level});
    }
  }

  Future<void> toggleVerification(String userId, bool isVerified) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref
          .read(usersRepositoryProvider)
          .toggleVerification(userId, isVerified);
    } else {
      await _handleModification(userId, {'is_verified': isVerified});
    }
  }

  Future<void> updateTags(String userId, List<String> tags) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref.read(usersRepositoryProvider).updateTags(userId, tags);
    } else {
      await _handleModification(userId, {'tags': tags});
    }
  }

  Future<void> toggleBan(String userId, bool isBanned) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref.read(usersRepositoryProvider).toggleBan(userId, isBanned);
    } else {
      await _handleModification(userId, {'is_banned': isBanned});
    }
  }

  Future<void> updateUserRoles(String userId, List<UserRole> newRoles) async {
    final isDirect = ref.read(authControllerProvider).isAdmin;
    if (isDirect) {
      await ref.read(usersRepositoryProvider).updateProfile(userId, {
        'roles': newRoles.map((r) => r.toDbString()).toList(),
      });
    } else {
      await _handleModification(userId, {
        'roles': newRoles.map((r) => r.toDbString()).toList(),
      });
    }
  }

  Future<void> deleteUser(String userId, {bool hardDelete = false}) async {
    if (!ref.read(authControllerProvider).isAdmin) {
      await _handleModification(userId, {
        '_action': 'DELETE',
        'hard': hardDelete,
      });
      return;
    }
    await ref
        .read(usersRepositoryProvider)
        .deleteUser(userId, hardDelete: hardDelete);
  }

  Future<void> refresh() async {}
}
