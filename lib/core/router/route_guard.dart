import 'package:hue/core/auth/roles.dart';

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
  '/students': {RoleCategory.studentRoles, RoleCategory.adminIT},
  '/grades': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
  },
  '/transcript': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
  },
  '/progress': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
  },
  '/subject-result': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
  },
  '/action-plan': {RoleCategory.studentRoles, RoleCategory.adminIT},
  '/attendance': {
    RoleCategory.studentRoles,
    RoleCategory.teachingStaff,
    RoleCategory.adminIT,
  },
  '/registration': {
    RoleCategory.studentRoles,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
  },
  '/payment': {RoleCategory.studentRoles, RoleCategory.adminIT},
  '/invoices': {RoleCategory.studentRoles, RoleCategory.adminIT},
  '/digital-id': {RoleCategory.studentRoles, RoleCategory.adminIT},

  '/professor-dashboard': {
    RoleCategory.teachingStaff,
    RoleCategory.academicLeadership,
    RoleCategory.adminIT,
  },
  '/professor-profile': {
    RoleCategory.teachingStaff,
    RoleCategory.academicLeadership,
    RoleCategory.adminIT,
  },
  '/manage-tas': {RoleCategory.teachingStaff, RoleCategory.adminIT},
  '/manage-groups': {RoleCategory.teachingStaff, RoleCategory.adminIT},
  '/professor-chat': {RoleCategory.teachingStaff, RoleCategory.adminIT},

  '/admin': {RoleCategory.adminIT},
  '/admin/users': {RoleCategory.adminIT},
  '/admin/users/new': {RoleCategory.adminIT},
  '/admin/users/details': {RoleCategory.adminIT},
  '/admin/users/edit': {RoleCategory.adminIT},
  '/admin/colleges': {RoleCategory.adminIT},
  '/admin/departments': {RoleCategory.adminIT},
  '/admin/audit-logs': {RoleCategory.adminIT},
  '/admin/roles': {RoleCategory.adminIT},
  '/admin/monitor': {RoleCategory.adminIT},
  '/admin/management/students': {
    RoleCategory.adminIT,
    RoleCategory.studentAffairs,
  },
  '/admin/management/staff': {RoleCategory.adminIT},
  '/admin/management/faculty': {RoleCategory.adminIT},
  '/admin/management/leadership': {RoleCategory.adminIT},
  '/admin/management/admin-it': {RoleCategory.adminIT},
};

bool canAccessRoute(String path, UserRole role) {
  if (role == UserRole.superAdmin) return true;

  final allowed = routePermissions[path];
  if (allowed == null) return true;

  return allowed.contains(role.category);
}
