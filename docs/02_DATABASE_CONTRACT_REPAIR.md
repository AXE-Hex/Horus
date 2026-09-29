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


# PHASE 2 — FLUTTER ↔ SUPABASE SCHEMA CONTRACT REPAIR

Read `/AGENTS.md` and the previous phase report first.

The large-file structural refactor should already be complete.

## Objective

Audit and repair all mismatches between:

```text
Flutter Models
Flutter Repositories
Supabase Queries
SQL Migrations
Database Schema
```

The database contract must become explicit and internally consistent.

## Important

Do not guess schema fields.

Inspect every relevant migration before changing application code.

Do not access the remote database.

Use migrations for schema changes.

## Known audit targets

Verify each against the CURRENT repository before modifying anything.

### Courses

Previously observed differences included:

```text
Flutter:
name
credits
prerequisites

Database:
name_en
name_ar
credit_hours
```

Determine and implement the correct canonical contract.

### Course prerequisites

The application has prerequisite logic.

Verify whether a real database representation exists.

If absent, implement a normalized relationship, preferably conceptually similar to:

```text
course_prerequisites
- course_id
- prerequisite_course_id
- minimum_grade
```

with proper constraints, indexes and RLS planning.

Do not store relational prerequisites as an uncontrolled JSON field unless the existing architecture clearly requires it.

### Colleges / Departments

Audit queries referencing:

```text
name
name_en
name_ar
```

Correct inconsistent queries and mappings.

### Posts

Verify whether Flutter expects:

```text
posts.department_id
```

and whether the database provides it.

Resolve the contract cleanly.

### Post comments

Verify usage of:

```text
post_comments.parent_id
```

If threaded replies are a real product requirement and the column is missing, implement it through a safe migration.

### Shared files

Verify any Flutter query using:

```text
shared_files.college_id
```

against the actual table.

Decide the correct relationship based on current feature behavior.

Do not add redundant columns without architectural justification.

### Support tickets

The application previously referenced:

```text
support_tickets
```

Verify whether the table now exists.

If the feature is active and the table is absent, create a proper schema.

If the feature is obsolete, remove the broken contract only after verifying that behavior is no longer required.

## Repository-wide audit

Do not limit the audit to the known issues.

Search all Flutter Supabase calls such as:

```dart
.from(...)
.select(...)
.insert(...)
.update(...)
.upsert(...)
.delete(...)
```

and compare referenced:

- tables;
- columns;
- relationships;
- enum values;
- RPC functions;

with migrations.

Create/update:

```text
docs/DATABASE_CONTRACT.md
```

Document the canonical contract for client-used tables.

## Strong typing

Where practical during this phase, correct broken mappings rather than spreading fallback expressions throughout UI code.

Avoid introducing more raw schema assumptions.

## Database rules

For new migrations:

- do not edit already-applied historical migrations unless repository state clearly indicates they are unreleased;
- prefer new forward migrations;
- use foreign keys;
- use indexes where relationships require them;
- preserve existing data;
- avoid destructive migration patterns.

## Validation

Run:

```bash
dart format .
flutter analyze
flutter test
git diff --check
```

Also validate SQL/migration syntax using available local tooling.

Do not run against production.

## Final report

Provide:

### Contract mismatches found

A table:

```text
Location | App expected | DB actual | Resolution
```

### Database changes

List every:

- migration;
- table;
- column;
- constraint;
- index;
- function;

changed.

### Flutter changes

Models/repositories updated.

### Unresolved contract questions

Anything that cannot safely be inferred.

### Validation

Exact commands and results.

Do not begin RBAC/RLS redesign in this phase except where required to keep new schema secure.
