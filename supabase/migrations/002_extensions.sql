-- ============================================================================
--  002_extensions.sql — POSTGRESQL EXTENSIONS
--  Purpose : Install all required PostgreSQL extensions.
--  Depends : 001_reset.sql
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";      -- gen_random_uuid(), crypt(), gen_salt()
CREATE EXTENSION IF NOT EXISTS "moddatetime";   -- Automatic updated_at maintenance
-- CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- Trigram similarity for fuzzy search (future)

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP EXTENSION IF EXISTS "moddatetime";
-- DROP EXTENSION IF EXISTS "pgcrypto";
-- ════════════════════════════════════════════════════════════════════════════
