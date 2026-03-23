import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/onboarding/presentation/screens/language_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/style_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/theme_screen.dart';
import 'package:hue/features/splash/presentation/screens/splash_screen.dart';
import 'package:hue/features/welcome/presentation/screens/welcome_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/college_details_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/academic_staff_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/college_departments_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/submit_rating_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/staff_rating_detail_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/department_detail_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/colleges_screen.dart';

import 'package:hue/features/shared/presentation/screens/transition_screen.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';

final List<RouteBase> onboardingRoutes = [
  GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
  GoRoute(
    path: '/language-selection',
    builder: (context, state) => const LanguageScreen(),
  ),
  GoRoute(
    path: '/ui-style-selection',
    builder: (context, state) => const StyleScreen(),
  ),
  GoRoute(
    path: '/theme-selection',
    builder: (context, state) => const ThemeScreen(),
  ),
  GoRoute(
    path: '/colleges-selection',
    builder: (context, state) => const CollegesScreen(),
  ),
  GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
  GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
  GoRoute(
    path: '/transition',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>?;
      return TransitionScreen(
        nextPath: extras?['nextPath'] ?? '/',
        message: extras?['message'],
        newLocale: extras?['newLocale'],
        onComplete: extras?['onComplete'],
        isRefresh: extras?['isRefresh'] ?? false,
      );
    },
  ),
  GoRoute(
    path: '/staff-rating-detail',
    builder: (context, state) {
      final staffMember = state.extra as Map<String, dynamic>?;

      if (staffMember == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return StaffRatingDetailScreen(staffMember: staffMember);
    },
  ),
  GoRoute(
    path: '/submit-rating',
    builder: (context, state) {
      final staffMember = state.extra as Map<String, dynamic>?;

      if (staffMember == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return SubmitRatingScreen(staffMember: staffMember);
    },
  ),
  GoRoute(
    path: '/department-detail',
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;

      if (extra == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      final department = extra['department'] as DepartmentModel;
      final color = extra['color'] as Color;
      return DepartmentDetailScreen(department: department, color: color);
    },
  ),
  GoRoute(
    path: '/academic-staff',
    builder: (context, state) {
      final collegeData = state.extra as Map<String, dynamic>?;

      if (collegeData == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return AcademicStaffScreen(collegeData: collegeData);
    },
  ),
  GoRoute(
    path: '/college-details',
    builder: (context, state) {
      final collegeData = state.extra as Map<String, dynamic>?;

      if (collegeData == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      return CollegeDetailsScreen(collegeData: collegeData);
    },
  ),
  GoRoute(
    path: '/college-departments',
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>?;

      if (extra == null) {
        return const Scaffold(
          body: Center(child: Text('Navigation error: missing data')),
        );
      }
      final college = extra['college'] as CollegeModel;
      final color = extra['color'] as Color;
      return CollegeDepartmentsScreen(college: college, color: color);
    },
  ),
];
