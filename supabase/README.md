# Horus UMS Database Architecture

This directory contains the modernized, enterprise-grade database architecture for the Horus University Management System.

## Principles

1. **Modular Migrations**: The schema is broken down into 15 specific bounded contexts (Identity, Academic, Financial, etc.).
2. **Strict Execution Order**: Migrations must be run in numeric order (001 -> 015).
3. **Partitioning**: High-frequency append-only tables (`messages`, `audit_logs`, `analytics_events`, `exam_cheat_events`, `notification_deliveries`) are partitioned by date.
4. **Performance**: All RLS policies use `EXISTS()` instead of `IN (SELECT)`. Role checks leverage JWT claims to bypass database lookups.
5. **Normalization**: 3NF compliant. Free-text fields like `semester` have been migrated to reference tables.
6. **Security**: Audit logging, field-level encryption for sensitive PII, and least-privilege `SECURITY DEFINER` functions.

## Migration Order

1. `001_reset.sql` - Complete schema teardown
2. `002_extensions.sql` - PostgreSQL extensions (pgcrypto, moddatetime)
3. `003_types.sql` - All ENUMs
4. `004_identity.sql` - Profiles, roles, sessions
5. `005_institution.sql` - Colleges, departments, semesters
6. `006_academic.sql` - Courses, sections, schedules
7. `007_registration.sql` - Enrollments, requests
8. `008_grading.sql` - Grades, GPA
9. `009_social.sql` - Feed, groups, forums
10. `010_messaging.sql` - Chat, partitioned messages
11. `011_financial.sql` - Invoices, payments
12. `012_exams.sql` - Online exams, AI similarity
13. `013_library.sql` - Physical and digital library
14. `014_system.sql` - Settings, audit logs, analytics
15. `015_functions_triggers_rls.sql` - All business logic and security policies

## Seed Data

After running all migrations, execute `seeds/001_seed.sql` to populate initial system roles, colleges, and configuration.
