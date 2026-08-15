import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/data/repositories/post_repository.dart';

final feedProvider = AsyncNotifierProvider<FeedNotifier, List<PostModel>>(
  FeedNotifier.new,
);

class FeedNotifier extends AsyncNotifier<List<PostModel>> {
  PostRepository get _repo => ref.read(postRepositoryProvider);

  static const int _pageSize = 20;
  int _currentOffset = 0;
  bool _hasMore = true;

  /// Whether more pages are available to load
  bool get hasMore => _hasMore;

  /// Whether a loadMore operation is in progress
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  @override
  Future<List<PostModel>> build() async {
    _currentOffset = 0;
    _hasMore = true;
    final posts = await _repo.getFeed(limit: _pageSize, offset: 0);
    _hasMore = posts.length >= _pageSize;
    _currentOffset = posts.length;
    return posts;
  }

  Future<void> refresh() async {
    _currentOffset = 0;
    _hasMore = true;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final posts = await _repo.getFeed(limit: _pageSize, offset: 0);
      _hasMore = posts.length >= _pageSize;
      _currentOffset = posts.length;
      return posts;
    });
  }

  /// Load next page of posts and append to current list
  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore) return;
    _isLoadingMore = true;

    try {
      final newPosts = await _repo.getFeed(
        limit: _pageSize,
        offset: _currentOffset,
      );
      _hasMore = newPosts.length >= _pageSize;
      _currentOffset += newPosts.length;

      final current = state.value ?? [];
      state = AsyncValue.data([...current, ...newPosts]);
    } catch (e) {
      // Don't replace existing data on pagination error, just rethrow
      rethrow;
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> addPost(PostModel post) async {
    final current = state.value ?? [];
    state = AsyncValue.data([post, ...current]);
  }

  Future<void> toggleLike(String postId) async {
    final currentPosts = state.value ?? [];
    final postIndex = currentPosts.indexWhere((p) => p.id == postId);
    if (postIndex == -1) return;

    final post = currentPosts[postIndex];
    final wasLiked = post.isLiked;

    final updatedPost = PostModel(
      id: post.id,
      authorId: post.authorId,
      collegeId: post.collegeId,
      departmentId: post.departmentId,
      content: post.content,
      mediaUrls: post.mediaUrls,
      linkUrl: post.linkUrl,
      type: post.type,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
      likesCount: wasLiked ? post.likesCount - 1 : post.likesCount + 1,
      commentsCount: post.commentsCount,
      isLiked: !wasLiked,
      authorName: post.authorName,
      authorAvatarUrl: post.authorAvatarUrl,
      authorRole: post.authorRole,
      collegeNameEn: post.collegeNameEn,
      collegeNameAr: post.collegeNameAr,
      departmentNameEn: post.departmentNameEn,
      departmentNameAr: post.departmentNameAr,
    );

    final newPosts = [...currentPosts];
    newPosts[postIndex] = updatedPost;
    state = AsyncValue.data(newPosts);

    try {
      if (wasLiked) {
        await _repo.unlikePost(postId);
      } else {
        await _repo.likePost(postId);
      }
    } catch (e) {
      state = AsyncValue.data(currentPosts);
      rethrow;
    }
  }

  Future<void> deletePost(String postId) async {
    final currentPosts = state.value ?? [];
    state = AsyncValue.data(currentPosts.where((p) => p.id != postId).toList());

    try {
      await _repo.deletePost(postId);
    } catch (e) {
      state = AsyncValue.data(currentPosts);
      rethrow;
    }
  }
}

final commentsProvider = FutureProvider.family<List<CommentModel>, String>((
  ref,
  postId,
) {
  return ref.read(postRepositoryProvider).getComments(postId);
});
