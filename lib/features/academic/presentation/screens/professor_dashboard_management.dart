part of 'professor_dashboard_screen.dart';

class _ManagementGrid extends ConsumerWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _ManagementGrid({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final collegeId = auth.profile?.collegeId ?? '';

    final isAdvisor = auth.hasPermission(RolePermission.adviseStudents);
    final isDean = auth.hasPermission(RolePermission.assignAdvisors);

    final pendingRequestsCount = isAdvisor
        ? ref.watch(pendingRequestCountProvider)
        : const AsyncValue<int>.data(0);
    final unassignedStudentsCount = isDean
        ? ref.watch(unassignedStudentsCountProvider(collegeId))
        : const AsyncValue<int>.data(0);

    return Column(
      children: [
        if (isAdvisor) ...[
          _ManagementRow(
            icon: LucideIcons.checkSquare,
            title: t.academic.registration_requests,
            count: pendingRequestsCount.value,
            color: Colors.greenAccent,
            onTap: () => context.push('/advisor-approval'),
            isArabic: isArabic,
            hideCount: false,
          ),
          const SizedBox(height: 12),
        ],
        if (isDean) ...[
          _ManagementRow(
            icon: LucideIcons.userPlus,
            title: t.academic.advisor_assignment,
            count: unassignedStudentsCount.value,
            color: Colors.orangeAccent,
            onTap: () => context.push('/dean-assignment'),
            isArabic: isArabic,
            hideCount: false,
          ),
          const SizedBox(height: 12),
        ],

        _ManagementRow(
          icon: LucideIcons.users,
          title: t.academic.manage_tas,
          count: profile.teachingAssistants.length,
          color: const Color(0xFF6366F1),
          onTap: () => context.push('/manage-tas', extra: profile),
          isArabic: isArabic,
        ),
        const SizedBox(height: 12),
        _ManagementRow(
          icon: LucideIcons.folderKey,
          title: t.academic.shared_files,
          count: profile.sharedFiles.length,
          color: const Color(0xFFF59E0B),
          onTap: () {},
          isArabic: isArabic,
        ),
      ],
    );
  }
}

class _ManagementRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final int? count;
  final Color color;
  final VoidCallback onTap;
  final bool isArabic;
  final bool hideCount;

  const _ManagementRow({
    required this.icon,
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
    required this.isArabic,
    this.hideCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (!hideCount)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count?.toString() ?? '—',
                  style: GoogleFonts.shareTechMono(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            const SizedBox(width: 12),

            Icon(
              isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
              color: Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isArabic;

  const _SectionHeader({
    required this.title,
    required this.onTap,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            t.academic.view_all,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6366F1),
            ),
          ),
        ),
      ],
    );
  }
}
