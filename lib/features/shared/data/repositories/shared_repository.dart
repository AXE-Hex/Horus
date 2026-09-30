import 'package:horus/core/data/base_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

final sharedRepositoryProvider = Provider<SharedRepository>(
  (ref) => SharedRepository(ref.watch(supabaseClientProvider)),
);

class SharedRepository extends BaseRepository {
  SharedRepository(super.client);

  Future<List<NotificationRecord>> getNotifications(
    String userId, {
    int offset = 0,
    int limit = 50,
  }) async {
    _validatePage(offset, limit);
    final rows = await client
        .from('notifications')
        .select(
          'id,user_id,title,title_ar,message,message_ar,type,is_read,created_at,read_at,action_url,metadata',
        )
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .order('id', ascending: false)
        .range(offset, offset + limit - 1);
    return rows.map((row) => NotificationRecord.fromJson(row)).toList();
  }

  Future<int> getUnreadCount(String userId) async {
    final result = await client
        .from('notifications')
        .count()
        .eq('user_id', userId)
        .eq('is_read', false);
    return result;
  }

  Future<void> markAsRead(String notificationId) => update(
    'notifications',
    notificationId,
    {'is_read': true, 'read_at': DateTime.now().toIso8601String()},
  );

  Future<int> markAllAsRead(String userId) async {
    final rows = await client
        .from('notifications')
        .update({'is_read': true, 'read_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId)
        .eq('is_read', false)
        .select('id');
    return rows.length;
  }

  Future<List<AnnouncementRecord>> getAnnouncements({
    String? courseId,
    int limit = 20,
  }) async {
    var query = client
        .from('announcements')
        .select(
          'id,author_id,college_id,department_id,course_id,title,title_ar,content,content_ar,priority,is_pinned,published_at,expires_at,profiles:author_id(full_name,avatar_url)',
        )
        .isFilter('deleted_at', null);

    if (courseId != null) {
      query = query.eq('course_id', courseId);
    }

    final result = await query
        .order('published_at', ascending: false)
        .limit(limit);
    return result.map((row) => AnnouncementRecord.fromJson(row)).toList();
  }

  Future<Map<String, dynamic>> createAnnouncement(Map<String, dynamic> data) =>
      insert('announcements', data);

  Future<List<ForumRecord>> getForums() async {
    final rows = await client
        .from('forums')
        .select('id,name,name_ar,description,category,is_active,created_at')
        .eq('is_active', true)
        .order('name');
    return rows.map((row) => ForumRecord.fromJson(row)).toList();
  }

  Future<List<ForumPostRecord>> getForumPosts(
    String forumId, {
    int offset = 0,
    int limit = 50,
  }) async {
    _validatePage(offset, limit);
    final result = await client
        .from('forum_posts')
        .select(
          'id,forum_id,author_id,title,content,is_pinned,reply_count,created_at,profiles:author_id(full_name,avatar_url)',
        )
        .eq('forum_id', forumId)
        .isFilter('deleted_at', null)
        .order('is_pinned', ascending: false)
        .order('created_at', ascending: false)
        .order('id', ascending: false)
        .range(offset, offset + limit - 1);
    return result.map((row) => ForumPostRecord.fromJson(row)).toList();
  }

  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data) =>
      insert('forum_posts', data);

  Future<List<UserSessionRecord>> getUserSessions(String userId) async {
    final rows = await client
        .from('user_sessions')
        .select(
          'id,user_id,device_type,is_active,last_active,created_at,device_name,location',
        )
        .eq('user_id', userId)
        .order('last_active', ascending: false);
    return rows.map((row) => UserSessionRecord.fromJson(row)).toList();
  }

  Future<void> revokeSession(String sessionId) =>
      update('user_sessions', sessionId, {'is_active': false});

  Future<List<SharedFileRecord>> getSharedFiles({
    String? courseId,
    int offset = 0,
    int limit = 50,
  }) async {
    _validatePage(offset, limit);
    final List<dynamic> rows;
    if (courseId != null) {
      rows = await client
          .from('shared_files')
          .select(
            'id,uploader_id,title,title_ar,file_path,file_type,file_size,download_count,is_public,created_at,course_id,deleted_at',
          )
          .eq('course_id', courseId)
          .eq('is_public', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false)
          .order('id', ascending: false)
          .range(offset, offset + limit - 1);
    } else {
      rows = await client
          .from('shared_files')
          .select(
            'id,uploader_id,title,title_ar,file_path,file_type,file_size,download_count,is_public,created_at,course_id,deleted_at',
          )
          .eq('is_public', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false)
          .order('id', ascending: false)
          .range(offset, offset + limit - 1);
    }
    return rows
        .map((row) => SharedFileRecord.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<SharedFileRecord> uploadSharedFile(SharedFileUpload metadata) async {
    final row = await client
        .from('shared_files')
        .insert(metadata.toDatabase())
        .select(
          'id,uploader_id,title,title_ar,file_path,file_type,file_size,download_count,is_public,created_at,course_id,deleted_at',
        )
        .single();
    return SharedFileRecord.fromJson(row);
  }

  void _validatePage(int offset, int limit) {
    if (offset < 0 || limit < 1 || limit > 100) {
      throw ArgumentError('Pagination is out of range.');
    }
  }
}
