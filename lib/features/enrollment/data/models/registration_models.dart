import 'package:hue/core/i18n/strings.g.dart';

class Course {
  final String id;
  final String code;
  final String name;
  final String? nameAr;
  final String? description;
  final String? descriptionAr;
  final int credits;
  final String departmentId;
  final List<String> prerequisites;
  final bool isActive;

  Course({
    required this.id,
    required this.code,
    required this.name,
    this.nameAr,
    this.description,
    this.descriptionAr,
    required this.credits,
    required this.departmentId,
    this.prerequisites = const [],
    this.isActive = true,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      nameAr: json['name_ar'],
      description: json['description'],
      descriptionAr: json['description_ar'],
      credits: json['credits'] ?? json['credit_hours'] ?? 3,
      departmentId: json['department_id'] ?? '',
      prerequisites: List<String>.from(json['prerequisites'] ?? []),
      isActive: json['is_active'] ?? true,
    );
  }
}

class CourseSection {
  final String id;
  final String courseId;
  final String name;
  final String semester;
  final int maxStudents;
  final DateTime createdAt;

  CourseSection({
    required this.id,
    required this.courseId,
    required this.name,
    required this.semester,
    required this.maxStudents,
    required this.createdAt,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) {
    return CourseSection(
      id: json['id'],
      courseId: json['course_id'],
      name: json['name'],
      semester: json['semester'],
      maxStudents: json['max_students'] ?? 50,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class CourseSubSection {
  final String id;
  final String sectionId;
  final String name;
  final int maxStudents;
  final DateTime createdAt;

  CourseSubSection({
    required this.id,
    required this.sectionId,
    required this.name,
    required this.maxStudents,
    required this.createdAt,
  });

  factory CourseSubSection.fromJson(Map<String, dynamic> json) {
    return CourseSubSection(
      id: json['id'],
      sectionId: json['section_id'],
      name: json['name'],
      maxStudents: json['max_students'] ?? 25,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class StudentRegistration {
  final String id;
  final String studentId;
  final String semester;
  final String sectionName;
  final String subSectionName;
  final DateTime registeredAt;

  StudentRegistration({
    required this.id,
    required this.studentId,
    required this.semester,
    required this.sectionName,
    required this.subSectionName,
    required this.registeredAt,
  });

  factory StudentRegistration.fromJson(Map<String, dynamic> json) {
    return StudentRegistration(
      id: json['id'],
      studentId: json['student_id'],
      semester: json['semester'],
      sectionName: json['section_name'],
      subSectionName: json['sub_section_name'],
      registeredAt: DateTime.parse(json['registered_at']),
    );
  }
}

class StudentCourseRegistration {
  final String id;
  final String studentId;
  final String courseId;
  final String semester;
  final String? sectionName;
  final String? subSectionName;
  final DateTime registeredAt;
  final Course? course;

  StudentCourseRegistration({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.semester,
    this.sectionName,
    this.subSectionName,
    required this.registeredAt,
    this.course,
  });

  factory StudentCourseRegistration.fromJson(Map<String, dynamic> json) {
    return StudentCourseRegistration(
      id: json['id'],
      studentId: json['student_id'],
      courseId: json['course_id'],
      semester: json['semester'],
      sectionName: json['section_name'],
      subSectionName: json['sub_section_name'],
      registeredAt: DateTime.parse(json['registered_at']),
      course: json['courses'] != null ? Course.fromJson(json['courses']) : null,
    );
  }
}

// ──────────────────────────────────────────────
// ADVISOR WORKFLOW MODELS
// ──────────────────────────────────────────────

enum RegistrationStatus { pending, approved, rejected, withdrawn }

extension RegistrationStatusX on RegistrationStatus {
  String get dbValue => name;

  String label({bool isArabic = false}) {
    switch (this) {
      case RegistrationStatus.pending:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .pending_review;
      case RegistrationStatus.approved:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .approved_1;
      case RegistrationStatus.rejected:
        return LocaleSettings.instance.currentTranslations.enrollment.rejected;
      case RegistrationStatus.withdrawn:
        return LocaleSettings.instance.currentTranslations.enrollment.withdrawn;
    }
  }

  static RegistrationStatus fromString(String s) {
    return RegistrationStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => RegistrationStatus.pending,
    );
  }
}

class RegistrationRequestCourse {
  final String id;
  final String requestId;
  final String courseId;
  final String? sectionName;
  final String? subSectionName;
  final Course? course;

  RegistrationRequestCourse({
    required this.id,
    required this.requestId,
    required this.courseId,
    this.sectionName,
    this.subSectionName,
    this.course,
  });

  factory RegistrationRequestCourse.fromJson(Map<String, dynamic> json) {
    return RegistrationRequestCourse(
      id: json['id'],
      requestId: json['request_id'],
      courseId: json['course_id'],
      sectionName: json['section_name'],
      subSectionName: json['sub_section_name'],
      course: json['courses'] != null ? Course.fromJson(json['courses']) : null,
    );
  }
}

class AdvisorInfo {
  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;

  AdvisorInfo({
    required this.id,
    required this.fullName,
    required this.email,
    this.avatarUrl,
  });

  factory AdvisorInfo.fromJson(Map<String, dynamic> json) {
    return AdvisorInfo(
      id: json['id'],
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatar_url'],
    );
  }
}

class RegistrationRequest {
  final String id;
  final String studentId;
  final String? advisorId;
  final String semester;
  final RegistrationStatus status;
  final String? advisorNotes;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final List<RegistrationRequestCourse> courses;
  final AdvisorInfo? advisor;
  final Map<String, dynamic>? studentProfile;

  RegistrationRequest({
    required this.id,
    required this.studentId,
    this.advisorId,
    required this.semester,
    required this.status,
    this.advisorNotes,
    required this.submittedAt,
    this.reviewedAt,
    this.courses = const [],
    this.advisor,
    this.studentProfile,
  });

  bool get isPending => status == RegistrationStatus.pending;
  bool get isApproved => status == RegistrationStatus.approved;
  bool get isRejected => status == RegistrationStatus.rejected;

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) {
    final coursesList = (json['registration_request_courses'] as List? ?? [])
        .map((c) => RegistrationRequestCourse.fromJson(c))
        .toList();

    return RegistrationRequest(
      id: json['id'],
      studentId: json['student_id'],
      advisorId: json['advisor_id'],
      semester: json['semester'],
      status: RegistrationStatusX.fromString(json['status'] ?? 'pending'),
      advisorNotes: json['advisor_notes'],
      submittedAt: DateTime.parse(json['submitted_at']),
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'])
          : null,
      courses: coursesList,
      advisor: json['advisor'] != null
          ? AdvisorInfo.fromJson(json['advisor'])
          : null,
      studentProfile: json['student'] as Map<String, dynamic>?,
    );
  }
}
