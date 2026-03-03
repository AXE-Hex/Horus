import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/features/admin/data/models/dynamic_role_model.dart';
import 'package:hue/features/admin/data/repositories/roles_repository.dart';

// Manual providers to bypass generator issues
final rolesControllerProvider =
    AsyncNotifierProvider<RolesController, List<DynamicRoleModel>>(
      RolesController.new,
    );

final rolesProvider = FutureProvider<List<DynamicRoleModel>>((ref) {
  return ref.watch(rolesControllerProvider.future);
});

class RolesController extends AsyncNotifier<List<DynamicRoleModel>> {
  @override
  Future<List<DynamicRoleModel>> build() async {
    return ref.watch(rolesRepositoryProvider).getRoles();
  }

  Future<void> addRole(DynamicRoleModel role) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(rolesRepositoryProvider).createRole(role);
      return ref.read(rolesRepositoryProvider).getRoles();
    });
  }

  Future<void> updateRole(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(rolesRepositoryProvider).updateRole(id, data);
      return ref.read(rolesRepositoryProvider).getRoles();
    });
  }

  Future<void> removeRole(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(rolesRepositoryProvider).deleteRole(id);
      return ref.read(rolesRepositoryProvider).getRoles();
    });
  }
}
