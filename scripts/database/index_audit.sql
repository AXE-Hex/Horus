SELECT c.conrelid::regclass, c.conname, pg_get_constraintdef(c.oid)
FROM pg_constraint c JOIN pg_namespace n ON n.oid=c.connamespace
WHERE n.nspname='public' AND c.contype='f' AND NOT EXISTS (
 SELECT 1 FROM pg_index i WHERE i.indrelid=c.conrelid AND i.indisvalid
 AND i.indpred IS NULL AND (i.indkey::smallint[])[0:cardinality(c.conkey)-1]=c.conkey)
ORDER BY 1;
SELECT a.indexrelid::regclass duplicate, b.indexrelid::regclass covering
FROM pg_index a JOIN pg_index b ON a.indrelid=b.indrelid AND a.indexrelid>b.indexrelid
AND a.indkey=b.indkey AND a.indclass=b.indclass AND a.indcollation=b.indcollation
AND a.indoption=b.indoption AND a.indpred IS NOT DISTINCT FROM b.indpred
AND a.indexprs IS NOT DISTINCT FROM b.indexprs
JOIN pg_class t ON t.oid=a.indrelid JOIN pg_namespace n ON n.oid=t.relnamespace
WHERE n.nspname='public' AND NOT t.relispartition;
