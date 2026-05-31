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
