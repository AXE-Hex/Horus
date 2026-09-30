import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/data/db_row.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/data/repositories/shared_repository.dart';

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

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'notification cache row');
    return AppNotification(
      id: row.requiredString('id'),
      title: row.requiredString('title'),
      message: row.requiredString('message'),
      timestamp: row.requiredDateTime('timestamp'),
      category: row.enumValue(
        'category',
        NotificationCategory.values,
        NotificationCategory.general,
      ),
      isRead: row.boolOr('isRead', false),
    );
  }

  factory AppNotification.fromRecord(NotificationRecord record) {
    final category = switch (record.type) {
      NotificationType.error ||
      NotificationType.warning => NotificationCategory.security,
      NotificationType.success => NotificationCategory.academic,
      _ => NotificationCategory.general,
    };
    return AppNotification(
      id: record.id,
      title: record.title,
      message: record.message,
      timestamp: record.createdAt,
      category: category,
      isRead: record.isRead,
    );
  }

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

      final records = await ref
          .watch(sharedRepositoryProvider)
          .getNotifications(auth.user!.id);
      return records.map(AppNotification.fromRecord).toList();
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
      await ref.read(sharedRepositoryProvider).markAsRead(id);
    } catch (e) {
      debugPrint('Error updating notification read status: $e');
    }
  }

  Future<void> markAllAsRead() async {
    final auth = ref.read(authControllerProvider);
    if (auth.user == null) return;

    try {
      final current = state.value ?? [];
      final updatedRows = await ref
          .read(sharedRepositoryProvider)
          .markAllAsRead(auth.user!.id);
      state = AsyncValue.data(
        notificationsAfterMarkAllRead(current, updatedRows: updatedRows),
      );
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
    }
  }
}

List<AppNotification> notificationsAfterMarkAllRead(
  List<AppNotification> notifications, {
  required int updatedRows,
}) {
  final unreadCount = notifications
      .where((notification) => !notification.isRead)
      .length;
  if (updatedRows < unreadCount) return notifications;
  return notifications
      .map((notification) => notification.copyWith(isRead: true))
      .toList();
}
