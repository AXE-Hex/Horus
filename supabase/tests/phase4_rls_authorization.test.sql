BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.plan(50);

-- Isolated synthetic fixture; auth triggers give every account the default
-- guest role before the test assigns a canonical role explicitly.
INSERT INTO auth.users (id, aud, role, email, raw_app_meta_data, raw_user_meta_data)
VALUES
  ('40000000-0000-4000-8000-000000000001', 'authenticated', 'authenticated', 'p4-student-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000002', 'authenticated', 'authenticated', 'p4-student-b@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000003', 'authenticated', 'authenticated', 'p4-professor-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000004', 'authenticated', 'authenticated', 'p4-lecturer-b@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000005', 'authenticated', 'authenticated', 'p4-ta-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000006', 'authenticated', 'authenticated', 'p4-advisor-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000007', 'authenticated', 'authenticated', 'p4-hod-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000008', 'authenticated', 'authenticated', 'p4-dean-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000009', 'authenticated', 'authenticated', 'p4-registrar-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000010', 'authenticated', 'authenticated', 'p4-dean-b@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('40000000-0000-4000-8000-000000000011', 'authenticated', 'authenticated', 'p4-rector@example.invalid', '{"provider":"email","providers":["email"]}', '{}');

INSERT INTO public.colleges (id, code, name_en, name_ar)
VALUES ('41000000-0000-4000-8000-000000000001', 'P4A', 'P4 College A', 'كلية أ'),
       ('41000000-0000-4000-8000-000000000002', 'P4B', 'P4 College B', 'كلية ب');
INSERT INTO public.departments (id, college_id, code, name_en, name_ar)
VALUES ('42000000-0000-4000-8000-000000000001', '41000000-0000-4000-8000-000000000001', 'P4DA', 'P4 Department A', 'قسم أ'),
       ('42000000-0000-4000-8000-000000000002', '41000000-0000-4000-8000-000000000002', 'P4DB', 'P4 Department B', 'قسم ب'),
       ('42000000-0000-4000-8000-000000000003', '41000000-0000-4000-8000-000000000001', 'P4DA2', 'P4 Department A2', 'قسم أ٢');

UPDATE public.profiles SET college_id = '41000000-0000-4000-8000-000000000001', department_id = '42000000-0000-4000-8000-000000000001'
WHERE id IN ('40000000-0000-4000-8000-000000000001', '40000000-0000-4000-8000-000000000003', '40000000-0000-4000-8000-000000000005', '40000000-0000-4000-8000-000000000006', '40000000-0000-4000-8000-000000000007', '40000000-0000-4000-8000-000000000008', '40000000-0000-4000-8000-000000000009');
UPDATE public.profiles SET college_id = '41000000-0000-4000-8000-000000000002', department_id = '42000000-0000-4000-8000-000000000002'
WHERE id IN ('40000000-0000-4000-8000-000000000002', '40000000-0000-4000-8000-000000000004', '40000000-0000-4000-8000-000000000010');
UPDATE public.profiles SET advisor_id = '40000000-0000-4000-8000-000000000006'
WHERE id = '40000000-0000-4000-8000-000000000001';
UPDATE public.profiles SET department_id = '42000000-0000-4000-8000-000000000001'
WHERE id = '40000000-0000-4000-8000-000000000011';
UPDATE public.departments SET hod_id = '40000000-0000-4000-8000-000000000007'
WHERE id = '42000000-0000-4000-8000-000000000001';
UPDATE public.colleges SET dean_id = '40000000-0000-4000-8000-000000000008'
WHERE id = '41000000-0000-4000-8000-000000000001';

DELETE FROM public.user_roles WHERE user_id IN (
  '40000000-0000-4000-8000-000000000001', '40000000-0000-4000-8000-000000000002',
  '40000000-0000-4000-8000-000000000003', '40000000-0000-4000-8000-000000000004',
  '40000000-0000-4000-8000-000000000005', '40000000-0000-4000-8000-000000000006',
  '40000000-0000-4000-8000-000000000007', '40000000-0000-4000-8000-000000000008',
  '40000000-0000-4000-8000-000000000009', '40000000-0000-4000-8000-000000000010',
  '40000000-0000-4000-8000-000000000011');
INSERT INTO public.user_roles (user_id, role_id)
SELECT v.user_id, rd.id
FROM (VALUES
  ('40000000-0000-4000-8000-000000000001'::uuid, 'student'),
  ('40000000-0000-4000-8000-000000000002'::uuid, 'student'),
  ('40000000-0000-4000-8000-000000000003'::uuid, 'professor'),
  ('40000000-0000-4000-8000-000000000004'::uuid, 'lecturer'),
  ('40000000-0000-4000-8000-000000000005'::uuid, 'teaching_assistant'),
  ('40000000-0000-4000-8000-000000000006'::uuid, 'academic_advisor'),
  ('40000000-0000-4000-8000-000000000007'::uuid, 'department_head'),
  ('40000000-0000-4000-8000-000000000008'::uuid, 'dean'),
  ('40000000-0000-4000-8000-000000000009'::uuid, 'registrar_officer'),
  ('40000000-0000-4000-8000-000000000010'::uuid, 'dean'),
  ('40000000-0000-4000-8000-000000000011'::uuid, 'rector')
) AS v(user_id, role_code)
JOIN public.role_definitions rd ON rd.code = v.role_code;
INSERT INTO public.courses (id, department_id, code, name_en, name_ar, professor_id)
VALUES ('43000000-0000-4000-8000-000000000001', '42000000-0000-4000-8000-000000000001', 'P4A1', 'P4 Course A', 'مقرر أ', '40000000-0000-4000-8000-000000000003'),
       ('43000000-0000-4000-8000-000000000002', '42000000-0000-4000-8000-000000000002', 'P4B1', 'P4 Course B', 'مقرر ب', '40000000-0000-4000-8000-000000000004'),
       ('43000000-0000-4000-8000-000000000003', '42000000-0000-4000-8000-000000000003', 'P4A2', 'P4 Course A2', 'مقرر أ٢', '40000000-0000-4000-8000-000000000003');
INSERT INTO public.teaching_assistants (profile_id, professor_id, course_id)
VALUES ('40000000-0000-4000-8000-000000000005', '40000000-0000-4000-8000-000000000003',
        '43000000-0000-4000-8000-000000000001');

INSERT INTO public.enrollments (student_id, course_id, semester, status)
VALUES ('40000000-0000-4000-8000-000000000001', '43000000-0000-4000-8000-000000000001', 'p4', 'approved'),
       ('40000000-0000-4000-8000-000000000002', '43000000-0000-4000-8000-000000000002', 'p4', 'approved');
INSERT INTO public.grades (student_id, course_id, semester, total, is_published)
VALUES ('40000000-0000-4000-8000-000000000001', '43000000-0000-4000-8000-000000000001', 'p4', 90, true),
       ('40000000-0000-4000-8000-000000000001', '43000000-0000-4000-8000-000000000001', 'p4-hidden', 20, false),
       ('40000000-0000-4000-8000-000000000002', '43000000-0000-4000-8000-000000000002', 'p4', 88, true);
INSERT INTO public.invoices (student_id, semester, description, amount)
VALUES ('40000000-0000-4000-8000-000000000001', 'p4', 'Own invoice', 10),
       ('40000000-0000-4000-8000-000000000002', 'p4', 'Other invoice', 20);
INSERT INTO public.notifications (user_id, title, message)
VALUES ('40000000-0000-4000-8000-000000000001', 'Own', 'Own notification'),
       ('40000000-0000-4000-8000-000000000002', 'Other', 'Other notification');
INSERT INTO public.registration_requests (student_id, advisor_id, semester)
VALUES ('40000000-0000-4000-8000-000000000001', '40000000-0000-4000-8000-000000000006', 'p4'),
       ('40000000-0000-4000-8000-000000000002', NULL, 'p4');
INSERT INTO public.student_registrations (student_id, semester, section_name, sub_section_name)
VALUES ('40000000-0000-4000-8000-000000000001', 'p4', 'A', '1'),
       ('40000000-0000-4000-8000-000000000002', 'p4', 'B', '1');
INSERT INTO public.posts (author_id, college_id, department_id, content)
VALUES ('40000000-0000-4000-8000-000000000001', '41000000-0000-4000-8000-000000000001', '42000000-0000-4000-8000-000000000001', 'A post'),
       ('40000000-0000-4000-8000-000000000002', '41000000-0000-4000-8000-000000000002', '42000000-0000-4000-8000-000000000002', 'B post');

SELECT extensions.ok(NOT has_table_privilege('anon', 'public.invoices', 'SELECT'), 'anonymous has no invoice table grant');
SELECT extensions.ok(NOT has_table_privilege('anon', 'public.profile_directory', 'SELECT'), 'anonymous has no profile directory grant');
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000001', true);
SELECT extensions.is(public.get_my_role()::text, 'student', 'student role comes from canonical assignment');
SELECT extensions.ok(public.has_permission('courses.enroll'), 'student receives canonical enrollment permission');
SELECT extensions.is((SELECT count(*)::integer FROM public.invoices), 1, 'student reads own invoice');
SELECT extensions.is((SELECT count(*)::integer FROM public.invoices WHERE student_id = '40000000-0000-4000-8000-000000000002'), 0, 'student cannot read another student invoice');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE is_published), 1, 'student reads own published grade');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE NOT is_published), 0, 'student cannot read unpublished grade');
SELECT extensions.is((SELECT count(*)::integer FROM public.notifications), 1, 'student reads own notifications');
SELECT extensions.is((SELECT count(*)::integer FROM public.notifications WHERE user_id = '40000000-0000-4000-8000-000000000002'), 0, 'student cannot read another student notification');
SELECT extensions.is((SELECT count(*)::integer FROM public.student_registrations), 1, 'student reads own registration');
SELECT extensions.is((SELECT count(*)::integer FROM public.posts WHERE content = 'B post'), 0, 'student cannot read a post scoped to another college');
SELECT extensions.is((SELECT count(*)::integer FROM public.posts WHERE content = 'A post'), 1, 'student reads a post within their department');
SELECT extensions.ok(NOT has_column_privilege('authenticated', 'public.profiles', 'roles', 'UPDATE'), 'profile roles are not directly writable');
SELECT extensions.ok(NOT has_column_privilege('authenticated', 'public.profiles', 'national_id', 'SELECT'), 'national ID is not directly readable');
SELECT extensions.ok(NOT has_table_privilege('authenticated', 'public.user_roles', 'INSERT') AND NOT has_table_privilege('authenticated', 'public.user_roles', 'UPDATE') AND NOT has_table_privilege('authenticated', 'public.user_roles', 'DELETE'), 'clients cannot mutate canonical role assignments');
SELECT extensions.throws_ok($$INSERT INTO public.student_registrations(student_id, semester, section_name, sub_section_name) VALUES ('40000000-0000-4000-8000-000000000002', 'p4-evil', 'X', 'X')$$, '42501', NULL, 'student cannot register another student');
INSERT INTO public.student_registrations (student_id, semester, section_name, sub_section_name)
VALUES ('40000000-0000-4000-8000-000000000001', 'p4-self', 'A', '1');
SELECT extensions.is((SELECT count(*)::integer FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4-self'), 1, 'student inserts their own registration');
UPDATE public.student_registrations SET section_name = 'A-updated'
WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4-self';
SELECT extensions.is((SELECT section_name FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4-self'), 'A-updated', 'student updates their own registration');
DELETE FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4-self';
SELECT extensions.is((SELECT count(*)::integer FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4-self'), 0, 'student deletes their own registration');
UPDATE public.notifications SET is_read = true WHERE user_id = '40000000-0000-4000-8000-000000000001';
SELECT extensions.ok((SELECT is_read FROM public.notifications WHERE user_id = '40000000-0000-4000-8000-000000000001'), 'student updates their own notification state');
SELECT extensions.throws_ok($$UPDATE public.student_registrations SET student_id = '40000000-0000-4000-8000-000000000002' WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4'$$, '42501', NULL, 'student cannot transfer a self-owned row to another student');
SELECT extensions.throws_ok($$INSERT INTO public.posts(author_id, content) VALUES ('40000000-0000-4000-8000-000000000001', 'not authorized')$$, '42501', NULL, 'student without posts.create cannot publish posts');
SELECT extensions.throws_ok($$INSERT INTO public.registration_requests(student_id, advisor_id, semester, status) VALUES ('40000000-0000-4000-8000-000000000001', '40000000-0000-4000-8000-000000000003', 'p4-hijack', 'pending')$$, '42501', NULL, 'student cannot expose their request to an unassigned advisor');
SELECT extensions.throws_ok($$INSERT INTO public.registration_request_courses(request_id, course_id) SELECT id, '43000000-0000-4000-8000-000000000002' FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000001' AND semester = 'p4'$$, '42501', NULL, 'student cannot add a cross-college course to a registration request');
SELECT extensions.throws_ok($$UPDATE public.profiles SET roles = '{rector}' WHERE id = '40000000-0000-4000-8000-000000000001'$$, '42501', NULL, 'student cannot self-assign a privileged role');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000003', true);
SELECT extensions.ok(public.has_permission('grades.manage'), 'professor receives grade management permission');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE course_id = '43000000-0000-4000-8000-000000000001'), 2, 'professor reads records only for the taught course');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE course_id = '43000000-0000-4000-8000-000000000002'), 0, 'professor cannot read a cross-course grade');
SELECT extensions.throws_ok($$INSERT INTO public.grades(student_id, course_id, semester, total) VALUES ('40000000-0000-4000-8000-000000000002', '43000000-0000-4000-8000-000000000002', 'p4-evil', 99)$$, '42501', NULL, 'professor cannot write grades for an unrelated course');
INSERT INTO public.attendance (student_id, course_id, date, recorded_by)
VALUES ('40000000-0000-4000-8000-000000000001', '43000000-0000-4000-8000-000000000001', '2026-09-01', '40000000-0000-4000-8000-000000000003');
SELECT extensions.is((SELECT count(*)::integer FROM public.attendance WHERE recorded_by = '40000000-0000-4000-8000-000000000003'), 1, 'professor records attendance in a taught course');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000004', true);
SELECT extensions.ok(public.has_permission('grades.manage'), 'lecturer receives grade management permission');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE course_id = '43000000-0000-4000-8000-000000000002'), 1, 'lecturer reads the course they teach');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000005', true);
SELECT extensions.ok(public.can_teach_course('43000000-0000-4000-8000-000000000001'), 'assigned teaching assistant is scoped to the assigned course');
SELECT extensions.is((SELECT count(*)::integer FROM public.attendance WHERE course_id = '43000000-0000-4000-8000-000000000001'), 1, 'teaching assistant reads attendance for assigned course');
SELECT extensions.is((SELECT count(*)::integer FROM public.attendance WHERE course_id = '43000000-0000-4000-8000-000000000002'), 0, 'teaching assistant cannot read attendance for another course');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000006', true);
SELECT extensions.is((SELECT count(*)::integer FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000001'), 1, 'advisor reads assigned advisee registration');
SELECT extensions.is((SELECT count(*)::integer FROM public.student_registrations WHERE student_id = '40000000-0000-4000-8000-000000000002'), 0, 'advisor cannot read an unassigned student in another college');
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000001'), 1, 'advisor reads assigned registration request');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000007', true);
SELECT extensions.ok(public.can_manage_course('43000000-0000-4000-8000-000000000001'), 'department head manages courses in assigned department');
SELECT extensions.ok(NOT public.can_manage_course('43000000-0000-4000-8000-000000000002'), 'department head cannot manage a cross-college course');
SELECT extensions.ok(NOT public.can_manage_course('43000000-0000-4000-8000-000000000003'), 'department head cannot manage a second department in the same college');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE course_id = '43000000-0000-4000-8000-000000000001'), 2, 'department head reads grades within managed department');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades WHERE course_id = '43000000-0000-4000-8000-000000000002'), 0, 'department head cannot read grades from another college');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000008', true);
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000001'), 1, 'dean reads registration requests in own college');
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000002'), 0, 'dean cannot read requests from another college');
SELECT extensions.ok(NOT public.can_manage_department('42000000-0000-4000-8000-000000000002'), 'dean cannot manage a cross-college department');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000009', true);
UPDATE public.registration_requests SET status = 'approved', reviewed_at = now()
WHERE student_id = '40000000-0000-4000-8000-000000000001';
SELECT extensions.is((SELECT status::text FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000001'), 'approved', 'registrar reviews a request inside their college');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000010', true);
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000001'), 0, 'second dean cannot see cross-college registration requests');

SELECT set_config('request.jwt.claim.sub', '40000000-0000-4000-8000-000000000011', true);
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests WHERE student_id = '40000000-0000-4000-8000-000000000002'), 1, 'university-level rector with canonical permission can review across colleges');

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
