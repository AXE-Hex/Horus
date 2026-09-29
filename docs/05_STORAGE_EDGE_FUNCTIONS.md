# HORUS CODEX REMEDIATION — GLOBAL RULES

> Phase 5 implementation record: see [`STORAGE_ACCESS.md`](STORAGE_ACCESS.md)
> for the bucket contract, Flutter call-site audit, authorization policies,
> payment boundary, and verification limitations.

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


# PHASE 5 — STORAGE + SERVER-SIDE PRIVILEGED OPERATIONS

## Objective

Make Supabase Storage and privileged backend operations reproducible and secure.

## Storage audit

Audit every bucket referenced by Flutter.

Known examples may include:

```text
avatars
post_media
chat_media
```

Verify current usage.

For every required bucket, define infrastructure through migrations/configuration rather than undocumented manual dashboard setup.

Define:

- bucket name;
- public/private status;
- allowed file types;
- maximum size where appropriate;
- path ownership rules;
- SELECT;
- INSERT;
- UPDATE;
- DELETE policies.

## Examples

Avatar uploads should not allow a user to overwrite arbitrary other users' files.

Post media must respect post ownership/moderation rules.

Chat media must be restricted to conversation participants.

## Privileged server operations

Audit client operations that should not directly execute privileged changes.

Candidates may include:

- user administration;
- role assignment;
- account bans;
- verification;
- sensitive academic overrides;
- payment confirmation;
- administrative bulk changes.

Move appropriate operations into secure Supabase Edge Functions or tightly controlled DB RPCs.

Each privileged operation must:

1. authenticate user;
2. resolve permissions server-side;
3. validate input;
4. perform operation;
5. create audit event where appropriate;
6. return controlled errors.

## Secrets

Never place:

```text
service_role
database password
provider secrets
private keys
```

inside Flutter.

## Payments

Client must never be authoritative for:

```text
paid
captured
refunded
```

states.

Prepare trusted backend flow.

Do not integrate a fictional provider.

If no payment provider has been selected, build safe abstractions and leave provider integration explicit and incomplete.

## Validation

Test:

- upload allowed;
- upload denied;
- reading allowed;
- reading denied;
- deletion ownership;
- privileged-function authorization;
- unauthorized invocation.

## Final report

Document:

- buckets;
- policies;
- Edge Functions/RPCs;
- client changes;
- secret requirements;
- payment status architecture;
- tests.
