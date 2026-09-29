import 'package:horus/core/i18n/strings.g.dart';

part 'role_registry.dart';
part 'role_extensions.dart';

enum RoleCategory {
  academicLeadership,
  teachingStaff,
  studentAffairs,
  studentRoles,
  facilitiesSecurity,
  externalRoles,
}

enum UserRole {
  rector,
  dean,
  departmentHead,
  assistantHod,
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
  manageColleges,
  manageDepartments,
  manageCourses,
  manageSchedules,
  approveEnrollments,

  manageGrades,
  manageAttendance,
  createAnnouncements,
  createPost,
  uploadMaterials,
  manageTAs,
  manageGroups,

  manageEnrollments,
  adviseStudents,
  assignAdvisors,
  manageLibrary,
  viewFinance,

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
