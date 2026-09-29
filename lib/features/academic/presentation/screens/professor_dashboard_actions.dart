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
    final titleController = TextEditingController();
    String? selectedFilePath;
    String? selectedFileName;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white10),
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            t.academic.upload_new_file,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: t.academic.file_title,
                  labelStyle: const TextStyle(color: Colors.white60),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white10),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6366F1)),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                icon: const Icon(Icons.attach_file, color: Colors.white70),
                label: Text(
                  selectedFileName ?? t.academic.file_will_be_uploaded_to_cloud,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: selectedFileName != null
                        ? Colors.white
                        : Colors.white38,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectedFilePath = 'uploads/${profile.id}/document.pdf';
                    selectedFileName = 'document.pdf';
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t.academic.cancel,
                style: const TextStyle(color: Colors.white60),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (titleController.text.isEmpty || selectedFilePath == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(t.academic.file_title),
                    ),
                  );
                  return;
                }
                await ref
                    .read(professorRepositoryProvider)
                    .uploadSharedFile(
                      professorId: profile.id,
                      title: titleController.text,
                      filePath: selectedFilePath!,
                      fileName: selectedFileName!,
                    );
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF6366F1),
                    content: Text(t.academic.uploaded_successfully),
                  ),
                );
              },
              child: Text(
                t.academic.upload,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
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
