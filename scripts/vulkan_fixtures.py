#!/usr/bin/env python3
"""Regenerates the Vulkan execution fixtures from llvm-project's mlir/test/Integration/GPU/Vulkan
and a vanilla mlir-opt 22.1.8.

For every test it writes, under tests/fixtures/:

    Integration__GPU__Vulkan__<name>.in.mlir   the test as mlir-opt reads it, generic
    Integration__GPU__Vulkan__<name>.check     its FileCheck lines (`CHECK:` / `CHECK-COUNT-N:`),
                                              and `PIPELINE: <options>` for its runner pipeline

    python3 scripts/vulkan_fixtures.py --llvm $LLVM --bin $LLVM_BUILD/bin
"""

import argparse
import re
import subprocess
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--llvm", required=True)
    ap.add_argument("--bin", required=True, help="directory with mlir-opt 22.1.8")
    ap.add_argument("--out", default=str(Path(__file__).resolve().parent.parent / "tests" / "fixtures"))
    a = ap.parse_args()
    out = Path(a.out)
    for path in sorted((Path(a.llvm) / "mlir/test/Integration/GPU/Vulkan").glob("*.mlir")):
        text = path.read_text()
        generic = subprocess.run([str(Path(a.bin) / "mlir-opt"), "--mlir-print-op-generic", str(path)], capture_output=True, text=True)
        if generic.returncode:
            print(f"skipped {path.name}: {generic.stderr.strip().splitlines()[0]}")
            continue
        stem = f"Integration__GPU__Vulkan__{path.stem}"
        checks = [m.group(0).strip() for m in re.finditer(r"CHECK(-COUNT-\d+)?:.*", text)]
        pipeline = re.search(r"-test-vulkan-runner-pipeline(=\S+)?", text)
        options = pipeline.group(1)[1:] if pipeline and pipeline.group(1) else ""
        (out / f"{stem}.in.mlir").write_text(generic.stdout)
        (out / f"{stem}.check").write_text(f"PIPELINE: {options}\n" + "".join(c + "\n" for c in checks))
        print(f"{stem}: {len(checks)} checks")


if __name__ == "__main__":
    main()
