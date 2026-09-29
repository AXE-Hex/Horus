import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/feed/data/repositories/post_repository.dart';

void main() {
  test(
    'post media object path binds upload to user and normalized extension',
    () {
      final path = postMediaObjectPath(
        userId: 'authenticated-user',
        timestamp: DateTime.fromMillisecondsSinceEpoch(123456),
        extension: '.PNG',
      );

      expect(path, 'authenticated-user/123456.png');
      expect(path.split('/').first, 'authenticated-user');
      expect(
        postMediaObjectPath(
          userId: 'authenticated-user',
          timestamp: DateTime.fromMillisecondsSinceEpoch(123456),
          extension: '',
        ),
        'authenticated-user/123456',
      );
    },
  );
}
