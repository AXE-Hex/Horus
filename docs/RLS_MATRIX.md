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

## Catalog-verified effective policies

This complete snapshot includes every application table and physical partition.
Restrictive account policies intersect permissive scope policies. No policy grants
table or column privileges. An absent grant remains deny-by-default.

| Relation | RLS | Forced | Anon grants | Authenticated table grants | Policies |
| --- | --- | --- | --- | --- | --- |
| `action_plan_items` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `analytics_events` | True | True | — | — | 1 |
| `analytics_events_future` | True | True | — | — | 1 |
| `analytics_events_y2025m05` | True | True | — | — | 1 |
| `analytics_events_y2025m06` | True | True | — | — | 1 |
| `announcements` | True | True | — | DELETE, SELECT | 5 |
| `attempt_answers` | True | True | — | — | 1 |
| `attendance` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 5 |
| `audit_logs` | True | True | — | — | 1 |
| `audit_logs_future` | True | True | — | — | 1 |
| `audit_logs_y2025` | True | True | — | — | 1 |
| `audit_logs_y2026` | True | True | — | — | 1 |
| `colleges` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `conversation_members` | True | True | — | DELETE, SELECT | 5 |
| `conversations` | True | True | — | DELETE, SELECT | 5 |
| `course_prerequisites` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `course_sections` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `course_sub_sections` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `courses` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `department_projects` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `departments` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `encrypted_data` | True | True | — | — | 1 |
| `encryption_keys` | True | True | — | — | 1 |
| `enrollments` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `exam_attempts` | True | True | — | — | 1 |
| `exam_cheat_events` | True | True | — | — | 1 |
| `exam_cheat_events_future` | True | True | — | — | 1 |
| `exam_cheat_events_y2025m05` | True | True | — | — | 1 |
| `exam_cheat_events_y2025m06` | True | True | — | — | 1 |
| `exam_questions` | True | True | — | — | 1 |
| `exam_schedules` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `exam_similarity_reports` | True | True | — | — | 1 |
| `forum_posts` | True | True | — | DELETE, SELECT | 5 |
| `forums` | True | True | — | — | 2 |
| `grade_scales` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `grades` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 5 |
| `group_members` | True | True | — | DELETE, INSERT, SELECT | 4 |
| `invoice_schedules` | True | True | — | — | 1 |
| `invoices` | True | True | — | SELECT | 2 |
| `library_borrows` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `library_items` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `library_reading_history` | True | True | — | SELECT | 2 |
| `library_reservations` | True | True | — | DELETE, SELECT | 4 |
| `message_reactions` | True | True | — | DELETE, SELECT | 4 |
| `messages` | True | True | — | DELETE, SELECT | 5 |
| `messages_future` | True | True | — | — | 1 |
| `messages_y2025m01` | True | True | — | — | 1 |
| `messages_y2025m02` | True | True | — | — | 1 |
| `messages_y2025m03` | True | True | — | — | 1 |
| `messages_y2025m04` | True | True | — | — | 1 |
| `messages_y2025m05` | True | True | — | — | 1 |
| `messages_y2025m06` | True | True | — | — | 1 |
| `messages_y2025m07` | True | True | — | — | 1 |
| `messages_y2025m08` | True | True | — | — | 1 |
| `messages_y2025m09` | True | True | — | — | 1 |
| `messages_y2025m10` | True | True | — | — | 1 |
| `messages_y2025m11` | True | True | — | — | 1 |
| `messages_y2025m12` | True | True | — | — | 1 |
| `messages_y2026m01` | True | True | — | — | 1 |
| `messages_y2026m02` | True | True | — | — | 1 |
| `messages_y2026m03` | True | True | — | — | 1 |
| `messages_y2026m04` | True | True | — | — | 1 |
| `messages_y2026m05` | True | True | — | — | 1 |
| `messages_y2026m06` | True | True | — | — | 1 |
| `notif_deliv_future` | True | True | — | — | 1 |
| `notif_deliv_y2025` | True | True | — | — | 1 |
| `notification_deliveries` | True | True | — | — | 1 |
| `notification_preferences` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 2 |
| `notifications` | True | True | — | SELECT | 3 |
| `office_hours` | True | True | — | SELECT | 2 |
| `online_exams` | True | True | — | — | 1 |
| `payment_transactions` | True | True | — | — | 1 |
| `permissions` | True | True | — | SELECT | 2 |
| `post_comments` | True | True | — | DELETE, SELECT | 5 |
| `post_likes` | True | True | — | DELETE, INSERT, SELECT | 4 |
| `posts` | True | True | — | DELETE, SELECT | 5 |
| `professor_details` | True | True | — | SELECT | 2 |
| `profiles` | True | True | — | — | 3 |
| `question_options` | True | True | — | — | 1 |
| `registration_request_courses` | True | True | — | DELETE, SELECT | 4 |
| `registration_requests` | True | True | — | DELETE, SELECT | 5 |
| `role_definitions` | True | True | — | SELECT | 2 |
| `role_permissions` | True | True | — | SELECT | 2 |
| `schedules` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `scholarship_applications` | True | True | — | SELECT | 4 |
| `scholarships` | True | True | — | SELECT | 3 |
| `semester_gpa` | True | True | — | SELECT | 2 |
| `semesters` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `shared_files` | True | True | — | DELETE, SELECT | 5 |
| `student_course_registrations` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 5 |
| `student_groups` | True | True | — | DELETE, SELECT | 3 |
| `student_registrations` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 5 |
| `system_settings` | True | True | — | — | 1 |
| `teaching_assistants` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `user_preferences` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 2 |
| `user_roles` | True | True | — | SELECT | 2 |
| `user_sessions` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 2 |
| `virtual_class_attendance` | True | True | — | DELETE, INSERT, SELECT, UPDATE | 3 |
| `virtual_classes` | True | True | — | DELETE, INSERT, UPDATE | 3 |

### Exact predicates by operation

#### `action_plan_items`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `action_plans_read_owner_or_advisor` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('grades.read'::text)) OR can_review_student(student_id)) | — |
| `action_plans_manage_advisor` | ALL | PERMISSIVE | (can_review_student(student_id) AND has_permission('students.advise'::text)) | (can_review_student(student_id) AND has_permission('students.advise'::text)) |
| `action_plan_items_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `analytics_events`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `analytics_events_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `analytics_events_future`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `analytics_events_future_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `analytics_events_y2025m05`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `analytics_events_y2025m05_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `analytics_events_y2025m06`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `analytics_events_y2025m06_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `announcements`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `announcements_read_in_scope` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND ((expires_at IS NULL) OR (expires_at > now())) AND (get_my_role() IS NOT NULL) AND ((college_id IS NULL) OR (college_id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))))) AND ((department_id IS NULL) OR (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))))) AND ((course_id IS NULL) OR can_access_course(course_id))) | — |
| `announcements_insert_scoped_author` | INSERT | PERMISSIVE | — | ((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('announcements.create'::text) AND ((has_permission('colleges.manage'::text) AND (college_id IS NULL) AND (department_id IS NULL) AND (course_id IS NULL)) OR ((department_id IS NOT NULL) AND can_manage_department(department_id) AND ((course_id IS NULL) OR can_manage_course(course_id))) OR ((department_id IS NOT NULL) AND (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))) AND has_permission('announcements.create'::text) AND ((course_id IS NULL) OR can_teach_course(course_id))) OR ((course_id IS NOT NULL) AND can_teach_course(course_id) AND (EXISTS ( SELECT 1    FROM ((courses c      JOIN profiles actor ON ((actor.id = ( SELECT auth.uid() AS uid))))      JOIN departments d ON ((d.id = c.department_id)))   WHERE ((c.id = announcements.course_id) AND (d.id = actor.department_id))))))) |
| `announcements_update_scoped_author` | UPDATE | PERMISSIVE | (((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('announcements.create'::text)) OR ((department_id IS NOT NULL) AND can_manage_department(department_id))) | (((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('announcements.create'::text) AND ((has_permission('colleges.manage'::text) AND (college_id IS NULL) AND (department_id IS NULL) AND (course_id IS NULL)) OR ((department_id IS NOT NULL) AND can_manage_department(department_id) AND ((course_id IS NULL) OR can_manage_course(course_id))) OR ((department_id IS NOT NULL) AND (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))) AND has_permission('announcements.create'::text) AND ((course_id IS NULL) OR can_teach_course(course_id))) OR ((course_id IS NOT NULL) AND can_teach_course(course_id)))) OR ((department_id IS NOT NULL) AND can_manage_department(department_id))) |
| `announcements_delete_scoped_author` | DELETE | PERMISSIVE | (((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('announcements.create'::text)) OR ((department_id IS NOT NULL) AND can_manage_department(department_id))) | — |
| `announcements_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `attempt_answers`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `attempt_answers_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `attendance`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `attendance_read_owner_staff_or_advisor` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('attendance.read'::text)) OR (can_teach_course(course_id) AND has_permission('attendance.manage'::text)) OR can_manage_course(course_id) OR (can_review_student(student_id) AND has_permission('attendance.read'::text))) | — |
| `attendance_delete_teacher` | DELETE | PERMISSIVE | (has_permission('attendance.manage'::text) AND can_teach_course(course_id)) | — |
| `attendance_insert_teacher` | INSERT | PERMISSIVE | — | ((recorded_by = ( SELECT auth.uid() AS uid)) AND has_permission('attendance.manage'::text) AND can_teach_course(course_id) AND (EXISTS ( SELECT 1    FROM enrollments e   WHERE ((e.student_id = attendance.student_id) AND (e.course_id = attendance.course_id) AND (e.status = 'approved'::enrollment_status))))) |
| `attendance_update_teacher` | UPDATE | PERMISSIVE | (has_permission('attendance.manage'::text) AND can_teach_course(course_id)) | (has_permission('attendance.manage'::text) AND can_teach_course(course_id) AND (EXISTS ( SELECT 1    FROM enrollments e   WHERE ((e.student_id = attendance.student_id) AND (e.course_id = attendance.course_id) AND (e.status = 'approved'::enrollment_status))))) |
| `attendance_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `audit_logs`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `audit_logs_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `audit_logs_future`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `audit_logs_future_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `audit_logs_y2025`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `audit_logs_y2025_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `audit_logs_y2026`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `audit_logs_y2026_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `colleges`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `colleges_read_active` | SELECT | PERMISSIVE | (is_active AND (get_my_role() IS NOT NULL)) | — |
| `colleges_manage_scope` | ALL | PERMISSIVE | (has_permission('colleges.manage'::text) AND ((( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))) IS NULL) OR (id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) | (has_permission('colleges.manage'::text) AND ((( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))) IS NULL) OR (id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) |
| `colleges_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `conversation_members`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `conversation_members_update_self` | UPDATE | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | (user_id = ( SELECT auth.uid() AS uid)) |
| `conversation_members_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `conversation_members_select_member` | SELECT | PERMISSIVE | is_conversation_member(conversation_id) | — |
| `conversation_members_insert_creator` | INSERT | PERMISSIVE | — | (is_conversation_creator(conversation_id) AND (EXISTS ( SELECT 1    FROM profiles p   WHERE (p.id = conversation_members.user_id))) AND (EXISTS ( SELECT 1    FROM profile_directory p   WHERE ((p.id = conversation_members.user_id) AND (p.role_codes && ARRAY['rector'::text, 'dean'::text, 'department_head'::text, 'assistant_hod'::text, 'academic_coordinator'::text, 'professor'::text, 'lecturer'::text, 'teaching_assistant'::text, 'registrar_officer'::text, 'academic_advisor'::text, 'librarian'::text, 'freshman'::text, 'regular_student'::text, 'student'::text, 'class_representative'::text, 'alumni'::text, 'dorm_supervisor'::text, 'security_officer'::text]))))) |
| `conversation_members_delete_self_or_creator` | DELETE | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) OR is_conversation_creator(conversation_id)) | — |

#### `conversations`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `conversations_create_self` | INSERT | PERMISSIVE | — | (created_by = ( SELECT auth.uid() AS uid)) |
| `conversations_update_creator` | UPDATE | PERMISSIVE | (created_by = ( SELECT auth.uid() AS uid)) | (created_by = ( SELECT auth.uid() AS uid)) |
| `conversations_delete_creator` | DELETE | PERMISSIVE | (created_by = ( SELECT auth.uid() AS uid)) | — |
| `conversations_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `conversations_member_select` | SELECT | PERMISSIVE | (is_conversation_member(id) OR is_conversation_creator(id)) | — |

#### `course_prerequisites`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `prerequisites_manage_scope` | ALL | PERMISSIVE | can_manage_course(course_id) | (can_manage_course(course_id) AND can_manage_course(prerequisite_course_id)) |
| `prerequisites_read_course` | SELECT | PERMISSIVE | (can_access_course(course_id) OR can_browse_course_catalog(course_id)) | — |
| `course_prerequisites_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `course_sections`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `sections_manage_scope` | ALL | PERMISSIVE | can_manage_course(course_id) | can_manage_course(course_id) |
| `sections_read_course` | SELECT | PERMISSIVE | (can_access_course(course_id) OR can_browse_course_catalog(course_id)) | — |
| `course_sections_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `course_sub_sections`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `subsections_manage_scope` | ALL | PERMISSIVE | (EXISTS ( SELECT 1    FROM course_sections s   WHERE ((s.id = course_sub_sections.section_id) AND can_manage_course(s.course_id)))) | (EXISTS ( SELECT 1    FROM course_sections s   WHERE ((s.id = course_sub_sections.section_id) AND can_manage_course(s.course_id)))) |
| `subsections_read_course` | SELECT | PERMISSIVE | (EXISTS ( SELECT 1    FROM course_sections s   WHERE ((s.id = course_sub_sections.section_id) AND (can_access_course(s.course_id) OR can_browse_course_catalog(s.course_id))))) | — |
| `course_sub_sections_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `courses`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `courses_read_active` | SELECT | PERMISSIVE | ((is_active AND (get_my_role() IS NOT NULL)) OR can_manage_course(id)) | — |
| `courses_manage_scope` | ALL | PERMISSIVE | can_manage_course(id) | can_manage_course_department(department_id) |
| `courses_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `department_projects`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `department_projects_read_scope` | SELECT | PERMISSIVE | ((get_my_role() IS NOT NULL) AND ((EXISTS ( SELECT 1    FROM (profiles actor      JOIN departments d ON ((d.id = department_projects.department_id)))   WHERE ((actor.id = ( SELECT auth.uid() AS uid)) AND (actor.department_id = d.id)))) OR can_manage_department(department_id))) | — |
| `department_projects_manage_scope` | ALL | PERMISSIVE | can_manage_department(department_id) | can_manage_department(department_id) |
| `department_projects_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `departments`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `departments_read_active` | SELECT | PERMISSIVE | (is_active AND (get_my_role() IS NOT NULL)) | — |
| `departments_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `departments_manage_scope` | ALL | PERMISSIVE | can_manage_department(id) | can_manage_college_departments(college_id) |

#### `encrypted_data`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `encrypted_data_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `encryption_keys`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `encryption_keys_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `enrollments`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `enrollments_read_owner_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) OR can_review_student(student_id) OR can_teach_course(course_id) OR can_manage_course(course_id)) | — |
| `enrollments_manage_registration` | ALL | PERMISSIVE | (has_permission('registration.manage'::text) AND can_review_student(student_id)) | (has_permission('registration.manage'::text) AND can_review_student(student_id) AND can_manage_registration_course(student_id, course_id) AND has_satisfied_course_prerequisites(student_id, course_id)) |
| `enrollments_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_attempts`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_attempts_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_cheat_events`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_cheat_events_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_cheat_events_future`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_cheat_events_future_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_cheat_events_y2025m05`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_cheat_events_y2025m05_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_cheat_events_y2025m06`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_cheat_events_y2025m06_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_questions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_questions_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_schedules`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_schedules_manage_scope` | ALL | PERMISSIVE | (can_manage_course(course_id) OR (has_permission('schedules.manage'::text) AND can_teach_course(course_id))) | (can_manage_course(course_id) OR (has_permission('schedules.manage'::text) AND can_teach_course(course_id))) |
| `exam_schedules_read_course` | SELECT | PERMISSIVE | (can_access_course(course_id) OR can_browse_course_catalog(course_id)) | — |
| `exam_schedules_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `exam_similarity_reports`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `exam_similarity_reports_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `forum_posts`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `forum_posts_read_active` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND has_permission('forums.access'::text) AND (EXISTS ( SELECT 1    FROM forums f   WHERE ((f.id = forum_posts.forum_id) AND f.is_active)))) | — |
| `forum_posts_insert_self` | INSERT | PERMISSIVE | — | ((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('forums.access'::text) AND (EXISTS ( SELECT 1    FROM forums f   WHERE ((f.id = forum_posts.forum_id) AND f.is_active)))) |
| `forum_posts_update_self` | UPDATE | PERMISSIVE | ((author_id = ( SELECT auth.uid() AS uid)) AND (deleted_at IS NULL)) | (author_id = ( SELECT auth.uid() AS uid)) |
| `forum_posts_delete_self` | DELETE | PERMISSIVE | (author_id = ( SELECT auth.uid() AS uid)) | — |
| `forum_posts_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `forums`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `forums_read_active` | SELECT | PERMISSIVE | (is_active AND has_permission('forums.access'::text)) | — |
| `forums_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `grade_scales`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `grade_scales_read_authenticated` | SELECT | PERMISSIVE | ((college_id IS NULL) OR (EXISTS ( SELECT 1    FROM profiles p   WHERE ((p.id = ( SELECT auth.uid() AS uid)) AND ((p.college_id = grade_scales.college_id) OR ((p.college_id IS NULL) AND has_permission('colleges.manage'::text))))))) | — |
| `grade_scales_manage_scope` | ALL | PERMISSIVE | (((college_id IS NULL) AND has_permission('colleges.manage'::text)) OR (EXISTS ( SELECT 1    FROM profiles p   WHERE ((p.id = ( SELECT auth.uid() AS uid)) AND (p.college_id = grade_scales.college_id) AND has_permission('departments.manage'::text))))) | (((college_id IS NULL) AND has_permission('colleges.manage'::text)) OR (EXISTS ( SELECT 1    FROM profiles p   WHERE ((p.id = ( SELECT auth.uid() AS uid)) AND (p.college_id = grade_scales.college_id) AND has_permission('departments.manage'::text))))) |
| `grade_scales_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `grades`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `grades_read_owner_staff_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND is_published AND has_permission('grades.read'::text)) OR (can_teach_course(course_id) AND has_permission('grades.manage'::text)) OR can_manage_course(course_id) OR (can_review_student(student_id) AND has_permission('grades.read'::text))) | — |
| `grades_delete_teacher` | DELETE | PERMISSIVE | (has_permission('grades.manage'::text) AND can_teach_course(course_id)) | — |
| `grades_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `grades_insert_teacher` | INSERT | PERMISSIVE | — | (has_permission('grades.manage'::text) AND can_teach_course(course_id) AND (EXISTS ( SELECT 1    FROM enrollments e   WHERE ((e.student_id = grades.student_id) AND (e.course_id = grades.course_id) AND (e.status = 'approved'::enrollment_status) AND (e.semester = grades.semester))))) |
| `grades_update_teacher` | UPDATE | PERMISSIVE | (has_permission('grades.manage'::text) AND can_teach_course(course_id)) | (has_permission('grades.manage'::text) AND can_teach_course(course_id) AND (EXISTS ( SELECT 1    FROM enrollments e   WHERE ((e.student_id = grades.student_id) AND (e.course_id = grades.course_id) AND (e.status = 'approved'::enrollment_status) AND (e.semester = grades.semester))))) |

#### `group_members`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `group_members_read_group` | SELECT | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM student_groups g   WHERE ((g.id = group_members.group_id) AND ((g.professor_id = ( SELECT auth.uid() AS uid)) OR can_access_course(g.course_id)))))) | — |
| `group_members_insert_teacher` | INSERT | PERMISSIVE | — | (EXISTS ( SELECT 1    FROM student_groups g   WHERE ((g.id = group_members.group_id) AND (g.professor_id = ( SELECT auth.uid() AS uid)) AND has_permission('groups.manage'::text) AND (EXISTS ( SELECT 1            FROM (profiles s              JOIN profiles actor ON ((actor.id = ( SELECT auth.uid() AS uid))))           WHERE ((s.id = group_members.student_id) AND s.is_active AND (s.college_id = actor.college_id)))) AND ((g.course_id IS NULL) OR (EXISTS ( SELECT 1            FROM enrollments e           WHERE ((e.student_id = group_members.student_id) AND (e.course_id = g.course_id)))))))) |
| `group_members_delete_owner_or_teacher` | DELETE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM student_groups g   WHERE ((g.id = group_members.group_id) AND (g.professor_id = ( SELECT auth.uid() AS uid)) AND has_permission('groups.manage'::text))))) | — |
| `group_members_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `invoice_schedules`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `invoice_schedules_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `invoices`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `invoices_read_owner_or_finance` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('finance.read'::text)) OR (has_permission('finance.read'::text) AND can_review_student(student_id))) | — |
| `invoices_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `library_borrows`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `library_borrows_read_owner_or_librarian` | SELECT | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) OR (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_borrows.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))))))) | — |
| `library_borrows_manage_librarian` | ALL | PERMISSIVE | (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_borrows.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid))))))))) | (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_borrows.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid))))))))) |
| `library_borrows_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `library_items`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `library_items_read_active` | SELECT | PERMISSIVE | ((get_my_role() IS NOT NULL) AND ((college_id IS NULL) OR (college_id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) | — |
| `library_items_manage` | ALL | PERMISSIVE | (has_permission('library.manage'::text) AND (NOT (college_id IS DISTINCT FROM ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) | (has_permission('library.manage'::text) AND (NOT (college_id IS DISTINCT FROM ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) |
| `library_items_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `library_reading_history`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `library_history_read_owner_or_librarian` | SELECT | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) OR (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_reading_history.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))))))) | — |
| `library_reading_history_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `library_reservations`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `library_reservations_read_owner_or_librarian` | SELECT | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) OR (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_reservations.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))))))) | — |
| `library_reservations_insert_owner` | INSERT | PERMISSIVE | — | ((user_id = ( SELECT auth.uid() AS uid)) AND (get_my_role() IS NOT NULL) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE (i.id = library_reservations.item_id)))) |
| `library_reservations_delete_owner_or_librarian` | DELETE | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) OR (has_permission('library.manage'::text) AND (EXISTS ( SELECT 1    FROM library_items i   WHERE ((i.id = library_reservations.item_id) AND (NOT (i.college_id IS DISTINCT FROM ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))))))) | — |
| `library_reservations_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `message_reactions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `message_reactions_read_conversation` | SELECT | PERMISSIVE | (EXISTS ( SELECT 1    FROM (messages m      JOIN conversation_members cm ON (((cm.conversation_id = m.conversation_id) AND (cm.user_id = ( SELECT auth.uid() AS uid)))))   WHERE ((m.id = message_reactions.message_id) AND (m.created_at = message_reactions.message_created_at)))) | — |
| `message_reactions_insert_self` | INSERT | PERMISSIVE | — | ((user_id = ( SELECT auth.uid() AS uid)) AND (EXISTS ( SELECT 1    FROM (messages m      JOIN conversation_members cm ON (((cm.conversation_id = m.conversation_id) AND (cm.user_id = ( SELECT auth.uid() AS uid)))))   WHERE ((m.id = message_reactions.message_id) AND (m.created_at = message_reactions.message_created_at))))) |
| `message_reactions_delete_self` | DELETE | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | — |
| `message_reactions_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_member_select` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND (EXISTS ( SELECT 1    FROM conversation_members cm   WHERE ((cm.conversation_id = messages.conversation_id) AND (cm.user_id = ( SELECT auth.uid() AS uid)))))) | — |
| `messages_member_insert` | INSERT | PERMISSIVE | — | ((sender_id = ( SELECT auth.uid() AS uid)) AND (EXISTS ( SELECT 1    FROM conversation_members cm   WHERE ((cm.conversation_id = messages.conversation_id) AND (cm.user_id = ( SELECT auth.uid() AS uid)))))) |
| `messages_sender_update` | UPDATE | PERMISSIVE | ((sender_id = ( SELECT auth.uid() AS uid)) AND (deleted_at IS NULL)) | (sender_id = ( SELECT auth.uid() AS uid)) |
| `messages_sender_delete` | DELETE | PERMISSIVE | (sender_id = ( SELECT auth.uid() AS uid)) | — |
| `messages_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_future`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_future_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m01`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m01_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m02`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m02_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m03`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m03_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m04`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m04_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m05`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m05_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m06`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m06_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m07`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m07_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m08`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m08_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m09`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m09_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m10`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m10_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m11`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m11_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2025m12`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2025m12_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m01`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m01_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m02`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m02_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m03`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m03_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m04`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m04_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m05`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m05_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `messages_y2026m06`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `messages_y2026m06_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `notif_deliv_future`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `notif_deliv_future_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `notif_deliv_y2025`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `notif_deliv_y2025_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `notification_deliveries`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `notification_deliveries_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `notification_preferences`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `notification_preferences_owner` | ALL | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | (user_id = ( SELECT auth.uid() AS uid)) |
| `notification_preferences_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `notifications`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `notifications_read_owner` | SELECT | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) AND has_permission('notifications.read'::text)) | — |
| `notifications_update_owner` | UPDATE | PERMISSIVE | ((user_id = ( SELECT auth.uid() AS uid)) AND has_permission('notifications.read'::text)) | ((user_id = ( SELECT auth.uid() AS uid)) AND has_permission('notifications.read'::text)) |
| `notifications_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `office_hours`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `office_hours_read_staff_or_course` | SELECT | PERMISSIVE | ((professor_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM courses c   WHERE ((c.professor_id = office_hours.professor_id) AND can_access_course(c.id))))) | — |
| `office_hours_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `online_exams`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `online_exams_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `payment_transactions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `payment_transactions_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `permissions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `permissions_read_catalog` | SELECT | PERMISSIVE | true | — |
| `permissions_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `post_comments`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `post_comments_read_visible_post` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_comments.post_id) AND (p.deleted_at IS NULL))))) | — |
| `post_comments_insert_self` | INSERT | PERMISSIVE | — | ((author_id = ( SELECT auth.uid() AS uid)) AND (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_comments.post_id) AND (p.deleted_at IS NULL))))) |
| `post_comments_update_self` | UPDATE | PERMISSIVE | ((author_id = ( SELECT auth.uid() AS uid)) AND (deleted_at IS NULL)) | ((author_id = ( SELECT auth.uid() AS uid)) AND (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_comments.post_id) AND (p.deleted_at IS NULL) AND ((p.college_id IS NULL) OR (p.college_id = ( SELECT profiles.college_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid))))) AND ((p.department_id IS NULL) OR (p.department_id = ( SELECT profiles.department_id            FROM profiles           WHERE (profiles.id = ( SELECT auth.uid() AS uid))))))))) |
| `post_comments_delete_self_or_post_author` | DELETE | PERMISSIVE | ((author_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_comments.post_id) AND (p.author_id = ( SELECT auth.uid() AS uid)))))) | — |
| `post_comments_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `post_likes`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `post_likes_read_visible_post` | SELECT | PERMISSIVE | (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_likes.post_id) AND (p.deleted_at IS NULL)))) | — |
| `post_likes_insert_self` | INSERT | PERMISSIVE | — | ((user_id = ( SELECT auth.uid() AS uid)) AND (EXISTS ( SELECT 1    FROM posts p   WHERE ((p.id = post_likes.post_id) AND (p.deleted_at IS NULL))))) |
| `post_likes_delete_self` | DELETE | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | — |
| `post_likes_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `posts`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `posts_delete_author` | DELETE | PERMISSIVE | (author_id = ( SELECT auth.uid() AS uid)) | — |
| `posts_read_active` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND ((college_id IS NULL) OR (EXISTS ( SELECT 1    FROM profiles p   WHERE ((p.id = ( SELECT auth.uid() AS uid)) AND (p.college_id = posts.college_id))))) AND ((department_id IS NULL) OR (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) | — |
| `posts_insert_author_permission` | INSERT | PERMISSIVE | — | ((author_id = ( SELECT auth.uid() AS uid)) AND has_permission('posts.create'::text) AND ((college_id IS NOT NULL) OR (department_id IS NOT NULL) OR has_permission('colleges.manage'::text)) AND ((college_id IS NULL) OR (college_id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))))) AND ((department_id IS NULL) OR (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) |
| `posts_update_author` | UPDATE | PERMISSIVE | ((author_id = ( SELECT auth.uid() AS uid)) AND (deleted_at IS NULL)) | ((author_id = ( SELECT auth.uid() AS uid)) AND ((college_id IS NOT NULL) OR (department_id IS NOT NULL) OR has_permission('colleges.manage'::text)) AND ((college_id IS NULL) OR (college_id = ( SELECT profiles.college_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid))))) AND ((department_id IS NULL) OR (department_id = ( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) |
| `posts_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `professor_details`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `professor_details_read_active` | SELECT | PERMISSIVE | ((get_my_role() IS NOT NULL) AND (EXISTS ( SELECT 1    FROM profiles p   WHERE ((p.id = professor_details.id) AND p.is_active AND (NOT p.is_banned) AND (p.deleted_at IS NULL))))) | — |
| `professor_details_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `profiles`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `profiles_update_self` | UPDATE | PERMISSIVE | ((id = ( SELECT auth.uid() AS uid)) AND has_permission('profiles.self_edit'::text)) | ((id = ( SELECT auth.uid() AS uid)) AND has_permission('profiles.self_edit'::text)) |
| `profiles_select_active` | SELECT | PERMISSIVE | ((id = ( SELECT auth.uid() AS uid)) OR (has_permission('profiles.read'::text) AND is_active AND (NOT is_banned) AND (deleted_at IS NULL))) | — |
| `profiles_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `question_options`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `question_options_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `registration_request_courses`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `registration_request_courses_read_related` | SELECT | PERMISSIVE | (EXISTS ( SELECT 1    FROM registration_requests rr   WHERE ((rr.id = registration_request_courses.request_id) AND ((rr.student_id = ( SELECT auth.uid() AS uid)) OR (rr.advisor_id = ( SELECT auth.uid() AS uid)) OR can_review_student(rr.student_id))))) | — |
| `registration_request_courses_delete_pending_owner` | DELETE | PERMISSIVE | (EXISTS ( SELECT 1    FROM registration_requests rr   WHERE ((rr.id = registration_request_courses.request_id) AND (rr.student_id = ( SELECT auth.uid() AS uid)) AND (rr.status = 'pending'::enrollment_status) AND has_permission('courses.enroll'::text)))) | — |
| `registration_request_courses_insert_pending_owner` | INSERT | PERMISSIVE | — | ((EXISTS ( SELECT 1    FROM registration_requests rr   WHERE ((rr.id = registration_request_courses.request_id) AND (rr.student_id = ( SELECT auth.uid() AS uid)) AND (rr.status = 'pending'::enrollment_status) AND has_permission('courses.enroll'::text)))) AND can_request_course_enrollment(course_id) AND has_satisfied_course_prerequisites(( SELECT auth.uid() AS uid), course_id)) |
| `registration_request_courses_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `registration_requests`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `registration_requests_insert_owner` | INSERT | PERMISSIVE | — | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text) AND (status = 'pending'::enrollment_status) AND (reviewed_at IS NULL) AND (NOT (advisor_id IS DISTINCT FROM ( SELECT profiles.advisor_id    FROM profiles   WHERE (profiles.id = ( SELECT auth.uid() AS uid)))))) |
| `registration_requests_update_review` | UPDATE | PERMISSIVE | (((advisor_id = ( SELECT auth.uid() AS uid)) AND has_permission('students.advise'::text)) OR (has_permission('registration.review'::text) AND can_review_student(student_id))) | (((advisor_id = ( SELECT auth.uid() AS uid)) AND has_permission('students.advise'::text)) OR (has_permission('registration.review'::text) AND can_review_student(student_id))) |
| `registration_requests_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `registration_requests_read_owner_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) OR ((advisor_id = ( SELECT auth.uid() AS uid)) AND has_permission('students.advise'::text)) OR can_review_student(student_id)) | — |
| `registration_requests_delete_pending_owner` | DELETE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) AND (status = 'pending'::enrollment_status) AND has_permission('courses.enroll'::text)) | — |

#### `role_definitions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `role_definitions_read_active` | SELECT | PERMISSIVE | is_active | — |
| `role_definitions_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `role_permissions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `role_permissions_read_catalog` | SELECT | PERMISSIVE | true | — |
| `role_permissions_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `schedules`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `schedules_manage_scope` | ALL | PERMISSIVE | (can_manage_course(course_id) OR (has_permission('schedules.manage'::text) AND can_teach_course(course_id))) | (can_manage_course(course_id) OR (has_permission('schedules.manage'::text) AND can_teach_course(course_id))) |
| `schedules_read_course` | SELECT | PERMISSIVE | (can_access_course(course_id) OR can_browse_course_catalog(course_id)) | — |
| `schedules_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `scholarship_applications`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `scholarship_apps_read_owner_or_manager` | SELECT | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) OR (has_permission('finance.read'::text) AND can_review_student(student_id))) | — |
| `scholarship_apps_insert_owner` | INSERT | PERMISSIVE | — | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('finance.read'::text)) |
| `scholarship_apps_update_manager` | UPDATE | PERMISSIVE | (has_permission('finance.read'::text) AND can_review_student(student_id)) | (has_permission('finance.read'::text) AND can_review_student(student_id)) |
| `scholarship_applications_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `scholarships`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `scholarships_read_active` | SELECT | PERMISSIVE | (is_active AND has_permission('finance.read'::text)) | — |
| `scholarships_manage_permission` | ALL | PERMISSIVE | (has_permission('finance.read'::text) AND has_permission('colleges.manage'::text)) | (has_permission('finance.read'::text) AND has_permission('colleges.manage'::text)) |
| `scholarships_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `semester_gpa`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `semester_gpa_read_owner_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND is_official AND has_permission('grades.read'::text)) OR can_review_student(student_id)) | — |
| `semester_gpa_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `semesters`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `semesters_read_active` | SELECT | PERMISSIVE | (is_active AND (get_my_role() IS NOT NULL)) | — |
| `semesters_manage_university` | ALL | PERMISSIVE | has_permission('colleges.manage'::text) | has_permission('colleges.manage'::text) |
| `semesters_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `shared_files`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `shared_files_delete_owner` | DELETE | PERMISSIVE | (uploader_id = ( SELECT auth.uid() AS uid)) | — |
| `shared_files_insert_owner` | INSERT | PERMISSIVE | — | ((uploader_id = ( SELECT auth.uid() AS uid)) AND (course_id IS NOT NULL) AND has_permission('materials.upload'::text) AND (can_teach_course(course_id) OR can_manage_course(course_id)) AND course_file_path_matches(file_path, course_id, uploader_id, id)) |
| `shared_files_update_owner` | UPDATE | PERMISSIVE | ((uploader_id = ( SELECT auth.uid() AS uid)) AND (course_id IS NOT NULL) AND has_permission('materials.upload'::text) AND (can_teach_course(course_id) OR can_manage_course(course_id)) AND course_file_path_matches(file_path, course_id, uploader_id, id)) | ((uploader_id = ( SELECT auth.uid() AS uid)) AND (course_id IS NOT NULL) AND has_permission('materials.upload'::text) AND (can_teach_course(course_id) OR can_manage_course(course_id)) AND course_file_path_matches(file_path, course_id, uploader_id, id)) |
| `shared_files_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `shared_files_read_course` | SELECT | PERMISSIVE | ((deleted_at IS NULL) AND (course_id IS NOT NULL) AND course_file_path_matches(file_path, course_id, uploader_id, id) AND (((uploader_id = ( SELECT auth.uid() AS uid)) AND has_permission('materials.upload'::text)) OR (is_public AND has_permission('materials.read'::text) AND can_access_course(course_id)))) | — |

#### `student_course_registrations`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `student_course_regs_delete_owner` | DELETE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) | — |
| `student_course_regs_insert_owner` | INSERT | PERMISSIVE | — | ((student_id = ( SELECT auth.uid() AS uid)) AND can_request_course_enrollment(course_id) AND has_satisfied_course_prerequisites(student_id, course_id)) |
| `student_course_regs_update_owner` | UPDATE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) | ((student_id = ( SELECT auth.uid() AS uid)) AND can_request_course_enrollment(course_id) AND has_satisfied_course_prerequisites(student_id, course_id)) |
| `student_course_registrations_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `student_course_regs_read_owner_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) OR can_review_student(student_id) OR can_manage_course(course_id)) | — |

#### `student_groups`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `student_groups_read_member_or_teacher` | SELECT | PERMISSIVE | ((get_my_role() IS NOT NULL) AND ((professor_id = ( SELECT auth.uid() AS uid)) OR can_access_course(course_id) OR ((course_id IS NULL) AND is_active AND (EXISTS ( SELECT 1    FROM (profiles owner      JOIN profiles actor ON ((actor.id = ( SELECT auth.uid() AS uid))))   WHERE ((owner.id = student_groups.professor_id) AND ((owner.college_id IS NULL) OR (owner.college_id = actor.college_id)))))))) | — |
| `student_groups_manage_teacher` | ALL | PERMISSIVE | ((professor_id = ( SELECT auth.uid() AS uid)) AND has_permission('groups.manage'::text)) | ((professor_id = ( SELECT auth.uid() AS uid)) AND has_permission('groups.manage'::text) AND ((course_id IS NULL) OR can_teach_course(course_id))) |
| `student_groups_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `student_registrations`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `student_registrations_write_owner` | INSERT | PERMISSIVE | — | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) |
| `student_registrations_update_owner` | UPDATE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) |
| `student_registrations_delete_owner` | DELETE | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) | — |
| `student_registrations_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `student_registrations_read_owner_or_reviewer` | SELECT | PERMISSIVE | (((student_id = ( SELECT auth.uid() AS uid)) AND has_permission('courses.enroll'::text)) OR can_review_student(student_id)) | — |

#### `system_settings`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `system_settings_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `teaching_assistants`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `teaching_assistants_read_scope` | SELECT | PERMISSIVE | ((get_my_role() IS NOT NULL) AND ((profile_id = ( SELECT auth.uid() AS uid)) OR (professor_id = ( SELECT auth.uid() AS uid)) OR can_access_course(course_id) OR ((course_id IS NULL) AND has_permission('teaching_assistants.manage'::text) AND (EXISTS ( SELECT 1    FROM (profiles actor      JOIN profiles target ON ((target.id = teaching_assistants.profile_id)))   WHERE ((actor.id = ( SELECT auth.uid() AS uid)) AND (actor.department_id = target.department_id))))) OR ((course_id IS NULL) AND can_manage_department(( SELECT profiles.department_id    FROM profiles   WHERE (profiles.id = teaching_assistants.profile_id)))))) | — |
| `teaching_assistants_manage_scope` | ALL | PERMISSIVE | (has_permission('teaching_assistants.manage'::text) AND (can_teach_course(course_id) OR can_manage_course(course_id))) | (has_permission('teaching_assistants.manage'::text) AND (can_teach_course(course_id) OR can_manage_course(course_id))) |
| `teaching_assistants_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

#### `user_preferences`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `user_preferences_owner` | ALL | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | (user_id = ( SELECT auth.uid() AS uid)) |
| `user_preferences_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `user_roles`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `user_roles_read_self` | SELECT | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | — |
| `user_roles_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `user_sessions`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `user_sessions_owner` | ALL | PERMISSIVE | (user_id = ( SELECT auth.uid() AS uid)) | (user_id = ( SELECT auth.uid() AS uid)) |
| `user_sessions_account_boundary` | ALL | RESTRICTIVE | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) | (( SELECT get_my_role() AS get_my_role) IS NOT NULL) |

#### `virtual_class_attendance`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `virtual_class_att_read_self_or_staff` | SELECT | PERMISSIVE | ((student_id = ( SELECT auth.uid() AS uid)) OR (EXISTS ( SELECT 1    FROM virtual_classes vc   WHERE ((vc.id = virtual_class_attendance.virtual_class_id) AND can_teach_course(vc.course_id))))) | — |
| `virtual_class_attendance_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |
| `virtual_class_att_manage_teacher` | ALL | PERMISSIVE | (EXISTS ( SELECT 1    FROM virtual_classes vc   WHERE ((vc.id = virtual_class_attendance.virtual_class_id) AND can_teach_course(vc.course_id) AND has_permission('attendance.manage'::text)))) | (EXISTS ( SELECT 1    FROM (virtual_classes vc      JOIN enrollments e ON (((e.course_id = vc.course_id) AND (e.student_id = virtual_class_attendance.student_id) AND (e.status = 'approved'::enrollment_status) AND (e.semester = vc.semester))))   WHERE ((vc.id = virtual_class_attendance.virtual_class_id) AND can_teach_course(vc.course_id) AND has_permission('attendance.manage'::text)))) |

#### `virtual_classes`

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `virtual_classes_read_course` | SELECT | PERMISSIVE | can_access_course(course_id) | — |
| `virtual_classes_manage_teacher` | ALL | PERMISSIVE | ((created_by = ( SELECT auth.uid() AS uid)) AND can_teach_course(course_id)) | ((created_by = ( SELECT auth.uid() AS uid)) AND can_teach_course(course_id)) |
| `virtual_classes_account_boundary` | ALL | RESTRICTIVE | ( SELECT is_active_university_member() AS is_active_university_member) | ( SELECT is_active_university_member() AS is_active_university_member) |

### Storage policies

| Policy | Command | Mode | USING | WITH CHECK |
| --- | --- | --- | --- | --- |
| `avatars_public_read` | SELECT | PERMISSIVE | (bucket_id = 'avatars'::text) | — |
| `avatars_owner_insert` | INSERT | PERMISSIVE | — | ((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text)) |
| `avatars_owner_update` | UPDATE | PERMISSIVE | ((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text)) | ((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text)) |
| `avatars_owner_delete` | DELETE | PERMISSIVE | ((bucket_id = 'avatars'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text)) | — |
| `post_media_visible_post_read` | SELECT | PERMISSIVE | ((bucket_id = 'post_media'::text) AND (((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text) OR (EXISTS ( SELECT 1    FROM posts p,     LATERAL unnest(p.media_urls) stored_media(stored_media)   WHERE (regexp_replace(stored_media.stored_media, '^.*/post_media/'::text, ''::text) = objects.name))))) | — |
| `post_media_owner_insert` | INSERT | PERMISSIVE | — | ((bucket_id = 'post_media'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text) AND has_permission('posts.create'::text)) |
| `post_media_owner_update` | UPDATE | PERMISSIVE | ((bucket_id = 'post_media'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text) AND has_permission('posts.create'::text)) | ((bucket_id = 'post_media'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text) AND has_permission('posts.create'::text)) |
| `post_media_owner_delete` | DELETE | PERMISSIVE | ((bucket_id = 'post_media'::text) AND ((storage.foldername(name))[1] = (( SELECT auth.uid() AS uid))::text)) | — |
| `chat_media_member_read` | SELECT | PERMISSIVE | ((bucket_id = 'chat_media'::text) AND can_access_storage_conversation((storage.foldername(name))[1])) | — |
| `chat_media_member_insert` | INSERT | PERMISSIVE | — | ((bucket_id = 'chat_media'::text) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND can_access_storage_conversation((storage.foldername(name))[1])) |
| `chat_media_owner_update` | UPDATE | PERMISSIVE | ((bucket_id = 'chat_media'::text) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND can_access_storage_conversation((storage.foldername(name))[1])) | ((bucket_id = 'chat_media'::text) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND can_access_storage_conversation((storage.foldername(name))[1])) |
| `chat_media_owner_delete` | DELETE | PERMISSIVE | ((bucket_id = 'chat_media'::text) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND can_access_storage_conversation((storage.foldername(name))[1])) | — |
| `course_files_scoped_read` | SELECT | PERMISSIVE | ((bucket_id = 'course_files'::text) AND (EXISTS ( SELECT 1    FROM shared_files sf   WHERE ((sf.file_path = objects.name) AND (sf.deleted_at IS NULL) AND course_file_path_matches(sf.file_path, sf.course_id, sf.uploader_id, sf.id) AND ((sf.uploader_id = ( SELECT auth.uid() AS uid)) OR (sf.is_public AND can_access_course(sf.course_id))))))) | — |
| `course_files_teacher_insert` | INSERT | PERMISSIVE | — | ((bucket_id = 'course_files'::text) AND (array_length(string_to_array(name, '/'::text), 1) = 4) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND ((storage.foldername(name))[3] ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) AND (storage.filename(name) <> ''::text) AND can_upload_storage_course_file((storage.foldername(name))[1])) |
| `course_files_owner_update` | UPDATE | PERMISSIVE | ((bucket_id = 'course_files'::text) AND (array_length(string_to_array(name, '/'::text), 1) = 4) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND ((storage.foldername(name))[3] ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) AND (storage.filename(name) <> ''::text) AND can_upload_storage_course_file((storage.foldername(name))[1]) AND (EXISTS ( SELECT 1    FROM shared_files sf   WHERE ((sf.file_path = objects.name) AND (sf.uploader_id = ( SELECT auth.uid() AS uid)) AND (sf.deleted_at IS NULL) AND course_file_path_matches(sf.file_path, sf.course_id, sf.uploader_id, sf.id))))) | ((bucket_id = 'course_files'::text) AND (array_length(string_to_array(name, '/'::text), 1) = 4) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND ((storage.foldername(name))[3] ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) AND (storage.filename(name) <> ''::text) AND can_upload_storage_course_file((storage.foldername(name))[1]) AND (EXISTS ( SELECT 1    FROM shared_files sf   WHERE ((sf.file_path = objects.name) AND (sf.uploader_id = ( SELECT auth.uid() AS uid)) AND (sf.deleted_at IS NULL) AND course_file_path_matches(sf.file_path, sf.course_id, sf.uploader_id, sf.id))))) |
| `course_files_owner_delete` | DELETE | PERMISSIVE | ((bucket_id = 'course_files'::text) AND (array_length(string_to_array(name, '/'::text), 1) = 4) AND ((storage.foldername(name))[2] = (( SELECT auth.uid() AS uid))::text) AND ((storage.foldername(name))[3] ~ '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$'::text) AND can_upload_storage_course_file((storage.foldername(name))[1])) | — |
| `objects_account_read_boundary` | SELECT | RESTRICTIVE | ((bucket_id = 'avatars'::text) OR ( SELECT is_active_university_member() AS is_active_university_member)) | — |
| `objects_account_insert_boundary` | INSERT | RESTRICTIVE | — | ((( SELECT get_my_role() AS get_my_role) IS NOT NULL) AND ((bucket_id = 'avatars'::text) OR ( SELECT is_active_university_member() AS is_active_university_member))) |
| `objects_account_update_boundary` | UPDATE | RESTRICTIVE | ((( SELECT get_my_role() AS get_my_role) IS NOT NULL) AND ((bucket_id = 'avatars'::text) OR ( SELECT is_active_university_member() AS is_active_university_member))) | ((( SELECT get_my_role() AS get_my_role) IS NOT NULL) AND ((bucket_id = 'avatars'::text) OR ( SELECT is_active_university_member() AS is_active_university_member))) |
| `objects_account_delete_boundary` | DELETE | RESTRICTIVE | ((( SELECT get_my_role() AS get_my_role) IS NOT NULL) AND ((bucket_id = 'avatars'::text) OR ( SELECT is_active_university_member() AS is_active_university_member))) | — |
