-- ============================================================================
--  014_system.sql — SYSTEM, LOGS, SECURITY & CONFIGURATION
--  Purpose : Cross-cutting concerns: audit logs, analytics, multi-channel 
--            notifications, field-level encryption, system config.
--  Depends : 004_identity.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. SYSTEM SETTINGS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.system_settings (
  key         TEXT        PRIMARY KEY,
  value       JSONB       NOT NULL,
  description TEXT,
  updated_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.system_settings ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. FIELD ENCRYPTION KEYS (Vault substitute)
-- ══════════════════════════════════════════════════════════════════════════════
-- Used to encrypt sensitive fields like national_id using pgcrypto.

CREATE TABLE IF NOT EXISTS public.encryption_keys (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  context     encryption_context NOT NULL UNIQUE,
  key_hash    TEXT               NOT NULL, -- securely hashed material
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ        NOT NULL DEFAULT now()
);
ALTER TABLE public.encryption_keys ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.encrypted_data (
  id          UUID               PRIMARY KEY DEFAULT gen_random_uuid(),
  context     encryption_context NOT NULL REFERENCES public.encryption_keys(context) ON DELETE RESTRICT,
  target_id   UUID               NOT NULL, -- polymorphic reference
  target_table TEXT              NOT NULL,
  cipher_text BYTEA              NOT NULL,
  created_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ        NOT NULL DEFAULT now(),
  UNIQUE (target_id, target_table, context)
);
ALTER TABLE public.encrypted_data ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. AUDIT LOGS (Partitioned by Year)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.audit_logs (
  id           UUID         NOT NULL DEFAULT gen_random_uuid(),
  performed_by UUID,        -- logical FK (cannot be true FK on partitioned table without partition key)
  target_user  UUID,        -- logical FK
  action       audit_action NOT NULL,
  table_name   TEXT,
  record_id    UUID,
  old_data     JSONB,
  new_data     JSONB,
  ip_address   INET,
  user_agent   TEXT,
  notes        TEXT,
  created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.audit_logs_y2025 PARTITION OF public.audit_logs FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
CREATE TABLE public.audit_logs_y2026 PARTITION OF public.audit_logs FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
CREATE TABLE public.audit_logs_future PARTITION OF public.audit_logs DEFAULT;

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. ANALYTICS EVENTS (Partitioned by Month)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.analytics_events (
  id          UUID        NOT NULL DEFAULT gen_random_uuid(),
  user_id     UUID,       -- logical FK
  session_id  UUID,       -- logical FK
  event_name  TEXT        NOT NULL,
  event_data  JSONB       DEFAULT '{}',
  platform    TEXT,
  version     TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.analytics_events_y2025m05 PARTITION OF public.analytics_events FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.analytics_events_y2025m06 PARTITION OF public.analytics_events FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.analytics_events_future PARTITION OF public.analytics_events DEFAULT;

ALTER TABLE public.analytics_events ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. NOTIFICATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.notifications (
  id         UUID              PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    UUID              NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title      TEXT              NOT NULL,
  title_ar   TEXT,
  message    TEXT              NOT NULL,
  message_ar TEXT,
  type       notification_type NOT NULL DEFAULT 'info',
  is_read    BOOLEAN           NOT NULL DEFAULT FALSE,
  action_url TEXT,
  metadata   JSONB             DEFAULT '{}',
  read_at    TIMESTAMPTZ,
  created_at TIMESTAMPTZ       NOT NULL DEFAULT now()
);
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Track delivery status across channels (email, sms, push)
CREATE TABLE IF NOT EXISTS public.notification_deliveries (
  id              UUID                  NOT NULL DEFAULT gen_random_uuid(),
  notification_id UUID                  NOT NULL, -- logical FK
  channel         notif_channel         NOT NULL,
  status          notif_delivery_status NOT NULL DEFAULT 'pending',
  provider_ref    TEXT,                 -- e.g., SendGrid message ID
  error_message   TEXT,
  created_at      TIMESTAMPTZ           NOT NULL DEFAULT now(),
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

CREATE TABLE public.notif_deliv_y2025 PARTITION OF public.notification_deliveries FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
CREATE TABLE public.notif_deliv_future PARTITION OF public.notification_deliveries DEFAULT;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_audit_performed_by        ON public.audit_logs(performed_by);
CREATE INDEX IF NOT EXISTS idx_audit_target_user         ON public.audit_logs(target_user);
CREATE INDEX IF NOT EXISTS idx_audit_action              ON public.audit_logs(action);

CREATE INDEX IF NOT EXISTS idx_analytics_user            ON public.analytics_events(user_id);
CREATE INDEX IF NOT EXISTS idx_analytics_name            ON public.analytics_events(event_name);

CREATE INDEX IF NOT EXISTS idx_notifications_user        ON public.notifications(user_id, is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at  ON public.notifications(created_at DESC);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.notification_deliveries CASCADE;
-- DROP TABLE IF EXISTS public.notifications CASCADE;
-- DROP TABLE IF EXISTS public.analytics_events CASCADE;
-- DROP TABLE IF EXISTS public.audit_logs CASCADE;
-- DROP TABLE IF EXISTS public.encrypted_data CASCADE;
-- DROP TABLE IF EXISTS public.encryption_keys CASCADE;
-- DROP TABLE IF EXISTS public.system_settings CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
