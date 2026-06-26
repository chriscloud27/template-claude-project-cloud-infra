#!/usr/bin/env bash
set -euo pipefail

# Triggered after Edit/Write to *.tf files
# Runs: terraform fmt, terraform validate
# Silent on success, emits only errors

TF_OUTPUT=$(mktemp)
trap "rm -f $TF_OUTPUT" EXIT

# terraform fmt (check without modifying)
if ! terraform fmt -check -no-color -recursive . > "$TF_OUTPUT" 2>&1; then
  echo "terraform fmt issues found:"
  cat "$TF_OUTPUT"
  exit 1
fi

# terraform validate
if ! terraform validate -no-color > "$TF_OUTPUT" 2>&1; then
  echo "terraform validate failed:"
  cat "$TF_OUTPUT"
  exit 1
fi

exit 0
