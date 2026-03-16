import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/feed/data/repositories/post_repository.dart';

final feedProvider = AsyncNotifierProvider<FeedNotifier, List<PostModel>>(
  FeedNotifier.new,
);

class FeedNotifier extends AsyncNotifier<List<PostModel>> {
  PostRepository get _repo => ref.read(postRepositoryProvider);

  @override
  Future<List<PostModel>> build() async {
    return _repo.getFeed();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repo.getFeed());
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

    // Optimistic update
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
      // Rollback on error
      state = AsyncValue.data(currentPosts);
    }
  }

  Future<void> deletePost(String postId) async {
    final currentPosts = state.value ?? [];
    state = AsyncValue.data(currentPosts.where((p) => p.id != postId).toList());

    try {
      await _repo.deletePost(postId);
    } catch (e) {
      state = AsyncValue.data(currentPosts);
    }
  }
}

final commentsProvider =
    FutureProvider.family<List<CommentModel>, String>((ref, postId) {
  return ref.read(postRepositoryProvider).getComments(postId);
});

