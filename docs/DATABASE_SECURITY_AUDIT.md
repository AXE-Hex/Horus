# HORUS DATABASE HARDENING REPORT

## Baseline and scope

Local-only review against PostgreSQL 17.6 / Supabase CLI 2.118.0. The baseline
migration replay and local seed succeeded; five pgTAP files contained 149 passing
assertions; baseline database lint reported no errors. Extensive pre-existing
Flutter/UI/auth/config work was present. A newer guest owner-record migration
and regression file appeared during this pass; they were preserved and the
combined current tree was tested. No remote database, deploy, commit, or push.

This is a reviewed local hardening pass, not a claim that every future production
workflow is implemented or that the platform is fully secure. Catalog counts,
exact predicates, column grants, function bodies, triggers, enums, and indexes
are recorded in [DATABASE_INVENTORY.md](DATABASE_INVENTORY.md) and
[RLS_MATRIX.md](RLS_MATRIX.md). Validation results are recorded below after the
final rebuild.

## Architecture and trust boundaries

Auth owns identities and password hashes. Public profiles contain institutional
and account state. Canonical authorization is exclusively role_definitions →
user_roles → role_permissions → permissions. A guest is authenticated but has
no internal university authority. Client navigation and cached roles are UX,
not authorization. PostgreSQL grants, column grants, restrictive account gates,
per-operation RLS, scoped RPC validation, and Storage path policies enforce the
boundary independently.

`service_role` remains a trusted backend bypass. FORCE RLS does not constrain
superusers or BYPASSRLS roles. Application SECURITY DEFINER functions are a
small reviewed bypass surface; every function pins search_path and revokes
PUBLIC/anon execution. Default privileges now require deliberate client grants
for new postgres-created tables/functions/sequences. Other migration-owner
roles need equivalent default privilege configuration before deployment.

The ordered migration directory is authoritative. Historical migrations were
not edited. `001_reset.sql` is a destructive legacy bootstrap, never a manual
production maintenance command. Unused `all_migrations.sql` and obsolete seed
`seeds/001_seed.sql` were removed after repository reference checks. The latter
had dummy encryption keys and was recommended by a stale README. Runtime
migrations contain schema/reference authorization data, not development accounts.

## Critical findings and regression evidence

| Severity | Object | Problem and impact | Repair | Regression evidence |
| --- | --- | --- | --- | --- |
| High | Account/guest RLS | Owner-only and internal catalog policies accepted guest, inactive or revoked identities; membership alone survived account bans. | Restrictive policies intersect every application relation; private Storage also intersects active internal membership. | Complete hardening account-state tests, guest_access_regressions, Storage banned-member tests, REST guest tests. |
| High | has_permission | Unknown role_definition code could carry permissions even though get_my_role rejected it. Future grants were already effective. | Both resolvers require known code and granted_at <= now(), unexpired active assignment and available profile. | Unknown, expired, future, inactive definition and absent assignment cases. |
| High | departments | WITH CHECK evaluated an ID lookup of the old row; a dean could move an existing department into another college. INSERT also could not authorize a nonexistent ID. | New caller-bound college-scope check validates the resulting college. | Allowed own-college INSERT; denied cross-college UPDATE. |
| High | Academic identity and grades | Mutable identifiers could retarget a legitimate record; grade writes accepted pending enrollment or another semester. | Client identity trigger preserves same-key upserts; approved same-semester enrollment required. | Pending/different-semester grade denial, identity denial, allowed grade upsert. |
| High | Institutional FK deletion | Course/department/college deletes could cascade academic history. | RESTRICT on hierarchy and grade/enrollment/attendance course FKs. | Course and department DELETE reject rather than delete history. |
| Medium | conversation_members | Recursive self-querying RLS prevented legitimate messaging and creator membership setup. | Auth.uid-bound membership/creator functions and explicit member policies; creators can read new conversation. | Allowed own conversation query/reply; denied outsider membership and cross-conversation reply. |
| Medium | notifications | Table-level UPDATE let owners forge server message content and delivery metadata. | Only is_read/read_at may change. | Content/recipient updates denied; acknowledgement allowed. |
| Medium | virtual_classes | Participant SELECT exposed host_url credential. | Narrow participant column grants exclude host_url. | Direct host_url SELECT denied. |
| Medium | profile RPCs | Definer self-edit/private-read ignored unavailable account state. Advisor assignment accepted banned/deleted targets. | Central resolver checks and target account checks. | Banned/inactive/deleted account RPC denial; scoped advising tests. |
| Medium | permissions | Parent/recruiter directory access lacked a trusted relationship; dorm/security broad directory scope was unmodeled; librarian course upload and representative institutional announcements lacked a justified workflow. | Remove those grants; existing scoped capabilities remain. | Guest/parent baseline tests and catalog role-grant inventory. |
| Medium | payment_transactions | No server invariant bound student/currency to invoice or prevented paid-state regression/amount retargeting. | Trusted-write trigger checks identity/currency and preserves settled identity/amount/reference; unique reference already supplies reference idempotency. | Mismatch, duplicate reference, settled amount and status regression cases. |

## RBAC, signup and account state

All 21 enum role codes were compared with the canonical registry and current
Dart role mapping, including assistant_hod. Every role-permission assignment was
reviewed; final assignments are reproducible from migrations and included in
the role matrix below. Lecturer shares teaching scope; assistants manage only
assigned-course attendance/materials, never grades. Registrar manages/reviews
registration in profile scope; an advisor reads assigned students. Department
leadership is limited to its department; dean to college; rector requires
explicit university permissions and has no implicit financial/grade-write bypass.

Signup ignores editable role/roles metadata and creates guest plus preferences.
Regression payloads request student, professor, dean, rector and administrator;
all remain guests. The compatibility profiles.roles default is now empty.
Unknown, future, expired, inactive, banned, deleted and unassigned states fail
closed. Existing metadata cannot change canonical privileges. Direct client
role/permission mutation is denied and tested as SQL operations, not only ACLs.

Parent academic access remains closed until trusted relationships exist.
Recruiter/dorm/security directory grants remain closed until a justified scoped
workflow exists. An active guest may read/edit its own identity through the
owner RPC and maintain preferences/avatar, but receives no internal catalog,
academic, financial, social or private messaging data. Public avatars remain a
documented exception; they must contain no private institutional metadata.

## Full RLS and scope methodology

Catalog review covers all 69 logical public tables and 30 partitions. All enable
and force RLS. Anonymous application relation access is absent. Separate grants
and operation predicates were inspected; tables with no trusted client workflow
remain closed, including exams/answers/attempts, encryption, operational logs,
analytics, payment transactions, delivery internals and system settings.

Restrictive policies add an account check without granting an operation or
weakening existing scopes. Existing USING checks protect original rows;
WITH CHECK protects results. Academic identity triggers additionally prevent
moves between two otherwise authorized records. Narrow column grants protect
profile security state, review targets, notifications, content ownership and
private host credentials. Course catalog, enrollment eligibility, approved course
participation, academic review and course management remain distinct.

Profile safe-directory reads intentionally contain only names/avatar/scope and
active canonical role labels. National IDs, email, phone, student identifiers,
moderation and security fields cannot be selected through directory/table grants.
Private self RPC is owner-bound; adviser directory exposes necessary student
contacts only to assigned/scoped authorized callers. Composite affiliation FK
prevents inconsistent populated college/department pairs without breaking null
university affiliation. The entire safe directory is intentionally shared among
permission-bearing internal members; pagination and staff directories do not
make sensitive profile columns public.

## RPC, trigger and SQL review

Application definers pin pg_catalog/public/auth or the required extensions
schema. Dynamic DDL uses catalog-derived identifiers and format(%I/%s with
regclass); no client-built SQL strings execute. Trigger-only functions are not
callable by ordinary clients. Timestamp triggers preserve existing behavior;
new triggers protect academic identity, message replies and payment integrity.
No duplicate auth-signup trigger exists. Function and trigger definitions are
included in the inventory, along with actual execution ACLs.

The catalog retains one PUBLIC/anon-executable, unpinned `public.moddatetime()`
function supplied by the installed C extension. It is a trigger-only function,
not SECURITY DEFINER, and PostgreSQL rejects direct invocation outside a
trigger. Its ACL is owned by `supabase_admin`; the local migration role cannot
revoke those extension-installed grants. This is a documented extension
boundary rather than an application RPC. Review extension ownership/default
ACLs during managed production provisioning.

Sensitive client RPCs retain signatures: get_my_profile_private,
update_my_profile, get_advisor_directory and assign_student_advisor. Owner RPCs
do not accept a target user ID. Advising RPCs independently validate supplied
IDs and caller scope. Allowed advising, unauthorized callers, cross-college
queries, unavailable accounts and anonymous REST/SQL calls are tested.
Boolean helpers bind auth.uid; malformed Storage scope IDs return false.

## Registration, grades and attendance

Prerequisites use published numeric grades and configured minimum_grade.
Self-created course selections do not establish private course access.
Student request/registration inserts cannot spoof another student or advisor.
Registrar enrollment writes require student scope, same-college course and
satisfied prerequisites. Existing tests exercise enrollment, request and direct
registration bypass attempts. No undocumented credit-load or conflict rules
were introduced. Review transitions are still application review state: no
automatic approved-request → enrollment trigger exists.

Students see own published grades; teaching writes require assigned course and
approved matching-semester enrollment. Academic reviewers retain existing
scoped academic access. Physical attendance requires approved course enrollment;
virtual attendance additionally matches class semester. Neither identity nor
recorder can be retargeted on existing direct-client records. Grade total/GPA
ranges and time/duration/order checks enforce new writes.

## Messaging, social and notifications

Private messages depend on current membership and active account state; sender
spoofing and outsider membership insertion are denied. Reply validation prevents
cross-conversation pointers; conversation FK prevents orphan messages. Partitioned
message UUID-only reply semantics are documented because historical PK is
(id,created_at). Message/media edits cannot change sender/conversation columns.
Conversation creators can invite visible internal members; that existing
invitation capability is deliberate, not a claim of recipient consent.

Post ownership and department/college visibility remain enforced. Same-post
comment parent FK and self-reply checks prevent invalid threads. Like/membership
uniqueness is database enforced. Notification insertion remains backend only;
clients acknowledge own rows. Mark-all acknowledgement remains correct when the
visible list is only one page.

## Storage, sensitive data and encryption

Four migration-defined buckets have server MIME allowlists and byte limits.
Only avatars are public. Private URLs are signed. Canonical course object paths
bind course/uploader/file ID to metadata; chat paths require current membership;
avatar/post paths require caller namespace. Cross-owner update/delete, wrong
bucket/path/course, malformed IDs and banned-account tests cover policy behavior.
Actual Storage HTTP tests verify MIME/oversize rejection, path spoofing and Auth.
See [STORAGE_ACCESS.md](STORAGE_ACCESS.md) for the complete path/operation contract.

PII: email/phone/national/student ID and advising/moderation state are restricted.
Academic/financial/messaging rows are private by ownership/assignment. Auth
hashes/tokens and operational encryption/delivery records are backend only.
A repository search found no service-role/secret-key literal in Flutter/assets/
workflows/environment examples. The unused dummy-key seed was removed; reset
contains zero encryption keys. `key_hash` is used as a symmetric encryption
secret by the legacy encrypt function; its name does not make that design safe.
It remains inaccessible to clients and is not used to claim encrypted profiles.

## Payment trust and Realtime

No provider webhook verification/event-ingestion workflow is configured.
Invoice settlement and transactions stay unavailable to clients. Numeric amounts
are exact, positive and reference-unique; new trusted-write invariants do not
prove that a provider actually captured money. Refund/event reconciliation,
auditable state transitions and provider idempotency must precede enabling a
payment workflow.

Publication is limited to existing client social/messaging/notification and
identity/authorization subscriptions. RLS still governs readable row access.
The inventory lists actual partition-expanded publication relations. Existing
client auth subscriptions dispose/remove channels; cached route authority is
not authoritative. Realtime DELETE payload/primary-key disclosure and role
catalog invalidation behavior need deployment-level verification; subscription
publication alone is not proof of absence of sensitive event exposure.

## Integrity, enums, FKs and nullability

All enums/types, FK delete semantics, constraints, unique indexes, nullable
columns, defaults and timestamps were cataloged. Financial values use numeric;
event timestamps use timestamptz; timetable TIME/DATE values remain deliberately
local schedule components. Stable enums were not replaced. Legacy free-text
semester plus nullable semester_id remains a compatibility contract.

New checks cover grades/GPA, library copy/fine/progress values, duration/date
ordering, exam marks, assignment expiry and self-replies. CHECK null semantics
preserve legitimate optional values. No blanket NOT NULL, fabricated backfill,
random academic rule or mass operational deletion was added. Most new checks/FKs
are NOT VALID so production historical violations require explicit reconciliation;
new writes are still enforced. PostgreSQL requires immediate validation of the
messages partitioned FK. Its migration fails on orphans rather than deleting them.
Local validation script validates every staged constraint inside a rollback.

## Performance and query audit

Seven query/FK indexes were added, one existing membership index widened, one
composite affiliation unique index was added, five
exact duplicate indexes removed. New index motivations:

| Table | Columns | Actual motivation |
| --- | --- | --- |
| role_permissions | permission_id | Reverse FK validation/deletion path not covered by role-first PK. |
| exam_schedules | course_id, exam_date | Course timetable filtering and missing course FK index. |
| post_comments | post_id, parent_id | Same-post parent FK lookup. |
| post_likes | user_id, post_id | Caller deletion/user FK lookup reverse to post-first PK. |
| notifications | user_id, created_at DESC, id DESC | Bounded user notification page under RLS. |
| posts | college_id, department_id, created_at DESC, id DESC; active rows | Scoped feed page. |
| conversation_members | user_id, conversation_id | Caller membership helper and user FK path; replaces single-column index. |
| registration_requests | advisor_id, status, submitted_at DESC, id DESC | Advisor queue filtering/page ordering. |
| departments | id, college_id unique | Composite profile affiliation FK contract, not a speculative performance index. |

Exact duplicates removed: idx_profiles_email, idx_colleges_code,
idx_departments_code, idx_attendance_composite, idx_library_borrows_item.
Other overlapping prefix indexes were retained unless demonstrated redundant.
The final catalog audit found 37 foreign keys with no supporting leading-column
index. This includes low-volume administrative references and several history
relationships. Review these against production write/delete volume before adding
indexes; the current pass covers the demonstrated RLS, paging, and course/FK
paths above. The list is in [DATABASE_VALIDATION.md](DATABASE_VALIDATION.md).
The read-only index audit lists remaining unindexed FKs; not every cold backend
FK needs an immediate speculative index. Permission/member helpers are STABLE;
restrictive caller predicates use SELECT initplans to avoid per-row reevaluation.
Representative notification/feed EXPLAIN ANALYZE uses 10,000 isolated synthetic
rows each under authenticated RLS, then rolls back. Plans use the intended
indexes with bounded output. Measurements are warm local microbenchmarks, not
production capacity predictions. Evidence is in DATABASE_VALIDATION.md.

Flutter query/RPC/model searches verified known course/name/credit, prerequisite,
profile privacy, file-path and nested FK contracts. Shared private upload URL
handling was corrected; comments/notifications/forum/file pages bounded; directory
ordering made deterministic; unread count runs in SQL. No UI redesign.

## Seed and migration strategy

Local seed uses ten deterministic Auth UUIDs and institution identifiers, canonical
single-role assignments, bcrypt hashes, matching Auth identities and no encrypted
production material. HTTP login verifies all ten accounts. Re-running local seed
is idempotent for records/roles; hashes/timestamps may change deliberately.
Local fixtures never substitute for a production provisioning workflow.
No plaintext password is stored in application tables. Development passwords in
docs/seed remain explicitly local only and must never be reused outside reset.

## Remaining risks and deliberate closed workflows

- Existing deployments require historical staged-constraint reconciliation and
  lock/rollout planning before production validation. No remote state was inspected.
- Legacy student_count trigger counts all affiliated profiles, not only active
  canonical students, and does not reflect timed role expiry. Treat counts as
  presentation hints until replaced with a canonical derived/maintained contract.
- Auth email-change/profile synchronization, no-email/anonymous signup, MFA,
  suspension/session revocation and production Auth settings need a dedicated
  workflow. Current signup requires email; database access still denies unavailable
  accounts with existing JWTs. Client user_sessions is device display data and
  changing it does not revoke a GoTrue refresh session.
- Legacy custom encryption stores usable secret material in encryption_keys.
  Profiles national_id is not automatically encrypted. A managed key/vault and
  rotation/backup threat model is required before using field encryption.
- Provider verification, financial audit/event processing and trusted user/role
  administration remain unimplemented. Backend Auth user deletion still cascades
  private profile-dependent records: retention/anonymization must be designed
  before enabling destructive account administration.
- Several reference/staff/academic aggregate/advising reads still rely on the
  Data API 1,000-row ceiling and scoped filters rather than complete cursor/UI
  paging. Transcript/GPA must not silently aggregate truncated pages. The audit
  did not replace official academic computation with a fabricated client result.
- Repositories still contain raw row adapters and some broad projections; typed
  feature models reduce presentation propagation but a full DTO cleanup is separate.
- Signature/uniqueness of UUID-only message replies, cyclic multi-course
  prerequisites, relational exam answer consistency and several backend-only
  polymorphic/logical references require workflow-specific constraints before
  those currently denied subsystems are exposed.
- SQL policy tests do not prove signed URL revocation, realtime DELETE privacy,
  virus detection, production load, filesystem object cleanup, or safe provider
  response handling. Public avatars and one-hour signed URL validity are explicit.
- No production/staging credentials, infrastructure, or remote data were tested.
