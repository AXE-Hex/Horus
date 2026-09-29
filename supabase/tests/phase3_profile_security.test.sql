BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.plan(12);

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
  'student',
  'signup assigns the server default role instead of trusting user metadata'
);
SELECT extensions.ok(
  public.has_permission('courses.enroll'),
  'the canonical student assignment grants course enrollment'
);
SELECT extensions.ok(
  NOT public.has_permission('colleges.manage'),
  'a default student receives no college management permission'
);
SELECT extensions.ok(
  NOT public.has_permission('posts.create'),
  'a default student receives no post creation permission'
);
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
SELECT extensions.is(
  (SELECT role_codes FROM public.profile_directory
   WHERE id = 'f033c7bd-13cc-4c9b-b61d-ceb4116ea321'),
  ARRAY['student']::text[],
  'the directory exposes canonical role codes'
);

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
  'a student cannot assign advisors'
);

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
