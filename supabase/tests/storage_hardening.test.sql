BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();
INSERT INTO public.conversations(id,created_by) VALUES
 ('81000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008');
INSERT INTO public.conversation_members(conversation_id,user_id) VALUES
 ('81000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008'),
 ('81000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000009');
INSERT INTO storage.objects(bucket_id,name,owner,owner_id,metadata) VALUES
 ('avatars','d0000000-0000-4000-8000-000000000009/storage-test.png','d0000000-0000-4000-8000-000000000009','d0000000-0000-4000-8000-000000000009','{"mimetype":"image/png"}'),
 ('chat_media','81000000-0000-4000-8000-000000000001/d0000000-0000-4000-8000-000000000009/storage-test.png','d0000000-0000-4000-8000-000000000009','d0000000-0000-4000-8000-000000000009','{"mimetype":"image/png"}');
SELECT extensions.ok((SELECT bool_and(file_size_limit>0 AND cardinality(allowed_mime_types)>0) FROM storage.buckets),'every bucket config has server size and MIME restrictions');
SELECT extensions.ok(NOT EXISTS (SELECT 1 FROM storage.buckets WHERE 'application/x-msdownload'=ANY(allowed_mime_types)),'executable MIME excluded from every bucket');
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='chat_media'),1,'current member reads shared private chat object');
SELECT extensions.throws_ok($$INSERT INTO storage.objects(bucket_id,name) VALUES ('chat_media','81000000-0000-4000-8000-000000000001/d0000000-0000-4000-8000-000000000009/spoof.png')$$,'42501',NULL,'member cannot upload to another uploader path');
WITH changed AS (UPDATE storage.objects SET metadata='{}' WHERE bucket_id='chat_media' RETURNING id)
SELECT extensions.is((SELECT count(*)::integer FROM changed),0,'member cannot update another uploader object');
-- Storage protects direct SQL deletes independently of RLS. Cross-owner
-- object deletion is exercised through the local Storage HTTP API harness.
SELECT extensions.throws_ok($$INSERT INTO storage.objects(bucket_id,name) VALUES ('course_files','not-a-course/d0000000-0000-4000-8000-000000000008/file.pdf')$$,'42501',NULL,'wrong course path denies Storage upload');
SELECT extensions.throws_ok($$INSERT INTO storage.objects(bucket_id,name) VALUES ('unknown-bucket','d0000000-0000-4000-8000-000000000008/file.png')$$,'42501',NULL,'unknown bucket has no matching upload policy');
SELECT extensions.ok(NOT public.can_access_storage_conversation(NULL),'null conversation identifier fails closed');
SELECT extensions.ok(NOT public.can_access_storage_conversation('bad'),'malformed conversation identifier fails closed');
RESET ROLE;
UPDATE public.profiles SET is_banned=true WHERE id='d0000000-0000-4000-8000-000000000008';
SET LOCAL ROLE authenticated;
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='chat_media'),0,'banned membership does not expose private Storage');
SELECT extensions.throws_ok($$INSERT INTO storage.objects(bucket_id,name) VALUES ('avatars','d0000000-0000-4000-8000-000000000008/banned.png')$$,'42501',NULL,'banned caller cannot upload even own avatar');
RESET ROLE;
SET LOCAL ROLE anon;
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='chat_media'),0,'anonymous cannot read private chat object');
RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
