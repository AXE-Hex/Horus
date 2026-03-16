import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:hue/features/enrollment/data/repositories/advisor_repository.dart';

// ── Provider for advisor's pending requests list
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

// ── Provider for student's own registration request
final myRegistrationRequestProvider =
    FutureProvider.family<RegistrationRequest?, String>((ref, semester) {
      return ref
          .read(advisorRepositoryProvider)
          .getMyRegistrationRequest(semester);
    });

// ── Provider for student's advisor info
final myAdvisorProvider = FutureProvider<AdvisorInfo?>((ref) {
  return ref.read(advisorRepositoryProvider).getMyAdvisor();
});

// ── Provider for pending count (badge)
final pendingRequestCountProvider = FutureProvider<int>((ref) {
  return ref.read(advisorRepositoryProvider).getPendingRequestCount();
});

// ── Provider for advisor students list
final advisorStudentsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) {
  return ref.read(advisorRepositoryProvider).getAdvisorStudents();
});

// ── Provider for dean: college advisors
final collegeAdvisorsProvider =
    FutureProvider.family<List<AdvisorInfo>, String>((ref, collegeId) {
      return ref.read(advisorRepositoryProvider).getCollegeAdvisors(collegeId);
    });

// ── Provider for dean: college students
final collegeStudentsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((ref, collegeId) {
      return ref.read(advisorRepositoryProvider).getCollegeStudents(collegeId);
    });

// ── Provider for dean: unassigned students count
final unassignedStudentsCountProvider =
    FutureProvider.family<int, String>((ref, collegeId) async {
  final students = await ref.read(advisorRepositoryProvider).getCollegeStudents(
    collegeId,
    unassignedOnly: true,
  );
  return students.length;
});

