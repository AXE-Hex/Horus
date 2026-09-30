# Horus local database

`supabase/migrations/` is the only authoritative schema evolution path. Replay
all files in CLI version order, including timestamped repairs after `001`–`015`.
Historical migrations are immutable; fixes belong in a new forward migration.
`001_reset.sql` is a legacy destructive bootstrap: never execute it manually on
an established environment or replay it against production.

```sh
npx supabase start
npx supabase db reset --local
npx supabase test db --local
npx supabase db lint --local --fail-on warning
```

`config.toml` loads only `seed.sql`, strictly for local development. It creates
twelve canonical test accounts, a deterministic institution, and synthetic
linked records for the main academic and campus workflows. Canonical roles
and permissions are seeded by migrations, not by development fixtures. Never
run this seed on staging/production. Credentials: [development accounts](../docs/DEVELOPMENT_ACCOUNTS.md).

The unconsumed `all_migrations.sql` concatenation and obsolete
`seeds/001_seed.sql` were removed during the September 2026 audit. The latter
contained dummy encryption keys and was incorrectly recommended by this README.
Their removal changes no applied migration history or operational database rows.

Security boundaries, live catalog inventory, and reproducible read-only audit
commands are documented in [database security audit](../docs/DATABASE_SECURITY_AUDIT.md),
[inventory](../docs/DATABASE_INVENTORY.md), [RLS matrix](../docs/RLS_MATRIX.md), and
[Storage contract](../docs/STORAGE_ACCESS.md). SQL audit scripts under
`scripts/database/` target a local reset database only. No remote deployment,
provider payment verification, or custom encryption safety is implied.
