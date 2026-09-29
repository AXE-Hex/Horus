import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:path/path.dart' as p;

final postRepositoryProvider = Provider((ref) {
  return PostRepository(Supabase.instance.client);
});

String postMediaObjectPath({
  required String userId,
  required DateTime timestamp,
  required String extension,
}) {
  final normalizedExtension = extension.toLowerCase();
  final suffix = normalizedExtension.isEmpty
      ? ''
      : normalizedExtension.startsWith('.')
      ? normalizedExtension
      : '.$normalizedExtension';
  return '$userId/${timestamp.millisecondsSinceEpoch}$suffix';
}

class PostRepository {
  final SupabaseClient _supabase;
  SupabaseClient get supabase => _supabase;

  PostRepository(this._supabase);

  Future<List<PostModel>> getFeed({int limit = 20, int offset = 0}) async {
    final userId = _supabase.auth.currentUser?.id;

    var query = _supabase.from('posts').select('''
          *,
          profiles!posts_author_id_fkey(full_name, avatar_url),
          colleges(name_en, name_ar),
          departments(name_en, name_ar),
          post_likes(user_id)
        ''');

    if (userId != null) {}

    final response = await query
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    final posts = (response as List<dynamic>).map((e) async {
      final map = Map<String, dynamic>.from(e as Map);

      if (userId != null && map['post_likes'] != null) {
        final likes = map['post_likes'] as List;
        map['post_likes'] = likes.where((l) => l['user_id'] == userId).toList();
      }
      return _withSignedMedia(map);
    });
    return Future.wait(posts);
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
        .select('*, profiles(full_name, avatar_url)')
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
        .select('*, profiles(full_name, avatar_url)')
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
          profiles!posts_author_id_fkey(full_name, avatar_url),
          colleges(name_en, name_ar),
          departments(name_en, name_ar)
        ''')
        .single();

    return _withSignedMedia(Map<String, dynamic>.from(response));
  }

  Future<String?> uploadMedia(File file) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw StateError('Authentication is required to upload post media.');
    }
    final ext = p.extension(file.path).toLowerCase();
    final path = postMediaObjectPath(
      userId: userId,
      timestamp: DateTime.now(),
      extension: ext,
    );

    await _supabase.storage.from('post_media').upload(path, file);

    return path;
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
          profiles!posts_author_id_fkey(full_name, avatar_url),
          colleges(name_en, name_ar),
          departments(name_en, name_ar)
        ''')
        .single();

    return _withSignedMedia(Map<String, dynamic>.from(response));
  }

  Future<PostModel> _withSignedMedia(Map<String, dynamic> row) async {
    final storedPaths = row['media_urls'] as List<dynamic>? ?? const [];
    final signedUrls = <String>[];
    for (final value in storedPaths) {
      final path = _postMediaPath(value.toString());
      if (path == null) {
        signedUrls.add(value.toString());
      } else {
        signedUrls.add(
          await _supabase.storage
              .from('post_media')
              .createSignedUrl(path, 3600),
        );
      }
    }
    row['media_urls'] = signedUrls;
    return PostModel.fromJson(row);
  }

  String? _postMediaPath(String value) {
    const publicPath = '/storage/v1/object/public/post_media/';
    final index = value.indexOf(publicPath);
    if (index >= 0) return value.substring(index + publicPath.length);
    final uri = Uri.tryParse(value);
    if (uri != null && uri.hasScheme) return null;
    return value;
  }
}
