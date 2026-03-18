import 'package:hue/core/auth/roles.dart';

class DynamicRoleModel {
  final String id;
  final String code;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final RoleCategory category;
  final Set<RolePermission> permissions;
  final int hierarchyLevel;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DynamicRoleModel({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.category,
    required this.permissions,
    required this.hierarchyLevel,
    this.createdAt,
    this.updatedAt,
  });

  factory DynamicRoleModel.fromJson(Map<String, dynamic> json) {
    return DynamicRoleModel(
      id: json['id'] as String,
      code: json['code'] as String,
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      descriptionEn: json['description_en'] as String? ?? '',
      descriptionAr: json['description_ar'] as String? ?? '',
      category: RoleCategory.values.firstWhere(
        (c) => c.name == json['category'],
        orElse: () => RoleCategory.externalRoles,
      ),
      permissions:
          (json['permissions'] as List<dynamic>?)
              ?.map(
                (p) => RolePermission.values.firstWhere(
                  (rp) => rp.name == p.toString(),
                ),
              )
              .toSet() ??
          {},
      hierarchyLevel: json['hierarchy_level'] as int? ?? 10,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'category': category.name,
      'permissions': permissions.map((p) => p.name).toList(),
      'hierarchy_level': hierarchyLevel,
    };
  }

  DynamicRoleModel copyWith({
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    RoleCategory? category,
    Set<RolePermission>? permissions,
    int? hierarchyLevel,
  }) {
    return DynamicRoleModel(
      id: id,
      code: code,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      category: category ?? this.category,
      permissions: permissions ?? this.permissions,
      hierarchyLevel: hierarchyLevel ?? this.hierarchyLevel,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
