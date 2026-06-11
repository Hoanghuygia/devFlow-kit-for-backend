---
name: database-schema-doc
description: Generate project-root SCHEMA.md from migration files first, then fall back to a live database. Use when asked to document the current database schema or create/update SCHEMA.md. Prefer Flyway, Liquibase, or equivalent SQL migration folders/files if present; if no migration source exists, query the live database via MCP postgres. If the database cannot be reached, stop and tell the user no schema could be created.
---

# Database Schema Doc

## Overview

**Announce at start:** "I'm using the `database-schema-doc` skill to create `SCHEMA.md`."

## Workflow

1. Find migration sources first.
   - Check common locations such as `db/migration`, `flyway`, `liquibase`, `migrations`, `src/main/resources/db/migration`, and migration files like `V*.sql`, `*.sql`, `schema.sql`.
   - If multiple migration systems exist, use the one the project actually applies.
   - If a migration source exists, treat it as the primary source of truth for this run.

2. Build the schema from migrations when present.
   - Extract tables, columns, primary keys, unique constraints, foreign keys, defaults, nullability, comments, enums, and check constraints when they are encoded in the migrations.
   - Keep table and column names exactly as the migrations define them.
   - Do not invent fields that are not supported by the migration source.

3. If no usable migration source exists, query the live database.
   - Use `mcp__postgres.query` to read the current database metadata.
   - If the database connection fails, credentials are missing, or the database cannot be reached, stop and tell the user that `SCHEMA.md` could not be created.

4. Write `<project-root>/SCHEMA.md`.
   - Use DBML-style blocks:

```text
Table users {
  id              BIGSERIAL   [pk]
  role            VARCHAR     [note: 'ADMIN, ARTIST, CUSTOMER']
  email           VARCHAR     [unique, note: 'nullable']
  customer_id     BIGINT      [ref: - customer_profiles.id]
  version         INT         [default: 0]
  is_deleted      BOOLEAN     [default: false]
  created_at      BIGINT
}
```

   - Keep one table block per table in stable order.
   - Align column name and type columns for readability.
   - Add `[pk]`, `[unique]`, `[default: ...]`, `[ref: ...]`, and `[note: ...]` only when supported by the source.

5. Verify the artifact.
   - Re-open `SCHEMA.md` after writing.
   - Confirm the file contains no TODO/TBD placeholders.
   - Confirm every table and column is supported by migration data or live database metadata.

## Failure Behavior

If there is no migration source and no reachable live database, stop and report that the schema file could not be generated. Do not guess.
