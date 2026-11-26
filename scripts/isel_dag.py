"""The SelectionDAG patterns of a target, for `isel.py`: what `llvm-tblgen -gen-dag-isel` matches
(its `Src` / `Dst` comments, the patterns with tblgen's types inferred, in the matcher's order) and
the pattern predicates on the way to each (`OPC_CheckPatternPredicate`), kept when the subtarget
has them, their types are scalar, and every node is one the target's lowering builds."""

import re
import sys

# The nodes each target's lowering (`src/targets/<t>/dag.rs`, as `X86ISelLowering` /
# `AArch64ISelLowering` would leave them) builds from the llvm dialect.
LOWERED = {
    "X86": set("""bb add sub mul and or xor shl srl sra ld st imm timm fpimm X86cmp X86setcc X86brcond X86cmov
        trunc zext sext fadd fsub fmul fdiv fsqrt sint_to_fp fp_to_sint fpextend fpround bitconvert""".split()),
    "AArch64": set("""bb add sub mul and or xor shl srl sra ld st imm timm fpimm trunc zext sext fadd fsub fmul fdiv
        fsqrt sint_to_fp uint_to_fp fp_to_sint fp_to_uint fpextend fpround bitconvert AArch64brcond AArch64csel
        AArch64sub_flag""".split()),
}

# Pseudo instructions a pattern may give, and what each is (`X86InstrInfo::expandPostRAPseudo`).
PSEUDO = {"X86": {"MOV32r0"}, "AArch64": set()}

# The nodes of a result that are not instructions.
SPECIAL = {"EXTRACT_SUBREG", "INSERT_SUBREG", "SUBREG_TO_REG", "IMPLICIT_DEF", "COPY", "COPY_TO_REGCLASS"}

SCALAR = {"i1": "I1", "i8": "I8", "i16": "I16", "i32": "I32", "i64": "I64", "f32": "F32", "f64": "F64", "iPTR": "I64"}
UNTYPED = {"isVoid", "Other", "untyped"}

TOK = re.compile(r"\s*(\(|\)|,|<<P:\w+>>|<<X:\w+>>|\{ \*:\[[^\]]*\] \}|:|\$\w+|-?\d+|[A-Za-z_][\w.]*|\?)")
OFF = re.compile(r"^/\*\s*(\d+)\*/(.*)$")


def tokens(s):
    out, i = [], 0
    while i < len(s):
        m = TOK.match(s, i)
        if not m or m.end() == i:
            if s[i].isspace():
                i += 1
                continue
            raise ValueError(s[i:])
        out.append(m.group(1))
        i = m.end()
    return out


def parse(s):
    """A pattern's text as a tree: {op, ty, kids, preds, name} or {leaf, ty, preds, name}."""
    t, pos = tokens(s), [0]

    def peek(k=0):
        return t[pos[0] + k] if pos[0] + k < len(t) else None

    def take():
        pos[0] += 1
        return t[pos[0] - 1]

    def types():
        ty = []
        while peek() == ":" and (peek(1) or "").startswith("{"):
            take()
            ty.append(take()[5:-3])
        return ty

    def item():
        if peek() == "(":
            take()
            n = {"op": take(), "kids": []}
            n["ty"] = types()
            while peek() != ")":
                if peek() == ",":
                    take()
                    continue
                n["kids"].append(item())
            take()
        else:
            n = {"leaf": take()}
            n["ty"] = types()
        n["preds"] = []
        while (peek() or "").startswith("<<"):
            n["preds"].append(take()[4:-2].removeprefix("Predicate_"))
        if peek() == ":" and (peek(1) or "").startswith("$"):
            take()
            n["name"] = take()[1:]
        return n

    r = item()
    if pos[0] != len(t):
        raise ValueError(s)
    return r


def read(text):
    """(src text, complexity, pattern predicates, dst text) in the matcher's order."""
    stack, pats, last = [], [], None
    for line in text.splitlines():
        m = OFF.match(line)
        if m:
            o, rest = int(m[1]), m[2]
            while stack and o >= stack[-1][0]:
                stack.pop()
            e = re.search(r"// ->(\d+)\s*$", rest)
            if e and ("Scope" in rest or "Switch" in rest):
                stack.append([int(e[1]), []])
            elif "OPC_CheckPatternPredicate" in rest:
                stack[-1][1].append(re.search(r"//\s*(.*)$", rest)[1])
            continue
        s = line.strip()
        if s.startswith("// Src:"):
            src, cx = s[8:].rsplit(" - Complexity = ", 1)
            last = [src, int(cx), [p for _, ps in stack for p in ps]]
        elif s.startswith("// Dst:") and last:
            last.append(s[8:])
            pats.append(last)
            last = None
    return pats


def walk(n):
    yield n
    for k in n.get("kids", []):
        yield from walk(k)


def scalar(n):
    return all(x.strip() in SCALAR or x.strip() in UNTYPED for t in n["ty"] for x in t.split(","))


def mvt(n):
    t = n["ty"][0] if n["ty"] else None
    return f"Some(Mvt::{SCALAR[t]})" if t in SCALAR else "None"


class Dag:
    """The kept patterns of one target and the names they use, ready to write as Rust."""

    def __init__(self, rec, target, text, holds, camel, encodable, expand):
        self.rec, self.target, self.camel, self.expand = rec, target, camel, expand
        self.sd, self.preds, self.complex, self.xforms, self.subregs = set(), set(), set(), set(), set()
        self.insts, self.classes, self.regs = set(), set(), set()
        self.kept = []
        seen = set()
        for src_text, cx, conds, dst_text in read(text):
            try:
                src, dst = parse(src_text), parse(dst_text)
            except ValueError:
                continue
            if not all(scalar(n) for n in walk(src)) or not all(scalar(n) for n in walk(dst)):
                continue
            try:
                if not all(holds(c) for c in conds):
                    continue
            except SystemExit:
                continue
            if not all(n["op"] in LOWERED[target] or self.rec.isa(n["op"], "ComplexPattern") for n in walk(src) if "op" in n):
                continue
            if not self.result_ok(dst, encodable):
                continue
            try:
                names = self.names(src)
                self.src(src, names)
                self.dst(dst, names)
            except ValueError:
                continue
            key = (src_text, dst_text)
            if key in seen:
                continue
            seen.add(key)
            self.kept.append((src, dst, cx))
        for src, dst, _ in self.kept:
            for n in walk(src):
                if "op" in n and self.rec.isa(n["op"], "ComplexPattern"):
                    self.complex.add(n["op"])
                elif "op" in n:
                    self.sd.add(n["op"])
                elif self.rec.isa(n["leaf"], "ComplexPattern"):
                    self.complex.add(n["leaf"])
                elif self.rec.isa(n["leaf"], "Register"):
                    self.regs.add(n["leaf"])
                elif self.rec.reg_class(n["leaf"]):
                    self.classes.add(self.rec.reg_class(n["leaf"]))
                self.preds.update(n["preds"])
            for n in walk(dst):
                op = n.get("op")
                if op and self.rec.isa(op, "Instruction") and op not in SPECIAL:
                    self.insts.add(op)
                    if op in self.expand:
                        self.insts.add(self.expand[op])
                elif op and self.rec.isa(op, "SDNodeXForm"):
                    self.xforms.add(op)
                leaf = n.get("leaf")
                if leaf and self.rec.isa(leaf, "SubRegIndex"):
                    self.subregs.add(leaf)
                elif leaf and self.rec.isa(leaf, "Register"):
                    self.regs.add(leaf)
                elif leaf and self.rec.reg_class(leaf):
                    self.classes.add(self.rec.reg_class(leaf))

    def result_ok(self, dst, encodable):
        for n in walk(dst):
            op = n.get("op")
            if not op or op in SPECIAL or op in ("imm", "timm", "fpimm", "bb") or self.rec.isa(op, "SDNodeXForm"):
                continue
            if not self.rec.isa(op, "Instruction"):
                return False
            if op not in PSEUDO[self.target] and op not in self.expand and not encodable(op):
                return False
        return True

    def names(self, src):
        out = []
        for n in walk(src):
            if "op" in n and self.rec.isa(n["op"], "ComplexPattern"):
                continue
            if "name" in n and n["name"] not in out:
                out.append(n["name"])
        return out

    def src(self, n, names):
        name = f"Some({names.index(n['name'])})" if "name" in n else "None"
        preds = "&[" + ", ".join(f"Pred::{self.camel(p)}" for p in n["preds"]) + "]"
        if "op" in n and self.rec.isa(n["op"], "ComplexPattern"):
            subs = [k.get("name") for k in n["kids"]]
            if None in subs or any("op" in k for k in n["kids"]):
                raise ValueError("a complex pattern over nodes")
            return f"DagSrc::Complex {{ pat: Complex::{self.camel(n['op'])}, names: &[{', '.join(str(names.index(x)) for x in subs)}] }}"
        if "op" in n:
            kids = ", ".join(self.src(k, names) for k in n["kids"])
            return f"DagSrc::Node {{ op: Sd::{self.camel(n['op'])}, vt: {mvt(n)}, kids: &[{kids}], preds: {preds}, name: {name} }}"
        leaf = n["leaf"]
        if re.fullmatch(r"-?\d+", leaf):
            return f"DagSrc::Int({leaf})"
        if self.rec.isa(leaf, "ComplexPattern"):
            return f"DagSrc::Complex {{ pat: Complex::{self.camel(leaf)}, names: &[{names.index(n['name'])}] }}"
        if self.rec.isa(leaf, "Register"):
            return f"DagSrc::Phys(Reg::{leaf})"
        if leaf == "bb":
            return f"DagSrc::Bb({names.index(n['name'])})"
        cls = self.rec.reg_class(leaf)
        if cls:
            return f"DagSrc::Class {{ class: Class::{cls}, vt: {mvt(n)}, preds: {preds}, name: {name} }}"
        if leaf == "?":
            return f"DagSrc::Any {{ name: {name} }}"
        raise ValueError(f"source leaf {leaf}")

    def dst(self, n, names):
        if "op" in n:
            op, kids = n["op"], [self.dst(k, names) for k in n["kids"]]
            if op in ("imm", "timm", "fpimm", "bb"):
                return f"DagDst::Ref({names.index(n['name'])})"
            if op == "EXTRACT_SUBREG":
                return f"DagDst::Extract(&{kids[0]}, {kids[1]})"
            if op == "INSERT_SUBREG":
                return f"DagDst::Insert(&{kids[0]}, &{kids[1]}, {kids[2]})"
            if op == "SUBREG_TO_REG":
                return f"DagDst::SubregToReg(&{kids[-2]}, {kids[-1]})"
            if op == "IMPLICIT_DEF":
                return f"DagDst::ImplicitDef({mvt(n)})"
            if op in ("COPY", "COPY_TO_REGCLASS"):
                return f"DagDst::Copy(&{kids[0]})"
            if self.rec.isa(op, "SDNodeXForm"):
                return f"DagDst::XForm(XForm::{self.camel(op)}, &{kids[0]})"
            return f"DagDst::Inst {{ op: Opcode::{op}, vt: {mvt(n)}, kids: &[{', '.join(kids)}] }}"
        leaf = n["leaf"]
        if "name" in n and n["name"] in names:
            return f"DagDst::Ref({names.index(n['name'])})"
        if re.fullmatch(r"-?\d+", leaf):
            return f"DagDst::Int({leaf})"
        if self.rec.isa(leaf, "SubRegIndex"):
            return f"SubReg::{self.camel(leaf)}"
        if self.rec.isa(leaf, "Register"):
            return f"DagDst::Phys(Reg::{leaf})"
        raise ValueError(f"result leaf {leaf}")

    def rust(self):
        out = ["/// The SelectionDAG patterns (`-gen-dag-isel`), in the matcher's order: complexity, then table order.",
               "pub const PATTERNS: &[DagPattern<'_, Opcode, Class, Reg, Pred, Complex, SubReg, XForm>] = &["]
        order = sorted(range(len(self.kept)), key=lambda i: -self.kept[i][2])
        for i in order:
            src, dst, cx = self.kept[i]
            names = self.names(src)
            out.append(f"    DagPattern {{ complexity: {cx}, src: {self.src(src, names)}, dst: {self.dst(dst, names)} }},")
        out += ["];", ""]
        return out
