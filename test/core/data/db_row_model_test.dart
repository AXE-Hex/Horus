import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/enrollment/data/models/invoice_models.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';

void main() {
  group('database row mapping', () {
    test('requires identifiers and gives a contextual malformed row error', () {
      expect(
        () => CollegeModel.fromJson({'name_en': 'Engineering'}),
        throwsA(
          isA<FormatException>().having(
            (error) => error.message,
            'message',
            contains('colleges.id'),
          ),
        ),
      );
    });

    test('maps nullable invoice fields and quarantines unknown SQL status', () {
      final invoice = Invoice.fromJson({
        'id': 'invoice-1',
        'student_id': 'student-1',
        'description': 'Fixture invoice',
        'currency': 'EGP',
        'amount': 12,
        'created_at': '2026-01-02T03:04:05Z',
        'due_date': null,
        'paid_at': null,
        'status': 'future_status',
      });

      expect(invoice.dueDate, isNull);
      expect(invoice.paidAt, isNull);
      expect(invoice.status, InvoiceStatus.unknown);
      expect(
        () => Invoice.fromJson({'id': 'invoice-1', 'student_id': 'student-1'}),
        throwsFormatException,
      );
    });

    test(
      'maps nested post relations and safely defaults unknown post type',
      () {
        final post = PostModel.fromJson({
          'id': 'post-1',
          'author_id': 'author-1',
          'content': 'Hello',
          'media_urls': ['media/file.webp'],
          'type': 'unknown_type',
          'created_at': '2026-01-02T03:04:05Z',
          'updated_at': '2026-01-02T03:04:05Z',
          'profiles': {'full_name': 'Author', 'avatar_url': null},
          'colleges': {'name_en': 'Engineering', 'name_ar': 'الهندسة'},
          'departments': null,
          'post_likes': [
            {'user_id': 'viewer'},
          ],
        });

        expect(post.type, PostType.text);
        expect(post.authorName, 'Author');
        expect(post.authorAvatarUrl, isNull);
        expect(post.collegeNameEn, 'Engineering');
        expect(post.departmentNameAr, isNull);
        expect(post.mediaUrls, ['media/file.webp']);
        expect(post.isLiked, isTrue);
      },
    );

    test(
      'rejects malformed nested comment relation and malformed list data',
      () {
        expect(
          () => CommentModel.fromJson({
            'id': 'comment-1',
            'post_id': 'post-1',
            'author_id': 'author-1',
            'content': 'Reply',
            'created_at': '2026-01-02T03:04:05Z',
            'updated_at': '2026-01-02T03:04:05Z',
            'profiles': 'not-an-object',
          }),
          throwsFormatException,
        );
        expect(
          () => PostModel.fromJson({
            'id': 'post-1',
            'author_id': 'author-1',
            'content': 'Hello',
            'media_urls': 'not-a-list',
            'created_at': '2026-01-02T03:04:05Z',
            'updated_at': '2026-01-02T03:04:05Z',
          }),
          throwsFormatException,
        );
      },
    );
  });
}
