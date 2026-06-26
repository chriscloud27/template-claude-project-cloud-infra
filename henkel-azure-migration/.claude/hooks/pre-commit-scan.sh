#!/usr/bin/env bash
set -euo pipefail

# Triggered before git commit / git push
# Scans staged files for common secret patterns
# Blocks and prints matches on hit, silent on clean

SECRETS_FOUND=0

# Patterns to block
declare -a PATTERNS=(
  "password\s*=\s*['\"].*['\"]"
  "api[_-]?key\s*[=:]\s*['\"].*['\"]"
  "secret\s*[=:]\s*['\"].*['\"]"
  "token\s*[=:]\s*['\"].*['\"]"
  "AWS_SECRET_ACCESS_KEY"
  "AZURE_.*_KEY"
  "BEGIN RSA PRIVATE KEY"
  "BEGIN PRIVATE KEY"
)

for pattern in "${PATTERNS[@]}"; do
  if git diff --cached --no-color | grep -iE "$pattern" > /dev/null 2>&1; then
    if [ $SECRETS_FOUND -eq 0 ]; then
      echo "⚠️  Potential secrets detected in staged changes:"
    fi
    echo ""
    echo "Pattern: $pattern"
    git diff --cached --no-color | grep -iE -C 2 "$pattern" || true
    SECRETS_FOUND=$((SECRETS_FOUND + 1))
  fi
done

if [ $SECRETS_FOUND -gt 0 ]; then
  echo ""
  echo "❌ Remove secrets and re-stage before committing"
  exit 1
fi

exit 0
