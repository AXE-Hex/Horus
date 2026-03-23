import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/home/presentation/screens/home_screen.dart';
import 'package:hue/features/students/presentation/screens/digital_id_screen.dart';
import 'package:hue/features/students/presentation/screens/student_dashboard_screen.dart';
import 'package:hue/features/admin/presentation/screens/staff_dashboard_screen.dart';

import 'package:hue/features/colleges/presentation/screens/college_portal_screen.dart';
import 'package:hue/core/constants/colleges_data.dart';

final List<RouteBase> homeRoutes = [
  GoRoute(
    path: '/dashboard',
    builder: (context, state) => const DashboardScreen(),
  ),
  GoRoute(
    path: '/staff-dashboard',
    builder: (context, state) => const StaffDashboardScreen(),
  ),
  GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  GoRoute(
    path: '/digital-id',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>? ?? {};
      return DigitalIDScreen(studentData: extras);
    },
  ),
  GoRoute(
    path: '/college-portal',
    builder: (context, state) {
      final college = state.extra as StaticCollegeData?;

      if (college == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return CollegePortalScreen(college: college);
    },
  ),
];
