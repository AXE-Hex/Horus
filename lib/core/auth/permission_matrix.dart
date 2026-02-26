import 'package:hue/core/auth/roles.dart';

class PermissionMatrixRow {
  final UserRole role;
  final Set<RolePermission> permissions;
  final Set<RolePermission> temporaryPermissions;
  final Map<RolePermission, DateTime> expirationDates;

  PermissionMatrixRow({
    required this.role,
    Set<RolePermission>? permissions,
    this.temporaryPermissions = const {},
    this.expirationDates = const {},
  }) : permissions = permissions ?? role.info.permissions.toSet();

  bool hasPermission(RolePermission permission) {
    if (permissions.contains(permission)) return true;

    if (temporaryPermissions.contains(permission)) {
      final expiration = expirationDates[permission];
      if (expiration == null || expiration.isAfter(DateTime.now())) {
        return true;
      }
    }

    return false;
  }
}

class PermissionMatrix {
  final Map<UserRole, PermissionMatrixRow> _matrix;

  PermissionMatrix(List<PermissionMatrixRow> rows)
    : _matrix = {for (var row in rows) row.role: row};

  bool checkAccess(UserRole role, RolePermission permission) {
    final row = _matrix[role];
    if (row != null) {
      return row.hasPermission(permission);
    }
    return role.hasPermission(permission);
  }

  factory PermissionMatrix.initial() {
    return PermissionMatrix(
      UserRole.values.map((role) => PermissionMatrixRow(role: role)).toList(),
    );
  }
}
