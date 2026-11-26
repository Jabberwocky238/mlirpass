//! The x86-64 SelectionDAG selector of `O1` and up: a block's ops seen as the nodes
//! `X86ISelLowering` leaves (`icmp` + `cond_br` as `X86brcond` over `X86cmp`, `select` as
//! `X86cmov`, ...), each root matched against the generated patterns in LLVM's order (whole
//! trees: a load folded into its user, an address into the access, a constant into the
//! immediate form, a compare into the branch), and the match emitted as the pattern's result.
//! Ops no pattern takes go to the fast selector.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use mlirformat::Error;
use mlirformat::llvm::ICmpPredicate;
use smallvec::SmallVec;

use super::encode::{Cc, Mem, X};
use super::isel::{Class, Complex, Opcode, PATTERNS, Pred, Reg, SubReg, XForm};
use super::{Lower, Pool};
use crate::targets::machine::{Constant, Pred as Predicate};
use crate::targets::{DagDst, DagSrc, Mvt, Sd};
use crate::{BlockId, Body, HoleKind, OpId, ValueId};

type Src<'t> = DagSrc<'t, Class, Reg, Pred, Complex>;
type Dst<'t> = DagDst<'t, Opcode, Reg, SubReg, XForm>;

/// What a node's operand is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kid {
    V(ValueId),
    /// A shift amount: `i8` to the patterns, whatever its type.
    Amt(ValueId),
    /// The `X86cmp` an `icmp` is.
    Cmp(OpId),
    /// `X86cmp v, 0`.
    Test(ValueId),
    /// The `0` of a `Test`.
    Zero,
    Cond(Cc),
    Bb(BlockId),
}

struct View {
    op: Sd,
    vt: Option<Mvt>,
    kids: SmallVec<[Kid; 4]>,
}

/// `base + index * scale + disp`, or a stencil's frame slot.
#[derive(Clone, Copy, Debug)]
pub enum Base {
    Val(ValueId),
    Slot(ValueId),
}

#[derive(Clone, Copy, Debug)]
pub struct Addr {
    base: Base,
    index: Option<(ValueId, u8)>,
    disp: i32,
}

#[derive(Clone, Copy, Debug)]
pub enum Cap {
    None,
    Val(ValueId),
    Imm(i64),
    Addr(Addr),
    Cond(Cc),
    Bb(BlockId),
}

/// A root matched: the pattern, its operands, the flags it reads (`X86cmp` matched on its own,
/// emitted first), values copied to physical registers, and the ops folded into it.
pub struct Match {
    pat: usize,
    caps: Vec<Cap>,
    flags: Option<alloc::boxed::Box<Match>>,
    phys: Vec<(Reg, ValueId)>,
    folded: Vec<OpId>,
}

/// Every pattern index by its root node, in order.
pub struct Table {
    by_root: BTreeMap<Sd, Vec<usize>>,
}

impl Table {
    pub fn new() -> Self {
        let mut by_root: BTreeMap<Sd, Vec<usize>> = BTreeMap::new();
        for (i, p) in PATTERNS.iter().enumerate() {
            match p.src {
                DagSrc::Node { op, .. } => by_root.entry(op).or_default().push(i),
                // `(i64 0)` and the like: a constant node.
                DagSrc::Int(_) => by_root.entry(Sd::Imm).or_default().push(i),
                _ => {}
            }
        }
        Table { by_root }
    }
}

/// Selection of one function: its matches by root op, and the ops folded into another.
pub struct Selected {
    pub roots: BTreeMap<OpId, Match>,
    pub folded: BTreeMap<OpId, OpId>,
}

pub struct Selector<'b, 'a> {
    body: &'b Body<'a>,
    table: &'b Table,
    slots: Option<&'b BTreeMap<ValueId, alloc::string::String>>,
    order: BTreeMap<OpId, (BlockId, usize)>,
    taken: BTreeSet<OpId>,
}

const I8_BITS: i64 = 8;

impl<'b, 'a> Selector<'b, 'a> {
    pub fn select(body: &'b Body<'a>, table: &'b Table, blocks: &[BlockId], slots: Option<&'b BTreeMap<ValueId, alloc::string::String>>) -> Selected {
        let mut order = BTreeMap::new();
        for &b in blocks {
            for (i, op) in body.block_ops(b).into_iter().enumerate() {
                order.insert(op, (b, i));
            }
        }
        let mut s = Selector { body, table, slots, order, taken: BTreeSet::new() };
        let mut roots = BTreeMap::new();
        let mut folded = BTreeMap::new();
        for &b in blocks {
            let ops: Vec<OpId> = body.block_ops(b);
            for &op in ops.iter().rev() {
                if s.taken.contains(&op) {
                    continue;
                }
                let Some(kid) = s.root_kid(op) else { continue };
                if let Some(m) = s.best(kid, op) {
                    s.claim(&m, op, &mut folded);
                    roots.insert(op, m);
                }
            }
        }
        Selected { roots, folded }
    }

    fn claim(&mut self, m: &Match, root: OpId, folded: &mut BTreeMap<OpId, OpId>) {
        for &f in &m.folded {
            self.taken.insert(f);
            folded.insert(f, root);
        }
        if let Some(fl) = &m.flags {
            self.claim(fl, root, folded);
        }
    }

    /// The node an op is as a root: its result's node, or a store / branch.
    fn root_kid(&self, op: OpId) -> Option<Kid> {
        let d = &self.body[op];
        match &*d.name {
            "llvm.store" | "llvm.cond_br" => Some(Kid::Cmp(op)),
            _ if d.results.len() == 1 => Some(Kid::V(d.results[0])),
            _ => None,
        }
    }

    fn mvt(&self, v: ValueId) -> Option<Mvt> {
        Mvt::try_from(&self.body[v].ty).ok()
    }

    /// The type of `v` when it is exactly an LLVM type (`i1`, `i7` are not their `i8`).
    fn exact(&self, v: ValueId) -> Option<Mvt> {
        let t = self.mvt(v)?;
        match &self.body[v].ty {
            mlirformat::Type::Integer { width, .. } if *width != t.bits() => None,
            _ => Some(t),
        }
    }

    fn constant(&self, v: ValueId) -> Option<i64> {
        let d = self.body.def_op(v)?;
        if self.body[d].name != "llvm.mlir.constant" {
            return None;
        }
        let t = self.mvt(v)?;
        let bits = Constant::bits(self.body, d, t).ok()?;
        Some(match t {
            Mvt::I1 | Mvt::I8 => i64::from(bits as u8 as i8),
            Mvt::I16 => i64::from(bits as u16 as i16),
            Mvt::I32 => i64::from(bits as u32 as i32),
            _ => bits.cast_signed(),
        })
    }

    fn icmp_cc(&self, op: OpId) -> Option<Cc> {
        Predicate::of::<ICmpPredicate>(self.body, op).ok().map(Lower::icmp_cc)
    }

    /// The `icmp` a condition is, when it is used only here and computed in this block.
    fn single_icmp(&self, c: ValueId, user: OpId) -> Option<OpId> {
        let d = self.body.def_op(c)?;
        (self.body[d].name == "llvm.icmp" && self.foldable(d, user)).then_some(d)
    }

    fn view(&self, k: Kid) -> Option<View> {
        let body = self.body;
        let kids = |ks: &[Kid]| ks.iter().copied().collect::<SmallVec<[Kid; 4]>>();
        match k {
            Kid::Cmp(op) => {
                let d = &body[op];
                match &*d.name {
                    "llvm.icmp" => Some(View { op: Sd::X86cmp, vt: Some(Mvt::I32), kids: kids(&[Kid::V(d.operands[0]), Kid::V(d.operands[1])]) }),
                    "llvm.store" => Some(View { op: Sd::St, vt: None, kids: kids(&[Kid::V(d.operands[0]), Kid::V(d.operands[1])]) }),
                    "llvm.cond_br" if d.operands.len() == 1 => {
                        let c = d.operands[0];
                        let t = d.successors[0];
                        match self.single_icmp(c, op) {
                            Some(i) => Some(View { op: Sd::X86brcond, vt: None, kids: kids(&[Kid::Bb(t), Kid::Cond(self.icmp_cc(i)?), Kid::Cmp(i)]) }),
                            None => Some(View { op: Sd::X86brcond, vt: None, kids: kids(&[Kid::Bb(t), Kid::Cond(Cc::Ne), Kid::Test(c)]) }),
                        }
                    }
                    _ => None,
                }
            }
            Kid::Test(v) => Some(View { op: Sd::X86cmp, vt: Some(Mvt::I32), kids: kids(&[Kid::V(v), Kid::Zero]) }),
            Kid::V(v) => {
                let op = body.def_op(v)?;
                let d = &body[op];
                let a = |i: usize| Kid::V(d.operands[i]);
                let vt = self.exact(v);
                let bin = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0), a(1)]) });
                let un = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0)]) });
                vt?;
                match &*d.name {
                    "llvm.add" => bin(Sd::Add),
                    "llvm.sub" => bin(Sd::Sub),
                    "llvm.mul" => bin(Sd::Mul),
                    "llvm.and" => bin(Sd::And),
                    "llvm.or" => bin(Sd::Or),
                    "llvm.xor" => bin(Sd::Xor),
                    "llvm.shl" | "llvm.lshr" | "llvm.ashr" => {
                        let sd = match &*d.name {
                            "llvm.shl" => Sd::Shl,
                            "llvm.lshr" => Sd::Srl,
                            _ => Sd::Sra,
                        };
                        Some(View { op: sd, vt, kids: kids(&[a(0), Kid::Amt(d.operands[1])]) })
                    }
                    "llvm.load" => Some(View { op: Sd::Ld, vt, kids: kids(&[a(0)]) }),
                    "llvm.icmp" => Some(View { op: Sd::X86setcc, vt: Some(Mvt::I8), kids: kids(&[Kid::Cond(self.icmp_cc(op)?), Kid::Cmp(op)]) }),
                    "llvm.select" => {
                        let c = d.operands[0];
                        let (t, f) = (Kid::V(d.operands[1]), Kid::V(d.operands[2]));
                        match self.single_icmp(c, op) {
                            Some(i) => Some(View { op: Sd::X86cmov, vt, kids: kids(&[f, t, Kid::Cond(self.icmp_cc(i)?), Kid::Cmp(i)]) }),
                            None => Some(View { op: Sd::X86cmov, vt, kids: kids(&[f, t, Kid::Cond(Cc::Ne), Kid::Test(c)]) }),
                        }
                    }
                    "llvm.zext" => self.exact(d.operands[0]).and_then(|_| un(Sd::Zext)),
                    "llvm.sext" => self.exact(d.operands[0]).and_then(|_| un(Sd::Sext)),
                    "llvm.trunc" => self.exact(d.operands[0]).and_then(|_| un(Sd::Trunc)),
                    "llvm.fadd" => bin(Sd::Fadd),
                    "llvm.fsub" => bin(Sd::Fsub),
                    "llvm.fmul" => bin(Sd::Fmul),
                    "llvm.fdiv" => bin(Sd::Fdiv),
                    "llvm.intr.sqrt" => un(Sd::Fsqrt),
                    "llvm.sitofp" => self.exact(d.operands[0]).and_then(|_| un(Sd::SintToFp)),
                    "llvm.fptosi" => un(Sd::FpToSint),
                    "llvm.fpext" => un(Sd::Fpextend),
                    "llvm.fptrunc" => un(Sd::Fpround),
                    "llvm.bitcast" => un(Sd::Bitconvert),
                    "llvm.mlir.constant" => Some(View { op: if vt.is_some_and(Mvt::is_float) { Sd::Fpimm } else { Sd::Imm }, vt, kids: SmallVec::new() }),
                    _ => None,
                }
            }
            Kid::Amt(v) => self.constant(v).map(|_| View { op: Sd::Imm, vt: Some(Mvt::I8), kids: SmallVec::new() }),
            Kid::Cond(_) => Some(View { op: Sd::Timm, vt: Some(Mvt::I8), kids: SmallVec::new() }),
            Kid::Bb(_) => Some(View { op: Sd::Bb, vt: None, kids: SmallVec::new() }),
            Kid::Zero => None,
        }
    }

    /// `op` can become part of `root`'s instruction: used once, there, in the same block, not
    /// taken by another root, and (a load) no write to memory between them.
    fn foldable(&self, op: OpId, root: OpId) -> bool {
        let d = &self.body[op];
        if self.taken.contains(&op) || d.results.len() != 1 || self.body[d.results[0]].uses.single().is_none_or(|u| u.op != root) {
            return false;
        }
        let (Some(&(b, i)), Some(&(rb, ri))) = (self.order.get(&op), self.order.get(&root)) else { return false };
        if b != rb || i >= ri {
            return false;
        }
        if d.name != "llvm.load" {
            return true;
        }
        self.body.block_ops(b).into_iter().skip(i + 1).take(ri - i - 1).all(|o| !matches!(&*self.body[o].name, "llvm.store" | "llvm.call"))
    }

    fn best(&self, kid: Kid, root: OpId) -> Option<Match> {
        let view = self.view(kid)?;
        for &i in self.table.by_root.get(&view.op)? {
            let mut m = Match { pat: i, caps: Vec::new(), flags: None, phys: Vec::new(), folded: Vec::new() };
            if self.matches(&PATTERNS[i].src, kid, root, true, &mut m) {
                return Some(m);
            }
        }
        None
    }

    fn cap(m: &mut Match, name: Option<u8>, c: Cap) {
        if let Some(n) = name {
            let n = usize::from(n);
            if m.caps.len() <= n {
                m.caps.resize(n + 1, Cap::None);
            }
            m.caps[n] = c;
        }
    }

    fn matches(&self, s: &Src<'_>, k: Kid, root: OpId, top: bool, m: &mut Match) -> bool {
        match *s {
            DagSrc::Node { op, vt, kids, preds, name } => {
                let Some(view) = self.view(k) else { return false };
                if view.op != op || (vt.is_some() && view.vt.is_some() && vt != view.vt) {
                    return false;
                }
                match op {
                    Sd::Imm | Sd::Fpimm => {
                        let v = match k {
                            Kid::V(v) | Kid::Amt(v) => v,
                            _ => return false,
                        };
                        let Some(mut c) = self.constant(v) else { return false };
                        if op == Sd::Fpimm {
                            c = self.mvt(v).and_then(|t| Constant::bits(self.body, self.body.def_op(v)?, t).ok()).map_or(c, |b| b.cast_signed());
                        }
                        if matches!(k, Kid::Amt(_)) && !(0..1 << I8_BITS).contains(&c) {
                            return false;
                        }
                        if !preds.iter().all(|p| p.imm(c)) {
                            return false;
                        }
                        Self::cap(m, name, Cap::Imm(c));
                        return true;
                    }
                    Sd::Timm => {
                        let Kid::Cond(c) = k else { return false };
                        Self::cap(m, name, Cap::Cond(c));
                        return true;
                    }
                    Sd::Bb => {
                        let Kid::Bb(b) = k else { return false };
                        Self::cap(m, name, Cap::Bb(b));
                        return true;
                    }
                    _ => {}
                }
                if view.kids.len() != kids.len() {
                    return false;
                }
                let def = match k {
                    Kid::V(v) => self.body.def_op(v),
                    Kid::Cmp(o) => Some(o),
                    _ => None,
                };
                if !top {
                    match (k, def) {
                        (Kid::V(_), Some(d)) if self.foldable(d, root) => m.folded.push(d),
                        (Kid::Cmp(d), _) if self.foldable(d, root) || d == root => m.folded.push(d),
                        (Kid::Test(_), _) => {}
                        _ => return false,
                    }
                }
                if !preds.iter().all(|p| p.node(self, def, root)) {
                    return false;
                }
                for (s, &k) in kids.iter().zip(view.kids.iter()) {
                    if !self.matches(s, k, root, false, m) {
                        return false;
                    }
                }
                if let Kid::V(v) = k {
                    Self::cap(m, name, Cap::Val(v));
                }
                true
            }
            DagSrc::Class { class, vt, preds, name } => {
                let v = match k {
                    Kid::V(v) => v,
                    _ => return false,
                };
                let Some(t) = self.mvt(v) else { return false };
                if vt.is_some_and(|w| w != t.legal()) || class.is_float() != t.is_float() || !preds.iter().all(|p| p.node(self, self.body.def_op(v), root)) {
                    return false;
                }
                Self::cap(m, name, Cap::Val(v));
                true
            }
            DagSrc::Complex { pat, name } => {
                let Kid::V(p) = k else { return false };
                match pat {
                    Complex::Addr => {
                        let a = self.address(p, root, m, false);
                        Self::cap(m, Some(name), Cap::Addr(a));
                        true
                    }
                    Complex::Lea64addr => {
                        let a = self.address(p, root, m, true);
                        if a.index.is_none() && a.disp == 0 {
                            return false;
                        }
                        Self::cap(m, Some(name), Cap::Addr(a));
                        true
                    }
                    Complex::Lea64Iaddr => false,
                    Complex::RelocImm => match self.constant(p) {
                        Some(c) => {
                            Self::cap(m, Some(name), Cap::Imm(c));
                            true
                        }
                        None => false,
                    },
                }
            }
            DagSrc::Phys(r) if r == Reg::EFLAGS => {
                // The compare is matched on its own, its uses checked where it is.
                let at = match k {
                    Kid::Cmp(c) => c,
                    Kid::Test(_) => root,
                    _ => return false,
                };
                match self.best(k, at) {
                    Some(f) => {
                        if at != root {
                            m.folded.push(at);
                        }
                        m.flags = Some(alloc::boxed::Box::new(f));
                        true
                    }
                    None => false,
                }
            }
            DagSrc::Phys(r) => match k {
                Kid::V(v) | Kid::Amt(v) => {
                    m.phys.push((r, v));
                    true
                }
                _ => false,
            },
            DagSrc::Int(n) => match k {
                Kid::V(v) | Kid::Amt(v) => self.constant(v) == Some(n),
                Kid::Zero => n == 0,
                _ => false,
            },
            DagSrc::Bb(name) => match k {
                Kid::Bb(b) => {
                    Self::cap(m, Some(name), Cap::Bb(b));
                    true
                }
                _ => false,
            },
            DagSrc::Any { name } => match k {
                Kid::V(v) => {
                    Self::cap(m, name, Cap::Val(v));
                    true
                }
                _ => false,
            },
        }
    }

    /// `X86DAGToDAGISel::selectAddr`, its common cases: a stencil frame slot, a
    /// `getelementptr` folded in (a constant offset, or a 64-bit index times 1, 2, 4 or 8).
    fn address(&self, p: ValueId, root: OpId, m: &mut Match, lea: bool) -> Addr {
        if self.slots.is_some_and(|s| s.contains_key(&p)) {
            return Addr { base: Base::Slot(p), index: None, disp: 0 };
        }
        let plain = Addr { base: Base::Val(p), index: None, disp: 0 };
        let Some(g) = self.body.def_op(p) else { return plain };
        if self.body[g].name != "llvm.getelementptr" || !self.foldable(g, root) {
            return plain;
        }
        let Some(size) = self.gep_size(g) else { return plain };
        let raw: Vec<i64> = match self.body[g].get("rawConstantIndices") {
            Some(mlirformat::Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse::<i64>().ok()).collect(),
            _ => return plain,
        };
        let base = self.body[g].operands[0];
        const DYNAMIC: i64 = i32::MIN as i64;
        let out = match raw[..] {
            [DYNAMIC] => {
                let i = self.body[g].operands[1];
                if self.exact(i) != Some(Mvt::I64) || !matches!(size, 1 | 2 | 4 | 8) {
                    return plain;
                }
                Addr { base: Base::Val(base), index: Some((i, u8::try_from(size).unwrap_or(1))), disp: 0 }
            }
            [c] => match i32::try_from(c * size) {
                Ok(d) => Addr { base: Base::Val(base), index: None, disp: d },
                Err(_) => return plain,
            },
            _ => return plain,
        };
        if lea && out.index.is_none() && out.disp == 0 {
            return plain;
        }
        m.folded.push(g);
        out
    }

    fn gep_size(&self, g: OpId) -> Option<i64> {
        match self.body[g].get("elem_type") {
            Some(mlirformat::Attribute::Type(t)) => Mvt::try_from(t).ok().map(|m| i64::from(m.bits().div_ceil(8))),
            _ => None,
        }
    }

    fn single_use(&self, def: Option<OpId>, root: OpId) -> bool {
        def.is_some_and(|d| self.foldable(d, root) || d == root)
    }
}

impl Pred {
    /// `ImmLeaf` predicates on a constant.
    fn imm(self, c: i64) -> bool {
        match self {
            Pred::I64immSExt32 | Pred::I64relocImmSExt32 => i32::try_from(c).is_ok(),
            Pred::I64immZExt32 => u32::try_from(c).is_ok(),
            Pred::Immff00Ffff => (0xff00..=0xffff).contains(&c),
            Pred::ImmSu | Pred::I64immSExt32Su | Pred::I64relocImmSExt32Su | Pred::RelocImm8Su | Pred::RelocImm16Su | Pred::RelocImm32Su => true,
            _ => false,
        }
    }

    /// The other `PatFrag` predicates, on the node `def` computes.
    fn node(self, s: &Selector<'_, '_>, def: Option<OpId>, root: OpId) -> bool {
        match self {
            // Loads are plain and unindexed; stores neither truncate nor skip the cache.
            Pred::Unindexedload | Pred::Load | Pred::Loadi8 | Pred::Loadi16 | Pred::Loadi32 | Pred::Unindexedstore | Pred::Store => true,
            Pred::Extload | Pred::Extloadi1 | Pred::Extloadi8 | Pred::Extloadi16 | Pred::Extloadi64i32 => false,
            Pred::Sextload | Pred::Sextloadi8 | Pred::Sextloadi16 | Pred::Sextloadi32 => false,
            Pred::Zextload | Pred::Zextloadi1 | Pred::Zextloadi8 | Pred::Zextloadi16 | Pred::Zextloadi32 => false,
            Pred::Nontemporalstore => false,
            // Every integer is kept zero-extended in its register.
            Pred::Def32 => true,
            Pred::AndSu | Pred::SrlSu | Pred::TruncSu => s.single_use(def, root),
            Pred::ShiftMask16 | Pred::ShiftMask32 | Pred::ShiftMask64 => false,
            p => def.is_some_and(|d| s.constant(s.body[d].results[0]).is_some_and(|c| p.imm(c))),
        }
    }
}

/// An operand a result node gives.
#[derive(Clone, Copy, Debug)]
enum Out {
    R(Reg),
    I(i64),
    M(Mem, Option<ValueId>),
    C(Cc),
    B(BlockId),
    None,
}

impl Lower<'_, '_> {
    /// Emits the match of `root`.
    pub fn emit_match(&mut self, root: OpId, m: &Match) -> Result<(), Error> {
        // The result computed where it lives: no operand of this op is there (it is live here).
        let into = match self.body[root].results.first().map(|&r| self.slot(r)) {
            Some(Ok(super::Loc::Gpr(u) | super::Loc::Xmm(u))) => Some(u),
            _ => None,
        };
        let out = self.emit_pattern(m, into)?;
        let body = self.body;
        if body[root].results.len() == 1 {
            let r = body[root].results[0];
            match out {
                Out::R(reg) => self.write(r, reg)?,
                o => return Err(Error(alloc::format!("{}: a result {o:?}", body[root].name))),
            }
        }
        if body[root].name == "llvm.cond_br" {
            let f = body[root].successors[1];
            self.jump_to(f);
        }
        Ok(())
    }

    /// The flags a match reads first, then its result.
    fn emit_pattern(&mut self, m: &Match, into: Option<Reg>) -> Result<Out, Error> {
        let mut temps: Vec<Reg> = [Reg::RAX, Reg::RDX, Reg::RSI, Reg::RDI, Reg::R8, Reg::R9, Reg::RCX].into_iter().filter(|t| !m.phys.iter().any(|(r, _)| r.unit() == *t)).collect();
        let mut ftemps: Vec<Reg> = Pool::FTEMPS.to_vec();
        if let Some(f) = &m.flags {
            self.emit_pattern(f, None)?;
        }
        for &(r, v) in &m.phys {
            self.read_into(v, r.unit())?;
        }
        self.emit_dst(&PATTERNS[m.pat].dst, m, &mut temps, &mut ftemps, into)
    }

    fn take(temps: &mut Vec<Reg>) -> Result<Reg, Error> {
        if temps.is_empty() {
            return Err(Error("out of temporaries".into()));
        }
        Ok(temps.remove(0))
    }

    fn reg_of(&mut self, v: ValueId, class: Class, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>) -> Result<Reg, Error> {
        let t = if class.is_float() { Self::take(ftemps)? } else { Self::take(temps)? };
        self.read(v, t, class)
    }

    fn dst_operand(&mut self, d: &Dst<'_>, m: &Match, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>, class: Option<Class>) -> Result<Out, Error> {
        Ok(match *d {
            DagDst::Ref(i) => match m.caps.get(usize::from(i)).copied().unwrap_or(Cap::None) {
                Cap::Val(v) => match class {
                    Some(c) => Out::R(self.reg_of(v, c, temps, ftemps)?),
                    None => Out::R(self.reg_of(v, Class::GR64, temps, ftemps)?),
                },
                Cap::Imm(c) => Out::I(c),
                Cap::Cond(c) => Out::C(c),
                Cap::Bb(b) => Out::B(b),
                Cap::Addr(a) => {
                    let (base, slot) = match a.base {
                        Base::Slot(p) => (Pool::FRAME, Some(p)),
                        Base::Val(p) => (self.reg_of(p, Class::GR64, temps, ftemps)?, None),
                    };
                    let index = match a.index {
                        Some((i, s)) => Some((self.reg_of(i, Class::GR64, temps, ftemps)?, s)),
                        None => None,
                    };
                    let mem = Mem { base, index, disp: a.disp, wide: slot.is_some() };
                    Out::M(mem, slot)
                }
                Cap::None => return Err(Error("a result refers to an operand not matched".into())),
            },
            DagDst::Int(n) => Out::I(n),
            DagDst::Phys(r) => Out::R(r),
            DagDst::XForm(x, inner) => match (x, self.dst_operand(inner, m, temps, ftemps, None)?) {
                (XForm::GetLo32XForm, Out::I(c)) => Out::I(i64::from(c as u32)),
                (XForm::InvCondXFORM, Out::C(c)) => Out::C(c.invert()),
                (x, o) => return Err(Error(alloc::format!("{x:?} of {o:?}"))),
            },
            DagDst::Extract(inner, _) | DagDst::SubregToReg(inner, _) | DagDst::Copy(inner) => self.dst_operand(inner, m, temps, ftemps, class)?,
            DagDst::Insert(base, inner, _) => match base {
                DagDst::ImplicitDef(_) => self.dst_operand(inner, m, temps, ftemps, class)?,
                _ => return Err(Error("INSERT_SUBREG into a value".into())),
            },
            DagDst::ImplicitDef(_) => Out::R(Self::take(temps)?),
            DagDst::Inst { .. } => self.emit_dst(d, m, temps, ftemps, None)?,
        })
    }

    fn emit_dst(&mut self, d: &Dst<'_>, m: &Match, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>, into: Option<Reg>) -> Result<Out, Error> {
        let DagDst::Inst { op, kids, .. } = *d else { return self.dst_operand(d, m, temps, ftemps, None) };
        // `X86InstrInfo::expandPostRAPseudo`: `MOV32r0` is `xor r, r`.
        if op == Opcode::MOV32r0 {
            let r = Class::GR32.of(match into {
                Some(u) if !u.is_xmm() => u,
                _ => Self::take(temps)?,
            });
            self.inst(Opcode::XOR32rr, &[X::R(r), X::R(r), X::R(r)]);
            return Ok(Out::R(r));
        }
        // The assembler's relaxation: a jump to a block may be far.
        let op = match op {
            Opcode::JCC_1 => Opcode::JCC_4,
            o => o,
        };
        let desc = op.desc();
        let outs = usize::from(desc.outs);
        if desc.operands.len() != outs + kids.len() {
            return Err(Error(alloc::format!("{}: {} operands for {}", op.name(), kids.len(), desc.operands.len() - outs)));
        }
        let tied = desc.tied.contains(&(1, 0));
        let mut ops: Vec<X> = Vec::new();
        let mut dst = None;
        let mut fixup = None;
        let mut hole = None;
        if outs == 1 {
            let c = desc.operands[0].class.ok_or_else(|| Error(alloc::format!("{}: a result without a class", op.name())))?;
            let unit = match into {
                Some(u) if u.is_xmm() == c.is_float() => u,
                _ if c.is_float() => Self::take(ftemps)?,
                _ => Self::take(temps)?,
            };
            dst = Some(c.of(unit));
            ops.push(X::R(c.of(unit)));
        }
        for (n, k) in kids.iter().enumerate() {
            let o = desc.operands[outs + n];
            let out = self.dst_operand(k, m, temps, ftemps, o.class)?;
            let x = match out {
                Out::R(r) => {
                    let r = o.class.map_or(r, |c| c.of(r));
                    if tied && outs + n == 1 {
                        let d = dst.expect("a tied result");
                        self.copy(d, r);
                        X::R(d)
                    } else {
                        X::R(r)
                    }
                }
                Out::I(i) => X::I(i),
                Out::M(mem, slot) => {
                    hole = slot;
                    X::M(mem)
                }
                Out::C(c) => X::C(c),
                Out::B(b) => {
                    fixup = Some(b);
                    X::Rel
                }
                Out::None => return Err(Error(alloc::format!("{}: an empty operand", op.name()))),
            };
            ops.push(x);
        }
        let placed = self.inst(op, &ops);
        if let (Some(b), Some(at)) = (fixup, placed.imm) {
            self.fixups.push((at, b));
        }
        if let (Some(p), Some(at)) = (hole, placed.disp) {
            let name = self.frame_slot(p).unwrap_or_default();
            self.hole(at, HoleKind::Disp32, name);
        }
        Ok(match dst {
            Some(r) => Out::R(r),
            None => desc.defs.iter().copied().find(|r| *r != Reg::EFLAGS).map_or(Out::None, Out::R),
        })
    }
}

impl Cc {
    /// `X86::GetOppositeBranchCondition`.
    pub const fn invert(self) -> Cc {
        match self {
            Cc::O => Cc::No,
            Cc::No => Cc::O,
            Cc::B => Cc::Ae,
            Cc::Ae => Cc::B,
            Cc::E => Cc::Ne,
            Cc::Ne => Cc::E,
            Cc::Be => Cc::A,
            Cc::A => Cc::Be,
            Cc::S => Cc::Ns,
            Cc::Ns => Cc::S,
            Cc::P => Cc::Np,
            Cc::Np => Cc::P,
            Cc::L => Cc::Ge,
            Cc::Ge => Cc::L,
            Cc::Le => Cc::G,
            Cc::G => Cc::Le,
        }
    }
}
