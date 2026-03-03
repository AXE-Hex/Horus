-- Create student_course_registrations table
CREATE TABLE IF NOT EXISTS student_course_registrations (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  course_id        UUID NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  semester         TEXT NOT NULL,
  section_name     TEXT,
  sub_section_name TEXT,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(student_id, course_id, semester)
);

-- Enable RLS
ALTER TABLE student_course_registrations ENABLE ROW LEVEL SECURITY;

-- Add RLS policies
CREATE POLICY "Users can view their own course registrations"
  ON student_course_registrations FOR SELECT
  USING (auth.uid() = student_id);

CREATE POLICY "Users can manage their own course registrations"
  ON student_course_registrations FOR ALL
  USING (auth.uid() = student_id);
