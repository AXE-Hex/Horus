part of 'feed_screen.dart';

class _OptionsMenu extends ConsumerWidget {
  final PostModel post;
  final bool isDark;
  final bool isArabic;
  const _OptionsMenu({
    required this.post,
    required this.isDark,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: Icon(
        LucideIcons.moreHorizontal,
        size: 18,
        color: isDark
            ? Colors.white.withValues(alpha: 0.38)
            : Colors.black.withValues(alpha: 0.38),
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? const Color(0xFF1E293B) : Colors.white,
      elevation: 8,
      onSelected: (value) {
        if (value == 'delete') _confirmDelete(context, ref);
        if (value == 'edit') _handleEdit(context, ref);
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(
                LucideIcons.pencil,
                size: 16,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.70)
                    : Colors.black.withValues(alpha: 0.87),
              ),
              const SizedBox(width: 10),
              Text(isArabic ? 'تعديل' : 'Edit', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(LucideIcons.trash2, size: 16, color: _kDanger),
              const SizedBox(width: 10),
              Text(
                isArabic ? 'حذف' : 'Delete',
                style: TextStyle(fontSize: 14, color: _kDanger),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleEdit(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: post.content);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 20,
          right: 20,
          top: 24,
        ),
        decoration: BoxDecoration(
          color: isDark ? _kSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              isArabic ? 'تعديل المنشور' : 'Edit Post',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : _kBg,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.12)
                      : _kBorderLight,
                ),
              ),
              child: TextField(
                controller: controller,
                maxLines: 6,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white.withValues(alpha: 0.87) : _kBg,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: isArabic ? 'اكتب هنا...' : 'Write here...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final newContent = controller.text.trim();
                if (newContent.isNotEmpty && newContent != post.content) {
                  await ref
                      .read(postRepositoryProvider)
                      .updatePost(post.id, content: newContent);
                  ref.invalidate(feedProvider);
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_kPrimary, Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    isArabic ? 'حفظ التغييرات' : 'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? _kSurface : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isArabic ? 'حذف المنشور؟' : 'Delete Post?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          isArabic
              ? 'هل أنت متأكد أنك تريد حذف هذا المنشور؟'
              : 'Are you sure you want to delete this post?',
          style: TextStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(feedProvider.notifier).deletePost(post.id);
              Navigator.pop(context);
            },
            child: Text(
              isArabic ? 'حذف' : 'Delete',
              style: TextStyle(color: _kDanger, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Comment Sheet ────────────────────────────────────────────────────────────
