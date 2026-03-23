import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/admin/presentation/screens/administration_screen.dart';

import 'package:hue/features/admin/presentation/screens/users_list_screen.dart';
import 'package:hue/features/admin/presentation/screens/user_form_screen.dart';
import 'package:hue/features/admin/presentation/screens/student_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/staff_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/leadership_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/admin_it_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/professors_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/system_settings_screen.dart';
import 'package:hue/features/admin/presentation/screens/user_details_screen.dart';
import 'package:hue/features/admin/presentation/screens/college_details_screen.dart'
    as admin_screens;
import 'package:hue/features/admin/presentation/screens/colleges_management_screen.dart';
import 'package:hue/features/admin/presentation/screens/departments_management_screen.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/presentation/screens/add_college_screen.dart';
import 'package:hue/features/admin/presentation/screens/add_department_screen.dart';
import 'package:hue/features/admin/presentation/screens/department_details_screen.dart';
import 'package:hue/features/admin/presentation/screens/audit_logs_screen.dart';
import 'package:hue/features/admin/presentation/screens/roles_management_screen.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/core/auth/roles.dart';

final List<RouteBase> adminRoutes = [
  GoRoute(
    path: '/admin',
    builder: (context, state) => const AdministrationScreen(),
  ),
  GoRoute(
    path: '/admin/management/students',
    builder: (context, state) => const StudentManagementScreen(),
  ),
  GoRoute(
    path: '/admin/management/staff',
    builder: (context, state) => const StaffManagementScreen(),
  ),
  GoRoute(
    path: '/admin/management/leadership',
    builder: (context, state) => const LeadershipManagementScreen(),
  ),
  GoRoute(
    path: '/admin/management/admin-it',
    builder: (context, state) => const AdminITManagementScreen(),
  ),
  GoRoute(
    path: '/admin/management/professors',
    builder: (context, state) => const ProfessorsManagementScreen(),
  ),
  GoRoute(
    path: '/admin/settings',
    builder: (context, state) => const SystemSettingsScreen(),
  ),
  GoRoute(
    path: '/admin/users',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      return UsersListScreen(
        category: extras['category'] as RoleCategory?,
        role: extras['role'] as UserRole?,
        title: extras['title'] as String? ?? 'User Management',
      );
    },
  ),
  GoRoute(
    path: '/admin/users/new',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      return UserFormScreen(
        initialCategory: extras['category'] as RoleCategory?,
        initialRole: extras['role'] as UserRole?,
      );
    },
  ),
  GoRoute(
    path: '/admin/users/details',
    builder: (context, state) {
      final user = state.extra as UserProfileModel?;

      if (user == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return UserDetailsScreen(user: user);
    },
  ),
  GoRoute(
    path: '/admin/users/edit',
    builder: (context, state) {
      final user = state.extra as UserProfileModel?;

      if (user == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return UserFormScreen(user: user);
    },
  ),
  GoRoute(
    path: '/admin/colleges',
    builder: (context, state) => const CollegesManagementScreen(),
  ),
  GoRoute(
    path: '/admin/colleges/form',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      return AddCollegeScreen(college: extras['college'] as CollegeModel?);
    },
  ),
  GoRoute(
    path: '/admin/departments',
    builder: (context, state) => const DepartmentsManagementScreen(),
  ),
  GoRoute(
    path: '/admin/departments/form',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      return AddDepartmentScreen(
        department: extras['department'] as DepartmentModel?,
        inputCollegeId: extras['collegeId'] as String?,
      );
    },
  ),
  GoRoute(
    path: '/admin/departments/details',
    builder: (context, state) {
      final dept = state.extra as DepartmentModel?;

      if (dept == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return DepartmentDetailsScreen(department: dept);
    },
  ),
  GoRoute(
    path: '/admin/audit-logs',
    builder: (context, state) => const AuditLogsScreen(),
  ),
  GoRoute(
    path: '/admin/roles',
    builder: (context, state) => const RolesManagementScreen(),
  ),
  GoRoute(
    path: '/admin/colleges/details',
    builder: (context, state) {
      final college = state.extra as CollegeModel?;

      if (college == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return admin_screens.CollegeDetailsScreen(college: college);
    },
  ),
];
