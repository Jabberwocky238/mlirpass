//! `convert-vector-to-scf`, as `VectorToSCF.cpp`, after the permutation-map lowerings of
//! `LowerVectorTransfer.cpp` (`populateVectorTransferPermutationMapLoweringPatterns`).

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::{Attribute, Dim, Error, ShapedKind, Shaped, Type};

use super::vector_transforms::{Build, VectorBuild, elem, vshape};
use crate::canon::MemrefOfr as Ofr;
use crate::{AffineExpr, AffineMap, Body, GreedyConfig, LlvmOptions, OpData, OpId, Run, Pattern, PatternSet, Rewriter, Trait, ValueId};

/// The label of transfers being lowered (`kPassLabel`).
const LABEL: &str = "__vector_to_scf_lowering__";

/// `VectorTransferToSCFOptions`.
#[derive(Clone, Copy)]
pub struct VectorToScfOptions {
    pub unroll: bool,
    pub target_rank: usize,
    pub lower_tensors: bool,
    pub lower_scalable: bool,
}

type Rw<'r, 'a> = Rewriter<'r, 'a>;

/// What a transfer op is, read off its operands and attributes.
#[derive(Clone)]
struct Xfer<'a> {
    read: bool,
    base: ValueId,
    indices: Vec<ValueId>,
    /// The padding (read) or the stored vector write.
    value: ValueId,
    mask: Option<ValueId>,
    vt: Type<'a>,
    map: AffineMap,
    in_bounds: Vec<bool>,
    tensor: bool,
}

impl<'a> Xfer<'a> {
    fn of(b: &Body<'a>, op: OpId) -> Option<Self> {
        let (base, indices, value, mask) = b.xfer_parts(op);
        let in_bounds = match b[op].get("in_bounds") {
            Some(Attribute::Array(a)) => a.iter().map(|x| matches!(x, Attribute::Bool(true))).collect(),
            _ => Vec::new(),
        };
        let tensor = matches!(&b[base].ty, Type::Shaped(s) if s.kind == ShapedKind::Tensor && s.shape.is_some());
        Some(Self { read: b[op].name == "vector.transfer_read", base, indices, value, mask, vt: b.xfer_vector_type(op), map: b.affine_map(op, "permutation_map")?, in_bounds, tensor })
    }

    fn rank(&self) -> usize {
        vshape(&self.vt).map_or(0, |s| s.0.len())
    }

    fn scalable0(&self) -> bool {
        vshape(&self.vt).is_some_and(|s| s.1.first() == Some(&true))
    }

    /// `unpackedDim`: the source dim of vector dim 0, `None` for a broadcast.
    fn unpacked_dim(&self) -> Option<usize> {
        match self.map.results.first() {
            Some(AffineExpr::Dim(d)) => Some(*d as usize),
            _ => None,
        }
    }

    fn broadcast0(&self) -> bool {
        self.unpacked_dim().is_none()
    }

    fn in_bounds0(&self) -> bool {
        self.in_bounds.first().copied().unwrap_or(false)
    }

    /// `unpackedPermutationMap`.
    fn unpacked_map(&self) -> AffineMap {
        AffineMap { results: self.map.results[1..].to_vec(), ..self.map.clone() }
    }

    fn mask_rank(&self, b: &Body<'_>) -> usize {
        self.mask.and_then(|m| vshape(&b[m].ty)).map_or(0, |s| s.0.len())
    }

    fn shaped_elem<'x>(&self, b: &'x Body<'a>) -> &'x Type<'a> {
        elem(&b[self.base].ty)
    }
}

/// `isMinorIdentity`.
fn minor_identity(m: &AffineMap) -> bool {
    let (d, n) = (m.dims as usize, m.results.len());
    d >= n && m.results.iter().enumerate().all(|(i, r)| *r == AffineExpr::Dim((d - n + i) as u32))
}

/// `isMinorIdentityWithBroadcasting`.
fn minor_identity_with_broadcasting(m: &AffineMap) -> bool {
    let (d, n) = (m.dims as usize, m.results.len());
    d >= n && m.results.iter().enumerate().all(|(i, r)| matches!(r, AffineExpr::Const(0)) || *r == AffineExpr::Dim((d - n + i) as u32))
}

/// `isPermutationOfMinorIdentityWithBroadcasting`.
fn permutation_of_minor_identity(m: &AffineMap) -> Option<Vec<usize>> {
    let (d, n) = (m.dims as usize, m.results.len());
    let start = d.saturating_sub(n);
    let lead = n.saturating_sub(d);
    let mut perm = vec![0usize; n];
    let mut found = vec![false; d.max(n)];
    let mut bcast = Vec::new();
    for (i, r) in m.results.iter().enumerate() {
        match r {
            AffineExpr::Const(0) => bcast.push(i),
            AffineExpr::Dim(p) if *p as usize >= start => {
                let np = *p as usize - start + lead;
                perm[i] = np;
                found[np] = true;
            }
            _ => return None,
        }
    }
    let mut pos = 0;
    for i in bcast {
        while pos < found.len() && found[pos] {
            pos += 1;
        }
        perm[i] = pos;
        pos += 1;
    }
    Some(perm)
}

/// `inversePermutation`.
fn inverse_permutation(m: &AffineMap) -> Option<AffineMap> {
    let mut exprs: Vec<Option<AffineExpr>> = vec![None; m.dims as usize];
    for (i, r) in m.results.iter().enumerate() {
        if let AffineExpr::Dim(d) = r
            && exprs[*d as usize].is_none()
        {
            exprs[*d as usize] = Some(AffineExpr::Dim(i as u32));
        }
    }
    let seen: Vec<AffineExpr> = exprs.into_iter().flatten().collect();
    (seen.len() == m.dims as usize).then(|| AffineMap { dims: m.results.len() as u32, syms: 0, results: seen })
}

fn bools<'a>(v: &[bool]) -> Attribute<'a> {
    Attribute::Array(v.iter().map(|b| Attribute::Bool(*b)).collect())
}

impl<'a> Rw<'_, 'a> {
    fn cidx(&mut self, v: i64) -> ValueId {
        self.make1(OpData::build("arith.constant").with("value", Attribute::index(v)), Type::Index)
    }

    /// `makeComposedAffineApply(d0 + d1, {a, b})`.
    fn add_apply(&mut self, a: ValueId, b: ValueId) -> ValueId {
        let sum = AffineMap { dims: 2, syms: 0, results: vec![AffineExpr::Dim(0).add(AffineExpr::Dim(1))] };
        self.composed_apply(sum, &[Ofr::V(a), Ofr::V(b)])
    }

    /// A `vector.transfer_read`.
    fn xfer_read(&mut self, vt: Type<'a>, base: ValueId, indices: &[ValueId], map: &AffineMap, padding: ValueId, mask: Option<ValueId>, in_bounds: &[bool]) -> OpId {
        let mut ops = vec![base];
        ops.extend(indices);
        ops.push(padding);
        ops.extend(mask);
        let data = OpData::build("vector.transfer_read").operands(&ops).segments(&[1, indices.len(), 1, usize::from(mask.is_some())]).with("permutation_map", Attribute::from(map)).with("in_bounds", bools(in_bounds));
        self.make(data, &[vt])
    }

    /// A `vector.transfer_write`, of a tensor when `ty` is given.
    fn xfer_write(&mut self, ty: Option<Type<'a>>, vec: ValueId, base: ValueId, indices: &[ValueId], map: &AffineMap, mask: Option<ValueId>, in_bounds: &[bool]) -> OpId {
        let mut ops = vec![vec, base];
        ops.extend(indices);
        ops.extend(mask);
        let data = OpData::build("vector.transfer_write").operands(&ops).segments(&[1, 1, indices.len(), usize::from(mask.is_some())]).with("permutation_map", Attribute::from(map)).with("in_bounds", bools(in_bounds));
        let types: Vec<Type<'a>> = ty.into_iter().collect();
        self.make(data, &types)
    }

    /// `memref.load`; without indices the builder sets no `nontemporal`.
    fn mload(&mut self, buf: ValueId, indices: &[ValueId]) -> ValueId {
        let ty = elem(&self.body[buf].ty).clone();
        let mut ops = vec![buf];
        ops.extend(indices);
        let mut data = OpData::build("memref.load").operands(&ops);
        if indices.is_empty() {
            data.remove("nontemporal");
        }
        self.make1(data, ty)
    }

    fn mstore(&mut self, v: ValueId, buf: ValueId, indices: &[ValueId]) {
        let mut ops = vec![v, buf];
        ops.extend(indices);
        let mut data = OpData::build("memref.store").operands(&ops);
        if indices.is_empty() {
            data.remove("nontemporal");
        }
        self.make(data, &[]);
    }

    /// `vector.extract` at a dynamic index.
    fn extract_dyn(&mut self, v: ValueId, i: ValueId) -> ValueId {
        let ty = self.body[v].ty.clone();
        let (s, sc) = vshape(&ty).expect("a vector");
        let rt = if s.len() == 1 { elem(&ty).clone() } else { Type::vector(&s[1..], &sc[1..], elem(&ty).clone()) };
        self.make1(OpData::build("vector.extract").operands(&[v, i]).with("static_position", Attribute::dense_i64(&[Dim::DYNAMIC])), rt)
    }

    /// `vector.extract` / `vector.insert` positions as mixed values.
    fn mixed_extract(&mut self, v: ValueId, pos: &[Ofr]) -> ValueId {
        let ty = self.body[v].ty.clone();
        let (s, sc) = vshape(&ty).expect("a vector");
        let rt = if s.len() == pos.len() { elem(&ty).clone() } else { Type::vector(&s[pos.len()..], &sc[pos.len()..], elem(&ty).clone()) };
        let (st, dy) = split(pos);
        let mut ops = vec![v];
        ops.extend(dy);
        self.make1(OpData::build("vector.extract").operands(&ops).with("static_position", Attribute::dense_i64(&st)), rt)
    }

    fn mixed_insert(&mut self, v: ValueId, dest: ValueId, pos: &[Ofr]) -> ValueId {
        let ty = self.body[dest].ty.clone();
        let (st, dy) = split(pos);
        let mut ops = vec![v, dest];
        ops.extend(dy);
        self.make1(OpData::build("vector.insert").operands(&ops).with("static_position", Attribute::dense_i64(&st)), ty)
    }

    /// `vector.print` of `v` (or of nothing), with a punctuation.
    fn print(&mut self, v: Option<ValueId>, punct: &str) -> OpId {
        let data = OpData::build("vector.print").operands(&v.into_iter().collect::<Vec<_>>()).with("punctuation", Attribute::dialect("vector.punctuation", &alloc::format!("<{punct}>")));
        self.make(data, &[])
    }

    /// `scf::ForOp::create` without a body builder: an empty body, only its terminator
    /// (`ensureTerminator`, unreported).
    fn bare_for(&mut self, lb: ValueId, ub: ValueId, step: ValueId) -> OpId {
        let op = self.body.create(OpData::build("scf.for").operands(&[lb, ub, step]), &[]);
        let r = self.body.add_region(op);
        let blk = self.body.add_block(r, &[(Type::Index, None)]);
        let y = self.body.create(OpData::build("scf.yield"), &[]);
        self.body.insert(y, blk, None);
        self.insert(op)
    }

    /// `vector::createOrFoldDimOp`.
    fn dim_of(&mut self, v: ValueId, d: usize) -> ValueId {
        let i = self.cidx(d as i64);
        let name = if matches!(&self.body[v].ty, Type::Shaped(s) if s.kind == ShapedKind::Tensor) { "tensor.dim" } else { "memref.dim" };
        self.create_or_fold(OpData::build(name).operands(&[v, i]), &[Type::Index])[0]
    }

    /// `getXferIndices`.
    fn xfer_indices(&mut self, x: &Xfer<'a>, iv: ValueId) -> Vec<ValueId> {
        let mut idx = x.indices.clone();
        if let Some(d) = x.unpacked_dim() {
            idx[d] = self.add_apply(x.indices[d], iv);
        }
        idx
    }

    /// `generateInBoundsCheck`.
    fn in_bounds_check(&mut self, x: &Xfer<'a>, iv: ValueId, dim: Option<usize>, types: &[Type<'a>], inside: &mut dyn FnMut(&mut Self) -> Option<ValueId>, outside: &mut dyn FnMut(&mut Self) -> Option<ValueId>) -> Option<ValueId> {
        let mut cond = None;
        if let (false, Some(d)) = (x.in_bounds0(), dim) {
            let size = self.dim_of(x.base, d);
            let idx = self.add_apply(x.indices[d], iv);
            cond = Some(self.make1(OpData::build("arith.cmpi").operands(&[size, idx]).with("predicate", Attribute::Int { lit: "4".into(), ty: Some(Type::int(64)) }), Type::int(1)));
        }
        // `generateMaskCheck`.
        if let Some(m) = x.mask.filter(|_| x.mask_rank(self.body) == 1 && !x.broadcast0()) {
            let mc = self.extract_dyn(m, iv);
            cond = Some(match cond {
                Some(c) => self.make1(OpData::build("arith.andi").operands(&[c, mc]), Type::int(1)),
                None => mc,
            });
        }
        let Some(c) = cond else { return inside(self) };
        let i = self.build_if(c, types, inside, outside);
        self.body[i].results.first().copied()
    }

    /// `allocBuffers`: the data (and mask) buffers at the start of the allocation scope.
    fn alloc_buffers(&mut self, op: OpId, x: &Xfer<'a>) -> (ValueId, Option<ValueId>) {
        let mut scope = self.body.parent_op(op);
        while let Some(s) = scope.filter(|s| !self.body.has(*s, Trait::AutomaticAllocationScope)) {
            scope = self.body.parent_op(s);
        }
        let scope = scope.expect("in an allocation scope");
        let block = self.body.top_block(scope);
        let saved = self.ip;
        self.set_start(block);
        let memref = |t: &Type<'a>| Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(Vec::new()), elem: t.clone().into(), extras: Vec::new() });
        let data = self.make1(OpData::build("memref.alloca").segments(&[0, 0]), memref(&x.vt));
        let mut mask = None;
        if let Some(m) = x.mask {
            let mt = self.body[m].ty.clone();
            let buf = self.make1(OpData::build("memref.alloca").segments(&[0, 0]), memref(&mt));
            self.set_before(op);
            self.mstore(m, buf, &[]);
            mask = Some(self.mload(buf, &[]));
        }
        self.ip = saved;
        (data, mask)
    }
}

fn split(pos: &[Ofr]) -> (Vec<i64>, Vec<ValueId>) {
    let mut st = Vec::new();
    let mut dy = Vec::new();
    for p in pos {
        match p {
            Ofr::C(c) => st.push(*c),
            Ofr::V(v) => {
                st.push(Dim::DYNAMIC);
                dy.push(*v);
            }
        }
    }
    (st, dy)
}

/// The mixed position of a `vector.extract` / `vector.insert` (`lead` operands before it).
fn mixed_position(b: &Body<'_>, op: OpId, lead: usize) -> Vec<Ofr> {
    let mut dy = b[op].operands[lead..].iter();
    b.dense_i64(op, "static_position").into_iter().map(|s| if s == Dim::DYNAMIC { Ofr::V(*dy.next().expect("dynamic")) } else { Ofr::C(s) }).collect()
}

/// `unpackOneDim`: `memref<...xvector<NxV>>` ⇒ `memref<...xNxvector<V>>`.
fn unpack_one_dim<'a>(t: &Type<'a>) -> Option<Type<'a>> {
    let Type::Shaped(m) = t else { return None };
    let (vs, sc) = vshape(&m.elem)?;
    if sc.first() == Some(&true) {
        return None;
    }
    let mut shape = m.shape.clone()?;
    shape.push(Dim::Static(vs[0]));
    let inner = Type::vector(&vs[1..], &sc[1..], elem(&m.elem).clone());
    Some(Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(shape), elem: inner.into(), extras: Vec::new() }))
}

/// A vector type with its leading dim dropped (`VectorType::Builder::dropDim(0)`).
fn drop_dim0<'a>(t: &Type<'a>) -> Type<'a> {
    let (s, sc) = vshape(t).expect("a vector");
    Type::vector(&s[1..], &sc[1..], elem(t).clone())
}

macro_rules! patterns {
    ($($name:ident($root:literal) |$rw:ident, $op:ident, $o:ident| $body:block)*) => {$(
        struct $name(VectorToScfOptions);

        impl Pattern for $name {
            fn name(&self) -> &str {
                stringify!($name)
            }

            fn root(&self) -> Option<&str> {
                Some($root)
            }

            #[allow(unused_variables)]
            fn rewrite(&self, $rw: &mut Rewriter<'_, '_>, $op: OpId) -> bool {
                let $o = self.0;
                $body
            }
        }
    )*};
}

/// `checkPrepareXferOp`.
fn check_prepare(b: &Body<'_>, op: OpId, x: &Xfer<'_>, o: VectorToScfOptions) -> bool {
    b[op].get(LABEL).is_none() && x.rank() > o.target_rank && !x.scalable0() && (!x.tensor || o.lower_tensors) && elem(&x.vt) == x.shaped_elem(b)
}

/// `TransferOpConversion<TransferReadOp / TransferWriteOp>`.
fn transfer_op_conversion<'a>(rw: &mut Rw<'_, 'a>, op: OpId, o: VectorToScfOptions) -> bool {
    let b = &*rw.body;
    if b[op].get(LABEL).is_none() {
        return false;
    }
    let Some(x) = Xfer::of(b, op) else { return false };
    // `Strategy<...>::getBuffer` and its indices.
    let (buffer, buf_indices, store) = if x.read {
        let r = b[op].results[0];
        let Some(u) = b[r].uses.first() else { return false };
        let s = u.op;
        if b[s].name != "memref.store" {
            return false;
        }
        (b[s].operands[1], b[s].operands[2..].to_vec(), Some(s))
    } else {
        let Some(l) = b.def_named(x.value, "memref.load") else { return false };
        (b[l].operands[0], b[l].operands[1..].to_vec(), None)
    };
    let Some(casted_ty) = unpack_one_dim(&b[buffer].ty) else { return false };
    let mask_buffer = x.mask.and_then(|m| b.def_named(m, "memref.load")).map(|l| b[l].operands[0]);
    let mask_rank = x.mask_rank(b);
    rw.set_before(op);
    let casted = rw.make1(OpData::build("vector.type_cast").operands(&[buffer]), casted_ty.clone());
    let mut casted_mask = None;
    if let Some(mb) = mask_buffer {
        casted_mask = Some(if x.broadcast0() || mask_rank == 1 {
            mb
        } else {
            let Some(t) = unpack_one_dim(&rw.body[mb].ty) else { return false };
            rw.make1(OpData::build("vector.type_cast").operands(&[mb]), t)
        });
    }
    let n = casted_ty.shape().and_then(|d| d.last()).map_or(0, |d| if let Dim::Static(n) = d { *n } else { 0 });
    let lb = rw.cidx(0);
    let ub = rw.cidx(n);
    let step = rw.cidx(1);
    let inits: Vec<ValueId> = if !x.read && x.tensor { vec![x.base] } else { Vec::new() };
    let in_bounds_rest = x.in_bounds.get(1..).unwrap_or(&[]).to_vec();
    let unpacked = x.unpacked_map();
    let elem_vt = elem(&casted_ty).clone();
    let for_op = rw.build_for(lb, ub, step, &inits, &mut |rw, iv, state| {
        let state_ty: Vec<Type> = state.iter().map(|s| rw.body[*s].ty.clone()).collect();
        let state = state.to_vec();
        let x2 = x.clone();
        let mut inside = |rw: &mut Rw<'_, 'a>| -> Option<ValueId> {
            // `Strategy<...>::rewriteOp`.
            let mut bi = buf_indices.clone();
            bi.push(iv);
            let xi = rw.xfer_indices(&x2, iv);
            let new = if x2.read {
                let n = rw.xfer_read(elem_vt.clone(), x2.base, &xi, &unpacked, x2.value, None, &in_bounds_rest);
                if vshape(&elem_vt).map_or(0, |s| s.0.len()) > o.target_rank {
                    rw.body[n].set(LABEL, Attribute::Unit);
                }
                let v = rw.body[n].results[0];
                rw.mstore(v, casted, &bi);
                n
            } else {
                let v = rw.mload(casted, &bi);
                let src = state.first().copied().unwrap_or(x2.base);
                let ty = x2.tensor.then(|| rw.body[x2.base].ty.clone());
                let n = rw.xfer_write(ty, v, src, &xi, &unpacked, None, &in_bounds_rest);
                if vshape(&elem_vt).map_or(0, |s| s.0.len()) > o.target_rank {
                    rw.body[n].set(LABEL, Attribute::Unit);
                }
                n
            };
            if let (Some(cm), Some(mb)) = (casted_mask, mask_buffer)
                && (x2.broadcast0() || mask_rank > 1)
            {
                let saved = rw.ip;
                rw.set_before(new);
                // `getMaskBufferLoadIndices`.
                let mut li: Vec<ValueId> = rw.body[mb].uses.iter().find(|u| rw.body[u.op].name == "memref.load").map(|u| rw.body[u.op].operands[1..].to_vec()).unwrap_or_default();
                if !x2.broadcast0() {
                    li.push(iv);
                }
                let m = rw.mload(cm, &li);
                rw.ip = saved;
                let k = rw.body[new].operands.len() - usize::from(x2.mask.is_some());
                let _ = k;
                let mut ops = rw.body[new].operands.clone();
                ops.push(m);
                rw.modify(new, |b| {
                    b.set_operands(new, ops);
                    let mut segs = b.segments(new, "operandSegmentSizes").unwrap_or_default();
                    if let Some(l) = segs.last_mut() {
                        *l = 1;
                    }
                    b[new].set("operandSegmentSizes", Attribute::dense_i32(&segs));
                });
            }
            (!state.is_empty()).then(|| rw.body[new].results[0])
        };
        let mut outside = |rw: &mut Rw<'_, 'a>| -> Option<ValueId> {
            // `Strategy<...>::handleOutOfBoundsDim`.
            if x.read {
                let mut bi = buf_indices.clone();
                bi.push(iv);
                let v = rw.broadcast(elem_vt.clone(), x.value);
                rw.mstore(v, casted, &bi);
                None
            } else if x.tensor {
                Some(state[0])
            } else {
                None
            }
        };
        let r = rw.in_bounds_check(&x, iv, x.unpacked_dim(), &state_ty, &mut inside, &mut outside);
        if state.is_empty() { Vec::new() } else { r.into_iter().collect() }
    });
    // `Strategy<...>::cleanup`.
    match store {
        Some(s) => {
            rw.erase_op(s);
            rw.erase_op(op);
        }
        None if x.tensor => {
            let r = rw.body[for_op].results[0];
            rw.replace_op(op, &[r]);
        }
        None => rw.erase_op(op),
    }
    true
}

/// `maybeAssignMask`.
fn maybe_assign_mask(rw: &mut Rw<'_, '_>, x: &Xfer<'_>, new: OpId, i: i64) {
    let Some(m) = x.mask else { return };
    let mask = if x.broadcast0() {
        m
    } else if x.mask_rank(rw.body) > 1 {
        let saved = rw.ip;
        rw.set_before(new);
        let e = rw.vextract_(m, &[i]);
        rw.ip = saved;
        e
    } else {
        return;
    };
    let mut ops = rw.body[new].operands.clone();
    ops.push(mask);
    rw.modify(new, |b| {
        b.set_operands(new, ops);
        let mut segs = b.segments(new, "operandSegmentSizes").unwrap_or_default();
        if let Some(l) = segs.last_mut() {
            *l = 1;
        }
        b[new].set("operandSegmentSizes", Attribute::dense_i32(&segs));
    });
}

patterns! {
    PrepareTransferReadConversion("vector.transfer_read") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if !check_prepare(b, op, &x, o) {
            return false;
        }
        rw.set_before(op);
        let (data, mask) = rw.alloc_buffers(op, &x);
        let mut map = crate::Mapping::default();
        let new = rw.clone(op, &mut map);
        rw.body[new].set(LABEL, Attribute::Unit);
        if let Some(m) = mask {
            let k = rw.body[new].operands.len() - 1;
            rw.body.set_operand(new, k, m);
        }
        let v = rw.body[new].results[0];
        rw.mstore(v, data, &[]);
        let l = rw.mload(data, &[]);
        rw.replace_op(op, &[l]);
        true
    }

    PrepareTransferWriteConversion("vector.transfer_write") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if !check_prepare(b, op, &x, o) {
            return false;
        }
        rw.set_before(op);
        let (data, mask) = rw.alloc_buffers(op, &x);
        rw.mstore(x.value, data, &[]);
        let l = rw.mload(data, &[]);
        rw.modify(op, |b| {
            b.set_operand(op, 0, l);
            b[op].set(LABEL, Attribute::Unit);
        });
        if let Some(m) = mask {
            let k = rw.body[op].operands.len() - 1;
            rw.modify(op, |b| b.set_operand(op, k, m));
        }
        true
    }

    TransferReadConversion("vector.transfer_read") |rw, op, o| {
        transfer_op_conversion(rw, op, o)
    }

    TransferWriteConversion("vector.transfer_write") |rw, op, o| {
        transfer_op_conversion(rw, op, o)
    }

    UnrollTransferReadConversion("vector.transfer_read") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.rank() <= o.target_rank || (x.tensor && !o.lower_tensors) || elem(&x.vt) != x.shaped_elem(b) || x.scalable0() {
            return false;
        }
        let r = b[op].results[0];
        let insert = match &b[r].uses[..] {
            [u] if b[u.op].name == "vector.insert" => Some(u.op),
            _ => None,
        };
        let prefix = insert.map(|i| mixed_position(b, i, 2)).unwrap_or_default();
        rw.set_before(op);
        let mut vec = match insert {
            Some(i) => rw.body[i].operands[1],
            None => rw.broadcast(x.vt.clone(), x.value),
        };
        let vec_ty = rw.body[vec].ty.clone();
        let new_vt = drop_dim0(&x.vt);
        let dim = vshape(&x.vt).map_or(0, |s| s.0[0]);
        let in_bounds_rest = x.in_bounds.get(1..).unwrap_or(&[]).to_vec();
        let map = x.unpacked_map();
        for i in 0..dim {
            let iv = rw.cidx(i);
            let cur = vec;
            vec = rw
                .in_bounds_check(
                    &x,
                    iv,
                    x.unpacked_dim(),
                    core::slice::from_ref(&vec_ty),
                    &mut |rw| {
                        let xi = rw.xfer_indices(&x, iv);
                        let mut pos = prefix.clone();
                        pos.push(Ofr::C(i));
                        let n = rw.xfer_read(new_vt.clone(), x.base, &xi, &map, x.value, None, &in_bounds_rest);
                        maybe_assign_mask(rw, &x, n, i);
                        let mut v = rw.body[n].results[0];
                        if vshape(&new_vt).is_some_and(|s| s.0.is_empty()) {
                            v = rw.vextract_(v, &[]);
                        }
                        Some(rw.mixed_insert(v, cur, &pos))
                    },
                    &mut |_| Some(cur),
                )
                .expect("a vector");
        }
        match insert {
            Some(ins) => {
                rw.replace_op(ins, &[vec]);
                rw.erase_op(op);
            }
            None => rw.replace_op(op, &[vec]),
        }
        true
    }

    UnrollTransferWriteConversion("vector.transfer_write") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.rank() <= o.target_rank || (x.tensor && !o.lower_tensors) || elem(&x.vt) != x.shaped_elem(b) {
            return false;
        }
        let extract = b.def_named(x.value, "vector.extract");
        let vec = extract.map_or(x.value, |e| b[e].operands[0]);
        if x.scalable0() {
            return false;
        }
        let prefix = extract.map(|e| mixed_position(b, e, 1)).unwrap_or_default();
        let dim = vshape(&x.vt).map_or(0, |s| s.0[0]);
        let mut source = x.base;
        let source_ty = x.tensor.then(|| b[x.base].ty.clone());
        let types: Vec<Type> = source_ty.iter().cloned().collect();
        let rank1 = x.rank() == 1;
        let in_bounds_rest = x.in_bounds.get(1..).unwrap_or(&[]).to_vec();
        let map = x.unpacked_map();
        rw.set_before(op);
        for i in 0..dim {
            let iv = rw.cidx(i);
            let src = source;
            let updated = rw.in_bounds_check(
                &x,
                iv,
                x.unpacked_dim(),
                &types,
                &mut |rw| {
                    let xi = rw.xfer_indices(&x, iv);
                    let mut pos = prefix.clone();
                    pos.push(Ofr::C(i));
                    let e = rw.mixed_extract(vec, &pos);
                    let xv = if rank1 {
                        let t = rw.body[e].ty.clone();
                        rw.broadcast(Type::vector(&[], &[], t), e)
                    } else {
                        e
                    };
                    let n = rw.xfer_write(source_ty.clone(), xv, src, &xi, &map, None, &in_bounds_rest);
                    maybe_assign_mask(rw, &x, n, i);
                    x.tensor.then(|| rw.body[n].results[0])
                },
                &mut |_| x.tensor.then_some(src),
            );
            if x.tensor {
                source = updated.expect("a tensor");
            }
        }
        if x.tensor {
            rw.replace_op(op, &[source]);
        } else {
            rw.erase_op(op);
        }
        true
    }

    DecomposePrintOpConversion("vector.print") |rw, op, o| {
        decompose_print(rw, op)
    }

    ScalableTransposeTransferWriteConversion("vector.transfer_write") |rw, op, o| {
        scalable_transpose_write(rw, op, o)
    }

    TransferRead1dConversion("vector.transfer_read") |rw, op, o| {
        transfer_1d(rw, op)
    }

    TransferWrite1dConversion("vector.transfer_write") |rw, op, o| {
        transfer_1d(rw, op)
    }

    TransferReadPermutationLowering("vector.transfer_read") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.map.results.is_empty() || b.in_mask(op) {
            return false;
        }
        let Some(perm) = permutation_of_minor_identity(&x.map) else { return false };
        let pm = AffineMap { dims: perm.iter().max().map_or(0, |m| *m as u32 + 1), syms: 0, results: perm.iter().map(|p| AffineExpr::Dim(*p as u32)).collect() };
        if pm.is_identity() {
            return false;
        }
        let Some(inv) = inverse_permutation(&pm) else { return false };
        let new_map = inv.compose(&x.map);
        let (shape, sc) = vshape(&x.vt).expect("a vector");
        let (mut ns, mut nsc, mut nib) = (vec![0; shape.len()], vec![false; shape.len()], vec![false; perm.len()]);
        for (i, p) in perm.iter().enumerate() {
            ns[*p] = shape[i];
            nsc[*p] = sc[i];
            nib[*p] = x.in_bounds.get(i).copied().unwrap_or(false);
        }
        let nt = Type::vector(&ns, &nsc, elem(&x.vt).clone());
        rw.set_before(op);
        let n = rw.xfer_read(nt, x.base, &x.indices, &new_map, x.value, x.mask, &nib);
        let v = rw.body[n].results[0];
        let perm64: Vec<i64> = perm.iter().map(|p| *p as i64).collect();
        let t = rw.make1(OpData::build("vector.transpose").operands(&[v]).with("permutation", Attribute::dense_i64(&perm64)), x.vt.clone());
        rw.replace_op(op, &[t]);
        true
    }

    TransferWritePermutationLowering("vector.transfer_write") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.map.results.is_empty() || b.in_mask(op) || minor_identity(&x.map) {
            return false;
        }
        let Some(perm) = permutation_of_minor_identity(&x.map) else { return false };
        // `compressUnusedDims`, then `inversePermutation`.
        let used: Vec<u32> = (0..x.map.dims).filter(|d| x.map.uses_dim(*d)).collect();
        let comp = AffineMap { dims: used.len() as u32, syms: 0, results: x.map.results.iter().map(|r| if let AffineExpr::Dim(d) = r { AffineExpr::Dim(used.iter().position(|u| u == d).expect("used") as u32) } else { r.clone() }).collect() };
        let Some(inv) = inverse_permutation(&comp) else { return false };
        let indices: Vec<i64> = inv.results.iter().map(|r| if let AffineExpr::Dim(d) = r { i64::from(*d) } else { 0 }).collect();
        let mut nib = vec![false; perm.len()];
        for (i, p) in perm.iter().enumerate() {
            nib[*p] = x.in_bounds.get(i).copied().unwrap_or(false);
        }
        let (shape, sc) = vshape(&x.vt).expect("a vector");
        let tshape: Vec<i64> = indices.iter().map(|i| shape[*i as usize]).collect();
        let tsc: Vec<bool> = indices.iter().map(|i| sc[*i as usize]).collect();
        let tt = Type::vector(&tshape, &tsc, elem(&x.vt).clone());
        let n = x.map.results.len() as u32;
        let new_map = AffineMap { dims: x.map.dims, syms: 0, results: (x.map.dims - n..x.map.dims).map(AffineExpr::Dim).collect() };
        rw.set_before(op);
        let t = rw.make1(OpData::build("vector.transpose").operands(&[x.value]).with("permutation", Attribute::dense_i64(&indices)), tt);
        let ty = x.tensor.then(|| rw.body[x.base].ty.clone());
        let w = rw.xfer_write(ty, t, x.base, &x.indices, &new_map, x.mask, &nib);
        if x.tensor {
            let r = rw.body[w].results[0];
            rw.replace_op(op, &[r]);
        } else {
            rw.erase_op(op);
        }
        true
    }

    TransferOpReduceRank("vector.transfer_read") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.map.results.is_empty() || b.in_mask(op) {
            return false;
        }
        let lead = x.map.results.iter().take_while(|r| matches!(r, AffineExpr::Const(0))).count();
        if lead == 0 {
            return false;
        }
        let keep = x.rank() - lead;
        let new_map = AffineMap { results: x.map.results[x.map.results.len() - keep..].to_vec(), ..x.map.clone() };
        if !minor_identity_with_broadcasting(&new_map) {
            return false;
        }
        let (shape, sc) = vshape(&x.vt).expect("a vector");
        let nt = Type::vector(&shape[shape.len() - keep..], &sc[sc.len() - keep..], elem(&x.vt).clone());
        let nib = x.in_bounds[x.in_bounds.len().saturating_sub(keep)..].to_vec();
        rw.set_before(op);
        let n = rw.xfer_read(nt, x.base, &x.indices, &new_map, x.value, x.mask, &nib);
        let v = rw.body[n].results[0];
        let r = rw.broadcast(x.vt.clone(), v);
        rw.replace_op(op, &[r]);
        true
    }

    TransferWriteNonPermutationLowering("vector.transfer_write") |rw, op, o| {
        let b = &*rw.body;
        let Some(x) = Xfer::of(b, op) else { return false };
        if x.map.results.is_empty() || b.in_mask(op) || permutation_of_minor_identity(&x.map).is_some() {
            return false;
        }
        let mut found = vec![false; x.map.dims as usize];
        for r in &x.map.results {
            let AffineExpr::Dim(d) = r else { return false };
            found[*d as usize] = true;
        }
        let mut exprs = Vec::new();
        let mut first = false;
        for (i, f) in found.iter().enumerate() {
            if *f {
                first = true;
                continue;
            }
            if first {
                exprs.push(AffineExpr::Dim(i as u32));
            }
        }
        let k = exprs.len();
        let (shape, sc) = vshape(&x.vt).expect("a vector");
        let mut ns = vec![1i64; k];
        ns.extend(&shape);
        let mut nsc = vec![false; k];
        nsc.extend(&sc);
        rw.set_before(op);
        let nv = rw.broadcast(Type::vector(&ns, &nsc, elem(&x.vt).clone()), x.value);
        let mut nm = None;
        if let Some(m) = x.mask {
            let mt = rw.body[m].ty.clone();
            let (ms, msc) = vshape(&mt).expect("a vector");
            let mut s2 = vec![1i64; k];
            s2.extend(&ms);
            let mut c2 = vec![false; k];
            c2.extend(&msc);
            let bm = rw.broadcast(Type::vector(&s2, &c2, elem(&mt).clone()), m);
            let r = s2.len();
            let perm: Vec<i64> = (k..r).chain(0..k).map(|i| i as i64).collect();
            let ts: Vec<i64> = perm.iter().map(|p| s2[*p as usize]).collect();
            let tc: Vec<bool> = perm.iter().map(|p| c2[*p as usize]).collect();
            nm = Some(rw.make1(OpData::build("vector.transpose").operands(&[bm]).with("permutation", Attribute::dense_i64(&perm)), Type::vector(&ts, &tc, elem(&mt).clone())));
        }
        exprs.extend(x.map.results.iter().cloned());
        let new_map = AffineMap { dims: x.map.dims, syms: 0, results: exprs };
        let mut nib = vec![true; k];
        nib.extend((0..x.rank()).map(|i| x.in_bounds.get(i).copied().unwrap_or(false)));
        let ty = x.tensor.then(|| rw.body[x.base].ty.clone());
        let w = rw.xfer_write(ty, nv, x.base, &x.indices, &new_map, nm, &nib);
        if x.tensor {
            let r = rw.body[w].results[0];
            rw.replace_op(op, &[r]);
        } else {
            rw.erase_op(op);
        }
        true
    }
}

/// `DecomposePrintOpConversion`: a vector printed element by element in loops.
fn decompose_print(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(&src) = b[op].operands.first() else { return false };
    let Some((shape0, scal)) = vshape(&b[src].ty) else { return false };
    if shape0.len() > 1 && scal.iter().any(|s| *s) {
        return false;
    }
    let punct = match b[op].get("punctuation") {
        Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().unwrap_or("<newline>").trim_matches(|c| c == '<' || c == '>').into(),
        _ => alloc::string::String::from("newline"),
    };
    let mut vt = b[src].ty.clone();
    let mut value = src;
    rw.set_before(op);
    if let Type::Integer { signedness, width } = elem(&vt).clone() {
        let legal = (width.max(8) - 1).next_power_of_two().max(8);
        let legal = if legal == width.max(8) - 1 { legal * 2 } else { legal };
        let with = |w: u32, sg: mlirformat::Signedness| Type::vector(&shape0, &scal, Type::Integer { signedness: sg, width: w });
        let (ss, st, tt) = (with(width, mlirformat::Signedness::Signless), with(legal, mlirformat::Signedness::Signless), with(legal, signedness));
        value = rw.make1(OpData::build("vector.bitcast").operands(&[value]), ss);
        if rw.body[value].ty != st {
            let ext = if width == 1 || signedness == mlirformat::Signedness::Unsigned { "arith.extui" } else { "arith.extsi" };
            value = rw.make1(OpData::build(ext).operands(&[value]), st);
        }
        value = rw.make1(OpData::build("vector.bitcast").operands(&[value]), tt.clone());
        vt = tt;
    }
    let shape = if shape0.is_empty() { vec![1] } else { shape0.clone() };
    if shape0.len() != 1 {
        let flat = Type::vector(&[shape.iter().product()], &[], elem(&vt).clone());
        value = rw.make1(OpData::build("vector.shape_cast").operands(&[value]), flat);
    }
    let mut first_close = None;
    let mut ivs = Vec::new();
    for (d, n) in shape.iter().enumerate() {
        let lb = rw.cidx(0);
        let mut ub = rw.cidx(*n);
        let step = rw.cidx(1);
        if scal.get(d) == Some(&true) {
            let vs = rw.make1(OpData::build("vector.vscale"), Type::Index);
            ub = rw.make1(OpData::build("arith.muli").operands(&[ub, vs]), Type::Index);
        }
        let last = rw.make1(OpData::build("arith.subi").operands(&[ub, step]), Type::Index);
        rw.print(None, "open");
        let lp = rw.bare_for(lb, ub, step);
        let close = rw.print(None, "close");
        let blk = rw.body.top_block(lp);
        if first_close.is_none() {
            first_close = Some(close);
        }
        let iv = rw.body[blk].args[0];
        ivs.push(iv);
        rw.set_start(blk);
        let not_last = rw.make1(OpData::build("arith.cmpi").operands(&[iv, last]).with("predicate", Attribute::Int { lit: "6".into(), ty: Some(Type::int(64)) }), Type::int(1));
        rw.build_if_then(not_last, &mut |rw| {
            rw.print(None, "comma");
        });
        rw.set_start(blk);
    }
    let mut flat: Option<ValueId> = None;
    let mut stride = 1i64;
    for d in (0..shape.len()).rev() {
        let s = rw.cidx(stride);
        let idx = rw.make1(OpData::build("arith.muli").operands(&[s, ivs[d]]), Type::Index);
        flat = Some(match flat {
            Some(f) => rw.make1(OpData::build("arith.addi").operands(&[f, idx]), Type::Index),
            None => idx,
        });
        stride *= shape[d];
    }
    let e = rw.extract_dyn(value, flat.expect("an index"));
    rw.print(Some(e), "no_punctuation");
    if let Some(c) = first_close {
        rw.set_after(c);
    }
    rw.print(None, &punct);
    rw.erase_op(op);
    true
}

/// `ScalableTransposeTransferWriteConversion`.
fn scalable_transpose_write(rw: &mut Rw<'_, '_>, op: OpId, o: VectorToScfOptions) -> bool {
    let b = &*rw.body;
    let Some(x) = Xfer::of(b, op) else { return false };
    if x.tensor && !o.lower_tensors {
        return false;
    }
    let Some((shape, sc)) = vshape(&x.vt) else { return false };
    if sc != [true, false] || !x.map.is_identity() || !x.in_bounds0() {
        return false;
    }
    let Some(t) = b.def_named(x.value, "vector.transpose").filter(|t| b.dense_i64(*t, "permutation") == [1, 0]) else { return false };
    let src = b[t].operands[0];
    let mask_dims: Option<Vec<Ofr>> = match x.mask {
        None => Some(Vec::new()),
        Some(m) => match b.def_op(m) {
            Some(d) if b[d].name == "vector.create_mask" => Some(b[d].operands.iter().map(|v| Ofr::V(*v)).collect()),
            Some(d) if b[d].name == "vector.constant_mask" => {
                let dims = b.dense_i64(d, "mask_dim_sizes");
                let msc = vshape(&b[m].ty).map(|s| s.1).unwrap_or_default();
                Some(dims.iter().zip(msc.iter().chain(core::iter::repeat(&false))).map(|(n, s)| if *s { Ofr::C(-*n - 1) } else { Ofr::C(*n) }).collect())
            }
            _ => None,
        },
    };
    let Some(mask_dims) = mask_dims else { return false };
    rw.set_before(op);
    let mut vscale: Option<ValueId> = None;
    let mut vs_mul = |rw: &mut Rw<'_, '_>, n: i64| -> ValueId {
        let v = match vscale {
            Some(v) => v,
            None => {
                let v = rw.make1(OpData::build("vector.vscale"), Type::Index);
                vscale = Some(v);
                v
            }
        };
        let c = rw.cidx(n);
        rw.make1(OpData::build("arith.muli").operands(&[v, c]), Type::Index)
    };
    // Constant mask sizes of scalable dims, as vscale multiples (encoded as `-n - 1`).
    let mask_dims: Vec<Ofr> = mask_dims.into_iter().map(|d| if let Ofr::C(c) = d && c < 0 { Ofr::V(vs_mul(rw, -c - 1)) } else { d }).collect();
    let slices: Vec<ValueId> = (0..shape[1]).map(|i| rw.vextract_(src, &[i])).collect();
    let lb = rw.cidx(0);
    let ub = match mask_dims.first() {
        None => vs_mul(rw, shape[0]),
        Some(Ofr::V(v)) => *v,
        Some(Ofr::C(c)) => rw.cidx(*c),
    };
    let step = rw.cidx(1);
    let slice_ty = Type::vector(&shape[1..], &sc[1..], elem(&x.vt).clone());
    let mut slice_mask = None;
    if !mask_dims.is_empty() {
        let vals: Vec<ValueId> = mask_dims[1..].iter().map(|d| match d {
            Ofr::V(v) => *v,
            Ofr::C(c) => rw.cidx(*c),
        }).collect();
        slice_mask = Some(rw.make1(OpData::build("vector.create_mask").operands(&vals), Type::vector(&shape[1..], &sc[1..], Type::int(1))));
    }
    let inits: Vec<ValueId> = if x.tensor { vec![x.base] } else { Vec::new() };
    let in_bounds_rest = x.in_bounds.get(1..).unwrap_or(&[]).to_vec();
    let rank = rw.body[x.base].ty.shape().map_or(0, <[Dim]>::len) as u32;
    let map = AffineMap { dims: rank, syms: 0, results: vec![AffineExpr::Dim(rank - 1)] };
    let f = rw.build_for(lb, ub, step, &inits, &mut |rw, iv, args| {
        let xi = rw.xfer_indices(&x, iv);
        let els: Vec<ValueId> = slices.iter().map(|s| rw.extract_dyn(*s, iv)).collect();
        let sv = rw.make1(OpData::build("vector.from_elements").operands(&els), slice_ty.clone());
        let dest = args.first().copied().unwrap_or(x.base);
        let ty = x.tensor.then(|| rw.body[dest].ty.clone());
        let w = rw.xfer_write(ty, sv, dest, &xi, &map, slice_mask, &in_bounds_rest);
        if args.is_empty() { Vec::new() } else { vec![rw.body[w].results[0]] }
    });
    if x.tensor {
        let r = rw.body[f].results[0];
        rw.replace_op(op, &[r]);
    } else {
        rw.erase_op(op);
    }
    true
}

/// `TransferOp1dConversion`.
fn transfer_1d(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
    let b = &*rw.body;
    let Some(x) = Xfer::of(b, op) else { return false };
    if x.map.results.is_empty() || x.rank() != 1 {
        return false;
    }
    let Type::Shaped(mt) = &b[x.base].ty else { return false };
    if mt.kind != ShapedKind::MemRef {
        return false;
    }
    let unit = LlvmOptions::default().strides_and_offset(mt).is_some_and(|(s, _)| s.last().is_none_or(|l| *l == 1));
    if minor_identity(&x.map) && unit {
        return false;
    }
    let (shape, sc) = vshape(&x.vt).expect("a vector");
    rw.set_before(op);
    let lb = rw.cidx(0);
    let mut ub = rw.cidx(shape[0]);
    if sc[0] {
        let vs = rw.make1(OpData::build("vector.vscale"), Type::Index);
        ub = rw.make1(OpData::build("arith.muli").operands(&[ub, vs]), Type::Index);
    }
    let step = rw.cidx(1);
    let inits: Vec<ValueId> = if x.read { vec![rw.broadcast(x.vt.clone(), x.value)] } else { Vec::new() };
    let vt = x.vt.clone();
    let f = rw.build_for(lb, ub, step, &inits, &mut |rw, iv, state| {
        // `get1dMemrefIndices`.
        let mut idx = x.indices.clone();
        if let Some(d) = x.unpacked_dim() {
            idx[d] = rw.add_apply(x.indices[d], iv);
        }
        if x.read {
            let cur = state[0];
            let next = rw.in_bounds_check(
                &x,
                iv,
                x.unpacked_dim(),
                core::slice::from_ref(&vt),
                &mut |rw| {
                    let v = rw.mload(x.base, &idx);
                    Some(rw.mixed_insert(v, cur, &[Ofr::V(iv)]))
                },
                &mut |_| Some(cur),
            );
            next.into_iter().collect()
        } else {
            rw.in_bounds_check(
                &x,
                iv,
                x.unpacked_dim(),
                &[],
                &mut |rw| {
                    let v = rw.extract_dyn(x.value, iv);
                    rw.mstore(v, x.base, &idx);
                    None
                },
                &mut |_| None,
            );
            Vec::new()
        }
    });
    let results = rw.body[f].results.clone();
    rw.replace_op(op, &results);
    true
}

/// `convert-vector-to-scf`.
#[pass("convert-vector-to-scf")]
pub struct ConvertVectorToScf {
    #[opt("full-unroll")]
    unroll: bool,
    #[opt("target-rank", default = 1)]
    target_rank: usize,
    #[opt("lower-tensors")]
    lower_tensors: bool,
    #[opt("lower-scalable")]
    lower_scalable: bool,
}

impl Run for ConvertVectorToScf {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let o = VectorToScfOptions { unroll: self.unroll, target_rank: self.target_rank, lower_tensors: self.lower_tensors, lower_scalable: self.lower_scalable };
        let mut first = PatternSet::default();
        first.add(TransferReadPermutationLowering(o)).add(TransferWritePermutationLowering(o)).add(TransferOpReduceRank(o)).add(TransferWriteNonPermutationLowering(o));
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &first, &GreedyConfig::default());
        }
        let mut set = PatternSet::default();
        if o.unroll {
            set.add(UnrollTransferReadConversion(o)).add(UnrollTransferWriteConversion(o));
        } else {
            set.add(PrepareTransferReadConversion(o)).add(PrepareTransferWriteConversion(o)).add(TransferReadConversion(o)).add(TransferWriteConversion(o));
        }
        if o.lower_scalable {
            set.add(ScalableTransposeTransferWriteConversion(o));
        }
        if o.target_rank == 1 {
            set.add(TransferRead1dConversion(o)).add(TransferWrite1dConversion(o));
        }
        set.add(DecomposePrintOpConversion(o));
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &set, &GreedyConfig::default());
        }
        Ok(())
    }
}
