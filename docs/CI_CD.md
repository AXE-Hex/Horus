# Horus CI/CD

This document defines the repository automation and deployment model for Horus.

## Goals

- keep generated, temporary, local, and sensitive files out of Git;
- generate Dart/Slang output deterministically in CI;
- validate Flutter code before merge;
- validate Supabase migrations in a local PostgreSQL 17 environment;
- scan for secrets and high/critical dependency issues;
- build supported platforms without committing build artifacts;
- publish tagged releases only from protected production environments;
- deploy Supabase changes only through the production GitHub Environment.

## Workflows

### `.github/workflows/ci.yml`

Runs on pull requests and pushes to `main`.

Checks:

1. repository hygiene;
2. dependency installation;
3. localization/code generation;
4. lockfile stability;
5. formatting;
6. Flutter analyzer;
7. custom lint;
8. tests + coverage;
9. web release build;
10. Android debug build.

### `.github/workflows/database.yml`

Runs only when Supabase files change.

It:

1. installs Supabase CLI 2.118.0;
2. starts the local PostgreSQL 17 database;
3. rebuilds from migrations and seeds;
4. runs database lint;
5. runs local database advisors.

No remote database is modified by this workflow.

### `.github/workflows/security.yml`

Runs Gitleaks and Trivy on PRs, main, weekly, and manually.

### `.github/workflows/platform-builds.yml`

Build verification for Linux, Windows, macOS, and unsigned iOS.

These builds are validation artifacts, not store releases.

### `.github/workflows/release.yml`

Triggered by semantic version tags such as:

```bash
git tag v1.2.0
git push origin v1.2.0
```

The release workflow requires the GitHub `production` Environment and builds:

- production web ZIP;
- signed Android AAB;
- GitHub Release with both artifacts.

Required production secrets:

- `PROD_SUPABASE_URL`
- `PROD_SUPABASE_ANON_KEY`
- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

### `.github/workflows/deploy-supabase.yml`

Applies migrations and deploys Edge Functions after approved changes reach `main`.

Required secrets:

- `SUPABASE_ACCESS_TOKEN`
- `SUPABASE_DB_PASSWORD`
- `SUPABASE_PROJECT_ID`

Configure these on the GitHub `production` Environment and require manual reviewers before deployment.

## Branch protection

Protect `main` and require pull requests.

Recommended required checks:

- `Quality and Tests`
- `Web Build`
- `Android Debug Build`
- `Supabase Migration Validation` when database files change
- `Secret Scan`
- `Dependency and Filesystem Scan`

Disable direct pushes to `main` once the initial CI/CD PR is merged.

## Generated files

Generated Dart files are intentionally not tracked:

- `*.g.dart`
- `*.freezed.dart`
- `*.gr.dart`
- `*.gen.dart`

Run:

```bash
bash tool/generate.sh
```

after cloning and whenever source annotations or translations change.

## Local pre-commit guard

Enable once per clone:

```bash
chmod +x .githooks/pre-commit tool/generate.sh tool/ci/repository_hygiene.sh
git config core.hooksPath .githooks
```

The hook rejects generated sources, environment files, signing material, local properties, build outputs, coverage, and other blocked artifacts.

## Flutter version

CI is pinned to Flutter 3.38.7 because the repository's committed Flutter metadata was created with that stable release.

Upgrade Flutter deliberately by changing the repository metadata and CI version together.

## Supabase version

CI is pinned to Supabase CLI 2.118.0.

The local database major version is PostgreSQL 17.

## Release safety

Release and database production workflows use the GitHub `production` Environment. Configure required reviewers before adding production secrets.

Never commit:

- service role / secret Supabase keys;
- database passwords;
- access tokens;
- Android keystores;
- Apple signing certificates;
- private API keys.

The client may contain a Supabase publishable/anon key at runtime, but production values are injected during build instead of being stored in the repository.
