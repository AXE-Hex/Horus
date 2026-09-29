import 'package:horus/core/data/db_row.dart';

enum SharedFileType { pdf, docx, pptx, xlsx, image, video, other, unknown }

extension SharedFileTypeX on SharedFileType {
  static SharedFileType fromDatabase(String? value) =>
      SharedFileType.values.firstWhere(
        (type) => type.name == value,
        orElse: () => SharedFileType.unknown,
      );

  String get databaseValue {
    if (this == SharedFileType.unknown) {
      throw StateError('Unknown shared-file type cannot be written.');
    }
    return name;
  }
}

class SharedFileRecord {
  const SharedFileRecord({
    required this.id,
    required this.uploaderId,
    required this.title,
    required this.path,
    required this.fileType,
    required this.fileSizeBytes,
    required this.downloadCount,
    required this.isPublic,
    required this.createdAt,
    this.titleAr,
    this.courseId,
    this.deletedAt,
  });

  final String id;
  final String uploaderId;
  final String title;
  final String? titleAr;
  final String path;
  final SharedFileType fileType;
  final int? fileSizeBytes;
  final int downloadCount;
  final bool isPublic;
  final DateTime createdAt;
  final String? courseId;
  final DateTime? deletedAt;

  String get sizeLabel => '${(fileSizeBytes ?? 0) ~/ 1024} KB';

  factory SharedFileRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'shared_files');
    return SharedFileRecord(
      id: row.requiredString('id'),
      uploaderId: row.requiredString('uploader_id'),
      title: row.requiredString('title'),
      titleAr: row.optionalString('title_ar'),
      path: row.requiredString('file_path'),
      fileType: SharedFileTypeX.fromDatabase(row.optionalString('file_type')),
      fileSizeBytes: row.optionalInt('file_size'),
      downloadCount: row.intOr('download_count', 0),
      isPublic: row.boolOr('is_public', true),
      createdAt: row.requiredDateTime('created_at'),
      courseId: row.optionalString('course_id'),
      deletedAt: row.optionalDateTime('deleted_at'),
    );
  }
}

class SharedFileUpload {
  const SharedFileUpload({
    required this.id,
    required this.uploaderId,
    required this.title,
    required this.path,
    required this.fileType,
    this.titleAr,
    required this.courseId,
    this.fileSizeBytes,
    this.isPublic = true,
  });

  final String id;
  final String uploaderId;
  final String title;
  final String? titleAr;
  final String path;
  final SharedFileType fileType;
  final String courseId;
  final int? fileSizeBytes;
  final bool isPublic;

  static String buildCourseFilePath({
    required String courseId,
    required String uploaderId,
    required String fileId,
    required String fileName,
  }) {
    final uuid = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    );
    if (!uuid.hasMatch(courseId) ||
        !uuid.hasMatch(uploaderId) ||
        !uuid.hasMatch(fileId) ||
        fileName.isEmpty ||
        fileName.contains('/') ||
        fileName == '.' ||
        fileName == '..') {
      throw ArgumentError('Course file path parts are invalid.');
    }
    return '$courseId/$uploaderId/$fileId/$fileName';
  }

  Map<String, dynamic> toDatabase() => {
    'id': id,
    'uploader_id': uploaderId,
    'title': title,
    'title_ar': titleAr,
    'file_path': path,
    'file_type': fileType.databaseValue,
    'course_id': courseId,
    'file_size': fileSizeBytes,
    'is_public': isPublic,
  };
}

class ConversationMemberRecord {
  const ConversationMemberRecord({
    required this.conversationId,
    required this.userId,
    required this.joinedAt,
    required this.lastReadAt,
    required this.isAdmin,
    required this.isMuted,
    this.profile,
  });

  final String conversationId;
  final String userId;
  final DateTime joinedAt;
  final DateTime lastReadAt;
  final bool isAdmin;
  final bool isMuted;
  final ConversationProfile? profile;

  factory ConversationMemberRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'conversation_members');
    final profileRow = row.optionalRow('profiles');
    return ConversationMemberRecord(
      conversationId: row.requiredString('conversation_id'),
      userId: row.requiredString('user_id'),
      joinedAt: row.requiredDateTime('joined_at'),
      lastReadAt: row.requiredDateTime('last_read_at'),
      isAdmin: row.boolOr('is_admin', false),
      isMuted: row.boolOr('is_muted', false),
      profile: profileRow == null
          ? null
          : ConversationProfile.fromRow(profileRow),
    );
  }
}

class ConversationProfile {
  const ConversationProfile({
    required this.id,
    required this.fullName,
    this.avatarUrl,
  });

  final String id;
  final String fullName;
  final String? avatarUrl;

  factory ConversationProfile.fromRow(DbRow row) => ConversationProfile(
    id: row.requiredString('id'),
    fullName: row.requiredString('full_name'),
    avatarUrl: row.optionalString('avatar_url'),
  );
}

class ConversationRecord {
  const ConversationRecord({
    required this.id,
    required this.isGroup,
    required this.createdAt,
    required this.updatedAt,
    this.title,
    this.createdBy,
    this.lastMessage,
    this.lastMessageAt,
    this.members = const [],
  });

  final String id;
  final String? title;
  final bool isGroup;
  final String? createdBy;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ConversationMemberRecord> members;

  factory ConversationRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'conversations');
    return ConversationRecord(
      id: row.requiredString('id'),
      title: row.optionalString('title'),
      isGroup: row.boolOr('is_group', false),
      createdBy: row.optionalString('created_by'),
      lastMessage: row.optionalString('last_message'),
      lastMessageAt: row.optionalDateTime('last_message_at'),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
      members: row
          .rowsOrEmpty('conversation_members')
          .map((member) => ConversationMemberRecord.fromJson(member.values))
          .toList(),
    );
  }
}

enum MessageStatus { sent, delivered, read, deleted, unknown }

class MessageRecord {
  const MessageRecord({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.status,
    required this.isEdited,
    required this.createdAt,
    this.mediaUrl,
    this.replyToId,
    this.deletedAt,
    this.sender,
    this.reply,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String content;
  final MessageStatus status;
  final bool isEdited;
  final DateTime createdAt;
  final String? mediaUrl;
  final String? replyToId;
  final DateTime? deletedAt;
  final ConversationProfile? sender;
  final ReplyMessagePreview? reply;

  factory MessageRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'messages');
    final senderRow = row.optionalRow('sender');
    final replyRow = row.optionalRow('reply');
    final status = MessageStatus.values.firstWhere(
      (value) => value.name == row.optionalString('status'),
      orElse: () => MessageStatus.unknown,
    );
    return MessageRecord(
      id: row.requiredString('id'),
      conversationId: row.requiredString('conversation_id'),
      senderId: row.requiredString('sender_id'),
      content: row.requiredString('content'),
      status: status,
      isEdited: row.boolOr('is_edited', false),
      createdAt: row.requiredDateTime('created_at'),
      mediaUrl: row.optionalString('media_url'),
      replyToId: row.optionalString('reply_to_id'),
      deletedAt: row.optionalDateTime('deleted_at'),
      sender: senderRow == null ? null : ConversationProfile.fromRow(senderRow),
      reply: replyRow == null ? null : ReplyMessagePreview.fromRow(replyRow),
    );
  }
}

class ReplyMessagePreview {
  const ReplyMessagePreview({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final String content;
  final DateTime createdAt;

  factory ReplyMessagePreview.fromRow(DbRow row) => ReplyMessagePreview(
    id: row.requiredString('id'),
    content: row.requiredString('content'),
    createdAt: row.requiredDateTime('created_at'),
  );
}

enum NotificationType { info, warning, success, error, unknown }

class NotificationRecord {
  const NotificationRecord({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.titleAr,
    this.messageAr,
    this.actionUrl,
    this.readAt,
    this.metadata,
  });

  final String id;
  final String userId;
  final String title;
  final String message;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final String? titleAr;
  final String? messageAr;
  final String? actionUrl;
  final DateTime? readAt;
  final Map<String, dynamic>? metadata;

  factory NotificationRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'notifications');
    final metadataRow = row.optionalRow('metadata');
    return NotificationRecord(
      id: row.requiredString('id'),
      userId: row.requiredString('user_id'),
      title: row.requiredString('title'),
      message: row.requiredString('message'),
      type: row.enumValue(
        'type',
        NotificationType.values,
        NotificationType.unknown,
      ),
      isRead: row.boolOr('is_read', false),
      createdAt: row.requiredDateTime('created_at'),
      titleAr: row.optionalString('title_ar'),
      messageAr: row.optionalString('message_ar'),
      actionUrl: row.optionalString('action_url'),
      readAt: row.optionalDateTime('read_at'),
      metadata: metadataRow?.values,
    );
  }
}

enum AnnouncementPriority { normal, important, urgent, unknown }

enum ForumCategory { general, academic, social, feedback, unknown }

class AnnouncementAuthor {
  const AnnouncementAuthor({this.fullName, this.avatarUrl});
  final String? fullName;
  final String? avatarUrl;

  factory AnnouncementAuthor.fromRow(DbRow row) => AnnouncementAuthor(
    fullName: row.optionalString('full_name'),
    avatarUrl: row.optionalString('avatar_url'),
  );
}

class AnnouncementRecord {
  const AnnouncementRecord({
    required this.id,
    required this.authorId,
    required this.title,
    required this.content,
    required this.priority,
    required this.isPinned,
    required this.publishedAt,
    this.titleAr,
    this.contentAr,
    this.collegeId,
    this.departmentId,
    this.courseId,
    this.expiresAt,
    this.author,
  });

  final String id;
  final String authorId;
  final String title;
  final String content;
  final AnnouncementPriority priority;
  final bool isPinned;
  final DateTime publishedAt;
  final String? titleAr;
  final String? contentAr;
  final String? collegeId;
  final String? departmentId;
  final String? courseId;
  final DateTime? expiresAt;
  final AnnouncementAuthor? author;

  factory AnnouncementRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'announcements');
    final author = row.optionalRow('profiles');
    return AnnouncementRecord(
      id: row.requiredString('id'),
      authorId: row.requiredString('author_id'),
      title: row.requiredString('title'),
      content: row.requiredString('content'),
      priority: row.enumValue(
        'priority',
        AnnouncementPriority.values,
        AnnouncementPriority.unknown,
      ),
      isPinned: row.boolOr('is_pinned', false),
      publishedAt: row.requiredDateTime('published_at'),
      titleAr: row.optionalString('title_ar'),
      contentAr: row.optionalString('content_ar'),
      collegeId: row.optionalString('college_id'),
      departmentId: row.optionalString('department_id'),
      courseId: row.optionalString('course_id'),
      expiresAt: row.optionalDateTime('expires_at'),
      author: author == null ? null : AnnouncementAuthor.fromRow(author),
    );
  }
}

class ForumRecord {
  const ForumRecord({
    required this.id,
    required this.name,
    required this.category,
    required this.isActive,
    required this.createdAt,
    this.nameAr,
    this.description,
  });
  final String id;
  final String name;
  final ForumCategory category;
  final bool isActive;
  final DateTime createdAt;
  final String? nameAr;
  final String? description;

  factory ForumRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'forums');
    return ForumRecord(
      id: row.requiredString('id'),
      name: row.requiredString('name'),
      category: row.enumValue(
        'category',
        ForumCategory.values,
        ForumCategory.unknown,
      ),
      isActive: row.boolOr('is_active', false),
      createdAt: row.requiredDateTime('created_at'),
      nameAr: row.optionalString('name_ar'),
      description: row.optionalString('description'),
    );
  }
}

class ForumPostRecord {
  const ForumPostRecord({
    required this.id,
    required this.forumId,
    required this.authorId,
    required this.title,
    required this.content,
    required this.isPinned,
    required this.replyCount,
    required this.createdAt,
    this.author,
  });
  final String id;
  final String forumId;
  final String authorId;
  final String title;
  final String content;
  final bool isPinned;
  final int replyCount;
  final DateTime createdAt;
  final AnnouncementAuthor? author;

  factory ForumPostRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'forum_posts');
    final author = row.optionalRow('profiles');
    return ForumPostRecord(
      id: row.requiredString('id'),
      forumId: row.requiredString('forum_id'),
      authorId: row.requiredString('author_id'),
      title: row.requiredString('title'),
      content: row.requiredString('content'),
      isPinned: row.boolOr('is_pinned', false),
      replyCount: row.intOr('reply_count', 0),
      createdAt: row.requiredDateTime('created_at'),
      author: author == null ? null : AnnouncementAuthor.fromRow(author),
    );
  }
}

enum SessionDevice { mobile, desktop, tablet, unknown }

class UserSessionRecord {
  const UserSessionRecord({
    required this.id,
    required this.userId,
    required this.deviceType,
    required this.isActive,
    required this.lastActive,
    required this.createdAt,
    this.deviceName,
    this.location,
  });
  final String id;
  final String userId;
  final SessionDevice deviceType;
  final bool isActive;
  final DateTime lastActive;
  final DateTime createdAt;
  final String? deviceName;
  final String? location;

  factory UserSessionRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'user_sessions');
    return UserSessionRecord(
      id: row.requiredString('id'),
      userId: row.requiredString('user_id'),
      deviceType: row.enumValue(
        'device_type',
        SessionDevice.values,
        SessionDevice.unknown,
      ),
      isActive: row.boolOr('is_active', true),
      lastActive: row.requiredDateTime('last_active'),
      createdAt: row.requiredDateTime('created_at'),
      deviceName: row.optionalString('device_name'),
      location: row.optionalString('location'),
    );
  }
}
