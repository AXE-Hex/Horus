import 'package:go_router/go_router.dart';
import 'package:hue/features/enrollment/presentation/screens/registration_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/payment_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/invoices_screen.dart';

import 'package:hue/features/enrollment/presentation/screens/advisor_approval_screen.dart';
import 'package:hue/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart';

final List<RouteBase> enrollmentRoutes = [
  GoRoute(
    path: '/registration',
    builder: (context, state) => const RegistrationScreen(),
  ),
  GoRoute(path: '/payment', builder: (context, state) => const PaymentScreen()),
  GoRoute(
    path: '/invoices',
    builder: (context, state) => const InvoicesScreen(),
  ),
  GoRoute(
    path: '/advisor-approval',
    builder: (context, state) => const AdvisorApprovalScreen(),
  ),
  GoRoute(
    path: '/dean-assignment',
    builder: (context, state) => const DeanAdvisorAssignmentScreen(),
  ),
];
