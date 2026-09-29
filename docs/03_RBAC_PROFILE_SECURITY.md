# HORUS CODEX REMEDIATION — GLOBAL RULES

Before executing this phase:

- Read `/AGENTS.md` completely.
- Treat `AGENTS.md` as mandatory project policy.
- Inspect the current repository before modifying anything.
- Do not assume that an issue listed in this prompt still exists; verify it first.
- Start work immediately.
- Do not ask for confirmation for normal repository modifications.
- Do not access or modify the remote/production Supabase database.
- Use repository migrations only for database changes.
- Never run destructive remote database commands.
- Never delete user data.
- Preserve existing functionality unless this phase explicitly requires a behavioral correction.
- Do not redesign unrelated UI.
- Do not introduce fake production data.
- Do not disable tests, RLS, linting, or security checks to make the project pass.
- Run verification after each meaningful batch.
- Keep changes scoped to the current phase.
- At the end, provide a detailed engineering report.


# PHASE 3 — RBAC + PROFILE SECURITY REPAIR

Read `/AGENTS.md`, the schema-contract documentation, and previous reports first.

## Objective

Create one consistent authorization architecture and remove dangerous client-side authority.

Focus on:

```text
Roles
Permissions
Profiles
Route authorization
Sensitive account operations
```

Do not redesign UI.

## Canonical authorization model

Audit the current implementation of:

```text
role_definitions
user_roles
permissions
role_permissions
profiles.roles
```

The long-term canonical authorization source must be:

```text
role_definitions
user_roles
permissions
role_permissions
```

`profiles.roles` must not remain an independent security authority.

If it must temporarily exist for compatibility, explicitly treat it as presentation/cache data only.

## Role synchronization

Audit all DB role enum values against Dart.

Previously identified database-only role:

```text
assistant_hod
```

Ensure all supported DB roles map correctly to Flutter.

Never silently map unknown privileged roles to `guest`.

Implement explicit safe handling.

## Permissions

Reduce hardcoded authorization patterns such as:

```dart
role == dean
```

where feature access should instead depend on permissions.

Establish consistent permission identifiers.

Examples:

```text
students.read
students.manage
grades.read
grades.manage
grades.publish
attendance.manage
courses.manage
registration.review
roles.manage
finance.read
finance.manage
```

Use actual project requirements and avoid inventing unnecessary permissions.

## Profiles security

Audit the `profiles` table.

Identify sensitive fields, including where present:

```text
roles
warning_level
is_verified
is_banned
is_active
college_id
department_id
advisor_id
national_id
```

A normal user must not be able to modify security-sensitive or institutional fields simply because the row belongs to them.

Implement a safe update model.

Possible approaches:

- column-level privileges;
- safe RPC;
- dedicated self-service update function;
- restricted writable view;

choose the design that best fits Supabase/Postgres and this project.

Users should only be able to edit explicitly allowed personal fields.

## Profile privacy

Do not expose complete profile records as a public directory.

Create an intentional safe public/staff profile contract where necessary.

Only expose fields required for the feature.

## Route guards

Audit `route_guard.dart` and all protected routes.

Sensitive routes must be deny-by-default.

Do not allow unknown routes merely because no permission mapping exists.

UI hiding is not authorization.

## Authentication development bypass

Audit development/mock login accounts.

Ensure mock authentication cannot operate in release/production configuration.

Use an explicit development/debug gate.

## Privileged actions

Identify client code performing privileged account operations.

Examples:

- changing roles;
- banning/unbanning;
- verification;
- account administration.

Do not embed `service_role` in any client.

Mark or migrate privileged workflows toward server-side execution where appropriate.

## Tests

Add focused tests for:

- role parsing;
- unknown roles;
- multiple roles;
- permissions;
- route guards;
- self-profile editing restrictions;
- privileged profile modifications;
- production blocking of mock auth.

## Validation

Run:

```bash
dart format .
flutter analyze
flutter test
git diff --check
```

Run available local DB authorization tests as well.

## Final report

Include:

- previous authorization architecture;
- new canonical model;
- role mappings;
- permission model;
- profile fields users may self-edit;
- profile fields restricted to privileged operations;
- route-guard changes;
- tests added;
- remaining RBAC work.

Do not proceed to broad RLS completion yet.
