import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'production Dart code contains no retired sample identities or records',
    () {
      const retiredValues = [
        'Ahmed Mohamed',
        'Ahmed Ali',
        'Sarah Mohamed',
        'Dr. Khaled Mahmoud',
        'Ada Lovelace',
        'Alan Turing',
        'Robert Smith',
        '20230001',
        '12,450 EGP',
        'mockDeanImage',
        'mockStaffImageBase',
        'pravatar.cc',
        'student@horus.edu.eg',
        'ta@horus.edu.eg',
      ];
      final violations = <String>[];

      for (final entity in Directory('lib').listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        if (entity.path.contains(
          '${Platform.pathSeparator}core${Platform.pathSeparator}i18n${Platform.pathSeparator}',
        )) {
          continue;
        }
        final source = entity.readAsStringSync();
        for (final value in retiredValues) {
          if (source.contains(value)) violations.add('${entity.path}: $value');
        }
      }

      expect(violations, isEmpty);
    },
  );
}
