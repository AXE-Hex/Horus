-- ============================================================================
--  009_social.sql — SOCIAL & COMMUNICATION
--  Purpose : Social feed, posts, student groups, announcements, shared files, forums.
--  Depends : 004_identity.sql, 005_institution.sql, 006_academic.sql
-- ============================================================================

-- ══════════════════════════════════════════════════════════════════════════════
-- 1. POSTS (Social Feed)
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.posts (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id      UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  college_id     UUID        REFERENCES public.colleges(id) ON DELETE CASCADE,
  content        TEXT        NOT NULL,
  media_urls     TEXT[]      NOT NULL DEFAULT '{}',
  link_url       TEXT,
  type           post_type   NOT NULL DEFAULT 'text',
  -- Denormalized counters (managed by triggers)
  likes_count    INT         NOT NULL DEFAULT 0 CHECK (likes_count >= 0),
  comments_count INT         NOT NULL DEFAULT 0 CHECK (comments_count >= 0),
  is_pinned      BOOLEAN     NOT NULL DEFAULT FALSE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS posts_updated_at ON public.posts;
CREATE TRIGGER posts_updated_at
  BEFORE UPDATE ON public.posts
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 2. POST LIKES & COMMENTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.post_likes (
  post_id    UUID        NOT NULL REFERENCES public.posts(id) ON DELETE CASCADE,
  user_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (post_id, user_id)
);
ALTER TABLE public.post_likes ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.post_comments (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id    UUID        NOT NULL REFERENCES public.posts(id) ON DELETE CASCADE,
  author_id  UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  content    TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ
);
ALTER TABLE public.post_comments ENABLE ROW LEVEL SECURITY;

DROP TRIGGER IF EXISTS post_comments_updated_at ON public.post_comments;
CREATE TRIGGER post_comments_updated_at
  BEFORE UPDATE ON public.post_comments
  FOR EACH ROW EXECUTE FUNCTION moddatetime(updated_at);

-- ══════════════════════════════════════════════════════════════════════════════
-- 3. STUDENT GROUPS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.student_groups (
  id           UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  professor_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id    UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  name         TEXT        NOT NULL,
  name_ar      TEXT,
  description  TEXT,
  max_students INT         NOT NULL DEFAULT 50 CHECK (max_students > 0),
  is_active    BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.student_groups ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.group_members (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  group_id   UUID        NOT NULL REFERENCES public.student_groups(id) ON DELETE CASCADE,
  student_id UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  joined_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (group_id, student_id)
);
ALTER TABLE public.group_members ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 4. ANNOUNCEMENTS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.announcements (
  id           UUID                  PRIMARY KEY DEFAULT gen_random_uuid(),
  author_id    UUID                  NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  college_id   UUID                  REFERENCES public.colleges(id) ON DELETE CASCADE,
  department_id UUID                 REFERENCES public.departments(id) ON DELETE CASCADE,
  course_id    UUID                  REFERENCES public.courses(id) ON DELETE SET NULL,
  title        TEXT                  NOT NULL,
  title_ar     TEXT,
  content      TEXT                  NOT NULL,
  content_ar   TEXT,
  priority     announcement_priority NOT NULL DEFAULT 'normal',
  is_pinned    BOOLEAN               NOT NULL DEFAULT FALSE,
  published_at TIMESTAMPTZ           NOT NULL DEFAULT now(),
  expires_at   TIMESTAMPTZ,
  CONSTRAINT chk_announcement_dates CHECK (expires_at IS NULL OR expires_at > published_at),
  created_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ           NOT NULL DEFAULT now(),
  deleted_at   TIMESTAMPTZ
);
ALTER TABLE public.announcements ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 5. SHARED FILES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.shared_files (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  uploader_id    UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  course_id      UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
  title          TEXT        NOT NULL,
  title_ar       TEXT,
  file_path      TEXT        NOT NULL,
  file_type      file_type   NOT NULL DEFAULT 'other',
  file_size      BIGINT      CHECK (file_size >= 0),
  download_count INT         NOT NULL DEFAULT 0 CHECK (download_count >= 0),
  is_public      BOOLEAN     NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at     TIMESTAMPTZ
);
ALTER TABLE public.shared_files ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 6. FORUMS
-- ══════════════════════════════════════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.forums (
  id          UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT           NOT NULL,
  name_ar     TEXT,
  description TEXT,
  category    forum_category NOT NULL DEFAULT 'general',
  is_active   BOOLEAN        NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ    NOT NULL DEFAULT now()
);
ALTER TABLE public.forums ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS public.forum_posts (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  forum_id    UUID        NOT NULL REFERENCES public.forums(id) ON DELETE CASCADE,
  author_id   UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT        NOT NULL,
  content     TEXT        NOT NULL,
  is_pinned   BOOLEAN     NOT NULL DEFAULT FALSE,
  reply_count INT         NOT NULL DEFAULT 0 CHECK (reply_count >= 0),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at  TIMESTAMPTZ
);
ALTER TABLE public.forum_posts ENABLE ROW LEVEL SECURITY;

-- ══════════════════════════════════════════════════════════════════════════════
-- 7. INDEXES
-- ══════════════════════════════════════════════════════════════════════════════

CREATE INDEX IF NOT EXISTS idx_posts_created_at          ON public.posts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_posts_author_id           ON public.posts(author_id);
CREATE INDEX IF NOT EXISTS idx_posts_college_id          ON public.posts(college_id);
CREATE INDEX IF NOT EXISTS idx_posts_type                ON public.posts(type);
CREATE INDEX IF NOT EXISTS idx_post_comments_post        ON public.post_comments(post_id);

CREATE INDEX IF NOT EXISTS idx_announcements_course      ON public.announcements(course_id);
CREATE INDEX IF NOT EXISTS idx_announcements_college     ON public.announcements(college_id);
CREATE INDEX IF NOT EXISTS idx_announcements_priority    ON public.announcements(priority);
CREATE INDEX IF NOT EXISTS idx_announcements_active      ON public.announcements(published_at) WHERE deleted_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_shared_files_course       ON public.shared_files(course_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_forum         ON public.forum_posts(forum_id);
CREATE INDEX IF NOT EXISTS idx_forum_posts_author        ON public.forum_posts(author_id);

-- ════════════════════════════════════════════════════════════════════════════
-- ROLLBACK:
-- DROP TABLE IF EXISTS public.forum_posts CASCADE;
-- DROP TABLE IF EXISTS public.forums CASCADE;
-- DROP TABLE IF EXISTS public.shared_files CASCADE;
-- DROP TABLE IF EXISTS public.announcements CASCADE;
-- DROP TABLE IF EXISTS public.group_members CASCADE;
-- DROP TABLE IF EXISTS public.student_groups CASCADE;
-- DROP TABLE IF EXISTS public.post_comments CASCADE;
-- DROP TABLE IF EXISTS public.post_likes CASCADE;
-- DROP TABLE IF EXISTS public.posts CASCADE;
-- ════════════════════════════════════════════════════════════════════════════
