-- ---------------------------------------------------------------------------
-- 🚀 Developed by the GT-AXE Team
-- 👤 Signature: Axe
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER;

DROP POLICY IF EXISTS "Users can view all active profiles" ON public.profiles;
CREATE POLICY "Users can view all active profiles" ON public.profiles 
FOR SELECT USING (
  deleted_at IS NULL 
  OR (public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor'))
);

DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles 
FOR UPDATE USING (
  auth.uid() = id 
  OR (public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor'))
);

DROP POLICY IF EXISTS "Admins can manage profiles" ON public.profiles;
CREATE POLICY "Admins can manage profiles" ON public.profiles 
FOR ALL USING (
  public.get_my_role() IN ('super_admin', 'admin', 'it_support', 'financial_auditor')
);

GRANT ALL ON TABLE public.profiles TO authenticated;

SELECT 'Admin permissions updated. Super Admins can now manage all user accounts.' as status;
