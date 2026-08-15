-- ============================================================================
--  FILE 9 — SECURITY HARDENING PATCH
--  Purpose : Prevent privilege escalation by protecting the `roles` column
--            on `profiles` from being modified by non-admin users.
--  Run     : Execute this AFTER all other files.
-- ============================================================================

-- ════════════════════════════════════════════════════════════════════════════
-- 1. TRIGGER: Protect `roles` column from self-modification
-- ════════════════════════════════════════════════════════════════════════════
-- This trigger fires BEFORE UPDATE on `profiles`.
-- If the `roles` array is being changed and the current user is NOT an admin,
-- the update is rejected. This prevents privilege escalation via RLS bypass.

CREATE OR REPLACE FUNCTION public.protect_roles_column()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  caller_role TEXT;
BEGIN
  -- If roles are not being changed, allow the update
  IF NEW.roles IS NOT DISTINCT FROM OLD.roles THEN
    RETURN NEW;
  END IF;

  -- Get the caller's current role
  caller_role := public.get_my_role();

  -- Only super_admin, admin, and it_support can change roles
  IF caller_role NOT IN ('super_admin', 'admin', 'it_support') THEN
    -- Silently revert the roles change (don't expose internals via error message)
    NEW.roles := OLD.roles;
  END IF;

  RETURN NEW;
END;
$$;

-- Drop existing trigger if any, then create
DROP TRIGGER IF EXISTS protect_roles_on_update ON public.profiles;
CREATE TRIGGER protect_roles_on_update
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.protect_roles_column();

-- ════════════════════════════════════════════════════════════════════════════
-- 2. Also protect `warning_level` and `is_banned` from self-modification
-- ════════════════════════════════════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.protect_admin_columns()
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  caller_role TEXT;
BEGIN
  caller_role := public.get_my_role();

  -- If the caller is an admin, allow all changes
  IF caller_role IN ('super_admin', 'admin', 'it_support') THEN
    RETURN NEW;
  END IF;

  -- Revert admin-only columns to their original values
  NEW.warning_level := OLD.warning_level;
  NEW.is_banned     := OLD.is_banned;
  NEW.is_verified   := OLD.is_verified;
  NEW.is_active     := OLD.is_active;
  NEW.deleted_at    := OLD.deleted_at;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS protect_admin_columns_on_update ON public.profiles;
CREATE TRIGGER protect_admin_columns_on_update
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.protect_admin_columns();
