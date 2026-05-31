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
