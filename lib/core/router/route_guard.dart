// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/core/auth/roles.dart';

/// ╔══════════════════════════════════════════════════════════════════╗
/// ║          HUE University — Route Permission Guards               ║
/// ╚══════════════════════════════════════════════════════════════════╝
///
/// Centralized role-based access control for all app routes.
/// Routes NOT listed here are accessible to all authenticated users.

/// Routes that do NOT require authentication (public routes).
const Set<String> publicRoutes = {
  '/splash',
  '/login',
  '/welcome',
  '/',
  '/forgot-password',
  '/language-selection',
  '/ui-style-selection',
  '/theme-selection',
  '/colleges-selection',
  '/transition',
};

/// Maps route paths → set of allowed [RoleCategory] values.
/// If a route is not in this map, any authenticated user can access it.
/// [superAdmin] always bypasses all restrictions.
const Map<String, Set<RoleCategory>> routePermissions = {
  // ── Student Pages ──────────────────────────────
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

  // ── Professor / Teaching Staff Pages ───────────
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

  // ── Admin Pages ────────────────────────────────
  '/admin': {RoleCategory.adminIT},
  '/students-mgmt': {RoleCategory.adminIT, RoleCategory.studentAffairs},
};

/// Check if a [UserRole] can access the given [path].
///
/// Logic:
/// 1. [superAdmin] can access everything.
/// 2. If the route is not in [routePermissions], any authenticated user can access it.
/// 3. Otherwise, check if the role's category is in the allowed set.
bool canAccessRoute(String path, UserRole role) {
  // Super admin bypasses all checks
  if (role == UserRole.superAdmin) return true;

  // If route has no restrictions, allow
  final allowed = routePermissions[path];
  if (allowed == null) return true;

  // Check if the role's category is in the allowed set
  return allowed.contains(role.category);
}
