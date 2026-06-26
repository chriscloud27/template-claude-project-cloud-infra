# Helm Rules

Rules for `**/Chart.yaml` and `**/values*.yaml` files.

## Chart Metadata

- `appVersion` must match the container image tag specified in `values.yaml`.
  - Example: if image is `myapp:1.2.3`, then `appVersion: 1.2.3` in Chart.yaml.
- Keep `version` (chart version) independent from app version.

## Image Tags

- ❌ Never use `image.tag: latest` in values files.
- ✅ Always pin image tags to semantic versions: `myapp:1.2.3`, `myapp:v2.0.0-rc1`.
- If using `image.tag: null`, set `image.pullPolicy: Always` to ensure fresh pulls.

## Resource Limits & Requests

Every container must specify **both** `requests` and `limits`:

```yaml
resources:
  requests:
    memory: "128Mi"
    cpu: "100m"
  limits:
    memory: "256Mi"
    cpu: "500m"
```

- Requests inform scheduling and HPA.
- Limits prevent runaway consumption.

## Linting

- Run `helm lint` before every commit.
- Fix warnings and errors reported by the linter.

## Values Organization

- Keep `values.yaml` as the base defaults.
- Use `values-dev.yaml`, `values-staging.yaml`, `values-prod.yaml` for environment overrides.
- Use kustomize or Helm overlays — do not fork entire charts.

## ConfigMap & Secret References

- Use `externalSecrets` or key references for secrets — never embed plaintext in values.
- Prefer Azure Key Vault integration over Kubernetes Secrets for production.
