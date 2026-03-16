import 'package:hue/core/i18n/strings.g.dart';

enum RoleCategory {
  adminIT,
  academicLeadership,
  teachingStaff,
  studentAffairs,
  studentRoles,
  facilitiesSecurity,
  externalRoles,
}

enum UserRole {
  superAdmin,
  admin,
  itSupport,
  financialAuditor,

  rector,
  dean,
  departmentHead,
  academicCoordinator,

  professor,
  lecturer,
  teachingAssistant,

  registrarOfficer,
  academicAdvisor,
  librarian,

  freshman,
  regularStudent,
  student,
  classRepresentative,
  alumni,

  dormSupervisor,
  securityOfficer,
  guest,

  parent,
  recruiter,
}

enum RolePermission {
  manageSystem,
  manageUsers,
  viewAuditLogs,
  manageFinances,

  manageColleges,
  manageDepartments,
  manageCourses,
  manageSchedules,
  approveEnrollments,

  manageGrades,
  manageAttendance,
  createAnnouncements,
  uploadMaterials,
  manageTAs,
  manageGroups,

  manageEnrollments,
  adviseStudents,
  manageLibrary,

  viewGrades,
  viewSchedule,
  viewAttendance,
  enrollCourses,
  submitRatings,
  accessForums,
  viewMaterials,

  viewStudentProgress,
  viewJobBoard,

  viewProfile,
  editOwnProfile,
  viewNotifications,
  submitSupportTicket,
}

class RoleInfo {
  final UserRole role;
  final RoleCategory category;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final int hierarchyLevel;
  final Set<RolePermission> permissions;

  const RoleInfo({
    required this.role,
    required this.category,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.hierarchyLevel,
    required this.permissions,
  });
}

final Map<UserRole, RoleInfo> roleRegistry = {
  UserRole.superAdmin: RoleInfo(
    role: UserRole.superAdmin,
    category: RoleCategory.adminIT,
    nameEn: 'Super Admin',
    nameAr: 'مدير النظام العام',
    descriptionEn: 'Full control over the entire system',
    descriptionAr: 'تحكم كامل في النظام بأكمله',
    hierarchyLevel: 0,
    permissions: RolePermission.values.toSet(),
  ),

  UserRole.admin: RoleInfo(
    role: UserRole.admin,
    category: RoleCategory.adminIT,
    nameEn: 'Administrator',
    nameAr: 'مسؤول نظام',
    descriptionEn: 'System administrator with high privileges',
    descriptionAr: 'مسؤول نظام بصلاحيات عالية',
    hierarchyLevel: 1,
    permissions: RolePermission.values
        .where((p) => p != RolePermission.manageSystem)
        .toSet(),
  ),

  UserRole.itSupport: const RoleInfo(
    role: UserRole.itSupport,
    category: RoleCategory.adminIT,
    nameEn: 'IT Support',
    nameAr: 'المسؤول التقني',
    descriptionEn: 'Technical system support and maintenance',
    descriptionAr: 'دعم وصيانة النظام التقني',
    hierarchyLevel: 1,
    permissions: {
      RolePermission.manageSystem,
      RolePermission.manageUsers,
      RolePermission.viewAuditLogs,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.financialAuditor: const RoleInfo(
    role: UserRole.financialAuditor,
    category: RoleCategory.adminIT,
    nameEn: 'Financial Auditor',
    nameAr: 'المراقب المالي',
    descriptionEn: 'Oversees financial records and invoices',
    descriptionAr: 'مراقبة السجلات المالية والفواتير',
    hierarchyLevel: 2,
    permissions: {
      RolePermission.manageFinances,
      RolePermission.viewAuditLogs,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.rector: const RoleInfo(
    role: UserRole.rector,
    category: RoleCategory.academicLeadership,
    nameEn: 'Rector / President',
    nameAr: 'مدير الجامعة',
    descriptionEn: 'University president with full academic oversight',
    descriptionAr: 'مدير الجامعة مع إشراف أكاديمي كامل',
    hierarchyLevel: 1,
    permissions: {
      RolePermission.manageColleges,
      RolePermission.manageDepartments,
      RolePermission.manageCourses,
      RolePermission.manageSchedules,
      RolePermission.approveEnrollments,
      RolePermission.viewAuditLogs,
      RolePermission.manageFinances,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.createAnnouncements,
    },
  ),

  UserRole.dean: const RoleInfo(
    role: UserRole.dean,
    category: RoleCategory.academicLeadership,
    nameEn: 'Dean',
    nameAr: 'عميد الكلية',
    descriptionEn: 'Head of a college/faculty',
    descriptionAr: 'رئيس كلية أو مجمع أكاديمي',
    hierarchyLevel: 2,
    permissions: {
      RolePermission.manageDepartments,
      RolePermission.manageCourses,
      RolePermission.manageSchedules,
      RolePermission.approveEnrollments,
      RolePermission.createAnnouncements,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.departmentHead: const RoleInfo(
    role: UserRole.departmentHead,
    category: RoleCategory.academicLeadership,
    nameEn: 'Department Head',
    nameAr: 'رئيس القسم',
    descriptionEn: 'Head of an academic department',
    descriptionAr: 'رئيس قسم أكاديمي',
    hierarchyLevel: 3,
    permissions: {
      RolePermission.manageCourses,
      RolePermission.manageSchedules,
      RolePermission.approveEnrollments,
      RolePermission.manageTAs,
      RolePermission.createAnnouncements,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.academicCoordinator: const RoleInfo(
    role: UserRole.academicCoordinator,
    category: RoleCategory.academicLeadership,
    nameEn: 'Academic Coordinator',
    nameAr: 'المنسق الأكاديمي',
    descriptionEn: 'Coordinates academic programs and scheduling',
    descriptionAr: 'تنسيق البرامج الأكاديمية والجداول',
    hierarchyLevel: 4,
    permissions: {
      RolePermission.manageCourses,
      RolePermission.manageSchedules,
      RolePermission.createAnnouncements,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.professor: const RoleInfo(
    role: UserRole.professor,
    category: RoleCategory.teachingStaff,
    nameEn: 'Professor / Instructor',
    nameAr: 'عضو هيئة تدريس',
    descriptionEn: 'Faculty member who teaches and manages courses',
    descriptionAr: 'عضو هيئة تدريس يقوم بالتدريس وإدارة المقررات',
    hierarchyLevel: 3,
    permissions: {
      RolePermission.manageGrades,
      RolePermission.manageAttendance,
      RolePermission.createAnnouncements,
      RolePermission.uploadMaterials,
      RolePermission.manageTAs,
      RolePermission.manageGroups,
      RolePermission.accessForums,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.lecturer: const RoleInfo(
    role: UserRole.lecturer,
    category: RoleCategory.teachingStaff,
    nameEn: 'Lecturer',
    nameAr: 'محاضر',
    descriptionEn: 'Teaches courses without full professor privileges',
    descriptionAr: 'يقوم بالتدريس بدون صلاحيات الأستاذ الكاملة',
    hierarchyLevel: 4,
    permissions: {
      RolePermission.manageGrades,
      RolePermission.manageAttendance,
      RolePermission.createAnnouncements,
      RolePermission.uploadMaterials,
      RolePermission.accessForums,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.teachingAssistant: const RoleInfo(
    role: UserRole.teachingAssistant,
    category: RoleCategory.teachingStaff,
    nameEn: 'Teaching Assistant',
    nameAr: 'معيد / مساعد باحث',
    descriptionEn: 'Assists professors with grading, labs, and tutorials',
    descriptionAr: 'يساعد الأساتذة في التصحيح والمعامل والتمارين',
    hierarchyLevel: 5,
    permissions: {
      RolePermission.manageAttendance,
      RolePermission.uploadMaterials,
      RolePermission.accessForums,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.registrarOfficer: const RoleInfo(
    role: UserRole.registrarOfficer,
    category: RoleCategory.studentAffairs,
    nameEn: 'Registrar Officer',
    nameAr: 'مشرف القبول والتسجيل',
    descriptionEn: 'Manages student enrollment and registration',
    descriptionAr: 'إدارة قبول وتسجيل الطلاب',
    hierarchyLevel: 3,
    permissions: {
      RolePermission.manageEnrollments,
      RolePermission.approveEnrollments,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.academicAdvisor: const RoleInfo(
    role: UserRole.academicAdvisor,
    category: RoleCategory.studentAffairs,
    nameEn: 'Academic Advisor',
    nameAr: 'المرشد الأكاديمي',
    descriptionEn: 'Guides students through academic planning',
    descriptionAr: 'يرشد الطلاب خلال التخطيط الأكاديمي',
    hierarchyLevel: 4,
    permissions: {
      RolePermission.adviseStudents,
      RolePermission.viewGrades,
      RolePermission.viewSchedule,
      RolePermission.viewAttendance,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.librarian: const RoleInfo(
    role: UserRole.librarian,
    category: RoleCategory.studentAffairs,
    nameEn: 'Librarian',
    nameAr: 'أمين المكتبة',
    descriptionEn: 'Manages library resources and materials',
    descriptionAr: 'إدارة الموارد والمواد المكتبية',
    hierarchyLevel: 4,
    permissions: {
      RolePermission.manageLibrary,
      RolePermission.uploadMaterials,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.freshman: const RoleInfo(
    role: UserRole.freshman,
    category: RoleCategory.studentRoles,
    nameEn: 'Freshman',
    nameAr: 'طالب مستجد',
    descriptionEn: 'First-year student with limited system access',
    descriptionAr: 'طالب في السنة الأولى مع صلاحيات محدودة',
    hierarchyLevel: 7,
    permissions: {
      RolePermission.viewGrades,
      RolePermission.viewSchedule,
      RolePermission.viewAttendance,
      RolePermission.enrollCourses,
      RolePermission.viewMaterials,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.regularStudent: const RoleInfo(
    role: UserRole.regularStudent,
    category: RoleCategory.studentRoles,
    nameEn: 'Regular Student',
    nameAr: 'طالب منتظم',
    descriptionEn: 'Full student with all standard academic privileges',
    descriptionAr: 'طالب منتظم مع جميع الصلاحيات الأكاديمية المعتادة',
    hierarchyLevel: 6,
    permissions: {
      RolePermission.viewGrades,
      RolePermission.viewSchedule,
      RolePermission.viewAttendance,
      RolePermission.enrollCourses,
      RolePermission.submitRatings,
      RolePermission.accessForums,
      RolePermission.viewMaterials,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.student: const RoleInfo(
    role: UserRole.student,
    category: RoleCategory.studentRoles,
    nameEn: 'Student',
    nameAr: 'طالب',
    descriptionEn: 'General student role',
    descriptionAr: 'طالب عام',
    hierarchyLevel: 7,
    permissions: {
      RolePermission.viewGrades,
      RolePermission.viewSchedule,
      RolePermission.viewAttendance,
      RolePermission.enrollCourses,
      RolePermission.viewMaterials,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.classRepresentative: const RoleInfo(
    role: UserRole.classRepresentative,
    category: RoleCategory.studentRoles,
    nameEn: 'Class Representative',
    nameAr: 'رئيس الدفعة',
    descriptionEn: 'Student leader who represents the class body',
    descriptionAr: 'قائد طلابي يمثل مجموعته الدراسية',
    hierarchyLevel: 5,
    permissions: {
      RolePermission.viewGrades,
      RolePermission.viewSchedule,
      RolePermission.viewAttendance,
      RolePermission.enrollCourses,
      RolePermission.submitRatings,
      RolePermission.accessForums,
      RolePermission.viewMaterials,
      RolePermission.createAnnouncements,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.alumni: const RoleInfo(
    role: UserRole.alumni,
    category: RoleCategory.studentRoles,
    nameEn: 'Alumni',
    nameAr: 'خريج',
    descriptionEn: 'Graduated student with limited access',
    descriptionAr: 'طالب خريج مع صلاحيات محدودة',
    hierarchyLevel: 8,
    permissions: {
      RolePermission.viewGrades,
      RolePermission.accessForums,
      RolePermission.viewMaterials,
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.viewJobBoard,
    },
  ),

  UserRole.dormSupervisor: const RoleInfo(
    role: UserRole.dormSupervisor,
    category: RoleCategory.facilitiesSecurity,
    nameEn: 'Dorm Supervisor',
    nameAr: 'مشرف السكن',
    descriptionEn: 'Manages student dormitory operations',
    descriptionAr: 'إدارة عمليات السكن الطلابي',
    hierarchyLevel: 5,
    permissions: {
      RolePermission.viewProfile,
      RolePermission.editOwnProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.securityOfficer: const RoleInfo(
    role: UserRole.securityOfficer,
    category: RoleCategory.facilitiesSecurity,
    nameEn: 'Security Officer',
    nameAr: 'مسؤول الأمن',
    descriptionEn: 'Campus security and access control',
    descriptionAr: 'أمن الحرم الجامعي والتحكم في الدخول',
    hierarchyLevel: 5,
    permissions: {
      RolePermission.viewProfile,
      RolePermission.viewNotifications,
      RolePermission.submitSupportTicket,
    },
  ),

  UserRole.guest: const RoleInfo(
    role: UserRole.guest,
    category: RoleCategory.facilitiesSecurity,
    nameEn: 'Guest',
    nameAr: 'زائر',
    descriptionEn: 'Temporary visitor with minimal access',
    descriptionAr: 'زائر مؤقت مع صلاحيات محدودة',
    hierarchyLevel: 10,
    permissions: {RolePermission.viewProfile},
  ),

  UserRole.parent: const RoleInfo(
    role: UserRole.parent,
    category: RoleCategory.externalRoles,
    nameEn: 'Parent / Guardian',
    nameAr: 'ولي الأمر',
    descriptionEn: 'Can view linked student progress and grades',
    descriptionAr: 'يمكنه متابعة تقدم الطالب المرتبط ودرجاته',
    hierarchyLevel: 8,
    permissions: {
      RolePermission.viewStudentProgress,
      RolePermission.viewGrades,
      RolePermission.viewAttendance,
      RolePermission.viewProfile,
      RolePermission.viewNotifications,
    },
  ),

  UserRole.recruiter: const RoleInfo(
    role: UserRole.recruiter,
    category: RoleCategory.externalRoles,
    nameEn: 'Recruiter',
    nameAr: 'جهة توظيف',
    descriptionEn: 'External recruitment organization',
    descriptionAr: 'جهة توظيف خارجية',
    hierarchyLevel: 9,
    permissions: {RolePermission.viewJobBoard, RolePermission.viewProfile},
  ),
};

extension UserRoleX on UserRole {
  RoleInfo get info => roleRegistry[this]!;

  String displayName({bool isArabic = false}) {
    switch (this) {
      case UserRole.superAdmin:
        return t.roles.names.super_admin;
      case UserRole.admin:
        return t.roles.names.admin;
      case UserRole.itSupport:
        return t.roles.names.it_support;
      case UserRole.financialAuditor:
        return t.roles.names.financial_auditor;
      case UserRole.rector:
        return t.roles.names.rector;
      case UserRole.dean:
        return t.roles.names.dean;
      case UserRole.departmentHead:
        return t.roles.names.department_head;
      case UserRole.academicCoordinator:
        return t.roles.names.academic_coordinator;
      case UserRole.professor:
        return t.roles.names.professor;
      case UserRole.lecturer:
        return t.roles.names.lecturer;
      case UserRole.teachingAssistant:
        return t.roles.names.teaching_assistant;
      case UserRole.registrarOfficer:
        return t.roles.names.registrar_officer;
      case UserRole.academicAdvisor:
        return t.roles.names.academic_advisor;
      case UserRole.librarian:
        return t.roles.names.librarian;
      case UserRole.freshman:
        return t.roles.names.freshman;
      case UserRole.regularStudent:
        return t.roles.names.regular_student;
      case UserRole.student:
        return t.roles.names.student;
      case UserRole.classRepresentative:
        return t.roles.names.class_representative;
      case UserRole.alumni:
        return t.roles.names.alumni;
      case UserRole.dormSupervisor:
        return t.roles.names.dorm_supervisor;
      case UserRole.securityOfficer:
        return t.roles.names.security_officer;
      case UserRole.guest:
        return t.roles.names.guest;
      case UserRole.parent:
        return t.roles.names.parent;
      case UserRole.recruiter:
        return t.roles.names.recruiter;
    }
  }

  String description({bool isArabic = false}) {
    switch (this) {
      case UserRole.superAdmin:
        return t.roles.descriptions.super_admin;
      case UserRole.admin:
        return t.roles.descriptions.admin;
      case UserRole.itSupport:
        return t.roles.descriptions.it_support;
      case UserRole.financialAuditor:
        return t.roles.descriptions.financial_auditor;
      case UserRole.rector:
        return t.roles.descriptions.rector;
      case UserRole.dean:
        return t.roles.descriptions.dean;
      case UserRole.departmentHead:
        return t.roles.descriptions.department_head;
      case UserRole.academicCoordinator:
        return t.roles.descriptions.academic_coordinator;
      case UserRole.professor:
        return t.roles.descriptions.professor;
      case UserRole.lecturer:
        return t.roles.descriptions.lecturer;
      case UserRole.teachingAssistant:
        return t.roles.descriptions.teaching_assistant;
      case UserRole.registrarOfficer:
        return t.roles.descriptions.registrar_officer;
      case UserRole.academicAdvisor:
        return t.roles.descriptions.academic_advisor;
      case UserRole.librarian:
        return t.roles.descriptions.librarian;
      case UserRole.freshman:
        return t.roles.descriptions.freshman;
      case UserRole.regularStudent:
        return t.roles.descriptions.regular_student;
      case UserRole.student:
        return t.roles.descriptions.student;
      case UserRole.classRepresentative:
        return t.roles.descriptions.class_representative;
      case UserRole.alumni:
        return t.roles.descriptions.alumni;
      case UserRole.dormSupervisor:
        return t.roles.descriptions.dorm_supervisor;
      case UserRole.securityOfficer:
        return t.roles.descriptions.security_officer;
      case UserRole.guest:
        return t.roles.descriptions.guest;
      case UserRole.parent:
        return t.roles.descriptions.parent;
      case UserRole.recruiter:
        return t.roles.descriptions.recruiter;
    }
  }

  RoleCategory get category => info.category;

  bool hasPermission(RolePermission permission) =>
      info.permissions.contains(permission);

  bool get isAdmin =>
      this == UserRole.superAdmin ||
      this == UserRole.admin ||
      this == UserRole.itSupport ||
      this == UserRole.financialAuditor;

  bool get isLeadership => category == RoleCategory.academicLeadership;

  bool get isTeachingStaff => category == RoleCategory.teachingStaff;

  bool get isStudent => category == RoleCategory.studentRoles;

  bool get isStaff =>
      category == RoleCategory.adminIT ||
      category == RoleCategory.academicLeadership ||
      category == RoleCategory.teachingStaff ||
      category == RoleCategory.studentAffairs;

  String toDbString() {
    return name
        .replaceAllMapped(
          RegExp(r'(?<=[a-z])[A-Z]'),
          (match) => '_${match.group(0)!.toLowerCase()}',
        )
        .toLowerCase();
  }

  static UserRole fromDbString(String value) {
    final camel = value.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (match) => match.group(1)!.toUpperCase(),
    );
    return UserRole.values.firstWhere(
      (r) => r.name == camel,
      orElse: () => UserRole.guest,
    );
  }
}

extension UserRolesX on List<UserRole> {
  bool get containsAcademicStaff => any((r) => r.isTeachingStaff);
  bool get containsAdmin => any((r) => r.isAdmin);

  UserRole get primaryRole => isNotEmpty ? first : UserRole.guest;
}

extension RoleCategoryX on RoleCategory {
  List<UserRole> get roles =>
      UserRole.values.where((r) => r.category == this).toList();

  String displayName({bool isArabic = false}) {
    switch (this) {
      case RoleCategory.adminIT:
        return t.roles.categories.admin_it;
      case RoleCategory.academicLeadership:
        return t.roles.categories.academic_leadership;
      case RoleCategory.teachingStaff:
        return t.roles.categories.teaching_staff;
      case RoleCategory.studentAffairs:
        return t.roles.categories.student_affairs;
      case RoleCategory.studentRoles:
        return t.roles.categories.student_roles;
      case RoleCategory.facilitiesSecurity:
        return t.roles.categories.facilities_security;
      case RoleCategory.externalRoles:
        return t.roles.categories.external_roles;
    }
  }
}