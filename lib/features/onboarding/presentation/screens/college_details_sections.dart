part of 'college_details_screen.dart';

extension _CollegeDetailsSections on CollegeDetailsScreen {
  Widget _buildSectionHeader(BuildContext context, String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildDeanCard(BuildContext context, Color color, bool isGlass) {
    return CollegeStaffPanel(
      collegeId: collegeData['id'] as String?,
      deanOnly: true,
    );
  }

  Widget _buildStaffList(BuildContext context, Color color, bool isGlass) {
    return CollegeStaffPanel(collegeId: collegeData['id'] as String?);
  }

  Widget _buildDepartmentsButton(
    BuildContext context,
    Map<String, dynamic> collegeData,
    Color color,
    bool isGlass,
  ) {
    final buttonContent = Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(LucideIcons.layoutGrid, color: color, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.colleges.details.departments,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  t.colleges.details.explore_majors,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.chevronRight, size: 20),
        ],
      ),
    );

    if (isGlass) {
      return GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: () => context.push('/college-departments', extra: collegeData),
          borderRadius: BorderRadius.circular(24),
          child: buttonContent,
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: InkWell(
          onTap: () => context.push('/college-departments', extra: collegeData),
          borderRadius: BorderRadius.circular(24),
          child: buttonContent,
        ),
      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
    }
  }
}
