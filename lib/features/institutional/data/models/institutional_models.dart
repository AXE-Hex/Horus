import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/data/db_row.dart';

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
    final row = DbRow(json, context: 'colleges');
    return CollegeModel(
      id: row.requiredString('id'),
      nameEn: row.requiredString('name_en'),
      nameAr: row.requiredString('name_ar'),
      code: row.optionalString('code'),
      descriptionEn: row.optionalString('description'),
      descriptionAr: row.optionalString('description_ar'),
      deanId: row.optionalString('dean_id'),
      imageUrl: row.optionalString('image_url'),
      established: json['established'] == null
          ? null
          : row.requiredInt('established'),
      studentCount: row.intOr('student_count', 0),
      createdAt: row.requiredDateTime('created_at'),
    );
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
    final row = DbRow(json, context: 'departments');
    return DepartmentModel(
      id: row.requiredString('id'),
      collegeId: row.requiredString('college_id'),
      nameEn: row.requiredString('name_en'),
      nameAr: row.requiredString('name_ar'),
      code: row.optionalString('code'),
      descriptionEn: row.optionalString('description'),
      descriptionAr: row.optionalString('description_ar'),
      headId: row.optionalString('hod_id'),
      assistantHeadId: row.optionalString('assistant_hod_id'),
      building: row.optionalString('building'),
      floor: json['floor'] == null ? null : row.requiredInt('floor'),
      officeSymbol: row.optionalString('office_symbol'),
      studentCount: row.intOr('student_count', 0),
      createdAt: row.requiredDateTime('created_at'),
    );
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
    final row = DbRow(json, context: 'appointments');
    return AppointmentModel(
      id: row.requiredString('id'),
      userId: row.requiredString('user_id'),
      role: UserRoleX.fromDbString(row.requiredString('role')),
      collegeId: row.optionalString('college_id'),
      departmentId: row.optionalString('department_id'),
      startDate: row.requiredDateTime('start_date'),
      endDate: row.optionalDateTime('end_date'),
      isActive: row.boolOr('is_active', true),
    );
  }
}

enum DepartmentProjectStatus { active, completed, paused, cancelled, unknown }

class DepartmentProjectModel {
  final String id;
  final String departmentId;
  final String titleEn;
  final String titleAr;
  final String? descriptionEn;
  final String? descriptionAr;
  final DepartmentProjectStatus status;
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
    final row = DbRow(json, context: 'department_projects');
    return DepartmentProjectModel(
      id: row.requiredString('id'),
      departmentId: row.requiredString('department_id'),
      titleEn: row.requiredString('title_en'),
      titleAr: row.requiredString('title_ar'),
      descriptionEn: row.optionalString('description_en'),
      descriptionAr: row.optionalString('description_ar'),
      status: row.enumValue(
        'status',
        DepartmentProjectStatus.values,
        DepartmentProjectStatus.unknown,
      ),
      createdAt: row.requiredDateTime('created_at'),
    );
  }
}
