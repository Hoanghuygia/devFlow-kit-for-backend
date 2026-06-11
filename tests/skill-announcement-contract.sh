#!/usr/bin/env bash
set -euo pipefail

status=0

for skill in skills/*/skill.md; do
  name="$(sed -n 's/^name: //p' "$skill")"

  if ! rg -q --fixed-strings "## Overview" "$skill"; then
    printf 'FAIL: %s is missing Overview\n' "$skill" >&2
    status=1
  fi

  if ! rg -q --fixed-strings "**Announce at start:**" "$skill"; then
    printf 'FAIL: %s is missing start announcement for %s\n' "$skill" "$name" >&2
    status=1
  fi
done

if (( status != 0 )); then
  exit "$status"
fi

printf 'PASS: skill announcement contract\n'
