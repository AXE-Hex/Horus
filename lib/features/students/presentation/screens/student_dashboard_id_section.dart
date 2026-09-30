part of 'student_dashboard_screen.dart';

extension _StudentDashboardIdSection on DashboardScreen {
  Widget _buildDigitalIDCard(
    BuildContext context,
    bool isArabic,
    AuthState auth,
  ) {
    final profile = auth.profile;
    if (profile == null) return const SizedBox.shrink();
    return Semantics(
      button: true,
      label: t.students.smart_digital_id,
      child: InkWell(
        onTap: () => context.push('/digital-id'),
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Hero(
          tag: 'digital_id_card',
          child: Material(
            color: Colors.transparent,
            child: HorusIdentityCard(profile: profile),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) =>
      DashboardSectionHeader(title: title);
}
