import 'package:horus/core/data/db_row.dart';

class AcademicSemester {
  const AcademicSemester({
    required this.code,
    required this.nameEn,
    this.nameAr,
  });

  final String code;
  final String nameEn;
  final String? nameAr;

  factory AcademicSemester.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'semesters');
    return AcademicSemester(
      code: row.requiredString('code'),
      nameEn: row.requiredString('name_en'),
      nameAr: row.optionalString('name_ar'),
    );
  }
}

class GradeCourseSummary {
  const GradeCourseSummary({
    required this.creditHours,
    this.code,
    this.nameEn,
    this.nameAr,
  });

  final int? creditHours;
  final String? code;
  final String? nameEn;
  final String? nameAr;

  factory GradeCourseSummary.fromRow(DbRow row) => GradeCourseSummary(
    creditHours: row['credit_hours'] == null
        ? null
        : row.requiredInt('credit_hours'),
    code: row.optionalString('code'),
    nameEn: row.optionalString('name_en'),
    nameAr: row.optionalString('name_ar'),
  );
}

class GradeRecord {
  const GradeRecord({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.semester,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    this.semesterId,
    this.coursework,
    this.midterm,
    this.practical,
    this.finalExam,
    this.total,
    this.gradeLetter,
    this.gpaPoints,
    this.publishedAt,
    this.course,
  });

  final String id;
  final String studentId;
  final String courseId;
  final String semester;
  final String? semesterId;
  final double? coursework;
  final double? midterm;
  final double? practical;
  final double? finalExam;
  final double? total;
  final String? gradeLetter;
  final double? gpaPoints;
  final bool isPublished;
  final DateTime? publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GradeCourseSummary? course;

  factory GradeRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'grades');
    final courseRow = row.optionalRow('courses');
    return GradeRecord(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      courseId: row.requiredString('course_id'),
      semester: row.requiredString('semester'),
      semesterId: row.optionalString('semester_id'),
      coursework: row.optionalDouble('coursework'),
      midterm: row.optionalDouble('midterm'),
      practical: row.optionalDouble('practical'),
      finalExam: row.optionalDouble('final_exam'),
      total: row.optionalDouble('total'),
      gradeLetter: row.optionalString('grade_letter'),
      gpaPoints: row.optionalDouble('gpa_points'),
      isPublished: row.boolOr('is_published', false),
      publishedAt: row.optionalDateTime('published_at'),
      createdAt: row.requiredDateTime('created_at'),
      updatedAt: row.requiredDateTime('updated_at'),
      course: courseRow == null ? null : GradeCourseSummary.fromRow(courseRow),
    );
  }
}

class GradeSubmission {
  const GradeSubmission({
    required this.studentId,
    required this.courseId,
    required this.semester,
    this.semesterId,
    this.coursework,
    this.midterm,
    this.practical,
    this.finalExam,
  });

  final String studentId;
  final String courseId;
  final String semester;
  final String? semesterId;
  final double? coursework;
  final double? midterm;
  final double? practical;
  final double? finalExam;

  Map<String, dynamic> toDatabase() => {
    'student_id': studentId,
    'course_id': courseId,
    'semester': semester,
    'semester_id': semesterId,
    'coursework': coursework,
    'midterm': midterm,
    'practical': practical,
    'final_exam': finalExam,
  };
}

enum AttendanceStatus { present, absent, late, excused, unknown }

extension AttendanceStatusX on AttendanceStatus {
  static AttendanceStatus fromDatabase(String? value) =>
      AttendanceStatus.values.firstWhere(
        (status) => status.name == value,
        orElse: () => AttendanceStatus.unknown,
      );

  String get databaseValue {
    if (this == AttendanceStatus.unknown) {
      throw StateError('Unknown attendance status cannot be written.');
    }
    return name;
  }
}

class AttendanceRecord {
  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.date,
    required this.status,
    required this.createdAt,
    this.notes,
    this.recordedBy,
    this.course,
  });

  final String id;
  final String studentId;
  final String courseId;
  final DateTime date;
  final AttendanceStatus status;
  final String? notes;
  final String? recordedBy;
  final DateTime createdAt;
  final GradeCourseSummary? course;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'attendance');
    return AttendanceRecord(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      courseId: row.requiredString('course_id'),
      date: row.requiredDateTime('date'),
      status: AttendanceStatusX.fromDatabase(row.optionalString('status')),
      notes: row.optionalString('notes'),
      recordedBy: row.optionalString('recorded_by'),
      createdAt: row.requiredDateTime('created_at'),
      course: row.optionalRow('courses') == null
          ? null
          : GradeCourseSummary.fromRow(row.optionalRow('courses')!),
    );
  }
}

class AttendanceSubmission {
  const AttendanceSubmission({
    required this.studentId,
    required this.courseId,
    required this.date,
    required this.status,
    this.notes,
  });

  final String studentId;
  final String courseId;
  final DateTime date;
  final AttendanceStatus status;
  final String? notes;

  Map<String, dynamic> toDatabase() => {
    'student_id': studentId,
    'course_id': courseId,
    'date': date.toIso8601String().substring(0, 10),
    'status': status.databaseValue,
    'notes': notes,
  };
}

enum ScheduleDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  unknown,
}

enum ScheduleType { lecture, lab, tutorial, online, unknown }

class CourseScheduleSummary {
  const CourseScheduleSummary({
    required this.nameEn,
    required this.nameAr,
    this.instructorName,
  });

  final String nameEn;
  final String? nameAr;
  final String? instructorName;

  factory CourseScheduleSummary.fromRow(DbRow row) {
    final professor = row.optionalRow('professor');
    return CourseScheduleSummary(
      nameEn: row.requiredString('name_en'),
      nameAr: row.optionalString('name_ar'),
      instructorName: professor?.optionalString('full_name'),
    );
  }
}

class StudentScheduleRecord {
  const StudentScheduleRecord({
    required this.id,
    required this.courseId,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.scheduleType,
    this.room,
    this.building,
    this.sectionName,
    this.subSectionName,
    this.course,
  });

  final String id;
  final String courseId;
  final ScheduleDay day;
  final String startTime;
  final String endTime;
  final ScheduleType scheduleType;
  final String? room;
  final String? building;
  final String? sectionName;
  final String? subSectionName;
  final CourseScheduleSummary? course;

  factory StudentScheduleRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'schedules');
    final courseRow = row.optionalRow('courses');
    return StudentScheduleRecord(
      id: row.requiredString('id'),
      courseId: row.requiredString('course_id'),
      day: ScheduleDay.values.firstWhere(
        (value) => value.name == row.optionalString('day'),
        orElse: () => ScheduleDay.unknown,
      ),
      startTime: row.requiredString('start_time'),
      endTime: row.requiredString('end_time'),
      scheduleType: ScheduleType.values.firstWhere(
        (value) => value.name == row.optionalString('schedule_type'),
        orElse: () => ScheduleType.unknown,
      ),
      room: row.optionalString('room'),
      building: row.optionalString('building'),
      sectionName: row.optionalString('section_name'),
      subSectionName: row.optionalString('sub_section_name'),
      course: courseRow == null
          ? null
          : CourseScheduleSummary.fromRow(courseRow),
    );
  }
}

enum ActionPlanStatus { planned, enrolled, passed, failed, withdrawn, unknown }

class ActionPlanItemRecord {
  const ActionPlanItemRecord({
    required this.id,
    required this.studentId,
    required this.semester,
    required this.year,
    required this.status,
    required this.createdAt,
    this.courseId,
    this.semesterId,
    this.gradeLetter,
    this.notes,
    this.courseName,
  });

  final String id;
  final String studentId;
  final String semester;
  final int year;
  final ActionPlanStatus status;
  final DateTime createdAt;
  final String? courseId;
  final String? semesterId;
  final String? gradeLetter;
  final String? notes;
  final String? courseName;

  factory ActionPlanItemRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'action_plan_items');
    final course = row.optionalRow('courses');
    return ActionPlanItemRecord(
      id: row.requiredString('id'),
      studentId: row.requiredString('student_id'),
      semester: row.requiredString('semester'),
      year: row.requiredInt('year'),
      status: row.enumValue(
        'status',
        ActionPlanStatus.values,
        ActionPlanStatus.unknown,
      ),
      createdAt: row.requiredDateTime('created_at'),
      courseId: row.optionalString('course_id'),
      semesterId: row.optionalString('semester_id'),
      gradeLetter: row.optionalString('grade_letter'),
      notes: row.optionalString('notes'),
      courseName: course?.optionalString('name_en'),
    );
  }
}

enum ExamType { midterm, finalExam, quiz, makeup, unknown }

class ExamScheduleRecord {
  const ExamScheduleRecord({
    required this.id,
    required this.courseId,
    required this.examType,
    required this.examDate,
    required this.startTime,
    required this.endTime,
    required this.semester,
    required this.createdAt,
    this.room,
    this.building,
    this.notes,
    this.courseCode,
    this.courseName,
  });

  final String id;
  final String courseId;
  final ExamType examType;
  final DateTime examDate;
  final String startTime;
  final String endTime;
  final String semester;
  final DateTime createdAt;
  final String? room;
  final String? building;
  final String? notes;
  final String? courseCode;
  final String? courseName;

  factory ExamScheduleRecord.fromJson(Map<String, dynamic> json) {
    final row = DbRow(json, context: 'exam_schedules');
    final course = row.optionalRow('courses');
    return ExamScheduleRecord(
      id: row.requiredString('id'),
      courseId: row.requiredString('course_id'),
      examType: switch (row.optionalString('exam_type')) {
        'midterm' => ExamType.midterm,
        'final' => ExamType.finalExam,
        'quiz' => ExamType.quiz,
        'makeup' => ExamType.makeup,
        _ => ExamType.unknown,
      },
      examDate: row.requiredDateTime('exam_date'),
      startTime: row.requiredString('start_time'),
      endTime: row.requiredString('end_time'),
      semester: row.requiredString('semester'),
      createdAt: row.requiredDateTime('created_at'),
      room: row.optionalString('room'),
      building: row.optionalString('building'),
      notes: row.optionalString('notes'),
      courseCode: course?.optionalString('code'),
      courseName: course?.optionalString('name_en'),
    );
  }
}
