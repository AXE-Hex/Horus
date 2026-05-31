import 'package:horus/core/auth/roles.dart';

class ProfileModel {
  final String id;
  final String email;
  final String fullName;
  final String? fullNameAr;
  final String? avatarUrl;
  final List<UserRole> roles;
  final String? studentId;
  final String? nationalId;
  final String? nationality;
  final String? phone;
  final String? bio;
  final String? bioAr;
  final String? collegeId;
  final String? departmentId;
  final String? advisorId;
  final int warningLevel;
  final bool isVerified;
  final List<String> tags;
  final bool isBanned;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.fullNameAr,
    this.avatarUrl,
    required this.roles,
    this.studentId,
    this.nationalId,
    this.nationality,
    this.phone,
    this.bio,
    this.bioAr,
    this.collegeId,
    this.departmentId,
    this.advisorId,
    this.warningLevel = 0,
    this.isVerified = false,
    this.tags = const [],
    this.isBanned = false,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    List<UserRole> parsedRoles = [];
    if (json['roles'] != null) {
      final rolesList = json['roles'] as List;
      parsedRoles = rolesList.map((r) => UserRoleX.fromDbString(r.toString())).toList();
    } else {
      parsedRoles = [UserRole.guest];
    }

    return ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      fullNameAr: json['full_name_ar'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      roles: parsedRoles,
      studentId: json['student_id'] as String?,
      nationalId: json['national_id'] as String?,
      nationality: json['nationality'] as String?,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      bioAr: json['bio_ar'] as String?,
      collegeId: json['college_id'] as String?,
      departmentId: json['department_id'] as String?,
      advisorId: json['advisor_id'] as String?,
      warningLevel: json['warning_level'] as int? ?? 0,
      isVerified: json['is_verified'] as bool? ?? false,
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      isBanned: json['is_banned'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      if (fullNameAr != null) 'full_name_ar': fullNameAr,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      'roles': roles.map((r) => r.toDbString()).toList(),
      if (studentId != null) 'student_id': studentId,
      if (nationalId != null) 'national_id': nationalId,
      if (nationality != null) 'nationality': nationality,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
      if (bioAr != null) 'bio_ar': bioAr,
      if (collegeId != null) 'college_id': collegeId,
      if (departmentId != null) 'department_id': departmentId,
      if (advisorId != null) 'advisor_id': advisorId,
      'warning_level': warningLevel,
      'is_verified': isVerified,
      'tags': tags,
      'is_banned': isBanned,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserRole get primaryRole => roles.isNotEmpty ? roles.first : UserRole.guest;
}
