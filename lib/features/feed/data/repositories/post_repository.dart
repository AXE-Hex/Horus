import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:path/path.dart' as p;

final postRepositoryProvider = Provider((ref) {
  return PostRepository(Supabase.instance.client);
});

class PostRepository {
  final SupabaseClient _supabase;
  SupabaseClient get supabase => _supabase;

  PostRepository(this._supabase);

  Future<List<PostModel>> getFeed({int limit = 20, int offset = 0}) async {
    final userId = _supabase.auth.currentUser?.id;

    var query = _supabase.from('posts').select('''
          *,
          profiles(full_name, avatar_url, roles),
          colleges(name_en, name_ar, name),
          departments(name_en, name_ar, name),
          post_likes(user_id)
        ''');

    if (userId != null) {
      // We can't easily filter the join results in a single select query with the current client
      // for a list of items to only include the current user's like.
      // But we can parse it in the model since we only care if the list is empty or not for that post.
      // However, to keep it efficient, we might want to only fetch likes for the current user.
      // query = query.filter('post_likes.user_id', 'eq', userId);
    }

    final response = await query
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return (response as List<dynamic>).map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      // Filter likes to only include the current user's like if needed,
      // but the model will check if post_likes is not empty.
      // Actually, if we fetch ALL likes it will be slow.
      // For now, let's assume post_likes join returns the user's like if we can filter it.
      if (userId != null && map['post_likes'] != null) {
        final likes = map['post_likes'] as List;
        map['post_likes'] = likes.where((l) => l['user_id'] == userId).toList();
      }
      return PostModel.fromJson(map);
    }).toList();
  }

  Future<void> likePost(String postId) async {
    final userId = _supabase.auth.currentUser!.id;
    await _supabase.from('post_likes').insert({
      'post_id': postId,
      'user_id': userId,
    });
  }

  Future<void> unlikePost(String postId) async {
    final userId = _supabase.auth.currentUser!.id;
    await _supabase.from('post_likes').delete().match({
      'post_id': postId,
      'user_id': userId,
    });
  }

  Future<List<CommentModel>> getComments(String postId) async {
    final response = await _supabase
        .from('post_comments')
        .select('*, profiles(full_name, avatar_url, roles)')
        .eq('post_id', postId)
        .order('created_at', ascending: true);

    return (response as List<dynamic>)
        .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<CommentModel> addComment(
    String postId,
    String content, {
    String? parentId,
  }) async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('post_comments')
        .insert({
          'post_id': postId,
          'author_id': userId,
          'content': content,
          'parent_id': parentId,
        })
        .select('*, profiles(full_name, avatar_url, roles)')
        .single();

    return CommentModel.fromJson(response);
  }

  Future<void> deleteComment(String commentId) async {
    await _supabase.from('post_comments').delete().eq('id', commentId);
  }

  Future<void> deletePost(String postId) async {
    await _supabase.from('posts').delete().eq('id', postId);
  }

  Future<PostModel> updatePost(
    String postId, {
    String? content,
    List<String>? mediaUrls,
  }) async {
    final updates = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };
    if (content != null) updates['content'] = content;
    if (mediaUrls != null) updates['media_urls'] = mediaUrls;

    final response = await _supabase
        .from('posts')
        .update(updates)
        .eq('id', postId)
        .select('''
          *,
          profiles(full_name, avatar_url, roles),
          colleges(name_en, name_ar, name),
          departments(name_en, name_ar, name)
        ''')
        .single();

    return PostModel.fromJson(response);
  }

  Future<String?> uploadMedia(File file, String userId) async {
    final ext = p.extension(file.path);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$ext';
    final path = '$userId/$fileName';

    await _supabase.storage.from('post_media').upload(path, file);

    return _supabase.storage.from('post_media').getPublicUrl(path);
  }

  Future<PostModel> createPost({
    required String content,
    String? collegeId,
    String? departmentId,
    List<String> mediaUrls = const [],
    String? linkUrl,
    PostType type = PostType.text,
  }) async {
    final userId = _supabase.auth.currentUser!.id;

    final response = await _supabase
        .from('posts')
        .insert({
          'author_id': userId,
          'college_id': collegeId,
          'department_id': departmentId,
          'content': content,
          'media_urls': mediaUrls,
          'link_url': linkUrl,
          'type': type.name,
        })
        .select('''
          *,
          profiles(full_name, avatar_url, roles),
          colleges(name_en, name_ar, name),
          departments(name_en, name_ar, name)
        ''')
        .single();

    return PostModel.fromJson(response);
  }

}
