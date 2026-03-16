class ProfessorProfile {
  final String id;
  final String name;
  final String role;
  final String department;
  final double generalRating;
  final double curriculumRating;
  final String email;
  final String officeSymbol;
  final String bio;

  final List<TeachingAssistant> teachingAssistants;
  final List<StudentGroup> groups;
  final List<ProfessorAnnouncement> announcements;
  final List<SharedFile> sharedFiles;
  final List<OfficeHour> officeHours;

  ProfessorProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.generalRating,
    required this.curriculumRating,
    required this.email,
    required this.officeSymbol,
    required this.bio,
    this.teachingAssistants = const [],
    this.groups = const [],
    this.announcements = const [],
    this.sharedFiles = const [],
    this.officeHours = const [],
  });
}

class TeachingAssistant {
  final String id;
  final String name;
  final String email;
  final String role;

  TeachingAssistant({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class StudentGroup {
  final String id;
  final String name;
  final String description;
  final int studentCount;
  final bool isJoined;

  StudentGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.studentCount,
    this.isJoined = false,
  });
}

class ProfessorAnnouncement {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final bool isUrgent;

  ProfessorAnnouncement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.isUrgent = false,
  });
}

class SharedFile {
  final String id;
  final String title;
  final String fileType;
  final String size;
  final DateTime uploadDate;

  SharedFile({
    required this.id,
    required this.title,
    required this.fileType,
    required this.size,
    required this.uploadDate,
  });
}

class OfficeHour {
  final String id;
  final String dayOfWeek;
  final String timeRange;
  final String location;
  final bool isWalkIn;

  OfficeHour({
    required this.id,
    required this.dayOfWeek,
    required this.timeRange,
    required this.location,
    this.isWalkIn = false,
  });
}


