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
}
