CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS user_role AS $$
DECLARE
    user_roles user_role[];
BEGIN
    SELECT roles INTO user_roles FROM public.profiles WHERE id = auth.uid();

    IF 'super_admin' = ANY(user_roles) THEN
        RETURN 'super_admin'::user_role;
    ELSIF 'admin' = ANY(user_roles) THEN
        RETURN 'admin'::user_role;
    ELSIF 'it_support' = ANY(user_roles) THEN
        RETURN 'it_support'::user_role;
    ELSIF 'financial_auditor' = ANY(user_roles) THEN
        RETURN 'financial_auditor'::user_role;
    ELSIF array_length(user_roles, 1) > 0 THEN
        RETURN user_roles[1];
    ELSE
        RETURN 'student'::user_role;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER STABLE;

-- 2. Implement administrative RPCs for precise management

-- Toggle Status (Activate/Deactivate)
CREATE OR REPLACE FUNCTION public.admin_toggle_user_status(
    user_id UUID,
    is_active BOOLEAN
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin', 'it_support')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can toggle user status.';
    END IF;

    UPDATE public.profiles 
    SET is_active = admin_toggle_user_status.is_active,
        updated_at = now()
    WHERE id = admin_toggle_user_status.user_id;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), user_id, 'toggle_status', 'Status changed to ' || is_active::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Delete User
CREATE OR REPLACE FUNCTION public.admin_delete_user(
    target_user_id UUID,
    hard_delete BOOLEAN DEFAULT FALSE
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can delete users.';
    END IF;

    IF hard_delete THEN
        DELETE FROM auth.users WHERE id = target_user_id;
    ELSE
        UPDATE public.profiles 
        SET deleted_at = now(),
            is_active = FALSE,
            updated_at = now()
        WHERE id = target_user_id;
    END IF;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), target_user_id, 'delete', CASE WHEN hard_delete THEN 'Hard delete' ELSE 'Soft delete' END);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Toggle Verification
CREATE OR REPLACE FUNCTION public.admin_toggle_verification(
    user_id UUID,
    is_verified BOOLEAN
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin', 'it_support')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can toggle verification.';
    END IF;

    UPDATE public.profiles 
    SET is_verified = admin_toggle_verification.is_verified,
        updated_at = now()
    WHERE id = admin_toggle_verification.user_id;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), user_id, 'update', 'Verification toggled to ' || is_verified::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Toggle Ban
CREATE OR REPLACE FUNCTION public.admin_toggle_ban(
    user_id UUID,
    is_banned BOOLEAN
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can toggle ban status.';
    END IF;

    UPDATE public.profiles 
    SET is_banned = admin_toggle_ban.is_banned,
        updated_at = now()
    WHERE id = admin_toggle_ban.user_id;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), user_id, 'update', 'Ban status toggled to ' || is_banned::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update Tags
CREATE OR REPLACE FUNCTION public.admin_update_tags(
    user_id UUID,
    tags TEXT[]
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin', 'it_support')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can update tags.';
    END IF;

    UPDATE public.profiles 
    SET tags = admin_update_tags.tags,
        updated_at = now()
    WHERE id = admin_update_tags.user_id;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), user_id, 'update', 'Tags updated');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update Warning Level
CREATE OR REPLACE FUNCTION public.admin_update_warning_level(
    user_id UUID,
    level INT
) RETURNS VOID AS $$
BEGIN
    IF NOT (public.get_my_role() IN ('super_admin', 'admin', 'it_support')) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins can update warning levels.';
    END IF;

    UPDATE public.profiles 
    SET warning_level = admin_update_warning_level.level,
        updated_at = now()
    WHERE id = admin_update_warning_level.user_id;

    INSERT INTO public.audit_logs (performed_by, target_user, action, notes)
    VALUES (auth.uid(), user_id, 'update', 'Warning level set to ' || level::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;