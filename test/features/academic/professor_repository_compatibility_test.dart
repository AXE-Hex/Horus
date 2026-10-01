import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

http.Response response(http.Request request, String body, int status) =>
    http.Response(
      body,
      status,
      request: request,
      headers: {'content-type': 'application/json'},
    );

void main() {
  for (final denied in [true, false]) {
    test(
      'professor public data survives optional details denial: $denied',
      () async {
        final requests = <Uri>[];
        final client = SupabaseClient(
          'http://localhost:54321',
          'test-public-key',
          httpClient: MockClient((request) async {
            requests.add(request.url);
            final table = request.url.pathSegments.last;
            if (table == 'profiles') {
              expect(
                request.url.queryParameters['select'],
                isNot(contains('professor_details')),
              );
              expect(request.url.queryParameters['id'], 'eq.professor-1');
              return response(
                request,
                jsonEncode([
                  {
                    'id': 'professor-1',
                    'full_name': 'Professor',
                    'department_id': null,
                  },
                ]),
                200,
              );
            }
            if (table == 'professor_details') {
              // A list projection preserves SQLSTATE; maybeSingle can remap it
              // to HTTP 403 in the current SDK before the caller handles it.
              expect(request.url.queryParameters['limit'], '1');
              return denied
                  ? response(
                      request,
                      jsonEncode({
                        'code': '42501',
                        'message': 'permission denied',
                      }),
                      403,
                    )
                  : response(request, '[]', 200);
            }
            return response(request, '[]', 200);
          }),
        );
        addTearDown(client.dispose);
        final profile = await ProfessorRepository(
          client,
        ).getFullProfessorProfile('professor-1');
        expect(profile?.id, 'professor-1');
        expect(profile?.name, 'Professor');
        expect(profile?.totalRatings, 0);
        expect(
          requests.map((uri) => uri.pathSegments.last),
          containsAll([
            'teaching_assistants',
            'student_groups',
            'announcements',
            'shared_files',
            'office_hours',
          ]),
        );
      },
    );
  }

  test('other professor details failures remain errors', () async {
    final client = SupabaseClient(
      'http://localhost:54321',
      'test-public-key',
      httpClient: MockClient(
        (request) async => request.url.pathSegments.last == 'profiles'
            ? response(
                request,
                jsonEncode([
                  {
                    'id': 'professor-1',
                    'full_name': 'Professor',
                    'department_id': null,
                  },
                ]),
                200,
              )
            : response(
                request,
                jsonEncode({'code': '42703', 'message': 'invalid projection'}),
                400,
              ),
      ),
    );
    addTearDown(client.dispose);
    await expectLater(
      ProfessorRepository(client).getFullProfessorProfile('professor-1'),
      throwsA(isA<PostgrestException>()),
    );
  });
}
