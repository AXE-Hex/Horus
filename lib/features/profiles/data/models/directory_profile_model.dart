import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/data/db_row.dart';

class DirectoryProfileModel {
  final String id;
  final String fullName;
  final String? fullNameAr;
  final String? avatarUrl;
  final List<UserRole> roles;
  final String? collegeId;
  final String? departmentId;
  final DateTime createdAt;

  DirectoryProfileModel({
    required this.id,
    required this.fullName,
    this.fullNameAr,
    this.avatarUrl,
    required this.roles,
    this.collegeId,
    this.departmentId,
    required this.createdAt,
  });

  factory DirectoryProfileModel.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'profile_directory');
    return DirectoryProfileModel(
      id: row.requiredString('id'),
      fullName: row.optionalString('full_name') ?? '',
      fullNameAr: row.optionalString('full_name_ar'),
      avatarUrl: row.optionalString('avatar_url'),
      roles: _parseRoles(json),
      collegeId: row.optionalString('college_id'),
      departmentId: row.optionalString('department_id'),
      createdAt: row.requiredDateTime('created_at'),
    );
  }

  static List<UserRole> _parseRoles(Map<String, dynamic> json) {
    final roles = json['role_codes'];
    if (roles is! List) return const [];
    return roles
        .map((role) => UserRoleX.tryFromDbString(role.toString()))
        .whereType<UserRole>()
        .toList();
  }
}
