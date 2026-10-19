#!/usr/bin/env python3
"""Generates src/traits.gen.rs: every upstream op's traits, interfaces and memory effects, from ODS.

The records come from `mlirformat tblgen --dump-json` (byte for byte what `llvm-tblgen --dump-json`
prints), so no LLVM build is needed — only llvm-project's `mlir/include` at llvmorg-22.1.8.

    python3 scripts/traits.py --llvm $LLVM --mlirformat path/to/mlirformat -I $LLVM_BUILD/tools/mlir/include
"""

import argparse
import json
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

# One entry `.td` per dialect (or several when the dialect has no umbrella file).
TDS = [
    "IR/BuiltinOps.td",
    "Dialect/Affine/IR/AffineOps.td",
    "Dialect/Arith/IR/ArithOps.td",
    "Dialect/Async/IR/AsyncOps.td",
    "Dialect/Bufferization/IR/BufferizationOps.td",
    "Dialect/Complex/IR/ComplexOps.td",
    "Dialect/ControlFlow/IR/ControlFlowOps.td",
    "Dialect/EmitC/IR/EmitC.td",
    "Dialect/Func/IR/FuncOps.td",
    "Dialect/GPU/IR/GPUOps.td",
    "Dialect/Index/IR/IndexOps.td",
    "Dialect/Linalg/IR/LinalgOps.td",
    "Dialect/Linalg/IR/LinalgStructuredOps.td",
    "Dialect/Linalg/IR/LinalgRelayoutOps.td",
    "Dialect/LLVMIR/LLVMOps.td",
    "Dialect/LLVMIR/LLVMIntrinsicOps.td",
    "Dialect/Math/IR/MathOps.td",
    "Dialect/MemRef/IR/MemRefOps.td",
    "Dialect/MLProgram/IR/MLProgramOps.td",
    "Dialect/PDL/IR/PDLOps.td",
    "Dialect/PDLInterp/IR/PDLInterpOps.td",
    "Dialect/Ptr/IR/PtrOps.td",
    "Dialect/SCF/IR/SCFOps.td",
    "Dialect/Shape/IR/ShapeOps.td",
    "Dialect/SPIRV/IR/SPIRVOps.td",
    "Dialect/Tensor/IR/TensorOps.td",
    "Dialect/Tosa/IR/TosaOps.td",
    "Dialect/Tosa/IR/TosaUtilOps.td",
    "Dialect/Tosa/IR/TosaShapeOps.td",
    "Dialect/UB/IR/UBOps.td",
    "Dialect/Vector/IR/VectorOps.td",
]

EFFECTS = {"Read": "Read", "Write": "Write", "Allocate": "Allocate", "Free": "Free"}


def dump(mlirformat: str, include: Path, extra: list, td: str):
    dirs = [a for i in [include, *extra] for a in ("-I", str(i))]
    out = subprocess.run([mlirformat, "tblgen", "--dump-json", str(include / td), *dirs], capture_output=True, text=True)
    if out.returncode != 0:
        raise SystemExit(f"{td}: {out.stderr.strip()}")
    return json.loads(out.stdout)


class Records:
    def __init__(self, d):
        self.d = d

    def native(self, trait: str) -> str:
        """`::mlir::OpTrait::SingleBlockImplicitTerminator<"YieldOp">::Impl` ⇒ `SingleBlockImplicitTerminator`."""
        base = trait.split("<", 1)[0]
        for suffix in ("::Impl", "::Trait"):
            base = base.removesuffix(suffix)
        return base.rsplit("::", 1)[-1]

    def interface(self, rec, out: set):
        out.add(rec["cppInterfaceName"])
        for base in rec.get("baseInterfaces", []) or []:
            self.interface(self.d[base["def"]], out)

    def effect(self, rec, on: str, out: list):
        kind = EFFECTS[rec["effect"].rsplit("::", 1)[-1]]
        resource = rec["resource"].rsplit("::", 1)[-1]
        out.append((kind, on, resource))

    def traits(self, refs, traits: set, effects: list, flags: dict):
        for ref in refs:
            rec = self.d[ref["def"]]
            sup = rec["!superclasses"]
            if "TraitList" in sup:
                self.traits(rec["traits"], traits, effects, flags)
                continue
            if "SideEffectsTraitBase" in sup or "MemoryEffects" in sup:
                flags["effects"] = True
                for e in rec.get("effects", []):
                    self.effect(self.d[e["def"]], "Op", effects)
                continue
            if "cppInterfaceName" in rec:
                self.interface(rec, traits)
                continue
            if "NativeTrait" in sup and rec.get("trait"):
                traits.add(self.native(rec["trait"]))

    def decorated(self, dag, kind: str, effects: list, flags: dict):
        for i, (arg, _name) in enumerate((dag or {}).get("args", [])):
            rec = self.d.get(arg["def"]) if isinstance(arg, dict) else None
            for dec in (rec or {}).get("decorators", []) or []:
                drec = self.d[dec["def"]]
                if "MemoryEffect" in drec["!superclasses"]:
                    flags["effects"] = True
                    self.effect(drec, f"{kind}({i})", effects)

    def inherent(self, dag):
        """The op's attribute and property arguments: what lives in `<{...}>`."""
        out = []
        for arg, name in (dag or {}).get("args", []):
            rec = self.d.get(arg["def"]) if isinstance(arg, dict) else None
            sup = (rec or {}).get("!superclasses", [])
            if "TypeConstraint" not in sup and ("Attr" in sup or "AttrConstraint" in sup or "Property" in sup):
                out.append(name)
        return out

    def ops(self):
        for name in self.d["!instanceof"].get("Op", []):
            rec = self.d[name]
            dialect = self.d[rec["opDialect"]["def"]]["name"]
            traits, effects, flags = set(), [], {"effects": False}
            self.traits(rec["traits"], traits, effects, flags)
            self.decorated(rec.get("arguments"), "Operand", effects, flags)
            self.decorated(rec.get("results"), "Result", effects, flags)
            yield f"{dialect}.{rec['opName']}", traits, effects if flags["effects"] else None, self.inherent(rec.get("arguments"))


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--llvm", required=True)
    ap.add_argument("--mlirformat", required=True)
    ap.add_argument("-I", dest="extra", action="append", default=[], help="more include dirs: a build's tools/mlir/include holds Linalg's yamlgen.td")
    ap.add_argument("-o", default=str(Path(__file__).resolve().parent.parent / "src" / "traits.gen.rs"))
    opts = ap.parse_args()
    include = Path(opts.llvm) / "mlir" / "include" / "mlir"

    with ThreadPoolExecutor() as pool:
        dumps = list(pool.map(lambda td: dump(opts.mlirformat, include.parent, opts.extra, f"mlir/{td}"), TDS))
    ops = {}
    for d in dumps:
        for name, traits, effects, inherent in Records(d).ops():
            ops[name] = (traits, effects, inherent)

    names = sorted({t for traits, _, _ in ops.values() for t in traits})
    lines = [
        "//! Generated by `scripts/traits.py` from llvm-project `llvmorg-22.1.8` ODS; do not edit.",
        "",
        "use super::{Effect, EffectKind, EffectOn, Effects, OpInfo};",
        "",
        "traits! {",
        *(f"    {n}," for n in names),
        "}",
        "",
        "/// Every op, sorted by name.",
        "pub const OPS: &[OpInfo] = &[",
    ]
    for name in sorted(ops):
        traits, effects, inherent = ops[name]
        ts = ", ".join(f"Trait::{t}" for t in sorted(traits))
        if effects is None:
            eff = "Effects::Unknown"
        else:
            def on(o):
                return "EffectOn::Op" if o == "Op" else "EffectOn::" + o
            es = ", ".join(f"Effect {{ kind: EffectKind::{k}, on: {on(o)}, resource: \"{r}\" }}" for k, o, r in effects)
            eff = f"Effects::Known(&[{es}])"
        attrs = ", ".join(f'"{a}"' for a in inherent)
        lines.append(f"    OpInfo {{ name: \"{name}\", traits: &[{ts}], effects: {eff}, inherent: &[{attrs}] }},")
    lines.append("];")
    Path(opts.o).write_text("\n".join(lines) + "\n")
    print(f"{len(ops)} ops, {len(names)} traits and interfaces")


if __name__ == "__main__":
    main()
