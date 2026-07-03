import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/feed/data/repositories/post_repository.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/presentation/providers/feed_provider.dart';
import 'package:horus/features/feed/presentation/widgets/media_grid.dart';
import 'package:horus/features/feed/presentation/widgets/link_preview_widget.dart';

// ─── Design Tokens ────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF6366F1);
const _kGold = Color(0xFFF59E0B);
const _kDanger = Color(0xFFEF4444);
const _kSurface = Color(0xFF1E293B);
const _kBg = Color(0xFF0F172A);
const _kSurfaceLight = Color(0xFFF8FAFC);
const _kBorderLight = Color(0xFFE2E8F0);

// ─── Feed Screen ──────────────────────────────────────────────────────────────
class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedProvider);
    final auth = ref.watch(authControllerProvider);
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final canPost = auth.role.hasPermission(RolePermission.createPost);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? _kBg : _kSurfaceLight,
      body: RefreshIndicator(
        onRefresh: () => ref.read(feedProvider.notifier).refresh(),
        color: _kPrimary,
        backgroundColor: isDark ? _kSurface : Colors.white,
        displacement: 80,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // ── Header ──────────────────────────────────────────────────────
            _FeedHeader(canPost: canPost, isArabic: isArabic, isDark: isDark),

            // ── Story-style quick-post bar ───────────────────────────────────
            if (canPost)
              SliverToBoxAdapter(
                child: _QuickPostBar(
                  auth: auth,
                  isArabic: isArabic,
                  isDark: isDark,
                ),
              ),

            SliverToBoxAdapter(child: const SizedBox(height: 8)),

            // ── Posts ────────────────────────────────────────────────────────
            feedState.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return SliverFillRemaining(
                    child: _EmptyFeedState(isArabic: isArabic, isDark: isDark),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _PostCard(post: posts[index])
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: index * 40),
                            duration: 350.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 0.08,
                            end: 0,
                            delay: Duration(milliseconds: index * 40),
                            duration: 350.ms,
                            curve: Curves.easeOut,
                          );
                    },
                    childCount: posts.length,
                  ),
                );
              },
              loading: () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _PostSkeleton(isDark: isDark)
                      .animate()
                      .fadeIn(delay: Duration(milliseconds: i * 60)),
                  childCount: 5,
                ),
              ),
              error: (err, _) => SliverFillRemaining(
                child: _ErrorState(error: err.toString(), isDark: isDark),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),

      // ── FAB ─────────────────────────────────────────────────────────────────
      floatingActionButton: canPost
          ? _PostFab(isArabic: isArabic)
              .animate()
              .scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                delay: 500.ms,
                curve: Curves.elasticOut,
                duration: 600.ms,
              )
          : null,
    );
  }
}

// ─── Sliver App Bar / Header ──────────────────────────────────────────────────
class _FeedHeader extends StatelessWidget {
  final bool canPost;
  final bool isArabic;
  final bool isDark;
  const _FeedHeader({
    required this.canPost,
    required this.isArabic,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      expandedHeight: 110,
      backgroundColor: isDark ? _kBg : _kSurfaceLight,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: Colors.black.withValues(alpha: 0.26),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kPrimary, Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                LucideIcons.rss,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              isArabic ? 'المنشورات' : 'Feed',
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            color: isDark ? _kBg : _kSurfaceLight,
          ),
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
          child: Row(
            children: [
              Text(
                isArabic ? 'آخر التحديثات' : 'Latest updates',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            LucideIcons.search,
            size: 20,
            color: isDark ? Colors.white.withValues(alpha: 0.70) : Colors.black.withValues(alpha: 0.54),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LucideIcons.filter,
            size: 20,
            color: isDark ? Colors.white.withValues(alpha: 0.70) : Colors.black.withValues(alpha: 0.54),
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}

// ─── Quick Post Bar ───────────────────────────────────────────────────────────
class _QuickPostBar extends StatelessWidget {
  final AuthState auth;
  final bool isArabic;
  final bool isDark;
  const _QuickPostBar({
    required this.auth,
    required this.isArabic,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? _kSurface : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.10) : _kBorderLight,
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          _AvatarWidget(
            avatarUrl: auth.profile?.avatarUrl,
            name: auth.profile?.fullName,
            radius: 20,
            isDark: isDark,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => context.push('/create-post'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  isArabic ? 'شاركنا رأيك...' : "What's on your mind?",
                  style: GoogleFonts.inter(
                    color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          _QuickActionBtn(
            icon: LucideIcons.image,
            color: const Color(0xFF10B981),
            onTap: () => context.push('/create-post'),
          ),
          const SizedBox(width: 6),
          _QuickActionBtn(
            icon: LucideIcons.video,
            color: _kDanger,
            onTap: () => context.push('/create-post'),
          ),
        ],
      ),
    );
  }
}

class _QuickActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _QuickActionBtn({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 16),
      ),
    );
  }
}

// ─── FAB ──────────────────────────────────────────────────────────────────────
class _PostFab extends StatelessWidget {
  final bool isArabic;
  const _PostFab({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        context.push('/create-post');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [_kPrimary, Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: _kPrimary.withValues(alpha: 0.45),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.plus, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              isArabic ? 'منشور جديد' : 'New Post',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Post Card ────────────────────────────────────────────────────────────────
class _PostCard extends ConsumerStatefulWidget {
  final PostModel post;
  const _PostCard({required this.post});

  @override
  ConsumerState<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<_PostCard>
    with SingleTickerProviderStateMixin {
  bool _isLiking = false;
  late AnimationController _likeAnim;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _likeAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _likeAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final authState = ref.watch(authControllerProvider);
    final isAuthor = authState.user?.id == widget.post.authorId;
    final isCollegePost = widget.post.collegeId != null;
    final isAnnouncement = widget.post.type == PostType.announcement;

    final senderName = isCollegePost
        ? (isArabic ? widget.post.collegeNameAr : widget.post.collegeNameEn) ??
              'College'
        : widget.post.authorName ?? 'Unknown';

    final subLabel = widget.post.departmentId != null
        ? (isArabic
              ? widget.post.departmentNameAr
              : widget.post.departmentNameEn)
        : null;

    final content = widget.post.content;
    final isLong = content.length > 280;
    final displayContent =
        (!_expanded && isLong) ? '${content.substring(0, 280)}…' : content;

    String? extractedLink = widget.post.linkUrl;
    if (extractedLink == null) {
      final urlRegExp = RegExp(
          r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,})');
      final match = urlRegExp.firstMatch(content);
      if (match != null) {
        extractedLink = content.substring(match.start, match.end);
        if (!extractedLink.startsWith('http')) {
          extractedLink = 'https://$extractedLink';
        }
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: BoxDecoration(
        color: isDark ? _kSurface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.06) : _kBorderLight,
          ),
          bottom: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.06) : _kBorderLight,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Announcement Banner ──────────────────────────────────────────
          if (isAnnouncement)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _kGold.withValues(alpha: 0.15),
                    _kGold.withValues(alpha: 0.05),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: _kGold.withValues(alpha: 0.25),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.megaphone, color: _kGold, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    isArabic ? 'إعلان رسمي' : 'Official Announcement',
                    style: GoogleFonts.outfit(
                      color: _kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

          // ── Author Header ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AvatarWidget(
                  avatarUrl: widget.post.authorAvatarUrl,
                  name: senderName,
                  radius: 22,
                  isDark: isDark,
                  isOrg: isCollegePost,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              senderName,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          if (isCollegePost ||
                              widget.post.authorRole == UserRole.professor ||
                              widget.post.authorRole == UserRole.rector)
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: _kPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          if (subLabel != null) ...[
                            _RoleChip(
                              label: subLabel,
                              color: _kPrimary,
                              isDark: isDark,
                            ),
                            const SizedBox(width: 6),
                          ] else if (widget.post.authorRole != null) ...[
                            _RoleChip(
                              label: _roleLabel(
                                widget.post.authorRole!,
                                isArabic,
                              ),
                              color: _roleColor(widget.post.authorRole!),
                              isDark: isDark,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            timeago.format(widget.post.createdAt),
                            style: GoogleFonts.inter(
                              color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isAuthor)
                  _OptionsMenu(
                    post: widget.post,
                    isDark: isDark,
                    isArabic: isArabic,
                  )
                else
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      LucideIcons.moreHorizontal,
                      size: 18,
                      color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayContent,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.55,
                      color: isDark ? Colors.white.withValues(alpha: 0.87) : const Color(0xFF1E293B),
                    ),
                  ),
                  if (isLong) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded
                            ? (isArabic ? 'عرض أقل' : 'Show less')
                            : (isArabic ? 'عرض المزيد' : 'See more'),
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _kPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          // ── Link Preview ─────────────────────────────────────────────────
          if (extractedLink != null && widget.post.mediaUrls.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: LinkPreviewWidget(url: extractedLink),
            ),

          // ── Media ────────────────────────────────────────────────────────
          if (widget.post.mediaUrls.isNotEmpty)
            ClipRRect(
              child: MediaGrid(
                mediaUrls: widget.post.mediaUrls,
                borderRadius: 0,
              ),
            ),

          // ── Stats Bar ────────────────────────────────────────────────────
          if (widget.post.likesCount > 0 || widget.post.commentsCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (widget.post.likesCount > 0)
                    Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: _kDanger,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.post.likesCount}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color:
                                isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  if (widget.post.commentsCount > 0)
                    Text(
                      '${widget.post.commentsCount} ${isArabic ? 'تعليق' : 'comments'}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
                      ),
                    ),
                ],
              ),
            ),

          // ── Divider ──────────────────────────────────────────────────────
          Divider(
            height: 1,
            color:
                isDark ? Colors.white.withValues(alpha: 0.06) : _kBorderLight,
          ),

          // ── Action Buttons ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    icon: widget.post.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    label: isArabic ? 'إعجاب' : 'Like',
                    color: widget.post.isLiked ? _kDanger : null,
                    isDark: isDark,
                    onTap: _handleLike,
                    isLoading: _isLiking,
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: LucideIcons.messageSquare,
                    label: isArabic ? 'تعليق' : 'Comment',
                    isDark: isDark,
                    onTap: _showComments,
                  ),
                ),
                Expanded(
                  child: _ActionButton(
                    icon: LucideIcons.share2,
                    label: isArabic ? 'مشاركة' : 'Share',
                    isDark: isDark,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleLike() async {
    if (_isLiking) return;
    HapticFeedback.lightImpact();
    setState(() => _isLiking = true);
    await ref.read(feedProvider.notifier).toggleLike(widget.post.id);
    if (mounted) setState(() => _isLiking = false);
  }

  void _showComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => _CommentSheet(post: widget.post),
    );
  }

  String _roleLabel(UserRole role, bool isArabic) {
    switch (role) {
      case UserRole.rector:
        return isArabic ? 'رئيس الجامعة' : 'Rector';
      case UserRole.dean:
        return isArabic ? 'العميد' : 'Dean';
      case UserRole.professor:
        return isArabic ? 'أستاذ' : 'Professor';
      case UserRole.teachingAssistant:
        return isArabic ? 'معيد' : 'TA';
      default:
        return isArabic ? 'طالب' : 'Student';
    }
  }

  Color _roleColor(UserRole role) {
    switch (role) {
      case UserRole.rector:
        return _kGold;
      case UserRole.dean:
        return const Color(0xFFF97316);
      case UserRole.professor:
        return _kPrimary;
      case UserRole.teachingAssistant:
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final bool isDark;
  final VoidCallback onTap;
  final bool isLoading;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? (isDark ? Colors.white.withValues(alpha: 0.54) : Colors.black.withValues(alpha: 0.45));
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: c,
                ),
              )
            else
              Icon(icon, size: 18, color: c),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: c,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Role Chip ────────────────────────────────────────────────────────────────
class _RoleChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  const _RoleChip({
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ─── Options Menu ─────────────────────────────────────────────────────────────
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
        color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
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
              Icon(LucideIcons.pencil, size: 16,
                  color: isDark ? Colors.white.withValues(alpha: 0.70) : Colors.black.withValues(alpha: 0.87)),
              const SizedBox(width: 10),
              Text(
                isArabic ? 'تعديل' : 'Edit',
                style: GoogleFonts.inter(fontSize: 14),
              ),
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
                style: GoogleFonts.inter(fontSize: 14, color: _kDanger),
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
              style: GoogleFonts.outfit(
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
                  color: isDark ? Colors.white.withValues(alpha: 0.12) : _kBorderLight,
                ),
              ),
              child: TextField(
                controller: controller,
                maxLines: 6,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: isDark ? Colors.white.withValues(alpha: 0.87) : _kBg,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: isArabic ? 'اكتب هنا...' : 'Write here...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey),
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
                    style: GoogleFonts.outfit(
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
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        content: Text(
          isArabic
              ? 'هل أنت متأكد أنك تريد حذف هذا المنشور؟'
              : 'Are you sure you want to delete this post?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: GoogleFonts.outfit(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(feedProvider.notifier).deletePost(post.id);
              Navigator.pop(context);
            },
            child: Text(
              isArabic ? 'حذف' : 'Delete',
              style: GoogleFonts.outfit(
                color: _kDanger,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Comment Sheet ────────────────────────────────────────────────────────────
class _CommentSheet extends ConsumerStatefulWidget {
  final PostModel post;
  const _CommentSheet({required this.post});

  @override
  ConsumerState<_CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<_CommentSheet> {
  final _controller = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final commentsAsync = ref.watch(commentsProvider(widget.post.id));

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: isDark ? _kSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 8, 12),
            child: Row(
              children: [
                Text(
                  isArabic ? 'التعليقات' : 'Comments',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : _kBg,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _kPrimary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    '${widget.post.commentsCount}',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _kPrimary,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    LucideIcons.x,
                    size: 20,
                    color: isDark ? Colors.white.withValues(alpha: 0.54) : Colors.black.withValues(alpha: 0.54),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: isDark ? Colors.white.withValues(alpha: 0.10) : _kBorderLight,
          ),

          // Comments List
          Expanded(
            child: commentsAsync.when(
              data: (comments) {
                if (comments.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.messageSquare,
                          size: 40,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.12)
                              : Colors.black.withValues(alpha: 0.12),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isArabic ? 'لا توجد تعليقات بعد' : 'No comments yet',
                          style: GoogleFonts.inter(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isArabic
                              ? 'كن أول من يعلق!'
                              : 'Be the first to comment!',
                          style: GoogleFonts.inter(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (_, i) => _CommentItem(
                    comment: comments[i],
                    isDark: isDark,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) =>
                  Center(child: Text('Error: $err')),
            ),
          ),

          // Input
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 12,
            ),
            decoration: BoxDecoration(
              color: isDark ? _kSurface : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white.withValues(alpha: 0.10) : _kBorderLight,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendComment(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: isArabic
                            ? 'أضف تعليقاً...'
                            : 'Add a comment...',
                        hintStyle: GoogleFonts.inter(
                          color:
                              isDark ? Colors.white.withValues(alpha: 0.30) : Colors.black.withValues(alpha: 0.30),
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isDark ? Colors.white.withValues(alpha: 0.87) : _kBg,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _isSending ? null : _sendComment,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: _isSending
                          ? null
                          : const LinearGradient(
                              colors: [_kPrimary, Color(0xFF8B5CF6)],
                            ),
                      color: _isSending ? Colors.grey : null,
                      shape: BoxShape.circle,
                      boxShadow: _isSending
                          ? []
                          : [
                              BoxShadow(
                                color: _kPrimary.withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: _isSending
                        ? const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Icon(
                            LucideIcons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() => _isSending = true);
    try {
      await ref
          .read(postRepositoryProvider)
          .addComment(widget.post.id, content);
      _controller.clear();
      ref.invalidate(commentsProvider(widget.post.id));
      ref.invalidate(feedProvider);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}

// ─── Comment Item ─────────────────────────────────────────────────────────────
class _CommentItem extends StatelessWidget {
  final CommentModel comment;
  final bool isDark;
  const _CommentItem({required this.comment, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AvatarWidget(
          avatarUrl: comment.authorAvatarUrl,
          name: comment.authorName,
          radius: 16,
          isDark: isDark,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF1F5F9),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.authorName ?? 'User',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: isDark ? Colors.white : _kBg,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.content,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        height: 1.4,
                        color: isDark ? Colors.white.withValues(alpha: 0.70) : const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  timeago.format(comment.createdAt),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Avatar Widget ────────────────────────────────────────────────────────────
class _AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? name;
  final double radius;
  final bool isDark;
  final bool isOrg;

  const _AvatarWidget({
    required this.avatarUrl,
    required this.name,
    required this.radius,
    required this.isDark,
    this.isOrg = false,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name != null && name!.isNotEmpty
        ? name!.trim().split(' ').take(2).map((w) => w[0]).join()
        : '?';

    return CircleAvatar(
      radius: radius,
      backgroundColor: isOrg
          ? _kPrimary.withValues(alpha: 0.15)
          : (isDark
              ? Colors.white.withValues(alpha: 0.08)
              : _kPrimary.withValues(alpha: 0.1)),
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Text(
              isOrg ? '🏛' : initials,
              style: GoogleFonts.outfit(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.bold,
                color: _kPrimary,
              ),
            )
          : null,
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────
class _EmptyFeedState extends StatelessWidget {
  final bool isArabic;
  final bool isDark;
  const _EmptyFeedState({required this.isArabic, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _kPrimary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.rss,
              color: _kPrimary,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isArabic ? 'لا توجد منشورات' : 'No posts yet',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withValues(alpha: 0.70) : _kBg,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? 'كن أول من ينشر شيئاً!'
                : 'Be the first to share something!',
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String error;
  final bool isDark;
  const _ErrorState({required this.error, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.wifiOff, color: _kDanger, size: 40),
          const SizedBox(height: 12),
          Text(
            'Something went wrong',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white.withValues(alpha: 0.70) : _kBg,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            error,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ─── Skeleton ─────────────────────────────────────────────────────────────────
class _PostSkeleton extends StatefulWidget {
  final bool isDark;
  const _PostSkeleton({required this.isDark});

  @override
  State<_PostSkeleton> createState() => _PostSkeletonState();
}

class _PostSkeletonState extends State<_PostSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = widget.isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.black.withValues(alpha: 0.05);

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          color: widget.isDark ? _kSurface : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _Bone(width: 44, height: 44, radius: 22, base: base,
                      opacity: _anim.value),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Bone(width: 140, height: 14, radius: 8, base: base,
                          opacity: _anim.value),
                      const SizedBox(height: 6),
                      _Bone(width: 90, height: 10, radius: 6, base: base,
                          opacity: _anim.value),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _Bone(width: double.infinity, height: 14, radius: 8, base: base,
                  opacity: _anim.value),
              const SizedBox(height: 6),
              _Bone(width: double.infinity, height: 14, radius: 8, base: base,
                  opacity: _anim.value),
              const SizedBox(height: 6),
              _Bone(width: 200, height: 14, radius: 8, base: base,
                  opacity: _anim.value),
            ],
          ),
        );
      },
    );
  }
}

class _Bone extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color base;
  final double opacity;

  const _Bone({
    required this.width,
    required this.height,
    required this.radius,
    required this.base,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
