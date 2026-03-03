-- ============================================================
-- Migration 04: Advisor Workflow & Student-Linked Registration
-- ============================================================

-- 1. Add advisor_id column to profiles (student -> advisor link)
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'profiles' AND column_name = 'advisor_id'
  ) THEN
    ALTER TABLE profiles ADD COLUMN advisor_id UUID REFERENCES profiles(id) ON DELETE SET NULL;
  END IF;
END $$;

-- 2. registration_requests table
CREATE TABLE IF NOT EXISTS registration_requests (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id      UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  advisor_id      UUID REFERENCES profiles(id) ON DELETE SET NULL,
  semester        TEXT NOT NULL,
  status          enrollment_status NOT NULL DEFAULT 'pending',
  advisor_notes   TEXT,
  submitted_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  reviewed_at     TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, semester)
);

ALTER TABLE registration_requests ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS registration_requests_updated_at ON registration_requests;
CREATE TRIGGER registration_requests_updated_at
  BEFORE UPDATE ON registration_requests
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- 3. registration_request_courses table (courses inside a request)
CREATE TABLE IF NOT EXISTS registration_request_courses (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id       UUID NOT NULL REFERENCES registration_requests(id) ON DELETE CASCADE,
  course_id        UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  section_name     TEXT,
  sub_section_name TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE registration_request_courses ENABLE ROW LEVEL SECURITY;

-- 4. RLS Policies

-- registration_requests: student sees own, advisor sees their students', admin sees all
DROP POLICY IF EXISTS "student_own_requests" ON registration_requests;
CREATE POLICY "student_own_requests" ON registration_requests
  FOR ALL
  USING (student_id = auth.uid())
  WITH CHECK (student_id = auth.uid());

DROP POLICY IF EXISTS "advisor_sees_assigned_requests" ON registration_requests;
CREATE POLICY "advisor_sees_assigned_requests" ON registration_requests
  FOR SELECT
  USING (
    advisor_id = auth.uid()
    OR 'academic_advisor' = ANY(
      SELECT unnest(roles) FROM profiles WHERE id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "advisor_can_update_requests" ON registration_requests;
CREATE POLICY "advisor_can_update_requests" ON registration_requests
  FOR UPDATE
  USING (
    advisor_id = auth.uid()
    OR 'academic_advisor' = ANY(
      SELECT unnest(roles) FROM profiles WHERE id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "admin_all_requests" ON registration_requests;
CREATE POLICY "admin_all_requests" ON registration_requests
  FOR ALL
  USING (
    'super_admin' = ANY(SELECT unnest(roles) FROM profiles WHERE id = auth.uid())
    OR 'admin' = ANY(SELECT unnest(roles) FROM profiles WHERE id = auth.uid())
    OR 'dean' = ANY(SELECT unnest(roles) FROM profiles WHERE id = auth.uid())
  );

-- registration_request_courses: join through request
DROP POLICY IF EXISTS "student_own_request_courses" ON registration_request_courses;
CREATE POLICY "student_own_request_courses" ON registration_request_courses
  FOR ALL
  USING (
    request_id IN (
      SELECT id FROM registration_requests WHERE student_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "advisor_sees_request_courses" ON registration_request_courses;
CREATE POLICY "advisor_sees_request_courses" ON registration_request_courses
  FOR SELECT
  USING (
    request_id IN (
      SELECT id FROM registration_requests WHERE advisor_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "admin_all_request_courses" ON registration_request_courses;
CREATE POLICY "admin_all_request_courses" ON registration_request_courses
  FOR ALL
  USING (
    'super_admin' = ANY(SELECT unnest(roles) FROM profiles WHERE id = auth.uid())
    OR 'admin' = ANY(SELECT unnest(roles) FROM profiles WHERE id = auth.uid())
  );

-- 5. Function: auto-enroll student_course_registrations after advisor approval
CREATE OR REPLACE FUNCTION on_registration_request_approved()
RETURNS TRIGGER AS $$
BEGIN
  -- Only act when status changes TO approved
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
    -- Delete old course registrations for this student/semester
    DELETE FROM student_course_registrations
    WHERE student_id = NEW.student_id AND semester = NEW.semester;

    -- Insert new registrations from approved request
    INSERT INTO student_course_registrations (student_id, course_id, semester, section_name, sub_section_name, registered_at)
    SELECT
      NEW.student_id,
      rrc.course_id,
      NEW.semester,
      rrc.section_name,
      rrc.sub_section_name,
      now()
    FROM registration_request_courses rrc
    WHERE rrc.request_id = NEW.id;

    -- Set reviewed_at timestamp
    NEW.reviewed_at := now();
  END IF;

  IF NEW.status = 'rejected' AND OLD.status != 'rejected' THEN
    NEW.reviewed_at := now();
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_request_approved ON registration_requests;
CREATE TRIGGER on_request_approved
  BEFORE UPDATE OF status ON registration_requests
  FOR EACH ROW EXECUTE FUNCTION on_registration_request_approved();
