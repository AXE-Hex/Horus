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
