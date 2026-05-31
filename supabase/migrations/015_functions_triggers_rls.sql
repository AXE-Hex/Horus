-- ============================================================================
--  015_functions_triggers_rls.sql — BUSINESS LOGIC & SECURITY
--  Purpose : All database functions, triggers, and Row Level Security policies.
--  Depends : All prior migrations (001 - 014)
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. UTILITY FUNCTIONS
-- ══════════════════════════════════════════════════════════════════════════════

-- get_my_role()
-- Performance optimization: Extracts role from JWT claims if available.
-- Fallbacks to the user_roles table if the claim is missing.
-- STABLE + SECURITY DEFINER ensures it runs fast and bypasses RLS on profiles.
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
DECLARE
  jwt_role TEXT;
  db_role user_role;
BEGIN
  -- 1. Try to read from JWT claims (fastest, no DB lookup)
  jwt_role := nullif(current_setting('request.jwt.claim.user_role', true), '');
  IF jwt_role IS NOT NULL THEN
    RETURN jwt_role::user_role;
  END IF;

  -- 2. Fallback to DB lookup (cache miss or running from SQL console)
  SELECT rd.code::user_role INTO db_role
  FROM public.user_roles ur
  JOIN public.role_definitions rd ON ur.role_id = rd.id
  WHERE ur.user_id = auth.uid()
  ORDER BY rd.priority ASC
  LIMIT 1;
  
  RETURN COALESCE(db_role, 'student'::user_role);
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path = public;

-- update_student_count()
-- Maintains the denormalized student counts on colleges and departments
CREATE OR REPLACE FUNCTION public.update_student_count()
RETURNS TRIGGER AS $$
BEGIN
  -- Handle DELETES or Updates where college/dept changes
  IF (TG_OP = 'DELETE' OR TG_OP = 'UPDATE') THEN
    IF OLD.college_id IS NOT NULL THEN
      UPDATE public.colleges SET student_count = student_count - 1 WHERE id = OLD.college_id AND student_count > 0;
    END IF;
    IF OLD.department_id IS NOT NULL THEN
      UPDATE public.departments SET student_count = student_count - 1 WHERE id = OLD.department_id AND student_count > 0;
    END IF;
  END IF;

  -- Handle INSERTS or Updates where college/dept changes
  IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
    IF NEW.college_id IS NOT NULL THEN
      UPDATE public.colleges SET student_count = student_count + 1 WHERE id = NEW.college_id;
    END IF;
    IF NEW.department_id IS NOT NULL THEN
      UPDATE public.departments SET student_count = student_count + 1 WHERE id = NEW.department_id;
    END IF;
  END IF;
  
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_profile_college_dept_change
  AFTER INSERT OR UPDATE OF college_id, department_id OR DELETE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_student_count();

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. AUTHENTICATION TRIGGERS
-- ══════════════════════════════════════════════════════════════════════════════

-- handle_new_user()
-- Automatically creates a profile when a new user signs up in Supabase Auth
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE
  default_role_id UUID;
BEGIN
  -- Get default student role ID
  SELECT id INTO default_role_id FROM public.role_definitions WHERE code = 'student' LIMIT 1;

  INSERT INTO public.profiles (
    id, email, full_name, full_name_ar, is_active, created_at, updated_at
  )
  VALUES (
    new.id,
    new.email,
    COALESCE(new.raw_user_meta_data->>'full_name', split_part(new.email, '@', 1)),
    new.raw_user_meta_data->>'full_name_ar',
    TRUE,
    now(),
    now()
  );

  -- Assign default role
  IF default_role_id IS NOT NULL THEN
    INSERT INTO public.user_roles (user_id, role_id) VALUES (new.id, default_role_id);
  END IF;

  -- Create preference records
  INSERT INTO public.user_preferences (user_id) VALUES (new.id);
  INSERT INTO public.notification_preferences (user_id) VALUES (new.id);

  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. ENCRYPTION LOGIC
-- ══════════════════════════════════════════════════════════════════════════════

-- Encrypt sensitive data
CREATE OR REPLACE FUNCTION public.fn_encrypt_field(
  p_target_id UUID,
  p_context encryption_context,
  p_table_name TEXT,
  p_plain_text TEXT
) RETURNS VOID AS $$
DECLARE
  v_key_hash TEXT;
  v_cipher_text BYTEA;
BEGIN
  -- Get encryption key for context
  SELECT key_hash INTO v_key_hash FROM public.encryption_keys WHERE context = p_context;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Encryption key not found for context %', p_context;
  END IF;

  -- Encrypt
  v_cipher_text := pgp_sym_encrypt(p_plain_text, v_key_hash);

  -- Store
  INSERT INTO public.encrypted_data (target_id, target_table, context, cipher_text)
  VALUES (p_target_id, p_table_name, p_context, v_cipher_text)
  ON CONFLICT (target_id, target_table, context) 
  DO UPDATE SET cipher_text = v_cipher_text, updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. ROW LEVEL SECURITY (RLS) POLICIES
-- ══════════════════════════════════════════════════════════════════════════════

-- Note: All policies use EXISTS instead of IN (SELECT) for optimal performance.

-- ── PROFILES ──
DROP POLICY IF EXISTS "profiles_select_active" ON public.profiles;
CREATE POLICY "profiles_select_active" ON public.profiles FOR SELECT
  USING (is_active = TRUE AND deleted_at IS NULL);

DROP POLICY IF EXISTS "profiles_update_self" ON public.profiles;
CREATE POLICY "profiles_update_self" ON public.profiles FOR UPDATE
  USING (id = auth.uid());

-- ── USER_ROLES ──
DROP POLICY IF EXISTS "user_roles_select" ON public.user_roles;
CREATE POLICY "user_roles_select" ON public.user_roles FOR SELECT
  USING (TRUE); -- Roles are public info internally

-- ── COLLEGES & DEPARTMENTS ──
DROP POLICY IF EXISTS "colleges_select" ON public.colleges;
CREATE POLICY "colleges_select" ON public.colleges FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "departments_select" ON public.departments;
CREATE POLICY "departments_select" ON public.departments FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "semesters_select" ON public.semesters;
CREATE POLICY "semesters_select" ON public.semesters FOR SELECT USING (is_active = TRUE);

-- ── COURSES & SCHEDULES ──
DROP POLICY IF EXISTS "courses_select" ON public.courses;
CREATE POLICY "courses_select" ON public.courses FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "schedules_select" ON public.schedules;
CREATE POLICY "schedules_select" ON public.schedules FOR SELECT USING (TRUE);

-- ── ENROLLMENTS & GRADES ──
DROP POLICY IF EXISTS "enrollments_select_self" ON public.enrollments;
CREATE POLICY "enrollments_select_self" ON public.enrollments FOR SELECT
  USING (student_id = auth.uid());

DROP POLICY IF EXISTS "enrollments_select_professor" ON public.enrollments;
CREATE POLICY "enrollments_select_professor" ON public.enrollments FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = public.enrollments.course_id AND c.professor_id = auth.uid()
  ));

DROP POLICY IF EXISTS "grades_select_published" ON public.grades;
CREATE POLICY "grades_select_published" ON public.grades FOR SELECT
  USING (student_id = auth.uid() AND is_published = TRUE);

DROP POLICY IF EXISTS "grades_select_professor" ON public.grades;
CREATE POLICY "grades_select_professor" ON public.grades FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = public.grades.course_id AND c.professor_id = auth.uid()
  ));

-- ── POSTS & SOCIAL ──
DROP POLICY IF EXISTS "posts_select_active" ON public.posts;
CREATE POLICY "posts_select_active" ON public.posts FOR SELECT
  USING (deleted_at IS NULL);

DROP POLICY IF EXISTS "posts_insert_auth" ON public.posts;
CREATE POLICY "posts_insert_auth" ON public.posts FOR INSERT
  WITH CHECK (author_id = auth.uid());

DROP POLICY IF EXISTS "posts_update_own" ON public.posts;
CREATE POLICY "posts_update_own" ON public.posts FOR UPDATE
  USING (author_id = auth.uid() AND deleted_at IS NULL);

-- ── MESSAGING ──
DROP POLICY IF EXISTS "conversations_select_member" ON public.conversations;
CREATE POLICY "conversations_select_member" ON public.conversations FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = id AND cm.user_id = auth.uid()
  ));

DROP POLICY IF EXISTS "messages_select_member" ON public.messages;
CREATE POLICY "messages_select_member" ON public.messages FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = messages.conversation_id AND cm.user_id = auth.uid()
  ));

DROP POLICY IF EXISTS "messages_insert_member" ON public.messages;
CREATE POLICY "messages_insert_member" ON public.messages FOR INSERT
  WITH CHECK (
    sender_id = auth.uid() AND
    EXISTS (
      SELECT 1 FROM public.conversation_members cm
      WHERE cm.conversation_id = messages.conversation_id AND cm.user_id = auth.uid()
    )
  );

-- ── FINANCIAL ──
DROP POLICY IF EXISTS "invoices_select_own" ON public.invoices;
CREATE POLICY "invoices_select_own" ON public.invoices FOR SELECT
  USING (student_id = auth.uid());

-- ── AUDIT LOGS ──
DROP POLICY IF EXISTS "audit_logs_insert_service" ON public.audit_logs;
CREATE POLICY "audit_logs_insert_service" ON public.audit_logs FOR INSERT
  WITH CHECK (TRUE); -- Handled exclusively by SECURITY DEFINER functions

DROP POLICY IF EXISTS "audit_logs_select_admin" ON public.audit_logs;
DROP POLICY IF EXISTS "audit_logs_select_privileged" ON public.audit_logs;
CREATE POLICY "audit_logs_select_privileged" ON public.audit_logs FOR SELECT
  USING (FALSE);

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. REALTIME CONFIGURATION
-- ══════════════════════════════════════════════════════════════════════════════
-- Enable Supabase Realtime subscriptions for critical client-facing tables

-- First drop publication if it exists to cleanly rebuild it
DO $$ BEGIN
  EXECUTE 'DROP PUBLICATION IF EXISTS supabase_realtime';
EXCEPTION WHEN OTHERS THEN NULL;
END $$;

CREATE PUBLICATION supabase_realtime FOR TABLE 
  public.messages, 
  public.conversations, 
  public.notifications,
  public.posts,
  public.post_comments,
  public.post_likes;

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP PUBLICATION IF EXISTS supabase_realtime;
-- DROP POLICY IF EXISTS "audit_logs_select_admin" ON public.audit_logs;
-- DROP POLICY IF EXISTS "audit_logs_insert_service" ON public.audit_logs;
-- DROP POLICY IF EXISTS "invoices_select_own" ON public.invoices;
-- DROP POLICY IF EXISTS "messages_insert_member" ON public.messages;
-- DROP POLICY IF EXISTS "messages_select_member" ON public.messages;
-- DROP POLICY IF EXISTS "conversations_select_member" ON public.conversations;
-- DROP POLICY IF EXISTS "posts_update_own" ON public.posts;
-- DROP POLICY IF EXISTS "posts_insert_auth" ON public.posts;
-- DROP POLICY IF EXISTS "posts_select_active" ON public.posts;
-- DROP POLICY IF EXISTS "grades_select_professor" ON public.grades;
-- DROP POLICY IF EXISTS "grades_select_published" ON public.grades;
-- DROP POLICY IF EXISTS "enrollments_select_professor" ON public.enrollments;
-- DROP POLICY IF EXISTS "enrollments_select_self" ON public.enrollments;
-- DROP POLICY IF EXISTS "schedules_select" ON public.schedules;
-- DROP POLICY IF EXISTS "courses_select" ON public.courses;
-- DROP POLICY IF EXISTS "semesters_select" ON public.semesters;
-- DROP POLICY IF EXISTS "departments_select" ON public.departments;
-- DROP POLICY IF EXISTS "colleges_select" ON public.colleges;
-- DROP POLICY IF EXISTS "user_roles_select" ON public.user_roles;
-- DROP POLICY IF EXISTS "profiles_update_self" ON public.profiles;
-- DROP POLICY IF EXISTS "profiles_select_active" ON public.profiles;
-- DROP FUNCTION IF EXISTS public.fn_encrypt_field(UUID, encryption_context, TEXT, TEXT);
-- DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
-- DROP FUNCTION IF EXISTS public.handle_new_user();
-- DROP TRIGGER IF EXISTS on_profile_college_dept_change ON public.profiles;
-- DROP FUNCTION IF EXISTS public.update_student_count();
-- DROP FUNCTION IF EXISTS public.get_my_role();
-- ════════════════════════════════════════════════════════════════════════════
