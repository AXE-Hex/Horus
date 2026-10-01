import 'package:horus/core/auth/auth_provider.dart';

const Set<String> publicRoutes = {
  '/splash',
  '/login',
  '/forgot-password',
  '/guest-registration',
};

/// Route entry points are a client convenience. Database RLS/RPC checks remain
/// the authority for data access and mutations.
const Map<String, Set<String>> routePermissions = {
  '/home': {'profiles.read'},
  '/colleges-selection': {'profiles.read'},
  '/control': {
    'courses.manage',
    'registration.manage',
    'registration.review',
    'students.advise',
    'students.assign_advisor',
  },
  '/access-pending': {},
  '/dashboard': {'grades.read', 'grades.manage', 'students.progress.read'},
  '/digital-id': {'courses.enroll'},
  '/college-portal': {'profiles.read'},
  '/college-details': {'profiles.read'},
  '/academic-staff': {'profiles.read'},
  '/college-departments': {'profiles.read'},
  '/department-detail': {'profiles.read'},
  '/staff-rating-detail': {'ratings.submit', 'grades.read'},
  '/submit-rating': {'ratings.submit', 'grades.read'},
  '/grades': {'grades.read'},
  '/transcript': {'grades.read'},
  '/progress': {'grades.read', 'students.progress.read'},
  '/subject-result': {'grades.read'},
  '/action-plan': {'grades.read'},
  '/attendance': {'attendance.read', 'attendance.manage'},
  '/schedule': {'schedule.read', 'schedules.manage'},
  '/exam-schedule': {'schedule.read', 'schedules.manage'},
  '/courses': {'courses.enroll', 'courses.manage'},
  '/specialization-projects': {'courses.enroll', 'courses.manage'},
  '/registration': {'courses.enroll', 'registration.manage'},
  '/advisor-approval': {'registration.review', 'students.advise'},
  '/dean-assignment': {'students.assign_advisor'},
  '/payment': {'finance.read'},
  '/invoices': {'finance.read'},
  '/professor-dashboard': {'grades.manage', 'courses.manage'},
  '/professor-profile': {'grades.manage', 'courses.manage'},
  '/manage-tas': {'teaching_assistants.manage'},
  '/manage-groups': {'groups.manage'},
  '/professor-chat': {'forums.access'},
  '/feed': {'profiles.read', 'forums.access'},
  '/conversations': {'forums.access'},
  '/conversations/:conversationId': {'forums.access'},
  '/create-post': {'posts.create'},
  '/forums': {'forums.access'},
  '/settings': {'profiles.self_edit'},
  '/profile': {'profiles.self_edit'},
  '/change-password': {'profiles.self_edit'},
  '/about': {'profiles.read'},
  '/privacy-policy': {'profiles.read'},
  '/biometrics': {'profiles.self_edit'},
  '/sessions': {'profiles.self_edit'},
  '/notifications': {'notifications.read'},
  '/support': {'support.submit'},
  '/tutorials': {'profiles.read'},
};

bool canAccessRoute(String path, Set<String> permissionCodes) {
  final requiredPermissions =
      routePermissions[path] ??
      (RegExp(r'^/conversations/[^/]+$').hasMatch(path)
          ? routePermissions['/conversations/:conversationId']
          : null);
  if (requiredPermissions == null || requiredPermissions.isEmpty) return false;
  return requiredPermissions.any(permissionCodes.contains);
}

String resolveInitialDestination(AuthState authState) {
  if (!authState.isAuthenticated) return '/login';
  if (authState.isLoading) return '/splash';
  if (!authState.hasRole) return '/access-pending';

  final permissions = authState.permissionCodes;
  if (permissions.contains('profiles.read')) return '/home';
  if (authState.profile!.roles.any(
        (role) => role.category == RoleCategory.academicLeadership,
      ) &&
      canAccessRoute('/control', permissions)) {
    return '/control';
  }
  if (permissions.contains('students.advise')) return '/advisor-approval';
  if (permissions.contains('registration.manage')) return '/registration';
  if (permissions.contains('grades.manage')) return '/professor-dashboard';
  if (permissions.contains('grades.read')) return '/dashboard';
  if (permissions.contains('forums.access')) return '/forums';
  if (permissions.contains('courses.manage')) return '/courses';
  if (permissions.contains('courses.enroll')) return '/courses';
  return '/access-pending';
}

/// Resolves auth-driven navigation transitions; database policies remain the
/// security boundary for data access and writes.
String? redirectForAuthState(String location, AuthState authState) {
  final isPublic = publicRoutes.contains(location);

  if (!authState.isAuthenticated && !isPublic) return '/login';

  if (location == '/access-pending') {
    return authState.isAuthenticated ? null : '/login';
  }

  if (location == '/splash') return null;

  if (authState.isAuthenticated && location == '/guest-registration') {
    return resolveInitialDestination(authState);
  }

  if (authState.isAuthenticated && location == '/login') {
    return resolveInitialDestination(authState);
  }

  if (authState.isAuthenticated && !isPublic && !authState.hasRole) {
    return '/access-pending';
  }

  if (authState.isAuthenticated &&
      !isPublic &&
      !canAccessRoute(location, authState.permissionCodes)) {
    return resolveInitialDestination(authState);
  }

  return null;
}
