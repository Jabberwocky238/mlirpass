#!/usr/bin/env python3
"""Generates the feature table of README.md (between `<!-- features -->` and
`<!-- /features -->`): every cargo feature of Cargo.toml, whether the default build has it, and
what it is — for a `dialect.*` / `target.*` feature, what it turns on and the passes it compiles
in, read from src/registry.gen.rs (each pass with the fewest features that register it).

    python3 scripts/features.py           # rewrite the table
    python3 scripts/features.py --check   # fail if it is out of date
"""

import argparse
import itertools
import re
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
README = ROOT / "README.md"
BEGIN, END = "<!-- features -->", "<!-- /features -->"

# What a feature is, for those whose name does not say it: by hand.
WHAT = {
    "std": "the standard library (without it the crate is `no_std` and needs `alloc`), threads (moremath's `ThreadMulti`, the default `Exec`), mlirformat's `std`",
    "cli": "the `mlirpass` command line: `mlir-opt`'s, for the passes this crate has",
    "all-dialects": "every upstream `dialect.*` below (not the GPU instruction sets)",
    "all-targets": "`target.llvm`, `target.emitc` and `target.spirv`",
    "dialect.image": "the images of the GPU instruction sets below (not an upstream dialect)",
    "dialect.rdna2": "AMD RDNA2's instruction set and PM4 command stream, as mlirpass encodes them (not an upstream dialect)",
    "dialect.agx": "Apple AGX (G13)'s instruction set and CDM command stream (not an upstream dialect)",
    "dialect.apple9": "Apple9 (M3 / M4)'s instruction set (not an upstream dialect)",
    "dialect.xe3": "Intel Xe3's instruction set and genxml batches (not an upstream dialect)",
    "target.llvm": "the type converter, dialect → `llvm` (the CPU dialect `x86` too: `convert-vector-to-llvm=enable-x86`), the llvm folds and memory-slot interfaces",
    "target.emitc": "dialect → `emitc`: the EmitC type converter",
    "target.spirv": "target env, type converter, dialect → `spirv`, the spirv dialect's own transforms; `SpirvBinary` (the serializer) and `SpirvGlsl` (GLSL 4.50) emit",
    "target.rdna2": "AMD RDNA2 (gfx1036) machine code without LLVM: `gpu.func` kernels, register allocation, waits, encoding, PM4, the image; checked against llvm-mc and Mesa radv (`tests/rdna2.rs`)",
    "target.agx": "Apple AGX (G13) machine code without LLVM, CDM command streams; checked against Mesa asahi (`tests/agx.rs`)",
    "target.apple9": "Apple9 (M3 / M4) compute kernels without LLVM; checked by running on an M4 through Metal (`scripts/apple9_check.py`, `tests/apple9.rs`)",
    "target.xe3": "Intel Xe3 machine code without LLVM: compute kernels, vertex and fragment shaders through `convert-spirv-entry-points`, genxml batches; checked against Mesa anv and gentool (`tests/xe3.rs`)",
}

FEATURE = re.compile(r'feature = "([^"]+)"')


def features():
    toml = tomllib.loads((ROOT / "Cargo.toml").read_text())
    return toml["features"]


def closure(feats, on):
    """`on` and everything it turns on."""
    out, work = set(), list(on)
    while work:
        f = work.pop()
        if f in out or f not in feats:
            continue
        out.add(f)
        work.extend(x for x in feats[f] if "/" not in x and not x.startswith("dep:"))
    return out


def cfg_eval(expr: str, on: set) -> bool:
    """A `cfg(...)` predicate of features, with `on` on."""
    py = FEATURE.sub(lambda m: repr(m.group(1) in on), expr)
    py = re.sub(r"\ball\(", "_all(", py)
    py = re.sub(r"\bany\(", "_any(", py)
    py = re.sub(r"\bnot\(", "_not(", py)
    return eval(py, {"_all": lambda *a: all(a), "_any": lambda *a: any(a), "_not": lambda a: not a})


def passes(feats):
    """(pass, its cfg or None) from src/registry.gen.rs, in its order."""
    out, cfg = [], None
    for line in (ROOT / "src/registry.gen.rs").read_text().splitlines():
        line = line.strip()
        if m := re.fullmatch(r"#\[cfg\((.*)\)\]", line):
            cfg = m.group(1)
        elif m := re.search(r"p\.register::<[^>]+>\(\); // (\S+)", line):
            out.append((m.group(1), cfg))
            cfg = None
    return out


def needs(feats, cfg):
    """What registers a pass of `cfg`: its home (the first feature every smallest set has; else
    the first named), the others every smallest set needs, and those of which any one does."""
    named = list(dict.fromkeys(FEATURE.findall(cfg)))
    for k in range(1, len(named) + 1):
        sets = [set(c) for c in itertools.combinations(named, k) if cfg_eval(cfg, closure(feats, c))]
        if sets:
            break
    else:
        raise SystemExit(f"no features register `{cfg}`")
    must = set.intersection(*sets)
    # No feature every set has: the pass goes under the first that registers it, the others
    # alternatives to it.
    home = next((f for f in named if f in must), None) or next(f for f in named if f in set.union(*sets))
    either = sorted(set.union(*sets) - must - {home}, key=named.index)
    return home, sorted(must - {home}, key=named.index), either, home in must


def table():
    feats = features()
    default = closure(feats, ["default"])
    by_feature, always = {}, []
    for name, cfg in passes(feats):
        if cfg is None:
            always.append(name)
            continue
        home, must, either, alone = needs(feats, cfg)
        implied = closure(feats, [home])
        rest = [f"`{f}`" for f in must if f not in implied]
        alts = " / ".join(f"`{f}`" for f in either)
        if either and alone:
            rest.append(f"one of {alts}")
        note = ("with " + ", ".join(rest) if rest else "") + ("" if alone or not either else ("; " if rest else "") + f"or with {alts} instead")
        by_feature.setdefault(home, []).append((name, note))
    rows = ["| feature | default | what it is |", "|---|---|---|"]
    order = ["std", "cli", "all-dialects", "all-targets"]
    upstream = sorted(f for f in feats if f.startswith("dialect.") and f in closure(feats, ["all-dialects"]))
    own = sorted(f for f in feats if f.startswith("dialect.") and f not in upstream)
    targets = sorted(f for f in feats if f.startswith("target."))
    for f in order + upstream + own + targets:
        what = WHAT.get(f)
        if what is None:
            what = f"`{f.split('.', 1)[1]}`: its op interfaces, folds and patterns"
        on = [x for x in feats[f] if not x.startswith("dep:") and "/" not in x]
        if on and f not in ("all-dialects", "all-targets", "default"):
            what += "; turns on " + ", ".join(f"`{x}`" for x in on)
        ps = by_feature.get(f, [])
        if ps:
            what += "; passes: " + ", ".join(f"`{n}`" + (f" ({rest})" if rest else "") for n, rest in sorted(ps))
        rows.append(f"| `{f}` | {'yes' if f in default else 'no'} | {what} |")
    rows.append("")
    rows.append("Always compiled in, whatever the features: " + ", ".join(f"`{n}`" for n in sorted(always)) + ".")
    missing = set(feats) - set(order + upstream + own + targets) - {"default"}
    if missing:
        raise SystemExit(f"features with no row: {sorted(missing)}")
    return "\n".join(rows)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--check", action="store_true")
    opts = ap.parse_args()
    text = README.read_text()
    head, rest = text.split(BEGIN, 1)
    _, tail = rest.split(END, 1)
    new = f"{head}{BEGIN}\n{table()}\n{END}{tail}"
    if opts.check:
        if new != text:
            sys.exit("README.md's feature table is out of date: python3 scripts/features.py")
        return
    README.write_text(new)


if __name__ == "__main__":
    main()
