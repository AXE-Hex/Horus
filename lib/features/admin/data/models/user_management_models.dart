import 'package:hue/core/auth/roles.dart';

class UserProfileModel {
  final String id;
  final String email;
  final String fullName;
  final String? fullNameAr;
  final String? avatarUrl;
  final List<UserRole> roles;
  final String? gender;
  final String? studentId;
  final String? nationalId;
  final String? nationality;
  final String? phone;
  final String? collegeId;
  final String? departmentId;
  final int warningLevel;
  final bool isVerified;
  final List<String> tags;
  final bool isBanned;
  final bool isActive;
  final bool mfaEnabled;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime? deletedAt;

  UserProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.fullNameAr,
    this.avatarUrl,
    required this.roles,
    this.gender,
    this.studentId,
    this.nationalId,
    this.nationality,
    this.phone,
    this.collegeId,
    this.departmentId,
    this.warningLevel = 0,
    this.isVerified = false,
    this.tags = const [],
    this.isBanned = false,
    required this.isActive,
    this.mfaEnabled = false,
    this.lastLogin,
    required this.createdAt,
    this.deletedAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      email: (json['email'] as String?) ?? '',
      fullName: (json['full_name'] as String?) ?? '',
      fullNameAr: json['full_name_ar'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      roles: _parseRoles(json),
      gender: json['gender'] as String?,
      studentId: json['student_id'] as String?,
      nationalId: json['national_id'] as String?,
      nationality: json['nationality'] as String?,
      phone: json['phone'] as String?,
      collegeId: json['college_id'] as String?,
      departmentId: json['department_id'] as String?,

      warningLevel: (json['warning_level'] as int?) ?? 0,
      isVerified: (json['is_verified'] as bool?) ?? false,
      tags: json.containsKey('tags')
          ? ((json['tags'] as List?)?.cast<String>() ?? [])
          : [],
      isBanned: (json['is_banned'] as bool?) ?? false,
      isActive: (json['is_active'] as bool?) ?? true,
      mfaEnabled: (json['mfa_enabled'] as bool?) ?? false,
      lastLogin: json['last_login'] != null
          ? DateTime.tryParse(json['last_login'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'] as String)
          : null,
    );
  }

  static List<UserRole> _parseRoles(Map<String, dynamic> json) {
    if (json['roles'] != null && json['roles'] is List) {
      final rolesList = json['roles'] as List;
      if (rolesList.isNotEmpty) {
        return rolesList
            .map((r) => UserRoleX.fromDbString(r as String))
            .toList();
      }
    }

    final roleStr = json['role'] as String? ?? 'student';
    return [UserRoleX.fromDbString(roleStr)];
  }

  Map<String, dynamic> toProfileJson() {
    return {
      'full_name': fullName,
      'full_name_ar': fullNameAr,
      'avatar_url': avatarUrl,
      'roles': roles.map((r) => r.toDbString()).toList(),
      'student_id': studentId,
      'national_id': nationalId,
      'nationality': nationality,
      'phone': phone,
      'college_id': collegeId,
      'department_id': departmentId,
      'is_active': isActive,
      'is_verified': isVerified,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      ...toProfileJson(),
      'warning_level': warningLevel,
      'tags': tags,
      'is_banned': isBanned,
      'mfa_enabled': mfaEnabled,
      'last_login': lastLogin?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? fullNameAr,
    String? avatarUrl,
    List<UserRole>? roles,
    String? gender,
    String? studentId,
    String? nationalId,
    String? nationality,
    String? phone,
    String? collegeId,
    String? departmentId,
    int? warningLevel,
    bool? isVerified,
    List<String>? tags,
    bool? isBanned,
    bool? isActive,
    bool? mfaEnabled,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      fullNameAr: fullNameAr ?? this.fullNameAr,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      roles: roles ?? this.roles,
      gender: gender ?? this.gender,
      studentId: studentId ?? this.studentId,
      nationalId: nationalId ?? this.nationalId,
      nationality: nationality ?? this.nationality,
      phone: phone ?? this.phone,
      collegeId: collegeId ?? this.collegeId,
      departmentId: departmentId ?? this.departmentId,
      warningLevel: warningLevel ?? this.warningLevel,
      isVerified: isVerified ?? this.isVerified,
      tags: tags ?? this.tags,
      isBanned: isBanned ?? this.isBanned,
      isActive: isActive ?? this.isActive,
      mfaEnabled: mfaEnabled ?? this.mfaEnabled,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
