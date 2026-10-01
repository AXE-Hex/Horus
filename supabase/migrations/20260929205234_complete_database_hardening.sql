-- Forward-only hardening. No operational records are deleted.
-- NOT VALID constraints enforce new writes without rewriting historical data.
REVOKE CREATE ON SCHEMA public FROM PUBLIC, anon, authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE ALL ON TABLES FROM PUBLIC, anon, authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE ALL ON SEQUENCES FROM PUBLIC, anon, authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
  REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC, anon, authenticated;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC, anon, authenticated;
ALTER TABLE public.profiles ALTER COLUMN roles SET DEFAULT '{}'::public.user_role[];

-- External roles have no verified relationship or internal directory purpose.
DELETE FROM public.role_permissions rp USING public.role_definitions rd, public.permissions p
WHERE rp.role_id = rd.id AND rp.permission_id = p.id
  AND (rd.code = 'guest'
    OR (rd.code IN ('parent', 'recruiter', 'dorm_supervisor', 'security_officer') AND p.code = 'profiles.read')
    OR (rd.code = 'class_representative' AND p.code = 'announcements.create')
    OR (rd.code = 'librarian' AND p.code = 'materials.upload'));


CREATE OR REPLACE FUNCTION public.get_my_role()
 RETURNS user_role
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT rd.code::public.user_role
  FROM public.user_roles ur
  JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
  WHERE ur.user_id = (SELECT auth.uid())
    AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
    AND EXISTS (SELECT 1 FROM public.profiles p
      WHERE p.id = ur.user_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL)
    AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
  ORDER BY rd.priority ASC, rd.code ASC
  LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.has_permission(p_permission_code text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.role_permissions rp ON rp.role_id = rd.id
    JOIN public.permissions p ON p.id = rp.permission_id
    JOIN public.profiles pr ON pr.id = ur.user_id
    WHERE ur.user_id = (SELECT auth.uid())
      AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
      AND p.code = p_permission_code
      AND pr.is_active AND NOT pr.is_banned AND pr.deleted_at IS NULL
  );
$function$
;


CREATE FUNCTION public.is_active_university_member() RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = pg_catalog, public, auth
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.profiles p ON p.id = ur.user_id
    WHERE ur.user_id = (SELECT auth.uid()) AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
      AND rd.code NOT IN ('guest', 'parent', 'recruiter')
  );
$$;
REVOKE ALL ON FUNCTION public.is_active_university_member() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.is_active_university_member() TO authenticated;
COMMENT ON FUNCTION public.is_active_university_member() IS
  'Account-wide restrictive boundary; existing permissive policies still decide each operation and scope.';

-- Restrictive policies cannot grant access; they intersect all existing policies.
DO $boundary$
DECLARE t record; predicate text;
BEGIN
  FOR t IN SELECT c.relname FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
    WHERE n.nspname='public' AND c.relkind IN ('r','p')
  LOOP
    predicate := CASE WHEN t.relname IN (
      'profiles','user_roles','role_definitions','permissions','role_permissions',
      'user_preferences','notification_preferences','user_sessions')
      THEN '(SELECT public.get_my_role()) IS NOT NULL'
      ELSE '(SELECT public.is_active_university_member())' END;
    EXECUTE format('CREATE POLICY %I ON public.%I AS RESTRICTIVE FOR ALL TO authenticated USING (%s) WITH CHECK (%s)',
      t.relname || '_account_boundary', t.relname, predicate, predicate);
  END LOOP;
END;
$boundary$;

CREATE FUNCTION public.can_manage_college_departments(p_college_id uuid) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = pg_catalog, public, auth
AS $$
  SELECT EXISTS (SELECT 1 FROM public.profiles actor
    WHERE actor.id=(SELECT auth.uid()) AND (
      (public.has_permission('departments.manage') AND actor.college_id=p_college_id)
      OR (public.has_permission('colleges.manage') AND actor.college_id IS NULL)));
$$;
REVOKE ALL ON FUNCTION public.can_manage_college_departments(uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.can_manage_college_departments(uuid) TO authenticated;
DROP POLICY departments_manage_scope ON public.departments;
CREATE POLICY departments_manage_scope ON public.departments FOR ALL TO authenticated
  USING (public.can_manage_department(id))
  WITH CHECK (public.can_manage_college_departments(college_id));

-- Membership lookups bypass only their own recursive RLS, with caller binding.
CREATE FUNCTION public.is_conversation_member(p_conversation_id uuid) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.is_active_university_member() AND EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id=p_conversation_id AND cm.user_id=(SELECT auth.uid()));
$$;
CREATE FUNCTION public.is_conversation_creator(p_conversation_id uuid) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.is_active_university_member() AND EXISTS (
    SELECT 1 FROM public.conversations c
    WHERE c.id=p_conversation_id AND c.created_by=(SELECT auth.uid()));
$$;
REVOKE ALL ON FUNCTION public.is_conversation_member(uuid), public.is_conversation_creator(uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.is_conversation_member(uuid), public.is_conversation_creator(uuid) TO authenticated;
DROP POLICY conversation_members_select_member ON public.conversation_members;
CREATE POLICY conversation_members_select_member ON public.conversation_members FOR SELECT TO authenticated
  USING (public.is_conversation_member(conversation_id));
DROP POLICY conversation_members_insert_creator ON public.conversation_members;
CREATE POLICY conversation_members_insert_creator ON public.conversation_members FOR INSERT TO authenticated
  WITH CHECK (public.is_conversation_creator(conversation_id)
    AND EXISTS (SELECT 1 FROM public.profiles p WHERE p.id=user_id)
    AND EXISTS (SELECT 1 FROM public.profile_directory p WHERE p.id=user_id
      AND p.role_codes && ARRAY['rector','dean','department_head','assistant_hod','academic_coordinator',
        'professor','lecturer','teaching_assistant','registrar_officer','academic_advisor','librarian',
        'freshman','regular_student','student','class_representative','alumni','dorm_supervisor','security_officer']));
DROP POLICY conversation_members_delete_self_or_creator ON public.conversation_members;
CREATE POLICY conversation_members_delete_self_or_creator ON public.conversation_members FOR DELETE TO authenticated
  USING (user_id=(SELECT auth.uid()) OR public.is_conversation_creator(conversation_id));
DROP POLICY conversations_member_select ON public.conversations;
CREATE POLICY conversations_member_select ON public.conversations FOR SELECT TO authenticated
  USING (public.is_conversation_member(id) OR public.is_conversation_creator(id));

-- Only notification acknowledgement fields are client writable.
REVOKE UPDATE ON public.notifications FROM authenticated;
GRANT UPDATE (is_read, read_at) ON public.notifications TO authenticated;
-- Meeting host URLs are privileged credentials, not participant resources.
REVOKE SELECT ON public.virtual_classes FROM authenticated;
GRANT SELECT (id,course_id,title,title_ar,provider,meeting_id,join_url,passcode,status,
  scheduled_at,duration_minutes,actual_start_at,actual_end_at,recording_url,
  attendance_taken,max_participants,actual_attendees,semester,semester_id,
  created_by,created_at,updated_at) ON public.virtual_classes TO authenticated;


CREATE OR REPLACE FUNCTION public.update_my_profile(p_full_name text, p_phone text, p_bio text, p_avatar_url text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
BEGIN
  IF public.get_my_role() IS NULL THEN
    RAISE EXCEPTION 'authentication required' USING ERRCODE = '42501';
  END IF;
  UPDATE public.profiles
  SET full_name = p_full_name,
      phone = p_phone,
      bio = p_bio,
      avatar_url = COALESCE(p_avatar_url, avatar_url)
  WHERE id = (SELECT auth.uid());
END;
$function$
;

CREATE OR REPLACE FUNCTION public.get_my_profile_private()
 RETURNS TABLE(email text, phone text, bio text, bio_ar text, national_id text, nationality text, student_id text, advisor_id uuid, warning_level integer, is_verified boolean, tags text[], is_banned boolean, is_active boolean)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT p.email, p.phone, p.bio, p.bio_ar, p.national_id, p.nationality,
         p.student_id, p.advisor_id, p.warning_level, p.is_verified, p.tags,
         p.is_banned, p.is_active
  FROM public.profiles p
  WHERE p.id = (SELECT auth.uid()) AND public.get_my_role() IS NOT NULL;
$function$
;

CREATE OR REPLACE FUNCTION public.assign_student_advisor(p_student_id uuid, p_advisor_id uuid)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
BEGIN
  IF (SELECT auth.uid()) IS NULL
     OR NOT public.has_permission('students.assign_advisor') THEN
    RAISE EXCEPTION 'insufficient privilege' USING ERRCODE = '42501';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_student_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code IN ('student', 'regular_student', 'freshman')
      AND ur.granted_at <= now() AND (ur.expires_at IS NULL OR ur.expires_at > now())
  ) OR (p_advisor_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_advisor_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code = 'academic_advisor'
      AND ur.granted_at <= now() AND (ur.expires_at IS NULL OR ur.expires_at > now())
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
$function$
;

CREATE OR REPLACE FUNCTION public.can_access_storage_conversation(p_conversation_id text)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
DECLARE
  v_conversation_id uuid;
BEGIN
  IF NOT public.is_active_university_member() OR p_conversation_id IS NULL OR p_conversation_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' THEN
    RETURN false;
  END IF;
  v_conversation_id := p_conversation_id::uuid;
  RETURN EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = v_conversation_id
      AND cm.user_id = (SELECT auth.uid())
  );
END;
$function$
;


-- Keep avatar public reads intentional; private reads and every mutation need
-- an active account. Guest avatars remain a self-service identity operation.
CREATE POLICY objects_account_read_boundary ON storage.objects AS RESTRICTIVE
  FOR SELECT TO authenticated USING (bucket_id='avatars' OR (SELECT public.is_active_university_member()));
CREATE POLICY objects_account_insert_boundary ON storage.objects AS RESTRICTIVE
  FOR INSERT TO authenticated WITH CHECK ((SELECT public.get_my_role()) IS NOT NULL
    AND (bucket_id='avatars' OR (SELECT public.is_active_university_member())));
CREATE POLICY objects_account_update_boundary ON storage.objects AS RESTRICTIVE
  FOR UPDATE TO authenticated USING ((SELECT public.get_my_role()) IS NOT NULL
    AND (bucket_id='avatars' OR (SELECT public.is_active_university_member())))
  WITH CHECK ((SELECT public.get_my_role()) IS NOT NULL
    AND (bucket_id='avatars' OR (SELECT public.is_active_university_member())));
CREATE POLICY objects_account_delete_boundary ON storage.objects AS RESTRICTIVE
  FOR DELETE TO authenticated USING ((SELECT public.get_my_role()) IS NOT NULL
    AND (bucket_id='avatars' OR (SELECT public.is_active_university_member())));

-- RLS checks original/resulting scope. Identity immutability additionally stops
-- moving an existing academic record between two otherwise authorized targets.
CREATE FUNCTION public.enforce_client_record_identity() RETURNS trigger
LANGUAGE plpgsql SET search_path = pg_catalog
AS $$
DECLARE column_name text;
BEGIN
  IF current_user IN ('authenticated','anon') THEN
    FOREACH column_name IN ARRAY TG_ARGV LOOP
      IF to_jsonb(NEW)->column_name IS DISTINCT FROM to_jsonb(OLD)->column_name THEN
        RAISE EXCEPTION 'record identity is immutable' USING ERRCODE='42501';
      END IF;
    END LOOP;
  END IF;
  RETURN NEW;
END;
$$;
REVOKE ALL ON FUNCTION public.enforce_client_record_identity() FROM PUBLIC, anon, authenticated;


CREATE TRIGGER grades_immutable_identity BEFORE UPDATE ON public.grades
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','course_id','semester','semester_id');

CREATE TRIGGER attendance_immutable_identity BEFORE UPDATE ON public.attendance
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','course_id','date','recorded_by');

CREATE TRIGGER enrollments_immutable_identity BEFORE UPDATE ON public.enrollments
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','course_id','semester','semester_id');

CREATE TRIGGER student_registrations_immutable_identity BEFORE UPDATE ON public.student_registrations
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','semester','semester_id');

CREATE TRIGGER student_course_registrations_immutable_identity BEFORE UPDATE ON public.student_course_registrations
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','course_id','semester','semester_id');

CREATE TRIGGER virtual_class_attendance_immutable_identity BEFORE UPDATE ON public.virtual_class_attendance
 FOR EACH ROW EXECUTE FUNCTION public.enforce_client_record_identity('student_id','virtual_class_id');

DROP POLICY grades_insert_teacher ON public.grades;
CREATE POLICY grades_insert_teacher ON public.grades FOR INSERT TO authenticated
 WITH CHECK (public.has_permission('grades.manage') AND public.can_teach_course(course_id)
   AND EXISTS (SELECT 1 FROM public.enrollments e WHERE e.student_id=grades.student_id
     AND e.course_id=grades.course_id AND e.status='approved' AND e.semester=grades.semester));

DROP POLICY grades_update_teacher ON public.grades;
CREATE POLICY grades_update_teacher ON public.grades FOR UPDATE TO authenticated USING (public.has_permission('grades.manage') AND public.can_teach_course(course_id))
 WITH CHECK (public.has_permission('grades.manage') AND public.can_teach_course(course_id)
   AND EXISTS (SELECT 1 FROM public.enrollments e WHERE e.student_id=grades.student_id
     AND e.course_id=grades.course_id AND e.status='approved' AND e.semester=grades.semester));


DROP POLICY virtual_class_att_manage_teacher ON public.virtual_class_attendance;
CREATE POLICY virtual_class_att_manage_teacher ON public.virtual_class_attendance FOR ALL TO authenticated
 USING (EXISTS (SELECT 1 FROM public.virtual_classes vc WHERE vc.id=virtual_class_id
   AND public.can_teach_course(vc.course_id) AND public.has_permission('attendance.manage')))
 WITH CHECK (EXISTS (SELECT 1 FROM public.virtual_classes vc JOIN public.enrollments e
   ON e.course_id=vc.course_id AND e.student_id=virtual_class_attendance.student_id
     AND e.status='approved' AND e.semester=vc.semester
   WHERE vc.id=virtual_class_id AND public.can_teach_course(vc.course_id)
     AND public.has_permission('attendance.manage')));

-- PostgreSQL requires immediate validation for a partitioned-table FK. Existing
-- orphans stop migration; repair them explicitly rather than deleting messages.
ALTER TABLE public.messages ADD CONSTRAINT messages_conversation_id_fkey
 FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;
ALTER TABLE public.messages ADD CONSTRAINT messages_not_self_reply
 CHECK (reply_to_id IS NULL OR reply_to_id <> id) NOT VALID;
CREATE FUNCTION public.enforce_message_reply_scope() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, public
AS $$
BEGIN
  IF NEW.reply_to_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM public.messages m WHERE m.id=NEW.reply_to_id
      AND m.conversation_id=NEW.conversation_id AND m.deleted_at IS NULL) THEN
    RAISE EXCEPTION 'reply must reference a live message in the same conversation' USING ERRCODE='23503';
  END IF;
  RETURN NEW;
END;
$$;
REVOKE ALL ON FUNCTION public.enforce_message_reply_scope() FROM PUBLIC, anon, authenticated;
CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages
 FOR EACH ROW EXECUTE FUNCTION public.enforce_message_reply_scope();


ALTER TABLE public.grades ADD CONSTRAINT grades_total_range
 CHECK (total BETWEEN 0 AND 100) NOT VALID;

ALTER TABLE public.grades ADD CONSTRAINT grades_gpa_points_range
 CHECK (gpa_points BETWEEN 0 AND 4) NOT VALID;

ALTER TABLE public.library_items ADD CONSTRAINT library_items_copy_totals
 CHECK (available_copies <= total_copies) NOT VALID;

ALTER TABLE public.library_items ADD CONSTRAINT library_items_counters_nonnegative
 CHECK (view_count >= 0 AND borrow_count >= 0) NOT VALID;

ALTER TABLE public.library_borrows ADD CONSTRAINT library_borrows_fine_nonnegative
 CHECK (fine_amount >= 0) NOT VALID;

ALTER TABLE public.library_borrows ADD CONSTRAINT library_borrows_return_order
 CHECK (returned_at IS NULL OR returned_at >= borrowed_at) NOT VALID;

ALTER TABLE public.library_reading_history ADD CONSTRAINT library_reading_history_progress_range
 CHECK (progress_pct BETWEEN 0 AND 100 AND last_page >= 1) NOT VALID;

ALTER TABLE public.library_reservations ADD CONSTRAINT library_reservations_expiry_order
 CHECK (expires_at > reserved_at) NOT VALID;

ALTER TABLE public.virtual_class_attendance ADD CONSTRAINT virtual_class_attendance_duration_nonnegative
 CHECK (duration_mins >= 0) NOT VALID;

ALTER TABLE public.virtual_class_attendance ADD CONSTRAINT virtual_class_attendance_leave_order
 CHECK (left_at IS NULL OR left_at >= joined_at) NOT VALID;

ALTER TABLE public.virtual_classes ADD CONSTRAINT virtual_classes_time_order
 CHECK (actual_end_at IS NULL OR actual_end_at >= actual_start_at) NOT VALID;

ALTER TABLE public.virtual_classes ADD CONSTRAINT virtual_classes_participants_nonnegative
 CHECK (max_participants > 0 AND actual_attendees >= 0) NOT VALID;

ALTER TABLE public.semester_gpa ADD CONSTRAINT semester_gpa_credits_nonnegative
 CHECK (total_credits >= 0 AND earned_credits >= 0 AND cumulative_credits >= 0 AND quality_points >= 0) NOT VALID;

ALTER TABLE public.semester_gpa ADD CONSTRAINT semester_gpa_gpa_range
 CHECK (semester_gpa BETWEEN 0 AND 4 AND cumulative_gpa BETWEEN 0 AND 4) NOT VALID;



ALTER TABLE public.post_comments ADD CONSTRAINT post_comments_not_self_reply
 CHECK (parent_id IS NULL OR parent_id <> id) NOT VALID;

ALTER TABLE public.online_exams ADD CONSTRAINT online_exams_marks_valid
 CHECK (total_marks > 0 AND duration_minutes > 0 AND passing_score BETWEEN 0 AND total_marks) NOT VALID;

ALTER TABLE public.exam_questions ADD CONSTRAINT exam_questions_marks_positive
 CHECK (marks > 0) NOT VALID;

ALTER TABLE public.attempt_answers ADD CONSTRAINT attempt_answers_marks_nonnegative
 CHECK (marks_awarded >= 0) NOT VALID;

ALTER TABLE public.exam_attempts ADD CONSTRAINT exam_attempts_completion_order
 CHECK (completed_at IS NULL OR completed_at >= started_at) NOT VALID;

ALTER TABLE public.user_roles ADD CONSTRAINT user_roles_expiry_order
 CHECK (expires_at IS NULL OR expires_at > granted_at) NOT VALID;


-- Backend payment writes still require verified provider evidence outside SQL.
-- This guard preserves terminal settlement and binds invoice identity/currency.
CREATE FUNCTION public.enforce_payment_integrity() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path = pg_catalog, public
AS $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM public.invoices i WHERE i.id=NEW.invoice_id
    AND i.student_id=NEW.student_id AND i.currency=NEW.currency) THEN
    RAISE EXCEPTION 'payment invoice identity or currency mismatch' USING ERRCODE='23514';
  END IF;
  IF TG_OP='UPDATE' AND OLD.status='paid' AND (NEW.status NOT IN ('paid','refunded')
    OR NEW.invoice_id IS DISTINCT FROM OLD.invoice_id
    OR NEW.student_id IS DISTINCT FROM OLD.student_id
    OR NEW.amount IS DISTINCT FROM OLD.amount
    OR NEW.currency IS DISTINCT FROM OLD.currency
    OR NEW.transaction_ref IS DISTINCT FROM OLD.transaction_ref) THEN
    RAISE EXCEPTION 'settled payment cannot regress' USING ERRCODE='23514';
  END IF;
  RETURN NEW;
END;
$$;
REVOKE ALL ON FUNCTION public.enforce_payment_integrity() FROM PUBLIC, anon, authenticated;
CREATE TRIGGER payment_transactions_integrity BEFORE INSERT OR UPDATE ON public.payment_transactions
 FOR EACH ROW EXECUTE FUNCTION public.enforce_payment_integrity();
COMMENT ON TABLE public.payment_transactions IS
 'Trusted backend only. Unique transaction_ref provides reference idempotency; no provider event ingestion or verification workflow is configured.';


-- Evidence: these B-tree definitions duplicate unique/primary indexes exactly.
DROP INDEX public.idx_profiles_email;
DROP INDEX public.idx_colleges_code;
DROP INDEX public.idx_departments_code;
DROP INDEX public.idx_attendance_composite;
DROP INDEX public.idx_library_borrows_item;
-- FK checks and hot RLS/list paths verified against catalog and repositories.
CREATE INDEX idx_role_permissions_permission ON public.role_permissions(permission_id);
CREATE INDEX idx_exam_schedules_course_date ON public.exam_schedules(course_id, exam_date);
CREATE INDEX idx_post_comments_parent ON public.post_comments(post_id, parent_id);
CREATE INDEX idx_post_likes_user ON public.post_likes(user_id, post_id);
CREATE INDEX idx_notifications_user_page ON public.notifications(user_id, created_at DESC, id DESC);
CREATE INDEX idx_posts_scope_page ON public.posts(college_id, department_id, created_at DESC, id DESC)
 WHERE deleted_at IS NULL;
CREATE INDEX idx_conversation_members_user_conversation ON public.conversation_members(user_id, conversation_id);
CREATE INDEX idx_registration_requests_advisor_page ON public.registration_requests(advisor_id, status, submitted_at DESC, id DESC);

COMMENT ON TABLE public.user_roles IS 'Trusted canonical assignments; no direct client mutations. Expired, future, inactive, unknown assignments grant no authority.';
COMMENT ON COLUMN public.virtual_classes.host_url IS 'Meeting host credential. Excluded from client SELECT grants; trusted backend use only.';

-- Directory role labels obey the same effective assignment rules as RBAC.
CREATE OR REPLACE VIEW public.profile_directory WITH (security_invoker=false) AS
 SELECT p.id,
    p.full_name,
    p.full_name_ar,
    p.avatar_url,
    p.college_id,
    p.department_id,
    p.created_at,
    COALESCE(array_agg(DISTINCT rd.code ORDER BY rd.code) FILTER (WHERE (rd.code IS NOT NULL)), ARRAY[]::text[]) AS role_codes
   FROM ((profiles p
     LEFT JOIN user_roles ur ON (((ur.user_id = p.id) AND ((ur.expires_at IS NULL) OR (ur.expires_at > now())) AND ur.granted_at <= now())))
     LEFT JOIN role_definitions rd ON (((rd.id = ur.role_id) AND rd.is_active AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text)))))
  WHERE (p.is_active AND (NOT p.is_banned) AND (p.deleted_at IS NULL) AND has_permission('profiles.read'::text))
  GROUP BY p.id;

-- Retain the single-column FK for department-only affiliation. The composite
-- FK additionally validates the college when both fields are populated.
ALTER TABLE public.departments ADD CONSTRAINT departments_id_college_key UNIQUE (id,college_id);
ALTER TABLE public.profiles ADD CONSTRAINT profiles_department_college_fkey
 FOREIGN KEY (department_id,college_id) REFERENCES public.departments(id,college_id)
 ON DELETE SET NULL (department_id) NOT VALID;

-- Institutional deletion must not erase academic history through cascades.
-- Existing FK dependencies are replaced atomically without deleting rows.
ALTER TABLE public.departments DROP CONSTRAINT departments_college_id_fkey;
ALTER TABLE public.departments ADD CONSTRAINT departments_college_id_fkey
 FOREIGN KEY (college_id) REFERENCES public.colleges(id) ON DELETE RESTRICT NOT VALID;
ALTER TABLE public.courses DROP CONSTRAINT courses_department_id_fkey;
ALTER TABLE public.courses ADD CONSTRAINT courses_department_id_fkey
 FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE RESTRICT NOT VALID;
ALTER TABLE public.grades DROP CONSTRAINT grades_course_id_fkey;
ALTER TABLE public.grades ADD CONSTRAINT grades_course_id_fkey
 FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE RESTRICT NOT VALID;
ALTER TABLE public.enrollments DROP CONSTRAINT enrollments_course_id_fkey;
ALTER TABLE public.enrollments ADD CONSTRAINT enrollments_course_id_fkey
 FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE RESTRICT NOT VALID;
ALTER TABLE public.attendance DROP CONSTRAINT attendance_course_id_fkey;
ALTER TABLE public.attendance ADD CONSTRAINT attendance_course_id_fkey
 FOREIGN KEY (course_id) REFERENCES public.courses(id) ON DELETE RESTRICT NOT VALID;
