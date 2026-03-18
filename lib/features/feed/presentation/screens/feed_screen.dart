import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final auth = ref.watch(authControllerProvider);
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final canPost = auth.role.hasPermission(RolePermission.createPost);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final hPad = isTablet ? (screenWidth - 600) / 2 : 0.0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: canPost
          ? FloatingActionButton.extended(
              heroTag: 'feed_create_post',
              onPressed: () => context.push('/create-post'),
              backgroundColor: const Color(0xFF6366F1),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              icon: const Icon(LucideIcons.plusCircle, color: Colors.white, size: 20),
              label: Text(
                isArabic ? 'منشور جديد' : 'New Post',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ).animate().scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                delay: 400.ms,
                curve: Curves.elasticOut,
              )
          : null,
      body: RefreshIndicator(
        onRefresh: () => ref.read(feedProvider.notifier).refresh(),
        color: const Color(0xFF6366F1),
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [

            SliverPadding(
              padding: EdgeInsets.fromLTRB(hPad, 4, hPad, 80),
              sliver: feedState.when(
                data: (posts) {
                  if (posts.isEmpty) {
                    return SliverFillRemaining(
                      child: _EmptyFeedState(isArabic: isArabic),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _PostCard(post: posts[index]).animate().fadeIn(
                            delay: Duration(milliseconds: index * 30),
                            duration: 300.ms,
                          ),
                      childCount: posts.length,
                    ),
                  );
                },
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Error: $err',
                      style: const TextStyle(color: Colors.red),
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
}

class _EmptyFeedState extends StatelessWidget {
  final bool isArabic;
  const _EmptyFeedState({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.info,
            size: 48,
            color: Colors.grey.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic ? 'لا توجد منشورات حالياً' : 'No posts available',
            style: GoogleFonts.outfit(fontSize: 16, color: Colors.grey),
          ),
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

    final isCollegePost = widget.post.collegeId != null;
    final senderName = isCollegePost
        ? (isArabic ? widget.post.collegeNameAr : widget.post.collegeNameEn) ??
              'College'
        : widget.post.authorName ?? 'Unknown';

    String? subHeader;
    if (widget.post.departmentId != null) {
      subHeader = isArabic
          ? widget.post.departmentNameAr
          : widget.post.departmentNameEn;
    } else if (widget.post.collegeId != null) {
      subHeader = isArabic
          ? widget.post.collegeNameAr
          : widget.post.collegeNameEn;
    }

    final cardColor = isDark
        ? const Color(0xFF1E293B).withValues(alpha: 0.6)
        : Colors.white.withValues(alpha: 0.8);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isDark ? Colors.white : theme.primaryColor).withValues(
            alpha: 0.05,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: _buildAuthorAvatar(theme),
            title: _buildAuthorName(senderName, isCollegePost, theme),
            subtitle: _buildPostMeta(subHeader, theme),
            trailing: _buildOptionsMenu(isAuthor, isAdmin, theme),
          ),

          if (widget.post.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
              child: Text(
                widget.post.content,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),

          if (widget.post.mediaUrls.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: MediaGrid(
                mediaUrls: widget.post.mediaUrls,
                borderRadius: 12,
              ),
            ),

          _buildFooterActions(theme, isArabic),
        ],
      ),
    );
  }

  Widget _buildAuthorAvatar(ThemeData theme) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
      backgroundImage: widget.post.authorAvatarUrl != null
          ? NetworkImage(widget.post.authorAvatarUrl!)
          : null,
      child: widget.post.authorAvatarUrl == null
          ? Icon(
              widget.post.collegeId != null
                  ? LucideIcons.building
                  : LucideIcons.user,
              color: theme.primaryColor,
              size: 16,
            )
          : null,
    );
  }

  Widget _buildAuthorName(String name, bool isCollege, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            name,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isCollege || widget.post.authorRole == UserRole.professor) ...[
          const SizedBox(width: 4),
          const Icon(Icons.verified, color: Colors.blue, size: 14),
        ],
      ],
    );
  }

  Widget _buildPostMeta(String? subHeader, ThemeData theme) {
    return Text(
      timeago.format(widget.post.createdAt, locale: t.extracted.en),
      style: GoogleFonts.inter(color: Colors.grey, fontSize: 11),
    );
  }

  Widget _buildFooterActions(ThemeData theme, bool isArabic) {
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
            icon: LucideIcons.messageSquare,
            label: '${widget.post.commentsCount}',
            onTap: _showComments,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.share2, size: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    String? label,
    Color? color,
    bool isFilled = false,
    required VoidCallback onTap,
  }) {
    return TextButton.icon(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: color ?? Colors.grey,
        iconColor: color ?? Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      icon: Icon(icon, size: 18, fill: isFilled ? 1.0 : 0.0),
      label: Text(
        label ?? '',
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildOptionsMenu(bool isAuthor, bool isAdmin, ThemeData theme) {
    if (!isAuthor && !isAdmin) return const SizedBox.shrink();
    return PopupMenuButton<String>(
      icon: const Icon(LucideIcons.moreVertical, color: Colors.grey, size: 18),
      onSelected: (value) {
        if (value == 'delete') _confirmDelete();
        if (value == 'edit') _handleEdit();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(LucideIcons.edit, size: 16),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(LucideIcons.trash2, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
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
                'Edit Post',
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
                  hintText: 'What\'s on your mind?',
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
                    await ref
                        .read(postRepositoryProvider)
                        .updatePost(widget.post.id, content: newContent);
                    ref.invalidate(feedProvider);
                  }
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Save'),
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
        title: const Text('Delete Post?'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(feedProvider.notifier).deletePost(widget.post.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

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
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final commentsAsync = ref.watch(commentsProvider(widget.post.id));

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  isArabic ? 'التعليقات' : 'Comments',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x, size: 20),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: commentsAsync.when(
              data: (comments) {
                if (comments.isEmpty)
                  return const Center(
                    child: Text(
                      'No comments yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: comments.length,
                  itemBuilder: (context, index) =>
                      _CommentItem(comment: comments[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 12,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: isArabic
                          ? 'أضف تعليقاً...'
                          : 'Add a comment...',
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _isSending ? null : _sendComment,
                  icon: const Icon(LucideIcons.send, color: Color(0xFF6366F1)),
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
      await ref
          .read(postRepositoryProvider)
          .addComment(widget.post.id, content);
      _commentController.clear();
      ref.invalidate(commentsProvider(widget.post.id));
      ref.invalidate(feedProvider);
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundImage: comment.authorAvatarUrl != null
                ? NetworkImage(comment.authorAvatarUrl!)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.authorName ?? 'User',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  comment.content,
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  timeago.format(comment.createdAt),
                  style: GoogleFonts.inter(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
