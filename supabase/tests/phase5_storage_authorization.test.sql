BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();

INSERT INTO auth.users (id, aud, role, email, raw_app_meta_data, raw_user_meta_data)
VALUES
  ('50000000-0000-4000-8000-000000000001', 'authenticated', 'authenticated', 'p5-student-a@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('50000000-0000-4000-8000-000000000002', 'authenticated', 'authenticated', 'p5-student-b@example.invalid', '{"provider":"email","providers":["email"]}', '{}'),
  ('50000000-0000-4000-8000-000000000003', 'authenticated', 'authenticated', 'p5-professor@example.invalid', '{"provider":"email","providers":["email"]}', '{}');

INSERT INTO public.colleges (id, code, name_en, name_ar)
VALUES ('51000000-0000-4000-8000-000000000001', 'P5', 'P5 College', 'كلية ٥'),
       ('51000000-0000-4000-8000-000000000002', 'P5B', 'P5 College B', 'كلية ٥ ب');
INSERT INTO public.departments (id, college_id, code, name_en, name_ar)
VALUES ('52000000-0000-4000-8000-000000000001', '51000000-0000-4000-8000-000000000001', 'P5D', 'P5 Department', 'قسم ٥'),
       ('52000000-0000-4000-8000-000000000002', '51000000-0000-4000-8000-000000000002', 'P5DB', 'P5 Department B', 'قسم ٥ ب');
UPDATE public.profiles
SET college_id = '51000000-0000-4000-8000-000000000001',
    department_id = '52000000-0000-4000-8000-000000000001'
WHERE id IN ('50000000-0000-4000-8000-000000000001',
             '50000000-0000-4000-8000-000000000003');
UPDATE public.profiles
SET college_id = '51000000-0000-4000-8000-000000000002',
    department_id = '52000000-0000-4000-8000-000000000002'
WHERE id = '50000000-0000-4000-8000-000000000002';
DELETE FROM public.user_roles WHERE user_id IN (
  '50000000-0000-4000-8000-000000000001',
  '50000000-0000-4000-8000-000000000002',
  '50000000-0000-4000-8000-000000000003');
INSERT INTO public.user_roles (user_id, role_id)
SELECT v.user_id, rd.id
FROM (VALUES
  ('50000000-0000-4000-8000-000000000001'::uuid, 'class_representative'),
  ('50000000-0000-4000-8000-000000000002'::uuid, 'regular_student'),
  ('50000000-0000-4000-8000-000000000003'::uuid, 'professor')
) AS v(user_id, role_code)
JOIN public.role_definitions rd ON rd.code = v.role_code;

INSERT INTO public.courses (id, department_id, code, name_en, name_ar, professor_id)
VALUES ('53000000-0000-4000-8000-000000000001', '52000000-0000-4000-8000-000000000001', 'P5C', 'P5 Course', 'مقرر ٥', '50000000-0000-4000-8000-000000000003');
INSERT INTO public.enrollments (student_id, course_id, semester, status)
VALUES ('50000000-0000-4000-8000-000000000001', '53000000-0000-4000-8000-000000000001', 'p5', 'approved');
INSERT INTO public.conversations (id, created_by)
VALUES ('54000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000003');
INSERT INTO public.conversation_members (conversation_id, user_id)
VALUES ('54000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001'),
       ('54000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000003');
INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
VALUES ('avatars', '50000000-0000-4000-8000-000000000002/avatar.png',
        '50000000-0000-4000-8000-000000000002', '50000000-0000-4000-8000-000000000002', '{"mimetype":"image/png"}');

SELECT extensions.ok((SELECT public FROM storage.buckets WHERE id = 'avatars'), 'avatars bucket is public');
SELECT extensions.ok(NOT (SELECT public FROM storage.buckets WHERE id = 'post_media'), 'post_media bucket is private');
SELECT extensions.ok(NOT (SELECT public FROM storage.buckets WHERE id = 'chat_media'), 'chat_media bucket is private');
SELECT extensions.ok(NOT (SELECT public FROM storage.buckets WHERE id = 'course_files'), 'course_files bucket is private');
SELECT extensions.is((SELECT file_size_limit::bigint FROM storage.buckets WHERE id = 'avatars'), 5242880::bigint, 'avatar size cap is provisioned');
SELECT extensions.is((SELECT file_size_limit::bigint FROM storage.buckets WHERE id = 'course_files'), 52428800::bigint, 'course file size cap is provisioned');
SELECT extensions.ok((SELECT allowed_mime_types @> ARRAY['image/png'] FROM storage.buckets WHERE id = 'avatars'), 'avatar MIME allowlist is provisioned');
SELECT extensions.ok(NOT has_function_privilege('anon', 'public.can_upload_storage_course_file(text)', 'EXECUTE'), 'anonymous cannot execute the course authorization helper');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000001', true);
INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
VALUES ('avatars', '50000000-0000-4000-8000-000000000001/avatar.png',
        '50000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001', '{"mimetype":"image/png"}');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'avatars'
  AND name = '50000000-0000-4000-8000-000000000001/avatar.png'), 1, 'user uploads avatar to own path');
SELECT extensions.throws_ok($$
  INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
  VALUES ('avatars', '50000000-0000-4000-8000-000000000002/avatar.png',
          '50000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001', '{"mimetype":"image/png"}')
$$, '42501', NULL, 'user cannot upload into another avatar path');
RESET ROLE;
SET LOCAL ROLE anon;
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'avatars'), 2, 'anonymous can read public avatar objects');
RESET ROLE;
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000001', true);
UPDATE storage.objects SET metadata = '{"mimetype":"image/png","updated":true}'
WHERE bucket_id = 'avatars' AND name = '50000000-0000-4000-8000-000000000001/avatar.png';
SELECT extensions.ok((SELECT metadata->>'updated' = 'true' FROM storage.objects
  WHERE bucket_id = 'avatars' AND name = '50000000-0000-4000-8000-000000000001/avatar.png'), 'avatar owner can update own object');
UPDATE storage.objects SET metadata = '{"mimetype":"image/png","updated":true}'
WHERE bucket_id = 'avatars' AND name = '50000000-0000-4000-8000-000000000002/avatar.png';
SELECT extensions.ok((SELECT metadata->>'updated' IS NULL FROM storage.objects
  WHERE bucket_id = 'avatars' AND name = '50000000-0000-4000-8000-000000000002/avatar.png'), 'user cannot update another avatar object');
INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
VALUES ('post_media', '50000000-0000-4000-8000-000000000001/post.png',
        '50000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001', '{"mimetype":"image/png"}');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'post_media'), 1, 'post creator with canonical permission uploads own media');
SELECT extensions.throws_ok($$
  INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
  VALUES ('post_media', '50000000-0000-4000-8000-000000000002/post.png',
          '50000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001', '{"mimetype":"image/png"}')
$$, '42501', NULL, 'post creator cannot upload to another owner path');

INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
VALUES ('chat_media', '54000000-0000-4000-8000-000000000001/50000000-0000-4000-8000-000000000001/photo.png',
        '50000000-0000-4000-8000-000000000001', '50000000-0000-4000-8000-000000000001', '{"mimetype":"image/png"}');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'chat_media'), 1, 'conversation member uploads chat media');

SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000003', true);
INSERT INTO public.shared_files (id, uploader_id, course_id, title, file_path, is_public)
VALUES ('55000000-0000-4000-8000-000000000001',
        '50000000-0000-4000-8000-000000000003',
        '53000000-0000-4000-8000-000000000001', 'P5 material',
        '53000000-0000-4000-8000-000000000001/50000000-0000-4000-8000-000000000003/55000000-0000-4000-8000-000000000001/notes.pdf', true);
INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
VALUES ('course_files', '53000000-0000-4000-8000-000000000001/50000000-0000-4000-8000-000000000003/55000000-0000-4000-8000-000000000001/notes.pdf',
        '50000000-0000-4000-8000-000000000003', '50000000-0000-4000-8000-000000000003', '{"mimetype":"application/pdf"}');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'course_files'), 1, 'assigned professor uploads to the taught course');

SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000001', true);
INSERT INTO public.posts (author_id, college_id, department_id, content, media_urls)
VALUES ('50000000-0000-4000-8000-000000000001',
        '51000000-0000-4000-8000-000000000001',
        '52000000-0000-4000-8000-000000000001', 'P5 media post',
        ARRAY['https://project.invalid/storage/v1/object/public/post_media/50000000-0000-4000-8000-000000000001/post.png']);
RESET ROLE;
SET LOCAL ROLE anon;
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'post_media'), 0, 'anonymous cannot read private post media');
RESET ROLE;
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000001', true);
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'post_media'), 1, 'post owner can read media referenced by a visible post');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'course_files'), 1, 'enrolled student reads public course file');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'chat_media'), 1, 'conversation member reads private chat media');
SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000003', true);
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'post_media'), 1, 'department reader with visible post can read its media');
RESET ROLE;
SELECT extensions.ok(EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'storage'
  AND tablename = 'objects' AND policyname = 'avatars_owner_delete' AND cmd = 'DELETE'
  AND qual LIKE '%foldername%'), 'avatar delete policy is limited to the caller path');
SELECT extensions.ok(EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'storage'
  AND tablename = 'objects' AND policyname = 'chat_media_owner_delete' AND cmd = 'DELETE'
  AND qual LIKE '%can_access_storage_conversation%'), 'chat delete policy requires ownership and current membership');
SELECT extensions.ok(EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = 'storage'
  AND tablename = 'objects' AND policyname = 'course_files_owner_delete' AND cmd = 'DELETE'
  AND qual LIKE '%can_upload_storage_course_file%'), 'course file delete policy requires uploader path and course scope');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub', '50000000-0000-4000-8000-000000000002', true);
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'chat_media'), 0, 'non-member cannot read private conversation media');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'post_media'), 0, 'cross-college user cannot read media from an invisible post');
SELECT extensions.throws_ok($$
  INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
  VALUES ('post_media', '50000000-0000-4000-8000-000000000002/post.png',
          '50000000-0000-4000-8000-000000000002', '50000000-0000-4000-8000-000000000002', '{"mimetype":"image/png"}')
$$, '42501', NULL, 'a student without posts.create cannot upload post media');
SELECT extensions.throws_ok($$
  INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
  VALUES ('chat_media', '54000000-0000-4000-8000-000000000001/50000000-0000-4000-8000-000000000002/photo.png',
          '50000000-0000-4000-8000-000000000002', '50000000-0000-4000-8000-000000000002', '{"mimetype":"image/png"}')
$$, '42501', NULL, 'non-member cannot upload conversation media');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id = 'course_files'), 0, 'student outside the enrolled course scope cannot read course media');
SELECT extensions.throws_ok($$
  INSERT INTO storage.objects (bucket_id, name, owner, owner_id, metadata)
  VALUES ('course_files', '53000000-0000-4000-8000-000000000001/50000000-0000-4000-8000-000000000002/55000000-0000-4000-8000-000000000002/evil.pdf',
          '50000000-0000-4000-8000-000000000002', '50000000-0000-4000-8000-000000000002', '{"mimetype":"application/pdf"}')
$$, '42501', NULL, 'student without materials.upload and course assignment cannot upload course files');
SELECT extensions.ok(NOT public.can_access_storage_conversation('not-a-uuid'), 'malformed conversation path fails closed');
SELECT extensions.ok(NOT public.can_upload_storage_course_file('not-a-uuid'), 'malformed course path fails closed');

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
