BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap WITH SCHEMA extensions;
SELECT extensions.no_plan();

INSERT INTO auth.users (id,aud,role,email,raw_app_meta_data,raw_user_meta_data)
VALUES ('62000000-0000-4000-8000-000000000001','authenticated','authenticated',
  'phase2-contract@example.invalid','{"provider":"email","providers":["email"]}','{}');
INSERT INTO public.colleges(id,code,name_en,name_ar)
VALUES ('62100000-0000-4000-8000-000000000001','P2C','P2 College','كلية');
INSERT INTO public.departments(id,college_id,code,name_en,name_ar)
VALUES ('62200000-0000-4000-8000-000000000001','62100000-0000-4000-8000-000000000001','P2D','P2 Department','قسم');
INSERT INTO public.courses(id,department_id,code,name_en,name_ar)
VALUES ('62300000-0000-4000-8000-000000000001','62200000-0000-4000-8000-000000000001','P2-1','Course One','الأول'),
       ('62300000-0000-4000-8000-000000000002','62200000-0000-4000-8000-000000000001','P2-2','Course Two','الثاني');

SELECT extensions.ok(EXISTS (SELECT 1 FROM pg_constraint
  WHERE conrelid='public.course_prerequisites'::regclass AND contype='p'
    AND conname='course_prerequisites_pkey'), 'course prerequisites have a composite primary key');
INSERT INTO public.course_prerequisites(course_id,prerequisite_course_id,minimum_grade)
VALUES ('62300000-0000-4000-8000-000000000002','62300000-0000-4000-8000-000000000001',70);
SELECT extensions.is((SELECT count(*)::integer FROM public.course_prerequisites
  WHERE course_id='62300000-0000-4000-8000-000000000002'),1,'valid course prerequisite applies');
SELECT extensions.throws_ok($$INSERT INTO public.course_prerequisites(course_id,prerequisite_course_id) VALUES ('62300000-0000-4000-8000-000000000001','62300000-0000-4000-8000-000000000001')$$,
  '23514',NULL,'course cannot be its own prerequisite');
SELECT extensions.throws_ok($$INSERT INTO public.course_prerequisites(course_id,prerequisite_course_id,minimum_grade) VALUES ('62300000-0000-4000-8000-000000000002','62300000-0000-4000-8000-000000000001',101)$$,
  '23514',NULL,'minimum prerequisite grade cannot exceed 100');
SELECT extensions.throws_ok($$INSERT INTO public.course_prerequisites(course_id,prerequisite_course_id) VALUES ('62300000-0000-4000-8000-000000000002','62300000-0000-4000-8000-000000000099')$$,
  '23503',NULL,'prerequisite must reference an existing course');

INSERT INTO public.posts(id,author_id,college_id,department_id,content)
VALUES ('62400000-0000-4000-8000-000000000001','62000000-0000-4000-8000-000000000001',
 '62100000-0000-4000-8000-000000000001','62200000-0000-4000-8000-000000000001','P2 post one'),
 ('62400000-0000-4000-8000-000000000002','62000000-0000-4000-8000-000000000001',
 '62100000-0000-4000-8000-000000000001',NULL,'P2 post two');
SELECT extensions.is((SELECT department_id::text FROM public.posts
  WHERE id='62400000-0000-4000-8000-000000000001'),
  '62200000-0000-4000-8000-000000000001','post department relationship stores the referenced department');
SELECT extensions.throws_ok($$INSERT INTO public.posts(author_id,department_id,content) VALUES ('62000000-0000-4000-8000-000000000001','62200000-0000-4000-8000-000000000099','bad department')$$,
  '23503',NULL,'post department must reference an existing department');

INSERT INTO public.post_comments(id,post_id,author_id,content,parent_id)
VALUES ('62500000-0000-4000-8000-000000000001','62400000-0000-4000-8000-000000000001',
 '62000000-0000-4000-8000-000000000001','Root comment',NULL);
INSERT INTO public.post_comments(id,post_id,author_id,content,parent_id)
VALUES ('62500000-0000-4000-8000-000000000002','62400000-0000-4000-8000-000000000001',
 '62000000-0000-4000-8000-000000000001','Same post reply','62500000-0000-4000-8000-000000000001');
SELECT extensions.is((SELECT count(*)::integer FROM public.post_comments
  WHERE id='62500000-0000-4000-8000-000000000002'),1,'reply to a comment in the same post is valid');
SELECT extensions.throws_ok($$INSERT INTO public.post_comments(post_id,author_id,content,parent_id) VALUES ('62400000-0000-4000-8000-000000000002','62000000-0000-4000-8000-000000000001','cross post reply','62500000-0000-4000-8000-000000000001')$$,
  '23503',NULL,'reply to a comment from another post is rejected');

SELECT * FROM extensions.finish();
ROLLBACK;
