import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:hue/features/enrollment/data/repositories/advisor_repository.dart';

final advisorRequestsProvider =
    AsyncNotifierProvider<AdvisorRequestsNotifier, List<RegistrationRequest>>(
      AdvisorRequestsNotifier.new,
    );

class AdvisorRequestsNotifier extends AsyncNotifier<List<RegistrationRequest>> {
  @override
  Future<List<RegistrationRequest>> build() {
    return ref.read(advisorRepositoryProvider).getAdvisorRequests();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(advisorRepositoryProvider).getAdvisorRequests(),
    );
  }

  Future<void> approve(String requestId, {String? notes}) async {
    await ref
        .read(advisorRepositoryProvider)
        .approveRequest(requestId, notes: notes);
    await refresh();
  }

  Future<void> reject(String requestId, {String? notes}) async {
    await ref
        .read(advisorRepositoryProvider)
        .rejectRequest(requestId, notes: notes);
    await refresh();
  }
}

final myRegistrationRequestProvider =
    FutureProvider.family<RegistrationRequest?, String>((ref, semester) {
      return ref
          .read(advisorRepositoryProvider)
          .getMyRegistrationRequest(semester);
    });

final myAdvisorProvider = FutureProvider<AdvisorInfo?>((ref) {
  return ref.read(advisorRepositoryProvider).getMyAdvisor();
});

final pendingRequestCountProvider = FutureProvider<int>((ref) {
  return ref.read(advisorRepositoryProvider).getPendingRequestCount();
});

final advisorStudentsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  return ref.read(advisorRepositoryProvider).getAdvisorStudents();
});

final collegeAdvisorsProvider =
    FutureProvider.family<List<AdvisorInfo>, String>((ref, collegeId) {
      return ref.read(advisorRepositoryProvider).getCollegeAdvisors(collegeId);
    });

final collegeStudentsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, collegeId) {
      return ref.read(advisorRepositoryProvider).getCollegeStudents(collegeId);
    });

final unassignedStudentsCountProvider = FutureProvider.family<int, String>((
  ref,
  collegeId,
) async {
  final students = await ref
      .read(advisorRepositoryProvider)
      .getCollegeStudents(collegeId, unassignedOnly: true);
  return students.length;
});
