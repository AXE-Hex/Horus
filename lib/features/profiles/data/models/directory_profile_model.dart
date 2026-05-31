import 'package:horus/core/auth/roles.dart';

class DirectoryProfileModel {
  final String id;
  final String email;
  final String fullName;
  final String? fullNameAr;
  final String? avatarUrl;
  final List<UserRole> roles;
  final String? studentId;
  final String? nationalId;
  final String? collegeId;
  final String? departmentId;
  final bool isActive;
  final DateTime createdAt;

  DirectoryProfileModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.fullNameAr,
    this.avatarUrl,
    required this.roles,
    this.studentId,
    this.nationalId,
    this.collegeId,
    this.departmentId,
    this.isActive = true,
    required this.createdAt,
  });

  factory DirectoryProfileModel.fromJson(Map<String, dynamic> json) {
    return DirectoryProfileModel(
      id: json['id'] as String,
      email: (json['email'] as String?) ?? '',
      fullName: (json['full_name'] as String?) ?? '',
      fullNameAr: json['full_name_ar'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      roles: _parseRoles(json),
      studentId: json['student_id'] as String?,
      nationalId: json['national_id'] as String?,
      collegeId: json['college_id'] as String?,
      departmentId: json['department_id'] as String?,
      isActive: (json['is_active'] as bool?) ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  static List<UserRole> _parseRoles(Map<String, dynamic> json) {
    final roles = json['roles'];
    if (roles is List && roles.isNotEmpty) {
      return roles.map((role) => UserRoleX.fromDbString(role.toString())).toList();
    }

    final role = json['role'] as String? ?? 'student';
    return [UserRoleX.fromDbString(role)];
  }
}
