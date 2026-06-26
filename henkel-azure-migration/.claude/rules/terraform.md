# Terraform Rules

Rules for `**/*.tf` files.

## Variable Usage

- **No hardcoded values.** All resource names, locations, SKUs, and IDs must use variables or data sources.
- Example: ❌ `name = "my-vnet-prod"` → ✅ `name = "${var.environment}-${var.project}-vnet"`

## Resource Tags

Every Azure resource must include these tags:
- `environment` — dev, staging, prod
- `owner` — team or person responsible
- `project` — project name (Henkel, Adesso, etc.)
- `created_by` — "Terraform" or IaC-sourced marker

```hcl
tags = {
  environment = var.environment
  owner       = var.team_owner
  project     = var.project_name
  created_by  = "Terraform"
}
```

## Module Versions

- Always pin module versions with `~>` constraint (allows patch updates, blocks minor/major).
- Example: ✅ `version = "~> 1.2.0"` (allows 1.2.x, blocks 1.3+)
- Never use `version = ">= 1.0"` or omit version.

## Count vs For_each

- Use `for_each` for maps / key-value collections (preferred, clearer state).
- Use `count` only when indices are necessary (rare).

## Provider Version Pinning

Required block must specify Azure provider version:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.70"
    }
  }
}
```

## Secrets & State

- Never store secrets, tokens, or credentials in `.tf` files.
- Use `sensitive = true` on outputs containing passwords.
- Always use Azure Key Vault or environment variables for runtime secrets.
