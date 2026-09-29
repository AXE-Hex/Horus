part of 'professor_profile_screen.dart';

extension _ProfessorProfileAnnouncements on ProfessorProfileScreen {
  Widget _buildUrgentAnnouncements(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.announcements.isEmpty) return const SizedBox.shrink();

    final urgentAnns = profile.announcements.where((a) => a.isUrgent).toList();
    if (urgentAnns.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.urgent_announcements,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        ...urgentAnns.map((ann) {
          final block = Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  LucideIcons.alertCircle,
                  color: Colors.redAccent,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ann.title,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ann.content,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isGlass ? Colors.white70 : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM dd, hh:mm a').format(ann.date),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: isGlass
                ? GlassContainer(
                    padding: EdgeInsets.zero,
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.3),
                    ),
                    child: block,
                  )
                : Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.redAccent,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: block,
                  ),
          );
        }),
      ],
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }

  Widget _buildTAsSection(
    BuildContext context,
    bool isGlass,
    Color color,
    bool isArabic,
  ) {
    if (profile.teachingAssistants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          t.professor.profile.teaching_assistants,
          isGlass,
          context,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: profile.teachingAssistants.length,
            itemBuilder: (context, index) {
              final ta = profile.teachingAssistants[index];
              final block = Container(
                width: 130,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isGlass ? null : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isGlass
                      ? null
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                          ),
                        ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: color.withValues(alpha: 0.1),
                      child: Icon(LucideIcons.user, color: color),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ta.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isGlass ? Colors.white : null,
                      ),
                    ),
                    Text(
                      ta.role,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: isGlass ? Colors.white60 : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Action: ${ta.name}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: isGlass
                      ? GlassContainer(padding: EdgeInsets.zero, child: block)
                      : block,
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn();
  }
}
