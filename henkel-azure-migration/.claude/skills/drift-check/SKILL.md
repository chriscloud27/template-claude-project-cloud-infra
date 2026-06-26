---
name: drift-check
description: Detect infrastructure drift between Terraform state and live Azure resources
---

# Drift Check

Runs `terraform plan -detailed-exitcode` to detect any differences between your Terraform state and live infrastructure. Useful for detecting manual changes or configuration drift.

## Usage

```
/drift-check
```

## What it does

1. Initializes Terraform (pulls current state)
2. Runs `terraform plan -detailed-exitcode` on all modules
3. Reports any resources that differ between state and live infra
4. Categorizes: additions, deletions, modifications
5. Suggests remediation: update Terraform or revert manual changes

## Example output

```
Drift detected in resource_group "prod":
  - tags: Manual tag added in Azure Portal
  - location: Matches (no drift)

Recommendation: 
  1. Import manual changes: terraform import azurerm_resource_group.prod /path
  2. Or: Remove manual changes in Azure Portal
```

## Use case

- Weekly drift audits
- Post-incident validation (did manual changes get reverted?)
- Before major Terraform updates

## Safety

- Read-only — no changes made
- Only reports differences
