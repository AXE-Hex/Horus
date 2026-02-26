-- ---------------------------------------------------------------------------
-- 🚀 Developed by the GT-AXE Team
-- 👤 Signature: Axe
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.admin_create_user(
  email TEXT,
  password TEXT,
  full_name TEXT,
  role user_role
) RETURNS UUID AS $$
DECLARE
  new_user_id UUID;
  current_user_role user_role;
BEGIN

  SELECT p.role INTO current_user_role FROM public.profiles p WHERE p.id = auth.uid();
  IF current_user_role NOT IN ('super_admin', 'admin', 'it_support', 'financial_auditor') THEN
    RAISE EXCEPTION 'Unauthorized: Only admins can create users.';
  END IF;

  INSERT INTO auth.users (
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    raw_app_meta_data,
    raw_user_meta_data,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
  ) VALUES (
    gen_random_uuid(),
    'authenticated',
    'authenticated',
    admin_create_user.email,
    crypt(admin_create_user.password, gen_salt('bf', 10)),
    now(),
    '{"provider":"email","providers":["email"]}',
    jsonb_build_object('full_name', admin_create_user.full_name, 'role', admin_create_user.role::text),
    now(),
    now(),
    '',
    '',
    '',
    ''
  ) RETURNING id INTO new_user_id;

  RETURN new_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.admin_toggle_user_status(
  user_id UUID,
  is_active BOOLEAN
) RETURNS VOID AS $$
DECLARE
  current_user_role user_role;
BEGIN
  SELECT p.role INTO current_user_role FROM public.profiles p WHERE p.id = auth.uid();
  IF current_user_role NOT IN ('super_admin', 'admin', 'it_support', 'financial_auditor') THEN
    RAISE EXCEPTION 'Unauthorized.';
  END IF;

  UPDATE public.profiles 
  SET is_active = admin_toggle_user_status.is_active,
      updated_at = now()
  WHERE id = admin_toggle_user_status.user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE FUNCTION public.admin_delete_user(
  target_user_id UUID,
  hard_delete BOOLEAN DEFAULT FALSE
) RETURNS VOID AS $$
DECLARE
  current_user_role user_role;
BEGIN
  SELECT p.role INTO current_user_role FROM public.profiles p WHERE p.id = auth.uid();
  IF current_user_role NOT IN ('super_admin', 'admin', 'it_support', 'financial_auditor') THEN
    RAISE EXCEPTION 'Unauthorized.';
  END IF;

  IF hard_delete THEN
    DELETE FROM auth.users WHERE id = target_user_id;
  ELSE
    UPDATE public.profiles 
    SET deleted_at = now() 
    WHERE id = target_user_id;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

SELECT 'Admin API functions deployed successfully.' as status;
