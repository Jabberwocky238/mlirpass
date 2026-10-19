//! The vector-to-vector lowerings `convert-vector-to-llvm` runs first, as
//! `Vector/Transforms/Lower*.cpp` and `VectorTransforms.cpp`, and the transfer lowerings it
//! also runs during the conversion.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use crate::canon::{AttrExt, rewrites};
use crate::{ApInt, Body, Const, ConversionRewriter, LlvmOptions, OpData, OpId, PatternSet, Rewriter, Scalar, ValueId, DYNAMIC};

/// What a lowering needs of its rewriter: the greedy one and the conversion one both do.
pub trait Build<'a> {
    fn body(&self) -> &Body<'a>;
    /// A new op at the insertion point.
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId;
    fn replace(&mut self, op: OpId, values: &[ValueId]);
    fn remove(&mut self, op: OpId);
    fn before(&mut self, op: OpId);

    fn make1(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.make(data, &[ty]);
        self.body()[o].results[0]
    }
}

impl<'a> Build<'a> for Rewriter<'_, 'a> {
    fn body(&self) -> &Body<'a> {
        self.body
    }
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.create(data, types)
    }
    fn replace(&mut self, op: OpId, values: &[ValueId]) {
        self.replace_op(op, values);
    }
    fn remove(&mut self, op: OpId) {
        self.erase_op(op);
    }
    fn before(&mut self, op: OpId) {
        self.set_before(op);
    }
}

impl<'a> Build<'a> for ConversionRewriter<'_, 'a, '_> {
    fn body(&self) -> &Body<'a> {
        self.rw.body
    }
    fn make(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        self.rw.create(data, types)
    }
    fn replace(&mut self, op: OpId, values: &[ValueId]) {
        self.replace_values(op, values);
    }
    fn remove(&mut self, op: OpId) {
        self.erase(op);
    }
    fn before(&mut self, op: OpId) {
        self.rw.set_before(op);
    }
}

pub(super) fn vshape(t: &Type<'_>) -> Option<(Vec<i64>, Vec<bool>)> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::Vector => {
            let dims = s.shape.as_ref()?;
            Some((dims.iter().map(|d| if let Dim::Static(n) | Dim::Scalable(n) = d { *n } else { DYNAMIC }).collect(), dims.iter().map(|d| matches!(d, Dim::Scalable(_))).collect()))
        }
        _ => None,
    }
}

pub(super) fn elem<'x, 'a>(t: &'x Type<'a>) -> &'x Type<'a> {
    crate::attr::element_type(t)
}

pub fn vector_type<'a>(shape: &[i64], scalable: &[bool], e: Type<'a>) -> Type<'a> {
    Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(shape.iter().zip(scalable.iter().chain(core::iter::repeat(&false))).map(|(n, s)| if *s { Dim::Scalable(*n) } else { Dim::Static(*n) }).collect()), elem: e.into(), extras: Vec::new() })
}

pub(super) fn dense_i64<'a>(v: &[i64]) -> Attribute<'a> {
    Attribute::DenseArray { ty: Type::int(64), values: v.iter().map(|x| format!("{x}").into()).collect() }
}

pub(super) fn index_attr<'a>(v: i64) -> Attribute<'a> {
    Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::Index) }
}

fn zeros<'a>(ty: &Type<'a>) -> Attribute<'a> {
    let z = match elem(ty) {
        Type::Float(k) => Scalar::Float(crate::ApFloat::from_f64(*k, 0.0).expect("zero")),
        t => Scalar::Int(ApInt::new(crate::bit_width(t).unwrap_or(64), 0)),
    };
    Const::splat(z, ty.clone()).into()
}

/// Vector-op builders shared by the lowerings.
pub(super) trait VectorBuild<'a>: Build<'a> {
    fn vextract_(&mut self, v: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.body()[v].ty.clone();
        let (shape, scal) = vshape(&ty).expect("a vector");
        let rt = if pos.len() == shape.len() { elem(&ty).clone() } else { vector_type(&shape[pos.len()..], &scal[pos.len()..], elem(&ty).clone()) };
        self.make1(OpData::build("vector.extract").operands(&[v]).with("static_position", dense_i64(pos)), rt)
    }

    fn vinsert(&mut self, v: ValueId, dest: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.body()[dest].ty.clone();
        self.make1(OpData::build("vector.insert").operands(&[v, dest]).with("static_position", dense_i64(pos)), ty)
    }

    fn broadcast(&mut self, ty: Type<'a>, v: ValueId) -> ValueId {
        self.make1(OpData::build("vector.broadcast").operands(&[v]), ty)
    }

    fn poison(&mut self, ty: Type<'a>) -> ValueId {
        self.make1(OpData::build("ub.poison").with("value", Attribute::dialect("ub.poison", "")), ty)
    }

    fn constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        self.make1(OpData::build("arith.constant").with("value", value), ty)
    }
}

impl<'a, B: Build<'a> + ?Sized> VectorBuild<'a> for B {}

impl<'a> Body<'a> {
    pub(super) fn xfer_segments(&self, op: OpId) -> Vec<usize> {
        self.segments(op, "operandSegmentSizes").unwrap_or_default()
    }

    /// (base, indices, padding / vector, mask) of a transfer.
    pub(super) fn xfer_parts(&self, op: OpId) -> (ValueId, Vec<ValueId>, ValueId, Option<ValueId>) {
        let s = self.xfer_segments(op);
        let o = &self[op].operands;
        if self[op].name == "vector.transfer_read" {
            let idx = o[1..1 + s[1]].to_vec();
            (o[0], idx, o[1 + s[1]], (s[3] == 1).then(|| *o.last().expect("mask")))
        } else {
            let idx = o[2..2 + s[2]].to_vec();
            (o[1], idx, o[0], (s[3] == 1).then(|| *o.last().expect("mask")))
        }
    }

    pub(super) fn xfer_vector_type(&self, op: OpId) -> Type<'a> {
        if self[op].name == "vector.transfer_read" { self[self[op].results[0]].ty.clone() } else { self[self[op].operands[0]].ty.clone() }
    }

    pub(super) fn xfer_out_of_bounds(&self, op: OpId) -> bool {
        match self[op].get("in_bounds") {
            Some(Attribute::Array(a)) => a.iter().any(|x| !matches!(x, Attribute::Bool(true))),
            _ => vshape(&self.xfer_vector_type(op)).is_some_and(|s| !s.0.is_empty()),
        }
    }

    pub(super) fn in_mask(&self, op: OpId) -> bool {
        self.parent_op(op).is_some_and(|p| self[p].name == "vector.mask")
    }

    /// The permutation map's results: dims, or `None` for broadcast (constant 0).
    pub(super) fn xfer_perm(&self, op: OpId) -> Option<(u32, Vec<Option<u32>>)> {
        let m = self.affine_map(op, "permutation_map")?;
        let r = m.results.iter().map(|e| match e {
            crate::AffineExpr::Dim(d) => Some(Some(*d)),
            crate::AffineExpr::Const(0) => Some(None),
            _ => None,
        });
        Some((m.dims, r.collect::<Option<Vec<_>>>()?))
    }
}

/// `TransferReadToVectorLoadLowering` (`max_rank` as `maxTransferRank`).
pub fn transfer_read_to_load<'a, B: Build<'a> + ?Sized>(rw: &mut B, op: OpId, max_rank: Option<usize>) -> bool {
    let b = rw.body();
    let vt = b.xfer_vector_type(op);
    let Some((shape, scal)) = vshape(&vt) else { return false };
    if max_rank.is_some_and(|m| shape.len() > m) || b.in_mask(op) {
        return false;
    }
    let Some((nd, perm)) = b.xfer_perm(op) else { return false };
    // `isMinorIdentityWithBroadcasting`.
    let n = perm.len() as u32;
    let mut bcast = Vec::new();
    for (i, r) in perm.iter().enumerate() {
        match r {
            None => bcast.push(i),
            Some(d) if *d == nd - n + i as u32 => {}
            Some(_) => return false,
        }
    }
    let (base, indices, padding, mask) = b.xfer_parts(op);
    let Some(mt) = (match &b[base].ty {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s.clone()),
        _ => None,
    }) else {
        return false;
    };
    if !LlvmOptions::default().strides_and_offset(&mt).is_some_and(|(s, _)| s.last().is_none_or(|l| *l == 1)) {
        return false;
    }
    let mut ushape = shape.clone();
    for i in &bcast {
        ushape[*i] = 1;
    }
    let ut = vector_type(&ushape, &scal, elem(&vt).clone());
    let me = &*mt.elem;
    if matches!(me, Type::Shaped(s) if s.kind == ShapedKind::Vector) {
        if *me != ut {
            return false;
        }
    } else if me != elem(&vt) {
        return false;
    }
    if b.xfer_out_of_bounds(op) {
        return false;
    }
    rw.before(op);
    let mut res = if let Some(m) = mask {
        if shape.len() != 1 {
            return false;
        }
        let fill = rw.broadcast(ut.clone(), padding);
        let mut ops = vec![base];
        ops.extend(&indices);
        ops.push(m);
        ops.push(fill);
        rw.make1(OpData::build("vector.maskedload").operands(&ops), ut)
    } else {
        let mut ops = vec![base];
        ops.extend(&indices);
        rw.make1(OpData::build("vector.load").operands(&ops), ut)
    };
    if !bcast.is_empty() {
        res = rw.broadcast(vt, res);
    }
    rw.replace(op, &[res]);
    true
}

/// `TransferWriteToVectorStoreLowering`.
pub fn transfer_write_to_store<'a, B: Build<'a> + ?Sized>(rw: &mut B, op: OpId, max_rank: Option<usize>) -> bool {
    let b = rw.body();
    let vt = b.xfer_vector_type(op);
    let Some((shape, _)) = vshape(&vt) else { return false };
    if max_rank.is_some_and(|m| shape.len() > m) || b.in_mask(op) {
        return false;
    }
    let Some((nd, perm)) = b.xfer_perm(op) else { return false };
    let n = perm.len() as u32;
    if perm.iter().enumerate().any(|(i, r)| *r != Some(nd - n + i as u32)) {
        return false;
    }
    let (base, indices, value, mask) = b.xfer_parts(op);
    let Some(mt) = (match &b[base].ty {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s.clone()),
        _ => None,
    }) else {
        return false;
    };
    if !LlvmOptions::default().strides_and_offset(&mt).is_some_and(|(s, _)| s.last().is_none_or(|l| *l == 1)) {
        return false;
    }
    let me = &*mt.elem;
    if matches!(me, Type::Shaped(s) if s.kind == ShapedKind::Vector) {
        if *me != vt {
            return false;
        }
    } else if me != elem(&vt) {
        return false;
    }
    if b.xfer_out_of_bounds(op) {
        return false;
    }
    rw.before(op);
    if let Some(m) = mask {
        if shape.len() != 1 {
            return false;
        }
        let mut ops = vec![base];
        ops.extend(&indices);
        ops.push(m);
        ops.push(value);
        rw.make(OpData::build("vector.maskedstore").operands(&ops), &[]);
    } else {
        let mut ops = vec![value, base];
        ops.extend(&indices);
        rw.make(OpData::build("vector.store").operands(&ops), &[]);
    }
    rw.remove(op);
    true
}

/// `buildVectorComparison`: `[0, 1, ...] (+ off) < bound`.
fn vector_comparison<'a>(rw: &mut Rewriter<'_, 'a>, dim: i64, bound: ValueId, off: Option<ValueId>, force32: bool) -> ValueId {
    let it = Type::int(if force32 { 32 } else { 64 });
    let shape: Vec<i64> = if dim == 0 { Vec::new() } else { vec![dim] };
    let vt = vector_type(&shape, &[], it.clone());
    let w = if force32 { 32 } else { 64 };
    let values: Vec<Scalar> = (0..dim.max(1)).map(|i| Scalar::Int(ApInt::new(w, i128::from(i)))).collect();
    let attr: Attribute = Const { ty: vt.clone(), values, elements: true }.into();
    let mut indices = rw.constant(attr, vt.clone());
    if let Some(o) = off {
        let o = cast_index_like(rw, &it, o);
        let ov = rw.broadcast(vt.clone(), o);
        indices = rw.make1(OpData::build("arith.addi").operands(&[ov, indices]), vt.clone());
    }
    let bnd = cast_index_like(rw, &it, bound);
    let bounds = rw.broadcast(vt.clone(), bnd);
    let mt = vector_type(&shape, &[], Type::int(1));
    rw.make1(OpData::build("arith.cmpi").operands(&[indices, bounds]).with("predicate", Attribute::i64(2)), mt)
}

/// `getValueOrCreateCastToIndexLike`.
fn cast_index_like<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, v: ValueId) -> ValueId {
    let vt = rw.body[v].ty.clone();
    if vt == *ty {
        return v;
    }
    if matches!(vt, Type::Index) != matches!(ty, Type::Index) {
        return rw.make1(OpData::build("arith.index_cast").operands(&[v]), ty.clone());
    }
    let (a, b) = (crate::bit_width(ty).unwrap_or(64), crate::bit_width(&vt).unwrap_or(64));
    rw.make1(OpData::build(if a > b { "arith.extsi" } else { "arith.trunci" }).operands(&[v]), ty.clone())
}

fn i64s(b: &Body<'_>, op: OpId, name: &str) -> Vec<i64> {
    match b[op].get(name) {
        Some(Attribute::Array(a)) => a.iter().filter_map(|x| if let Attribute::Int { lit, .. } = x { lit.parse().ok() } else { None }).collect(),
        _ => Vec::new(),
    }
}

/// An `ArrayAttr` of `i64`.
fn arr<'a>(v: &[i64]) -> Attribute<'a> {
    Attribute::Array(v.iter().map(|x| Attribute::Int { lit: format!("{x}").into(), ty: None }).collect())
}

/// `createUnrollIterator(type, 1)`: the positions of the leading dims, up to the first
/// scalable one.
fn unroll_positions(shape: &[i64], scal: &[bool]) -> Option<Vec<Vec<i64>>> {
    if shape.len() <= 1 {
        return None;
    }
    let lead = &scal[..shape.len() - 1];
    let k = lead.iter().position(|s| *s).unwrap_or(lead.len());
    if k == 0 {
        return None;
    }
    let mut out = Vec::new();
    let mut pos = vec![0i64; k];
    loop {
        out.push(pos.clone());
        let mut d = k;
        loop {
            if d == 0 {
                return Some(out);
            }
            d -= 1;
            pos[d] += 1;
            if pos[d] < shape[d] {
                break;
            }
            pos[d] = 0;
        }
    }
}

/// `unrollVectorOp`: a rank-n result rebuilt from `make(i)` rank-(n-1) pieces.
fn unroll_op<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, mut make: impl FnMut(&mut Rewriter<'_, 'a>, Type<'a>, i64) -> ValueId) -> bool {
    let rt = rw.body[rw.body[op].results[0]].ty.clone();
    let Some((shape, scal)) = vshape(&rt) else { return false };
    if shape.len() < 2 || scal[0] {
        return false;
    }
    rw.set_before(op);
    let mut r = rw.poison(rt.clone());
    let sub = vector_type(&shape[1..], &scal[1..], elem(&rt).clone());
    for i in 0..shape[0] {
        let v = make(rw, sub.clone(), i);
        r = rw.vinsert(v, r, &[i]);
    }
    rw.replace_op(op, &[r]);
    true
}

/// `createContractArithOp`.
fn contract_arith<'a>(rw: &mut Rewriter<'_, 'a>, x: ValueId, y: ValueId, acc: Option<ValueId>, kind: &str, is_int: bool, mask: Option<ValueId>) -> Option<ValueId> {
    let ty = rw.body[x].ty.clone();
    let mul = if is_int {
        if matches!(kind, "minnumf" | "maxnumf" | "minimumf" | "maximumf") {
            return None;
        }
        rw.make1(OpData::build("arith.muli").operands(&[x, y]), ty)
    } else {
        if matches!(kind, "and" | "minui" | "minsi" | "maxui" | "maxsi" | "or" | "xor") {
            return None;
        }
        if let Some(a) = acc
            && vshape(&rw.body[a].ty).is_some()
            && kind == "add"
        {
            let mut f = rw.make1(OpData::build("vector.fma").operands(&[x, y, a]), ty.clone());
            if let Some(m) = mask {
                f = rw.make1(OpData::build("arith.select").operands(&[m, f, a]), ty);
            }
            return Some(f);
        }
        rw.make1(OpData::build("arith.mulf").operands(&[x, y]), ty)
    };
    let Some(a) = acc else { return Some(mul) };
    Some(rw.arith_reduction(kind, mul, a, None, mask))
}

/// Options of the pre-pass patterns that need them.
#[derive(Clone, Copy)]
struct Force32(bool);

rewrites! {
    /// `BroadcastOpLowering`.
    BroadcastOpLowering("vector.broadcast", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let dt = b[b[op].results[0]].ty.clone();
        let Some((ss, _)) = vshape(&b[src].ty) else { return false };
        let Some((ds, dsc)) = vshape(&dt) else { return false };
        let (sr, dr) = (ss.len(), ds.len());
        rw.set_before(op);
        if sr <= 1 && dr == 1 {
            let e = rw.vextract_(src, &vec![0; sr]);
            rw.replace_with(op, OpData::build("vector.broadcast").operands(&[e]), &[dt]);
            return true;
        }
        let low = vector_type(&ds[1..], &dsc[1..], elem(&dt).clone());
        if sr < dr {
            let bc = rw.broadcast(low, src);
            let mut r = rw.poison(dt);
            for d in 0..ds[0] {
                r = rw.vinsert(bc, r, &[d]);
            }
            rw.replace_op(op, &[r]);
            return true;
        }
        let Some(m) = (0..dr).find(|r| ss[*r] != ds[*r]) else {
            rw.replace_op(op, &[src]);
            return true;
        };
        let mut r = rw.poison(dt.clone());
        if m == 0 {
            let e = rw.vextract_(src, &[0]);
            let bc = rw.broadcast(low, e);
            for d in 0..ds[0] {
                r = rw.vinsert(bc, r, &[d]);
            }
        } else {
            if dsc[0] {
                return false;
            }
            for d in 0..ds[0] {
                let e = rw.vextract_(src, &[d]);
                let bc = rw.broadcast(low.clone(), e);
                r = rw.vinsert(bc, r, &[d]);
            }
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `UnrollBitCastOp` to rank 1.
    UnrollBitCastOp("vector.bitcast", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&rt) else { return false };
        let Some(positions) = unroll_positions(&shape, &scal) else { return false };
        let k = positions[0].len();
        let bt = vector_type(&shape[k..], &scal[k..], elem(&rt).clone());
        let src = b[op].operands[0];
        rw.set_before(op);
        let mut r = rw.poison(rt);
        for pos in positions {
            let e = rw.vextract_(src, &pos);
            let c = rw.make1(OpData::build("vector.bitcast").operands(&[e]), bt.clone());
            r = rw.vinsert(c, r, &pos);
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `UnrollInterleaveOp` to rank 1.
    UnrollInterleaveOp("vector.interleave", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&rt) else { return false };
        let Some(positions) = unroll_positions(&shape, &scal) else { return false };
        let (l, r0) = (b[op].operands[0], b[op].operands[1]);
        let k = positions[0].len();
        let it = vector_type(&shape[k..], &scal[k..], elem(&rt).clone());
        rw.set_before(op);
        let mut res = rw.constant(zeros(&rt), rt);
        for pos in positions {
            let (a, c) = (rw.vextract_(l, &pos), rw.vextract_(r0, &pos));
            let i = rw.make1(OpData::build("vector.interleave").operands(&[a, c]), it.clone());
            res = rw.vinsert(i, res, &pos);
        }
        rw.replace_op(op, &[res]);
        true
    }

    /// `UnrollDeinterleaveOp` to rank 1.
    UnrollDeinterleaveOp("vector.deinterleave", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&rt) else { return false };
        let Some(positions) = unroll_positions(&shape, &scal) else { return false };
        let src = b[op].operands[0];
        let k = positions[0].len();
        let dt = vector_type(&shape[k..], &scal[k..], elem(&rt).clone());
        rw.set_before(op);
        let empty = rw.constant(zeros(&rt), rt);
        let (mut even, mut odd) = (empty, empty);
        for pos in positions {
            let x = rw.vextract_(src, &pos);
            let d = rw.make(OpData::build("vector.deinterleave").operands(&[x]), &[dt.clone(), dt.clone()]);
            let (e, o) = (rw.body[d].results[0], rw.body[d].results[1]);
            even = rw.vinsert(e, even, &pos);
            odd = rw.vinsert(o, odd, &pos);
        }
        rw.replace_op(op, &[even, odd]);
        true
    }

    /// `StepToArithConstantOpRewrite`.
    StepToArithConstantOpRewrite("vector.step", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&rt) else { return false };
        if scal.contains(&true) {
            return false;
        }
        let n: i64 = shape.iter().product();
        let c: Attribute = Const { ty: rt.clone(), values: (0..n).map(|i| Scalar::Int(ApInt::new(64, i128::from(i)))).collect(), elements: true }.into();
        rw.replace_with(op, OpData::build("arith.constant").with("value", c), &[rt]);
        true
    }

    /// `UnrollGather`.
    UnrollGather("vector.gather", 1) |rw, op| {
        let b = &*rw.body;
        let ops = b[op].operands.clone();
        let n = ops.len();
        let (idx, mask, pass) = (ops[n - 3], ops[n - 2], ops[n - 1]);
        let fixed = ops[..n - 3].to_vec();
        let align = b[op].get("alignment").cloned();
        unroll_op(rw, op, |rw, sub, i| {
            let (a, m, p) = (rw.vextract_(idx, &[i]), rw.vextract_(mask, &[i]), rw.vextract_(pass, &[i]));
            let mut operands = fixed.clone();
            operands.extend([a, m, p]);
            let mut d = OpData::build("vector.gather").operands(&operands);
            if let Some(al) = &align {
                d.set("alignment", al.clone());
            }
            rw.make1(d, sub)
        })
    }

    /// `UnrollFromElements`.
    UnrollFromElements("vector.from_elements", 1) |rw, op| {
        let all = rw.body[op].operands.clone();
        unroll_op(rw, op, |rw, sub, i| {
            let n: i64 = vshape(&sub).map_or(1, |s| s.0.iter().product());
            let slice = &all[(i * n) as usize..((i + 1) * n) as usize];
            rw.make1(OpData::build("vector.from_elements").operands(slice), sub)
        })
    }

    /// `UnrollToElements`.
    UnrollToElements("vector.to_elements", 1) |rw, op| {
        let b = &*rw.body;
        let src = b[op].operands[0];
        let Some((shape, scal)) = vshape(&b[src].ty) else { return false };
        if shape.len() < 2 || scal[0] {
            return false;
        }
        let et = elem(&b[src].ty).clone();
        rw.set_before(op);
        let mut results = Vec::new();
        let subs: Vec<ValueId> = (0..shape[0]).map(|i| rw.vextract_(src, &[i])).collect();
        for v in subs {
            let n: i64 = vshape(&rw.body[v].ty).map_or(1, |s| s.0.iter().product());
            let t = rw.make(OpData::build("vector.to_elements").operands(&[v]), &vec![et.clone(); n as usize]);
            results.extend(rw.body[t].results.clone());
        }
        rw.replace_op(op, &results);
        true
    }

    /// `Convert1DExtractStridedSliceIntoExtractInsertChain`, for scalable vectors.
    Convert1DExtractStridedSliceIntoExtractInsertChain("vector.extract_strided_slice", 1) |rw, op| {
        let b = &*rw.body;
        let dt = b[b[op].results[0]].ty.clone();
        let src = b[op].operands[0];
        let scalable = vshape(&dt).is_some_and(|s| s.1.contains(&true)) || vshape(&b[src].ty).is_some_and(|s| s.1.contains(&true));
        let (offs, sizes, strides) = (i64s(b, op, "offsets"), i64s(b, op, "sizes"), i64s(b, op, "strides"));
        if !scalable || offs.len() != 1 {
            return false;
        }
        rw.set_before(op);
        let mut elems = Vec::new();
        let mut i = offs[0];
        while i < offs[0] + sizes[0] * strides[0] {
            elems.push(rw.vextract_(src, &[i]));
            i += strides[0];
        }
        let mut r = rw.constant(zeros(&dt), dt);
        for (k, e) in elems.into_iter().enumerate() {
            r = rw.vinsert(e, r, &[k as i64]);
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `CreateMaskOpLowering`: n-D masks become selects of (n-1)-D ones.
    CreateMaskOpLowering("vector.create_mask", 1) |rw, op| {
        let b = &*rw.body;
        let dt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&dt) else { return false };
        if shape.len() <= 1 || scal[0] {
            return false;
        }
        let ops = b[op].operands.clone();
        let low = vector_type(&shape[1..], &scal[1..], Type::int(1));
        rw.set_before(op);
        let t = rw.make1(OpData::build("vector.create_mask").operands(&ops[1..]), low.clone());
        let f = rw.constant(zeros(&low), low.clone());
        let mut r = rw.constant(zeros(&dt), dt.clone());
        for d in 0..shape[0] {
            let bnd = rw.constant(index_attr(d), Type::Index);
            let c = rw.make1(OpData::build("arith.cmpi").operands(&[bnd, ops[0]]).with("predicate", Attribute::i64(2)), Type::int(1));
            let s = rw.make1(OpData::build("arith.select").operands(&[c, t, f]), low.clone());
            r = rw.vinsert(s, r, &[d]);
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `ConstantMaskOpLowering`.
    ConstantMaskOpLowering("vector.constant_mask", 1) |rw, op| {
        let b = &*rw.body;
        let dt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&dt) else { return false };
        let dims = b.dense_i64(op, "mask_dim_sizes");
        let bool_const = |values: Vec<bool>, ty: &Type<'_>| -> Attribute<'static> {
            let vals: Vec<Scalar> = values.into_iter().map(|v| Scalar::Int(ApInt::new(1, i128::from(v)))).collect();
            Const { ty: crate::Owned::owned(ty), values: vals, elements: true }.into()
        };
        if shape.is_empty() {
            let c = bool_const(vec![dims[0] == 1], &dt);
            rw.replace_with(op, OpData::build("arith.constant").with("value", c), &[dt]);
            return true;
        }
        let t = dims[0];
        if shape.len() == 1 {
            let c = if t == 0 || t == shape[0] { bool_const(vec![t != 0], &dt) } else { bool_const((0..shape[0]).map(|i| i < t).collect(), &dt) };
            rw.replace_with(op, OpData::build("arith.constant").with("value", c), &[dt]);
            return true;
        }
        if scal[0] {
            return false;
        }
        let low = vector_type(&shape[1..], &scal[1..], Type::int(1));
        rw.set_before(op);
        let tv = rw.make1(OpData::build("vector.constant_mask").with("mask_dim_sizes", dense_i64(&dims[1..])), low);
        let mut r = rw.constant(zeros(&dt), dt);
        for d in 0..t {
            r = rw.vinsert(tv, r, &[d]);
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `VectorFMAOpNDRewritePattern`.
    VectorFMAOpNDRewritePattern("vector.fma", 1) |rw, op| {
        let b = &*rw.body;
        let vt = b[b[op].results[0]].ty.clone();
        let Some((shape, _)) = vshape(&vt) else { return false };
        if shape.len() < 2 {
            return false;
        }
        let (l, r, a) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let et = elem(&vt).clone();
        rw.set_before(op);
        let zero_attr = match &et {
            Type::Float(_) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(et.clone()) },
            _ => Attribute::Int { lit: "0".into(), ty: Some(et.clone()) },
        };
        let z = rw.constant(zero_attr, et);
        let mut desc = rw.broadcast(vt, z);
        for i in 0..shape[0] {
            let (el, er, ea) = (rw.vextract_(l, &[i]), rw.vextract_(r, &[i]), rw.vextract_(a, &[i]));
            let t = rw.body[el].ty.clone();
            let f = rw.make1(OpData::build("vector.fma").operands(&[el, er, ea]), t);
            desc = rw.vinsert(f, desc, &[i]);
        }
        rw.replace_op(op, &[desc]);
        true
    }

    /// `TransferReadToVectorLoadLowering` (rank 1).
    TransferReadToLoad1("vector.transfer_read", 1) |rw, op| { transfer_read_to_load(rw, op, Some(1)) }
    /// `TransferWriteToVectorStoreLowering` (rank 1).
    TransferWriteToStore1("vector.transfer_write", 1) |rw, op| { transfer_write_to_store(rw, op, Some(1)) }

    /// `OuterProductOpLowering`.
    OuterProductOpLowering("vector.outerproduct", 1) |rw, op| {
        let b = &*rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some((rshape, rscal)) = vshape(&rt) else { return false };
        if rshape.len() >= 2 && rscal.iter().all(|s| *s) {
            return false;
        }
        let (lhs, rhs) = (b[op].operands[0], b[op].operands[1]);
        let acc = b[op].operands.get(2).copied();
        let et = elem(&rt).clone();
        let is_int = matches!(et, Type::Integer { .. } | Type::Index);
        let kind = match b[op].get("kind") {
            Some(Attribute::Extended { ext, .. }) => alloc::string::String::from(ext.body.as_deref().unwrap_or("<add>").trim_matches(|c| c == '<' || c == '>')),
            _ => "add".into(),
        };
        let mask_op = b.parent_op(op).filter(|p| b[*p].name == "vector.mask");
        let root = mask_op.unwrap_or(op);
        let mask = mask_op.map(|m| b[m].operands[0]);
        let lt = b[lhs].ty.clone();
        let rhs_ty = b[rhs].ty.clone();
        rw.set_before(root);
        if vshape(&rhs_ty).is_none() {
            let bc = rw.broadcast(lt, rhs);
            let Some(m) = contract_arith(rw, lhs, bc, acc, &kind, is_int, mask) else { return false };
            rw.replace_op(root, &[m]);
            return true;
        }
        let mut result = rw.constant(zeros(&rt), rt.clone());
        for d in 0..rshape[0] {
            let x = rw.vextract_(lhs, &[d]);
            let a = rw.broadcast(rhs_ty.clone(), x);
            let r = acc.map(|acc| rw.vextract_(acc, &[d]));
            let em = mask.map(|m| rw.vextract_(m, &[d]));
            let Some(m) = contract_arith(rw, a, rhs, r, &kind, is_int, em) else { return false };
            result = rw.vinsert(m, result, &[d]);
        }
        rw.replace_op(root, &[result]);
        true
    }

    /// `DecomposeDifferentRankInsertStridedSlice`.
    DecomposeDifferentRankInsertStridedSlice("vector.insert_strided_slice", 1) |rw, op| {
        let b = &*rw.body;
        let (src, dst) = (b[op].operands[0], b[op].operands[1]);
        let offsets = i64s(b, op, "offsets");
        let strides = i64s(b, op, "strides");
        if offsets.is_empty() {
            return false;
        }
        let (Some((ss, _)), Some((ds, _))) = (vshape(&b[src].ty), vshape(&b[dst].ty)) else { return false };
        let diff = ds.len() - ss.len();
        if diff == 0 {
            return false;
        }
        let rest = ds.len() - diff;
        let lead = &offsets[..offsets.len() - rest];
        rw.set_before(op);
        let x = rw.vextract_(dst, lead);
        let xt = rw.body[x].ty.clone();
        let inner = rw.make1(OpData::build("vector.insert_strided_slice").operands(&[src, x]).with("offsets", arr(&offsets[diff..])).with("strides", arr(&strides)), xt);
        let dt = rw.body[dst].ty.clone();
        rw.replace_with(op, OpData::build("vector.insert").operands(&[inner, dst]).with("static_position", dense_i64(lead)), &[dt]);
        true
    }

    /// `DecomposeNDExtractStridedSlice`.
    DecomposeNDExtractStridedSlice("vector.extract_strided_slice", 1) |rw, op| {
        let b = &*rw.body;
        let (offs, sizes, strides) = (i64s(b, op, "offsets"), i64s(b, op, "sizes"), i64s(b, op, "strides"));
        if offs.len() == 1 {
            return false;
        }
        let dt = b[b[op].results[0]].ty.clone();
        let src = b[op].operands[0];
        let et = elem(&dt).clone();
        rw.set_before(op);
        let zero_attr = match &et {
            Type::Float(_) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(et.clone()) },
            _ => Attribute::Int { lit: "0".into(), ty: Some(et.clone()) },
        };
        let z = rw.constant(zero_attr, et);
        let mut res = rw.broadcast(dt, z);
        let (offset, size, stride) = (offs[0], sizes[0], strides[0]);
        let mut idx = 0;
        let mut off = offset;
        while off < offset + size * stride {
            let one = rw.vextract_(src, &[off]);
            let (os, osc) = vshape(&rw.body[one].ty).unwrap_or_default();
            let mut shape = os.clone();
            for (i, s) in sizes[1..].iter().enumerate() {
                shape[i] = *s;
            }
            let t = vector_type(&shape, &osc, elem(&rw.body[one].ty).clone());
            let x = rw.make1(OpData::build("vector.extract_strided_slice").operands(&[one]).with("offsets", arr(&offs[1..])).with("sizes", arr(&sizes[1..])).with("strides", arr(&strides[1..])), t);
            res = rw.vinsert(x, res, &[idx]);
            off += stride;
            idx += 1;
        }
        rw.replace_op(op, &[res]);
        true
    }

    /// `ConvertSameRankInsertStridedSliceIntoShuffle`.
    ConvertSameRankInsertStridedSliceIntoShuffle("vector.insert_strided_slice", 1) |rw, op| {
        let b = &*rw.body;
        let (src, dst) = (b[op].operands[0], b[op].operands[1]);
        let (st, dt) = (b[src].ty.clone(), b[dst].ty.clone());
        let (Some((ss, ssc)), Some((ds, dsc))) = (vshape(&st), vshape(&dt)) else { return false };
        if (ssc.contains(&true) || dsc.contains(&true)) && ss.len() == 1 {
            return false;
        }
        let offsets = i64s(b, op, "offsets");
        let strides = i64s(b, op, "strides");
        if offsets.is_empty() || ds.len() != ss.len() {
            return false;
        }
        if st == dt {
            rw.replace_op(op, &[src]);
            return true;
        }
        let (offset, size, stride) = (offsets[0], ss[0], strides[0]);
        rw.set_before(op);
        if ss.len() == 1 {
            let (ns, nd) = (ss[0], ds[0]);
            let mut mask = vec![0i64; nd as usize];
            for i in 0..ns {
                mask[i as usize] = i;
            }
            let t = vector_type(&[nd], &[false], elem(&st).clone());
            let scaled = rw.make1(OpData::build("vector.shuffle").operands(&[src, src]).with("mask", dense_i64(&mask)), t);
            let e = offset + size * stride;
            let mask: Vec<i64> = (0..nd).map(|i| if i < offset || i >= e || (i - offset) % stride != 0 { nd + i } else { (i - offset) / stride }).collect();
            rw.replace_with(op, OpData::build("vector.shuffle").operands(&[scaled, dst]).with("mask", dense_i64(&mask)), &[dt]);
            return true;
        }
        let mut res = dst;
        let mut off = offset;
        let mut idx = 0;
        while off < offset + size * stride {
            let mut x = rw.vextract_(src, &[idx]);
            if vshape(&rw.body[x].ty).is_some() {
                let xd = rw.vextract_(dst, &[off]);
                let t = rw.body[xd].ty.clone();
                x = rw.make1(OpData::build("vector.insert_strided_slice").operands(&[x, xd]).with("offsets", arr(&offsets[1..])).with("strides", arr(&strides[1..])), t);
            }
            res = rw.vinsert(x, res, &[off]);
            off += stride;
            idx += 1;
        }
        rw.replace_op(op, &[res]);
        true
    }

    /// `Convert1DExtractStridedSliceIntoShuffle`.
    Convert1DExtractStridedSliceIntoShuffle("vector.extract_strided_slice", 1) |rw, op| {
        let b = &*rw.body;
        let dt = b[b[op].results[0]].ty.clone();
        let src = b[op].operands[0];
        let (Some((_, dsc)), Some((_, ssc))) = (vshape(&dt), vshape(&b[src].ty)) else { return false };
        if dsc.contains(&true) || ssc.contains(&true) {
            return false;
        }
        let (offs, sizes, strides) = (i64s(b, op, "offsets"), i64s(b, op, "sizes"), i64s(b, op, "strides"));
        if offs.len() != 1 {
            return false;
        }
        let mut mask = Vec::new();
        let mut off = offs[0];
        while off < offs[0] + sizes[0] * strides[0] {
            mask.push(off);
            off += strides[0];
        }
        rw.replace_with(op, OpData::build("vector.shuffle").operands(&[src, src]).with("mask", dense_i64(&mask)), &[dt]);
        true
    }

    /// `FoldI1Select`.
    FoldI1Select("arith.select", 1) |rw, op| {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&ty) else { return false };
        if *elem(&ty) != Type::int(1) || vshape(&b[b[op].operands[0]].ty).is_some() || shape != [1] || scal[0] {
            return false;
        }
        let all = |v: ValueId, want: bool| {
            b.def_named(v, "arith.constant").and_then(|c| Const::try_from(b[c].get("value")?).ok()).is_some_and(|c| c.is_splat() && c.values[0].int().is_some_and(|i| i.is_one() == want))
        };
        if !all(b[op].operands[1], true) || !all(b[op].operands[2], false) {
            return false;
        }
        let cond = b[op].operands[0];
        let bt = vector_type(&[1], &[false], Type::int(1));
        rw.replace_with(op, OpData::build("vector.broadcast").operands(&[cond]), &[bt]);
        true
    }
}

/// `VectorCreateMaskOpConversion` (1-D, fixed size).
struct CreateMaskMaterialize(Force32);

impl crate::Pattern for CreateMaskMaterialize {
    fn name(&self) -> &str {
        "VectorCreateMaskOpConversion"
    }
    fn root(&self) -> Option<&str> {
        Some("vector.create_mask")
    }
    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let dt = b[b[op].results[0]].ty.clone();
        let Some((shape, scal)) = vshape(&dt) else { return false };
        if scal.contains(&true) || shape.len() > 1 {
            return false;
        }
        let bound = b[op].operands[0];
        rw.set_before(op);
        let c = vector_comparison(rw, shape.first().copied().unwrap_or(0), bound, None, self.0.0);
        rw.replace_op(op, &[c]);
        true
    }
}

/// `MaterializeTransferMask<TransferReadOp / TransferWriteOp>`.
struct MaterializeTransferMask(&'static str, Force32);

impl crate::Pattern for MaterializeTransferMask {
    fn name(&self) -> &str {
        "MaterializeTransferMask"
    }
    fn root(&self) -> Option<&str> {
        Some(self.0)
    }
    fn rewrite(&self, rw: &mut Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        if !b.xfer_out_of_bounds(op) {
            return false;
        }
        let vt = b.xfer_vector_type(op);
        let Some((shape, scal)) = vshape(&vt) else { return false };
        let (base, indices, _, mask) = b.xfer_parts(op);
        if shape.len() > 1 || indices.is_empty() {
            return false;
        }
        let last = indices.len() - 1;
        let off = indices[last];
        rw.set_before(op);
        // `createOrFoldDimOp`.
        let idx = rw.constant(index_attr(last as i64), Type::Index);
        let tensor = matches!(&rw.body[base].ty, Type::Shaped(s) if s.kind == ShapedKind::Tensor);
        let dim = rw.create_or_fold(OpData::build(if tensor { "tensor.dim" } else { "memref.dim" }).operands(&[base, idx]), &[Type::Index])[0];
        let bound = rw.make1(OpData::build("arith.subi").operands(&[dim, off]), Type::Index);
        let mt = vector_type(&shape, &scal, Type::int(1));
        let mut m = rw.make1(OpData::build("vector.create_mask").operands(&[bound]), mt.clone());
        if let Some(old) = mask {
            m = rw.make1(OpData::build("arith.andi").operands(&[m, old]), mt);
        }
        let _ = self.1;
        rw.modify(op, |b| {
            let mut ops = b[op].operands.clone();
            let mut segs = b.segments(op, "operandSegmentSizes").unwrap_or_default();
            if segs[3] == 1 {
                *ops.last_mut().expect("mask") = m;
            } else {
                ops.push(m);
                segs[3] = 1;
            }
            b.set_operands(op, ops);
            b[op].set("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: segs.iter().map(|x| format!("{x}").into()).collect() });
            b[op].set("in_bounds", Attribute::Array(vec![Attribute::Bool(true)]));
        });
        true
    }
}

/// The `convert-vector-to-llvm` pre-pass: the patterns of `ConvertVectorToLLVMPass` that are
/// ported, in its order.
pub fn pre_patterns(force32: bool) -> PatternSet {
    let mut set = PatternSet::default();
    crate::canon::vector_to_vector_canonicalization(&mut set);
    set.add(UnrollBitCastOp);
    set.add(BroadcastOpLowering);
    set.add(OuterProductOpLowering);
    set.add(CreateMaskOpLowering);
    set.add(ConstantMaskOpLowering);
    set.add(DecomposeDifferentRankInsertStridedSlice);
    set.add(DecomposeNDExtractStridedSlice);
    set.add(ConvertSameRankInsertStridedSliceIntoShuffle);
    set.add(Convert1DExtractStridedSliceIntoShuffle);
    set.add(UnrollInterleaveOp);
    set.add(UnrollDeinterleaveOp);
    set.add(TransferReadToLoad1);
    set.add(TransferWriteToStore1);
    set.add(CreateMaskMaterialize(Force32(force32)));
    set.add(MaterializeTransferMask("vector.transfer_read", Force32(force32)));
    set.add(MaterializeTransferMask("vector.transfer_write", Force32(force32)));
    set.add(FoldI1Select);
    set.add(Convert1DExtractStridedSliceIntoExtractInsertChain);
    set.add(StepToArithConstantOpRewrite);
    set.add(VectorFMAOpNDRewritePattern);
    set.add(UnrollGather);
    set.add(UnrollFromElements);
    set.add(UnrollToElements);
    set
}
