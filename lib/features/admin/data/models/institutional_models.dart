import 'package:hue/core/auth/roles.dart';

class CollegeModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String? code;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? deanId;
  final String? imageUrl;
  final int? established;
  final int studentCount;
  final DateTime createdAt;

  CollegeModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.code,
    this.descriptionEn,
    this.descriptionAr,
    this.deanId,
    this.imageUrl,
    this.established,
    this.studentCount = 0,
    required this.createdAt,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] as String,
      nameEn: (json['name_en'] as String?) ?? (json['name'] as String? ?? ''),
      nameAr: (json['name_ar'] as String?) ?? '',
      code: json['code'] as String?,
      descriptionEn: (json['description'] as String?),
      descriptionAr: json['description_ar'] as String?,
      deanId: json['dean_id'] as String?,
      imageUrl: json['image_url'] as String?,
      established: json['established'] as int?,
      studentCount: (json['student_count'] as int?) ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nameEn,
      'name_en': nameEn,
      'name_ar': nameAr,
      if (code != null) 'code': code,
      'description': descriptionEn,
      'description_ar': descriptionAr,
      'dean_id': deanId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (established != null) 'established': established,
    };
  }
}

class DepartmentModel {
  final String id;
  final String collegeId;
  final String nameEn;
  final String nameAr;
  final String? code;
  final String? descriptionEn;
  final String? descriptionAr;
  final String? headId;
  final String? assistantHeadId;
  final String? building;
  final int? floor;
  final String? officeSymbol;
  final int studentCount;
  final DateTime createdAt;

  DepartmentModel({
    required this.id,
    required this.collegeId,
    required this.nameEn,
    required this.nameAr,
    this.code,
    this.descriptionEn,
    this.descriptionAr,
    this.headId,
    this.assistantHeadId,
    this.building,
    this.floor,
    this.officeSymbol,
    this.studentCount = 0,
    required this.createdAt,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as String,
      collegeId: json['college_id'] as String,
      nameEn: (json['name_en'] as String?) ?? (json['name'] as String? ?? ''),
      nameAr: (json['name_ar'] as String?) ?? '',
      code: json['code'] as String?,
      descriptionEn: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      headId: json['hod_id'] as String?,
      assistantHeadId: json['assistant_hod_id'] as String?,
      building: json['building'] as String?,
      floor: json['floor'] as int?,
      officeSymbol: json['office_symbol'] as String?,
      studentCount: (json['student_count'] as int?) ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'college_id': collegeId,
      'name': nameEn,
      'name_en': nameEn,
      'name_ar': nameAr,
      if (code != null) 'code': code,
      'description': descriptionEn,
      'description_ar': descriptionAr,
      'hod_id': headId,
      'assistant_hod_id': assistantHeadId,
      if (building != null) 'building': building,
      if (floor != null) 'floor': floor,
      if (officeSymbol != null) 'office_symbol': officeSymbol,
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
      'department_id': departmentId,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'status': status,
    };
  }
}
