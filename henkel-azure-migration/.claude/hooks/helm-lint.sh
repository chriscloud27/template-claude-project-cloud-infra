#!/usr/bin/env bash
set -euo pipefail

# Triggered after Edit/Write to Chart.yaml or values*.yaml
# Runs: helm lint
# Silent on success, emits only errors

HELM_OUTPUT=$(mktemp)
trap "rm -f $HELM_OUTPUT" EXIT

# Find all Chart.yaml files and lint them
while IFS= read -r chart_file; do
  chart_dir=$(dirname "$chart_file")

  if ! helm lint "$chart_dir" -q > "$HELM_OUTPUT" 2>&1; then
    echo "helm lint failed for $chart_dir:"
    cat "$HELM_OUTPUT"
    exit 1
  fi
done < <(find . -name "Chart.yaml" -type f 2>/dev/null)

exit 0
