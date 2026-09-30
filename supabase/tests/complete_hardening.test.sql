BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();

INSERT INTO public.colleges(id,code,name_en,name_ar) VALUES
 ('71000000-0000-4000-8000-000000000001','HARD-B','Other college','أخرى');
INSERT INTO public.departments(id,college_id,code,name_en,name_ar) VALUES
 ('72000000-0000-4000-8000-000000000001','71000000-0000-4000-8000-000000000001','HARD-B','Other department','آخر');
INSERT INTO public.courses(id,department_id,code,name_en,name_ar,professor_id) VALUES
 ('73000000-0000-4000-8000-000000000001','d2000000-0000-4000-8000-000000000001','HARD-A','Own course','أ','d0000000-0000-4000-8000-000000000004'),
 ('73000000-0000-4000-8000-000000000002','72000000-0000-4000-8000-000000000001','HARD-B','Other course','ب',NULL);
INSERT INTO public.enrollments(student_id,course_id,semester,status) VALUES
 ('d0000000-0000-4000-8000-000000000008','73000000-0000-4000-8000-000000000001','hard','approved'),
 ('d0000000-0000-4000-8000-000000000009','73000000-0000-4000-8000-000000000001','hard','pending');
INSERT INTO public.teaching_assistants(profile_id,professor_id,course_id) VALUES
 ('d0000000-0000-4000-8000-000000000005','d0000000-0000-4000-8000-000000000004','73000000-0000-4000-8000-000000000001')
ON CONFLICT (profile_id, professor_id) DO UPDATE SET course_id = EXCLUDED.course_id;
UPDATE public.profiles SET advisor_id='d0000000-0000-4000-8000-000000000007'
 WHERE id='d0000000-0000-4000-8000-000000000008';
INSERT INTO public.notifications(user_id,title,message) VALUES
 ('d0000000-0000-4000-8000-000000000008','Own','Private'),
 ('d0000000-0000-4000-8000-000000000009','Other','Private');
INSERT INTO public.conversations(id,created_by) VALUES
 ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000004'),
 ('74000000-0000-4000-8000-000000000002','d0000000-0000-4000-8000-000000000009');
INSERT INTO public.conversation_members(conversation_id,user_id) VALUES
 ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000004'),
 ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008'),
 ('74000000-0000-4000-8000-000000000002','d0000000-0000-4000-8000-000000000009');
INSERT INTO public.messages(id,conversation_id,sender_id,content) VALUES
 ('75000000-0000-4000-8000-000000000001','74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000004','Private A'),
 ('75000000-0000-4000-8000-000000000002','74000000-0000-4000-8000-000000000002','d0000000-0000-4000-8000-000000000009','Private B');
INSERT INTO public.invoices(id,student_id,semester,description,amount) VALUES
 ('76000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008','hard','Own',100);


SELECT extensions.ok(NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname='public' AND c.relkind IN ('r','p') AND (NOT c.relrowsecurity OR NOT c.relforcerowsecurity)),'all application tables and partitions enable and force RLS');

SELECT extensions.ok(NOT EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname='public' AND p.prosecdef AND (p.proconfig IS NULL OR NOT EXISTS (SELECT 1 FROM unnest(p.proconfig) x WHERE x LIKE 'search_path=%'))) ,'every public SECURITY DEFINER has a pinned search path');

SELECT extensions.ok(NOT EXISTS (SELECT 1 FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname='public' AND p.prosecdef AND has_function_privilege('anon',p.oid,'EXECUTE')),'anon cannot execute application definers');


SELECT extensions.ok(NOT EXISTS (SELECT 1 FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname='public' AND c.relkind IN ('r','p','v','m') AND has_table_privilege('anon',c.oid,'SELECT,INSERT,UPDATE,DELETE')),'anon has no application relation privilege');

INSERT INTO auth.users(id,aud,role,email,raw_user_meta_data) VALUES (gen_random_uuid(),'authenticated','authenticated','hard-signup-student@example.invalid',jsonb_build_object('role','student','roles',ARRAY['student']));

SELECT extensions.ok((SELECT bool_and(rd.code='guest') FROM public.user_roles ur JOIN public.role_definitions rd ON rd.id=ur.role_id JOIN auth.users u ON u.id=ur.user_id WHERE u.email='hard-signup-student@example.invalid'),'student signup metadata cannot create privileges');

INSERT INTO auth.users(id,aud,role,email,raw_user_meta_data) VALUES (gen_random_uuid(),'authenticated','authenticated','hard-signup-professor@example.invalid',jsonb_build_object('role','professor','roles',ARRAY['professor']));

SELECT extensions.ok((SELECT bool_and(rd.code='guest') FROM public.user_roles ur JOIN public.role_definitions rd ON rd.id=ur.role_id JOIN auth.users u ON u.id=ur.user_id WHERE u.email='hard-signup-professor@example.invalid'),'professor signup metadata cannot create privileges');

INSERT INTO auth.users(id,aud,role,email,raw_user_meta_data) VALUES (gen_random_uuid(),'authenticated','authenticated','hard-signup-dean@example.invalid',jsonb_build_object('role','dean','roles',ARRAY['dean']));

SELECT extensions.ok((SELECT bool_and(rd.code='guest') FROM public.user_roles ur JOIN public.role_definitions rd ON rd.id=ur.role_id JOIN auth.users u ON u.id=ur.user_id WHERE u.email='hard-signup-dean@example.invalid'),'dean signup metadata cannot create privileges');

INSERT INTO auth.users(id,aud,role,email,raw_user_meta_data) VALUES (gen_random_uuid(),'authenticated','authenticated','hard-signup-rector@example.invalid',jsonb_build_object('role','rector','roles',ARRAY['rector']));

SELECT extensions.ok((SELECT bool_and(rd.code='guest') FROM public.user_roles ur JOIN public.role_definitions rd ON rd.id=ur.role_id JOIN auth.users u ON u.id=ur.user_id WHERE u.email='hard-signup-rector@example.invalid'),'rector signup metadata cannot create privileges');

INSERT INTO auth.users(id,aud,role,email,raw_user_meta_data) VALUES (gen_random_uuid(),'authenticated','authenticated','hard-signup-administrator@example.invalid',jsonb_build_object('role','administrator','roles',ARRAY['administrator']));

SELECT extensions.ok((SELECT bool_and(rd.code='guest') FROM public.user_roles ur JOIN public.role_definitions rd ON rd.id=ur.role_id JOIN auth.users u ON u.id=ur.user_id WHERE u.email='hard-signup-administrator@example.invalid'),'administrator signup metadata cannot create privileges');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000010',true);

SELECT extensions.is((SELECT count(*)::integer FROM public.profile_directory),0,'guest cannot read profile_directory');

SELECT extensions.is((SELECT count(*)::integer FROM public.courses),0,'guest cannot read courses');

SELECT extensions.is((SELECT count(*)::integer FROM public.departments),0,'guest cannot read departments');

SELECT extensions.is((SELECT count(*)::integer FROM public.colleges),0,'guest cannot read colleges');

SELECT extensions.is((SELECT count(*)::integer FROM public.posts),0,'guest cannot read posts');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'guest cannot read messages');

SELECT extensions.is((SELECT count(*)::integer FROM public.conversation_members),0,'guest cannot read conversation_members');

SELECT extensions.is((SELECT count(*)::integer FROM public.library_items),0,'guest cannot read library_items');

SELECT extensions.is((SELECT count(*)::integer FROM public.grades),0,'guest cannot read grades');

SELECT extensions.is((SELECT count(*)::integer FROM public.attendance),0,'guest cannot read attendance');

SELECT extensions.is((SELECT count(*)::integer FROM public.notifications),0,'guest cannot read notifications');

SELECT extensions.is((SELECT count(*)::integer FROM public.invoices),0,'guest cannot read invoices');

SELECT extensions.is((SELECT count(*)::integer FROM public.registration_requests),0,'guest cannot read registration_requests');

SELECT extensions.throws_ok($q$INSERT INTO public.conversations(created_by) VALUES ('d0000000-0000-4000-8000-000000000010')$q$,'42501',NULL,'guest cannot create private conversations');

SELECT extensions.throws_ok($q$INSERT INTO public.post_likes(post_id,user_id) VALUES (gen_random_uuid(),'d0000000-0000-4000-8000-000000000010')$q$,'42501',NULL,'guest cannot insert likes');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.throws_ok($q$INSERT INTO public.user_roles(user_id,role_id) SELECT 'd0000000-0000-4000-8000-000000000008',id FROM public.role_definitions WHERE code='rector'$q$,'42501',NULL,'client cannot modify user_roles INSERT');

SELECT extensions.throws_ok($q$UPDATE public.user_roles SET expires_at=NULL WHERE user_id='d0000000-0000-4000-8000-000000000008'$q$,'42501',NULL,'client cannot modify user_roles UPDATE');

SELECT extensions.throws_ok($q$DELETE FROM public.user_roles WHERE user_id='d0000000-0000-4000-8000-000000000008'$q$,'42501',NULL,'client cannot modify user_roles DELETE');

SELECT extensions.throws_ok($q$UPDATE public.permissions SET code='evil' WHERE code='grades.read'$q$,'42501',NULL,'client cannot modify permissions');

SELECT extensions.throws_ok($q$DELETE FROM public.role_permissions$q$,'42501',NULL,'client cannot modify role_permissions');

SELECT extensions.throws_ok($q$UPDATE public.profiles SET roles='{rector}' WHERE id='d0000000-0000-4000-8000-000000000008'$q$,'42501',NULL,'client cannot modify profile role cache');

SELECT extensions.is((SELECT count(*)::integer FROM public.notifications WHERE title='Own'),1,'student reads own test notification');

SELECT extensions.throws_ok($q$UPDATE public.notifications SET title='Forged'$q$,'42501',NULL,'notification contents cannot be forged');

SELECT extensions.throws_ok($q$UPDATE public.notifications SET user_id='d0000000-0000-4000-8000-000000000009'$q$,'42501',NULL,'notification cannot be retargeted');

UPDATE public.notifications SET is_read=true, read_at=now() WHERE title='Own';

SELECT extensions.ok((SELECT bool_and(is_read) FROM public.notifications WHERE title='Own'),'notification acknowledgement remains allowed');

SELECT extensions.is((SELECT count(*)::integer FROM public.conversation_members),2,'membership SELECT succeeds without recursion and shows own conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),1,'member cannot read another conversation');

SELECT extensions.throws_ok($q$INSERT INTO public.conversation_members(conversation_id,user_id) VALUES ('74000000-0000-4000-8000-000000000002','d0000000-0000-4000-8000-000000000008')$q$,'42501',NULL,'member cannot add self to someone else conversation');

SELECT extensions.throws_ok($q$INSERT INTO public.messages(conversation_id,sender_id,content) VALUES ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000009','spoof')$q$,'42501',NULL,'message sender cannot be spoofed');

SELECT extensions.throws_ok($q$INSERT INTO public.messages(conversation_id,sender_id,content,reply_to_id) VALUES ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008','reply','75000000-0000-4000-8000-000000000002')$q$,'23503',NULL,'reply cannot reference a different conversation');

INSERT INTO public.messages(conversation_id,sender_id,content,reply_to_id) VALUES ('74000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008','allowed reply','75000000-0000-4000-8000-000000000001');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),2,'member sends valid same-conversation reply');

SELECT extensions.throws_ok($q$UPDATE public.invoices SET status='paid'$q$,'42501',NULL,'student cannot settle invoice');

SELECT extensions.throws_ok($q$INSERT INTO public.payment_transactions(invoice_id,student_id,amount,payment_method) VALUES ('76000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008',100,'cash')$q$,'42501',NULL,'student cannot create trusted payment');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000004',true);

SELECT extensions.ok(public.can_teach_course('73000000-0000-4000-8000-000000000001'),'professor is assigned to own course');

SELECT extensions.ok(NOT public.can_teach_course('73000000-0000-4000-8000-000000000002'),'professor cannot manage unrelated course');

INSERT INTO public.grades(student_id,course_id,semester,total) VALUES ('d0000000-0000-4000-8000-000000000008','73000000-0000-4000-8000-000000000001','hard',85);

SELECT extensions.throws_ok($q$INSERT INTO public.grades(student_id,course_id,semester,total) VALUES ('d0000000-0000-4000-8000-000000000009','73000000-0000-4000-8000-000000000001','hard',85)$q$,'42501',NULL,'pending enrollment does not authorize grades');

SELECT extensions.throws_ok($q$INSERT INTO public.grades(student_id,course_id,semester,total) VALUES ('d0000000-0000-4000-8000-000000000008','73000000-0000-4000-8000-000000000001','other-semester',85)$q$,'42501',NULL,'old enrollment does not authorize a different grade semester');

SELECT extensions.throws_ok($q$UPDATE public.grades SET student_id='d0000000-0000-4000-8000-000000000009'$q$,'42501',NULL,'grade identity cannot move to another student');

INSERT INTO public.grades(student_id,course_id,semester,total) VALUES ('d0000000-0000-4000-8000-000000000008','73000000-0000-4000-8000-000000000001','hard',86) ON CONFLICT(student_id,course_id,semester) DO UPDATE SET total=excluded.total,student_id=excluded.student_id;

SELECT extensions.is((SELECT total FROM public.grades WHERE semester='hard'),86::numeric,'same-key grade upsert remains allowed');

SELECT extensions.throws_ok($q$UPDATE public.grades SET total=101 WHERE course_id='73000000-0000-4000-8000-000000000001' AND semester='hard'$q$,'23514',NULL,'grade total range enforced');

SELECT extensions.throws_ok($q$SELECT host_url FROM public.virtual_classes$q$,'42501',NULL,'participants cannot select meeting host credentials');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000005',true);

SELECT extensions.ok(public.has_permission('attendance.manage') AND public.can_teach_course('73000000-0000-4000-8000-000000000001'),'teaching assistant attendance permission is assigned-course scoped');

SELECT extensions.ok(NOT public.has_permission('grades.manage'),'teaching assistant cannot manage grades');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000007',true);

SELECT * FROM public.get_advisor_directory(NULL,true,false);

SELECT extensions.is((SELECT count(*)::integer FROM public.get_advisor_directory(NULL,true,false)),1,'advisor can read only assigned students');

SELECT extensions.throws_ok($q$SELECT * FROM public.get_advisor_directory(NULL,false,false)$q$,'42501',NULL,'advisor cannot request an unscoped directory');

SELECT extensions.throws_ok($q$SELECT public.assign_student_advisor('d0000000-0000-4000-8000-000000000008','d0000000-0000-4000-8000-000000000007')$q$,'42501',NULL,'advisor cannot self-authorize assignments');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000006',true);

SELECT extensions.ok(public.can_review_student('d0000000-0000-4000-8000-000000000008'),'registrar reviews a student inside permitted college');

SELECT extensions.ok(NOT public.can_manage_course('73000000-0000-4000-8000-000000000001'),'registrar cannot manage academic course');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000003',true);

SELECT extensions.ok(public.can_manage_course('73000000-0000-4000-8000-000000000001'),'department head manages assigned department');

SELECT extensions.ok(NOT public.can_manage_course('73000000-0000-4000-8000-000000000002'),'department head cannot manage another department');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000002',true);

SELECT extensions.throws_ok($q$UPDATE public.departments SET college_id='71000000-0000-4000-8000-000000000001' WHERE id='d2000000-0000-4000-8000-000000000001'$q$,'42501',NULL,'dean cannot move own department to another college');

INSERT INTO public.departments(college_id,code,name_en,name_ar) VALUES ('d1000000-0000-4000-8000-000000000001','HARD-NEW','New department','جديد');

SELECT extensions.is((SELECT count(*)::integer FROM public.departments WHERE code='HARD-NEW'),1,'dean can create department in own college');

SELECT extensions.throws_ok($q$SELECT * FROM public.get_advisor_directory('71000000-0000-4000-8000-000000000001',false,false)$q$,'42501',NULL,'dean directory denies another college');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000001',true);

SELECT extensions.ok(public.can_manage_department('72000000-0000-4000-8000-000000000001'),'rector explicitly manages university scope');

SELECT extensions.ok(NOT public.has_permission('finance.read'),'rector has no implicit financial bypass');

RESET ROLE;

INSERT INTO public.role_definitions(id,code,name_en) VALUES ('77000000-0000-4000-8000-000000000001','unknown_admin','Unknown');

INSERT INTO public.role_permissions(role_id,permission_id) SELECT '77000000-0000-4000-8000-000000000001',id FROM public.permissions WHERE code='grades.manage';

DELETE FROM public.user_roles WHERE user_id='d0000000-0000-4000-8000-000000000008'; INSERT INTO public.user_roles(user_id,role_id) VALUES ('d0000000-0000-4000-8000-000000000008','77000000-0000-4000-8000-000000000001');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.manage'),'unknown canonical code cannot supply role or permission');

RESET ROLE;

DELETE FROM public.user_roles WHERE user_id='d0000000-0000-4000-8000-000000000008'; INSERT INTO public.user_roles(user_id,role_id) SELECT 'd0000000-0000-4000-8000-000000000008',id FROM public.role_definitions WHERE code='regular_student';

UPDATE public.profiles SET is_active=false WHERE id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'inactive profile fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'inactive profile cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'inactive profile cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'inactive profile cannot use definer self update');

RESET ROLE;
UPDATE public.profiles SET is_active=true WHERE id='d0000000-0000-4000-8000-000000000008';

UPDATE public.profiles SET is_banned=true WHERE id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'banned profile fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'banned profile cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'banned profile cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'banned profile cannot use definer self update');

RESET ROLE;
UPDATE public.profiles SET is_banned=false WHERE id='d0000000-0000-4000-8000-000000000008';

UPDATE public.profiles SET deleted_at=now() WHERE id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'deleted profile fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'deleted profile cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'deleted profile cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'deleted profile cannot use definer self update');

RESET ROLE;
UPDATE public.profiles SET deleted_at=NULL WHERE id='d0000000-0000-4000-8000-000000000008';

UPDATE public.user_roles SET granted_at=now()-interval '2 days',expires_at=now()-interval '1 day' WHERE user_id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'expired assignment fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'expired assignment cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'expired assignment cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'expired assignment cannot use definer self update');

RESET ROLE;
UPDATE public.user_roles SET expires_at=NULL,granted_at=now() WHERE user_id='d0000000-0000-4000-8000-000000000008';

UPDATE public.user_roles SET granted_at=now()+interval '1 day' WHERE user_id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'future assignment fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'future assignment cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'future assignment cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'future assignment cannot use definer self update');

RESET ROLE;
UPDATE public.user_roles SET granted_at=now() WHERE user_id='d0000000-0000-4000-8000-000000000008';

UPDATE public.role_definitions SET is_active=false WHERE code='regular_student';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL AND NOT public.has_permission('grades.read'),'inactive definition fails closed');

SELECT extensions.is((SELECT count(*)::integer FROM public.messages),0,'inactive definition cannot read owned conversation');

SELECT extensions.is((SELECT count(*)::integer FROM public.get_my_profile_private()),0,'inactive definition cannot read private profile');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'inactive definition cannot use definer self update');

RESET ROLE;
UPDATE public.role_definitions SET is_active=true WHERE code='regular_student';

DELETE FROM public.user_roles WHERE user_id='d0000000-0000-4000-8000-000000000008';

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','d0000000-0000-4000-8000-000000000008',true);

SELECT extensions.ok(public.get_my_role() IS NULL,'no role does not fall back to student or guest');

RESET ROLE;

INSERT INTO public.payment_transactions(invoice_id,student_id,amount,payment_method,status,transaction_ref) VALUES ('76000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008',100,'cash','paid','hard-payment');

SELECT extensions.throws_ok($q$UPDATE public.payment_transactions SET status='pending' WHERE transaction_ref='hard-payment'$q$,'23514',NULL,'settled payment cannot regress');

SELECT extensions.throws_ok($q$UPDATE public.payment_transactions SET amount=99 WHERE transaction_ref='hard-payment'$q$,'23514',NULL,'settled amount cannot change');

SELECT extensions.throws_ok($q$INSERT INTO public.payment_transactions(invoice_id,student_id,amount,payment_method) VALUES ('76000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000009',100,'cash')$q$,'23514',NULL,'payment identity must match invoice');

SELECT extensions.throws_ok($q$INSERT INTO public.payment_transactions(invoice_id,student_id,amount,payment_method,transaction_ref) VALUES ('76000000-0000-4000-8000-000000000001','d0000000-0000-4000-8000-000000000008',100,'cash','hard-payment')$q$,'23505',NULL,'payment reference is idempotent');

SELECT extensions.throws_ok($q$INSERT INTO public.library_items(title,author,category,total_copies,available_copies) VALUES ('Bad','Fixture','test',1,2)$q$,'23514',NULL,'library availability cannot exceed inventory');

SELECT extensions.throws_ok($q$DELETE FROM public.courses WHERE id='73000000-0000-4000-8000-000000000001'$q$,'23503',NULL,'course deletion preserves grades and enrollment history');
SELECT extensions.throws_ok($q$DELETE FROM public.departments WHERE id='d2000000-0000-4000-8000-000000000001'$q$,'23503',NULL,'department deletion cannot cascade academic course history');
SELECT extensions.throws_ok($q$UPDATE public.profiles SET college_id='71000000-0000-4000-8000-000000000001' WHERE id='d0000000-0000-4000-8000-000000000004'$q$,'23503',NULL,'profile college must match its department');

SET LOCAL ROLE anon;

SELECT extensions.throws_ok($q$SELECT * FROM public.get_my_profile_private()$q$,'42501',NULL,'anonymous sensitive RPC is denied');

SELECT extensions.throws_ok($q$SELECT public.update_my_profile('evil',NULL,NULL,NULL)$q$,'42501',NULL,'anonymous sensitive RPC is denied');

SELECT extensions.throws_ok($q$SELECT * FROM public.get_advisor_directory(NULL,true,false)$q$,'42501',NULL,'anonymous sensitive RPC is denied');

SELECT extensions.throws_ok($q$SELECT public.assign_student_advisor('d0000000-0000-4000-8000-000000000008','d0000000-0000-4000-8000-000000000007')$q$,'42501',NULL,'anonymous sensitive RPC is denied');

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
