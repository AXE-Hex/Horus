-- LOCAL DEVELOPMENT FIXTURES ONLY.
-- Supabase CLI loads this file only during local `supabase db reset`.
-- Never run or adapt these credentials for staging or production.

INSERT INTO public.colleges (id, code, name_en, name_ar)
VALUES ('d1000000-0000-4000-8000-000000000001', 'DEV-LOCAL', 'Development College', 'كلية التطوير المحلية')
ON CONFLICT (code) DO UPDATE
SET name_en = EXCLUDED.name_en, name_ar = EXCLUDED.name_ar;

INSERT INTO public.departments (id, college_id, code, name_en, name_ar)
SELECT 'd2000000-0000-4000-8000-000000000001'::uuid, id, 'DEV-LOCAL-CS', 'Development Computing', 'الحوسبة للتطوير'
FROM public.colleges WHERE code = 'DEV-LOCAL'
ON CONFLICT (code) DO UPDATE
SET college_id = EXCLUDED.college_id,
    name_en = EXCLUDED.name_en,
    name_ar = EXCLUDED.name_ar;

WITH accounts(id, email, password, full_name, role_code) AS (
  VALUES
    ('d0000000-0000-4000-8000-000000000001'::uuid, 'rector.dev@horus.edu.eg', 'HorusDev!2026-Rector', 'Development Rector', 'rector'),
    ('d0000000-0000-4000-8000-000000000002'::uuid, 'dean.dev@horus.edu.eg', 'HorusDev!2026-Dean', 'Development Dean', 'dean'),
    ('d0000000-0000-4000-8000-000000000003'::uuid, 'hod.dev@horus.edu.eg', 'HorusDev!2026-Hod', 'Development Department Head', 'department_head'),
    ('d0000000-0000-4000-8000-000000000004'::uuid, 'professor.dev@horus.edu.eg', 'HorusDev!2026-Professor', 'Development Professor', 'professor'),
    ('d0000000-0000-4000-8000-000000000005'::uuid, 'ta.dev@horus.edu.eg', 'HorusDev!2026-Assistant', 'Development Teaching Assistant', 'teaching_assistant'),
    ('d0000000-0000-4000-8000-000000000006'::uuid, 'registrar.dev@horus.edu.eg', 'HorusDev!2026-Registrar', 'Development Registrar', 'registrar_officer'),
    ('d0000000-0000-4000-8000-000000000007'::uuid, 'advisor.dev@horus.edu.eg', 'HorusDev!2026-Advisor', 'Development Academic Advisor', 'academic_advisor'),
    ('d0000000-0000-4000-8000-000000000008'::uuid, 'student.dev@horus.edu.eg', 'HorusDev!2026-Student', 'Development Student', 'regular_student'),
    ('d0000000-0000-4000-8000-000000000009'::uuid, 'freshman.dev@horus.edu.eg', 'HorusDev!2026-Freshman', 'Development Freshman', 'freshman'),
    -- Deliberately malicious user metadata verifies it cannot grant a role.
    ('d0000000-0000-4000-8000-000000000010'::uuid, 'guest.dev@horus.edu.eg', 'HorusDev!2026-Guest', 'Development Guest', 'guest'),
    ('d0000000-0000-4000-8000-000000000011'::uuid, 'student2.dev@horus.edu.eg', 'HorusDev!2026-Student2', 'Development Student Two', 'regular_student'),
    ('d0000000-0000-4000-8000-000000000012'::uuid, 'student3.dev@horus.edu.eg', 'HorusDev!2026-Student3', 'Development Student Three', 'regular_student')
), auth_rows AS (
  INSERT INTO auth.users (
    id, instance_id, aud, role, email, encrypted_password, email_confirmed_at,
    confirmation_token, recovery_token, email_change_token_new, email_change,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at
  )
  SELECT id, '00000000-0000-0000-0000-000000000000'::uuid, 'authenticated', 'authenticated', email,
         extensions.crypt(password, extensions.gen_salt('bf')), now(),
         '', '', '', '',
         '{"provider":"email","providers":["email"]}'::jsonb,
         jsonb_build_object('full_name', full_name,
           'role', CASE WHEN role_code = 'guest' THEN 'rector' ELSE role_code END),
         now(), now()
  FROM accounts
  ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    instance_id = EXCLUDED.instance_id,
    confirmation_token = '', recovery_token = '',
    email_change_token_new = '', email_change = '',
    encrypted_password = EXCLUDED.encrypted_password,
    email_confirmed_at = EXCLUDED.email_confirmed_at,
    raw_app_meta_data = EXCLUDED.raw_app_meta_data,
    raw_user_meta_data = EXCLUDED.raw_user_meta_data,
    updated_at = now()
  RETURNING id
)
SELECT count(*) FROM auth_rows;

INSERT INTO auth.identities (provider_id, user_id, identity_data, provider, created_at, updated_at)
SELECT id::text, id,
       jsonb_build_object('sub', id::text, 'email', email, 'email_verified', true),
       'email', now(), now()
FROM auth.users
WHERE id BETWEEN 'd0000000-0000-4000-8000-000000000001'::uuid
             AND 'd0000000-0000-4000-8000-000000000012'::uuid
ON CONFLICT (provider_id, provider) DO UPDATE SET
  user_id = EXCLUDED.user_id,
  identity_data = EXCLUDED.identity_data,
  updated_at = now();

UPDATE public.profiles p
SET full_name = a.full_name,
    full_name_ar = CASE a.id
      WHEN 'd0000000-0000-4000-8000-000000000001'::uuid THEN 'حساب تطوير: رئيس الجامعة'
      WHEN 'd0000000-0000-4000-8000-000000000002'::uuid THEN 'حساب تطوير: عميد الكلية'
      WHEN 'd0000000-0000-4000-8000-000000000003'::uuid THEN 'حساب تطوير: رئيس القسم'
      WHEN 'd0000000-0000-4000-8000-000000000004'::uuid THEN 'حساب تطوير: عضو هيئة تدريس'
      WHEN 'd0000000-0000-4000-8000-000000000005'::uuid THEN 'حساب تطوير: مساعد تدريس'
      WHEN 'd0000000-0000-4000-8000-000000000006'::uuid THEN 'حساب تطوير: مسؤول التسجيل'
      WHEN 'd0000000-0000-4000-8000-000000000007'::uuid THEN 'حساب تطوير: مرشد أكاديمي'
      WHEN 'd0000000-0000-4000-8000-000000000008'::uuid THEN 'حساب تطوير: طالب 01'
      WHEN 'd0000000-0000-4000-8000-000000000009'::uuid THEN 'حساب تطوير: طالب مستجد'
      WHEN 'd0000000-0000-4000-8000-000000000010'::uuid THEN 'حساب تطوير: زائر'
      WHEN 'd0000000-0000-4000-8000-000000000011'::uuid THEN 'حساب تطوير: طالب 02'
      ELSE 'حساب تطوير: طالب 03'
    END,
    student_id = CASE a.id
      WHEN 'd0000000-0000-4000-8000-000000000008'::uuid THEN 'DEV-STU-008'
      WHEN 'd0000000-0000-4000-8000-000000000009'::uuid THEN 'DEV-STU-009'
      WHEN 'd0000000-0000-4000-8000-000000000011'::uuid THEN 'DEV-STU-011'
      WHEN 'd0000000-0000-4000-8000-000000000012'::uuid THEN 'DEV-STU-012'
      ELSE NULL
    END,
    advisor_id = CASE
      WHEN a.id = 'd0000000-0000-4000-8000-000000000008'::uuid
        THEN 'd0000000-0000-4000-8000-000000000007'::uuid
      ELSE NULL
    END,
    college_id = CASE WHEN p.id = 'd0000000-0000-4000-8000-000000000001'::uuid THEN NULL ELSE c.id END,
    department_id = CASE WHEN p.id = 'd0000000-0000-4000-8000-000000000001'::uuid THEN NULL ELSE d.id END,
    is_active = true,
    is_banned = false,
    deleted_at = NULL
FROM (VALUES
  ('d0000000-0000-4000-8000-000000000001'::uuid, 'Development Rector'),
  ('d0000000-0000-4000-8000-000000000002'::uuid, 'Development Dean'),
  ('d0000000-0000-4000-8000-000000000003'::uuid, 'Development Department Head'),
  ('d0000000-0000-4000-8000-000000000004'::uuid, 'Development Professor'),
  ('d0000000-0000-4000-8000-000000000005'::uuid, 'Development Teaching Assistant'),
  ('d0000000-0000-4000-8000-000000000006'::uuid, 'Development Registrar'),
  ('d0000000-0000-4000-8000-000000000007'::uuid, 'Development Academic Advisor'),
  ('d0000000-0000-4000-8000-000000000008'::uuid, 'Development Student'),
  ('d0000000-0000-4000-8000-000000000009'::uuid, 'Development Freshman'),
  ('d0000000-0000-4000-8000-000000000010'::uuid, 'Development Guest'),
  ('d0000000-0000-4000-8000-000000000011'::uuid, 'Development Student Two'),
  ('d0000000-0000-4000-8000-000000000012'::uuid, 'Development Student Three')
) AS a(id, full_name)
CROSS JOIN public.colleges c
CROSS JOIN public.departments d
WHERE p.id = a.id AND c.code = 'DEV-LOCAL' AND d.code = 'DEV-LOCAL-CS';

DELETE FROM public.user_roles
WHERE user_id BETWEEN 'd0000000-0000-4000-8000-000000000001'::uuid
                  AND 'd0000000-0000-4000-8000-000000000012'::uuid;

INSERT INTO public.user_roles (user_id, role_id)
SELECT a.id, r.id
FROM (VALUES
  ('d0000000-0000-4000-8000-000000000001'::uuid, 'rector'),
  ('d0000000-0000-4000-8000-000000000002'::uuid, 'dean'),
  ('d0000000-0000-4000-8000-000000000003'::uuid, 'department_head'),
  ('d0000000-0000-4000-8000-000000000004'::uuid, 'professor'),
  ('d0000000-0000-4000-8000-000000000005'::uuid, 'teaching_assistant'),
  ('d0000000-0000-4000-8000-000000000006'::uuid, 'registrar_officer'),
  ('d0000000-0000-4000-8000-000000000007'::uuid, 'academic_advisor'),
  ('d0000000-0000-4000-8000-000000000008'::uuid, 'regular_student'),
  ('d0000000-0000-4000-8000-000000000009'::uuid, 'freshman'),
  ('d0000000-0000-4000-8000-000000000010'::uuid, 'guest'),
  ('d0000000-0000-4000-8000-000000000011'::uuid, 'regular_student'),
  ('d0000000-0000-4000-8000-000000000012'::uuid, 'regular_student')
) AS a(id, role_code)
JOIN public.role_definitions r ON r.code = a.role_code AND r.is_active;

-- All records below are synthetic local fixtures. They exercise real table
-- contracts and RLS; they are not university records and never run in prod.

UPDATE public.colleges SET dean_id = 'd0000000-0000-4000-8000-000000000002'
WHERE code = 'DEV-LOCAL';
UPDATE public.departments SET hod_id = 'd0000000-0000-4000-8000-000000000003'
WHERE code = 'DEV-LOCAL-CS';

INSERT INTO public.professor_details (id, department_id, office_symbol)
VALUES ('d0000000-0000-4000-8000-000000000004',
        'd2000000-0000-4000-8000-000000000001', 'DEV-B-214')
ON CONFLICT (id) DO UPDATE SET department_id = EXCLUDED.department_id,
  office_symbol = EXCLUDED.office_symbol;

INSERT INTO public.semesters
  (id, code, name_en, name_ar, academic_year, start_date, end_date, is_current, is_active)
VALUES
  ('e1000000-0000-4000-8000-000000000001', 'DEV-2026-FALL', 'Fall 2026', 'خريف 2026',
   '2026-2027', '2026-08-30', '2026-12-31', true, true),
  ('e1000000-0000-4000-8000-000000000002', 'DEV-2026-SPRING', 'Spring 2026', 'ربيع 2026',
   '2025-2026', '2026-02-01', '2026-06-30', false, true)
ON CONFLICT (code) DO UPDATE SET name_en = EXCLUDED.name_en,
  name_ar = EXCLUDED.name_ar, academic_year = EXCLUDED.academic_year,
  start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date,
  is_current = EXCLUDED.is_current, is_active = EXCLUDED.is_active;

INSERT INTO public.courses
  (id, department_id, code, name_en, name_ar, description, credit_hours,
   semester, semester_id, professor_id, max_students, is_active)
VALUES
  ('c1000000-0000-4000-8000-000000000001', 'd2000000-0000-4000-8000-000000000001',
   'DEV-CS101', 'Introduction to Programming', 'مقدمة في البرمجة',
   'Local fixture course covering programming fundamentals.', 3,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 40, true),
  ('c1000000-0000-4000-8000-000000000002', 'd2000000-0000-4000-8000-000000000001',
   'DEV-MA101', 'Calculus I', 'التفاضل والتكامل 1',
   'Local fixture course covering limits and derivatives.', 3,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 40, true),
  ('c1000000-0000-4000-8000-000000000003', 'd2000000-0000-4000-8000-000000000001',
   'DEV-CS201', 'Data Structures', 'هياكل البيانات',
   'Local fixture course covering common data structures.', 3,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 35, true),
  ('c1000000-0000-4000-8000-000000000004', 'd2000000-0000-4000-8000-000000000001',
   'DEV-CS301', 'Database Systems', 'نظم قواعد البيانات',
   'Local fixture course covering relational databases and SQL.', 3,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 30, true)
ON CONFLICT (id) DO UPDATE SET department_id = EXCLUDED.department_id,
  code = EXCLUDED.code, name_en = EXCLUDED.name_en, name_ar = EXCLUDED.name_ar,
  description = EXCLUDED.description, credit_hours = EXCLUDED.credit_hours,
  semester = EXCLUDED.semester, semester_id = EXCLUDED.semester_id,
  professor_id = EXCLUDED.professor_id, max_students = EXCLUDED.max_students,
  is_active = EXCLUDED.is_active;

INSERT INTO public.course_prerequisites (course_id, prerequisite_course_id, minimum_grade)
VALUES ('c1000000-0000-4000-8000-000000000004',
        'c1000000-0000-4000-8000-000000000003', 50)
ON CONFLICT DO NOTHING;

INSERT INTO public.course_sections (id, course_id, name, semester, semester_id, max_students)
VALUES
  ('c2000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001', 'A', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 40),
  ('c2000000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000002', 'A', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 40),
  ('c2000000-0000-4000-8000-000000000003', 'c1000000-0000-4000-8000-000000000003', 'B', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 35),
  ('c2000000-0000-4000-8000-000000000004', 'c1000000-0000-4000-8000-000000000004', 'A', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 30)
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  name = EXCLUDED.name, semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id, max_students = EXCLUDED.max_students;

INSERT INTO public.course_sub_sections (id, section_id, name, max_students)
VALUES
  ('c3000000-0000-4000-8000-000000000001', 'c2000000-0000-4000-8000-000000000001', 'Lab 1', 20),
  ('c3000000-0000-4000-8000-000000000002', 'c2000000-0000-4000-8000-000000000001', 'Lab 2', 20),
  ('c3000000-0000-4000-8000-000000000003', 'c2000000-0000-4000-8000-000000000003', 'Lab 1', 18)
ON CONFLICT (id) DO UPDATE SET section_id = EXCLUDED.section_id,
  name = EXCLUDED.name, max_students = EXCLUDED.max_students;

INSERT INTO public.teaching_assistants (id, profile_id, professor_id, course_id, ta_role, is_active)
VALUES
  ('c4000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000005', 'd0000000-0000-4000-8000-000000000004', 'c1000000-0000-4000-8000-000000000001', 'Lab Assistant', true)
ON CONFLICT (id) DO UPDATE SET profile_id = EXCLUDED.profile_id,
  professor_id = EXCLUDED.professor_id, course_id = EXCLUDED.course_id,
  ta_role = EXCLUDED.ta_role, is_active = EXCLUDED.is_active;

INSERT INTO public.enrollments (id, student_id, course_id, status, semester, semester_id, approved_at)
VALUES
  ('e2000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000002', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000003', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000004', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000001', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000005', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000002', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000006', 'd0000000-0000-4000-8000-000000000011', 'c1000000-0000-4000-8000-000000000001', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now()),
  ('e2000000-0000-4000-8000-000000000007', 'd0000000-0000-4000-8000-000000000012', 'c1000000-0000-4000-8000-000000000003', 'approved', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', now())
ON CONFLICT (student_id, course_id, semester) DO UPDATE SET status = EXCLUDED.status,
  semester_id = EXCLUDED.semester_id, approved_at = EXCLUDED.approved_at;

INSERT INTO public.student_course_registrations
  (id, student_id, course_id, semester, semester_id, section_name, sub_section_name)
VALUES
  ('e3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'A', 'Lab 1'),
  ('e3000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000002', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'A', NULL),
  ('e3000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000003', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'B', 'Lab 1'),
  ('e3000000-0000-4000-8000-000000000004', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000001', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'A', 'Lab 2')
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  semester = EXCLUDED.semester, semester_id = EXCLUDED.semester_id,
  section_name = EXCLUDED.section_name, sub_section_name = EXCLUDED.sub_section_name;

INSERT INTO public.student_registrations
  (id, student_id, semester, semester_id, section_name, sub_section_name)
VALUES
  ('e4000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'A', 'Lab 1'),
  ('e4000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000009', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'A', 'Lab 2')
ON CONFLICT (id) DO UPDATE SET semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id, section_name = EXCLUDED.section_name,
  sub_section_name = EXCLUDED.sub_section_name;

INSERT INTO public.schedules
  (id, course_id, day, start_time, end_time, room, building, schedule_type,
   section_name, sub_section_name, semester, semester_id)
VALUES
  ('e5000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001', 'monday', '09:00', '10:30', 'B-201', 'Development Building', 'lecture', 'A', NULL, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001'),
  ('e5000000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000001', 'wednesday', '11:00', '12:30', 'Lab-03', 'Development Building', 'lab', 'A', 'Lab 1', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001'),
  ('e5000000-0000-4000-8000-000000000003', 'c1000000-0000-4000-8000-000000000002', 'tuesday', '09:00', '10:30', 'B-105', 'Development Building', 'lecture', 'A', NULL, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001'),
  ('e5000000-0000-4000-8000-000000000004', 'c1000000-0000-4000-8000-000000000003', 'thursday', '12:00', '13:30', 'B-212', 'Development Building', 'lecture', 'B', NULL, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001'),
  ('e5000000-0000-4000-8000-000000000005', 'c1000000-0000-4000-8000-000000000004', 'wednesday', '13:00', '14:30', 'B-214', 'Development Building', 'lecture', 'A', NULL, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001')
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  day = EXCLUDED.day, start_time = EXCLUDED.start_time, end_time = EXCLUDED.end_time,
  room = EXCLUDED.room, building = EXCLUDED.building,
  schedule_type = EXCLUDED.schedule_type, section_name = EXCLUDED.section_name,
  sub_section_name = EXCLUDED.sub_section_name, semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id;

INSERT INTO public.exam_schedules
  (id, course_id, exam_type, exam_date, start_time, end_time, room, building,
   semester, semester_id, notes)
VALUES
  ('e6000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001', 'midterm', '2026-10-26', '09:00', '11:00', 'B-201', 'Development Building', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Local test fixture.'),
  ('e6000000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000002', 'midterm', '2026-10-28', '12:00', '14:00', 'B-105', 'Development Building', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Local test fixture.'),
  ('e6000000-0000-4000-8000-000000000003', 'c1000000-0000-4000-8000-000000000003', 'final', '2026-12-20', '09:00', '12:00', 'B-212', 'Development Building', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Local test fixture.')
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  exam_type = EXCLUDED.exam_type, exam_date = EXCLUDED.exam_date,
  start_time = EXCLUDED.start_time, end_time = EXCLUDED.end_time,
  room = EXCLUDED.room, building = EXCLUDED.building,
  semester = EXCLUDED.semester, semester_id = EXCLUDED.semester_id,
  notes = EXCLUDED.notes;

INSERT INTO public.attendance (id, student_id, course_id, date, status, notes, recorded_by)
VALUES
  ('e7000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', '2026-09-07', 'present', 'Local fixture attendance.', 'd0000000-0000-4000-8000-000000000004'),
  ('e7000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', '2026-09-14', 'late', 'Local fixture attendance.', 'd0000000-0000-4000-8000-000000000004'),
  ('e7000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', '2026-09-21', 'present', 'Local fixture attendance.', 'd0000000-0000-4000-8000-000000000004'),
  ('e7000000-0000-4000-8000-000000000004', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000001', '2026-09-07', 'absent', 'Local fixture attendance.', 'd0000000-0000-4000-8000-000000000004'),
  ('e7000000-0000-4000-8000-000000000005', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000002', '2026-09-08', 'excused', 'Local fixture attendance.', 'd0000000-0000-4000-8000-000000000004')
ON CONFLICT (student_id, course_id, date) DO UPDATE SET status = EXCLUDED.status,
  notes = EXCLUDED.notes, recorded_by = EXCLUDED.recorded_by;

INSERT INTO public.grades
  (id, student_id, course_id, semester, semester_id, coursework, midterm,
   practical, final_exam, total, grade_letter, gpa_points, is_published, published_at)
VALUES
  ('e8000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000001', 'Spring 2026', 'e1000000-0000-4000-8000-000000000002', 18, 17, 19, 36, 90, 'A', 4.0, true, now()),
  ('e8000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000002', 'Spring 2026', 'e1000000-0000-4000-8000-000000000002', 16, 15, NULL, 34, 82, 'B+', 3.3, true, now()),
  ('e8000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000011', 'c1000000-0000-4000-8000-000000000001', 'Spring 2026', 'e1000000-0000-4000-8000-000000000002', 15, 14, 17, 31, 77, 'B', 3.0, true, now())
ON CONFLICT (student_id, course_id, semester) DO UPDATE SET
  semester_id = EXCLUDED.semester_id, coursework = EXCLUDED.coursework,
  midterm = EXCLUDED.midterm, practical = EXCLUDED.practical,
  final_exam = EXCLUDED.final_exam, total = EXCLUDED.total,
  grade_letter = EXCLUDED.grade_letter, gpa_points = EXCLUDED.gpa_points,
  is_published = EXCLUDED.is_published, published_at = EXCLUDED.published_at;

INSERT INTO public.semester_gpa
  (id, student_id, semester, semester_id, total_credits, earned_credits,
   quality_points, semester_gpa, cumulative_gpa, cumulative_credits, is_official)
VALUES
  ('e9000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Spring 2026', 'e1000000-0000-4000-8000-000000000002', 6, 6, 21.9, 3.65, 3.65, 6, true),
  ('e9000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011', 'Spring 2026', 'e1000000-0000-4000-8000-000000000002', 3, 3, 9.0, 3.0, 3.0, 3, true)
ON CONFLICT (id) DO UPDATE SET total_credits = EXCLUDED.total_credits,
  earned_credits = EXCLUDED.earned_credits, quality_points = EXCLUDED.quality_points,
  semester_gpa = EXCLUDED.semester_gpa, cumulative_gpa = EXCLUDED.cumulative_gpa,
  cumulative_credits = EXCLUDED.cumulative_credits, is_official = EXCLUDED.is_official;

INSERT INTO public.action_plan_items
  (id, student_id, course_id, semester, semester_id, year, status, notes)
VALUES
  ('ea000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000003', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 2026, 'enrolled', 'Synthetic local fixture.'),
  ('ea000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'c1000000-0000-4000-8000-000000000004', 'Spring 2027', NULL, 2027, 'planned', 'Synthetic local fixture.'),
  ('ea000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000009', 'c1000000-0000-4000-8000-000000000002', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 2026, 'enrolled', 'Synthetic local fixture.')
ON CONFLICT (id) DO UPDATE SET student_id = EXCLUDED.student_id,
  course_id = EXCLUDED.course_id, semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id, year = EXCLUDED.year,
  status = EXCLUDED.status, notes = EXCLUDED.notes;

INSERT INTO public.registration_requests
  (id, student_id, advisor_id, semester, semester_id, status, advisor_notes)
VALUES
  ('eb000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'd0000000-0000-4000-8000-000000000007', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'pending', NULL),
  ('eb000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000009', 'd0000000-0000-4000-8000-000000000007', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'approved', 'Synthetic local approval fixture.')
ON CONFLICT (id) DO UPDATE SET advisor_id = EXCLUDED.advisor_id,
  semester_id = EXCLUDED.semester_id, status = EXCLUDED.status,
  advisor_notes = EXCLUDED.advisor_notes;

INSERT INTO public.registration_request_courses (id, request_id, course_id, section_name, sub_section_name)
VALUES
  ('ec000000-0000-4000-8000-000000000001', 'eb000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001', 'A', 'Lab 1'),
  ('ec000000-0000-4000-8000-000000000002', 'eb000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000002', 'A', NULL),
  ('ec000000-0000-4000-8000-000000000003', 'eb000000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000001', 'A', 'Lab 2')
ON CONFLICT (request_id, course_id) DO UPDATE SET
  section_name = EXCLUDED.section_name, sub_section_name = EXCLUDED.sub_section_name;

INSERT INTO public.office_hours (id, professor_id, day, start_time, end_time, location, is_walk_in, semester, semester_id)
VALUES
  ('ed000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 'monday', '13:00', '15:00', 'DEV-B-214', true, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001'),
  ('ed000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000004', 'wednesday', '10:00', '11:00', 'DEV-B-214', false, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001')
ON CONFLICT (id) DO UPDATE SET day = EXCLUDED.day, start_time = EXCLUDED.start_time,
  end_time = EXCLUDED.end_time, location = EXCLUDED.location,
  is_walk_in = EXCLUDED.is_walk_in, semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id;

INSERT INTO public.student_groups (id, professor_id, course_id, name, name_ar, description, max_students)
VALUES
  ('ee000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 'c1000000-0000-4000-8000-000000000001', 'Programming Study Group', 'مجموعة دراسة البرمجة', 'Local fixture for group management.', 20),
  ('ee000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000004', 'c1000000-0000-4000-8000-000000000003', 'Data Structures Lab', 'مختبر هياكل البيانات', 'Local fixture for group management.', 18)
ON CONFLICT (id) DO UPDATE SET professor_id = EXCLUDED.professor_id,
  course_id = EXCLUDED.course_id, name = EXCLUDED.name, name_ar = EXCLUDED.name_ar,
  description = EXCLUDED.description, max_students = EXCLUDED.max_students;

INSERT INTO public.group_members (id, group_id, student_id)
VALUES
  ('ef000000-0000-4000-8000-000000000001', 'ee000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008'),
  ('ef000000-0000-4000-8000-000000000002', 'ee000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000009'),
  ('ef000000-0000-4000-8000-000000000003', 'ee000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011'),
  ('ef000000-0000-4000-8000-000000000004', 'ee000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000012')
ON CONFLICT (group_id, student_id) DO NOTHING;

INSERT INTO public.department_projects (id, department_id, title_en, title_ar, description_en, description_ar, status)
VALUES
  ('f1000000-0000-4000-8000-000000000001', 'd2000000-0000-4000-8000-000000000001', 'Campus Mobility Study', 'دراسة التنقل داخل الحرم', 'Synthetic local project for department portal testing.', 'مشروع محلي تجريبي لاختبار بوابة القسم.', 'active'),
  ('f1000000-0000-4000-8000-000000000002', 'd2000000-0000-4000-8000-000000000001', 'Open Data Lab', 'مختبر البيانات المفتوحة', 'Synthetic local project record.', 'سجل مشروع تجريبي محلي.', 'completed')
ON CONFLICT (id) DO UPDATE SET title_en = EXCLUDED.title_en,
  title_ar = EXCLUDED.title_ar, description_en = EXCLUDED.description_en,
  description_ar = EXCLUDED.description_ar, status = EXCLUDED.status;

INSERT INTO public.announcements
  (id, author_id, college_id, department_id, course_id, title, title_ar, content, content_ar, priority, is_pinned)
VALUES
  ('f2000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000002', 'd1000000-0000-4000-8000-000000000001', NULL, NULL, 'Development Campus Notice', 'إعلان الحرم التجريبي', 'Synthetic local notice for dashboard testing.', 'إعلان تجريبي محلي لاختبار لوحة التحكم.', 'important', true),
  ('f2000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000004', NULL, 'd2000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001', 'Programming Lab Information', 'معلومات مختبر البرمجة', 'Synthetic local course notice.', 'إعلان مقرر تجريبي محلي.', 'normal', false),
  ('f2000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000004', NULL, 'd2000000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000003', 'Data Structures Office Hours', 'الساعات المكتبية لهياكل البيانات', 'Synthetic local course notice.', 'إعلان مقرر تجريبي محلي.', 'normal', false)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, title_ar = EXCLUDED.title_ar,
  content = EXCLUDED.content, content_ar = EXCLUDED.content_ar,
  priority = EXCLUDED.priority, is_pinned = EXCLUDED.is_pinned;

INSERT INTO public.posts (id, author_id, college_id, department_id, content, type, likes_count, comments_count, is_pinned)
VALUES
  ('f3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004', 'd1000000-0000-4000-8000-000000000001', 'd2000000-0000-4000-8000-000000000001', 'Development fixture: welcome to the local Computer Science community.', 'text', 2, 2, true),
  ('f3000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'd1000000-0000-4000-8000-000000000001', 'd2000000-0000-4000-8000-000000000001', 'Development fixture: share a study tip for this week.', 'text', 1, 1, false),
  ('f3000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000011', 'd1000000-0000-4000-8000-000000000001', 'd2000000-0000-4000-8000-000000000001', 'Development fixture: looking for a programming lab partner.', 'text', 0, 0, false)
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content,
  likes_count = EXCLUDED.likes_count, comments_count = EXCLUDED.comments_count,
  is_pinned = EXCLUDED.is_pinned;

INSERT INTO public.post_likes (post_id, user_id)
VALUES
  ('f3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008'),
  ('f3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000009'),
  ('f3000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011')
ON CONFLICT (post_id, user_id) DO NOTHING;

INSERT INTO public.post_comments (id, post_id, author_id, content)
VALUES
  ('f4000000-0000-4000-8000-000000000001', 'f3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Development fixture comment: thank you for the update.'),
  ('f4000000-0000-4000-8000-000000000002', 'f3000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000009', 'Development fixture comment: looking forward to the lab.'),
  ('f4000000-0000-4000-8000-000000000003', 'f3000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011', 'Development fixture comment: I will post my notes.')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content;

INSERT INTO public.forums (id, name, name_ar, description, category, is_active)
VALUES
  ('f5000000-0000-4000-8000-000000000001', 'Campus Community', 'مجتمع الحرم', 'General development discussion fixtures.', 'general', true),
  ('f5000000-0000-4000-8000-000000000002', 'Computer Science', 'علوم الحاسوب', 'Academic development discussion fixtures.', 'academic', true),
  ('f5000000-0000-4000-8000-000000000003', 'Student Feedback', 'آراء الطلاب', 'Feedback development fixtures.', 'feedback', true)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name, name_ar = EXCLUDED.name_ar,
  description = EXCLUDED.description, category = EXCLUDED.category,
  is_active = EXCLUDED.is_active;

INSERT INTO public.forum_posts (id, forum_id, author_id, title, content, is_pinned, reply_count)
VALUES
  ('f6000000-0000-4000-8000-000000000001', 'f5000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000004', 'How to prepare for the programming lab', 'Development fixture post: review the weekly exercises and bring questions.', true, 1),
  ('f6000000-0000-4000-8000-000000000002', 'f5000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Study group schedule', 'Development fixture post: suggest a time for a peer study session.', false, 0),
  ('f6000000-0000-4000-8000-000000000003', 'f5000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000011', 'Library opening hours', 'Development fixture question for testing discussions.', false, 0)
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title,
  content = EXCLUDED.content, is_pinned = EXCLUDED.is_pinned,
  reply_count = EXCLUDED.reply_count;

INSERT INTO public.invoices
  (id, student_id, semester, semester_id, description, description_ar, amount, currency, status, due_date, metadata)
VALUES
  ('f7000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Development tuition installment', 'قسط دراسي تجريبي', 12500, 'EGP', 'pending', current_date + 20, '{"fixture":"local-development"}'),
  ('f7000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Development laboratory fee', 'رسوم مختبر تجريبية', 850, 'EGP', 'pending', current_date + 35, '{"fixture":"local-development"}'),
  ('f7000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000009', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'Development tuition installment', 'قسط دراسي تجريبي', 12500, 'EGP', 'pending', current_date + 20, '{"fixture":"local-development"}')
ON CONFLICT (id) DO UPDATE SET description = EXCLUDED.description,
  description_ar = EXCLUDED.description_ar, amount = EXCLUDED.amount,
  currency = EXCLUDED.currency, status = EXCLUDED.status,
  due_date = EXCLUDED.due_date, metadata = EXCLUDED.metadata;

INSERT INTO public.invoice_schedules (id, parent_invoice, installment_num, amount, due_date, status)
VALUES
  ('f8000000-0000-4000-8000-000000000001', 'f7000000-0000-4000-8000-000000000001', 1, 6250, current_date + 20, 'pending'),
  ('f8000000-0000-4000-8000-000000000002', 'f7000000-0000-4000-8000-000000000001', 2, 6250, current_date + 60, 'pending'),
  ('f8000000-0000-4000-8000-000000000003', 'f7000000-0000-4000-8000-000000000002', 1, 850, current_date + 35, 'pending')
ON CONFLICT (parent_invoice, installment_num) DO UPDATE SET
  amount = EXCLUDED.amount, due_date = EXCLUDED.due_date, status = EXCLUDED.status;

INSERT INTO public.library_items
  (id, title, title_ar, author, author_ar, isbn, publisher, publish_year, category,
   item_type, description, description_ar, total_copies, available_copies, location_shelf, college_id)
VALUES
  ('f9000000-0000-4000-8000-000000000001', 'Algorithms: A Development Fixture', 'الخوارزميات: مادة تجريبية', 'Horus Development Fixture', 'مادة تطوير محلية', 'DEV-ISBN-0001', 'Local Development Press', 2025, 'Computer Science', 'book', 'Synthetic local catalog entry.', 'سجل فهرس محلي تجريبي.', 5, 4, 'DEV-CS-A1', 'd1000000-0000-4000-8000-000000000001'),
  ('f9000000-0000-4000-8000-000000000002', 'Journal of Local Test Data', 'مجلة بيانات الاختبار المحلية', 'Horus Development Fixture', 'مادة تطوير محلية', 'DEV-ISBN-0002', 'Local Development Press', 2026, 'Academic Journal', 'journal', 'Synthetic local catalog entry.', 'سجل فهرس محلي تجريبي.', 3, 3, 'DEV-LIB-B2', 'd1000000-0000-4000-8000-000000000001'),
  ('f9000000-0000-4000-8000-000000000003', 'Research Methods: Sample Record', 'مناهج البحث: سجل تجريبي', 'Horus Development Fixture', 'مادة تطوير محلية', 'DEV-ISBN-0003', 'Local Development Press', 2024, 'Research', 'research_paper', 'Synthetic local catalog entry.', 'سجل فهرس محلي تجريبي.', 1, 1, 'DEV-LIB-C1', 'd1000000-0000-4000-8000-000000000001')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, title_ar = EXCLUDED.title_ar,
  author = EXCLUDED.author, author_ar = EXCLUDED.author_ar, category = EXCLUDED.category,
  item_type = EXCLUDED.item_type, description = EXCLUDED.description,
  description_ar = EXCLUDED.description_ar, total_copies = EXCLUDED.total_copies,
  available_copies = EXCLUDED.available_copies, location_shelf = EXCLUDED.location_shelf;

INSERT INTO public.library_borrows
  (id, item_id, user_id, borrowed_at, due_date, status, fine_amount, issued_by, notes)
VALUES
  ('fa000000-0000-4000-8000-000000000001', 'f9000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', now() - interval '2 days', current_date + 12, 'borrowed', 0, 'd0000000-0000-4000-8000-000000000006', 'Synthetic local checkout fixture.'),
  ('fa000000-0000-4000-8000-000000000002', 'f9000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000009', now() - interval '20 days', current_date - 2, 'overdue', 0, 'd0000000-0000-4000-8000-000000000006', 'Synthetic local overdue fixture.')
ON CONFLICT (id) DO UPDATE SET item_id = EXCLUDED.item_id,
  user_id = EXCLUDED.user_id, due_date = EXCLUDED.due_date,
  status = EXCLUDED.status, fine_amount = EXCLUDED.fine_amount,
  issued_by = EXCLUDED.issued_by, notes = EXCLUDED.notes;

INSERT INTO public.library_reservations (id, item_id, user_id, expires_at, status)
VALUES
  ('fb000000-0000-4000-8000-000000000001', 'f9000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000008', now() + interval '3 days', 'active'),
  ('fb000000-0000-4000-8000-000000000002', 'f9000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011', now() + interval '5 days', 'active')
ON CONFLICT (id) DO UPDATE SET expires_at = EXCLUDED.expires_at,
  status = EXCLUDED.status;

INSERT INTO public.library_reading_history
  (id, item_id, user_id, last_page, progress_pct)
VALUES
  ('fc000000-0000-4000-8000-000000000001', 'f9000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 32, 24.00),
  ('fc000000-0000-4000-8000-000000000002', 'f9000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011', 11, 10.00)
ON CONFLICT (item_id, user_id) DO UPDATE SET last_page = EXCLUDED.last_page,
  progress_pct = EXCLUDED.progress_pct, last_read_at = now();

INSERT INTO public.scholarships
  (id, name_en, name_ar, description_en, description_ar, discount_pct)
VALUES
  ('fd000000-0000-4000-8000-000000000001', 'Development Merit Award', 'منحة التفوق التجريبية', 'Synthetic local scholarship fixture.', 'سجل منحة محلي تجريبي.', 20),
  ('fd000000-0000-4000-8000-000000000002', 'Development Access Grant', 'منحة الدعم التجريبية', 'Synthetic local scholarship fixture.', 'سجل منحة محلي تجريبي.', 35)
ON CONFLICT (id) DO UPDATE SET name_en = EXCLUDED.name_en,
  name_ar = EXCLUDED.name_ar, description_en = EXCLUDED.description_en,
  description_ar = EXCLUDED.description_ar, discount_pct = EXCLUDED.discount_pct;

INSERT INTO public.scholarship_applications
  (id, scholarship_id, student_id, semester, semester_id, status, reviewed_by, review_notes)
VALUES
  ('fe000000-0000-4000-8000-000000000001', 'fd000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'under_review', NULL, NULL),
  ('fe000000-0000-4000-8000-000000000002', 'fd000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000011', 'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'applied', NULL, NULL)
ON CONFLICT (id) DO UPDATE SET status = EXCLUDED.status,
  reviewed_by = EXCLUDED.reviewed_by, review_notes = EXCLUDED.review_notes;

INSERT INTO public.online_exams
  (id, course_id, title, description, total_marks, duration_minutes, passing_score,
   start_time, end_time, status, show_results, semester, semester_id, created_by)
VALUES
  ('fe100000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001',
   'Programming Fundamentals Practice', 'Synthetic local exam fixture.', 20, 30, 10,
   now() - interval '10 days', now() - interval '9 days', 'completed', true,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004'),
  ('fe100000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000003',
   'Data Structures Practice', 'Synthetic local exam fixture.', 20, 30, 10,
   now() + interval '10 days', now() + interval '10 days 1 hour', 'published', false,
   'Fall 2026', 'e1000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000004')
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  title = EXCLUDED.title, description = EXCLUDED.description,
  total_marks = EXCLUDED.total_marks, duration_minutes = EXCLUDED.duration_minutes,
  passing_score = EXCLUDED.passing_score, start_time = EXCLUDED.start_time,
  end_time = EXCLUDED.end_time, status = EXCLUDED.status,
  show_results = EXCLUDED.show_results, semester = EXCLUDED.semester,
  semester_id = EXCLUDED.semester_id, created_by = EXCLUDED.created_by;

INSERT INTO public.exam_questions
  (id, exam_id, question_text, question_type, marks, order_index, correct_answer, explanation)
VALUES
  ('fe200000-0000-4000-8000-000000000001', 'fe100000-0000-4000-8000-000000000001', 'Which structure follows last-in, first-out order?', 'mcq', 10, 1, NULL, 'Stack operations follow LIFO.'),
  ('fe200000-0000-4000-8000-000000000002', 'fe100000-0000-4000-8000-000000000001', 'What is the result of 2 + 3?', 'short_answer', 10, 2, '5', 'A simple arithmetic fixture question.'),
  ('fe200000-0000-4000-8000-000000000003', 'fe100000-0000-4000-8000-000000000002', 'Which structure efficiently removes from both ends?', 'mcq', 20, 1, NULL, 'A deque supports efficient operations at both ends.')
ON CONFLICT (id) DO UPDATE SET exam_id = EXCLUDED.exam_id,
  question_text = EXCLUDED.question_text, question_type = EXCLUDED.question_type,
  marks = EXCLUDED.marks, order_index = EXCLUDED.order_index,
  correct_answer = EXCLUDED.correct_answer, explanation = EXCLUDED.explanation;

INSERT INTO public.question_options (id, question_id, option_text, is_correct, order_index)
VALUES
  ('fe300000-0000-4000-8000-000000000001', 'fe200000-0000-4000-8000-000000000001', 'Stack', true, 1),
  ('fe300000-0000-4000-8000-000000000002', 'fe200000-0000-4000-8000-000000000001', 'Queue', false, 2),
  ('fe300000-0000-4000-8000-000000000003', 'fe200000-0000-4000-8000-000000000001', 'Graph', false, 3),
  ('fe300000-0000-4000-8000-000000000004', 'fe200000-0000-4000-8000-000000000003', 'Deque', true, 1),
  ('fe300000-0000-4000-8000-000000000005', 'fe200000-0000-4000-8000-000000000003', 'Binary tree', false, 2)
ON CONFLICT (id) DO UPDATE SET question_id = EXCLUDED.question_id,
  option_text = EXCLUDED.option_text, is_correct = EXCLUDED.is_correct,
  order_index = EXCLUDED.order_index;

INSERT INTO public.exam_attempts
  (id, exam_id, student_id, started_at, completed_at, score, is_passed)
VALUES
  ('fe400000-0000-4000-8000-000000000001', 'fe100000-0000-4000-8000-000000000001',
   'd0000000-0000-4000-8000-000000000008', now() - interval '10 days' + interval '15 minutes',
   now() - interval '10 days' + interval '45 minutes', 18, true),
  ('fe400000-0000-4000-8000-000000000002', 'fe100000-0000-4000-8000-000000000001',
   'd0000000-0000-4000-8000-000000000009', now() - interval '10 days' + interval '20 minutes',
   now() - interval '10 days' + interval '50 minutes', 14, true)
ON CONFLICT (id) DO UPDATE SET exam_id = EXCLUDED.exam_id,
  student_id = EXCLUDED.student_id, started_at = EXCLUDED.started_at,
  completed_at = EXCLUDED.completed_at, score = EXCLUDED.score,
  is_passed = EXCLUDED.is_passed;

INSERT INTO public.attempt_answers
  (id, attempt_id, question_id, selected_option, text_answer, is_correct, marks_awarded)
VALUES
  ('fe500000-0000-4000-8000-000000000001', 'fe400000-0000-4000-8000-000000000001', 'fe200000-0000-4000-8000-000000000001', 'fe300000-0000-4000-8000-000000000001', NULL, true, 10),
  ('fe500000-0000-4000-8000-000000000002', 'fe400000-0000-4000-8000-000000000001', 'fe200000-0000-4000-8000-000000000002', NULL, '5', true, 8),
  ('fe500000-0000-4000-8000-000000000003', 'fe400000-0000-4000-8000-000000000002', 'fe200000-0000-4000-8000-000000000001', 'fe300000-0000-4000-8000-000000000002', NULL, false, 0),
  ('fe500000-0000-4000-8000-000000000004', 'fe400000-0000-4000-8000-000000000002', 'fe200000-0000-4000-8000-000000000002', NULL, '5', true, 8)
ON CONFLICT (id) DO UPDATE SET attempt_id = EXCLUDED.attempt_id,
  question_id = EXCLUDED.question_id, selected_option = EXCLUDED.selected_option,
  text_answer = EXCLUDED.text_answer, is_correct = EXCLUDED.is_correct,
  marks_awarded = EXCLUDED.marks_awarded;

INSERT INTO public.virtual_classes
  (id, course_id, title, title_ar, provider, status, scheduled_at, duration_minutes,
   semester, semester_id, created_by, attendance_taken, max_participants, actual_attendees)
VALUES
  ('fe600000-0000-4000-8000-000000000001', 'c1000000-0000-4000-8000-000000000001',
   'Programming Lab Review', 'مراجعة مختبر البرمجة', 'jitsi', 'scheduled',
   now() + interval '3 days', 60, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001',
   'd0000000-0000-4000-8000-000000000004', false, 40, 0),
  ('fe600000-0000-4000-8000-000000000002', 'c1000000-0000-4000-8000-000000000003',
   'Data Structures Q&A', 'جلسة أسئلة هياكل البيانات', 'jitsi', 'ended',
   now() - interval '3 days', 45, 'Fall 2026', 'e1000000-0000-4000-8000-000000000001',
   'd0000000-0000-4000-8000-000000000004', true, 35, 2)
ON CONFLICT (id) DO UPDATE SET course_id = EXCLUDED.course_id,
  title = EXCLUDED.title, title_ar = EXCLUDED.title_ar,
  provider = EXCLUDED.provider, status = EXCLUDED.status,
  scheduled_at = EXCLUDED.scheduled_at, duration_minutes = EXCLUDED.duration_minutes,
  semester = EXCLUDED.semester, semester_id = EXCLUDED.semester_id,
  created_by = EXCLUDED.created_by, attendance_taken = EXCLUDED.attendance_taken,
  max_participants = EXCLUDED.max_participants,
  actual_attendees = EXCLUDED.actual_attendees;

INSERT INTO public.virtual_class_attendance
  (id, virtual_class_id, student_id, joined_at, left_at, duration_mins)
VALUES
  ('fe700000-0000-4000-8000-000000000001', 'fe600000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', now() - interval '3 days', now() - interval '3 days' + interval '42 minutes', 42),
  ('fe700000-0000-4000-8000-000000000002', 'fe600000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000009', now() - interval '3 days', now() - interval '3 days' + interval '38 minutes', 38)
ON CONFLICT (id) DO UPDATE SET virtual_class_id = EXCLUDED.virtual_class_id,
  student_id = EXCLUDED.student_id, joined_at = EXCLUDED.joined_at,
  left_at = EXCLUDED.left_at, duration_mins = EXCLUDED.duration_mins;

INSERT INTO public.notifications (id, user_id, title, title_ar, message, message_ar, type, action_url, metadata)
VALUES
  ('ff000000-0000-4000-8000-000000000001', 'd0000000-0000-4000-8000-000000000008', 'New course announcement', 'إعلان مقرر جديد', 'A local development announcement is available.', 'يتوفر إعلان تجريبي محلي.', 'info', '/announcements', '{"fixture":"local-development"}'),
  ('ff000000-0000-4000-8000-000000000002', 'd0000000-0000-4000-8000-000000000008', 'Registration needs review', 'التسجيل بانتظار المراجعة', 'Your local registration request is pending review.', 'طلب التسجيل التجريبي بانتظار المراجعة.', 'warning', '/registration', '{"fixture":"local-development"}'),
  ('ff000000-0000-4000-8000-000000000003', 'd0000000-0000-4000-8000-000000000009', 'Exam schedule updated', 'تم تحديث جدول الاختبارات', 'A local exam fixture is available.', 'يتوفر جدول اختبار تجريبي محلي.', 'success', '/exam-schedule', '{"fixture":"local-development"}'),
  ('ff000000-0000-4000-8000-000000000004', 'd0000000-0000-4000-8000-000000000011', 'Library reservation', 'حجز المكتبة', 'Your local fixture reservation is active.', 'الحجز التجريبي المحلي نشط.', 'info', '/library', '{"fixture":"local-development"}')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, title_ar = EXCLUDED.title_ar,
  message = EXCLUDED.message, message_ar = EXCLUDED.message_ar,
  type = EXCLUDED.type, action_url = EXCLUDED.action_url, metadata = EXCLUDED.metadata;

INSERT INTO public.notification_preferences (user_id)
SELECT id FROM public.profiles
WHERE id BETWEEN 'd0000000-0000-4000-8000-000000000001'::uuid
             AND 'd0000000-0000-4000-8000-000000000012'::uuid
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO public.user_preferences (user_id, locale, theme, timezone)
SELECT id, CASE WHEN id = 'd0000000-0000-4000-8000-000000000008'::uuid THEN 'en' ELSE 'ar' END,
       'system', 'Africa/Cairo'
FROM public.profiles
WHERE id BETWEEN 'd0000000-0000-4000-8000-000000000001'::uuid
             AND 'd0000000-0000-4000-8000-000000000012'::uuid
ON CONFLICT (user_id) DO UPDATE SET locale = EXCLUDED.locale,
  theme = EXCLUDED.theme, timezone = EXCLUDED.timezone;

-- Intentionally do not create payment_transactions or mark invoices paid:
-- payment completion must only come from a trusted payment provider workflow.
