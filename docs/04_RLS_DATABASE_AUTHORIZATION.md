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


# PHASE 4 — COMPLETE RLS AND DATABASE AUTHORIZATION

Read `/AGENTS.md`, database-contract documentation, and RBAC implementation first.

## Objective

Complete and test Row Level Security for every client-used table.

RLS must enforce authorization independently of Flutter.

## First action

Generate an inventory of:

```text
All tables
RLS enabled?
SELECT policy?
INSERT policy?
UPDATE policy?
DELETE policy?
Used by client?
Expected roles/permissions?
```

Save/update:

```text
docs/RLS_MATRIX.md
```

## Priority workflows

Pay particular attention to previously incomplete areas:

- grades;
- attendance;
- student registrations;
- student course registrations;
- registration requests;
- registration request courses;
- course sections;
- course sub-sections;
- action plan items;
- notifications;
- posts;
- comments;
- likes;
- conversations;
- messages;
- invoices;
- scholarships;
- library;
- exams.

Verify current repository state first.

## Security principles

Policies must use least privilege.

### Student

Can generally access only their own private academic/financial data.

### Professor / teaching staff

Can access records only for courses/sections they legitimately teach/manage.

### Advisors

Can access assigned advisees according to project requirements.

### Department roles

Must be restricted to their department.

### College leadership

Must be restricted to their college unless a broader permission explicitly exists.

### System-level privileged roles

Use explicit permissions.

Never use a policy equivalent to:

```sql
authenticated = everything
```

simply to make the app work.

## Write policies

Ensure legitimate application operations have matching write policies.

Previously problematic workflows included:

```text
grades upsert
attendance recording
registration workflows
notification updates
```

Verify all repository write operations.

## RLS tests

Create local database authorization tests.

Test at minimum representative personas:

```text
anonymous
student A
student B
professor
teaching assistant
advisor
department head
dean
registrar
```

For each relevant workflow test:

- allowed access succeeds;
- forbidden access fails.

Pay particular attention to cross-user and cross-department access.

## Performance

Avoid expensive unindexed policy predicates.

Add necessary indexes for RLS relationship checks where justified.

## Validation

Run local Supabase/Postgres migrations and tests.

Never use production.

Also run Flutter tests because policies may affect repository assumptions.

## Final report

Return:

### RLS Matrix

Tables and supported operations.

### Policies added/changed

Exact policy names.

### Authorization tests

Allowed and denied cases.

### Indexes added for RLS

If any.

### Remaining tables

Any table intentionally not exposed to clients.

### Validation

Exact commands/results.
