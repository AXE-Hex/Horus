import 'package:hue/core/auth/roles.dart';
import 'package:hue/features/admin/data/repositories/users_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_stats_provider.g.dart';

@riverpod
Future<Map<RoleCategory, int>> adminStats(Ref ref) async {
  final repo = ref.watch(usersRepositoryProvider);

  final studentCount = await repo.getCategoryCount(RoleCategory.studentRoles);

  final adminStaffCount = await repo.getCategoryCount(RoleCategory.adminIT);
  final academicStaffCount = await repo.getCategoryCount(
    RoleCategory.teachingStaff,
  );
  final leadershipCount = await repo.getCategoryCount(
    RoleCategory.academicLeadership,
  );
  final studentAffairsCount = await repo.getCategoryCount(
    RoleCategory.studentAffairs,
  );

  return {
    RoleCategory.studentRoles: studentCount,
    RoleCategory.adminIT: adminStaffCount,
    RoleCategory.teachingStaff: academicStaffCount,
    RoleCategory.academicLeadership: leadershipCount,
    RoleCategory.studentAffairs: studentAffairsCount,
  };
}

@riverpod
Future<int> totalStaffCount(Ref ref) async {
  final stats = await ref.watch(adminStatsProvider.future);
  return stats[RoleCategory.adminIT]! +
      stats[RoleCategory.teachingStaff]! +
      stats[RoleCategory.academicLeadership]! +
      stats[RoleCategory.studentAffairs]!;
}

@riverpod
Future<int> totalStudentCount(Ref ref) async {
  final stats = await ref.watch(adminStatsProvider.future);
  return stats[RoleCategory.studentRoles] ?? 0;
}
