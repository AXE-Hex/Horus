-- LOCAL ONLY. Validate staged constraints against reset/fixture data, then
-- rollback so the inventory accurately retains migration rollout state.
BEGIN;
DO $validation$
DECLARE c record;
BEGIN
 FOR c IN SELECT conrelid,conname FROM pg_constraint
   WHERE connamespace='public'::regnamespace AND NOT convalidated
     AND conparentid=0 ORDER BY conrelid,conname LOOP
   EXECUTE format('ALTER TABLE %s VALIDATE CONSTRAINT %I',c.conrelid::regclass,c.conname);
 END LOOP;
END;
$validation$;
ROLLBACK;
