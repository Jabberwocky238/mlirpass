#!/usr/bin/env python3
"""Generates src/emits/spirv/tables.gen.rs from the SPIR-V dialect's ODS (llvm-project 22.1.8), as
`mlir-tblgen -gen-spirv-serialization` and `-gen-enum-decls` read it:

* every SPIR-V enum: its cases and values, whether it is a bit enum, and the attribute mnemonics
  (`#spirv.storage_class<...>`) that carry it;
* every `SPIRV_Op` that serializes: its opcode (or extended instruction set and number), its
  operand groups, and its arguments in definition order, each an operand group or an attribute
  with how the attribute serializes (`emitAttributeSerialization`).

    python3 scripts/spirv_tables.py --llvm $LLVM --mlirformat path/to/mlirformat
"""

import argparse
import re
import json
import subprocess
from pathlib import Path

# `constantIdEnumAttrs` in SPIRVUtilsGen.cpp: these enums serialize as the <id> of an i32 constant.
CONSTANT_ID = {"SPIRV_ScopeAttr", "SPIRV_KHR_CooperativeMatrixUseAttr", "SPIRV_KHR_CooperativeMatrixLayoutAttr", "SPIRV_MemorySemanticsAttr", "SPIRV_MatrixLayoutAttr"}


def load(llvm: Path, mlirformat: str):
    td = llvm / "mlir/include/mlir/Dialect/SPIRV/IR/SPIRVOps.td"
    out = subprocess.run([mlirformat, "tblgen", "--dump-json", "-I", str(llvm / "mlir/include"), str(td)], capture_output=True, check=True)
    # Records only (the dump also lists `!instanceof` and `!tablegen_json_version`).
    return {k: v for k, v in json.loads(out.stdout).items() if isinstance(v, dict)}


def val(v):
    """A record field: the dump writes plain JSON values."""
    return v


def supers(rec):
    return val(rec.get("!superclasses", "[]"))


def avail(d, rec):
    """`Avail { .. }` of a record's `availability` list (`SPIRVAvailability.td`)."""
    lo = hi = None
    exts, caps = [], []
    for a in rec.get("availability") or []:
        r = d[a["def"]]
        sc = supers(r)
        if "MinVersion" in sc:
            lo = int(r["instance"].rsplit("_", 1)[1])
        elif "MaxVersion" in sc:
            hi = int(r["instance"].rsplit("_", 1)[1])
        elif "Extension" in sc:
            exts.append(re.findall(r"Extension::(\w+)", r["instancePreparation"]))
        elif "Capability" in sc:
            caps.append(re.findall(r"Capability::(\w+)", r["instancePreparation"]))
    groups = lambda gs: "&[" + ", ".join("&[" + ", ".join(rust_str(x) for x in g) + "]" for g in gs if g) + "]"
    opt = lambda v: f"Some({v})" if v is not None else "None"
    return f"Avail {{ min: {opt(lo)}, max: {opt(hi)}, exts: {groups(exts)}, caps: {groups(caps)} }}"


def rust_str(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def enums(d):
    """(class, bits, [(case, value)]) of every SPIR-V enum, and attr mnemonic -> class."""
    out = {}
    for name, rec in d.items():
        sc = supers(rec)
        if "EnumInfo" not in sc or val(rec.get("cppNamespace")) != "::mlir::spirv":
            continue
        cases = []
        for c in val(rec["enumerants"]):
            cr = d[c["def"]]
            implies = [d[i["def"]]["str"] for i in cr.get("implies") or []]
            cases.append((val(cr["str"]), int(val(cr["value"])), avail(d, cr), implies))
        out[val(rec["className"])] = ("BitEnumBase" in sc, cases)
    mnemonics = {}
    for name, rec in d.items():
        sc = supers(rec)
        if "EnumAttr" in sc and val(rec.get("attrName", "")).startswith("spirv."):
            enum = d[val(rec["enum"])["def"]]
            mnemonics[val(rec["mnemonic"])] = val(enum["className"])
    return out, mnemonics


def attr_class(d, rec_name):
    """The enum class an (optional) enum attribute carries, if any."""
    rec = d[rec_name]
    if rec.get("baseAttr") and ("OptionalAttr" in supers(rec) or "DefaultValuedAttr" in supers(rec)):
        return attr_class(d, rec["baseAttr"]["def"])
    if "EnumAttr" in supers(rec) and rec.get("enum"):
        return d[rec["enum"]["def"]].get("className")
    return None


def attr_kind(d, rec_name):
    """How `emitAttributeSerialization` writes an attribute of def `rec_name`."""
    rec = d[rec_name]
    sc = supers(rec)
    if "OptionalAttr" in sc or "DefaultValuedAttr" in sc or "DefaultValuedOptionalAttr" in sc:
        return attr_kind(d, val(rec["baseAttr"])["def"])
    # `Attribute::getAttrDefName`: an anonymous attribute is named by its base.
    def_name = rec_name
    while d[def_name].get("!anonymous") and d[def_name].get("baseAttr"):
        def_name = d[def_name]["baseAttr"]["def"]
    if def_name in CONSTANT_ID:
        return "ConstId"
    if "SPIRV_BitEnumAttr" in sc or "SPIRV_I32EnumAttr" in sc:
        return "Enum"
    if def_name == "I32ArrayAttr":
        return "I32Array"
    if def_name == "I32Attr":
        return "I32"
    if "EnumAttrInfo" in sc or "TypeAttrBase" in sc:
        return "Type"
    return None


def ops(d, opcodes):
    out = []
    for name, rec in sorted(d.items()):
        sc = supers(rec)
        if "SPIRV_Op" not in sc:
            continue
        ext = "SPIRV_ExtInstOp" in sc
        mlir_name = "spirv." + val(rec["opName"])
        groups, args = [], []
        n_attrs = 0
        for a in val(rec["arguments"])["args"]:
            ref, arg_name = a[0]["def"], a[1]
            asc = supers(d[ref])
            if "TypeConstraint" in asc:
                kind = "Variadic" if "Variadic" in asc else "Optional" if "Optional" in asc else "One"
                args.append(f"Arg::Operands({len(groups)})")
                groups.append(f"Group::{kind}")
            else:
                n_attrs += 1
                k = attr_kind(d, ref)
                cls = attr_class(d, ref)
                args.append(f"Arg::Attr({rust_str(arg_name)}, {('Some(AttrKind::' + k + ')') if k else 'None'}, {('Some(' + rust_str(cls) + ')') if cls else 'None'})")
        results = len(val(rec["results"])["args"])
        variable = any(g != "Group::One" for g in groups)
        if ext:
            code = f"Code::Ext({rust_str(val(rec['extendedInstSetName']))}, {int(val(rec['extendedInstOpcode']))})"
        elif int(val(rec["hasOpcode"])):
            code = f"Code::Op({opcodes[val(rec['spirvOpName'])]})"
        else:
            code = "Code::None"
        out.append(
            f"    OpSpec {{ name: {rust_str(mlir_name)}, code: {code}, autogen: {str(bool(int(val(rec['autogenSerialization'])))).lower()}, "
            f"plain: {str(n_attrs == 0 and not variable).lower()}, results: {results}, groups: &[{', '.join(groups)}], args: &[{', '.join(args)}], avail: {avail(d, rec)}, unsigned: {str(any(t.get('def') == 'UnsignedOp' for t in rec.get('traits') or [])).lower()} }},"
        )
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--llvm", required=True, type=Path)
    ap.add_argument("--mlirformat", required=True)
    ap.add_argument("--out", type=Path, default=Path(__file__).resolve().parent.parent / "src/emits/spirv/tables.gen.rs")
    a = ap.parse_args()
    d = load(a.llvm, a.mlirformat)
    es, mnemonics = enums(d)
    opcodes = {n: v for n, v, _, _ in es["Opcode"][1]}
    lines = [
        "// Generated by scripts/spirv_tables.py from llvm-project 22.1.8's SPIR-V ODS; do not edit.",
        "",
        "use super::{Arg, AttrKind, Avail, Case, Code, EnumSpec, Group, OpSpec};",
        "",
        "/// Every SPIR-V enum, by class name.",
        "pub const ENUMS: &[EnumSpec<'_>] = &[",
    ]
    for cls in sorted(es):
        bits, cases = es[cls]
        cs = ", ".join(f"Case {{ name: {rust_str(n)}, value: {v}, avail: {a}, implies: &[{', '.join(rust_str(i) for i in im)}] }}" for n, v, a, im in cases)
        lines.append(f"    EnumSpec {{ class: {rust_str(cls)}, bits: {str(bits).lower()}, cases: &[{cs}] }},")
    lines += ["];", "", "/// `#spirv.<mnemonic><...>` attributes and the enum each carries.", "pub const ENUM_ATTRS: &[(&str, &str)] = &["]
    lines += [f"    ({rust_str(m)}, {rust_str(c)})," for m, c in sorted(mnemonics.items())]
    lines += ["];", "", "/// Every SPIR-V op, by name.", "pub const OPS: &[OpSpec<'_>] = &["]
    lines += sorted(ops(d, opcodes), key=lambda l: l.split('name: "')[1])
    lines += ["];", ""]
    a.out.parent.mkdir(parents=True, exist_ok=True)
    a.out.write_text("\n".join(lines))
    print(f"{len(es)} enums, {len(mnemonics)} enum attributes, {len(lines)} lines -> {a.out}")


if __name__ == "__main__":
    main()
