# Kustomize Rules

Rules for `**/kustomization.yaml` files.

## Base vs Overlays

- Use a single base directory (e.g., `base/`) with complete, standalone manifests.
- Use overlay directories (e.g., `overlays/dev/`, `overlays/prod/`) to override values only.
- ❌ Never duplicate entire resources across overlays.

## Patches & Strategic Merge Patches

- Use `patchesStrategicMerge` for simple field overrides (image tag, replicas, resource limits).
- Use `patchesJson6902` for complex structural changes.
- ❌ Avoid inline patches that duplicate large portions of base resources.

Example:
```yaml
patchesStrategicMerge:
  - |-
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: myapp
    spec:
      replicas: 3  # Override base replicas
```

## Image Transformers

- Use `images:` transformer to update image tags, not manual patches.

```yaml
images:
  - name: myapp
    newTag: "1.2.3"
    newName: "registry.azurecr.io/myapp"
```

## Namespace Override

- Use `namespace:` directive to set namespace for all resources.

```yaml
namespace: production
```

## Validation

- Run `kubectl kustomize .` before every commit to catch rendering errors.
- Build overlays: `kustomize build overlays/prod/` to verify environment-specific output.

## Secrets & ConfigMaps

- Use `configMapGenerator` and `secretGenerator` for dynamic secret/configmap creation.
- ❌ Never embed plaintext passwords or tokens.

```yaml
configMapGenerator:
  - name: app-config
    files:
      - config.yaml
```

## Resource Limits

All resources must include resource limits in the base or overlay:

```yaml
resources:
  requests:
    memory: "128Mi"
    cpu: "100m"
  limits:
    memory: "256Mi"
    cpu: "500m"
```
