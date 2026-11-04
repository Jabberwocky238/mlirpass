#!/bin/bash
# Every feature combination checked alone: std, std + all targets, each target, each dialect, each dialect with all
# targets (`cargo check --lib --no-default-features`). Errors and warnings of each into target/featcheck/<features>.txt,
# a line a combination into target/featcheck/summary.txt.
cd "$(dirname "$0")/.."
out=target/featcheck
rm -rf "$out"; mkdir -p "$out"
dialects=$(sed -n 's/^all-dialects = \[\(.*\)\]/\1/p' Cargo.toml | tr -d '",' | sed 's/dialect\.//g')
combos="std std,all-targets std,target.llvm std,target.spirv std,target.emitc"
for d in $dialects; do combos="$combos std,dialect.$d std,dialect.$d,all-targets"; done
for c in $combos; do
  log=$(cargo check --lib --no-default-features --features "$c" --message-format=short --target-dir target/featcheck-build 2>&1 | grep -E "^src.*(error|warning)")
  e=$(echo -n "$log" | grep -c "error")
  w=$(echo -n "$log" | grep -c "warning")
  echo "$c: $e errors, $w warnings" | tee -a "$out/summary.txt"
  [ -n "$log" ] && echo "$log" > "$out/$c.txt"
done
