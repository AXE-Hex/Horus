import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/data/db_row.dart';

class RoleDefinitionRecord {
  const RoleDefinitionRecord({
    required this.id,
    required this.code,
    required this.role,
    required this.priority,
  });

  final String id;
  final String code;
  final UserRole role;
  final int priority;

  factory RoleDefinitionRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'role_definitions');
    final code = row.requiredString('code');
    return RoleDefinitionRecord(
      id: row.requiredString('id'),
      code: code,
      role: UserRoleX.fromDbString(code),
      priority: row.requiredInt('priority'),
    );
  }
}

class UserRoleAssignmentRecord {
  const UserRoleAssignmentRecord({
    required this.roleId,
    required this.role,
    this.expiresAt,
  });

  final String roleId;
  final RoleDefinitionRecord role;
  final DateTime? expiresAt;

  factory UserRoleAssignmentRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'user_roles');
    final roleRow = row.optionalRow('role_definitions');
    if (roleRow == null) {
      throw const FormatException('user_roles.role_definitions is required');
    }
    return UserRoleAssignmentRecord(
      roleId: row.requiredString('role_id'),
      role: RoleDefinitionRecord.fromJson(roleRow.values),
      expiresAt: row.optionalDateTime('expires_at'),
    );
  }
}

class PermissionRecord {
  const PermissionRecord({
    required this.id,
    required this.code,
    required this.permission,
  });

  final String id;
  final String code;
  final RolePermission permission;

  factory PermissionRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'permissions');
    final code = row.requiredString('code');
    final permission = RolePermission.values
        .where((candidate) => candidate.code == code)
        .firstOrNull;
    if (permission == null) {
      throw FormatException('Unknown canonical permission code: $code');
    }
    return PermissionRecord(
      id: row.requiredString('id'),
      code: code,
      permission: permission,
    );
  }
}

class RolePermissionAssignmentRecord {
  const RolePermissionAssignmentRecord({
    required this.roleId,
    required this.permission,
  });

  final String roleId;
  final PermissionRecord permission;

  factory RolePermissionAssignmentRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'role_permissions');
    final permissionRow = row.optionalRow('permissions');
    if (permissionRow == null) {
      throw const FormatException('role_permissions.permissions is required');
    }
    return RolePermissionAssignmentRecord(
      roleId: row.requiredString('role_id'),
      permission: PermissionRecord.fromJson(permissionRow.values),
    );
  }
}
