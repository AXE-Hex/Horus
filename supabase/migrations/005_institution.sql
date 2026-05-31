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
