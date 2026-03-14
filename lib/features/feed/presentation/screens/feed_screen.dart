import 'dart:ui';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/feed/presentation/providers/feed_provider.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedProvider);

    return RefreshIndicator(
      onRefresh: () => ref.read(feedProvider.notifier).refresh(),
      child: CustomScrollView(
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(top: 110)),
          feedState.when(
            data: (posts) {
              if (posts.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        t.$meta.locale.languageCode == 'ar'
                            ? 'لا توجد منشورات حتى الآن.'
                            : 'No posts yet.',
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _PostCard(post: posts[index]);
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
              child: Center(child: Text('Error loading feed: $err')),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}

class _PostCard extends ConsumerWidget {
  final PostModel post;

  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    // Determine the sender name
    final isCollegePost = post.collegeId != null;
    final senderName = isCollegePost
        ? (isArabic ? post.collegeNameAr : post.collegeNameEn) ?? 'College'
        : post.authorName ?? 'Unknown User';

    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      decoration: BoxDecoration(
        color: (isDark ? const Color(0xFF1E293B) : Colors.white).withValues(
          alpha: 0.8,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isDark ? Colors.white : theme.primaryColor).withValues(
            alpha: 0.15,
          ),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : theme.primaryColor).withValues(
              alpha: 0.08,
            ),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          // Top shine effect
          BoxShadow(
            color: Colors.white.withValues(alpha: isDark ? 0.05 : 0.4),
            blurRadius: 0,
            spreadRadius: 0,
            offset: const Offset(0, 1), // Only 1px shine at the top
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            // Inner gradient gloss layer
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: isDark ? 0.1 : 0.4),
                  Colors.white.withValues(alpha: 0.0),
                ],
                stops: const [0.0, 0.4],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.primaryColor.withValues(
                          alpha: 0.15,
                        ),
                        backgroundImage: post.authorAvatarUrl != null
                            ? NetworkImage(post.authorAvatarUrl!)
                            : null,
                        radius: 20,
                        child: post.authorAvatarUrl == null
                            ? Icon(
                                isCollegePost ? Icons.business : Icons.person,
                                color: theme.primaryColor,
                              )
                            : null,
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isCollegePost) ...[
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.verified,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              timeago.format(
                                post.createdAt,
                                locale: isArabic ? 'ar' : 'en',
                              ),
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (post.type == PostType.announcement)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade400.withValues(alpha: 0.2),
                                Colors.orange.shade600.withValues(alpha: 0.1),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.orange.withValues(alpha: 0.3),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.campaign,
                                color: Colors.orange.shade700,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isArabic ? 'إعلان هام' : 'Announcement',
                                style: GoogleFonts.inter(
                                  color: Colors.orange.shade700,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: theme.iconTheme.color?.withValues(alpha: 0.6),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // Content
                if (post.content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      post.content,
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                  ),

                const SizedBox(height: 8),

                // Media (Image)
                if (post.type == PostType.image && post.mediaUrls.isNotEmpty)
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(post.mediaUrls.first),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                // Link Preview
                if (post.type == PostType.link && post.linkUrl != null)
                  GestureDetector(
                    onTap: () {
                      // Would launch URL here
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.primaryColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.link, color: theme.primaryColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              post.linkUrl!,
                              style: GoogleFonts.inter(
                                color: theme.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Footer (Likes / Comments)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          Text(
                            '\${post.likesCount}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline),
                            onPressed: () {},
                          ),
                          Text(
                            '\${post.commentsCount}',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
