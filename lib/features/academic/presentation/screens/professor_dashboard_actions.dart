part of 'professor_dashboard_screen.dart';

class _QuickActionsPanel extends HookConsumerWidget {
  final ProfessorProfile profile;
  final bool isArabic;

  const _QuickActionsPanel({required this.profile, required this.isArabic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.academic.quick_actions,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.megaphone,
                label: t.academic.urgent_news,
                color: Colors.redAccent,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.uploadCloud,
                label: t.academic.upload_files,
                color: Colors.blueAccent,
                onTap: () => _showUploadDialog(context, ref, profile),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionTile(
                icon: LucideIcons.messageCircle,
                label: t.academic.messages,
                color: Colors.tealAccent,
                onTap: () => context.push('/professor-chat', extra: profile),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showUploadDialog(
    BuildContext context,
    WidgetRef ref,
    ProfessorProfile profile,
  ) {
    showDialog<bool>(
      context: context,
      builder: (context) => const CourseFileUploadDialog(),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
