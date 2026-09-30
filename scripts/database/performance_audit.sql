-- Synthetic rows are isolated in a transaction and always rolled back.
-- Distinct users avoid unrealistic single-owner planner selectivity.
BEGIN;
INSERT INTO auth.users (id,aud,role,email,raw_user_meta_data)
SELECT ('88000000-0000-4000-8000-'||lpad(g::text,12,'0'))::uuid,
       'authenticated','authenticated','perf-'||g||'@example.invalid','{}'
FROM generate_series(1,100) g;
DELETE FROM public.user_roles WHERE user_id BETWEEN
 '88000000-0000-4000-8000-000000000001'::uuid AND '88000000-0000-4000-8000-000000000100'::uuid;
INSERT INTO public.user_roles (user_id,role_id)
SELECT p.id,r.id FROM public.profiles p CROSS JOIN public.role_definitions r
WHERE p.id BETWEEN '88000000-0000-4000-8000-000000000001'::uuid
 AND '88000000-0000-4000-8000-000000000100'::uuid AND r.code='regular_student';
INSERT INTO public.notifications(id,user_id,title,message,created_at)
SELECT md5('horus-notification-'||u.id::text||'-'||g)::uuid,u.id,
 'Local performance fixture','Synthetic',now()-g*interval '1 second'
FROM public.profiles u CROSS JOIN generate_series(1,100) g
WHERE u.id BETWEEN '88000000-0000-4000-8000-000000000001'::uuid
 AND '88000000-0000-4000-8000-000000000100'::uuid;
INSERT INTO public.posts(id,author_id,college_id,department_id,content,created_at)
SELECT md5('horus-post-'||g)::uuid,'d0000000-0000-4000-8000-000000000004',
 'd1000000-0000-4000-8000-000000000001','d2000000-0000-4000-8000-000000000001',
 'Local performance fixture',now()-g*interval '1 second' FROM generate_series(1,10000) g;
ANALYZE public.notifications;
ANALYZE public.posts;
SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','88000000-0000-4000-8000-000000000050',true);
EXPLAIN (ANALYZE, BUFFERS) SELECT id,title,is_read FROM public.notifications
 WHERE user_id='88000000-0000-4000-8000-000000000050' ORDER BY created_at DESC,id DESC LIMIT 50;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000004',true);
EXPLAIN (ANALYZE, BUFFERS) SELECT id,content FROM public.posts
 WHERE college_id='d1000000-0000-4000-8000-000000000001'
 AND department_id='d2000000-0000-4000-8000-000000000001' AND deleted_at IS NULL
 ORDER BY created_at DESC,id DESC LIMIT 20;
RESET ROLE;
ROLLBACK;
