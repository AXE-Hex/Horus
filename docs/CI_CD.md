# Horus CI/CD

This repository uses GitHub Actions for reproducible Flutter, database, build, and security validation. Workflows use fresh GitHub-hosted Linux runners. No workflow links to, reads from, migrates, or deploys to a remote Supabase project.

## Workflows

### CI — `.github/workflows/ci.yml`

Runs for pull requests targeting `main`, pushes to `main`, and as a reusable verification workflow for tagged releases. Concurrency cancels obsolete runs for the same PR or branch.

- **Flutter Quality** pins Flutter stable `3.44.4` and runs `flutter pub get --enforce-lockfile`, code generation, generated-output drift checks, format verification, `flutter analyze`, `dart run custom_lint`, tests, and coverage. The `lcov.info` report is retained as a 14-day Actions artifact. Coverage is for visibility; there is no percentage gate.
- **Database Validation** installs Supabase CLI `2.118.0`, starts only the local stack, resets from all checked-in migrations, executes all pgTAP tests, lints the local schema, and stops the stack in an always-run step.
- **Build Validation** installs Temurin JDK 17, creates an Android debug APK, and builds Flutter Web release. The Android job uses no production keystore and is not a distributable production build. `android/gradle.properties` does not pin a machine-specific Java path; CI supplies a compatible JDK explicitly.

Web support is enabled with `web/index.html` and `web/manifest.json`, generated from `flutter create --platforms web --no-pub` and updated with Horus metadata. These are the only Flutter platform scaffold files added for Web.

### Security — `.github/workflows/security.yml`

Runs on PRs to `main`, pushes to `main`, weekly, and by manual dispatch. Trivy scans source/config/dependency inputs for secrets, vulnerabilities, and misconfiguration. The raw JSON scan report stays on the ephemeral runner, is never logged or uploaded, and is deleted after processing. The summary prints only rule IDs, package IDs, severity, path, and line; it never prints matched secret content. Critical and high vulnerabilities/misconfigurations and any detected secret fail the check. Local Supabase runtime, build, cache, and coverage directories are excluded.

Dependency Review runs on pull requests for public repositories. For a private repository, set the repository variable `DEPENDENCY_REVIEW_ENABLED=true` only when the repository has the GitHub Advanced Security entitlement required by GitHub. It is otherwise skipped because GitHub does not provide its dependency-review API for unsupported private repositories.

### Release — `.github/workflows/release.yml`

A pushed `v*.*.*` tag first calls the complete reusable CI workflow and security scanner, then builds and attaches a versioned Web archive to a GitHub Release. It does not publish to an app store, deploy a website, or migrate a remote database. Configure the `production` GitHub Environment with required reviewers before enabling release tags.

Android production release signing is intentionally disabled. The repository still uses the placeholder `com.example.horus` application ID and Android's debug signing configuration; these are not safe production release identifiers or credentials.

## Generated Dart files

Generated Dart output remains tracked, including Riverpod `*.g.dart` output and Slang `strings*.g.dart` output. CI regenerates it with:

```sh
dart run build_runner build
dart run slang
```

CI disables the Slang build_runner adapter because it writes duplicate files under `lib/gen/`; Slang is run once through its configured CLI instead. `slang.yaml` disables generated timestamps so output is reproducible. CI fails if generation changes tracked files under `lib/` or creates untracked Dart files there. Do not edit generated output by hand; edit its source and commit the deterministic regenerated files.

## Local verification

Install Flutter stable `3.44.4` and Node/npm. From the repository root:

```sh
bash tool/verify.sh
```

The script enforces the lockfile, regenerates and verifies tracked Dart output, runs format/analyze/custom lint/tests/coverage, then uses `npx supabase@2.118.0` for local-only database reset, pgTAP, and lint. It explicitly invokes `--local` for database commands and does not link or access a remote project. Local database reset discards the local Supabase database volumes for this project; use CI if you do not want to reset local development data.

Equivalent focused commands:

```sh
flutter pub get --enforce-lockfile
dart run build_runner build
dart run slang
dart format --output=none --set-exit-if-changed lib test
flutter analyze
dart run custom_lint
flutter test
flutter test --coverage
flutter build apk --debug
flutter build web --release
npx --yes supabase@2.118.0 start
npx --yes supabase@2.118.0 db reset --local
npx --yes supabase@2.118.0 test db --local
npx --yes supabase@2.118.0 db lint --local
npx --yes supabase@2.118.0 stop
```

`supabase/config.toml` disables seed execution because the schema is created entirely by migrations and the repository has no seed data file.

## Environment and secrets

**Public build-time values:** The existing Horus project URL (`https://reyvrbvdgojpnbecvzwn.supabase.co`) and its Supabase publishable client key are embedded in Flutter Web at build time. They are public client configuration and must be protected by database RLS and Storage policies. For tagged Web releases, configure `SUPABASE_PUBLISHABLE_KEY` as a GitHub Environment **variable** on the `production` environment. `SUPABASE_ANON_KEY` remains a legacy fallback name for existing environments. The release job fails if the key is absent.

**Private secrets:** service-role keys, database passwords, payment provider secrets, signing keystores/passwords, and store publishing credentials are never Flutter build inputs and are not configured in current workflows. Never put them in Dart source, workflow YAML, docs, `.env.example`, or a client bundle.

`AXE_SIG` is also a client-side `String.fromEnvironment` value in this app, so it cannot serve as a private authentication secret. Do not give it server authority.

Future deployment workflows must use separate `development`, `staging`, and `production` GitHub Environments, environment-scoped credentials, required production reviewers, and an explicit deployment design. Current workflows have no remote Supabase credentials and no deployment step.

## Dependency updates

Dependabot checks Pub weekly and GitHub Actions monthly, groups compatible minor/patch updates, and limits open PRs. Updates are reviewed and tested; there is no automatic merge.

## Git hooks

Install the repository's optional hygiene hook once per checkout:

```sh
git config core.hooksPath .githooks
```

The pre-commit hook blocks common `.env`, signing material, build output, coverage, and local Supabase runtime paths. Secret scanning in CI remains authoritative.

## Branch protection

Protect `main` in repository settings. Require a pull request and require successful `Flutter Quality`, `Database Validation`, and `Build Validation` checks. Require the `Horus Security / Secret and Vulnerability Scan` check; also require `Dependency Review` when the repository supports it. Require conversations to be resolved and, if appropriate for the team's merge cadence, require branches to be up to date. Block force pushes and branch deletion. This repository change does not alter GitHub administration settings.

## First-run and release setup

GitHub-hosted Actions must be enabled. For private repositories, confirm the needed entitlement before requiring Dependency Review. Configure branch protection after the first successful CI run so GitHub presents the exact check names. Configure the `production` Environment variables and reviewer gate before tagging a Web release. Android release remains blocked until a canonical application ID and authorized signing/release process exist. iOS/store publishing and remote database migration/deployment are outside the current workflow.
