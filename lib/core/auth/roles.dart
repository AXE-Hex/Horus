import 'package:horus/core/i18n/strings.g.dart';

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
