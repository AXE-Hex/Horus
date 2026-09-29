import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/data/db_row.dart';

class Course {
  final String id;
  final String code;
  final String name;
  final String? nameAr;
  final String? description;
  final int credits;
  final String departmentId;
  final List<CoursePrerequisite> prerequisites;
  final bool isActive;

  Course({
    required this.id,
    required this.code,
    required this.name,
    this.nameAr,
    this.description,
    required this.credits,
    required this.departmentId,
    this.prerequisites = const [],
    this.isActive = true,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'courses');
    return Course(
      id: row.requiredString('id'),
      code: row.requiredString('code'),
      name: row.requiredString('name_en'),
      nameAr: row.optionalString('name_ar'),
      description: row.optionalString('description'),
      credits: row.requiredInt('credit_hours'),
      departmentId: row.requiredString('department_id'),
      prerequisites: row
          .rowsOrEmpty('course_prerequisites')
          .map(
            (prerequisite) => CoursePrerequisite.fromJson(prerequisite.values),
          )
          .toList(),
      isActive: row.boolOr('is_active', true),
    );
  }
}

class CoursePrerequisite {
  final String courseId;
  final String code;
  final String nameEn;
  final String? nameAr;
  final double minimumGrade;

  const CoursePrerequisite({
    required this.courseId,
    required this.code,
    required this.nameEn,
    this.nameAr,
    required this.minimumGrade,
  });

  factory CoursePrerequisite.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'course_prerequisites');
    final course = row.optionalRow('prerequisite_course');
    if (course == null) {
      throw const FormatException(
        'course_prerequisites.prerequisite_course is required',
      );
    }
    return CoursePrerequisite(
      courseId: course.requiredString('id'),
      code: course.requiredString('code'),
      nameEn: course.requiredString('name_en'),
      nameAr: course.optionalString('name_ar'),
      minimumGrade: row.requiredDouble('minimum_grade'),
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
    final row = DbRow(json, context: 'course_sections');
    return CourseSection(
      id: row.requiredString('id'),
      courseId: row.requiredString('course_id'),
      name: row.requiredString('name'),
      semester: row.requiredString('semester'),
      maxStudents: row.intOr('max_students', 50),
      createdAt: row.requiredDateTime('created_at'),
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
    final row = DbRow(json, context: 'course_sub_sections');
    return CourseSubSection(
      id: row.requiredString('id'),
      sectionId: row.requiredString('section_id'),
      name: row.requiredString('name'),
      maxStudents: row.intOr('max_students', 25),
      createdAt: row.requiredDateTime('created_at'),
    );
  }
}

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  unknown,
}

class ScheduleOption {
  const ScheduleOption({
    required this.id,
    required this.courseId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.semester,
    this.room,
    this.building,
    this.sectionName,
    this.subSectionName,
  });

  final String id;
  final String courseId;
  final Weekday day;
  final String startTime;
  final String endTime;
  final String semester;
  final String? room;
  final String? building;
  final String? sectionName;
  final String? subSectionName;

  factory ScheduleOption.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'schedules');
    return ScheduleOption(
      id: row.requiredString('id'),
      courseId: row.requiredString('course_id'),
      day: Weekday.values.firstWhere(
        (value) => value.name == row.optionalString('day'),
        orElse: () => Weekday.unknown,
      ),
      startTime: row.requiredString('start_time'),
      endTime: row.requiredString('end_time'),
      semester: row.requiredString('semester'),
      room: row.optionalString('room'),
      building: row.optionalString('building'),
      sectionName: row.optionalString('section_name'),
      subSectionName: row.optionalString('sub_section_name'),
    );
  }
}

class CompletedCourseGrade {
  const CompletedCourseGrade({this.total, this.courseCode});

  final double? total;
  final String? courseCode;

  factory CompletedCourseGrade.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'grades');
    final course = row.optionalRow('courses');
    return CompletedCourseGrade(
      total: row.optionalDouble('total'),
      courseCode: course?.optionalString('code'),
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
    final row = DbRow(json, context: 'student_course_registrations');
    return StudentRegistration(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      semester: row.requiredString('semester'),
      sectionName: row.requiredString('section_name'),
      subSectionName: row.requiredString('sub_section_name'),
      registeredAt: row.requiredDateTime('registered_at'),
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
    final row = DbRow(json, context: 'student_course_registrations');
    final course = row.optionalRow('courses');
    return StudentCourseRegistration(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      courseId: row.requiredString('course_id'),
      semester: row.requiredString('semester'),
      sectionName: row.optionalString('section_name'),
      subSectionName: row.optionalString('sub_section_name'),
      registeredAt: row.requiredDateTime('registered_at'),
      course: course == null ? null : Course.fromJson(course.values),
    );
  }
}

enum RegistrationStatus { pending, approved, rejected, withdrawn, unknown }

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
      case RegistrationStatus.unknown:
        return LocaleSettings
            .instance
            .currentTranslations
            .enrollment
            .pending_review;
    }
  }

  static RegistrationStatus fromString(String s) {
    return RegistrationStatus.values.firstWhere(
      (e) => e.name == s,
      orElse: () => RegistrationStatus.unknown,
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
    final row = DbRow(json, context: 'registration_request_courses');
    final courseRow = row.optionalRow('courses');
    return RegistrationRequestCourse(
      id: row.requiredString('id'),
      requestId: row.requiredString('request_id'),
      courseId: row.requiredString('course_id'),
      sectionName: row.optionalString('section_name'),
      subSectionName: row.optionalString('sub_section_name'),
      course: courseRow == null ? null : Course.fromJson(courseRow.values),
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
    final row = DbRow(json, context: 'advisor profile');
    return AdvisorInfo(
      id: row.requiredString('id'),
      fullName: row.optionalString('full_name') ?? '',
      email: row.optionalString('email') ?? '',
      avatarUrl: row.optionalString('avatar_url'),
    );
  }
}

class AdvisorStudent {
  const AdvisorStudent({
    required this.id,
    required this.fullName,
    required this.email,
    required this.studentNumber,
    required this.advisorId,
    required this.avatarUrl,
    required this.departmentId,
    required this.collegeId,
  });

  final String id;
  final String fullName;
  final String email;
  final String? studentNumber;
  final String? advisorId;
  final String? avatarUrl;
  final String? departmentId;
  final String? collegeId;

  factory AdvisorStudent.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'get_advisor_directory');
    return AdvisorStudent(
      id: row.requiredString('id'),
      fullName: row.requiredString('full_name'),
      email: row.requiredString('email'),
      studentNumber: row.optionalString('student_id'),
      advisorId: row.optionalString('advisor_id'),
      avatarUrl: row.optionalString('avatar_url'),
      departmentId: row.optionalString('department_id'),
      collegeId: row.optionalString('college_id'),
    );
  }
}

class RegistrationCourseSelection {
  const RegistrationCourseSelection({
    required this.courseId,
    this.sectionName,
    this.subSectionName,
  });

  final String courseId;
  final String? sectionName;
  final String? subSectionName;
}

enum EnrollmentStatus {
  pending,
  approved,
  rejected,
  withdrawn,
  cancelled,
  unknown,
}

class EnrollmentRecord {
  const EnrollmentRecord({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.status,
    required this.semester,
    required this.enrolledAt,
    required this.createdAt,
    required this.updatedAt,
    this.semesterId,
    this.approvedAt,
    this.course,
  });

  final String id;
  final String studentId;
  final String courseId;
  final EnrollmentStatus status;
  final String semester;
  final String? semesterId;
  final DateTime enrolledAt;
  final DateTime? approvedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Course? course;

  factory EnrollmentRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'enrollments');
    final courseRow = row.optionalRow('courses');
    return EnrollmentRecord(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      courseId: row.requiredString('course_id'),
      status: EnrollmentStatus.values.firstWhere(
        (value) => value.name == row.optionalString('status'),
        orElse: () => EnrollmentStatus.unknown,
      ),
      semester: row.requiredString('semester'),
      semesterId: row.optionalString('semester_id'),
      enrolledAt: row.requiredDateTime('enrolled_at'),
      approvedAt: row.optionalDateTime('approved_at'),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
      course: courseRow == null ? null : Course.fromJson(courseRow.values),
    );
  }
}

class EnrollmentDraft {
  const EnrollmentDraft({
    required this.studentId,
    required this.courseId,
    required this.semester,
    this.status = EnrollmentStatus.pending,
  });

  final String studentId;
  final String courseId;
  final String semester;
  final EnrollmentStatus status;

  Map<String, dynamic> toDatabase() {
    if (status == EnrollmentStatus.unknown) {
      throw StateError('Unknown enrollment status cannot be written.');
    }
    return {
      'student_id': studentId,
      'course_id': courseId,
      'semester': semester,
      'status': status.name,
    };
  }
}

class StudentProfileSummary {
  const StudentProfileSummary({this.fullName, this.studentNumber});

  final String? fullName;
  final String? studentNumber;

  factory StudentProfileSummary.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'registration request student');
    return StudentProfileSummary(
      fullName: row.optionalString('full_name'),
      studentNumber: row.optionalString('student_id'),
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
  final StudentProfileSummary? studentProfile;

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
    final row = DbRow(json, context: 'registration_requests');
    final coursesList = row
        .rowsOrEmpty('registration_request_courses')
        .map((c) => RegistrationRequestCourse.fromJson(c.values))
        .toList();
    final advisorRow = row.optionalRow('advisor');
    final studentRow = row.optionalRow('student');

    return RegistrationRequest(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      advisorId: row.optionalString('advisor_id'),
      semester: row.requiredString('semester'),
      status: RegistrationStatusX.fromString(
        row.optionalString('status') ?? 'pending',
      ),
      advisorNotes: row.optionalString('advisor_notes'),
      submittedAt: row.requiredDateTime('submitted_at'),
      reviewedAt: row.optionalDateTime('reviewed_at'),
      courses: coursesList,
      advisor: advisorRow != null
          ? AdvisorInfo.fromJson(advisorRow.values)
          : null,
      studentProfile: studentRow == null
          ? null
          : StudentProfileSummary.fromJson(studentRow.values),
    );
  }
}
