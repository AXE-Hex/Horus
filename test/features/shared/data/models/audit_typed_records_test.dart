import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/data/notification_provider.dart';

void main() {
  group('audit typed row contracts', () {
    test('notification maps database type and nullable metadata safely', () {
      final record = NotificationRecord.fromJson({
        'id': 'notice-1',
        'user_id': 'user-1',
        'title': 'Result posted',
        'message': 'Your result is available',
        'type': 'unexpected',
        'is_read': false,
        'created_at': '2026-09-29T10:00:00Z',
        'title_ar': null,
        'message_ar': null,
        'action_url': null,
        'read_at': null,
        'metadata': null,
      });

      expect(record.type, NotificationType.unknown);
      expect(record.titleAr, isNull);
      expect(record.metadata, isNull);
      expect(AppNotification.fromRecord(record).isRead, isFalse);
    });

    test('clearing notification UI state represents persisted read state', () {
      final notes = [
        AppNotification(
          id: 'notice-1',
          title: 'A',
          message: 'B',
          timestamp: DateTime.utc(2026),
          category: NotificationCategory.general,
        ),
      ];

      expect(
        notificationsAfterMarkAllRead(notes, updatedRows: 1).single.isRead,
        isTrue,
      );
      expect(
        notificationsAfterMarkAllRead(notes, updatedRows: 0).single.isRead,
        isFalse,
      );
      expect(notes.single.isRead, isFalse);
    });

    test('exam and action plan parse required values and nested course', () {
      final examRow = {
        'id': 'exam-1',
        'course_id': 'course-1',
        'exam_type': 'final',
        'exam_date': '2026-12-01',
        'start_time': '09:00:00',
        'end_time': '11:00:00',
        'semester': '2026-fall',
        'created_at': '2026-09-29T10:00:00Z',
        'room': null,
        'courses': {'code': 'CS101', 'name_en': 'Computing'},
      };
      final exam = ExamScheduleRecord.fromJson(examRow);
      final unknownExam = ExamScheduleRecord.fromJson({
        ...examRow,
        'exam_type': 'future_type',
      });
      final plan = ActionPlanItemRecord.fromJson({
        'id': 'plan-1',
        'student_id': 'student-1',
        'semester': '2026-fall',
        'year': 2026,
        'status': 'unknown-status',
        'created_at': '2026-09-29T10:00:00Z',
        'course_id': null,
        'notes': null,
        'courses': null,
      });

      expect(exam.courseCode, 'CS101');
      expect(exam.examType, ExamType.finalExam);
      expect(unknownExam.examType, ExamType.unknown);
      expect(exam.room, isNull);
      expect(plan.status, ActionPlanStatus.unknown);
      expect(plan.courseName, isNull);
      expect(
        () => ExamScheduleRecord.fromJson({'id': 'missing-required-fields'}),
        throwsFormatException,
      );
    });

    test(
      'shared course file path binds course, uploader, row ID, filename',
      () {
        const courseId = '12345678-1234-4234-8234-123456789abc';
        const uploaderId = '22345678-1234-4234-8234-123456789abc';
        const fileId = '32345678-1234-4234-8234-123456789abc';

        expect(
          SharedFileUpload.buildCourseFilePath(
            courseId: courseId,
            uploaderId: uploaderId,
            fileId: fileId,
            fileName: 'notes.pdf',
          ),
          '$courseId/$uploaderId/$fileId/notes.pdf',
        );
        expect(
          () => SharedFileUpload.buildCourseFilePath(
            courseId: courseId,
            uploaderId: uploaderId,
            fileId: fileId,
            fileName: '../notes.pdf',
          ),
          throwsArgumentError,
        );
      },
    );

    test('announcement and forum rows map nested authors centrally', () {
      final announcement = AnnouncementRecord.fromJson({
        'id': 'announcement-1',
        'author_id': 'staff-1',
        'title': 'Notice',
        'content': 'Content',
        'priority': 'normal',
        'is_pinned': false,
        'published_at': '2026-09-29T10:00:00Z',
        'profiles': {'full_name': 'Staff', 'avatar_url': null},
      });
      final post = ForumPostRecord.fromJson({
        'id': 'forum-post-1',
        'forum_id': 'forum-1',
        'author_id': 'student-1',
        'title': 'Question',
        'content': 'Text',
        'is_pinned': false,
        'reply_count': 0,
        'created_at': '2026-09-29T10:00:00Z',
        'profiles': null,
      });

      expect(announcement.author?.fullName, 'Staff');
      expect(post.author, isNull);
      expect(
        () => NotificationRecord.fromJson({'id': 'malformed'}),
        throwsFormatException,
      );
    });

    test('forum, session, and department project contracts are typed', () {
      final forum = ForumRecord.fromJson({
        'id': 'forum-1',
        'name': 'General',
        'category': 'general',
        'is_active': true,
        'created_at': '2026-09-29T10:00:00Z',
        'name_ar': null,
        'description': null,
      });
      final session = UserSessionRecord.fromJson({
        'id': 'session-1',
        'user_id': 'user-1',
        'device_type': 'tablet',
        'is_active': true,
        'last_active': '2026-09-29T10:00:00Z',
        'created_at': '2026-09-28T10:00:00Z',
        'device_name': null,
        'location': null,
      });
      final project = DepartmentProjectModel.fromJson({
        'id': 'project-1',
        'department_id': 'department-1',
        'title_en': 'Research',
        'title_ar': 'بحث',
        'description_en': null,
        'description_ar': null,
        'status': 'active',
        'created_at': '2026-09-29T10:00:00Z',
      });

      expect(forum.nameAr, isNull);
      expect(forum.category, ForumCategory.general);
      expect(session.deviceType, SessionDevice.tablet);
      expect(project.descriptionEn, isNull);
      expect(project.status, DepartmentProjectStatus.active);
    });
  });
}
