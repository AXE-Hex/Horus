-- Phase 3: canonical RBAC, profile privacy, and safe self-service writes.
-- The permission catalog mirrors the existing feature permissions; assignments
-- are stored here and are read from user_roles/role_permissions at runtime.

INSERT INTO public.role_definitions (code, name_en, priority)
VALUES
  ('rector', 'Rector', 10),
  ('dean', 'Dean', 20),
  ('department_head', 'Department Head', 30),
  ('academic_coordinator', 'Academic Coordinator', 40),
  ('professor', 'Professor', 30),
  ('lecturer', 'Lecturer', 40),
  ('teaching_assistant', 'Teaching Assistant', 50),
  ('registrar_officer', 'Registrar Officer', 30),
  ('academic_advisor', 'Academic Advisor', 40),
  ('librarian', 'Librarian', 40),
  ('freshman', 'Freshman', 70),
  ('regular_student', 'Regular Student', 60),
  ('student', 'Student', 70),
  ('class_representative', 'Class Representative', 50),
  ('alumni', 'Alumni', 80),
  ('dorm_supervisor', 'Dorm Supervisor', 50),
  ('security_officer', 'Security Officer', 50),
  ('guest', 'Guest', 100),
  ('parent', 'Parent', 80),
  ('recruiter', 'Recruiter', 90),
  ('assistant_hod', 'Assistant Hod', 30)
ON CONFLICT (code) DO NOTHING;

INSERT INTO public.permissions (code, module, name_en)
VALUES
  ('announcements.create', 'announcements', 'Announcements Create'),
  ('attendance.manage', 'attendance', 'Attendance Manage'),
  ('attendance.read', 'attendance', 'Attendance Read'),
  ('colleges.manage', 'colleges', 'Colleges Manage'),
  ('courses.enroll', 'courses', 'Courses Enroll'),
  ('courses.manage', 'courses', 'Courses Manage'),
  ('departments.manage', 'departments', 'Departments Manage'),
  ('forums.access', 'forums', 'Forums Access'),
  ('finance.read', 'finance', 'Finance Read'),
  ('grades.manage', 'grades', 'Grades Manage'),
  ('grades.read', 'grades', 'Grades Read'),
  ('groups.manage', 'groups', 'Groups Manage'),
  ('jobs.read', 'jobs', 'Jobs Read'),
  ('library.manage', 'library', 'Library Manage'),
  ('materials.read', 'materials', 'Materials Read'),
  ('materials.upload', 'materials', 'Materials Upload'),
  ('notifications.read', 'notifications', 'Notifications Read'),
  ('posts.create', 'posts', 'Posts Create'),
  ('profiles.read', 'profiles', 'Profiles Read'),
  ('profiles.self_edit', 'profiles', 'Profiles Self_Edit'),
  ('ratings.submit', 'ratings', 'Ratings Submit'),
  ('registration.manage', 'registration', 'Registration Manage'),
  ('registration.review', 'registration', 'Registration Review'),
  ('schedule.read', 'schedule', 'Schedule Read'),
  ('schedules.manage', 'schedules', 'Schedules Manage'),
  ('students.advise', 'students', 'Students Advise'),
  ('students.assign_advisor', 'students', 'Students Assign Advisor'),
  ('students.progress.read', 'students', 'Students Progress Read'),
  ('support.submit', 'support', 'Support Submit'),
  ('teaching_assistants.manage', 'teaching_assistants', 'Teaching_Assistants Manage')
ON CONFLICT (code) DO NOTHING;

INSERT INTO public.role_permissions (role_id, permission_id)
SELECT rd.id, p.id
FROM (VALUES
  ('rector', 'colleges.manage'),
  ('rector', 'departments.manage'),
  ('rector', 'courses.manage'),
  ('rector', 'schedules.manage'),
  ('rector', 'registration.review'),
  ('rector', 'profiles.read'),
  ('rector', 'profiles.self_edit'),
  ('rector', 'notifications.read'),
  ('rector', 'announcements.create'),
  ('rector', 'posts.create'),
  ('dean', 'departments.manage'),
  ('dean', 'courses.manage'),
  ('dean', 'schedules.manage'),
  ('dean', 'registration.review'),
  ('dean', 'announcements.create'),
  ('dean', 'posts.create'),
  ('dean', 'profiles.read'),
  ('dean', 'profiles.self_edit'),
  ('dean', 'notifications.read'),
  ('department_head', 'courses.manage'),
  ('department_head', 'schedules.manage'),
  ('department_head', 'registration.review'),
  ('department_head', 'teaching_assistants.manage'),
  ('department_head', 'announcements.create'),
  ('department_head', 'posts.create'),
  ('department_head', 'profiles.read'),
  ('department_head', 'profiles.self_edit'),
  ('department_head', 'notifications.read'),
  ('academic_coordinator', 'courses.manage'),
  ('academic_coordinator', 'schedules.manage'),
  ('academic_coordinator', 'announcements.create'),
  ('academic_coordinator', 'posts.create'),
  ('academic_coordinator', 'profiles.read'),
  ('academic_coordinator', 'profiles.self_edit'),
  ('academic_coordinator', 'notifications.read'),
  ('professor', 'grades.manage'),
  ('professor', 'attendance.manage'),
  ('professor', 'announcements.create'),
  ('professor', 'posts.create'),
  ('professor', 'materials.upload'),
  ('professor', 'teaching_assistants.manage'),
  ('professor', 'groups.manage'),
  ('professor', 'forums.access'),
  ('professor', 'profiles.read'),
  ('professor', 'profiles.self_edit'),
  ('professor', 'notifications.read'),
  ('professor', 'support.submit'),
  ('lecturer', 'grades.manage'),
  ('lecturer', 'attendance.manage'),
  ('lecturer', 'announcements.create'),
  ('lecturer', 'posts.create'),
  ('lecturer', 'materials.upload'),
  ('lecturer', 'forums.access'),
  ('lecturer', 'profiles.read'),
  ('lecturer', 'profiles.self_edit'),
  ('lecturer', 'notifications.read'),
  ('lecturer', 'support.submit'),
  ('teaching_assistant', 'attendance.manage'),
  ('teaching_assistant', 'materials.upload'),
  ('teaching_assistant', 'forums.access'),
  ('teaching_assistant', 'profiles.read'),
  ('teaching_assistant', 'profiles.self_edit'),
  ('teaching_assistant', 'notifications.read'),
  ('teaching_assistant', 'support.submit'),
  ('registrar_officer', 'registration.manage'),
  ('registrar_officer', 'registration.review'),
  ('registrar_officer', 'profiles.read'),
  ('registrar_officer', 'profiles.self_edit'),
  ('registrar_officer', 'notifications.read'),
  ('registrar_officer', 'support.submit'),
  ('academic_advisor', 'students.advise'),
  ('academic_advisor', 'grades.read'),
  ('academic_advisor', 'schedule.read'),
  ('academic_advisor', 'attendance.read'),
  ('academic_advisor', 'profiles.read'),
  ('academic_advisor', 'profiles.self_edit'),
  ('academic_advisor', 'notifications.read'),
  ('academic_advisor', 'support.submit'),
  ('librarian', 'library.manage'),
  ('librarian', 'materials.upload'),
  ('librarian', 'profiles.read'),
  ('librarian', 'profiles.self_edit'),
  ('librarian', 'notifications.read'),
  ('librarian', 'support.submit'),
  ('freshman', 'grades.read'),
  ('freshman', 'schedule.read'),
  ('freshman', 'attendance.read'),
  ('freshman', 'courses.enroll'),
  ('freshman', 'finance.read'),
  ('freshman', 'materials.read'),
  ('freshman', 'profiles.read'),
  ('freshman', 'profiles.self_edit'),
  ('freshman', 'notifications.read'),
  ('freshman', 'support.submit'),
  ('regular_student', 'grades.read'),
  ('regular_student', 'schedule.read'),
  ('regular_student', 'attendance.read'),
  ('regular_student', 'courses.enroll'),
  ('regular_student', 'finance.read'),
  ('regular_student', 'ratings.submit'),
  ('regular_student', 'forums.access'),
  ('regular_student', 'materials.read'),
  ('regular_student', 'profiles.read'),
  ('regular_student', 'profiles.self_edit'),
  ('regular_student', 'notifications.read'),
  ('regular_student', 'support.submit'),
  ('student', 'grades.read'),
  ('student', 'schedule.read'),
  ('student', 'attendance.read'),
  ('student', 'courses.enroll'),
  ('student', 'finance.read'),
  ('student', 'materials.read'),
  ('student', 'profiles.read'),
  ('student', 'profiles.self_edit'),
  ('student', 'notifications.read'),
  ('student', 'support.submit'),
  ('class_representative', 'grades.read'),
  ('class_representative', 'schedule.read'),
  ('class_representative', 'attendance.read'),
  ('class_representative', 'courses.enroll'),
  ('class_representative', 'finance.read'),
  ('class_representative', 'ratings.submit'),
  ('class_representative', 'forums.access'),
  ('class_representative', 'materials.read'),
  ('class_representative', 'announcements.create'),
  ('class_representative', 'posts.create'),
  ('class_representative', 'profiles.read'),
  ('class_representative', 'profiles.self_edit'),
  ('class_representative', 'notifications.read'),
  ('class_representative', 'support.submit'),
  ('alumni', 'grades.read'),
  ('alumni', 'forums.access'),
  ('alumni', 'materials.read'),
  ('alumni', 'profiles.read'),
  ('alumni', 'profiles.self_edit'),
  ('alumni', 'notifications.read'),
  ('alumni', 'jobs.read'),
  ('dorm_supervisor', 'profiles.read'),
  ('dorm_supervisor', 'profiles.self_edit'),
  ('dorm_supervisor', 'notifications.read'),
  ('dorm_supervisor', 'support.submit'),
  ('security_officer', 'profiles.read'),
  ('security_officer', 'notifications.read'),
  ('security_officer', 'support.submit'),
  ('guest', 'profiles.read'),
  ('parent', 'students.progress.read'),
  ('parent', 'grades.read'),
  ('parent', 'attendance.read'),
  ('parent', 'profiles.read'),
  ('parent', 'notifications.read'),
  ('recruiter', 'jobs.read'),
  ('recruiter', 'profiles.read'),
  ('assistant_hod', 'courses.manage'),
  ('assistant_hod', 'schedules.manage'),
  ('assistant_hod', 'registration.review'),
  ('assistant_hod', 'teaching_assistants.manage'),
  ('assistant_hod', 'announcements.create'),
  ('assistant_hod', 'posts.create'),
  ('assistant_hod', 'profiles.read'),
  ('assistant_hod', 'profiles.self_edit'),
  ('assistant_hod', 'notifications.read')
) AS grants(role_code, permission_code)
JOIN public.role_definitions rd ON rd.code = grants.role_code AND rd.is_active
JOIN public.permissions p ON p.code = grants.permission_code
ON CONFLICT DO NOTHING;

-- Deans and the rector can assign academic advisors in the existing workflow.
INSERT INTO public.role_permissions (role_id, permission_id)
SELECT rd.id, p.id
FROM public.role_definitions rd
CROSS JOIN public.permissions p
WHERE rd.code IN ('rector', 'dean')
  AND p.code IN ('students.advise', 'students.assign_advisor')
ON CONFLICT DO NOTHING;

-- Role resolution no longer trusts JWT user_metadata claims or defaults a
-- missing role to student. A user without an active canonical assignment has
-- no role and consequently no client permissions.
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS public.user_role
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT rd.code::public.user_role
  FROM public.user_roles ur
  JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
  WHERE ur.user_id = (SELECT auth.uid())
    AND (ur.expires_at IS NULL OR ur.expires_at > now())
    AND EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = ur.user_id AND p.is_active AND NOT p.is_banned
    )
    AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
  ORDER BY rd.priority ASC, rd.code ASC
  LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION public.has_permission(p_permission_code text)
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.role_permissions rp ON rp.role_id = rd.id
    JOIN public.permissions p ON p.id = rp.permission_id
    WHERE ur.user_id = (SELECT auth.uid())
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND p.code = p_permission_code
      AND EXISTS (
        SELECT 1 FROM public.profiles pr
        WHERE pr.id = ur.user_id AND pr.is_active AND NOT pr.is_banned
      )
  );
$$;
REVOKE ALL ON FUNCTION public.has_permission(text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.has_permission(text) TO authenticated;

-- Authenticated clients can read only the safe profile columns below. Private
-- profile fields are available through owner-bound RPCs; the directory view is
-- a deliberately narrow authenticated contract.
DROP POLICY IF EXISTS "profiles_select_active" ON public.profiles;
DROP POLICY IF EXISTS "profiles_select_self" ON public.profiles;
CREATE POLICY "profiles_select_active" ON public.profiles FOR SELECT TO authenticated
  USING (is_active AND NOT is_banned AND deleted_at IS NULL);

DROP POLICY IF EXISTS "profiles_update_self" ON public.profiles;
CREATE POLICY "profiles_update_self" ON public.profiles FOR UPDATE TO authenticated
  USING (id = (SELECT auth.uid()))
  WITH CHECK (id = (SELECT auth.uid()));

REVOKE SELECT, UPDATE ON public.profiles FROM PUBLIC, anon, authenticated;
REVOKE SELECT (
  id, email, full_name, full_name_ar, avatar_url, roles, student_id,
  national_id, nationality, phone, bio, bio_ar, college_id, department_id,
  advisor_id, warning_level, is_verified, tags, is_banned, is_active,
  created_at, updated_at, deleted_at
) ON public.profiles FROM PUBLIC, anon, authenticated;
GRANT SELECT (id, full_name, full_name_ar, avatar_url, college_id,
  department_id, created_at, updated_at) ON public.profiles TO authenticated;
REVOKE UPDATE ON public.profiles FROM PUBLIC, anon, authenticated;
REVOKE UPDATE (
  id, email, full_name, full_name_ar, avatar_url, roles, student_id,
  national_id, nationality, phone, bio, bio_ar, college_id, department_id,
  advisor_id, warning_level, is_verified, tags, is_banned, is_active,
  created_at, updated_at, deleted_at
) ON public.profiles FROM PUBLIC, anon, authenticated;
COMMENT ON COLUMN public.profiles.roles IS
  'Legacy compatibility cache only; canonical authorization is role_definitions/user_roles/permissions/role_permissions.';

ALTER TABLE public.role_definitions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.role_permissions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "role_definitions_read_active" ON public.role_definitions;
CREATE POLICY "role_definitions_read_active" ON public.role_definitions
  FOR SELECT TO authenticated USING (is_active);
DROP POLICY IF EXISTS "permissions_read_catalog" ON public.permissions;
CREATE POLICY "permissions_read_catalog" ON public.permissions
  FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "role_permissions_read_catalog" ON public.role_permissions;
CREATE POLICY "role_permissions_read_catalog" ON public.role_permissions
  FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "user_roles_select" ON public.user_roles;
CREATE POLICY "user_roles_select" ON public.user_roles
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid()));
GRANT SELECT ON public.role_definitions, public.permissions, public.role_permissions,
  public.user_roles TO authenticated;

CREATE OR REPLACE VIEW public.profile_directory
WITH (security_invoker = false)
AS
SELECT
  p.id,
  p.full_name,
  p.full_name_ar,
  p.avatar_url,
  p.college_id,
  p.department_id,
  p.created_at,
  COALESCE(
    array_agg(DISTINCT rd.code ORDER BY rd.code)
      FILTER (WHERE rd.code IS NOT NULL),
    ARRAY[]::text[]
  ) AS role_codes
FROM public.profiles p
LEFT JOIN public.user_roles ur
  ON ur.user_id = p.id AND (ur.expires_at IS NULL OR ur.expires_at > now())
LEFT JOIN public.role_definitions rd
  ON rd.id = ur.role_id AND rd.is_active
WHERE p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
GROUP BY p.id;
REVOKE ALL ON public.profile_directory FROM PUBLIC, anon;
GRANT SELECT ON public.profile_directory TO authenticated;
COMMENT ON VIEW public.profile_directory IS
  'Authenticated directory projection. Keep private profile data out of this owner-executed view.';

-- Private profile fields are available only through an owner-bound function.
CREATE OR REPLACE FUNCTION public.get_my_profile_private()
RETURNS TABLE (
  email text,
  phone text,
  bio text,
  bio_ar text,
  national_id text,
  nationality text,
  student_id text,
  advisor_id uuid,
  warning_level integer,
  is_verified boolean,
  tags text[],
  is_banned boolean,
  is_active boolean
)
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT p.email, p.phone, p.bio, p.bio_ar, p.national_id, p.nationality,
         p.student_id, p.advisor_id, p.warning_level, p.is_verified, p.tags,
         p.is_banned, p.is_active
  FROM public.profiles p
  WHERE p.id = (SELECT auth.uid());
$$;
REVOKE ALL ON FUNCTION public.get_my_profile_private() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_my_profile_private() TO authenticated;

CREATE OR REPLACE FUNCTION public.update_my_profile(
  p_full_name text,
  p_phone text,
  p_bio text,
  p_avatar_url text DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
BEGIN
  IF (SELECT auth.uid()) IS NULL THEN
    RAISE EXCEPTION 'authentication required' USING ERRCODE = '42501';
  END IF;
  UPDATE public.profiles
  SET full_name = p_full_name,
      phone = p_phone,
      bio = p_bio,
      avatar_url = COALESCE(p_avatar_url, avatar_url)
  WHERE id = (SELECT auth.uid());
END;
$$;
REVOKE ALL ON FUNCTION public.update_my_profile(text, text, text, text)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.update_my_profile(text, text, text, text)
  TO authenticated;

-- Keep privileged advisor assignment server-side and permission checked.
CREATE OR REPLACE FUNCTION public.assign_student_advisor(
  p_student_id uuid,
  p_advisor_id uuid
) RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
BEGIN
  IF (SELECT auth.uid()) IS NULL
     OR NOT public.has_permission('students.assign_advisor') THEN
    RAISE EXCEPTION 'insufficient privilege' USING ERRCODE = '42501';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_student_id AND p.is_active
      AND rd.code IN ('student', 'regular_student', 'freshman')
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
  ) OR (p_advisor_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_advisor_id AND p.is_active
      AND rd.code = 'academic_advisor'
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
  )) THEN
    RAISE EXCEPTION 'student or advisor is unavailable' USING ERRCODE = '22023';
  END IF;
  IF NOT public.has_permission('colleges.manage') AND EXISTS (
    SELECT 1
    FROM public.profiles student
    LEFT JOIN public.profiles caller ON caller.id = (SELECT auth.uid())
    WHERE student.id = p_student_id
      AND student.college_id IS DISTINCT FROM caller.college_id
  ) THEN
    RAISE EXCEPTION 'student is outside the caller college' USING ERRCODE = '42501';
  END IF;
  IF p_advisor_id IS NOT NULL AND EXISTS (
    SELECT 1
    FROM public.profiles student
    JOIN public.profiles advisor ON advisor.id = p_advisor_id
    WHERE student.id = p_student_id
      AND student.college_id IS DISTINCT FROM advisor.college_id
  ) THEN
    RAISE EXCEPTION 'advisor must belong to the student college' USING ERRCODE = '22023';
  END IF;
  UPDATE public.profiles SET advisor_id = p_advisor_id WHERE id = p_student_id;
END;
$$;
REVOKE ALL ON FUNCTION public.assign_student_advisor(uuid, uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.assign_student_advisor(uuid, uuid) TO authenticated;

CREATE OR REPLACE FUNCTION public.get_advisor_directory(
  p_college_id uuid DEFAULT NULL,
  p_assigned_to_me boolean DEFAULT FALSE,
  p_unassigned_only boolean DEFAULT FALSE
) RETURNS TABLE (
  id uuid,
  full_name text,
  email text,
  student_id text,
  avatar_url text,
  advisor_id uuid,
  department_id uuid,
  college_id uuid
)
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
BEGIN
  IF (SELECT auth.uid()) IS NULL
     OR NOT public.has_permission('students.advise') THEN
    RAISE EXCEPTION 'insufficient privilege' USING ERRCODE = '42501';
  END IF;
  IF NOT public.has_permission('students.assign_advisor')
     AND NOT p_assigned_to_me THEN
    RAISE EXCEPTION 'advisor access is limited to assigned students'
      USING ERRCODE = '42501';
  END IF;
  IF public.has_permission('students.assign_advisor')
     AND NOT public.has_permission('colleges.manage')
     AND (p_college_id IS NULL OR p_college_id IS DISTINCT FROM (
       SELECT p.college_id FROM public.profiles p WHERE p.id = (SELECT auth.uid())
     )) THEN
    RAISE EXCEPTION 'directory access is limited to the caller college'
      USING ERRCODE = '42501';
  END IF;
  RETURN QUERY
  SELECT p.id, p.full_name, p.email, p.student_id, p.avatar_url,
         p.advisor_id, p.department_id, p.college_id
  FROM public.profiles p
  WHERE p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
    AND (p_college_id IS NULL OR p.college_id = p_college_id)
    AND (p_assigned_to_me IS FALSE OR p.advisor_id = (SELECT auth.uid()))
    AND (p_unassigned_only IS FALSE OR p.advisor_id IS NULL)
    AND EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
      WHERE ur.user_id = p.id
        AND rd.code IN ('student', 'regular_student', 'freshman')
        AND (ur.expires_at IS NULL OR ur.expires_at > now())
    )
  ORDER BY p.full_name;
END;
$$;
REVOKE ALL ON FUNCTION public.get_advisor_directory(uuid, boolean, boolean)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_advisor_directory(uuid, boolean, boolean)
  TO authenticated;

-- Enforce the same canonical grant at the write boundary for post creation.
DROP POLICY IF EXISTS "posts_insert_auth" ON public.posts;
CREATE POLICY "posts_insert_auth" ON public.posts FOR INSERT TO authenticated
  WITH CHECK (
    author_id = (SELECT auth.uid())
    AND public.has_permission('posts.create')
  );
