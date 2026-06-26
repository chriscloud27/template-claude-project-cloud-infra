---
name: deploy-staging
description: Deploy to staging with Terraform plan review and confirmation
---

# Deploy to Staging

Runs a Terraform plan scoped to the staging environment, displays the summary, and asks for confirmation before applying.

## Usage

```
/deploy-staging
```

## What it does

1. Detects Terraform working directory (assumes `terraform/` or similar)
2. Runs `terraform plan -out=tfplan -var-file=staging.tfvars`
3. Displays the plan summary (resource additions, changes, deletions)
4. Prompts for manual approval: "Apply these changes to staging? (yes/no)"
5. If approved: runs `terraform apply tfplan`
6. If rejected: cancels cleanly without changes

## Safety

- Plan is always reviewed before apply
- No auto-approve — requires explicit confirmation
- Logs all changes to workflow transcript
