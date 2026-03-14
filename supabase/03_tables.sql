-- ============================================================================
--  FILE 3 OF 5 — DOMAIN TABLES & INDEXES
--  Purpose : All application tables, organized into four clear sections:
--            A. Academic  — courses, staff details, registrations, grades, schedules
--            B. Social    — posts, groups, announcements, files, forums
--            C. Admin     — tickets, ratings, invoices, notifications, sessions, audit
--  Depends : 02_foundation.sql must have been executed first.
-- ============================================================================

-- ════════════════════════════════════════════════════════════════════════════
-- SECTION A — ACADEMIC
--   Covers: faculty, courses, sections, registrations, grades,
--           schedules, exams, attendance, office hours, action plans.
-- ════════════════════════════════════════════════════════════════════════════

-- ── courses ───────────────────────────────────────────────────────────────────
CREATE TABLE public.courses (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id UUID        NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  code          TEXT        NOT NULL UNIQUE,
  name          TEXT        NOT NULL,
  name_en       TEXT,
  name_ar       TEXT        NOT NULL,
  description   TEXT,
  credit_hours  INT         NOT NULL DEFAULT 3 CHECK (credit_hours BETWEEN 1 AND 12),
  semester      TEXT,
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

-- ── professor_details ─────────────────────────────────────────────────────────
-- Extended profile data exclusively for professors / lecturers.
CREATE TABLE public.professor_details (
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

-- ── teaching_assistants ───────────────────────────────────────────────────────
CREATE TABLE public.teaching_assistants (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  ta_role      TEXT        NOT NULL DEFAULT 'Lab Assistant',
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (profile_id, professor_id)
);
ALTER TABLE public.teaching_assistants ENABLE ROW LEVEL SECURITY;

-- ── department_projects ───────────────────────────────────────────────────────
CREATE TABLE public.department_projects (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id  UUID        NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  title_en       TEXT        NOT NULL,
  title_ar       TEXT        NOT NULL,
  description_en TEXT,
  description_ar TEXT,
  status         TEXT        NOT NULL DEFAULT 'active'
                             CHECK (status IN ('active','completed','paused','cancelled')),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.department_projects ENABLE ROW LEVEL SECURITY;

-- ── course_sections ───────────────────────────────────────────────────────────
CREATE TABLE public.course_sections (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id    UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  semester     TEXT        NOT NULL,
  max_students INT         NOT NULL DEFAULT 50 CHECK (max_students > 0),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sections ENABLE ROW LEVEL SECURITY;

-- ── course_sub_sections ───────────────────────────────────────────────────────
CREATE TABLE public.course_sub_sections (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  section_id   UUID        NOT NULL REFERENCES public.course_sections(id) ON DELETE CASCADE,
  name         TEXT        NOT NULL,
  max_students INT         NOT NULL DEFAULT 25 CHECK (max_students > 0),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sub_sections ENABLE ROW LEVEL SECURITY;

-- ── student_registrations ─────────────────────────────────────────────────────
-- Tracks which section/sub-section a student is assigned to each semester.
CREATE TABLE public.student_registrations (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester         TEXT        NOT NULL,
  section_name     TEXT        NOT NULL,
  sub_section_name TEXT        NOT NULL,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, semester)
);
ALTER TABLE public.student_registrations ENABLE ROW LEVEL SECURITY;

-- ── student_course_registrations ──────────────────────────────────────────────
-- Final, approved list of courses a student is enrolled in per semester.
CREATE TABLE public.student_course_registrations (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester         TEXT        NOT NULL,
  section_name     TEXT,
  sub_section_name TEXT,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.student_course_registrations ENABLE ROW LEVEL SECURITY;

-- ── registration_requests ─────────────────────────────────────────────────────
-- A student's pending course-selection request, reviewed by their advisor.
CREATE TABLE public.registration_requests (
  id            UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  advisor_id    UUID              REFERENCES public.profiles(id) ON DELETE SET NULL,
  semester      TEXT              NOT NULL,
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

-- ── registration_request_courses ──────────────────────────────────────────────
-- Line items of a registration request (one row per requested course).
CREATE TABLE public.registration_request_courses (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id       UUID        NOT NULL REFERENCES public.registration_requests(id) ON DELETE CASCADE,
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  section_name     TEXT,
  sub_section_name TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (request_id, course_id)
);
ALTER TABLE public.registration_request_courses ENABLE ROW LEVEL SECURITY;

-- ── enrollments ───────────────────────────────────────────────────────────────
CREATE TABLE public.enrollments (
  id          UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id   UUID              NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  status      enrollment_status NOT NULL DEFAULT 'pending',
  semester    TEXT              NOT NULL,
  enrolled_at TIMESTAMPTZ       NOT NULL DEFAULT now(),
  approved_at TIMESTAMPTZ,
  created_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ       NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

-- ── grades ────────────────────────────────────────────────────────────────────
-- total, grade_letter, and gpa_points are auto-calculated via trigger.
CREATE TABLE public.grades (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester     TEXT        NOT NULL,
  midterm      NUMERIC(5,2) CHECK (midterm    BETWEEN 0 AND 100),
  final_exam   NUMERIC(5,2) CHECK (final_exam BETWEEN 0 AND 100),
  coursework   NUMERIC(5,2) CHECK (coursework BETWEEN 0 AND 100),
  practical    NUMERIC(5,2) CHECK (practical  BETWEEN 0 AND 100),
  -- Auto-computed by trigger:
  total        NUMERIC(5,2),
  grade_letter TEXT,
  gpa_points   NUMERIC(3,2),
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

-- ── schedules ─────────────────────────────────────────────────────────────────
CREATE TABLE public.schedules (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  day              day_of_week NOT NULL,
  start_time       TIME        NOT NULL,
  end_time         TIME        NOT NULL,
  CONSTRAINT chk_schedule_times CHECK (start_time < end_time),
  room             TEXT,
  building         TEXT,
  schedule_type    TEXT        NOT NULL DEFAULT 'lecture'
                               CHECK (schedule_type IN ('lecture','lab','tutorial','online')),
  section_name     TEXT,
  sub_section_name TEXT,
  semester         TEXT        NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.schedules ENABLE ROW LEVEL SECURITY;

-- ── exam_schedules ────────────────────────────────────────────────────────────
CREATE TABLE public.exam_schedules (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id  UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  exam_type  TEXT        NOT NULL DEFAULT 'final'
                         CHECK (exam_type IN ('midterm','final','quiz','makeup')),
  exam_date  DATE        NOT NULL,
  start_time TIME        NOT NULL,
  end_time   TIME        NOT NULL,
  CONSTRAINT chk_exam_times CHECK (start_time < end_time),
  room       TEXT,
  building   TEXT,
  semester   TEXT        NOT NULL,
  notes      TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_schedules ENABLE ROW LEVEL SECURITY;

-- ── attendance ────────────────────────────────────────────────────────────────
CREATE TABLE public.attendance (
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

-- ── office_hours ──────────────────────────────────────────────────────────────
CREATE TABLE public.office_hours (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  day          day_of_week NOT NULL,
  start_time   TIME        NOT NULL,
  end_time     TIME        NOT NULL,
  CONSTRAINT chk_office_times CHECK (start_time < end_time),
  location     TEXT        NOT NULL,
  is_walk_in   BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.office_hours ENABLE ROW LEVEL SECURITY;

-- ── action_plan_items ─────────────────────────────────────────────────────────
-- Advisor-driven academic plan: which courses a student intends to take per year.
CREATE TABLE public.action_plan_items (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  semester     TEXT        NOT NULL,
  year         INT         NOT NULL CHECK (year > 2000),
  status       TEXT        NOT NULL DEFAULT 'planned'
                           CHECK (status IN ('planned','enrolled','passed','failed','withdrawn')),
  grade_letter TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.action_plan_items ENABLE ROW LEVEL SECURITY;

-- ════════════════════════════════════════════════════════════════════════════
-- SECTION B — SOCIAL & COMMUNICATION
--   Covers: social feed posts, student groups, announcements,
--           shared files, forums.
-- ════════════════════════════════════════════════════════════════════════════

-- ── posts (social feed) ───────────────────────────────────────────────────────
CREATE TABLE public.posts (
  id             UUID      PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id      UUID      NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  college_id     UUID      REFERENCES public.colleges(id) ON DELETE CASCADE,
  content        TEXT      NOT NULL,
  media_urls     TEXT[]    NOT NULL DEFAULT '{}',
  link_url       TEXT,
  type           post_type NOT NULL DEFAULT 'text',
  likes_count    INT       NOT NULL DEFAULT 0 CHECK (likes_count >= 0),
  comments_count INT       NOT NULL DEFAULT 0 CHECK (comments_count >= 0),
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS posts_updated_at ON public.posts;
CREATE TRIGGER posts_updated_at
  BEFORE UPDATE ON public.posts
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ── student_groups ────────────────────────────────────────────────────────────
CREATE TABLE public.student_groups (
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

-- ── group_members ─────────────────────────────────────────────────────────────
CREATE TABLE public.group_members (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id   UUID        NOT NULL REFERENCES public.student_groups(id) ON DELETE CASCADE,
  student_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (group_id, student_id)
);
ALTER TABLE public.group_members ENABLE ROW LEVEL SECURITY;

-- ── announcements ─────────────────────────────────────────────────────────────
CREATE TABLE public.announcements (
  id           UUID                  PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id    UUID                  NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
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

-- ── shared_files ──────────────────────────────────────────────────────────────
CREATE TABLE public.shared_files (
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

-- ── forums ────────────────────────────────────────────────────────────────────
CREATE TABLE public.forums (
  id          UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT           NOT NULL,
  name_ar     TEXT,
  description TEXT,
  category    forum_category NOT NULL DEFAULT 'general',
  is_active   BOOLEAN        NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.forums ENABLE ROW LEVEL SECURITY;

-- ── forum_posts ───────────────────────────────────────────────────────────────
CREATE TABLE public.forum_posts (
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

-- ════════════════════════════════════════════════════════════════════════════
-- SECTION C — ADMINISTRATION & OPERATIONS
--   Covers: support tickets, professor ratings, invoices,
--           notifications, user sessions, audit logs.
-- ════════════════════════════════════════════════════════════════════════════

-- ── support_tickets ───────────────────────────────────────────────────────────
CREATE TABLE public.support_tickets (
  id          UUID                  PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID                  NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  subject     TEXT                  NOT NULL,
  description TEXT                  NOT NULL,
  category    TEXT                  NOT NULL DEFAULT 'general',
  status      support_ticket_status NOT NULL DEFAULT 'open',
  assigned_to UUID                  REFERENCES public.profiles(id) ON DELETE SET NULL,
  resolved_at TIMESTAMPTZ,
  created_at  TIMESTAMPTZ           NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ           NOT NULL DEFAULT now()
);
ALTER TABLE public.support_tickets ENABLE ROW LEVEL SECURITY;

-- ── professor_ratings ─────────────────────────────────────────────────────────
CREATE TABLE public.professor_ratings (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  general_score    SMALLINT    NOT NULL CHECK (general_score    BETWEEN 1 AND 5),
  curriculum_score SMALLINT    NOT NULL CHECK (curriculum_score BETWEEN 1 AND 5),
  comment          TEXT,
  is_anonymous     BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (professor_id, student_id)
);
ALTER TABLE public.professor_ratings ENABLE ROW LEVEL SECURITY;

-- ── invoices ──────────────────────────────────────────────────────────────────
CREATE TABLE public.invoices (
  id             UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id     UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester       TEXT           NOT NULL,
  description    TEXT           NOT NULL,
  description_ar TEXT,
  amount         NUMERIC(10,2)  NOT NULL CHECK (amount > 0),
  currency       TEXT           NOT NULL DEFAULT 'EGP',
  status         payment_status NOT NULL DEFAULT 'pending',
  due_date       DATE,
  paid_at        TIMESTAMPTZ,
  receipt_url    TEXT,
  created_at     TIMESTAMPTZ    NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;

-- ── notifications ─────────────────────────────────────────────────────────────
CREATE TABLE public.notifications (
  id         UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title      TEXT              NOT NULL,
  title_ar   TEXT,
  message    TEXT              NOT NULL,
  message_ar TEXT,
  type       notification_type NOT NULL DEFAULT 'info',
  is_read    BOOLEAN           NOT NULL DEFAULT FALSE,
  action_url TEXT,
  read_at    TIMESTAMPTZ,
  created_at TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- ── user_sessions ─────────────────────────────────────────────────────────────
CREATE TABLE public.user_sessions (
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

-- ── audit_logs ────────────────────────────────────────────────────────────────
-- Immutable record of every admin action. Never UPDATE or DELETE rows here.
CREATE TABLE public.audit_logs (
  id           UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  performed_by UUID         REFERENCES public.profiles(id) ON DELETE SET NULL,
  target_user  UUID         REFERENCES public.profiles(id) ON DELETE SET NULL,
  action       audit_action NOT NULL,
  table_name   TEXT,
  record_id    UUID,
  old_data     JSONB,
  new_data     JSONB,
  ip_address   INET,
  user_agent   TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT now()
);
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- ════════════════════════════════════════════════════════════════════════════
-- SECTION D — INDEXES
-- ════════════════════════════════════════════════════════════════════════════

-- Academic
CREATE INDEX idx_courses_department        ON public.courses(department_id);
CREATE INDEX idx_courses_professor         ON public.courses(professor_id);
CREATE INDEX idx_enrollments_student       ON public.enrollments(student_id);
CREATE INDEX idx_enrollments_course        ON public.enrollments(course_id);
CREATE INDEX idx_enrollments_status        ON public.enrollments(status);
CREATE INDEX idx_grades_student            ON public.grades(student_id);
CREATE INDEX idx_grades_course             ON public.grades(course_id);
CREATE INDEX idx_grades_published          ON public.grades(is_published);
CREATE INDEX idx_attendance_student        ON public.attendance(student_id);
CREATE INDEX idx_attendance_course         ON public.attendance(course_id);
CREATE INDEX idx_attendance_date           ON public.attendance(date);
CREATE INDEX idx_schedules_course          ON public.schedules(course_id);
CREATE INDEX idx_schedules_day             ON public.schedules(day);
CREATE INDEX idx_reg_requests_student      ON public.registration_requests(student_id);
CREATE INDEX idx_reg_requests_advisor      ON public.registration_requests(advisor_id);
CREATE INDEX idx_reg_requests_status       ON public.registration_requests(status);
CREATE INDEX idx_action_plan_student       ON public.action_plan_items(student_id);

-- Social
CREATE INDEX idx_posts_created_at          ON public.posts(created_at DESC);
CREATE INDEX idx_posts_author_id           ON public.posts(author_id);
CREATE INDEX idx_posts_college_id          ON public.posts(college_id);
CREATE INDEX idx_posts_type                ON public.posts(type);
CREATE INDEX idx_announcements_course      ON public.announcements(course_id);
CREATE INDEX idx_announcements_priority    ON public.announcements(priority);
CREATE INDEX idx_shared_files_course       ON public.shared_files(course_id);
CREATE INDEX idx_forum_posts_forum         ON public.forum_posts(forum_id);
CREATE INDEX idx_forum_posts_author        ON public.forum_posts(author_id);

-- Administration
CREATE INDEX idx_notifications_user        ON public.notifications(user_id, is_read);
CREATE INDEX idx_notifications_created_at  ON public.notifications(created_at DESC);
CREATE INDEX idx_invoices_student          ON public.invoices(student_id);
CREATE INDEX idx_invoices_status           ON public.invoices(status);
CREATE INDEX idx_support_tickets_user      ON public.support_tickets(user_id);
CREATE INDEX idx_support_tickets_status    ON public.support_tickets(status);
CREATE INDEX idx_audit_performed_by        ON public.audit_logs(performed_by);
CREATE INDEX idx_audit_target_user         ON public.audit_logs(target_user);
CREATE INDEX idx_audit_action              ON public.audit_logs(action);
CREATE INDEX idx_audit_created_at          ON public.audit_logs(created_at DESC);
CREATE INDEX idx_sessions_user_active      ON public.user_sessions(user_id, is_active);