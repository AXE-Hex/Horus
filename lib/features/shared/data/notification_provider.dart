
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/config/supabase_client.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

enum NotificationCategory { academic, finance, security, social, general }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final NotificationCategory category;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.category,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
    'category': category.name,
    'isRead': isRead,
  };

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      AppNotification(
        id: json['id'],
        title: json['title'],
        message: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
        category: NotificationCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => NotificationCategory.general,
        ),
        isRead: json['isRead'] ?? false,
      );

  AppNotification copyWith({bool? isRead}) => AppNotification(
    id: id,
    title: title,
    message: message,
    timestamp: timestamp,
    category: category,
    isRead: isRead ?? this.isRead,
  );
}

@Riverpod(keepAlive: true)
class NotificationController extends _$NotificationController {
  @override
  FutureOr<List<AppNotification>> build() async {
    return _fetchFromSupabase();
  }

  Future<List<AppNotification>> _fetchFromSupabase() async {
    try {
      final auth = ref.watch(authControllerProvider);
      if (auth.user == null) return [];

      final supabase = ref.watch(supabaseClientProvider);
      final response = await supabase
          .from('notifications')
          .select('*')
          .eq('user_id', auth.user!.id)
          .order('created_at', ascending: false);

      final List<AppNotification> notes = [];
      for (final row in response) {

        NotificationCategory category;
        final typeStr = row['type'] as String?;
        switch (typeStr) {
          case 'error':
          case 'warning':
            category = NotificationCategory.security;
            break;
          case 'success':
            category = NotificationCategory.academic;
            break;
          case 'info':
          default:
            category = NotificationCategory.general;
            break;
        }

        notes.add(
          AppNotification(
            id: row['id'].toString(),
            title: row['title'] ?? '',
            message: row['message'] ?? '',
            timestamp: DateTime.parse(row['created_at']),
            category: category,
            isRead: row['is_read'] ?? false,
          ),
        );
      }
      return notes;
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
      return [];
    }
  }

  Future<void> addNotification(AppNotification note) async {

    final current = state.value ?? [];
    state = AsyncValue.data([note, ...current]);
  }

  Future<void> markAsRead(String id) async {
    final auth = ref.read(authControllerProvider);
    if (auth.user == null) return;

    final current = state.value ?? [];
    final updated = current
        .map((e) => e.id == id ? e.copyWith(isRead: true) : e)
        .toList();
    state = AsyncValue.data(updated);

    try {
      final supabase = ref.read(supabaseClientProvider);
      await supabase
          .from('notifications')
          .update({
            'is_read': true,
            'read_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);
    } catch (e) {
      debugPrint('Error updating notification read status: $e');
    }
  }

  Future<void> clearAll() async {
    final auth = ref.read(authControllerProvider);
    if (auth.user == null) return;

    state = const AsyncValue.data([]);

    try {
      final supabase = ref.read(supabaseClientProvider);
      await supabase
          .from('notifications')
          .delete()
          .eq('user_id', auth.user!.id);
    } catch (e) {
      debugPrint('Error clearing notifications: $e');
    }
  }
}
