#!/usr/bin/env dash
# Regenerate tests/rdna2/isa.expected: assemble the LLVM-syntax comment above each op of
# tests/rdna2/isa.mlir with llvm-mc for gfx1036 (wave32), one instruction at a time, as a line of hex.
# LLVM_MC: the llvm-mc to run (default llvm-mc; LLVM 18 or later knows gfx1036).
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
mc=${LLVM_MC:-llvm-mc}
cd "$root"
out=tests/rdna2/isa.expected
: > "$out"
sed -n 's|^// \([a-z].*\)|\1|p' tests/rdna2/isa.mlir | while IFS= read -r line; do
  case "$line" in RDNA2*|Mesa*|mnemonics*) continue ;; esac
  enc=$(printf '%s\n' "$line" | $mc -arch=amdgcn -mcpu=gfx1036 -mattr=+wavefrontsize32 -show-encoding 2>&1 | sed -n 's/.*encoding: \[\(.*\)\]/\1/p')
  [ -n "$enc" ] || { echo "llvm-mc rejected: $line" >&2; exit 1; }
  echo "$enc" | tr -d ' ' | tr ',' ' ' | sed 's/0x//g' >> "$out"
done
wc -l "$out"
