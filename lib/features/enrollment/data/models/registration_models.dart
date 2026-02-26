
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
      credits: json['credits'] ?? 3,
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
