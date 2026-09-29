-- Phase 5: reproducible Storage buckets and access policies.
-- Object names carry the ownership/scope path; authorization is evaluated
-- from auth.uid() and the canonical permission/course/conversation relations.

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('avatars', 'avatars', true, 5242880,
   ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('post_media', 'post_media', false, 15728640,
   ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']),
  ('chat_media', 'chat_media', false, 26214400,
   ARRAY['image/jpeg', 'image/png', 'image/webp', 'audio/mpeg', 'audio/ogg',
         'audio/webm', 'video/mp4', 'video/webm']),
  ('course_files', 'course_files', false, 52428800,
   ARRAY['application/pdf', 'application/msword',
         'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
         'application/vnd.openxmlformats-officedocument.presentationml.presentation',
         'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
         'text/plain', 'image/jpeg', 'image/png', 'image/webp', 'video/mp4',
         'video/webm'])
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  public = EXCLUDED.public,
  file_size_limit = EXCLUDED.file_size_limit,
  allowed_mime_types = EXCLUDED.allowed_mime_types;

-- Keep function resolution controlled, and bind every scope lookup to the
-- authenticated caller instead of trusting IDs carried in an object path.
CREATE OR REPLACE FUNCTION public.can_access_storage_conversation(p_conversation_id text)
RETURNS boolean
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
DECLARE
  v_conversation_id uuid;
BEGIN
  IF (SELECT auth.uid()) IS NULL OR p_conversation_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' THEN
    RETURN false;
  END IF;
  v_conversation_id := p_conversation_id::uuid;
  RETURN EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = v_conversation_id
      AND cm.user_id = (SELECT auth.uid())
  );
END;
$$;
REVOKE ALL ON FUNCTION public.can_access_storage_conversation(text)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.can_access_storage_conversation(text)
  TO authenticated;

CREATE OR REPLACE FUNCTION public.can_upload_storage_course_file(p_course_id text)
RETURNS boolean
LANGUAGE plpgsql
STABLE
SECURITY DEFINER
SET search_path = pg_catalog, public, auth
AS $$
DECLARE
  v_course_id uuid;
BEGIN
  IF (SELECT auth.uid()) IS NULL OR p_course_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
     OR NOT public.has_permission('materials.upload') THEN
    RETURN false;
  END IF;
  v_course_id := p_course_id::uuid;
  RETURN public.can_teach_course(v_course_id)
    OR public.can_manage_course(v_course_id);
END;
$$;
REVOKE ALL ON FUNCTION public.can_upload_storage_course_file(text)
  FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.can_upload_storage_course_file(text)
  TO authenticated;

-- Public avatar reads are intentional. Writes are owner-path scoped.
-- Remove legacy policies recorded by 001_reset.sql as well: they may still
-- exist when this forward migration is applied to an established database.
DROP POLICY IF EXISTS "post_media_select" ON storage.objects;
DROP POLICY IF EXISTS "post_media_insert" ON storage.objects;
DROP POLICY IF EXISTS "post_media_update" ON storage.objects;
DROP POLICY IF EXISTS "post_media_delete" ON storage.objects;
DROP POLICY IF EXISTS "chat_media_auth_view" ON storage.objects;
DROP POLICY IF EXISTS "chat_media_auth_upload" ON storage.objects;
DROP POLICY IF EXISTS "chat_media_own_delete" ON storage.objects;
DROP POLICY IF EXISTS "Public Access for post_media" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated users can upload post_media" ON storage.objects;
DROP POLICY IF EXISTS "Users can update their own post_media" ON storage.objects;
DROP POLICY IF EXISTS "Users can delete their own post_media" ON storage.objects;
DROP POLICY IF EXISTS avatars_public_read ON storage.objects;
DROP POLICY IF EXISTS avatars_owner_insert ON storage.objects;
DROP POLICY IF EXISTS avatars_owner_update ON storage.objects;
DROP POLICY IF EXISTS avatars_owner_delete ON storage.objects;
CREATE POLICY avatars_public_read ON storage.objects
  FOR SELECT TO public USING (bucket_id = 'avatars');
CREATE POLICY avatars_owner_insert ON storage.objects
  FOR INSERT TO authenticated WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );
CREATE POLICY avatars_owner_update ON storage.objects
  FOR UPDATE TO authenticated USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  ) WITH CHECK (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );
CREATE POLICY avatars_owner_delete ON storage.objects
  FOR DELETE TO authenticated USING (
    bucket_id = 'avatars'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );

DROP POLICY IF EXISTS post_media_public_read ON storage.objects;
DROP POLICY IF EXISTS post_media_visible_post_read ON storage.objects;
DROP POLICY IF EXISTS post_media_owner_insert ON storage.objects;
DROP POLICY IF EXISTS post_media_owner_update ON storage.objects;
DROP POLICY IF EXISTS post_media_owner_delete ON storage.objects;
CREATE POLICY post_media_visible_post_read ON storage.objects
  FOR SELECT TO authenticated USING (
    bucket_id = 'post_media'
    AND ((storage.foldername(name))[1] = (SELECT auth.uid())::text
      OR EXISTS (
        SELECT 1 FROM public.posts p, unnest(p.media_urls) AS stored_media
        WHERE regexp_replace(stored_media, '^.*/post_media/', '') = storage.objects.name
      ))
  );
CREATE POLICY post_media_owner_insert ON storage.objects
  FOR INSERT TO authenticated WITH CHECK (
    bucket_id = 'post_media'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
    AND public.has_permission('posts.create')
  );
CREATE POLICY post_media_owner_update ON storage.objects
  FOR UPDATE TO authenticated USING (
    bucket_id = 'post_media'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
    AND public.has_permission('posts.create')
  ) WITH CHECK (
    bucket_id = 'post_media'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
    AND public.has_permission('posts.create')
  );
CREATE POLICY post_media_owner_delete ON storage.objects
  FOR DELETE TO authenticated USING (
    bucket_id = 'post_media'
    AND (storage.foldername(name))[1] = (SELECT auth.uid())::text
  );

-- Private chat objects use {conversation_id}/{uploader_id}/{filename}. Every
-- operation rechecks current membership, and mutations are uploader scoped.
DROP POLICY IF EXISTS chat_media_member_read ON storage.objects;
DROP POLICY IF EXISTS chat_media_member_insert ON storage.objects;
DROP POLICY IF EXISTS chat_media_owner_update ON storage.objects;
DROP POLICY IF EXISTS chat_media_owner_delete ON storage.objects;
CREATE POLICY chat_media_member_read ON storage.objects
  FOR SELECT TO authenticated USING (
    bucket_id = 'chat_media'
    AND public.can_access_storage_conversation((storage.foldername(name))[1])
  );
CREATE POLICY chat_media_member_insert ON storage.objects
  FOR INSERT TO authenticated WITH CHECK (
    bucket_id = 'chat_media'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_access_storage_conversation((storage.foldername(name))[1])
  );
CREATE POLICY chat_media_owner_update ON storage.objects
  FOR UPDATE TO authenticated USING (
    bucket_id = 'chat_media'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_access_storage_conversation((storage.foldername(name))[1])
  ) WITH CHECK (
    bucket_id = 'chat_media'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_access_storage_conversation((storage.foldername(name))[1])
  );
CREATE POLICY chat_media_owner_delete ON storage.objects
  FOR DELETE TO authenticated USING (
    bucket_id = 'chat_media'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_access_storage_conversation((storage.foldername(name))[1])
  );

-- Private course objects use {course_id}/{uploader_id}/{filename}. Downloads
-- require a visible shared_files row, so course scope and is_public are taken
-- from database authorization, never from metadata sent by the Storage client.
DROP POLICY IF EXISTS course_files_scoped_read ON storage.objects;
DROP POLICY IF EXISTS course_files_teacher_insert ON storage.objects;
DROP POLICY IF EXISTS course_files_owner_update ON storage.objects;
DROP POLICY IF EXISTS course_files_owner_delete ON storage.objects;
CREATE POLICY course_files_scoped_read ON storage.objects
  FOR SELECT TO authenticated USING (
    bucket_id = 'course_files'
    AND EXISTS (
      SELECT 1 FROM public.shared_files sf
      WHERE sf.file_path = storage.objects.name
        AND sf.deleted_at IS NULL
        AND (sf.uploader_id = (SELECT auth.uid())
          OR (sf.is_public AND sf.course_id IS NOT NULL
            AND public.can_access_course(sf.course_id)))
    )
  );
CREATE POLICY course_files_teacher_insert ON storage.objects
  FOR INSERT TO authenticated WITH CHECK (
    bucket_id = 'course_files'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  );
CREATE POLICY course_files_owner_update ON storage.objects
  FOR UPDATE TO authenticated USING (
    bucket_id = 'course_files'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  ) WITH CHECK (
    bucket_id = 'course_files'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  );
CREATE POLICY course_files_owner_delete ON storage.objects
  FOR DELETE TO authenticated USING (
    bucket_id = 'course_files'
    AND (storage.foldername(name))[2] = (SELECT auth.uid())::text
    AND public.can_upload_storage_course_file((storage.foldername(name))[1])
  );

COMMENT ON FUNCTION public.can_access_storage_conversation(text) IS
  'Storage authorization helper bound to auth.uid(); grants access only while the caller is a current conversation member.';
COMMENT ON FUNCTION public.can_upload_storage_course_file(text) IS
  'Storage authorization helper bound to auth.uid(); validates a course path and the canonical upload permission plus course assignment.';
