#!/usr/bin/env bash
set -euo pipefail

# Triggered before git push
# Warns if a .tf or Chart.yaml file was changed but no new ADR was added in the same commit

TF_CHANGED=$(git diff --cached --name-only --no-color | grep -c '\.tf$' || true)
HELM_CHANGED=$(git diff --cached --name-only --no-color | grep -c 'Chart\.yaml\|values.*\.yaml' || true)
ADR_CHANGED=$(git diff --cached --name-only --no-color | grep -c '\.claude/docs/adr/[0-9]*-' || true)

# If Terraform or Helm changed but no ADR added, warn but don't block
if [[ $((TF_CHANGED + HELM_CHANGED)) -gt 0 ]] && [[ $ADR_CHANGED -eq 0 ]]; then
  echo "⚠️  Warning: Infrastructure code changed but no ADR was created."
  echo ""
  echo "Changed files:"
  git diff --cached --name-only --no-color | grep -E '\.tf$|Chart\.yaml|values.*\.yaml' || true
  echo ""
  echo "Consider: Did this decision warrant an ADR?"
  echo "  - If YES: create one with /adr-new and amend this commit"
  echo "  - If NO: proceed with push (this is just a reminder)"
  echo ""
fi

exit 0
