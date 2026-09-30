BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.plan(18);

INSERT INTO auth.users (
  id,
  aud,
  role,
  email,
  raw_app_meta_data,
  raw_user_meta_data
)
VALUES (
  'f033c7bd-13cc-4c9b-b61d-ceb4116ea321',
  'authenticated',
  'authenticated',
  'phase3-security-test@example.invalid',
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Phase 3 Test","roles":["rector"]}'
);

SELECT set_config(
  'request.jwt.claim.sub',
  'f033c7bd-13cc-4c9b-b61d-ceb4116ea321',
  true
);
SET LOCAL ROLE authenticated;

SELECT extensions.is(
  (SELECT public.get_my_role()::text),
  'guest',
  'signup assigns the least-privilege guest role instead of trusting user metadata'
);
SELECT extensions.ok(
  NOT public.has_permission('courses.enroll'),
  'guest cannot enroll in courses'
);
SELECT extensions.ok(
  NOT public.has_permission('colleges.manage'),
  'guest receives no college management permission'
);
SELECT extensions.ok(
  NOT public.has_permission('posts.create'),
  'guest receives no post creation permission'
);
SELECT extensions.ok(NOT public.has_permission('profiles.read'), 'guest cannot browse the profile directory');
SELECT extensions.ok(NOT public.has_permission('grades.read'), 'guest cannot read grades');
SELECT extensions.ok(NOT public.has_permission('attendance.read'), 'guest cannot read attendance');
SELECT extensions.ok(NOT public.has_permission('finance.read'), 'guest cannot read invoices');
SELECT extensions.ok(NOT public.has_permission('registration.manage'), 'guest cannot manage registration');
SELECT extensions.ok(NOT public.has_permission('materials.read'), 'guest cannot access private course materials');
SELECT extensions.ok(
  NOT has_column_privilege('authenticated', 'public.profiles', 'roles', 'UPDATE'),
  'authenticated clients cannot update the legacy roles cache'
);
SELECT extensions.ok(
  NOT has_column_privilege('authenticated', 'public.profiles', 'national_id', 'SELECT'),
  'authenticated clients cannot directly read national IDs'
);
SELECT extensions.ok(
  NOT has_column_privilege('authenticated', 'public.profiles', 'email', 'SELECT'),
  'authenticated clients cannot directly read other profile emails'
);
SELECT extensions.ok(
  NOT has_column_privilege('authenticated', 'public.profiles', 'is_banned', 'UPDATE'),
  'authenticated clients cannot modify moderation state'
);
SELECT extensions.is((SELECT count(*)::integer FROM public.profile_directory), 0,
  'guest cannot read the authenticated profile directory');

SELECT public.update_my_profile('Updated Test Name', '555', 'self edit', NULL);
SELECT extensions.is(
  (SELECT full_name FROM public.profiles
   WHERE id = 'f033c7bd-13cc-4c9b-b61d-ceb4116ea321'),
  'Updated Test Name',
  'the owner-bound self-service update changes an allowed personal field'
);
SELECT extensions.is(
  (SELECT email FROM public.get_my_profile_private()),
  'phase3-security-test@example.invalid',
  'the private profile RPC returns the caller own private fields'
);
SELECT extensions.throws_ok(
  $$SELECT public.assign_student_advisor(
      'f033c7bd-13cc-4c9b-b61d-ceb4116ea321',
      'f033c7bd-13cc-4c9b-b61d-ceb4116ea321'
    )$$,
  '42501',
  'insufficient privilege',
  'a guest cannot assign advisors'
);

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
