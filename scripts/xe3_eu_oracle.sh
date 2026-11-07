#!/usr/bin/env dash
# Regenerate tests/xe3/eu.expected: assemble the gentool text in the comment above each op of
# tests/xe3/eu.mlir with Mesa's gentool for Panther Lake, one instruction at a time, as a line of hex.
# GENTOOL: how to run gentool (`gentool asm -p ptl`, built from a Mesa tree with -Dtools=intel).
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
gentool=${GENTOOL:?set GENTOOL to the gentool binary}
cd "$root"
out=tests/xe3/eu.expected
: > "$out"
sed -n 's|^// ||p' tests/xe3/eu.mlir | while IFS= read -r line; do
  hex=$(printf '%s\n' "$line" | $gentool asm -p ptl -i - -o - | od -An -tx1 -v | tr -s ' \n' ' ' | sed 's/^ //; s/ $//')
  [ -n "$hex" ] || { echo "gentool rejected: $line" >&2; exit 1; }
  echo "$hex" >> "$out"
done
wc -l "$out"
