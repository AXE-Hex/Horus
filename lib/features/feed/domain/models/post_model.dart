import 'package:hue/core/auth/roles.dart';

enum PostType { text, image, video, link, announcement }

class PostModel {
  final String id;
  final String authorId;
  final String? collegeId;
  final String content;
  final List<String> mediaUrls;
  final String? linkUrl;
  final PostType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;

  // Joined fields from profiles
  final String? authorName;
  final String? authorAvatarUrl;
  final UserRole? authorRole;

  // Joined fields from colleges
  final String? collegeNameEn;
  final String? collegeNameAr;

  PostModel({
    required this.id,
    required this.authorId,
    this.collegeId,
    required this.content,
    required this.mediaUrls,
    this.linkUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.likesCount,
    required this.commentsCount,
    this.authorName,
    this.authorAvatarUrl,
    this.authorRole,
    this.collegeNameEn,
    this.collegeNameAr,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Parse author info if joined
    final profile = json['profiles'] as Map<String, dynamic>?;
    final college = json['colleges'] as Map<String, dynamic>?;

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

    return PostModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      collegeId: json['college_id'] as String?,
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
      authorName: profile?['full_name'] as String?,
      authorAvatarUrl: profile?['avatar_url'] as String?,
      authorRole: parsedRole,
      collegeNameEn:
          college?['name_en'] as String? ?? college?['name'] as String?,
      collegeNameAr: college?['name_ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'college_id': collegeId,
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
