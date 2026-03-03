ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS roles user_role[] NOT NULL DEFAULT '{student}';
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS national_id TEXT UNIQUE;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS nationality TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS phone TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS college_id UUID;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS department_id UUID;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'colleges') THEN
    IF NOT EXISTS (
      SELECT 1 FROM information_schema.table_constraints
      WHERE table_name = 'profiles' AND constraint_name = 'profiles_college_id_fkey'
    ) THEN
      ALTER TABLE public.profiles ADD CONSTRAINT profiles_college_id_fkey
        FOREIGN KEY (college_id) REFERENCES colleges(id);
    END IF;
  END IF;
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'departments') THEN
    IF NOT EXISTS (
      SELECT 1 FROM information_schema.table_constraints
      WHERE table_name = 'profiles' AND constraint_name = 'profiles_department_id_fkey'
    ) THEN
      ALTER TABLE public.profiles ADD CONSTRAINT profiles_department_id_fkey
        FOREIGN KEY (department_id) REFERENCES departments(id);
    END IF;
  END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'profiles' AND column_name = 'role') THEN
        UPDATE public.profiles 
        SET roles = ARRAY[role::user_role]
        WHERE roles = '{student}' OR roles IS NULL;

    END IF;
END $$;

UPDATE auth.users u
SET raw_user_meta_data = raw_user_meta_data || jsonb_build_object('roles', ARRAY[raw_user_meta_data->>'role'])
WHERE raw_user_meta_data->>'role' IS NOT NULL 
  AND raw_user_meta_data->'roles' IS NULL;

CREATE OR REPLACE FUNCTION public.admin_create_user(
  email TEXT,
  password TEXT,
  full_name TEXT,
  roles user_role[],
  student_id TEXT DEFAULT NULL,
  national_id TEXT DEFAULT NULL,
  nationality TEXT DEFAULT NULL,
  phone TEXT DEFAULT NULL,
  college_id UUID DEFAULT NULL,
  department_id UUID DEFAULT NULL
) RETURNS UUID AS $$
DECLARE
  new_user_id UUID;
  current_user_roles user_role[];
BEGIN
  -- Security check
  SELECT p.roles INTO current_user_roles FROM public.profiles p WHERE p.id = auth.uid();
  IF NOT (current_user_roles && ARRAY['super_admin', 'admin', 'it_support']::user_role[]) THEN
    RAISE EXCEPTION 'Unauthorized: Only admins can create users.';
  END IF;

  INSERT INTO auth.users (
    id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
    confirmation_token, email_change, email_change_token_new, recovery_token
  ) VALUES (
    gen_random_uuid(), 'authenticated', 'authenticated', admin_create_user.email,
    crypt(admin_create_user.password, gen_salt('bf', 10)), now(),
    '{"provider":"email","providers":["email"]}',
    jsonb_build_object('full_name', admin_create_user.full_name, 'roles', admin_create_user.roles::text[]),
    now(), now(),
    '', '', '', ''  
  ) RETURNING id INTO new_user_id;

  UPDATE public.profiles SET
    student_id = admin_create_user.student_id,
    national_id = admin_create_user.national_id,
    nationality = admin_create_user.nationality,
    phone = admin_create_user.phone,
    college_id = admin_create_user.college_id,
    department_id = admin_create_user.department_id,
    roles = admin_create_user.roles
  WHERE id = new_user_id;

  RETURN new_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;