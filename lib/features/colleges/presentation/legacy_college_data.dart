import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';
import 'package:horus/features/institutional/data/repositories/institutional_repository.dart';
import 'package:horus/features/profiles/data/models/directory_profile_model.dart';

// Resolve a historical visual catalog key to an actual current schema UUID.
// An absent match must never become an unscoped directory request.
final legacyCollegeProvider = FutureProvider.family<CollegeModel?, String>((
  ref,
  key,
) async {
  final colleges = await ref
      .watch(institutionalRepositoryProvider)
      .getColleges();
  for (final college in colleges) {
    if (college.id == key || college.code?.toLowerCase() == key.toLowerCase()) {
      return college;
    }
  }
  return null;
});
final legacyCollegeStaffProvider =
    FutureProvider.family<List<DirectoryProfileModel>, String>((
      ref,
      key,
    ) async {
      final college = await ref.watch(legacyCollegeProvider(key).future);
      if (college == null) return const [];
      return ref
          .watch(institutionalRepositoryProvider)
          .getCollegeStaffList(college.id);
    });
final legacyCollegeStatsProvider =
    FutureProvider.family<Map<String, int>, String>((ref, key) async {
      final college = await ref.watch(legacyCollegeProvider(key).future);
      if (college == null) return const {};
      return ref
          .watch(institutionalRepositoryProvider)
          .getCollegeRealTimeStats(college.id);
    });

final legacyCollegeDepartmentsProvider =
    FutureProvider.family<List<DepartmentModel>, String>((ref, key) async {
      final college = await ref.watch(legacyCollegeProvider(key).future);
      if (college == null) return const [];
      return ref
          .watch(institutionalRepositoryProvider)
          .getDepartments(collegeId: college.id);
    });
