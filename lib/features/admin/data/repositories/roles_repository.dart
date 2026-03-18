import 'package:hue/features/admin/data/models/dynamic_role_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RolesRepository {
  final SupabaseClient _client;

  RolesRepository(this._client);

  Future<List<DynamicRoleModel>> getRoles() async {
    final response = await _client
        .from('roles')
        .select()
        .order('hierarchy_level', ascending: true);

    return (response as List)
        .map((json) => DynamicRoleModel.fromJson(json))
        .toList();
  }

  Future<void> createRole(DynamicRoleModel role) async {
    await _client.from('roles').insert(role.toJson());
  }

  Future<void> updateRole(String id, Map<String, dynamic> data) async {
    await _client.from('roles').update(data).eq('id', id);
  }

  Future<void> deleteRole(String id) async {
    await _client.from('roles').delete().eq('id', id);
  }
}

final rolesRepositoryProvider = Provider<RolesRepository>((ref) {
  return RolesRepository(Supabase.instance.client);
});
