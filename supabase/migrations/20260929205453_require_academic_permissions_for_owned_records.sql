-- Ownership alone does not grant academic access. This closes reads for
-- guests and users whose canonical academic permissions have been revoked.
ALTER POLICY student_registrations_read_owner_or_reviewer
ON public.student_registrations USING (
  (student_id = (SELECT auth.uid()) AND public.has_permission('courses.enroll'))
  OR public.can_review_student(student_id)
);

ALTER POLICY student_course_regs_read_owner_or_reviewer
ON public.student_course_registrations USING (
  (student_id = (SELECT auth.uid()) AND public.has_permission('courses.enroll'))
  OR public.can_review_student(student_id) OR public.can_manage_course(course_id)
);

ALTER POLICY enrollments_read_owner_or_reviewer ON public.enrollments USING (
  (student_id = (SELECT auth.uid()) AND public.has_permission('courses.enroll'))
  OR public.can_review_student(student_id)
  OR public.can_teach_course(course_id) OR public.can_manage_course(course_id)
);

ALTER POLICY action_plans_read_owner_or_advisor ON public.action_plan_items USING (
  (student_id = (SELECT auth.uid()) AND public.has_permission('grades.read'))
  OR public.can_review_student(student_id)
);

ALTER POLICY registration_requests_read_owner_or_reviewer
ON public.registration_requests USING (
  (student_id = (SELECT auth.uid()) AND public.has_permission('courses.enroll'))
  OR (advisor_id = (SELECT auth.uid()) AND public.has_permission('students.advise'))
  OR public.can_review_student(student_id)
);

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
                   AND e.status = 'approved' AND public.has_permission('courses.enroll'))
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND e.status = 'approved'
                   AND public.can_review_student(e.student_id))
    )
  );
$$;


ALTER POLICY registration_requests_delete_pending_owner ON public.registration_requests
USING (student_id = (SELECT auth.uid()) AND status = 'pending'
  AND public.has_permission('courses.enroll'));

ALTER POLICY shared_files_read_course ON public.shared_files USING (
  deleted_at IS NULL AND course_id IS NOT NULL
  AND public.course_file_path_matches(file_path, course_id, uploader_id, id)
  AND (
    (uploader_id = (SELECT auth.uid()) AND public.has_permission('materials.upload'))
    OR (is_public AND public.has_permission('materials.read')
      AND public.can_access_course(course_id))
  )
);
