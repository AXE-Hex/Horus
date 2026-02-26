-- ---------------------------------------------------------------------------
-- 🚀 Developed by the GT-AXE Team
-- 👤 Signature: Axe
-- ---------------------------------------------------------------------------

CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "moddatetime";

DO $$ BEGIN
  CREATE TYPE user_role AS ENUM (

    'super_admin', 'admin', 'it_support', 'financial_auditor',

    'rector', 'dean', 'department_head', 'academic_coordinator',

    'professor', 'lecturer', 'teaching_assistant',

    'registrar_officer', 'academic_advisor', 'librarian',

    'freshman', 'regular_student', 'student', 'class_representative', 'alumni',

    'dorm_supervisor', 'security_officer', 'guest',
    
    'parent', 'recruiter'
  );
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE announcement_priority AS ENUM ('normal', 'important', 'urgent');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE enrollment_status AS ENUM ('pending', 'approved', 'rejected', 'withdrawn');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'overdue', 'refunded');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE attendance_status AS ENUM ('present', 'absent', 'late', 'excused');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE notification_type AS ENUM ('info', 'warning', 'success', 'error');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE file_type AS ENUM ('pdf', 'docx', 'pptx', 'xlsx', 'image', 'video', 'other');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE day_of_week AS ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE session_device AS ENUM ('mobile', 'desktop', 'tablet', 'unknown');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE forum_category AS ENUM ('general', 'academic', 'social', 'feedback');
EXCEPTION WHEN duplicate_object THEN null; END $$;

DO $$ BEGIN
  CREATE TYPE support_ticket_status AS ENUM ('open', 'in_progress', 'resolved', 'closed');
EXCEPTION WHEN duplicate_object THEN null; END $$;

CREATE TABLE IF NOT EXISTS profiles (
  id            UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email         TEXT NOT NULL UNIQUE,
  full_name     TEXT NOT NULL,
  full_name_ar  TEXT,
  avatar_url    TEXT,
  role          user_role NOT NULL DEFAULT 'student',
  student_id    TEXT UNIQUE,
  phone         TEXT,
  bio           TEXT,
  bio_ar        TEXT,
  warning_level INT NOT NULL DEFAULT 0,
  is_verified   BOOLEAN NOT NULL DEFAULT FALSE,
  tags          TEXT[] NOT NULL DEFAULT '{}',
  is_banned     BOOLEAN NOT NULL DEFAULT FALSE,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

DROP TRIGGER IF EXISTS profiles_updated_at ON profiles;
CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN

  BEGIN

    IF NOT EXISTS (SELECT 1 FROM public.profiles WHERE email = NEW.email) THEN
      INSERT INTO public.profiles (id, email, full_name, role)
      VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
        COALESCE((NEW.raw_user_meta_data->>'role')::user_role, 'student'::user_role)
      )
      ON CONFLICT (id) DO NOTHING;
    END IF;
  EXCEPTION WHEN OTHERS THEN

    RETURN NEW;
  END;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

DO $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role)
  SELECT 
    id, 
    email, 
    COALESCE(raw_user_meta_data->>'full_name', email),
    COALESCE((raw_user_meta_data->>'role')::user_role, 'student'::user_role)
  FROM auth.users
  WHERE id NOT IN (SELECT id FROM public.profiles)
    AND email NOT IN (SELECT email FROM public.profiles)
  ON CONFLICT (id) DO NOTHING;
END $$;

CREATE TABLE IF NOT EXISTS colleges (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  name_ar       TEXT NOT NULL,
  code          TEXT NOT NULL UNIQUE,
  description   TEXT,
  description_ar TEXT,
  dean_id       UUID REFERENCES profiles(id),
  image_url     TEXT,
  established   INT,
  student_count INT DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE colleges ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS colleges_updated_at ON colleges;
CREATE TRIGGER colleges_updated_at
  BEFORE UPDATE ON colleges
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS departments (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id    UUID NOT NULL REFERENCES colleges(id) ON DELETE CASCADE,
  name          TEXT NOT NULL,
  name_ar       TEXT NOT NULL,
  code          TEXT NOT NULL UNIQUE,
  hod_id        UUID REFERENCES profiles(id),
  description   TEXT,
  description_ar TEXT,
  office_symbol TEXT,
  floor         INT,
  building      TEXT,
  student_count INT DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE departments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS departments_updated_at ON departments;
CREATE TRIGGER departments_updated_at
  BEFORE UPDATE ON departments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS courses (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id   UUID NOT NULL REFERENCES departments(id) ON DELETE CASCADE,
  code            TEXT NOT NULL UNIQUE,
  name            TEXT NOT NULL,
  name_ar         TEXT NOT NULL,
  description     TEXT,
  credit_hours    INT NOT NULL DEFAULT 3,
  semester        TEXT,
  professor_id    UUID REFERENCES profiles(id),
  max_students    INT DEFAULT 50,
  is_active       BOOLEAN NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE courses ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS courses_updated_at ON courses;
CREATE TRIGGER courses_updated_at
  BEFORE UPDATE ON courses
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS professor_details (
  id                UUID PRIMARY KEY REFERENCES profiles(id) ON DELETE CASCADE,
  department_id     UUID REFERENCES departments(id),
  office_symbol     TEXT,
  general_rating    NUMERIC(3,2) DEFAULT 0,
  curriculum_rating NUMERIC(3,2) DEFAULT 0,
  total_ratings     INT DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE professor_details ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS professor_details_updated_at ON professor_details;
CREATE TRIGGER professor_details_updated_at
  BEFORE UPDATE ON professor_details
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS teaching_assistants (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  professor_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  ta_role       TEXT DEFAULT 'Lab Assistant',
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(profile_id, professor_id)
);

ALTER TABLE teaching_assistants ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS enrollments (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  status        enrollment_status NOT NULL DEFAULT 'pending',
  semester      TEXT NOT NULL,
  enrolled_at   TIMESTAMPTZ DEFAULT now(),
  approved_at   TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);

ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS enrollments_updated_at ON enrollments;
CREATE TRIGGER enrollments_updated_at
  BEFORE UPDATE ON enrollments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS course_sections (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id    UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  semester     TEXT NOT NULL,
  max_students INT DEFAULT 50,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE course_sections ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS course_sub_sections (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  section_id   UUID NOT NULL REFERENCES course_sections(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  max_students INT DEFAULT 25,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE course_sub_sections ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS student_registrations (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  semester         TEXT NOT NULL,
  section_name     TEXT NOT NULL,
  sub_section_name TEXT NOT NULL,
  registered_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE(student_id, semester)
);

ALTER TABLE student_registrations ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS grades (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  semester      TEXT NOT NULL,
  midterm       NUMERIC(5,2),
  final_exam    NUMERIC(5,2),
  coursework    NUMERIC(5,2),
  practical     NUMERIC(5,2),
  total         NUMERIC(5,2),
  grade_letter  TEXT,
  gpa_points    NUMERIC(3,2),
  is_published  BOOLEAN NOT NULL DEFAULT FALSE,
  published_at  TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);

ALTER TABLE grades ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION calculate_grade_metrics()
RETURNS TRIGGER AS $$
BEGIN

  NEW.total := COALESCE(NEW.midterm, 0) + 
               COALESCE(NEW.final_exam, 0) + 
               COALESCE(NEW.coursework, 0) + 
               COALESCE(NEW.practical, 0);

  IF NEW.total >= 95 THEN
    NEW.grade_letter := 'A+'; NEW.gpa_points := 4.00;
  ELSIF NEW.total >= 90 THEN
    NEW.grade_letter := 'A';  NEW.gpa_points := 3.75;
  ELSIF NEW.total >= 85 THEN
    NEW.grade_letter := 'B+'; NEW.gpa_points := 3.50;
  ELSIF NEW.total >= 80 THEN
    NEW.grade_letter := 'B';  NEW.gpa_points := 3.00;
  ELSIF NEW.total >= 75 THEN
    NEW.grade_letter := 'C+'; NEW.gpa_points := 2.50;
  ELSIF NEW.total >= 70 THEN
    NEW.grade_letter := 'C';  NEW.gpa_points := 2.00;
  ELSIF NEW.total >= 65 THEN
    NEW.grade_letter := 'D+'; NEW.gpa_points := 1.50;
  ELSIF NEW.total >= 60 THEN
    NEW.grade_letter := 'D';  NEW.gpa_points := 1.00;
  ELSE
    NEW.grade_letter := 'F';  NEW.gpa_points := 0.00;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS grades_metrics_trigger ON grades;
CREATE TRIGGER grades_metrics_trigger
  BEFORE INSERT OR UPDATE OF midterm, final_exam, coursework, practical
  ON grades
  FOR EACH ROW
  EXECUTE FUNCTION calculate_grade_metrics();

DROP TRIGGER IF EXISTS grades_updated_at ON grades;
CREATE TRIGGER grades_updated_at
  BEFORE UPDATE ON grades
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS schedules (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  day           day_of_week NOT NULL,
  start_time    TIME NOT NULL,
  end_time      TIME NOT NULL,
  CONSTRAINT check_time_range CHECK (start_time < end_time),
  room          TEXT,
  building      TEXT,
  schedule_type TEXT DEFAULT 'lecture',
  semester      TEXT NOT NULL,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE schedules ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS exam_schedules (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  exam_type     TEXT NOT NULL DEFAULT 'final',
  exam_date     DATE NOT NULL,
  start_time    TIME NOT NULL,
  end_time      TIME NOT NULL,
  CONSTRAINT check_exam_time_range CHECK (start_time < end_time),
  room          TEXT,
  building      TEXT,
  semester      TEXT NOT NULL,
  notes         TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE exam_schedules ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS attendance (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  date          DATE NOT NULL,
  status        attendance_status NOT NULL DEFAULT 'present',
  notes         TEXT,
  recorded_by   UUID REFERENCES profiles(id),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, date)
);

ALTER TABLE attendance ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS office_hours (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  day           day_of_week NOT NULL,
  start_time    TIME NOT NULL,
  end_time      TIME NOT NULL,
  CONSTRAINT check_office_time_range CHECK (start_time < end_time),
  location      TEXT NOT NULL,
  is_walk_in    BOOLEAN NOT NULL DEFAULT FALSE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE office_hours ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS student_groups (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id  UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID REFERENCES courses(id),
  name          TEXT NOT NULL,
  name_ar       TEXT,
  description   TEXT,
  max_students  INT DEFAULT 50,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE student_groups ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS student_groups_updated_at ON student_groups;
CREATE TRIGGER student_groups_updated_at
  BEFORE UPDATE ON student_groups
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);
CREATE TABLE IF NOT EXISTS group_members (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id      UUID NOT NULL REFERENCES student_groups(id) ON DELETE CASCADE,
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  joined_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(group_id, student_id)
);

ALTER TABLE group_members ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS announcements (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID REFERENCES courses(id),
  title         TEXT NOT NULL,
  title_ar      TEXT,
  content       TEXT NOT NULL,
  content_ar    TEXT,
  priority      announcement_priority NOT NULL DEFAULT 'normal',
  is_pinned     BOOLEAN NOT NULL DEFAULT FALSE,
  published_at  TIMESTAMPTZ DEFAULT now(),
  expires_at    TIMESTAMPTZ,
  CONSTRAINT check_announcement_dates CHECK (expires_at IS NULL OR expires_at > published_at),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS announcements_updated_at ON announcements;
CREATE TRIGGER announcements_updated_at
  BEFORE UPDATE ON announcements
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS shared_files (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_id   UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID REFERENCES courses(id),
  title         TEXT NOT NULL,
  title_ar      TEXT,
  file_path     TEXT NOT NULL,
  file_type     file_type NOT NULL DEFAULT 'other',
  file_size     BIGINT,
  download_count INT DEFAULT 0,
  is_public     BOOLEAN DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

ALTER TABLE shared_files ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS forums (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  name_ar       TEXT,
  description   TEXT,
  category      forum_category NOT NULL DEFAULT 'general',
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE forums ENABLE ROW LEVEL SECURITY;
CREATE TABLE IF NOT EXISTS forum_posts (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  forum_id      UUID NOT NULL REFERENCES forums(id) ON DELETE CASCADE,
  author_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  content       TEXT NOT NULL,
  is_pinned     BOOLEAN DEFAULT FALSE,
  reply_count   INT DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);

ALTER TABLE forum_posts ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS forum_posts_updated_at ON forum_posts;
CREATE TRIGGER forum_posts_updated_at
  BEFORE UPDATE ON forum_posts
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS support_tickets (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  subject       TEXT NOT NULL,
  description   TEXT NOT NULL,
  category      TEXT DEFAULT 'general',
  status        support_ticket_status NOT NULL DEFAULT 'open',
  assigned_to   UUID REFERENCES profiles(id),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at   TIMESTAMPTZ
);

ALTER TABLE support_tickets ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS support_tickets_updated_at ON support_tickets;
CREATE TRIGGER support_tickets_updated_at
  BEFORE UPDATE ON support_tickets
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS professor_ratings (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  student_id      UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  general_score   INT NOT NULL CHECK (general_score BETWEEN 1 AND 5),
  curriculum_score INT NOT NULL CHECK (curriculum_score BETWEEN 1 AND 5),
  comment         TEXT,
  is_anonymous    BOOLEAN DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(professor_id, student_id)
);

ALTER TABLE professor_ratings ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS invoices (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  semester      TEXT NOT NULL,
  description   TEXT NOT NULL,
  description_ar TEXT,
  amount        NUMERIC(10,2) NOT NULL,
  currency      TEXT NOT NULL DEFAULT 'EGP',
  status        payment_status NOT NULL DEFAULT 'pending',
  due_date      DATE,
  CONSTRAINT check_invoice_due_date CHECK (due_date IS NULL OR due_date >= (created_at::DATE)),
  paid_at       TIMESTAMPTZ,
  receipt_url   TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS invoices_updated_at ON invoices;
CREATE TRIGGER invoices_updated_at
  BEFORE UPDATE ON invoices
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE TABLE IF NOT EXISTS notifications (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  title         TEXT NOT NULL,
  title_ar      TEXT,
  message       TEXT NOT NULL,
  message_ar    TEXT,
  type          notification_type NOT NULL DEFAULT 'info',
  is_read       BOOLEAN NOT NULL DEFAULT FALSE,
  action_url    TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  read_at       TIMESTAMPTZ
);

ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS user_sessions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  device_name   TEXT,
  device_type   session_device DEFAULT 'unknown',
  ip_address    INET,
  location      TEXT,
  user_agent    TEXT,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  last_active   TIMESTAMPTZ DEFAULT now(),
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE user_sessions ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS action_plan_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id     UUID REFERENCES courses(id),
  semester      TEXT NOT NULL,
  year          INT NOT NULL,
  status        TEXT DEFAULT 'planned',
  grade_letter  TEXT,
  notes         TEXT,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE action_plan_items ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS action_plan_items_updated_at ON action_plan_items;
CREATE TRIGGER action_plan_items_updated_at
  BEFORE UPDATE ON action_plan_items
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

CREATE INDEX IF NOT EXISTS idx_enrollments_student ON enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course ON enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_grades_student ON grades(student_id);
CREATE INDEX IF NOT EXISTS idx_grades_course ON grades(course_id);
CREATE INDEX IF NOT EXISTS idx_attendance_student ON attendance(student_id);
CREATE INDEX IF NOT EXISTS idx_attendance_course ON attendance(course_id);
CREATE INDEX IF NOT EXISTS idx_schedules_course ON schedules(course_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id, is_read);
CREATE INDEX IF NOT EXISTS idx_announcements_course ON announcements(course_id);
CREATE INDEX IF NOT EXISTS idx_invoices_student ON invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_forum ON forum_posts(forum_id);
CREATE INDEX IF NOT EXISTS idx_shared_files_course ON shared_files(course_id);
CREATE INDEX IF NOT EXISTS idx_action_plan_student ON action_plan_items(student_id);

DROP POLICY IF EXISTS "Users can view all active profiles" ON profiles;
CREATE POLICY "Users can view all active profiles" ON profiles FOR SELECT USING (deleted_at IS NULL OR (auth.jwt() ->> 'role' = 'authenticated' AND (public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor'))));
DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id OR (public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor')));
DROP POLICY IF EXISTS "Admins can manage profiles" ON profiles;
CREATE POLICY "Admins can manage profiles" ON profiles FOR ALL USING (public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor'));

DROP POLICY IF EXISTS "Anyone can view colleges" ON colleges;
CREATE POLICY "Anyone can view colleges" ON colleges FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Anyone can view departments" ON departments;
CREATE POLICY "Anyone can view departments" ON departments FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Anyone can view active courses" ON courses;
CREATE POLICY "Anyone can view active courses" ON courses FOR SELECT USING (is_active = TRUE);

DROP POLICY IF EXISTS "Anyone can view professor details" ON professor_details;
CREATE POLICY "Anyone can view professor details" ON professor_details FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Anyone can view TAs" ON teaching_assistants;
CREATE POLICY "Anyone can view TAs" ON teaching_assistants FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Students can view own enrollments" ON enrollments;
CREATE POLICY "Students can view own enrollments" ON enrollments FOR SELECT USING (auth.uid() = student_id);
DROP POLICY IF EXISTS "Admins can manage enrollments" ON enrollments;
CREATE POLICY "Admins can manage enrollments" ON enrollments FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin', 'it_support', 'financial_auditor')));

DROP POLICY IF EXISTS "Anyone can view sections" ON course_sections;
CREATE POLICY "Anyone can view sections" ON course_sections FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Anyone can view sub_sections" ON course_sub_sections;
CREATE POLICY "Anyone can view sub_sections" ON course_sub_sections FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Students can view own registrations" ON student_registrations;
CREATE POLICY "Students can view own registrations" ON student_registrations FOR SELECT USING (auth.uid() = student_id);
DROP POLICY IF EXISTS "Students can insert own registrations" ON student_registrations;
CREATE POLICY "Students can insert own registrations" ON student_registrations FOR INSERT WITH CHECK (auth.uid() = student_id);
DROP POLICY IF EXISTS "Admins can manage registrations" ON student_registrations;
CREATE POLICY "Admins can manage registrations" ON student_registrations FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin', 'it_support', 'financial_auditor')));

DROP POLICY IF EXISTS "Students can view own grades" ON grades;
CREATE POLICY "Students can view own grades" ON grades FOR SELECT USING (auth.uid() = student_id AND is_published = TRUE);
DROP POLICY IF EXISTS "Professors can manage grades" ON grades;
CREATE POLICY "Professors can manage grades" ON grades FOR ALL USING (EXISTS (SELECT 1 FROM courses c WHERE c.id = grades.course_id AND c.professor_id = auth.uid()));

DROP POLICY IF EXISTS "Anyone can view schedules" ON schedules;
CREATE POLICY "Anyone can view schedules" ON schedules FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Anyone can view exam schedules" ON exam_schedules;
CREATE POLICY "Anyone can view exam schedules" ON exam_schedules FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Students can view own attendance" ON attendance;
CREATE POLICY "Students can view own attendance" ON attendance FOR SELECT USING (auth.uid() = student_id);

DROP POLICY IF EXISTS "Anyone can view office hours" ON office_hours;
CREATE POLICY "Anyone can view office hours" ON office_hours FOR SELECT USING (TRUE);

DROP POLICY IF EXISTS "Anyone can view active groups" ON student_groups;
CREATE POLICY "Anyone can view active groups" ON student_groups FOR SELECT USING (is_active = TRUE);
DROP POLICY IF EXISTS "Group members can view their groups" ON group_members;
CREATE POLICY "Group members can view their groups" ON group_members FOR SELECT USING (auth.uid() = student_id);

DROP POLICY IF EXISTS "Anyone can view active announcements" ON announcements;
CREATE POLICY "Anyone can view active announcements" ON announcements FOR SELECT USING (deleted_at IS NULL);

DROP POLICY IF EXISTS "Anyone can view public files" ON shared_files;
CREATE POLICY "Anyone can view public files" ON shared_files FOR SELECT USING (is_public = TRUE AND deleted_at IS NULL);

DROP POLICY IF EXISTS "Anyone can view forums" ON forums;
CREATE POLICY "Anyone can view forums" ON forums FOR SELECT USING (is_active = TRUE);
DROP POLICY IF EXISTS "Anyone can view posts" ON forum_posts;
CREATE POLICY "Anyone can view posts" ON forum_posts FOR SELECT USING (deleted_at IS NULL);

DROP POLICY IF EXISTS "Users can view own tickets" ON support_tickets;
CREATE POLICY "Users can view own tickets" ON support_tickets FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Anyone can view ratings" ON professor_ratings;
CREATE POLICY "Anyone can view ratings" ON professor_ratings FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Students can rate professors" ON professor_ratings;
CREATE POLICY "Students can rate professors" ON professor_ratings FOR INSERT WITH CHECK (auth.uid() = student_id);

DROP POLICY IF EXISTS "Students can view own invoices" ON invoices;
CREATE POLICY "Students can view own invoices" ON invoices FOR SELECT USING (auth.uid() = student_id);

DROP POLICY IF EXISTS "Users can view own notifications" ON notifications;
CREATE POLICY "Users can view own notifications" ON notifications FOR SELECT USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "Users can update own notifications" ON notifications;
CREATE POLICY "Users can update own notifications" ON notifications FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can view own sessions" ON user_sessions;
CREATE POLICY "Users can view own sessions" ON user_sessions FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Students can view own action plan" ON action_plan_items;
CREATE POLICY "Students can view own action plan" ON action_plan_items FOR SELECT USING (auth.uid() = student_id);

GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon, authenticated;

DELETE FROM public.profiles WHERE email = 'admin@horus.edu.eg' AND id NOT IN (SELECT id FROM auth.users WHERE email = 'admin@horus.edu.eg');

INSERT INTO auth.users (
  id,
  aud,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  role,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
)
SELECT
  gen_random_uuid(),
  'authenticated',
  'admin@horus.edu.eg',
  crypt('admin123', gen_salt('bf')),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{"full_name":"Super Admin", "role":"super_admin"}',
  now(),
  now(),
  'authenticated',
  '',
  '',
  '',
  ''
WHERE NOT EXISTS (
  SELECT 1 FROM auth.users WHERE email = 'admin@horus.edu.eg'
);
