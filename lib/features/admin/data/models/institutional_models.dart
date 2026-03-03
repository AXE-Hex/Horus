import 'package:hue/core/auth/roles.dart';

class CollegeModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? deanId;
  final DateTime createdAt;

  CollegeModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.deanId,
    required this.createdAt,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] as String,
      nameEn: json['name'] as String,
      nameAr: json['name_ar'] as String,
      descriptionEn: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      deanId: json['dean_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameEn,
      'name_ar': nameAr,
      'description': descriptionEn,
      'description_ar': descriptionAr,
      'dean_id': deanId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class DepartmentModel {
  final String id;
  final String collegeId;
  final String nameEn;
  final String nameAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? headId;
  final DateTime createdAt;

  DepartmentModel({
    required this.id,
    required this.collegeId,
    required this.nameEn,
    required this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.headId,
    required this.createdAt,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String,
      collegeId: json['college_id'] as String,
      nameEn: json['name'] as String,
      nameAr: json['name_ar'] as String,
      descriptionEn: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      headId: json['head_id'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'college_id': collegeId,
      'name': nameEn,
      'name_ar': nameAr,
      'description': descriptionEn,
      'description_ar': descriptionAr,
      'head_id': headId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class AppointmentModel {
  final String id;
  final String userId;
  final UserRole role;
  final String? collegeId;
  final String? departmentId;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.role,
    this.collegeId,
    this.departmentId,
    required this.startDate,
    this.endDate,
    this.isActive = true,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      role: UserRoleX.fromDbString(json['role'] as String),
      collegeId: json['college_id'] as String?,
      departmentId: json['department_id'] as String?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'role': role.toDbString(),
      'college_id': collegeId,
      'department_id': departmentId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive,
    };
  }
}

class DepartmentProjectModel {
  final String id;
  final String departmentId;
  final String titleEn;
  final String titleAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final String status;
  final DateTime createdAt;

  DepartmentProjectModel({
    required this.id,
    required this.departmentId,
    required this.titleEn,
    required this.titleAr,
    this.descriptionEn,
    this.descriptionAr,
    required this.status,
    required this.createdAt,
  });

  factory DepartmentProjectModel.fromJson(Map<String, dynamic> json) {
    return DepartmentProjectModel(
      id: json['id'] as String,
      departmentId: json['department_id'] as String,
      titleEn: json['title_en'] as String,
      titleAr: json['title_ar'] as String,
      descriptionEn: json['description_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department_id': departmentId,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
