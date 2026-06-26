---
name: code-review
description: Review changed Terraform, Helm, and pipeline files against project rules
---

# Code Review

Checks all changed `.tf`, `Chart.yaml`, `values*.yaml`, and workflow files against the `.claude/rules/` standards. Reports violations before commit.

## Usage

```
/code-review
```

## What it does

1. Finds all changed files in `git diff --name-only`
2. Runs rule checks against each file:
   - **terraform.md rules** on `*.tf` files (hardcoded values, tags, version pinning)
   - **helm.md rules** on Chart.yaml and values files (image tags, resource limits, appVersion sync)
   - **cicd.md rules** on `.github/workflows/` and `azure-pipelines/` (secrets, pinned versions)
   - **kustomize.md rules** on `kustomization.yaml` (patches, images, resources)
3. Reports all violations with file path and line number
4. Blocks commit if violations found (exit 1)

## Examples

✅ Passes:
- All resources have tags (environment, owner, project, created_by)
- Image tags are pinned to versions (no `latest`)
- Resource limits are specified

❌ Fails:
- Hardcoded resource name `my-app-prod`
- Image tag is `latest`
- No resource requests/limits specified
- Secret in env var without GitHub Secrets reference

## Safety

- Read-only — no changes made
- Violations reported before commit
