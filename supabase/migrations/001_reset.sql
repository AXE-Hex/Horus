-- ============================================================================
--  001_reset.sql — COMPLETE SCHEMA TEARDOWN
--  Purpose : Drop every object in strict reverse-dependency order so the
--            schema can be rebuilt from scratch without conflicts.
--  Run     : Execute this FIRST before any other migration file.
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. STORAGE POLICIES
-- ══════════════════════════════════════════════════════════════════════════════

DROP POLICY IF EXISTS "post_media_select"               ON storage.objects;
DROP POLICY IF EXISTS "post_media_insert"               ON storage.objects;
DROP POLICY IF EXISTS "post_media_update"               ON storage.objects;
DROP POLICY IF EXISTS "post_media_delete"               ON storage.objects;
DROP POLICY IF EXISTS "chat_media_auth_view"            ON storage.objects;
DROP POLICY IF EXISTS "chat_media_auth_upload"          ON storage.objects;
DROP POLICY IF EXISTS "chat_media_own_delete"           ON storage.objects;
-- Legacy policy names
DROP POLICY IF EXISTS "Public Access for post_media"              ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload post_media" ON storage.objects;
DROP POLICY IF EXISTS "Users can update their own post_media"     ON storage.objects;
DROP POLICY IF EXISTS "Users can delete their own post_media"     ON storage.objects;

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. TRIGGERS
-- ══════════════════════════════════════════════════════════════════════════════

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
DROP TRIGGER IF EXISTS conversations_updated_at           ON public.conversations;
DROP TRIGGER IF EXISTS trg_update_post_likes_count        ON public.post_likes;
DROP TRIGGER IF EXISTS trg_update_post_comments_count     ON public.post_comments;
DROP TRIGGER IF EXISTS trg_cumulative_gpa                 ON public.semester_gpa;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. MATERIALIZED VIEWS
-- ══════════════════════════════════════════════════════════════════════════════

DROP MATERIALIZED VIEW IF EXISTS public.mv_student_academic_summary CASCADE;
DROP MATERIALIZED VIEW IF EXISTS public.mv_financial_daily          CASCADE;
DROP MATERIALIZED VIEW IF EXISTS public.mv_revenue_monthly          CASCADE;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. VIEWS
-- ══════════════════════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS public.vw_transcript CASCADE;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. TABLES (reverse dependency order)
-- ══════════════════════════════════════════════════════════════════════════════

-- System & Operations
DROP TABLE IF EXISTS public.app_versions                CASCADE;
DROP TABLE IF EXISTS public.login_attempts              CASCADE;
DROP TABLE IF EXISTS public.ministry_sync_logs          CASCADE;
DROP TABLE IF EXISTS public.analytics_events            CASCADE;
DROP TABLE IF EXISTS public.ai_predictions              CASCADE;
DROP TABLE IF EXISTS public.course_recommendations      CASCADE;
DROP TABLE IF EXISTS public.translation_requests        CASCADE;
DROP TABLE IF EXISTS public.translations                CASCADE;
DROP TABLE IF EXISTS public.supported_locales           CASCADE;
DROP TABLE IF EXISTS public.device_push_tokens          CASCADE;
DROP TABLE IF EXISTS public.email_queue                 CASCADE;
DROP TABLE IF EXISTS public.sms_log                     CASCADE;
DROP TABLE IF EXISTS public.notification_deliveries     CASCADE;
DROP TABLE IF EXISTS public.notification_preferences    CASCADE;
DROP TABLE IF EXISTS public.encrypted_data              CASCADE;
DROP TABLE IF EXISTS public.encryption_keys             CASCADE;
DROP TABLE IF EXISTS public.system_settings             CASCADE;

-- Financial
DROP TABLE IF EXISTS public.scholarship_applications    CASCADE;
DROP TABLE IF EXISTS public.scholarships                CASCADE;
DROP TABLE IF EXISTS public.invoice_schedules           CASCADE;
DROP TABLE IF EXISTS public.payment_transactions        CASCADE;
DROP TABLE IF EXISTS public.invoices                    CASCADE;

-- Examinations
DROP TABLE IF EXISTS public.exam_similarity_reports     CASCADE;
DROP TABLE IF EXISTS public.exam_cheat_events           CASCADE;
DROP TABLE IF EXISTS public.attempt_answers             CASCADE;
DROP TABLE IF EXISTS public.exam_attempts               CASCADE;
DROP TABLE IF EXISTS public.question_options            CASCADE;
DROP TABLE IF EXISTS public.exam_questions              CASCADE;
DROP TABLE IF EXISTS public.online_exams                CASCADE;

-- Library
DROP TABLE IF EXISTS public.library_reading_history     CASCADE;
DROP TABLE IF EXISTS public.library_reservations        CASCADE;
DROP TABLE IF EXISTS public.library_borrows             CASCADE;
DROP TABLE IF EXISTS public.library_items               CASCADE;

-- Messaging
DROP TABLE IF EXISTS public.message_reactions           CASCADE;
DROP TABLE IF EXISTS public.messages                    CASCADE;
DROP TABLE IF EXISTS public.conversation_members        CASCADE;
DROP TABLE IF EXISTS public.conversations               CASCADE;

-- Social
DROP TABLE IF EXISTS public.post_comments               CASCADE;
DROP TABLE IF EXISTS public.post_likes                  CASCADE;
DROP TABLE IF EXISTS public.forum_posts                 CASCADE;
DROP TABLE IF EXISTS public.forums                      CASCADE;
DROP TABLE IF EXISTS public.shared_files                CASCADE;
DROP TABLE IF EXISTS public.announcements               CASCADE;
DROP TABLE IF EXISTS public.group_members               CASCADE;
DROP TABLE IF EXISTS public.student_groups              CASCADE;
DROP TABLE IF EXISTS public.posts                       CASCADE;

-- User services
DROP TABLE IF EXISTS public.audit_logs                  CASCADE;
DROP TABLE IF EXISTS public.user_sessions               CASCADE;
DROP TABLE IF EXISTS public.notifications               CASCADE;
DROP TABLE IF EXISTS public.user_preferences            CASCADE;
DROP TABLE IF EXISTS public.support_tickets             CASCADE;
DROP TABLE IF EXISTS public.professor_ratings           CASCADE;

-- Academic & Registration
DROP TABLE IF EXISTS public.virtual_class_attendance    CASCADE;
DROP TABLE IF EXISTS public.virtual_classes             CASCADE;
DROP TABLE IF EXISTS public.semester_gpa                CASCADE;
DROP TABLE IF EXISTS public.action_plan_items           CASCADE;
DROP TABLE IF EXISTS public.attendance                  CASCADE;
DROP TABLE IF EXISTS public.exam_schedules              CASCADE;
DROP TABLE IF EXISTS public.schedules                   CASCADE;
DROP TABLE IF EXISTS public.grades                      CASCADE;
DROP TABLE IF EXISTS public.enrollments                 CASCADE;
DROP TABLE IF EXISTS public.registration_request_courses CASCADE;
DROP TABLE IF EXISTS public.registration_requests       CASCADE;
DROP TABLE IF EXISTS public.student_course_registrations CASCADE;
DROP TABLE IF EXISTS public.student_registrations       CASCADE;

-- Academic Core
DROP TABLE IF EXISTS public.course_sub_sections         CASCADE;
DROP TABLE IF EXISTS public.course_sections             CASCADE;
DROP TABLE IF EXISTS public.teaching_assistants         CASCADE;
DROP TABLE IF EXISTS public.professor_details           CASCADE;
DROP TABLE IF EXISTS public.department_projects         CASCADE;
DROP TABLE IF EXISTS public.courses                     CASCADE;

-- Identity & Institution
DROP TABLE IF EXISTS public.user_roles                  CASCADE;
DROP TABLE IF EXISTS public.role_permissions            CASCADE;
DROP TABLE IF EXISTS public.permissions                 CASCADE;
DROP TABLE IF EXISTS public.role_definitions            CASCADE;
DROP TABLE IF EXISTS public.semesters                   CASCADE;
DROP TABLE IF EXISTS public.departments                 CASCADE;
DROP TABLE IF EXISTS public.colleges                    CASCADE;
DROP TABLE IF EXISTS public.profiles                    CASCADE;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. FUNCTIONS
-- ══════════════════════════════════════════════════════════════════════════════

DROP FUNCTION IF EXISTS public.update_student_count()                                                      CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user()                                                           CASCADE;
DROP FUNCTION IF EXISTS public.get_my_role()                                                               CASCADE;
DROP FUNCTION IF EXISTS public.calculate_grade_metrics()                                                   CASCADE;
DROP FUNCTION IF EXISTS public.on_registration_request_approved()                                          CASCADE;
DROP FUNCTION IF EXISTS public.fn_update_post_counts()                                                     CASCADE;
DROP FUNCTION IF EXISTS public.fn_recalculate_cumulative_gpa()                                             CASCADE;
DROP FUNCTION IF EXISTS public.fn_decrypt_field(UUID, encryption_context, TEXT)                             CASCADE;
DROP FUNCTION IF EXISTS public.fn_encrypt_field(UUID, encryption_context, TEXT, TEXT)                       CASCADE;
DROP FUNCTION IF EXISTS public.admin_create_user(TEXT,TEXT,TEXT,user_role[],TEXT,TEXT,TEXT,TEXT,UUID,UUID)     CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_user_status(UUID,BOOLEAN)                                      CASCADE;
DROP FUNCTION IF EXISTS public.admin_delete_user(UUID,BOOLEAN)                                             CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_verification(UUID,BOOLEAN)                                     CASCADE;
DROP FUNCTION IF EXISTS public.admin_toggle_ban(UUID,BOOLEAN)                                              CASCADE;
DROP FUNCTION IF EXISTS public.admin_update_tags(UUID,TEXT[])                                               CASCADE;
DROP FUNCTION IF EXISTS public.admin_update_warning_level(UUID,INT)                                        CASCADE;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. ENUM TYPES
-- ══════════════════════════════════════════════════════════════════════════════

DROP TYPE IF EXISTS public.user_role              CASCADE;
DROP TYPE IF EXISTS public.announcement_priority  CASCADE;
DROP TYPE IF EXISTS public.forum_category         CASCADE;
DROP TYPE IF EXISTS public.notification_type      CASCADE;
DROP TYPE IF EXISTS public.file_type              CASCADE;
DROP TYPE IF EXISTS public.post_type              CASCADE;
DROP TYPE IF EXISTS public.enrollment_status      CASCADE;
DROP TYPE IF EXISTS public.attendance_status      CASCADE;
DROP TYPE IF EXISTS public.day_of_week            CASCADE;
DROP TYPE IF EXISTS public.payment_status         CASCADE;
DROP TYPE IF EXISTS public.support_ticket_status  CASCADE;
DROP TYPE IF EXISTS public.session_device         CASCADE;
DROP TYPE IF EXISTS public.audit_action           CASCADE;
DROP TYPE IF EXISTS public.message_status         CASCADE;
DROP TYPE IF EXISTS public.exam_status            CASCADE;
DROP TYPE IF EXISTS public.question_type          CASCADE;
DROP TYPE IF EXISTS public.library_item_type      CASCADE;
DROP TYPE IF EXISTS public.borrow_status          CASCADE;
DROP TYPE IF EXISTS public.payment_method         CASCADE;
DROP TYPE IF EXISTS public.payment_gateway_type   CASCADE;
DROP TYPE IF EXISTS public.notif_channel          CASCADE;
DROP TYPE IF EXISTS public.notif_delivery_status  CASCADE;
DROP TYPE IF EXISTS public.ai_model_type          CASCADE;
DROP TYPE IF EXISTS public.sync_status            CASCADE;
DROP TYPE IF EXISTS public.virtual_class_status   CASCADE;
DROP TYPE IF EXISTS public.scholarship_status     CASCADE;
DROP TYPE IF EXISTS public.encryption_context     CASCADE;

-- ══════════════════════════════════════════════════════════════════════════════
-- 8. STORAGE BUCKETS
-- ══════════════════════════════════════════════════════════════════════════════

-- DELETE FROM storage.buckets WHERE id IN ('post_media', 'chat_media');

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK: This file IS the rollback. Re-run migrations to restore.
-- ════════════════════════════════════════════════════════════════════════════
