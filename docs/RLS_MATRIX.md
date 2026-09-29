# Horus database RLS matrix

This matrix inventories all 69 public application tables declared by the
migration chain, plus their 30 partition relations. It records the state found
before Phase 4 and the effective client operations after
`20260928170000_rls_database_authorization.sql` and the audit-remediation
migration. `S/I/U/D` mean SELECT,
INSERT, UPDATE, and DELETE. A dash means the client has no usable grant and no
matching operation policy. `RLS on` records the migration-chain baseline;
`RLS off` identifies tables where a policy existed but was dormant because RLS
was not enabled.

Phase 4 enables and forces RLS on every public base table and partition,
removes historical client grants and policies, then restores only the
operations listed below. Operations shown as available remain limited by both
column grants and row policies. Anonymous clients receive no table grants.

| Table | Baseline RLS | Baseline operation policies (S/I/U/D) | Effective operations | Authorization scope |
| --- | --- | --- | --- | --- |
| `profiles` | on | S,U | S,U | Active safe directory columns; self updates only for name, phone, bio, avatar. Private fields use owner-bound RPC. |
| `role_definitions` | on | — | S | Active canonical role catalog; authenticated only. |
| `user_roles` | on | S | S | Caller’s own assignments only. |
| `permissions` | on | — | S | Permission catalog only. |
| `role_permissions` | on | — | S | Canonical permission mapping only. |
| `user_preferences` | on | — | S,I,U,D | Owner only. |
| `notification_preferences` | on | — | S,I,U,D | Owner only. |
| `user_sessions` | on | — | S,I,U,D | Owner only. |
| `colleges` | on | S | S,I,U,D | Active catalog read; management limited to caller’s college, or university scope with `colleges.manage`. |
| `departments` | on | S | S,I,U,D | Active catalog read; management limited to assigned department or college. |
| `semesters` | off | S | S,I,U,D | Active catalog read; management requires university `colleges.manage`. |
| `courses` | on | S | S,I,U,D | Active course catalog; writes require `courses.manage` and department/college scope. |
| `course_prerequisites` | on | S | S,I,U,D | Course participants, same-college users with `courses.enroll` browsing the prerequisite catalog, or scoped course managers; catalog reads do not grant private resource access. Writes require management scope for both courses. |
| `professor_details` | on | — | S | Active faculty directory fields only; no direct writes to ratings. |
| `teaching_assistants` | on | — | S,I,U,D | Assigned assistant, related teacher, or scoped course manager; writes require `teaching_assistants.manage` and course assignment/scope. |
| `department_projects` | on | — | S,I,U,D | Department members or scoped department/college managers read; management writes require `departments.manage`. |
| `course_sections` | on | — | S,I,U,D | Same-college users with `courses.enroll` may read sections as enrollment catalog data; private course access still requires approved enrollment, assigned staff, scoped reviewer, or scoped manager. Writes require course management. |
| `course_sub_sections` | on | — | S,I,U,D | Same scope as parent section. |
| `schedules` | on | S | S,I,U,D | Same-college users with `courses.enroll` may read schedule catalog rows to select a course request; other private resources require approved enrollment, assigned staff, scoped reviewer, or scoped manager. Edits require schedule/course management permission and teaching/scope. |
| `exam_schedules` | on | — | S,I,U,D | Same enrollment-catalog read boundary as schedules; private academic records still require actual course scope. |
| `office_hours` | on | — | S | Own office hours or course participants; direct client writes remain denied until an explicit scheduling workflow exists. |
| `attendance` | on | — | S,I,U,D | Student self, scoped academic reviewer, course staff with `attendance.manage`, or scoped course manager. Teacher INSERT/UPDATE requires course assignment and an approved enrollment for the resulting student/course pair. |
| `virtual_classes` | on | — | S,I,U,D | Course participants read; assigned teacher creates and manages own class. |
| `virtual_class_attendance` | on | — | S,I,U,D | Student self or assigned teacher; writes require `attendance.manage` and the class course assignment. |
| `student_registrations` | on | — | S,I,U,D | Student self or scoped advisor/department/college/registrar; student writes are self-owned and require `courses.enroll`. |
| `student_course_registrations` | on | — | S,I,U,D | Owner, assigned reviewer, or course manager; student writes are self-owned, same-college eligible, and must satisfy published-grade prerequisites. |
| `registration_requests` | on | — | S,I,U,D | Student owner, assigned advisor, or permission-bearing reviewer in scope; reviewer updates limited to review fields; students may delete pending requests. |
| `registration_request_courses` | on | — | S,I,D | Parent request owner/reviewer; owner may add/remove courses only while pending, same-college eligible, and prerequisite checks pass. |
| `enrollments` | on | — | S,I,U,D | Student owner, course staff, assigned reviewer, or scoped manager; mutations require `registration.manage`, student scope, and published-grade prerequisite checks. |
| `action_plan_items` | on | — | S,I,U,D | Student owner or assigned advisor; advisor mutations require `students.advise`. |
| `grade_scales` | off | — | S,I,U,D | College-specific or global catalog; writes limited to scoped department/college manager. |
| `grades` | on | S | S,I,U,D | Student reads own published grade; teachers read/manage only taught-course grades; assigned academic reviewers read permitted students. Writes require `grades.manage`, assigned course, and matching enrollment. |
| `semester_gpa` | on | — | S | Official owner record or scoped academic reviewer. |
| `posts` | on | S,I,U | S,I,U,D | Authenticated active users read within college/department visibility; create requires `posts.create`; owner edit/delete, update columns restricted. University-wide posts require `colleges.manage`. |
| `post_likes` | on | — | S,I,D | Visible post only; insert/delete by caller only. |
| `post_comments` | on | — | S,I,U,D | Visible post thread only; create/edit by author; delete by author or post owner; replies remain same-post by schema constraint. |
| `student_groups` | on | — | S,I,U,D | Teacher/member or active unscoped group; course groups visible only to course participants; writes require `groups.manage` and assigned course. |
| `group_members` | on | — | S,I,D | Member or group teacher; additions limited to same-college students, and course members where the group has a course. |
| `announcements` | on | — | S,I,U,D | Exact college, department, or course audience; global audience requires `colleges.manage`; author or scoped department manager controls writes. |
| `shared_files` | on | — | S,I,U,D | Path-bound course rows only; uploader or an actual course participant may read according to `is_public`. Upload requires `materials.upload`, assigned/scoped course, and a path bound to course, uploader, and row ID. |
| `forums` | on | — | S | Active forum and `forums.access`. No client forum administration policy is defined. |
| `forum_posts` | on | — | S,I,U,D | Active forum and `forums.access`; author-owned create/edit/delete. |
| `conversations` | on | S | S,I,U,D | Existing members read; creator creates, edits, or deletes their own conversation. |
| `conversation_members` | on | — | S,I,U,D | Members can read member list; only creator can add members; users may update only read/mute fields on their own membership. |
| `messages` | on | S,I | S,I,U,D | Conversation members only; sender-owned insert/edit/delete with content-only update columns. |
| `message_reactions` | on | — | S,I,D | Members of the referenced conversation; caller-owned reactions. |
| `invoices` | on | S | S | Own invoice with `finance.read`; scoped academic financial reviewers may read. No client writes. |
| `payment_transactions` | on | — | — | No client access; payment state remains trusted-backend only. |
| `invoice_schedules` | on | — | — | No client access. |
| `scholarships` | on | — | S | Active scholarship listing with `finance.read`; no client mutation grant. |
| `scholarship_applications` | on | — | S,I,U | Owner reads/applies; in-scope financial reviewer may update review fields. No client delete. |
| `online_exams` | on | — | — | No client access until exam-specific authorization is designed. |
| `exam_questions` | on | — | — | No client access; answer/key protection. |
| `question_options` | on | — | — | No client access; answer/key protection. |
| `exam_attempts` | on | — | — | No client access until exam workflow policies exist. |
| `attempt_answers` | on | — | — | No client access; answer submission is deferred. |
| `exam_cheat_events` | on | — | — | No client access; trusted exam operations only. |
| `exam_similarity_reports` | on | — | — | No client access; trusted exam operations only. |
| `library_items` | on | — | S,I,U,D | Authenticated active-role catalog filtered to college; writes require `library.manage` in the same college scope (global items require university scope). |
| `library_borrows` | on | — | S,I,U,D | Owner read or librarian in item college; mutation requires `library.manage` in item college. |
| `library_reservations` | on | — | S,I,D | Owner or in-scope librarian; owner may reserve active library items and cancel own reservation. |
| `library_reading_history` | on | — | S | Owner or in-scope librarian; no client writes. |
| `system_settings` | on | — | — | Trusted database/admin only. |
| `encryption_keys` | on | — | — | Trusted database functions only; encryption helper execution revoked from clients. |
| `encrypted_data` | on | — | — | Trusted database functions only. |
| `audit_logs` | on | I,S | — | Client grants and historical permissive policies removed; writes must come from trusted functions. |
| `analytics_events` | on | — | — | No client table access; ingestion path is deferred. |
| `notifications` | on | — | S,U | Recipient only with `notifications.read`; no client insert/delete. |
| `notification_deliveries` | off | — | — | Trusted delivery worker only. |

All partition children of `messages`, `audit_logs`, `analytics_events`,
`exam_cheat_events`, and `notification_deliveries` are also RLS enabled and
forced by the migration. They receive no direct `anon` or `authenticated`
table grants; queries through the partitioned parent use the parent policy.
This includes `messages_y2025m01` through `messages_y2026m06` and
`messages_future`; `audit_logs_y2025`, `audit_logs_y2026`, and
`audit_logs_future`; `analytics_events_y2025m05`, `analytics_events_y2025m06`,
and `analytics_events_future`; `exam_cheat_events_y2025m05`,
`exam_cheat_events_y2025m06`, and `exam_cheat_events_future`; and
`notif_deliv_y2025` and `notif_deliv_future`.

## Scope definitions

- **Owner scoped:** row owner matches `auth.uid()`; no other student can read or
  mutate that private row.
- **Course scoped:** private resources require the caller to teach/be assigned
  to the course, have an approved enrollment, or have scoped review/manage
  authority. Same-college students with `courses.enroll` may read only the
  section, timetable, and prerequisite catalog needed to prepare a request.
  `student_course_registrations`
  is a client selection and does not establish approved participation.
- **Department scoped:** department leadership with `courses.manage` is
  restricted to its assigned department. `departments.manage` permits that
  department or departments in the caller’s college.
- **College scoped:** management and student-review permissions are limited to
  the caller’s `profiles.college_id`.
- **University wide:** only the explicit `colleges.manage` permission with no
  profile college assignment grants university-wide scope. Legacy
  `profiles.roles` is never consulted.
- **Parent academic access:** denied while the schema has no trusted
  parent/student relationship. College or department membership does not
  create that relationship.

## Baseline gaps closed

Before Phase 4, RLS was enabled on most core tables, but many enabled tables had
no policies at all. Policies were also missing for each operation separately;
for example, registration, comments, likes, notifications, preferences,
library, and course workflow tables had no complete read/write contract.
`semesters`, `grade_scales`, and notification delivery partitions had policies
or table definitions without active parent RLS. Partition children themselves
had no direct RLS setup. The migration makes all public relations default-deny
before restoring the least-privilege operations above.

## SECURITY DEFINER functions

New scope helpers use `search_path = pg_catalog, public, auth`, derive the
caller from `auth.uid()`, and consult `has_permission()` plus the canonical
role tables. Existing trigger-only student-count, auth signup, and encryption
functions receive pinned search paths; client execution is revoked from those
functions. Phase 3 profile/advisor RPCs retain their auth-bound checks and
controlled search paths. No client `service_role` capability is added.
