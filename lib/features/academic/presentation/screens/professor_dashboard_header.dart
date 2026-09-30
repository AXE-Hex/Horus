part of 'professor_dashboard_screen.dart';

class _ImmersiveHeader extends StatelessWidget {
  const _ImmersiveHeader({required this.profile, required this.isArabic});
  final ProfessorProfile profile;
  final bool isArabic;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.navy700, AppColors.navy950],
            ),
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.gold400.withValues(alpha: .4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Logo_dark.png',
                width: 148,
                height: 74,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                '${t.auth.splash.welcome_prefix} ${profile.name}',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              if (profile.department.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  profile.department,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.gold300),
                ),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
