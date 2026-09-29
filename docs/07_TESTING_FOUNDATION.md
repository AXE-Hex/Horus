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


# PHASE 7 — TESTING FOUNDATION

## Objective

Build a meaningful automated testing foundation before CI/CD becomes a merge gate.

Current test coverage is insufficient.

## Required test layers

### Unit tests

Focus on:

- models;
- mappers;
- validators;
- permission resolver;
- role handling;
- registration rules;
- GPA/academic calculations;
- repository logic.

### Widget tests

Focus on important states:

```text
loading
success
empty
error
permission denied
```

### Navigation tests

Verify:

- student cannot open administrative routes;
- incorrect roles are rejected;
- permissions affect route access.

### Repository/integration tests

Test key application workflows with controlled test doubles or local Supabase where suitable.

### Database tests

Test:

- migrations;
- constraints;
- functions;
- RLS;
- RBAC;
- ownership;
- cross-user denial.

## Highest priority user journeys

Build coverage around:

1. sign in/session restore;
2. profile loading;
3. student course registration;
4. registration approval;
5. attendance;
6. grade entry/publishing;
7. notifications;
8. feed post/comment actions;
9. invoice visibility;
10. administrative permission checks.

## Regression tests

For every bug fixed during previous phases, add a regression test where practical.

## Quality rule

Do not write meaningless tests just to increase count.

A test should protect behavior or security.

Do not modify production behavior merely to make tests easier unless the change improves architecture.

## Final report

Return:

- number of test files before/after;
- test categories;
- important scenarios covered;
- known untested areas;
- total tests;
- pass/fail results.

The repository should reach a stable green baseline before the next phase.
