part of 'college_portal_screen.dart';

extension _CollegePortalDepartments on _CollegePortalScreenState {
  Widget _buildDepartmentsSection(
    StaticCollegeData college,
    Color color,
    bool isGlass,
    bool isArabic,
  ) {
    final depts = isArabic ? college.departmentsAr : college.departmentsEn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.grid, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              t.extracted.scientific_departments,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: depts.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final dept = depts[index];
            final item = Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: isGlass ? null : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: isGlass
                    ? null
                    : Border.all(color: Colors.grey.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      dept,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: isGlass ? Colors.white38 : Colors.grey[400],
                  ),
                ],
              ),
            );

            return isGlass
                ? GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: EdgeInsets.zero,
                    child: item,
                  )
                : item;
          },
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
  }
}
