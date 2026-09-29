import 'package:flutter_test/flutter_test.dart';
import 'package:horus/core/auth/rbac_records.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/enrollment/data/models/registration_models.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';

void main() {
  test('grade scores and nullable component fields map explicitly', () {
    final grade = GradeRecord.fromJson({
      'id': 'grade-1',
      'student_id': 'student-1',
      'course_id': 'course-1',
      'semester': '2026-1',
      'coursework': 21.5,
      'midterm': null,
      'practical': 18,
      'final_exam': null,
      'total': 72.5,
      'grade_letter': 'B',
      'gpa_points': 3,
      'is_published': false,
      'published_at': null,
      'created_at': '2026-01-02T03:04:05Z',
      'updated_at': '2026-01-02T03:04:05Z',
      'courses': {'credit_hours': 4},
    });

    expect(grade.coursework, 21.5);
    expect(grade.midterm, isNull);
    expect(grade.total, 72.5);
    expect(grade.course?.creditHours, 4);
    expect(grade.publishedAt, isNull);
    expect(
      () => GradeRecord.fromJson({'id': 'incomplete'}),
      throwsFormatException,
    );
  });

  test(
    'attendance status recognizes known values and quarantines unknowns',
    () {
      final row = {
        'id': 'attendance-1',
        'student_id': 'student-1',
        'course_id': 'course-1',
        'date': '2026-01-02',
        'status': 'late',
        'notes': null,
        'recorded_by': null,
        'created_at': '2026-01-02T03:04:05Z',
      };
      expect(AttendanceRecord.fromJson(row).status, AttendanceStatus.late);
      expect(
        AttendanceRecord.fromJson({...row, 'status': 'future_value'}).status,
        AttendanceStatus.unknown,
      );
      expect(
        () => AttendanceSubmission(
          studentId: 'student-1',
          courseId: 'course-1',
          date: DateTime(2026),
          status: AttendanceStatus.unknown,
        ).toDatabase(),
        throwsStateError,
      );
    },
  );

  test('student schedule rows map nested course and unknown enum values', () {
    final schedule = StudentScheduleRecord.fromJson({
      'id': 'schedule-1',
      'course_id': 'course-1',
      'day': 'monday',
      'start_time': '09:00:00',
      'end_time': '10:30:00',
      'schedule_type': 'lecture',
      'room': null,
      'building': null,
      'section_name': 'A',
      'sub_section_name': null,
      'courses': {
        'name_en': 'Databases',
        'name_ar': 'قواعد البيانات',
        'professor': {'full_name': 'Professor'},
      },
    });
    expect(schedule.day, ScheduleDay.monday);
    expect(schedule.scheduleType, ScheduleType.lecture);
    expect(schedule.course?.nameAr, 'قواعد البيانات');
    expect(schedule.course?.instructorName, 'Professor');
    expect(schedule.room, isNull);
    expect(
      StudentScheduleRecord.fromJson({
        'id': 'schedule-2',
        'course_id': 'course-1',
        'day': 'new_day',
        'start_time': '09:00:00',
        'end_time': '10:30:00',
        'schedule_type': 'future_type',
      }).scheduleType,
      ScheduleType.unknown,
    );
  });

  test('registration request maps nested student and selected course rows', () {
    final enrollment = EnrollmentRecord.fromJson({
      'id': 'enrollment-1',
      'student_id': 'student-1',
      'course_id': 'course-1',
      'semester': '2026-1',
      'status': 'approved',
      'semester_id': null,
      'enrolled_at': '2026-01-02T03:04:05Z',
      'approved_at': null,
      'created_at': '2026-01-02T03:04:05Z',
      'updated_at': '2026-01-02T03:04:05Z',
      'courses': {
        'id': 'course-1',
        'code': 'CS101',
        'name_en': 'Programming',
        'name_ar': 'برمجة',
        'credit_hours': 3,
        'department_id': 'department-1',
      },
    });
    expect(enrollment.status, EnrollmentStatus.approved);
    expect(enrollment.approvedAt, isNull);
    expect(enrollment.course?.name, 'Programming');

    final request = RegistrationRequest.fromJson({
      'id': 'request-1',
      'student_id': 'student-1',
      'advisor_id': null,
      'semester': '2026-1',
      'status': 'unexpected',
      'advisor_notes': null,
      'submitted_at': '2026-01-02T03:04:05Z',
      'reviewed_at': null,
      'student': {'full_name': 'Student', 'student_id': 'S-1'},
      'advisor': {
        'id': 'advisor-1',
        'full_name': 'Advisor',
        'email': 'advisor@example.test',
        'avatar_url': null,
      },
      'registration_request_courses': [
        {
          'id': 'request-course-1',
          'request_id': 'request-1',
          'course_id': 'course-1',
          'section_name': null,
          'sub_section_name': null,
          'courses': {
            'id': 'course-1',
            'code': 'CS101',
            'name_en': 'Programming',
            'name_ar': 'برمجة',
            'credit_hours': 3,
            'department_id': 'department-1',
          },
        },
      ],
    });

    expect(request.status, RegistrationStatus.unknown);
    expect(request.studentProfile?.fullName, 'Student');
    expect(request.studentProfile?.studentNumber, 'S-1');
    expect(request.advisor?.fullName, 'Advisor');
    expect(request.courses.single.course?.code, 'CS101');
    expect(request.courses.single.sectionName, isNull);
    final directoryStudent = AdvisorStudent.fromJson({
      'id': 'student-1',
      'full_name': 'Student',
      'email': 'student@example.test',
      'student_id': 'S-1',
      'advisor_id': 'advisor-1',
      'avatar_url': null,
      'department_id': null,
      'college_id': 'college-1',
    });
    expect(directoryStudent.advisorId, 'advisor-1');
    expect(
      () => RegistrationRequest.fromJson({'id': 'malformed'}),
      throwsFormatException,
    );
  });

  test('shared-file type, nullable size and unknown type are explicit', () {
    final row = {
      'id': 'file-1',
      'uploader_id': 'user-1',
      'title': 'Notes',
      'title_ar': null,
      'file_path': 'course/uploader/notes.pdf',
      'file_type': 'pdf',
      'file_size': null,
      'download_count': 0,
      'is_public': true,
      'created_at': '2026-01-02T03:04:05Z',
      'course_id': null,
      'deleted_at': null,
    };
    expect(SharedFileRecord.fromJson(row).fileType, SharedFileType.pdf);
    expect(SharedFileRecord.fromJson(row).fileSizeBytes, isNull);
    expect(
      SharedFileRecord.fromJson({...row, 'file_type': 'future_file'}).fileType,
      SharedFileType.unknown,
    );
  });

  test('conversation and message mappers parse nested members and replies', () {
    final conversation = ConversationRecord.fromJson({
      'id': 'conversation-1',
      'title': null,
      'is_group': false,
      'created_by': 'user-1',
      'last_message': 'Hello',
      'last_message_at': null,
      'created_at': '2026-01-02T03:04:05Z',
      'updated_at': '2026-01-02T03:04:05Z',
      'conversation_members': [
        {
          'conversation_id': 'conversation-1',
          'user_id': 'user-1',
          'joined_at': '2026-01-02T03:04:05Z',
          'last_read_at': '2026-01-02T03:04:05Z',
          'is_admin': false,
          'is_muted': false,
          'profiles': {
            'id': 'user-1',
            'full_name': 'Member',
            'avatar_url': null,
          },
        },
      ],
    });
    expect(conversation.members.single.profile?.fullName, 'Member');

    final message = MessageRecord.fromJson({
      'id': 'message-1',
      'conversation_id': 'conversation-1',
      'sender_id': 'user-1',
      'content': 'Reply',
      'status': 'sent',
      'is_edited': false,
      'created_at': '2026-01-02T03:04:05Z',
      'media_url': null,
      'reply_to_id': 'message-0',
      'deleted_at': null,
      'sender': {'id': 'user-1', 'full_name': 'Member', 'avatar_url': null},
      'reply': {
        'id': 'message-0',
        'content': 'Earlier',
        'created_at': '2026-01-01T03:04:05Z',
      },
    });
    expect(message.sender?.fullName, 'Member');
    expect(message.reply?.content, 'Earlier');
    expect(
      MessageRecord.fromJson({
        'id': 'message-1',
        'conversation_id': 'conversation-1',
        'sender_id': 'user-1',
        'content': 'New status',
        'status': 'future_status',
        'created_at': '2026-01-02T03:04:05Z',
      }).status,
      MessageStatus.unknown,
    );
  });

  test('canonical RBAC row mappers fail closed on unknown codes', () {
    final assignment = UserRoleAssignmentRecord.fromJson({
      'role_id': 'role-1',
      'expires_at': null,
      'role_definitions': {
        'id': 'role-1',
        'code': 'academic_advisor',
        'priority': 4,
      },
    });
    expect(assignment.role.role.name, 'academicAdvisor');
    expect(assignment.expiresAt, isNull);

    final permission = RolePermissionAssignmentRecord.fromJson({
      'role_id': 'role-1',
      'permissions': {'id': 'permission-1', 'code': 'grades.read'},
    });
    expect(permission.permission.permission, RolePermission.viewGrades);
    expect(
      () => UserRoleAssignmentRecord.fromJson({
        'role_id': 'role-2',
        'role_definitions': {
          'id': 'role-2',
          'code': 'future_role',
          'priority': 1,
        },
      }),
      throwsFormatException,
    );
    expect(
      () => PermissionRecord.fromJson({
        'id': 'permission-2',
        'code': 'future.permission',
      }),
      throwsFormatException,
    );
  });
}
