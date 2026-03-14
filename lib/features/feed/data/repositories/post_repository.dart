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
    final response = await _supabase
        .from('posts')
        .select(
          '*, profiles(full_name, avatar_url, roles), colleges(name_en, name_ar, name)',
        )
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return (response as List<dynamic>)
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<String?> uploadMedia(File file, String userId) async {
    final ext = p.extension(file.path);
    final fileName = '${DateTime.now().millisecondsSinceEpoch}$ext';
    final path = '$userId/$fileName';

    await _supabase.storage.from('post_media').upload(path, file);

    final urlResponse = _supabase.storage.from('post_media').getPublicUrl(path);
    return urlResponse;
  }

  Future<PostModel> createPost({
    required String content,
    String? collegeId,
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
          'content': content,
          'media_urls': mediaUrls,
          'link_url': linkUrl,
          'type': type.name,
        })
        .select(
          '*, profiles(full_name, avatar_url, roles), colleges(name_en, name_ar, name)',
        )
        .single();

    return PostModel.fromJson(response);
  }
}
