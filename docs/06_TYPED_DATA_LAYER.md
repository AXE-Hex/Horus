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


# PHASE 6 — TYPED DATA LAYER AND REPOSITORY HARDENING

## Objective

Reduce schema drift and make the Flutter data layer strongly typed.

Do this incrementally.

Do not rewrite the entire app blindly.

## Target architecture

Prefer:

```text
Supabase
↓
Data Source
↓
DTO
↓
Mapper
↓
Domain Entity
↓
Repository Interface
↓
Repository Implementation
↓
Controller / Provider
↓
UI
```

Adapt this to existing feature architecture where appropriate.

## Problems to reduce

Audit and reduce widespread use of:

```dart
Map<String, dynamic>
dynamic
json['column']
```

inside presentation/business code.

Raw database structures should not propagate into screens.

## Priorities

Start with high-risk domains:

1. authentication/profile;
2. courses;
3. registration;
4. grades;
5. attendance;
6. finance;
7. feed;
8. notifications.

## Rules

Do not over-engineer simple static objects.

Keep feature ownership clear.

Do not create one giant generic repository for unrelated domains.

Repository interfaces should reflect domain use cases.

Translate Supabase/Postgres failures into controlled application errors.

## Error model

Create/standardize meaningful states such as:

```text
validation
unauthenticated
forbidden
notFound
conflict
network
server
unknown
```

Presentation should not need to understand raw PostgREST exceptions.

## Testing

Add mapper/model/repository tests.

Test:

- nullability;
- enum mapping;
- date parsing;
- renamed DB fields;
- invalid values;
- permission errors;
- empty results.

## Final report

Include:

- domains migrated;
- raw dynamic usage removed;
- new DTO/entity/repository files;
- remaining dynamic hotspots;
- tests.
