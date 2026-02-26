import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/data/repositories/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

export 'package:hue/core/auth/roles.dart' show UserRole, RoleCategory;

part 'users_provider.g.dart';

@riverpod
class UsersController extends _$UsersController {
  @override
  FutureOr<List<UserProfileModel>> build({
    RoleCategory? category,
    UserRole? role,
  }) async {
    return ref
        .watch(usersRepositoryProvider)
        .getUsers(category: category, role: role);
  }

  Future<void> createUser({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(usersRepositoryProvider)
          .createAccount(
            email: email,
            password: password,
            fullName: fullName,
            role: role,
          );
      if (!ref.mounted) return [];
      return ref
          .read(usersRepositoryProvider)
          .getUsers(category: category, role: role);
    });
  }

  Future<void> _handleModification(
    String userId,
    Map<String, dynamic> data,
  ) async {
    final authState = ref.read(authControllerProvider);
    if (authState.isAdmin) {
      await ref.read(usersRepositoryProvider).updateProfile(userId, data);
    } else {
      // Queue for approval
      await Supabase.instance.client.from('user_modification_requests').insert({
        'target_user_id': userId,
        'requester_id': authState.user?.id,
        'modification_data': data,
      });
    }
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(isActive: isActive) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref
            .read(usersRepositoryProvider)
            .toggleUserStatus(userId, isActive);
      } else {
        await _handleModification(userId, {'is_active': isActive});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> updateWarningLevel(String userId, int level) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(warningLevel: level) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref
            .read(usersRepositoryProvider)
            .updateWarningLevel(userId, level);
      } else {
        await _handleModification(userId, {'warning_level': level});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> toggleVerification(String userId, bool isVerified) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(isVerified: isVerified) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref
            .read(usersRepositoryProvider)
            .toggleVerification(userId, isVerified);
      } else {
        await _handleModification(userId, {'is_verified': isVerified});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> updateTags(String userId, List<String> tags) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(tags: tags) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref.read(usersRepositoryProvider).updateTags(userId, tags);
      } else {
        await _handleModification(userId, {'tags': tags});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> toggleBan(String userId, bool isBanned) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(isBanned: isBanned) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref.read(usersRepositoryProvider).toggleBan(userId, isBanned);
      } else {
        await _handleModification(userId, {'is_banned': isBanned});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> updateUserRole(String userId, UserRole newRole) async {
    final previousState = state.value;
    if (previousState == null) return;

    final authState = ref.read(authControllerProvider);
    final isDirect = authState.isAdmin;

    if (isDirect) {
      state = AsyncValue.data(
        previousState
            .map((u) => u.id == userId ? u.copyWith(role: newRole) : u)
            .toList(),
      );
    }

    try {
      if (isDirect) {
        await ref.read(usersRepositoryProvider).updateProfile(userId, {
          'role': newRole.toDbString(),
        });
      } else {
        await _handleModification(userId, {'role': newRole.toDbString()});
      }
    } catch (e) {
      if (!ref.mounted) return;
      if (isDirect) state = AsyncValue.data(previousState);
    }
  }

  Future<void> deleteUser(String userId, {bool hardDelete = false}) async {
    final authState = ref.read(authControllerProvider);
    if (!authState.isAdmin) {
      // For delete, maybe we just block it or queue a deletion request
      await _handleModification(userId, {
        '_action': 'DELETE',
        'hard': hardDelete,
      });
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(usersRepositoryProvider)
          .deleteUser(userId, hardDelete: hardDelete);
      if (!ref.mounted) return [];
      return ref
          .read(usersRepositoryProvider)
          .getUsers(category: category, role: role);
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final users = await ref
          .read(usersRepositoryProvider)
          .getUsers(category: category, role: role);
      if (!ref.mounted) return [];
      return users;
    });
  }
}
