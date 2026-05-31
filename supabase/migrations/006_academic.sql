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
