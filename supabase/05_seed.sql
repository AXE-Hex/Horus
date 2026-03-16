-- ============================================================================
--  FILE 5 OF 6 — SEED DATA (optional, idempotent)
--  Purpose : Insert a small, deterministic baseline dataset so the app can run
--            in a fresh environment without manual setup.
--  Depends : 01_reset.sql → 02_foundation.sql → 03_tables.sql → 04_functions_triggers_rls.sql
--  Notes   : This file is intentionally lightweight. Extend as needed.
-- ============================================================================

BEGIN;

-- ── Colleges ────────────────────────────────────────────────────────────────
-- Use `code` as the stable natural key (unique).
INSERT INTO public.colleges (code, name_en, name_ar, established)
VALUES
  ('dentistry', 'Faculty of Dentistry', 'كلية طب الفم والأسنان', 2013),
  ('pharmacy',  'Faculty of Pharmacy',  'كلية الصيدلة',         2013)
ON CONFLICT (code) DO UPDATE SET
  name_en      = EXCLUDED.name_en,
  name_ar      = EXCLUDED.name_ar,
  established  = EXCLUDED.established;

-- ── Departments ─────────────────────────────────────────────────────────────
-- Reference college via its `code` so this remains idempotent.
INSERT INTO public.departments (college_id, code, name_en, name_ar)
VALUES
  (
    (SELECT id FROM public.colleges WHERE code = 'dentistry'),
    'dentistry_omfs',
    'Oral and Maxillofacial Surgery',
    'قسم جراحة الفم والوجة والفكين'
  ),
  (
    (SELECT id FROM public.colleges WHERE code = 'dentistry'),
    'dentistry_ortho_pedo',
    'Orthodontics and Pediatric Dentistry',
    'قسم التقويم وطب أسنان الأطفال'
  ),
  (
    (SELECT id FROM public.colleges WHERE code = 'dentistry'),
    'dentistry_periodontics',
    'Periodontics and Oral Medicine',
    'قسم أمراض اللثة وطب الفم'
  ),
  (
    (SELECT id FROM public.colleges WHERE code = 'pharmacy'),
    'pharmacy_chem',
    'Pharmaceutical Chemistry',
    'قسم الكيمياء الصيدلية'
  ),
  (
    (SELECT id FROM public.colleges WHERE code = 'pharmacy'),
    'pharmacy_pharmacognosy',
    'Pharmacognosy',
    'قسم العقاقير'
  ),
  (
    (SELECT id FROM public.colleges WHERE code = 'pharmacy'),
    'pharmacy_clinical',
    'Clinical Pharmacy',
    'قسم الصيدلة الإكلينيكية'
  )
ON CONFLICT (code) DO UPDATE SET
  name_en = EXCLUDED.name_en,
  name_ar = EXCLUDED.name_ar;

COMMIT;

