import 'package:horus/core/auth/roles.dart';

const Set<String> publicRoutes = {
  '/splash',
  '/login',
  '/welcome',
  '/',
  '/language-selection',
  '/ui-style-selection',
  '/theme-selection',
  '/colleges-selection',
  '/transition',
};

const Map<String, Set<RoleCategory>> routePermissions = {
  '/dashboard': {RoleCategory.studentRoles},
  '/grades': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
  },
  '/transcript': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
  },
  '/progress': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
  },
  '/subject-result': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
  },
  '/action-plan': {RoleCategory.studentRoles},
  '/attendance': {
    RoleCategory.studentRoles,
    RoleCategory.teachingStaff,
  },
  '/registration': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
  },
  '/payment': {RoleCategory.studentRoles},
  '/invoices': {RoleCategory.studentRoles},
  '/digital-id': {RoleCategory.studentRoles},

  '/professor-dashboard': {
    RoleCategory.teachingStaff,
    RoleCategory.academicLeadership,
  },
  '/professor-profile': {
    RoleCategory.teachingStaff,
    RoleCategory.academicLeadership,
  },
  '/manage-tas': {RoleCategory.teachingStaff},
  '/manage-groups': {RoleCategory.teachingStaff},
  '/professor-chat': {RoleCategory.teachingStaff},
};

bool canAccessRoute(String path, UserRole role) {
  final allowed = routePermissions[path];
  if (allowed == null) return true;

  return allowed.contains(role.category);
}
