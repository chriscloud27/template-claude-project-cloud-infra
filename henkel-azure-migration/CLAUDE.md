# Project Instructions

Azure Migration project — Infrastructure as Code and deployment automation for a customer's cloud infrastructure migration to Microsoft Azure.

## Key References

- Architecture: `.claude/docs/architecture.md`
- Project context & stakeholders: `.claude/docs/project-context.md`
- Domain glossary: `.claude/docs/glossary.md`
- Decision index & ADR guidelines: `.claude/docs/decisions.md`
- Architecture Decision Records: `.claude/docs/adr/`

## Conventions

- IaC: Terraform / OpenTofu
- Helm for Kubernetes workloads, kustomize for environment overlays
- CI/CD: GitHub Actions or Azure DevOps
- Confirm `terraform plan` / `tofu plan` before any apply
- Never store secrets in code — use Azure Key Vault references or environment variables

## Architecture Decision Records (ADRs)

ADRs live in `.claude/docs/adr/`. Use `0000-template.md` as the base.

**File naming:** next available four-digit prefix + lowercase dash-separated title  
Example: `0002-choose-iac-tooling.md`

**Status values:** `proposed` · `accepted` · `deprecated` · `superseded by [ADR-XXXX](XXXX-title.md)`

**Write an ADR when a decision:**
- Changes or establishes overall architecture (networking, identity, storage, tenancy)
- Chooses between technologies or platforms
- Establishes a pattern all future contributions must follow
- Would be confusing to a new contributor without context
- Explicitly rejects a reasonable alternative

**Do not write one for:** implementation details, bug fixes, or decisions obvious from reading the code.

**To create a new ADR:** copy `0000-template.md`, increment the number, fill in Context / Decision / Consequences, set status to `proposed` or `accepted`. Claude Code can auto-generate the structure—just describe the decision and I'll produce a correctly numbered ADR file.
