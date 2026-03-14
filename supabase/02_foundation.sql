-- ============================================================================
--  FILE 2 OF 5 — EXTENSIONS · ENUM TYPES · CORE IDENTITY TABLES
--  Purpose : Foundation layer of the entire schema.
--            • PostgreSQL extensions
--            • All custom ENUM types (defined once, referenced everywhere)
--            • Core identity tables: profiles, colleges, departments
--            • Deferred FK wiring between those three tables
--            • Core indexes
--  Depends : 01_reset.sql must have been executed first.
-- ============================================================================

-- ════════════════════════════════════════════════════════════════════════════
-- 1. EXTENSIONS
-- ════════════════════════════════════════════════════════════════════════════

CREATE EXTENSION IF NOT EXISTS "pgcrypto";     -- gen_random_uuid(), crypt(), gen_salt()
CREATE EXTENSION IF NOT EXISTS "moddatetime";  -- automatic updated_at maintenance

-- ════════════════════════════════════════════════════════════════════════════
-- 2. ENUM TYPES
-- ════════════════════════════════════════════════════════════════════════════

-- User roles — ordered from most-privileged to least-privileged.
CREATE TYPE public.user_role AS ENUM (
  'super_admin', 'admin', 'it_support', 'financial_auditor',
  'rector', 'dean', 'department_head', 'assistant_hod', 'academic_coordinator',
  'professor', 'lecturer', 'teaching_assistant',
  'registrar_officer', 'academic_advisor', 'librarian',
  'freshman', 'regular_student', 'student', 'class_representative', 'alumni',
  'dorm_supervisor', 'security_officer', 'guest', 'parent', 'recruiter'
);

-- Content & communication
CREATE TYPE public.announcement_priority AS ENUM ('normal', 'important', 'urgent');
CREATE TYPE public.forum_category        AS ENUM ('general', 'academic', 'social', 'feedback');
CREATE TYPE public.notification_type     AS ENUM ('info', 'warning', 'success', 'error');
CREATE TYPE public.file_type             AS ENUM ('pdf', 'docx', 'pptx', 'xlsx', 'image', 'video', 'other');
CREATE TYPE public.post_type             AS ENUM ('text', 'image', 'video', 'link', 'announcement');

-- Academic workflow
CREATE TYPE public.enrollment_status     AS ENUM ('pending', 'approved', 'rejected', 'withdrawn', 'cancelled');
CREATE TYPE public.attendance_status     AS ENUM ('present', 'absent', 'late', 'excused');
CREATE TYPE public.day_of_week           AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');

-- Finance & operations
CREATE TYPE public.payment_status        AS ENUM ('pending', 'paid', 'overdue', 'refunded');
CREATE TYPE public.support_ticket_status AS ENUM ('open', 'in_progress', 'resolved', 'closed');
CREATE TYPE public.session_device        AS ENUM ('mobile', 'desktop', 'tablet', 'unknown');

-- Audit trail
CREATE TYPE public.audit_action AS ENUM (
  'create', 'update', 'delete', 'login', 'logout',
  'toggle_status', 'role_change', 'password_reset', 'view'
);

-- ════════════════════════════════════════════════════════════════════════════
-- 3. CORE IDENTITY TABLES
-- ════════════════════════════════════════════════════════════════════════════

-- ── profiles ─────────────────────────────────────────────────────────────────
-- Central user table. Every authenticated user has exactly one profile row.
-- college_id and department_id FKs are added after those tables are created.
CREATE TABLE public.profiles (
  id            UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email         TEXT        NOT NULL UNIQUE,
  full_name     TEXT        NOT NULL,
  full_name_ar  TEXT,
  avatar_url    TEXT,
  roles         user_role[] NOT NULL DEFAULT '{student}',
  student_id    TEXT        UNIQUE,
  national_id   TEXT        UNIQUE,
  nationality   TEXT,
  phone         TEXT,
  bio           TEXT,
  bio_ar        TEXT,
  -- These two FKs are deferred until colleges/departments tables exist.
  college_id    UUID,
  department_id UUID,
  advisor_id    UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  warning_level INT         NOT NULL DEFAULT 0 CHECK (warning_level >= 0),
  is_verified   BOOLEAN     NOT NULL DEFAULT FALSE,
  tags          TEXT[]      NOT NULL DEFAULT '{}',
  is_banned     BOOLEAN     NOT NULL DEFAULT FALSE,
  is_active     BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS profiles_updated_at ON public.profiles;
CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ── colleges ─────────────────────────────────────────────────────────────────
CREATE TABLE public.colleges (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name_en        TEXT        NOT NULL,
  name_ar        TEXT        NOT NULL,
  -- Computed display name: prefer English, fall back to Arabic.
  name           TEXT        GENERATED ALWAYS AS (COALESCE(name_en, name_ar)) STORED,
  code           TEXT        UNIQUE,
  description    TEXT,
  description_ar TEXT,
  dean_id        UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  image_url      TEXT,
  established    INT         CHECK (established > 1800),
  student_count  INT         NOT NULL DEFAULT 0 CHECK (student_count >= 0),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.colleges ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS colleges_updated_at ON public.colleges;
CREATE TRIGGER colleges_updated_at
  BEFORE UPDATE ON public.colleges
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ── departments ───────────────────────────────────────────────────────────────
CREATE TABLE public.departments (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id       UUID        NOT NULL REFERENCES public.colleges(id) ON DELETE CASCADE,
  name_en          TEXT        NOT NULL,
  name_ar          TEXT        NOT NULL,
  -- Computed display name.
  name             TEXT        GENERATED ALWAYS AS (COALESCE(name_en, name_ar)) STORED,
  code             TEXT        UNIQUE,
  hod_id           UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  assistant_hod_id UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  description      TEXT,
  description_ar   TEXT,
  office_symbol    TEXT,
  floor            INT,
  building         TEXT,
  student_count    INT         NOT NULL DEFAULT 0 CHECK (student_count >= 0),
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS departments_updated_at ON public.departments;
CREATE TRIGGER departments_updated_at
  BEFORE UPDATE ON public.departments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ── Deferred FKs: profiles → colleges / departments ──────────────────────────
ALTER TABLE public.profiles
  ADD CONSTRAINT profiles_college_id_fkey
    FOREIGN KEY (college_id)    REFERENCES public.colleges(id)    ON DELETE SET NULL,
  ADD CONSTRAINT profiles_department_id_fkey
    FOREIGN KEY (department_id) REFERENCES public.departments(id) ON DELETE SET NULL;

-- ════════════════════════════════════════════════════════════════════════════
-- 4. CORE INDEXES
-- ════════════════════════════════════════════════════════════════════════════

CREATE INDEX idx_profiles_roles      ON public.profiles USING GIN(roles);
CREATE INDEX idx_profiles_email      ON public.profiles(email);
CREATE INDEX idx_profiles_college    ON public.profiles(college_id);
CREATE INDEX idx_profiles_department ON public.profiles(department_id);
CREATE INDEX idx_colleges_code       ON public.colleges(code);
CREATE INDEX idx_departments_college ON public.departments(college_id);