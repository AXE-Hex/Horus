/// ╔══════════════════════════════════════════════════════════════════╗
/// ║               HUE University — Role & Permission System         ║
/// ╚══════════════════════════════════════════════════════════════════╝
///
/// Each role belongs to a [RoleCategory] and has a defined set of
/// [RolePermission]s. The system is hierarchical — higher-privilege
/// roles inherit the permissions of lower ones within the same category.

// ─────────────────────────────────────────────────
// 1. ROLE CATEGORIES
// ─────────────────────────────────────────────────

/// Top-level grouping for all roles in the system.
enum RoleCategory {
  adminIT,
  academicLeadership,
  teachingStaff,
  studentAffairs,
  studentRoles,
  facilitiesSecurity,
  externalRoles,
}

// ─────────────────────────────────────────────────
// 2. USER ROLES (all 22 roles)
// ─────────────────────────────────────────────────

/// Every role in the HUE university system.
enum UserRole {
  // ── 1. Admin & IT ─────────────────────────────
  superAdmin,
  itSupport,
  financialAuditor,

  // ── 2. Academic Leadership ────────────────────
  rector,
  dean,
  departmentHead,
  academicCoordinator,

  // ── 3. Teaching Staff ─────────────────────────
  professor,
  lecturer,
  teachingAssistant,

  // ── 4. Student Affairs ────────────────────────
  registrarOfficer,
  academicAdvisor,
  librarian,

  // ── 5. Student Roles ──────────────────────────
  freshman,
  regularStudent,
  classRepresentative,
  alumni,

  // ── 6. Facilities & Security ──────────────────
  dormSupervisor,
  securityOfficer,
  guest,

  // ── 7. External Roles ─────────────────────────
  parent,
  recruiter,
}

// ─────────────────────────────────────────────────
// 3. PERMISSIONS
// ─────────────────────────────────────────────────

/// Fine-grained permissions that can be assigned to roles.
enum RolePermission {
  // System
  manageSystem,
  manageUsers,
  viewAuditLogs,
  manageFinances,

  // Academic Management
  manageColleges,
  manageDepartments,
  manageCourses,
  manageSchedules,
  approveEnrollments,

  // Teaching
  manageGrades,
  manageAttendance,
  createAnnouncements,
  uploadMaterials,
  manageTAs,
  manageGroups,

  // Student Affairs
  manageEnrollments,
  adviseStudents,
  manageLibrary,

  // Student
  viewGrades,
  viewSchedule,
  viewAttendance,
  enrollCourses,
  submitRatings,
  accessForums,
  viewMaterials,

  // External
  viewStudentProgress,
  viewJobBoard,

  // Shared
  viewProfile,
  editOwnProfile,
  viewNotifications,
  submitSupportTicket,
}

// ─────────────────────────────────────────────────
// 4. ROLE METADATA
// ─────────────────────────────────────────────────

/// Holds display info and permissions for a single role.
class RoleInfo {
  final UserRole role;
  final RoleCategory category;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final int hierarchyLevel; // lower = more privilege
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

// ─────────────────────────────────────────────────
// 5. ROLE REGISTRY
// ─────────────────────────────────────────────────

/// The complete registry of all roles with their metadata and permissions.
final Map<UserRole, RoleInfo> roleRegistry = {
  // ═══ 1. Admin & IT ════════════════════════════
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

  // ═══ 2. Academic Leadership ═══════════════════
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

  // ═══ 3. Teaching Staff ════════════════════════
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

  // ═══ 4. Student Affairs ═══════════════════════
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

  // ═══ 5. Student Roles ═════════════════════════
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

  // ═══ 6. Facilities & Security ═════════════════
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

  // ═══ 7. External Roles ════════════════════════
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

// ─────────────────────────────────────────────────
// 6. UTILITY EXTENSIONS
// ─────────────────────────────────────────────────

extension UserRoleX on UserRole {
  /// Get the [RoleInfo] metadata for this role.
  RoleInfo get info => roleRegistry[this]!;

  /// Localized display name (auto-selects based on [isArabic]).
  String displayName({bool isArabic = false}) =>
      isArabic ? info.nameAr : info.nameEn;

  /// Localized description.
  String description({bool isArabic = false}) =>
      isArabic ? info.descriptionAr : info.descriptionEn;

  /// The category this role belongs to.
  RoleCategory get category => info.category;

  /// Check if this role has a specific permission.
  bool hasPermission(RolePermission permission) =>
      info.permissions.contains(permission);

  /// Check if this role is any kind of admin.
  bool get isAdmin =>
      this == UserRole.superAdmin ||
      this == UserRole.itSupport ||
      this == UserRole.financialAuditor;

  /// Check if this role is academic leadership.
  bool get isLeadership => category == RoleCategory.academicLeadership;

  /// Check if this role is teaching staff.
  bool get isTeachingStaff => category == RoleCategory.teachingStaff;

  /// Check if this role is a student (any type).
  bool get isStudent => category == RoleCategory.studentRoles;

  /// Check if this role belongs to staff (non-student, non-external).
  bool get isStaff =>
      category == RoleCategory.adminIT ||
      category == RoleCategory.academicLeadership ||
      category == RoleCategory.teachingStaff ||
      category == RoleCategory.studentAffairs;

  /// Convert to database string (snake_case).
  String toDbString() {
    // Convert camelCase enum name to snake_case
    return name.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
  }

  /// Parse from database string.
  static UserRole fromDbString(String value) {
    // Convert snake_case to camelCase
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

/// Extension to get roles by category.
extension RoleCategoryX on RoleCategory {
  /// Get all roles in this category.
  List<UserRole> get roles =>
      UserRole.values.where((r) => r.category == this).toList();
      
  /// Localized category name.
  String displayName({bool isArabic = false}) {
    switch (this) {
      case RoleCategory.adminIT:
        return isArabic ? 'الإدارة والتقنية' : 'Admin & IT';
      case RoleCategory.academicLeadership:
        return isArabic ? 'القيادة الأكاديمية' : 'Academic Leadership';
      case RoleCategory.teachingStaff:
        return isArabic ? 'الكادر التعليمي' : 'Teaching Staff';
      case RoleCategory.studentAffairs:
        return isArabic ? 'الخدمات الطلابية' : 'Student Affairs';
      case RoleCategory.studentRoles:
        return isArabic ? 'رتب الطلاب' : 'Student Roles';
      case RoleCategory.facilitiesSecurity:
        return isArabic ? 'المرافق والأمن' : 'Facilities & Security';
      case RoleCategory.externalRoles:
        return isArabic ? 'الخبراء الخارجيين' : 'External Roles';
    }
  }
}
