-- Close authorization gaps found during the repository audit. These changes
-- are forward-only and retain the existing canonical RBAC tables.

-- There is no trusted parent/student relationship in the current schema.
-- Parents therefore receive no academic-record permissions until such a
-- relationship is modeled and verified server-side.
DELETE FROM public.role_permissions rp
USING public.role_definitions rd, public.permissions p
WHERE rp.role_id = rd.id AND rp.permission_id = p.id
  AND rd.code = 'parent'
  AND p.code IN ('students.progress.read', 'grades.read', 'attendance.read');

COMMENT ON TABLE public.role_permissions IS
  'Canonical role-to-permission assignments. Parent academic access remains disabled until a trusted parent/student relationship exists.';

-- A course is a private resource only for assigned staff, enrolled students,
-- and explicitly scoped academic reviewers. Catalog visibility and the
-- ability to request enrollment are separate checks.
CREATE OR REPLACE FUNCTION public.can_access_course(p_course_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.get_my_role() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND (
      public.can_teach_course(c.id)
      OR public.can_manage_course(c.id)
      OR public.can_manage_department(c.department_id)
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND e.student_id = (SELECT auth.uid())
                   AND e.status = 'approved')
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND e.status = 'approved'
                   AND public.can_review_student(e.student_id))
    )
  );
$$;

CREATE OR REPLACE FUNCTION public.can_browse_course_catalog(p_course_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.get_my_role() IS NOT NULL
    AND public.has_permission('courses.enroll')
    AND EXISTS (
      SELECT 1 FROM public.courses c
      JOIN public.departments d ON d.id = c.department_id
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE c.id = p_course_id AND c.is_active
        AND actor.is_active AND NOT actor.is_banned
        AND actor.deleted_at IS NULL AND actor.college_id = d.college_id
    );
$$;

CREATE OR REPLACE FUNCTION public.has_satisfied_course_prerequisites(
  p_student_id uuid, p_course_id uuid
)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT (p_student_id = (SELECT auth.uid())
      OR (public.has_permission('registration.manage')
          AND public.can_review_student(p_student_id)))
    AND NOT EXISTS (
      SELECT 1 FROM public.course_prerequisites cp
      WHERE cp.course_id = p_course_id
        AND NOT EXISTS (
          SELECT 1 FROM public.grades g
          WHERE g.student_id = p_student_id
            AND g.course_id = cp.prerequisite_course_id
            AND g.is_published AND g.total >= cp.minimum_grade
        )
  );
$$;

CREATE OR REPLACE FUNCTION public.can_request_course_enrollment(p_course_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.can_browse_course_catalog(p_course_id)
    AND public.has_satisfied_course_prerequisites(
      (SELECT auth.uid()), p_course_id);
$$;

CREATE OR REPLACE FUNCTION public.can_manage_registration_course(
  p_student_id uuid, p_course_id uuid
)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.has_permission('registration.manage')
    AND public.can_review_student(p_student_id)
    AND EXISTS (
      SELECT 1 FROM public.profiles target
      JOIN public.courses c ON c.id = p_course_id
      JOIN public.departments d ON d.id = c.department_id
      WHERE target.id = p_student_id AND c.is_active
        AND target.college_id = d.college_id
    );
$$;

DROP POLICY IF EXISTS enrollments_manage_registration ON public.enrollments;
CREATE POLICY enrollments_manage_registration ON public.enrollments
  FOR ALL TO authenticated USING (
    public.has_permission('registration.manage')
    AND public.can_review_student(student_id)
  ) WITH CHECK (
    public.has_permission('registration.manage')
    AND public.can_review_student(student_id)
    AND public.can_manage_registration_course(student_id, course_id)
    AND public.has_satisfied_course_prerequisites(student_id, course_id)
  );

DROP POLICY IF EXISTS attendance_insert_teacher ON public.attendance;
CREATE POLICY attendance_insert_teacher ON public.attendance
  FOR INSERT TO authenticated WITH CHECK (
    recorded_by = (SELECT auth.uid())
    AND public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id)
    AND EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = attendance.student_id
        AND e.course_id = attendance.course_id AND e.status = 'approved')
  );
DROP POLICY IF EXISTS attendance_update_teacher ON public.attendance;
CREATE POLICY attendance_update_teacher ON public.attendance
  FOR UPDATE TO authenticated USING (
    public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id)
  ) WITH CHECK (
    public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id)
    AND EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = attendance.student_id
        AND e.course_id = attendance.course_id AND e.status = 'approved')
  );

REVOKE ALL ON FUNCTION public.can_access_course(uuid),
  public.can_browse_course_catalog(uuid),
  public.can_request_course_enrollment(uuid),
  public.can_manage_registration_course(uuid, uuid),
  public.has_satisfied_course_prerequisites(uuid, uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.can_access_course(uuid),
  public.can_browse_course_catalog(uuid),
  public.can_request_course_enrollment(uuid),
  public.can_manage_registration_course(uuid, uuid),
  public.has_satisfied_course_prerequisites(uuid, uuid) TO authenticated;

DROP POLICY IF EXISTS prerequisites_read_course ON public.course_prerequisites;
CREATE POLICY prerequisites_read_course ON public.course_prerequisites
  FOR SELECT TO authenticated USING (
    public.can_access_course(course_id)
    OR public.can_browse_course_catalog(course_id)
  );

-- Section and timetable rows are enrollment catalog information. Eligible
-- same-college students may inspect them while choosing a request, but this
-- does not grant access to shared files, attendance, grades, or course classes.
DROP POLICY IF EXISTS sections_read_course ON public.course_sections;
CREATE POLICY sections_read_course ON public.course_sections
  FOR SELECT TO authenticated USING (
    public.can_access_course(course_id)
    OR public.can_browse_course_catalog(course_id)
  );
DROP POLICY IF EXISTS subsections_read_course ON public.course_sub_sections;
CREATE POLICY subsections_read_course ON public.course_sub_sections
  FOR SELECT TO authenticated USING (EXISTS (
    SELECT 1 FROM public.course_sections s WHERE s.id = section_id
      AND (public.can_access_course(s.course_id)
        OR public.can_browse_course_catalog(s.course_id))
  ));
DROP POLICY IF EXISTS schedules_read_course ON public.schedules;
CREATE POLICY schedules_read_course ON public.schedules
  FOR SELECT TO authenticated USING (
    public.can_access_course(course_id)
    OR public.can_browse_course_catalog(course_id)
  );
DROP POLICY IF EXISTS exam_schedules_read_course ON public.exam_schedules;
CREATE POLICY exam_schedules_read_course ON public.exam_schedules
  FOR SELECT TO authenticated USING (
    public.can_access_course(course_id)
    OR public.can_browse_course_catalog(course_id)
  );

DROP POLICY IF EXISTS student_course_regs_insert_owner ON public.student_course_registrations;
CREATE POLICY student_course_regs_insert_owner ON public.student_course_registrations
  FOR INSERT TO authenticated WITH CHECK (
    student_id = (SELECT auth.uid())
    AND public.can_request_course_enrollment(course_id)
    AND public.has_satisfied_course_prerequisites(student_id, course_id)
  );
DROP POLICY IF EXISTS student_course_regs_update_owner ON public.student_course_registrations;
CREATE POLICY student_course_regs_update_owner ON public.student_course_registrations
  FOR UPDATE TO authenticated USING (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'))
  WITH CHECK (student_id = (SELECT auth.uid())
    AND public.can_request_course_enrollment(course_id)
    AND public.has_satisfied_course_prerequisites(student_id, course_id));

DROP POLICY IF EXISTS registration_request_courses_insert_pending_owner
  ON public.registration_request_courses;
CREATE POLICY registration_request_courses_insert_pending_owner
  ON public.registration_request_courses FOR INSERT TO authenticated
  WITH CHECK (
    EXISTS (SELECT 1 FROM public.registration_requests rr
      WHERE rr.id = request_id AND rr.student_id = (SELECT auth.uid())
        AND rr.status = 'pending' AND public.has_permission('courses.enroll'))
    AND public.can_request_course_enrollment(course_id)
    AND public.has_satisfied_course_prerequisites(
      (SELECT auth.uid()), course_id)
  );

-- Ensure a course-file row names only its own uploader/course/file object.
-- The path is relative to the private course_files bucket:
-- {course_uuid}/{uploader_uuid}/{shared_files_uuid}/{filename}.
CREATE OR REPLACE FUNCTION public.course_file_path_matches(
  p_file_path text, p_course_id uuid, p_uploader_id uuid, p_file_id uuid
)
RETURNS boolean
LANGUAGE sql IMMUTABLE
SET search_path = pg_catalog
AS $$
  SELECT p_file_path IS NOT NULL AND p_course_id IS NOT NULL
    AND p_uploader_id IS NOT NULL AND p_file_id IS NOT NULL
    AND p_file_path ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[^/]+$'
    AND split_part(p_file_path, '/', 1) = p_course_id::text
    AND split_part(p_file_path, '/', 2) = p_uploader_id::text
    AND split_part(p_file_path, '/', 3) = p_file_id::text;
$$;
REVOKE ALL ON FUNCTION public.course_file_path_matches(text, uuid, uuid, uuid)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.course_file_path_matches(text, uuid, uuid, uuid)
  TO authenticated;

GRANT INSERT (id, uploader_id, course_id, title, title_ar, file_path, file_type,
              file_size, is_public)
  ON public.shared_files TO authenticated;
DROP POLICY IF EXISTS shared_files_read_course ON public.shared_files;
CREATE POLICY shared_files_read_course ON public.shared_files
  FOR SELECT TO authenticated USING (
    deleted_at IS NULL
    AND course_id IS NOT NULL
    AND public.course_file_path_matches(file_path, course_id, uploader_id, id)
    AND (uploader_id = (SELECT auth.uid())
      OR (is_public AND public.can_access_course(course_id)))
  );
DROP POLICY IF EXISTS shared_files_insert_owner ON public.shared_files;
CREATE POLICY shared_files_insert_owner ON public.shared_files
  FOR INSERT TO authenticated WITH CHECK (
    uploader_id = (SELECT auth.uid()) AND course_id IS NOT NULL
    AND public.has_permission('materials.upload')
    AND (public.can_teach_course(course_id) OR public.can_manage_course(course_id))
    AND public.course_file_path_matches(file_path, course_id, uploader_id, id)
  );
DROP POLICY IF EXISTS shared_files_update_owner ON public.shared_files;
CREATE POLICY shared_files_update_owner ON public.shared_files
  FOR UPDATE TO authenticated USING (
    uploader_id = (SELECT auth.uid()) AND course_id IS NOT NULL
    AND public.has_permission('materials.upload')
    AND (public.can_teach_course(course_id) OR public.can_manage_course(course_id))
    AND public.course_file_path_matches(file_path, course_id, uploader_id, id)
  ) WITH CHECK (
    uploader_id = (SELECT auth.uid()) AND course_id IS NOT NULL
    AND public.has_permission('materials.upload')
    AND (public.can_teach_course(course_id) OR public.can_manage_course(course_id))
    AND public.course_file_path_matches(file_path, course_id, uploader_id, id)
  );

CREATE OR REPLACE FUNCTION public.can_upload_storage_course_file(p_course_id text)
RETURNS boolean
LANGUAGE plpgsql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
DECLARE v_course_id uuid;
BEGIN
  IF (SELECT auth.uid()) IS NULL OR p_course_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
     OR NOT public.has_permission('materials.upload') THEN
    RETURN false;
  END IF;
  v_course_id := p_course_id::uuid;
  RETURN public.can_teach_course(v_course_id)
    OR public.can_manage_course(v_course_id);
END;
$$;

DROP POLICY IF EXISTS course_files_scoped_read ON storage.objects;
CREATE POLICY course_files_scoped_read ON storage.objects
  FOR SELECT TO authenticated USING (
    bucket_id = 'course_files'
    AND EXISTS (SELECT 1 FROM public.shared_files sf
      WHERE sf.file_path = storage.objects.name AND sf.deleted_at IS NULL
        AND public.course_file_path_matches(
          sf.file_path, sf.course_id, sf.uploader_id, sf.id)
        AND (sf.uploader_id = (SELECT auth.uid())
          OR (sf.is_public AND public.can_access_course(sf.course_id))))
  );
DROP POLICY IF EXISTS course_files_teacher_insert ON storage.objects;
CREATE POLICY course_files_teacher_insert ON storage.objects
  FOR INSERT TO authenticated WITH CHECK (
    bucket_id = 'course_files'
    AND array_length(string_to_array(name, '/'), 1) = 4
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND (storage.foldername(name))[3] ~
      '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
    AND (storage.filename(name)) <> ''
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  );
DROP POLICY IF EXISTS course_files_owner_update ON storage.objects;
CREATE POLICY course_files_owner_update ON storage.objects
  FOR UPDATE TO authenticated USING (
    bucket_id = 'course_files' AND array_length(string_to_array(name, '/'), 1) = 4
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND (storage.foldername(name))[3] ~
      '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
    AND (storage.filename(name)) <> ''
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
    AND EXISTS (SELECT 1 FROM public.shared_files sf
      WHERE sf.file_path = storage.objects.name
        AND sf.uploader_id = (SELECT auth.uid()) AND sf.deleted_at IS NULL
        AND public.course_file_path_matches(
          sf.file_path, sf.course_id, sf.uploader_id, sf.id))
  ) WITH CHECK (
    bucket_id = 'course_files' AND array_length(string_to_array(name, '/'), 1) = 4
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND (storage.foldername(name))[3] ~
      '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
    AND (storage.filename(name)) <> ''
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
    AND EXISTS (SELECT 1 FROM public.shared_files sf
      WHERE sf.file_path = storage.objects.name
        AND sf.uploader_id = (SELECT auth.uid()) AND sf.deleted_at IS NULL
        AND public.course_file_path_matches(
          sf.file_path, sf.course_id, sf.uploader_id, sf.id))
  );
DROP POLICY IF EXISTS course_files_owner_delete ON storage.objects;
CREATE POLICY course_files_owner_delete ON storage.objects
  FOR DELETE TO authenticated USING (
    bucket_id = 'course_files' AND array_length(string_to_array(name, '/'), 1) = 4
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND (storage.foldername(name))[3] ~
      '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  );

-- The existing notification contract persists rows and permits owner UPDATE,
-- not DELETE. No DELETE grant or policy is introduced here.

-- Realtime subscribers refresh the cached canonical role/permission snapshot.
DO $publication$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
    IF NOT EXISTS (SELECT 1 FROM pg_publication_tables
      WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'user_roles') THEN
      ALTER PUBLICATION supabase_realtime ADD TABLE public.user_roles;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_publication_tables
      WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'role_permissions') THEN
      ALTER PUBLICATION supabase_realtime ADD TABLE public.role_permissions;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_publication_tables
      WHERE pubname = 'supabase_realtime' AND schemaname = 'public' AND tablename = 'profiles') THEN
      ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;
    END IF;
  END IF;
END;
$publication$;
