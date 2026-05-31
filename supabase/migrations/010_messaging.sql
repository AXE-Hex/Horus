-- ============================================================================
--  010_messaging.sql — MESSAGING SYSTEM
--  Purpose : Real-time chat, conversations, and partitioned messages.
--  Depends : 004_identity.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. CONVERSATIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.conversations (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  title        TEXT,                                    -- null for direct 1-on-1 messages
  is_group     BOOLEAN     NOT NULL DEFAULT FALSE,
  created_by   UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  last_message TEXT,
  last_message_at TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS conversations_updated_at ON public.conversations;
CREATE TRIGGER conversations_updated_at
  BEFORE UPDATE ON public.conversations
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. CONVERSATION MEMBERS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.conversation_members (
  conversation_id UUID        NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  user_id         UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_read_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_admin        BOOLEAN     NOT NULL DEFAULT FALSE,
  is_muted        BOOLEAN     NOT NULL DEFAULT FALSE,
  PRIMARY KEY (conversation_id, user_id)
);
ALTER TABLE public.conversation_members ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. MESSAGES (PARTITIONED)
-- ══════════════════════════════════════════════════════════════════════════════
-- Because messages scale rapidly, we partition by created_at (monthly).
-- Note: Partitioned tables cannot have foreign keys pointing TO them in standard PG
-- unless the referencing table includes the partition key.

CREATE TABLE IF NOT EXISTS public.messages (
  id              UUID           NOT NULL DEFAULT gen_random_uuid(),
  conversation_id UUID           NOT NULL, -- Cannot be standard FK due to partitioning constraints in some PG versions, handled by app logic or relaxed constraint
  sender_id       UUID           NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content         TEXT           NOT NULL,
  media_url       TEXT,
  status          message_status NOT NULL DEFAULT 'sent',
  reply_to_id     UUID,
  is_edited       BOOLEAN        NOT NULL DEFAULT FALSE,
  created_at      TIMESTAMPTZ    NOT NULL DEFAULT now(),
  deleted_at      TIMESTAMPTZ,
  PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

-- Initial partitions
CREATE TABLE public.messages_y2025m01 PARTITION OF public.messages FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');
CREATE TABLE public.messages_y2025m02 PARTITION OF public.messages FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');
CREATE TABLE public.messages_y2025m03 PARTITION OF public.messages FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');
CREATE TABLE public.messages_y2025m04 PARTITION OF public.messages FOR VALUES FROM ('2025-04-01') TO ('2025-05-01');
CREATE TABLE public.messages_y2025m05 PARTITION OF public.messages FOR VALUES FROM ('2025-05-01') TO ('2025-06-01');
CREATE TABLE public.messages_y2025m06 PARTITION OF public.messages FOR VALUES FROM ('2025-06-01') TO ('2025-07-01');
CREATE TABLE public.messages_y2025m07 PARTITION OF public.messages FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');
CREATE TABLE public.messages_y2025m08 PARTITION OF public.messages FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');
CREATE TABLE public.messages_y2025m09 PARTITION OF public.messages FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');
CREATE TABLE public.messages_y2025m10 PARTITION OF public.messages FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');
CREATE TABLE public.messages_y2025m11 PARTITION OF public.messages FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');
CREATE TABLE public.messages_y2025m12 PARTITION OF public.messages FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');
CREATE TABLE public.messages_y2026m01 PARTITION OF public.messages FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');
CREATE TABLE public.messages_y2026m02 PARTITION OF public.messages FOR VALUES FROM ('2026-02-01') TO ('2026-03-01');
CREATE TABLE public.messages_y2026m03 PARTITION OF public.messages FOR VALUES FROM ('2026-03-01') TO ('2026-04-01');
CREATE TABLE public.messages_y2026m04 PARTITION OF public.messages FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');
CREATE TABLE public.messages_y2026m05 PARTITION OF public.messages FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');
CREATE TABLE public.messages_y2026m06 PARTITION OF public.messages FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');

-- Future partition bucket for anything beyond current definitions to prevent inserts from failing
CREATE TABLE public.messages_future PARTITION OF public.messages DEFAULT;

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. MESSAGE REACTIONS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.message_reactions (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id       UUID        NOT NULL, -- Logical FK
  message_created_at TIMESTAMPTZ NOT NULL, -- Needed to query partitioned table efficiently
  user_id          UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  emoji            TEXT        NOT NULL,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (message_id, user_id, emoji)
);
-- Note: Foreign key to messages omitted due to PG partitioning constraints without composite keys.
ALTER TABLE public.message_reactions ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_conversation_members_user ON public.conversation_members(user_id);
CREATE INDEX IF NOT EXISTS idx_messages_conversation_time ON public.messages(conversation_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_messages_sender ON public.messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_message_reactions_message ON public.message_reactions(message_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.message_reactions CASCADE;
-- DROP TABLE IF EXISTS public.messages CASCADE;
-- DROP TABLE IF EXISTS public.conversation_members CASCADE;
-- DROP TABLE IF EXISTS public.conversations CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
