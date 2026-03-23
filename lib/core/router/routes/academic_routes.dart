import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/features/academic/presentation/screens/transcript_screen.dart';
import 'package:hue/features/academic/presentation/screens/academic_progress_screen.dart';
import 'package:hue/features/academic/presentation/screens/grades_screen.dart';
import 'package:hue/features/academic/presentation/screens/subject_results_screen.dart';
import 'package:hue/features/academic/presentation/screens/action_plan_screen.dart';
import 'package:hue/features/academic/presentation/screens/courses_screen.dart';
import 'package:hue/features/academic/presentation/screens/daily_schedule_screen.dart';
import 'package:hue/features/academic/presentation/screens/exam_schedule_screen.dart';
import 'package:hue/features/academic/presentation/screens/attendance_screen.dart';
import 'package:hue/features/academic/presentation/screens/specialization_projects_screen.dart';

import 'package:hue/features/academic/presentation/screens/professor_profile_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_dashboard_screen.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/academic/presentation/screens/manage_tas_screen.dart';
import 'package:hue/features/academic/presentation/screens/manage_groups_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_chat_screen.dart';

final List<RouteBase> academicRoutes = [
  GoRoute(path: '/grades', builder: (context, state) => const GradesScreen()),
  GoRoute(
    path: '/transcript',
    builder: (context, state) => const TranscriptScreen(),
  ),
  GoRoute(
    path: '/progress',
    builder: (context, state) => const AcademicProgressScreen(),
  ),
  GoRoute(
    path: '/subject-result',
    builder: (context, state) => const SubjectResultsScreen(),
  ),
  GoRoute(
    path: '/specialization-projects',
    builder: (context, state) => const SpecializationProjectsScreen(),
  ),
  GoRoute(
    path: '/action-plan',
    builder: (context, state) => ActionPlanScreen(),
  ),
  GoRoute(
    path: '/schedule',
    builder: (context, state) => const DailyScheduleScreen(),
  ),
  GoRoute(
    path: '/exam-schedule',
    builder: (context, state) => ExamScheduleScreen(),
  ),
  GoRoute(
    path: '/attendance',
    builder: (context, state) => const AttendanceScreen(),
  ),
  GoRoute(path: '/courses', builder: (context, state) => const CoursesScreen()),
  GoRoute(
    path: '/professor-profile',
    builder: (context, state) {
      final profile = state.extra as ProfessorProfile?;
      if (profile == null) {
        return const Scaffold(
          body: Center(child: Text('Professor profile not available')),
        );
      }
      return ProfessorProfileScreen(profile: profile);
    },
  ),
  GoRoute(
    path: '/professor-dashboard',
    builder: (context, state) {
      final profile = state.extra as ProfessorProfile?;
      if (profile == null) {
        return const Scaffold(
          body: Center(child: Text('Professor profile not available')),
        );
      }
      return ProfessorDashboardScreen(profile: profile);
    },
  ),
  GoRoute(
    path: '/manage-tas',
    builder: (context, state) {
      final profile = state.extra as ProfessorProfile?;
      if (profile == null) {
        return const Scaffold(
          body: Center(child: Text('Professor profile not available')),
        );
      }
      return ManageTasScreen(profile: profile);
    },
  ),
  GoRoute(
    path: '/manage-groups',
    builder: (context, state) {
      final profile = state.extra as ProfessorProfile?;
      if (profile == null) {
        return const Scaffold(
          body: Center(child: Text('Professor profile not available')),
        );
      }
      return ManageGroupsScreen(profile: profile);
    },
  ),
  GoRoute(
    path: '/professor-chat',
    builder: (context, state) {
      final profile = state.extra as ProfessorProfile?;
      if (profile == null) {
        return const Scaffold(
          body: Center(child: Text('Professor profile not available')),
        );
      }
      return ProfessorChatScreen(profile: profile);
    },
  ),
];
