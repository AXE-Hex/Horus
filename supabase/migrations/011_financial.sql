-- ============================================================================
--  011_financial.sql — FINANCIAL SYSTEM
--  Purpose : Invoices, payments, schedules, and scholarships.
--  Depends : 004_identity.sql, 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. INVOICES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.invoices (
  id             UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  student_id     UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester       TEXT           NOT NULL,
  semester_id    UUID           REFERENCES public.semesters(id) ON DELETE SET NULL,
  description    TEXT           NOT NULL,
  description_ar TEXT,
  amount         NUMERIC(10,2)  NOT NULL CHECK (amount > 0),
  currency       TEXT           NOT NULL DEFAULT 'EGP', -- Consider a currency table in V2
  status         payment_status NOT NULL DEFAULT 'pending',
  due_date       DATE,
  paid_at        TIMESTAMPTZ,
  receipt_url    TEXT,
  metadata       JSONB          DEFAULT '{}',
  created_at     TIMESTAMPTZ    NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.invoices ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS invoices_updated_at ON public.invoices;
CREATE TRIGGER invoices_updated_at
  BEFORE UPDATE ON public.invoices
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. PAYMENT TRANSACTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.payment_transactions (
  id                UUID                 PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_id        UUID                 NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
  student_id        UUID                 NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount            NUMERIC(10,2)        NOT NULL CHECK (amount > 0),
  currency          TEXT                 NOT NULL DEFAULT 'EGP',
  payment_method    payment_method       NOT NULL,
  gateway           payment_gateway_type,
  transaction_ref   TEXT                 UNIQUE,
  status            payment_status       NOT NULL DEFAULT 'pending',
  gateway_response  JSONB                DEFAULT '{}',
  processed_at      TIMESTAMPTZ,
  created_at        TIMESTAMPTZ          NOT NULL DEFAULT now()
);
ALTER TABLE public.payment_transactions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. INVOICE SCHEDULES (Installments)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.invoice_schedules (
  id              UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  parent_invoice  UUID           NOT NULL REFERENCES public.invoices(id) ON DELETE CASCADE,
  installment_num INT            NOT NULL CHECK (installment_num > 0),
  amount          NUMERIC(10,2)  NOT NULL CHECK (amount > 0),
  due_date        DATE           NOT NULL,
  status          payment_status NOT NULL DEFAULT 'pending',
  paid_at         TIMESTAMPTZ,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  UNIQUE (parent_invoice, installment_num)
);
ALTER TABLE public.invoice_schedules ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS invoice_schedules_updated_at ON public.invoice_schedules;
CREATE TRIGGER invoice_schedules_updated_at
  BEFORE UPDATE ON public.invoice_schedules
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. SCHOLARSHIPS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.scholarships (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name_en         TEXT        NOT NULL,
  name_ar         TEXT        NOT NULL,
  description_en  TEXT,
  description_ar  TEXT,
  discount_pct    NUMERIC(5,2) CHECK (discount_pct BETWEEN 0 AND 100),
  discount_amount NUMERIC(10,2) CHECK (discount_amount >= 0),
  -- Require either percentage OR amount
  CONSTRAINT chk_scholarship_value CHECK (
    (discount_pct IS NOT NULL AND discount_amount IS NULL) OR
    (discount_pct IS NULL AND discount_amount IS NOT NULL)
  ),
  is_active       BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.scholarships ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. SCHOLARSHIP APPLICATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.scholarship_applications (
  id              UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  scholarship_id  UUID               NOT NULL REFERENCES public.scholarships(id) ON DELETE CASCADE,
  student_id      UUID               NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  semester        TEXT               NOT NULL,
  semester_id     UUID               REFERENCES public.semesters(id) ON DELETE SET NULL,
  status          scholarship_status NOT NULL DEFAULT 'applied',
  documents       TEXT[]             DEFAULT '{}',
  reviewed_by     UUID               REFERENCES public.profiles(id) ON DELETE SET NULL,
  review_notes    TEXT,
  applied_at      TIMESTAMPTZ        NOT NULL DEFAULT now(),
  reviewed_at     TIMESTAMPTZ,
  UNIQUE (scholarship_id, student_id, semester)
);
ALTER TABLE public.scholarship_applications ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_invoices_student          ON public.invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_invoices_status           ON public.invoices(status);
CREATE INDEX IF NOT EXISTS idx_invoices_semester         ON public.invoices(semester_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_invoice        ON public.payment_transactions(invoice_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_student        ON public.payment_transactions(student_id);
CREATE INDEX IF NOT EXISTS idx_payment_tx_status         ON public.payment_transactions(status);
CREATE INDEX IF NOT EXISTS idx_scholarship_app_student   ON public.scholarship_applications(student_id);
CREATE INDEX IF NOT EXISTS idx_scholarship_app_status    ON public.scholarship_applications(status);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.scholarship_applications CASCADE;
-- DROP TABLE IF EXISTS public.scholarships CASCADE;
-- DROP TABLE IF EXISTS public.invoice_schedules CASCADE;
-- DROP TABLE IF EXISTS public.payment_transactions CASCADE;
-- DROP TABLE IF EXISTS public.invoices CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
