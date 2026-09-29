import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/features/profiles/data/models/directory_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDirectoryRepository {
  final SupabaseClient _client;

  ProfileDirectoryRepository(this._client);

  Future<List<DirectoryProfileModel>> watchProfiles({
    RoleCategory? category,
    UserRole? role,
  }) async {
    final response = await _client
        .from('profile_directory')
        .select()
        .order('created_at', ascending: false);
    var profiles = (response as List)
        .map((json) => DirectoryProfileModel.fromJson(json))
        .toList();

    if (role != null) {
      profiles = profiles
          .where((profile) => profile.roles.contains(role))
          .toList();
    } else if (category != null) {
      profiles = profiles
          .where(
            (profile) => profile.roles.any(
              (profileRole) => category.roles.contains(profileRole),
            ),
          )
          .toList();
    }
    return profiles;
  }
}

final profileDirectoryRepositoryProvider = Provider<ProfileDirectoryRepository>(
  (ref) {
    return ProfileDirectoryRepository(Supabase.instance.client);
  },
);

final profileDirectoryProvider =
    FutureProvider.family<List<DirectoryProfileModel>, ProfileDirectoryFilter>((
      ref,
      filter,
    ) {
      return ref
          .watch(profileDirectoryRepositoryProvider)
          .watchProfiles(category: filter.category, role: filter.role);
    });

class ProfileDirectoryFilter {
  final RoleCategory? category;
  final UserRole? role;

  const ProfileDirectoryFilter({this.category, this.role});

  @override
  bool operator ==(Object other) {
    return other is ProfileDirectoryFilter &&
        other.category == category &&
        other.role == role;
  }

  @override
  int get hashCode => Object.hash(category, role);
}
