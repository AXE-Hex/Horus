-- ============================================================================
--  013_library.sql — LIBRARY SYSTEM
--  Purpose : Digital and physical library catalog, reservations, and borrowing.
--  Depends : 004_identity.sql, 005_institution.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. LIBRARY ITEMS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_items (
  id              UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  title           TEXT              NOT NULL,
  title_ar        TEXT,
  author          TEXT              NOT NULL,
  author_ar       TEXT,
  isbn            TEXT              UNIQUE,
  publisher       TEXT,
  publish_year    INT               CHECK (publish_year > 1000),
  category        TEXT              NOT NULL,
  item_type       library_item_type NOT NULL DEFAULT 'book',
  description     TEXT,
  description_ar  TEXT,
  cover_url       TEXT,
  file_url        TEXT,             -- For digital assets
  -- Physical inventory
  total_copies    INT               NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
  available_copies INT              NOT NULL DEFAULT 1 CHECK (available_copies >= 0),
  location_shelf  TEXT,
  college_id      UUID              REFERENCES public.colleges(id) ON DELETE CASCADE,
  -- Stats
  view_count      INT               NOT NULL DEFAULT 0,
  borrow_count    INT               NOT NULL DEFAULT 0,
  created_at      TIMESTAMPTZ       NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.library_items ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS library_items_updated_at ON public.library_items;
CREATE TRIGGER library_items_updated_at
  BEFORE UPDATE ON public.library_items
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. LIBRARY BORROWS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_borrows (
  id              UUID          PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID          NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID          NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  borrowed_at     TIMESTAMPTZ   NOT NULL DEFAULT now(),
  due_date        DATE          NOT NULL,
  returned_at     TIMESTAMPTZ,
  status          borrow_status NOT NULL DEFAULT 'borrowed',
  fine_amount     NUMERIC(8,2)  NOT NULL DEFAULT 0,
  issued_by       UUID          REFERENCES public.profiles(id) ON DELETE SET NULL,
  received_by     UUID          REFERENCES public.profiles(id) ON DELETE SET NULL,
  notes           TEXT,
  created_at      TIMESTAMPTZ   NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ   NOT NULL DEFAULT now()
);
ALTER TABLE public.library_borrows ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS library_borrows_updated_at ON public.library_borrows;
CREATE TRIGGER library_borrows_updated_at
  BEFORE UPDATE ON public.library_borrows
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. LIBRARY RESERVATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_reservations (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  reserved_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at      TIMESTAMPTZ NOT NULL,
  status          TEXT        NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'fulfilled', 'cancelled', 'expired')),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.library_reservations ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. DIGITAL READING HISTORY
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.library_reading_history (
  id              UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         UUID        NOT NULL REFERENCES public.library_items(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  last_page       INT         NOT NULL DEFAULT 1,
  progress_pct    NUMERIC(5,2) NOT NULL DEFAULT 0,
  last_read_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (item_id, user_id)
);
ALTER TABLE public.library_reading_history ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_lib_items_category      ON public.library_items(category);
CREATE INDEX IF NOT EXISTS idx_lib_items_type          ON public.library_items(item_type);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_user        ON public.library_borrows(user_id);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_item        ON public.library_borrows(item_id);
CREATE INDEX IF NOT EXISTS idx_lib_borrows_status      ON public.library_borrows(status);
CREATE INDEX IF NOT EXISTS idx_lib_resv_user           ON public.library_reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_lib_history_user        ON public.library_reading_history(user_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.library_reading_history CASCADE;
-- DROP TABLE IF EXISTS public.library_reservations CASCADE;
-- DROP TABLE IF EXISTS public.library_borrows CASCADE;
-- DROP TABLE IF EXISTS public.library_items CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
