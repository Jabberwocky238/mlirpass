#!/usr/bin/env python3
"""Regenerates the SPIR-V serialization fixtures from llvm-project's mlir/test/Target/SPIRV and a
vanilla mlir-opt / mlir-translate 22.1.8.

For every chunk (`// -----`) of every test file that serializes (`--serialize-spirv` or
`--test-spirv-roundtrip` on a RUN line) it writes, under tests/fixtures/:

    Target__SPIRV__<name>.<k>.in.mlir   the chunk as mlir-opt reads it: parsed and printed generic
    Target__SPIRV__<name>.<k>.spv       what `mlir-translate --serialize-spirv` writes for it

A chunk mlir-translate does not serialize (one that expects a diagnostic) is skipped.
"""

import argparse
import subprocess
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--llvm", required=True, help="llvm-project checkout")
    ap.add_argument("--bin", required=True, help="directory with mlir-opt and mlir-translate 22.1.8")
    ap.add_argument("--out", default=str(Path(__file__).resolve().parent.parent / "tests" / "fixtures"))
    a = ap.parse_args()
    root = Path(a.llvm) / "mlir" / "test" / "Target" / "SPIRV"
    out = Path(a.out)
    opt, translate = Path(a.bin) / "mlir-opt", Path(a.bin) / "mlir-translate"
    kept = skipped = 0
    for path in sorted(root.glob("*.mlir")):
        text = path.read_text()
        runs = [l for l in text.splitlines() if l.startswith("// RUN:")]
        if not any("serialize-spirv" in l or "test-spirv-roundtrip" in l for l in runs):
            continue
        for k, chunk in enumerate(text.split("// -----")):
            if "expected-error" in chunk:
                skipped += 1
                continue
            stem = f"Target__SPIRV__{path.stem}.{k}"
            spv = subprocess.run([translate, "--no-implicit-module", "--serialize-spirv", "-o", "-"], input=chunk.encode(), capture_output=True)
            generic = subprocess.run([opt, "--no-implicit-module", "--mlir-print-op-generic"], input=chunk.encode(), capture_output=True)
            if spv.returncode or generic.returncode or not spv.stdout:
                skipped += 1
                continue
            (out / f"{stem}.in.mlir").write_bytes(generic.stdout)
            (out / f"{stem}.spv").write_bytes(spv.stdout)
            kept += 1
    print(f"{kept} chunks kept, {skipped} skipped")


if __name__ == "__main__":
    main()
