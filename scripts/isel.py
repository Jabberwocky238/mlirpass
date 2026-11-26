#!/usr/bin/env python3
"""Generates the instruction selection of the CPU targets from llvm-project 23.1.5's TableGen, as
LLVM's own fast instruction selector (the one `-O0` and its JITs use) gets it:

* `llvm-tblgen -gen-fast-isel`: every pattern of one node over registers and immediates, its
  value types, its immediate predicate and the instruction it selects, under the subtarget below
  (`SUBTARGETS`: x86-64 v1, Armv8-A);
* `llvm-tblgen --dump-json`: those instructions and the ones the hand-written part of the
  selector uses (`EXTRA`, what `X86FastISel.cpp` / `AArch64FastISel.cpp` name), their operands,
  tied operands, implicit registers and encodings, and the registers and register classes.

    python3 scripts/isel.py --llvm $LLVM [--tblgen $LLVM_BUILD/bin/llvm-tblgen] [--check]

writes `src/targets/x86_64/isel.gen.rs` and `src/targets/aarch64/isel.gen.rs`.
"""

import argparse
import json
import isel_dag
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# The value types the scalar targets select.
SCALAR = ["i1", "i8", "i16", "i32", "i64", "f32", "f64"]

# The subtarget the patterns are taken for: what `Subtarget->...()` answers.
SUBTARGETS = {
    "X86": {
        "is64Bit": True, "isTarget64BitLP64": True, "slowIncDec": True, "hasSSE1": True, "hasSSE2": True, "hasX87": True,
        "canUseCMOV": True, "hasCMOV": True,
    },
    "AArch64": {
        "hasFPARMv8": True, "hasNEON": True, "isNeonAvailable": True, "isLittleEndian": True,
    },
}

# What the hand-written part of each selector emits besides the patterns (loads, stores,
# compares, branches, calls, returns, frames, copies).
EXTRA = {
    "X86": """
        MOV8rm MOV16rm MOV32rm MOV64rm MOVZX32rm8 MOVZX32rm16 MOVSX32rm8 MOVSX32rm16 MOVSX64rm8 MOVSX64rm16 MOVSX64rm32
        MOV8mr MOV16mr MOV32mr MOV64mr MOVSDrm MOVSDmr MOVSSrm MOVSSmr
        MOV64ri MOV32ri MOV64rr MOV32rr MOV16rr MOV8rr MOVAPSrr MOV64toSDrr MOVSDto64rr MOVDI2SSrr MOVSS2DIrr
        MOVZX32rr8 MOVZX32rr16 MOVSX32rr8 MOVSX32rr16 MOVSX64rr8 MOVSX64rr16 MOVSX64rr32
        CMP8rr CMP16rr CMP32rr CMP64rr CMP64ri32 CMP32ri TEST8rr TEST32rr TEST64rr TEST8ri UCOMISDrr UCOMISSrr
        SETCCr JCC_1 JCC_4 JMP_1 JMP_4 CMOV16rr CMOV32rr CMOV64rr CALL64r RET64 PUSH64r POP64r LEA64r
        SUB64ri32 ADD64ri32 CWD CDQ CQO IDIV8r IDIV16r IDIV32r IDIV64r DIV8r DIV16r DIV32r DIV64r
        SHL8rCL SHL16rCL SHL32rCL SHL64rCL SHR8rCL SHR16rCL SHR32rCL SHR64rCL SAR8rCL SAR16rCL SAR32rCL SAR64rCL
        XOR32rr XOR64rr AND32ri TRAP
    """.split(),
    "AArch64": """
        LDRXui LDRWui LDRHHui LDRBBui LDRSWui LDRSHXui LDRSBXui LDRSHWui LDRSBWui LDRDui LDRSui
        LDURXi LDURWi LDURHHi LDURBBi LDURSWi LDURSHXi LDURSBXi LDURSHWi LDURSBWi LDURDi LDURSi
        STRXui STRWui STRHHui STRBBui STRDui STRSui STURXi STURWi STURHHi STURBBi STURDi STURSi
        MOVZXi MOVKXi MOVZWi MOVKWi MOVNXi MOVNWi ORRXrs ORRWrs ADDXrs ADDWrs SUBXrs SUBWrs SUBSXrs SUBSWrs SUBSXri SUBSWri
        ADDXri ADDWri SUBXri SUBWri CSINCWr CSINCXr CSELXr CSELWr FCMPDrr FCMPSrr FCSELDrrr FCSELSrrr
        Bcc B BL BLR RET CBNZW CBNZX CBZW CBZX SBFMXri UBFMXri SBFMWri UBFMWri
        SDIVXr UDIVXr SDIVWr UDIVWr MSUBXrrr MSUBWrrr MADDXrrr MADDWrrr LSLVXr LSRVXr ASRVXr LSLVWr LSRVWr ASRVWr
        FMOVXDr FMOVDXr FMOVDr FMOVSr FMOVWSr FMOVSWr STPXpre LDPXpost BRK
        LDRXl LDRSWl LDRXroX LDRWroX LDRHHroX LDRBBroX LDRDroX LDRSroX STRXroX STRWroX STRHHroX STRBBroX STRDroX STRSroX
    """.split(),
}

# Registers the subtarget does not have (`getReservedRegs` for the features above).
ABSENT = {
    "X86": re.compile(r"^(R(1[6-9]|2\d|3[01])[BWD]?|XMM(1[6-9]|2\d|3[01])|RIP|EIP|IP|AH|BH|CH|DH)$"),
    "AArch64": re.compile(r"^$"),
}

# The C calling convention, its return convention and callee-saved registers.
CC = {
    "X86": ("CC_X86_64_C", "RetCC_X86_64_C", "CSR_64"),
    "AArch64": ("CC_AArch64_AAPCS", "RetCC_AArch64_AAPCS", "CSR_AArch64_AAPCS"),
}

TD = {"X86": ("X86", "X86.td", "x86_64"), "AArch64": ("AArch64", "AArch64.td", "aarch64")}


def tblgen(tool, llvm, target, *args):
    d, td, _ = TD[target]
    tdir = llvm / "llvm/lib/Target" / d
    out = subprocess.run([str(tool), *args, "-I", str(llvm / "llvm/include"), "-I", str(tdir), str(tdir / td)], capture_output=True, check=True, text=True)
    return out.stdout


def camel(name):
    """`SINT_TO_FP` ⇒ `SintToFp`, `i64immSExt32` ⇒ `I64immSExt32`, `sub_8bit` ⇒ `Sub8bit`."""
    if name.upper() == name:
        return "".join(w[:1].upper() + w[1:].lower() for w in name.split("_"))
    return "".join(w[:1].upper() + w[1:] for w in name.split("_"))


FUNC = re.compile(r"^Register (fastEmit_\w+)\((.*?)\) \{\n(.*?)^\}", re.M | re.S)
NAME = re.compile(r"^fastEmit_(?P<node>ISD_[A-Za-z0-9_]+?)_MVT_(?P<vt>[a-z0-9]+)(?:_MVT_(?P<ret>[a-z0-9]+))?_(?P<kinds>[rif]+)(?:_Predicate_(?P<pred>\w+))?$")
BLOCK = re.compile(r"^  if \((?P<cond>[^\n]*)\) \{\n(?P<body>.*?)^  \}|^  (?P<plain>(?:BuildMI[^\n]*\n  )*return fastEmitInst_[^\n]*)", re.M | re.S)
CALL = re.compile(r"return (?P<call>fastEmitInst_\w+)\((?P<args>[^;]*)\);")
COPY = re.compile(r"TargetOpcode::COPY\), \w+::(?P<reg>\w+)\)\.addReg\(Op(?P<op>\d+)\)")
PRED = re.compile(r"^static bool Predicate_(\w+)\(int64_t Imm\) \{\n(.*?)^\}", re.M | re.S)


def holds(cond, features):
    expr = re.sub(r"Subtarget->(\w+)\(\)", lambda m: str(features.get(m.group(1), False)), cond)
    expr = expr.replace("&&", " and ").replace("||", " or ").replace("!", " not ")
    if re.search(r"[A-Za-z_]+", re.sub(r"\b(True|False|and|or|not)\b", "", expr)):
        sys.exit(f"isel.py: a condition the subtarget cannot answer: {cond}")
    return eval(expr)


def fast_isel(text, target):
    ns = target + "::"
    features = SUBTARGETS[target]
    preds = {n: " ".join(b.split()) for n, b in PRED.findall(text)}
    rows = []
    for name, _params, body in FUNC.findall(text):
        m = NAME.match(name)
        if not m or "switch (RetVT.SimpleTy)" in body:
            continue
        vt = m["vt"]
        ret = m["ret"] or (re.search(r"RetVT.SimpleTy != MVT::(\w+)", body) or [None, vt])[1]
        if vt not in SCALAR or ret not in SCALAR:
            continue
        for b in BLOCK.finditer(body):
            if b["cond"] and not holds(b["cond"], features):
                continue
            block = b["body"] or b["plain"]
            c = CALL.search(block)
            if not c:
                continue
            args = [a.strip() for a in c["args"].split(",")]
            copies = tuple((int(x["op"]), x["reg"]) for x in COPY.finditer(block))
            used = tuple(int(re.search(r"\d+$", x)[0]) for x in args if re.fullmatch(r"(Op|imm|f)\d+", x))
            if c["call"] == "fastEmitInst_extractsubreg":
                emit = ("sub", args[2].removeprefix(ns), used, copies)
            else:
                emit = ("inst", args[0].removeprefix(ns), args[1].removeprefix("&" + ns).removesuffix("RegClass"), used, copies)
            rows.append((m["node"].removeprefix("ISD_"), vt, ret, m["kinds"], m["pred"], emit))
            break
    used = {r[4] for r in rows if r[4]}
    return rows, {p: preds[p] for p in sorted(used)}


class Records:
    def __init__(self, j, target):
        self.d = j
        self.target = target
        self.absent = ABSENT[target]

    def isa(self, name, cls):
        r = self.d.get(name)
        return r is not None and cls in r["!superclasses"]

    def members(self, dag):
        """`SetTheory` on a register class's member list: add, sub, and, sequence."""
        if isinstance(dag, dict) and dag.get("kind") == "def":
            n = dag["def"]
            return self.class_members(n) if self.isa(n, "RegisterClass") else [n]
        op = dag["operator"]["def"]
        args = [a for a, _ in dag["args"]]
        if op == "sequence":
            fmt, lo, hi = args
            return [fmt.replace("%u", str(i)) for i in range(lo, hi + 1)]
        sets = [self.members(a) for a in args]
        if op == "add":
            out = []
            for s in sets:
                out += [r for r in s if r not in out]
            return out
        if op == "sub":
            drop = {r for s in sets[1:] for r in s}
            return [r for r in sets[0] if r not in drop]
        if op == "and":
            keep = set(sets[1])
            return [r for r in sets[0] if r in keep]
        sys.exit(f"isel.py: register set operator {op}")

    def class_members(self, cls):
        return [r for r in self.members(self.d[cls]["MemberList"]) if not self.absent.match(r)]

    def reg_class(self, name):
        """The register class an operand names (a class, a register operand, a class by mode)."""
        if self.isa(name, "RegisterClass"):
            return name
        r = self.d.get(name)
        if r is None:
            return None
        if self.isa(name, "RegisterOperand"):
            return self.reg_class(r["RegClass"]["def"])
        if self.isa(name, "RegClassByHwMode"):
            modes = [m["def"] for m in r["Modes"]]
            return self.reg_class(r["Objects"][modes.index("X86_64")]["def"])
        return None

    def encoding(self, reg):
        bits = self.d[reg]["HWEncoding"]
        return sum(b << i for i, b in enumerate(bits))


def cc_regs(rec, cc, vt):
    """The registers a `CallingConv` assigns a value of `vt`, as `CCState` runs its actions for a
    plain argument (no `ArgFlags`, not variadic) on the subtarget above."""
    features = SUBTARGETS[rec.target]

    def run(actions, vt):
        for a in actions:
            r = rec.d[a["def"]]
            kind = r["!superclasses"][-1]
            if kind == "CCIfType":
                if vt in [t["def"] for t in r["VTs"]]:
                    got, vt = run([r["SubAction"]], vt)
                    if got is not None:
                        return got, vt
            elif kind in ("CCPromoteToType", "CCBitConvertToType"):
                return None, r["DestTy"]["def"]
            elif kind == "CCIfSubtarget":
                m = re.search(r"\.(\w+)\(\)$", r["Predicate"])
                if m and features.get(m[1], False):
                    got, vt = run([r["SubAction"]], vt)
                    if got is not None:
                        return got, vt
            elif kind == "CCIfNotVarArg":
                got, vt = run([r["SubAction"]], vt)
                if got is not None:
                    return got, vt
            elif kind == "CCDelegateTo":
                got, vt = run(rec.d[r["CC"]["def"]]["Actions"], vt)
                if got is not None:
                    return got, vt
            elif kind == "CCAssignToReg":
                return [x["def"] for x in r["RegList"]], vt
            elif kind in ("CCAssignToStack", "CCPassByVal"):
                return [], vt
        return None, vt

    actions = rec.d[cc]["Actions"]
    while True:
        got, nvt = run(actions, vt)
        if got is not None:
            return got
        if nvt == vt:
            return []
        vt = nvt


def units(rec, regs):
    """Each register's widest register in `regs` that contains it (`RAX` for `AL`, `D0` for `S0`)."""
    parent = {}
    for name in rec.d["!instanceof"]["Register"]:
        for sub in rec.d[name].get("SubRegs", []):
            parent.setdefault(sub["def"], name)
    out = {}
    for r in regs:
        top, x = r, r
        while x in parent:
            x = parent[x]
            if x in regs:
                top = x
        out[r] = top
    return out


def bits(v):
    return sum((b or 0) << i for i, b in enumerate(v))


def operands(rec, inst):
    """The instruction's operands, outs then ins: (name, kind, class, sub-operand count, encoder).
    An operand written with named sub-operands (`(arith_shifted_reg64 ?:$Rm, ?:$shift)`) is its
    sub-operands."""
    r = rec.d[inst]
    out = []

    def one(o, n):
        cls = rec.reg_class(o)
        if cls:
            out.append((n, "Reg", cls, 1, ""))
            return
        od = rec.d[o]
        info = od.get("MIOperandInfo") or {"args": []}
        ty = od.get("OperandType", "OPERAND_UNKNOWN").removeprefix("OPERAND_")
        kind = {"MEMORY": "Mem", "PCREL": "PcRel", "COND_CODE": "Cond"}.get(ty, "Imm")
        if rec.target == "X86" and len(info["args"]) == 5:
            kind = "Mem"  # `lea64mem`: an address, its type unknown
        out.append((n, kind, None, max(1, len(info["args"])), od.get("EncoderMethod") or ""))

    for lst in ("OutOperandList", "InOperandList"):
        for a, n in r[lst]["args"]:
            if a.get("kind") == "dag":
                subs = rec.d[a["operator"]["def"]]["MIOperandInfo"]["args"]
                for (sd, _), (_, sn) in zip(subs, a["args"]):
                    one(sd["def"], sn)
            else:
                one(a["def"], n)
    return out


def tied(r, ops):
    """`$a = $b` constraints as (the input, the output it is)."""
    names = [o[0] for o in ops]
    out = []
    for c in (r.get("Constraints") or "").split(","):
        m = re.match(r"\s*\$(\w+)\s*=\s*\$(\w+)\s*$", c)
        if m:
            a, b = names.index(m[1]), names.index(m[2])
            out.append((max(a, b), min(a, b)))
    return out


def x86_encoding(rec, inst):
    r = rec.d[inst]
    if r["OpEnc"]["def"] != "EncNormal":
        sys.exit(f"isel.py: {inst} is not legacy-encoded")
    return {
        "opcode": bits(r["Opcode"]),
        "form": r["Form"]["def"],
        "prefix": r["OpPrefix"]["def"],
        "map": r["OpMap"]["def"],
        "rex_w": bool(r["hasREX_W"]),
        "opsize": r["OpSize"]["def"],
        "imm": r["ImmT"]["def"],
    }


def a64_encoding(rec, inst, ops):
    r = rec.d[inst]
    names = [o[0] for o in ops]
    fixed, fields = 0, []
    for i, b in enumerate(r["Inst"]):
        if isinstance(b, int):
            fixed |= b << i
        elif b is None:
            sys.exit(f"isel.py: {inst} has an unset encoding bit {i}")
        else:
            var, at = b["var"], b["index"]
            if var not in names:
                sys.exit(f"isel.py: {inst}: encoding field {var} is no operand")
            k = names.index(var)
            if fields and fields[-1][0] == k and fields[-1][1] + fields[-1][3] == i and fields[-1][2] + fields[-1][3] == at:
                fields[-1][3] += 1
            else:
                fields.append([k, i, at, 1])
    return fixed, fields


def twin(rec, inst):
    """A codegen-only instruction's twin: the one with its encoding that a disassembler gives."""
    r = rec.d[inst]
    if not r.get("isCodeGenOnly"):
        return None
    if rec.target == "X86":
        key = lambda n: x86_encoding(rec, n) if rec.d[n].get("OpEnc", {}).get("def") == "EncNormal" else None
    else:
        key = lambda n: (bits(rec.d[n]["Inst"]) if all(isinstance(b, int) for b in rec.d[n]["Inst"]) else None, [None if isinstance(b, int) else (b or {}).get("var") for b in rec.d[n]["Inst"]])
    want = key(inst)
    for n in rec.d["!instanceof"]["Instruction"]:
        o = rec.d[n]
        if n != inst and not o.get("isCodeGenOnly") and not o.get("isPseudo") and not o.get("isAsmParserOnly") and (rec.target == "X86" or o.get("Inst") is not None) and key(n) == want:
            return n
    return None


def is_pseudo(rec, inst):
    r = rec.d[inst]
    if r.get("isPseudo") or r.get("isCodeGenOnly") and rec.target == "AArch64" and all(b is None for b in r.get("Inst", [None])):
        return True
    return rec.target == "AArch64" and all(b is None for b in r.get("Inst", [None]))


# Pseudo instructions LLVM's pseudo expansion turns into one real instruction with a zero shift
# (`AArch64ExpandPseudo::expandMI`: `case AArch64::ADDWrr: Opcode = AArch64::ADDWrs; break;`).
EXPANSION = re.compile(r"case AArch64::(\w+rr):\s+Opcode = AArch64::(\w+rs); break;")


def expansions(llvm, target):
    if target != "AArch64":
        return {}
    src = (llvm / "llvm/lib/Target/AArch64/AArch64ExpandPseudoInsts.cpp").read_text()
    return dict(EXPANSION.findall(src))


def rust_str(s):
    return json.dumps(s)


def encodable(rec, inst):
    r = rec.d[inst]
    if r.get("isPseudo"):
        return False
    if rec.target == "X86":
        return r.get("OpEnc", {}).get("def") == "EncNormal" and r.get("Form", {}).get("def") != "Pseudo"
    return all(b is not None for b in r.get("Inst", [None]))


def generate(llvm, target, fast_text, dag_text, j):
    rec = Records(j, target)
    rows, preds = fast_isel(fast_text, target)
    dag = isel_dag.Dag(rec, target, dag_text, lambda c: holds(c, SUBTARGETS[target]), camel, lambda i: encodable(rec, i))
    insts = sorted({e[1] for *_, e in rows if e[0] == "inst"} | set(EXTRA[target]) | dag.insts)
    expand = {p: r for p, r in expansions(llvm, target).items() if p in insts}
    insts = sorted(set(insts) | set(expand.values()))
    pseudo = {i for i in insts if is_pseudo(rec, i)}
    descs = {i: operands(rec, i) for i in insts}
    classes = sorted({c for ops in descs.values() for _, k, c, _, _ in ops if c} | {e[2] for *_, e in rows if e[0] == "inst"} | dag.classes)
    members = {c: rec.class_members(c) for c in classes}
    implicit = {i: ([x["def"] for x in j[i].get("Defs", [])], [x["def"] for x in j[i].get("Uses", [])]) for i in insts}
    regs = []
    for c in classes:
        regs += [r for r in members[c] if r not in regs]
    for d, u in implicit.values():
        regs += [r for r in d + u if r not in regs and not rec.absent.match(r)]
    args_cc, ret_cc, csr = CC[target]
    vts = ["i32", "i64", "f32", "f64"]
    cc_args = {vt: cc_regs(rec, args_cc, vt) for vt in vts}
    cc_rets = {vt: cc_regs(rec, ret_cc, vt) for vt in vts}
    saved = rec.members(j[csr]["SaveList"])
    for r in [x for l in list(cc_args.values()) + list(cc_rets.values()) for x in l] + saved + sorted(dag.regs):
        if r not in regs:
            regs.append(r)
    unit = units(rec, regs)
    subregs = sorted({e[1] for *_, e in rows if e[0] == "sub"} | dag.subregs)
    encoders = sorted({o[4] for ops in descs.values() for o in ops if o[4]})
    lines = [
        f"// Generated by scripts/isel.py from llvm-project 23.1.5's {target} TableGen (-gen-fast-isel, --dump-json); do not edit.",
        "",
        "#![allow(non_camel_case_types, dead_code)]",
        "",
        "use crate::targets::{DagDst, DagPattern, DagSrc, Fast, FastEmit, Isd, Kinds, MachineOperand, Mvt, OperandKind, Sd};",
        "",
    ]

    def enum(name, doc, items, derive="Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash"):
        lines.append(f"/// {doc}")
        lines.append(f"#[derive({derive})]")
        lines.append(f"pub enum {name} {{")
        for it in items:
            if isinstance(it, tuple):
                lines.append(f"    /// `{it[1]}`")
                it = it[0]
            lines.append(f"    {it},")
        lines.append("}")
        lines.append("")

    enum("Opcode", f"Every instruction the selector emits, by its {target} name.", insts)
    lines += ["impl Opcode {", "    pub const NAMES: &[&str] = &[" + ", ".join(rust_str(i) for i in insts) + "];",
              "    pub const ALL: &[Opcode] = &[" + ", ".join(f"Opcode::{i}" for i in insts) + "];", "}", ""]
    enum("Reg", "The registers the classes below hold, and the implicit ones.", regs)
    enc = ", ".join(str(rec.encoding(r)) for r in regs)
    lines += ["impl Reg {", "    pub const NAMES: &[&str] = &[" + ", ".join(rust_str(r) for r in regs) + "];",
              "    /// `HWEncoding`, by `Reg`.", f"    pub const ENCODINGS: &[u8] = &[{enc}];",
              "    /// The widest register each one is part of, by `Reg`.", "    pub const UNITS: &[Reg] = &[" + ", ".join(f"Reg::{unit[r]}" for r in regs) + "];",
              f"    /// The C calling convention's argument registers (`{args_cc}`), by value type.",
              "    pub const ARGS: &[(Mvt, &[Reg])] = &[" + ", ".join(f"(Mvt::{vt.upper()}, &[" + ", ".join(f"Reg::{x}" for x in cc_args[vt]) + "])" for vt in vts) + "];",
              f"    /// Its return registers (`{ret_cc}`).",
              "    pub const RETS: &[(Mvt, &[Reg])] = &[" + ", ".join(f"(Mvt::{vt.upper()}, &[" + ", ".join(f"Reg::{x}" for x in cc_rets[vt]) + "])" for vt in vts) + "];",
              f"    /// Callee-saved (`{csr}`).", "    pub const SAVED: &[Reg] = &[" + ", ".join(f"Reg::{x}" for x in saved) + "];",
              "}", ""]
    enum("Class", "Register classes, each with its members in allocation order.", classes)
    lines += ["impl Class {", "    pub const MEMBERS: &[&[Reg]] = &["]
    for c in classes:
        lines.append("        &[" + ", ".join(f"Reg::{r}" for r in members[c]) + "],")
    lines += ["    ];", "}", ""]
    enum("ImmPred", "Immediate predicates of the patterns (`ImmLeaf`), their C++ as LLVM writes it.", [(camel(p), preds[p]) for p in preds])
    if subregs:
        enum("SubReg", "Sub-register indices a pattern extracts.", [camel(s) for s in subregs])
    else:
        lines += ["/// Sub-register indices a pattern extracts.", "#[derive(Clone, Copy, Debug, PartialEq, Eq)]", "pub enum SubReg {}", ""]
    def code(name):
        r = j.get(name, {})
        return " ".join(((r.get("PredicateCode") or "") + " " + (r.get("ImmediateCode") or "")).split()) or name

    enum("Pred", "Node predicates of the SelectionDAG patterns (`PatFrag`s), their C++ as LLVM writes it.", [(camel(p), code(p)) for p in sorted(dag.preds)] or ["None_"])
    enum("Complex", "Complex patterns (`ComplexPattern`): the C++ function that matches each.", [(camel(c), j[c]["SelectFunc"]) for c in sorted(dag.complex)] or ["None_"])
    enum("XForm", "Operand transforms of the results (`SDNodeXForm`).", [(camel(x), " ".join((j[x].get("XFormFunction") or "").split())) for x in sorted(dag.xforms)] or ["None_"])
    enum("Encoder", "Operand encoder methods (`EncoderMethod`), as LLVM names them.", ["Plain"] + [(camel(re.sub(r"\W+", "_", e).strip("_")), e) for e in encoders])
    enc_name = {e: camel(re.sub(r"\W+", "_", e).strip("_")) for e in encoders}

    if target == "X86":
        real = [x86_encoding(rec, i) for i in insts if i not in pseudo]
        enum("Form", "`Format`s of the instructions.", sorted({e["form"] for e in real}))
        enum("Prefix", "Mandatory prefixes (`OpPrefix`).", sorted({e["prefix"] for e in real}))
        enum("Map", "Opcode maps (`OpMap`).", sorted({e["map"] for e in real}))
        enum("OpSize", "Operand-size prefixes (`OpSize`).", sorted({e["opsize"] for e in real}))
        enum("ImmT", "Immediate kinds (`ImmT`).", sorted({e["imm"] for e in real}))
        lines += ["/// An instruction's legacy encoding.", "#[derive(Clone, Copy, Debug, PartialEq, Eq)]", "pub struct Encoding {",
                  "    pub opcode: u8,", "    pub form: Form,", "    pub prefix: Prefix,", "    pub map: Map,", "    pub rex_w: bool,",
                  "    pub opsize: OpSize,", "    pub imm: ImmT,", "}", ""]
    else:
        lines += ["/// An instruction's encoding: the fixed bits and where each operand's bits go.", "#[derive(Clone, Copy, Debug, PartialEq, Eq)]",
                  "pub struct Encoding<'t> {", "    pub bits: u32,", "    pub fields: &'t [Field],", "}", "",
                  "/// `width` bits of operand `operand`'s encoded value from bit `from`, at instruction bit `at`.",
                  "#[derive(Clone, Copy, Debug, PartialEq, Eq)]", "pub struct Field {", "    pub operand: u8,", "    pub at: u8,", "    pub from: u8,", "    pub width: u8,", "}", ""]

    lt = "" if target == "X86" else "<'t>"
    lines += ["/// An instruction: its operands (outs, then ins), the pairs that must be one register, implicit registers, encoding.",
              "#[derive(Clone, Copy, Debug)]", "pub struct Desc<'t> {", "    pub outs: u8,", "    pub operands: &'t [MachineOperand<Class, Encoder>],",
              "    pub tied: &'t [(u8, u8)],", "    pub defs: &'t [Reg],", "    pub uses: &'t [Reg],", f"    /// `None`: a pseudo instruction, expanded before encoding.", f"    pub encoding: Option<Encoding{lt}>,", "}", "",
              "impl Opcode {", "    /// By `Opcode`.", "    pub const DESCS: &[Desc<'_>] = &["]
    for i in insts:
        ops = descs[i]
        r = j[i]
        nout = len(r["OutOperandList"]["args"])
        os = ", ".join(
            f"MachineOperand {{ kind: OperandKind::{k}, class: {('Some(Class::' + c + ')') if c else 'None'}, subs: {s}, encoder: Encoder::{enc_name.get(e, 'Plain')} }}"
            for _, k, c, s, e in ops)
        t = ", ".join(f"({a}, {b})" for a, b in tied(r, ops))
        d, u = implicit[i]
        ds = ", ".join(f"Reg::{x}" for x in d if not rec.absent.match(x))
        us = ", ".join(f"Reg::{x}" for x in u if not rec.absent.match(x))
        if i in pseudo:
            es = "None"
        elif target == "X86":
            e = x86_encoding(rec, i)
            es = (f"Some(Encoding {{ opcode: {e['opcode']:#04x}, form: Form::{e['form']}, prefix: Prefix::{e['prefix']}, map: Map::{e['map']}, "
                  f"rex_w: {str(e['rex_w']).lower()}, opsize: OpSize::{e['opsize']}, imm: ImmT::{e['imm']} }})")
        else:
            fixed, fields = a64_encoding(rec, i, ops)
            fs = ", ".join(f"Field {{ operand: {k}, at: {at}, from: {fr}, width: {w} }}" for k, at, fr, w in fields)
            es = f"Some(Encoding {{ bits: {fixed:#010x}, fields: &[{fs}] }})"
        lines.append(f"        // {i}: {r.get('AsmString', '')!r}")
        lines.append(f"        Desc {{ outs: {nout}, operands: &[{os}], tied: &[{t}], defs: &[{ds}], uses: &[{us}], encoding: {es} }},")
    lines += ["    ];", "}", ""]

    if target == "AArch64":
        lines += ["/// Pseudo instructions and the real one each becomes, with a zero shift appended.", "pub const EXPAND: &[(Opcode, Opcode)] = &["]
        lines += [f"    (Opcode::{p}, Opcode::{r})," for p, r in sorted(expand.items())]
        lines += ["];", ""]
    twins = [(i, twin(rec, i)) for i in insts if i not in pseudo]
    lines += ["impl Opcode {", "    /// Codegen-only instructions and the one with the same encoding a disassembler names.",
              "    pub const TWINS: &[(Opcode, &str)] = &[" + ", ".join(f"(Opcode::{a}, {rust_str(b)})" for a, b in twins if b) + "];", "}", ""]
    lines += ["/// The patterns of one node, by node, value type, result type and operand kinds; the first whose predicate holds wins.",
              "pub const FAST: &[Fast<'_, Opcode, Class, ImmPred, SubReg, Reg>] = &["]
    for node, vt, ret, kinds, pred, emit in sorted(rows, key=lambda r: (r[0], SCALAR.index(r[1]), SCALAR.index(r[2]), r[3], r[4] or "")):
        p = f"Some(ImmPred::{camel(pred)})" if pred else "None"
        e = f"FastEmit::Inst(Opcode::{emit[1]}, Class::{emit[2]})" if emit[0] == "inst" else f"FastEmit::Extract(SubReg::{camel(emit[1])})"
        cp = ", ".join(f"({o}, Reg::{r})" for o, r in emit[-1])
        lines.append(f"    Fast {{ node: Isd::{camel(node)}, vt: Mvt::{vt.upper()}, ret: Mvt::{ret.upper()}, kinds: Kinds::{camel(kinds)}, pred: {p}, copies: &[{cp}], args: &[{", ".join(map(str, emit[-2]))}], emit: {e} }},")
    lines += ["];", ""]
    lines += dag.rust()
    nodes = sorted({r[0] for r in rows})
    return "\n".join(lines), nodes, dag.sd, len(rows), len(insts), len(dag.kept)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--llvm", required=True, type=Path)
    ap.add_argument("--tblgen", type=Path)
    ap.add_argument("--check", action="store_true")
    a = ap.parse_args()
    tool = a.tblgen or a.llvm / "build/bin/llvm-tblgen"
    all_nodes, all_sd = set(), set()
    stale = False
    outs = {}
    for target in TD:
        fast = tblgen(tool, a.llvm, target, "-gen-fast-isel")
        j = json.loads(tblgen(tool, a.llvm, target, "--dump-json"))
        dagtext = tblgen(tool, a.llvm, target, "-gen-dag-isel")
        text, nodes, sd, nrows, ninsts, ndag = generate(a.llvm, target, fast, dagtext, j)
        all_nodes |= set(nodes)
        all_sd |= sd
        outs[ROOT / "src/targets" / TD[target][2] / "isel.gen.rs"] = text
        print(f"{target}: {nrows} fast patterns, {ndag} DAG patterns, {ninsts} instructions")
    isd = ["// Generated by scripts/isel.py from llvm-project 23.1.5's fast instruction selectors; do not edit.", "",
           "/// The `ISD` nodes the CPU targets' patterns select, LLVM's names.", "#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]", "pub enum Isd {"]
    isd += [f"    /// `ISD::{n}`\n    {camel(n)}," for n in sorted(all_nodes)]
    isd += ["}", "", "/// The `SDNode`s the CPU targets' SelectionDAG patterns match, TableGen's names.",
            "#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]", "pub enum Sd {"]
    isd += [f"    /// `{n}`\n    {camel(n)}," for n in sorted(all_sd)]
    isd += ["}", ""]
    outs[ROOT / "src/targets/machine/isd.gen.rs"] = "\n".join(isd)
    for path, text in outs.items():
        if a.check:
            if not path.exists() or path.read_text() != text:
                print(f"stale: {path}")
                stale = True
        else:
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text)
    sys.exit(1 if stale else 0)


if __name__ == "__main__":
    main()
