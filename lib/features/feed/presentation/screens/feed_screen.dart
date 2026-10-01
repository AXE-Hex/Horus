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

part 'feed_post_card.dart';
part 'feed_post_options.dart';
part 'feed_comments.dart';
part 'feed_comment_widgets.dart';

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
    final canPost = auth.hasPermission(RolePermission.createPost);
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
                  delegate: SliverChildBuilderDelegate((context, index) {
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
                  }, childCount: posts.length),
                );
              },
              loading: () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _PostSkeleton(
                    isDark: isDark,
                  ).animate().fadeIn(delay: Duration(milliseconds: i * 60)),
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
          ? _PostFab(isArabic: isArabic).animate().scale(
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
              child: const Icon(LucideIcons.rss, color: Colors.white, size: 16),
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
          decoration: BoxDecoration(color: isDark ? _kBg : _kSurfaceLight),
          padding: const EdgeInsets.fromLTRB(20, 56, 20, 0),
          child: Row(
            children: [
              Text(
                isArabic ? 'آخر التحديثات' : 'Latest updates',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.38)
                      : Colors.black.withValues(alpha: 0.38),
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
            color: isDark
                ? Colors.white.withValues(alpha: 0.70)
                : Colors.black.withValues(alpha: 0.54),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            LucideIcons.filter,
            size: 20,
            color: isDark
                ? Colors.white.withValues(alpha: 0.70)
                : Colors.black.withValues(alpha: 0.54),
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
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.38)
                        : Colors.black.withValues(alpha: 0.38),
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
