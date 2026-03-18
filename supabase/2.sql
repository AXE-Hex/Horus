
-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 0 — NEW ENUM TYPES
-- ═══════════════════════════════════════════════════════════════════════════

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'message_status') THEN
    CREATE TYPE public.message_status AS ENUM ('sent','delivered','read','deleted');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'exam_status') THEN
    CREATE TYPE public.exam_status AS ENUM ('draft','published','in_progress','completed','cancelled');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'question_type') THEN
    CREATE TYPE public.question_type AS ENUM ('mcq','true_false','short_answer','essay','file_upload');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'library_item_type') THEN
    CREATE TYPE public.library_item_type AS ENUM ('book','journal','thesis','research_paper','e_resource','video');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'borrow_status') THEN
    CREATE TYPE public.borrow_status AS ENUM ('reserved','borrowed','returned','overdue','lost');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_method') THEN
    CREATE TYPE public.payment_method AS ENUM ('cash','card','bank_transfer','paymob','stripe','wallet');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_gateway_type') THEN
    CREATE TYPE public.payment_gateway_type AS ENUM ('paymob','stripe','cash','bank_transfer','wallet');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_channel') THEN
    CREATE TYPE public.notif_channel AS ENUM ('in_app','email','sms','push');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'notif_delivery_status') THEN
    CREATE TYPE public.notif_delivery_status AS ENUM ('pending','sent','delivered','failed','bounced');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ai_model_type') THEN
    CREATE TYPE public.ai_model_type AS ENUM ('gpa_predictor','cheat_detector','course_recommender','dropout_risk','grade_forecast');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sync_status') THEN
    CREATE TYPE public.sync_status AS ENUM ('pending','synced','failed','skipped','retry');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'virtual_class_status') THEN
    CREATE TYPE public.virtual_class_status AS ENUM ('scheduled','live','ended','cancelled');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'scholarship_status') THEN
    CREATE TYPE public.scholarship_status AS ENUM ('open','applied','under_review','awarded','rejected','expired');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'encryption_context') THEN
    CREATE TYPE public.encryption_context AS ENUM ('national_id','bank_account','medical','grade','financial');
  END IF;
END $$;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 1 — REAL-TIME CHAT & MESSAGING
--   Priority answer: نظام دردشة / مراسلة فورية
--   Scale: messages partitioned by quarter for 200k+ write throughput.
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.conversations (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  is_group     BOOLEAN     NOT NULL DEFAULT FALSE,
  name         TEXT,
  name_ar      TEXT,
  description  TEXT,
  avatar_url   TEXT,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  created_by   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  last_msg_at  TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS conversations_updated_at ON public.conversations;
CREATE TRIGGER conversations_updated_at
  BEFORE UPDATE ON public.conversations
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS public.conversation_members (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID        NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  is_admin        BOOLEAN     NOT NULL DEFAULT FALSE,
  is_muted        BOOLEAN     NOT NULL DEFAULT FALSE,
  last_read_at    TIMESTAMPTZ,
  joined_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  left_at         TIMESTAMPTZ,
  UNIQUE (conversation_id, user_id)
);
ALTER TABLE public.conversation_members ENABLE ROW LEVEL SECURITY;

-- Partitioned by quarter — add partitions each year via pg_cron or manually
CREATE TABLE IF NOT EXISTS public.messages (
  id              UUID           DEFAULT gen_random_uuid(),
  conversation_id UUID           NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  sender_id       UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content         TEXT,
  media_urls      TEXT[]         NOT NULL DEFAULT '{}',
  status          message_status NOT NULL DEFAULT 'sent',
  reply_to_id     UUID,
  is_system_msg   BOOLEAN        NOT NULL DEFAULT FALSE,
  is_edited       BOOLEAN        NOT NULL DEFAULT FALSE,
  edited_at       TIMESTAMPTZ,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  deleted_at      TIMESTAMPTZ,
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_default') THEN
    CREATE TABLE public.messages_default PARTITION OF public.messages DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2025_q1') THEN
    CREATE TABLE public.messages_2025_q1 PARTITION OF public.messages FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2025_q2') THEN
    CREATE TABLE public.messages_2025_q2 PARTITION OF public.messages FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2025_q3') THEN
    CREATE TABLE public.messages_2025_q3 PARTITION OF public.messages FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2025_q4') THEN
    CREATE TABLE public.messages_2025_q4 PARTITION OF public.messages FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2026_q1') THEN
    CREATE TABLE public.messages_2026_q1 PARTITION OF public.messages FOR VALUES FROM ('2026-01-01') TO ('2026-04-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2026_q2') THEN
    CREATE TABLE public.messages_2026_q2 PARTITION OF public.messages FOR VALUES FROM ('2026-04-01') TO ('2026-07-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2026_q3') THEN
    CREATE TABLE public.messages_2026_q3 PARTITION OF public.messages FOR VALUES FROM ('2026-07-01') TO ('2026-10-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'messages_2026_q4') THEN
    CREATE TABLE public.messages_2026_q4 PARTITION OF public.messages FOR VALUES FROM ('2026-10-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.message_reactions (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id  UUID        NOT NULL,
  user_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  emoji       TEXT        NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (message_id, user_id, emoji)
);
ALTER TABLE public.message_reactions ENABLE ROW LEVEL SECURITY;

INSERT INTO storage.buckets (id, name, public) VALUES ('chat_media','chat_media',false) ON CONFLICT (id) DO NOTHING;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 2 — ONLINE EXAM ENGINE + ANTI-CHEAT
--   Priority answers: نظام امتحانات إلكترونية + كشف الغش في الامتحانات
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.online_exams (
  id                  UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id           UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  title               TEXT        NOT NULL,
  title_ar            TEXT,
  instructions        TEXT,
  instructions_ar     TEXT,
  status              exam_status NOT NULL DEFAULT 'draft',
  exam_type           TEXT        NOT NULL DEFAULT 'quiz'
                                  CHECK (exam_type IN ('quiz','midterm','final','assignment','practice')),
  total_marks         NUMERIC(6,2) NOT NULL DEFAULT 100 CHECK (total_marks > 0),
  pass_marks          NUMERIC(6,2) NOT NULL DEFAULT 50,
  CONSTRAINT chk_pass_le_total CHECK (pass_marks <= total_marks),
  duration_minutes    INT         NOT NULL DEFAULT 60 CHECK (duration_minutes > 0),
  start_at            TIMESTAMPTZ,
  end_at              TIMESTAMPTZ,
  CONSTRAINT chk_exam_window CHECK (end_at IS NULL OR end_at > start_at),
  randomise_questions BOOLEAN     NOT NULL DEFAULT TRUE,
  randomise_options   BOOLEAN     NOT NULL DEFAULT TRUE,
  show_results_after  BOOLEAN     NOT NULL DEFAULT FALSE,
  allow_review        BOOLEAN     NOT NULL DEFAULT FALSE,
  max_attempts        SMALLINT    NOT NULL DEFAULT 1 CHECK (max_attempts >= 1),
  -- 0=disabled  1=basic(tab switch)  2=standard  3=strict(fullscreen+monitoring)
  anti_cheat_level    SMALLINT    NOT NULL DEFAULT 2 CHECK (anti_cheat_level BETWEEN 0 AND 3),
  semester            TEXT        NOT NULL,
  created_by          UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.online_exams ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.exam_questions (
  id            UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id       UUID          NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  question_text TEXT          NOT NULL,
  question_ar   TEXT,
  type          question_type NOT NULL DEFAULT 'mcq',
  marks         NUMERIC(5,2)  NOT NULL DEFAULT 1 CHECK (marks > 0),
  order_index   INT           NOT NULL DEFAULT 0,
  media_url     TEXT,
  explanation   TEXT,
  difficulty    SMALLINT      NOT NULL DEFAULT 2 CHECK (difficulty BETWEEN 1 AND 5),
  created_at    TIMESTAMPTZ   NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_questions ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.question_options (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID        NOT NULL REFERENCES public.exam_questions(id) ON DELETE CASCADE,
  option_text TEXT        NOT NULL,
  option_ar   TEXT,
  is_correct  BOOLEAN     NOT NULL DEFAULT FALSE,
  order_index INT         NOT NULL DEFAULT 0
);
ALTER TABLE public.question_options ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.exam_attempts (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id          UUID        NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  student_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  attempt_number   SMALLINT    NOT NULL DEFAULT 1,
  started_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  submitted_at     TIMESTAMPTZ,
  time_spent_secs  INT,
  total_score      NUMERIC(6,2),
  percentage       NUMERIC(5,2),
  grade_letter     TEXT,
  is_graded        BOOLEAN     NOT NULL DEFAULT FALSE,
  is_flagged       BOOLEAN     NOT NULL DEFAULT FALSE,
  cheat_score      NUMERIC(5,4) NOT NULL DEFAULT 0 CHECK (cheat_score BETWEEN 0 AND 1),
  tab_switches     SMALLINT    NOT NULL DEFAULT 0,
  fullscreen_exits SMALLINT    NOT NULL DEFAULT 0,
  ip_address       INET,
  browser_info     TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (exam_id, student_id, attempt_number)
);
ALTER TABLE public.exam_attempts ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.attempt_answers (
  id                 UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  attempt_id         UUID        NOT NULL REFERENCES public.exam_attempts(id) ON DELETE CASCADE,
  question_id        UUID        NOT NULL REFERENCES public.exam_questions(id) ON DELETE CASCADE,
  selected_option_id UUID        REFERENCES public.question_options(id) ON DELETE SET NULL,
  text_answer        TEXT,
  file_url           TEXT,
  marks_awarded      NUMERIC(5,2),
  is_correct         BOOLEAN,
  grader_notes       TEXT,
  time_spent_secs    INT,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (attempt_id, question_id)
);
ALTER TABLE public.attempt_answers ENABLE ROW LEVEL SECURITY;

-- Anti-cheat event stream — partitioned (high-frequency writes during exams)
CREATE TABLE IF NOT EXISTS public.exam_cheat_events (
  id           UUID        DEFAULT gen_random_uuid(),
  attempt_id   UUID        NOT NULL REFERENCES public.exam_attempts(id) ON DELETE CASCADE,
  event_type   TEXT        NOT NULL CHECK (event_type IN (
                 'tab_switch','window_blur','copy_paste','screenshot_attempt',
                 'multiple_ips','unusual_speed','browser_extension','fullscreen_exit',
                 'rapid_answers','vpn_detected','devtools_open','answer_similarity'
               )),
  severity     SMALLINT    NOT NULL DEFAULT 1 CHECK (severity BETWEEN 1 AND 3),
  details      JSONB,
  occurred_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, occurred_at)
) PARTITION BY RANGE (occurred_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'exam_cheat_events_default') THEN
    CREATE TABLE public.exam_cheat_events_default PARTITION OF public.exam_cheat_events DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'exam_cheat_events_2025') THEN
    CREATE TABLE public.exam_cheat_events_2025 PARTITION OF public.exam_cheat_events FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'exam_cheat_events_2026') THEN
    CREATE TABLE public.exam_cheat_events_2026 PARTITION OF public.exam_cheat_events FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.exam_cheat_events ENABLE ROW LEVEL SECURITY;

-- AI cross-student answer similarity report
CREATE TABLE IF NOT EXISTS public.exam_similarity_reports (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_id          UUID        NOT NULL REFERENCES public.online_exams(id) ON DELETE CASCADE,
  student_a_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  student_b_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  similarity_score NUMERIC(5,4) NOT NULL CHECK (similarity_score BETWEEN 0 AND 1),
  flagged_questions JSONB,
  reviewed_by      UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  verdict          TEXT        CHECK (verdict IN ('coincidence','suspected','confirmed','dismissed')),
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_similarity_reports ENABLE ROW LEVEL SECURITY;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 3 — DIGITAL LIBRARY
--   Priority answer: نظام مكتبة رقمية
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_items (
  id               UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  title            TEXT              NOT NULL,
  title_ar         TEXT,
  author           TEXT,
  author_ar        TEXT,
  isbn             TEXT              UNIQUE,
  doi              TEXT,
  category         TEXT,
  subject          TEXT,
  type             library_item_type NOT NULL DEFAULT 'book',
  edition          TEXT,
  publish_year     INT               CHECK (publish_year BETWEEN 1800 AND 2100),
  publisher        TEXT,
  language         TEXT              NOT NULL DEFAULT 'ar',
  total_copies     INT               NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
  available_copies INT               NOT NULL DEFAULT 1,
  CONSTRAINT chk_available_copies CHECK (available_copies BETWEEN 0 AND total_copies),
  digital_url      TEXT,
  cover_url        TEXT,
  description      TEXT,
  keywords         TEXT[],
  college_id       UUID              REFERENCES public.colleges(id) ON DELETE SET NULL,
  department_id    UUID              REFERENCES public.departments(id) ON DELETE SET NULL,
  is_active        BOOLEAN           NOT NULL DEFAULT TRUE,
  view_count       INT               NOT NULL DEFAULT 0,
  download_count   INT               NOT NULL DEFAULT 0,
  created_at       TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.library_items ENABLE ROW LEVEL SECURITY;

-- Full-text search (Arabic + English)
CREATE INDEX IF NOT EXISTS idx_lib_fts_ar ON public.library_items USING GIN (
  to_tsvector('arabic', COALESCE(title_ar,'') || ' ' || COALESCE(author_ar,'') || ' ' || COALESCE(description,''))
);
CREATE INDEX IF NOT EXISTS idx_lib_fts_en ON public.library_items USING GIN (
  to_tsvector('english', COALESCE(title,'') || ' ' || COALESCE(author,'') || ' ' || COALESCE(description,''))
);

CREATE TABLE IF NOT EXISTS public.library_borrows (
  id           UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id      UUID          NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id      UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  status       borrow_status NOT NULL DEFAULT 'borrowed',
  borrowed_at  TIMESTAMPTZ   NOT NULL DEFAULT now(),
  due_date     DATE          NOT NULL,
  CONSTRAINT chk_due_date CHECK (due_date > borrowed_at::DATE),
  returned_at  TIMESTAMPTZ,
  renewals     SMALLINT      NOT NULL DEFAULT 0,
  fine_amount  NUMERIC(8,2)  NOT NULL DEFAULT 0 CHECK (fine_amount >= 0),
  fine_paid    BOOLEAN       NOT NULL DEFAULT FALSE,
  notes        TEXT
);
ALTER TABLE public.library_borrows ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.library_reservations (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id       UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id       UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  queue_position INT        NOT NULL DEFAULT 1,
  reserved_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at    TIMESTAMPTZ NOT NULL DEFAULT (now() + INTERVAL '7 days'),
  is_fulfilled  BOOLEAN     NOT NULL DEFAULT FALSE,
  notified_at   TIMESTAMPTZ,
  UNIQUE (item_id, user_id)
);
ALTER TABLE public.library_reservations ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.library_reading_history (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id        UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  item_id        UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  opened_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  duration_mins  INT,
  UNIQUE (user_id, item_id)
);
ALTER TABLE public.library_reading_history ENABLE ROW LEVEL SECURITY;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 4 — CUMULATIVE GPA TRACKING
--   Priority answer: نظام تتبع التقدم الأكاديمي (GPA تراكمي)
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.semester_gpa (
  id                UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id        UUID         NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester          TEXT         NOT NULL,
  academic_year     TEXT         NOT NULL,
  credits_attempted INT          NOT NULL DEFAULT 0 CHECK (credits_attempted >= 0),
  credits_earned    INT          NOT NULL DEFAULT 0,
  CONSTRAINT chk_credits_earned CHECK (credits_earned BETWEEN 0 AND credits_attempted),
  quality_points    NUMERIC(8,2) NOT NULL DEFAULT 0 CHECK (quality_points >= 0),
  semester_gpa      NUMERIC(4,3) NOT NULL DEFAULT 0 CHECK (semester_gpa BETWEEN 0 AND 4),
  cumulative_gpa    NUMERIC(4,3) NOT NULL DEFAULT 0 CHECK (cumulative_gpa BETWEEN 0 AND 4),
  total_credits_all INT          NOT NULL DEFAULT 0,
  standing          TEXT         NOT NULL DEFAULT 'good'
                                 CHECK (standing IN ('excellent','very_good','good','satisfactory','warning','probation','suspended')),
  rank_in_dept      INT,
  rank_in_college   INT,
  calculated_at     TIMESTAMPTZ  NOT NULL DEFAULT now(),
  UNIQUE (student_id, semester)
);
ALTER TABLE public.semester_gpa ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.fn_recalculate_cumulative_gpa()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  v_total_cred INT;
  v_total_qp   NUMERIC(10,2);
  v_cgpa       NUMERIC(4,3);
  v_standing   TEXT;
BEGIN
  SELECT COALESCE(SUM(credits_attempted),0), COALESCE(SUM(quality_points),0)
    INTO v_total_cred, v_total_qp
  FROM public.semester_gpa WHERE student_id = NEW.student_id;

  v_cgpa := CASE WHEN v_total_cred = 0 THEN 0
                 ELSE LEAST(4.0, ROUND((v_total_qp / v_total_cred)::NUMERIC, 3)) END;

  v_standing := CASE
    WHEN v_cgpa >= 3.75 THEN 'excellent'
    WHEN v_cgpa >= 3.40 THEN 'very_good'
    WHEN v_cgpa >= 3.00 THEN 'good'
    WHEN v_cgpa >= 2.00 THEN 'satisfactory'
    WHEN v_cgpa >= 1.50 THEN 'warning'
    WHEN v_cgpa >= 1.00 THEN 'probation'
    ELSE 'suspended'
  END;

  UPDATE public.semester_gpa
    SET cumulative_gpa = v_cgpa, total_credits_all = v_total_cred,
        standing = v_standing, calculated_at = now()
  WHERE student_id = NEW.student_id AND semester = NEW.semester;

  -- Auto-notify student if standing worsened
  IF v_standing IN ('warning','probation','suspended')
     AND (OLD IS NULL OR OLD.standing NOT IN ('warning','probation','suspended')) THEN
    INSERT INTO public.notifications (user_id, title, title_ar, message, message_ar, type)
    VALUES (
      NEW.student_id, 'Academic Standing Alert', 'تنبيه الوضع الأكاديمي',
      'Your academic standing changed to: ' || v_standing,
      'تغير وضعك الأكاديمي إلى: ' || v_standing, 'warning'
    );
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_cumulative_gpa ON public.semester_gpa;
CREATE TRIGGER trg_cumulative_gpa
  AFTER INSERT OR UPDATE OF semester_gpa, quality_points, credits_attempted
  ON public.semester_gpa
  FOR EACH ROW EXECUTE FUNCTION public.fn_recalculate_cumulative_gpa();

-- Transcript view (students + registrar)
CREATE VIEW public.vw_transcript AS
SELECT
  p.id AS student_id, p.full_name, p.full_name_ar, p.student_id AS student_no,
  col.name_en AS college, dep.name_en AS department,
  g.semester, co.code, co.name, co.name_ar, co.credit_hours,
  g.midterm, g.final_exam, g.coursework, g.practical,
  g.total, g.grade_letter, g.gpa_points, g.is_published,
  sg.semester_gpa, sg.cumulative_gpa, sg.standing
FROM public.grades g
JOIN public.profiles p    ON p.id  = g.student_id
JOIN public.courses co    ON co.id = g.course_id
LEFT JOIN public.colleges col    ON col.id = p.college_id
LEFT JOIN public.departments dep ON dep.id = p.department_id
LEFT JOIN public.semester_gpa sg ON sg.student_id = g.student_id AND sg.semester = g.semester
WHERE g.is_published = TRUE;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 5 — ADVANCED NOTIFICATION SYSTEM  (In-App + Email + SMS + Push)
--   Answer 3: إشعارات + SMS + بريد إلكتروني
-- ═══════════════════════════════════════════════════════════════════════════

-- Per-user preferences per channel
CREATE TABLE IF NOT EXISTS public.notification_preferences (
  user_id           UUID    PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  in_app_enabled    BOOLEAN NOT NULL DEFAULT TRUE,
  email_enabled     BOOLEAN NOT NULL DEFAULT TRUE,
  sms_enabled       BOOLEAN NOT NULL DEFAULT FALSE,   -- opt-in required
  push_enabled      BOOLEAN NOT NULL DEFAULT TRUE,
  channel_overrides JSONB   NOT NULL DEFAULT '{}',    -- event-level overrides
  quiet_start       TIME,
  quiet_end         TIME,
  timezone          TEXT    NOT NULL DEFAULT 'Africa/Cairo',
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.notification_preferences ENABLE ROW LEVEL SECURITY;

-- Delivery log partitioned (very high-volume for 200k+ users)
CREATE TABLE IF NOT EXISTS public.notification_deliveries (
  id              UUID                  DEFAULT gen_random_uuid(),
  notification_id UUID                  NOT NULL REFERENCES public.notifications(id) ON DELETE CASCADE,
  user_id         UUID                  NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  channel         notif_channel         NOT NULL,
  status          notif_delivery_status NOT NULL DEFAULT 'pending',
  provider        TEXT,
  provider_msg_id TEXT,
  recipient       TEXT,
  subject         TEXT,
  body_preview    TEXT,
  error_message   TEXT,
  attempts        SMALLINT              NOT NULL DEFAULT 0,
  sent_at         TIMESTAMPTZ,
  delivered_at    TIMESTAMPTZ,
  opened_at       TIMESTAMPTZ,
  created_at      TIMESTAMPTZ           NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'notification_deliveries_default') THEN
    CREATE TABLE public.notification_deliveries_default PARTITION OF public.notification_deliveries DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'notification_deliveries_2025') THEN
    CREATE TABLE public.notification_deliveries_2025 PARTITION OF public.notification_deliveries FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'notification_deliveries_2026') THEN
    CREATE TABLE public.notification_deliveries_2026 PARTITION OF public.notification_deliveries FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.notification_deliveries ENABLE ROW LEVEL SECURITY;

-- SMS log (compliance + cost tracking)
CREATE TABLE IF NOT EXISTS public.sms_log (
  id           UUID                  DEFAULT gen_random_uuid(),
  user_id      UUID                  REFERENCES public.profiles(id) ON DELETE SET NULL,
  phone        TEXT                  NOT NULL,
  message      TEXT                  NOT NULL,
  provider     TEXT                  NOT NULL DEFAULT 'vonage'
                                     CHECK (provider IN ('vonage','twilio','unifonic','msegat')),
  status       notif_delivery_status NOT NULL DEFAULT 'pending',
  cost_usd     NUMERIC(6,4),
  provider_id  TEXT,
  sent_at      TIMESTAMPTZ,
  created_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'sms_log_default') THEN
    CREATE TABLE public.sms_log_default PARTITION OF public.sms_log DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'sms_log_2025') THEN
    CREATE TABLE public.sms_log_2025 PARTITION OF public.sms_log FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'sms_log_2026') THEN
    CREATE TABLE public.sms_log_2026 PARTITION OF public.sms_log FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.sms_log ENABLE ROW LEVEL SECURITY;

-- Email queue (bulk sends, processed by Edge Function / pg_cron)
CREATE TABLE IF NOT EXISTS public.email_queue (
  id             UUID                  DEFAULT gen_random_uuid(),
  user_id        UUID                  REFERENCES public.profiles(id) ON DELETE SET NULL,
  to_email       TEXT                  NOT NULL,
  to_name        TEXT,
  subject        TEXT                  NOT NULL,
  subject_ar     TEXT,
  html_body      TEXT                  NOT NULL,
  template_id    TEXT,
  template_vars  JSONB,
  priority       SMALLINT              NOT NULL DEFAULT 2 CHECK (priority BETWEEN 1 AND 5),
  scheduled_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  sent_at        TIMESTAMPTZ,
  status         notif_delivery_status NOT NULL DEFAULT 'pending',
  error_message  TEXT,
  created_at     TIMESTAMPTZ           NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);
ALTER TABLE public.email_queue ENABLE ROW LEVEL SECURITY;

-- Mobile push device tokens
CREATE TABLE IF NOT EXISTS public.device_push_tokens (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  token        TEXT        NOT NULL UNIQUE,
  platform     TEXT        NOT NULL CHECK (platform IN ('ios','android','web')),
  app_version  TEXT,
  device_model TEXT,
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  last_used_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.device_push_tokens ENABLE ROW LEVEL SECURITY;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 6 — COLUMN-LEVEL ENCRYPTION (pgcrypto)
--   Answer 4: تشفير البيانات الحساسة داخل DB
-- ═══════════════════════════════════════════════════════════════════════════

-- Key registry (holds reference names only — real keys live in Vault/Secrets)
CREATE TABLE IF NOT EXISTS public.encryption_keys (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  context     encryption_context NOT NULL UNIQUE,
  key_ref     TEXT               NOT NULL,   -- name of Vault secret
  algorithm   TEXT               NOT NULL DEFAULT 'aes256',
  rotated_at  TIMESTAMPTZ,
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now()
);
ALTER TABLE public.encryption_keys ENABLE ROW LEVEL SECURITY;

-- Encrypted blobs store
CREATE TABLE IF NOT EXISTS public.encrypted_data (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id    UUID               NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  context     encryption_context NOT NULL,
  ciphertext  BYTEA              NOT NULL,   -- pgp_sym_encrypt output
  checksum    TEXT,                          -- SHA-256 of plaintext (integrity check)
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  UNIQUE (owner_id, context)
);
ALTER TABLE public.encrypted_data ENABLE ROW LEVEL SECURITY;

-- Decrypt SECURITY DEFINER — only this function can read ciphertext
CREATE OR REPLACE FUNCTION public.fn_decrypt_field(
  p_owner_id UUID, p_context encryption_context, p_key TEXT
) RETURNS TEXT LANGUAGE plpgsql SECURITY DEFINER STABLE AS $$
DECLARE v_cipher BYTEA;
BEGIN
  IF auth.uid() <> p_owner_id
     AND NOT (public.get_my_role() IN ('super_admin','admin','it_support'))
  THEN RAISE EXCEPTION 'Access denied: insufficient privilege.'; END IF;

  SELECT ciphertext INTO v_cipher FROM public.encrypted_data
   WHERE owner_id = p_owner_id AND context = p_context;
  IF v_cipher IS NULL THEN RETURN NULL; END IF;
  RETURN pgp_sym_decrypt(v_cipher, p_key);
EXCEPTION WHEN OTHERS THEN
  RAISE WARNING 'Decryption failed for % %: %', p_owner_id, p_context, SQLERRM;
  RETURN NULL;
END;
$$;

-- Encrypt SECURITY DEFINER
CREATE OR REPLACE FUNCTION public.fn_encrypt_field(
  p_owner_id UUID, p_context encryption_context, p_value TEXT, p_key TEXT
) RETURNS VOID LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  IF auth.uid() <> p_owner_id
     AND NOT (public.get_my_role() IN ('super_admin','admin','it_support'))
  THEN RAISE EXCEPTION 'Access denied.'; END IF;

  INSERT INTO public.encrypted_data (owner_id, context, ciphertext, checksum)
  VALUES (p_owner_id, p_context,
          pgp_sym_encrypt(p_value, p_key),
          encode(digest(p_value,'sha256'),'hex'))
  ON CONFLICT (owner_id, context) DO UPDATE
    SET ciphertext = EXCLUDED.ciphertext, checksum = EXCLUDED.checksum, updated_at = now();
END;
$$;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 7 — COMPLETE FINANCIAL SYSTEM
--   Answer 5: بوابة دفع (Stripe/Paymob) + فواتير تلقائية + تقارير مالية
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.payment_transactions (
  id                UUID                PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id        UUID                NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
  student_id        UUID                NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  gateway           payment_gateway_type NOT NULL,
  gateway_order_id  TEXT,
  gateway_txn_id    TEXT,
  amount            NUMERIC(10,2)        NOT NULL CHECK (amount > 0),
  currency          TEXT                 NOT NULL DEFAULT 'EGP',
  method            payment_method       NOT NULL DEFAULT 'card',
  status            payment_status       NOT NULL DEFAULT 'pending',
  raw_response      JSONB,
  failure_code      TEXT,
  failure_reason    TEXT,
  initiated_at      TIMESTAMPTZ          NOT NULL DEFAULT now(),
  completed_at      TIMESTAMPTZ,
  refunded_at       TIMESTAMPTZ,
  refund_amount     NUMERIC(10,2),
  refund_reason     TEXT
);
ALTER TABLE public.payment_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS status payment_status NOT NULL DEFAULT 'pending';
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS gateway payment_gateway_type NOT NULL DEFAULT 'cash';
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS currency TEXT NOT NULL DEFAULT 'EGP';
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS amount NUMERIC(10,2) NOT NULL DEFAULT 0;
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS initiated_at TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE public.payment_transactions ADD COLUMN IF NOT EXISTS refund_amount NUMERIC(10,2);

CREATE TABLE IF NOT EXISTS public.invoice_schedules (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name            TEXT        NOT NULL,
  description     TEXT,
  amount          NUMERIC(10,2) NOT NULL CHECK (amount > 0),
  currency        TEXT        NOT NULL DEFAULT 'EGP',
  college_id      UUID        REFERENCES public.colleges(id) ON DELETE SET NULL,
  department_id   UUID        REFERENCES public.departments(id) ON DELETE SET NULL,
  target_roles    user_role[] NOT NULL DEFAULT '{student}',
  semester        TEXT,
  due_days_offset INT         NOT NULL DEFAULT 30,
  auto_generate   BOOLEAN     NOT NULL DEFAULT TRUE,
  is_active       BOOLEAN     NOT NULL DEFAULT TRUE,
  last_run_at     TIMESTAMPTZ,
  next_run_at     TIMESTAMPTZ,
  created_by      UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.invoice_schedules ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.scholarships (
  id               UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT               NOT NULL,
  name_ar          TEXT,
  description      TEXT,
  amount           NUMERIC(10,2),
  percentage       NUMERIC(5,2)       CHECK (percentage BETWEEN 0 AND 100),
  status           scholarship_status NOT NULL DEFAULT 'open',
  min_gpa          NUMERIC(4,3)       CHECK (min_gpa BETWEEN 0 AND 4),
  college_id       UUID               REFERENCES public.colleges(id) ON DELETE SET NULL,
  department_id    UUID               REFERENCES public.departments(id) ON DELETE SET NULL,
  max_recipients   INT                CHECK (max_recipients > 0),
  apply_deadline   DATE,
  academic_year    TEXT               NOT NULL,
  created_by       UUID               NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at       TIMESTAMPTZ        NOT NULL DEFAULT now()
);
ALTER TABLE public.scholarships ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.scholarship_applications (
  id             UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  scholarship_id UUID               NOT NULL REFERENCES public.scholarships(id) ON DELETE CASCADE,
  student_id     UUID               NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  status         scholarship_status NOT NULL DEFAULT 'applied',
  statement      TEXT,
  documents_urls TEXT[]             NOT NULL DEFAULT '{}',
  reviewer_id    UUID               REFERENCES public.profiles(id) ON DELETE SET NULL,
  reviewer_notes TEXT,
  awarded_at     TIMESTAMPTZ,
  created_at     TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ        NOT NULL DEFAULT now(),
  UNIQUE (scholarship_id, student_id)
);
ALTER TABLE public.scholarship_applications ENABLE ROW LEVEL SECURITY;

-- Materialised view: daily financial summary
DROP MATERIALIZED VIEW IF EXISTS public.mv_financial_daily;
CREATE MATERIALIZED VIEW public.mv_financial_daily AS
SELECT
  DATE_TRUNC('day', pt.initiated_at)::DATE              AS report_date,
  c.name_en                                             AS college,
  pt.gateway, pt.currency,
  COUNT(*)                                              AS total_txns,
  COUNT(*) FILTER (WHERE pt.status = 'paid')            AS paid_count,
  COUNT(*) FILTER (WHERE pt.status = 'pending')         AS pending_count,
  COUNT(*) FILTER (WHERE pt.status = 'refunded')        AS refunded_count,
  COALESCE(SUM(pt.amount)        FILTER (WHERE pt.status = 'paid'),    0) AS collected,
  COALESCE(SUM(pt.amount)        FILTER (WHERE pt.status = 'pending'), 0) AS outstanding,
  COALESCE(SUM(pt.refund_amount) FILTER (WHERE pt.status = 'refunded'),0) AS refunded
FROM public.payment_transactions pt
JOIN public.profiles p    ON p.id = pt.student_id
LEFT JOIN public.colleges c ON c.id = p.college_id
GROUP BY report_date, c.name_en, pt.gateway, pt.currency
WITH NO DATA;
-- SELECT cron.schedule('refresh_fin_daily','0 2 * * *',
--   $$REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_financial_daily$$);

-- Materialised view: monthly revenue
DROP MATERIALIZED VIEW IF EXISTS public.mv_revenue_monthly;
CREATE MATERIALIZED VIEW public.mv_revenue_monthly AS
SELECT
  DATE_TRUNC('month', pt.initiated_at)::DATE AS month,
  c.name_en                                  AS college,
  COUNT(DISTINCT pt.student_id)              AS unique_payers,
  COALESCE(SUM(pt.amount) FILTER (WHERE pt.status='paid'), 0) AS revenue,
  pt.currency
FROM public.payment_transactions pt
JOIN public.profiles p    ON p.id = pt.student_id
LEFT JOIN public.colleges c ON c.id = p.college_id
WHERE pt.status = 'paid'
GROUP BY month, c.name_en, pt.currency
WITH NO DATA;
-- SELECT cron.schedule('refresh_rev_monthly','0 3 1 * *',
--   $$REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_revenue_monthly$$);


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 8 — i18n + AUTO-TRANSLATION QUEUE
--   Answer 6: واجهة متعددة اللغات مع ترجمة تلقائية
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.supported_locales (
  code       TEXT     PRIMARY KEY,
  name_en    TEXT     NOT NULL,
  name_local TEXT     NOT NULL,
  direction  TEXT     NOT NULL DEFAULT 'ltr' CHECK (direction IN ('ltr','rtl')),
  is_active  BOOLEAN  NOT NULL DEFAULT TRUE,
  sort_order SMALLINT NOT NULL DEFAULT 99
);

INSERT INTO public.supported_locales (code, name_en, name_local, direction, sort_order) VALUES
  ('ar','Arabic',  'العربية',  'rtl', 1),
  ('en','English', 'English',  'ltr', 2),
  ('fr','French',  'Français', 'ltr', 3),
  ('de','German',  'Deutsch',  'ltr', 4),
  ('zh','Chinese', '中文',      'ltr', 5)
ON CONFLICT (code) DO NOTHING;

CREATE TABLE IF NOT EXISTS public.translations (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  locale     TEXT        NOT NULL REFERENCES public.supported_locales(code) ON DELETE CASCADE,
  namespace  TEXT        NOT NULL DEFAULT 'common',
  key        TEXT        NOT NULL,
  value      TEXT        NOT NULL,
  is_auto    BOOLEAN     NOT NULL DEFAULT FALSE,   -- auto-translated, needs human review
  reviewed   BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (locale, namespace, key)
);
ALTER TABLE public.translations ENABLE ROW LEVEL SECURITY;

-- Auto-translation queue (consumed by Edge Function → OpenAI / DeepL / Google)
CREATE TABLE IF NOT EXISTS public.translation_requests (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  source_text  TEXT        NOT NULL,
  source_lang  TEXT        NOT NULL DEFAULT 'ar',
  target_lang  TEXT        NOT NULL,
  namespace    TEXT        NOT NULL DEFAULT 'common',
  key          TEXT        NOT NULL,
  status       TEXT        NOT NULL DEFAULT 'pending'
                           CHECK (status IN ('pending','processing','done','failed')),
  translated   TEXT,
  provider     TEXT        NOT NULL DEFAULT 'openai'
                           CHECK (provider IN ('openai','deepl','google')),
  error        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ
);
ALTER TABLE public.translation_requests ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.user_preferences (
  user_id           UUID    PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  locale            TEXT    NOT NULL DEFAULT 'ar' REFERENCES public.supported_locales(code),
  theme             TEXT    NOT NULL DEFAULT 'system' CHECK (theme IN ('light','dark','system')),
  notifications_on  BOOLEAN NOT NULL DEFAULT TRUE,
  email_digest      TEXT    NOT NULL DEFAULT 'daily' CHECK (email_digest IN ('off','daily','weekly')),
  sms_opt_in        BOOLEAN NOT NULL DEFAULT FALSE,
  timezone          TEXT    NOT NULL DEFAULT 'Africa/Cairo',
  dashboard_widgets JSONB   NOT NULL DEFAULT '{}',
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.user_preferences ENABLE ROW LEVEL SECURITY;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 9 — AI ANALYTICS & PREDICTIONS
--   Answer 8: لوحة تحليلات + توقع أداء الطالب بالـ AI + كشف الغش
-- ═══════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.ai_predictions (
  id               UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  model_type       ai_model_type NOT NULL,
  semester         TEXT          NOT NULL,
  confidence       NUMERIC(5,4)  NOT NULL CHECK (confidence BETWEEN 0 AND 1),
  risk_score       NUMERIC(5,4)  CHECK (risk_score BETWEEN 0 AND 1),
  predicted_grade  TEXT,
  predicted_gpa    NUMERIC(4,3)  CHECK (predicted_gpa BETWEEN 0 AND 4),
  feature_snapshot JSONB,
  model_version    TEXT,
  is_acted_on      BOOLEAN       NOT NULL DEFAULT FALSE,
  actioned_by      UUID          REFERENCES public.profiles(id) ON DELETE SET NULL,
  actioned_at      TIMESTAMPTZ,
  created_at       TIMESTAMPTZ   NOT NULL DEFAULT now()
);
ALTER TABLE public.ai_predictions ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.course_recommendations (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester     TEXT        NOT NULL,
  relevance    NUMERIC(5,4) NOT NULL CHECK (relevance BETWEEN 0 AND 1),
  reason_en    TEXT,
  reason_ar    TEXT,
  is_dismissed BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (student_id, course_id, semester)
);
ALTER TABLE public.course_recommendations ENABLE ROW LEVEL SECURITY;

-- Analytics event stream (partitioned)
CREATE TABLE IF NOT EXISTS public.analytics_events (
  id         UUID        DEFAULT gen_random_uuid(),
  user_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  event_name TEXT        NOT NULL,
  payload    JSONB,
  ip_address INET,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'analytics_events_default') THEN
    CREATE TABLE public.analytics_events_default PARTITION OF public.analytics_events DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'analytics_events_2025') THEN
    CREATE TABLE public.analytics_events_2025 PARTITION OF public.analytics_events FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'analytics_events_2026') THEN
    CREATE TABLE public.analytics_events_2026 PARTITION OF public.analytics_events FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.analytics_events ENABLE ROW LEVEL SECURITY;

-- Admin dashboard MV: full student academic snapshot
DROP MATERIALIZED VIEW IF EXISTS public.mv_student_academic_summary;
CREATE MATERIALIZED VIEW public.mv_student_academic_summary AS
SELECT
  p.id AS student_id, p.full_name, p.full_name_ar,
  p.email, p.student_id AS student_no,
  p.college_id, p.department_id,
  col.name_en AS college_name, dep.name_en AS department_name,
  sg.cumulative_gpa, sg.semester_gpa, sg.standing,
  sg.total_credits_all, sg.semester AS latest_semester,
  COUNT(DISTINCT scr.course_id)                                         AS enrolled_courses,
  COUNT(DISTINCT g.id) FILTER (WHERE g.is_published AND g.total >= 60)  AS passed_courses,
  COUNT(DISTINCT g.id) FILTER (WHERE g.is_published AND g.total <  60)  AS failed_courses,
  ROUND(COUNT(a.id) FILTER (WHERE a.status='present')::NUMERIC
        / NULLIF(COUNT(a.id),0) * 100, 1)                               AS attendance_pct,
  COALESCE(SUM(inv.amount) FILTER (WHERE inv.status='pending'), 0)      AS outstanding_fees,
  ap.risk_score AS dropout_risk
FROM public.profiles p
LEFT JOIN public.colleges col    ON col.id = p.college_id
LEFT JOIN public.departments dep ON dep.id = p.department_id
LEFT JOIN public.semester_gpa sg ON sg.student_id = p.id
  AND sg.calculated_at = (SELECT MAX(s2.calculated_at) FROM public.semester_gpa s2 WHERE s2.student_id = p.id)
LEFT JOIN public.student_course_registrations scr ON scr.student_id = p.id
LEFT JOIN public.grades g    ON g.student_id = p.id
LEFT JOIN public.attendance a ON a.student_id = p.id
LEFT JOIN public.invoices inv ON inv.student_id = p.id
LEFT JOIN public.ai_predictions ap ON ap.student_id = p.id AND ap.model_type = 'dropout_risk'
  AND ap.created_at = (SELECT MAX(a2.created_at) FROM public.ai_predictions a2 WHERE a2.student_id=p.id AND a2.model_type='dropout_risk')
WHERE p.roles @> ARRAY['student'::user_role] AND p.deleted_at IS NULL
GROUP BY p.id, p.full_name, p.full_name_ar, p.email, p.student_id,
         p.college_id, p.department_id, col.name_en, dep.name_en,
         sg.cumulative_gpa, sg.semester_gpa, sg.standing, sg.total_credits_all,
         sg.semester, ap.risk_score
WITH NO DATA;
-- SELECT cron.schedule('refresh_academic_summary','30 2 * * *',
--   $$REFRESH MATERIALIZED VIEW CONCURRENTLY public.mv_student_academic_summary$$);


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 10 — EXTERNAL INTEGRATIONS
--   Answer 9: موبايل iOS/Android + Zoom/Google Meet + Ministry API
-- ═══════════════════════════════════════════════════════════════════════════

-- Virtual classrooms (Zoom / Google Meet)
CREATE TABLE IF NOT EXISTS public.virtual_classes (
  id               UUID                 PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        UUID                 NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  title            TEXT                 NOT NULL,
  title_ar         TEXT,
  provider         TEXT                 NOT NULL DEFAULT 'zoom'
                                        CHECK (provider IN ('zoom','google_meet','microsoft_teams','jitsi')),
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
  created_by       UUID                 NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at       TIMESTAMPTZ          NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ          NOT NULL DEFAULT now()
);
ALTER TABLE public.virtual_classes ENABLE ROW LEVEL SECURITY;

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

-- Ministry of Education sync log (partitioned)
CREATE TABLE IF NOT EXISTS public.ministry_sync_logs (
  id               UUID        DEFAULT gen_random_uuid(),
  entity_type      TEXT        NOT NULL
                               CHECK (entity_type IN ('student','grade','enrollment','course','graduate')),
  entity_id        UUID        NOT NULL,
  national_id      TEXT,
  status           sync_status NOT NULL DEFAULT 'pending',
  attempt_count    SMALLINT    NOT NULL DEFAULT 0,
  ministry_ref     TEXT,
  request_payload  JSONB,
  response_payload JSONB,
  error_message    TEXT,
  synced_at        TIMESTAMPTZ,
  retry_after      TIMESTAMPTZ,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'ministry_sync_logs_default') THEN
    CREATE TABLE public.ministry_sync_logs_default PARTITION OF public.ministry_sync_logs DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'ministry_sync_logs_2025') THEN
    CREATE TABLE public.ministry_sync_logs_2025 PARTITION OF public.ministry_sync_logs FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'ministry_sync_logs_2026') THEN
    CREATE TABLE public.ministry_sync_logs_2026 PARTITION OF public.ministry_sync_logs FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.ministry_sync_logs ENABLE ROW LEVEL SECURITY;

-- Login attempt throttle (partitioned)
CREATE TABLE IF NOT EXISTS public.login_attempts (
  id             UUID        DEFAULT gen_random_uuid(),
  email          TEXT        NOT NULL,
  ip_address     INET        NOT NULL,
  user_agent     TEXT,
  platform       TEXT        CHECK (platform IN ('ios','android','web','api')),
  is_success     BOOLEAN     NOT NULL DEFAULT FALSE,
  failure_reason TEXT,
  attempted_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, attempted_at)
) PARTITION BY RANGE (attempted_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'login_attempts_default') THEN
    CREATE TABLE public.login_attempts_default PARTITION OF public.login_attempts DEFAULT;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'login_attempts_2025') THEN
    CREATE TABLE public.login_attempts_2025 PARTITION OF public.login_attempts FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid = c.relnamespace WHERE n.nspname = 'public' AND c.relname = 'login_attempts_2026') THEN
    CREATE TABLE public.login_attempts_2026 PARTITION OF public.login_attempts FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
  END IF;
END $$;
ALTER TABLE public.login_attempts ENABLE ROW LEVEL SECURITY;

-- Mobile app version management (force-update support)
CREATE TABLE IF NOT EXISTS public.app_versions (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  platform         TEXT        NOT NULL CHECK (platform IN ('ios','android')),
  version_code     TEXT        NOT NULL,
  version_name     TEXT        NOT NULL,
  release_notes    TEXT,
  release_notes_ar TEXT,
  is_mandatory     BOOLEAN     NOT NULL DEFAULT FALSE,
  min_version      TEXT,
  store_url        TEXT,
  released_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (platform, version_code)
);
ALTER TABLE public.app_versions ENABLE ROW LEVEL SECURITY;


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 11 — PERFORMANCE INDEXES (200,000 + users)
-- ═══════════════════════════════════════════════════════════════════════════

-- Chat
CREATE INDEX IF NOT EXISTS idx_conv_created_by        ON public.conversations(created_by);
CREATE INDEX IF NOT EXISTS idx_conv_course            ON public.conversations(course_id);
CREATE INDEX IF NOT EXISTS idx_conv_members_user      ON public.conversation_members(user_id);
CREATE INDEX IF NOT EXISTS idx_conv_members_conv      ON public.conversation_members(conversation_id);
CREATE INDEX IF NOT EXISTS idx_messages_conv_time     ON public.messages(conversation_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_messages_sender        ON public.messages(sender_id);

-- Exams
CREATE INDEX IF NOT EXISTS idx_online_exams_course    ON public.online_exams(course_id);
CREATE INDEX IF NOT EXISTS idx_online_exams_status    ON public.online_exams(status);
CREATE INDEX IF NOT EXISTS idx_exam_questions_exam    ON public.exam_questions(exam_id);
CREATE INDEX IF NOT EXISTS idx_exam_attempts_exam     ON public.exam_attempts(exam_id);
CREATE INDEX IF NOT EXISTS idx_exam_attempts_student  ON public.exam_attempts(student_id);
CREATE INDEX IF NOT EXISTS idx_cheat_events_attempt   ON public.exam_cheat_events(attempt_id);
CREATE INDEX IF NOT EXISTS idx_cheat_events_type_sev  ON public.exam_cheat_events(event_type, severity);
CREATE INDEX IF NOT EXISTS idx_similarity_exam_score  ON public.exam_similarity_reports(exam_id, similarity_score DESC);

-- Library
CREATE INDEX IF NOT EXISTS idx_lib_type               ON public.library_items(type);
CREATE INDEX IF NOT EXISTS idx_lib_available          ON public.library_items(available_copies) WHERE available_copies > 0;
CREATE INDEX IF NOT EXISTS idx_lib_borrows_user       ON public.library_borrows(user_id);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_due        ON public.library_borrows(due_date) WHERE status = 'borrowed';
CREATE INDEX IF NOT EXISTS idx_lib_res_item           ON public.library_reservations(item_id);

-- GPA
CREATE INDEX IF NOT EXISTS idx_sgpa_student           ON public.semester_gpa(student_id);
CREATE INDEX IF NOT EXISTS idx_sgpa_standing          ON public.semester_gpa(standing);
CREATE INDEX IF NOT EXISTS idx_sgpa_cgpa_desc         ON public.semester_gpa(cumulative_gpa DESC);

-- Notifications
CREATE INDEX IF NOT EXISTS idx_notif_del_user_status  ON public.notification_deliveries(user_id, status);
CREATE INDEX IF NOT EXISTS idx_notif_del_channel      ON public.notification_deliveries(channel, status);
CREATE INDEX IF NOT EXISTS idx_sms_log_phone          ON public.sms_log(phone);
CREATE INDEX IF NOT EXISTS idx_email_queue_pending    ON public.email_queue(status, scheduled_at) WHERE status = 'pending';
CREATE INDEX IF NOT EXISTS idx_push_tokens_user       ON public.device_push_tokens(user_id, is_active);

-- Financial
CREATE INDEX IF NOT EXISTS idx_pay_txn_student        ON public.payment_transactions(student_id);
CREATE INDEX IF NOT EXISTS idx_pay_txn_status         ON public.payment_transactions(status);
CREATE INDEX IF NOT EXISTS idx_pay_txn_gateway        ON public.payment_transactions(gateway);
CREATE INDEX IF NOT EXISTS idx_scholarship_app_stu    ON public.scholarship_applications(student_id, status);

-- i18n
CREATE INDEX IF NOT EXISTS idx_translations_lns       ON public.translations(locale, namespace, key);
CREATE INDEX IF NOT EXISTS idx_trans_req_pending      ON public.translation_requests(status) WHERE status = 'pending';

-- AI
CREATE INDEX IF NOT EXISTS idx_ai_pred_stu_type       ON public.ai_predictions(student_id, model_type);
CREATE INDEX IF NOT EXISTS idx_ai_pred_risk_desc      ON public.ai_predictions(risk_score DESC) WHERE risk_score IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_course_recs_student    ON public.course_recommendations(student_id, semester);

-- Integrations
CREATE INDEX IF NOT EXISTS idx_vclass_course_sched    ON public.virtual_classes(course_id, scheduled_at);
CREATE INDEX IF NOT EXISTS idx_ministry_status        ON public.ministry_sync_logs(status, created_at);
CREATE INDEX IF NOT EXISTS idx_login_email_time       ON public.login_attempts(email, attempted_at DESC);
CREATE INDEX IF NOT EXISTS idx_login_ip_time          ON public.login_attempts(ip_address, attempted_at DESC);


-- ═══════════════════════════════════════════════════════════════════════════
-- BLOCK 12 — ROW LEVEL SECURITY (NEW TABLES)
-- ═══════════════════════════════════════════════════════════════════════════

-- Chat
DROP POLICY IF EXISTS "conv_member_view" ON public.conversations;
CREATE POLICY "conv_member_view"    ON public.conversations FOR SELECT
  USING (id IN (SELECT conversation_id FROM public.conversation_members WHERE user_id=auth.uid() AND left_at IS NULL));
DROP POLICY IF EXISTS "conv_create_own" ON public.conversations;
CREATE POLICY "conv_create_own"     ON public.conversations FOR INSERT WITH CHECK (created_by=auth.uid());
DROP POLICY IF EXISTS "conv_admin_all" ON public.conversations;
CREATE POLICY "conv_admin_all"      ON public.conversations FOR ALL USING (public.get_my_role() IN ('super_admin','admin'));
DROP POLICY IF EXISTS "conv_members_own" ON public.conversation_members;
CREATE POLICY "conv_members_own"    ON public.conversation_members FOR ALL USING (user_id=auth.uid());
DROP POLICY IF EXISTS "conv_members_admin" ON public.conversation_members;
CREATE POLICY "conv_members_admin"  ON public.conversation_members FOR ALL USING (public.get_my_role() IN ('super_admin','admin'));
DROP POLICY IF EXISTS "msg_member_view" ON public.messages;
CREATE POLICY "msg_member_view"     ON public.messages FOR SELECT
  USING (conversation_id IN (SELECT conversation_id FROM public.conversation_members WHERE user_id=auth.uid()));
DROP POLICY IF EXISTS "msg_send_own" ON public.messages;
CREATE POLICY "msg_send_own"        ON public.messages FOR INSERT WITH CHECK (sender_id=auth.uid());
DROP POLICY IF EXISTS "msg_soft_delete_own" ON public.messages;
CREATE POLICY "msg_soft_delete_own" ON public.messages FOR UPDATE USING (sender_id=auth.uid());

-- Exams
DROP POLICY IF EXISTS "exam_student_view" ON public.online_exams;
CREATE POLICY "exam_student_view"   ON public.online_exams FOR SELECT
  USING (status IN ('published','in_progress','completed') AND course_id IN (
    SELECT course_id FROM public.student_course_registrations WHERE student_id=auth.uid()));
DROP POLICY IF EXISTS "exam_professor_all" ON public.online_exams;
CREATE POLICY "exam_professor_all"  ON public.online_exams FOR ALL
  USING (created_by=auth.uid() OR course_id IN (SELECT id FROM public.courses WHERE professor_id=auth.uid()));
DROP POLICY IF EXISTS "exam_admin_all" ON public.online_exams;
CREATE POLICY "exam_admin_all"      ON public.online_exams FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "attempt_own" ON public.exam_attempts;
CREATE POLICY "attempt_own"         ON public.exam_attempts FOR ALL USING (student_id=auth.uid());
DROP POLICY IF EXISTS "attempt_professor" ON public.exam_attempts;
CREATE POLICY "attempt_professor"   ON public.exam_attempts FOR SELECT
  USING (exam_id IN (SELECT id FROM public.online_exams WHERE created_by=auth.uid()));
DROP POLICY IF EXISTS "attempt_admin" ON public.exam_attempts;
CREATE POLICY "attempt_admin"       ON public.exam_attempts FOR ALL USING (public.get_my_role() IN ('super_admin','admin'));
DROP POLICY IF EXISTS "cheat_ev_insert" ON public.exam_cheat_events;
CREATE POLICY "cheat_ev_insert"     ON public.exam_cheat_events FOR INSERT WITH CHECK (TRUE);
DROP POLICY IF EXISTS "cheat_ev_admin" ON public.exam_cheat_events;
CREATE POLICY "cheat_ev_admin"      ON public.exam_cheat_events FOR SELECT USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "similarity_admin" ON public.exam_similarity_reports;
CREATE POLICY "similarity_admin"    ON public.exam_similarity_reports FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- Library
DROP POLICY IF EXISTS "lib_items_view" ON public.library_items;
CREATE POLICY "lib_items_view"      ON public.library_items FOR SELECT USING (is_active=TRUE);
DROP POLICY IF EXISTS "lib_items_admin" ON public.library_items;
CREATE POLICY "lib_items_admin"     ON public.library_items FOR ALL USING (public.get_my_role() IN ('super_admin','admin','librarian'));
DROP POLICY IF EXISTS "lib_borrows_own" ON public.library_borrows;
CREATE POLICY "lib_borrows_own"     ON public.library_borrows FOR ALL USING (user_id=auth.uid());
DROP POLICY IF EXISTS "lib_borrows_admin" ON public.library_borrows;
CREATE POLICY "lib_borrows_admin"   ON public.library_borrows FOR ALL USING (public.get_my_role() IN ('super_admin','admin','librarian'));
DROP POLICY IF EXISTS "lib_res_own" ON public.library_reservations;
CREATE POLICY "lib_res_own"         ON public.library_reservations FOR ALL USING (user_id=auth.uid());
DROP POLICY IF EXISTS "lib_history_own" ON public.library_reading_history;
CREATE POLICY "lib_history_own"     ON public.library_reading_history FOR ALL USING (user_id=auth.uid());

-- GPA
DROP POLICY IF EXISTS "gpa_own" ON public.semester_gpa;
CREATE POLICY "gpa_own"             ON public.semester_gpa FOR SELECT USING (student_id=auth.uid());
DROP POLICY IF EXISTS "gpa_advisor" ON public.semester_gpa;
CREATE POLICY "gpa_advisor"         ON public.semester_gpa FOR SELECT
  USING (student_id IN (SELECT id FROM public.profiles WHERE advisor_id=auth.uid()));
DROP POLICY IF EXISTS "gpa_admin" ON public.semester_gpa;
CREATE POLICY "gpa_admin"           ON public.semester_gpa FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','registrar_officer'));

-- Notifications
DROP POLICY IF EXISTS "notif_pref_own" ON public.notification_preferences;
CREATE POLICY "notif_pref_own"      ON public.notification_preferences FOR ALL USING (user_id=auth.uid());
DROP POLICY IF EXISTS "notif_del_admin" ON public.notification_deliveries;
CREATE POLICY "notif_del_admin"     ON public.notification_deliveries FOR SELECT USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "sms_log_admin" ON public.sms_log;
CREATE POLICY "sms_log_admin"       ON public.sms_log FOR SELECT USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "email_q_admin" ON public.email_queue;
CREATE POLICY "email_q_admin"       ON public.email_queue FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "push_tok_own" ON public.device_push_tokens;
CREATE POLICY "push_tok_own"        ON public.device_push_tokens FOR ALL USING (user_id=auth.uid());

-- Encryption
DROP POLICY IF EXISTS "enc_data_own" ON public.encrypted_data;
CREATE POLICY "enc_data_own"        ON public.encrypted_data FOR SELECT USING (owner_id=auth.uid());
DROP POLICY IF EXISTS "enc_data_admin" ON public.encrypted_data;
CREATE POLICY "enc_data_admin"      ON public.encrypted_data FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "enc_keys_admin" ON public.encryption_keys;
CREATE POLICY "enc_keys_admin"      ON public.encryption_keys FOR ALL USING (public.get_my_role() IN ('super_admin','it_support'));

-- Financial
DROP POLICY IF EXISTS "pay_txn_own" ON public.payment_transactions;
CREATE POLICY "pay_txn_own"         ON public.payment_transactions FOR SELECT USING (student_id=auth.uid());
DROP POLICY IF EXISTS "pay_txn_admin" ON public.payment_transactions;
CREATE POLICY "pay_txn_admin"       ON public.payment_transactions FOR ALL USING (public.get_my_role() IN ('super_admin','admin','financial_auditor'));
DROP POLICY IF EXISTS "inv_sched_admin" ON public.invoice_schedules;
CREATE POLICY "inv_sched_admin"     ON public.invoice_schedules FOR ALL USING (public.get_my_role() IN ('super_admin','admin','financial_auditor'));
DROP POLICY IF EXISTS "scholarship_open" ON public.scholarships;
CREATE POLICY "scholarship_open"    ON public.scholarships FOR SELECT USING (status='open');
DROP POLICY IF EXISTS "scholarship_admin" ON public.scholarships;
CREATE POLICY "scholarship_admin"   ON public.scholarships FOR ALL USING (public.get_my_role() IN ('super_admin','admin','financial_auditor'));
DROP POLICY IF EXISTS "schol_app_own" ON public.scholarship_applications;
CREATE POLICY "schol_app_own"       ON public.scholarship_applications FOR ALL USING (student_id=auth.uid());
DROP POLICY IF EXISTS "schol_app_admin" ON public.scholarship_applications;
CREATE POLICY "schol_app_admin"     ON public.scholarship_applications FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','financial_auditor','academic_advisor'));

-- i18n
DROP POLICY IF EXISTS "translations_public" ON public.translations;
CREATE POLICY "translations_public" ON public.translations FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "translations_admin" ON public.translations;
CREATE POLICY "translations_admin"  ON public.translations FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "trans_req_admin" ON public.translation_requests;
CREATE POLICY "trans_req_admin"     ON public.translation_requests FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "user_prefs_own" ON public.user_preferences;
CREATE POLICY "user_prefs_own"      ON public.user_preferences FOR ALL USING (user_id=auth.uid());

-- AI
DROP POLICY IF EXISTS "ai_pred_own" ON public.ai_predictions;
CREATE POLICY "ai_pred_own"         ON public.ai_predictions FOR SELECT USING (student_id=auth.uid());
DROP POLICY IF EXISTS "ai_pred_advisor" ON public.ai_predictions;
CREATE POLICY "ai_pred_advisor"     ON public.ai_predictions FOR SELECT
  USING (student_id IN (SELECT id FROM public.profiles WHERE advisor_id=auth.uid()));
DROP POLICY IF EXISTS "ai_pred_admin" ON public.ai_predictions;
CREATE POLICY "ai_pred_admin"       ON public.ai_predictions FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "course_rec_own" ON public.course_recommendations;
CREATE POLICY "course_rec_own"      ON public.course_recommendations FOR ALL USING (student_id=auth.uid());
DROP POLICY IF EXISTS "analytics_admin" ON public.analytics_events;
CREATE POLICY "analytics_admin"     ON public.analytics_events FOR ALL USING (public.get_my_role() IN ('super_admin','admin'));

-- Integrations
DROP POLICY IF EXISTS "vclass_enrolled" ON public.virtual_classes;
CREATE POLICY "vclass_enrolled"     ON public.virtual_classes FOR SELECT
  USING (course_id IN (SELECT course_id FROM public.student_course_registrations WHERE student_id=auth.uid()));
DROP POLICY IF EXISTS "vclass_professor" ON public.virtual_classes;
CREATE POLICY "vclass_professor"    ON public.virtual_classes FOR ALL USING (created_by=auth.uid());
DROP POLICY IF EXISTS "vclass_admin" ON public.virtual_classes;
CREATE POLICY "vclass_admin"        ON public.virtual_classes FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "vclass_attend_own" ON public.virtual_class_attendance;
CREATE POLICY "vclass_attend_own"   ON public.virtual_class_attendance FOR ALL USING (student_id=auth.uid());
DROP POLICY IF EXISTS "ministry_admin" ON public.ministry_sync_logs;
CREATE POLICY "ministry_admin"      ON public.ministry_sync_logs FOR ALL USING (public.get_my_role() IN ('super_admin','admin','registrar_officer'));
DROP POLICY IF EXISTS "login_att_admin" ON public.login_attempts;
CREATE POLICY "login_att_admin"     ON public.login_attempts FOR SELECT USING (public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "app_ver_public" ON public.app_versions;
CREATE POLICY "app_ver_public"      ON public.app_versions FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "app_ver_admin" ON public.app_versions;
CREATE POLICY "app_ver_admin"       ON public.app_versions FOR ALL USING (public.get_my_role() IN ('super_admin','admin','it_support'));

-- Storage: private chat media
DROP POLICY IF EXISTS "chat_media_auth_view" ON storage.objects;
CREATE POLICY "chat_media_auth_view"   ON storage.objects FOR SELECT
  USING (bucket_id='chat_media' AND auth.role()='authenticated');
DROP POLICY IF EXISTS "chat_media_auth_upload" ON storage.objects;
CREATE POLICY "chat_media_auth_upload" ON storage.objects FOR INSERT
  WITH CHECK (bucket_id='chat_media' AND auth.role()='authenticated');
DROP POLICY IF EXISTS "chat_media_own_delete" ON storage.objects;
CREATE POLICY "chat_media_own_delete"  ON storage.objects FOR DELETE
  USING (bucket_id='chat_media' AND auth.uid()=owner);


-- ════════════════════════════════════════════════════════════════════════════════════
-- ╔══════════════════════════════════════════════════════════════════════════════════╗
-- ║                                                                                  ║
-- ║   ██████╗ ████████╗    ████████╗███████╗ ██████╗██╗  ██╗                        ║
-- ║  ██╔════╝ ╚══██╔══╝       ██╔══╝██╔════╝██╔════╝██║  ██║                        ║
-- ║  ██║  ███╗   ██║          ██║   █████╗  ██║     ███████║                        ║
-- ║  ██║   ██║   ██║          ██║   ██╔══╝  ██║     ██╔══██║                        ║
-- ║  ╚██████╔╝   ██║          ██║   ███████╗╚██████╗██║  ██║                        ║
-- ║   ╚═════╝    ╚═╝          ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝                        ║
-- ║                                                                                  ║
-- ║  ─────────────────────────────────────────────────────────────────────────      ║
-- ║  SCHEMA MANIFEST — University Management System (UMS)                            ║
-- ║  ─────────────────────────────────────────────────────────────────────────      ║
-- ║  01_reset.sql                   Complete schema tear-down                        ║
-- ║  02_foundation.sql              Extensions · ENUMs · Core identity tables        ║
-- ║  03_tables.sql                  Academic · Social · Admin domain tables          ║
-- ║  04_functions_triggers_rls.sql  Business logic · Auth triggers · Core RLS        ║
-- ║  05_seed.sql                    10 Colleges · 55+ Departments                    ║
-- ║  06_enhancements.sql  ◄ HERE    Advanced feature layer (200k+ scale)             ║
-- ║                                                                                  ║
-- ║  ─────────────────────────────────────────────────────────────────────────      ║
-- ║  WHAT'S IN THIS FILE                                                             ║
-- ║  ─────────────────────────────────────────────────────────────────────────      ║
-- ║  ✦  Real-Time Chat & Messaging       Partitioned · reactions · reactions         ║
-- ║  ✦  Online Exam Engine               Anti-cheat · AI similarity · difficulty     ║
-- ║  ✦  Digital Library                  FTS (ar+en) · borrow · reserve · history    ║
-- ║  ✦  Cumulative GPA Tracking          Auto-trigger · standing alerts · transcript  ║
-- ║  ✦  Multi-Channel Notifications      In-App · Email · SMS · Push                 ║
-- ║  ✦  Column-Level DB Encryption       pgcrypto · SECURITY DEFINER functions       ║
-- ║  ✦  Full Financial System            Paymob/Stripe · auto-invoices · 2 MVs       ║
-- ║  ✦  Scholarships & Financial Aid     Apply · review · award workflow             ║
-- ║  ✦  i18n + Auto-Translation Queue    ar/en/fr/de/zh · RTL/LTR · OpenAI/DeepL    ║
-- ║  ✦  AI Analytics & Predictions       Dropout risk · grade forecast · recs        ║
-- ║  ✦  Zoom / Google Meet               Virtual classes · live attendance           ║
-- ║  ✦  Ministry of Education API Sync   Partitioned log · retry logic              ║
-- ║  ✦  Mobile App Support               iOS/Androi
-- ║  © 2025 GT Company 