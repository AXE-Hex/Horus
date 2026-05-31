

-- FILE: 001_reset.sql
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


-- FILE: 002_extensions.sql
-- ============================================================================
--  002_extensions.sql — POSTGRESQL EXTENSIONS
--  Purpose : Install all required PostgreSQL extensions.
--  Depends : 001_reset.sql
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";      -- gen_random_uuid(), crypt(), gen_salt()
CREATE EXTENSION IF NOT EXISTS "moddatetime";   -- Automatic updated_at maintenance
-- CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- Trigram similarity for fuzzy search (future)

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP EXTENSION IF EXISTS "moddatetime";
-- DROP EXTENSION IF EXISTS "pgcrypto";
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 003_types.sql
-- ============================================================================
--  003_types.sql — ALL ENUM TYPES (CONSOLIDATED)
--  Purpose : Single source of truth for every ENUM type in the system.
--            Organized by domain with clear documentation.
--  Depends : 002_extensions.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- IDENTITY & ACCESS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE public.user_role AS ENUM (
      -- University leadership
      'rector', 'dean', 'department_head', 'assistant_hod', 'academic_coordinator',
      -- Faculty
      'professor', 'lecturer', 'teaching_assistant',
      -- Staff
      'registrar_officer', 'academic_advisor', 'librarian',
      -- Students
      'freshman', 'regular_student', 'student', 'class_representative', 'alumni',
      -- Operations
      'dorm_supervisor', 'security_officer',
      -- External
      'guest', 'parent', 'recruiter'
    );
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'session_device') THEN
    CREATE TYPE public.session_device AS ENUM ('mobile', 'desktop', 'tablet', 'unknown');
  END IF;
END $$;

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'audit_action') THEN
    CREATE TYPE public.audit_action AS ENUM (
      'create', 'update', 'delete', 'login', 'logout',
      'toggle_status', 'role_change', 'password_reset', 'view',
      'export', 'import', 'approve', 'reject'
    );
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- CONTENT & COMMUNICATION
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'post_type') THEN
    CREATE TYPE public.post_type AS ENUM ('text', 'image', 'video', 'link', 'announcement');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'announcement_priority') THEN
    CREATE TYPE public.announcement_priority AS ENUM ('normal', 'important', 'urgent');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'forum_category') THEN
    CREATE TYPE public.forum_category AS ENUM ('general', 'academic', 'social', 'feedback');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notification_type') THEN
    CREATE TYPE public.notification_type AS ENUM ('info', 'warning', 'success', 'error');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'file_type') THEN
    CREATE TYPE public.file_type AS ENUM ('pdf', 'docx', 'pptx', 'xlsx', 'image', 'video', 'other');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'message_status') THEN
    CREATE TYPE public.message_status AS ENUM ('sent', 'delivered', 'read', 'deleted');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- ACADEMIC WORKFLOW
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'enrollment_status') THEN
    CREATE TYPE public.enrollment_status AS ENUM ('pending', 'approved', 'rejected', 'withdrawn', 'cancelled');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'attendance_status') THEN
    CREATE TYPE public.attendance_status AS ENUM ('present', 'absent', 'late', 'excused');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'day_of_week') THEN
    CREATE TYPE public.day_of_week AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- EXAMINATIONS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'exam_status') THEN
    CREATE TYPE public.exam_status AS ENUM ('draft', 'published', 'in_progress', 'completed', 'cancelled');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'question_type') THEN
    CREATE TYPE public.question_type AS ENUM ('mcq', 'true_false', 'short_answer', 'essay', 'file_upload');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- LIBRARY
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'library_item_type') THEN
    CREATE TYPE public.library_item_type AS ENUM ('book', 'journal', 'thesis', 'research_paper', 'e_resource', 'video');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'borrow_status') THEN
    CREATE TYPE public.borrow_status AS ENUM ('reserved', 'borrowed', 'returned', 'overdue', 'lost');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- FINANCIAL
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_status') THEN
    CREATE TYPE public.payment_status AS ENUM ('pending', 'paid', 'overdue', 'refunded');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN
    CREATE TYPE public.payment_method AS ENUM ('cash', 'card', 'bank_transfer', 'paymob', 'stripe', 'wallet');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_gateway_type') THEN
    CREATE TYPE public.payment_gateway_type AS ENUM ('paymob', 'stripe', 'cash', 'bank_transfer', 'wallet');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'scholarship_status') THEN
    CREATE TYPE public.scholarship_status AS ENUM ('open', 'applied', 'under_review', 'awarded', 'rejected', 'expired');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- SUPPORT & OPERATIONS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'support_ticket_status') THEN
    CREATE TYPE public.support_ticket_status AS ENUM ('open', 'in_progress', 'resolved', 'closed');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sync_status') THEN
    CREATE TYPE public.sync_status AS ENUM ('pending', 'synced', 'failed', 'skipped', 'retry');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'virtual_class_status') THEN
    CREATE TYPE public.virtual_class_status AS ENUM ('scheduled', 'live', 'ended', 'cancelled');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- NOTIFICATIONS (MULTI-CHANNEL)
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_channel') THEN
    CREATE TYPE public.notif_channel AS ENUM ('in_app', 'email', 'sms', 'push');
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_delivery_status') THEN
    CREATE TYPE public.notif_delivery_status AS ENUM ('pending', 'sent', 'delivered', 'failed', 'bounced');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- AI & ANALYTICS
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ai_model_type') THEN
    CREATE TYPE public.ai_model_type AS ENUM ('gpa_predictor', 'cheat_detector', 'course_recommender', 'dropout_risk', 'grade_forecast');
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- SECURITY & ENCRYPTION
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'encryption_context') THEN
    CREATE TYPE public.encryption_context AS ENUM ('national_id', 'bank_account', 'medical', 'grade', 'financial');
  END IF;
END $$;

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TYPE IF EXISTS public.encryption_context CASCADE;
-- DROP TYPE IF EXISTS public.ai_model_type CASCADE;
-- DROP TYPE IF EXISTS public.notif_delivery_status CASCADE;
-- DROP TYPE IF EXISTS public.notif_channel CASCADE;
-- DROP TYPE IF EXISTS public.virtual_class_status CASCADE;
-- DROP TYPE IF EXISTS public.sync_status CASCADE;
-- DROP TYPE IF EXISTS public.support_ticket_status CASCADE;
-- DROP TYPE IF EXISTS public.scholarship_status CASCADE;
-- DROP TYPE IF EXISTS public.payment_gateway_type CASCADE;
-- DROP TYPE IF EXISTS public.payment_method CASCADE;
-- DROP TYPE IF EXISTS public.payment_status CASCADE;
-- DROP TYPE IF EXISTS public.borrow_status CASCADE;
-- DROP TYPE IF EXISTS public.library_item_type CASCADE;
-- DROP TYPE IF EXISTS public.question_type CASCADE;
-- DROP TYPE IF EXISTS public.exam_status CASCADE;
-- DROP TYPE IF EXISTS public.day_of_week CASCADE;
-- DROP TYPE IF EXISTS public.attendance_status CASCADE;
-- DROP TYPE IF EXISTS public.enrollment_status CASCADE;
-- DROP TYPE IF EXISTS public.message_status CASCADE;
-- DROP TYPE IF EXISTS public.file_type CASCADE;
-- DROP TYPE IF EXISTS public.notification_type CASCADE;
-- DROP TYPE IF EXISTS public.forum_category CASCADE;
-- DROP TYPE IF EXISTS public.announcement_priority CASCADE;
-- DROP TYPE IF EXISTS public.post_type CASCADE;
-- DROP TYPE IF EXISTS public.audit_action CASCADE;
-- DROP TYPE IF EXISTS public.session_device CASCADE;
-- DROP TYPE IF EXISTS public.user_role CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 004_identity.sql
-- ============================================================================
--  004_identity.sql — IDENTITY, ACCESS CONTROL & SESSIONS
--  Purpose : Core user identity, role-based access control, preferences,
--            and session management.
--  Depends : 003_types.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. PROFILES — Core user identity (slimmed from 23+ columns)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.profiles (
  id            UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email         TEXT        NOT NULL UNIQUE,
  full_name     TEXT        NOT NULL,
  full_name_ar  TEXT,
  avatar_url    TEXT,
  -- Role array kept for backward compatibility with Dart models.
  -- The user_roles junction table is the canonical source for queries.
  roles         user_role[] NOT NULL DEFAULT '{student}',
  -- Student-specific fields (kept on profiles for query simplicity)
  student_id    TEXT        UNIQUE,
  national_id   TEXT        UNIQUE,
  nationality   TEXT,
  phone         TEXT,
  bio           TEXT,
  bio_ar        TEXT,
  -- Institutional affiliation (FKs added after colleges/departments exist)
  college_id    UUID,
  department_id UUID,
  advisor_id    UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  -- Moderation
  warning_level INT         NOT NULL DEFAULT 0 CHECK (warning_level >= 0),
  is_verified   BOOLEAN     NOT NULL DEFAULT FALSE,
  tags          TEXT[]      NOT NULL DEFAULT '{}',
  is_banned     BOOLEAN     NOT NULL DEFAULT FALSE,
  is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
  -- Timestamps
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS profiles_updated_at ON public.profiles;
CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. ROLE DEFINITIONS — Canonical role registry
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.role_definitions (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  code        TEXT        NOT NULL UNIQUE,         -- matches user_role enum value
  name_en     TEXT        NOT NULL,
  name_ar     TEXT,
  description TEXT,
  priority    SMALLINT    NOT NULL DEFAULT 99,      -- lower = higher privilege
  is_active   BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. USER_ROLES — Many-to-many junction (canonical role source)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.user_roles (
  user_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  role_id     UUID        NOT NULL REFERENCES public.role_definitions(id) ON DELETE CASCADE,
  granted_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  granted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at  TIMESTAMPTZ,  -- for temporary role assignments
  PRIMARY KEY (user_id, role_id)
);
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. PERMISSIONS — Granular permission definitions
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.permissions (
  id          UUID    PRIMARY KEY DEFAULT gen_random_uuid(),
  code        TEXT    NOT NULL UNIQUE,        -- e.g., 'grades.publish', 'users.create'
  name_en     TEXT    NOT NULL,
  name_ar     TEXT,
  module      TEXT    NOT NULL,               -- e.g., 'grades', 'users', 'finance'
  description TEXT
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. ROLE_PERMISSIONS — Role-to-permission mapping
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.role_permissions (
  role_id       UUID NOT NULL REFERENCES public.role_definitions(id) ON DELETE CASCADE,
  permission_id UUID NOT NULL REFERENCES public.permissions(id) ON DELETE CASCADE,
  PRIMARY KEY (role_id, permission_id)
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. USER PREFERENCES — All user settings in one place
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.user_preferences (
  user_id           UUID    PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  locale            TEXT    NOT NULL DEFAULT 'ar',
  theme             TEXT    NOT NULL DEFAULT 'system' CHECK (theme IN ('light', 'dark', 'system')),
  timezone          TEXT    NOT NULL DEFAULT 'Africa/Cairo',
  notifications_on  BOOLEAN NOT NULL DEFAULT TRUE,
  email_digest      TEXT    NOT NULL DEFAULT 'daily' CHECK (email_digest IN ('off', 'daily', 'weekly')),
  sms_opt_in        BOOLEAN NOT NULL DEFAULT FALSE,
  dashboard_widgets JSONB   NOT NULL DEFAULT '{}',
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. NOTIFICATION PREFERENCES — Per-channel notification settings
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.notification_preferences (
  user_id           UUID    PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  in_app_enabled    BOOLEAN NOT NULL DEFAULT TRUE,
  email_enabled     BOOLEAN NOT NULL DEFAULT TRUE,
  sms_enabled       BOOLEAN NOT NULL DEFAULT FALSE,
  push_enabled      BOOLEAN NOT NULL DEFAULT TRUE,
  channel_overrides JSONB   NOT NULL DEFAULT '{}',   -- event-level overrides
  quiet_start       TIME,
  quiet_end         TIME,
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.notification_preferences ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 8. USER SESSIONS — Active session tracking
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.user_sessions (
  id          UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  device_name TEXT,
  device_type session_device NOT NULL DEFAULT 'unknown',
  ip_address  INET,
  location    TEXT,
  user_agent  TEXT,
  is_active   BOOLEAN        NOT NULL DEFAULT TRUE,
  last_active TIMESTAMPTZ    NOT NULL DEFAULT now(),
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.user_sessions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 9. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_profiles_email          ON public.profiles(email);
CREATE INDEX IF NOT EXISTS idx_profiles_roles          ON public.profiles USING GIN(roles);
CREATE INDEX IF NOT EXISTS idx_profiles_college        ON public.profiles(college_id);
CREATE INDEX IF NOT EXISTS idx_profiles_department     ON public.profiles(department_id);
CREATE INDEX IF NOT EXISTS idx_profiles_advisor        ON public.profiles(advisor_id);
CREATE INDEX IF NOT EXISTS idx_profiles_active         ON public.profiles(is_active) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_user_roles_user         ON public.user_roles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_roles_role         ON public.user_roles(role_id);
CREATE INDEX IF NOT EXISTS idx_role_perms_role         ON public.role_permissions(role_id);
CREATE INDEX IF NOT EXISTS idx_sessions_user_active    ON public.user_sessions(user_id, is_active);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.user_sessions CASCADE;
-- DROP TABLE IF EXISTS public.notification_preferences CASCADE;
-- DROP TABLE IF EXISTS public.user_preferences CASCADE;
-- DROP TABLE IF EXISTS public.role_permissions CASCADE;
-- DROP TABLE IF EXISTS public.permissions CASCADE;
-- DROP TABLE IF EXISTS public.user_roles CASCADE;
-- DROP TABLE IF EXISTS public.role_definitions CASCADE;
-- DROP TABLE IF EXISTS public.profiles CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 005_institution.sql
-- ============================================================================
--  005_institution.sql — INSTITUTIONAL STRUCTURE
--  Purpose : Colleges, departments, semesters, and deferred FK wiring.
--  Depends : 004_identity.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. COLLEGES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.colleges (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  code           TEXT        UNIQUE,
  name_en        TEXT        NOT NULL,
  name_ar        TEXT        NOT NULL,
  description    TEXT,
  description_ar TEXT,
  dean_id        UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  image_url      TEXT,
  established    INT         CHECK (established > 1800),
  student_count  INT         NOT NULL DEFAULT 0 CHECK (student_count >= 0),
  is_active      BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.colleges ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS colleges_updated_at ON public.colleges;
CREATE TRIGGER colleges_updated_at
  BEFORE UPDATE ON public.colleges
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. DEPARTMENTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.departments (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id       UUID        NOT NULL REFERENCES public.colleges(id) ON DELETE CASCADE,
  code             TEXT        UNIQUE,
  name_en          TEXT        NOT NULL,
  name_ar          TEXT        NOT NULL,
  hod_id           UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  assistant_hod_id UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  description      TEXT,
  description_ar   TEXT,
  office_symbol    TEXT,
  floor            INT,
  building         TEXT,
  student_count    INT         NOT NULL DEFAULT 0 CHECK (student_count >= 0),
  is_active        BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS departments_updated_at ON public.departments;
CREATE TRIGGER departments_updated_at
  BEFORE UPDATE ON public.departments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. SEMESTERS — Reference table for all semester references
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.semesters (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  code          TEXT        NOT NULL UNIQUE,     -- e.g., 'fall_2025', 'spring_2026'
  name_en       TEXT        NOT NULL,            -- e.g., 'Fall 2025'
  name_ar       TEXT        NOT NULL,            -- e.g., 'خريف 2025'
  academic_year TEXT        NOT NULL,            -- e.g., '2025-2026'
  start_date    DATE,
  end_date      DATE,
  CONSTRAINT chk_semester_dates CHECK (end_date IS NULL OR end_date > start_date),
  is_current    BOOLEAN     NOT NULL DEFAULT FALSE,
  is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. DEFERRED FOREIGN KEYS — profiles → colleges / departments
-- ══════════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints
    WHERE constraint_name = 'profiles_college_id_fkey'
      AND table_name = 'profiles' AND table_schema = 'public'
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT profiles_college_id_fkey
      FOREIGN KEY (college_id) REFERENCES public.colleges(id) ON DELETE SET NULL;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints
    WHERE constraint_name = 'profiles_department_id_fkey'
      AND table_name = 'profiles' AND table_schema = 'public'
  ) THEN
    ALTER TABLE public.profiles
      ADD CONSTRAINT profiles_department_id_fkey
      FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE SET NULL;
  END IF;
END $$;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_colleges_code        ON public.colleges(code);
CREATE INDEX IF NOT EXISTS idx_colleges_active      ON public.colleges(is_active) WHERE is_active = TRUE;
CREATE INDEX IF NOT EXISTS idx_departments_college  ON public.departments(college_id);
CREATE INDEX IF NOT EXISTS idx_departments_code     ON public.departments(code);
CREATE INDEX IF NOT EXISTS idx_departments_active   ON public.departments(is_active) WHERE is_active = TRUE;
CREATE INDEX IF NOT EXISTS idx_semesters_current    ON public.semesters(is_current) WHERE is_current = TRUE;
CREATE INDEX IF NOT EXISTS idx_semesters_year       ON public.semesters(academic_year);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_department_id_fkey;
-- ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_college_id_fkey;
-- DROP TABLE IF EXISTS public.semesters CASCADE;
-- DROP TABLE IF EXISTS public.departments CASCADE;
-- DROP TABLE IF EXISTS public.colleges CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 006_academic.sql
-- ============================================================================
--  006_academic.sql — ACADEMIC CORE
--  Purpose : Courses, sections, professor details, teaching assistants,
--            department projects.
--  Depends : 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. COURSES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.courses (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id UUID        NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  code          TEXT        NOT NULL UNIQUE,
  name_en       TEXT        NOT NULL,
  name_ar       TEXT        NOT NULL,
  description   TEXT,
  credit_hours  INT         NOT NULL DEFAULT 3 CHECK (credit_hours BETWEEN 1 AND 12),
  semester      TEXT,                         -- kept as TEXT for backward compat; new code should use semester_id
  semester_id   UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  professor_id  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  max_students  INT         NOT NULL DEFAULT 50 CHECK (max_students > 0),
  is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS courses_updated_at ON public.courses;
CREATE TRIGGER courses_updated_at
  BEFORE UPDATE ON public.courses
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. PROFESSOR DETAILS — Extended profile for faculty
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.professor_details (
  id                UUID         PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  department_id     UUID         REFERENCES public.departments(id) ON DELETE SET NULL,
  office_symbol     TEXT,
  general_rating    NUMERIC(3,2) NOT NULL DEFAULT 0 CHECK (general_rating    BETWEEN 0 AND 5),
  curriculum_rating NUMERIC(3,2) NOT NULL DEFAULT 0 CHECK (curriculum_rating BETWEEN 0 AND 5),
  total_ratings     INT          NOT NULL DEFAULT 0 CHECK (total_ratings >= 0),
  created_at        TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ  NOT NULL DEFAULT now()
);
ALTER TABLE public.professor_details ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. TEACHING ASSISTANTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.teaching_assistants (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  ta_role      TEXT        NOT NULL DEFAULT 'Lab Assistant',
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (profile_id, professor_id)
);
ALTER TABLE public.teaching_assistants ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. DEPARTMENT PROJECTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.department_projects (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id  UUID        NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  title_en       TEXT        NOT NULL,
  title_ar       TEXT        NOT NULL,
  description_en TEXT,
  description_ar TEXT,
  status         TEXT        NOT NULL DEFAULT 'active'
                             CHECK (status IN ('active', 'completed', 'paused', 'cancelled')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.department_projects ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. COURSE SECTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.course_sections (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id    UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  semester     TEXT        NOT NULL,
  semester_id  UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  max_students INT         NOT NULL DEFAULT 50 CHECK (max_students > 0),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sections ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. COURSE SUB-SECTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.course_sub_sections (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  section_id   UUID        NOT NULL REFERENCES public.course_sections(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  max_students INT         NOT NULL DEFAULT 25 CHECK (max_students > 0),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sub_sections ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. SCHEDULES — Class timetable
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.schedules (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  day              day_of_week NOT NULL,
  start_time       TIME        NOT NULL,
  end_time         TIME        NOT NULL,
  CONSTRAINT chk_schedule_times CHECK (start_time < end_time),
  room             TEXT,
  building         TEXT,
  schedule_type    TEXT        NOT NULL DEFAULT 'lecture'
                               CHECK (schedule_type IN ('lecture', 'lab', 'tutorial', 'online')),
  section_name     TEXT,
  sub_section_name TEXT,
  semester         TEXT        NOT NULL,
  semester_id      UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.schedules ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 8. EXAM SCHEDULES — Physical exam timetable
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.exam_schedules (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id   UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  exam_type   TEXT        NOT NULL DEFAULT 'final'
                          CHECK (exam_type IN ('midterm', 'final', 'quiz', 'makeup')),
  exam_date   DATE        NOT NULL,
  start_time  TIME        NOT NULL,
  end_time    TIME        NOT NULL,
  CONSTRAINT chk_exam_times CHECK (start_time < end_time),
  room        TEXT,
  building    TEXT,
  semester    TEXT        NOT NULL,
  semester_id UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  notes       TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_schedules ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 9. OFFICE HOURS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.office_hours (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  day          day_of_week NOT NULL,
  start_time   TIME        NOT NULL,
  end_time     TIME        NOT NULL,
  CONSTRAINT chk_office_times CHECK (start_time < end_time),
  location     TEXT        NOT NULL,
  is_walk_in   BOOLEAN     NOT NULL DEFAULT FALSE,
  semester     TEXT,
  semester_id  UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.office_hours ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 10. ATTENDANCE
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.attendance (
  id          UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id   UUID              NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  date        DATE              NOT NULL,
  status      attendance_status NOT NULL DEFAULT 'present',
  notes       TEXT,
  recorded_by UUID              REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, date)
);
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 11. VIRTUAL CLASSES — Zoom / Google Meet / Teams
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.virtual_classes (
  id               UUID                 PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        UUID                 NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  title            TEXT                 NOT NULL,
  title_ar         TEXT,
  provider         TEXT                 NOT NULL DEFAULT 'zoom'
                                        CHECK (provider IN ('zoom', 'google_meet', 'microsoft_teams', 'jitsi')),
  meeting_id       TEXT,
  join_url         TEXT,
  host_url         TEXT,
  passcode         TEXT,
  status           virtual_class_status NOT NULL DEFAULT 'scheduled',
  scheduled_at     TIMESTAMPTZ          NOT NULL,
  duration_minutes INT                  NOT NULL DEFAULT 90 CHECK (duration_minutes > 0),
  actual_start_at  TIMESTAMPTZ,
  actual_end_at    TIMESTAMPTZ,
  recording_url    TEXT,
  attendance_taken BOOLEAN              NOT NULL DEFAULT FALSE,
  max_participants INT,
  actual_attendees INT,
  semester         TEXT                 NOT NULL,
  semester_id      UUID                 REFERENCES public.semesters(id) ON DELETE SET NULL,
  created_by       UUID                 NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at       TIMESTAMPTZ          NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ          NOT NULL DEFAULT now()
);
ALTER TABLE public.virtual_classes ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 12. VIRTUAL CLASS ATTENDANCE
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.virtual_class_attendance (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  virtual_class_id UUID        NOT NULL REFERENCES public.virtual_classes(id) ON DELETE CASCADE,
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  left_at          TIMESTAMPTZ,
  duration_mins    INT,
  UNIQUE (virtual_class_id, student_id)
);
ALTER TABLE public.virtual_class_attendance ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 13. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

-- Courses
CREATE INDEX IF NOT EXISTS idx_courses_department     ON public.courses(department_id);
CREATE INDEX IF NOT EXISTS idx_courses_professor      ON public.courses(professor_id);
CREATE INDEX IF NOT EXISTS idx_courses_semester        ON public.courses(semester_id);
CREATE INDEX IF NOT EXISTS idx_courses_active          ON public.courses(is_active) WHERE is_active = TRUE;

-- Sections
CREATE INDEX IF NOT EXISTS idx_sections_course         ON public.course_sections(course_id);
CREATE INDEX IF NOT EXISTS idx_sub_sections_section    ON public.course_sub_sections(section_id);

-- Schedules
CREATE INDEX IF NOT EXISTS idx_schedules_course        ON public.schedules(course_id);
CREATE INDEX IF NOT EXISTS idx_schedules_day           ON public.schedules(day);
CREATE INDEX IF NOT EXISTS idx_schedules_semester       ON public.schedules(semester_id);

-- Attendance
CREATE INDEX IF NOT EXISTS idx_attendance_student      ON public.attendance(student_id);
CREATE INDEX IF NOT EXISTS idx_attendance_course       ON public.attendance(course_id);
CREATE INDEX IF NOT EXISTS idx_attendance_date         ON public.attendance(date);
CREATE INDEX IF NOT EXISTS idx_attendance_composite    ON public.attendance(student_id, course_id, date);

-- Virtual classes
CREATE INDEX IF NOT EXISTS idx_vclass_course_sched     ON public.virtual_classes(course_id, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_vclass_semester          ON public.virtual_classes(semester_id);
CREATE INDEX IF NOT EXISTS idx_vclass_status            ON public.virtual_classes(status);
CREATE INDEX IF NOT EXISTS idx_vclass_att_student       ON public.virtual_class_attendance(student_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.virtual_class_attendance CASCADE;
-- DROP TABLE IF EXISTS public.virtual_classes CASCADE;
-- DROP TABLE IF EXISTS public.attendance CASCADE;
-- DROP TABLE IF EXISTS public.office_hours CASCADE;
-- DROP TABLE IF EXISTS public.exam_schedules CASCADE;
-- DROP TABLE IF EXISTS public.schedules CASCADE;
-- DROP TABLE IF EXISTS public.course_sub_sections CASCADE;
-- DROP TABLE IF EXISTS public.course_sections CASCADE;
-- DROP TABLE IF EXISTS public.department_projects CASCADE;
-- DROP TABLE IF EXISTS public.teaching_assistants CASCADE;
-- DROP TABLE IF EXISTS public.professor_details CASCADE;
-- DROP TABLE IF EXISTS public.courses CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 007_registration.sql
-- ============================================================================
--  007_registration.sql — REGISTRATION & ENROLLMENT
--  Purpose : Student course registrations, advisor approval workflows,
--            enrollments, and long-term action plans.
--  Depends : 006_academic.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. STUDENT REGISTRATIONS — Core student semester registration status
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.student_registrations (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester         TEXT        NOT NULL,
  semester_id      UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  section_name     TEXT        NOT NULL,
  sub_section_name TEXT        NOT NULL,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, semester)
);
ALTER TABLE public.student_registrations ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. STUDENT COURSE REGISTRATIONS — Final approved list of courses
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.student_course_registrations (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester         TEXT        NOT NULL,
  semester_id      UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  section_name     TEXT,
  sub_section_name TEXT,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.student_course_registrations ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. REGISTRATION REQUESTS — Student's pending course-selection request
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.registration_requests (
  id            UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  advisor_id    UUID              REFERENCES public.profiles(id) ON DELETE SET NULL,
  semester      TEXT              NOT NULL,
  semester_id   UUID              REFERENCES public.semesters(id) ON DELETE SET NULL,
  status        enrollment_status NOT NULL DEFAULT 'pending',
  advisor_notes TEXT,
  submitted_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  reviewed_at   TIMESTAMPTZ,
  created_at    TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ       NOT NULL DEFAULT now(),
  UNIQUE (student_id, semester)
);
ALTER TABLE public.registration_requests ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS registration_requests_updated_at ON public.registration_requests;
CREATE TRIGGER registration_requests_updated_at
  BEFORE UPDATE ON public.registration_requests
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. REGISTRATION REQUEST COURSES — Line items for registration requests
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.registration_request_courses (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id       UUID        NOT NULL REFERENCES public.registration_requests(id) ON DELETE CASCADE,
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  section_name     TEXT,
  sub_section_name TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (request_id, course_id)
);
ALTER TABLE public.registration_request_courses ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. ENROLLMENTS — Active student-course linkage and current status
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.enrollments (
  id          UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id   UUID              NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  status      enrollment_status NOT NULL DEFAULT 'pending',
  semester    TEXT              NOT NULL,
  semester_id UUID              REFERENCES public.semesters(id) ON DELETE SET NULL,
  enrolled_at TIMESTAMPTZ       NOT NULL DEFAULT now(),
  approved_at TIMESTAMPTZ,
  created_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS enrollments_updated_at ON public.enrollments;
CREATE TRIGGER enrollments_updated_at
  BEFORE UPDATE ON public.enrollments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. ACTION PLAN ITEMS — Advisor-driven academic plan (future semesters)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.action_plan_items (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  semester     TEXT        NOT NULL,
  semester_id  UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  year         INT         NOT NULL CHECK (year > 2000),
  status       TEXT        NOT NULL DEFAULT 'planned'
                           CHECK (status IN ('planned', 'enrolled', 'passed', 'failed', 'withdrawn')),
  grade_letter TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.action_plan_items ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS action_plan_items_updated_at ON public.action_plan_items;
CREATE TRIGGER action_plan_items_updated_at
  BEFORE UPDATE ON public.action_plan_items
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_reg_requests_student      ON public.registration_requests(student_id);
CREATE INDEX IF NOT EXISTS idx_reg_requests_advisor      ON public.registration_requests(advisor_id);
CREATE INDEX IF NOT EXISTS idx_reg_requests_status       ON public.registration_requests(status);
CREATE INDEX IF NOT EXISTS idx_reg_requests_semester      ON public.registration_requests(semester_id);

CREATE INDEX IF NOT EXISTS idx_enrollments_student       ON public.enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course        ON public.enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_status        ON public.enrollments(status);
CREATE INDEX IF NOT EXISTS idx_enrollments_semester       ON public.enrollments(semester_id);
-- Composite index for the very common (student, semester) lookup
CREATE INDEX IF NOT EXISTS idx_enrollments_student_sem   ON public.enrollments(student_id, semester_id);

CREATE INDEX IF NOT EXISTS idx_action_plan_student       ON public.action_plan_items(student_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.action_plan_items CASCADE;
-- DROP TABLE IF EXISTS public.enrollments CASCADE;
-- DROP TABLE IF EXISTS public.registration_request_courses CASCADE;
-- DROP TABLE IF EXISTS public.registration_requests CASCADE;
-- DROP TABLE IF EXISTS public.student_course_registrations CASCADE;
-- DROP TABLE IF EXISTS public.student_registrations CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 008_grading.sql
-- ============================================================================
--  008_grading.sql — GRADES & GPA
--  Purpose : Course grades, semester GPA tracking, and grade scale configurations.
--  Depends : 006_academic.sql, 007_registration.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. GRADE SCALES — Configuration for mapping numeric grades to letter/GPA
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.grade_scales (
  id            UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id    UUID         REFERENCES public.colleges(id) ON DELETE CASCADE, -- Optional: if specific to college
  letter        TEXT         NOT NULL, -- e.g., 'A', 'B+'
  min_score     NUMERIC(5,2) NOT NULL CHECK (min_score >= 0 AND min_score <= 100),
  max_score     NUMERIC(5,2) NOT NULL CHECK (max_score >= 0 AND max_score <= 100),
  gpa_points    NUMERIC(3,2) NOT NULL CHECK (gpa_points >= 0 AND gpa_points <= 4.0),
  is_passing    BOOLEAN      NOT NULL DEFAULT TRUE,
  CONSTRAINT chk_grade_range CHECK (min_score < max_score),
  UNIQUE (college_id, letter)
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. GRADES — Individual course grades
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.grades (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester     TEXT        NOT NULL,
  semester_id  UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  -- Components
  coursework   NUMERIC(5,2) CHECK (coursework BETWEEN 0 AND 100),
  midterm      NUMERIC(5,2) CHECK (midterm    BETWEEN 0 AND 100),
  practical    NUMERIC(5,2) CHECK (practical  BETWEEN 0 AND 100),
  final_exam   NUMERIC(5,2) CHECK (final_exam BETWEEN 0 AND 100),
  -- Computed Totals (can be set by triggers)
  total        NUMERIC(5,2),
  grade_letter TEXT,
  gpa_points   NUMERIC(3,2),
  -- Workflow
  is_published BOOLEAN     NOT NULL DEFAULT FALSE,
  published_at TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.grades ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS grades_updated_at ON public.grades;
CREATE TRIGGER grades_updated_at
  BEFORE UPDATE ON public.grades
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. SEMESTER GPA — Aggregated performance per semester
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.semester_gpa (
  id                 UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id         UUID         NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester           TEXT         NOT NULL,
  semester_id        UUID         REFERENCES public.semesters(id) ON DELETE SET NULL,
  total_credits      INT          NOT NULL DEFAULT 0,
  earned_credits     INT          NOT NULL DEFAULT 0,
  quality_points     NUMERIC(8,2) NOT NULL DEFAULT 0,
  semester_gpa       NUMERIC(4,2) NOT NULL DEFAULT 0,
  cumulative_gpa     NUMERIC(4,2) NOT NULL DEFAULT 0,
  cumulative_credits INT          NOT NULL DEFAULT 0,
  is_official        BOOLEAN      NOT NULL DEFAULT FALSE,
  created_at         TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at         TIMESTAMPTZ  NOT NULL DEFAULT now(),
  UNIQUE (student_id, semester)
);
ALTER TABLE public.semester_gpa ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS semester_gpa_updated_at ON public.semester_gpa;
CREATE TRIGGER semester_gpa_updated_at
  BEFORE UPDATE ON public.semester_gpa
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_grades_student            ON public.grades(student_id);
CREATE INDEX IF NOT EXISTS idx_grades_course             ON public.grades(course_id);
CREATE INDEX IF NOT EXISTS idx_grades_semester           ON public.grades(semester_id);
CREATE INDEX IF NOT EXISTS idx_grades_published          ON public.grades(is_published);
-- Critical composite index for transcript generation
CREATE INDEX IF NOT EXISTS idx_grades_student_sem_pub    ON public.grades(student_id, semester_id, is_published);

CREATE INDEX IF NOT EXISTS idx_sem_gpa_student           ON public.semester_gpa(student_id);
CREATE INDEX IF NOT EXISTS idx_sem_gpa_semester          ON public.semester_gpa(semester_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.semester_gpa CASCADE;
-- DROP TABLE IF EXISTS public.grades CASCADE;
-- DROP TABLE IF EXISTS public.grade_scales CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 009_social.sql
-- ============================================================================
--  009_social.sql — SOCIAL & COMMUNICATION
--  Purpose : Social feed, posts, student groups, announcements, shared files, forums.
--  Depends : 004_identity.sql, 005_institution.sql, 006_academic.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. POSTS (Social Feed)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.posts (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id      UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  college_id     UUID        REFERENCES public.colleges(id) ON DELETE CASCADE,
  content        TEXT        NOT NULL,
  media_urls     TEXT[]      NOT NULL DEFAULT '{}',
  link_url       TEXT,
  type           post_type   NOT NULL DEFAULT 'text',
  -- Denormalized counters (managed by triggers)
  likes_count    INT         NOT NULL DEFAULT 0 CHECK (likes_count >= 0),
  comments_count INT         NOT NULL DEFAULT 0 CHECK (comments_count >= 0),
  is_pinned      BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS posts_updated_at ON public.posts;
CREATE TRIGGER posts_updated_at
  BEFORE UPDATE ON public.posts
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. POST LIKES & COMMENTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.post_likes (
  post_id    UUID        NOT NULL REFERENCES public.posts(id) ON DELETE CASCADE,
  user_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (post_id, user_id)
);
ALTER TABLE public.post_likes ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.post_comments (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id    UUID        NOT NULL REFERENCES public.posts(id) ON DELETE CASCADE,
  author_id  UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content    TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);
ALTER TABLE public.post_comments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS post_comments_updated_at ON public.post_comments;
CREATE TRIGGER post_comments_updated_at
  BEFORE UPDATE ON public.post_comments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. STUDENT GROUPS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.student_groups (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  name         TEXT        NOT NULL,
  name_ar      TEXT,
  description  TEXT,
  max_students INT         NOT NULL DEFAULT 50 CHECK (max_students > 0),
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.student_groups ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.group_members (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id   UUID        NOT NULL REFERENCES public.student_groups(id) ON DELETE CASCADE,
  student_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (group_id, student_id)
);
ALTER TABLE public.group_members ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. ANNOUNCEMENTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.announcements (
  id           UUID                  PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id    UUID                  NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  college_id   UUID                  REFERENCES public.colleges(id) ON DELETE CASCADE,
  department_id UUID                 REFERENCES public.departments(id) ON DELETE CASCADE,
  course_id    UUID                  REFERENCES public.courses(id) ON DELETE SET NULL,
  title        TEXT                  NOT NULL,
  title_ar     TEXT,
  content      TEXT                  NOT NULL,
  content_ar   TEXT,
  priority     announcement_priority NOT NULL DEFAULT 'normal',
  is_pinned    BOOLEAN               NOT NULL DEFAULT FALSE,
  published_at TIMESTAMPTZ           NOT NULL DEFAULT now(),
  expires_at   TIMESTAMPTZ,
  CONSTRAINT chk_announcement_dates CHECK (expires_at IS NULL OR expires_at > published_at),
  created_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ
);
ALTER TABLE public.announcements ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. SHARED FILES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.shared_files (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id      UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  title          TEXT        NOT NULL,
  title_ar       TEXT,
  file_path      TEXT        NOT NULL,
  file_type      file_type   NOT NULL DEFAULT 'other',
  file_size      BIGINT      CHECK (file_size >= 0),
  download_count INT         NOT NULL DEFAULT 0 CHECK (download_count >= 0),
  is_public      BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);
ALTER TABLE public.shared_files ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. FORUMS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.forums (
  id          UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT           NOT NULL,
  name_ar     TEXT,
  description TEXT,
  category    forum_category NOT NULL DEFAULT 'general',
  is_active   BOOLEAN        NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.forums ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.forum_posts (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  forum_id    UUID        NOT NULL REFERENCES public.forums(id) ON DELETE CASCADE,
  author_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT        NOT NULL,
  content     TEXT        NOT NULL,
  is_pinned   BOOLEAN     NOT NULL DEFAULT FALSE,
  reply_count INT         NOT NULL DEFAULT 0 CHECK (reply_count >= 0),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);
ALTER TABLE public.forum_posts ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_posts_created_at          ON public.posts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_author_id           ON public.posts(author_id);
CREATE INDEX IF NOT EXISTS idx_posts_college_id          ON public.posts(college_id);
CREATE INDEX IF NOT EXISTS idx_posts_type                ON public.posts(type);
CREATE INDEX IF NOT EXISTS idx_post_comments_post        ON public.post_comments(post_id);

CREATE INDEX IF NOT EXISTS idx_announcements_course      ON public.announcements(course_id);
CREATE INDEX IF NOT EXISTS idx_announcements_college     ON public.announcements(college_id);
CREATE INDEX IF NOT EXISTS idx_announcements_priority    ON public.announcements(priority);
CREATE INDEX IF NOT EXISTS idx_announcements_active      ON public.announcements(published_at) WHERE deleted_at IS NULL AND (expires_at IS NULL OR expires_at > now());

CREATE INDEX IF NOT EXISTS idx_shared_files_course       ON public.shared_files(course_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_forum         ON public.forum_posts(forum_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_author        ON public.forum_posts(author_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.forum_posts CASCADE;
-- DROP TABLE IF EXISTS public.forums CASCADE;
-- DROP TABLE IF EXISTS public.shared_files CASCADE;
-- DROP TABLE IF EXISTS public.announcements CASCADE;
-- DROP TABLE IF EXISTS public.group_members CASCADE;
-- DROP TABLE IF EXISTS public.student_groups CASCADE;
-- DROP TABLE IF EXISTS public.post_comments CASCADE;
-- DROP TABLE IF EXISTS public.post_likes CASCADE;
-- DROP TABLE IF EXISTS public.posts CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 010_messaging.sql
-- ============================================================================
--  010_messaging.sql — MESSAGING SYSTEM
--  Purpose : Real-time chat, conversations, and partitioned messages.
--  Depends : 004_identity.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. CONVERSATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.conversations (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  title        TEXT,                                    -- null for direct 1-on-1 messages
  is_group     BOOLEAN     NOT NULL DEFAULT FALSE,
  created_by   UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  last_message TEXT,
  last_message_at TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS conversations_updated_at ON public.conversations;
CREATE TRIGGER conversations_updated_at
  BEFORE UPDATE ON public.conversations
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. CONVERSATION MEMBERS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.conversation_members (
  conversation_id UUID        NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_read_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_admin        BOOLEAN     NOT NULL DEFAULT FALSE,
  is_muted        BOOLEAN     NOT NULL DEFAULT FALSE,
  PRIMARY KEY (conversation_id, user_id)
);
ALTER TABLE public.conversation_members ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. MESSAGES (PARTITIONED)
-- ══════════════════════════════════════════════════════════════════════════════
-- Because messages scale rapidly, we partition by created_at (monthly).
-- Note: Partitioned tables cannot have foreign keys pointing TO them in standard PG
-- unless the referencing table includes the partition key.

CREATE TABLE IF NOT EXISTS public.messages (
  id              UUID           NOT NULL DEFAULT gen_random_uuid(),
  conversation_id UUID           NOT NULL, -- Cannot be standard FK due to partitioning constraints in some PG versions, handled by app logic or relaxed constraint
  sender_id       UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content         TEXT           NOT NULL,
  media_url       TEXT,
  status          message_status NOT NULL DEFAULT 'sent',
  reply_to_id     UUID,
  is_edited       BOOLEAN        NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  deleted_at      TIMESTAMPTZ,
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

-- Initial partitions
CREATE TABLE public.messages_y2025m01 PARTITION OF public.messages FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');
CREATE TABLE public.messages_y2025m02 PARTITION OF public.messages FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');
CREATE TABLE public.messages_y2025m03 PARTITION OF public.messages FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');
CREATE TABLE public.messages_y2025m04 PARTITION OF public.messages FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');
CREATE TABLE public.messages_y2025m05 PARTITION OF public.messages FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.messages_y2025m06 PARTITION OF public.messages FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.messages_y2025m07 PARTITION OF public.messages FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');
CREATE TABLE public.messages_y2025m08 PARTITION OF public.messages FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');
CREATE TABLE public.messages_y2025m09 PARTITION OF public.messages FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');
CREATE TABLE public.messages_y2025m10 PARTITION OF public.messages FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');
CREATE TABLE public.messages_y2025m11 PARTITION OF public.messages FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');
CREATE TABLE public.messages_y2025m12 PARTITION OF public.messages FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');
CREATE TABLE public.messages_y2026m01 PARTITION OF public.messages FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE public.messages_y2026m02 PARTITION OF public.messages FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE public.messages_y2026m03 PARTITION OF public.messages FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
CREATE TABLE public.messages_y2026m04 PARTITION OF public.messages FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE public.messages_y2026m05 PARTITION OF public.messages FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');
CREATE TABLE public.messages_y2026m06 PARTITION OF public.messages FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');

-- Future partition bucket for anything beyond current definitions to prevent inserts from failing
CREATE TABLE public.messages_future PARTITION OF public.messages DEFAULT;

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. MESSAGE REACTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.message_reactions (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id       UUID        NOT NULL, -- Logical FK
  message_created_at TIMESTAMPTZ NOT NULL, -- Needed to query partitioned table efficiently
  user_id          UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  emoji            TEXT        NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (message_id, user_id, emoji)
);
-- Note: Foreign key to messages omitted due to PG partitioning constraints without composite keys.
ALTER TABLE public.message_reactions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_conversation_members_user ON public.conversation_members(user_id);
CREATE INDEX IF NOT EXISTS idx_messages_conversation_time ON public.messages(conversation_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_messages_sender ON public.messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_message_reactions_message ON public.message_reactions(message_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.message_reactions CASCADE;
-- DROP TABLE IF EXISTS public.messages CASCADE;
-- DROP TABLE IF EXISTS public.conversation_members CASCADE;
-- DROP TABLE IF EXISTS public.conversations CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 011_financial.sql
-- ============================================================================
--  011_financial.sql — FINANCIAL SYSTEM
--  Purpose : Invoices, payments, schedules, and scholarships.
--  Depends : 004_identity.sql, 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. INVOICES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.invoices (
  id             UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id     UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester       TEXT           NOT NULL,
  semester_id    UUID           REFERENCES public.semesters(id) ON DELETE SET NULL,
  description    TEXT           NOT NULL,
  description_ar TEXT,
  amount         NUMERIC(10,2)  NOT NULL CHECK (amount > 0),
  currency       TEXT           NOT NULL DEFAULT 'EGP', -- Consider a currency table in V2
  status         payment_status NOT NULL DEFAULT 'pending',
  due_date       DATE,
  paid_at        TIMESTAMPTZ,
  receipt_url    TEXT,
  metadata       JSONB          DEFAULT '{}',
  created_at     TIMESTAMPTZ    NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS invoices_updated_at ON public.invoices;
CREATE TRIGGER invoices_updated_at
  BEFORE UPDATE ON public.invoices
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. PAYMENT TRANSACTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.payment_transactions (
  id                UUID                 PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id        UUID                 NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
  student_id        UUID                 NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount            NUMERIC(10,2)        NOT NULL CHECK (amount > 0),
  currency          TEXT                 NOT NULL DEFAULT 'EGP',
  payment_method    payment_method       NOT NULL,
  gateway           payment_gateway_type,
  transaction_ref   TEXT                 UNIQUE,
  status            payment_status       NOT NULL DEFAULT 'pending',
  gateway_response  JSONB                DEFAULT '{}',
  processed_at      TIMESTAMPTZ,
  created_at        TIMESTAMPTZ          NOT NULL DEFAULT now()
);
ALTER TABLE public.payment_transactions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. INVOICE SCHEDULES (Installments)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.invoice_schedules (
  id              UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_invoice  UUID           NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
  installment_num INT            NOT NULL CHECK (installment_num > 0),
  amount          NUMERIC(10,2)  NOT NULL CHECK (amount > 0),
  due_date        DATE           NOT NULL,
  status          payment_status NOT NULL DEFAULT 'pending',
  paid_at         TIMESTAMPTZ,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  UNIQUE (parent_invoice, installment_num)
);
ALTER TABLE public.invoice_schedules ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS invoice_schedules_updated_at ON public.invoice_schedules;
CREATE TRIGGER invoice_schedules_updated_at
  BEFORE UPDATE ON public.invoice_schedules
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. SCHOLARSHIPS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.scholarships (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name_en         TEXT        NOT NULL,
  name_ar         TEXT        NOT NULL,
  description_en  TEXT,
  description_ar  TEXT,
  discount_pct    NUMERIC(5,2) CHECK (discount_pct BETWEEN 0 AND 100),
  discount_amount NUMERIC(10,2) CHECK (discount_amount >= 0),
  -- Require either percentage OR amount
  CONSTRAINT chk_scholarship_value CHECK (
    (discount_pct IS NOT NULL AND discount_amount IS NULL) OR
    (discount_pct IS NULL AND discount_amount IS NOT NULL)
  ),
  is_active       BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.scholarships ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. SCHOLARSHIP APPLICATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.scholarship_applications (
  id              UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  scholarship_id  UUID               NOT NULL REFERENCES public.scholarships(id) ON DELETE CASCADE,
  student_id      UUID               NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester        TEXT               NOT NULL,
  semester_id     UUID               REFERENCES public.semesters(id) ON DELETE SET NULL,
  status          scholarship_status NOT NULL DEFAULT 'applied',
  documents       TEXT[]             DEFAULT '{}',
  reviewed_by     UUID               REFERENCES public.profiles(id) ON DELETE SET NULL,
  review_notes    TEXT,
  applied_at      TIMESTAMPTZ        NOT NULL DEFAULT now(),
  reviewed_at     TIMESTAMPTZ,
  UNIQUE (scholarship_id, student_id, semester)
);
ALTER TABLE public.scholarship_applications ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_invoices_student          ON public.invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_invoices_status           ON public.invoices(status);
CREATE INDEX IF NOT EXISTS idx_invoices_semester         ON public.invoices(semester_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_invoice        ON public.payment_transactions(invoice_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_student        ON public.payment_transactions(student_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_status         ON public.payment_transactions(status);
CREATE INDEX IF NOT EXISTS idx_scholarship_app_student   ON public.scholarship_applications(student_id);
CREATE INDEX IF NOT EXISTS idx_scholarship_app_status    ON public.scholarship_applications(status);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.scholarship_applications CASCADE;
-- DROP TABLE IF EXISTS public.scholarships CASCADE;
-- DROP TABLE IF EXISTS public.invoice_schedules CASCADE;
-- DROP TABLE IF EXISTS public.payment_transactions CASCADE;
-- DROP TABLE IF EXISTS public.invoices CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 012_exams.sql
-- ============================================================================
--  012_exams.sql — EXAMINATIONS
--  Purpose : Online exam engine, questions, attempts, and anti-cheat mechanisms.
--  Depends : 006_academic.sql, 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. ONLINE EXAMS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.online_exams (
  id                UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id         UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  title             TEXT        NOT NULL,
  description       TEXT,
  total_marks       INT         NOT NULL DEFAULT 100,
  duration_minutes  INT         NOT NULL DEFAULT 60,
  passing_score     INT         NOT NULL DEFAULT 50,
  start_time        TIMESTAMPTZ NOT NULL,
  end_time          TIMESTAMPTZ NOT NULL,
  status            exam_status NOT NULL DEFAULT 'draft',
  -- Settings
  shuffle_questions BOOLEAN     NOT NULL DEFAULT TRUE,
  shuffle_options   BOOLEAN     NOT NULL DEFAULT TRUE,
  allow_back        BOOLEAN     NOT NULL DEFAULT TRUE,
  show_results      BOOLEAN     NOT NULL DEFAULT FALSE,
  strict_mode       BOOLEAN     NOT NULL DEFAULT TRUE,  -- Enables anti-cheat
  semester          TEXT        NOT NULL,
  semester_id       UUID        REFERENCES public.semesters(id) ON DELETE SET NULL,
  created_by        UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT chk_exam_times CHECK (end_time > start_time)
);
ALTER TABLE public.online_exams ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS online_exams_updated_at ON public.online_exams;
CREATE TRIGGER online_exams_updated_at
  BEFORE UPDATE ON public.online_exams
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. EXAM QUESTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.exam_questions (
  id              UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id         UUID          NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  question_text   TEXT          NOT NULL,
  question_type   question_type NOT NULL DEFAULT 'mcq',
  marks           INT           NOT NULL DEFAULT 1,
  media_url       TEXT,
  order_index     INT           NOT NULL DEFAULT 0,
  correct_answer  TEXT,         -- Used for short answer
  explanation     TEXT,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_questions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. QUESTION OPTIONS (For MCQs)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.question_options (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID        NOT NULL REFERENCES public.exam_questions(id) ON DELETE CASCADE,
  option_text TEXT        NOT NULL,
  is_correct  BOOLEAN     NOT NULL DEFAULT FALSE,
  order_index INT         NOT NULL DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.question_options ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. EXAM ATTEMPTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.exam_attempts (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id          UUID        NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  started_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at     TIMESTAMPTZ,
  score            NUMERIC(5,2),
  is_passed        BOOLEAN,
  ip_address       INET,
  device_info      TEXT,
  flagged_for_cheat BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (exam_id, student_id)
);
ALTER TABLE public.exam_attempts ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. ATTEMPT ANSWERS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.attempt_answers (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id      UUID        NOT NULL REFERENCES public.exam_attempts(id) ON DELETE CASCADE,
  question_id     UUID        NOT NULL REFERENCES public.exam_questions(id) ON DELETE CASCADE,
  selected_option UUID        REFERENCES public.question_options(id) ON DELETE SET NULL,
  text_answer     TEXT,
  is_correct      BOOLEAN,
  marks_awarded   NUMERIC(5,2),
  answered_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (attempt_id, question_id)
);
ALTER TABLE public.attempt_answers ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. EXAM CHEAT EVENTS (Partitioned)
-- ══════════════════════════════════════════════════════════════════════════════
-- High volume log during exams, partitioned by month.

CREATE TABLE IF NOT EXISTS public.exam_cheat_events (
  id          UUID        NOT NULL DEFAULT gen_random_uuid(),
  attempt_id  UUID        NOT NULL, -- logical FK
  exam_id     UUID        NOT NULL, -- logical FK
  student_id  UUID        NOT NULL, -- logical FK
  event_type  TEXT        NOT NULL, -- e.g., 'tab_switch', 'window_blur', 'multiple_faces'
  description TEXT,
  severity    TEXT        NOT NULL DEFAULT 'low',
  timestamp   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, timestamp)
) PARTITION BY RANGE (timestamp);

CREATE TABLE public.exam_cheat_events_y2025m05 PARTITION OF public.exam_cheat_events FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.exam_cheat_events_y2025m06 PARTITION OF public.exam_cheat_events FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.exam_cheat_events_future PARTITION OF public.exam_cheat_events DEFAULT;

ALTER TABLE public.exam_cheat_events ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. EXAM SIMILARITY REPORTS (AI Integrity)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.exam_similarity_reports (
  id               UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id          UUID         NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  student_id       UUID         NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  target_student_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  similarity_score NUMERIC(5,2) NOT NULL CHECK (similarity_score BETWEEN 0 AND 100),
  matched_questions INT         NOT NULL,
  ai_confidence    NUMERIC(5,2) NOT NULL,
  status           TEXT         NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'investigating', 'confirmed', 'cleared')),
  investigated_by  UUID         REFERENCES public.profiles(id) ON DELETE SET NULL,
  notes            TEXT,
  created_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ  NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_similarity_reports ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 8. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_online_exams_course      ON public.online_exams(course_id);
CREATE INDEX IF NOT EXISTS idx_online_exams_status      ON public.online_exams(status);
CREATE INDEX IF NOT EXISTS idx_online_exams_semester    ON public.online_exams(semester_id);
CREATE INDEX IF NOT EXISTS idx_exam_questions_exam      ON public.exam_questions(exam_id);
CREATE INDEX IF NOT EXISTS idx_question_options_q       ON public.question_options(question_id);
CREATE INDEX IF NOT EXISTS idx_exam_attempts_exam       ON public.exam_attempts(exam_id);
CREATE INDEX IF NOT EXISTS idx_exam_attempts_student    ON public.exam_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_cheat_events_attempt     ON public.exam_cheat_events(attempt_id);
CREATE INDEX IF NOT EXISTS idx_similarity_exam          ON public.exam_similarity_reports(exam_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.exam_similarity_reports CASCADE;
-- DROP TABLE IF EXISTS public.exam_cheat_events CASCADE;
-- DROP TABLE IF EXISTS public.attempt_answers CASCADE;
-- DROP TABLE IF EXISTS public.exam_attempts CASCADE;
-- DROP TABLE IF EXISTS public.question_options CASCADE;
-- DROP TABLE IF EXISTS public.exam_questions CASCADE;
-- DROP TABLE IF EXISTS public.online_exams CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 013_library.sql
-- ============================================================================
--  013_library.sql — LIBRARY SYSTEM
--  Purpose : Digital and physical library catalog, reservations, and borrowing.
--  Depends : 004_identity.sql, 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. LIBRARY ITEMS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_items (
  id              UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  title           TEXT              NOT NULL,
  title_ar        TEXT,
  author          TEXT              NOT NULL,
  author_ar       TEXT,
  isbn            TEXT              UNIQUE,
  publisher       TEXT,
  publish_year    INT               CHECK (publish_year > 1000),
  category        TEXT              NOT NULL,
  item_type       library_item_type NOT NULL DEFAULT 'book',
  description     TEXT,
  description_ar  TEXT,
  cover_url       TEXT,
  file_url        TEXT,             -- For digital assets
  -- Physical inventory
  total_copies    INT               NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
  available_copies INT              NOT NULL DEFAULT 1 CHECK (available_copies >= 0),
  location_shelf  TEXT,
  college_id      UUID              REFERENCES public.colleges(id) ON DELETE CASCADE,
  -- Stats
  view_count      INT               NOT NULL DEFAULT 0,
  borrow_count    INT               NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.library_items ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS library_items_updated_at ON public.library_items;
CREATE TRIGGER library_items_updated_at
  BEFORE UPDATE ON public.library_items
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. LIBRARY BORROWS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_borrows (
  id              UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID          NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  borrowed_at     TIMESTAMPTZ   NOT NULL DEFAULT now(),
  due_date        DATE          NOT NULL,
  returned_at     TIMESTAMPTZ,
  status          borrow_status NOT NULL DEFAULT 'borrowed',
  fine_amount     NUMERIC(8,2)  NOT NULL DEFAULT 0,
  issued_by       UUID          REFERENCES public.profiles(id) ON DELETE SET NULL,
  received_by     UUID          REFERENCES public.profiles(id) ON DELETE SET NULL,
  notes           TEXT,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT now()
);
ALTER TABLE public.library_borrows ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS library_borrows_updated_at ON public.library_borrows;
CREATE TRIGGER library_borrows_updated_at
  BEFORE UPDATE ON public.library_borrows
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. LIBRARY RESERVATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_reservations (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  reserved_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at      TIMESTAMPTZ NOT NULL,
  status          TEXT        NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'fulfilled', 'cancelled', 'expired')),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.library_reservations ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. DIGITAL READING HISTORY
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_reading_history (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  last_page       INT         NOT NULL DEFAULT 1,
  progress_pct    NUMERIC(5,2) NOT NULL DEFAULT 0,
  last_read_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (item_id, user_id)
);
ALTER TABLE public.library_reading_history ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_lib_items_category      ON public.library_items(category);
CREATE INDEX IF NOT EXISTS idx_lib_items_type          ON public.library_items(item_type);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_user        ON public.library_borrows(user_id);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_item        ON public.library_borrows(item_id);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_status      ON public.library_borrows(status);
CREATE INDEX IF NOT EXISTS idx_lib_resv_user           ON public.library_reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_lib_history_user        ON public.library_reading_history(user_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.library_reading_history CASCADE;
-- DROP TABLE IF EXISTS public.library_reservations CASCADE;
-- DROP TABLE IF EXISTS public.library_borrows CASCADE;
-- DROP TABLE IF EXISTS public.library_items CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 014_system.sql
-- ============================================================================
--  014_system.sql — SYSTEM, LOGS, SECURITY & CONFIGURATION
--  Purpose : Cross-cutting concerns: audit logs, analytics, multi-channel 
--            notifications, field-level encryption, system config.
--  Depends : 004_identity.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. SYSTEM SETTINGS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.system_settings (
  key         TEXT        PRIMARY KEY,
  value       JSONB       NOT NULL,
  description TEXT,
  updated_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.system_settings ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. FIELD ENCRYPTION KEYS (Vault substitute)
-- ══════════════════════════════════════════════════════════════════════════════
-- Used to encrypt sensitive fields like national_id using pgcrypto.

CREATE TABLE IF NOT EXISTS public.encryption_keys (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  context     encryption_context NOT NULL UNIQUE,
  key_hash    TEXT               NOT NULL, -- securely hashed material
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ        NOT NULL DEFAULT now()
);
ALTER TABLE public.encryption_keys ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.encrypted_data (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  context     encryption_context NOT NULL REFERENCES public.encryption_keys(context) ON DELETE RESTRICT,
  target_id   UUID               NOT NULL, -- polymorphic reference
  target_table TEXT              NOT NULL,
  cipher_text BYTEA              NOT NULL,
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  UNIQUE (target_id, target_table, context)
);
ALTER TABLE public.encrypted_data ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. AUDIT LOGS (Partitioned by Year)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.audit_logs (
  id           UUID         NOT NULL DEFAULT gen_random_uuid(),
  performed_by UUID,        -- logical FK (cannot be true FK on partitioned table without partition key)
  target_user  UUID,        -- logical FK
  action       audit_action NOT NULL,
  table_name   TEXT,
  record_id    UUID,
  old_data     JSONB,
  new_data     JSONB,
  ip_address   INET,
  user_agent   TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.audit_logs_y2025 PARTITION OF public.audit_logs FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
CREATE TABLE public.audit_logs_y2026 PARTITION OF public.audit_logs FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
CREATE TABLE public.audit_logs_future PARTITION OF public.audit_logs DEFAULT;

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. ANALYTICS EVENTS (Partitioned by Month)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.analytics_events (
  id          UUID        NOT NULL DEFAULT gen_random_uuid(),
  user_id     UUID,       -- logical FK
  session_id  UUID,       -- logical FK
  event_name  TEXT        NOT NULL,
  event_data  JSONB       DEFAULT '{}',
  platform    TEXT,
  version     TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.analytics_events_y2025m05 PARTITION OF public.analytics_events FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.analytics_events_y2025m06 PARTITION OF public.analytics_events FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.analytics_events_future PARTITION OF public.analytics_events DEFAULT;

ALTER TABLE public.analytics_events ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. NOTIFICATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.notifications (
  id         UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title      TEXT              NOT NULL,
  title_ar   TEXT,
  message    TEXT              NOT NULL,
  message_ar TEXT,
  type       notification_type NOT NULL DEFAULT 'info',
  is_read    BOOLEAN           NOT NULL DEFAULT FALSE,
  action_url TEXT,
  metadata   JSONB             DEFAULT '{}',
  read_at    TIMESTAMPTZ,
  created_at TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Track delivery status across channels (email, sms, push)
CREATE TABLE IF NOT EXISTS public.notification_deliveries (
  id              UUID                  NOT NULL DEFAULT gen_random_uuid(),
  notification_id UUID                  NOT NULL, -- logical FK
  channel         notif_channel         NOT NULL,
  status          notif_delivery_status NOT NULL DEFAULT 'pending',
  provider_ref    TEXT,                 -- e.g., SendGrid message ID
  error_message   TEXT,
  created_at      TIMESTAMPTZ           NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.notif_deliv_y2025 PARTITION OF public.notification_deliveries FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
CREATE TABLE public.notif_deliv_future PARTITION OF public.notification_deliveries DEFAULT;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_audit_performed_by        ON public.audit_logs(performed_by);
CREATE INDEX IF NOT EXISTS idx_audit_target_user         ON public.audit_logs(target_user);
CREATE INDEX IF NOT EXISTS idx_audit_action              ON public.audit_logs(action);

CREATE INDEX IF NOT EXISTS idx_analytics_user            ON public.analytics_events(user_id);
CREATE INDEX IF NOT EXISTS idx_analytics_name            ON public.analytics_events(event_name);

CREATE INDEX IF NOT EXISTS idx_notifications_user        ON public.notifications(user_id, is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at  ON public.notifications(created_at DESC);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.notification_deliveries CASCADE;
-- DROP TABLE IF EXISTS public.notifications CASCADE;
-- DROP TABLE IF EXISTS public.analytics_events CASCADE;
-- DROP TABLE IF EXISTS public.audit_logs CASCADE;
-- DROP TABLE IF EXISTS public.encrypted_data CASCADE;
-- DROP TABLE IF EXISTS public.encryption_keys CASCADE;
-- DROP TABLE IF EXISTS public.system_settings CASCADE;
-- ════════════════════════════════════════════════════════════════════════════


-- FILE: 015_functions_triggers_rls.sql
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

