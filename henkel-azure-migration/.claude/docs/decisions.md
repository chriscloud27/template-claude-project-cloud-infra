# Decisions

Architecture decisions are recorded as ADRs (Architecture Decision Records) in [`.claude/docs/adr/`](adr/).

Use [`0000-template.md`](adr/0000-template.md) as the starting point for every new ADR.

## Naming & Format

- **Filename:** `XXXX-kebab-case-title.md` (e.g. `0001-adopt-adr-system.md`)
- **Status:** proposed · accepted · deprecated · superseded by [ADR-XXXX](XXXX-title.md)

## When to write an ADR

Write one when a decision:
- Changes or establishes overall architecture (networking, identity, storage, tenancy)
- Chooses between technologies or platforms
- Establishes a pattern all future code must follow
- Would be confusing to a new contributor without context
- Explicitly rejects a reasonable alternative

Do **not** write one for implementation details, bug fixes, or decisions obvious from reading the code.

See `CLAUDE.md` for full ADR authoring guidelines and how Claude Code auto-generates new ADRs.
