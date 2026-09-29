part of 'professor_profile_screen.dart';

extension _ProfessorProfileGroupsFiles on ProfessorProfileScreen {
  Widget _buildGroupsSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.groups.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(t.professor.stats.groups, isGlass, context),
        const SizedBox(height: 12),
        ...profile.groups.map((group) {
          final block = ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(LucideIcons.users, color: color, size: 20),
            ),
            title: Text(
              group.name,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
            subtitle: Text(
              '${group.studentCount} students',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: isGlass ? Colors.white60 : Colors.grey,
              ),
            ),
            trailing: group.isJoined
                ? const Icon(LucideIcons.checkCircle2, color: Colors.green)
                : OutlinedButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${t.academic.joined} ${group.name}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: isGlass ? Colors.white : color,
                      side: BorderSide(color: isGlass ? Colors.white30 : color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(t.professor.join),
                  ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildSharedFilesSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.sharedFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.shared_resources,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        ...profile.sharedFiles.map((file) {
          final block = ListTile(
            onTap: () {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${t.professor.quick_actions.action_clicked}: ${file.title}',
                  ),
                ),
              );
            },
            leading: Icon(
              file.fileType == SharedFileType.pdf
                  ? LucideIcons.fileText
                  : LucideIcons.file,
              color: file.fileType == SharedFileType.pdf
                  ? Colors.redAccent
                  : Colors.blueAccent,
            ),
            title: Text(
              file.title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isGlass ? Colors.white : null,
              ),
            ),
            subtitle: Text(
              '${file.fileType.name.toUpperCase()} • ${file.sizeLabel}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: isGlass ? Colors.white60 : Colors.grey,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                LucideIcons.download,
                color: isGlass ? Colors.white70 : Colors.black54,
              ),
              onPressed: () {
                HapticFeedback.selectionClick();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.professor.downloading),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildOfficeHoursSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.officeHours.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(t.professor.profile.office_hours, isGlass, context),
        const SizedBox(height: 12),
        ...profile.officeHours.map((oh) {
          final block = Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        oh.dayOfWeek,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isGlass ? Colors.white : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        oh.timeRange,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: 12,
                            color: isGlass ? Colors.white60 : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            oh.location,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: isGlass ? Colors.white60 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (oh.isWalkIn)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t.professor.walk_in,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(padding: EdgeInsets.zero, child: block)
                : Card(child: block),
          );
        }),
      ],
    ).animate().fadeIn();
  }

  Widget _buildSectionTitle(String title, bool isGlass, BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: isGlass ? Colors.white : Theme.of(context).primaryColor,
      ),
    );
  }
}
