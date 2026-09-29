import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/data/db_row.dart';

class ProfileModel {
  final String id;
  final String email;
  final String fullName;
  final String? fullNameAr;
  final String? avatarUrl;

  /// Loaded from canonical user_roles assignments, never from profiles.roles.
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

  factory ProfileModel.fromJson(
    Map<String, dynamic> json, {
    required List<String> roleCodes,
  }) {
    final row = DbRow(json, context: 'profiles');
    final parsedRoles = roleCodes
        .map(UserRoleX.tryFromDbString)
        .whereType<UserRole>()
        .toList();
    return ProfileModel(
      id: row.requiredString('id'),
      email: row.requiredString('email'),
      fullName: row.requiredString('full_name'),
      fullNameAr: row.optionalString('full_name_ar'),
      avatarUrl: row.optionalString('avatar_url'),
      roles: parsedRoles,
      studentId: row.optionalString('student_id'),
      nationalId: row.optionalString('national_id'),
      nationality: row.optionalString('nationality'),
      phone: row.optionalString('phone'),
      bio: row.optionalString('bio'),
      bioAr: row.optionalString('bio_ar'),
      collegeId: row.optionalString('college_id'),
      departmentId: row.optionalString('department_id'),
      advisorId: row.optionalString('advisor_id'),
      warningLevel: row.intOr('warning_level', 0),
      isVerified: row.boolOr('is_verified', false),
      tags: row.stringsOrEmpty('tags'),
      isBanned: row.boolOr('is_banned', false),
      isActive: row.boolOr('is_active', true),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
    );
  }

  UserRole get primaryRole => roles.isNotEmpty ? roles.first : UserRole.guest;
}
