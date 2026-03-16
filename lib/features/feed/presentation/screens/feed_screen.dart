
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/feed/presentation/providers/feed_provider.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/feed/data/repositories/post_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/feed/presentation/widgets/media_grid.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(feedProvider.notifier).refresh(),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(top: 110)),
          feedState.when(
            data: (posts) {
              if (posts.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.frown,
                            size: 48,
                            color: Colors.grey.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            t.$meta.locale.languageCode == 'ar'
                                ? 'لا توجد منشورات حتى الآن.'
                                : 'No posts yet.',
                            style: GoogleFonts.outfit(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn().scale(),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _PostCard(post: posts[index])
                      .animate()
                      .fadeIn(delay: (index * 50).ms)
                      .slideY(begin: 0.1, end: 0);
                }, childCount: posts.length),
              );
            },
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (err, stack) => SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'Error: $err',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}

class _PostCard extends ConsumerStatefulWidget {
  final PostModel post;

  const _PostCard({required this.post});

  @override
  ConsumerState<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<_PostCard> {
  bool _isLiking = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final authState = ref.watch(authControllerProvider);
    final isAuthor = authState.user?.id == widget.post.authorId;
    final isAdmin = authState.isAdmin;

    // Determine the sender name and department
    final isCollegePost = widget.post.collegeId != null;
    final senderName = isCollegePost
        ? (isArabic ? widget.post.collegeNameAr : widget.post.collegeNameEn) ??
            'College'
        : widget.post.authorName ?? 'Unknown User';

    String? subHeader;
    if (widget.post.departmentId != null) {
      subHeader = isArabic ? widget.post.departmentNameAr : widget.post.departmentNameEn;
    } else if (widget.post.collegeId != null) {
      subHeader = isArabic ? widget.post.collegeNameAr : widget.post.collegeNameEn;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 12, right: 12),
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF1E293B) : Colors.white).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isDark ? Colors.white : theme.primaryColor).withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          color: theme.cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
                child: Row(
                  children: [
                    _buildAuthorAvatar(theme),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAuthorName(senderName, isCollegePost),
                          _buildPostMeta(subHeader, isArabic, theme),
                        ],
                      ),
                    ),
                    if (widget.post.type == PostType.announcement)
                      _buildAnnouncementBadge(isArabic),
                    _buildOptionsMenu(isAuthor, isAdmin, theme),
                  ],
                ),
              ),

              // Content
              if (widget.post.content.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                  child: Text(
                    widget.post.content,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87,
                    ),
                  ),
                ),

              // Media
              if (widget.post.mediaUrls.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: MediaGrid(
                    mediaUrls: widget.post.mediaUrls,
                    borderRadius: 20,
                  ),
                ),

              // Link Preview
              if (widget.post.type == PostType.link && widget.post.linkUrl != null)
                _buildLinkPreview(widget.post.linkUrl!, theme),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
                ),
              ),

              // Footer Actions
              _buildFooterActions(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorAvatar(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.1), width: 1.5),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: theme.primaryColor.withValues(alpha: 0.05),
        backgroundImage: widget.post.authorAvatarUrl != null ? NetworkImage(widget.post.authorAvatarUrl!) : null,
        child: widget.post.authorAvatarUrl == null
            ? Icon(widget.post.collegeId != null ? LucideIcons.building : LucideIcons.user, color: theme.primaryColor, size: 18)
            : null,
      ),
    );
  }

  Widget _buildAuthorName(String name, bool isCollege) {
    return Row(
      children: [
        Flexible(
          child: Text(
            name,
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isCollege || widget.post.authorRole == UserRole.professor) ...[
          const SizedBox(width: 4),
          const Icon(Icons.verified, color: Colors.blue, size: 16),
        ],
      ],
    );
  }

  Widget _buildPostMeta(String? subHeader, bool isArabic, ThemeData theme) {
    return Row(
      children: [
        Text(
          timeago.format(widget.post.createdAt, locale: t.extracted.en),
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
        ),
        if (subHeader != null) ...[
          const SizedBox(width: 6),
          const Text('•', style: TextStyle(color: Colors.white24, fontSize: 10)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              subHeader,
              style: GoogleFonts.inter(color: theme.primaryColor.withValues(alpha: 0.6), fontSize: 11, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooterActions(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          _buildActionItem(
            icon: widget.post.isLiked ? LucideIcons.heart : LucideIcons.heart,
            label: '${widget.post.likesCount}',
            color: widget.post.isLiked ? Colors.red : null,
            isFilled: widget.post.isLiked,
            onTap: _handleLike,
          ),
          _buildActionItem(
            icon: LucideIcons.messageCircle,
            label: '${widget.post.commentsCount}',
            onTap: _showComments,
          ),
          const Spacer(),
          _buildActionItem(icon: LucideIcons.share2, onTap: () {}),
          _buildActionItem(icon: LucideIcons.bookmark, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem({required IconData icon, String? label, Color? color, bool isFilled = false, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: color ?? Colors.white54, fill: isFilled ? 1.0 : 0.0),
              if (label != null) ...[
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: color?.withValues(alpha: 0.8) ?? Colors.white38),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementBadge(bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade400.withValues(alpha: 0.15),
            Colors.orange.shade600.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.megaphone, color: Colors.orange.shade700, size: 12),
          const SizedBox(width: 4),
          Text(
            t.extracted.news,
            style: GoogleFonts.inter(
              color: Colors.orange.shade700,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsMenu(bool isAuthor, bool isAdmin, ThemeData theme) {
    return PopupMenuButton<String>(
      icon: Icon(
        LucideIcons.moreHorizontal,
        color: theme.iconTheme.color?.withValues(alpha: 0.5),
        size: 20,
      ),
      onSelected: (value) {
        if (value == 'delete') {
          _confirmDelete();
        } else if (value == 'edit') {
          _handleEdit();
        }
      },
      itemBuilder: (context) => [
        if (isAuthor || isAdmin) ...[
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                const Icon(LucideIcons.edit3, size: 18),
                const SizedBox(width: 8),
                Text(t.$meta.locale.languageCode == 'ar' ? 'تعديل' : 'Edit'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                const Icon(LucideIcons.trash2, size: 18, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  t.$meta.locale.languageCode == 'ar' ? 'حذف' : 'Delete',
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
        PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              const Icon(LucideIcons.flag, size: 18),
              const SizedBox(width: 8),
              Text(t.$meta.locale.languageCode == 'ar' ? 'إبلاغ' : 'Report'),
            ],
          ),
        ),
      ],
    );
  }

  // MediaGrid handles this now

  Widget _buildLinkPreview(String url, ThemeData theme) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.primaryColor.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Icon(LucideIcons.link, color: theme.primaryColor, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                url,
                style: GoogleFonts.inter(
                  color: theme.primaryColor,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLike() {
    if (_isLiking) return;
    setState(() => _isLiking = true);
    ref.read(feedProvider.notifier).toggleLike(widget.post.id).then((_) {
      if (mounted) setState(() => _isLiking = false);
    });
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CommentSheet(post: widget.post),
    );
  }

  void _handleEdit() {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final controller = TextEditingController(text: widget.post.content);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.extracted.edit_post,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: t.extracted.write_something,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  final newContent = controller.text.trim();
                  if (newContent.isNotEmpty &&
                      newContent != widget.post.content) {
                    try {
                      await ref
                          .read(postRepositoryProvider)
                          .updatePost(widget.post.id, content: newContent);
                      ref.invalidate(feedProvider);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error updating post: $e')),
                        );
                      }
                    }
                  }
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(t.extracted.save),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.$meta.locale.languageCode == 'ar' ? 'حذف المنشور؟' : 'Delete Post?'),
        content: Text(
          t.$meta.locale.languageCode == 'ar'
              ? 'هل أنت متأكد من حذف هذا المنشور؟ لا يمكن التراجع عن هذا العمل.'
              : 'Are you sure you want to delete this post? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.$meta.locale.languageCode == 'ar' ? 'إلغاء' : 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(feedProvider.notifier).deletePost(widget.post.id);
              Navigator.pop(context);
            },
            child: Text(
              t.$meta.locale.languageCode == 'ar' ? 'حذف' : 'Delete',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

  // ActionButton is replaced by _buildActionItem

class _CommentSheet extends ConsumerStatefulWidget {
  final PostModel post;

  const _CommentSheet({required this.post});

  @override
  ConsumerState<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<_CommentSheet> {
  final _commentController = TextEditingController();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final commentsAsync = ref.watch(commentsProvider(widget.post.id));

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  t.$meta.locale.languageCode == 'ar' ? 'التعليقات' : 'Comments',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x),
                ),
              ],
            ),
          ),

          const Divider(),

          // Comments List
          Expanded(
            child: commentsAsync.when(
              data: (comments) {
                if (comments.isEmpty) {
                  return Center(
                    child: Text(
                      t.$meta.locale.languageCode == 'ar'
                          ? 'كن أول من يعلق!'
                          : 'Be the first to comment!',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) => _CommentItem(comment: comments[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: \$err')),
            ),
          ),

          // Input
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 16,
              right: 16,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: t.$meta.locale.languageCode == 'ar' ? 'اكتب تعليقاً...' : 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _isSending
                    ? const CircularProgressIndicator()
                    : IconButton(
                        onPressed: _sendComment,
                        icon: const Icon(LucideIcons.send),
                        color: Theme.of(context).primaryColor,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    setState(() => _isSending = true);
    try {
      await ref.read(postRepositoryProvider).addComment(widget.post.id, content);
      _commentController.clear();
      ref.invalidate(commentsProvider(widget.post.id));
      ref.invalidate(feedProvider); // To refresh comment count
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}

class _CommentItem extends StatelessWidget {
  final CommentModel comment;

  const _CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            backgroundImage: comment.authorAvatarUrl != null ? NetworkImage(comment.authorAvatarUrl!) : null,
            child: comment.authorAvatarUrl == null ? Icon(LucideIcons.user, size: 14, color: theme.primaryColor) : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E293B) : Colors.grey.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.only(
                      topLeft: isArabic ? const Radius.circular(4) : const Radius.circular(20),
                      topRight: isArabic ? const Radius.circular(20) : const Radius.circular(4),
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.authorName ?? 'User',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13, color: theme.primaryColor),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.content,
                        style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.white.withValues(alpha: 0.9) : Colors.black87),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4, right: 4),
                  child: Text(
                    timeago.format(comment.createdAt, locale: t.extracted.en),
                    style: GoogleFonts.inter(fontSize: 10, color: Colors.white24, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: isArabic ? -0.05 : 0.05, end: 0);
  }
}

