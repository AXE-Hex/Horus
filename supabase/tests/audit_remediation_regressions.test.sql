BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();

INSERT INTO auth.users (id, aud, role, email, raw_app_meta_data, raw_user_meta_data)
VALUES
 ('61000000-0000-4000-8000-000000000001','authenticated','authenticated','audit-student-a@example.invalid','{"provider":"email","providers":["email"]}','{}'),
 ('61000000-0000-4000-8000-000000000002','authenticated','authenticated','audit-student-b@example.invalid','{"provider":"email","providers":["email"]}','{}'),
 ('61000000-0000-4000-8000-000000000003','authenticated','authenticated','audit-parent@example.invalid','{"provider":"email","providers":["email"]}','{}'),
 ('61000000-0000-4000-8000-000000000004','authenticated','authenticated','audit-professor@example.invalid','{"provider":"email","providers":["email"]}','{}'),
 ('61000000-0000-4000-8000-000000000005','authenticated','authenticated','audit-registrar@example.invalid','{"provider":"email","providers":["email"]}','{}');

INSERT INTO public.colleges(id, code, name_en, name_ar)
VALUES ('61100000-0000-4000-8000-000000000001','AUDIT','Audit College','كلية الاختبار'),
       ('61100000-0000-4000-8000-000000000002','AUDIT2','Other College','كلية أخرى');
INSERT INTO public.departments(id, college_id, code, name_en, name_ar)
VALUES ('61200000-0000-4000-8000-000000000001','61100000-0000-4000-8000-000000000001','AUDIT-A','Audit A','قسم أ'),
       ('61200000-0000-4000-8000-000000000002','61100000-0000-4000-8000-000000000001','AUDIT-B','Audit B','قسم ب'),
       ('61200000-0000-4000-8000-000000000003','61100000-0000-4000-8000-000000000002','AUDIT-C','Audit C','قسم ج');
UPDATE public.profiles SET college_id='61100000-0000-4000-8000-000000000001', department_id='61200000-0000-4000-8000-000000000001'
WHERE id IN ('61000000-0000-4000-8000-000000000001','61000000-0000-4000-8000-000000000003','61000000-0000-4000-8000-000000000004');
UPDATE public.profiles SET college_id='61100000-0000-4000-8000-000000000001', department_id='61200000-0000-4000-8000-000000000001'
WHERE id='61000000-0000-4000-8000-000000000005';
UPDATE public.profiles SET college_id='61100000-0000-4000-8000-000000000001', department_id='61200000-0000-4000-8000-000000000002'
WHERE id='61000000-0000-4000-8000-000000000002';

DELETE FROM public.user_roles WHERE user_id IN (
 '61000000-0000-4000-8000-000000000001','61000000-0000-4000-8000-000000000002',
 '61000000-0000-4000-8000-000000000003','61000000-0000-4000-8000-000000000004',
 '61000000-0000-4000-8000-000000000005');
INSERT INTO public.user_roles(user_id, role_id)
SELECT v.user_id, rd.id FROM (VALUES
 ('61000000-0000-4000-8000-000000000001'::uuid,'student'),
 ('61000000-0000-4000-8000-000000000002'::uuid,'student'),
 ('61000000-0000-4000-8000-000000000003'::uuid,'parent'),
 ('61000000-0000-4000-8000-000000000004'::uuid,'professor'),
 ('61000000-0000-4000-8000-000000000005'::uuid,'registrar_officer')
) AS v(user_id,code) JOIN public.role_definitions rd ON rd.code=v.code;

INSERT INTO public.courses(id,department_id,code,name_en,name_ar,professor_id)
VALUES
 ('61300000-0000-4000-8000-000000000001','61200000-0000-4000-8000-000000000001','AUDIT-1','Audit One','واحد','61000000-0000-4000-8000-000000000004'),
 ('61300000-0000-4000-8000-000000000002','61200000-0000-4000-8000-000000000001','AUDIT-2','Audit Two','اثنان',NULL),
 ('61300000-0000-4000-8000-000000000003','61200000-0000-4000-8000-000000000002','AUDIT-3','Audit Three','ثلاثة',NULL),
 ('61300000-0000-4000-8000-000000000004','61200000-0000-4000-8000-000000000003','AUDIT-4','Audit Four','أربعة',NULL);
INSERT INTO public.enrollments(student_id,course_id,semester,status)
VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000001','audit','approved'),
       ('61000000-0000-4000-8000-000000000002','61300000-0000-4000-8000-000000000002','audit','approved');
INSERT INTO public.grades(student_id,course_id,semester,total,is_published)
VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000001','audit',90,true),
       ('61000000-0000-4000-8000-000000000002','61300000-0000-4000-8000-000000000001','audit',80,true);
INSERT INTO public.attendance(student_id,course_id,date,recorded_by)
VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000001','2026-09-01','61000000-0000-4000-8000-000000000004');
INSERT INTO public.action_plan_items(student_id,semester,year,status)
VALUES ('61000000-0000-4000-8000-000000000001','audit',2026,'planned');
INSERT INTO public.registration_requests(student_id,advisor_id,semester)
VALUES ('61000000-0000-4000-8000-000000000001',NULL,'audit-request');
INSERT INTO public.course_prerequisites(course_id,prerequisite_course_id,minimum_grade)
VALUES ('61300000-0000-4000-8000-000000000002','61300000-0000-4000-8000-000000000001',70),
       ('61300000-0000-4000-8000-000000000003','61300000-0000-4000-8000-000000000001',95);
INSERT INTO public.course_sections(course_id,name,semester)
VALUES ('61300000-0000-4000-8000-000000000002','A','audit');
INSERT INTO public.schedules(course_id,day,start_time,end_time,semester)
VALUES ('61300000-0000-4000-8000-000000000002','monday','09:00','10:00','audit');
INSERT INTO public.shared_files(id,uploader_id,course_id,title,file_path,is_public)
VALUES ('61400000-0000-4000-8000-000000000001','61000000-0000-4000-8000-000000000004',
 '61300000-0000-4000-8000-000000000001','Valid material',
 '61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000001/notes.pdf',true),
 ('61400000-0000-4000-8000-000000000004','61000000-0000-4000-8000-000000000004',
 '61300000-0000-4000-8000-000000000003','Other course material',
 '61300000-0000-4000-8000-000000000003/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000004/other.pdf',true),
 ('61400000-0000-4000-8000-000000000007','61000000-0000-4000-8000-000000000004',
 '61300000-0000-4000-8000-000000000002','Selected course material',
 '61300000-0000-4000-8000-000000000002/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000007/selected.pdf',true);
INSERT INTO storage.objects(bucket_id,name,owner,owner_id,metadata)
VALUES ('course_files','61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000001/notes.pdf',
 '61000000-0000-4000-8000-000000000004','61000000-0000-4000-8000-000000000004','{"mimetype":"application/pdf"}'),
 ('course_files','61300000-0000-4000-8000-000000000003/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000004/other.pdf',
 '61000000-0000-4000-8000-000000000004','61000000-0000-4000-8000-000000000004','{"mimetype":"application/pdf"}'),
 ('course_files','61300000-0000-4000-8000-000000000002/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000007/selected.pdf',
 '61000000-0000-4000-8000-000000000004','61000000-0000-4000-8000-000000000004','{"mimetype":"application/pdf"}');

SET LOCAL ROLE authenticated;
SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000003',true);
SELECT extensions.ok(NOT public.has_permission('students.progress.read'),'parent has no progress permission without a trusted relationship model');
SELECT extensions.ok(NOT public.has_permission('grades.read'),'parent has no grade permission without a trusted relationship model');
SELECT extensions.ok(NOT public.has_permission('attendance.read'),'parent has no attendance permission without a trusted relationship model');
SELECT extensions.ok(NOT public.can_review_student('61000000-0000-4000-8000-000000000001'),'same-college and same-department membership do not make a parent an academic reviewer');
SELECT extensions.is((SELECT count(*)::integer FROM public.grades),0,'parent cannot read unrelated student grades');
SELECT extensions.is((SELECT count(*)::integer FROM public.attendance),0,'parent cannot read unrelated student attendance');
SELECT extensions.is((SELECT count(*)::integer FROM public.action_plan_items),0,'parent cannot read unrelated student progress');

SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000001',true);
SELECT extensions.ok(public.can_request_course_enrollment('61300000-0000-4000-8000-000000000002'),'same-college student can request enrollment in catalog course');
SELECT extensions.ok(public.can_browse_course_catalog('61300000-0000-4000-8000-000000000003'),'same-college student can browse a course whose prerequisite is not yet satisfied');
SELECT extensions.ok(NOT public.can_request_course_enrollment('61300000-0000-4000-8000-000000000003'),'student with an insufficient published prerequisite grade cannot request the course');
SELECT extensions.ok(NOT public.can_browse_course_catalog('61300000-0000-4000-8000-000000000004'),'same-college enrollment permission does not browse a cross-college course');
SELECT extensions.ok(NOT public.can_access_course('61300000-0000-4000-8000-000000000002'),'enrollment eligibility does not grant private course participation');
SELECT extensions.ok(NOT public.can_access_course('61300000-0000-4000-8000-000000000003'),'same-college student cannot access an unregistered cross-department course');
SELECT extensions.ok(NOT public.can_access_course('61300000-0000-4000-8000-000000000004'),'student cannot access a cross-college course');
SELECT extensions.is((SELECT count(*)::integer FROM public.course_sections),1,'eligible student can inspect the section catalog while preparing enrollment');
SELECT extensions.is((SELECT count(*)::integer FROM public.schedules),1,'eligible student can inspect the schedule catalog while preparing enrollment');
SELECT extensions.is((SELECT count(*)::integer FROM public.shared_files),1,'same-college membership does not expose another course file');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='course_files'),1,'Storage SELECT denies a different same-college course file');
SELECT extensions.throws_ok($$INSERT INTO public.student_course_registrations(student_id,course_id,semester) VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000004','audit')$$,'42501',NULL,'cross-department course registration is denied');
INSERT INTO public.student_course_registrations(student_id,course_id,semester)
VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000002','audit');
SELECT extensions.is((SELECT count(*)::integer FROM public.student_course_registrations WHERE course_id='61300000-0000-4000-8000-000000000002'),1,'student with a published passing prerequisite can register');
SELECT extensions.ok(NOT public.can_access_course('61300000-0000-4000-8000-000000000002'),'a self-created registration selection is not approved course participation');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='course_files'),1,'registration selection does not grant access to course material');
SELECT extensions.throws_ok($$INSERT INTO public.student_course_registrations(student_id,course_id,semester) VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000003','audit2')$$,'42501',NULL,'insufficient prerequisite grade denies registration');
INSERT INTO public.registration_request_courses(request_id,course_id)
SELECT id,'61300000-0000-4000-8000-000000000002' FROM public.registration_requests
WHERE student_id='61000000-0000-4000-8000-000000000001' AND semester='audit-request';
SELECT extensions.is((SELECT count(*)::integer FROM public.registration_request_courses rc
  JOIN public.registration_requests rr ON rr.id=rc.request_id
  WHERE rr.student_id='61000000-0000-4000-8000-000000000001'),1,'eligible student may request a course with a passing prerequisite');
SELECT extensions.throws_ok($$INSERT INTO public.registration_request_courses(request_id,course_id) SELECT id,'61300000-0000-4000-8000-000000000003' FROM public.registration_requests WHERE student_id='61000000-0000-4000-8000-000000000001' AND semester='audit-request'$$,'42501',NULL,'registration request course insert cannot bypass prerequisite minimum');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='course_files'),1,'enrolled student can read a course file with matching metadata');

SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000004',true);
SELECT extensions.throws_ok($$INSERT INTO public.shared_files(id,uploader_id,course_id,title,file_path,is_public) VALUES ('61400000-0000-4000-8000-000000000002','61000000-0000-4000-8000-000000000004','61300000-0000-4000-8000-000000000001','Wrong file id','61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000099/evil.pdf',true)$$,'42501',NULL,'metadata cannot name another object identifier');
SELECT extensions.throws_ok($$INSERT INTO public.shared_files(id,uploader_id,course_id,title,file_path,is_public) VALUES ('61400000-0000-4000-8000-000000000003','61000000-0000-4000-8000-000000000004','61300000-0000-4000-8000-000000000002','Wrong course','61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000003/evil.pdf',true)$$,'42501',NULL,'metadata cannot point at a different course path');
SELECT extensions.throws_ok($$INSERT INTO public.shared_files(id,uploader_id,course_id,title,file_path,is_public) VALUES ('61400000-0000-4000-8000-000000000005','61000000-0000-4000-8000-000000000004','61300000-0000-4000-8000-000000000001','Wrong uploader','61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000001/61400000-0000-4000-8000-000000000005/evil.pdf',true)$$,'42501',NULL,'metadata path uploader must match the row uploader');
SELECT extensions.throws_ok($$UPDATE public.shared_files SET file_path='61300000-0000-4000-8000-000000000002/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000001/retarget.pdf' WHERE id='61400000-0000-4000-8000-000000000001'$$,'42501',NULL,'metadata update cannot retarget the file to another course');
SELECT extensions.throws_ok($$UPDATE storage.objects SET name='61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000099/retarget.pdf' WHERE bucket_id='course_files' AND name='61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000001/notes.pdf'$$,'42501',NULL,'Storage object update cannot retarget away from its bound shared-file metadata');
SELECT extensions.throws_ok($$INSERT INTO storage.objects(bucket_id,name,owner,owner_id,metadata) VALUES ('course_files','61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/not-a-uuid/evil.pdf','61000000-0000-4000-8000-000000000004','61000000-0000-4000-8000-000000000004','{"mimetype":"application/pdf"}')$$,'42501',NULL,'Storage rejects a path without a valid object identifier');
INSERT INTO public.shared_files(id,uploader_id,course_id,title,file_path,is_public)
VALUES ('61400000-0000-4000-8000-000000000006','61000000-0000-4000-8000-000000000004',
 '61300000-0000-4000-8000-000000000001','Metadata only',
 '61300000-0000-4000-8000-000000000001/61000000-0000-4000-8000-000000000004/61400000-0000-4000-8000-000000000006/missing.pdf',true);
SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000001',true);
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='course_files'),1,'a matching metadata row alone does not create or grant a Storage object');
SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000004',true);

UPDATE public.attendance SET status='absent' WHERE student_id='61000000-0000-4000-8000-000000000001';
SELECT extensions.throws_ok($$UPDATE public.attendance SET student_id='61000000-0000-4000-8000-000000000002' WHERE student_id='61000000-0000-4000-8000-000000000001'$$,'42501',NULL,'teacher cannot retarget attendance to a student not enrolled in that course');

SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000005',true);
SELECT extensions.throws_ok($$INSERT INTO public.enrollments(student_id,course_id,semester,status) VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000003','audit-direct','approved')$$,'42501',NULL,'registrar cannot directly enroll a student below the prerequisite minimum');
SELECT extensions.throws_ok($$INSERT INTO public.enrollments(student_id,course_id,semester,status) VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000004','audit-cross-college','approved')$$,'42501',NULL,'registrar cannot enroll a student in a course outside the student college');
INSERT INTO public.enrollments(student_id,course_id,semester,status)
VALUES ('61000000-0000-4000-8000-000000000001','61300000-0000-4000-8000-000000000002','audit-direct','approved');
SELECT extensions.is((SELECT count(*)::integer FROM public.enrollments
  WHERE student_id='61000000-0000-4000-8000-000000000001'
    AND course_id='61300000-0000-4000-8000-000000000002'
    AND semester='audit-direct'),1,'registrar may enroll a scoped student whose published prerequisite grade passes');
SELECT set_config('request.jwt.claim.sub','61000000-0000-4000-8000-000000000001',true);
SELECT extensions.ok(public.can_access_course('61300000-0000-4000-8000-000000000002'),'approved enrollment grants actual course participation');
SELECT extensions.is((SELECT count(*)::integer FROM storage.objects WHERE bucket_id='course_files'),2,'approved enrollment grants access to the matching course file');

RESET ROLE;
SELECT * FROM extensions.finish();
ROLLBACK;
