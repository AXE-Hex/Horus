import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:horus/core/theme/app_colors.dart';
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
const _kPrimary = AppColors.navy500;
const _kGold = AppColors.gold500;
const _kDanger = AppColors.danger;
const _kSurface = AppColors.darkSurfaceElevated;
const _kBg = AppColors.darkBackground;
const _kSurfaceLight = AppColors.lightBackground;
const _kBorderLight = AppColors.neutral200;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final showContext = constraints.maxWidth >= 980;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 740),
                    child: RefreshIndicator(
                      onRefresh: () =>
                          ref.read(feedProvider.notifier).refresh(),
                      color: _kPrimary,
                      backgroundColor: isDark ? _kSurface : Colors.white,
                      displacement: 64,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: [
                          // ── Header ──────────────────────────────────────────────────────
                          _FeedHeader(
                            canReadNotifications: auth.hasPermission(
                              RolePermission.viewNotifications,
                            ),
                            permissions: auth.permissionCodes,
                            isArabic: isArabic,
                            isDark: isDark,
                          ),

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
                                  child: _EmptyFeedState(
                                    isArabic: isArabic,
                                    isDark: isDark,
                                  ),
                                );
                              }
                              return SliverList(
                                delegate: SliverChildBuilderDelegate((
                                  context,
                                  index,
                                ) {
                                  return _PostCard(post: posts[index])
                                      .animate()
                                      .fadeIn(
                                        delay: Duration(
                                          milliseconds: index * 40,
                                        ),
                                        duration: 350.ms,
                                        curve: Curves.easeOut,
                                      )
                                      .slideY(
                                        begin: 0.08,
                                        end: 0,
                                        delay: Duration(
                                          milliseconds: index * 40,
                                        ),
                                        duration: 350.ms,
                                        curve: Curves.easeOut,
                                      );
                                }, childCount: posts.length),
                              );
                            },
                            loading: () => SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, i) => _PostSkeleton(isDark: isDark)
                                    .animate()
                                    .fadeIn(
                                      delay: Duration(milliseconds: i * 60),
                                    ),
                                childCount: 5,
                              ),
                            ),
                            error: (err, _) => SliverFillRemaining(
                              child: _ErrorState(
                                error: err.toString(),
                                isDark: isDark,
                              ),
                            ),
                          ),

                          const SliverToBoxAdapter(
                            child: SizedBox(height: 100),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (showContext)
                SizedBox(
                  width: 268,
                  child: _FeedContextPanel(permissions: auth.permissionCodes),
                ),
            ],
          );
        },
      ),

      // ── FAB ─────────────────────────────────────────────────────────────────
      floatingActionButton: canPost ? _PostFab(isArabic: isArabic) : null,
    );
  }
}

class _FeedContextPanel extends StatelessWidget {
  const _FeedContextPanel({required this.permissions});

  final Set<String> permissions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final actions =
        <({String permission, String path, IconData icon, String label})>[
          (
            permission: 'schedule.read',
            path: '/schedule',
            icon: Icons.calendar_month_outlined,
            label: t.students.daily_schedule,
          ),
          (
            permission: 'grades.read',
            path: '/grades',
            icon: Icons.school_outlined,
            label: t.academic.academic_results,
          ),
          (
            permission: 'courses.enroll',
            path: '/registration',
            icon: Icons.app_registration_rounded,
            label: t.registration.title,
          ),
          (
            permission: 'notifications.read',
            path: '/notifications',
            icon: Icons.notifications_none_rounded,
            label: t.students.notifications,
          ),
        ].where((action) => permissions.contains(action.permission));

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 28, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      theme.brightness == Brightness.dark
                          ? 'assets/images/Logo_dark.png'
                          : 'assets/images/Logo_light.png',
                      height: 48,
                      fit: BoxFit.contain,
                      alignment: AlignmentDirectional.centerStart,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      t.settings.horus_university,
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    for (final action in actions)
                      ListTile(
                        minLeadingWidth: 28,
                        leading: Icon(action.icon),
                        title: Text(action.label),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.go(action.path),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Sliver App Bar / Header ──────────────────────────────────────────────────
class _FeedHeader extends StatelessWidget {
  final bool canReadNotifications;
  final Set<String> permissions;
  final bool isArabic;
  final bool isDark;
  const _FeedHeader({
    required this.canReadNotifications,
    required this.permissions,
    required this.isArabic,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final secondaryDestinations = <_FeedMenuDestination>[
      _FeedMenuDestination(
        '/settings',
        t.settings.title,
        Icons.settings_outlined,
      ),
      _FeedMenuDestination(
        '/notifications',
        t.students.notifications,
        Icons.notifications_none_rounded,
      ),
      _FeedMenuDestination(
        '/schedule',
        t.students.daily_schedule,
        Icons.calendar_month_outlined,
      ),
      _FeedMenuDestination(
        '/grades',
        t.academic.academic_results,
        Icons.school_outlined,
      ),
      _FeedMenuDestination(
        '/transcript',
        t.academic.transcript_title,
        Icons.article_outlined,
      ),
      _FeedMenuDestination(
        '/attendance',
        t.academic.attendance_title,
        Icons.fact_check_outlined,
      ),
      _FeedMenuDestination(
        '/exam-schedule',
        t.academic.exam_schedule_title,
        Icons.event_note_outlined,
      ),
      _FeedMenuDestination(
        '/registration',
        t.registration.title,
        Icons.app_registration_rounded,
      ),
      _FeedMenuDestination(
        '/invoices',
        t.students.invoices,
        Icons.receipt_long_outlined,
      ),
      _FeedMenuDestination(
        '/dashboard',
        t.extracted.dashboard,
        Icons.insights_outlined,
      ),
      _FeedMenuDestination(
        '/professor-dashboard',
        t.control.title,
        Icons.manage_accounts_outlined,
      ),
      _FeedMenuDestination(
        '/control',
        t.control.title,
        Icons.account_balance_outlined,
      ),
      _FeedMenuDestination(
        '/support',
        t.shared.support,
        Icons.support_agent_outlined,
      ),
      _FeedMenuDestination('/forums', t.students.forums, Icons.forum_outlined),
    ].where((item) => canAccessRoute(item.route, permissions)).toList();

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
      actions: [
        if (canReadNotifications)
          IconButton(
            tooltip: t.students.notifications,
            onPressed: () => context.go('/notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        if (canAccessRoute('/profile', permissions))
          IconButton(
            tooltip: t.extracted.account,
            onPressed: () => context.go('/profile'),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        if (secondaryDestinations.isNotEmpty)
          PopupMenuButton<String>(
            tooltip: t.navigation.more,
            icon: const Icon(Icons.more_horiz_rounded),
            onSelected: context.go,
            itemBuilder: (context) => [
              for (final destination in secondaryDestinations)
                PopupMenuItem(
                  value: destination.route,
                  child: Row(
                    children: [
                      Icon(destination.icon, size: 20),
                      const SizedBox(width: 12),
                      Flexible(child: Text(destination.label)),
                    ],
                  ),
                ),
            ],
          ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.navy700, AppColors.navy900],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(LucideIcons.rss, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Text(
              t.home.home,
              style: TextStyle(
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
                t.home.home,
                style: TextStyle(
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
    );
  }
}

class _FeedMenuDestination {
  const _FeedMenuDestination(this.route, this.label, this.icon);

  final String route;
  final String label;
  final IconData icon;
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
                  style: TextStyle(
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
            colors: [AppColors.navy600, AppColors.navy800],
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
              style: TextStyle(
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
