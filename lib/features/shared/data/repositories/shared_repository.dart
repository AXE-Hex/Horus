import 'package:horus/core/data/base_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/config/supabase_client.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

final sharedRepositoryProvider = Provider<SharedRepository>(
  (ref) => SharedRepository(ref.watch(supabaseClientProvider)),
);

class SharedRepository extends BaseRepository {
  SharedRepository(super.client);

  Future<List<NotificationRecord>> getNotifications(String userId) async {
    final rows = await client
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    return rows.map((row) => NotificationRecord.fromJson(row)).toList();
  }

  Future<int> getUnreadCount(String userId) async {
    final result = await client
        .from('notifications')
        .select()
        .eq('user_id', userId)
        .eq('is_read', false);
    return (result as List).length;
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
        .select('*, profiles:author_id(full_name, avatar_url)')
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
    final rows = await client.from('forums').select().order('name');
    return rows.map((row) => ForumRecord.fromJson(row)).toList();
  }

  Future<List<ForumPostRecord>> getForumPosts(String forumId) async {
    final result = await client
        .from('forum_posts')
        .select('*, profiles:author_id(full_name, avatar_url)')
        .eq('forum_id', forumId)
        .isFilter('deleted_at', null)
        .order('is_pinned', ascending: false)
        .order('created_at', ascending: false);
    return result.map((row) => ForumPostRecord.fromJson(row)).toList();
  }

  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data) =>
      insert('forum_posts', data);

  Future<List<UserSessionRecord>> getUserSessions(String userId) async {
    final rows = await client
        .from('user_sessions')
        .select()
        .eq('user_id', userId)
        .order('last_active', ascending: false);
    return rows.map((row) => UserSessionRecord.fromJson(row)).toList();
  }

  Future<void> revokeSession(String sessionId) =>
      update('user_sessions', sessionId, {'is_active': false});

  Future<List<SharedFileRecord>> getSharedFiles({String? courseId}) async {
    final List<dynamic> rows;
    if (courseId != null) {
      rows = await client
          .from('shared_files')
          .select()
          .eq('course_id', courseId)
          .eq('is_public', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);
    } else {
      rows = await client
          .from('shared_files')
          .select()
          .eq('is_public', true)
          .isFilter('deleted_at', null)
          .order('created_at', ascending: false);
    }
    return rows
        .map((row) => SharedFileRecord.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<SharedFileRecord> uploadSharedFile(SharedFileUpload metadata) async {
    final row = await client
        .from('shared_files')
        .insert(metadata.toDatabase())
        .select()
        .single();
    return SharedFileRecord.fromJson(row);
  }

  Future<void> incrementDownloadCount(String fileId) async {
    final currentRow = await client
        .from('shared_files')
        .select()
        .eq('id', fileId)
        .single();
    final current = SharedFileRecord.fromJson(currentRow);
    await client
        .from('shared_files')
        .update({'download_count': current.downloadCount + 1})
        .eq('id', fileId);
  }
}
