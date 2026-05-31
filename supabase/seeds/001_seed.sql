-- ============================================================================
--  001_seed.sql — SYSTEM SEED DATA
--  Purpose : Initial system data required for the application to function.
--            Run AFTER all migrations are complete.
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. ROLE DEFINITIONS
-- ══════════════════════════════════════════════════════════════════════════════

INSERT INTO public.role_definitions (code, name_en, name_ar, priority, is_active) VALUES
-- Academic Leadership
('rector', 'University Rector', 'رئيس الجامعة', 10, true),
('dean', 'Dean', 'عميد الكلية', 11, true),
('department_head', 'Head of Department', 'رئيس القسم', 12, true),
('assistant_hod', 'Assistant HOD', 'مساعد رئيس القسم', 13, true),

-- Faculty
('professor', 'Professor', 'أستاذ', 20, true),
('lecturer', 'Lecturer', 'مدرس', 21, true),
('teaching_assistant', 'Teaching Assistant', 'معيد', 22, true),

-- Students
('freshman', 'Freshman', 'طالب مستجد', 90, true),
('regular_student', 'Regular Student', 'طالب منتظم', 91, true),
('student', 'Student', 'طالب', 99, true)
ON CONFLICT (code) DO NOTHING;

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. ENCRYPTION KEYS (Example seed, MUST be replaced in production)
-- ══════════════════════════════════════════════════════════════════════════════

-- WARNING: In a real system, these would be injected via environment variables
-- or a secure vault mechanism.
INSERT INTO public.encryption_keys (context, key_hash) VALUES
('national_id', 'DEV_DUMMY_KEY_NEVER_USE_IN_PROD_111111111111'),
('bank_account', 'DEV_DUMMY_KEY_NEVER_USE_IN_PROD_222222222222')
ON CONFLICT (context) DO NOTHING;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. SEMESTERS
-- ══════════════════════════════════════════════════════════════════════════════

INSERT INTO public.semesters (code, name_en, name_ar, academic_year, start_date, end_date, is_current) VALUES
('fall_2025', 'Fall 2025', 'خريف 2025', '2025-2026', '2025-09-01', '2026-01-15', true),
('spring_2026', 'Spring 2026', 'ربيع 2026', '2025-2026', '2026-02-15', '2026-06-30', false)
ON CONFLICT (code) DO NOTHING;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. COLLEGES
-- ══════════════════════════════════════════════════════════════════════════════

INSERT INTO public.colleges (code, name_en, name_ar, description, established) VALUES
('ENG', 'Faculty of Engineering', 'كلية الهندسة', 'Leading engineering faculty.', 2005),
('MED', 'Faculty of Medicine', 'كلية الطب', 'Top tier medical education.', 2007),
('CS', 'Faculty of Computer Science', 'كلية الحاسبات', 'Modern CS curriculum.', 2010),
('BUS', 'Faculty of Business', 'كلية إدارة الأعمال', 'Business and management.', 2005)
ON CONFLICT (code) DO NOTHING;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. DEPARTMENTS (Requires Colleges to exist)
-- ══════════════════════════════════════════════════════════════════════════════

DO $$
DECLARE
  eng_id UUID;
  cs_id UUID;
BEGIN
  -- Get college IDs
  SELECT id INTO eng_id FROM public.colleges WHERE code = 'ENG';
  SELECT id INTO cs_id FROM public.colleges WHERE code = 'CS';

  -- Engineering Depts
  IF eng_id IS NOT NULL THEN
    INSERT INTO public.departments (college_id, code, name_en, name_ar) VALUES
    (eng_id, 'ENG-CIVIL', 'Civil Engineering', 'الهندسة المدنية'),
    (eng_id, 'ENG-MECH', 'Mechanical Engineering', 'الهندسة الميكانيكية'),
    (eng_id, 'ENG-ARCH', 'Architecture', 'هندسة معمارية')
    ON CONFLICT (code) DO NOTHING;
  END IF;

  -- CS Depts
  IF cs_id IS NOT NULL THEN
    INSERT INTO public.departments (college_id, code, name_en, name_ar) VALUES
    (cs_id, 'CS-SE', 'Software Engineering', 'هندسة البرمجيات'),
    (cs_id, 'CS-AI', 'Artificial Intelligence', 'الذكاء الاصطناعي'),
    (cs_id, 'CS-CYBER', 'Cyber Security', 'الأمن السيبراني')
    ON CONFLICT (code) DO NOTHING;
  END IF;
END $$;
