BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();

-- Independent fixtures also test stale academic records owned by a guest.
INSERT INTO auth.users (id, aud, role, email, raw_user_meta_data)
VALUES ('60000000-0000-4000-8000-000000000001', 'authenticated', 'authenticated',
        'guest-regression@example.invalid', '{"role":"rector","roles":["dean","student"]}'),
       ('60000000-0000-4000-8000-000000000002', 'authenticated', 'authenticated',
        'other-regression@example.invalid', '{}');
INSERT INTO public.colleges (id, code, name_en, name_ar)
VALUES ('61000000-0000-4000-8000-000000000001', 'GUEST-TEST', 'Test College', 'كلية الاختبار');
INSERT INTO public.departments (id, college_id, code, name_en, name_ar)
VALUES ('62000000-0000-4000-8000-000000000001', '61000000-0000-4000-8000-000000000001',
        'GUEST-TEST-D', 'Test Department', 'قسم الاختبار');
INSERT INTO public.courses (id, department_id, code, name_en, name_ar)
VALUES ('63000000-0000-4000-8000-000000000001', '62000000-0000-4000-8000-000000000001',
        'GUEST-TEST-C', 'Test Course', 'مقرر الاختبار');
INSERT INTO public.enrollments (student_id, course_id, semester, status)
VALUES ('60000000-0000-4000-8000-000000000001', '63000000-0000-4000-8000-000000000001', 'test', 'approved');
INSERT INTO public.grades (student_id, course_id, semester, total, is_published)
VALUES ('60000000-0000-4000-8000-000000000001', '63000000-0000-4000-8000-000000000001', 'test', 90, true);
INSERT INTO public.attendance (student_id, course_id, date)
VALUES ('60000000-0000-4000-8000-000000000001', '63000000-0000-4000-8000-000000000001', '2026-09-01');
INSERT INTO public.invoices (student_id, semester, description, amount)
VALUES ('60000000-0000-4000-8000-000000000001', 'test', 'Test invoice', 10);
INSERT INTO public.student_registrations (student_id, semester, section_name, sub_section_name)
VALUES ('60000000-0000-4000-8000-000000000001', 'test', 'A', '1');
INSERT INTO public.registration_requests (student_id, semester)
VALUES ('60000000-0000-4000-8000-000000000001', 'test');

SELECT set_config('request.jwt.claim.sub', '60000000-0000-4000-8000-000000000001', true);
SET LOCAL ROLE authenticated;
SELECT extensions.is(public.get_my_role()::text, 'guest', 'metadata cannot grant university roles');
SELECT extensions.is((SELECT count(*)::int FROM public.grades), 0, 'guest denied even own published grades');
SELECT extensions.is((SELECT count(*)::int FROM public.attendance), 0, 'guest denied own attendance');
SELECT extensions.is((SELECT count(*)::int FROM public.invoices), 0, 'guest denied own invoices');
SELECT extensions.is((SELECT count(*)::int FROM public.enrollments), 0, 'guest denied own enrollments');
SELECT extensions.is((SELECT count(*)::int FROM public.student_registrations), 0, 'guest denied own registration');
SELECT extensions.is((SELECT count(*)::int FROM public.registration_requests), 0, 'guest denied own requests');
SELECT extensions.is((SELECT count(*)::int FROM public.shared_files WHERE NOT is_public), 0, 'guest denied private files');
SELECT extensions.is((SELECT count(*)::int FROM public.profile_directory), 0, 'guest denied staff directory');
SELECT extensions.is((SELECT count(*)::int FROM public.user_roles WHERE user_id <> auth.uid()), 0, 'guest denied other role assignments');
SELECT extensions.ok(NOT public.can_access_course('63000000-0000-4000-8000-000000000001'), 'stale enrollment does not authorize a guest');
SELECT extensions.throws_ok($$INSERT INTO public.user_roles(user_id, role_id)
  SELECT auth.uid(), id FROM public.role_definitions WHERE code = 'rector'$$,
  '42501', NULL, 'guest cannot assign privileged roles');
RESET ROLE;

DELETE FROM public.user_roles WHERE user_id = '60000000-0000-4000-8000-000000000001';
INSERT INTO public.user_roles (user_id, role_id, granted_at, expires_at)
SELECT '60000000-0000-4000-8000-000000000001', id, now() - interval '2 days', now() - interval '1 day'
FROM public.role_definitions WHERE code = 'regular_student';
SET LOCAL ROLE authenticated;
SELECT extensions.ok(NOT public.has_permission('grades.read'), 'expired role denies permissions');
SELECT extensions.ok(public.get_my_role() IS NULL, 'expired role has no initial role');
RESET ROLE;
UPDATE public.user_roles SET expires_at = NULL WHERE user_id = '60000000-0000-4000-8000-000000000001';
UPDATE public.profiles SET is_banned = true WHERE id = '60000000-0000-4000-8000-000000000001';
SET LOCAL ROLE authenticated;
SELECT extensions.ok(NOT public.has_permission('grades.read'), 'banned account denies permissions');
RESET ROLE;
UPDATE public.profiles SET is_banned = false, is_active = false WHERE id = '60000000-0000-4000-8000-000000000001';
SET LOCAL ROLE authenticated;
SELECT extensions.ok(NOT public.has_permission('grades.read'), 'inactive account denies permissions');
RESET ROLE;
UPDATE public.profiles SET is_active = true, deleted_at = now() WHERE id = '60000000-0000-4000-8000-000000000001';
SET LOCAL ROLE authenticated;
SELECT extensions.ok(NOT public.has_permission('grades.read'), 'deleted account denies permissions');
RESET ROLE;

SELECT * FROM extensions.finish();
ROLLBACK;
