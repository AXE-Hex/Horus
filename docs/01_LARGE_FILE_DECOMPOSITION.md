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


# PHASE 1 — LARGE FILE DECOMPOSITION

You are working on the Horus Flutter repository.

## Objective

Perform a repository-wide structural refactor of oversized source files.

This phase is **STRUCTURAL ONLY**.

Do not change:

- application behavior;
- UI appearance;
- navigation;
- business logic;
- permissions;
- Supabase queries unless extraction requires moving the exact same code;
- database schema;
- localization text;
- feature behavior.

## File-size policy

Target:

- Prefer files below 400 lines.
- 400–600 lines is acceptable when the file remains cohesive.
- More than 600 lines should normally be decomposed.

Do not mechanically split files merely to satisfy a line count.

Split by responsibility.

## Known large candidates

Verify their current paths and sizes first:

- `feed_screen.dart`
- `settings_screen.dart`
- `digital_id_screen.dart`
- `registration_screen.dart`
- `profile_screen.dart`
- `invoices_screen.dart`
- `create_post_screen.dart`
- `professor_dashboard_screen.dart`
- `student_dashboard_screen.dart`

Also scan the entire repository for other oversized hand-written Dart files.

Exclude generated files.

## Preferred extraction

Extract where appropriate:

- widgets;
- screen sections;
- dialogs;
- bottom sheets;
- forms;
- builders;
- controllers;
- state;
- formatters;
- validators;
- feature-specific utilities.

Keep feature-specific code inside its feature.

Do not move feature-specific code into `core` merely to reduce file size.

## Process

For every oversized file:

1. Read and understand the entire file.
2. Identify responsibilities.
3. Determine extraction boundaries.
4. Refactor incrementally.
5. Preserve public APIs where practical.
6. Preserve state lifecycle.
7. Preserve Riverpod behavior.
8. Preserve UI output.
9. Fix imports.
10. Run formatting.
11. Run analyzer/tests.
12. Continue to the next file only after the current extraction is stable.

Do not refactor all large files simultaneously without intermediate verification.

## Validation

Run at minimum:

```bash
dart format .
flutter analyze
flutter test
git diff --check
```

If existing failures are unrelated to your changes, document them precisely instead of hiding them.

## Final report

Return:

### Completed
Every large file refactored.

### Before / After

For every affected file:

```text
original file:
old line count:
new line count:

extracted files:
- ...
- ...
```

### Behavior

Confirm whether any runtime behavior was intentionally changed.

Expected answer should normally be:

```text
No intentional functional or visual changes.
```

### Validation

Commands executed and exact outcomes.

### Remaining oversized files

Any files still above the project target and why.

Do not start backend/database remediation in this phase.
