import 'package:hue/core/auth/roles.dart';

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
    final profile = json['profiles'] as Map<String, dynamic>?;
    final college = json['colleges'] as Map<String, dynamic>?;
    final department = json['departments'] as Map<String, dynamic>?;

    UserRole? parsedRole;
    if (profile?['role'] != null) {
      parsedRole = UserRoleX.fromDbString(profile!['role'] as String);
    } else if (profile?['roles'] != null) {
      final roles = profile!['roles'] as List;
      if (roles.isNotEmpty) {
        parsedRole = UserRoleX.fromDbString(roles.first as String);
      }
    }

    final mediaList = json['media_urls'] as List<dynamic>? ?? [];

    final likes = json['post_likes'] as List<dynamic>?;
    final isLiked = likes != null && likes.isNotEmpty;

    return PostModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      collegeId: json['college_id'] as String?,
      departmentId: json['department_id'] as String?,
      content: json['content'] as String,
      mediaUrls: mediaList.map((e) => e.toString()).toList(),
      linkUrl: json['link_url'] as String?,
      type: PostType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PostType.text,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      isLiked: isLiked,
      authorName: profile?['full_name'] as String?,
      authorAvatarUrl: profile?['avatar_url'] as String?,
      authorRole: parsedRole,
      collegeNameEn:
          college?['name_en'] as String? ?? college?['name'] as String?,
      collegeNameAr: college?['name_ar'] as String?,
      departmentNameEn:
          department?['name_en'] as String? ?? department?['name'] as String?,
      departmentNameAr: department?['name_ar'] as String?,
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
    final profile = json['profiles'] as Map<String, dynamic>?;

    UserRole? parsedRole;
    if (profile?['role'] != null) {
      parsedRole = UserRoleX.fromDbString(profile!['role'] as String);
    } else if (profile?['roles'] != null) {
      final roles = profile!['roles'] as List;
      if (roles.isNotEmpty) {
        parsedRole = UserRoleX.fromDbString(roles.first as String);
      }
    }

    return CommentModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      authorId: json['author_id'] as String,
      content: json['content'] as String,
      parentId: json['parent_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      authorName: profile?['full_name'] as String?,
      authorAvatarUrl: profile?['avatar_url'] as String?,
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
