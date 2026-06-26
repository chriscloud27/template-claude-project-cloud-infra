#!/usr/bin/env bash
set -euo pipefail

# Triggered on Claude Stop event
# Prints kubectl context and changed files summary
# Always short output — max ~5 lines

echo "── Context ──"

# Current kubectl context
if command -v kubectl &> /dev/null; then
  CONTEXT=$(kubectl config current-context 2>/dev/null || echo "none")
  echo "kubectl context: $CONTEXT"
fi

# Git status: changed files summary
if git rev-parse --git-dir > /dev/null 2>&1; then
  echo ""
  echo "── Changes ──"
  git diff --stat --no-color 2>/dev/null | head -8 || true
fi

exit 0
