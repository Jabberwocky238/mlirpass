//! What the `tensor` and `memref` reshapes share, as `ReshapeOpsUtils`: reassociations, the
//! reshape fold, and the patterns composing reshapes.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Dim, ShapedKind, Type};

use super::MemrefOfr as Ofr;
use crate::{Body, Const, Fold, Folded, MemrefLayout, OpData, OpId, Pattern, Rewriter, ValueId};

/// `ReassociationIndices` of each result (collapse) or source (expand) dimension.
pub type Reassoc = Vec<Vec<i64>>;

/// A `[l, r]` range of source dimensions (`ReassociationIndexRange`).
#[derive(Clone, Copy)]
struct Range {
    l: i64,
    r: i64,
}

impl Range {
    fn within(self, n: i64) -> bool {
        self.l >= 0 && self.r <= n - 1
    }

    fn full(self) -> Vec<i64> {
        (self.l..=self.r).collect()
    }

    /// `getNonOverlappingIndicesWith`.
    fn non_overlapping(self, o: Range) -> Vec<i64> {
        if self.r < o.l {
            let mut v = self.full();
            v.extend(o.full());
            return v;
        }
        let mut v: Vec<i64> = (self.l.min(o.l)..self.l.max(o.l)).collect();
        let (rs, re) = (self.r.min(o.r) + 1, self.r.max(o.r));
        if rs < re {
            v.extend(rs..=re);
        }
        v
    }
}

/// The reassociation helpers.
pub struct Reshape;

impl Reshape {
    pub fn attr<'a>(r: &Reassoc) -> Attribute<'a> {
        let int = |x: &i64| Attribute::Int { lit: Cow::Owned(format!("{x}")), ty: None };
        Attribute::Array(r.iter().map(|g| Attribute::Array(g.iter().map(int).collect())).collect())
    }

    /// `composeReassociationIndices`.
    pub fn compose(producer: &Reassoc, consumer: &Reassoc) -> Option<Reassoc> {
        if producer.len() == consumer.len() {
            return None;
        }
        let (p, c) = if producer.len() < consumer.len() { (consumer, producer) } else { (producer, consumer) };
        if c.is_empty() {
            return Some(Vec::new());
        }
        if p.len() != c.iter().map(Vec::len).sum::<usize>() {
            return None;
        }
        Some(c.iter().map(|g| g.iter().flat_map(|i| p[*i as usize].iter().copied()).collect()).collect())
    }

    /// `findReassociationRangeForDynamicDim`.
    fn range_for_dynamic(src: &[i64], start: i64, greedy: bool) -> Option<Range> {
        let n = src.len() as i64;
        let mut it = Range { l: start, r: start };
        let mut res = None;
        while it.within(n) {
            if src[it.r as usize] == Dim::DYNAMIC {
                res = Some(it);
                break;
            }
            it.r += 1;
        }
        let mut res = res?;
        if greedy {
            res.r = n - 1;
        }
        Some(res)
    }

    /// `findReassociationRangeForSize`.
    fn range_for_size(src: &[i64], start: i64, target: i64, greedy: bool) -> Option<Range> {
        let n = src.len() as i64;
        let mut it = Range { l: start, r: start };
        let mut res = None;
        let mut prod: i64 = 1;
        while it.within(n) {
            let s = src[it.r as usize];
            if s == Dim::DYNAMIC {
                prod = 1;
                it = Range { l: it.r + 1, r: it.r + 1 };
                continue;
            }
            prod = prod.wrapping_mul(s);
            while prod > target && it.l != it.r {
                prod /= src[it.l as usize];
                it.l += 1;
            }
            if prod == target {
                res = Some(it);
                break;
            }
            it.r += 1;
        }
        let mut res = res?;
        if greedy {
            it.r += 1;
            while it.within(n) && src[it.r as usize] == 1 {
                res = it;
                it.r += 1;
            }
        }
        Some(res)
    }

    /// `findReassociationRangesForCollapse`, left to right.
    fn ranges(src: &[i64], tgt: &[i64]) -> Option<Vec<Range>> {
        let n = src.len() as i64;
        let mut out: Vec<Range> = Vec::new();
        let mut prev: Option<i64> = None;
        let mut s = 0i64;
        for (t, ts) in tgt.iter().enumerate() {
            let greedy = t == tgt.len() - 1;
            let r = if *ts == Dim::DYNAMIC { Self::range_for_dynamic(src, s, greedy) } else { Self::range_for_size(src, s, *ts, greedy) };
            let r = r.filter(|r| r.l >= 0 && r.l <= r.r && r.within(n))?;
            if r.l > s {
                if prev != Some(Dim::DYNAMIC) {
                    return None;
                }
                out.last_mut()?.r = r.l - 1;
            }
            prev = Some(*ts);
            s = r.r + 1;
            out.push(r);
        }
        if out.last()?.r < n - 1 {
            return None;
        }
        Some(out)
    }

    /// The same, right to left, as ranges of the original order.
    fn ranges_reversed(src: &[i64], tgt: &[i64]) -> Option<Vec<Range>> {
        let rs: Vec<i64> = src.iter().rev().copied().collect();
        let rt: Vec<i64> = tgt.iter().rev().copied().collect();
        let n = src.len() as i64;
        let mut out: Vec<Range> = Self::ranges(&rs, &rt)?.into_iter().map(|r| Range { l: n - 1 - r.r, r: n - 1 - r.l }).collect();
        out.reverse();
        Some(out)
    }

    /// `getReassociationIndicesForCollapse`.
    pub fn for_collapse(src: &[i64], tgt: &[i64]) -> Option<Reassoc> {
        if src.len() <= tgt.len() {
            return None;
        }
        if tgt.is_empty() {
            return src.iter().all(|s| *s == 1 || *s == Dim::DYNAMIC).then(Vec::new);
        }
        let fwd = Self::ranges(src, tgt)?;
        let rev = Self::ranges_reversed(src, tgt)?;
        if fwd.len() != tgt.len() || rev.len() != tgt.len() {
            return None;
        }
        let mut out = Vec::new();
        for (f, r) in fwd.iter().zip(&rev) {
            if f.non_overlapping(*r).iter().any(|i| src[*i as usize] != 1) {
                return None;
            }
            out.push(f.full());
        }
        Some(out)
    }

    /// `hasNonIdentityLayout`.
    fn non_identity(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == ShapedKind::MemRef && !s.identity_layout())
    }

    fn rank(t: &Type<'_>) -> usize {
        t.shape().map_or(0, <[Dim]>::len)
    }
}

impl<'a> Body<'a> {
    /// The `reassociation` of a reshape.
    pub fn reassociation(&self, op: OpId) -> Reassoc {
        let int = |a: &Attribute<'_>| if let Attribute::Int { lit, .. } = a { lit.parse().ok() } else { None };
        match self[op].get("reassociation") {
            Some(Attribute::Array(gs)) => gs.iter().map(|g| if let Attribute::Array(xs) = g { xs.iter().filter_map(int).collect() } else { Vec::new() }).collect(),
            _ => Vec::new(),
        }
    }

    /// `getMixedOutputShape` of an `expand_shape`.
    pub fn mixed_output_shape(&self, op: OpId) -> Vec<Ofr> {
        let mut dynamic = self[op].operands[1..].iter();
        self.dense_i64(op, "static_output_shape").into_iter().map(|s| if s == Dim::DYNAMIC { Ofr::V(*dynamic.next().expect("dynamic")) } else { Ofr::C(s) }).collect()
    }

    /// `foldReshapeOp<ReshapeOp, InverseReshapeOp>`.
    pub fn fold_reshape(&mut self, op: OpId, inverse: &str, src_const: Option<&Attribute<'a>>) -> Fold<'a> {
        let (src, res) = (self[op].operands[0], self[op].results[0]);
        if self[src].ty == self[res].ty {
            return Folded::Value(src).into();
        }
        if let Some(c) = src_const.and_then(|a| Const::try_from(a).ok()).filter(|c| c.elements) {
            return Folded::Attr(Const { ty: self[res].ty.clone(), ..c }.into()).into();
        }
        let Some(p) = self.def_named(src, inverse) else { return Fold::Failed };
        let psrc = self[p].operands[0];
        if self[psrc].ty != self[res].ty {
            return Fold::Failed;
        }
        let shape = self[psrc].ty.dims().unwrap_or_default();
        let dynamic = |s: &[i64]| s.iter().filter(|x| **x == Dim::DYNAMIC).count();
        if dynamic(&shape) < 2 {
            return Folded::Value(psrc).into();
        }
        let r = self.reassociation(op);
        if r != self.reassociation(p) {
            return Fold::Failed;
        }
        if Reshape::rank(&self[psrc].ty) < Reshape::rank(&self[self[p].results[0]].ty) {
            return Folded::Value(psrc).into();
        }
        if r.iter().all(|g| g.first().is_none_or(|f| dynamic(&shape[*f as usize..*f as usize + g.len()]) < 2)) {
            return Folded::Value(psrc).into();
        }
        Fold::Failed
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// A `collapse_shape` of `dialect`.
    fn collapse_data(dialect: &str, src: ValueId, r: &Reassoc) -> OpData<'a> {
        OpData::build(&format!("{dialect}.collapse_shape")).operands(&[src]).with("reassociation", Reshape::attr(r))
    }

    /// An `expand_shape` of `dialect` to `shape`.
    pub fn expand_data(dialect: &str, src: ValueId, r: &Reassoc, shape: &[Ofr]) -> OpData<'a> {
        let mut ops = vec![src];
        let mut statics = Vec::new();
        for s in shape {
            match s {
                Ofr::C(c) => statics.push(*c),
                Ofr::V(v) => {
                    ops.push(*v);
                    statics.push(Dim::DYNAMIC);
                }
            }
        }
        let values = statics.iter().map(|x| Cow::Owned(format!("{x}"))).collect();
        OpData::build(&format!("{dialect}.expand_shape")).operands(&ops).with("reassociation", Reshape::attr(r)).with("static_output_shape", Attribute::DenseArray { ty: Type::int(64), values })
    }

    fn index_mul(&mut self, a: ValueId, b: ValueId) -> ValueId {
        let o = self.create(OpData::build("arith.muli").operands(&[a, b]), &[Type::Index]);
        self.body[o].results[0]
    }
}

/// `ComposeReassociativeReshapeOps`: a reshape of a reshape of the same kind.
pub struct ComposeReassociative {
    pub name: &'static str,
    pub dialect: &'static str,
    pub root: &'static str,
    pub expand: bool,
}

impl Pattern for ComposeReassociative {
    fn name(&self) -> &str {
        self.name
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(s) = b.def_named(b[op].operands[0], self.root) else { return false };
        let res = b[op].results[0];
        if Reshape::non_identity(&b[b[s].operands[0]].ty) || Reshape::non_identity(&b[b[op].operands[0]].ty) || Reshape::non_identity(&b[res].ty) {
            return false;
        }
        let Some(r) = Reshape::compose(&b.reassociation(s), &b.reassociation(op)) else { return false };
        let ty = b[res].ty.clone();
        let src = b[s].operands[0];
        let data = if self.expand { Rewriter::expand_data(self.dialect, src, &r, &b.mixed_output_shape(op)) } else { Rewriter::collapse_data(self.dialect, src, &r) };
        rw.replace_with(op, data, &[ty]);
        true
    }
}

/// `ComposeCollapseOfExpandOp`.
pub struct ComposeCollapseOfExpand {
    pub name: &'static str,
    pub dialect: &'static str,
}

impl Pattern for ComposeCollapseOfExpand {
    fn name(&self) -> &str {
        self.name
    }

    fn root(&self) -> Option<&str> {
        match self.dialect {
            "tensor" => Some("tensor.collapse_shape"),
            _ => Some("memref.collapse_shape"),
        }
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(e) = b.def_named(b[op].operands[0], &format!("{}.expand_shape", self.dialect)) else { return false };
        let src = b[e].operands[0];
        let (st, rt) = (b[src].ty.clone(), b[b[op].results[0]].ty.clone());
        if Reshape::non_identity(&b[b[op].operands[0]].ty) || Reshape::non_identity(&st) || Reshape::non_identity(&b[b[e].results[0]].ty) {
            return false;
        }
        let (sr, rr) = (Reshape::rank(&st), Reshape::rank(&rt));
        if st == rt {
            return false;
        }
        let (higher, lower) = if sr > rr { (b.reassociation(e), b.reassociation(op)) } else { (b.reassociation(op), b.reassociation(e)) };
        let mut at = 0;
        let mut composed: Reassoc = Vec::new();
        for low in &lower {
            let Some(&last) = low.last() else { return false };
            let mut group = Vec::new();
            while at < higher.len() {
                let right = *higher[at].last().expect("non-empty");
                if right > last {
                    return false;
                }
                group.push(at as i64);
                at += 1;
                if right == last {
                    break;
                }
            }
            composed.push(group);
        }
        if sr > rr {
            rw.replace_with(op, Rewriter::collapse_data(self.dialect, src, &composed), &[rt]);
        } else if sr < rr {
            let orig = b.mixed_output_shape(e);
            let groups = b.reassociation(op);
            rw.set_before(op);
            let mut shape = Vec::new();
            for g in groups {
                let mut statics = 1i64;
                let mut dynamic = Vec::new();
                for i in g {
                    match rw.body.ofr_int(orig[i as usize]) {
                        Some(c) => statics = statics.wrapping_mul(c),
                        None => dynamic.push(orig[i as usize]),
                    }
                }
                if dynamic.is_empty() {
                    shape.push(Ofr::C(statics));
                    continue;
                }
                let val = |o: &Ofr| if let Ofr::V(v) = o { *v } else { unreachable!() };
                let mut acc = val(&dynamic[0]);
                for v in &dynamic[1..] {
                    acc = rw.index_mul(acc, val(v));
                }
                if statics != 1 {
                    let k = rw.emit(&arith::Constant::new(Attribute::index(statics), Type::Index));
                    let k = rw.body[k].results[0];
                    acc = rw.index_mul(acc, k);
                }
                shape.push(Ofr::V(acc));
            }
            rw.replace_with(op, Rewriter::expand_data(self.dialect, src, &composed, &shape), &[rt]);
        } else {
            rw.replace_with(op, OpData::build(&format!("{}.cast", self.dialect)).operands(&[src]), &[rt]);
        }
        true
    }
}

/// `ComposeExpandOfCollapseOp`.
pub struct ComposeExpandOfCollapse {
    pub name: &'static str,
    pub dialect: &'static str,
}

impl ComposeExpandOfCollapse {
    /// `findCollapsingReassociation`.
    fn find(src_r: &Reassoc, res_r: &Reassoc, src: &[i64], res: &[i64]) -> Option<Reassoc> {
        if src_r.is_empty() {
            return Reshape::for_collapse(src, res);
        }
        let dynamic = |s: &[i64]| s.iter().filter(|x| **x == Dim::DYNAMIC).count();
        let mut out = Vec::new();
        for (si, ri) in src_r.iter().zip(res_r) {
            let (sf, rf) = (si[0] as usize, ri[0] as usize);
            let (ss, rs) = (&src[sf..sf + si.len()], &res[rf..rf + ri.len()]);
            if dynamic(ss) >= 2 && dynamic(rs) >= 2 {
                return None;
            }
            if ss.len() == rs.len() {
                if ss != rs {
                    return None;
                }
                out.extend((0..ss.len()).map(|k| vec![(sf + k) as i64]));
                continue;
            }
            for g in Reshape::for_collapse(ss, rs)? {
                out.push(g.iter().map(|i| i + sf as i64).collect());
            }
        }
        Some(out)
    }
}

impl Pattern for ComposeExpandOfCollapse {
    fn name(&self) -> &str {
        self.name
    }

    fn root(&self) -> Option<&str> {
        match self.dialect {
            "tensor" => Some("tensor.expand_shape"),
            _ => Some("memref.expand_shape"),
        }
    }

    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(c) = b.def_named(b[op].operands[0], &format!("{}.collapse_shape", self.dialect)) else { return false };
        let src = b[c].operands[0];
        let (st, rt) = (b[src].ty.clone(), b[b[op].results[0]].ty.clone());
        if Reshape::non_identity(&b[b[op].operands[0]].ty) || Reshape::non_identity(&st) || Reshape::non_identity(&b[b[c].results[0]].ty) {
            return false;
        }
        let (sr, rr) = (Reshape::rank(&st), Reshape::rank(&rt));
        if sr == rr {
            return false;
        }
        let (src_r, res_r) = (b.reassociation(c), b.reassociation(op));
        let (ss, rs) = (st.dims().unwrap_or_default(), rt.dims().unwrap_or_default());
        if sr > rr {
            let Some(composed) = Self::find(&src_r, &res_r, &ss, &rs) else { return false };
            rw.replace_with(op, Rewriter::collapse_data(self.dialect, src, &composed), &[rt]);
            return true;
        }
        let Some(composed) = Self::find(&res_r, &src_r, &rs, &ss) else { return false };
        let shape = b.mixed_output_shape(op);
        rw.replace_with(op, Rewriter::expand_data(self.dialect, src, &composed, &shape), &[rt]);
        true
    }
}
