# Horus database inventory

Generated from the LOCAL PostgreSQL 17 catalog after the September 2026 hardening reset.
`scripts/database/catalog.sql` → JSON → `scripts/database/render_inventory.py`.
Migrations remain authoritative. This snapshot is evidence, not a second schema source.

| Object | Count |
| --- | ---: |
| Tables | 69 |
| Partitions | 30 |
| Views | 1 |
| Functions | 29 |
| Triggers | 46 |
| Enums | 27 |
| Policies | 246 |
| Indexes | 303 |
| Storage buckets | 4 |

Tables exclude partition children; indexes include physical child indexes. Policies include
public application relations and Storage. Functions exclude extension-owned functions.
Triggers include application triggers on auth.users and inherited partition triggers.

## Table contracts

Each table below lists all columns and relationships, not just client-used fields. Sensitive
classification is conservative: private academic, financial, messaging, operational and
identity rows require authorization even where a particular column is not named below.
Read/write permission predicates are the exact policies in the accompanying RLS matrix.
Column grants can further restrict a table grant. Unlisted operations remain denied.

### `action_plan_items`

Purpose: Action plan items relation; bounded context and exact fields below.

Owning scope: `course_id, student_id`. Sensitive fields: `grade_letter`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `course_id` | uuid | True | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `year` | integer | False | — |
| `status` | text | False | 'planned'::text |
| `grade_letter` | text | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `action_plan_items_year_check`: CHECK ((year > 2000)); validated=True.
- `action_plan_items_status_check`: CHECK ((status = ANY (ARRAY['planned'::text, 'enrolled'::text, 'passed'::text, 'failed'::text, 'withdrawn'::text]))); validated=True.
- `action_plan_items_pkey`: PRIMARY KEY (id); validated=True.
- `action_plan_items_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `action_plan_items_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL; validated=True.
- `action_plan_items_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX action_plan_items_pkey ON public.action_plan_items USING btree (id)`
- `CREATE INDEX idx_action_plan_student ON public.action_plan_items USING btree (student_id)`

### `analytics_events`

Purpose: Analytics events relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | True | — |
| `session_id` | uuid | True | — |
| `event_name` | text | False | — |
| `event_data` | jsonb | True | '{}'::jsonb |
| `platform` | text | True | — |
| `version` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `analytics_events_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX analytics_events_pkey ON ONLY public.analytics_events USING btree (id, created_at)`
- `CREATE INDEX idx_analytics_user ON ONLY public.analytics_events USING btree (user_id)`
- `CREATE INDEX idx_analytics_name ON ONLY public.analytics_events USING btree (event_name)`

### `analytics_events_future`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | True | — |
| `session_id` | uuid | True | — |
| `event_name` | text | False | — |
| `event_data` | jsonb | True | '{}'::jsonb |
| `platform` | text | True | — |
| `version` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `analytics_events_future_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX analytics_events_future_pkey ON public.analytics_events_future USING btree (id, created_at)`
- `CREATE INDEX analytics_events_future_user_id_idx ON public.analytics_events_future USING btree (user_id)`
- `CREATE INDEX analytics_events_future_event_name_idx ON public.analytics_events_future USING btree (event_name)`

### `analytics_events_y2025m05`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | True | — |
| `session_id` | uuid | True | — |
| `event_name` | text | False | — |
| `event_data` | jsonb | True | '{}'::jsonb |
| `platform` | text | True | — |
| `version` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `analytics_events_y2025m05_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX analytics_events_y2025m05_pkey ON public.analytics_events_y2025m05 USING btree (id, created_at)`
- `CREATE INDEX analytics_events_y2025m05_user_id_idx ON public.analytics_events_y2025m05 USING btree (user_id)`
- `CREATE INDEX analytics_events_y2025m05_event_name_idx ON public.analytics_events_y2025m05 USING btree (event_name)`

### `analytics_events_y2025m06`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | True | — |
| `session_id` | uuid | True | — |
| `event_name` | text | False | — |
| `event_data` | jsonb | True | '{}'::jsonb |
| `platform` | text | True | — |
| `version` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `analytics_events_y2025m06_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX analytics_events_y2025m06_pkey ON public.analytics_events_y2025m06 USING btree (id, created_at)`
- `CREATE INDEX analytics_events_y2025m06_user_id_idx ON public.analytics_events_y2025m06 USING btree (user_id)`
- `CREATE INDEX analytics_events_y2025m06_event_name_idx ON public.analytics_events_y2025m06 USING btree (event_name)`

### `announcements`

Purpose: Announcements relation; bounded context and exact fields below.

Owning scope: `author_id, college_id, course_id, department_id`. Sensitive fields: `content`, `content_ar`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `author_id` | uuid | False | — |
| `college_id` | uuid | True | — |
| `department_id` | uuid | True | — |
| `course_id` | uuid | True | — |
| `title` | text | False | — |
| `title_ar` | text | True | — |
| `content` | text | False | — |
| `content_ar` | text | True | — |
| `priority` | announcement_priority | False | 'normal'::announcement_priority |
| `is_pinned` | boolean | False | false |
| `published_at` | timestamp with time zone | False | now() |
| `expires_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `chk_announcement_dates`: CHECK (((expires_at IS NULL) OR (expires_at > published_at))); validated=True.
- `announcements_pkey`: PRIMARY KEY (id); validated=True.
- `announcements_author_id_fkey`: FOREIGN KEY (author_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `announcements_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE CASCADE; validated=True.
- `announcements_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE; validated=True.
- `announcements_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX announcements_pkey ON public.announcements USING btree (id)`
- `CREATE INDEX idx_announcements_course ON public.announcements USING btree (course_id)`
- `CREATE INDEX idx_announcements_college ON public.announcements USING btree (college_id)`
- `CREATE INDEX idx_announcements_priority ON public.announcements USING btree (priority)`
- `CREATE INDEX idx_announcements_active ON public.announcements USING btree (published_at) WHERE (deleted_at IS NULL)`
- `CREATE INDEX idx_announcements_department_scope ON public.announcements USING btree (department_id) WHERE (deleted_at IS NULL)`

### `attempt_answers`

Purpose: Attempt answers relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `answered_at`, `text_answer`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `attempt_id` | uuid | False | — |
| `question_id` | uuid | False | — |
| `selected_option` | uuid | True | — |
| `text_answer` | text | True | — |
| `is_correct` | boolean | True | — |
| `marks_awarded` | numeric(5,2) | True | — |
| `answered_at` | timestamp with time zone | False | now() |

Constraints:

- `attempt_answers_pkey`: PRIMARY KEY (id); validated=True.
- `attempt_answers_attempt_id_question_id_key`: UNIQUE (attempt_id, question_id); validated=True.
- `attempt_answers_attempt_id_fkey`: FOREIGN KEY (attempt_id) REFERENCES exam_attempts(id) ON DELETE CASCADE; validated=True.
- `attempt_answers_question_id_fkey`: FOREIGN KEY (question_id) REFERENCES exam_questions(id) ON DELETE CASCADE; validated=True.
- `attempt_answers_selected_option_fkey`: FOREIGN KEY (selected_option) REFERENCES question_options(id) ON DELETE SET NULL; validated=True.
- `attempt_answers_marks_nonnegative`: CHECK ((marks_awarded >= (0)::numeric)) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX attempt_answers_pkey ON public.attempt_answers USING btree (id)`
- `CREATE UNIQUE INDEX attempt_answers_attempt_id_question_id_key ON public.attempt_answers USING btree (attempt_id, question_id)`

### `attendance`

Purpose: Student attendance records for academic offerings.

Owning scope: `course_id, student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `course_id` | uuid | False | — |
| `date` | date | False | — |
| `status` | attendance_status | False | 'present'::attendance_status |
| `notes` | text | True | — |
| `recorded_by` | uuid | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `attendance_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `attendance_pkey`: PRIMARY KEY (id); validated=True.
- `attendance_student_id_course_id_date_key`: UNIQUE (student_id, course_id, date); validated=True.
- `attendance_recorded_by_fkey`: FOREIGN KEY (recorded_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `attendance_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE RESTRICT NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX attendance_pkey ON public.attendance USING btree (id)`
- `CREATE UNIQUE INDEX attendance_student_id_course_id_date_key ON public.attendance USING btree (student_id, course_id, date)`
- `CREATE INDEX idx_attendance_student ON public.attendance USING btree (student_id)`
- `CREATE INDEX idx_attendance_course ON public.attendance USING btree (course_id)`
- `CREATE INDEX idx_attendance_date ON public.attendance USING btree (date)`

### `audit_logs`

Purpose: Audit logs relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `ip_address`, `new_data`, `old_data`, `user_agent`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `performed_by` | uuid | True | — |
| `target_user` | uuid | True | — |
| `action` | audit_action | False | — |
| `table_name` | text | True | — |
| `record_id` | uuid | True | — |
| `old_data` | jsonb | True | — |
| `new_data` | jsonb | True | — |
| `ip_address` | inet | True | — |
| `user_agent` | text | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `audit_logs_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX audit_logs_pkey ON ONLY public.audit_logs USING btree (id, created_at)`
- `CREATE INDEX idx_audit_performed_by ON ONLY public.audit_logs USING btree (performed_by)`
- `CREATE INDEX idx_audit_target_user ON ONLY public.audit_logs USING btree (target_user)`
- `CREATE INDEX idx_audit_action ON ONLY public.audit_logs USING btree (action)`

### `audit_logs_future`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `performed_by` | uuid | True | — |
| `target_user` | uuid | True | — |
| `action` | audit_action | False | — |
| `table_name` | text | True | — |
| `record_id` | uuid | True | — |
| `old_data` | jsonb | True | — |
| `new_data` | jsonb | True | — |
| `ip_address` | inet | True | — |
| `user_agent` | text | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `audit_logs_future_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX audit_logs_future_pkey ON public.audit_logs_future USING btree (id, created_at)`
- `CREATE INDEX audit_logs_future_performed_by_idx ON public.audit_logs_future USING btree (performed_by)`
- `CREATE INDEX audit_logs_future_target_user_idx ON public.audit_logs_future USING btree (target_user)`
- `CREATE INDEX audit_logs_future_action_idx ON public.audit_logs_future USING btree (action)`

### `audit_logs_y2025`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `performed_by` | uuid | True | — |
| `target_user` | uuid | True | — |
| `action` | audit_action | False | — |
| `table_name` | text | True | — |
| `record_id` | uuid | True | — |
| `old_data` | jsonb | True | — |
| `new_data` | jsonb | True | — |
| `ip_address` | inet | True | — |
| `user_agent` | text | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `audit_logs_y2025_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX audit_logs_y2025_pkey ON public.audit_logs_y2025 USING btree (id, created_at)`
- `CREATE INDEX audit_logs_y2025_performed_by_idx ON public.audit_logs_y2025 USING btree (performed_by)`
- `CREATE INDEX audit_logs_y2025_target_user_idx ON public.audit_logs_y2025 USING btree (target_user)`
- `CREATE INDEX audit_logs_y2025_action_idx ON public.audit_logs_y2025 USING btree (action)`

### `audit_logs_y2026`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `performed_by` | uuid | True | — |
| `target_user` | uuid | True | — |
| `action` | audit_action | False | — |
| `table_name` | text | True | — |
| `record_id` | uuid | True | — |
| `old_data` | jsonb | True | — |
| `new_data` | jsonb | True | — |
| `ip_address` | inet | True | — |
| `user_agent` | text | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `audit_logs_y2026_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX audit_logs_y2026_pkey ON public.audit_logs_y2026 USING btree (id, created_at)`
- `CREATE INDEX audit_logs_y2026_performed_by_idx ON public.audit_logs_y2026 USING btree (performed_by)`
- `CREATE INDEX audit_logs_y2026_target_user_idx ON public.audit_logs_y2026 USING btree (target_user)`
- `CREATE INDEX audit_logs_y2026_action_idx ON public.audit_logs_y2026 USING btree (action)`

### `colleges`

Purpose: Colleges relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `code` | text | True | — |
| `name_en` | text | False | — |
| `name_ar` | text | False | — |
| `description` | text | True | — |
| `description_ar` | text | True | — |
| `dean_id` | uuid | True | — |
| `image_url` | text | True | — |
| `established` | integer | True | — |
| `student_count` | integer | False | 0 |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `colleges_established_check`: CHECK ((established > 1800)); validated=True.
- `colleges_student_count_check`: CHECK ((student_count >= 0)); validated=True.
- `colleges_pkey`: PRIMARY KEY (id); validated=True.
- `colleges_code_key`: UNIQUE (code); validated=True.
- `colleges_dean_id_fkey`: FOREIGN KEY (dean_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX colleges_pkey ON public.colleges USING btree (id)`
- `CREATE UNIQUE INDEX colleges_code_key ON public.colleges USING btree (code)`
- `CREATE INDEX idx_colleges_active ON public.colleges USING btree (is_active) WHERE (is_active = true)`

### `conversation_members`

Purpose: Conversation membership and invitation state.

Owning scope: `conversation_id, user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `conversation_id` | uuid | False | — |
| `user_id` | uuid | False | — |
| `joined_at` | timestamp with time zone | False | now() |
| `last_read_at` | timestamp with time zone | False | now() |
| `is_admin` | boolean | False | false |
| `is_muted` | boolean | False | false |

Constraints:

- `conversation_members_pkey`: PRIMARY KEY (conversation_id, user_id); validated=True.
- `conversation_members_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `conversation_members_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX conversation_members_pkey ON public.conversation_members USING btree (conversation_id, user_id)`
- `CREATE INDEX idx_conversation_members_user ON public.conversation_members USING btree (user_id)`
- `CREATE INDEX idx_conversation_members_user_conversation ON public.conversation_members USING btree (user_id, conversation_id)`

### `conversations`

Purpose: Private conversation roots and creator ownership.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `title` | text | True | — |
| `is_group` | boolean | False | false |
| `created_by` | uuid | True | — |
| `last_message` | text | True | — |
| `last_message_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `conversations_pkey`: PRIMARY KEY (id); validated=True.
- `conversations_created_by_fkey`: FOREIGN KEY (created_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX conversations_pkey ON public.conversations USING btree (id)`

### `course_prerequisites`

Purpose: Course prerequisites relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: `minimum_grade`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `course_id` | uuid | False | — |
| `prerequisite_course_id` | uuid | False | — |
| `minimum_grade` | numeric(5,2) | False | 50 |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `course_prerequisites_minimum_grade_check`: CHECK (((minimum_grade >= (0)::numeric) AND (minimum_grade <= (100)::numeric))); validated=True.
- `course_prerequisites_no_self_reference`: CHECK ((course_id <> prerequisite_course_id)); validated=True.
- `course_prerequisites_pkey`: PRIMARY KEY (course_id, prerequisite_course_id); validated=True.
- `course_prerequisites_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `course_prerequisites_prerequisite_course_id_fkey`: FOREIGN KEY (prerequisite_course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX course_prerequisites_pkey ON public.course_prerequisites USING btree (course_id, prerequisite_course_id)`
- `CREATE INDEX idx_course_prerequisites_prerequisite ON public.course_prerequisites USING btree (prerequisite_course_id)`

### `course_sections`

Purpose: Course sections relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `course_id` | uuid | False | — |
| `name` | text | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `max_students` | integer | False | 50 |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `course_sections_max_students_check`: CHECK ((max_students > 0)); validated=True.
- `course_sections_pkey`: PRIMARY KEY (id); validated=True.
- `course_sections_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `course_sections_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX course_sections_pkey ON public.course_sections USING btree (id)`
- `CREATE INDEX idx_sections_course ON public.course_sections USING btree (course_id)`

### `course_sub_sections`

Purpose: Course sub sections relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `section_id` | uuid | False | — |
| `name` | text | False | — |
| `max_students` | integer | False | 25 |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `course_sub_sections_max_students_check`: CHECK ((max_students > 0)); validated=True.
- `course_sub_sections_pkey`: PRIMARY KEY (id); validated=True.
- `course_sub_sections_section_id_fkey`: FOREIGN KEY (section_id) REFERENCES course_sections(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX course_sub_sections_pkey ON public.course_sub_sections USING btree (id)`
- `CREATE INDEX idx_sub_sections_section ON public.course_sub_sections USING btree (section_id)`

### `courses`

Purpose: Courses relation; bounded context and exact fields below.

Owning scope: `department_id, professor_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `department_id` | uuid | False | — |
| `code` | text | False | — |
| `name_en` | text | False | — |
| `name_ar` | text | False | — |
| `description` | text | True | — |
| `credit_hours` | integer | False | 3 |
| `semester` | text | True | — |
| `semester_id` | uuid | True | — |
| `professor_id` | uuid | True | — |
| `max_students` | integer | False | 50 |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `courses_credit_hours_check`: CHECK (((credit_hours >= 1) AND (credit_hours <= 12))); validated=True.
- `courses_max_students_check`: CHECK ((max_students > 0)); validated=True.
- `courses_pkey`: PRIMARY KEY (id); validated=True.
- `courses_code_key`: UNIQUE (code); validated=True.
- `courses_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `courses_professor_id_fkey`: FOREIGN KEY (professor_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `courses_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX courses_pkey ON public.courses USING btree (id)`
- `CREATE UNIQUE INDEX courses_code_key ON public.courses USING btree (code)`
- `CREATE INDEX idx_courses_department ON public.courses USING btree (department_id)`
- `CREATE INDEX idx_courses_professor ON public.courses USING btree (professor_id)`
- `CREATE INDEX idx_courses_semester ON public.courses USING btree (semester_id)`
- `CREATE INDEX idx_courses_active ON public.courses USING btree (is_active) WHERE (is_active = true)`

### `department_projects`

Purpose: Department projects relation; bounded context and exact fields below.

Owning scope: `department_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `department_id` | uuid | False | — |
| `title_en` | text | False | — |
| `title_ar` | text | False | — |
| `description_en` | text | True | — |
| `description_ar` | text | True | — |
| `status` | text | False | 'active'::text |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `department_projects_status_check`: CHECK ((status = ANY (ARRAY['active'::text, 'completed'::text, 'paused'::text, 'cancelled'::text]))); validated=True.
- `department_projects_pkey`: PRIMARY KEY (id); validated=True.
- `department_projects_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX department_projects_pkey ON public.department_projects USING btree (id)`
- `CREATE INDEX idx_department_projects_department ON public.department_projects USING btree (department_id)`

### `departments`

Purpose: Departments relation; bounded context and exact fields below.

Owning scope: `college_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `college_id` | uuid | False | — |
| `code` | text | True | — |
| `name_en` | text | False | — |
| `name_ar` | text | False | — |
| `hod_id` | uuid | True | — |
| `assistant_hod_id` | uuid | True | — |
| `description` | text | True | — |
| `description_ar` | text | True | — |
| `office_symbol` | text | True | — |
| `floor` | integer | True | — |
| `building` | text | True | — |
| `student_count` | integer | False | 0 |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `departments_student_count_check`: CHECK ((student_count >= 0)); validated=True.
- `departments_pkey`: PRIMARY KEY (id); validated=True.
- `departments_code_key`: UNIQUE (code); validated=True.
- `departments_hod_id_fkey`: FOREIGN KEY (hod_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `departments_assistant_hod_id_fkey`: FOREIGN KEY (assistant_hod_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `departments_id_college_key`: UNIQUE (id, college_id); validated=True.
- `departments_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE RESTRICT NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX departments_pkey ON public.departments USING btree (id)`
- `CREATE UNIQUE INDEX departments_code_key ON public.departments USING btree (code)`
- `CREATE INDEX idx_departments_college ON public.departments USING btree (college_id)`
- `CREATE INDEX idx_departments_active ON public.departments USING btree (is_active) WHERE (is_active = true)`
- `CREATE UNIQUE INDEX departments_id_college_key ON public.departments USING btree (id, college_id)`

### `encrypted_data`

Purpose: Encrypted data relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `cipher_text`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `context` | encryption_context | False | — |
| `target_id` | uuid | False | — |
| `target_table` | text | False | — |
| `cipher_text` | bytea | False | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `encrypted_data_pkey`: PRIMARY KEY (id); validated=True.
- `encrypted_data_target_id_target_table_context_key`: UNIQUE (target_id, target_table, context); validated=True.
- `encrypted_data_context_fkey`: FOREIGN KEY (context) REFERENCES encryption_keys(context) ON DELETE RESTRICT; validated=True.

Indexes:

- `CREATE UNIQUE INDEX encrypted_data_pkey ON public.encrypted_data USING btree (id)`
- `CREATE UNIQUE INDEX encrypted_data_target_id_target_table_context_key ON public.encrypted_data USING btree (target_id, target_table, context)`

### `encryption_keys`

Purpose: Encryption keys relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `key_hash`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `context` | encryption_context | False | — |
| `key_hash` | text | False | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `encryption_keys_pkey`: PRIMARY KEY (id); validated=True.
- `encryption_keys_context_key`: UNIQUE (context); validated=True.

Indexes:

- `CREATE UNIQUE INDEX encryption_keys_pkey ON public.encryption_keys USING btree (id)`
- `CREATE UNIQUE INDEX encryption_keys_context_key ON public.encryption_keys USING btree (context)`

### `enrollments`

Purpose: Enrollments relation; bounded context and exact fields below.

Owning scope: `course_id, student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `course_id` | uuid | False | — |
| `status` | enrollment_status | False | 'pending'::enrollment_status |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `enrolled_at` | timestamp with time zone | False | now() |
| `approved_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `enrollments_pkey`: PRIMARY KEY (id); validated=True.
- `enrollments_student_id_course_id_semester_key`: UNIQUE (student_id, course_id, semester); validated=True.
- `enrollments_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `enrollments_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `enrollments_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE RESTRICT NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX enrollments_pkey ON public.enrollments USING btree (id)`
- `CREATE UNIQUE INDEX enrollments_student_id_course_id_semester_key ON public.enrollments USING btree (student_id, course_id, semester)`
- `CREATE INDEX idx_enrollments_student ON public.enrollments USING btree (student_id)`
- `CREATE INDEX idx_enrollments_course ON public.enrollments USING btree (course_id)`
- `CREATE INDEX idx_enrollments_status ON public.enrollments USING btree (status)`
- `CREATE INDEX idx_enrollments_semester ON public.enrollments USING btree (semester_id)`
- `CREATE INDEX idx_enrollments_student_sem ON public.enrollments USING btree (student_id, semester_id)`

### `exam_attempts`

Purpose: Exam attempts relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `device_info`, `ip_address`, `score`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `started_at` | timestamp with time zone | False | now() |
| `completed_at` | timestamp with time zone | True | — |
| `score` | numeric(5,2) | True | — |
| `is_passed` | boolean | True | — |
| `ip_address` | inet | True | — |
| `device_info` | text | True | — |
| `flagged_for_cheat` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `exam_attempts_pkey`: PRIMARY KEY (id); validated=True.
- `exam_attempts_exam_id_student_id_key`: UNIQUE (exam_id, student_id); validated=True.
- `exam_attempts_exam_id_fkey`: FOREIGN KEY (exam_id) REFERENCES online_exams(id) ON DELETE CASCADE; validated=True.
- `exam_attempts_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `exam_attempts_completion_order`: CHECK (((completed_at IS NULL) OR (completed_at >= started_at))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX exam_attempts_pkey ON public.exam_attempts USING btree (id)`
- `CREATE UNIQUE INDEX exam_attempts_exam_id_student_id_key ON public.exam_attempts USING btree (exam_id, student_id)`
- `CREATE INDEX idx_exam_attempts_exam ON public.exam_attempts USING btree (exam_id)`
- `CREATE INDEX idx_exam_attempts_student ON public.exam_attempts USING btree (student_id)`

### `exam_cheat_events`

Purpose: Exam cheat events relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `attempt_id` | uuid | False | — |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `event_type` | text | False | — |
| `description` | text | True | — |
| `severity` | text | False | 'low'::text |
| `timestamp` | timestamp with time zone | False | now() |

Constraints:

- `exam_cheat_events_pkey`: PRIMARY KEY (id, "timestamp"); validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_cheat_events_pkey ON ONLY public.exam_cheat_events USING btree (id, "timestamp")`
- `CREATE INDEX idx_cheat_events_attempt ON ONLY public.exam_cheat_events USING btree (attempt_id)`

### `exam_cheat_events_future`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `attempt_id` | uuid | False | — |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `event_type` | text | False | — |
| `description` | text | True | — |
| `severity` | text | False | 'low'::text |
| `timestamp` | timestamp with time zone | False | now() |

Constraints:

- `exam_cheat_events_future_pkey`: PRIMARY KEY (id, "timestamp"); validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_cheat_events_future_pkey ON public.exam_cheat_events_future USING btree (id, "timestamp")`
- `CREATE INDEX exam_cheat_events_future_attempt_id_idx ON public.exam_cheat_events_future USING btree (attempt_id)`

### `exam_cheat_events_y2025m05`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `attempt_id` | uuid | False | — |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `event_type` | text | False | — |
| `description` | text | True | — |
| `severity` | text | False | 'low'::text |
| `timestamp` | timestamp with time zone | False | now() |

Constraints:

- `exam_cheat_events_y2025m05_pkey`: PRIMARY KEY (id, "timestamp"); validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_cheat_events_y2025m05_pkey ON public.exam_cheat_events_y2025m05 USING btree (id, "timestamp")`
- `CREATE INDEX exam_cheat_events_y2025m05_attempt_id_idx ON public.exam_cheat_events_y2025m05 USING btree (attempt_id)`

### `exam_cheat_events_y2025m06`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `attempt_id` | uuid | False | — |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `event_type` | text | False | — |
| `description` | text | True | — |
| `severity` | text | False | 'low'::text |
| `timestamp` | timestamp with time zone | False | now() |

Constraints:

- `exam_cheat_events_y2025m06_pkey`: PRIMARY KEY (id, "timestamp"); validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_cheat_events_y2025m06_pkey ON public.exam_cheat_events_y2025m06 USING btree (id, "timestamp")`
- `CREATE INDEX exam_cheat_events_y2025m06_attempt_id_idx ON public.exam_cheat_events_y2025m06 USING btree (attempt_id)`

### `exam_questions`

Purpose: Exam questions relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `correct_answer`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `exam_id` | uuid | False | — |
| `question_text` | text | False | — |
| `question_type` | question_type | False | 'mcq'::question_type |
| `marks` | integer | False | 1 |
| `media_url` | text | True | — |
| `order_index` | integer | False | 0 |
| `correct_answer` | text | True | — |
| `explanation` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `exam_questions_pkey`: PRIMARY KEY (id); validated=True.
- `exam_questions_exam_id_fkey`: FOREIGN KEY (exam_id) REFERENCES online_exams(id) ON DELETE CASCADE; validated=True.
- `exam_questions_marks_positive`: CHECK ((marks > 0)) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX exam_questions_pkey ON public.exam_questions USING btree (id)`
- `CREATE INDEX idx_exam_questions_exam ON public.exam_questions USING btree (exam_id)`

### `exam_schedules`

Purpose: Exam schedules relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `course_id` | uuid | False | — |
| `exam_type` | text | False | 'final'::text |
| `exam_date` | date | False | — |
| `start_time` | time without time zone | False | — |
| `end_time` | time without time zone | False | — |
| `room` | text | True | — |
| `building` | text | True | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `chk_exam_times`: CHECK ((start_time < end_time)); validated=True.
- `exam_schedules_pkey`: PRIMARY KEY (id); validated=True.
- `exam_schedules_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `exam_schedules_exam_type_check`: CHECK ((exam_type = ANY (ARRAY['midterm'::text, 'final'::text, 'quiz'::text, 'makeup'::text]))); validated=True.
- `exam_schedules_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_schedules_pkey ON public.exam_schedules USING btree (id)`
- `CREATE INDEX idx_exam_schedules_course_date ON public.exam_schedules USING btree (course_id, exam_date)`

### `exam_similarity_reports`

Purpose: Exam similarity reports relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `similarity_score`, `student_id`, `target_student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `exam_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `target_student_id` | uuid | False | — |
| `similarity_score` | numeric(5,2) | False | — |
| `matched_questions` | integer | False | — |
| `ai_confidence` | numeric(5,2) | False | — |
| `status` | text | False | 'pending'::text |
| `investigated_by` | uuid | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `exam_similarity_reports_similarity_score_check`: CHECK (((similarity_score >= (0)::numeric) AND (similarity_score <= (100)::numeric))); validated=True.
- `exam_similarity_reports_status_check`: CHECK ((status = ANY (ARRAY['pending'::text, 'investigating'::text, 'confirmed'::text, 'cleared'::text]))); validated=True.
- `exam_similarity_reports_pkey`: PRIMARY KEY (id); validated=True.
- `exam_similarity_reports_exam_id_fkey`: FOREIGN KEY (exam_id) REFERENCES online_exams(id) ON DELETE CASCADE; validated=True.
- `exam_similarity_reports_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `exam_similarity_reports_target_student_id_fkey`: FOREIGN KEY (target_student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `exam_similarity_reports_investigated_by_fkey`: FOREIGN KEY (investigated_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX exam_similarity_reports_pkey ON public.exam_similarity_reports USING btree (id)`
- `CREATE INDEX idx_similarity_exam ON public.exam_similarity_reports USING btree (exam_id)`

### `forum_posts`

Purpose: Forum posts relation; bounded context and exact fields below.

Owning scope: `author_id`. Sensitive fields: `content`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `forum_id` | uuid | False | — |
| `author_id` | uuid | False | — |
| `title` | text | False | — |
| `content` | text | False | — |
| `is_pinned` | boolean | False | false |
| `reply_count` | integer | False | 0 |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `forum_posts_reply_count_check`: CHECK ((reply_count >= 0)); validated=True.
- `forum_posts_pkey`: PRIMARY KEY (id); validated=True.
- `forum_posts_forum_id_fkey`: FOREIGN KEY (forum_id) REFERENCES forums(id) ON DELETE CASCADE; validated=True.
- `forum_posts_author_id_fkey`: FOREIGN KEY (author_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX forum_posts_pkey ON public.forum_posts USING btree (id)`
- `CREATE INDEX idx_forum_posts_forum ON public.forum_posts USING btree (forum_id)`
- `CREATE INDEX idx_forum_posts_author ON public.forum_posts USING btree (author_id)`

### `forums`

Purpose: Forums relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `name` | text | False | — |
| `name_ar` | text | True | — |
| `description` | text | True | — |
| `category` | forum_category | False | 'general'::forum_category |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `forums_pkey`: PRIMARY KEY (id); validated=True.

Indexes:

- `CREATE UNIQUE INDEX forums_pkey ON public.forums USING btree (id)`

### `grade_scales`

Purpose: Grade scales relation; bounded context and exact fields below.

Owning scope: `college_id`. Sensitive fields: `gpa_points`, `max_score`, `min_score`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `college_id` | uuid | True | — |
| `letter` | text | False | — |
| `min_score` | numeric(5,2) | False | — |
| `max_score` | numeric(5,2) | False | — |
| `gpa_points` | numeric(3,2) | False | — |
| `is_passing` | boolean | False | true |

Constraints:

- `grade_scales_min_score_check`: CHECK (((min_score >= (0)::numeric) AND (min_score <= (100)::numeric))); validated=True.
- `grade_scales_max_score_check`: CHECK (((max_score >= (0)::numeric) AND (max_score <= (100)::numeric))); validated=True.
- `grade_scales_gpa_points_check`: CHECK (((gpa_points >= (0)::numeric) AND (gpa_points <= 4.0))); validated=True.
- `chk_grade_range`: CHECK ((min_score < max_score)); validated=True.
- `grade_scales_pkey`: PRIMARY KEY (id); validated=True.
- `grade_scales_college_id_letter_key`: UNIQUE (college_id, letter); validated=True.
- `grade_scales_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX grade_scales_pkey ON public.grade_scales USING btree (id)`
- `CREATE UNIQUE INDEX grade_scales_college_id_letter_key ON public.grade_scales USING btree (college_id, letter)`

### `grades`

Purpose: Student course grade records.

Owning scope: `course_id, student_id`. Sensitive fields: `gpa_points`, `grade_letter`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `course_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `coursework` | numeric(5,2) | True | — |
| `midterm` | numeric(5,2) | True | — |
| `practical` | numeric(5,2) | True | — |
| `final_exam` | numeric(5,2) | True | — |
| `total` | numeric(5,2) | True | — |
| `grade_letter` | text | True | — |
| `gpa_points` | numeric(3,2) | True | — |
| `is_published` | boolean | False | false |
| `published_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `grades_coursework_check`: CHECK (((coursework >= (0)::numeric) AND (coursework <= (100)::numeric))); validated=True.
- `grades_midterm_check`: CHECK (((midterm >= (0)::numeric) AND (midterm <= (100)::numeric))); validated=True.
- `grades_practical_check`: CHECK (((practical >= (0)::numeric) AND (practical <= (100)::numeric))); validated=True.
- `grades_final_exam_check`: CHECK (((final_exam >= (0)::numeric) AND (final_exam <= (100)::numeric))); validated=True.
- `grades_pkey`: PRIMARY KEY (id); validated=True.
- `grades_student_id_course_id_semester_key`: UNIQUE (student_id, course_id, semester); validated=True.
- `grades_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `grades_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `grades_total_range`: CHECK (((total >= (0)::numeric) AND (total <= (100)::numeric))) NOT VALID; validated=False.
- `grades_gpa_points_range`: CHECK (((gpa_points >= (0)::numeric) AND (gpa_points <= (4)::numeric))) NOT VALID; validated=False.
- `grades_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE RESTRICT NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX grades_pkey ON public.grades USING btree (id)`
- `CREATE UNIQUE INDEX grades_student_id_course_id_semester_key ON public.grades USING btree (student_id, course_id, semester)`
- `CREATE INDEX idx_grades_student ON public.grades USING btree (student_id)`
- `CREATE INDEX idx_grades_course ON public.grades USING btree (course_id)`
- `CREATE INDEX idx_grades_semester ON public.grades USING btree (semester_id)`
- `CREATE INDEX idx_grades_published ON public.grades USING btree (is_published)`
- `CREATE INDEX idx_grades_student_sem_pub ON public.grades USING btree (student_id, semester_id, is_published)`

### `group_members`

Purpose: Group members relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `group_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `joined_at` | timestamp with time zone | False | now() |

Constraints:

- `group_members_pkey`: PRIMARY KEY (id); validated=True.
- `group_members_group_id_student_id_key`: UNIQUE (group_id, student_id); validated=True.
- `group_members_group_id_fkey`: FOREIGN KEY (group_id) REFERENCES student_groups(id) ON DELETE CASCADE; validated=True.
- `group_members_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX group_members_pkey ON public.group_members USING btree (id)`
- `CREATE UNIQUE INDEX group_members_group_id_student_id_key ON public.group_members USING btree (group_id, student_id)`
- `CREATE INDEX idx_group_members_student_group ON public.group_members USING btree (student_id, group_id)`

### `invoice_schedules`

Purpose: Invoice schedules relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `amount`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `parent_invoice` | uuid | False | — |
| `installment_num` | integer | False | — |
| `amount` | numeric(10,2) | False | — |
| `due_date` | date | False | — |
| `status` | payment_status | False | 'pending'::payment_status |
| `paid_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `invoice_schedules_installment_num_check`: CHECK ((installment_num > 0)); validated=True.
- `invoice_schedules_amount_check`: CHECK ((amount > (0)::numeric)); validated=True.
- `invoice_schedules_pkey`: PRIMARY KEY (id); validated=True.
- `invoice_schedules_parent_invoice_installment_num_key`: UNIQUE (parent_invoice, installment_num); validated=True.
- `invoice_schedules_parent_invoice_fkey`: FOREIGN KEY (parent_invoice) REFERENCES invoices(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX invoice_schedules_pkey ON public.invoice_schedules USING btree (id)`
- `CREATE UNIQUE INDEX invoice_schedules_parent_invoice_installment_num_key ON public.invoice_schedules USING btree (parent_invoice, installment_num)`

### `invoices`

Purpose: Student financial obligations.

Owning scope: `student_id`. Sensitive fields: `amount`, `metadata`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `description` | text | False | — |
| `description_ar` | text | True | — |
| `amount` | numeric(10,2) | False | — |
| `currency` | text | False | 'EGP'::text |
| `status` | payment_status | False | 'pending'::payment_status |
| `due_date` | date | True | — |
| `paid_at` | timestamp with time zone | True | — |
| `receipt_url` | text | True | — |
| `metadata` | jsonb | True | '{}'::jsonb |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `invoices_amount_check`: CHECK ((amount > (0)::numeric)); validated=True.
- `invoices_pkey`: PRIMARY KEY (id); validated=True.
- `invoices_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `invoices_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX invoices_pkey ON public.invoices USING btree (id)`
- `CREATE INDEX idx_invoices_student ON public.invoices USING btree (student_id)`
- `CREATE INDEX idx_invoices_status ON public.invoices USING btree (status)`
- `CREATE INDEX idx_invoices_semester ON public.invoices USING btree (semester_id)`

### `library_borrows`

Purpose: Library borrows relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: `fine_amount`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `item_id` | uuid | False | — |
| `user_id` | uuid | False | — |
| `borrowed_at` | timestamp with time zone | False | now() |
| `due_date` | date | False | — |
| `returned_at` | timestamp with time zone | True | — |
| `status` | borrow_status | False | 'borrowed'::borrow_status |
| `fine_amount` | numeric(8,2) | False | 0 |
| `issued_by` | uuid | True | — |
| `received_by` | uuid | True | — |
| `notes` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `library_borrows_pkey`: PRIMARY KEY (id); validated=True.
- `library_borrows_item_id_fkey`: FOREIGN KEY (item_id) REFERENCES library_items(id) ON DELETE CASCADE; validated=True.
- `library_borrows_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `library_borrows_issued_by_fkey`: FOREIGN KEY (issued_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `library_borrows_received_by_fkey`: FOREIGN KEY (received_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `library_borrows_fine_nonnegative`: CHECK ((fine_amount >= (0)::numeric)) NOT VALID; validated=False.
- `library_borrows_return_order`: CHECK (((returned_at IS NULL) OR (returned_at >= borrowed_at))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX library_borrows_pkey ON public.library_borrows USING btree (id)`
- `CREATE INDEX idx_lib_borrows_user ON public.library_borrows USING btree (user_id)`
- `CREATE INDEX idx_lib_borrows_item ON public.library_borrows USING btree (item_id)`
- `CREATE INDEX idx_lib_borrows_status ON public.library_borrows USING btree (status)`

### `library_items`

Purpose: Library items relation; bounded context and exact fields below.

Owning scope: `college_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `title` | text | False | — |
| `title_ar` | text | True | — |
| `author` | text | False | — |
| `author_ar` | text | True | — |
| `isbn` | text | True | — |
| `publisher` | text | True | — |
| `publish_year` | integer | True | — |
| `category` | text | False | — |
| `item_type` | library_item_type | False | 'book'::library_item_type |
| `description` | text | True | — |
| `description_ar` | text | True | — |
| `cover_url` | text | True | — |
| `file_url` | text | True | — |
| `total_copies` | integer | False | 1 |
| `available_copies` | integer | False | 1 |
| `location_shelf` | text | True | — |
| `college_id` | uuid | True | — |
| `view_count` | integer | False | 0 |
| `borrow_count` | integer | False | 0 |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `library_items_publish_year_check`: CHECK ((publish_year > 1000)); validated=True.
- `library_items_total_copies_check`: CHECK ((total_copies >= 0)); validated=True.
- `library_items_available_copies_check`: CHECK ((available_copies >= 0)); validated=True.
- `library_items_pkey`: PRIMARY KEY (id); validated=True.
- `library_items_isbn_key`: UNIQUE (isbn); validated=True.
- `library_items_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE CASCADE; validated=True.
- `library_items_copy_totals`: CHECK ((available_copies <= total_copies)) NOT VALID; validated=False.
- `library_items_counters_nonnegative`: CHECK (((view_count >= 0) AND (borrow_count >= 0))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX library_items_pkey ON public.library_items USING btree (id)`
- `CREATE UNIQUE INDEX library_items_isbn_key ON public.library_items USING btree (isbn)`
- `CREATE INDEX idx_lib_items_category ON public.library_items USING btree (category)`
- `CREATE INDEX idx_lib_items_type ON public.library_items USING btree (item_type)`

### `library_reading_history`

Purpose: Library reading history relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `item_id` | uuid | False | — |
| `user_id` | uuid | False | — |
| `last_page` | integer | False | 1 |
| `progress_pct` | numeric(5,2) | False | 0 |
| `last_read_at` | timestamp with time zone | False | now() |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `library_reading_history_pkey`: PRIMARY KEY (id); validated=True.
- `library_reading_history_item_id_user_id_key`: UNIQUE (item_id, user_id); validated=True.
- `library_reading_history_item_id_fkey`: FOREIGN KEY (item_id) REFERENCES library_items(id) ON DELETE CASCADE; validated=True.
- `library_reading_history_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `library_reading_history_progress_range`: CHECK ((((progress_pct >= (0)::numeric) AND (progress_pct <= (100)::numeric)) AND (last_page >= 1))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX library_reading_history_pkey ON public.library_reading_history USING btree (id)`
- `CREATE UNIQUE INDEX library_reading_history_item_id_user_id_key ON public.library_reading_history USING btree (item_id, user_id)`
- `CREATE INDEX idx_lib_history_user ON public.library_reading_history USING btree (user_id)`

### `library_reservations`

Purpose: Library reservations relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `item_id` | uuid | False | — |
| `user_id` | uuid | False | — |
| `reserved_at` | timestamp with time zone | False | now() |
| `expires_at` | timestamp with time zone | False | — |
| `status` | text | False | 'active'::text |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `library_reservations_status_check`: CHECK ((status = ANY (ARRAY['active'::text, 'fulfilled'::text, 'cancelled'::text, 'expired'::text]))); validated=True.
- `library_reservations_pkey`: PRIMARY KEY (id); validated=True.
- `library_reservations_item_id_fkey`: FOREIGN KEY (item_id) REFERENCES library_items(id) ON DELETE CASCADE; validated=True.
- `library_reservations_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `library_reservations_expiry_order`: CHECK ((expires_at > reserved_at)) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX library_reservations_pkey ON public.library_reservations USING btree (id)`
- `CREATE INDEX idx_lib_resv_user ON public.library_reservations USING btree (user_id)`
- `CREATE INDEX idx_library_reservations_item ON public.library_reservations USING btree (item_id)`

### `message_reactions`

Purpose: Message reactions relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `message_id` | uuid | False | — |
| `message_created_at` | timestamp with time zone | False | — |
| `user_id` | uuid | False | — |
| `emoji` | text | False | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `message_reactions_pkey`: PRIMARY KEY (id); validated=True.
- `message_reactions_message_id_user_id_emoji_key`: UNIQUE (message_id, user_id, emoji); validated=True.
- `message_reactions_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX message_reactions_pkey ON public.message_reactions USING btree (id)`
- `CREATE UNIQUE INDEX message_reactions_message_id_user_id_emoji_key ON public.message_reactions USING btree (message_id, user_id, emoji)`
- `CREATE INDEX idx_message_reactions_message ON public.message_reactions USING btree (message_id)`

### `messages`

Purpose: Conversation-scoped private messages.

Owning scope: `conversation_id, sender_id`. Sensitive fields: `content`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_pkey ON ONLY public.messages USING btree (id, created_at)`
- `CREATE INDEX idx_messages_conversation_time ON ONLY public.messages USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX idx_messages_sender ON ONLY public.messages USING btree (sender_id)`

### `messages_future`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_future_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_future_pkey ON public.messages_future USING btree (id, created_at)`
- `CREATE INDEX messages_future_conversation_id_created_at_idx ON public.messages_future USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_future_sender_id_idx ON public.messages_future USING btree (sender_id)`

### `messages_y2025m01`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m01_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m01_pkey ON public.messages_y2025m01 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m01_conversation_id_created_at_idx ON public.messages_y2025m01 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m01_sender_id_idx ON public.messages_y2025m01 USING btree (sender_id)`

### `messages_y2025m02`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m02_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m02_pkey ON public.messages_y2025m02 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m02_conversation_id_created_at_idx ON public.messages_y2025m02 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m02_sender_id_idx ON public.messages_y2025m02 USING btree (sender_id)`

### `messages_y2025m03`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m03_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m03_pkey ON public.messages_y2025m03 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m03_conversation_id_created_at_idx ON public.messages_y2025m03 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m03_sender_id_idx ON public.messages_y2025m03 USING btree (sender_id)`

### `messages_y2025m04`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m04_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m04_pkey ON public.messages_y2025m04 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m04_conversation_id_created_at_idx ON public.messages_y2025m04 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m04_sender_id_idx ON public.messages_y2025m04 USING btree (sender_id)`

### `messages_y2025m05`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m05_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m05_pkey ON public.messages_y2025m05 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m05_conversation_id_created_at_idx ON public.messages_y2025m05 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m05_sender_id_idx ON public.messages_y2025m05 USING btree (sender_id)`

### `messages_y2025m06`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m06_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m06_pkey ON public.messages_y2025m06 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m06_conversation_id_created_at_idx ON public.messages_y2025m06 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m06_sender_id_idx ON public.messages_y2025m06 USING btree (sender_id)`

### `messages_y2025m07`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m07_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m07_pkey ON public.messages_y2025m07 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m07_conversation_id_created_at_idx ON public.messages_y2025m07 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m07_sender_id_idx ON public.messages_y2025m07 USING btree (sender_id)`

### `messages_y2025m08`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m08_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m08_pkey ON public.messages_y2025m08 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m08_conversation_id_created_at_idx ON public.messages_y2025m08 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m08_sender_id_idx ON public.messages_y2025m08 USING btree (sender_id)`

### `messages_y2025m09`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m09_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m09_pkey ON public.messages_y2025m09 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m09_conversation_id_created_at_idx ON public.messages_y2025m09 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m09_sender_id_idx ON public.messages_y2025m09 USING btree (sender_id)`

### `messages_y2025m10`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m10_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m10_pkey ON public.messages_y2025m10 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m10_conversation_id_created_at_idx ON public.messages_y2025m10 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m10_sender_id_idx ON public.messages_y2025m10 USING btree (sender_id)`

### `messages_y2025m11`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m11_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m11_pkey ON public.messages_y2025m11 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m11_conversation_id_created_at_idx ON public.messages_y2025m11 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m11_sender_id_idx ON public.messages_y2025m11 USING btree (sender_id)`

### `messages_y2025m12`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2025m12_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2025m12_pkey ON public.messages_y2025m12 USING btree (id, created_at)`
- `CREATE INDEX messages_y2025m12_conversation_id_created_at_idx ON public.messages_y2025m12 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2025m12_sender_id_idx ON public.messages_y2025m12 USING btree (sender_id)`

### `messages_y2026m01`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m01_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m01_pkey ON public.messages_y2026m01 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m01_conversation_id_created_at_idx ON public.messages_y2026m01 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m01_sender_id_idx ON public.messages_y2026m01 USING btree (sender_id)`

### `messages_y2026m02`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m02_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m02_pkey ON public.messages_y2026m02 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m02_conversation_id_created_at_idx ON public.messages_y2026m02 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m02_sender_id_idx ON public.messages_y2026m02 USING btree (sender_id)`

### `messages_y2026m03`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m03_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m03_pkey ON public.messages_y2026m03 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m03_conversation_id_created_at_idx ON public.messages_y2026m03 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m03_sender_id_idx ON public.messages_y2026m03 USING btree (sender_id)`

### `messages_y2026m04`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m04_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m04_pkey ON public.messages_y2026m04 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m04_conversation_id_created_at_idx ON public.messages_y2026m04 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m04_sender_id_idx ON public.messages_y2026m04 USING btree (sender_id)`

### `messages_y2026m05`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m05_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m05_pkey ON public.messages_y2026m05 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m05_conversation_id_created_at_idx ON public.messages_y2026m05 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m05_sender_id_idx ON public.messages_y2026m05 USING btree (sender_id)`

### `messages_y2026m06`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `conversation_id` | uuid | False | — |
| `sender_id` | uuid | False | — |
| `content` | text | False | — |
| `media_url` | text | True | — |
| `status` | message_status | False | 'sent'::message_status |
| `reply_to_id` | uuid | True | — |
| `is_edited` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `messages_y2026m06_pkey`: PRIMARY KEY (id, created_at); validated=True.
- `messages_sender_id_fkey`: FOREIGN KEY (sender_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `messages_conversation_id_fkey`: FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE; validated=True.
- `messages_not_self_reply`: CHECK (((reply_to_id IS NULL) OR (reply_to_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX messages_y2026m06_pkey ON public.messages_y2026m06 USING btree (id, created_at)`
- `CREATE INDEX messages_y2026m06_conversation_id_created_at_idx ON public.messages_y2026m06 USING btree (conversation_id, created_at DESC)`
- `CREATE INDEX messages_y2026m06_sender_id_idx ON public.messages_y2026m06 USING btree (sender_id)`

### `notif_deliv_future`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `notification_id` | uuid | False | — |
| `channel` | notif_channel | False | — |
| `status` | notif_delivery_status | False | 'pending'::notif_delivery_status |
| `provider_ref` | text | True | — |
| `error_message` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `notif_deliv_future_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX notif_deliv_future_pkey ON public.notif_deliv_future USING btree (id, created_at)`

### `notif_deliv_y2025`

Physical partition; inherits its parent contract. Direct client grants remain denied.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `notification_id` | uuid | False | — |
| `channel` | notif_channel | False | — |
| `status` | notif_delivery_status | False | 'pending'::notif_delivery_status |
| `provider_ref` | text | True | — |
| `error_message` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `notif_deliv_y2025_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX notif_deliv_y2025_pkey ON public.notif_deliv_y2025 USING btree (id, created_at)`

### `notification_deliveries`

Purpose: Notification deliveries relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `notification_id` | uuid | False | — |
| `channel` | notif_channel | False | — |
| `status` | notif_delivery_status | False | 'pending'::notif_delivery_status |
| `provider_ref` | text | True | — |
| `error_message` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `notification_deliveries_pkey`: PRIMARY KEY (id, created_at); validated=True.

Indexes:

- `CREATE UNIQUE INDEX notification_deliveries_pkey ON ONLY public.notification_deliveries USING btree (id, created_at)`

### `notification_preferences`

Purpose: Notification preferences relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: `email_enabled`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `user_id` | uuid | False | — |
| `in_app_enabled` | boolean | False | true |
| `email_enabled` | boolean | False | true |
| `sms_enabled` | boolean | False | false |
| `push_enabled` | boolean | False | true |
| `channel_overrides` | jsonb | False | '{}'::jsonb |
| `quiet_start` | time without time zone | True | — |
| `quiet_end` | time without time zone | True | — |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `notification_preferences_pkey`: PRIMARY KEY (user_id); validated=True.
- `notification_preferences_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX notification_preferences_pkey ON public.notification_preferences USING btree (user_id)`

### `notifications`

Purpose: Per-user application notifications and read state.

Owning scope: `user_id`. Sensitive fields: `metadata`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | False | — |
| `title` | text | False | — |
| `title_ar` | text | True | — |
| `message` | text | False | — |
| `message_ar` | text | True | — |
| `type` | notification_type | False | 'info'::notification_type |
| `is_read` | boolean | False | false |
| `action_url` | text | True | — |
| `metadata` | jsonb | True | '{}'::jsonb |
| `read_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `notifications_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `notifications_pkey`: PRIMARY KEY (id); validated=True.

Indexes:

- `CREATE UNIQUE INDEX notifications_pkey ON public.notifications USING btree (id)`
- `CREATE INDEX idx_notifications_user ON public.notifications USING btree (user_id, is_read)`
- `CREATE INDEX idx_notifications_created_at ON public.notifications USING btree (created_at DESC)`
- `CREATE INDEX idx_notifications_user_page ON public.notifications USING btree (user_id, created_at DESC, id DESC)`

### `office_hours`

Purpose: Office hours relation; bounded context and exact fields below.

Owning scope: `professor_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `professor_id` | uuid | False | — |
| `day` | day_of_week | False | — |
| `start_time` | time without time zone | False | — |
| `end_time` | time without time zone | False | — |
| `location` | text | False | — |
| `is_walk_in` | boolean | False | false |
| `semester` | text | True | — |
| `semester_id` | uuid | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `chk_office_times`: CHECK ((start_time < end_time)); validated=True.
- `office_hours_pkey`: PRIMARY KEY (id); validated=True.
- `office_hours_professor_id_fkey`: FOREIGN KEY (professor_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `office_hours_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX office_hours_pkey ON public.office_hours USING btree (id)`
- `CREATE INDEX idx_office_hours_professor ON public.office_hours USING btree (professor_id)`

### `online_exams`

Purpose: Online exams relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: `passing_score`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `course_id` | uuid | False | — |
| `title` | text | False | — |
| `description` | text | True | — |
| `total_marks` | integer | False | 100 |
| `duration_minutes` | integer | False | 60 |
| `passing_score` | integer | False | 50 |
| `start_time` | timestamp with time zone | False | — |
| `end_time` | timestamp with time zone | False | — |
| `status` | exam_status | False | 'draft'::exam_status |
| `shuffle_questions` | boolean | False | true |
| `shuffle_options` | boolean | False | true |
| `allow_back` | boolean | False | true |
| `show_results` | boolean | False | false |
| `strict_mode` | boolean | False | true |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `created_by` | uuid | False | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `chk_exam_times`: CHECK ((end_time > start_time)); validated=True.
- `online_exams_pkey`: PRIMARY KEY (id); validated=True.
- `online_exams_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `online_exams_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `online_exams_created_by_fkey`: FOREIGN KEY (created_by) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `online_exams_marks_valid`: CHECK (((total_marks > 0) AND (duration_minutes > 0) AND ((passing_score >= 0) AND (passing_score <= total_marks)))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX online_exams_pkey ON public.online_exams USING btree (id)`
- `CREATE INDEX idx_online_exams_course ON public.online_exams USING btree (course_id)`
- `CREATE INDEX idx_online_exams_status ON public.online_exams USING btree (status)`
- `CREATE INDEX idx_online_exams_semester ON public.online_exams USING btree (semester_id)`

### `payment_transactions`

Purpose: Trusted backend only. Unique transaction_ref provides reference idempotency; no provider event ingestion or verification workflow is configured.

Owning scope: `student_id`. Sensitive fields: `amount`, `gateway_response`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `invoice_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `amount` | numeric(10,2) | False | — |
| `currency` | text | False | 'EGP'::text |
| `payment_method` | payment_method | False | — |
| `gateway` | payment_gateway_type | True | — |
| `transaction_ref` | text | True | — |
| `status` | payment_status | False | 'pending'::payment_status |
| `gateway_response` | jsonb | True | '{}'::jsonb |
| `processed_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `payment_transactions_amount_check`: CHECK ((amount > (0)::numeric)); validated=True.
- `payment_transactions_pkey`: PRIMARY KEY (id); validated=True.
- `payment_transactions_transaction_ref_key`: UNIQUE (transaction_ref); validated=True.
- `payment_transactions_invoice_id_fkey`: FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE; validated=True.
- `payment_transactions_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX payment_transactions_pkey ON public.payment_transactions USING btree (id)`
- `CREATE UNIQUE INDEX payment_transactions_transaction_ref_key ON public.payment_transactions USING btree (transaction_ref)`
- `CREATE INDEX idx_payment_tx_invoice ON public.payment_transactions USING btree (invoice_id)`
- `CREATE INDEX idx_payment_tx_student ON public.payment_transactions USING btree (student_id)`
- `CREATE INDEX idx_payment_tx_status ON public.payment_transactions USING btree (status)`

### `permissions`

Purpose: Canonical permission catalog.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `code` | text | False | — |
| `name_en` | text | False | — |
| `name_ar` | text | True | — |
| `module` | text | False | — |
| `description` | text | True | — |

Constraints:

- `permissions_pkey`: PRIMARY KEY (id); validated=True.
- `permissions_code_key`: UNIQUE (code); validated=True.

Indexes:

- `CREATE UNIQUE INDEX permissions_pkey ON public.permissions USING btree (id)`
- `CREATE UNIQUE INDEX permissions_code_key ON public.permissions USING btree (code)`

### `post_comments`

Purpose: Threaded comments on feed posts.

Owning scope: `author_id`. Sensitive fields: `content`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `post_id` | uuid | False | — |
| `author_id` | uuid | False | — |
| `content` | text | False | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |
| `parent_id` | uuid | True | — |

Constraints:

- `post_comments_pkey`: PRIMARY KEY (id); validated=True.
- `post_comments_post_id_fkey`: FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE; validated=True.
- `post_comments_author_id_fkey`: FOREIGN KEY (author_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `post_comments_post_id_id_key`: UNIQUE (post_id, id); validated=True.
- `post_comments_parent_same_post_fkey`: FOREIGN KEY (post_id, parent_id) REFERENCES post_comments(post_id, id) ON DELETE CASCADE; validated=True.
- `post_comments_not_self_reply`: CHECK (((parent_id IS NULL) OR (parent_id <> id))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX post_comments_pkey ON public.post_comments USING btree (id)`
- `CREATE INDEX idx_post_comments_post ON public.post_comments USING btree (post_id)`
- `CREATE UNIQUE INDEX post_comments_post_id_id_key ON public.post_comments USING btree (post_id, id)`
- `CREATE INDEX idx_post_comments_parent_id ON public.post_comments USING btree (parent_id)`
- `CREATE INDEX idx_post_comments_parent ON public.post_comments USING btree (post_id, parent_id)`

### `post_likes`

Purpose: Unique user reactions to feed posts.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `post_id` | uuid | False | — |
| `user_id` | uuid | False | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `post_likes_pkey`: PRIMARY KEY (post_id, user_id); validated=True.
- `post_likes_post_id_fkey`: FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE; validated=True.
- `post_likes_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX post_likes_pkey ON public.post_likes USING btree (post_id, user_id)`
- `CREATE INDEX idx_post_likes_user ON public.post_likes USING btree (user_id, post_id)`

### `posts`

Purpose: University feed posts with explicit academic visibility scope.

Owning scope: `author_id, college_id, department_id`. Sensitive fields: `content`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `author_id` | uuid | False | — |
| `college_id` | uuid | True | — |
| `content` | text | False | — |
| `media_urls` | text[] | False | '{}'::text[] |
| `link_url` | text | True | — |
| `type` | post_type | False | 'text'::post_type |
| `likes_count` | integer | False | 0 |
| `comments_count` | integer | False | 0 |
| `is_pinned` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |
| `department_id` | uuid | True | — |

Constraints:

- `posts_likes_count_check`: CHECK ((likes_count >= 0)); validated=True.
- `posts_comments_count_check`: CHECK ((comments_count >= 0)); validated=True.
- `posts_pkey`: PRIMARY KEY (id); validated=True.
- `posts_author_id_fkey`: FOREIGN KEY (author_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `posts_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE CASCADE; validated=True.
- `posts_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX posts_pkey ON public.posts USING btree (id)`
- `CREATE INDEX idx_posts_created_at ON public.posts USING btree (created_at DESC)`
- `CREATE INDEX idx_posts_author_id ON public.posts USING btree (author_id)`
- `CREATE INDEX idx_posts_college_id ON public.posts USING btree (college_id)`
- `CREATE INDEX idx_posts_type ON public.posts USING btree (type)`
- `CREATE INDEX idx_posts_department_id ON public.posts USING btree (department_id)`
- `CREATE INDEX idx_posts_scope_page ON public.posts USING btree (college_id, department_id, created_at DESC, id DESC) WHERE (deleted_at IS NULL)`

### `professor_details`

Purpose: Professor details relation; bounded context and exact fields below.

Owning scope: `department_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | — |
| `department_id` | uuid | True | — |
| `office_symbol` | text | True | — |
| `general_rating` | numeric(3,2) | False | 0 |
| `curriculum_rating` | numeric(3,2) | False | 0 |
| `total_ratings` | integer | False | 0 |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `professor_details_general_rating_check`: CHECK (((general_rating >= (0)::numeric) AND (general_rating <= (5)::numeric))); validated=True.
- `professor_details_curriculum_rating_check`: CHECK (((curriculum_rating >= (0)::numeric) AND (curriculum_rating <= (5)::numeric))); validated=True.
- `professor_details_total_ratings_check`: CHECK ((total_ratings >= 0)); validated=True.
- `professor_details_pkey`: PRIMARY KEY (id); validated=True.
- `professor_details_id_fkey`: FOREIGN KEY (id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `professor_details_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX professor_details_pkey ON public.professor_details USING btree (id)`

### `profiles`

Purpose: Authentication-linked user profile and account state.

Owning scope: `college_id, department_id, student_id`. Sensitive fields: `advisor_id`, `email`, `is_banned`, `national_id`, `nationality`, `phone`, `student_id`, `tags`, `warning_level`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | — |
| `email` | text | False | — |
| `full_name` | text | False | — |
| `full_name_ar` | text | True | — |
| `avatar_url` | text | True | — |
| `roles` | user_role[] | False | '{}'::user_role[] |
| `student_id` | text | True | — |
| `national_id` | text | True | — |
| `nationality` | text | True | — |
| `phone` | text | True | — |
| `bio` | text | True | — |
| `bio_ar` | text | True | — |
| `college_id` | uuid | True | — |
| `department_id` | uuid | True | — |
| `advisor_id` | uuid | True | — |
| `warning_level` | integer | False | 0 |
| `is_verified` | boolean | False | false |
| `tags` | text[] | False | '{}'::text[] |
| `is_banned` | boolean | False | false |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `profiles_department_id_fkey`: FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE SET NULL; validated=True.
- `profiles_warning_level_check`: CHECK ((warning_level >= 0)); validated=True.
- `profiles_pkey`: PRIMARY KEY (id); validated=True.
- `profiles_email_key`: UNIQUE (email); validated=True.
- `profiles_student_id_key`: UNIQUE (student_id); validated=True.
- `profiles_national_id_key`: UNIQUE (national_id); validated=True.
- `profiles_id_fkey`: FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE; validated=True.
- `profiles_advisor_id_fkey`: FOREIGN KEY (advisor_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `profiles_college_id_fkey`: FOREIGN KEY (college_id) REFERENCES colleges(id) ON DELETE SET NULL; validated=True.
- `profiles_department_college_fkey`: FOREIGN KEY (department_id, college_id) REFERENCES departments(id, college_id) ON DELETE SET NULL (department_id) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX profiles_pkey ON public.profiles USING btree (id)`
- `CREATE UNIQUE INDEX profiles_email_key ON public.profiles USING btree (email)`
- `CREATE UNIQUE INDEX profiles_student_id_key ON public.profiles USING btree (student_id)`
- `CREATE UNIQUE INDEX profiles_national_id_key ON public.profiles USING btree (national_id)`
- `CREATE INDEX idx_profiles_roles ON public.profiles USING gin (roles)`
- `CREATE INDEX idx_profiles_college ON public.profiles USING btree (college_id)`
- `CREATE INDEX idx_profiles_department ON public.profiles USING btree (department_id)`
- `CREATE INDEX idx_profiles_advisor ON public.profiles USING btree (advisor_id)`
- `CREATE INDEX idx_profiles_active ON public.profiles USING btree (is_active) WHERE (deleted_at IS NULL)`

### `question_options`

Purpose: Question options relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `question_id` | uuid | False | — |
| `option_text` | text | False | — |
| `is_correct` | boolean | False | false |
| `order_index` | integer | False | 0 |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `question_options_pkey`: PRIMARY KEY (id); validated=True.
- `question_options_question_id_fkey`: FOREIGN KEY (question_id) REFERENCES exam_questions(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX question_options_pkey ON public.question_options USING btree (id)`
- `CREATE INDEX idx_question_options_q ON public.question_options USING btree (question_id)`

### `registration_request_courses`

Purpose: Registration request courses relation; bounded context and exact fields below.

Owning scope: `course_id, request_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `request_id` | uuid | False | — |
| `course_id` | uuid | False | — |
| `section_name` | text | True | — |
| `sub_section_name` | text | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `registration_request_courses_pkey`: PRIMARY KEY (id); validated=True.
- `registration_request_courses_request_id_course_id_key`: UNIQUE (request_id, course_id); validated=True.
- `registration_request_courses_request_id_fkey`: FOREIGN KEY (request_id) REFERENCES registration_requests(id) ON DELETE CASCADE; validated=True.
- `registration_request_courses_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX registration_request_courses_pkey ON public.registration_request_courses USING btree (id)`
- `CREATE UNIQUE INDEX registration_request_courses_request_id_course_id_key ON public.registration_request_courses USING btree (request_id, course_id)`
- `CREATE INDEX idx_registration_request_courses_course_request ON public.registration_request_courses USING btree (course_id, request_id)`

### `registration_requests`

Purpose: Registration requests relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `advisor_id`, `advisor_notes`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `advisor_id` | uuid | True | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `status` | enrollment_status | False | 'pending'::enrollment_status |
| `advisor_notes` | text | True | — |
| `submitted_at` | timestamp with time zone | False | now() |
| `reviewed_at` | timestamp with time zone | True | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `registration_requests_pkey`: PRIMARY KEY (id); validated=True.
- `registration_requests_student_id_semester_key`: UNIQUE (student_id, semester); validated=True.
- `registration_requests_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `registration_requests_advisor_id_fkey`: FOREIGN KEY (advisor_id) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `registration_requests_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX registration_requests_pkey ON public.registration_requests USING btree (id)`
- `CREATE UNIQUE INDEX registration_requests_student_id_semester_key ON public.registration_requests USING btree (student_id, semester)`
- `CREATE INDEX idx_reg_requests_student ON public.registration_requests USING btree (student_id)`
- `CREATE INDEX idx_reg_requests_advisor ON public.registration_requests USING btree (advisor_id)`
- `CREATE INDEX idx_reg_requests_status ON public.registration_requests USING btree (status)`
- `CREATE INDEX idx_reg_requests_semester ON public.registration_requests USING btree (semester_id)`
- `CREATE INDEX idx_registration_requests_advisor_page ON public.registration_requests USING btree (advisor_id, status, submitted_at DESC, id DESC)`

### `role_definitions`

Purpose: Canonical role catalog for authorization.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `code` | text | False | — |
| `name_en` | text | False | — |
| `name_ar` | text | True | — |
| `description` | text | True | — |
| `priority` | smallint | False | 99 |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `role_definitions_pkey`: PRIMARY KEY (id); validated=True.
- `role_definitions_code_key`: UNIQUE (code); validated=True.

Indexes:

- `CREATE UNIQUE INDEX role_definitions_pkey ON public.role_definitions USING btree (id)`
- `CREATE UNIQUE INDEX role_definitions_code_key ON public.role_definitions USING btree (code)`

### `role_permissions`

Purpose: Canonical role-to-permission assignments. Parent academic access remains disabled until a trusted parent/student relationship exists.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `role_id` | uuid | False | — |
| `permission_id` | uuid | False | — |

Constraints:

- `role_permissions_permission_id_fkey`: FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE; validated=True.
- `role_permissions_pkey`: PRIMARY KEY (role_id, permission_id); validated=True.
- `role_permissions_role_id_fkey`: FOREIGN KEY (role_id) REFERENCES role_definitions(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX role_permissions_pkey ON public.role_permissions USING btree (role_id, permission_id)`
- `CREATE INDEX idx_role_perms_role ON public.role_permissions USING btree (role_id)`
- `CREATE INDEX idx_role_permissions_permission ON public.role_permissions USING btree (permission_id)`

### `schedules`

Purpose: Schedules relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `course_id` | uuid | False | — |
| `day` | day_of_week | False | — |
| `start_time` | time without time zone | False | — |
| `end_time` | time without time zone | False | — |
| `room` | text | True | — |
| `building` | text | True | — |
| `schedule_type` | text | False | 'lecture'::text |
| `section_name` | text | True | — |
| `sub_section_name` | text | True | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `chk_schedule_times`: CHECK ((start_time < end_time)); validated=True.
- `schedules_schedule_type_check`: CHECK ((schedule_type = ANY (ARRAY['lecture'::text, 'lab'::text, 'tutorial'::text, 'online'::text]))); validated=True.
- `schedules_pkey`: PRIMARY KEY (id); validated=True.
- `schedules_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `schedules_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX schedules_pkey ON public.schedules USING btree (id)`
- `CREATE INDEX idx_schedules_course ON public.schedules USING btree (course_id)`
- `CREATE INDEX idx_schedules_day ON public.schedules USING btree (day)`
- `CREATE INDEX idx_schedules_semester ON public.schedules USING btree (semester_id)`

### `scholarship_applications`

Purpose: Scholarship applications relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `scholarship_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `status` | scholarship_status | False | 'applied'::scholarship_status |
| `documents` | text[] | True | '{}'::text[] |
| `reviewed_by` | uuid | True | — |
| `review_notes` | text | True | — |
| `applied_at` | timestamp with time zone | False | now() |
| `reviewed_at` | timestamp with time zone | True | — |

Constraints:

- `scholarship_applications_pkey`: PRIMARY KEY (id); validated=True.
- `scholarship_applications_scholarship_id_student_id_semester_key`: UNIQUE (scholarship_id, student_id, semester); validated=True.
- `scholarship_applications_scholarship_id_fkey`: FOREIGN KEY (scholarship_id) REFERENCES scholarships(id) ON DELETE CASCADE; validated=True.
- `scholarship_applications_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `scholarship_applications_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `scholarship_applications_reviewed_by_fkey`: FOREIGN KEY (reviewed_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX scholarship_applications_pkey ON public.scholarship_applications USING btree (id)`
- `CREATE UNIQUE INDEX scholarship_applications_scholarship_id_student_id_semester_key ON public.scholarship_applications USING btree (scholarship_id, student_id, semester)`
- `CREATE INDEX idx_scholarship_app_student ON public.scholarship_applications USING btree (student_id)`
- `CREATE INDEX idx_scholarship_app_status ON public.scholarship_applications USING btree (status)`

### `scholarships`

Purpose: Scholarships relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: `discount_amount`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `name_en` | text | False | — |
| `name_ar` | text | False | — |
| `description_en` | text | True | — |
| `description_ar` | text | True | — |
| `discount_pct` | numeric(5,2) | True | — |
| `discount_amount` | numeric(10,2) | True | — |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `scholarships_discount_pct_check`: CHECK (((discount_pct >= (0)::numeric) AND (discount_pct <= (100)::numeric))); validated=True.
- `scholarships_discount_amount_check`: CHECK ((discount_amount >= (0)::numeric)); validated=True.
- `chk_scholarship_value`: CHECK ((((discount_pct IS NOT NULL) AND (discount_amount IS NULL)) OR ((discount_pct IS NULL) AND (discount_amount IS NOT NULL)))); validated=True.
- `scholarships_pkey`: PRIMARY KEY (id); validated=True.

Indexes:

- `CREATE UNIQUE INDEX scholarships_pkey ON public.scholarships USING btree (id)`

### `semester_gpa`

Purpose: Semester gpa relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `cumulative_gpa`, `semester_gpa`, `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `total_credits` | integer | False | 0 |
| `earned_credits` | integer | False | 0 |
| `quality_points` | numeric(8,2) | False | 0 |
| `semester_gpa` | numeric(4,2) | False | 0 |
| `cumulative_gpa` | numeric(4,2) | False | 0 |
| `cumulative_credits` | integer | False | 0 |
| `is_official` | boolean | False | false |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `semester_gpa_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `semester_gpa_pkey`: PRIMARY KEY (id); validated=True.
- `semester_gpa_student_id_semester_key`: UNIQUE (student_id, semester); validated=True.
- `semester_gpa_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `semester_gpa_credits_nonnegative`: CHECK (((total_credits >= 0) AND (earned_credits >= 0) AND (cumulative_credits >= 0) AND (quality_points >= (0)::numeric))) NOT VALID; validated=False.
- `semester_gpa_gpa_range`: CHECK ((((semester_gpa >= (0)::numeric) AND (semester_gpa <= (4)::numeric)) AND ((cumulative_gpa >= (0)::numeric) AND (cumulative_gpa <= (4)::numeric)))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX semester_gpa_pkey ON public.semester_gpa USING btree (id)`
- `CREATE UNIQUE INDEX semester_gpa_student_id_semester_key ON public.semester_gpa USING btree (student_id, semester)`
- `CREATE INDEX idx_sem_gpa_student ON public.semester_gpa USING btree (student_id)`
- `CREATE INDEX idx_sem_gpa_semester ON public.semester_gpa USING btree (semester_id)`

### `semesters`

Purpose: Semesters relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `code` | text | False | — |
| `name_en` | text | False | — |
| `name_ar` | text | False | — |
| `academic_year` | text | False | — |
| `start_date` | date | True | — |
| `end_date` | date | True | — |
| `is_current` | boolean | False | false |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `chk_semester_dates`: CHECK (((end_date IS NULL) OR (end_date > start_date))); validated=True.
- `semesters_pkey`: PRIMARY KEY (id); validated=True.
- `semesters_code_key`: UNIQUE (code); validated=True.

Indexes:

- `CREATE UNIQUE INDEX semesters_pkey ON public.semesters USING btree (id)`
- `CREATE UNIQUE INDEX semesters_code_key ON public.semesters USING btree (code)`
- `CREATE INDEX idx_semesters_current ON public.semesters USING btree (is_current) WHERE (is_current = true)`
- `CREATE INDEX idx_semesters_year ON public.semesters USING btree (academic_year)`

### `shared_files`

Purpose: Shared files relation; bounded context and exact fields below.

Owning scope: `course_id, uploader_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `uploader_id` | uuid | False | — |
| `course_id` | uuid | True | — |
| `title` | text | False | — |
| `title_ar` | text | True | — |
| `file_path` | text | False | — |
| `file_type` | file_type | False | 'other'::file_type |
| `file_size` | bigint | True | — |
| `download_count` | integer | False | 0 |
| `is_public` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `deleted_at` | timestamp with time zone | True | — |

Constraints:

- `shared_files_file_size_check`: CHECK ((file_size >= 0)); validated=True.
- `shared_files_download_count_check`: CHECK ((download_count >= 0)); validated=True.
- `shared_files_pkey`: PRIMARY KEY (id); validated=True.
- `shared_files_uploader_id_fkey`: FOREIGN KEY (uploader_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `shared_files_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX shared_files_pkey ON public.shared_files USING btree (id)`
- `CREATE INDEX idx_shared_files_course ON public.shared_files USING btree (course_id)`
- `CREATE INDEX idx_shared_files_uploader ON public.shared_files USING btree (uploader_id)`

### `student_course_registrations`

Purpose: Student course registrations relation; bounded context and exact fields below.

Owning scope: `course_id, student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `course_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `section_name` | text | True | — |
| `sub_section_name` | text | True | — |
| `registered_at` | timestamp with time zone | False | now() |

Constraints:

- `student_course_registrations_pkey`: PRIMARY KEY (id); validated=True.
- `student_course_registrations_student_id_course_id_semester_key`: UNIQUE (student_id, course_id, semester); validated=True.
- `student_course_registrations_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `student_course_registrations_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `student_course_registrations_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX student_course_registrations_pkey ON public.student_course_registrations USING btree (id)`
- `CREATE UNIQUE INDEX student_course_registrations_student_id_course_id_semester_key ON public.student_course_registrations USING btree (student_id, course_id, semester)`
- `CREATE INDEX idx_student_course_regs_course_student ON public.student_course_registrations USING btree (course_id, student_id)`

### `student_groups`

Purpose: Student groups relation; bounded context and exact fields below.

Owning scope: `course_id, professor_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `professor_id` | uuid | False | — |
| `course_id` | uuid | True | — |
| `name` | text | False | — |
| `name_ar` | text | True | — |
| `description` | text | True | — |
| `max_students` | integer | False | 50 |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `student_groups_max_students_check`: CHECK ((max_students > 0)); validated=True.
- `student_groups_pkey`: PRIMARY KEY (id); validated=True.
- `student_groups_professor_id_fkey`: FOREIGN KEY (professor_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `student_groups_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX student_groups_pkey ON public.student_groups USING btree (id)`

### `student_registrations`

Purpose: Student registrations relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `student_id` | uuid | False | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `section_name` | text | False | — |
| `sub_section_name` | text | False | — |
| `registered_at` | timestamp with time zone | False | now() |

Constraints:

- `student_registrations_pkey`: PRIMARY KEY (id); validated=True.
- `student_registrations_student_id_semester_key`: UNIQUE (student_id, semester); validated=True.
- `student_registrations_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `student_registrations_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX student_registrations_pkey ON public.student_registrations USING btree (id)`
- `CREATE UNIQUE INDEX student_registrations_student_id_semester_key ON public.student_registrations USING btree (student_id, semester)`

### `system_settings`

Purpose: System settings relation; bounded context and exact fields below.

Owning scope: `reference/system scope`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: —; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `key` | text | False | — |
| `value` | jsonb | False | — |
| `description` | text | True | — |
| `updated_by` | uuid | True | — |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `system_settings_pkey`: PRIMARY KEY (key); validated=True.
- `system_settings_updated_by_fkey`: FOREIGN KEY (updated_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX system_settings_pkey ON public.system_settings USING btree (key)`

### `teaching_assistants`

Purpose: Teaching assistants relation; bounded context and exact fields below.

Owning scope: `course_id, professor_id, profile_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `profile_id` | uuid | False | — |
| `professor_id` | uuid | False | — |
| `course_id` | uuid | True | — |
| `ta_role` | text | False | 'Lab Assistant'::text |
| `is_active` | boolean | False | true |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `teaching_assistants_pkey`: PRIMARY KEY (id); validated=True.
- `teaching_assistants_profile_id_professor_id_key`: UNIQUE (profile_id, professor_id); validated=True.
- `teaching_assistants_profile_id_fkey`: FOREIGN KEY (profile_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `teaching_assistants_professor_id_fkey`: FOREIGN KEY (professor_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `teaching_assistants_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL; validated=True.

Indexes:

- `CREATE UNIQUE INDEX teaching_assistants_pkey ON public.teaching_assistants USING btree (id)`
- `CREATE UNIQUE INDEX teaching_assistants_profile_id_professor_id_key ON public.teaching_assistants USING btree (profile_id, professor_id)`
- `CREATE INDEX idx_teaching_assistants_course_active ON public.teaching_assistants USING btree (course_id, profile_id) WHERE is_active`
- `CREATE INDEX idx_teaching_assistants_profile_active ON public.teaching_assistants USING btree (profile_id, course_id) WHERE is_active`

### `user_preferences`

Purpose: User preferences relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: `email_digest`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `user_id` | uuid | False | — |
| `locale` | text | False | 'ar'::text |
| `theme` | text | False | 'system'::text |
| `timezone` | text | False | 'Africa/Cairo'::text |
| `notifications_on` | boolean | False | true |
| `email_digest` | text | False | 'daily'::text |
| `sms_opt_in` | boolean | False | false |
| `dashboard_widgets` | jsonb | False | '{}'::jsonb |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `user_preferences_theme_check`: CHECK ((theme = ANY (ARRAY['light'::text, 'dark'::text, 'system'::text]))); validated=True.
- `user_preferences_email_digest_check`: CHECK ((email_digest = ANY (ARRAY['off'::text, 'daily'::text, 'weekly'::text]))); validated=True.
- `user_preferences_pkey`: PRIMARY KEY (user_id); validated=True.
- `user_preferences_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX user_preferences_pkey ON public.user_preferences USING btree (user_id)`

### `user_roles`

Purpose: Trusted canonical assignments; no direct client mutations. Expired, future, inactive, unknown assignments grant no authority.

Owning scope: `user_id`. Sensitive fields: row classification and authorization still apply.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: SELECT; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `user_id` | uuid | False | — |
| `role_id` | uuid | False | — |
| `granted_by` | uuid | True | — |
| `granted_at` | timestamp with time zone | False | now() |
| `expires_at` | timestamp with time zone | True | — |

Constraints:

- `user_roles_pkey`: PRIMARY KEY (user_id, role_id); validated=True.
- `user_roles_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `user_roles_role_id_fkey`: FOREIGN KEY (role_id) REFERENCES role_definitions(id) ON DELETE CASCADE; validated=True.
- `user_roles_granted_by_fkey`: FOREIGN KEY (granted_by) REFERENCES profiles(id) ON DELETE SET NULL; validated=True.
- `user_roles_expiry_order`: CHECK (((expires_at IS NULL) OR (expires_at > granted_at))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX user_roles_pkey ON public.user_roles USING btree (user_id, role_id)`
- `CREATE INDEX idx_user_roles_user ON public.user_roles USING btree (user_id)`
- `CREATE INDEX idx_user_roles_role ON public.user_roles USING btree (role_id)`

### `user_sessions`

Purpose: User sessions relation; bounded context and exact fields below.

Owning scope: `user_id`. Sensitive fields: `device_name`, `device_type`, `ip_address`, `user_agent`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `user_id` | uuid | False | — |
| `device_name` | text | True | — |
| `device_type` | session_device | False | 'unknown'::session_device |
| `ip_address` | inet | True | — |
| `location` | text | True | — |
| `user_agent` | text | True | — |
| `is_active` | boolean | False | true |
| `last_active` | timestamp with time zone | False | now() |
| `created_at` | timestamp with time zone | False | now() |

Constraints:

- `user_sessions_pkey`: PRIMARY KEY (id); validated=True.
- `user_sessions_user_id_fkey`: FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.

Indexes:

- `CREATE UNIQUE INDEX user_sessions_pkey ON public.user_sessions USING btree (id)`
- `CREATE INDEX idx_sessions_user_active ON public.user_sessions USING btree (user_id, is_active)`

### `virtual_class_attendance`

Purpose: Virtual class attendance relation; bounded context and exact fields below.

Owning scope: `student_id`. Sensitive fields: `student_id`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, SELECT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `virtual_class_id` | uuid | False | — |
| `student_id` | uuid | False | — |
| `joined_at` | timestamp with time zone | False | now() |
| `left_at` | timestamp with time zone | True | — |
| `duration_mins` | integer | True | — |

Constraints:

- `virtual_class_attendance_pkey`: PRIMARY KEY (id); validated=True.
- `virtual_class_attendance_virtual_class_id_student_id_key`: UNIQUE (virtual_class_id, student_id); validated=True.
- `virtual_class_attendance_virtual_class_id_fkey`: FOREIGN KEY (virtual_class_id) REFERENCES virtual_classes(id) ON DELETE CASCADE; validated=True.
- `virtual_class_attendance_student_id_fkey`: FOREIGN KEY (student_id) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `virtual_class_attendance_duration_nonnegative`: CHECK ((duration_mins >= 0)) NOT VALID; validated=False.
- `virtual_class_attendance_leave_order`: CHECK (((left_at IS NULL) OR (left_at >= joined_at))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX virtual_class_attendance_pkey ON public.virtual_class_attendance USING btree (id)`
- `CREATE UNIQUE INDEX virtual_class_attendance_virtual_class_id_student_id_key ON public.virtual_class_attendance USING btree (virtual_class_id, student_id)`
- `CREATE INDEX idx_vclass_att_student ON public.virtual_class_attendance USING btree (student_id)`

### `virtual_classes`

Purpose: Virtual classes relation; bounded context and exact fields below.

Owning scope: `course_id`. Sensitive fields: `host_url`, `passcode`.

RLS enabled: **True**; forced: **True**.

Table grants — anon: —; authenticated: DELETE, INSERT, UPDATE; service_role: DELETE, INSERT, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE.

| Column | Type | Nullable | Default |
| --- | --- | --- | --- |
| `id` | uuid | False | gen_random_uuid() |
| `course_id` | uuid | False | — |
| `title` | text | False | — |
| `title_ar` | text | True | — |
| `provider` | text | False | 'zoom'::text |
| `meeting_id` | text | True | — |
| `join_url` | text | True | — |
| `host_url` | text | True | — |
| `passcode` | text | True | — |
| `status` | virtual_class_status | False | 'scheduled'::virtual_class_status |
| `scheduled_at` | timestamp with time zone | False | — |
| `duration_minutes` | integer | False | 90 |
| `actual_start_at` | timestamp with time zone | True | — |
| `actual_end_at` | timestamp with time zone | True | — |
| `recording_url` | text | True | — |
| `attendance_taken` | boolean | False | false |
| `max_participants` | integer | True | — |
| `actual_attendees` | integer | True | — |
| `semester` | text | False | — |
| `semester_id` | uuid | True | — |
| `created_by` | uuid | False | — |
| `created_at` | timestamp with time zone | False | now() |
| `updated_at` | timestamp with time zone | False | now() |

Constraints:

- `virtual_classes_provider_check`: CHECK ((provider = ANY (ARRAY['zoom'::text, 'google_meet'::text, 'microsoft_teams'::text, 'jitsi'::text]))); validated=True.
- `virtual_classes_duration_minutes_check`: CHECK ((duration_minutes > 0)); validated=True.
- `virtual_classes_pkey`: PRIMARY KEY (id); validated=True.
- `virtual_classes_course_id_fkey`: FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE; validated=True.
- `virtual_classes_semester_id_fkey`: FOREIGN KEY (semester_id) REFERENCES semesters(id) ON DELETE SET NULL; validated=True.
- `virtual_classes_created_by_fkey`: FOREIGN KEY (created_by) REFERENCES profiles(id) ON DELETE CASCADE; validated=True.
- `virtual_classes_time_order`: CHECK (((actual_end_at IS NULL) OR (actual_end_at >= actual_start_at))) NOT VALID; validated=False.
- `virtual_classes_participants_nonnegative`: CHECK (((max_participants > 0) AND (actual_attendees >= 0))) NOT VALID; validated=False.

Indexes:

- `CREATE UNIQUE INDEX virtual_classes_pkey ON public.virtual_classes USING btree (id)`
- `CREATE INDEX idx_vclass_course_sched ON public.virtual_classes USING btree (course_id, scheduled_at)`
- `CREATE INDEX idx_vclass_semester ON public.virtual_classes USING btree (semester_id)`
- `CREATE INDEX idx_vclass_status ON public.virtual_classes USING btree (status)`

## Views

### `profile_directory`

Authenticated directory projection. Keep private profile data out of this owner-executed view.

```sql
 SELECT p.id,
    p.full_name,
    p.full_name_ar,
    p.avatar_url,
    p.college_id,
    p.department_id,
    p.created_at,
    COALESCE(array_agg(DISTINCT rd.code ORDER BY rd.code) FILTER (WHERE (rd.code IS NOT NULL)), ARRAY[]::text[]) AS role_codes
   FROM ((profiles p
     LEFT JOIN user_roles ur ON (((ur.user_id = p.id) AND ((ur.expires_at IS NULL) OR (ur.expires_at > now())) AND (ur.granted_at <= now()))))
     LEFT JOIN role_definitions rd ON (((rd.id = ur.role_id) AND rd.is_active AND (rd.code = ANY (ARRAY( SELECT (unnest(enum_range(NULL::user_role)))::text AS unnest))))))
  WHERE (p.is_active AND (NOT p.is_banned) AND (p.deleted_at IS NULL) AND has_permission('profiles.read'::text))
  GROUP BY p.id;
```

## Functions and RPCs

All application definers have pinned search_path and no PUBLIC/anon EXECUTE. Helpers
are callable by authenticated because policies need them, and independently bind the caller.

| Signature | Returns | Definer | Volatility | Configuration | ACL |
| --- | --- | --- | --- | --- | --- |
| `assign_student_advisor(uuid,uuid)` | void | True | v | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_access_course(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_access_storage_conversation(text)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_browse_course_catalog(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_manage_college_departments(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'service_role=X/postgres', 'authenticated=X/postgres'] |
| `can_manage_course(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_manage_course_department(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_manage_department(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_manage_registration_course(uuid,uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_request_course_enrollment(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_review_student(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_teach_course(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `can_upload_storage_course_file(text)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `course_file_path_matches(text,uuid,uuid,uuid)` | boolean | False | i | ['search_path=pg_catalog'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `enforce_client_record_identity()` | trigger | False | v | ['search_path=pg_catalog'] | ['postgres=X/postgres', 'service_role=X/postgres'] |
| `enforce_message_reply_scope()` | trigger | True | v | ['search_path=pg_catalog, public'] | ['postgres=X/postgres', 'service_role=X/postgres'] |
| `enforce_payment_integrity()` | trigger | True | v | ['search_path=pg_catalog, public'] | ['postgres=X/postgres', 'service_role=X/postgres'] |
| `fn_encrypt_field(uuid,encryption_context,text,text)` | void | True | v | ['search_path=pg_catalog, public, extensions'] | ['postgres=X/postgres', 'service_role=X/postgres'] |
| `get_advisor_directory(uuid,boolean,boolean)` | TABLE(id uuid, full_name text, email text, student_id text, avatar_url text, advisor_id uuid, department_id uuid, college_id uuid) | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `get_my_profile_private()` | TABLE(email text, phone text, bio text, bio_ar text, national_id text, nationality text, student_id text, advisor_id uuid, warning_level integer, is_verified boolean, tags text[], is_banned boolean, is_active boolean) | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `get_my_role()` | user_role | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `handle_new_user()` | trigger | True | v | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'service_role=X/postgres'] |
| `has_permission(text)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `has_satisfied_course_prerequisites(uuid,uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `is_active_university_member()` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'service_role=X/postgres', 'authenticated=X/postgres'] |
| `is_conversation_creator(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'service_role=X/postgres', 'authenticated=X/postgres'] |
| `is_conversation_member(uuid)` | boolean | True | s | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'service_role=X/postgres', 'authenticated=X/postgres'] |
| `update_my_profile(text,text,text,text)` | void | True | v | ['search_path=pg_catalog, public, auth'] | ['postgres=X/postgres', 'authenticated=X/postgres', 'service_role=X/postgres'] |
| `update_student_count()` | trigger | True | v | ['search_path=pg_catalog, public'] | ['postgres=X/postgres', 'service_role=X/postgres'] |

### Function definitions

#### `assign_student_advisor(uuid,uuid)`

```sql
CREATE OR REPLACE FUNCTION public.assign_student_advisor(p_student_id uuid, p_advisor_id uuid)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
BEGIN
  IF (SELECT auth.uid()) IS NULL
     OR NOT public.has_permission('students.assign_advisor') THEN
    RAISE EXCEPTION 'insufficient privilege' USING ERRCODE = '42501';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_student_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code IN ('student', 'regular_student', 'freshman')
      AND ur.granted_at <= now() AND (ur.expires_at IS NULL OR ur.expires_at > now())
  ) OR (p_advisor_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM public.profiles p
    JOIN public.user_roles ur ON ur.user_id = p.id
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    WHERE p.id = p_advisor_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code = 'academic_advisor'
      AND ur.granted_at <= now() AND (ur.expires_at IS NULL OR ur.expires_at > now())
  )) THEN
    RAISE EXCEPTION 'student or advisor is unavailable' USING ERRCODE = '22023';
  END IF;
  IF NOT public.has_permission('colleges.manage') AND EXISTS (
    SELECT 1
    FROM public.profiles student
    LEFT JOIN public.profiles caller ON caller.id = (SELECT auth.uid())
    WHERE student.id = p_student_id
      AND student.college_id IS DISTINCT FROM caller.college_id
  ) THEN
    RAISE EXCEPTION 'student is outside the caller college' USING ERRCODE = '42501';
  END IF;
  IF p_advisor_id IS NOT NULL AND EXISTS (
    SELECT 1
    FROM public.profiles student
    JOIN public.profiles advisor ON advisor.id = p_advisor_id
    WHERE student.id = p_student_id
      AND student.college_id IS DISTINCT FROM advisor.college_id
  ) THEN
    RAISE EXCEPTION 'advisor must belong to the student college' USING ERRCODE = '22023';
  END IF;
  UPDATE public.profiles SET advisor_id = p_advisor_id WHERE id = p_student_id;
END;
$function$

```

#### `can_access_course(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_access_course(p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.get_my_role() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND (
      public.can_teach_course(c.id)
      OR public.can_manage_course(c.id)
      OR public.can_manage_department(c.department_id)
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND e.student_id = (SELECT auth.uid())
                   AND e.status = 'approved' AND public.has_permission('courses.enroll'))
      OR EXISTS (SELECT 1 FROM public.enrollments e
                 WHERE e.course_id = c.id AND e.status = 'approved'
                   AND public.can_review_student(e.student_id))
    )
  );
$function$

```

#### `can_access_storage_conversation(text)`

```sql
CREATE OR REPLACE FUNCTION public.can_access_storage_conversation(p_conversation_id text)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
DECLARE
  v_conversation_id uuid;
BEGIN
  IF NOT public.is_active_university_member() OR p_conversation_id IS NULL OR p_conversation_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' THEN
    RETURN false;
  END IF;
  v_conversation_id := p_conversation_id::uuid;
  RETURN EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id = v_conversation_id
      AND cm.user_id = (SELECT auth.uid())
  );
END;
$function$

```

#### `can_browse_course_catalog(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_browse_course_catalog(p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.get_my_role() IS NOT NULL
    AND public.has_permission('courses.enroll')
    AND EXISTS (
      SELECT 1 FROM public.courses c
      JOIN public.departments d ON d.id = c.department_id
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE c.id = p_course_id AND c.is_active
        AND actor.is_active AND NOT actor.is_banned
        AND actor.deleted_at IS NULL AND actor.college_id = d.college_id
    );
$function$

```

#### `can_manage_college_departments(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_manage_college_departments(p_college_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT EXISTS (SELECT 1 FROM public.profiles actor
    WHERE actor.id=(SELECT auth.uid()) AND (
      (public.has_permission('departments.manage') AND actor.college_id=p_college_id)
      OR (public.has_permission('colleges.manage') AND actor.college_id IS NULL)));
$function$

```

#### `can_manage_course(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_manage_course(p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT EXISTS (SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND public.can_manage_course_department(c.department_id));
$function$

```

#### `can_manage_course_department(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_manage_course_department(p_department_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.has_permission('courses.manage')
    AND EXISTS (
      SELECT 1 FROM public.departments d
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE d.id = p_department_id
        AND (actor.department_id = d.id
          OR (public.has_permission('departments.manage')
              AND actor.college_id = d.college_id)
          OR (actor.college_id IS NULL AND public.has_permission('colleges.manage')))
    );
$function$

```

#### `can_manage_department(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_manage_department(p_department_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT COALESCE((SELECT p.is_active AND NOT p.is_banned FROM public.profiles p
                   WHERE p.id = (SELECT auth.uid())), false)
    AND public.has_permission('departments.manage')
    AND EXISTS (
      SELECT 1
      FROM public.departments d
      JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
      WHERE d.id = p_department_id
        AND (actor.department_id = d.id
          OR (public.has_permission('departments.manage')
              AND actor.college_id = d.college_id)
          OR (actor.college_id IS NULL AND public.has_permission('colleges.manage')))
    );
$function$

```

#### `can_manage_registration_course(uuid,uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_manage_registration_course(p_student_id uuid, p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.has_permission('registration.manage')
    AND public.can_review_student(p_student_id)
    AND EXISTS (
      SELECT 1 FROM public.profiles target
      JOIN public.courses c ON c.id = p_course_id
      JOIN public.departments d ON d.id = c.department_id
      WHERE target.id = p_student_id AND c.is_active
        AND target.college_id = d.college_id
    );
$function$

```

#### `can_request_course_enrollment(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_request_course_enrollment(p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.can_browse_course_catalog(p_course_id)
    AND public.has_satisfied_course_prerequisites(
      (SELECT auth.uid()), p_course_id);
$function$

```

#### `can_review_student(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_review_student(p_student_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT (SELECT auth.uid()) IS NOT NULL AND EXISTS (
    SELECT 1
    FROM public.profiles target
    JOIN public.profiles actor ON actor.id = (SELECT auth.uid())
    WHERE target.id = p_student_id
      AND target.is_active AND NOT target.is_banned AND target.deleted_at IS NULL
      AND (
        (target.advisor_id = actor.id AND public.has_permission('students.advise'))
        OR (public.has_permission('students.progress.read')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
        OR (public.has_permission('departments.manage')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id))
        OR (public.has_permission('courses.manage')
            AND (actor.department_id = target.department_id
              OR (public.has_permission('departments.manage')
                  AND actor.college_id = target.college_id)
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
        OR (public.has_permission('colleges.manage')
            AND (actor.college_id IS NULL OR actor.college_id = target.college_id))
        OR (public.has_permission('registration.manage')
            AND (actor.department_id = target.department_id
              OR actor.college_id = target.college_id
              OR (actor.college_id IS NULL AND public.has_permission('colleges.manage'))))
      )
  );
$function$

```

#### `can_teach_course(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.can_teach_course(p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.get_my_role() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.courses c
    WHERE c.id = p_course_id AND (
      c.professor_id = (SELECT auth.uid())
      OR EXISTS (SELECT 1 FROM public.teaching_assistants ta
                 WHERE ta.course_id = c.id
                   AND ta.profile_id = (SELECT auth.uid()) AND ta.is_active)
    )
  );
$function$

```

#### `can_upload_storage_course_file(text)`

```sql
CREATE OR REPLACE FUNCTION public.can_upload_storage_course_file(p_course_id text)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
DECLARE v_course_id uuid;
BEGIN
  IF (SELECT auth.uid()) IS NULL OR p_course_id !~*
     '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'
     OR NOT public.has_permission('materials.upload') THEN
    RETURN false;
  END IF;
  v_course_id := p_course_id::uuid;
  RETURN public.can_teach_course(v_course_id)
    OR public.can_manage_course(v_course_id);
END;
$function$

```

#### `course_file_path_matches(text,uuid,uuid,uuid)`

```sql
CREATE OR REPLACE FUNCTION public.course_file_path_matches(p_file_path text, p_course_id uuid, p_uploader_id uuid, p_file_id uuid)
 RETURNS boolean
 LANGUAGE sql
 IMMUTABLE
 SET search_path TO 'pg_catalog'
AS $function$
  SELECT p_file_path IS NOT NULL AND p_course_id IS NOT NULL
    AND p_uploader_id IS NOT NULL AND p_file_id IS NOT NULL
    AND p_file_path ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/[^/]+$'
    AND split_part(p_file_path, '/', 1) = p_course_id::text
    AND split_part(p_file_path, '/', 2) = p_uploader_id::text
    AND split_part(p_file_path, '/', 3) = p_file_id::text;
$function$

```

#### `enforce_client_record_identity()`

```sql
CREATE OR REPLACE FUNCTION public.enforce_client_record_identity()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog'
AS $function$
DECLARE column_name text;
BEGIN
  IF current_user IN ('authenticated','anon') THEN
    FOREACH column_name IN ARRAY TG_ARGV LOOP
      IF to_jsonb(NEW)->column_name IS DISTINCT FROM to_jsonb(OLD)->column_name THEN
        RAISE EXCEPTION 'record identity is immutable' USING ERRCODE='42501';
      END IF;
    END LOOP;
  END IF;
  RETURN NEW;
END;
$function$

```

#### `enforce_message_reply_scope()`

```sql
CREATE OR REPLACE FUNCTION public.enforce_message_reply_scope()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
BEGIN
  IF NEW.reply_to_id IS NOT NULL AND NOT EXISTS (
    SELECT 1 FROM public.messages m WHERE m.id=NEW.reply_to_id
      AND m.conversation_id=NEW.conversation_id AND m.deleted_at IS NULL) THEN
    RAISE EXCEPTION 'reply must reference a live message in the same conversation' USING ERRCODE='23503';
  END IF;
  RETURN NEW;
END;
$function$

```

#### `enforce_payment_integrity()`

```sql
CREATE OR REPLACE FUNCTION public.enforce_payment_integrity()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM public.invoices i WHERE i.id=NEW.invoice_id
    AND i.student_id=NEW.student_id AND i.currency=NEW.currency) THEN
    RAISE EXCEPTION 'payment invoice identity or currency mismatch' USING ERRCODE='23514';
  END IF;
  IF TG_OP='UPDATE' AND OLD.status='paid' AND (NEW.status NOT IN ('paid','refunded')
    OR NEW.invoice_id IS DISTINCT FROM OLD.invoice_id
    OR NEW.student_id IS DISTINCT FROM OLD.student_id
    OR NEW.amount IS DISTINCT FROM OLD.amount
    OR NEW.currency IS DISTINCT FROM OLD.currency
    OR NEW.transaction_ref IS DISTINCT FROM OLD.transaction_ref) THEN
    RAISE EXCEPTION 'settled payment cannot regress' USING ERRCODE='23514';
  END IF;
  RETURN NEW;
END;
$function$

```

#### `fn_encrypt_field(uuid,encryption_context,text,text)`

```sql
CREATE OR REPLACE FUNCTION public.fn_encrypt_field(p_target_id uuid, p_context encryption_context, p_table_name text, p_plain_text text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'extensions'
AS $function$
DECLARE
  v_key_hash TEXT;
  v_cipher_text BYTEA;
BEGIN
  -- Get encryption key for context
  SELECT key_hash INTO v_key_hash FROM public.encryption_keys WHERE context = p_context;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'Encryption key not found for context %', p_context;
  END IF;

  -- Encrypt
  v_cipher_text := pgp_sym_encrypt(p_plain_text, v_key_hash);

  -- Store
  INSERT INTO public.encrypted_data (target_id, target_table, context, cipher_text)
  VALUES (p_target_id, p_table_name, p_context, v_cipher_text)
  ON CONFLICT (target_id, target_table, context) 
  DO UPDATE SET cipher_text = v_cipher_text, updated_at = now();
END;
$function$

```

#### `get_advisor_directory(uuid,boolean,boolean)`

```sql
CREATE OR REPLACE FUNCTION public.get_advisor_directory(p_college_id uuid DEFAULT NULL::uuid, p_assigned_to_me boolean DEFAULT false, p_unassigned_only boolean DEFAULT false)
 RETURNS TABLE(id uuid, full_name text, email text, student_id text, avatar_url text, advisor_id uuid, department_id uuid, college_id uuid)
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
BEGIN
  IF (SELECT auth.uid()) IS NULL
     OR NOT public.has_permission('students.advise') THEN
    RAISE EXCEPTION 'insufficient privilege' USING ERRCODE = '42501';
  END IF;
  IF NOT public.has_permission('students.assign_advisor')
     AND NOT p_assigned_to_me THEN
    RAISE EXCEPTION 'advisor access is limited to assigned students'
      USING ERRCODE = '42501';
  END IF;
  IF public.has_permission('students.assign_advisor')
     AND NOT public.has_permission('colleges.manage')
     AND (p_college_id IS NULL OR p_college_id IS DISTINCT FROM (
       SELECT p.college_id FROM public.profiles p WHERE p.id = (SELECT auth.uid())
     )) THEN
    RAISE EXCEPTION 'directory access is limited to the caller college'
      USING ERRCODE = '42501';
  END IF;
  RETURN QUERY
  SELECT p.id, p.full_name, p.email, p.student_id, p.avatar_url,
         p.advisor_id, p.department_id, p.college_id
  FROM public.profiles p
  WHERE p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
    AND (p_college_id IS NULL OR p.college_id = p_college_id)
    AND (p_assigned_to_me IS FALSE OR p.advisor_id = (SELECT auth.uid()))
    AND (p_unassigned_only IS FALSE OR p.advisor_id IS NULL)
    AND EXISTS (
      SELECT 1 FROM public.user_roles ur
      JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
      WHERE ur.user_id = p.id
        AND rd.code IN ('student', 'regular_student', 'freshman')
        AND (ur.expires_at IS NULL OR ur.expires_at > now())
    )
  ORDER BY p.full_name;
END;
$function$

```

#### `get_my_profile_private()`

```sql
CREATE OR REPLACE FUNCTION public.get_my_profile_private()
 RETURNS TABLE(email text, phone text, bio text, bio_ar text, national_id text, nationality text, student_id text, advisor_id uuid, warning_level integer, is_verified boolean, tags text[], is_banned boolean, is_active boolean)
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT p.email, p.phone, p.bio, p.bio_ar, p.national_id, p.nationality,
         p.student_id, p.advisor_id, p.warning_level, p.is_verified, p.tags,
         p.is_banned, p.is_active
  FROM public.profiles p
  WHERE p.id = (SELECT auth.uid()) AND public.get_my_role() IS NOT NULL;
$function$

```

#### `get_my_role()`

```sql
CREATE OR REPLACE FUNCTION public.get_my_role()
 RETURNS user_role
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT rd.code::public.user_role
  FROM public.user_roles ur
  JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
  WHERE ur.user_id = (SELECT auth.uid())
    AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
    AND EXISTS (SELECT 1 FROM public.profiles p
      WHERE p.id = ur.user_id AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL)
    AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
  ORDER BY rd.priority ASC, rd.code ASC
  LIMIT 1;
$function$

```

#### `handle_new_user()`

```sql
CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
DECLARE
  guest_role_id uuid;
BEGIN
  SELECT id INTO guest_role_id
  FROM public.role_definitions
  WHERE code = 'guest' AND is_active;

  IF guest_role_id IS NULL THEN
    RAISE EXCEPTION 'active guest role is required for self signup';
  END IF;

  INSERT INTO public.profiles (
    id, email, full_name, full_name_ar, is_active, created_at, updated_at
  ) VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NULLIF(NEW.raw_user_meta_data->>'full_name', ''), split_part(NEW.email, '@', 1)),
    NEW.raw_user_meta_data->>'full_name_ar',
    TRUE,
    now(),
    now()
  );

  INSERT INTO public.user_roles (user_id, role_id)
  VALUES (NEW.id, guest_role_id);

  INSERT INTO public.user_preferences (user_id) VALUES (NEW.id);
  INSERT INTO public.notification_preferences (user_id) VALUES (NEW.id);

  RETURN NEW;
END;
$function$

```

#### `has_permission(text)`

```sql
CREATE OR REPLACE FUNCTION public.has_permission(p_permission_code text)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.role_permissions rp ON rp.role_id = rd.id
    JOIN public.permissions p ON p.id = rp.permission_id
    JOIN public.profiles pr ON pr.id = ur.user_id
    WHERE ur.user_id = (SELECT auth.uid())
      AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
      AND p.code = p_permission_code
      AND pr.is_active AND NOT pr.is_banned AND pr.deleted_at IS NULL
  );
$function$

```

#### `has_satisfied_course_prerequisites(uuid,uuid)`

```sql
CREATE OR REPLACE FUNCTION public.has_satisfied_course_prerequisites(p_student_id uuid, p_course_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT (p_student_id = (SELECT auth.uid())
      OR (public.has_permission('registration.manage')
          AND public.can_review_student(p_student_id)))
    AND NOT EXISTS (
      SELECT 1 FROM public.course_prerequisites cp
      WHERE cp.course_id = p_course_id
        AND NOT EXISTS (
          SELECT 1 FROM public.grades g
          WHERE g.student_id = p_student_id
            AND g.course_id = cp.prerequisite_course_id
            AND g.is_published AND g.total >= cp.minimum_grade
        )
  );
$function$

```

#### `is_active_university_member()`

```sql
CREATE OR REPLACE FUNCTION public.is_active_university_member()
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT EXISTS (
    SELECT 1 FROM public.user_roles ur
    JOIN public.role_definitions rd ON rd.id = ur.role_id AND rd.is_active
    JOIN public.profiles p ON p.id = ur.user_id
    WHERE ur.user_id = (SELECT auth.uid()) AND ur.granted_at <= now()
      AND (ur.expires_at IS NULL OR ur.expires_at > now())
      AND p.is_active AND NOT p.is_banned AND p.deleted_at IS NULL
      AND rd.code = ANY (ARRAY(SELECT unnest(enum_range(NULL::public.user_role))::text))
      AND rd.code NOT IN ('guest', 'parent', 'recruiter')
  );
$function$

```

#### `is_conversation_creator(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.is_conversation_creator(p_conversation_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.is_active_university_member() AND EXISTS (
    SELECT 1 FROM public.conversations c
    WHERE c.id=p_conversation_id AND c.created_by=(SELECT auth.uid()));
$function$

```

#### `is_conversation_member(uuid)`

```sql
CREATE OR REPLACE FUNCTION public.is_conversation_member(p_conversation_id uuid)
 RETURNS boolean
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
  SELECT public.is_active_university_member() AND EXISTS (
    SELECT 1 FROM public.conversation_members cm
    WHERE cm.conversation_id=p_conversation_id AND cm.user_id=(SELECT auth.uid()));
$function$

```

#### `update_my_profile(text,text,text,text)`

```sql
CREATE OR REPLACE FUNCTION public.update_my_profile(p_full_name text, p_phone text, p_bio text, p_avatar_url text DEFAULT NULL::text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public', 'auth'
AS $function$
BEGIN
  IF public.get_my_role() IS NULL THEN
    RAISE EXCEPTION 'authentication required' USING ERRCODE = '42501';
  END IF;
  UPDATE public.profiles
  SET full_name = p_full_name,
      phone = p_phone,
      bio = p_bio,
      avatar_url = COALESCE(p_avatar_url, avatar_url)
  WHERE id = (SELECT auth.uid());
END;
$function$

```

#### `update_student_count()`

```sql
CREATE OR REPLACE FUNCTION public.update_student_count()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog', 'public'
AS $function$
BEGIN
  -- Handle DELETES or Updates where college/dept changes
  IF (TG_OP = 'DELETE' OR TG_OP = 'UPDATE') THEN
    IF OLD.college_id IS NOT NULL THEN
      UPDATE public.colleges SET student_count = student_count - 1 WHERE id = OLD.college_id AND student_count > 0;
    END IF;
    IF OLD.department_id IS NOT NULL THEN
      UPDATE public.departments SET student_count = student_count - 1 WHERE id = OLD.department_id AND student_count > 0;
    END IF;
  END IF;

  -- Handle INSERTS or Updates where college/dept changes
  IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
    IF NEW.college_id IS NOT NULL THEN
      UPDATE public.colleges SET student_count = student_count + 1 WHERE id = NEW.college_id;
    END IF;
    IF NEW.department_id IS NOT NULL THEN
      UPDATE public.departments SET student_count = student_count + 1 WHERE id = NEW.department_id;
    END IF;
  END IF;
  
  RETURN NULL;
END;
$function$

```

## Triggers

| Relation | Trigger | Definition |
| --- | --- | --- |
| `action_plan_items` | `action_plan_items_updated_at` | CREATE TRIGGER action_plan_items_updated_at BEFORE UPDATE ON public.action_plan_items FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `attendance` | `attendance_immutable_identity` | CREATE TRIGGER attendance_immutable_identity BEFORE UPDATE ON public.attendance FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'course_id', 'date', 'recorded_by') |
| `auth.users` | `on_auth_user_created` | CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION handle_new_user() |
| `colleges` | `colleges_updated_at` | CREATE TRIGGER colleges_updated_at BEFORE UPDATE ON public.colleges FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `conversations` | `conversations_updated_at` | CREATE TRIGGER conversations_updated_at BEFORE UPDATE ON public.conversations FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `courses` | `courses_updated_at` | CREATE TRIGGER courses_updated_at BEFORE UPDATE ON public.courses FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `departments` | `departments_updated_at` | CREATE TRIGGER departments_updated_at BEFORE UPDATE ON public.departments FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `enrollments` | `enrollments_immutable_identity` | CREATE TRIGGER enrollments_immutable_identity BEFORE UPDATE ON public.enrollments FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'course_id', 'semester', 'semester_id') |
| `enrollments` | `enrollments_updated_at` | CREATE TRIGGER enrollments_updated_at BEFORE UPDATE ON public.enrollments FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `grades` | `grades_immutable_identity` | CREATE TRIGGER grades_immutable_identity BEFORE UPDATE ON public.grades FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'course_id', 'semester', 'semester_id') |
| `grades` | `grades_updated_at` | CREATE TRIGGER grades_updated_at BEFORE UPDATE ON public.grades FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `invoice_schedules` | `invoice_schedules_updated_at` | CREATE TRIGGER invoice_schedules_updated_at BEFORE UPDATE ON public.invoice_schedules FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `invoices` | `invoices_updated_at` | CREATE TRIGGER invoices_updated_at BEFORE UPDATE ON public.invoices FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `library_borrows` | `library_borrows_updated_at` | CREATE TRIGGER library_borrows_updated_at BEFORE UPDATE ON public.library_borrows FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `library_items` | `library_items_updated_at` | CREATE TRIGGER library_items_updated_at BEFORE UPDATE ON public.library_items FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `messages` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_future` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_future FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m01` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m01 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m02` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m02 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m03` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m03 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m04` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m04 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m05` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m05 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m06` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m06 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m07` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m07 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m08` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m08 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m09` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m09 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m10` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m10 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m11` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m11 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2025m12` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2025m12 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m01` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m01 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m02` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m02 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m03` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m03 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m04` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m04 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m05` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m05 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `messages_y2026m06` | `messages_reply_scope` | CREATE TRIGGER messages_reply_scope BEFORE INSERT OR UPDATE OF reply_to_id, conversation_id ON public.messages_y2026m06 FOR EACH ROW EXECUTE FUNCTION enforce_message_reply_scope() |
| `online_exams` | `online_exams_updated_at` | CREATE TRIGGER online_exams_updated_at BEFORE UPDATE ON public.online_exams FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `payment_transactions` | `payment_transactions_integrity` | CREATE TRIGGER payment_transactions_integrity BEFORE INSERT OR UPDATE ON public.payment_transactions FOR EACH ROW EXECUTE FUNCTION enforce_payment_integrity() |
| `post_comments` | `post_comments_updated_at` | CREATE TRIGGER post_comments_updated_at BEFORE UPDATE ON public.post_comments FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `posts` | `posts_updated_at` | CREATE TRIGGER posts_updated_at BEFORE UPDATE ON public.posts FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `profiles` | `on_profile_college_dept_change` | CREATE TRIGGER on_profile_college_dept_change AFTER INSERT OR DELETE OR UPDATE OF college_id, department_id ON public.profiles FOR EACH ROW EXECUTE FUNCTION update_student_count() |
| `profiles` | `profiles_updated_at` | CREATE TRIGGER profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `registration_requests` | `registration_requests_updated_at` | CREATE TRIGGER registration_requests_updated_at BEFORE UPDATE ON public.registration_requests FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `semester_gpa` | `semester_gpa_updated_at` | CREATE TRIGGER semester_gpa_updated_at BEFORE UPDATE ON public.semester_gpa FOR EACH ROW EXECUTE FUNCTION moddatetime('updated_at') |
| `student_course_registrations` | `student_course_registrations_immutable_identity` | CREATE TRIGGER student_course_registrations_immutable_identity BEFORE UPDATE ON public.student_course_registrations FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'course_id', 'semester', 'semester_id') |
| `student_registrations` | `student_registrations_immutable_identity` | CREATE TRIGGER student_registrations_immutable_identity BEFORE UPDATE ON public.student_registrations FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'semester', 'semester_id') |
| `virtual_class_attendance` | `virtual_class_attendance_immutable_identity` | CREATE TRIGGER virtual_class_attendance_immutable_identity BEFORE UPDATE ON public.virtual_class_attendance FOR EACH ROW EXECUTE FUNCTION enforce_client_record_identity('student_id', 'virtual_class_id') |

## Enums

| Enum | Values |
| --- | --- |
| `ai_model_type` | gpa_predictor, cheat_detector, course_recommender, dropout_risk, grade_forecast |
| `announcement_priority` | normal, important, urgent |
| `attendance_status` | present, absent, late, excused |
| `audit_action` | create, update, delete, login, logout, toggle_status, role_change, password_reset, view, export, import, approve, reject |
| `borrow_status` | reserved, borrowed, returned, overdue, lost |
| `day_of_week` | monday, tuesday, wednesday, thursday, friday, saturday, sunday |
| `encryption_context` | national_id, bank_account, medical, grade, financial |
| `enrollment_status` | pending, approved, rejected, withdrawn, cancelled |
| `exam_status` | draft, published, in_progress, completed, cancelled |
| `file_type` | pdf, docx, pptx, xlsx, image, video, other |
| `forum_category` | general, academic, social, feedback |
| `library_item_type` | book, journal, thesis, research_paper, e_resource, video |
| `message_status` | sent, delivered, read, deleted |
| `notif_channel` | in_app, email, sms, push |
| `notif_delivery_status` | pending, sent, delivered, failed, bounced |
| `notification_type` | info, warning, success, error |
| `payment_gateway_type` | paymob, stripe, cash, bank_transfer, wallet |
| `payment_method` | cash, card, bank_transfer, paymob, stripe, wallet |
| `payment_status` | pending, paid, overdue, refunded |
| `post_type` | text, image, video, link, announcement |
| `question_type` | mcq, true_false, short_answer, essay, file_upload |
| `scholarship_status` | open, applied, under_review, awarded, rejected, expired |
| `session_device` | mobile, desktop, tablet, unknown |
| `support_ticket_status` | open, in_progress, resolved, closed |
| `sync_status` | pending, synced, failed, skipped, retry |
| `user_role` | rector, dean, department_head, assistant_hod, academic_coordinator, professor, lecturer, teaching_assistant, registrar_officer, academic_advisor, librarian, freshman, regular_student, student, class_representative, alumni, dorm_supervisor, security_officer, guest, parent, recruiter |
| `virtual_class_status` | scheduled, live, ended, cancelled |

## Storage buckets

| Bucket | Public | Size bytes | MIME allowlist |
| --- | --- | ---: | --- |
| `avatars` | True | 5242880 | ['image/jpeg', 'image/png', 'image/webp'] |
| `chat_media` | False | 26214400 | ['image/jpeg', 'image/png', 'image/webp', 'audio/mpeg', 'audio/ogg', 'audio/webm', 'video/mp4', 'video/webm'] |
| `course_files` | False | 52428800 | ['application/pdf', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.presentationml.presentation', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'text/plain', 'image/jpeg', 'image/png', 'image/webp', 'video/mp4', 'video/webm'] |
| `post_media` | False | 15728640 | ['image/jpeg', 'image/png', 'image/webp', 'image/gif'] |

## Realtime publication

| Publication | Relation |
| --- | --- |
| `supabase_realtime` | `public.conversations` |
| `supabase_realtime` | `public.messages_future` |
| `supabase_realtime` | `public.messages_y2025m01` |
| `supabase_realtime` | `public.messages_y2025m02` |
| `supabase_realtime` | `public.messages_y2025m03` |
| `supabase_realtime` | `public.messages_y2025m04` |
| `supabase_realtime` | `public.messages_y2025m05` |
| `supabase_realtime` | `public.messages_y2025m06` |
| `supabase_realtime` | `public.messages_y2025m07` |
| `supabase_realtime` | `public.messages_y2025m08` |
| `supabase_realtime` | `public.messages_y2025m09` |
| `supabase_realtime` | `public.messages_y2025m10` |
| `supabase_realtime` | `public.messages_y2025m11` |
| `supabase_realtime` | `public.messages_y2025m12` |
| `supabase_realtime` | `public.messages_y2026m01` |
| `supabase_realtime` | `public.messages_y2026m02` |
| `supabase_realtime` | `public.messages_y2026m03` |
| `supabase_realtime` | `public.messages_y2026m04` |
| `supabase_realtime` | `public.messages_y2026m05` |
| `supabase_realtime` | `public.messages_y2026m06` |
| `supabase_realtime` | `public.notifications` |
| `supabase_realtime` | `public.post_comments` |
| `supabase_realtime` | `public.post_likes` |
| `supabase_realtime` | `public.posts` |
| `supabase_realtime` | `public.profiles` |
| `supabase_realtime` | `public.role_permissions` |
| `supabase_realtime` | `public.user_roles` |

## Direct client column grants

| Relation | Role | Column | Privilege |
| --- | --- | --- | --- |
| `action_plan_items` | authenticated | `course_id` | INSERT |
| `action_plan_items` | authenticated | `course_id` | SELECT |
| `action_plan_items` | authenticated | `course_id` | UPDATE |
| `action_plan_items` | authenticated | `created_at` | INSERT |
| `action_plan_items` | authenticated | `created_at` | SELECT |
| `action_plan_items` | authenticated | `created_at` | UPDATE |
| `action_plan_items` | authenticated | `grade_letter` | INSERT |
| `action_plan_items` | authenticated | `grade_letter` | SELECT |
| `action_plan_items` | authenticated | `grade_letter` | UPDATE |
| `action_plan_items` | authenticated | `id` | INSERT |
| `action_plan_items` | authenticated | `id` | SELECT |
| `action_plan_items` | authenticated | `id` | UPDATE |
| `action_plan_items` | authenticated | `notes` | INSERT |
| `action_plan_items` | authenticated | `notes` | SELECT |
| `action_plan_items` | authenticated | `notes` | UPDATE |
| `action_plan_items` | authenticated | `semester` | INSERT |
| `action_plan_items` | authenticated | `semester` | SELECT |
| `action_plan_items` | authenticated | `semester` | UPDATE |
| `action_plan_items` | authenticated | `semester_id` | INSERT |
| `action_plan_items` | authenticated | `semester_id` | SELECT |
| `action_plan_items` | authenticated | `semester_id` | UPDATE |
| `action_plan_items` | authenticated | `status` | INSERT |
| `action_plan_items` | authenticated | `status` | SELECT |
| `action_plan_items` | authenticated | `status` | UPDATE |
| `action_plan_items` | authenticated | `student_id` | INSERT |
| `action_plan_items` | authenticated | `student_id` | SELECT |
| `action_plan_items` | authenticated | `student_id` | UPDATE |
| `action_plan_items` | authenticated | `updated_at` | INSERT |
| `action_plan_items` | authenticated | `updated_at` | SELECT |
| `action_plan_items` | authenticated | `updated_at` | UPDATE |
| `action_plan_items` | authenticated | `year` | INSERT |
| `action_plan_items` | authenticated | `year` | SELECT |
| `action_plan_items` | authenticated | `year` | UPDATE |
| `announcements` | authenticated | `author_id` | INSERT |
| `announcements` | authenticated | `author_id` | SELECT |
| `announcements` | authenticated | `college_id` | INSERT |
| `announcements` | authenticated | `college_id` | SELECT |
| `announcements` | authenticated | `content` | INSERT |
| `announcements` | authenticated | `content` | SELECT |
| `announcements` | authenticated | `content` | UPDATE |
| `announcements` | authenticated | `content_ar` | INSERT |
| `announcements` | authenticated | `content_ar` | SELECT |
| `announcements` | authenticated | `content_ar` | UPDATE |
| `announcements` | authenticated | `course_id` | INSERT |
| `announcements` | authenticated | `course_id` | SELECT |
| `announcements` | authenticated | `created_at` | SELECT |
| `announcements` | authenticated | `deleted_at` | SELECT |
| `announcements` | authenticated | `deleted_at` | UPDATE |
| `announcements` | authenticated | `department_id` | INSERT |
| `announcements` | authenticated | `department_id` | SELECT |
| `announcements` | authenticated | `expires_at` | INSERT |
| `announcements` | authenticated | `expires_at` | SELECT |
| `announcements` | authenticated | `expires_at` | UPDATE |
| `announcements` | authenticated | `id` | SELECT |
| `announcements` | authenticated | `is_pinned` | SELECT |
| `announcements` | authenticated | `priority` | INSERT |
| `announcements` | authenticated | `priority` | SELECT |
| `announcements` | authenticated | `priority` | UPDATE |
| `announcements` | authenticated | `published_at` | INSERT |
| `announcements` | authenticated | `published_at` | SELECT |
| `announcements` | authenticated | `published_at` | UPDATE |
| `announcements` | authenticated | `title` | INSERT |
| `announcements` | authenticated | `title` | SELECT |
| `announcements` | authenticated | `title` | UPDATE |
| `announcements` | authenticated | `title_ar` | INSERT |
| `announcements` | authenticated | `title_ar` | SELECT |
| `announcements` | authenticated | `title_ar` | UPDATE |
| `announcements` | authenticated | `updated_at` | SELECT |
| `announcements` | authenticated | `updated_at` | UPDATE |
| `attendance` | authenticated | `course_id` | INSERT |
| `attendance` | authenticated | `course_id` | SELECT |
| `attendance` | authenticated | `course_id` | UPDATE |
| `attendance` | authenticated | `created_at` | INSERT |
| `attendance` | authenticated | `created_at` | SELECT |
| `attendance` | authenticated | `created_at` | UPDATE |
| `attendance` | authenticated | `date` | INSERT |
| `attendance` | authenticated | `date` | SELECT |
| `attendance` | authenticated | `date` | UPDATE |
| `attendance` | authenticated | `id` | INSERT |
| `attendance` | authenticated | `id` | SELECT |
| `attendance` | authenticated | `id` | UPDATE |
| `attendance` | authenticated | `notes` | INSERT |
| `attendance` | authenticated | `notes` | SELECT |
| `attendance` | authenticated | `notes` | UPDATE |
| `attendance` | authenticated | `recorded_by` | INSERT |
| `attendance` | authenticated | `recorded_by` | SELECT |
| `attendance` | authenticated | `recorded_by` | UPDATE |
| `attendance` | authenticated | `status` | INSERT |
| `attendance` | authenticated | `status` | SELECT |
| `attendance` | authenticated | `status` | UPDATE |
| `attendance` | authenticated | `student_id` | INSERT |
| `attendance` | authenticated | `student_id` | SELECT |
| `attendance` | authenticated | `student_id` | UPDATE |
| `colleges` | authenticated | `code` | INSERT |
| `colleges` | authenticated | `code` | SELECT |
| `colleges` | authenticated | `code` | UPDATE |
| `colleges` | authenticated | `created_at` | INSERT |
| `colleges` | authenticated | `created_at` | SELECT |
| `colleges` | authenticated | `created_at` | UPDATE |
| `colleges` | authenticated | `dean_id` | INSERT |
| `colleges` | authenticated | `dean_id` | SELECT |
| `colleges` | authenticated | `dean_id` | UPDATE |
| `colleges` | authenticated | `description` | INSERT |
| `colleges` | authenticated | `description` | SELECT |
| `colleges` | authenticated | `description` | UPDATE |
| `colleges` | authenticated | `description_ar` | INSERT |
| `colleges` | authenticated | `description_ar` | SELECT |
| `colleges` | authenticated | `description_ar` | UPDATE |
| `colleges` | authenticated | `established` | INSERT |
| `colleges` | authenticated | `established` | SELECT |
| `colleges` | authenticated | `established` | UPDATE |
| `colleges` | authenticated | `id` | INSERT |
| `colleges` | authenticated | `id` | SELECT |
| `colleges` | authenticated | `id` | UPDATE |
| `colleges` | authenticated | `image_url` | INSERT |
| `colleges` | authenticated | `image_url` | SELECT |
| `colleges` | authenticated | `image_url` | UPDATE |
| `colleges` | authenticated | `is_active` | INSERT |
| `colleges` | authenticated | `is_active` | SELECT |
| `colleges` | authenticated | `is_active` | UPDATE |
| `colleges` | authenticated | `name_ar` | INSERT |
| `colleges` | authenticated | `name_ar` | SELECT |
| `colleges` | authenticated | `name_ar` | UPDATE |
| `colleges` | authenticated | `name_en` | INSERT |
| `colleges` | authenticated | `name_en` | SELECT |
| `colleges` | authenticated | `name_en` | UPDATE |
| `colleges` | authenticated | `student_count` | INSERT |
| `colleges` | authenticated | `student_count` | SELECT |
| `colleges` | authenticated | `student_count` | UPDATE |
| `colleges` | authenticated | `updated_at` | INSERT |
| `colleges` | authenticated | `updated_at` | SELECT |
| `colleges` | authenticated | `updated_at` | UPDATE |
| `conversation_members` | authenticated | `conversation_id` | INSERT |
| `conversation_members` | authenticated | `conversation_id` | SELECT |
| `conversation_members` | authenticated | `is_admin` | SELECT |
| `conversation_members` | authenticated | `is_muted` | SELECT |
| `conversation_members` | authenticated | `is_muted` | UPDATE |
| `conversation_members` | authenticated | `joined_at` | SELECT |
| `conversation_members` | authenticated | `last_read_at` | SELECT |
| `conversation_members` | authenticated | `last_read_at` | UPDATE |
| `conversation_members` | authenticated | `user_id` | INSERT |
| `conversation_members` | authenticated | `user_id` | SELECT |
| `conversations` | authenticated | `created_at` | SELECT |
| `conversations` | authenticated | `created_by` | INSERT |
| `conversations` | authenticated | `created_by` | SELECT |
| `conversations` | authenticated | `id` | SELECT |
| `conversations` | authenticated | `is_group` | INSERT |
| `conversations` | authenticated | `is_group` | SELECT |
| `conversations` | authenticated | `last_message` | SELECT |
| `conversations` | authenticated | `last_message` | UPDATE |
| `conversations` | authenticated | `last_message_at` | SELECT |
| `conversations` | authenticated | `last_message_at` | UPDATE |
| `conversations` | authenticated | `title` | INSERT |
| `conversations` | authenticated | `title` | SELECT |
| `conversations` | authenticated | `title` | UPDATE |
| `conversations` | authenticated | `updated_at` | SELECT |
| `conversations` | authenticated | `updated_at` | UPDATE |
| `course_prerequisites` | authenticated | `course_id` | INSERT |
| `course_prerequisites` | authenticated | `course_id` | SELECT |
| `course_prerequisites` | authenticated | `course_id` | UPDATE |
| `course_prerequisites` | authenticated | `created_at` | INSERT |
| `course_prerequisites` | authenticated | `created_at` | SELECT |
| `course_prerequisites` | authenticated | `created_at` | UPDATE |
| `course_prerequisites` | authenticated | `minimum_grade` | INSERT |
| `course_prerequisites` | authenticated | `minimum_grade` | SELECT |
| `course_prerequisites` | authenticated | `minimum_grade` | UPDATE |
| `course_prerequisites` | authenticated | `prerequisite_course_id` | INSERT |
| `course_prerequisites` | authenticated | `prerequisite_course_id` | SELECT |
| `course_prerequisites` | authenticated | `prerequisite_course_id` | UPDATE |
| `course_sections` | authenticated | `course_id` | INSERT |
| `course_sections` | authenticated | `course_id` | SELECT |
| `course_sections` | authenticated | `course_id` | UPDATE |
| `course_sections` | authenticated | `created_at` | INSERT |
| `course_sections` | authenticated | `created_at` | SELECT |
| `course_sections` | authenticated | `created_at` | UPDATE |
| `course_sections` | authenticated | `id` | INSERT |
| `course_sections` | authenticated | `id` | SELECT |
| `course_sections` | authenticated | `id` | UPDATE |
| `course_sections` | authenticated | `max_students` | INSERT |
| `course_sections` | authenticated | `max_students` | SELECT |
| `course_sections` | authenticated | `max_students` | UPDATE |
| `course_sections` | authenticated | `name` | INSERT |
| `course_sections` | authenticated | `name` | SELECT |
| `course_sections` | authenticated | `name` | UPDATE |
| `course_sections` | authenticated | `semester` | INSERT |
| `course_sections` | authenticated | `semester` | SELECT |
| `course_sections` | authenticated | `semester` | UPDATE |
| `course_sections` | authenticated | `semester_id` | INSERT |
| `course_sections` | authenticated | `semester_id` | SELECT |
| `course_sections` | authenticated | `semester_id` | UPDATE |
| `course_sub_sections` | authenticated | `created_at` | INSERT |
| `course_sub_sections` | authenticated | `created_at` | SELECT |
| `course_sub_sections` | authenticated | `created_at` | UPDATE |
| `course_sub_sections` | authenticated | `id` | INSERT |
| `course_sub_sections` | authenticated | `id` | SELECT |
| `course_sub_sections` | authenticated | `id` | UPDATE |
| `course_sub_sections` | authenticated | `max_students` | INSERT |
| `course_sub_sections` | authenticated | `max_students` | SELECT |
| `course_sub_sections` | authenticated | `max_students` | UPDATE |
| `course_sub_sections` | authenticated | `name` | INSERT |
| `course_sub_sections` | authenticated | `name` | SELECT |
| `course_sub_sections` | authenticated | `name` | UPDATE |
| `course_sub_sections` | authenticated | `section_id` | INSERT |
| `course_sub_sections` | authenticated | `section_id` | SELECT |
| `course_sub_sections` | authenticated | `section_id` | UPDATE |
| `courses` | authenticated | `code` | INSERT |
| `courses` | authenticated | `code` | SELECT |
| `courses` | authenticated | `code` | UPDATE |
| `courses` | authenticated | `created_at` | INSERT |
| `courses` | authenticated | `created_at` | SELECT |
| `courses` | authenticated | `created_at` | UPDATE |
| `courses` | authenticated | `credit_hours` | INSERT |
| `courses` | authenticated | `credit_hours` | SELECT |
| `courses` | authenticated | `credit_hours` | UPDATE |
| `courses` | authenticated | `department_id` | INSERT |
| `courses` | authenticated | `department_id` | SELECT |
| `courses` | authenticated | `department_id` | UPDATE |
| `courses` | authenticated | `description` | INSERT |
| `courses` | authenticated | `description` | SELECT |
| `courses` | authenticated | `description` | UPDATE |
| `courses` | authenticated | `id` | INSERT |
| `courses` | authenticated | `id` | SELECT |
| `courses` | authenticated | `id` | UPDATE |
| `courses` | authenticated | `is_active` | INSERT |
| `courses` | authenticated | `is_active` | SELECT |
| `courses` | authenticated | `is_active` | UPDATE |
| `courses` | authenticated | `max_students` | INSERT |
| `courses` | authenticated | `max_students` | SELECT |
| `courses` | authenticated | `max_students` | UPDATE |
| `courses` | authenticated | `name_ar` | INSERT |
| `courses` | authenticated | `name_ar` | SELECT |
| `courses` | authenticated | `name_ar` | UPDATE |
| `courses` | authenticated | `name_en` | INSERT |
| `courses` | authenticated | `name_en` | SELECT |
| `courses` | authenticated | `name_en` | UPDATE |
| `courses` | authenticated | `professor_id` | INSERT |
| `courses` | authenticated | `professor_id` | SELECT |
| `courses` | authenticated | `professor_id` | UPDATE |
| `courses` | authenticated | `semester` | INSERT |
| `courses` | authenticated | `semester` | SELECT |
| `courses` | authenticated | `semester` | UPDATE |
| `courses` | authenticated | `semester_id` | INSERT |
| `courses` | authenticated | `semester_id` | SELECT |
| `courses` | authenticated | `semester_id` | UPDATE |
| `courses` | authenticated | `updated_at` | INSERT |
| `courses` | authenticated | `updated_at` | SELECT |
| `courses` | authenticated | `updated_at` | UPDATE |
| `department_projects` | authenticated | `created_at` | INSERT |
| `department_projects` | authenticated | `created_at` | SELECT |
| `department_projects` | authenticated | `created_at` | UPDATE |
| `department_projects` | authenticated | `department_id` | INSERT |
| `department_projects` | authenticated | `department_id` | SELECT |
| `department_projects` | authenticated | `department_id` | UPDATE |
| `department_projects` | authenticated | `description_ar` | INSERT |
| `department_projects` | authenticated | `description_ar` | SELECT |
| `department_projects` | authenticated | `description_ar` | UPDATE |
| `department_projects` | authenticated | `description_en` | INSERT |
| `department_projects` | authenticated | `description_en` | SELECT |
| `department_projects` | authenticated | `description_en` | UPDATE |
| `department_projects` | authenticated | `id` | INSERT |
| `department_projects` | authenticated | `id` | SELECT |
| `department_projects` | authenticated | `id` | UPDATE |
| `department_projects` | authenticated | `status` | INSERT |
| `department_projects` | authenticated | `status` | SELECT |
| `department_projects` | authenticated | `status` | UPDATE |
| `department_projects` | authenticated | `title_ar` | INSERT |
| `department_projects` | authenticated | `title_ar` | SELECT |
| `department_projects` | authenticated | `title_ar` | UPDATE |
| `department_projects` | authenticated | `title_en` | INSERT |
| `department_projects` | authenticated | `title_en` | SELECT |
| `department_projects` | authenticated | `title_en` | UPDATE |
| `department_projects` | authenticated | `updated_at` | INSERT |
| `department_projects` | authenticated | `updated_at` | SELECT |
| `department_projects` | authenticated | `updated_at` | UPDATE |
| `departments` | authenticated | `assistant_hod_id` | INSERT |
| `departments` | authenticated | `assistant_hod_id` | SELECT |
| `departments` | authenticated | `assistant_hod_id` | UPDATE |
| `departments` | authenticated | `building` | INSERT |
| `departments` | authenticated | `building` | SELECT |
| `departments` | authenticated | `building` | UPDATE |
| `departments` | authenticated | `code` | INSERT |
| `departments` | authenticated | `code` | SELECT |
| `departments` | authenticated | `code` | UPDATE |
| `departments` | authenticated | `college_id` | INSERT |
| `departments` | authenticated | `college_id` | SELECT |
| `departments` | authenticated | `college_id` | UPDATE |
| `departments` | authenticated | `created_at` | INSERT |
| `departments` | authenticated | `created_at` | SELECT |
| `departments` | authenticated | `created_at` | UPDATE |
| `departments` | authenticated | `description` | INSERT |
| `departments` | authenticated | `description` | SELECT |
| `departments` | authenticated | `description` | UPDATE |
| `departments` | authenticated | `description_ar` | INSERT |
| `departments` | authenticated | `description_ar` | SELECT |
| `departments` | authenticated | `description_ar` | UPDATE |
| `departments` | authenticated | `floor` | INSERT |
| `departments` | authenticated | `floor` | SELECT |
| `departments` | authenticated | `floor` | UPDATE |
| `departments` | authenticated | `hod_id` | INSERT |
| `departments` | authenticated | `hod_id` | SELECT |
| `departments` | authenticated | `hod_id` | UPDATE |
| `departments` | authenticated | `id` | INSERT |
| `departments` | authenticated | `id` | SELECT |
| `departments` | authenticated | `id` | UPDATE |
| `departments` | authenticated | `is_active` | INSERT |
| `departments` | authenticated | `is_active` | SELECT |
| `departments` | authenticated | `is_active` | UPDATE |
| `departments` | authenticated | `name_ar` | INSERT |
| `departments` | authenticated | `name_ar` | SELECT |
| `departments` | authenticated | `name_ar` | UPDATE |
| `departments` | authenticated | `name_en` | INSERT |
| `departments` | authenticated | `name_en` | SELECT |
| `departments` | authenticated | `name_en` | UPDATE |
| `departments` | authenticated | `office_symbol` | INSERT |
| `departments` | authenticated | `office_symbol` | SELECT |
| `departments` | authenticated | `office_symbol` | UPDATE |
| `departments` | authenticated | `student_count` | INSERT |
| `departments` | authenticated | `student_count` | SELECT |
| `departments` | authenticated | `student_count` | UPDATE |
| `departments` | authenticated | `updated_at` | INSERT |
| `departments` | authenticated | `updated_at` | SELECT |
| `departments` | authenticated | `updated_at` | UPDATE |
| `enrollments` | authenticated | `approved_at` | INSERT |
| `enrollments` | authenticated | `approved_at` | SELECT |
| `enrollments` | authenticated | `approved_at` | UPDATE |
| `enrollments` | authenticated | `course_id` | INSERT |
| `enrollments` | authenticated | `course_id` | SELECT |
| `enrollments` | authenticated | `course_id` | UPDATE |
| `enrollments` | authenticated | `created_at` | INSERT |
| `enrollments` | authenticated | `created_at` | SELECT |
| `enrollments` | authenticated | `created_at` | UPDATE |
| `enrollments` | authenticated | `enrolled_at` | INSERT |
| `enrollments` | authenticated | `enrolled_at` | SELECT |
| `enrollments` | authenticated | `enrolled_at` | UPDATE |
| `enrollments` | authenticated | `id` | INSERT |
| `enrollments` | authenticated | `id` | SELECT |
| `enrollments` | authenticated | `id` | UPDATE |
| `enrollments` | authenticated | `semester` | INSERT |
| `enrollments` | authenticated | `semester` | SELECT |
| `enrollments` | authenticated | `semester` | UPDATE |
| `enrollments` | authenticated | `semester_id` | INSERT |
| `enrollments` | authenticated | `semester_id` | SELECT |
| `enrollments` | authenticated | `semester_id` | UPDATE |
| `enrollments` | authenticated | `status` | INSERT |
| `enrollments` | authenticated | `status` | SELECT |
| `enrollments` | authenticated | `status` | UPDATE |
| `enrollments` | authenticated | `student_id` | INSERT |
| `enrollments` | authenticated | `student_id` | SELECT |
| `enrollments` | authenticated | `student_id` | UPDATE |
| `enrollments` | authenticated | `updated_at` | INSERT |
| `enrollments` | authenticated | `updated_at` | SELECT |
| `enrollments` | authenticated | `updated_at` | UPDATE |
| `exam_schedules` | authenticated | `building` | INSERT |
| `exam_schedules` | authenticated | `building` | SELECT |
| `exam_schedules` | authenticated | `building` | UPDATE |
| `exam_schedules` | authenticated | `course_id` | INSERT |
| `exam_schedules` | authenticated | `course_id` | SELECT |
| `exam_schedules` | authenticated | `course_id` | UPDATE |
| `exam_schedules` | authenticated | `created_at` | INSERT |
| `exam_schedules` | authenticated | `created_at` | SELECT |
| `exam_schedules` | authenticated | `created_at` | UPDATE |
| `exam_schedules` | authenticated | `end_time` | INSERT |
| `exam_schedules` | authenticated | `end_time` | SELECT |
| `exam_schedules` | authenticated | `end_time` | UPDATE |
| `exam_schedules` | authenticated | `exam_date` | INSERT |
| `exam_schedules` | authenticated | `exam_date` | SELECT |
| `exam_schedules` | authenticated | `exam_date` | UPDATE |
| `exam_schedules` | authenticated | `exam_type` | INSERT |
| `exam_schedules` | authenticated | `exam_type` | SELECT |
| `exam_schedules` | authenticated | `exam_type` | UPDATE |
| `exam_schedules` | authenticated | `id` | INSERT |
| `exam_schedules` | authenticated | `id` | SELECT |
| `exam_schedules` | authenticated | `id` | UPDATE |
| `exam_schedules` | authenticated | `notes` | INSERT |
| `exam_schedules` | authenticated | `notes` | SELECT |
| `exam_schedules` | authenticated | `notes` | UPDATE |
| `exam_schedules` | authenticated | `room` | INSERT |
| `exam_schedules` | authenticated | `room` | SELECT |
| `exam_schedules` | authenticated | `room` | UPDATE |
| `exam_schedules` | authenticated | `semester` | INSERT |
| `exam_schedules` | authenticated | `semester` | SELECT |
| `exam_schedules` | authenticated | `semester` | UPDATE |
| `exam_schedules` | authenticated | `semester_id` | INSERT |
| `exam_schedules` | authenticated | `semester_id` | SELECT |
| `exam_schedules` | authenticated | `semester_id` | UPDATE |
| `exam_schedules` | authenticated | `start_time` | INSERT |
| `exam_schedules` | authenticated | `start_time` | SELECT |
| `exam_schedules` | authenticated | `start_time` | UPDATE |
| `forum_posts` | authenticated | `author_id` | INSERT |
| `forum_posts` | authenticated | `author_id` | SELECT |
| `forum_posts` | authenticated | `content` | INSERT |
| `forum_posts` | authenticated | `content` | SELECT |
| `forum_posts` | authenticated | `content` | UPDATE |
| `forum_posts` | authenticated | `created_at` | SELECT |
| `forum_posts` | authenticated | `deleted_at` | SELECT |
| `forum_posts` | authenticated | `deleted_at` | UPDATE |
| `forum_posts` | authenticated | `forum_id` | INSERT |
| `forum_posts` | authenticated | `forum_id` | SELECT |
| `forum_posts` | authenticated | `id` | SELECT |
| `forum_posts` | authenticated | `is_pinned` | SELECT |
| `forum_posts` | authenticated | `reply_count` | SELECT |
| `forum_posts` | authenticated | `title` | INSERT |
| `forum_posts` | authenticated | `title` | SELECT |
| `forum_posts` | authenticated | `title` | UPDATE |
| `forum_posts` | authenticated | `updated_at` | SELECT |
| `forum_posts` | authenticated | `updated_at` | UPDATE |
| `grade_scales` | authenticated | `college_id` | INSERT |
| `grade_scales` | authenticated | `college_id` | SELECT |
| `grade_scales` | authenticated | `college_id` | UPDATE |
| `grade_scales` | authenticated | `gpa_points` | INSERT |
| `grade_scales` | authenticated | `gpa_points` | SELECT |
| `grade_scales` | authenticated | `gpa_points` | UPDATE |
| `grade_scales` | authenticated | `id` | INSERT |
| `grade_scales` | authenticated | `id` | SELECT |
| `grade_scales` | authenticated | `id` | UPDATE |
| `grade_scales` | authenticated | `is_passing` | INSERT |
| `grade_scales` | authenticated | `is_passing` | SELECT |
| `grade_scales` | authenticated | `is_passing` | UPDATE |
| `grade_scales` | authenticated | `letter` | INSERT |
| `grade_scales` | authenticated | `letter` | SELECT |
| `grade_scales` | authenticated | `letter` | UPDATE |
| `grade_scales` | authenticated | `max_score` | INSERT |
| `grade_scales` | authenticated | `max_score` | SELECT |
| `grade_scales` | authenticated | `max_score` | UPDATE |
| `grade_scales` | authenticated | `min_score` | INSERT |
| `grade_scales` | authenticated | `min_score` | SELECT |
| `grade_scales` | authenticated | `min_score` | UPDATE |
| `grades` | authenticated | `course_id` | INSERT |
| `grades` | authenticated | `course_id` | SELECT |
| `grades` | authenticated | `course_id` | UPDATE |
| `grades` | authenticated | `coursework` | INSERT |
| `grades` | authenticated | `coursework` | SELECT |
| `grades` | authenticated | `coursework` | UPDATE |
| `grades` | authenticated | `created_at` | INSERT |
| `grades` | authenticated | `created_at` | SELECT |
| `grades` | authenticated | `created_at` | UPDATE |
| `grades` | authenticated | `final_exam` | INSERT |
| `grades` | authenticated | `final_exam` | SELECT |
| `grades` | authenticated | `final_exam` | UPDATE |
| `grades` | authenticated | `gpa_points` | INSERT |
| `grades` | authenticated | `gpa_points` | SELECT |
| `grades` | authenticated | `gpa_points` | UPDATE |
| `grades` | authenticated | `grade_letter` | INSERT |
| `grades` | authenticated | `grade_letter` | SELECT |
| `grades` | authenticated | `grade_letter` | UPDATE |
| `grades` | authenticated | `id` | INSERT |
| `grades` | authenticated | `id` | SELECT |
| `grades` | authenticated | `id` | UPDATE |
| `grades` | authenticated | `is_published` | INSERT |
| `grades` | authenticated | `is_published` | SELECT |
| `grades` | authenticated | `is_published` | UPDATE |
| `grades` | authenticated | `midterm` | INSERT |
| `grades` | authenticated | `midterm` | SELECT |
| `grades` | authenticated | `midterm` | UPDATE |
| `grades` | authenticated | `practical` | INSERT |
| `grades` | authenticated | `practical` | SELECT |
| `grades` | authenticated | `practical` | UPDATE |
| `grades` | authenticated | `published_at` | INSERT |
| `grades` | authenticated | `published_at` | SELECT |
| `grades` | authenticated | `published_at` | UPDATE |
| `grades` | authenticated | `semester` | INSERT |
| `grades` | authenticated | `semester` | SELECT |
| `grades` | authenticated | `semester` | UPDATE |
| `grades` | authenticated | `semester_id` | INSERT |
| `grades` | authenticated | `semester_id` | SELECT |
| `grades` | authenticated | `semester_id` | UPDATE |
| `grades` | authenticated | `student_id` | INSERT |
| `grades` | authenticated | `student_id` | SELECT |
| `grades` | authenticated | `student_id` | UPDATE |
| `grades` | authenticated | `total` | INSERT |
| `grades` | authenticated | `total` | SELECT |
| `grades` | authenticated | `total` | UPDATE |
| `grades` | authenticated | `updated_at` | INSERT |
| `grades` | authenticated | `updated_at` | SELECT |
| `grades` | authenticated | `updated_at` | UPDATE |
| `group_members` | authenticated | `group_id` | INSERT |
| `group_members` | authenticated | `group_id` | SELECT |
| `group_members` | authenticated | `id` | INSERT |
| `group_members` | authenticated | `id` | SELECT |
| `group_members` | authenticated | `joined_at` | INSERT |
| `group_members` | authenticated | `joined_at` | SELECT |
| `group_members` | authenticated | `student_id` | INSERT |
| `group_members` | authenticated | `student_id` | SELECT |
| `invoices` | authenticated | `amount` | SELECT |
| `invoices` | authenticated | `created_at` | SELECT |
| `invoices` | authenticated | `currency` | SELECT |
| `invoices` | authenticated | `description` | SELECT |
| `invoices` | authenticated | `description_ar` | SELECT |
| `invoices` | authenticated | `due_date` | SELECT |
| `invoices` | authenticated | `id` | SELECT |
| `invoices` | authenticated | `metadata` | SELECT |
| `invoices` | authenticated | `paid_at` | SELECT |
| `invoices` | authenticated | `receipt_url` | SELECT |
| `invoices` | authenticated | `semester` | SELECT |
| `invoices` | authenticated | `semester_id` | SELECT |
| `invoices` | authenticated | `status` | SELECT |
| `invoices` | authenticated | `student_id` | SELECT |
| `invoices` | authenticated | `updated_at` | SELECT |
| `library_borrows` | authenticated | `borrowed_at` | INSERT |
| `library_borrows` | authenticated | `borrowed_at` | SELECT |
| `library_borrows` | authenticated | `borrowed_at` | UPDATE |
| `library_borrows` | authenticated | `created_at` | INSERT |
| `library_borrows` | authenticated | `created_at` | SELECT |
| `library_borrows` | authenticated | `created_at` | UPDATE |
| `library_borrows` | authenticated | `due_date` | INSERT |
| `library_borrows` | authenticated | `due_date` | SELECT |
| `library_borrows` | authenticated | `due_date` | UPDATE |
| `library_borrows` | authenticated | `fine_amount` | INSERT |
| `library_borrows` | authenticated | `fine_amount` | SELECT |
| `library_borrows` | authenticated | `fine_amount` | UPDATE |
| `library_borrows` | authenticated | `id` | INSERT |
| `library_borrows` | authenticated | `id` | SELECT |
| `library_borrows` | authenticated | `id` | UPDATE |
| `library_borrows` | authenticated | `issued_by` | INSERT |
| `library_borrows` | authenticated | `issued_by` | SELECT |
| `library_borrows` | authenticated | `issued_by` | UPDATE |
| `library_borrows` | authenticated | `item_id` | INSERT |
| `library_borrows` | authenticated | `item_id` | SELECT |
| `library_borrows` | authenticated | `item_id` | UPDATE |
| `library_borrows` | authenticated | `notes` | INSERT |
| `library_borrows` | authenticated | `notes` | SELECT |
| `library_borrows` | authenticated | `notes` | UPDATE |
| `library_borrows` | authenticated | `received_by` | INSERT |
| `library_borrows` | authenticated | `received_by` | SELECT |
| `library_borrows` | authenticated | `received_by` | UPDATE |
| `library_borrows` | authenticated | `returned_at` | INSERT |
| `library_borrows` | authenticated | `returned_at` | SELECT |
| `library_borrows` | authenticated | `returned_at` | UPDATE |
| `library_borrows` | authenticated | `status` | INSERT |
| `library_borrows` | authenticated | `status` | SELECT |
| `library_borrows` | authenticated | `status` | UPDATE |
| `library_borrows` | authenticated | `updated_at` | INSERT |
| `library_borrows` | authenticated | `updated_at` | SELECT |
| `library_borrows` | authenticated | `updated_at` | UPDATE |
| `library_borrows` | authenticated | `user_id` | INSERT |
| `library_borrows` | authenticated | `user_id` | SELECT |
| `library_borrows` | authenticated | `user_id` | UPDATE |
| `library_items` | authenticated | `author` | INSERT |
| `library_items` | authenticated | `author` | SELECT |
| `library_items` | authenticated | `author` | UPDATE |
| `library_items` | authenticated | `author_ar` | INSERT |
| `library_items` | authenticated | `author_ar` | SELECT |
| `library_items` | authenticated | `author_ar` | UPDATE |
| `library_items` | authenticated | `available_copies` | INSERT |
| `library_items` | authenticated | `available_copies` | SELECT |
| `library_items` | authenticated | `available_copies` | UPDATE |
| `library_items` | authenticated | `borrow_count` | INSERT |
| `library_items` | authenticated | `borrow_count` | SELECT |
| `library_items` | authenticated | `borrow_count` | UPDATE |
| `library_items` | authenticated | `category` | INSERT |
| `library_items` | authenticated | `category` | SELECT |
| `library_items` | authenticated | `category` | UPDATE |
| `library_items` | authenticated | `college_id` | INSERT |
| `library_items` | authenticated | `college_id` | SELECT |
| `library_items` | authenticated | `college_id` | UPDATE |
| `library_items` | authenticated | `cover_url` | INSERT |
| `library_items` | authenticated | `cover_url` | SELECT |
| `library_items` | authenticated | `cover_url` | UPDATE |
| `library_items` | authenticated | `created_at` | INSERT |
| `library_items` | authenticated | `created_at` | SELECT |
| `library_items` | authenticated | `created_at` | UPDATE |
| `library_items` | authenticated | `description` | INSERT |
| `library_items` | authenticated | `description` | SELECT |
| `library_items` | authenticated | `description` | UPDATE |
| `library_items` | authenticated | `description_ar` | INSERT |
| `library_items` | authenticated | `description_ar` | SELECT |
| `library_items` | authenticated | `description_ar` | UPDATE |
| `library_items` | authenticated | `file_url` | INSERT |
| `library_items` | authenticated | `file_url` | SELECT |
| `library_items` | authenticated | `file_url` | UPDATE |
| `library_items` | authenticated | `id` | INSERT |
| `library_items` | authenticated | `id` | SELECT |
| `library_items` | authenticated | `id` | UPDATE |
| `library_items` | authenticated | `isbn` | INSERT |
| `library_items` | authenticated | `isbn` | SELECT |
| `library_items` | authenticated | `isbn` | UPDATE |
| `library_items` | authenticated | `item_type` | INSERT |
| `library_items` | authenticated | `item_type` | SELECT |
| `library_items` | authenticated | `item_type` | UPDATE |
| `library_items` | authenticated | `location_shelf` | INSERT |
| `library_items` | authenticated | `location_shelf` | SELECT |
| `library_items` | authenticated | `location_shelf` | UPDATE |
| `library_items` | authenticated | `publish_year` | INSERT |
| `library_items` | authenticated | `publish_year` | SELECT |
| `library_items` | authenticated | `publish_year` | UPDATE |
| `library_items` | authenticated | `publisher` | INSERT |
| `library_items` | authenticated | `publisher` | SELECT |
| `library_items` | authenticated | `publisher` | UPDATE |
| `library_items` | authenticated | `title` | INSERT |
| `library_items` | authenticated | `title` | SELECT |
| `library_items` | authenticated | `title` | UPDATE |
| `library_items` | authenticated | `title_ar` | INSERT |
| `library_items` | authenticated | `title_ar` | SELECT |
| `library_items` | authenticated | `title_ar` | UPDATE |
| `library_items` | authenticated | `total_copies` | INSERT |
| `library_items` | authenticated | `total_copies` | SELECT |
| `library_items` | authenticated | `total_copies` | UPDATE |
| `library_items` | authenticated | `updated_at` | INSERT |
| `library_items` | authenticated | `updated_at` | SELECT |
| `library_items` | authenticated | `updated_at` | UPDATE |
| `library_items` | authenticated | `view_count` | INSERT |
| `library_items` | authenticated | `view_count` | SELECT |
| `library_items` | authenticated | `view_count` | UPDATE |
| `library_reading_history` | authenticated | `created_at` | SELECT |
| `library_reading_history` | authenticated | `id` | SELECT |
| `library_reading_history` | authenticated | `item_id` | SELECT |
| `library_reading_history` | authenticated | `last_page` | SELECT |
| `library_reading_history` | authenticated | `last_read_at` | SELECT |
| `library_reading_history` | authenticated | `progress_pct` | SELECT |
| `library_reading_history` | authenticated | `user_id` | SELECT |
| `library_reservations` | authenticated | `created_at` | SELECT |
| `library_reservations` | authenticated | `expires_at` | INSERT |
| `library_reservations` | authenticated | `expires_at` | SELECT |
| `library_reservations` | authenticated | `id` | SELECT |
| `library_reservations` | authenticated | `item_id` | INSERT |
| `library_reservations` | authenticated | `item_id` | SELECT |
| `library_reservations` | authenticated | `reserved_at` | SELECT |
| `library_reservations` | authenticated | `status` | SELECT |
| `library_reservations` | authenticated | `user_id` | INSERT |
| `library_reservations` | authenticated | `user_id` | SELECT |
| `message_reactions` | authenticated | `created_at` | SELECT |
| `message_reactions` | authenticated | `emoji` | INSERT |
| `message_reactions` | authenticated | `emoji` | SELECT |
| `message_reactions` | authenticated | `id` | SELECT |
| `message_reactions` | authenticated | `message_created_at` | INSERT |
| `message_reactions` | authenticated | `message_created_at` | SELECT |
| `message_reactions` | authenticated | `message_id` | INSERT |
| `message_reactions` | authenticated | `message_id` | SELECT |
| `message_reactions` | authenticated | `user_id` | INSERT |
| `message_reactions` | authenticated | `user_id` | SELECT |
| `messages` | authenticated | `content` | INSERT |
| `messages` | authenticated | `content` | SELECT |
| `messages` | authenticated | `content` | UPDATE |
| `messages` | authenticated | `conversation_id` | INSERT |
| `messages` | authenticated | `conversation_id` | SELECT |
| `messages` | authenticated | `created_at` | SELECT |
| `messages` | authenticated | `deleted_at` | SELECT |
| `messages` | authenticated | `deleted_at` | UPDATE |
| `messages` | authenticated | `id` | SELECT |
| `messages` | authenticated | `is_edited` | SELECT |
| `messages` | authenticated | `is_edited` | UPDATE |
| `messages` | authenticated | `media_url` | INSERT |
| `messages` | authenticated | `media_url` | SELECT |
| `messages` | authenticated | `media_url` | UPDATE |
| `messages` | authenticated | `reply_to_id` | INSERT |
| `messages` | authenticated | `reply_to_id` | SELECT |
| `messages` | authenticated | `sender_id` | INSERT |
| `messages` | authenticated | `sender_id` | SELECT |
| `messages` | authenticated | `status` | SELECT |
| `notification_preferences` | authenticated | `channel_overrides` | INSERT |
| `notification_preferences` | authenticated | `channel_overrides` | SELECT |
| `notification_preferences` | authenticated | `channel_overrides` | UPDATE |
| `notification_preferences` | authenticated | `email_enabled` | INSERT |
| `notification_preferences` | authenticated | `email_enabled` | SELECT |
| `notification_preferences` | authenticated | `email_enabled` | UPDATE |
| `notification_preferences` | authenticated | `in_app_enabled` | INSERT |
| `notification_preferences` | authenticated | `in_app_enabled` | SELECT |
| `notification_preferences` | authenticated | `in_app_enabled` | UPDATE |
| `notification_preferences` | authenticated | `push_enabled` | INSERT |
| `notification_preferences` | authenticated | `push_enabled` | SELECT |
| `notification_preferences` | authenticated | `push_enabled` | UPDATE |
| `notification_preferences` | authenticated | `quiet_end` | INSERT |
| `notification_preferences` | authenticated | `quiet_end` | SELECT |
| `notification_preferences` | authenticated | `quiet_end` | UPDATE |
| `notification_preferences` | authenticated | `quiet_start` | INSERT |
| `notification_preferences` | authenticated | `quiet_start` | SELECT |
| `notification_preferences` | authenticated | `quiet_start` | UPDATE |
| `notification_preferences` | authenticated | `sms_enabled` | INSERT |
| `notification_preferences` | authenticated | `sms_enabled` | SELECT |
| `notification_preferences` | authenticated | `sms_enabled` | UPDATE |
| `notification_preferences` | authenticated | `updated_at` | INSERT |
| `notification_preferences` | authenticated | `updated_at` | SELECT |
| `notification_preferences` | authenticated | `updated_at` | UPDATE |
| `notification_preferences` | authenticated | `user_id` | INSERT |
| `notification_preferences` | authenticated | `user_id` | SELECT |
| `notification_preferences` | authenticated | `user_id` | UPDATE |
| `notifications` | authenticated | `action_url` | SELECT |
| `notifications` | authenticated | `created_at` | SELECT |
| `notifications` | authenticated | `id` | SELECT |
| `notifications` | authenticated | `is_read` | SELECT |
| `notifications` | authenticated | `is_read` | UPDATE |
| `notifications` | authenticated | `message` | SELECT |
| `notifications` | authenticated | `message_ar` | SELECT |
| `notifications` | authenticated | `metadata` | SELECT |
| `notifications` | authenticated | `read_at` | SELECT |
| `notifications` | authenticated | `read_at` | UPDATE |
| `notifications` | authenticated | `title` | SELECT |
| `notifications` | authenticated | `title_ar` | SELECT |
| `notifications` | authenticated | `type` | SELECT |
| `notifications` | authenticated | `user_id` | SELECT |
| `office_hours` | authenticated | `created_at` | SELECT |
| `office_hours` | authenticated | `day` | SELECT |
| `office_hours` | authenticated | `end_time` | SELECT |
| `office_hours` | authenticated | `id` | SELECT |
| `office_hours` | authenticated | `is_walk_in` | SELECT |
| `office_hours` | authenticated | `location` | SELECT |
| `office_hours` | authenticated | `professor_id` | SELECT |
| `office_hours` | authenticated | `semester` | SELECT |
| `office_hours` | authenticated | `semester_id` | SELECT |
| `office_hours` | authenticated | `start_time` | SELECT |
| `permissions` | authenticated | `code` | SELECT |
| `permissions` | authenticated | `description` | SELECT |
| `permissions` | authenticated | `id` | SELECT |
| `permissions` | authenticated | `module` | SELECT |
| `permissions` | authenticated | `name_ar` | SELECT |
| `permissions` | authenticated | `name_en` | SELECT |
| `post_comments` | authenticated | `author_id` | INSERT |
| `post_comments` | authenticated | `author_id` | SELECT |
| `post_comments` | authenticated | `content` | INSERT |
| `post_comments` | authenticated | `content` | SELECT |
| `post_comments` | authenticated | `content` | UPDATE |
| `post_comments` | authenticated | `created_at` | SELECT |
| `post_comments` | authenticated | `deleted_at` | SELECT |
| `post_comments` | authenticated | `deleted_at` | UPDATE |
| `post_comments` | authenticated | `id` | SELECT |
| `post_comments` | authenticated | `parent_id` | INSERT |
| `post_comments` | authenticated | `parent_id` | SELECT |
| `post_comments` | authenticated | `post_id` | INSERT |
| `post_comments` | authenticated | `post_id` | SELECT |
| `post_comments` | authenticated | `updated_at` | SELECT |
| `post_comments` | authenticated | `updated_at` | UPDATE |
| `post_likes` | authenticated | `created_at` | INSERT |
| `post_likes` | authenticated | `created_at` | SELECT |
| `post_likes` | authenticated | `post_id` | INSERT |
| `post_likes` | authenticated | `post_id` | SELECT |
| `post_likes` | authenticated | `user_id` | INSERT |
| `post_likes` | authenticated | `user_id` | SELECT |
| `posts` | authenticated | `author_id` | INSERT |
| `posts` | authenticated | `author_id` | SELECT |
| `posts` | authenticated | `college_id` | INSERT |
| `posts` | authenticated | `college_id` | SELECT |
| `posts` | authenticated | `comments_count` | SELECT |
| `posts` | authenticated | `content` | INSERT |
| `posts` | authenticated | `content` | SELECT |
| `posts` | authenticated | `content` | UPDATE |
| `posts` | authenticated | `created_at` | SELECT |
| `posts` | authenticated | `deleted_at` | SELECT |
| `posts` | authenticated | `deleted_at` | UPDATE |
| `posts` | authenticated | `department_id` | INSERT |
| `posts` | authenticated | `department_id` | SELECT |
| `posts` | authenticated | `id` | SELECT |
| `posts` | authenticated | `is_pinned` | SELECT |
| `posts` | authenticated | `likes_count` | SELECT |
| `posts` | authenticated | `link_url` | INSERT |
| `posts` | authenticated | `link_url` | SELECT |
| `posts` | authenticated | `link_url` | UPDATE |
| `posts` | authenticated | `media_urls` | INSERT |
| `posts` | authenticated | `media_urls` | SELECT |
| `posts` | authenticated | `media_urls` | UPDATE |
| `posts` | authenticated | `type` | INSERT |
| `posts` | authenticated | `type` | SELECT |
| `posts` | authenticated | `type` | UPDATE |
| `posts` | authenticated | `updated_at` | SELECT |
| `posts` | authenticated | `updated_at` | UPDATE |
| `professor_details` | authenticated | `created_at` | SELECT |
| `professor_details` | authenticated | `curriculum_rating` | SELECT |
| `professor_details` | authenticated | `department_id` | SELECT |
| `professor_details` | authenticated | `general_rating` | SELECT |
| `professor_details` | authenticated | `id` | SELECT |
| `professor_details` | authenticated | `office_symbol` | SELECT |
| `professor_details` | authenticated | `total_ratings` | SELECT |
| `professor_details` | authenticated | `updated_at` | SELECT |
| `profile_directory` | authenticated | `avatar_url` | INSERT |
| `profile_directory` | authenticated | `avatar_url` | REFERENCES |
| `profile_directory` | authenticated | `avatar_url` | SELECT |
| `profile_directory` | authenticated | `avatar_url` | UPDATE |
| `profile_directory` | authenticated | `college_id` | INSERT |
| `profile_directory` | authenticated | `college_id` | REFERENCES |
| `profile_directory` | authenticated | `college_id` | SELECT |
| `profile_directory` | authenticated | `college_id` | UPDATE |
| `profile_directory` | authenticated | `created_at` | INSERT |
| `profile_directory` | authenticated | `created_at` | REFERENCES |
| `profile_directory` | authenticated | `created_at` | SELECT |
| `profile_directory` | authenticated | `created_at` | UPDATE |
| `profile_directory` | authenticated | `department_id` | INSERT |
| `profile_directory` | authenticated | `department_id` | REFERENCES |
| `profile_directory` | authenticated | `department_id` | SELECT |
| `profile_directory` | authenticated | `department_id` | UPDATE |
| `profile_directory` | authenticated | `full_name` | INSERT |
| `profile_directory` | authenticated | `full_name` | REFERENCES |
| `profile_directory` | authenticated | `full_name` | SELECT |
| `profile_directory` | authenticated | `full_name` | UPDATE |
| `profile_directory` | authenticated | `full_name_ar` | INSERT |
| `profile_directory` | authenticated | `full_name_ar` | REFERENCES |
| `profile_directory` | authenticated | `full_name_ar` | SELECT |
| `profile_directory` | authenticated | `full_name_ar` | UPDATE |
| `profile_directory` | authenticated | `id` | INSERT |
| `profile_directory` | authenticated | `id` | REFERENCES |
| `profile_directory` | authenticated | `id` | SELECT |
| `profile_directory` | authenticated | `id` | UPDATE |
| `profile_directory` | authenticated | `role_codes` | INSERT |
| `profile_directory` | authenticated | `role_codes` | REFERENCES |
| `profile_directory` | authenticated | `role_codes` | SELECT |
| `profile_directory` | authenticated | `role_codes` | UPDATE |
| `profiles` | authenticated | `avatar_url` | SELECT |
| `profiles` | authenticated | `avatar_url` | UPDATE |
| `profiles` | authenticated | `bio` | UPDATE |
| `profiles` | authenticated | `college_id` | SELECT |
| `profiles` | authenticated | `created_at` | SELECT |
| `profiles` | authenticated | `department_id` | SELECT |
| `profiles` | authenticated | `full_name` | SELECT |
| `profiles` | authenticated | `full_name` | UPDATE |
| `profiles` | authenticated | `full_name_ar` | SELECT |
| `profiles` | authenticated | `id` | SELECT |
| `profiles` | authenticated | `phone` | UPDATE |
| `profiles` | authenticated | `updated_at` | SELECT |
| `registration_request_courses` | authenticated | `course_id` | INSERT |
| `registration_request_courses` | authenticated | `course_id` | SELECT |
| `registration_request_courses` | authenticated | `created_at` | SELECT |
| `registration_request_courses` | authenticated | `id` | SELECT |
| `registration_request_courses` | authenticated | `request_id` | INSERT |
| `registration_request_courses` | authenticated | `request_id` | SELECT |
| `registration_request_courses` | authenticated | `section_name` | INSERT |
| `registration_request_courses` | authenticated | `section_name` | SELECT |
| `registration_request_courses` | authenticated | `sub_section_name` | INSERT |
| `registration_request_courses` | authenticated | `sub_section_name` | SELECT |
| `registration_requests` | authenticated | `advisor_id` | INSERT |
| `registration_requests` | authenticated | `advisor_id` | SELECT |
| `registration_requests` | authenticated | `advisor_notes` | SELECT |
| `registration_requests` | authenticated | `advisor_notes` | UPDATE |
| `registration_requests` | authenticated | `created_at` | SELECT |
| `registration_requests` | authenticated | `id` | SELECT |
| `registration_requests` | authenticated | `reviewed_at` | SELECT |
| `registration_requests` | authenticated | `reviewed_at` | UPDATE |
| `registration_requests` | authenticated | `semester` | INSERT |
| `registration_requests` | authenticated | `semester` | SELECT |
| `registration_requests` | authenticated | `semester_id` | INSERT |
| `registration_requests` | authenticated | `semester_id` | SELECT |
| `registration_requests` | authenticated | `status` | INSERT |
| `registration_requests` | authenticated | `status` | SELECT |
| `registration_requests` | authenticated | `status` | UPDATE |
| `registration_requests` | authenticated | `student_id` | INSERT |
| `registration_requests` | authenticated | `student_id` | SELECT |
| `registration_requests` | authenticated | `submitted_at` | INSERT |
| `registration_requests` | authenticated | `submitted_at` | SELECT |
| `registration_requests` | authenticated | `updated_at` | SELECT |
| `registration_requests` | authenticated | `updated_at` | UPDATE |
| `role_definitions` | authenticated | `code` | SELECT |
| `role_definitions` | authenticated | `created_at` | SELECT |
| `role_definitions` | authenticated | `description` | SELECT |
| `role_definitions` | authenticated | `id` | SELECT |
| `role_definitions` | authenticated | `is_active` | SELECT |
| `role_definitions` | authenticated | `name_ar` | SELECT |
| `role_definitions` | authenticated | `name_en` | SELECT |
| `role_definitions` | authenticated | `priority` | SELECT |
| `role_permissions` | authenticated | `permission_id` | SELECT |
| `role_permissions` | authenticated | `role_id` | SELECT |
| `schedules` | authenticated | `building` | INSERT |
| `schedules` | authenticated | `building` | SELECT |
| `schedules` | authenticated | `building` | UPDATE |
| `schedules` | authenticated | `course_id` | INSERT |
| `schedules` | authenticated | `course_id` | SELECT |
| `schedules` | authenticated | `course_id` | UPDATE |
| `schedules` | authenticated | `created_at` | INSERT |
| `schedules` | authenticated | `created_at` | SELECT |
| `schedules` | authenticated | `created_at` | UPDATE |
| `schedules` | authenticated | `day` | INSERT |
| `schedules` | authenticated | `day` | SELECT |
| `schedules` | authenticated | `day` | UPDATE |
| `schedules` | authenticated | `end_time` | INSERT |
| `schedules` | authenticated | `end_time` | SELECT |
| `schedules` | authenticated | `end_time` | UPDATE |
| `schedules` | authenticated | `id` | INSERT |
| `schedules` | authenticated | `id` | SELECT |
| `schedules` | authenticated | `id` | UPDATE |
| `schedules` | authenticated | `room` | INSERT |
| `schedules` | authenticated | `room` | SELECT |
| `schedules` | authenticated | `room` | UPDATE |
| `schedules` | authenticated | `schedule_type` | INSERT |
| `schedules` | authenticated | `schedule_type` | SELECT |
| `schedules` | authenticated | `schedule_type` | UPDATE |
| `schedules` | authenticated | `section_name` | INSERT |
| `schedules` | authenticated | `section_name` | SELECT |
| `schedules` | authenticated | `section_name` | UPDATE |
| `schedules` | authenticated | `semester` | INSERT |
| `schedules` | authenticated | `semester` | SELECT |
| `schedules` | authenticated | `semester` | UPDATE |
| `schedules` | authenticated | `semester_id` | INSERT |
| `schedules` | authenticated | `semester_id` | SELECT |
| `schedules` | authenticated | `semester_id` | UPDATE |
| `schedules` | authenticated | `start_time` | INSERT |
| `schedules` | authenticated | `start_time` | SELECT |
| `schedules` | authenticated | `start_time` | UPDATE |
| `schedules` | authenticated | `sub_section_name` | INSERT |
| `schedules` | authenticated | `sub_section_name` | SELECT |
| `schedules` | authenticated | `sub_section_name` | UPDATE |
| `scholarship_applications` | authenticated | `applied_at` | SELECT |
| `scholarship_applications` | authenticated | `documents` | INSERT |
| `scholarship_applications` | authenticated | `documents` | SELECT |
| `scholarship_applications` | authenticated | `id` | SELECT |
| `scholarship_applications` | authenticated | `review_notes` | SELECT |
| `scholarship_applications` | authenticated | `review_notes` | UPDATE |
| `scholarship_applications` | authenticated | `reviewed_at` | SELECT |
| `scholarship_applications` | authenticated | `reviewed_at` | UPDATE |
| `scholarship_applications` | authenticated | `reviewed_by` | SELECT |
| `scholarship_applications` | authenticated | `reviewed_by` | UPDATE |
| `scholarship_applications` | authenticated | `scholarship_id` | INSERT |
| `scholarship_applications` | authenticated | `scholarship_id` | SELECT |
| `scholarship_applications` | authenticated | `semester` | INSERT |
| `scholarship_applications` | authenticated | `semester` | SELECT |
| `scholarship_applications` | authenticated | `semester_id` | INSERT |
| `scholarship_applications` | authenticated | `semester_id` | SELECT |
| `scholarship_applications` | authenticated | `status` | SELECT |
| `scholarship_applications` | authenticated | `status` | UPDATE |
| `scholarship_applications` | authenticated | `student_id` | INSERT |
| `scholarship_applications` | authenticated | `student_id` | SELECT |
| `scholarships` | authenticated | `created_at` | SELECT |
| `scholarships` | authenticated | `description_ar` | SELECT |
| `scholarships` | authenticated | `description_en` | SELECT |
| `scholarships` | authenticated | `discount_amount` | SELECT |
| `scholarships` | authenticated | `discount_pct` | SELECT |
| `scholarships` | authenticated | `id` | SELECT |
| `scholarships` | authenticated | `is_active` | SELECT |
| `scholarships` | authenticated | `name_ar` | SELECT |
| `scholarships` | authenticated | `name_en` | SELECT |
| `scholarships` | authenticated | `updated_at` | SELECT |
| `semester_gpa` | authenticated | `created_at` | SELECT |
| `semester_gpa` | authenticated | `cumulative_credits` | SELECT |
| `semester_gpa` | authenticated | `cumulative_gpa` | SELECT |
| `semester_gpa` | authenticated | `earned_credits` | SELECT |
| `semester_gpa` | authenticated | `id` | SELECT |
| `semester_gpa` | authenticated | `is_official` | SELECT |
| `semester_gpa` | authenticated | `quality_points` | SELECT |
| `semester_gpa` | authenticated | `semester` | SELECT |
| `semester_gpa` | authenticated | `semester_gpa` | SELECT |
| `semester_gpa` | authenticated | `semester_id` | SELECT |
| `semester_gpa` | authenticated | `student_id` | SELECT |
| `semester_gpa` | authenticated | `total_credits` | SELECT |
| `semester_gpa` | authenticated | `updated_at` | SELECT |
| `semesters` | authenticated | `academic_year` | INSERT |
| `semesters` | authenticated | `academic_year` | SELECT |
| `semesters` | authenticated | `academic_year` | UPDATE |
| `semesters` | authenticated | `code` | INSERT |
| `semesters` | authenticated | `code` | SELECT |
| `semesters` | authenticated | `code` | UPDATE |
| `semesters` | authenticated | `created_at` | INSERT |
| `semesters` | authenticated | `created_at` | SELECT |
| `semesters` | authenticated | `created_at` | UPDATE |
| `semesters` | authenticated | `end_date` | INSERT |
| `semesters` | authenticated | `end_date` | SELECT |
| `semesters` | authenticated | `end_date` | UPDATE |
| `semesters` | authenticated | `id` | INSERT |
| `semesters` | authenticated | `id` | SELECT |
| `semesters` | authenticated | `id` | UPDATE |
| `semesters` | authenticated | `is_active` | INSERT |
| `semesters` | authenticated | `is_active` | SELECT |
| `semesters` | authenticated | `is_active` | UPDATE |
| `semesters` | authenticated | `is_current` | INSERT |
| `semesters` | authenticated | `is_current` | SELECT |
| `semesters` | authenticated | `is_current` | UPDATE |
| `semesters` | authenticated | `name_ar` | INSERT |
| `semesters` | authenticated | `name_ar` | SELECT |
| `semesters` | authenticated | `name_ar` | UPDATE |
| `semesters` | authenticated | `name_en` | INSERT |
| `semesters` | authenticated | `name_en` | SELECT |
| `semesters` | authenticated | `name_en` | UPDATE |
| `semesters` | authenticated | `start_date` | INSERT |
| `semesters` | authenticated | `start_date` | SELECT |
| `semesters` | authenticated | `start_date` | UPDATE |
| `shared_files` | authenticated | `course_id` | INSERT |
| `shared_files` | authenticated | `course_id` | SELECT |
| `shared_files` | authenticated | `created_at` | SELECT |
| `shared_files` | authenticated | `deleted_at` | SELECT |
| `shared_files` | authenticated | `deleted_at` | UPDATE |
| `shared_files` | authenticated | `download_count` | SELECT |
| `shared_files` | authenticated | `file_path` | INSERT |
| `shared_files` | authenticated | `file_path` | SELECT |
| `shared_files` | authenticated | `file_path` | UPDATE |
| `shared_files` | authenticated | `file_size` | INSERT |
| `shared_files` | authenticated | `file_size` | SELECT |
| `shared_files` | authenticated | `file_size` | UPDATE |
| `shared_files` | authenticated | `file_type` | INSERT |
| `shared_files` | authenticated | `file_type` | SELECT |
| `shared_files` | authenticated | `file_type` | UPDATE |
| `shared_files` | authenticated | `id` | INSERT |
| `shared_files` | authenticated | `id` | SELECT |
| `shared_files` | authenticated | `is_public` | INSERT |
| `shared_files` | authenticated | `is_public` | SELECT |
| `shared_files` | authenticated | `is_public` | UPDATE |
| `shared_files` | authenticated | `title` | INSERT |
| `shared_files` | authenticated | `title` | SELECT |
| `shared_files` | authenticated | `title` | UPDATE |
| `shared_files` | authenticated | `title_ar` | INSERT |
| `shared_files` | authenticated | `title_ar` | SELECT |
| `shared_files` | authenticated | `title_ar` | UPDATE |
| `shared_files` | authenticated | `uploader_id` | INSERT |
| `shared_files` | authenticated | `uploader_id` | SELECT |
| `student_course_registrations` | authenticated | `course_id` | INSERT |
| `student_course_registrations` | authenticated | `course_id` | SELECT |
| `student_course_registrations` | authenticated | `course_id` | UPDATE |
| `student_course_registrations` | authenticated | `id` | INSERT |
| `student_course_registrations` | authenticated | `id` | SELECT |
| `student_course_registrations` | authenticated | `id` | UPDATE |
| `student_course_registrations` | authenticated | `registered_at` | INSERT |
| `student_course_registrations` | authenticated | `registered_at` | SELECT |
| `student_course_registrations` | authenticated | `registered_at` | UPDATE |
| `student_course_registrations` | authenticated | `section_name` | INSERT |
| `student_course_registrations` | authenticated | `section_name` | SELECT |
| `student_course_registrations` | authenticated | `section_name` | UPDATE |
| `student_course_registrations` | authenticated | `semester` | INSERT |
| `student_course_registrations` | authenticated | `semester` | SELECT |
| `student_course_registrations` | authenticated | `semester` | UPDATE |
| `student_course_registrations` | authenticated | `semester_id` | INSERT |
| `student_course_registrations` | authenticated | `semester_id` | SELECT |
| `student_course_registrations` | authenticated | `semester_id` | UPDATE |
| `student_course_registrations` | authenticated | `student_id` | INSERT |
| `student_course_registrations` | authenticated | `student_id` | SELECT |
| `student_course_registrations` | authenticated | `student_id` | UPDATE |
| `student_course_registrations` | authenticated | `sub_section_name` | INSERT |
| `student_course_registrations` | authenticated | `sub_section_name` | SELECT |
| `student_course_registrations` | authenticated | `sub_section_name` | UPDATE |
| `student_groups` | authenticated | `course_id` | INSERT |
| `student_groups` | authenticated | `course_id` | SELECT |
| `student_groups` | authenticated | `created_at` | SELECT |
| `student_groups` | authenticated | `description` | INSERT |
| `student_groups` | authenticated | `description` | SELECT |
| `student_groups` | authenticated | `description` | UPDATE |
| `student_groups` | authenticated | `id` | SELECT |
| `student_groups` | authenticated | `is_active` | INSERT |
| `student_groups` | authenticated | `is_active` | SELECT |
| `student_groups` | authenticated | `is_active` | UPDATE |
| `student_groups` | authenticated | `max_students` | INSERT |
| `student_groups` | authenticated | `max_students` | SELECT |
| `student_groups` | authenticated | `max_students` | UPDATE |
| `student_groups` | authenticated | `name` | INSERT |
| `student_groups` | authenticated | `name` | SELECT |
| `student_groups` | authenticated | `name` | UPDATE |
| `student_groups` | authenticated | `name_ar` | INSERT |
| `student_groups` | authenticated | `name_ar` | SELECT |
| `student_groups` | authenticated | `name_ar` | UPDATE |
| `student_groups` | authenticated | `professor_id` | INSERT |
| `student_groups` | authenticated | `professor_id` | SELECT |
| `student_groups` | authenticated | `updated_at` | SELECT |
| `student_groups` | authenticated | `updated_at` | UPDATE |
| `student_registrations` | authenticated | `id` | INSERT |
| `student_registrations` | authenticated | `id` | SELECT |
| `student_registrations` | authenticated | `id` | UPDATE |
| `student_registrations` | authenticated | `registered_at` | INSERT |
| `student_registrations` | authenticated | `registered_at` | SELECT |
| `student_registrations` | authenticated | `registered_at` | UPDATE |
| `student_registrations` | authenticated | `section_name` | INSERT |
| `student_registrations` | authenticated | `section_name` | SELECT |
| `student_registrations` | authenticated | `section_name` | UPDATE |
| `student_registrations` | authenticated | `semester` | INSERT |
| `student_registrations` | authenticated | `semester` | SELECT |
| `student_registrations` | authenticated | `semester` | UPDATE |
| `student_registrations` | authenticated | `semester_id` | INSERT |
| `student_registrations` | authenticated | `semester_id` | SELECT |
| `student_registrations` | authenticated | `semester_id` | UPDATE |
| `student_registrations` | authenticated | `student_id` | INSERT |
| `student_registrations` | authenticated | `student_id` | SELECT |
| `student_registrations` | authenticated | `student_id` | UPDATE |
| `student_registrations` | authenticated | `sub_section_name` | INSERT |
| `student_registrations` | authenticated | `sub_section_name` | SELECT |
| `student_registrations` | authenticated | `sub_section_name` | UPDATE |
| `teaching_assistants` | authenticated | `course_id` | INSERT |
| `teaching_assistants` | authenticated | `course_id` | SELECT |
| `teaching_assistants` | authenticated | `course_id` | UPDATE |
| `teaching_assistants` | authenticated | `created_at` | INSERT |
| `teaching_assistants` | authenticated | `created_at` | SELECT |
| `teaching_assistants` | authenticated | `created_at` | UPDATE |
| `teaching_assistants` | authenticated | `id` | INSERT |
| `teaching_assistants` | authenticated | `id` | SELECT |
| `teaching_assistants` | authenticated | `id` | UPDATE |
| `teaching_assistants` | authenticated | `is_active` | INSERT |
| `teaching_assistants` | authenticated | `is_active` | SELECT |
| `teaching_assistants` | authenticated | `is_active` | UPDATE |
| `teaching_assistants` | authenticated | `professor_id` | INSERT |
| `teaching_assistants` | authenticated | `professor_id` | SELECT |
| `teaching_assistants` | authenticated | `professor_id` | UPDATE |
| `teaching_assistants` | authenticated | `profile_id` | INSERT |
| `teaching_assistants` | authenticated | `profile_id` | SELECT |
| `teaching_assistants` | authenticated | `profile_id` | UPDATE |
| `teaching_assistants` | authenticated | `ta_role` | INSERT |
| `teaching_assistants` | authenticated | `ta_role` | SELECT |
| `teaching_assistants` | authenticated | `ta_role` | UPDATE |
| `user_preferences` | authenticated | `dashboard_widgets` | INSERT |
| `user_preferences` | authenticated | `dashboard_widgets` | SELECT |
| `user_preferences` | authenticated | `dashboard_widgets` | UPDATE |
| `user_preferences` | authenticated | `email_digest` | INSERT |
| `user_preferences` | authenticated | `email_digest` | SELECT |
| `user_preferences` | authenticated | `email_digest` | UPDATE |
| `user_preferences` | authenticated | `locale` | INSERT |
| `user_preferences` | authenticated | `locale` | SELECT |
| `user_preferences` | authenticated | `locale` | UPDATE |
| `user_preferences` | authenticated | `notifications_on` | INSERT |
| `user_preferences` | authenticated | `notifications_on` | SELECT |
| `user_preferences` | authenticated | `notifications_on` | UPDATE |
| `user_preferences` | authenticated | `sms_opt_in` | INSERT |
| `user_preferences` | authenticated | `sms_opt_in` | SELECT |
| `user_preferences` | authenticated | `sms_opt_in` | UPDATE |
| `user_preferences` | authenticated | `theme` | INSERT |
| `user_preferences` | authenticated | `theme` | SELECT |
| `user_preferences` | authenticated | `theme` | UPDATE |
| `user_preferences` | authenticated | `timezone` | INSERT |
| `user_preferences` | authenticated | `timezone` | SELECT |
| `user_preferences` | authenticated | `timezone` | UPDATE |
| `user_preferences` | authenticated | `updated_at` | INSERT |
| `user_preferences` | authenticated | `updated_at` | SELECT |
| `user_preferences` | authenticated | `updated_at` | UPDATE |
| `user_preferences` | authenticated | `user_id` | INSERT |
| `user_preferences` | authenticated | `user_id` | SELECT |
| `user_preferences` | authenticated | `user_id` | UPDATE |
| `user_roles` | authenticated | `expires_at` | SELECT |
| `user_roles` | authenticated | `granted_at` | SELECT |
| `user_roles` | authenticated | `granted_by` | SELECT |
| `user_roles` | authenticated | `role_id` | SELECT |
| `user_roles` | authenticated | `user_id` | SELECT |
| `user_sessions` | authenticated | `created_at` | INSERT |
| `user_sessions` | authenticated | `created_at` | SELECT |
| `user_sessions` | authenticated | `created_at` | UPDATE |
| `user_sessions` | authenticated | `device_name` | INSERT |
| `user_sessions` | authenticated | `device_name` | SELECT |
| `user_sessions` | authenticated | `device_name` | UPDATE |
| `user_sessions` | authenticated | `device_type` | INSERT |
| `user_sessions` | authenticated | `device_type` | SELECT |
| `user_sessions` | authenticated | `device_type` | UPDATE |
| `user_sessions` | authenticated | `id` | INSERT |
| `user_sessions` | authenticated | `id` | SELECT |
| `user_sessions` | authenticated | `id` | UPDATE |
| `user_sessions` | authenticated | `ip_address` | INSERT |
| `user_sessions` | authenticated | `ip_address` | SELECT |
| `user_sessions` | authenticated | `ip_address` | UPDATE |
| `user_sessions` | authenticated | `is_active` | INSERT |
| `user_sessions` | authenticated | `is_active` | SELECT |
| `user_sessions` | authenticated | `is_active` | UPDATE |
| `user_sessions` | authenticated | `last_active` | INSERT |
| `user_sessions` | authenticated | `last_active` | SELECT |
| `user_sessions` | authenticated | `last_active` | UPDATE |
| `user_sessions` | authenticated | `location` | INSERT |
| `user_sessions` | authenticated | `location` | SELECT |
| `user_sessions` | authenticated | `location` | UPDATE |
| `user_sessions` | authenticated | `user_agent` | INSERT |
| `user_sessions` | authenticated | `user_agent` | SELECT |
| `user_sessions` | authenticated | `user_agent` | UPDATE |
| `user_sessions` | authenticated | `user_id` | INSERT |
| `user_sessions` | authenticated | `user_id` | SELECT |
| `user_sessions` | authenticated | `user_id` | UPDATE |
| `virtual_class_attendance` | authenticated | `duration_mins` | INSERT |
| `virtual_class_attendance` | authenticated | `duration_mins` | SELECT |
| `virtual_class_attendance` | authenticated | `duration_mins` | UPDATE |
| `virtual_class_attendance` | authenticated | `id` | INSERT |
| `virtual_class_attendance` | authenticated | `id` | SELECT |
| `virtual_class_attendance` | authenticated | `id` | UPDATE |
| `virtual_class_attendance` | authenticated | `joined_at` | INSERT |
| `virtual_class_attendance` | authenticated | `joined_at` | SELECT |
| `virtual_class_attendance` | authenticated | `joined_at` | UPDATE |
| `virtual_class_attendance` | authenticated | `left_at` | INSERT |
| `virtual_class_attendance` | authenticated | `left_at` | SELECT |
| `virtual_class_attendance` | authenticated | `left_at` | UPDATE |
| `virtual_class_attendance` | authenticated | `student_id` | INSERT |
| `virtual_class_attendance` | authenticated | `student_id` | SELECT |
| `virtual_class_attendance` | authenticated | `student_id` | UPDATE |
| `virtual_class_attendance` | authenticated | `virtual_class_id` | INSERT |
| `virtual_class_attendance` | authenticated | `virtual_class_id` | SELECT |
| `virtual_class_attendance` | authenticated | `virtual_class_id` | UPDATE |
| `virtual_classes` | authenticated | `actual_attendees` | INSERT |
| `virtual_classes` | authenticated | `actual_attendees` | SELECT |
| `virtual_classes` | authenticated | `actual_attendees` | UPDATE |
| `virtual_classes` | authenticated | `actual_end_at` | INSERT |
| `virtual_classes` | authenticated | `actual_end_at` | SELECT |
| `virtual_classes` | authenticated | `actual_end_at` | UPDATE |
| `virtual_classes` | authenticated | `actual_start_at` | INSERT |
| `virtual_classes` | authenticated | `actual_start_at` | SELECT |
| `virtual_classes` | authenticated | `actual_start_at` | UPDATE |
| `virtual_classes` | authenticated | `attendance_taken` | INSERT |
| `virtual_classes` | authenticated | `attendance_taken` | SELECT |
| `virtual_classes` | authenticated | `attendance_taken` | UPDATE |
| `virtual_classes` | authenticated | `course_id` | INSERT |
| `virtual_classes` | authenticated | `course_id` | SELECT |
| `virtual_classes` | authenticated | `course_id` | UPDATE |
| `virtual_classes` | authenticated | `created_at` | INSERT |
| `virtual_classes` | authenticated | `created_at` | SELECT |
| `virtual_classes` | authenticated | `created_at` | UPDATE |
| `virtual_classes` | authenticated | `created_by` | INSERT |
| `virtual_classes` | authenticated | `created_by` | SELECT |
| `virtual_classes` | authenticated | `created_by` | UPDATE |
| `virtual_classes` | authenticated | `duration_minutes` | INSERT |
| `virtual_classes` | authenticated | `duration_minutes` | SELECT |
| `virtual_classes` | authenticated | `duration_minutes` | UPDATE |
| `virtual_classes` | authenticated | `host_url` | INSERT |
| `virtual_classes` | authenticated | `host_url` | UPDATE |
| `virtual_classes` | authenticated | `id` | INSERT |
| `virtual_classes` | authenticated | `id` | SELECT |
| `virtual_classes` | authenticated | `id` | UPDATE |
| `virtual_classes` | authenticated | `join_url` | INSERT |
| `virtual_classes` | authenticated | `join_url` | SELECT |
| `virtual_classes` | authenticated | `join_url` | UPDATE |
| `virtual_classes` | authenticated | `max_participants` | INSERT |
| `virtual_classes` | authenticated | `max_participants` | SELECT |
| `virtual_classes` | authenticated | `max_participants` | UPDATE |
| `virtual_classes` | authenticated | `meeting_id` | INSERT |
| `virtual_classes` | authenticated | `meeting_id` | SELECT |
| `virtual_classes` | authenticated | `meeting_id` | UPDATE |
| `virtual_classes` | authenticated | `passcode` | INSERT |
| `virtual_classes` | authenticated | `passcode` | SELECT |
| `virtual_classes` | authenticated | `passcode` | UPDATE |
| `virtual_classes` | authenticated | `provider` | INSERT |
| `virtual_classes` | authenticated | `provider` | SELECT |
| `virtual_classes` | authenticated | `provider` | UPDATE |
| `virtual_classes` | authenticated | `recording_url` | INSERT |
| `virtual_classes` | authenticated | `recording_url` | SELECT |
| `virtual_classes` | authenticated | `recording_url` | UPDATE |
| `virtual_classes` | authenticated | `scheduled_at` | INSERT |
| `virtual_classes` | authenticated | `scheduled_at` | SELECT |
| `virtual_classes` | authenticated | `scheduled_at` | UPDATE |
| `virtual_classes` | authenticated | `semester` | INSERT |
| `virtual_classes` | authenticated | `semester` | SELECT |
| `virtual_classes` | authenticated | `semester` | UPDATE |
| `virtual_classes` | authenticated | `semester_id` | INSERT |
| `virtual_classes` | authenticated | `semester_id` | SELECT |
| `virtual_classes` | authenticated | `semester_id` | UPDATE |
| `virtual_classes` | authenticated | `status` | INSERT |
| `virtual_classes` | authenticated | `status` | SELECT |
| `virtual_classes` | authenticated | `status` | UPDATE |
| `virtual_classes` | authenticated | `title` | INSERT |
| `virtual_classes` | authenticated | `title` | SELECT |
| `virtual_classes` | authenticated | `title` | UPDATE |
| `virtual_classes` | authenticated | `title_ar` | INSERT |
| `virtual_classes` | authenticated | `title_ar` | SELECT |
| `virtual_classes` | authenticated | `title_ar` | UPDATE |
| `virtual_classes` | authenticated | `updated_at` | INSERT |
| `virtual_classes` | authenticated | `updated_at` | SELECT |
| `virtual_classes` | authenticated | `updated_at` | UPDATE |
