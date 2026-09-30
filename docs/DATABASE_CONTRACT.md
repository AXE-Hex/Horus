# Horus Flutter ↔ Supabase Database Contract

This document records the canonical database contract used by the Flutter
client. The ordered SQL migrations are authoritative for exact types, defaults,
constraints, enum definitions and row-level security policies. This inventory
was audited against every literal `.from(...)` call and every table passed to
`BaseRepository` in `lib/` (excluding generated Dart files).

## Canonical field rules

- College names are `colleges.name_en` and `colleges.name_ar`.
- Department names are `departments.name_en` and `departments.name_ar`.
- Course names are `courses.name_en` and `courses.name_ar`; credit value is
  `courses.credit_hours`. There is no `courses.name`, `credits`,
  `description_ar`, or inline `prerequisites` column.
- Course prerequisites are rows in `course_prerequisites`, keyed by
  `(course_id, prerequisite_course_id)`. `minimum_grade` is on the same
  0–100 scale as `grades.total`.
- Grade numeric total is `grades.total`, not `total_score`. Course joins that
  need credit values select `courses.credit_hours`.
- Posts may have a nullable `department_id` in addition to nullable
  `college_id`. Both identifiers reference their respective institution rows.
- `post_comments.parent_id` is nullable. Its composite foreign key requires a
  parent comment to belong to the same `post_id`.
- `shared_files.course_id` is nullable in the historical table, but client
  inserts, updates, and reads now require a course-scoped row. Its private
  Storage path is `{course_id}/{uploader_id}/{shared_files_id}/{filename}`;
  each path segment is checked against the row and authenticated uploader.
  College scope follows `course_id → courses.department_id → departments.college_id`;
  `shared_files.college_id` does not exist and is not duplicated.
- There is no `support_tickets` table and no active ticket submission flow.
  The support screen currently provides contact information only.
- Professor rating display reads the aggregate `professor_details.general_rating`.
  No `professor_ratings` table exists. The current rating submission screen is
  presentation-only and does not persist a rating.
- Flutter invokes these Supabase RPC functions in the current source tree:
  `get_my_profile_private` (private profile reads), `get_advisor_directory`
  (scoped advisor/student lookup), `assign_student_advisor` (authorized advisor
  assignment), and `update_my_profile` (allowlisted self-profile updates).
  They are used by `AuthController`, `AdvisorRepository`, and profile editing
  widgets respectively; SQL function authorization remains authoritative.

Course catalog visibility, enrollment-request eligibility, and private course
participation are separate contracts. `can_request_course_enrollment` requires
an active same-college course, canonical enrollment permission, and satisfied
published-grade prerequisites. `can_browse_course_catalog` permits eligible
same-college enrollment candidates to inspect section, timetable, and
prerequisite catalog rows. Neither catalog visibility nor a client-created
registration selection establishes private course access; `can_access_course`
requires assigned staff, approved enrollment, or a scoped academic reviewer.
Prerequisites are enforced by RLS on both direct course-registration writes
and registration-request course writes, using published grades and
`course_prerequisites.minimum_grade`.

## Client-used tables

The following tables are queried or mutated by the application. Exact
definitions are in the migration listed for each bounded context.

| Table | Contract highlights | Migration |
| --- | --- | --- |
| `profiles` | Identity and account fields; `roles` is a legacy cache only. Client profile role data is loaded from `user_roles` and `role_definitions`. | `004_identity.sql` plus Phase 3 security migration |
| `colleges` | `id`, `code`, `name_en`, `name_ar`, dean and display metadata | `005_institution.sql` |
| `departments` | `id`, `college_id`, `code`, `name_en`, `name_ar`, head IDs and location metadata | `005_institution.sql` |
| `semesters` | `id`, `code`, `name_en`, `name_ar`, academic dates and current/active flags | `005_institution.sql` |
| `courses` | `id`, `department_id`, `code`, `name_en`, `name_ar`, `credit_hours`, semester references, professor and active state | `006_academic.sql` |
| `course_prerequisites` | course/prerequisite course IDs and `minimum_grade` | `20260928152302_database_contract_repair.sql` |
| `professor_details` | profile ID, department ID, `general_rating`, `curriculum_rating`, office metadata | `006_academic.sql` |
| `teaching_assistants` | profile, professor and optional course IDs; active state | `006_academic.sql` |
| `department_projects` | department and bilingual project fields | `006_academic.sql` |
| `course_sections` | course ID, section name, semester and capacity | `006_academic.sql` |
| `course_sub_sections` | section ID, name and capacity | `006_academic.sql` |
| `schedules` | course, day/time, section, semester and location | `006_academic.sql` |
| `exam_schedules` | course, exam type/date/time, section context and location | `006_academic.sql` |
| `office_hours` | professor, day/time, location and semester | `006_academic.sql` |
| `attendance` | student, course, date, attendance status and recorder | `006_academic.sql` |
| `action_plan_items` | student, optional course, semester, year and planning status | `007_registration.sql` |
| `student_registrations` | student, semester, section and subsection | `007_registration.sql` |
| `student_course_registrations` | student, course, semester, section and subsection | `007_registration.sql` |
| `registration_requests` | student, advisor, semester, workflow status and review data | `007_registration.sql` |
| `registration_request_courses` | request, course and selected section | `007_registration.sql` |
| `enrollments` | student, course, semester and enrollment status | `007_registration.sql` |
| `grades` | student, course, semester, component scores, `total`, grade and publication state | `008_grading.sql` |
| `posts` | author, college, `department_id`, content/media, type and counters | `009_social.sql` plus Phase 2 migration |
| `post_likes` | `(post_id, user_id)` relationship | `009_social.sql` |
| `post_comments` | post, author, content, nullable `parent_id` and timestamps | `009_social.sql` plus Phase 2 migration |
| `student_groups` | professor, optional course, name and active state | `009_social.sql` |
| `group_members` | group and student membership | `009_social.sql` |
| `announcements` | author, college/department/course, content, priority and publication dates | `009_social.sql` |
| `shared_files` | uploader/course/file ID bound to a canonical private Storage path, type, visibility and download count | `009_social.sql` plus audit remediation migration |
| `forums` | bilingual name, category and active state | `009_social.sql` |
| `forum_posts` | forum, author, title/content and moderation counters | `009_social.sql` |
| `invoices` | `student_id`, `semester`, `description`, `currency`, `amount`, `status`, due/paid dates, receipt and metadata | `011_financial.sql` |
| `user_sessions` | user, device/session metadata and active state | `004_identity.sql` |
| `notifications` | recipient, localized message, type, read state and metadata | `014_system.sql` |

The Flutter client uploads avatar images to `avatars` and post images to
`post_media`. Phase 5 also provisions private `chat_media` and `course_files`
buckets for the message and shared-file contracts. Bucket configuration and
the per-operation access matrix are documented in
[`STORAGE_ACCESS.md`](STORAGE_ACCESS.md) and applied by
`20260928180000_storage_access.sql`.

## Relationship notes

- `courses.department_id → departments.id` and
  `departments.college_id → colleges.id` are the source of academic ownership.
- `course_prerequisites.course_id` and
  `course_prerequisites.prerequisite_course_id` both reference `courses.id`.
  Self-prerequisites are rejected; deleting either course removes the relation.
- `posts.department_id → departments.id` uses `ON DELETE SET NULL` to retain
  posts when a department is removed.
- `(post_comments.post_id, post_comments.parent_id)` references the
  `(post_id, id)` key on `post_comments`, so a reply cannot cross post threads.
- `shared_files.course_id → courses.id`; college membership is derived through
  the course department relationship.

## Phase 3 profile and authorization access

- `role_definitions`, `user_roles`, `permissions`, and `role_permissions` are
  the canonical authorization tables. Flutter reads role assignments and
  permission codes from these relations. `profiles.roles` is a legacy cache
  and is not read for authorization.
- Flutter permission IDs use stable dotted codes such as `grades.read`,
  `grades.manage`, `finance.read`, `posts.create`, and `students.advise`. The forward migration
  seeds the current application grants into `permissions` and
  `role_permissions`, including the database `assistant_hod` role.
- Authenticated clients can directly read only safe profile columns. The
  `profile_directory` view exposes names, avatar, college/department IDs, and
  canonical role codes; it does not expose email, national ID, student ID,
  phone, bio, moderation state, or security assignments.
- `get_my_profile_private()` returns private fields for `auth.uid()` only.
  `update_my_profile()` accepts only full name, phone, bio, and avatar URL.
  National ID, role assignments, verification, ban/active state, warning level,
  and institutional assignments are not self-service fields.
- `get_advisor_directory()` and `assign_student_advisor()` are permission
  checked server-side contracts for the existing advising workflow. Advisor
  directory access is limited to assigned students or a caller's college;
  rector access may span colleges.
- Router permission checks fail closed when a route lacks a permission map or
  the signed-in profile has no active canonical role. These checks improve
  navigation behavior; database policies and checked RPCs remain the security
  boundary for data access and writes.

## Access and enum rules

- Existing table RLS policies remain defined in
  `015_functions_triggers_rls.sql` and are superseded by the forward-only
  Phase 4 authorization migration. `course_prerequisites` reads require a
  visible course scope; inserts, updates, and deletes require `courses.manage`
  in the departments of both courses.
- The social/registration enum values and table checks are defined in
  `003_types.sql`, `006_academic.sql`, `007_registration.sql` and
  `009_social.sql`. Dart writes enum `.name` only where it matches those SQL
  values; invalid file extensions are not valid `file_type` values.

## Contract audit notes

- `support_tickets` and `professor_ratings` appear only in unused repository
  methods. Those methods were removed or redirected after verifying that the
  support route is contact-only and rating display already has an aggregate
  field. No tables were added for these inactive contracts.
- Repository calls using `BaseRepository` were included in the audit, not just
  literal `.from(...)` calls.
- Historical migration files were not modified. Phase 2 schema changes are in
  the forward migration recorded above.

## Phase 4 database authorization

- `docs/RLS_MATRIX.md` inventories all public application tables and their
  separate SELECT, INSERT, UPDATE, and DELETE access after Phase 4.
- Migration `20260928170000_rls_database_authorization.sql` enables and forces
  RLS on every public table and partition, removes old client policies/grants,
  and restores only the grants and policies in the matrix.
- Authorization reads canonical `role_definitions`, `user_roles`,
  `permissions`, and `role_permissions` through `has_permission()`; profile
  role caches are not consulted.
- Students are owner scoped for private academic, registration, financial, and
  notification data. Teaching staff are limited to explicitly assigned
  courses. Department leaders with `courses.manage` are limited to their
  assigned department; college leadership with `departments.manage` is limited
  to its college; university-wide access requires `colleges.manage` and no
  assigned college.
- Inactive, banned, deleted, unknown-role, and anonymous callers receive no
  permission-based access. Anonymous clients have no table grants.
- System settings, encryption material, audit logs, analytics, exam questions
  and attempts, payment transactions, invoice schedules, and delivery internals
  remain unavailable to client roles until trusted workflows are implemented.
- Teaching assistants receive `attendance.manage` through a forward canonical
  role-permission grant; table policy checks still require an active course
  assignment.

## September 2026 complete local hardening pass

The timestamped migrations remain the sole schema authority. The unused SQL
concatenation and obsolete seed containing dummy encryption material were
removed; `supabase/seed.sql` remains local development only. See the
[catalog inventory](DATABASE_INVENTORY.md) and [security audit](DATABASE_SECURITY_AUDIT.md).

- `get_my_role` and `has_permission` both require a known active canonical role,
  effective grant time, unexpired assignment, and active/non-banned/non-deleted
  profile. Editable Auth metadata and `profiles.roles` never authorize.
- Restrictive policies intersect every application's existing operation/scope
  policies. Guests and external parent/recruiter identities cannot use internal
  university relations. Self identity/preferences remain available to an active
  canonical account; public avatar downloads remain intentional.
- Notification UPDATE permits `is_read` and `read_at` only. No caller may change
  message content, recipient, or delivery metadata. Notifications/comments/files
  use bounded repository pages with deterministic ID tie breakers; unread
  notification counts execute in PostgreSQL.
- Private buckets always use signed URLs, including the shared upload helper.
  `virtual_classes.host_url` is excluded from direct client reads.
- Academic record identity fields are immutable for direct clients, while
  same-key upserts remain valid. Grade writes require approved enrollment in
  the same semester. Virtual attendance requires an approved matching enrollment.
- Conversation membership uses caller-bound, recursion-free lookups. Creators
  can read a newly created conversation before membership is inserted; only a
  creator can add visible internal members. Reply targets must be live messages
  in that same conversation; `reply_to_id` remains UUID-only because the
  historical messages primary key includes the partition timestamp.
- `profiles.department_id` and `college_id`, when both populated, must refer to
  the same department/college relationship. University staff with null college
  retain the existing department-only affiliation contract.
- Deleting an institution/course cannot cascade through existing academic
  course, enrollment, grade, or attendance history. Use active-state changes
  instead. The relevant foreign keys now use RESTRICT.
- New score/range/order checks are staged `NOT VALID` for existing deployments:
  they enforce new/updated rows immediately. Validate and reconcile historical
  rows before production rollout; no migration deletes or silently backfills them.
