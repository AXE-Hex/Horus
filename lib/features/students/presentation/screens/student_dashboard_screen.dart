import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/shared/presentation/widgets/dashboard_action_widgets.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/students/presentation/widgets/horus_identity_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

part 'student_dashboard_academic_sections.dart';
part 'student_dashboard_id_section.dart';
part 'student_dashboard_list_sections.dart';
part 'student_dashboard_action_sections.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final auth = ref.watch(authControllerProvider);
    const d = Duration(milliseconds: 100);

    return GlassScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            _buildDigitalIDCard(context, isArabic, auth)
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOut)
                .shimmer(
                  duration: 1200.ms,
                  color: Colors.white.withValues(alpha: 0.2),
                ),

            const SizedBox(height: 32),

            _buildSectionHeader(context, t.students.academic)
                .animate()
                .fadeIn(delay: d)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildAcademicGrid(
              context,
              auth,
              isArabic,
            ).animate().fadeIn(delay: d * 2).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),

            _buildSectionHeader(context, t.students.enrollment_finance)
                .animate()
                .fadeIn(delay: d * 3)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildEnrollmentGrid(
              context,
              auth,
              isArabic,
            ).animate().fadeIn(delay: d * 4).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 24),

            _buildSectionHeader(context, t.students.utilities)
                .animate()
                .fadeIn(delay: d * 5)
                .slideX(begin: isArabic ? 0.2 : -0.2, end: 0),
            const SizedBox(height: 12),
            _buildUtilitiesRow(
              context,
              auth,
              isArabic,
            ).animate().fadeIn(delay: d * 6).slideX(begin: 0.2, end: 0),

            const SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
