-- Read-only LOCAL audit; run after reset/tests as postgres.
SELECT 'profiles_without_auth' AS check_name,count(*) AS violations
FROM public.profiles p LEFT JOIN auth.users u ON u.id=p.id WHERE u.id IS NULL
UNION ALL SELECT 'auth_without_profile',count(*) FROM auth.users u LEFT JOIN public.profiles p ON p.id=u.id WHERE p.id IS NULL
UNION ALL SELECT 'invalid_role_permissions',count(*) FROM public.role_permissions rp
 LEFT JOIN public.role_definitions r ON r.id=rp.role_id LEFT JOIN public.permissions p ON p.id=rp.permission_id WHERE r.id IS NULL OR p.id IS NULL
UNION ALL SELECT 'profile_department_college_mismatch',count(*) FROM public.profiles p JOIN public.departments d ON d.id=p.department_id
 WHERE p.college_id IS NOT NULL AND p.college_id<>d.college_id
UNION ALL SELECT 'unknown_role_codes',count(*) FROM public.role_definitions r
 WHERE r.code <> ALL(ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
UNION ALL SELECT 'duplicate_assignments',count(*) FROM (SELECT user_id,role_id FROM public.user_roles GROUP BY 1,2 HAVING count(*)>1) x
UNION ALL SELECT 'duplicate_permissions',count(*) FROM (SELECT code FROM public.permissions GROUP BY 1 HAVING count(*)>1) x
UNION ALL SELECT 'orphan_messages',count(*) FROM public.messages m LEFT JOIN public.conversations c ON c.id=m.conversation_id WHERE c.id IS NULL
UNION ALL SELECT 'development_encryption_keys',count(*) FROM public.encryption_keys;

SELECT r.code,count(*) assignments,count(*) FILTER (WHERE ur.expires_at<=now()) expired
FROM public.role_definitions r LEFT JOIN public.user_roles ur ON ur.role_id=r.id GROUP BY r.code ORDER BY r.code;
SELECT c.oid::regclass AS relation,c.relrowsecurity AS rls,c.relforcerowsecurity AS forced,
 has_table_privilege('anon',c.oid,'SELECT,INSERT,UPDATE,DELETE') AS anon_dml,
 has_table_privilege('authenticated',c.oid,'SELECT,INSERT,UPDATE,DELETE') AS authenticated_dml,
 (SELECT count(*) FROM pg_policy p WHERE p.polrelid=c.oid) AS policy_count
FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace WHERE n.nspname='public' AND c.relkind IN ('r','p') ORDER BY c.relname;
SELECT p.oid::regprocedure AS function,p.prosecdef,p.proconfig,
 EXISTS(SELECT 1 FROM aclexplode(COALESCE(p.proacl,acldefault('f',p.proowner))) a WHERE a.grantee=0 AND a.privilege_type='EXECUTE') AS public_execute,
 has_function_privilege('anon',p.oid,'EXECUTE') AS anon_execute,
 has_function_privilege('authenticated',p.oid,'EXECUTE') AS authenticated_execute
FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace WHERE n.nspname='public' ORDER BY p.proname;
SELECT conrelid::regclass,conname,pg_get_constraintdef(oid) FROM pg_constraint
 WHERE connamespace='public'::regnamespace AND NOT convalidated ORDER BY 1,2;
