part of 'roles.dart';

extension UserRoleX on UserRole {
  RoleInfo get info => roleRegistry[this]!;

  String displayName({bool isArabic = false}) {
    switch (this) {
      case UserRole.rector:
        return t.roles.names.rector;
      case UserRole.dean:
        return t.roles.names.dean;
      case UserRole.departmentHead:
        return t.roles.names.department_head;
      case UserRole.assistantHod:
        return 'Assistant Head of Department';
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
      case UserRole.rector:
        return t.roles.descriptions.rector;
      case UserRole.dean:
        return t.roles.descriptions.dean;
      case UserRole.departmentHead:
        return t.roles.descriptions.department_head;
      case UserRole.assistantHod:
        return 'Assists the head of an academic department';
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

  bool get isLeadership => category == RoleCategory.academicLeadership;

  bool get isTeachingStaff => category == RoleCategory.teachingStaff;

  bool get isStudent => category == RoleCategory.studentRoles;

  bool get isStaff =>
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

  static UserRole? tryFromDbString(String value) {
    final camel = value.replaceAllMapped(
      RegExp(r'_([a-z])'),
      (match) => match.group(1)!.toUpperCase(),
    );
    for (final role in UserRole.values) {
      if (role.name == camel) return role;
    }
    return null;
  }

  static UserRole fromDbString(String value) {
    return tryFromDbString(value) ??
        (throw FormatException('Unknown database role: $value'));
  }
}

extension RolePermissionX on RolePermission {
  String get code => switch (this) {
    RolePermission.manageColleges => 'colleges.manage',
    RolePermission.manageDepartments => 'departments.manage',
    RolePermission.manageCourses => 'courses.manage',
    RolePermission.manageSchedules => 'schedules.manage',
    RolePermission.approveEnrollments => 'registration.review',
    RolePermission.manageGrades => 'grades.manage',
    RolePermission.manageAttendance => 'attendance.manage',
    RolePermission.createAnnouncements => 'announcements.create',
    RolePermission.createPost => 'posts.create',
    RolePermission.uploadMaterials => 'materials.upload',
    RolePermission.manageTAs => 'teaching_assistants.manage',
    RolePermission.manageGroups => 'groups.manage',
    RolePermission.manageEnrollments => 'registration.manage',
    RolePermission.adviseStudents => 'students.advise',
    RolePermission.assignAdvisors => 'students.assign_advisor',
    RolePermission.manageLibrary => 'library.manage',
    RolePermission.viewFinance => 'finance.read',
    RolePermission.viewGrades => 'grades.read',
    RolePermission.viewSchedule => 'schedule.read',
    RolePermission.viewAttendance => 'attendance.read',
    RolePermission.enrollCourses => 'courses.enroll',
    RolePermission.submitRatings => 'ratings.submit',
    RolePermission.accessForums => 'forums.access',
    RolePermission.viewMaterials => 'materials.read',
    RolePermission.viewStudentProgress => 'students.progress.read',
    RolePermission.viewJobBoard => 'jobs.read',
    RolePermission.viewProfile => 'profiles.read',
    RolePermission.editOwnProfile => 'profiles.self_edit',
    RolePermission.viewNotifications => 'notifications.read',
    RolePermission.submitSupportTicket => 'support.submit',
  };
}

extension UserRolesX on List<UserRole> {
  bool get containsAcademicStaff => any((r) => r.isTeachingStaff);

  UserRole get primaryRole => isNotEmpty ? first : UserRole.guest;
}

extension RoleCategoryX on RoleCategory {
  List<UserRole> get roles =>
      UserRole.values.where((r) => r.category == this).toList();

  String displayName({bool isArabic = false}) {
    switch (this) {
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
