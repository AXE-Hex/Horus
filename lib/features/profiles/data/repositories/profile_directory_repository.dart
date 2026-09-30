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
    String? profileId,
    String? collegeId,
    Set<UserRole>? roles,
    int offset = 0,
    int limit = 50,
  }) async {
    if (offset < 0 || limit < 1 || limit > 100) {
      throw ArgumentError('Profile directory pagination is out of range.');
    }

    var query = _client
        .from('profile_directory')
        .select(
          'id,full_name,full_name_ar,avatar_url,college_id,department_id,created_at,role_codes',
        );
    if (profileId != null) query = query.eq('id', profileId);
    if (collegeId != null) query = query.eq('college_id', collegeId);
    if (roles != null && roles.isNotEmpty) {
      query = query.overlaps(
        'role_codes',
        roles.map((value) => value.toDbString()).toList(),
      );
    } else if (role != null) {
      query = query.contains('role_codes', [role.toDbString()]);
    } else if (category != null) {
      query = query.overlaps(
        'role_codes',
        category.roles.map((value) => value.toDbString()).toList(),
      );
    }

    final response = await query
        .order('created_at', ascending: false)
        .order('id', ascending: false)
        .range(offset, offset + limit - 1);
    return response
        .map((json) => DirectoryProfileModel.fromJson(json))
        .toList();
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
          .watchProfiles(
            category: filter.category,
            role: filter.role,
            profileId: filter.profileId,
            collegeId: filter.collegeId,
            roles: filter.roles,
          );
    });

class ProfileDirectoryFilter {
  final RoleCategory? category;
  final UserRole? role;
  final String? profileId;
  final String? collegeId;
  final Set<UserRole>? roles;

  const ProfileDirectoryFilter({
    this.category,
    this.role,
    this.profileId,
    this.collegeId,
    this.roles,
  });

  @override
  bool operator ==(Object other) {
    return other is ProfileDirectoryFilter &&
        other.category == category &&
        other.role == role &&
        other.profileId == profileId &&
        other.collegeId == collegeId &&
        (roles == null
            ? other.roles == null
            : other.roles != null &&
                  roles!.length == other.roles!.length &&
                  roles!.containsAll(other.roles!));
  }

  @override
  int get hashCode => Object.hash(
    category,
    role,
    profileId,
    collegeId,
    roles == null ? null : Object.hashAllUnordered(roles!),
  );
}
