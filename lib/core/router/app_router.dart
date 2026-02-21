// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/router/route_guard.dart';
import 'package:hue/features/auth/presentation/screens/login_screen.dart';
import 'package:hue/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:hue/features/home/presentation/screens/home_screen.dart';
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
import 'package:hue/features/students/presentation/screens/digital_id_screen.dart';
import 'package:hue/features/students/presentation/screens/student_dashboard_screen.dart';
import 'package:hue/features/settings/presentation/screens/settings_screen.dart';
import 'package:hue/features/admin/presentation/screens/administration_screen.dart';
import 'package:hue/features/academic/presentation/screens/transcript_screen.dart';
import 'package:hue/features/academic/presentation/screens/academic_progress_screen.dart';
import 'package:hue/features/academic/presentation/screens/grades_screen.dart';
import 'package:hue/features/academic/presentation/screens/subject_results_screen.dart';
import 'package:hue/features/academic/presentation/screens/action_plan_screen.dart';
import 'package:hue/features/academic/presentation/screens/courses_screen.dart';
import 'package:hue/features/academic/presentation/screens/daily_schedule_screen.dart';
import 'package:hue/features/academic/presentation/screens/exam_schedule_screen.dart';
import 'package:hue/features/academic/presentation/screens/attendance_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/registration_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/payment_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/invoices_screen.dart';
import 'package:hue/features/shared/presentation/screens/notifications_screen.dart';
import 'package:hue/features/shared/presentation/screens/support_screen.dart';
import 'package:hue/features/shared/presentation/screens/security_screen.dart';
import 'package:hue/features/shared/presentation/screens/sessions_screen.dart';
import 'package:hue/features/shared/presentation/screens/tutorials_screen.dart';
import 'package:hue/features/shared/presentation/screens/forums_screen.dart';
import 'package:hue/features/shared/presentation/screens/placeholder_screen.dart';
import 'package:hue/features/shared/presentation/screens/transition_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_profile_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_dashboard_screen.dart';
import 'package:hue/features/academic/data/models/professor_profile_models.dart';
import 'package:hue/features/academic/presentation/screens/manage_tas_screen.dart';
import 'package:hue/features/academic/presentation/screens/manage_groups_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_chat_screen.dart';
import 'package:hue/features/settings/presentation/screens/profile_screen.dart';
import 'package:hue/features/settings/presentation/screens/change_password_screen.dart';
import 'package:hue/features/settings/presentation/screens/about_screen.dart';
import 'package:hue/features/settings/presentation/screens/privacy_policy_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = ValueNotifier<AuthState>(
    ref.read(authControllerProvider),
  );

  ref.listen<AuthState>(authControllerProvider, (_, next) {
    authNotifier.value = next;
  });

  ref.onDispose(authNotifier.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;
      final location = state.matchedLocation;
      final isLoggedIn = authState.isAuthenticated;
      final isPublic = publicRoutes.contains(location);

      // 1. Auth guard — unauthenticated users must go to /login
      if (!isLoggedIn && !isPublic) {
        return '/login';
      }

      // 2. Already-logged-in guard — no need to see /login again
      if (isLoggedIn && location == '/login') {
        return '/home';
      }

      // 3. Role guard — check route permissions
      if (isLoggedIn && !canAccessRoute(location, authState.role)) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
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
      GoRoute(
        path: '/students',
        builder: (context, state) => const StudentDashboardScreen(),
      ),
      GoRoute(
        path: '/grades',
        builder: (context, state) => const GradesScreen(),
      ),
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
        path: '/action-plan',
        builder: (context, state) => const ActionPlanScreen(),
      ),
      GoRoute(
        path: '/schedule',
        builder: (context, state) => const DailyScheduleScreen(),
      ),
      GoRoute(
        path: '/exam-schedule',
        builder: (context, state) => const ExamScheduleScreen(),
      ),
      GoRoute(
        path: '/attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CoursesScreen(),
      ),
      GoRoute(
        path: '/registration',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: '/invoices',
        builder: (context, state) => const InvoicesScreen(),
      ),
      GoRoute(
        path: '/biometrics',
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: '/sessions',
        builder: (context, state) => const SessionsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/forums',
        builder: (context, state) => const ForumsScreen(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: '/students-mgmt',
        builder: (context, state) =>
            const PlaceholderScreen(title: 'Students Management'),
      ),
      GoRoute(
        path: '/tutorials',
        builder: (context, state) => const TutorialsScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdministrationScreen(),
      ),
      GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
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
          final staffMember = state.extra as Map<String, dynamic>;
          return StaffRatingDetailScreen(staffMember: staffMember);
        },
      ),
      GoRoute(
        path: '/submit-rating',
        builder: (context, state) {
          final staffMember = state.extra as Map<String, dynamic>;
          return SubmitRatingScreen(staffMember: staffMember);
        },
      ),
      GoRoute(
        path: '/department-detail',
        builder: (context, state) {
          final departmentData = state.extra as Map<String, dynamic>;
          return DepartmentDetailScreen(departmentData: departmentData);
        },
      ),
      GoRoute(
        path: '/academic-staff',
        builder: (context, state) {
          final collegeData = state.extra as Map<String, dynamic>;
          return AcademicStaffScreen(collegeData: collegeData);
        },
      ),
      GoRoute(
        path: '/college-details',
        builder: (context, state) {
          final collegeData = state.extra as Map<String, dynamic>;
          return CollegeDetailsScreen(collegeData: collegeData);
        },
      ),
      GoRoute(
        path: '/college-departments',
        builder: (context, state) {
          final collegeData = state.extra as Map<String, dynamic>;
          return CollegeDepartmentsScreen(collegeData: collegeData);
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/digital-id',
        builder: (context, state) {
          final extras = state.extra as Map<String, dynamic>? ?? {};
          return DigitalIDScreen(studentData: extras);
        },
      ),
      GoRoute(
        path: '/professor-profile',
        builder: (context, state) {
          final profile = state.extra as ProfessorProfile;
          return ProfessorProfileScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/professor-dashboard',
        builder: (context, state) {
          final profile = state.extra as ProfessorProfile;
          return ProfessorDashboardScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/manage-tas',
        builder: (context, state) {
          final profile = state.extra as ProfessorProfile;
          return ManageTasScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/manage-groups',
        builder: (context, state) {
          final profile = state.extra as ProfessorProfile;
          return ManageGroupsScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/professor-chat',
        builder: (context, state) {
          final profile = state.extra as ProfessorProfile;
          return ProfessorChatScreen(profile: profile);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(path: '/about', builder: (context, state) => const AboutScreen()),
      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
    ],
  );
});
