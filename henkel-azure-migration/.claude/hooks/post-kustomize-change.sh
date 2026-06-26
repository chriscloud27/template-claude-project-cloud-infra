#!/usr/bin/env bash
set -euo pipefail

# Triggered after Edit/Write to **/kustomization.yaml
# Runs: kubectl kustomize (dry-run to validate rendering)
# Silent on success, emits only errors

KUSTOMIZE_OUTPUT=$(mktemp)
trap "rm -f $KUSTOMIZE_OUTPUT" EXIT

# Find all kustomization.yaml files and validate them
while IFS= read -r kustomize_file; do
  kustomize_dir=$(dirname "$kustomize_file")

  if ! kubectl kustomize "$kustomize_dir" > "$KUSTOMIZE_OUTPUT" 2>&1; then
    echo "❌ Kustomize validation failed for $kustomize_dir:"
    cat "$KUSTOMIZE_OUTPUT"
    exit 1
  fi
done < <(find . -name "kustomization.yaml" -type f 2>/dev/null)

exit 0
