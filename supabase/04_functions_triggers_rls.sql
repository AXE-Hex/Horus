-- ============================================================================
--  FILE 4 OF 5 — FUNCTIONS · TRIGGERS · ROW LEVEL SECURITY
--  Purpose : All business logic and access-control rules.
--            A. Utility functions (get_my_role)
--            B. Auth trigger (handle_new_user) + back-fill
--            C. Grade metrics trigger
--            D. Registration approval trigger
--            E. Student-count maintenance trigger
--            F. Admin management functions
--            G. Row Level Security policies for every table
--            H. Supabase Storage bucket + policies (post_media)
--  Depends : 03_tables.sql must have been executed first.
-- ============================================================================

-- ════════════════════════════════════════════════════════════════════════════
-- A. UTILITY FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════════

-- Returns the single most-privileged role of the current user.
-- Used extensively inside RLS policies to keep expressions concise.
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role
LANGUAGE plpgsql SECURITY DEFINER STABLE AS $$
DECLARE
  v_roles user_role[];
BEGIN
  SELECT roles INTO v_roles FROM public.profiles WHERE id = auth.uid();
  IF    'super_admin'       = ANY(v_roles) THEN RETURN 'super_admin'::user_role;
  ELSIF 'admin'             = ANY(v_roles) THEN RETURN 'admin'::user_role;
  ELSIF 'it_support'        = ANY(v_roles) THEN RETURN 'it_support'::user_role;
  ELSIF 'financial_auditor' = ANY(v_roles) THEN RETURN 'financial_auditor'::user_role;
  ELSIF array_length(v_roles, 1) > 0       THEN RETURN v_roles[1];
  ELSE                                          RETURN 'student'::user_role;
  END IF;
END;
$$;

-- ════════════════════════════════════════════════════════════════════════════
-- B. AUTH TRIGGER — handle_new_user
-- ════════════════════════════════════════════════════════════════════════════

-- Automatically creates a profile row whenever a new auth.users row is inserted.
-- Reads roles and full_name from raw_user_meta_data if provided.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_roles     user_role[];
  v_full_name TEXT;
BEGIN
  -- Guard: if a profile already exists for this e-mail, sync the id only.
  IF EXISTS (SELECT 1 FROM public.profiles WHERE email = NEW.email) THEN
    UPDATE public.profiles
      SET id = NEW.id
    WHERE email = NEW.email AND id <> NEW.id;
    RETURN NEW;
  END IF;

  -- Resolve roles array from metadata (supports both 'roles' array and 'role' string).
  IF NEW.raw_user_meta_data -> 'roles' IS NOT NULL THEN
    SELECT ARRAY(
      SELECT elem::user_role
      FROM jsonb_array_elements_text(NEW.raw_user_meta_data -> 'roles') AS elem
    ) INTO v_roles;
  ELSE
    v_roles := ARRAY[
      COALESCE((NEW.raw_user_meta_data ->> 'role')::user_role, 'student'::user_role)
    ];
  END IF;

  v_full_name := COALESCE(
    NULLIF(TRIM(NEW.raw_user_meta_data ->> 'full_name'), ''),
    NEW.email
  );

  INSERT INTO public.profiles (id, email, full_name, roles)
  VALUES (NEW.id, NEW.email, v_full_name, v_roles)
  ON CONFLICT (id) DO UPDATE SET
    email     = EXCLUDED.email,
    -- Only overwrite full_name if the profile still holds the placeholder (email).
    full_name = CASE
                  WHEN public.profiles.full_name = public.profiles.email
                  THEN EXCLUDED.full_name
                  ELSE public.profiles.full_name
                END,
    -- Only overwrite roles if the profile still has the default '{student}'.
    roles     = CASE
                  WHEN public.profiles.roles = '{student}'
                  THEN EXCLUDED.roles
                  ELSE public.profiles.roles
                END;

  RETURN NEW;
EXCEPTION WHEN OTHERS THEN
  RAISE WARNING 'handle_new_user failed for %: % (%)', NEW.id, SQLERRM, SQLSTATE;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Back-fill: create profile rows for any existing auth users that lack one.
DO $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, roles)
  SELECT
    u.id,
    u.email,
    COALESCE(NULLIF(TRIM(u.raw_user_meta_data ->> 'full_name'), ''), u.email),
    ARRAY[COALESCE((u.raw_user_meta_data ->> 'role')::user_role, 'student'::user_role)]
  FROM auth.users u
  WHERE u.id    NOT IN (SELECT id    FROM public.profiles)
    AND u.email NOT IN (SELECT email FROM public.profiles)
  ON CONFLICT (id) DO NOTHING;
END
$$;

-- ════════════════════════════════════════════════════════════════════════════
-- C. GRADE METRICS TRIGGER
-- ════════════════════════════════════════════════════════════════════════════

-- Automatically recalculates total, grade_letter, and gpa_points whenever
-- any of the four component scores change.
CREATE OR REPLACE FUNCTION public.calculate_grade_metrics()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
  NEW.total :=
    COALESCE(NEW.midterm,    0) +
    COALESCE(NEW.final_exam, 0) +
    COALESCE(NEW.coursework, 0) +
    COALESCE(NEW.practical,  0);

  NEW.grade_letter := CASE
    WHEN NEW.total >= 95 THEN 'A+'
    WHEN NEW.total >= 90 THEN 'A'
    WHEN NEW.total >= 85 THEN 'B+'
    WHEN NEW.total >= 80 THEN 'B'
    WHEN NEW.total >= 75 THEN 'C+'
    WHEN NEW.total >= 70 THEN 'C'
    WHEN NEW.total >= 65 THEN 'D+'
    WHEN NEW.total >= 60 THEN 'D'
    ELSE                      'F'
  END;

  NEW.gpa_points := CASE
    WHEN NEW.total >= 95 THEN 4.00
    WHEN NEW.total >= 90 THEN 3.75
    WHEN NEW.total >= 85 THEN 3.50
    WHEN NEW.total >= 80 THEN 3.00
    WHEN NEW.total >= 75 THEN 2.50
    WHEN NEW.total >= 70 THEN 2.00
    WHEN NEW.total >= 65 THEN 1.50
    WHEN NEW.total >= 60 THEN 1.00
    ELSE                      0.00
  END;

  -- Auto-stamp publication timestamp when first published.
  IF NEW.is_published = TRUE AND (OLD IS NULL OR OLD.is_published = FALSE) THEN
    NEW.published_at := now();
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS grades_metrics_trigger ON public.grades;
CREATE TRIGGER grades_metrics_trigger
  BEFORE INSERT OR UPDATE OF midterm, final_exam, coursework, practical, is_published
  ON public.grades
  FOR EACH ROW EXECUTE FUNCTION public.calculate_grade_metrics();

-- ════════════════════════════════════════════════════════════════════════════
-- D. REGISTRATION APPROVAL TRIGGER
-- ════════════════════════════════════════════════════════════════════════════

-- When an advisor approves a registration request, the selected courses are
-- written into student_course_registrations (replacing any prior semester list).
CREATE OR REPLACE FUNCTION public.on_registration_request_approved()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NEW.status = 'approved' AND OLD.status <> 'approved' THEN
    -- Replace the student's current semester registrations atomically.
    DELETE FROM public.student_course_registrations
      WHERE student_id = NEW.student_id AND semester = NEW.semester;

    INSERT INTO public.student_course_registrations
      (student_id, course_id, semester, section_name, sub_section_name, registered_at)
    SELECT
      NEW.student_id,
      rrc.course_id,
      NEW.semester,
      rrc.section_name,
      rrc.sub_section_name,
      now()
    FROM public.registration_request_courses rrc
    WHERE rrc.request_id = NEW.id;

    NEW.reviewed_at := now();
  END IF;

  IF NEW.status = 'rejected' AND OLD.status <> 'rejected' THEN
    NEW.reviewed_at := now();
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_request_approved ON public.registration_requests;
CREATE TRIGGER on_request_approved
  BEFORE UPDATE OF status ON public.registration_requests
  FOR EACH ROW EXECUTE FUNCTION public.on_registration_request_approved();

-- ════════════════════════════════════════════════════════════════════════════
-- E. STUDENT COUNT MAINTENANCE TRIGGER
-- ════════════════════════════════════════════════════════════════════════════

-- Keeps colleges.student_count and departments.student_count accurate
-- whenever a profile with role 'student' is inserted, updated, or deleted.
-- Uses GREATEST(0, ...) to prevent counts from going negative.
CREATE OR REPLACE FUNCTION public.update_student_count()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_was_student BOOLEAN;
  v_is_student  BOOLEAN;
BEGIN
  -- ── DELETE ────────────────────────────────────────────────────────────────
  IF TG_OP = 'DELETE' THEN
    IF OLD.roles @> ARRAY['student'::user_role] THEN
      IF OLD.college_id    IS NOT NULL THEN
        UPDATE public.colleges    SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.college_id;
      END IF;
      IF OLD.department_id IS NOT NULL THEN
        UPDATE public.departments SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.department_id;
      END IF;
    END IF;
    RETURN OLD;
  END IF;

  -- ── INSERT ────────────────────────────────────────────────────────────────
  IF TG_OP = 'INSERT' THEN
    IF NEW.roles @> ARRAY['student'::user_role] THEN
      IF NEW.college_id    IS NOT NULL THEN
        UPDATE public.colleges    SET student_count = student_count + 1 WHERE id = NEW.college_id;
      END IF;
      IF NEW.department_id IS NOT NULL THEN
        UPDATE public.departments SET student_count = student_count + 1 WHERE id = NEW.department_id;
      END IF;
    END IF;
    RETURN NEW;
  END IF;

  -- ── UPDATE ────────────────────────────────────────────────────────────────
  v_was_student := OLD.roles @> ARRAY['student'::user_role];
  v_is_student  := NEW.roles @> ARRAY['student'::user_role];

  -- Role gained: student
  IF v_is_student AND NOT v_was_student THEN
    IF NEW.college_id    IS NOT NULL THEN UPDATE public.colleges    SET student_count = student_count + 1 WHERE id = NEW.college_id;    END IF;
    IF NEW.department_id IS NOT NULL THEN UPDATE public.departments SET student_count = student_count + 1 WHERE id = NEW.department_id; END IF;

  -- Role lost: student
  ELSIF v_was_student AND NOT v_is_student THEN
    IF OLD.college_id    IS NOT NULL THEN UPDATE public.colleges    SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.college_id;    END IF;
    IF OLD.department_id IS NOT NULL THEN UPDATE public.departments SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.department_id; END IF;

  -- Still a student: check for college/department transfer
  ELSIF v_is_student AND v_was_student THEN
    IF OLD.college_id IS DISTINCT FROM NEW.college_id THEN
      IF OLD.college_id IS NOT NULL THEN UPDATE public.colleges SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.college_id; END IF;
      IF NEW.college_id IS NOT NULL THEN UPDATE public.colleges SET student_count = student_count + 1              WHERE id = NEW.college_id; END IF;
    END IF;
    IF OLD.department_id IS DISTINCT FROM NEW.department_id THEN
      IF OLD.department_id IS NOT NULL THEN UPDATE public.departments SET student_count = GREATEST(0, student_count - 1) WHERE id = OLD.department_id; END IF;
      IF NEW.department_id IS NOT NULL THEN UPDATE public.departments SET student_count = student_count + 1              WHERE id = NEW.department_id; END IF;
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_profile_college_dept_change ON public.profiles;
CREATE TRIGGER on_profile_college_dept_change
  AFTER INSERT OR UPDATE OR DELETE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_student_count();

-- ════════════════════════════════════════════════════════════════════════════
-- F. ADMIN MANAGEMENT FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════════
-- All admin functions follow the same pattern:
--   1. Check caller's role — raise EXCEPTION if unauthorized.
--   2. Execute the action.
--   3. Insert an audit_log row.
-- Parameters use a p_ prefix to avoid name collisions with column names.

-- ── admin_create_user ─────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_create_user(
  p_email         TEXT,
  p_password      TEXT,
  p_full_name     TEXT,
  p_roles         user_role[],
  p_student_id    TEXT  DEFAULT NULL,
  p_national_id   TEXT  DEFAULT NULL,
  p_nationality   TEXT  DEFAULT NULL,
  p_phone         TEXT  DEFAULT NULL,
  p_college_id    UUID  DEFAULT NULL,
  p_department_id UUID  DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_new_user_id        UUID;
  v_current_user_roles user_role[];
BEGIN
  SELECT roles INTO v_current_user_roles FROM public.profiles WHERE id = auth.uid();
  IF NOT (v_current_user_roles && ARRAY['super_admin','admin','it_support']::user_role[]) THEN
    RAISE EXCEPTION 'Unauthorized: Only admins can create users.';
  END IF;

  INSERT INTO auth.users (
    id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data,
    created_at, updated_at,
    confirmation_token, email_change, email_change_token_new, recovery_token
  ) VALUES (
    gen_random_uuid(),
    'authenticated', 'authenticated',
    p_email,
    crypt(p_password, gen_salt('bf', 10)),
    now(),
    '{"provider":"email","providers":["email"]}',
    jsonb_build_object('full_name', p_full_name, 'roles', p_roles::text[]),
    now(), now(), '', '', '', ''
  )
  RETURNING id INTO v_new_user_id;

  -- The handle_new_user trigger already created the profile; we enrich it here.
  UPDATE public.profiles SET
    student_id    = p_student_id,
    national_id   = p_national_id,
    nationality   = p_nationality,
    phone         = p_phone,
    college_id    = p_college_id,
    department_id = p_department_id,
    roles         = p_roles
  WHERE id = v_new_user_id;

  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), v_new_user_id, 'create', 'User created by admin');

  RETURN v_new_user_id;
END;
$$;

-- ── admin_toggle_user_status ──────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_toggle_user_status(p_user_id UUID, p_is_active BOOLEAN)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  UPDATE public.profiles
    SET is_active = p_is_active, updated_at = now()
  WHERE id = p_user_id;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_user_id, 'toggle_status', 'Status set to ' || p_is_active::text);
END;
$$;

-- ── admin_delete_user ─────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_delete_user(
  p_target_user_id UUID,
  p_hard_delete    BOOLEAN DEFAULT FALSE
)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  IF p_hard_delete THEN
    DELETE FROM auth.users WHERE id = p_target_user_id;
  ELSE
    UPDATE public.profiles
      SET deleted_at = now(), is_active = FALSE, updated_at = now()
    WHERE id = p_target_user_id;
  END IF;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_target_user_id, 'delete',
            CASE WHEN p_hard_delete THEN 'Hard delete' ELSE 'Soft delete' END);
END;
$$;

-- ── admin_toggle_verification ─────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_toggle_verification(p_user_id UUID, p_is_verified BOOLEAN)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  UPDATE public.profiles
    SET is_verified = p_is_verified, updated_at = now()
  WHERE id = p_user_id;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_user_id, 'update', 'Verification set to ' || p_is_verified::text);
END;
$$;

-- ── admin_toggle_ban ──────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_toggle_ban(p_user_id UUID, p_is_banned BOOLEAN)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  UPDATE public.profiles
    SET is_banned = p_is_banned, updated_at = now()
  WHERE id = p_user_id;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_user_id, 'update', 'Ban set to ' || p_is_banned::text);
END;
$$;

-- ── admin_update_tags ─────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_update_tags(p_user_id UUID, p_tags TEXT[])
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  UPDATE public.profiles
    SET tags = p_tags, updated_at = now()
  WHERE id = p_user_id;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_user_id, 'update', 'Tags updated');
END;
$$;

-- ── admin_update_warning_level ────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.admin_update_warning_level(p_user_id UUID, p_level INT)
RETURNS VOID
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF p_level < 0 THEN RAISE EXCEPTION 'Warning level cannot be negative'; END IF;
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  UPDATE public.profiles
    SET warning_level = p_level, updated_at = now()
  WHERE id = p_user_id;
  INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), p_user_id, 'update', 'Warning level set to ' || p_level::text);
END;
$$;

-- ════════════════════════════════════════════════════════════════════════════
-- G. ROW LEVEL SECURITY POLICIES
-- ════════════════════════════════════════════════════════════════════════════
-- Convention:
--   • Public read-only data  → simple USING (TRUE) or condition
--   • Own-data access        → auth.uid() = <owner_column>
--   • Role-gated full access → public.get_my_role() IN (...)
--   • Multiple permissive policies for the same command are OR-combined.

-- ── profiles ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "profiles_select" ON public.profiles;
CREATE POLICY "profiles_select"
  ON public.profiles FOR SELECT
  USING (
    deleted_at IS NULL
    OR public.get_my_role() IN ('super_admin','admin','it_support','financial_auditor')
  );

DROP POLICY IF EXISTS "profiles_update_own" ON public.profiles;
CREATE POLICY "profiles_update_own"
  ON public.profiles FOR UPDATE
  USING (
    auth.uid() = id
    OR public.get_my_role() IN ('super_admin','admin','it_support')
  );

DROP POLICY IF EXISTS "profiles_admin_all" ON public.profiles;
CREATE POLICY "profiles_admin_all"
  ON public.profiles FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','financial_auditor'));

-- ── colleges ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "colleges_select" ON public.colleges;
CREATE POLICY "colleges_select"
  ON public.colleges FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "colleges_admin_all" ON public.colleges;
CREATE POLICY "colleges_admin_all"
  ON public.colleges FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── departments ───────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "departments_select" ON public.departments;
CREATE POLICY "departments_select"
  ON public.departments FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "departments_admin_all" ON public.departments;
CREATE POLICY "departments_admin_all"
  ON public.departments FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── courses ───────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "courses_select" ON public.courses;
CREATE POLICY "courses_select"
  ON public.courses FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "courses_professor_select" ON public.courses;
CREATE POLICY "courses_professor_select"
  ON public.courses FOR SELECT
  USING (professor_id = auth.uid());   -- professors can see their own inactive courses

DROP POLICY IF EXISTS "courses_admin_all" ON public.courses;
CREATE POLICY "courses_admin_all"
  ON public.courses FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── department_projects ───────────────────────────────────────────────────────
DROP POLICY IF EXISTS "dept_projects_select" ON public.department_projects;
CREATE POLICY "dept_projects_select"
  ON public.department_projects FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "dept_projects_admin_all" ON public.department_projects;
CREATE POLICY "dept_projects_admin_all"
  ON public.department_projects FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','dean','department_head'));

-- ── professor_details ─────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "professor_details_select" ON public.professor_details;
CREATE POLICY "professor_details_select"
  ON public.professor_details FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "professor_details_own" ON public.professor_details;
CREATE POLICY "professor_details_own"
  ON public.professor_details FOR UPDATE
  USING (id = auth.uid());

DROP POLICY IF EXISTS "professor_details_admin_all" ON public.professor_details;
CREATE POLICY "professor_details_admin_all"
  ON public.professor_details FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── teaching_assistants ───────────────────────────────────────────────────────
DROP POLICY IF EXISTS "ta_select" ON public.teaching_assistants;
CREATE POLICY "ta_select"
  ON public.teaching_assistants FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "ta_professor_all" ON public.teaching_assistants;
CREATE POLICY "ta_professor_all"
  ON public.teaching_assistants FOR ALL
  USING (professor_id = auth.uid());

DROP POLICY IF EXISTS "ta_admin_all" ON public.teaching_assistants;
CREATE POLICY "ta_admin_all"
  ON public.teaching_assistants FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── course_sections / course_sub_sections ─────────────────────────────────────
DROP POLICY IF EXISTS "course_sections_select" ON public.course_sections;
CREATE POLICY "course_sections_select"
  ON public.course_sections FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "course_sections_admin_all" ON public.course_sections;
CREATE POLICY "course_sections_admin_all"
  ON public.course_sections FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','registrar_officer'));

DROP POLICY IF EXISTS "course_sub_sections_select" ON public.course_sub_sections;
CREATE POLICY "course_sub_sections_select"
  ON public.course_sub_sections FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "course_sub_sections_admin_all" ON public.course_sub_sections;
CREATE POLICY "course_sub_sections_admin_all"
  ON public.course_sub_sections FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','registrar_officer'));

-- ── student_registrations ─────────────────────────────────────────────────────
DROP POLICY IF EXISTS "student_reg_own_all" ON public.student_registrations;
CREATE POLICY "student_reg_own_all"
  ON public.student_registrations FOR ALL
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "student_reg_admin_all" ON public.student_registrations;
CREATE POLICY "student_reg_admin_all"
  ON public.student_registrations FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','registrar_officer'));

-- ── student_course_registrations ──────────────────────────────────────────────
DROP POLICY IF EXISTS "scr_own_select" ON public.student_course_registrations;
CREATE POLICY "scr_own_select"
  ON public.student_course_registrations FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "scr_admin_all" ON public.student_course_registrations;
CREATE POLICY "scr_admin_all"
  ON public.student_course_registrations FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','registrar_officer'));

-- ── registration_requests ─────────────────────────────────────────────────────
DROP POLICY IF EXISTS "rr_student_all" ON public.registration_requests;
CREATE POLICY "rr_student_all"
  ON public.registration_requests FOR ALL
  USING (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

DROP POLICY IF EXISTS "rr_advisor_select" ON public.registration_requests;
CREATE POLICY "rr_advisor_select"
  ON public.registration_requests FOR SELECT
  USING (
    advisor_id = auth.uid()
    OR 'academic_advisor' = ANY(
      SELECT unnest(roles) FROM public.profiles WHERE id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "rr_advisor_update" ON public.registration_requests;
CREATE POLICY "rr_advisor_update"
  ON public.registration_requests FOR UPDATE
  USING (
    advisor_id = auth.uid()
    OR 'academic_advisor' = ANY(
      SELECT unnest(roles) FROM public.profiles WHERE id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "rr_admin_all" ON public.registration_requests;
CREATE POLICY "rr_admin_all"
  ON public.registration_requests FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','dean','registrar_officer'));

-- ── registration_request_courses ─────────────────────────────────────────────
DROP POLICY IF EXISTS "rrc_student_all" ON public.registration_request_courses;
CREATE POLICY "rrc_student_all"
  ON public.registration_request_courses FOR ALL
  USING (
    request_id IN (
      SELECT id FROM public.registration_requests WHERE student_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "rrc_advisor_select" ON public.registration_request_courses;
CREATE POLICY "rrc_advisor_select"
  ON public.registration_request_courses FOR SELECT
  USING (
    request_id IN (
      SELECT id FROM public.registration_requests WHERE advisor_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "rrc_admin_all" ON public.registration_request_courses;
CREATE POLICY "rrc_admin_all"
  ON public.registration_request_courses FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','registrar_officer'));

-- ── enrollments ───────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "enrollments_student_select" ON public.enrollments;
CREATE POLICY "enrollments_student_select"
  ON public.enrollments FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "enrollments_admin_all" ON public.enrollments;
CREATE POLICY "enrollments_admin_all"
  ON public.enrollments FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','registrar_officer'));

-- ── grades ────────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "grades_student_select" ON public.grades;
CREATE POLICY "grades_student_select"
  ON public.grades FOR SELECT
  USING (student_id = auth.uid() AND is_published = TRUE);

DROP POLICY IF EXISTS "grades_professor_all" ON public.grades;
CREATE POLICY "grades_professor_all"
  ON public.grades FOR ALL
  USING (
    course_id IN (SELECT id FROM public.courses WHERE professor_id = auth.uid())
  );

DROP POLICY IF EXISTS "grades_admin_all" ON public.grades;
CREATE POLICY "grades_admin_all"
  ON public.grades FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── schedules ─────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "schedules_select" ON public.schedules;
CREATE POLICY "schedules_select"
  ON public.schedules FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "schedules_admin_all" ON public.schedules;
CREATE POLICY "schedules_admin_all"
  ON public.schedules FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','registrar_officer'));

-- ── exam_schedules ────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "exam_schedules_select" ON public.exam_schedules;
CREATE POLICY "exam_schedules_select"
  ON public.exam_schedules FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "exam_schedules_admin_all" ON public.exam_schedules;
CREATE POLICY "exam_schedules_admin_all"
  ON public.exam_schedules FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','registrar_officer'));

-- ── attendance ────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "attendance_student_select" ON public.attendance;
CREATE POLICY "attendance_student_select"
  ON public.attendance FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "attendance_professor_all" ON public.attendance;
CREATE POLICY "attendance_professor_all"
  ON public.attendance FOR ALL
  USING (
    course_id IN (SELECT id FROM public.courses WHERE professor_id = auth.uid())
    OR recorded_by = auth.uid()
  );

DROP POLICY IF EXISTS "attendance_admin_all" ON public.attendance;
CREATE POLICY "attendance_admin_all"
  ON public.attendance FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── office_hours ──────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "office_hours_select" ON public.office_hours;
CREATE POLICY "office_hours_select"
  ON public.office_hours FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "office_hours_professor_all" ON public.office_hours;
CREATE POLICY "office_hours_professor_all"
  ON public.office_hours FOR ALL
  USING (professor_id = auth.uid());

DROP POLICY IF EXISTS "office_hours_admin_all" ON public.office_hours;
CREATE POLICY "office_hours_admin_all"
  ON public.office_hours FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── action_plan_items ─────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "action_plan_student_all" ON public.action_plan_items;
CREATE POLICY "action_plan_student_all"
  ON public.action_plan_items FOR ALL
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "action_plan_advisor_select" ON public.action_plan_items;
CREATE POLICY "action_plan_advisor_select"
  ON public.action_plan_items FOR SELECT
  USING (
    student_id IN (
      SELECT id FROM public.profiles WHERE advisor_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "action_plan_admin_all" ON public.action_plan_items;
CREATE POLICY "action_plan_admin_all"
  ON public.action_plan_items FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','academic_advisor'));

-- ── posts ─────────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "posts_authenticated_select" ON public.posts;
CREATE POLICY "posts_authenticated_select"
  ON public.posts FOR SELECT
  USING (auth.role() = 'authenticated');

DROP POLICY IF EXISTS "posts_insert_own" ON public.posts;
CREATE POLICY "posts_insert_own"
  ON public.posts FOR INSERT
  WITH CHECK (auth.uid() = author_id);

DROP POLICY IF EXISTS "posts_update_own" ON public.posts;
CREATE POLICY "posts_update_own"
  ON public.posts FOR UPDATE
  USING (auth.uid() = author_id);

DROP POLICY IF EXISTS "posts_delete_own" ON public.posts;
CREATE POLICY "posts_delete_own"
  ON public.posts FOR DELETE
  USING (auth.uid() = author_id);

DROP POLICY IF EXISTS "posts_admin_all" ON public.posts;
CREATE POLICY "posts_admin_all"
  ON public.posts FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin'));

-- ── student_groups / group_members ────────────────────────────────────────────
DROP POLICY IF EXISTS "student_groups_select" ON public.student_groups;
CREATE POLICY "student_groups_select"
  ON public.student_groups FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "student_groups_professor_all" ON public.student_groups;
CREATE POLICY "student_groups_professor_all"
  ON public.student_groups FOR ALL
  USING (professor_id = auth.uid());

DROP POLICY IF EXISTS "student_groups_admin_all" ON public.student_groups;
CREATE POLICY "student_groups_admin_all"
  ON public.student_groups FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

DROP POLICY IF EXISTS "group_members_select" ON public.group_members;
CREATE POLICY "group_members_select"
  ON public.group_members FOR SELECT
  USING (
    group_id IN (SELECT id FROM public.student_groups WHERE is_active = TRUE)
  );

DROP POLICY IF EXISTS "group_members_student_own" ON public.group_members;
CREATE POLICY "group_members_student_own"
  ON public.group_members FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "group_members_professor_all" ON public.group_members;
CREATE POLICY "group_members_professor_all"
  ON public.group_members FOR ALL
  USING (
    group_id IN (
      SELECT id FROM public.student_groups WHERE professor_id = auth.uid()
    )
  );

-- ── announcements ─────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "announcements_select" ON public.announcements;
CREATE POLICY "announcements_select"
  ON public.announcements FOR SELECT
  USING (
    deleted_at IS NULL
    AND (expires_at IS NULL OR expires_at > now())
  );

DROP POLICY IF EXISTS "announcements_author_update" ON public.announcements;
CREATE POLICY "announcements_author_update"
  ON public.announcements FOR UPDATE
  USING (author_id = auth.uid());

DROP POLICY IF EXISTS "announcements_admin_all" ON public.announcements;
CREATE POLICY "announcements_admin_all"
  ON public.announcements FOR ALL
  USING (
    public.get_my_role() IN ('super_admin','admin','dean','department_head','professor','lecturer')
  );

-- ── shared_files ──────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "shared_files_public_select" ON public.shared_files;
CREATE POLICY "shared_files_public_select"
  ON public.shared_files FOR SELECT
  USING (is_public = TRUE AND deleted_at IS NULL);

DROP POLICY IF EXISTS "shared_files_own_all" ON public.shared_files;
CREATE POLICY "shared_files_own_all"
  ON public.shared_files FOR ALL
  USING (uploader_id = auth.uid());

DROP POLICY IF EXISTS "shared_files_admin_all" ON public.shared_files;
CREATE POLICY "shared_files_admin_all"
  ON public.shared_files FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── forums / forum_posts ──────────────────────────────────────────────────────
DROP POLICY IF EXISTS "forums_select" ON public.forums;
CREATE POLICY "forums_select"
  ON public.forums FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "forums_admin_all" ON public.forums;
CREATE POLICY "forums_admin_all"
  ON public.forums FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin'));

DROP POLICY IF EXISTS "forum_posts_select" ON public.forum_posts;
CREATE POLICY "forum_posts_select"
  ON public.forum_posts FOR SELECT USING (deleted_at IS NULL);

DROP POLICY IF EXISTS "forum_posts_insert_own" ON public.forum_posts;
CREATE POLICY "forum_posts_insert_own"
  ON public.forum_posts FOR INSERT
  WITH CHECK (author_id = auth.uid());

DROP POLICY IF EXISTS "forum_posts_update_own" ON public.forum_posts;
CREATE POLICY "forum_posts_update_own"
  ON public.forum_posts FOR UPDATE
  USING (author_id = auth.uid());

DROP POLICY IF EXISTS "forum_posts_admin_all" ON public.forum_posts;
CREATE POLICY "forum_posts_admin_all"
  ON public.forum_posts FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin'));

-- ── support_tickets ───────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "tickets_own_all" ON public.support_tickets;
CREATE POLICY "tickets_own_all"
  ON public.support_tickets FOR ALL
  USING (user_id = auth.uid());

DROP POLICY IF EXISTS "tickets_support_all" ON public.support_tickets;
CREATE POLICY "tickets_support_all"
  ON public.support_tickets FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── professor_ratings ─────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "ratings_student_own_all" ON public.professor_ratings;
CREATE POLICY "ratings_student_own_all"
  ON public.professor_ratings FOR ALL
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "ratings_professor_select" ON public.professor_ratings;
CREATE POLICY "ratings_professor_select"
  ON public.professor_ratings FOR SELECT
  USING (professor_id = auth.uid());

DROP POLICY IF EXISTS "ratings_admin_all" ON public.professor_ratings;
CREATE POLICY "ratings_admin_all"
  ON public.professor_ratings FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin'));

-- ── invoices ──────────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "invoices_student_select" ON public.invoices;
CREATE POLICY "invoices_student_select"
  ON public.invoices FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "invoices_admin_all" ON public.invoices;
CREATE POLICY "invoices_admin_all"
  ON public.invoices FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','financial_auditor'));

-- ── notifications ─────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "notifications_own_all" ON public.notifications;
CREATE POLICY "notifications_own_all"
  ON public.notifications FOR ALL
  USING (user_id = auth.uid());

DROP POLICY IF EXISTS "notifications_admin_all" ON public.notifications;
CREATE POLICY "notifications_admin_all"
  ON public.notifications FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── user_sessions ─────────────────────────────────────────────────────────────
DROP POLICY IF EXISTS "sessions_own_all" ON public.user_sessions;
CREATE POLICY "sessions_own_all"
  ON public.user_sessions FOR ALL
  USING (user_id = auth.uid());

DROP POLICY IF EXISTS "sessions_admin_select" ON public.user_sessions;
CREATE POLICY "sessions_admin_select"
  ON public.user_sessions FOR SELECT
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- ── audit_logs ────────────────────────────────────────────────────────────────
-- Audit logs are INSERT-only from functions; no user should be able to UPDATE or DELETE.
DROP POLICY IF EXISTS "audit_logs_admin_select" ON public.audit_logs;
CREATE POLICY "audit_logs_admin_select"
  ON public.audit_logs FOR SELECT
  USING (public.get_my_role() IN ('super_admin','admin','it_support','financial_auditor'));

DROP POLICY IF EXISTS "audit_logs_service_insert" ON public.audit_logs;
CREATE POLICY "audit_logs_service_insert"
  ON public.audit_logs FOR INSERT
  WITH CHECK (TRUE);   -- controlled exclusively by SECURITY DEFINER functions

-- ════════════════════════════════════════════════════════════════════════════
-- H. SUPABASE STORAGE — post_media BUCKET
-- ════════════════════════════════════════════════════════════════════════════

INSERT INTO storage.buckets (id, name, public)
VALUES ('post_media', 'post_media', true)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS "post_media_select" ON storage.objects;
CREATE POLICY "post_media_select"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'post_media');

DROP POLICY IF EXISTS "post_media_insert" ON storage.objects;
CREATE POLICY "post_media_insert"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'post_media' AND auth.role() = 'authenticated');

DROP POLICY IF EXISTS "post_media_update" ON storage.objects;
CREATE POLICY "post_media_update"
  ON storage.objects FOR UPDATE
  USING (bucket_id = 'post_media' AND auth.uid() = owner);

DROP POLICY IF EXISTS "post_media_delete" ON storage.objects;
CREATE POLICY "post_media_delete"
  ON storage.objects FOR DELETE
  USING (bucket_id = 'post_media' AND auth.uid() = owner);

-- ════════════════════════════════════════════════════════════════════════════
-- I. TABLE-LEVEL GRANTS
-- ════════════════════════════════════════════════════════════════════════════
-- RLS policies control row-level access, but the PostgreSQL roles also need
-- table-level GRANT permissions. Without these, queries fail with:
--   "permission denied for table <name>" (42501)
--
-- Supabase uses two key roles:
--   • authenticated — logged-in users (JWT with sub claim)
--   • anon          — unauthenticated / public access

-- Grant usage on the public schema
GRANT USAGE ON SCHEMA public TO authenticated, anon;

-- Grant all DML operations on ALL current and future tables in public schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO anon;

-- Ensure future tables also get the same grants automatically
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT ON TABLES TO anon;

-- Grant usage on all sequences (needed for serial/auto-increment columns)
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE ON SEQUENCES TO authenticated;

-- Grant execute on all functions
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT EXECUTE ON FUNCTIONS TO authenticated;

-- ════════════════════════════════════════════════════════════════════════════
-- J. SUPABASE REALTIME — enable change events for key tables
-- ════════════════════════════════════════════════════════════════════════════
-- The supabase_realtime publication must include any table the client listens
-- to via .onPostgresChanges(). Without this, Realtime silently ignores changes.

ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;