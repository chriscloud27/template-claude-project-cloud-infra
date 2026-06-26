---
name: cost-estimate
description: Estimate infrastructure costs using infracost for changed Terraform modules
---

# Cost Estimate

Runs Infracost on changed Terraform modules to estimate monthly costs and show cost diff vs current deployment.

## Usage

```
/cost-estimate
```

## Prerequisites

- `infracost` CLI installed and configured
- Terraform modules to have valid provider configuration

## What it does

1. Detects changed `*.tf` files
2. Runs `infracost breakdown` on affected modules
3. Shows monthly cost estimates for new/modified resources
4. Compares vs current state (if state exists)
5. Reports cost impact (cheaper, more expensive, or neutral)

## Example

```
Infracost Breakdown
==================

Deployment: AKS cluster
  - node_pool (Standard_D4s_v3): $XX/month
  - load_balancer: $YY/month
  - storage_account: $ZZ/month
Total: $XXX/month

Change: +$50/month (+5%) vs current deployment
```

## Use case

Before opening a PR with infrastructure changes, check the cost impact. Share the output with stakeholders.

## Safety

- Dry-run only — no changes made
- Requires valid Terraform configuration
