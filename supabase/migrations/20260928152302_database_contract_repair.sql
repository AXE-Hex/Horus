-- Repair the client-facing contracts added in Phase 2 without rewriting
-- historical migrations or removing existing application data.

-- Course prerequisites are a real relation, so keep them normalized and
-- reference both sides of the relationship explicitly.
CREATE TABLE IF NOT EXISTS public.course_prerequisites (
  course_id UUID NOT NULL
    REFERENCES public.courses(id) ON DELETE CASCADE,
  prerequisite_course_id UUID NOT NULL
    REFERENCES public.courses(id) ON DELETE CASCADE,
  minimum_grade NUMERIC(5,2) NOT NULL DEFAULT 50
    CHECK (minimum_grade BETWEEN 0 AND 100),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT course_prerequisites_pkey
    PRIMARY KEY (course_id, prerequisite_course_id),
  CONSTRAINT course_prerequisites_no_self_reference
    CHECK (course_id <> prerequisite_course_id)
);
CREATE INDEX IF NOT EXISTS idx_course_prerequisites_prerequisite
  ON public.course_prerequisites(prerequisite_course_id);
ALTER TABLE public.course_prerequisites ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS course_prerequisites_select_authenticated
  ON public.course_prerequisites;
CREATE POLICY course_prerequisites_select_authenticated
  ON public.course_prerequisites FOR SELECT TO authenticated
  USING (TRUE);

-- A post may target a department as well as a college.
ALTER TABLE public.posts
  ADD COLUMN IF NOT EXISTS department_id UUID
    REFERENCES public.departments(id) ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS idx_posts_department_id
  ON public.posts(department_id);

-- Threaded comments must reply to a comment on the same post.
ALTER TABLE public.post_comments
  ADD COLUMN IF NOT EXISTS parent_id UUID;
ALTER TABLE public.post_comments
  ADD CONSTRAINT post_comments_post_id_id_key UNIQUE (post_id, id);
ALTER TABLE public.post_comments
  ADD CONSTRAINT post_comments_parent_same_post_fkey
  FOREIGN KEY (post_id, parent_id)
  REFERENCES public.post_comments(post_id, id)
  ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_post_comments_parent_id
  ON public.post_comments(parent_id);
