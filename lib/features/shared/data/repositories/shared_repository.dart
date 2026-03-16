
import 'package:hue/core/data/base_repository.dart';

class SharedRepository extends BaseRepository {
  SharedRepository(super.client);

  Future<List<Map<String, dynamic>>> getNotifications(String userId) =>
      fetchWhere(
        'notifications',
        'user_id',
        userId,
        orderBy: 'created_at',
        ascending: false,
      );

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

  Future<void> markAllAsRead(String userId) async {
    await client
        .from('notifications')
        .update({'is_read': true, 'read_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId)
        .eq('is_read', false);
  }

  Future<List<Map<String, dynamic>>> getAnnouncements({
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
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> createAnnouncement(Map<String, dynamic> data) =>
      insert('announcements', data);

  Future<List<Map<String, dynamic>>> getForums() =>
      fetchAll('forums', orderBy: 'name');

  Future<List<Map<String, dynamic>>> getForumPosts(String forumId) async {
    final result = await client
        .from('forum_posts')
        .select('*, profiles:author_id(full_name, avatar_url)')
        .eq('forum_id', forumId)
        .isFilter('deleted_at', null)
        .order('is_pinned', ascending: false)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(result);
  }

  Future<Map<String, dynamic>> createPost(Map<String, dynamic> data) =>
      insert('forum_posts', data);

  Future<List<Map<String, dynamic>>> getTickets(String userId) => fetchWhere(
    'support_tickets',
    'user_id',
    userId,
    orderBy: 'created_at',
    ascending: false,
  );

  Future<Map<String, dynamic>> createTicket(Map<String, dynamic> data) =>
      insert('support_tickets', data);

  Future<Map<String, dynamic>> updateTicketStatus(
    String ticketId,
    String status,
  ) => update('support_tickets', ticketId, {'status': status});

  Future<List<Map<String, dynamic>>> getUserSessions(String userId) =>
      fetchWhere(
        'user_sessions',
        'user_id',
        userId,
        orderBy: 'last_active',
        ascending: false,
      );

  Future<void> revokeSession(String sessionId) =>
      update('user_sessions', sessionId, {'is_active': false});

  Future<List<Map<String, dynamic>>> getSharedFiles({String? courseId}) async {
    if (courseId != null) {
      return fetchAll(
        'shared_files',
        filters: {'course_id': courseId, 'is_public': true},
        orderBy: 'created_at',
        ascending: false,
      );
    }
    return fetchWhere(
      'shared_files',
      'is_public',
      true,
      orderBy: 'created_at',
      ascending: false,
    );
  }

  Future<Map<String, dynamic>> uploadSharedFile(
    Map<String, dynamic> metadata,
  ) => insert('shared_files', metadata);

  Future<void> incrementDownloadCount(String fileId) async {

    final current = await fetchById('shared_files', fileId);
    final count = (current['download_count'] as int? ?? 0) + 1;
    await update('shared_files', fileId, {'download_count': count});
  }
}
