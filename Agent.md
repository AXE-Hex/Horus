# HORUS ENGINEERING CONSTITUTION

This file defines the mandatory engineering rules for every AI coding agent, Codex session, developer, refactor, feature implementation, bug fix, database change, UI modification, and architectural change performed inside the Horus repository.

These rules are not optional.

Every task must follow this document unless the user explicitly overrides a specific rule.

---

# 1. PRIMARY OBJECTIVE

Horus is a production-grade university platform.

All changes must prioritize:

1. Correctness
2. Security
3. Data integrity
4. Maintainability
5. Clear architecture
6. Testability
7. Performance
8. Accessibility
9. Consistent UX
10. Long-term scalability

Never optimize for speed of implementation at the expense of architecture, security, or maintainability.

---

# 2. AGENT OPERATING RULES

Before modifying anything:

1. Read this `AGENTS.md`.
2. Inspect the relevant existing files.
3. Understand the current architecture.
4. Trace affected dependencies.
5. Inspect relevant Supabase migrations and database contracts when data is involved.
6. Check existing models, repositories, providers/controllers, routes, localization, and tests.
7. Determine the blast radius of the requested change.

Do not blindly edit files based only on filenames.

Do not assume database columns, relationships, permissions, or API contracts.

Verify them from the repository.

---

# 3. NEVER MAKE UNRELATED CHANGES

A task must remain scoped.

Do not:

- redesign unrelated screens;
- rename unrelated classes;
- move unrelated directories;
- change behavior outside the requested feature;
- rewrite working modules without a technical reason;
- perform opportunistic large refactors during a small fix.

If another problem is discovered, document it separately unless fixing it is required for the current task.

---

# 4. PRESERVE WORKING BEHAVIOR

Refactoring must preserve behavior unless behavior change is explicitly required.

When performing structural refactoring:

- do not change UI appearance;
- do not change navigation behavior;
- do not change database behavior;
- do not alter business rules;
- do not change user-visible copy;
- do not change permissions;
- do not silently remove functionality.

Structural refactoring and behavioral changes must be separate whenever reasonably possible.

---

# 5. FILE SIZE POLICY

Source files must remain focused and maintainable.

Target:

- Prefer files below 400 lines.
- 400–600 lines is acceptable only when the file remains cohesive.
- More than 600 lines requires refactoring unless there is a clear technical justification.

Do not split files mechanically only to satisfy line counts.

Split by responsibility.

Examples:

```text
screen/
├── student_dashboard_screen.dart
├── widgets/
│   ├── dashboard_header.dart
│   ├── upcoming_classes.dart
│   ├── attendance_summary.dart
│   └── quick_actions.dart
├── controller/
├── state/
└── models/
```

A file must represent one clear responsibility.

Exceptions may include:

- generated files;
- localization-generated files;
- generated serialization code;
- database migration files where splitting would break migration integrity;
- highly declarative configuration where extraction would reduce clarity.

Never manually edit generated files unless the generation system explicitly requires it.

---

# 6. LARGE SCREEN POLICY

Large Flutter screens must not contain the entire feature implementation.

A screen should primarily coordinate layout and feature components.

Extract:

- reusable widgets;
- sections;
- dialogs;
- sheets;
- forms;
- controllers;
- state;
- formatters;
- validators;
- data transformations;
- business rules.

Avoid enormous private widget methods such as:

```dart
Widget _buildEverything(...)
```

Prefer dedicated widgets with clear inputs.

---

# 7. ARCHITECTURE RULE

Horus uses feature-oriented architecture.

New functionality must belong to the feature that owns it.

Do not create random global folders for feature-specific code.

Preferred conceptual structure:

```text
feature/
├── data/
│   ├── datasources/
│   ├── dto/
│   ├── repositories/
│   └── services/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── screens/
    ├── widgets/
    ├── state/
    └── controllers/
```

The exact structure may adapt to the existing codebase, but responsibilities must remain separated.

---

# 8. SHARED CODE RULE

Code belongs in shared/core packages only when it is genuinely reusable.

Do not move feature-specific logic into `core` merely to reduce duplication.

Shared code may include:

- networking;
- Supabase setup;
- authentication infrastructure;
- common error types;
- localization;
- reusable UI foundations;
- app-wide configuration;
- shared domain primitives;
- permissions infrastructure.

Feature-specific rules stay inside the feature.

---

# 9. FUTURE HORUS APPLICATION ARCHITECTURE

The repository is expected to evolve toward:

```text
Horus Platform
├── Horus Campus
└── Horus Control
```

`Horus Campus` serves academic users such as:

- students;
- professors;
- lecturers;
- teaching assistants;
- academic advisors.

`Horus Control` serves management and operational roles such as:

- rector;
- dean;
- department head;
- assistant department head;
- academic coordinator;
- registrar;
- finance;
- library;
- dormitory administration;
- security administration.

Do not prematurely duplicate shared code between these applications.

Shared functionality must eventually be extracted into reusable packages.

---

# 10. ONE BACKEND — MULTIPLE CLIENTS

Horus Campus and Horus Control must use the same authoritative backend where appropriate.

They may share:

- Supabase Auth;
- database;
- domain contracts;
- common models;
- localization foundations;
- design primitives.

They must not share unrestricted administrative capabilities.

Administrative operations must remain protected server-side.

---

# 11. DATABASE IS A CONTRACT

Never guess the database schema.

Before writing or modifying code that interacts with Supabase:

1. inspect the relevant migration;
2. verify table names;
3. verify column names;
4. verify column types;
5. verify relationships;
6. verify nullable fields;
7. verify constraints;
8. verify RLS policies;
9. verify expected permissions.

Flutter models, repositories, database migrations, and RLS must agree.

Any mismatch must be corrected explicitly.

---

# 12. DATABASE CHANGES MUST USE MIGRATIONS

Never rely on undocumented manual database modifications.

All schema changes must be represented as versioned migrations.

Do not modify historical migrations that may already have been applied unless the task specifically concerns an unreleased clean schema.

Prefer creating a new migration.

Never use destructive reset commands against a remote or production database.

Never run:

```text
DROP DATABASE
```

or destructive equivalent against production.

Never wipe remote data to make migrations easier.

---

# 13. DATABASE SAFETY

Before performing destructive operations such as:

- DROP TABLE;
- DROP COLUMN;
- TRUNCATE;
- mass DELETE;
- destructive type conversion;
- constraint changes capable of deleting data;

first determine whether the operation can cause data loss.

Prefer safe migration patterns:

1. add new structure;
2. migrate data;
3. verify data;
4. switch application reads/writes;
5. remove obsolete structure later.

---

# 14. RLS IS MANDATORY

Client-side permissions are not security.

Every Supabase table exposed to client applications must have appropriate Row Level Security.

Do not solve authorization only with:

```dart
if (user.isAdmin)
```

The database must independently enforce access.

When a client-used table is introduced or modified, verify:

- RLS enabled;
- SELECT rules;
- INSERT rules;
- UPDATE rules;
- DELETE rules;
- ownership rules;
- role/permission rules.

---

# 15. RBAC SOURCE OF TRUTH

Horus must have one canonical authorization system.

Roles and permissions must not diverge across multiple independent representations.

The long-term authorization source of truth is:

```text
role_definitions
user_roles
permissions
role_permissions
```

Legacy role fields must not become a second security authority.

UI role information may be cached or denormalized for presentation, but security decisions must use the canonical authorization system.

---

# 16. PERMISSIONS OVER ROLE CHECKS

For sensitive operations prefer permission checks such as:

```text
students.read
students.update
grades.publish
attendance.manage
courses.manage
finance.read
finance.manage
users.manage_roles
```

instead of hardcoding:

```text
role == dean
```

Roles should grant permissions.

Features should depend on permissions whenever practical.

---

# 17. PRIVILEGED OPERATIONS

Never place Supabase `service_role` credentials inside:

- Flutter;
- Android;
- iOS;
- Web;
- Windows;
- Linux;
- macOS clients.

Privileged operations must use secure server-side execution such as:

- Supabase Edge Functions;
- trusted backend services;
- secure database functions with carefully controlled permissions.

Examples include:

- deleting users;
- assigning privileged roles;
- banning users;
- financial settlement;
- changing payment status;
- administrative bulk actions.

---

# 18. AUTHENTICATION

Authentication logic must remain centralized.

Do not implement different independent authentication mechanisms for individual features.

Never expose secrets.

Never log:

- passwords;
- access tokens;
- refresh tokens;
- service keys;
- private credentials.

Development authentication shortcuts must never become production behavior.

---

# 19. MOCK DATA POLICY

Do not introduce fake production data.

Mocks are allowed only for:

- tests;
- isolated development fixtures;
- explicitly marked prototypes;
- development-only environments.

Mock authentication accounts and prototype content must be guarded against production use.

---

# 20. STRONG TYPING

Avoid unstructured `dynamic` and raw `Map<String, dynamic>` propagation through the application.

Database rows should be mapped into typed DTOs/models.

Domain code should operate on typed entities.

Prefer:

```text
Supabase response
        ↓
DTO
        ↓
Domain model
        ↓
UI state
```

Do not let database JSON structures leak throughout presentation code.

---

# 21. REPOSITORY RESPONSIBILITY

Repositories handle data operations.

They must not contain UI logic.

Widgets must not contain raw Supabase queries unless there is an exceptional documented reason.

Prefer:

```text
UI
↓
Controller / State
↓
Use Case / Application Logic
↓
Repository
↓
Supabase / API
```

---

# 22. BUSINESS LOGIC

Business rules must not be embedded deeply inside UI widgets.

Examples:

- prerequisite validation;
- registration eligibility;
- GPA logic;
- payment eligibility;
- academic standing;
- permissions;
- enrollment limits.

These must live in testable application/domain layers.

---

# 23. STATE MANAGEMENT

Do not introduce a second state-management system casually.

Follow the currently approved project direction.

When migrating state-management architecture, migrate systematically feature by feature.

Do not create a permanent uncontrolled mixture of:

- Riverpod;
- BLoC;
- Provider;
- GetX;
- custom global state.

Any state-management migration must have an explicit plan.

---

# 24. UI CONSISTENCY

Use the shared design system.

Do not hardcode random:

- colors;
- font sizes;
- border radii;
- spacing;
- shadows;
- animation durations.

Reusable design tokens and components should be used.

Pages may have unique layouts while still using common design foundations.

---

# 25. RESPONSIVE DESIGN

Screens must not assume one device size.

Verify layouts for relevant form factors:

- phone;
- tablet;
- desktop;
- web.

Avoid fixed dimensions where responsive constraints are more appropriate.

Administrative dashboards should prioritize desktop and large-screen usability.

---

# 26. LOCALIZATION

User-visible text must use the localization system.

Do not hardcode interface strings into widgets unless explicitly exempted.

Current supported localization infrastructure must remain compatible with:

- Arabic;
- English;
- German;
- Chinese.

Arabic layouts must remain RTL-safe.

---

# 27. ACCESSIBILITY

Interactive controls must remain understandable and usable.

Where relevant:

- provide semantic labels;
- preserve readable contrast;
- support keyboard navigation on desktop/web;
- avoid tiny tap targets;
- handle text scaling;
- avoid conveying status only through color.

---

# 28. NAVIGATION

Routes must be intentional and permission-aware.

Sensitive routes should use deny-by-default principles.

Do not rely only on hiding navigation buttons.

A user manually navigating to a restricted route must still be denied.

Unknown sensitive routes must not automatically become accessible.

---

# 29. ERROR HANDLING

Do not silently swallow exceptions.

Avoid:

```dart
catch (_) {}
```

unless silence is explicitly intentional and documented.

Translate infrastructure failures into controlled application errors.

The UI should receive meaningful states such as:

```text
loading
success
empty
permissionDenied
validationError
networkError
serverError
```

instead of raw Supabase exceptions.

---

# 30. LOGGING

Logging should help debugging without leaking sensitive data.

Never log:

- tokens;
- passwords;
- private keys;
- full national IDs;
- payment credentials;
- sensitive personal records.

Development diagnostics should be disabled or reduced in release builds.

---

# 31. FINANCIAL DATA

Client applications must not be authoritative for payment completion.

A client must never be able to simply set:

```text
invoice.status = paid
```

Payment state must come from trusted backend verification or payment-provider events.

Financial operations require:

- authorization;
- validation;
- auditability;
- idempotency where relevant.

---

# 32. STORAGE

Supabase Storage buckets and policies must be defined and reproducible.

Do not depend on manually configured buckets that are absent from repository infrastructure.

When introducing storage:

- define bucket purpose;
- define ownership;
- define read policy;
- define upload policy;
- define delete policy;
- define size/type restrictions where appropriate.

---

# 33. REALTIME

Realtime subscriptions must have lifecycle management.

Always consider:

- unsubscribe/dispose;
- duplicate subscriptions;
- reconnect behavior;
- filtering;
- authorization;
- unnecessary bandwidth.

Do not subscribe entire large tables when a filtered stream is sufficient.

---

# 34. PERFORMANCE

Avoid premature optimization, but prevent obvious performance problems.

Watch for:

- unnecessary rebuilds;
- repeated database requests;
- N+1 queries;
- oversized realtime subscriptions;
- loading entire tables unnecessarily;
- unbounded lists;
- repeated expensive computations;
- large images without optimization.

Use pagination for potentially large datasets.

---

# 35. SECURITY-SENSITIVE DATA

Personally identifiable and sensitive information must receive special treatment.

Examples:

- national ID;
- phone;
- email;
- academic records;
- warnings;
- payment records;
- authentication information.

Do not expose full profile database rows as a public directory.

Create restricted views/RPCs when public subsets are needed.

---

# 36. TESTING REQUIREMENT

Every meaningful behavior change should include or update tests.

Prioritize tests for:

- authentication;
- permissions;
- route guards;
- registration;
- enrollment;
- grades;
- attendance;
- payments;
- repositories;
- RLS;
- database functions.

Bug fixes should receive regression tests whenever practical.

---

# 37. DATABASE TESTING

RLS and database authorization must be tested as different users.

At minimum consider:

```text
anonymous
student
professor
teaching assistant
department head
dean
registrar
administrator
```

Tests should verify both:

- allowed operations succeed;
- forbidden operations fail.

---

# 38. BUILD VALIDATION

After substantial Flutter changes, run the relevant available checks.

At minimum:

```bash
dart format .
flutter analyze
flutter test
```

When the affected platform requires it, also run an appropriate build.

Examples:

```bash
flutter build web
flutter build apk --debug
```

Do not claim success if checks were not actually run.

If a check cannot be run, clearly report it.

---

# 39. DATABASE VALIDATION

After changing Supabase migrations or database behavior:

- validate migration syntax;
- run local migration/database tests where available;
- verify RLS;
- verify affected queries;
- ensure migration ordering is correct.

Never claim the database is valid solely because Dart compiles.

---

# 40. NO FALSE SUCCESS

Never report:

```text
completed
fixed
working
verified
```

unless the relevant change has actually been implemented and checked.

Use precise language.

Example:

```text
Implemented and verified with flutter analyze and 42 tests.
```

or:

```text
Implemented, but Android build was not run because the Android SDK is unavailable in this environment.
```

---

# 41. NO SECRET MODIFICATIONS

Do not:

- disable tests to obtain green status;
- delete failing tests without justification;
- weaken security checks;
- remove RLS to make queries work;
- bypass validation;
- suppress analyzer errors broadly;
- replace real functionality with mocks.

Fix the root problem.

---

# 42. COMMENTS

Comments should explain why, not restate obvious code.

Avoid excessive comments.

Document:

- non-obvious business constraints;
- security assumptions;
- architectural decisions;
- unusual workarounds.

---

# 43. NAMING

Names must communicate intent.

Avoid generic names such as:

```text
data
stuff
helper2
temp
newFile
managerThing
```

Prefer domain names.

Examples:

```text
EnrollmentRepository
GradePublishingService
StudentRegistrationState
RolePermissionResolver
```

---

# 44. DEAD CODE

Do not retain obsolete duplicate implementations indefinitely.

After a successful migration:

- remove unused imports;
- remove dead code;
- remove abandoned widgets;
- remove obsolete services;
- update documentation.

But never delete code merely because it appears unused without checking references and runtime usage.

---

# 45. DEPENDENCY POLICY

Do not add packages unnecessarily.

Before introducing a dependency:

1. determine whether current dependencies already solve the problem;
2. check maintenance and compatibility;
3. understand platform impact;
4. avoid packages for trivial utilities.

Large architectural dependencies require strong justification.

---

# 46. DOCUMENTATION

Major architecture changes must update relevant documentation.

Documentation must describe the current system, not an aspirational system that does not yet exist.

If implementation and README disagree, correct the documentation as part of the appropriate task.

---

# 47. GIT CHANGE DISCIPLINE

Keep changes logically grouped.

Avoid formatting the entire repository during an unrelated change.

Do not modify generated lockfiles or platform files unless the change actually requires it.

Review the final diff before considering work complete.

Use:

```bash
git diff --check
```

where appropriate.

---

# 48. REFACTORING LARGE FILES

When the task is specifically to split oversized files:

Do not redesign them.

Process each file as follows:

1. understand the file;
2. identify responsibilities;
3. extract cohesive widgets/classes;
4. preserve public API;
5. preserve state behavior;
6. preserve UI appearance;
7. format;
8. analyze;
9. test;
10. compare behavior;
11. continue to the next file.

Do not refactor all files simultaneously without intermediate verification.

---

# 49. CURRENT HIGH-PRIORITY LARGE FILES

The following existing files are known candidates for decomposition:

```text
feed_screen.dart
settings_screen.dart
digital_id_screen.dart
registration_screen.dart
profile_screen.dart
invoices_screen.dart
create_post_screen.dart
professor_dashboard_screen.dart
student_dashboard_screen.dart
```

Exact current paths and sizes must be verified before modification.

Do not assume this list is exhaustive.

Search the repository for additional oversized source files.

---

# 50. CURRENT DATABASE REMEDIATION PRIORITIES

After structural cleanup, high-priority backend work includes:

1. canonical roles and permissions;
2. profile privacy and update restrictions;
3. missing RLS policies;
4. Flutter ↔ SQL schema mismatches;
5. course prerequisite schema;
6. feed schema mismatches;
7. support ticket schema;
8. registration workflow policies;
9. grade write permissions;
10. attendance policies;
11. notification policies;
12. storage buckets and storage RLS;
13. trusted financial workflows;
14. typed repository contracts;
15. database authorization tests.

Do not attempt to hide these problems with client-side workarounds.

---

# 51. KNOWN CONTRACT RISKS

The repository has previously shown schema-contract inconsistencies.

Examples that must be verified before related work:

```text
courses.name vs courses.name_en/name_ar
courses.credits vs courses.credit_hours
course prerequisites
posts.department_id
post_comments.parent_id
shared_files.college_id
support_tickets
department/college name fields
```

Treat these as audit targets, not assumptions.

Check the current repository because they may have been corrected since this file was written.

---

# 52. USER DATA PROTECTION

Never expose sensitive profile fields merely because a user is authenticated.

Public or directory profile interfaces should return only intentionally public fields.

Authorization must distinguish between:

- self;
- public profile;
- teaching staff;
- academic administration;
- privileged administration.

---

# 53. ADMINISTRATION SECURITY

Horus Control must use least privilege.

An administrative user should receive only capabilities required by their permissions.

Being able to access the Control application does not automatically grant unrestricted database access.

Every privileged action should be independently authorized.

Critical operations should create audit records.

---

# 54. AUDITABILITY

Important administrative and financial operations should produce audit events.

Examples:

- role changes;
- account suspension;
- grade publication;
- enrollment overrides;
- payment state changes;
- sensitive record changes.

Audit information should include appropriate actor, action, target, and timestamp without storing unnecessary secrets.

---

# 55. FUTURE MONOREPO DIRECTION

When Horus is split into separate clients, the preferred direction is:

```text
horus/
├── apps/
│   ├── campus/
│   └── control/
│
├── packages/
│   ├── horus_core/
│   ├── horus_auth/
│   ├── horus_models/
│   ├── horus_api/
│   ├── horus_permissions/
│   ├── horus_design_system/
│   ├── horus_localization/
│   └── horus_utils/
│
├── supabase/
├── docs/
└── tooling/
```

Do not migrate to this structure casually during unrelated tasks.

The migration must be performed as a dedicated verified phase.

---

# 56. DO NOT DUPLICATE CAMPUS AND CONTROL LOGIC

When splitting applications:

Do not copy common source files into both apps.

Move genuinely shared functionality into packages.

However, do not put administrative-only functionality in packages shipped unnecessarily to Campus.

Maintain clear security and domain boundaries.

---

# 57. DEFINITION OF DONE

A task is not complete merely because code was written.

Before reporting completion:

- requested behavior exists;
- architecture remains coherent;
- no unrelated behavior was changed;
- formatting passes;
- analyzer passes where applicable;
- relevant tests pass;
- database validation passes when applicable;
- security implications were checked;
- no sensitive data was introduced;
- final diff was reviewed;
- documentation was updated when needed.

---

# 58. FINAL REPORT REQUIREMENT

After completing any substantial task, provide a concise engineering report containing:

## Completed
What was actually changed.

## Files Changed
Important files created, modified, moved, or deleted.

## Architecture
Any structural decisions made.

## Database
Migrations, policies, functions, tables, or contracts affected.

## Security
Security implications and authorization changes.

## Validation
Commands and tests actually executed, including results.

## Remaining Issues
Known relevant issues that were intentionally not included in the task.

Never hide failures or incomplete work.

---

# 59. WHEN UNCERTAIN

Do not invent behavior.

Inspect the repository.

Prefer existing project conventions unless they violate this constitution or the explicit task.

When several valid implementations exist, choose the one with:

1. clearer ownership;
2. lower coupling;
3. stronger typing;
4. easier testing;
5. safer security boundaries;
6. lower long-term maintenance cost.

---

# 60. CORE PRINCIPLE

Every change must leave Horus easier to understand, safer to operate, and easier to extend than it was before.

Do not trade long-term project integrity for short-term convenience.