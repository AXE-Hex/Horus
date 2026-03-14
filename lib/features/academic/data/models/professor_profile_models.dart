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

final mockProfessorProfile = ProfessorProfile(
  id: 'dr_sarah_101',
  name: 'Prof. Sarah Miller',
  role: 'Head of Department',
  department: 'AI Systems',
  generalRating: 4.9,
  curriculumRating: 4.7,
  email: 'sarah.miller@university.edu',
  officeSymbol: 'AI-302',
  bio:
      'Ph.D. in Machine Learning from MIT. Lead researcher in Applied AI with 15+ years of teaching experience. Passionate about bringing practical industry problems into the classroom.',
  teachingAssistants: [
    TeachingAssistant(
      id: 'ta_1',
      name: 'Eng. Pam Beesly',
      email: 'pam.beesly@university.edu',
      role: 'Lead Lab Assistant',
    ),
    TeachingAssistant(
      id: 'ta_2',
      name: 'Eng. Ryan Howard',
      email: 'ryan.howard@university.edu',
      role: 'Grading Assistant',
    ),
  ],
  groups: [
    StudentGroup(
      id: 'grp_1',
      name: 'AI 301 - Section A',
      description: 'Main lecture group for Artificial Intelligence Principles.',
      studentCount: 45,
      isJoined: true,
    ),
    StudentGroup(
      id: 'grp_2',
      name: 'AI 301 - Lab B',
      description: 'Practical python implementation group.',
      studentCount: 22,
      isJoined: false,
    ),
  ],
  announcements: [
    ProfessorAnnouncement(
      id: 'ann_1',
      title: 'Midterm Exam Moved',
      content:
          'The midterm exam has been pushed back to next Tuesday. Please check the updated syllabus.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isUrgent: true,
    ),
    ProfessorAnnouncement(
      id: 'ann_2',
      title: 'Lab 3 Grades Posted',
      content:
          'Lab 3 grades are now available on the portal. Great job everyone!',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isUrgent: false,
    ),
  ],
  sharedFiles: [
    SharedFile(
      id: 'file_1',
      title: 'Updated Syllabus 2024',
      fileType: 'pdf',
      size: '2.4 MB',
      uploadDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
    SharedFile(
      id: 'file_2',
      title: 'Lecture 4: Neural Networks',
      fileType: 'pptx',
      size: '15.1 MB',
      uploadDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ],
  officeHours: [
    OfficeHour(
      id: 'oh_1',
      dayOfWeek: 'Monday',
      timeRange: '10:00 AM - 12:00 PM',
      location: 'Office AI-302',
      isWalkIn: true,
    ),
    OfficeHour(
      id: 'oh_2',
      dayOfWeek: 'Wednesday',
      timeRange: '02:00 PM - 04:00 PM',
      location: 'Lab 4',
      isWalkIn: false,
    ),
  ],
);

final globalFacultyTAs = [
  TeachingAssistant(
    id: 'ta_3',
    name: 'Eng. Dwight Schrute',
    email: 'dwight.schrute@university.edu',
    role: 'Senior Lab Assistant',
  ),
  TeachingAssistant(
    id: 'ta_4',
    name: 'Eng. Jim Halpert',
    email: 'jim.halpert@university.edu',
    role: 'Grading Assistant',
  ),
  TeachingAssistant(
    id: 'ta_5',
    name: 'Eng. Kelly Kapoor',
    email: 'kelly.kapoor@university.edu',
    role: 'Student Coordinator',
  ),
  TeachingAssistant(
    id: 'ta_6',
    name: 'Eng. Toby Flenderson',
    email: 'toby.flenderson@university.edu',
    role: 'Compliance Supervisor',
  ),
];
