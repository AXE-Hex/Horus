import 'package:horus/core/auth/auth_provider.dart';

const Set<String> publicRoutes = {
  '/',
  '/splash',
  '/login',
  '/forgot-password',
  '/welcome',
  '/language-selection',
  '/ui-style-selection',
  '/theme-selection',
  '/colleges-selection',
  '/transition',
};

/// Route entry points are a client convenience. Database RLS/RPC checks remain
/// the authority for data access and mutations.
const Map<String, Set<String>> routePermissions = {
  '/home': {'profiles.read'},
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
  final requiredPermissions = routePermissions[path];
  if (requiredPermissions == null || requiredPermissions.isEmpty) return false;
  return requiredPermissions.any(permissionCodes.contains);
}

/// Resolves auth-driven navigation transitions; database policies remain the
/// security boundary for data access and writes.
String? redirectForAuthState(String location, AuthState authState) {
  final isPublic = publicRoutes.contains(location);

  if (!authState.isAuthenticated && !isPublic) return '/login';

  if (authState.isAuthenticated && location == '/login') {
    return authState.hasRole ? '/home' : '/splash';
  }

  if (authState.isAuthenticated && !isPublic && !authState.hasRole) {
    return '/splash';
  }

  if (authState.isAuthenticated &&
      !isPublic &&
      !canAccessRoute(location, authState.permissionCodes)) {
    return canAccessRoute('/home', authState.permissionCodes)
        ? '/home'
        : '/splash';
  }

  return null;
}
