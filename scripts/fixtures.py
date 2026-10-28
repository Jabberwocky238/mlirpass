#!/usr/bin/env python3
"""Regenerates tests/fixtures/ from llvm-project's own mlir tests and a vanilla mlir-opt 22.1.8.

For every kept `// RUN: mlir-opt ...` line of a test file it writes, under tests/fixtures/:

    <name>.mlir             the upstream input (once per file)
    <name>.<k>.args         the mlir-opt arguments, one per line (`%s` dropped)
    <name>.<k>.in.mlir      the input as mlir-opt reads it: parsed and printed generic, no pass run
    <name>.<k>.out.mlir     what mlir-opt prints
    <name>.<k>.generic.mlir the same with --mlir-print-op-generic

`<name>` is the path below mlir/test with `/` turned into `__`. A RUN line is dropped (and listed
in tests/fixtures/SKIPPED with why) when it pipes into a second tool other than FileCheck (or a bare
`mlir-opt`, which only prints back), runs a
test-only `-test-*` pass, or mlir-opt itself fails on it. `-verify-diagnostics` runs are kept:
mlir-opt still prints the chunks that succeed.
"""

import argparse
import shlex
import subprocess
from pathlib import Path

# Conversion targets outside this crate's scope (vendor / runtime specific, see README).
OUT_OF_SCOPE = (
    "AMDGPU", "ROCDL", "NVVM", "NVGPU", "ArmSME", "ArmNeon", "AMX", "XeGPU", "XeVM", "MPI",
    "OpenMP", "OpenACC", "Shard", "Calculet", "VCIX", "GPUToLLVMSPV",
)

def tests(root: Path):
    found = list(root.glob("Conversion/**/*.mlir")) + list(root.glob("Transforms/*.mlir"))
    found += list(root.glob("Dialect/**/canonicalize*.mlir"))
    found += list(root.glob("Dialect/**/mem2reg*.mlir")) + list(root.glob("Dialect/**/sroa*.mlir"))
    # Linalg to loops: convert-linalg-to-{loops,parallel-loops,affine-loops}.
    found += [root / "Dialect/Linalg/loops.mlir", root / "Dialect/Linalg/parallel-loops.mlir", root / "Dialect/Linalg/affine.mlir"]
    # The SPIR-V and GPU dialects whole: their ops, transforms and canonicalization.
    found += list(root.glob("Dialect/SPIRV/**/*.mlir")) + list(root.glob("Dialect/GPU/**/*.mlir"))
    # The x86 CPU dialects: their LLVM lowering (`convert-vector-to-llvm` `enable-x86vector` /
    # `enable-amx`) and the rest of their tests.
    found += list(root.glob("Dialect/X86Vector/*.mlir")) + list(root.glob("Dialect/AMX/*.mlir"))
    for path in sorted(set(found)):
        rel = path.relative_to(root)
        if rel.parts[0] == "Conversion" and any(s in part for part in rel.parts[1:-1] for s in OUT_OF_SCOPE):
            continue
        yield path, rel


def run_lines(text: str):
    """The RUN commands of a file, continuation lines joined."""
    out, cur = [], ""
    for line in text.splitlines():
        line = line.strip()
        if not line.startswith("//") or "RUN:" not in line:
            continue
        body = line.split("RUN:", 1)[1].strip()
        if body.endswith("\\"):
            cur += body[:-1] + " "
            continue
        out.append(cur + body)
        cur = ""
    return out


def args_of(cmd: str):
    """`mlir-opt` arguments of one RUN command, or the reason it is dropped."""
    stages = [s.strip() for s in cmd.split("|")]
    try:
        first = shlex.split(stages[0])
    except ValueError as e:
        return None, f"unparsable RUN line: {e}"
    if not first or first[0] != "mlir-opt":
        return None, f"not mlir-opt: {first[:1]}"
    for later in stages[1:]:
        tool = later.split()[0] if later.split() else ""
        # A bare `mlir-opt` only parses and prints back what the first one printed.
        if later.split() == ["mlir-opt"]:
            continue
        if tool != "FileCheck":
            return None, f"pipes into {tool}"
    args = [a for a in first[1:] if a != "%s"]
    for a in args:
        if a.lstrip("-").startswith("test-") or "-test-" in a:
            return None, f"test-only pass {a}"
        if a.lstrip("-").startswith(LOGS):
            return None, f"prints logs, not IR: {a}"
        if "%" in a:
            return None, f"lit substitution {a}"
    return args, None


# Flags whose output is a log or a dump instead of (only) the resulting IR.
LOGS = ("log-actions", "mlir-print-ir", "mlir-timing", "dump-pass-pipeline", "debug", "mlir-pass-statistics")

# Arguments that change how the input is read, not what is done to it (and every `-mlir-print-*`:
# the input must print the way the output does, locations included).
READING = ("-allow-unregistered-dialect", "--allow-unregistered-dialect", "-split-input-file", "--split-input-file")


def mlir_opt(binary: str, args, input_path: Path, generic: bool):
    extra = ["--mlir-print-op-generic"] if generic else []
    return subprocess.run([binary, *args, *extra, str(input_path)], capture_output=True, text=True, timeout=120)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--llvm", required=True, help="llvm-project checkout at llvmorg-22.1.8")
    ap.add_argument("--mlir-opt", required=True, help="a vanilla mlir-opt 22.1.8")
    ap.add_argument("-o", default=str(Path(__file__).resolve().parent.parent / "tests" / "fixtures"))
    ap.add_argument("--only", action="append", help="regenerate just the tests matching these globs (relative to mlir/test), keeping the rest")
    opts = ap.parse_args()

    root = Path(opts.llvm) / "mlir" / "test"
    out = Path(opts.o)
    out.mkdir(parents=True, exist_ok=True)
    if not opts.only:
        for old in out.glob("*.mlir"):
            old.unlink()
        for old in out.glob("*.args"):
            old.unlink()

    skipped, kept = [], 0
    for path, rel in tests(root):
        if opts.only and not any(rel.match(g) for g in opts.only):
            continue
        name = "__".join(rel.with_suffix("").parts)
        text = path.read_text()
        wrote_input = False
        for k, cmd in enumerate(run_lines(text)):
            args, why = args_of(cmd)
            if args is None:
                skipped.append(f"{name}.{k}\t{why}")
                continue
            custom = mlir_opt(opts.mlir_opt, args, path, False)
            if custom.returncode != 0:
                err = (custom.stderr.strip().splitlines() or ["?"])[0]
                skipped.append(f"{name}.{k}\tmlir-opt failed: {err}")
                continue
            generic = mlir_opt(opts.mlir_opt, args, path, True)
            if generic.returncode != 0:
                skipped.append(f"{name}.{k}\tmlir-opt failed (generic)")
                continue
            reading = mlir_opt(opts.mlir_opt, [a for a in args if a in READING or a.lstrip("-").startswith("mlir-print")], path, True)
            if reading.returncode != 0:
                skipped.append(f"{name}.{k}\tmlir-opt failed (reading the input)")
                continue
            if not wrote_input:
                (out / f"{name}.mlir").write_text(text)
                wrote_input = True
            (out / f"{name}.{k}.args").write_text("".join(a + "\n" for a in args))
            (out / f"{name}.{k}.in.mlir").write_text(reading.stdout)
            (out / f"{name}.{k}.out.mlir").write_text(custom.stdout)
            (out / f"{name}.{k}.generic.mlir").write_text(generic.stdout)
            kept += 1

    with open(out / "SKIPPED", "a" if opts.only else "w") as f:
        f.write("".join(s + "\n" for s in skipped))
    print(f"kept {kept} RUN lines, skipped {len(skipped)} (see {out / 'SKIPPED'})")


if __name__ == "__main__":
    main()
