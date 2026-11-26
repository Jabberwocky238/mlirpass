//! The SelectionDAG instruction selection both CPU targets share (`SelectionDAGISel`'s
//! matching): a block's ops seen as the nodes a target's lowering leaves (`Lowering::view`), each
//! root matched against the generated patterns in LLVM's order, single-use operands folded in.
//! Which nodes exist, the complex patterns and the predicates are each target's.

use alloc::boxed::Box;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use smallvec::SmallVec;

use super::{Constant, DagPattern, DagSrc, Mvt, Sd};
use crate::{BlockId, Body, OpId, ValueId};

/// What a node's operand is.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kid {
    V(ValueId),
    /// A shift amount: the patterns' amount type, whatever its own.
    Amt(ValueId),
    /// The compare an `icmp` is.
    Cmp(OpId),
    /// The compare of a value against zero.
    Test(ValueId),
    /// A constant the lowering puts there (the zero of a `Test`, the `1` of a `cset`).
    Const(i64),
    /// A condition code, the target's number.
    Cond(u8),
    Bb(BlockId),
    /// A store or a branch: the root op itself.
    Root(OpId),
}

pub struct View {
    pub op: Sd,
    pub vt: Option<Mvt>,
    pub kids: SmallVec<[Kid; 4]>,
}

/// `base + index (scaled) + disp`, or a stencil's frame slot.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Base {
    Val(ValueId),
    Slot(ValueId),
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Addr {
    pub base: Base,
    pub index: Option<(ValueId, u8)>,
    pub disp: i32,
}

/// What a pattern's named operand matched.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Cap {
    None,
    Val(ValueId),
    Imm(i64),
    Addr(Addr),
    Cond(u8),
    Bb(BlockId),
    /// A register and the shift applied to it (AArch64's shifted-register operands).
    Shifted(ValueId, i64),
}

/// A root matched: the pattern, its operands, the flags it reads (the compare matched on its
/// own, emitted first), values copied to physical registers, the ops folded into it.
pub struct Match<R> {
    pub pat: usize,
    pub caps: Vec<Cap>,
    pub flags: Option<Box<Match<R>>>,
    pub phys: Vec<(R, ValueId)>,
    pub folded: Vec<OpId>,
}

impl<R> Match<R> {
    pub fn set(&mut self, name: u8, c: Cap) {
        let n = usize::from(name);
        if self.caps.len() <= n {
            self.caps.resize(n + 1, Cap::None);
        }
        self.caps[n] = c;
    }
}

/// A target's side of the selection.
pub trait Lowering: Sized {
    type Opcode: Copy;
    type Class: Copy;
    type Reg: Copy + PartialEq;
    type Pred: Copy;
    type Complex: Copy;
    type SubReg: Copy;
    type XForm: Copy;

    /// The flags register a compare defines and a branch reads.
    const FLAGS: Self::Reg;
    /// The node a condition code is (`timm` on x86, `imm` on AArch64).
    const COND: Sd;

    fn patterns<'t>() -> &'t [DagPattern<'t, Self::Opcode, Self::Class, Self::Reg, Self::Pred, Self::Complex, Self::SubReg, Self::XForm>];
    fn is_float(c: Self::Class) -> bool;
    /// The node `k` is, as the target's lowering leaves the llvm dialect.
    fn view(s: &Selector<'_, '_, Self>, k: Kid) -> Option<View>;
    /// A predicate on a constant.
    fn imm(p: Self::Pred, c: i64) -> bool;
    /// A predicate on the node `def` computes, part of `root`.
    fn node(p: Self::Pred, s: &Selector<'_, '_, Self>, def: Option<OpId>, root: OpId) -> bool;
    /// A complex pattern on `k`: its operands set by name.
    fn complex(s: &Selector<'_, '_, Self>, pat: Self::Complex, names: &[u8], k: Kid, root: OpId, m: &mut Match<Self::Reg>) -> bool;
}

/// Selection of one function: its matches by root op, and each op folded into another.
pub struct Selected<R> {
    pub roots: BTreeMap<OpId, Match<R>>,
    pub folded: BTreeMap<OpId, OpId>,
}

pub struct Selector<'b, 'a, T: Lowering> {
    pub body: &'b Body<'a>,
    pub slots: Option<&'b BTreeMap<ValueId, alloc::string::String>>,
    by_root: BTreeMap<Sd, Vec<usize>>,
    order: BTreeMap<OpId, (BlockId, usize)>,
    taken: BTreeSet<OpId>,
    _t: core::marker::PhantomData<T>,
}

impl<'b, 'a, T: Lowering> Selector<'b, 'a, T> {
    pub fn select(body: &'b Body<'a>, blocks: &[BlockId], slots: Option<&'b BTreeMap<ValueId, alloc::string::String>>) -> Selected<T::Reg> {
        let mut by_root: BTreeMap<Sd, Vec<usize>> = BTreeMap::new();
        for (i, p) in T::patterns().iter().enumerate() {
            match p.src {
                DagSrc::Node { op, .. } => by_root.entry(op).or_default().push(i),
                // `(i64 0)` and the like: a constant node.
                DagSrc::Int(_) => by_root.entry(Sd::Imm).or_default().push(i),
                _ => {}
            }
        }
        let mut order = BTreeMap::new();
        for &b in blocks {
            for (i, op) in body.block_ops(b).into_iter().enumerate() {
                order.insert(op, (b, i));
            }
        }
        let mut s = Selector::<T> { body, slots, by_root, order, taken: BTreeSet::new(), _t: core::marker::PhantomData };
        let (mut roots, mut folded) = (BTreeMap::new(), BTreeMap::new());
        for &b in blocks {
            for op in body.block_ops(b).into_iter().rev() {
                if s.taken.contains(&op) {
                    continue;
                }
                let d = &body[op];
                let kid = match &*d.name {
                    "llvm.store" | "llvm.cond_br" => Kid::Root(op),
                    _ if d.results.len() == 1 => Kid::V(d.results[0]),
                    _ => continue,
                };
                if let Some(m) = s.best(kid, op) {
                    s.claim(&m, op, &mut folded);
                    roots.insert(op, m);
                }
            }
        }
        Selected { roots, folded }
    }

    fn claim(&mut self, m: &Match<T::Reg>, root: OpId, folded: &mut BTreeMap<OpId, OpId>) {
        for &f in &m.folded {
            self.taken.insert(f);
            folded.insert(f, root);
        }
        if let Some(fl) = &m.flags {
            self.claim(fl, root, folded);
        }
    }

    pub fn mvt(&self, v: ValueId) -> Option<Mvt> {
        Mvt::try_from(&self.body[v].ty).ok()
    }

    /// The type of `v` when it is exactly an LLVM type (`i1`, `i7` are not their `i8`).
    pub fn exact(&self, v: ValueId) -> Option<Mvt> {
        let t = self.mvt(v)?;
        match &self.body[v].ty {
            mlirformat::Type::Integer { width, .. } if *width != t.bits() => None,
            _ => Some(t),
        }
    }

    /// The constant `v` is, sign-extended from its type.
    pub fn constant(&self, v: ValueId) -> Option<i64> {
        let d = self.body.def_op(v)?;
        if self.body[d].name != "llvm.mlir.constant" {
            return None;
        }
        let t = self.mvt(v)?;
        let bits = Constant::bits(self.body, d, t).ok()?;
        Some(match t {
            Mvt::I1 | Mvt::I8 => i64::from(bits as u8 as i8),
            Mvt::I16 => i64::from(bits as u16 as i16),
            Mvt::I32 | Mvt::F32 => i64::from(bits as u32 as i32),
            _ => bits.cast_signed(),
        })
    }

    pub fn is_slot(&self, p: ValueId) -> bool {
        self.slots.is_some_and(|s| s.contains_key(&p))
    }

    /// The `icmp` a condition is, when it is used only here and computed in this block.
    pub fn single_icmp(&self, c: ValueId, user: OpId) -> Option<OpId> {
        let d = self.body.def_op(c)?;
        (self.body[d].name == "llvm.icmp" && self.foldable(d, user)).then_some(d)
    }

    /// `op` can become part of `root`'s instructions: used once, there, in the same block
    /// before it, not taken by another root, and (a load) no write to memory between them.
    pub fn foldable(&self, op: OpId, root: OpId) -> bool {
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

    pub fn single_use(&self, def: Option<OpId>, root: OpId) -> bool {
        def.is_some_and(|d| self.foldable(d, root) || d == root)
    }

    pub fn best(&self, kid: Kid, root: OpId) -> Option<Match<T::Reg>> {
        let view = T::view(self, kid)?;
        for &i in self.by_root.get(&view.op)? {
            let mut m = Match { pat: i, caps: Vec::new(), flags: None, phys: Vec::new(), folded: Vec::new() };
            if self.matches(&T::patterns()[i].src, kid, root, true, &mut m) {
                return Some(m);
            }
        }
        None
    }

    fn matches(&self, s: &DagSrc<'_, T::Class, T::Reg, T::Pred, T::Complex>, k: Kid, root: OpId, top: bool, m: &mut Match<T::Reg>) -> bool {
        match *s {
            DagSrc::Node { op, vt, kids, preds, name } => {
                if let (Kid::Cond(c), true) = (k, op == T::COND) {
                    if let Some(n) = name {
                        m.set(n, Cap::Cond(c));
                    }
                    return true;
                }
                let Some(view) = T::view(self, k) else { return false };
                if view.op != op || (vt.is_some() && view.vt.is_some() && vt != view.vt) {
                    return false;
                }
                match op {
                    Sd::Imm | Sd::Fpimm => {
                        let (Kid::V(v) | Kid::Amt(v)) = k else { return false };
                        let Some(c) = self.constant(v) else { return false };
                        if matches!(k, Kid::Amt(_)) && !(0..i64::from(Mvt::I64.bits())).contains(&c) {
                            return false;
                        }
                        if !preds.iter().all(|&p| T::imm(p, c)) {
                            return false;
                        }
                        if let Some(n) = name {
                            m.set(n, Cap::Imm(c));
                        }
                        return true;
                    }
                    Sd::Bb => {
                        let Kid::Bb(b) = k else { return false };
                        if let Some(n) = name {
                            m.set(n, Cap::Bb(b));
                        }
                        return true;
                    }
                    _ => {}
                }
                if view.kids.len() != kids.len() {
                    return false;
                }
                let def = match k {
                    Kid::V(v) => self.body.def_op(v),
                    Kid::Cmp(o) | Kid::Root(o) => Some(o),
                    _ => None,
                };
                if !top {
                    match (k, def) {
                        (Kid::V(_), Some(d)) if self.foldable(d, root) => m.folded.push(d),
                        (Kid::Cmp(d), _) if self.foldable(d, root) => m.folded.push(d),
                        (Kid::Test(_), _) => {}
                        _ => return false,
                    }
                }
                if !preds.iter().all(|&p| T::node(p, self, def, root)) {
                    return false;
                }
                for (s, &k) in kids.iter().zip(view.kids.iter()) {
                    if !self.matches(s, k, root, false, m) {
                        return false;
                    }
                }
                if let (Kid::V(v), Some(n)) = (k, name) {
                    m.set(n, Cap::Val(v));
                }
                true
            }
            DagSrc::Class { class, vt, preds, name } => {
                let Kid::V(v) = k else { return false };
                let Some(t) = self.mvt(v) else { return false };
                if vt.is_some_and(|w| w != t.legal()) || T::is_float(class) != t.is_float() || !preds.iter().all(|&p| T::node(p, self, self.body.def_op(v), root)) {
                    return false;
                }
                if let Some(n) = name {
                    m.set(n, Cap::Val(v));
                }
                true
            }
            DagSrc::Complex { pat, names } => T::complex(self, pat, names, k, root, m),
            DagSrc::Phys(r) if r == T::FLAGS => {
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
                        m.flags = Some(Box::new(f));
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
                Kid::Const(c) => n == c,
                _ => false,
            },
            DagSrc::Bb(name) => match k {
                Kid::Bb(b) => {
                    m.set(name, Cap::Bb(b));
                    true
                }
                _ => false,
            },
            DagSrc::Any { name } => match k {
                Kid::V(v) => {
                    if let Some(n) = name {
                        m.set(n, Cap::Val(v));
                    }
                    true
                }
                _ => false,
            },
        }
    }

    /// The common part of `selectAddr` / `SelectAddrModeIndexed`: a stencil frame slot, or a
    /// `getelementptr` folded in (a constant byte offset, or a 64-bit index times its size).
    pub fn address(&self, p: ValueId, root: OpId, m: &mut Match<T::Reg>) -> Addr {
        if self.is_slot(p) {
            return Addr { base: Base::Slot(p), index: None, disp: 0 };
        }
        let plain = Addr { base: Base::Val(p), index: None, disp: 0 };
        let Some(g) = self.body.def_op(p) else { return plain };
        if self.body[g].name != "llvm.getelementptr" || !self.foldable(g, root) {
            return plain;
        }
        let size = match self.body[g].get("elem_type") {
            Some(mlirformat::Attribute::Type(t)) => match Mvt::try_from(t) {
                Ok(m) => i64::from(m.bits().div_ceil(8)),
                Err(_) => return plain,
            },
            _ => return plain,
        };
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
        m.folded.push(g);
        out
    }
}
