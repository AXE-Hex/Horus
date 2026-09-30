part of 'college_portal_screen.dart';

extension _CollegePortalStaffSections on _CollegePortalScreenState {
  Widget _buildDeanSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    return CollegeStaffPanel(collegeId: college.id, deanOnly: true);
  }

  Widget _buildStaffSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final staffAsync = ref.watch(collegeStaffListProvider(college.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.users, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.faculty_staff,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        staffAsync.when(
          data: (staff) {
            if (staff.isEmpty) {
              return Center(
                child: Text(
                  t.extracted.no_staff_registered_yet,
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: staff.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final member = staff[index];
                final name = isArabic && member.fullNameAr != null
                    ? member.fullNameAr!
                    : member.fullName;

                final role = member.roles.isNotEmpty
                    ? member.roles.first.displayName()
                    : '';

                final item = Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isGlass ? null : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: isGlass
                        ? null
                        : Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: color.withValues(alpha: 0.1),
                        backgroundImage: member.avatarUrl != null
                            ? NetworkImage(member.avatarUrl!)
                            : null,
                        child: member.avatarUrl == null
                            ? Icon(LucideIcons.user, color: color)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isGlass ? Colors.white : null,
                              ),
                            ),
                            Text(
                              role,
                              style: TextStyle(
                                fontSize: 13,
                                color: color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );

                return isGlass
                    ? GlassContainer(
                        borderRadius: BorderRadius.circular(20),
                        padding: EdgeInsets.zero,
                        child: item,
                      )
                    : item;
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(t.academic.error)),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }
}
