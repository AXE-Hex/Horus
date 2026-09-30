-- New self signups receive only the canonical guest role. Authorization data
-- in raw_user_meta_data is intentionally ignored.
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
DECLARE
  guest_role_id uuid;
BEGIN
  SELECT id INTO guest_role_id
  FROM public.role_definitions
  WHERE code = 'guest' AND is_active;

  IF guest_role_id IS NULL THEN
    RAISE EXCEPTION 'active guest role is required for self signup';
  END IF;

  INSERT INTO public.profiles (
    id, email, full_name, full_name_ar, is_active, created_at, updated_at
  ) VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NULLIF(NEW.raw_user_meta_data->>'full_name', ''), split_part(NEW.email, '@', 1)),
    NEW.raw_user_meta_data->>'full_name_ar',
    TRUE,
    now(),
    now()
  );

  INSERT INTO public.user_roles (user_id, role_id)
  VALUES (NEW.id, guest_role_id);

  INSERT INTO public.user_preferences (user_id) VALUES (NEW.id);
  INSERT INTO public.notification_preferences (user_id) VALUES (NEW.id);

  RETURN NEW;
END;
$$;

-- Guest accounts have no directory/profile access. Public university content
-- is surfaced through explicitly public routes and data contracts.
DELETE FROM public.role_permissions rp
USING public.role_definitions rd, public.permissions p
WHERE rp.role_id = rd.id
  AND rp.permission_id = p.id
  AND rd.code = 'guest'
  AND p.code IN (
    'profiles.read', 'grades.read', 'attendance.read', 'finance.read',
    'courses.enroll', 'materials.read', 'registration.manage',
    'registration.review', 'students.progress.read', 'forums.access',
    'ratings.submit', 'users.manage_roles', 'notifications.read'
  );

DROP POLICY IF EXISTS profiles_select_active ON public.profiles;
CREATE POLICY profiles_select_active ON public.profiles FOR SELECT TO authenticated
  USING (
    id = (SELECT auth.uid())
    OR (public.has_permission('profiles.read') AND is_active
        AND NOT is_banned AND deleted_at IS NULL)
  );

CREATE OR REPLACE VIEW public.profile_directory
WITH (security_invoker = false)
AS
SELECT p.id, p.full_name, p.full_name_ar, p.avatar_url, p.college_id,
       p.department_id, p.created_at,
       COALESCE(
         array_agg(DISTINCT rd.code ORDER BY rd.code)
           FILTER (WHERE rd.code IS NOT NULL),
         ARRAY[]::text[]
       ) AS role_codes
FROM public.profiles p
LEFT JOIN public.user_roles ur
  ON ur.user_id = p.id AND (ur.expires_at IS NULL OR ur.expires_at > now())
LEFT JOIN public.role_definitions rd
  ON rd.id = ur.role_id AND rd.is_active
WHERE p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
  AND public.has_permission('profiles.read')
GROUP BY p.id;
REVOKE ALL ON public.profile_directory FROM PUBLIC, anon;
GRANT SELECT ON public.profile_directory TO authenticated;

COMMENT ON FUNCTION public.handle_new_user() IS
  'Creates a least-privilege guest profile for self-signups; role metadata is never used for authorization.';
