# Local database validation evidence

All commands ran against the Supabase stack bound to loopback. No remote project
was linked or contacted. The final catalog export was taken after a fresh
`npx supabase db reset --local`.

## Rebuild and tests

| Check | Result | Evidence |
| --- | --- | --- |
| Fresh reset and seed | PASS | Replayed 001_reset through 20260929205453 and `supabase/seed.sql` without manual steps. |
| pgTAP | PASS | 8 files, 280 assertions. |
| DB lint | PASS | `npx supabase db lint --local`; no schema errors. |
| Development Auth / Storage HTTP | PASS | All 12 local accounts authenticate; regular student can read seeded rows across 7 campus areas; disallowed MIME, 5 MiB + 1 byte avatar, cross-owner upload and delete are rejected; owner can delete; guest REST profile directory/grades/messages/catalog are empty; anonymous sensitive RPCs fail. |
| Catalog integrity | PASS | Zero violations across nine checked conditions: Auth/profile pairing, invalid RBAC links/codes, duplicate role assignments/permissions, profile affiliation mismatch, orphan messages, and development encryption keys. |
| Staged constraint validation | PASS | Every top-level `NOT VALID` constraint validated in a local transaction and rolled back. |
| Dart analysis | PASS | `dart analyze lib test`; no issues. |
| Flutter tests | PASS | `flutter test --coverage`; 68 tests passed (11.31% coverage). |
| Diff whitespace | PASS | `git diff --check` reports no whitespace errors in the final worktree. |

Each of the 12 seeded accounts has the intended single canonical role and no
expired assignment at reset. The seed provides related fixture rows across
academic, social, registration, finance-read, library, scholarship, online
exam, virtual class, and notification workflows. A REST-level check confirms
a regular student can read seeded rows in seven campus areas while guest access
remains empty for protected resources. These are local test fixtures, not
production data.

## Catalog audit

Generated from `scripts/database/catalog.sql` executed on local PostgreSQL 17.6:

| Measure | Count |
| --- | ---: |
| Logical application tables | 69 |
| Physical partitions | 30 |
| Application views | 1 |
| Application functions (extension-owned excluded) | 29 |
| Triggers (including auth and partition triggers) | 46 |
| Enums | 27 |
| Policies (public relations and Storage) | 246 |
| Physical indexes | 303 |
| Storage buckets | 4 |

The programmatic RLS audit showed every public table/partition had RLS enabled
and forced; `anon` had no table DML. Policies and table grants are exhaustively
listed in [RLS_MATRIX.md](RLS_MATRIX.md). The full relation/function/trigger/
enum/bucket catalog is in [DATABASE_INVENTORY.md](DATABASE_INVENTORY.md).
All 29 application functions have a pinned search path and no PUBLIC/anon
execute grant. The only catalog exception is extension-owned C trigger helper
`public.moddatetime()`, which is non-definer and cannot be called directly; its
ACL belongs to `supabase_admin`, outside the migration role's authority. This
managed-extension boundary is documented in [DATABASE_SECURITY_AUDIT.md](DATABASE_SECURITY_AUDIT.md).

The FK audit found 37 foreign keys without a leading-column supporting index;
there were zero duplicate index definitions. This result is intentionally
retained as a concrete follow-up queue: several missing FK indexes protect
administrative or low-volume paths, while observed feed, notification, advisor,
membership and course paths already have targeted indexes. Add indexes only
after checking real query/delete frequency and write cost.

## Representative `EXPLAIN (ANALYZE, BUFFERS)`

The local-only script inserts 10,000 deterministic notifications across 100
temporary users and 10,000 scoped posts, analyzes, runs queries under
authenticated RLS, then rolls the transaction back.

| Query | Plan | Observed result |
| --- | --- | --- |
| One user’s notifications ordered by `(created_at DESC, id DESC) LIMIT 50` | `idx_notifications_user_page` index scan | 50 rows, 4.151 ms execution, 1,511 shared buffers including authorization helper reads. |
| College/department feed ordered by `(created_at DESC, id DESC) LIMIT 20` | `idx_posts_scope_page` index scan | 20 rows, 1.166 ms execution, 124 shared buffers including profile/scope helpers. |

These are warm local microbenchmarks, not production capacity forecasts. The
notification plan demonstrates the correct bounded index path, while its helper
buffer cost merits observation against larger production role/profile datasets.

## Catalog and integrity scripts

Scripts under `scripts/database/` are local inspection utilities. The catalog
renderer writes documentation snapshots; SQL audits report table grants/RLS,
functions, unindexed foreign keys, duplicate indexes, integrity conditions, and
staged constraint validation. `performance_audit.sql` uses a transaction and
rolls back all synthetic rows. `storage_api_test.py` refuses a non-loopback API
host and does not print JWTs or keys.
