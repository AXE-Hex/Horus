-- Phase 4: database authorization for every application table.
-- Client grants are reset first, then restored only where a corresponding
-- operation policy exists. Unlisted relations remain default-deny.

-- A teaching assistant's attendance capability remains course scoped through
-- the active assistant assignment checked by can_teach_course().
INSERT INTO public.role_permissions (role_id, permission_id)
SELECT rd.id, p.id FROM public.role_definitions rd
CROSS JOIN public.permissions p
WHERE rd.code = 'teaching_assistant' AND p.code = 'attendance.manage'
ON CONFLICT DO NOTHING;

CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS public.user_role
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT rd.code::public.user_role
  FROM public.user_roles ur
  JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
  WHERE ur.user_id = (SELECT auth.uid())
    AND (ur.expires_at IS NULL OR ur.expires_at > now())
    AND EXISTS (SELECT 1 FROM public.profiles p
      WHERE p.id = ur.user_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL)
    AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
  ORDER BY rd.priority ASC, rd.code ASC
  LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION public.has_permission(p_permission_code text)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.role_permissions rp ON rp.role_id = rd.id
    JOIN public.permissions p ON p.id = rp.permission_id
    JOIN public.profiles pr ON pr.id = ur.user_id
    WHERE ur.user_id = (SELECT auth.uid())
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND p.code = p_permission_code
      AND pr.is_active AND NOT pr.is_banned AND pr.deleted_at IS NULL
  );
$$;
REVOKE ALL ON FUNCTION public.get_my_role(), public.has_permission(text)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_my_role(), public.has_permission(text)
  TO authenticated;

CREATE OR REPLACE FUNCTION public.can_manage_department(p_department_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT COALESCE((SELECT p.is_active AND NOT p.is_banned FROM public.profiles p
                   WHERE p.id = (SELECT auth.uid())), false)
    AND public.has_permission('departments.manage')
    AND EXISTS (
      SELECT 1
      FROM public.departments d
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE d.id = p_department_id
        AND (actor.department_id = d.id
          OR (public.has_permission('departments.manage')
              AND actor.college_id = d.college_id)
          OR (actor.college_id IS NULL AND public.has_permission('colleges.manage')))
    );
$$;

CREATE OR REPLACE FUNCTION public.can_manage_course_department(p_department_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.has_permission('courses.manage')
    AND EXISTS (
      SELECT 1 FROM public.departments d
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE d.id = p_department_id
        AND (actor.department_id = d.id
          OR (public.has_permission('departments.manage')
              AND actor.college_id = d.college_id)
          OR (actor.college_id IS NULL AND public.has_permission('colleges.manage')))
    );
$$;

CREATE OR REPLACE FUNCTION public.can_manage_course(p_course_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT EXISTS (SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND public.can_manage_course_department(c.department_id));
$$;

CREATE OR REPLACE FUNCTION public.can_teach_course(p_course_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT public.get_my_role() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND (
      c.professor_id = (SELECT auth.uid())
      OR EXISTS (SELECT 1 FROM public.teaching_assistants ta
                 WHERE ta.course_id = c.id
                   AND ta.profile_id = (SELECT auth.uid()) AND ta.is_active)
    )
  );
$$;

CREATE OR REPLACE FUNCTION public.can_review_student(p_student_id uuid)
RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
  SELECT (SELECT auth.uid()) IS NOT NULL AND EXISTS (
    SELECT 1
    FROM public.profiles target
    JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
    WHERE target.id = p_student_id
      AND target.is_active AND NOT target.is_banned AND target.deleted_at IS NULL
      AND (
        (target.advisor_id = actor.id AND public.has_permission('students.advise'))
        OR (public.has_permission('students.progress.read')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
        OR (public.has_permission('departments.manage')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id))
        OR (public.has_permission('courses.manage')
            AND (actor.department_id = target.department_id
              OR (public.has_permission('departments.manage')
                  AND actor.college_id = target.college_id)
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
        OR (public.has_permission('colleges.manage')
            AND (actor.college_id IS NULL OR actor.college_id = target.college_id))
        OR (public.has_permission('registration.manage')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
      )
  );
$$;

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
                 WHERE e.course_id = c.id AND e.student_id = (SELECT auth.uid()))
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND public.can_review_student(e.student_id))
      OR EXISTS (SELECT 1 FROM public.student_course_registrations r
                 WHERE r.course_id = c.id AND r.student_id = (SELECT auth.uid()))
      OR EXISTS (SELECT 1 FROM public.student_course_registrations r
                 WHERE r.course_id = c.id AND public.can_review_student(r.student_id))
      OR EXISTS (SELECT 1 FROM public.registration_request_courses rc
                 JOIN public.registration_requests rr ON rr.id = rc.request_id
                 WHERE rc.course_id = c.id AND (rr.student_id = (SELECT auth.uid())
                   OR public.can_review_student(rr.student_id)))
      OR (public.has_permission('courses.enroll') AND EXISTS (
        SELECT 1 FROM public.departments d
        JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
        WHERE d.id = c.department_id AND actor.college_id = d.college_id))
    )
  );
$$;

REVOKE ALL ON FUNCTION public.can_manage_department(uuid),
  public.can_manage_course_department(uuid), public.can_manage_course(uuid), public.can_teach_course(uuid),
  public.can_review_student(uuid), public.can_access_course(uuid)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.can_manage_department(uuid),
  public.can_manage_course_department(uuid), public.can_manage_course(uuid), public.can_teach_course(uuid),
  public.can_review_student(uuid), public.can_access_course(uuid)
  TO authenticated;

-- Legacy trigger/encryption definers are not client RPCs. Pin their search
-- paths and revoke default PUBLIC execution while preserving trigger calls.
ALTER FUNCTION public.update_student_count()
  SET search_path = pg_catalog, public;
ALTER FUNCTION public.handle_new_user()
  SET search_path = pg_catalog, public, auth;
ALTER FUNCTION public.fn_encrypt_field(uuid, public.encryption_context, text, text)
  SET search_path = pg_catalog, public, extensions;
REVOKE ALL ON FUNCTION public.update_student_count(), public.handle_new_user(),
  public.fn_encrypt_field(uuid, public.encryption_context, text, text)
  FROM PUBLIC, anon, authenticated;

-- Remove historical permissive policies and direct client grants from all
-- public base tables, including tables that previously had no usable policy.
DO $phase4$
DECLARE
  t record;
  p record;
BEGIN
  FOR t IN SELECT c.oid, n.nspname, c.relname
           FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace
           WHERE n.nspname = 'public' AND c.relkind IN ('r', 'p')
  LOOP
    EXECUTE format('ALTER TABLE %I.%I ENABLE ROW LEVEL SECURITY', t.nspname, t.relname);
    EXECUTE format('ALTER TABLE %I.%I FORCE ROW LEVEL SECURITY', t.nspname, t.relname);
    EXECUTE format('REVOKE ALL PRIVILEGES ON TABLE %I.%I FROM PUBLIC, anon, authenticated',
                   t.nspname, t.relname);
    FOR p IN SELECT polname FROM pg_policy WHERE polrelid = t.oid LOOP
      EXECUTE format('DROP POLICY %I ON %I.%I', p.polname, t.nspname, t.relname);
    END LOOP;
  END LOOP;
END;
$phase4$;

-- Reference data and canonical authorization catalog.
GRANT SELECT ON public.role_definitions, public.permissions,
  public.role_permissions, public.user_roles TO authenticated;
GRANT SELECT ON public.colleges, public.departments, public.semesters,
  public.courses, public.course_prerequisites, public.professor_details,
  public.teaching_assistants, public.department_projects,
  public.course_sections, public.course_sub_sections, public.schedules,
  public.exam_schedules, public.office_hours TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.colleges, public.departments,
  public.semesters, public.courses, public.course_prerequisites,
  public.teaching_assistants, public.department_projects,
  public.course_sections, public.course_sub_sections, public.schedules,
  public.exam_schedules TO authenticated;

CREATE POLICY role_definitions_read_active ON public.role_definitions
  FOR SELECT TO authenticated USING (is_active);
CREATE POLICY permissions_read_catalog ON public.permissions
  FOR SELECT TO authenticated USING (true);
CREATE POLICY role_permissions_read_catalog ON public.role_permissions
  FOR SELECT TO authenticated USING (true);
CREATE POLICY user_roles_read_self ON public.user_roles
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid()));

CREATE POLICY colleges_read_active ON public.colleges
  FOR SELECT TO authenticated USING (is_active AND public.get_my_role() IS NOT NULL);
CREATE POLICY colleges_manage_scope ON public.colleges
  FOR ALL TO authenticated USING (
    public.has_permission('colleges.manage')
    AND ((SELECT college_id FROM public.profiles WHERE id = (SELECT auth.uid())) IS NULL
      OR id = (SELECT college_id FROM public.profiles WHERE id = (SELECT auth.uid())))
  ) WITH CHECK (
    public.has_permission('colleges.manage')
    AND ((SELECT college_id FROM public.profiles WHERE id = (SELECT auth.uid())) IS NULL
      OR id = (SELECT college_id FROM public.profiles WHERE id = (SELECT auth.uid())))
  );
CREATE POLICY departments_read_active ON public.departments
  FOR SELECT TO authenticated USING (is_active AND public.get_my_role() IS NOT NULL);
CREATE POLICY departments_manage_scope ON public.departments
  FOR ALL TO authenticated USING (public.can_manage_department(id))
  WITH CHECK (public.can_manage_department(id));
CREATE POLICY semesters_read_active ON public.semesters
  FOR SELECT TO authenticated USING (is_active AND public.get_my_role() IS NOT NULL);
CREATE POLICY semesters_manage_university ON public.semesters
  FOR ALL TO authenticated USING (public.has_permission('colleges.manage'))
  WITH CHECK (public.has_permission('colleges.manage'));

CREATE POLICY courses_read_active ON public.courses
  FOR SELECT TO authenticated USING ((is_active AND public.get_my_role() IS NOT NULL)
    OR public.can_manage_course(id));
CREATE POLICY courses_manage_scope ON public.courses
  FOR ALL TO authenticated USING (public.can_manage_course(id))
  WITH CHECK (public.can_manage_course_department(department_id));
CREATE POLICY prerequisites_read_course ON public.course_prerequisites
  FOR SELECT TO authenticated USING (public.can_access_course(course_id));
CREATE POLICY prerequisites_manage_scope ON public.course_prerequisites
  FOR ALL TO authenticated USING (public.can_manage_course(course_id))
  WITH CHECK (public.can_manage_course(course_id)
              AND public.can_manage_course(prerequisite_course_id));
CREATE POLICY professor_details_read_active ON public.professor_details
  FOR SELECT TO authenticated USING (public.get_my_role() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.profiles p WHERE p.id = professor_details.id
      AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL));
CREATE POLICY teaching_assistants_read_scope ON public.teaching_assistants
  FOR SELECT TO authenticated USING (public.get_my_role() IS NOT NULL AND (
    profile_id = (SELECT auth.uid()) OR professor_id = (SELECT auth.uid())
    OR public.can_access_course(course_id)
    OR (course_id IS NULL AND public.has_permission('teaching_assistants.manage')
      AND EXISTS (SELECT 1 FROM public.profiles actor JOIN public.profiles target
        ON target.id = teaching_assistants.profile_id
        WHERE actor.id = (SELECT auth.uid()) AND actor.department_id = target.department_id))
    OR (course_id IS NULL AND public.can_manage_department(
      (SELECT department_id FROM public.profiles WHERE id = profile_id)))));
CREATE POLICY teaching_assistants_manage_scope ON public.teaching_assistants
  FOR ALL TO authenticated USING (
    public.has_permission('teaching_assistants.manage')
    AND (public.can_teach_course(course_id) OR public.can_manage_course(course_id)))
  WITH CHECK (public.has_permission('teaching_assistants.manage')
    AND (public.can_teach_course(course_id) OR public.can_manage_course(course_id)));
CREATE POLICY department_projects_read_scope ON public.department_projects
  FOR SELECT TO authenticated USING (
    public.get_my_role() IS NOT NULL AND (
    EXISTS (SELECT 1 FROM public.profiles actor
            JOIN public.departments d ON d.id = department_projects.department_id
            WHERE actor.id = (SELECT auth.uid())
              AND actor.department_id = d.id)
    OR public.can_manage_department(department_id)));
CREATE POLICY department_projects_manage_scope ON public.department_projects
  FOR ALL TO authenticated USING (public.can_manage_department(department_id))
  WITH CHECK (public.can_manage_department(department_id));

CREATE POLICY sections_read_course ON public.course_sections
  FOR SELECT TO authenticated USING (public.can_access_course(course_id));
CREATE POLICY sections_manage_scope ON public.course_sections
  FOR ALL TO authenticated USING (public.can_manage_course(course_id))
  WITH CHECK (public.can_manage_course(course_id));
CREATE POLICY subsections_read_course ON public.course_sub_sections
  FOR SELECT TO authenticated USING (EXISTS (
    SELECT 1 FROM public.course_sections s WHERE s.id = section_id
      AND public.can_access_course(s.course_id)));
CREATE POLICY subsections_manage_scope ON public.course_sub_sections
  FOR ALL TO authenticated USING (EXISTS (
    SELECT 1 FROM public.course_sections s WHERE s.id = section_id
      AND public.can_manage_course(s.course_id)))
  WITH CHECK (EXISTS (SELECT 1 FROM public.course_sections s
    WHERE s.id = section_id AND public.can_manage_course(s.course_id)));
CREATE POLICY schedules_read_course ON public.schedules
  FOR SELECT TO authenticated USING (public.can_access_course(course_id));
CREATE POLICY schedules_manage_scope ON public.schedules
  FOR ALL TO authenticated USING (public.can_manage_course(course_id)
    OR (public.has_permission('schedules.manage') AND public.can_teach_course(course_id)))
  WITH CHECK (public.can_manage_course(course_id)
    OR (public.has_permission('schedules.manage') AND public.can_teach_course(course_id)));
CREATE POLICY exam_schedules_read_course ON public.exam_schedules
  FOR SELECT TO authenticated USING (public.can_access_course(course_id));
CREATE POLICY exam_schedules_manage_scope ON public.exam_schedules
  FOR ALL TO authenticated USING (public.can_manage_course(course_id)
    OR (public.has_permission('schedules.manage') AND public.can_teach_course(course_id)))
  WITH CHECK (public.can_manage_course(course_id)
    OR (public.has_permission('schedules.manage') AND public.can_teach_course(course_id)));
CREATE POLICY office_hours_read_staff_or_course ON public.office_hours
  FOR SELECT TO authenticated USING (professor_id = (SELECT auth.uid())
    OR EXISTS (SELECT 1 FROM public.courses c WHERE c.professor_id = office_hours.professor_id
      AND public.can_access_course(c.id)));

-- Student academic data is owner scoped; teaching and administration access is
-- limited to courses taught or institutional scopes managed by permissions.
GRANT SELECT, INSERT, UPDATE, DELETE ON public.student_registrations,
  public.student_course_registrations TO authenticated;
GRANT SELECT ON public.enrollments, public.action_plan_items, public.grades,
  public.semester_gpa, public.grade_scales, public.attendance,
  public.virtual_classes, public.virtual_class_attendance TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.enrollments,
  public.action_plan_items, public.grades, public.grade_scales,
  public.attendance, public.virtual_classes,
  public.virtual_class_attendance TO authenticated;
CREATE POLICY student_registrations_read_owner_or_reviewer ON public.student_registrations
  FOR SELECT TO authenticated USING (public.get_my_role() IS NOT NULL AND
    (student_id = (SELECT auth.uid())
    OR public.can_review_student(student_id)));
CREATE POLICY student_registrations_write_owner ON public.student_registrations
  FOR INSERT TO authenticated WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'));
CREATE POLICY student_registrations_update_owner ON public.student_registrations
  FOR UPDATE TO authenticated USING (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'))
  WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'));
CREATE POLICY student_registrations_delete_owner ON public.student_registrations
  FOR DELETE TO authenticated USING (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'));
CREATE POLICY student_course_regs_read_owner_or_reviewer ON public.student_course_registrations
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid())
    OR public.can_review_student(student_id)
    OR public.can_manage_course(course_id));
CREATE POLICY student_course_regs_insert_owner ON public.student_course_registrations
  FOR INSERT TO authenticated WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll') AND public.can_access_course(course_id));
CREATE POLICY student_course_regs_update_owner ON public.student_course_registrations
  FOR UPDATE TO authenticated USING (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'))
  WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll') AND public.can_access_course(course_id));
CREATE POLICY student_course_regs_delete_owner ON public.student_course_registrations
  FOR DELETE TO authenticated USING (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll'));

CREATE POLICY enrollments_read_owner_or_reviewer ON public.enrollments
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid())
    OR public.can_review_student(student_id)
    OR public.can_teach_course(course_id) OR public.can_manage_course(course_id));
CREATE POLICY enrollments_manage_registration ON public.enrollments
  FOR ALL TO authenticated USING (public.has_permission('registration.manage')
    AND public.can_review_student(student_id))
  WITH CHECK (public.has_permission('registration.manage')
    AND public.can_review_student(student_id));
CREATE POLICY action_plans_read_owner_or_advisor ON public.action_plan_items
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid())
    OR public.can_review_student(student_id));
CREATE POLICY action_plans_manage_advisor ON public.action_plan_items
  FOR ALL TO authenticated USING (public.can_review_student(student_id)
    AND public.has_permission('students.advise'))
  WITH CHECK (public.can_review_student(student_id)
    AND public.has_permission('students.advise'));
CREATE POLICY grades_read_owner_staff_or_reviewer ON public.grades
  FOR SELECT TO authenticated USING (
    (student_id = (SELECT auth.uid()) AND is_published
      AND public.has_permission('grades.read'))
    OR (public.can_teach_course(course_id) AND public.has_permission('grades.manage'))
    OR public.can_manage_course(course_id)
    OR (public.can_review_student(student_id) AND public.has_permission('grades.read')));
CREATE POLICY grades_insert_teacher ON public.grades
  FOR INSERT TO authenticated WITH CHECK (public.has_permission('grades.manage')
    AND public.can_teach_course(course_id)
    AND EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = grades.student_id AND e.course_id = grades.course_id));
CREATE POLICY grades_update_teacher ON public.grades
  FOR UPDATE TO authenticated USING (public.has_permission('grades.manage')
    AND public.can_teach_course(course_id))
  WITH CHECK (public.has_permission('grades.manage')
    AND public.can_teach_course(course_id)
    AND EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = grades.student_id AND e.course_id = grades.course_id));
CREATE POLICY grades_delete_teacher ON public.grades
  FOR DELETE TO authenticated USING (public.has_permission('grades.manage')
    AND public.can_teach_course(course_id));
CREATE POLICY semester_gpa_read_owner_or_reviewer ON public.semester_gpa
  FOR SELECT TO authenticated USING ((student_id = (SELECT auth.uid()) AND is_official
      AND public.has_permission('grades.read')) OR public.can_review_student(student_id));
CREATE POLICY grade_scales_read_authenticated ON public.grade_scales
  FOR SELECT TO authenticated USING (college_id IS NULL OR EXISTS (
    SELECT 1 FROM public.profiles p WHERE p.id = (SELECT auth.uid())
      AND (p.college_id = grade_scales.college_id
        OR (p.college_id IS NULL AND public.has_permission('colleges.manage')))));
CREATE POLICY grade_scales_manage_scope ON public.grade_scales
  FOR ALL TO authenticated USING (college_id IS NULL
    AND public.has_permission('colleges.manage') OR EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = (SELECT auth.uid())
        AND p.college_id = grade_scales.college_id
        AND public.has_permission('departments.manage')))
  WITH CHECK (college_id IS NULL AND public.has_permission('colleges.manage')
    OR EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = (SELECT auth.uid())
      AND p.college_id = grade_scales.college_id
      AND public.has_permission('departments.manage')));
CREATE POLICY attendance_read_owner_staff_or_advisor ON public.attendance
  FOR SELECT TO authenticated USING (
    (student_id = (SELECT auth.uid()) AND public.has_permission('attendance.read'))
    OR (public.can_teach_course(course_id) AND public.has_permission('attendance.manage'))
    OR public.can_manage_course(course_id)
    OR (public.can_review_student(student_id) AND public.has_permission('attendance.read')));
CREATE POLICY attendance_insert_teacher ON public.attendance
  FOR INSERT TO authenticated WITH CHECK (recorded_by = (SELECT auth.uid())
    AND public.has_permission('attendance.manage') AND public.can_teach_course(course_id)
    AND EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = attendance.student_id AND e.course_id = attendance.course_id));
CREATE POLICY attendance_update_teacher ON public.attendance
  FOR UPDATE TO authenticated USING (public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id))
  WITH CHECK (public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id));
CREATE POLICY attendance_delete_teacher ON public.attendance
  FOR DELETE TO authenticated USING (public.has_permission('attendance.manage')
    AND public.can_teach_course(course_id));
CREATE POLICY virtual_classes_read_course ON public.virtual_classes
  FOR SELECT TO authenticated USING (public.can_access_course(course_id));
CREATE POLICY virtual_classes_manage_teacher ON public.virtual_classes
  FOR ALL TO authenticated USING (created_by = (SELECT auth.uid())
    AND public.can_teach_course(course_id))
  WITH CHECK (created_by = (SELECT auth.uid()) AND public.can_teach_course(course_id));
CREATE POLICY virtual_class_att_read_self_or_staff ON public.virtual_class_attendance
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid()) OR EXISTS (
    SELECT 1 FROM public.virtual_classes vc WHERE vc.id = virtual_class_id
      AND public.can_teach_course(vc.course_id)));
CREATE POLICY virtual_class_att_manage_teacher ON public.virtual_class_attendance
  FOR ALL TO authenticated USING (EXISTS (
    SELECT 1 FROM public.virtual_classes vc WHERE vc.id = virtual_class_id
      AND public.can_teach_course(vc.course_id)
      AND public.has_permission('attendance.manage')))
  WITH CHECK (EXISTS (SELECT 1 FROM public.virtual_classes vc
    WHERE vc.id = virtual_class_id AND public.can_teach_course(vc.course_id)
      AND public.has_permission('attendance.manage')));

-- Registration is owner scoped for students and assigned/ad hoc scoped for
-- advisors and registrar permissions. Review columns can only be changed by
-- an assigned advisor, scoped manager, or registration permission holder.
GRANT SELECT, DELETE ON public.registration_requests,
  public.registration_request_courses TO authenticated;
GRANT INSERT (student_id, advisor_id, semester, semester_id, status, submitted_at)
  ON public.registration_requests TO authenticated;
GRANT INSERT (request_id, course_id, section_name, sub_section_name)
  ON public.registration_request_courses TO authenticated;
GRANT UPDATE (status, advisor_notes, reviewed_at, updated_at)
  ON public.registration_requests TO authenticated;
CREATE POLICY registration_requests_read_owner_or_reviewer ON public.registration_requests
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid())
    OR advisor_id = (SELECT auth.uid()) OR public.can_review_student(student_id));
CREATE POLICY registration_requests_insert_owner ON public.registration_requests
  FOR INSERT TO authenticated WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('courses.enroll') AND status = 'pending'
    AND reviewed_at IS NULL
    AND advisor_id IS NOT DISTINCT FROM (SELECT advisor_id FROM public.profiles
                                          WHERE id = (SELECT auth.uid())));
CREATE POLICY registration_requests_update_review ON public.registration_requests
  FOR UPDATE TO authenticated USING (
    (advisor_id = (SELECT auth.uid()) AND public.has_permission('students.advise'))
    OR (public.has_permission('registration.review') AND public.can_review_student(student_id)))
  WITH CHECK (
    (advisor_id = (SELECT auth.uid()) AND public.has_permission('students.advise'))
    OR (public.has_permission('registration.review') AND public.can_review_student(student_id)));
CREATE POLICY registration_requests_delete_pending_owner ON public.registration_requests
  FOR DELETE TO authenticated USING (student_id = (SELECT auth.uid()) AND status = 'pending');
CREATE POLICY registration_request_courses_read_related ON public.registration_request_courses
  FOR SELECT TO authenticated USING (EXISTS (
    SELECT 1 FROM public.registration_requests rr WHERE rr.id = request_id
      AND (rr.student_id = (SELECT auth.uid()) OR rr.advisor_id = (SELECT auth.uid())
        OR public.can_review_student(rr.student_id))));
CREATE POLICY registration_request_courses_insert_pending_owner ON public.registration_request_courses
  FOR INSERT TO authenticated WITH CHECK (EXISTS (
    SELECT 1 FROM public.registration_requests rr WHERE rr.id = request_id
      AND rr.student_id = (SELECT auth.uid()) AND rr.status = 'pending'
      AND public.has_permission('courses.enroll'))
    AND public.can_access_course(course_id));
CREATE POLICY registration_request_courses_delete_pending_owner ON public.registration_request_courses
  FOR DELETE TO authenticated USING (EXISTS (
    SELECT 1 FROM public.registration_requests rr WHERE rr.id = request_id
      AND rr.student_id = (SELECT auth.uid()) AND rr.status = 'pending'
      AND public.has_permission('courses.enroll')));

-- Social content is readable to signed-in users; writes require ownership and
-- the relevant feature permission. Institutional visibility is resolved from
-- the author's department/college, without granting cross-college access.
GRANT SELECT, DELETE ON public.posts, public.post_likes,
  public.post_comments, public.student_groups, public.group_members,
  public.announcements, public.shared_files,
  public.forum_posts TO authenticated;
GRANT INSERT ON public.post_likes, public.group_members TO authenticated;
GRANT INSERT (forum_id, author_id, title, content)
  ON public.forum_posts TO authenticated;
GRANT UPDATE (content, media_urls, link_url, type, updated_at, deleted_at)
  ON public.posts TO authenticated;
GRANT UPDATE (content, updated_at, deleted_at)
  ON public.post_comments TO authenticated;
GRANT UPDATE (name, name_ar, description, max_students, is_active, updated_at)
  ON public.student_groups TO authenticated;
GRANT UPDATE (title, title_ar, content, content_ar, priority, published_at,
  expires_at, deleted_at, updated_at) ON public.announcements TO authenticated;
GRANT UPDATE (title, title_ar, file_path, file_type, file_size, is_public, deleted_at)
  ON public.shared_files TO authenticated;
CREATE POLICY posts_read_active ON public.posts FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND (college_id IS NULL OR EXISTS (
    SELECT 1 FROM public.profiles p WHERE p.id = (SELECT auth.uid())
      AND p.college_id = posts.college_id))
    AND (department_id IS NULL OR department_id = (SELECT department_id FROM public.profiles
                                                  WHERE id = (SELECT auth.uid()))));
CREATE POLICY posts_insert_author_permission ON public.posts FOR INSERT TO authenticated
  WITH CHECK (author_id = (SELECT auth.uid()) AND public.has_permission('posts.create')
    AND ((college_id IS NOT NULL OR department_id IS NOT NULL)
      OR public.has_permission('colleges.manage'))
    AND (college_id IS NULL OR college_id = (SELECT college_id FROM public.profiles
                                              WHERE id = (SELECT auth.uid())))
    AND (department_id IS NULL OR department_id = (SELECT department_id FROM public.profiles
                                                    WHERE id = (SELECT auth.uid()))));
CREATE POLICY posts_update_author ON public.posts FOR UPDATE TO authenticated
  USING (author_id = (SELECT auth.uid()) AND deleted_at IS NULL)
  WITH CHECK (author_id = (SELECT auth.uid())
    AND ((college_id IS NOT NULL OR department_id IS NOT NULL)
      OR public.has_permission('colleges.manage'))
    AND (college_id IS NULL OR college_id = (SELECT college_id FROM public.profiles
                                              WHERE id = (SELECT auth.uid())))
    AND (department_id IS NULL OR department_id = (SELECT department_id FROM public.profiles
                                                    WHERE id = (SELECT auth.uid()))));
CREATE POLICY posts_delete_author ON public.posts FOR DELETE TO authenticated
  USING (author_id = (SELECT auth.uid()));
CREATE POLICY post_likes_read_visible_post ON public.post_likes FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM public.posts p WHERE p.id = post_id AND p.deleted_at IS NULL));
CREATE POLICY post_likes_insert_self ON public.post_likes FOR INSERT TO authenticated
  WITH CHECK (user_id = (SELECT auth.uid()) AND EXISTS (
    SELECT 1 FROM public.posts p WHERE p.id = post_id AND p.deleted_at IS NULL));
CREATE POLICY post_likes_delete_self ON public.post_likes FOR DELETE TO authenticated
  USING (user_id = (SELECT auth.uid()));
CREATE POLICY post_comments_read_visible_post ON public.post_comments FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND EXISTS (SELECT 1 FROM public.posts p
    WHERE p.id = post_id AND p.deleted_at IS NULL));
CREATE POLICY post_comments_insert_self ON public.post_comments FOR INSERT TO authenticated
  WITH CHECK (author_id = (SELECT auth.uid()) AND EXISTS (
    SELECT 1 FROM public.posts p WHERE p.id = post_id AND p.deleted_at IS NULL));
CREATE POLICY post_comments_update_self ON public.post_comments FOR UPDATE TO authenticated
  USING (author_id = (SELECT auth.uid()) AND deleted_at IS NULL)
  WITH CHECK (author_id = (SELECT auth.uid()) AND EXISTS (
    SELECT 1 FROM public.posts p WHERE p.id = post_id AND p.deleted_at IS NULL
      AND (p.college_id IS NULL OR p.college_id = (SELECT college_id FROM public.profiles
                                                   WHERE id = (SELECT auth.uid())))
      AND (p.department_id IS NULL OR p.department_id = (SELECT department_id FROM public.profiles
                                                         WHERE id = (SELECT auth.uid())))));
CREATE POLICY post_comments_delete_self_or_post_author ON public.post_comments FOR DELETE TO authenticated
  USING (author_id = (SELECT auth.uid()) OR EXISTS (SELECT 1 FROM public.posts p
    WHERE p.id = post_id AND p.author_id = (SELECT auth.uid())));
CREATE POLICY student_groups_read_member_or_teacher ON public.student_groups
  FOR SELECT TO authenticated USING (public.get_my_role() IS NOT NULL AND (
    professor_id = (SELECT auth.uid()) OR public.can_access_course(course_id)
    OR (course_id IS NULL AND is_active AND EXISTS (
      SELECT 1 FROM public.profiles owner JOIN public.profiles actor
        ON actor.id = (SELECT auth.uid())
      WHERE owner.id = student_groups.professor_id
        AND (owner.college_id IS NULL OR owner.college_id = actor.college_id)))));
CREATE POLICY student_groups_manage_teacher ON public.student_groups
  FOR ALL TO authenticated USING (professor_id = (SELECT auth.uid())
    AND public.has_permission('groups.manage'))
  WITH CHECK (professor_id = (SELECT auth.uid())
    AND public.has_permission('groups.manage')
    AND (course_id IS NULL OR public.can_teach_course(course_id)));
CREATE POLICY group_members_read_group ON public.group_members FOR SELECT TO authenticated
  USING (student_id = (SELECT auth.uid()) OR EXISTS (
    SELECT 1 FROM public.student_groups g WHERE g.id = group_id
      AND (g.professor_id = (SELECT auth.uid()) OR public.can_access_course(g.course_id))));
CREATE POLICY group_members_insert_teacher ON public.group_members FOR INSERT TO authenticated
  WITH CHECK (EXISTS (SELECT 1 FROM public.student_groups g WHERE g.id = group_members.group_id
    AND g.professor_id = (SELECT auth.uid()) AND public.has_permission('groups.manage')
    AND EXISTS (SELECT 1 FROM public.profiles s JOIN public.profiles actor
      ON actor.id = (SELECT auth.uid()) WHERE s.id = group_members.student_id AND s.is_active
        AND s.college_id = actor.college_id)
    AND (g.course_id IS NULL OR EXISTS (SELECT 1 FROM public.enrollments e
      WHERE e.student_id = group_members.student_id AND e.course_id = g.course_id))));
CREATE POLICY group_members_delete_owner_or_teacher ON public.group_members FOR DELETE TO authenticated
  USING (student_id = (SELECT auth.uid()) OR EXISTS (
    SELECT 1 FROM public.student_groups g WHERE g.id = group_id
      AND g.professor_id = (SELECT auth.uid()) AND public.has_permission('groups.manage')));
CREATE POLICY announcements_read_in_scope ON public.announcements FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND (expires_at IS NULL OR expires_at > now())
    AND public.get_my_role() IS NOT NULL
    AND (college_id IS NULL OR college_id = (SELECT college_id FROM public.profiles
                                              WHERE id = (SELECT auth.uid())))
    AND (department_id IS NULL OR department_id = (SELECT department_id FROM public.profiles
                                                    WHERE id = (SELECT auth.uid())))
    AND (course_id IS NULL OR public.can_access_course(course_id)));
CREATE POLICY announcements_insert_scoped_author ON public.announcements FOR INSERT TO authenticated
  WITH CHECK (author_id = (SELECT auth.uid()) AND public.has_permission('announcements.create')
    AND ((public.has_permission('colleges.manage') AND college_id IS NULL
          AND department_id IS NULL AND course_id IS NULL)
      OR (department_id IS NOT NULL AND public.can_manage_department(department_id)
          AND (course_id IS NULL OR public.can_manage_course(course_id)))
      OR (department_id IS NOT NULL AND department_id = (SELECT department_id
          FROM public.profiles WHERE id = (SELECT auth.uid()))
          AND public.has_permission('announcements.create')
          AND (course_id IS NULL OR public.can_teach_course(course_id)))
      OR (course_id IS NOT NULL AND public.can_teach_course(course_id)
          AND EXISTS (SELECT 1 FROM public.courses c
                      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
                      JOIN public.departments d ON d.id = c.department_id
                      WHERE c.id = course_id AND d.id = actor.department_id))));
CREATE POLICY announcements_update_scoped_author ON public.announcements FOR UPDATE TO authenticated
  USING ((author_id = (SELECT auth.uid()) AND public.has_permission('announcements.create')) OR
    (department_id IS NOT NULL AND public.can_manage_department(department_id)))
  WITH CHECK ((author_id = (SELECT auth.uid()) AND public.has_permission('announcements.create')
    AND ((public.has_permission('colleges.manage') AND college_id IS NULL
          AND department_id IS NULL AND course_id IS NULL)
      OR (department_id IS NOT NULL AND public.can_manage_department(department_id)
          AND (course_id IS NULL OR public.can_manage_course(course_id)))
      OR (department_id IS NOT NULL AND department_id = (SELECT department_id
          FROM public.profiles WHERE id = (SELECT auth.uid()))
          AND public.has_permission('announcements.create')
          AND (course_id IS NULL OR public.can_teach_course(course_id)))
      OR (course_id IS NOT NULL AND public.can_teach_course(course_id)))) OR
    (department_id IS NOT NULL AND public.can_manage_department(department_id)));
CREATE POLICY announcements_delete_scoped_author ON public.announcements FOR DELETE TO authenticated
  USING ((author_id = (SELECT auth.uid()) AND public.has_permission('announcements.create')) OR
    (department_id IS NOT NULL AND public.can_manage_department(department_id)));
CREATE POLICY shared_files_read_course ON public.shared_files FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND (uploader_id = (SELECT auth.uid())
    OR (is_public AND ((course_id IS NOT NULL AND public.can_access_course(course_id))
      OR (course_id IS NULL AND EXISTS (
        SELECT 1 FROM public.profiles owner JOIN public.profiles actor
          ON actor.id = (SELECT auth.uid())
        WHERE owner.id = shared_files.uploader_id
          AND owner.college_id = actor.college_id))))));
CREATE POLICY shared_files_insert_owner ON public.shared_files FOR INSERT TO authenticated
  WITH CHECK (uploader_id = (SELECT auth.uid()) AND public.has_permission('materials.upload')
    AND (course_id IS NULL OR public.can_teach_course(course_id)
      OR public.can_manage_course(course_id)));
CREATE POLICY shared_files_update_owner ON public.shared_files FOR UPDATE TO authenticated
  USING (uploader_id = (SELECT auth.uid())) WITH CHECK (uploader_id = (SELECT auth.uid())
    AND (course_id IS NULL OR public.can_teach_course(course_id)
      OR public.can_manage_course(course_id)));
CREATE POLICY shared_files_delete_owner ON public.shared_files FOR DELETE TO authenticated
  USING (uploader_id = (SELECT auth.uid()));
CREATE POLICY forums_read_active ON public.forums FOR SELECT TO authenticated
  USING (is_active AND public.has_permission('forums.access'));
CREATE POLICY forum_posts_read_active ON public.forum_posts FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND public.has_permission('forums.access') AND EXISTS (
    SELECT 1 FROM public.forums f WHERE f.id = forum_id AND f.is_active));
CREATE POLICY forum_posts_insert_self ON public.forum_posts FOR INSERT TO authenticated
  WITH CHECK (author_id = (SELECT auth.uid()) AND public.has_permission('forums.access')
    AND EXISTS (SELECT 1 FROM public.forums f WHERE f.id = forum_id AND f.is_active));
CREATE POLICY forum_posts_update_self ON public.forum_posts FOR UPDATE TO authenticated
  USING (author_id = (SELECT auth.uid()) AND deleted_at IS NULL)
  WITH CHECK (author_id = (SELECT auth.uid()));
CREATE POLICY forum_posts_delete_self ON public.forum_posts FOR DELETE TO authenticated
  USING (author_id = (SELECT auth.uid()));

-- Conversations and messages are restricted to existing membership; callers
-- cannot add themselves to another user's conversation.
GRANT SELECT, DELETE ON public.conversations,
  public.conversation_members, public.messages, public.message_reactions TO authenticated;
GRANT UPDATE (title, last_message, last_message_at, updated_at)
  ON public.conversations TO authenticated;
GRANT UPDATE (last_read_at, is_muted)
  ON public.conversation_members TO authenticated;
GRANT UPDATE (content, media_url, is_edited, deleted_at)
  ON public.messages TO authenticated;
GRANT INSERT (author_id, college_id, department_id, content, media_urls, link_url, type)
  ON public.posts TO authenticated;
GRANT INSERT (author_id, post_id, content, parent_id)
  ON public.post_comments TO authenticated;
GRANT INSERT (professor_id, course_id, name, name_ar, description, max_students, is_active)
  ON public.student_groups TO authenticated;
GRANT INSERT (author_id, college_id, department_id, course_id, title, title_ar,
  content, content_ar, priority, published_at, expires_at)
  ON public.announcements TO authenticated;
GRANT INSERT (uploader_id, course_id, title, title_ar, file_path, file_type,
  file_size, is_public) ON public.shared_files TO authenticated;
GRANT INSERT (conversation_id, user_id) ON public.conversation_members TO authenticated;
GRANT INSERT (created_by, title, is_group) ON public.conversations TO authenticated;
GRANT INSERT (conversation_id, sender_id, content, media_url, reply_to_id)
  ON public.messages TO authenticated;
GRANT INSERT (message_id, message_created_at, user_id, emoji)
  ON public.message_reactions TO authenticated;
GRANT UPDATE (title, content, updated_at, deleted_at)
  ON public.forum_posts TO authenticated;
CREATE POLICY conversations_member_select ON public.conversations FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = id AND cm.user_id = (SELECT auth.uid())));
CREATE POLICY conversations_create_self ON public.conversations FOR INSERT TO authenticated
  WITH CHECK (created_by = (SELECT auth.uid()));
CREATE POLICY conversations_update_creator ON public.conversations FOR UPDATE TO authenticated
  USING (created_by = (SELECT auth.uid())) WITH CHECK (created_by = (SELECT auth.uid()));
CREATE POLICY conversations_delete_creator ON public.conversations FOR DELETE TO authenticated
  USING (created_by = (SELECT auth.uid()));
CREATE POLICY conversation_members_select_member ON public.conversation_members
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid()) OR EXISTS (
    SELECT 1 FROM public.conversation_members me WHERE me.conversation_id = conversation_members.conversation_id
      AND me.user_id = (SELECT auth.uid())));
CREATE POLICY conversation_members_insert_creator ON public.conversation_members
  FOR INSERT TO authenticated WITH CHECK (
    EXISTS (SELECT 1 FROM public.conversations c WHERE c.id = conversation_id
      AND c.created_by = (SELECT auth.uid())));
CREATE POLICY conversation_members_update_self ON public.conversation_members
  FOR UPDATE TO authenticated USING (user_id = (SELECT auth.uid()))
  WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY conversation_members_delete_self_or_creator ON public.conversation_members
  FOR DELETE TO authenticated USING (user_id = (SELECT auth.uid()) OR EXISTS (
    SELECT 1 FROM public.conversations c WHERE c.id = conversation_id
      AND c.created_by = (SELECT auth.uid())));
CREATE POLICY messages_member_select ON public.messages FOR SELECT TO authenticated
  USING (deleted_at IS NULL AND EXISTS (SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = messages.conversation_id AND cm.user_id = (SELECT auth.uid())));
CREATE POLICY messages_member_insert ON public.messages FOR INSERT TO authenticated
  WITH CHECK (sender_id = (SELECT auth.uid()) AND EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = messages.conversation_id AND cm.user_id = (SELECT auth.uid())));
CREATE POLICY messages_sender_update ON public.messages FOR UPDATE TO authenticated
  USING (sender_id = (SELECT auth.uid()) AND deleted_at IS NULL)
  WITH CHECK (sender_id = (SELECT auth.uid()));
CREATE POLICY messages_sender_delete ON public.messages FOR DELETE TO authenticated
  USING (sender_id = (SELECT auth.uid()));
CREATE POLICY message_reactions_read_conversation ON public.message_reactions FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM public.messages m JOIN public.conversation_members cm
    ON cm.conversation_id = m.conversation_id AND cm.user_id = (SELECT auth.uid())
    WHERE m.id = message_id AND m.created_at = message_created_at));
CREATE POLICY message_reactions_insert_self ON public.message_reactions FOR INSERT TO authenticated
  WITH CHECK (user_id = (SELECT auth.uid()) AND EXISTS (
    SELECT 1 FROM public.messages m JOIN public.conversation_members cm
      ON cm.conversation_id = m.conversation_id AND cm.user_id = (SELECT auth.uid())
    WHERE m.id = message_id AND m.created_at = message_created_at));
CREATE POLICY message_reactions_delete_self ON public.message_reactions FOR DELETE TO authenticated
  USING (user_id = (SELECT auth.uid()));

-- Finance and library: owner data is read only; management writes are limited
-- by explicit permissions and institutional/course scope.
GRANT SELECT ON public.invoices, public.scholarships, public.scholarship_applications,
  public.library_items, public.library_borrows, public.library_reservations,
  public.library_reading_history TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.library_items TO authenticated;
GRANT INSERT (item_id, user_id, expires_at) ON public.library_reservations TO authenticated;
GRANT DELETE ON public.library_reservations TO authenticated;
GRANT INSERT (student_id, scholarship_id, semester, semester_id, documents)
  ON public.scholarship_applications TO authenticated;
GRANT UPDATE (status, reviewed_by, review_notes, reviewed_at)
  ON public.scholarship_applications TO authenticated;
GRANT INSERT, UPDATE, DELETE ON public.library_borrows TO authenticated;
CREATE POLICY invoices_read_owner_or_finance ON public.invoices FOR SELECT TO authenticated
  USING (student_id = (SELECT auth.uid()) AND public.has_permission('finance.read')
    OR public.has_permission('finance.read') AND public.can_review_student(student_id));
CREATE POLICY scholarships_read_active ON public.scholarships FOR SELECT TO authenticated
  USING (is_active AND public.has_permission('finance.read'));
CREATE POLICY scholarships_manage_permission ON public.scholarships FOR ALL TO authenticated
  USING (public.has_permission('finance.read') AND public.has_permission('colleges.manage'))
  WITH CHECK (public.has_permission('finance.read') AND public.has_permission('colleges.manage'));
CREATE POLICY scholarship_apps_read_owner_or_manager ON public.scholarship_applications
  FOR SELECT TO authenticated USING (student_id = (SELECT auth.uid())
    OR (public.has_permission('finance.read') AND public.can_review_student(student_id)));
CREATE POLICY scholarship_apps_insert_owner ON public.scholarship_applications
  FOR INSERT TO authenticated WITH CHECK (student_id = (SELECT auth.uid())
    AND public.has_permission('finance.read'));
CREATE POLICY scholarship_apps_update_manager ON public.scholarship_applications
  FOR UPDATE TO authenticated USING (public.has_permission('finance.read')
    AND public.can_review_student(student_id))
  WITH CHECK (public.has_permission('finance.read') AND public.can_review_student(student_id));
CREATE POLICY library_items_read_active ON public.library_items FOR SELECT TO authenticated
  USING (public.get_my_role() IS NOT NULL
    AND (college_id IS NULL OR college_id = (SELECT college_id FROM public.profiles
                                              WHERE id = (SELECT auth.uid()))));
CREATE POLICY library_items_manage ON public.library_items FOR ALL TO authenticated
  USING (public.has_permission('library.manage')
    AND college_id IS NOT DISTINCT FROM (SELECT college_id FROM public.profiles
                                          WHERE id = (SELECT auth.uid())))
  WITH CHECK (public.has_permission('library.manage')
    AND college_id IS NOT DISTINCT FROM (SELECT college_id FROM public.profiles
                                          WHERE id = (SELECT auth.uid())));
CREATE POLICY library_borrows_read_owner_or_librarian ON public.library_borrows
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid())
    OR (public.has_permission('library.manage') AND EXISTS (
      SELECT 1 FROM public.library_items i WHERE i.id = library_borrows.item_id
        AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
          FROM public.profiles WHERE id = (SELECT auth.uid())))));
CREATE POLICY library_borrows_manage_librarian ON public.library_borrows
  FOR ALL TO authenticated USING (public.has_permission('library.manage') AND EXISTS (
    SELECT 1 FROM public.library_items i WHERE i.id = library_borrows.item_id
      AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
        FROM public.profiles WHERE id = (SELECT auth.uid()))))
  WITH CHECK (public.has_permission('library.manage') AND EXISTS (
    SELECT 1 FROM public.library_items i WHERE i.id = library_borrows.item_id
      AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
        FROM public.profiles WHERE id = (SELECT auth.uid()))));
CREATE POLICY library_reservations_read_owner_or_librarian ON public.library_reservations
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid())
    OR (public.has_permission('library.manage') AND EXISTS (
      SELECT 1 FROM public.library_items i WHERE i.id = library_reservations.item_id
        AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
          FROM public.profiles WHERE id = (SELECT auth.uid())))));
CREATE POLICY library_reservations_insert_owner ON public.library_reservations
  FOR INSERT TO authenticated WITH CHECK (user_id = (SELECT auth.uid())
    AND public.get_my_role() IS NOT NULL AND EXISTS (
      SELECT 1 FROM public.library_items i WHERE i.id = library_reservations.item_id));
CREATE POLICY library_reservations_delete_owner_or_librarian ON public.library_reservations
  FOR DELETE TO authenticated USING (user_id = (SELECT auth.uid())
    OR (public.has_permission('library.manage') AND EXISTS (
      SELECT 1 FROM public.library_items i WHERE i.id = library_reservations.item_id
        AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
          FROM public.profiles WHERE id = (SELECT auth.uid())))));
CREATE POLICY library_history_read_owner_or_librarian ON public.library_reading_history
  FOR SELECT TO authenticated USING (user_id = (SELECT auth.uid())
    OR (public.has_permission('library.manage') AND EXISTS (
      SELECT 1 FROM public.library_items i WHERE i.id = library_reading_history.item_id
        AND i.college_id IS NOT DISTINCT FROM (SELECT college_id
          FROM public.profiles WHERE id = (SELECT auth.uid())))));

-- User-owned preferences, sessions and notifications; no direct access to
-- payment transactions, system settings, encryption material, audit logs,
-- analytics, notification delivery internals, exams, or exam answer keys.
GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_preferences,
  public.notification_preferences, public.user_sessions TO authenticated;
GRANT SELECT, UPDATE ON public.notifications TO authenticated;
CREATE POLICY user_preferences_owner ON public.user_preferences FOR ALL TO authenticated
  USING (user_id = (SELECT auth.uid())) WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY notification_preferences_owner ON public.notification_preferences FOR ALL TO authenticated
  USING (user_id = (SELECT auth.uid())) WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY user_sessions_owner ON public.user_sessions FOR ALL TO authenticated
  USING (user_id = (SELECT auth.uid())) WITH CHECK (user_id = (SELECT auth.uid()));
CREATE POLICY notifications_read_owner ON public.notifications FOR SELECT TO authenticated
  USING (user_id = (SELECT auth.uid()) AND public.has_permission('notifications.read'));
CREATE POLICY notifications_update_owner ON public.notifications FOR UPDATE TO authenticated
  USING (user_id = (SELECT auth.uid()) AND public.has_permission('notifications.read'))
  WITH CHECK (user_id = (SELECT auth.uid()) AND public.has_permission('notifications.read'));

-- Existing lookup indexes cover most policy joins; these complete the hot
-- staff assignment and department announcement predicates.
CREATE INDEX IF NOT EXISTS idx_teaching_assistants_course_active
  ON public.teaching_assistants(course_id, profile_id) WHERE is_active;
CREATE INDEX IF NOT EXISTS idx_teaching_assistants_profile_active
  ON public.teaching_assistants(profile_id, course_id) WHERE is_active;
CREATE INDEX IF NOT EXISTS idx_announcements_department_scope
  ON public.announcements(department_id) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_department_projects_department
  ON public.department_projects(department_id);
CREATE INDEX IF NOT EXISTS idx_office_hours_professor
  ON public.office_hours(professor_id);
CREATE INDEX IF NOT EXISTS idx_student_course_regs_course_student
  ON public.student_course_registrations(course_id, student_id);
CREATE INDEX IF NOT EXISTS idx_registration_request_courses_course_request
  ON public.registration_request_courses(course_id, request_id);
CREATE INDEX IF NOT EXISTS idx_group_members_student_group
  ON public.group_members(student_id, group_id);
CREATE INDEX IF NOT EXISTS idx_library_borrows_item
  ON public.library_borrows(item_id);
CREATE INDEX IF NOT EXISTS idx_library_reservations_item
  ON public.library_reservations(item_id);
CREATE INDEX IF NOT EXISTS idx_shared_files_uploader
  ON public.shared_files(uploader_id);

-- Reapply the Phase 3 safe profile column contract after the global grant reset.
CREATE POLICY profiles_select_active ON public.profiles FOR SELECT TO authenticated
  USING (is_active AND NOT is_banned AND deleted_at IS NULL);
CREATE POLICY profiles_update_self ON public.profiles FOR UPDATE TO authenticated
  USING (id = (SELECT auth.uid()) AND public.has_permission('profiles.self_edit'))
  WITH CHECK (id = (SELECT auth.uid()) AND public.has_permission('profiles.self_edit'));
GRANT SELECT (id, full_name, full_name_ar, avatar_url, college_id,
  department_id, created_at, updated_at) ON public.profiles TO authenticated;
GRANT UPDATE (full_name, phone, bio, avatar_url) ON public.profiles TO authenticated;
GRANT SELECT ON public.profile_directory TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_my_profile_private(),
  public.update_my_profile(text, text, text, text),
  public.get_advisor_directory(uuid, boolean, boolean),
  public.assign_student_advisor(uuid, uuid) TO authenticated;

COMMENT ON FUNCTION public.can_manage_department(uuid) IS
  'Permission and profile-scope check for department or college leadership; null college is university scope only with colleges.manage.';
COMMENT ON FUNCTION public.can_review_student(uuid) IS
  'Auth.uid-bound student access for assigned advisors and in-scope academic or registration permissions.';
