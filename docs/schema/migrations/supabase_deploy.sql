CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "moddatetime";

DO $$ BEGIN CREATE TYPE user_role AS ENUM (
  'super_admin','admin','it_support','financial_auditor',
  'rector','dean','department_head','assistant_hod','academic_coordinator',
  'professor','lecturer','teaching_assistant',
  'registrar_officer','academic_advisor','librarian',
  'freshman','regular_student','student','class_representative','alumni',
  'dorm_supervisor','security_officer','guest','parent','recruiter'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE announcement_priority AS ENUM ('normal','important','urgent');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE enrollment_status AS ENUM ('pending','approved','rejected','withdrawn','cancelled');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE payment_status AS ENUM ('pending','paid','overdue','refunded');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE attendance_status AS ENUM ('present','absent','late','excused');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE notification_type AS ENUM ('info','warning','success','error');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE file_type AS ENUM ('pdf','docx','pptx','xlsx','image','video','other');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE day_of_week AS ENUM ('monday','tuesday','wednesday','thursday','friday','saturday','sunday');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE session_device AS ENUM ('mobile','desktop','tablet','unknown');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE forum_category AS ENUM ('general','academic','social','feedback');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE support_ticket_status AS ENUM ('open','in_progress','resolved','closed');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN CREATE TYPE audit_action AS ENUM (
  'create','update','delete','login','logout',
  'toggle_status','role_change','password_reset','view'
); EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- profiles
CREATE TABLE IF NOT EXISTS public.profiles (
  id            UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email         TEXT NOT NULL UNIQUE,
  full_name     TEXT NOT NULL,
  full_name_ar  TEXT,
  avatar_url    TEXT,
  roles         user_role[] NOT NULL DEFAULT '{student}',
  student_id    TEXT UNIQUE,
  national_id   TEXT UNIQUE,
  nationality   TEXT,
  phone         TEXT,
  bio           TEXT,
  bio_ar        TEXT,
  college_id    UUID,
  department_id UUID,
  advisor_id    UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  warning_level INT     NOT NULL DEFAULT 0,
  is_verified   BOOLEAN NOT NULL DEFAULT FALSE,
  tags          TEXT[]  NOT NULL DEFAULT '{}',
  is_banned     BOOLEAN NOT NULL DEFAULT FALSE,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at    TIMESTAMPTZ
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS profiles_updated_at ON public.profiles;
CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- colleges
CREATE TABLE IF NOT EXISTS public.colleges (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name           TEXT NOT NULL,
  name_en        TEXT,
  name_ar        TEXT NOT NULL,
  code           TEXT NOT NULL UNIQUE,
  description    TEXT,
  description_ar TEXT,
  dean_id        UUID REFERENCES public.profiles(id),
  image_url      TEXT,
  established    INT,
  student_count  INT DEFAULT 0,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.colleges ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS colleges_updated_at ON public.colleges;
CREATE TRIGGER colleges_updated_at
  BEFORE UPDATE ON public.colleges
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- departments
CREATE TABLE IF NOT EXISTS public.departments (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id       UUID NOT NULL REFERENCES public.colleges(id) ON DELETE CASCADE,
  name             TEXT NOT NULL,
  name_en          TEXT,
  name_ar          TEXT NOT NULL,
  code             TEXT NOT NULL UNIQUE,
  hod_id           UUID REFERENCES public.profiles(id),
  assistant_hod_id UUID REFERENCES public.profiles(id),
  description      TEXT,
  description_ar   TEXT,
  office_symbol    TEXT,
  floor            INT,
  building         TEXT,
  student_count    INT DEFAULT 0,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS departments_updated_at ON public.departments;
CREATE TRIGGER departments_updated_at
  BEFORE UPDATE ON public.departments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name='profiles' AND constraint_name='profiles_college_id_fkey') THEN
    ALTER TABLE public.profiles ADD CONSTRAINT profiles_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(id);
  END IF;
  IF NOT EXISTS (SELECT 1 FROM information_schema.table_constraints WHERE table_name='profiles' AND constraint_name='profiles_department_id_fkey') THEN
    ALTER TABLE public.profiles ADD CONSTRAINT profiles_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);
  END IF;
END $$;

-- courses
CREATE TABLE IF NOT EXISTS public.courses (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id UUID NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  code          TEXT NOT NULL UNIQUE,
  name          TEXT NOT NULL,
  name_en       TEXT,
  name_ar       TEXT NOT NULL,
  description   TEXT,
  credit_hours  INT NOT NULL DEFAULT 3,
  semester      TEXT,
  professor_id  UUID REFERENCES public.profiles(id),
  max_students  INT DEFAULT 50,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS courses_updated_at ON public.courses;
CREATE TRIGGER courses_updated_at
  BEFORE UPDATE ON public.courses
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- department_projects
CREATE TABLE IF NOT EXISTS public.department_projects (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id  UUID NOT NULL REFERENCES public.departments(id) ON DELETE CASCADE,
  title_en       TEXT NOT NULL,
  title_ar       TEXT NOT NULL,
  description_en TEXT,
  description_ar TEXT,
  status         TEXT NOT NULL DEFAULT 'active',
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.department_projects ENABLE ROW LEVEL SECURITY;

-- professor_details
CREATE TABLE IF NOT EXISTS public.professor_details (
  id                UUID PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  department_id     UUID REFERENCES public.departments(id),
  office_symbol     TEXT,
  general_rating    NUMERIC(3,2) DEFAULT 0,
  curriculum_rating NUMERIC(3,2) DEFAULT 0,
  total_ratings     INT DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.professor_details ENABLE ROW LEVEL SECURITY;

-- teaching_assistants
CREATE TABLE IF NOT EXISTS public.teaching_assistants (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  profile_id   UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  professor_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  ta_role      TEXT DEFAULT 'Lab Assistant',
  is_active    BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(profile_id, professor_id)
);
ALTER TABLE public.teaching_assistants ENABLE ROW LEVEL SECURITY;

-- course_sections
CREATE TABLE IF NOT EXISTS public.course_sections (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id    UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  semester     TEXT NOT NULL,
  max_students INT DEFAULT 50,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sections ENABLE ROW LEVEL SECURITY;

-- course_sub_sections
CREATE TABLE IF NOT EXISTS public.course_sub_sections (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  section_id   UUID NOT NULL REFERENCES public.course_sections(id) ON DELETE CASCADE,
  name         TEXT NOT NULL,
  max_students INT DEFAULT 25,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.course_sub_sections ENABLE ROW LEVEL SECURITY;

-- student_registrations
CREATE TABLE IF NOT EXISTS public.student_registrations (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester         TEXT NOT NULL,
  section_name     TEXT NOT NULL,
  sub_section_name TEXT NOT NULL,
  registered_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE(student_id, semester)
);
ALTER TABLE public.student_registrations ENABLE ROW LEVEL SECURITY;

-- student_course_registrations
CREATE TABLE IF NOT EXISTS public.student_course_registrations (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id        UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester         TEXT NOT NULL,
  section_name     TEXT,
  sub_section_name TEXT,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);
ALTER TABLE public.student_course_registrations ENABLE ROW LEVEL SECURITY;

-- registration_requests
CREATE TABLE IF NOT EXISTS public.registration_requests (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id    UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  advisor_id    UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  semester      TEXT NOT NULL,
  status        enrollment_status NOT NULL DEFAULT 'pending',
  advisor_notes TEXT,
  submitted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at   TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, semester)
);
ALTER TABLE public.registration_requests ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS registration_requests_updated_at ON public.registration_requests;
CREATE TRIGGER registration_requests_updated_at
  BEFORE UPDATE ON public.registration_requests
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- registration_request_courses
CREATE TABLE IF NOT EXISTS public.registration_request_courses (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id       UUID NOT NULL REFERENCES public.registration_requests(id) ON DELETE CASCADE,
  course_id        UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  section_name     TEXT,
  sub_section_name TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.registration_request_courses ENABLE ROW LEVEL SECURITY;

-- enrollments
CREATE TABLE IF NOT EXISTS public.enrollments (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id   UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  status      enrollment_status NOT NULL DEFAULT 'pending',
  semester    TEXT NOT NULL,
  enrolled_at TIMESTAMPTZ DEFAULT now(),
  approved_at TIMESTAMPTZ,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);
ALTER TABLE public.enrollments ENABLE ROW LEVEL SECURITY;

-- grades
CREATE TABLE IF NOT EXISTS public.grades (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  semester     TEXT NOT NULL,
  midterm      NUMERIC(5,2),
  final_exam   NUMERIC(5,2),
  coursework   NUMERIC(5,2),
  practical    NUMERIC(5,2),
  total        NUMERIC(5,2),
  grade_letter TEXT,
  gpa_points   NUMERIC(3,2),
  is_published BOOLEAN NOT NULL DEFAULT FALSE,
  published_at TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);
ALTER TABLE public.grades ENABLE ROW LEVEL SECURITY;
DROP TRIGGER IF EXISTS grades_updated_at ON public.grades;
CREATE TRIGGER grades_updated_at
  BEFORE UPDATE ON public.grades
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- schedules
CREATE TABLE IF NOT EXISTS public.schedules (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id        UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  day              day_of_week NOT NULL,
  start_time       TIME NOT NULL,
  end_time         TIME NOT NULL,
  CONSTRAINT check_time_range CHECK (start_time < end_time),
  room             TEXT,
  building         TEXT,
  schedule_type    TEXT DEFAULT 'lecture',
  section_name     TEXT,
  sub_section_name TEXT,
  semester         TEXT NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.schedules ENABLE ROW LEVEL SECURITY;

-- exam_schedules
CREATE TABLE IF NOT EXISTS public.exam_schedules (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id  UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  exam_type  TEXT NOT NULL DEFAULT 'final',
  exam_date  DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time   TIME NOT NULL,
  CONSTRAINT check_exam_time_range CHECK (start_time < end_time),
  room       TEXT,
  building   TEXT,
  semester   TEXT NOT NULL,
  notes      TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.exam_schedules ENABLE ROW LEVEL SECURITY;

-- attendance
CREATE TABLE IF NOT EXISTS public.attendance (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id  UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id   UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
  date        DATE NOT NULL,
  status      attendance_status NOT NULL DEFAULT 'present',
  notes       TEXT,
  recorded_by UUID REFERENCES public.profiles(id),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, date)
);
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;

-- office_hours
CREATE TABLE IF NOT EXISTS public.office_hours (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  day          day_of_week NOT NULL,
  start_time   TIME NOT NULL,
  end_time     TIME NOT NULL,
  CONSTRAINT check_office_time_range CHECK (start_time < end_time),
  location     TEXT NOT NULL,
  is_walk_in   BOOLEAN NOT NULL DEFAULT FALSE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.office_hours ENABLE ROW LEVEL SECURITY;

-- student_groups
CREATE TABLE IF NOT EXISTS public.student_groups (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID REFERENCES public.courses(id),
  name         TEXT NOT NULL,
  name_ar      TEXT,
  description  TEXT,
  max_students INT DEFAULT 50,
  is_active    BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.student_groups ENABLE ROW LEVEL SECURITY;

-- group_members
CREATE TABLE IF NOT EXISTS public.group_members (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id   UUID NOT NULL REFERENCES public.student_groups(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(group_id, student_id)
);
ALTER TABLE public.group_members ENABLE ROW LEVEL SECURITY;

-- announcements
CREATE TABLE IF NOT EXISTS public.announcements (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id    UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID REFERENCES public.courses(id),
  title        TEXT NOT NULL,
  title_ar     TEXT,
  content      TEXT NOT NULL,
  content_ar   TEXT,
  priority     announcement_priority NOT NULL DEFAULT 'normal',
  is_pinned    BOOLEAN NOT NULL DEFAULT FALSE,
  published_at TIMESTAMPTZ DEFAULT now(),
  expires_at   TIMESTAMPTZ,
  CONSTRAINT check_announcement_dates CHECK (expires_at IS NULL OR expires_at > published_at),
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ
);
ALTER TABLE public.announcements ENABLE ROW LEVEL SECURITY;

-- shared_files
CREATE TABLE IF NOT EXISTS public.shared_files (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_id    UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id      UUID REFERENCES public.courses(id),
  title          TEXT NOT NULL,
  title_ar       TEXT,
  file_path      TEXT NOT NULL,
  file_type      file_type NOT NULL DEFAULT 'other',
  file_size      BIGINT,
  download_count INT DEFAULT 0,
  is_public      BOOLEAN DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);
ALTER TABLE public.shared_files ENABLE ROW LEVEL SECURITY;

-- forums
CREATE TABLE IF NOT EXISTS public.forums (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  name_ar     TEXT,
  description TEXT,
  category    forum_category NOT NULL DEFAULT 'general',
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.forums ENABLE ROW LEVEL SECURITY;

-- forum_posts
CREATE TABLE IF NOT EXISTS public.forum_posts (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  forum_id    UUID NOT NULL REFERENCES public.forums(id) ON DELETE CASCADE,
  author_id   UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT NOT NULL,
  content     TEXT NOT NULL,
  is_pinned   BOOLEAN DEFAULT FALSE,
  reply_count INT DEFAULT 0,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);
ALTER TABLE public.forum_posts ENABLE ROW LEVEL SECURITY;

-- support_tickets
CREATE TABLE IF NOT EXISTS public.support_tickets (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  subject     TEXT NOT NULL,
  description TEXT NOT NULL,
  category    TEXT DEFAULT 'general',
  status      support_ticket_status NOT NULL DEFAULT 'open',
  assigned_to UUID REFERENCES public.profiles(id),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ
);
ALTER TABLE public.support_tickets ENABLE ROW LEVEL SECURITY;

-- professor_ratings
CREATE TABLE IF NOT EXISTS public.professor_ratings (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  student_id       UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  general_score    INT NOT NULL CHECK (general_score    BETWEEN 1 AND 5),
  curriculum_score INT NOT NULL CHECK (curriculum_score BETWEEN 1 AND 5),
  comment          TEXT,
  is_anonymous     BOOLEAN DEFAULT TRUE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(professor_id, student_id)
);
ALTER TABLE public.professor_ratings ENABLE ROW LEVEL SECURITY;

-- invoices
CREATE TABLE IF NOT EXISTS public.invoices (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester       TEXT NOT NULL,
  description    TEXT NOT NULL,
  description_ar TEXT,
  amount         NUMERIC(10,2) NOT NULL,
  currency       TEXT NOT NULL DEFAULT 'EGP',
  status         payment_status NOT NULL DEFAULT 'pending',
  due_date       DATE,
  CONSTRAINT check_invoice_due_date CHECK (due_date IS NULL OR due_date >= created_at::DATE),
  paid_at        TIMESTAMPTZ,
  receipt_url    TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;

-- notifications
CREATE TABLE IF NOT EXISTS public.notifications (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title      TEXT NOT NULL,
  title_ar   TEXT,
  message    TEXT NOT NULL,
  message_ar TEXT,
  type       notification_type NOT NULL DEFAULT 'info',
  is_read    BOOLEAN NOT NULL DEFAULT FALSE,
  action_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  read_at    TIMESTAMPTZ
);
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- user_sessions
CREATE TABLE IF NOT EXISTS public.user_sessions (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  device_name TEXT,
  device_type session_device DEFAULT 'unknown',
  ip_address  INET,
  location    TEXT,
  user_agent  TEXT,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  last_active TIMESTAMPTZ DEFAULT now(),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.user_sessions ENABLE ROW LEVEL SECURITY;

-- action_plan_items
CREATE TABLE IF NOT EXISTS public.action_plan_items (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id   UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID REFERENCES public.courses(id),
  semester     TEXT NOT NULL,
  year         INT NOT NULL,
  status       TEXT DEFAULT 'planned',
  grade_letter TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.action_plan_items ENABLE ROW LEVEL SECURITY;

-- audit_logs
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  performed_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  target_user  UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  action       audit_action NOT NULL,
  table_name   TEXT,
  record_id    UUID,
  old_data     JSONB,
  new_data     JSONB,
  ip_address   INET,
  user_agent   TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- get_my_role
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
DECLARE user_roles user_role[];
BEGIN
  SELECT roles INTO user_roles FROM public.profiles WHERE id = auth.uid();
  IF    'super_admin'       = ANY(user_roles) THEN RETURN 'super_admin'::user_role;
  ELSIF 'admin'             = ANY(user_roles) THEN RETURN 'admin'::user_role;
  ELSIF 'it_support'        = ANY(user_roles) THEN RETURN 'it_support'::user_role;
  ELSIF 'financial_auditor' = ANY(user_roles) THEN RETURN 'financial_auditor'::user_role;
  ELSIF array_length(user_roles, 1) > 0        THEN RETURN user_roles[1];
  ELSE  RETURN 'student'::user_role;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- handle_new_user
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
DECLARE resolved_roles user_role[];
BEGIN
  BEGIN
    IF NOT EXISTS (SELECT 1 FROM public.profiles WHERE email = NEW.email) THEN
      IF NEW.raw_user_meta_data->'roles' IS NOT NULL THEN
        SELECT ARRAY(SELECT elem::user_role FROM jsonb_array_elements_text(NEW.raw_user_meta_data->'roles') AS elem) INTO resolved_roles;
      ELSE
        resolved_roles := ARRAY[COALESCE((NEW.raw_user_meta_data->>'role')::user_role,'student'::user_role)];
      END IF;
      INSERT INTO public.profiles (id, email, full_name, roles)
      VALUES (NEW.id, NEW.email, COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email), resolved_roles)
      ON CONFLICT (id) DO NOTHING;
    END IF;
  EXCEPTION WHEN OTHERS THEN RETURN NEW;
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
  INSERT INTO public.profiles (id, email, full_name, roles)
  SELECT id, email, COALESCE(raw_user_meta_data->>'full_name', email),
    ARRAY[COALESCE((raw_user_meta_data->>'role')::user_role,'student'::user_role)]
  FROM auth.users
  WHERE id NOT IN (SELECT id FROM public.profiles) AND email NOT IN (SELECT email FROM public.profiles)
  ON CONFLICT (id) DO NOTHING;
END $$;

-- admin_create_user
CREATE OR REPLACE FUNCTION public.admin_create_user(
  email TEXT, password TEXT, full_name TEXT, roles user_role[],
  student_id TEXT DEFAULT NULL, national_id TEXT DEFAULT NULL,
  nationality TEXT DEFAULT NULL, phone TEXT DEFAULT NULL,
  college_id UUID DEFAULT NULL, department_id UUID DEFAULT NULL
) RETURNS UUID AS $$
DECLARE new_user_id UUID; current_user_roles user_role[];
BEGIN
  SELECT p.roles INTO current_user_roles FROM public.profiles p WHERE p.id = auth.uid();
  IF NOT (current_user_roles && ARRAY['super_admin','admin','it_support']::user_role[]) THEN
    RAISE EXCEPTION 'Unauthorized: Only admins can create users.';
  END IF;
  INSERT INTO auth.users (id,aud,role,email,encrypted_password,email_confirmed_at,raw_app_meta_data,raw_user_meta_data,created_at,updated_at,confirmation_token,email_change,email_change_token_new,recovery_token)
  VALUES (gen_random_uuid(),'authenticated','authenticated',admin_create_user.email,crypt(admin_create_user.password,gen_salt('bf',10)),now(),'{"provider":"email","providers":["email"]}',jsonb_build_object('full_name',admin_create_user.full_name,'roles',admin_create_user.roles::text[]),now(),now(),'','','','')
  RETURNING id INTO new_user_id;
  UPDATE public.profiles SET student_id=admin_create_user.student_id,national_id=admin_create_user.national_id,nationality=admin_create_user.nationality,phone=admin_create_user.phone,college_id=admin_create_user.college_id,department_id=admin_create_user.department_id,roles=admin_create_user.roles WHERE id=new_user_id;
  RETURN new_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_toggle_user_status
CREATE OR REPLACE FUNCTION public.admin_toggle_user_status(user_id UUID, is_active BOOLEAN) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  UPDATE public.profiles SET is_active=admin_toggle_user_status.is_active,updated_at=now() WHERE id=admin_toggle_user_status.user_id;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),user_id,'toggle_status','Status changed to '||is_active::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_delete_user
CREATE OR REPLACE FUNCTION public.admin_delete_user(target_user_id UUID, hard_delete BOOLEAN DEFAULT FALSE) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  IF hard_delete THEN DELETE FROM auth.users WHERE id=target_user_id;
  ELSE UPDATE public.profiles SET deleted_at=now(),is_active=FALSE,updated_at=now() WHERE id=target_user_id; END IF;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),target_user_id,'delete',CASE WHEN hard_delete THEN 'Hard delete' ELSE 'Soft delete' END);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_toggle_verification
CREATE OR REPLACE FUNCTION public.admin_toggle_verification(user_id UUID, is_verified BOOLEAN) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  UPDATE public.profiles SET is_verified=admin_toggle_verification.is_verified,updated_at=now() WHERE id=admin_toggle_verification.user_id;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),user_id,'update','Verification toggled to '||is_verified::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_toggle_ban
CREATE OR REPLACE FUNCTION public.admin_toggle_ban(user_id UUID, is_banned BOOLEAN) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  UPDATE public.profiles SET is_banned=admin_toggle_ban.is_banned,updated_at=now() WHERE id=admin_toggle_ban.user_id;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),user_id,'update','Ban toggled to '||is_banned::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_update_tags
CREATE OR REPLACE FUNCTION public.admin_update_tags(user_id UUID, tags TEXT[]) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  UPDATE public.profiles SET tags=admin_update_tags.tags,updated_at=now() WHERE id=admin_update_tags.user_id;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),user_id,'update','Tags updated');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- admin_update_warning_level
CREATE OR REPLACE FUNCTION public.admin_update_warning_level(user_id UUID, level INT) RETURNS VOID AS $$
BEGIN
  IF NOT (public.get_my_role() IN ('super_admin','admin','it_support')) THEN RAISE EXCEPTION 'Unauthorized'; END IF;
  UPDATE public.profiles SET warning_level=admin_update_warning_level.level,updated_at=now() WHERE id=admin_update_warning_level.user_id;
  INSERT INTO public.audit_logs (performed_by,target_user,action,notes) VALUES (auth.uid(),user_id,'update','Warning level set to '||level::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- calculate_grade_metrics
CREATE OR REPLACE FUNCTION public.calculate_grade_metrics()
RETURNS TRIGGER AS $$
BEGIN
  NEW.total := COALESCE(NEW.midterm,0)+COALESCE(NEW.final_exam,0)+COALESCE(NEW.coursework,0)+COALESCE(NEW.practical,0);
  IF    NEW.total >= 95 THEN NEW.grade_letter:='A+'; NEW.gpa_points:=4.00;
  ELSIF NEW.total >= 90 THEN NEW.grade_letter:='A';  NEW.gpa_points:=3.75;
  ELSIF NEW.total >= 85 THEN NEW.grade_letter:='B+'; NEW.gpa_points:=3.50;
  ELSIF NEW.total >= 80 THEN NEW.grade_letter:='B';  NEW.gpa_points:=3.00;
  ELSIF NEW.total >= 75 THEN NEW.grade_letter:='C+'; NEW.gpa_points:=2.50;
  ELSIF NEW.total >= 70 THEN NEW.grade_letter:='C';  NEW.gpa_points:=2.00;
  ELSIF NEW.total >= 65 THEN NEW.grade_letter:='D+'; NEW.gpa_points:=1.50;
  ELSIF NEW.total >= 60 THEN NEW.grade_letter:='D';  NEW.gpa_points:=1.00;
  ELSE                        NEW.grade_letter:='F';  NEW.gpa_points:=0.00;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS grades_metrics_trigger ON public.grades;
CREATE TRIGGER grades_metrics_trigger
  BEFORE INSERT OR UPDATE OF midterm,final_exam,coursework,practical ON public.grades
  FOR EACH ROW EXECUTE FUNCTION public.calculate_grade_metrics();

-- on_registration_request_approved
CREATE OR REPLACE FUNCTION public.on_registration_request_approved()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status='approved' AND OLD.status!='approved' THEN
    DELETE FROM public.student_course_registrations WHERE student_id=NEW.student_id AND semester=NEW.semester;
    INSERT INTO public.student_course_registrations (student_id,course_id,semester,section_name,sub_section_name,registered_at)
    SELECT NEW.student_id,rrc.course_id,NEW.semester,rrc.section_name,rrc.sub_section_name,now()
    FROM public.registration_request_courses rrc WHERE rrc.request_id=NEW.id;
    NEW.reviewed_at:=now();
  END IF;
  IF NEW.status='rejected' AND OLD.status!='rejected' THEN NEW.reviewed_at:=now(); END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_request_approved ON public.registration_requests;
CREATE TRIGGER on_request_approved
  BEFORE UPDATE OF status ON public.registration_requests
  FOR EACH ROW EXECUTE FUNCTION public.on_registration_request_approved();

CREATE INDEX IF NOT EXISTS idx_profiles_roles       ON public.profiles USING GIN(roles);
CREATE INDEX IF NOT EXISTS idx_profiles_email       ON public.profiles(email);
CREATE INDEX IF NOT EXISTS idx_colleges_code        ON public.colleges(code);
CREATE INDEX IF NOT EXISTS idx_departments_college  ON public.departments(college_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_student  ON public.enrollments(student_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_course   ON public.enrollments(course_id);
CREATE INDEX IF NOT EXISTS idx_grades_student       ON public.grades(student_id);
CREATE INDEX IF NOT EXISTS idx_grades_course        ON public.grades(course_id);
CREATE INDEX IF NOT EXISTS idx_attendance_student   ON public.attendance(student_id);
CREATE INDEX IF NOT EXISTS idx_attendance_course    ON public.attendance(course_id);
CREATE INDEX IF NOT EXISTS idx_schedules_course     ON public.schedules(course_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user   ON public.notifications(user_id, is_read);
CREATE INDEX IF NOT EXISTS idx_announcements_course ON public.announcements(course_id);
CREATE INDEX IF NOT EXISTS idx_invoices_student     ON public.invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_forum    ON public.forum_posts(forum_id);
CREATE INDEX IF NOT EXISTS idx_shared_files_course  ON public.shared_files(course_id);
CREATE INDEX IF NOT EXISTS idx_action_plan_student  ON public.action_plan_items(student_id);
CREATE INDEX IF NOT EXISTS idx_audit_performed_by   ON public.audit_logs(performed_by);
CREATE INDEX IF NOT EXISTS idx_audit_target_user    ON public.audit_logs(target_user);
CREATE INDEX IF NOT EXISTS idx_audit_action         ON public.audit_logs(action);
CREATE INDEX IF NOT EXISTS idx_audit_created_at     ON public.audit_logs(created_at DESC);

DROP POLICY IF EXISTS "Users can view all active profiles" ON public.profiles;
CREATE POLICY "Users can view all active profiles" ON public.profiles FOR SELECT
  USING (deleted_at IS NULL OR public.get_my_role() IN ('super_admin','admin','it_support','financial_auditor'));
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE
  USING (auth.uid()=id OR public.get_my_role() IN ('super_admin','admin','it_support'));
DROP POLICY IF EXISTS "Admins can manage profiles" ON public.profiles;
CREATE POLICY "Admins can manage profiles" ON public.profiles FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support','financial_auditor'));

DROP POLICY IF EXISTS "Anyone can view colleges" ON public.colleges;
CREATE POLICY "Anyone can view colleges" ON public.colleges FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins can manage colleges" ON public.colleges;
CREATE POLICY "Admins can manage colleges" ON public.colleges FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

DROP POLICY IF EXISTS "Anyone can view departments" ON public.departments;
CREATE POLICY "Anyone can view departments" ON public.departments FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins can manage departments" ON public.departments;
CREATE POLICY "Admins can manage departments" ON public.departments FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

DROP POLICY IF EXISTS "Anyone can view active courses" ON public.courses;
CREATE POLICY "Anyone can view active courses" ON public.courses FOR SELECT USING (is_active=TRUE);
DROP POLICY IF EXISTS "Admins can manage courses" ON public.courses;
CREATE POLICY "Admins can manage courses" ON public.courses FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','it_support'));

DROP POLICY IF EXISTS "Projects are viewable by everyone." ON public.department_projects;
CREATE POLICY "Projects are viewable by everyone." ON public.department_projects FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Users with academic leadership or admin roles can manage projects." ON public.department_projects;
CREATE POLICY "Users with academic leadership or admin roles can manage projects."
  ON public.department_projects FOR ALL
  USING (public.get_my_role() IN ('super_admin','admin','dean','department_head'));

DROP POLICY IF EXISTS "Users can view their own course registrations" ON public.student_course_registrations;
CREATE POLICY "Users can view their own course registrations"
  ON public.student_course_registrations FOR SELECT USING (auth.uid()=student_id);
DROP POLICY IF EXISTS "Users can manage their own course registrations" ON public.student_course_registrations;
CREATE POLICY "Users can manage their own course registrations"
  ON public.student_course_registrations FOR ALL USING (auth.uid()=student_id);

DROP POLICY IF EXISTS "student_own_requests" ON public.registration_requests;
CREATE POLICY "student_own_requests" ON public.registration_requests
  FOR ALL USING (student_id=auth.uid()) WITH CHECK (student_id=auth.uid());
DROP POLICY IF EXISTS "advisor_sees_assigned_requests" ON public.registration_requests;
CREATE POLICY "advisor_sees_assigned_requests" ON public.registration_requests FOR SELECT
  USING (advisor_id=auth.uid() OR 'academic_advisor'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()));
DROP POLICY IF EXISTS "advisor_can_update_requests" ON public.registration_requests;
CREATE POLICY "advisor_can_update_requests" ON public.registration_requests FOR UPDATE
  USING (advisor_id=auth.uid() OR 'academic_advisor'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()));
DROP POLICY IF EXISTS "admin_all_requests" ON public.registration_requests;
CREATE POLICY "admin_all_requests" ON public.registration_requests FOR ALL
  USING ('super_admin'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()) OR 'admin'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()) OR 'dean'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()));

DROP POLICY IF EXISTS "student_own_request_courses" ON public.registration_request_courses;
CREATE POLICY "student_own_request_courses" ON public.registration_request_courses FOR ALL
  USING (request_id IN (SELECT id FROM public.registration_requests WHERE student_id=auth.uid()));
DROP POLICY IF EXISTS "advisor_sees_request_courses" ON public.registration_request_courses;
CREATE POLICY "advisor_sees_request_courses" ON public.registration_request_courses FOR SELECT
  USING (request_id IN (SELECT id FROM public.registration_requests WHERE advisor_id=auth.uid()));
DROP POLICY IF EXISTS "admin_all_request_courses" ON public.registration_request_courses;
CREATE POLICY "admin_all_request_courses" ON public.registration_request_courses FOR ALL
  USING ('super_admin'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()) OR 'admin'=ANY(SELECT unnest(roles) FROM public.profiles WHERE id=auth.uid()));