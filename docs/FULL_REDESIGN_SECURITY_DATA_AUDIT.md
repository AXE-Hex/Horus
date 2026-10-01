# Horus redesign, security, and data audit

## 1. Executive summary

Implemented a shared Horus design foundation and applied it across the main
authentication, student, academic, professor, college, feed, enrollment, and
settings flows. Removed several sources of runtime sample data, replaced the
payment balance with the signed-in student's invoice summary, and connected the
forum and session pages to repository data. Added forward-only database
hardening, a local-only Supabase seed, account verification, and broader RLS and
Storage tests.

This worktree still contains screens and workflow gaps outside the completed
paths below. In particular, the app does not yet have a trusted payment-provider
workflow, forum post detail/navigation and feed search/filter are not implemented,
and several repositories/UI collections still need end-to-end paging. The design
system is established and applied across major screens, but a visual comparison
of every route at all target widths has not been completed. This is an audit of
implemented work, not a claim that every requested production workflow is done.

## 2. Files changed

Changes span `lib/core/auth`, `lib/core/router`, `lib/core/theme`, `lib/core/i18n`,
feature presentation and repository code, shared widgets/layout, four source
translation files and generated Slang output, Supabase configuration, three
forward migrations, seed data, pgTAP tests, database audit scripts, and design,
database, storage, RBAC, and development-account documentation. The unused
49 MiB `assets/Video/HUE.mp4` was removed after source/reference scans found no
runtime use. Existing official Horus logo and university assets were retained.

## 3. Screens redesigned or data-corrected

- Startup, welcome, sign-in, forgot-password, guest registration, and restricted
  access states.
- Student home and Digital ID, using authenticated profile data and an explicit
  unavailable state when identity fields are absent.
- Courses, grades, transcript, attendance, schedules, exam schedule, academic
  progress, action plan, registration, and professor course workflows, using
  repository state with loading/error/empty paths where migrated.
- Professor dashboard, college/control dashboards, staff panel, feed cards,
  invoices/payment summary, forums, sessions, settings, and shared states.
- Payment balance now comes from invoice rows; the screen offers invoice review
  and does not present an unimplemented charge as available.
- Removed static forum counts and sample device/location/session records. Forums
  and session metadata now come from `SharedRepository`.
- Removed embedded dean identities and student/staff/research totals from the
  legacy college catalog; the active college portal obtains scoped records from
  Supabase.

Some legacy components and workflows remain. See “Remaining technical debt.”

## 4. Design system components

Centralized brand/semantic colors, typography, spacing, radii, shadows,
breakpoints, motion durations, light/dark themes, and reduced-motion handling in
`lib/core/theme/`. Added/revised shared cards (standard, academic, premium),
buttons, text fields, badges, progress, skeleton, entrance, page layout, and
error/empty state widgets. Navy, warm white, and restrained gold are brand
colors; semantic warning/error colors remain independent. No logo redraw or
liquid logo treatment was introduced.

The style-selection provider and onboarding routes/screens were retired.
Appearance defaults to System; supported device locales are selected
automatically, with English fallback and Arabic RTL.

## 5. Removed legacy design components

Removed the user-selectable visual style architecture and obsolete onboarding
language/theme/style screens, redundant role registry, unused liquid background,
and unused Digital ID customization components. Glass compatibility wrappers
remain in use in some old call sites but render without large blur layers.

## 6. Removed fake/mock runtime data

- Removed runtime mock sign-in accounts, role bypasses, debug authentication
  shortcuts, and fabricated profile/student identity fallbacks.
- Removed hardcoded grade/course/attendance examples encountered in the
  migrated academic screens and fake staff-review entries.
- Removed fixed `12,450 EGP` balance, fake forum membership/thread counts, sample
  device sessions, and embedded college staff/stat figures.
- Removed the no-op share/search/filter/urgent-news/session-revoke/forum-detail
  affordances that implied behavior without an implementation. Feed like and
  comment operations remain connected to their existing handlers.
- A production-code scan found no requested sample names, IDs, fake-avatar
  providers, or runtime mock-auth strings. Remaining literal `placeholder`
  matches are image loading placeholders, localization keys, or test fixtures.

## 7. Supabase seed architecture

`supabase/seed.sql` is enabled only for local `supabase db reset` through
`supabase/config.toml`. It uses deterministic development UUIDs, local bcrypt
password hashes, and canonical role assignment tables. No plaintext password
is stored in application tables. The `@horus.edu.eg` addresses are isolated
fixtures for the local Auth instance; `docs/DEVELOPMENT_ACCOUNTS.md` marks all
credentials LOCAL DEVELOPMENT ONLY / NEVER USE IN PRODUCTION.
The local seed now includes linked sample records for academic, online exam,
virtual class, registration, feed, library, finance-read, scholarship,
notification, and department project flows. The samples are marked local-only;
invoices remain unpaid and no payment transactions or receipts are fabricated.
Student profiles use explicit
`DEV-STU-*` identifiers and contain no national IDs.

## 8–9. Development accounts and RBAC mapping

| Account prefix | Canonical role | Representative allowed scope |
| --- | --- | --- |
| `rector.dev` | `rector` | University-scope department management explicitly granted by policy |
| `dean.dev` | `dean` | Department operations in assigned college |
| `hod.dev` | `department_head` | Assigned department courses |
| `professor.dev` | `professor` | Taught-course academic workflows |
| `ta.dev` | `teaching_assistant` | Attendance in assigned courses |
| `registrar.dev` | `registrar_officer` | Registration review in permitted scope |
| `advisor.dev` | `academic_advisor` | Assigned advisees only |
| `student.dev` | `regular_student` | Own academic and finance records |
| `freshman.dev` | `freshman` | Own scoped academic information and catalog |
| `guest.dev` | `guest` | Explicit public/basic functions only |
| `student2.dev`, `student3.dev` | `regular_student` | Additional scoped student fixtures |

Exact passwords and allowed/denied examples are in
[`DEVELOPMENT_ACCOUNTS.md`](DEVELOPMENT_ACCOUNTS.md). UI route resolution is a
convenience; canonical RBAC and RLS continue to enforce database access.

## 10. Guest security model

Self-signup assigns the canonical `guest` role regardless of editable Auth
metadata. Guest has no role permission grants in the seed. RLS/REST tests verify
no guest rows for profile directory, grades, messages, courses, and other
sensitive tables; pgTAP covers invoices, attendance, registration, role
assignments, and admin access. Storage and RPC checks fail closed.

## 11. Routing behavior

The auth provider reads canonical role assignments and permissions, validates
profile state, and fails closed for missing/unknown/inactive/banned/deleted or
expired identities. A central destination resolver distinguishes signed-out,
authorized role destinations, and restricted access. Public routes were reduced
to auth/startup and guest-access flows; protected routes require explicit
permissions.

## 12–14. Performance and older-device changes

- Removed the 49 MiB unused video asset, app-wide blur treatments, and a
  continuously animated background; shared motion honors reduced-motion
  preferences and animations use finite durations.
- Long migrated datasets use builder/sliver lists. Feed range pagination was
  retained; attendance, courses, profiles, notifications, feed, messages, and
  shared records use bounded query paths where present.
- Student schedules use a batched relational query instead of a query per
  enrollment. Profile directory role filters are applied in Supabase.
- Removed production Google Font runtime fetching from screen styles in favor
  of theme/platform text styling; no production screen calls `GoogleFonts`.
- Repository scans still find broad projections and lists that need additional
  bounded/paged contracts. See the database audit and remaining debt below.

## 15–16. Security findings and fixes

- Fixed self-signup role escalation from metadata by assigning guest in a new
  migration and keeping trusted role assignment server-controlled.
- Tightened canonical permission evaluation for account state and role timing;
  restricted role-table writes and expanded profile, ownership, academic,
  messaging, payment, Storage, and scoped-management protections.
- Added constraints/indexes based on the audited schema/access paths, with
  forward-only migrations. Existing payment state is not client-authoritative.
- Removed raw backend exception text from migrated user-facing error paths.
- Found and fixed an invoice model/schema mismatch: the Flutter model previously
  queried non-existent `invoice_number`, `type`, and `paid_amount` fields. It now
  maps the actual `description`, `currency`, `amount`, and `payment_status`
  contract, treats unknown statuses as unavailable, and no longer offers a
  client-side “confirm payment” action without a trusted settlement workflow.
- Added Storage HTTP regression coverage for MIME/size enforcement,
  cross-owner path/delete denial, and owner cleanup.

Full policy and constraint evidence is in [`DATABASE_SECURITY_AUDIT.md`](DATABASE_SECURITY_AUDIT.md),
[`DATABASE_CONTRACT.md`](DATABASE_CONTRACT.md), [`RLS_MATRIX.md`](RLS_MATRIX.md),
and [`STORAGE_ACCESS.md`](STORAGE_ACCESS.md).

## 17. New migrations

- `20260929192617_secure_guest_signup_and_permissions.sql`
- `20260929205234_complete_database_hardening.sql`
- `20260929205453_require_academic_permissions_for_owned_records.sql`

Historical migrations were not rewritten. Fresh local reset applied the full
migration chain and seed successfully.

## 18. Tests added or updated

Added startup identity/routing, email normalization, theme, locale, responsive
width/text-scale, typed data, academic summary, guest, canonical role, RLS, and
Storage regression coverage. Development account verification is available in
`scripts/database/verify_development_accounts.py`; loopback-only Auth/Storage
checks are in `scripts/database/storage_api_test.py`.

## 19–22. Validation results

- Fresh `supabase db reset --local`: PASS; all migrations and seed applied.
- `supabase test db --local`: PASS, 8 files / 280 pgTAP assertions.
- `supabase db lint --local`: PASS, no schema errors.
- Local Auth seed verification: PASS, 12 of 12 logins and canonical roles.
- Local REST/Storage regression script: PASS, including guest boundaries,
  anonymous RPC denials, MIME/size rejection, cross-owner upload/delete denial,
  and owner deletion.
- `dart format lib test`: PASS.
- `dart analyze lib test`: PASS, no issues.
- `flutter test --coverage`: PASS, 81 tests in the latest completed run,
  including the production sample-data regression scan.
- `flutter build web --debug`: PASS in the latest completed build.
- `git diff --check`: PASS at the last run.
- Coverage: 17.54% (2,126 of 12,120 executable lines hit). Coverage is low
  because tests focus on auth, data contracts, theme, routing, and selected
  widget flows rather than all screens.

## 23. Remaining technical debt

- The full requested all-route visual comparison across compact phone, tablet,
  and desktop has not been completed. Some legacy screens still use bespoke
  visual primitives rather than the shared card/button tokens.
- Forum posts do not yet have a detail route; feed search and filter controls
  need real query-backed implementations before they return as affordances.
- There is no trusted payment provider/settlement workflow. The UI now reports
  invoice data and avoids simulating payment.
- Several collections/aggregates still depend on Data API row limits or load
  entire result sets (including invoice summary); add server aggregates or
  explicit page state before data volume grows.
- Signed media URL cache lifetimes, video lifecycle/autoplay policy, and image
  decode sizing still need route-by-route verification on low-memory devices.
- A large set of administrative workflows remain visually legacy, and
  control-oriented tables/filtering/analytics require further migration.
- Production/staging Auth password, email-confirmation, reset, MFA, and rate
  limit configuration was not applied to a remote environment. Local config
  and production recommendations are documented separately.
- Local tests do not establish production load capacity, payment-provider
  integrity, signed URL revocation, realtime privacy, or operational retention.


## Product experience recovery follow-up — 2026-10-01

The active product direction is one Horus university super app with Feed as
Home, concise domain navigation, and responsive presentations. The current
implementation update:

- Main navigation now prioritizes Feed, Conversations, Courses, University,
  and Profile. Dashboard routes remain secondary and role/permission gated.
- Feed remains backed by the existing posts repository, is width constrained,
  and places permission-filtered shortcuts in a desktop context panel. Official
  trust marks remain limited to fields and scopes supported by the data contract.
- Messaging has new list/thread routes and typed repository queries for the
  existing conversations, member, profile, and message tables. Member RLS is
  unchanged. It supports text send, refresh, and bounded paging; no realtime,
  media upload, or presence claims were added. Routes reuse `forums.access`
  because the validated RBAC contract has no dedicated messaging permission.
- Courses now show a responsive selected-course summary from actual catalog
  fields; unsupported assignment/material/channel areas were not fabricated.
- Settings uses bounded grouped sections at wide widths and avoids its previous
  decorative blur/continuous painter. The unreferenced painter was removed.
- Screen inventory now records 55 GoRouter routes and 54 screen modules.
- Responsive widget checks passed at 390, 768, and 1440 pixels for Feed, Settings,
  Messaging, and the app navigation shell. This verifies layout constraints;
  actual screenshot capture and visual comparison against the original app have
  not yet been completed.
- Current Flutter validation: 81 tests passed; analyzer clean; Linux debug build
  succeeded; coverage 17.54%. No database migrations, RLS, or RBAC policies were
  changed during this UI correction.

The overall redesign remains incomplete. Most academic services, profile and
Digital ID, university exploration, notifications, and management screens still
need parity review and migration. Desktop visual inspection at 1440 and direct
role-by-role interactive review remain outstanding.
