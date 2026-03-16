import 'package:hue/core/auth/roles.dart';
import 'package:hue/core/auth/permission_matrix.dart';

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

/// Global permission matrix used for fine-grained route access checks.
final PermissionMatrix _permissionMatrix = PermissionMatrix.initial();

/// Required permissions for restricted admin routes.
///
/// A user may access the route if they have **any** of the listed permissions.
const Map<String, Set<RolePermission>> adminRoutePermissions = {
  '/admin': {
    RolePermission.manageSystem,
    RolePermission.manageUsers,
    RolePermission.manageColleges,
    RolePermission.manageDepartments,
    RolePermission.viewAuditLogs,
  },
  '/admin/users': {RolePermission.manageUsers},
  '/admin/users/new': {RolePermission.manageUsers},
  '/admin/users/details': {RolePermission.manageUsers},
  '/admin/users/edit': {RolePermission.manageUsers},
  '/admin/colleges': {RolePermission.manageColleges},
  '/admin/departments': {RolePermission.manageDepartments},
  '/admin/audit-logs': {RolePermission.viewAuditLogs},
  '/admin/roles': {
    RolePermission.manageSystem,
    RolePermission.manageUsers,
  },
  '/admin/monitor': {RolePermission.manageSystem},
  '/admin/management/students': {
    RolePermission.manageEnrollments,
    RolePermission.adviseStudents,
  },
  '/admin/management/staff': {RolePermission.manageUsers},
  '/admin/management/faculty': {RolePermission.manageUsers},
  '/admin/management/leadership': {
    RolePermission.manageColleges,
    RolePermission.manageDepartments,
  },
  '/admin/management/admin-it': {RolePermission.manageSystem},
};

const Map<String, Set<RoleCategory>> routePermissions = {
  '/dashboard': {
    RoleCategory.studentRoles,
    RoleCategory.adminIT,
  },
  '/staff-dashboard': {
    RoleCategory.teachingStaff,
    RoleCategory.academicLeadership,
    RoleCategory.studentAffairs,
    RoleCategory.adminIT,
    RoleCategory.facilitiesSecurity,
    RoleCategory.externalRoles,
  },
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

  // 1) Fine-grained admin routes based on RolePermission.
  final requiredPermissions = adminRoutePermissions[path];
  if (requiredPermissions != null) {
    for (final permission in requiredPermissions) {
      if (_permissionMatrix.checkAccess(role, permission)) {
        return true;
      }
    }
    // Route is protected by permissions and none matched.
    return false;
  }

  // 2) Legacy category-based restrictions for non-admin routes.
  final allowed = routePermissions[path];
  if (allowed == null) return true;

  return allowed.contains(role.category);
}
