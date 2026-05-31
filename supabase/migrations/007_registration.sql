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
