# CI/CD Rules

Rules for `.github/workflows/**` and `azure-pipelines/**` files.

## Secrets & Credentials

- ❌ Never embed secrets, API keys, or tokens in workflow files.
- ✅ Use GitHub Secrets (GitHub Actions) or variable groups (Azure Pipelines).
- ✅ Prefer OpenID Connect (OIDC) over long-lived service principal credentials.

Example (GitHub Actions with OIDC):
```yaml
- uses: azure/login@v1
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

## Action & Tool Versions

- Always pin GitHub Actions to a **commit SHA**, not `@main` or `@v2`.
  - ❌ `uses: actions/checkout@v3`
  - ✅ `uses: actions/checkout@a81bbbf8298c0fa03ea29cdc473d45769f953675` (SHA from release)
- Pin tool versions: `terraform`, `helm`, `kubectl`, `az` CLI.

## Environment Variables

- Do not hardcode sensitive values in `env:` blocks.
- Use GitHub Secrets or Azure Pipelines variable groups for all credentials and tokens.

## Approval Gates

- Add manual approval steps before production deployments.
- Document the approval criteria in the workflow.

## Artifact & State Management

- Upload `terraform plan` output as a workflow artifact for review before apply.
- Never commit `.tfstate` files to the repository.
- Use remote state (Azure Storage Backend) exclusively.

## Logging

- Mask sensitive outputs in logs using `::add-mask::`.
- Example: `echo "::add-mask::${{ secrets.MY_SECRET }}"`

## Notifications

- Integrate with Slack, Teams, or email for deployment notifications.
- Include relevant context: environment, branch, deployment status, approval link.
