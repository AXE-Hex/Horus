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


# PHASE 8 — PRODUCTION-GRADE CI/CD

The Horus remediation phases are complete and the repository should now have a clean baseline.

Read `/AGENTS.md` and all previous reports.

## Objective

Implement a complete CI/CD foundation for Horus.

The pipeline must prevent low-quality, generated, temporary, build and sensitive files from entering releases.

Do not automatically deploy to production databases or app stores without explicit environment configuration.

## Repository hygiene

Audit and strengthen `.gitignore`.

Do not commit:

```text
build/
.dart_tool/
coverage/
IDE caches
logs
temporary files
.env
.env.*
private keys
signing files
local Supabase runtime files
database dumps
generated code that can be reproduced reliably
```

Keep:

```text
.env.example
pubspec.lock
source translations
migrations
configuration
```

Remove tracked generated files from Git only when CI/local build can reliably regenerate them.

Do not delete source files accidentally.

## Generated code policy

If generated files such as:

```text
*.g.dart
*.freezed.dart
Slang generated Dart files
```

are removed from version control:

CI must run their generators before:

```text
analyze
test
build
```

Verify a fresh checkout works.

## GitHub Actions

Create:

```text
.github/workflows/ci.yml
.github/workflows/security.yml
.github/workflows/release.yml
.github/dependabot.yml
```

### CI

On pull requests and pushes to protected development branches:

Run:

```text
checkout
Flutter setup
dependency restore
code generation
format check
flutter analyze
custom lint
unit/widget/integration tests
Supabase migration validation
database tests
RLS tests
Web build
Android build verification
git diff/check cleanliness
```

Use caching appropriately.

Use concurrency cancellation for superseded branch runs.

Use minimum GitHub token permissions.

## Security pipeline

Include appropriate maintained tools for:

- secret scanning;
- dependency/vulnerability scanning;
- repository security checks.

Do not hardcode credentials.

## Release

Releases should be triggered intentionally by version tags such as:

```text
v1.0.0
```

The release job should:

1. rerun required verification;
2. build supported release artifacts;
3. package artifacts;
4. publish GitHub Release assets.

Do NOT configure automatic production Supabase migrations unless a safe explicit production deployment design exists.

Do NOT deploy to Play Store/App Store unless signing and store credentials have been explicitly configured.

## Secrets

Document required GitHub Environment secrets.

Use:

```text
GitHub Environments
development
staging
production
```

where appropriate.

Production deployment must support approval gates.

## Dependabot

Configure dependency update PRs for:

- Dart/Pub;
- GitHub Actions.

Use a controlled schedule and PR limits.

## Git hooks

Add repository hygiene hook/scripts where practical to stop obvious:

- `.env`;
- signing keys;
- generated build output;
- temporary artifacts;

before commit.

Document setup.

## Branch protection documentation

Create documentation describing recommended `main` protection:

Require:

- pull request;
- successful CI;
- successful security checks;
- up-to-date branch if appropriate;
- no force push;
- no deletion.

Do not alter repository administration settings unless tools/permissions explicitly support it and the user has requested it.

## Documentation

Create:

```text
docs/CI_CD.md
```

Document:

- triggers;
- jobs;
- artifacts;
- secrets;
- release flow;
- local commands matching CI;
- failure troubleshooting.

## Fresh checkout verification

The most important final test:

A clean checkout must be able to:

```text
install dependencies
generate code
analyze
test
validate database
build supported targets
```

without relying on untracked local files except intentionally documented secrets.

## Final report

Return:

### Workflows created

### Ignore policy

### Generated-file policy

### Checks enforced

### Security scanning

### Database validation

### Build targets

### Release process

### Required secrets

### Branch protection recommendations

### Exact verification results

Do not claim the CI/CD system is complete until workflow syntax and a fresh-checkout-equivalent path have been validated.
