import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/data/db_row.dart';

enum PostType { text, image, video, link, announcement }

class PostModel {
  final String id;
  final String authorId;
  final String? collegeId;
  final String? departmentId;
  final String content;
  final List<String> mediaUrls;
  final String? linkUrl;
  final PostType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;

  final String? authorName;
  final String? authorAvatarUrl;
  final UserRole? authorRole;

  final String? collegeNameEn;
  final String? collegeNameAr;

  final String? departmentNameEn;
  final String? departmentNameAr;

  PostModel({
    required this.id,
    required this.authorId,
    this.collegeId,
    this.departmentId,
    required this.content,
    required this.mediaUrls,
    this.linkUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    this.isLiked = false,
    this.authorName,
    this.authorAvatarUrl,
    this.authorRole,
    this.collegeNameEn,
    this.collegeNameAr,
    this.departmentNameEn,
    this.departmentNameAr,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'posts');
    final profile = row.optionalRow('profiles');
    final college = row.optionalRow('colleges');
    final department = row.optionalRow('departments');

    const UserRole? parsedRole = null;
    final likes = row.rowsOrEmpty('post_likes');

    return PostModel(
      id: row.requiredString('id'),
      authorId: row.requiredString('author_id'),
      collegeId: row.optionalString('college_id'),
      departmentId: row.optionalString('department_id'),
      content: row.requiredString('content'),
      mediaUrls: row.stringsOrEmpty('media_urls'),
      linkUrl: row.optionalString('link_url'),
      type: row.enumValue('type', PostType.values, PostType.text),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
      likesCount: row.intOr('likes_count', 0),
      commentsCount: row.intOr('comments_count', 0),
      isLiked: likes.isNotEmpty,
      authorName: profile?.optionalString('full_name'),
      authorAvatarUrl: profile?.optionalString('avatar_url'),
      authorRole: parsedRole,
      collegeNameEn: college?.optionalString('name_en'),
      collegeNameAr: college?.optionalString('name_ar'),
      departmentNameEn: department?.optionalString('name_en'),
      departmentNameAr: department?.optionalString('name_ar'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'college_id': collegeId,
      'department_id': departmentId,
      'content': content,
      'media_urls': mediaUrls,
      'link_url': linkUrl,
      'type': type.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'likes_count': likesCount,
      'comments_count': commentsCount,
    };
  }
}

class CommentModel {
  final String id;
  final String postId;
  final String authorId;
  final String content;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String? authorName;
  final String? authorAvatarUrl;
  final UserRole? authorRole;

  CommentModel({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.content,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    this.authorName,
    this.authorAvatarUrl,
    this.authorRole,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'post_comments');
    final profile = row.optionalRow('profiles');

    const UserRole? parsedRole = null;

    return CommentModel(
      id: row.requiredString('id'),
      postId: row.requiredString('post_id'),
      authorId: row.requiredString('author_id'),
      content: row.requiredString('content'),
      parentId: row.optionalString('parent_id'),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
      authorName: profile?.optionalString('full_name'),
      authorAvatarUrl: profile?.optionalString('avatar_url'),
      authorRole: parsedRole,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'author_id': authorId,
      'content': content,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
