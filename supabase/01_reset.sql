-- ============================================================================
--  FILE 1 OF 5 — COMPLETE DATABASE RESET
--  Purpose : Tear down every object in strict reverse-dependency order so
--            the schema can be rebuilt from scratch without conflicts.
--  Run     : Execute this file FIRST before any other file.
-- ============================================================================

-- ── Storage Policies (Supabase storage layer) ────────────────────────────────
DROP POLICY IF EXISTS "post_media_select" ON storage.objects;
DROP POLICY IF EXISTS "post_media_insert" ON storage.objects;
DROP POLICY IF EXISTS "post_media_update" ON storage.objects;
DROP POLICY IF EXISTS "post_media_delete" ON storage.objects;
-- Legacy policy names (from earlier versions)
DROP POLICY IF EXISTS "Public Access for post_media"              ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload post_media" ON storage.objects;
DROP POLICY IF EXISTS "Users can update their own post_media"     ON storage.objects;
DROP POLICY IF EXISTS "Users can delete their own post_media"     ON storage.objects;

-- ── Triggers ─────────────────────────────────────────────────────────────────
DROP TRIGGER IF EXISTS on_profile_college_dept_change     ON public.profiles;
DROP TRIGGER IF EXISTS on_auth_user_created               ON auth.users;
DROP TRIGGER IF EXISTS profiles_updated_at                ON public.profiles;
DROP TRIGGER IF EXISTS colleges_updated_at                ON public.colleges;
DROP TRIGGER IF EXISTS departments_updated_at             ON public.departments;
DROP TRIGGER IF EXISTS courses_updated_at                 ON public.courses;
DROP TRIGGER IF EXISTS grades_updated_at                  ON public.grades;
DROP TRIGGER IF EXISTS grades_metrics_trigger             ON public.grades;
DROP TRIGGER IF EXISTS on_request_approved                ON public.registration_requests;
DROP TRIGGER IF EXISTS registration_requests_updated_at   ON public.registration_requests;
DROP TRIGGER IF EXISTS posts_updated_at                   ON public.posts;

-- ── Tables (reverse dependency order) ───────────────────────────────────────
DROP TABLE IF EXISTS public.audit_logs                    CASCADE;
DROP TABLE IF EXISTS public.action_plan_items             CASCADE;
DROP TABLE IF EXISTS public.user_sessions                 CASCADE;
DROP TABLE IF EXISTS public.notifications                 CASCADE;
DROP TABLE IF EXISTS public.invoices                      CASCADE;
DROP TABLE IF EXISTS public.professor_ratings             CASCADE;
DROP TABLE IF EXISTS public.support_tickets               CASCADE;
DROP TABLE IF EXISTS public.forum_posts                   CASCADE;
DROP TABLE IF EXISTS public.forums                        CASCADE;
DROP TABLE IF EXISTS public.shared_files                  CASCADE;
DROP TABLE IF EXISTS public.posts                         CASCADE;
DROP TABLE IF EXISTS public.announcements                 CASCADE;
DROP TABLE IF EXISTS public.group_members                 CASCADE;
DROP TABLE IF EXISTS public.student_groups                CASCADE;
DROP TABLE IF EXISTS public.office_hours                  CASCADE;
DROP TABLE IF EXISTS public.attendance                    CASCADE;
DROP TABLE IF EXISTS public.exam_schedules                CASCADE;
DROP TABLE IF EXISTS public.schedules                     CASCADE;
DROP TABLE IF EXISTS public.grades                        CASCADE;
DROP TABLE IF EXISTS public.enrollments                   CASCADE;
DROP TABLE IF EXISTS public.registration_request_courses  CASCADE;
DROP TABLE IF EXISTS public.registration_requests         CASCADE;
DROP TABLE IF EXISTS public.student_course_registrations  CASCADE;
DROP TABLE IF EXISTS public.student_registrations         CASCADE;
DROP TABLE IF EXISTS public.course_sub_sections           CASCADE;
DROP TABLE IF EXISTS public.course_sections               CASCADE;
DROP TABLE IF EXISTS public.teaching_assistants           CASCADE;
DROP TABLE IF EXISTS public.professor_details             CASCADE;
DROP TABLE IF EXISTS public.department_projects           CASCADE;
DROP TABLE IF EXISTS public.courses                       CASCADE;
DROP TABLE IF EXISTS public.departments                   CASCADE;
DROP TABLE IF EXISTS public.colleges                      CASCADE;
DROP TABLE IF EXISTS public.profiles                      CASCADE;

-- ── Functions ─────────────────────────────────────────────────────────────────
DROP FUNCTION IF EXISTS public.update_student_count()                                                       CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user()                                                            CASCADE;
DROP FUNCTION IF EXISTS public.get_my_role()                                                                CASCADE;
DROP FUNCTION IF EXISTS public.calculate_grade_metrics()                                                    CASCADE;
DROP FUNCTION IF EXISTS public.on_registration_request_approved()                                           CASCADE;
DROP FUNCTION IF EXISTS public.admin_create_user(TEXT,TEXT,TEXT,user_role[],TEXT,TEXT,TEXT,TEXT,UUID,UUID)  CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_user_status(UUID,BOOLEAN)                                       CASCADE;
DROP FUNCTION IF EXISTS public.admin_delete_user(UUID,BOOLEAN)                                              CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_verification(UUID,BOOLEAN)                                      CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_ban(UUID,BOOLEAN)                                               CASCADE;
DROP FUNCTION IF EXISTS public.admin_update_tags(UUID,TEXT[])                                               CASCADE;
DROP FUNCTION IF EXISTS public.admin_update_warning_level(UUID,INT)                                         CASCADE;

-- ── Enum Types ────────────────────────────────────────────────────────────────
DROP TYPE IF EXISTS public.post_type             CASCADE;
DROP TYPE IF EXISTS public.user_role             CASCADE;
DROP TYPE IF EXISTS public.announcement_priority CASCADE;
DROP TYPE IF EXISTS public.enrollment_status     CASCADE;
DROP TYPE IF EXISTS public.payment_status        CASCADE;
DROP TYPE IF EXISTS public.attendance_status     CASCADE;
DROP TYPE IF EXISTS public.notification_type     CASCADE;
DROP TYPE IF EXISTS public.file_type             CASCADE;
DROP TYPE IF EXISTS public.day_of_week           CASCADE;
DROP TYPE IF EXISTS public.session_device        CASCADE;
DROP TYPE IF EXISTS public.forum_category        CASCADE;
DROP TYPE IF EXISTS public.support_ticket_status CASCADE;
DROP TYPE IF EXISTS public.audit_action          CASCADE;

-- ── Storage Buckets ───────────────────────────────────────────────────────────
-- DELETE FROM storage.buckets WHERE id = 'post_media';