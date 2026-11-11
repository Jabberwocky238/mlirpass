//! `vector` ⇒ `xegpu`, as `VectorToXeGPU.cpp`: loads and stores (transfers too, on chips with
//! 2-D block I/O) as nd descriptors, the rest as gathers and scatters on the flat address,
//! row-major contractions as `xegpu.dpas`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use crate::{AffineExpr, AffineMap, Chip, MemrefLayout, MemrefOfr as Ofr, OpData, OpId, Rewriter, ValueId};

type Rw<'r, 'a> = Rewriter<'r, 'a>;

fn memref_of<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Some(s),
        _ => None,
    }
}

fn vector_shape(t: &Type<'_>) -> Option<Vec<i64>> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::Vector => s.dims(),
        _ => None,
    }
}

fn shaped<'a>(kind: ShapedKind, shape: &[i64], elem: Type<'a>) -> Type<'a> {
    Type::Shaped(alloc::boxed::Box::new(Shaped { kind, shape: Some(shape.iter().map(|&n| if n == Dim::DYNAMIC { Dim::Dynamic } else { Dim::Static(n) }).collect()), elem: elem.into(), extras: Vec::new() }))
}

/// `TensorDescType::get(shape, elem, array_length 1, boundary_check, global)`: the encoding
/// only when the boundary check is off.
fn tensor_desc<'a>(shape: &[i64], elem: &Type<'_>, boundary_check: bool) -> Option<Type<'a>> {
    let dims: String = shape.iter().map(|d| format!("{d}x")).collect();
    let enc = if boundary_check { String::new() } else { String::from(", #xegpu.block_tdesc_attr<boundary_check = false>") };
    let text = format!("!xegpu.tensor_desc<{dims}{elem}{enc}>");
    mlirformat::Parser::read(&text, |p| p.ty()).ok().map(|t| t.owned())
}

/// The builders the lowerings share.
trait Xg<'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId;
    fn bin(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId;
    fn splat_to(&mut self, v: ValueId, ty: Type<'a>) -> ValueId;
    fn ofr_of(&self, v: ValueId) -> Ofr;
    fn strided_metadata(&mut self, m: ValueId) -> Option<(ValueId, ValueId, Vec<ValueId>, Vec<ValueId>)>;
}

impl<'a> Xg<'a> for Rw<'_, 'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    fn bin(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.body[a].ty.clone();
        self.mk(OpData::build(name).operands(&[a, b]), ty)
    }

    fn splat_to(&mut self, v: ValueId, ty: Type<'a>) -> ValueId {
        self.mk(OpData::build("vector.broadcast").operands(&[v]), ty)
    }

    /// `getAsOpFoldResult`.
    fn ofr_of(&self, v: ValueId) -> Ofr {
        self.body.int_constant(v).map_or(Ofr::V(v), |c| Ofr::C(c as i64))
    }

    /// `memref.extract_strided_metadata` of `m`: base, offset, sizes, strides.
    fn strided_metadata(&mut self, m: ValueId) -> Option<(ValueId, ValueId, Vec<ValueId>, Vec<ValueId>)> {
        let s = memref_of(&self.body[m].ty)?.clone();
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        let base = Type::Shaped(alloc::boxed::Box::new(Shaped { shape: Some(Vec::new()), extras: s.memory_space().cloned().into_iter().collect(), ..s.clone() }));
        let types: Vec<Type<'a>> = [base, Type::Index].into_iter().chain(core::iter::repeat_n(Type::Index, 2 * rank)).collect();
        let o = self.create(OpData::build("memref.extract_strided_metadata").operands(&[m]), &types);
        let r = self.body[o].results.clone();
        Some((r[0], r[1], r[2..2 + rank].to_vec(), r[2 + rank..].to_vec()))
    }
}

/// The vector ⇒ xegpu patterns (`populateVectorToXeGPUConversionPatterns`).
pub struct VectorToXegpu;

impl VectorToXegpu {
    /// `xegpu::getChipStr` is pvc, bmg or cri (2-D block I/O).
    fn block_io(rw: &Rw<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at.filter(|o| b[*o].name != "gpu.module") {
            at = b.parent_op(o);
        }
        let Some(Attribute::Array(ts)) = at.and_then(|m| b[m].get("targets")) else { return false };
        matches!(ts.iter().find_map(Chip::of_target), Some(Chip::Pvc | Chip::Bmg | Chip::Cri))
    }

    /// `transferPreconditions`.
    fn transfer_ok(rw: &Rw<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let (base, _, _, mask) = b.xfer_parts(op);
        if mask.is_some() {
            return false;
        }
        let Some(s) = memref_of(&b[base].ty) else { return false };
        // Strides known, not a 0-D memref, contiguous innermost.
        if !s.strides_and_offset().is_some_and(|(st, _)| st.last() == Some(&1)) {
            return false;
        }
        let Some(shape) = vector_shape(&b.xfer_vector_type(op)) else { return false };
        let rank = shape.len() as u32;
        if rank == 0 {
            return false;
        }
        if b.xfer_out_of_bounds(op) && rank < 2 {
            return false;
        }
        let Some(map) = b.affine_map(op, "permutation_map") else { return false };
        Self::projected_permutation(&map) && map.results.iter().rev().take(rank as usize).all(|e| matches!(e, AffineExpr::Dim(d) if *d >= map.dims - rank))
    }

    /// `XeGPUDialect::isSharedMemory`: memory space 3, `#xegpu.memory_space<slm>`,
    /// `#xevm.addr_space<shared>` or `#gpu.address_space<workgroup>`.
    pub(crate) fn shared_memory(t: &Type<'_>) -> bool {
        let Some(s) = memref_of(t) else { return false };
        match s.memory_space() {
            Some(Attribute::Int { lit, .. }) => lit == "3",
            Some(a) => {
                let text = format!("{a}");
                text.contains("memory_space<slm>") || text.contains("addr_space<shared>") || text == "#gpu.address_space<workgroup>"
            }
            None => false,
        }
    }

    /// `storeLoadPreconditions`: a 1-D or 2-D vector of integers or floats, the memref's
    /// elements integers or floats.
    fn store_load_ok(vt: &Type<'_>, mt: &Type<'_>) -> bool {
        let scalar = |t: &Type<'_>| matches!(t, Type::Integer { .. } | Type::Float(_));
        let (Type::Shaped(v), Some(m)) = (vt, memref_of(mt)) else { return false };
        matches!(v.dims().map(|d| d.len()), Some(1 | 2)) && scalar(&v.elem) && scalar(&m.elem)
    }

    /// `xegpu.create_mem_desc` of SLM memref `base`: `!xegpu.mem_desc<shape x elem>`.
    fn mem_desc(rw: &mut Rw<'_, '_>, base: ValueId) -> Option<ValueId> {
        let s = memref_of(&rw.body[base].ty)?.clone();
        let dims: String = s.dims()?.iter().map(|d| format!("{d}x")).collect();
        let ty = mlirformat::Parser::read(&format!("!xegpu.mem_desc<{dims}{}>", s.elem), |p| p.ty()).ok()?.owned();
        Some(rw.mk(OpData::build("xegpu.create_mem_desc").operands(&[base]), ty))
    }

    /// `isProjectedPermutation(false)`: distinct dims.
    fn projected_permutation(m: &AffineMap) -> bool {
        let mut seen = Vec::new();
        m.syms == 0
            && m.results.iter().all(|e| match e {
                AffineExpr::Dim(d) if !seen.contains(d) => {
                    seen.push(*d);
                    true
                }
                _ => false,
            })
    }

    fn minor_identity(m: &AffineMap) -> bool {
        let n = m.results.len() as u32;
        m.dims >= n && m.results.iter().enumerate().all(|(i, e)| matches!(e, AffineExpr::Dim(d) if *d == m.dims - n + i as u32))
    }

    /// `adjustStridesForPermutation`: through `inverseAndBroadcastProjectedPermutation` and
    /// `isPermutationOfMinorIdentityWithBroadcasting`.
    fn permute_strides(m: &AffineMap, strides: Vec<ValueId>) -> Vec<ValueId> {
        let n_res = m.results.len() as u32;
        // The inverse: `dims` results over `n_res` inputs, a 0 where an input is unused.
        let mut inv: Vec<Option<u32>> = vec![None; m.dims as usize];
        for (i, e) in m.results.iter().enumerate() {
            if let AffineExpr::Dim(d) = e {
                inv[*d as usize] = Some(i as u32);
            }
        }
        let (inputs, results) = (n_res, m.dims);
        let start = inputs.saturating_sub(results);
        let lead = results.saturating_sub(inputs);
        let mut perm = vec![0u32; results as usize];
        let mut found = vec![false; inputs.max(results) as usize];
        let mut bcast = Vec::new();
        for (i, r) in inv.iter().enumerate() {
            match r {
                None => bcast.push(i),
                Some(d) => {
                    let p = d - start + lead;
                    perm[i] = p;
                    found[p as usize] = true;
                }
            }
        }
        let mut pos = 0;
        for i in bcast {
            while pos < found.len() && found[pos] {
                pos += 1;
            }
            perm[i] = pos as u32;
            pos += 1;
        }
        perm.iter().map(|&p| strides[p as usize]).collect()
    }

    /// `computeMemrefMeta`: the strides (permuted for a transfer) and the offset of `base`.
    fn memref_meta(rw: &mut Rw<'_, '_>, op: OpId, base: ValueId) -> Option<(Vec<ValueId>, ValueId)> {
        let s = memref_of(&rw.body[base].ty)?.clone();
        let mut strides = Vec::new();
        let mut offset = None;
        if s.shape.as_ref().is_some_and(|sh| sh.iter().all(|d| matches!(d, Dim::Static(_)))) {
            let (st, off) = s.strides_and_offset()?;
            if !st.contains(&Dim::DYNAMIC) {
                strides = st.iter().map(|&x| rw.value_of(Ofr::C(x))).collect();
            }
            if off != Dim::DYNAMIC {
                offset = Some(rw.value_of(Ofr::C(off)));
            }
        }
        if strides.is_empty() || offset.is_none() {
            // The base as `memref<elem>`, without a memory space.
            let rank = s.shape.as_ref().map_or(0, Vec::len);
            let types: Vec<Type<'_>> = [shaped(ShapedKind::MemRef, &[], (*s.elem).clone()), Type::Index].into_iter().chain(core::iter::repeat_n(Type::Index, 2 * rank)).collect();
            let o = rw.create(OpData::build("memref.extract_strided_metadata").operands(&[base]), &types);
            let r = rw.body[o].results.clone();
            if strides.is_empty() {
                strides = r[2 + rank..].to_vec();
            }
            offset = offset.or(Some(r[1]));
        }
        let _ = op;
        Some((strides, offset?))
    }

    /// `computeOffsets` of a transfer: the strided steps of each vector dimension (the strides
    /// permuted to the vector's order), broadcast and summed, plus the linearized indices (the
    /// memref's order).
    fn transfer_offsets(rw: &mut Rw<'_, '_>, op: OpId, strides: &[ValueId], mut base: ValueId) -> Option<ValueId> {
        let shape = vector_shape(&rw.body.xfer_vector_type(op))?;
        let (_, indices, _, _) = rw.body.xfer_parts(op);
        let map = rw.body.affine_map(op, "permutation_map")?;
        let permuted = Self::permute_strides(&map, strides.to_vec());
        let steps: Vec<ValueId> = shape.iter().map(|&d| rw.mk(OpData::build("vector.step"), shaped(ShapedKind::Vector, &[d], Type::Index))).collect();
        let (mr, vr) = (permuted.len(), shape.len());
        let mut muls = Vec::new();
        for i in 0..vr {
            let ty = rw.body[steps[i]].ty.clone();
            let b = rw.splat_to(permuted[mr - vr + i], ty);
            muls.push(rw.bin("arith.muli", steps[i], b));
        }
        let full = shaped(ShapedKind::Vector, &shape, Type::Index);
        let mut casts = Vec::new();
        for (i, m) in muls.into_iter().enumerate() {
            let mut unit = vec![1; vr];
            unit[i] = shape[i];
            casts.push(rw.mk(OpData::build("vector.shape_cast").operands(&[m]), shaped(ShapedKind::Vector, &unit, Type::Index)));
        }
        let bcast: Vec<ValueId> = casts.into_iter().map(|c| rw.splat_to(c, full.clone())).collect();
        let mut local = bcast[0];
        for b in &bcast[1..] {
            local = rw.bin("arith.addi", local, *b);
        }
        for (i, idx) in indices.iter().enumerate() {
            let c = rw.bin("arith.muli", *idx, strides[i]);
            base = rw.bin("arith.addi", base, c);
        }
        let b = rw.splat_to(base, full);
        Some(rw.bin("arith.addi", b, local))
    }

    /// `computeOffsets` of a gather / scatter.
    fn gather_offsets(rw: &mut Rw<'_, '_>, offsets: &[ValueId], indices: ValueId, strides: &[ValueId], mut base: ValueId) -> ValueId {
        for (o, s) in offsets.iter().zip(strides) {
            let c = rw.bin("arith.muli", *o, *s);
            base = rw.bin("arith.addi", base, c);
        }
        let ity = rw.body[indices].ty.clone();
        let sv = rw.splat_to(*strides.last().expect("a stride"), ity.clone());
        let si = rw.bin("arith.muli", sv, indices);
        let shape = vector_shape(&ity).unwrap_or_default();
        let bv = rw.splat_to(base, shaped(ShapedKind::Vector, &shape, Type::Index));
        rw.bin("arith.addi", bv, si)
    }

    /// `memrefToIndexPtr`.
    fn index_ptr(rw: &mut Rw<'_, '_>, base: ValueId) -> ValueId {
        let p = rw.mk(OpData::build("memref.extract_aligned_pointer_as_index").operands(&[base]), Type::Index);
        rw.mk(OpData::build("arith.index_cast").operands(&[p]), Type::int(64))
    }

    /// `convertMemrefAndOffsetsToTargetRank`: the leading dimensions taken by a rank-reducing
    /// subview.
    fn to_rank(rw: &mut Rw<'_, '_>, m: ValueId, offsets: Vec<Ofr>, rank: usize) -> Option<(ValueId, Vec<Ofr>)> {
        let s = memref_of(&rw.body[m].ty)?.clone();
        let shape = s.dims()?;
        if shape.len() <= rank {
            return Some((m, offsets));
        }
        let combined = shape.len() - rank;
        let (_, _, sizes_v, _) = rw.strided_metadata(m)?;
        let mut offs: Vec<Ofr> = offsets[..combined].to_vec();
        let mut sizes = vec![Ofr::C(1); combined];
        let mut result = Vec::new();
        for i in combined..shape.len() {
            offs.push(Ofr::C(0));
            if shape[i] == Dim::DYNAMIC {
                sizes.push(Ofr::V(sizes_v[i]));
                result.push(Dim::DYNAMIC);
            } else {
                sizes.push(Ofr::C(shape[i]));
                result.push(shape[i]);
            }
        }
        let strides = vec![Ofr::C(1); shape.len()];
        let dropped = Ofr::dropped(&sizes, &result);
        let ty = Ofr::subview_type(&s, &offs, &sizes, &strides, &dropped)?;
        let lists = [offs, sizes, strides];
        let o = rw.create(OpData::sliced("memref.subview", &[m], &lists), &[ty]);
        Some((rw.body[o].results[0], offsets[combined..].to_vec()))
    }

    /// `createNdDescriptor`: the memref itself when static, else its adjusted base address with
    /// the sizes and strides.
    fn nd_desc<'a>(rw: &mut Rw<'_, 'a>, desc: Type<'a>, src: ValueId) -> Option<ValueId> {
        let s = memref_of(&rw.body[src].ty)?.clone();
        let (strides, offset) = s.strides_and_offset()?;
        let static_shape = s.shape.as_ref()?.iter().all(|d| matches!(d, Dim::Static(_)));
        if static_shape && offset != Dim::DYNAMIC && !strides.contains(&Dim::DYNAMIC) {
            return Some(rw.mk(OpData::build("xegpu.create_nd_tdesc").operands(&[src]).segments(&[1, 0, 0]), desc));
        }
        let (base, off, sizes_v, strides_v) = rw.strided_metadata(src)?;
        let ptr = rw.mk(OpData::build("memref.extract_aligned_pointer_as_index").operands(&[base]), Type::Index);
        let size = rw.value_of(Ofr::C(i64::from(s.elem.bit_width()? / 8)));
        let bytes = rw.bin("arith.muli", off, size);
        let addr = rw.bin("arith.addi", ptr, bytes);
        let addr = rw.mk(OpData::build("arith.index_cast").operands(&[addr]), Type::int(64));
        // `getConstifiedMixedSizes` / `getConstifiedMixedStrides`: the result type's statics first.
        let constify = |rw: &Rw<'_, '_>, vals: &[ValueId], statics: &[i64]| -> Vec<Ofr> { vals.iter().zip(statics).map(|(v, s)| if *s != Dim::DYNAMIC { Ofr::C(*s) } else { rw.ofr_of(*v) }).collect() };
        let shape = s.dims()?;
        let sizes = constify(rw, &sizes_v, &shape);
        let strides = constify(rw, &strides_v, &strides);
        let data = OpData::mixed("xegpu.create_nd_tdesc", &[addr], &[&sizes, &strides], &["const_shape", "const_strides"]);
        Some(rw.mk(data, desc))
    }

    /// An nd op on `desc` at `offsets` (`const_offsets` and the dynamic ones).
    fn nd_op<'a>(name: &str, lead: &[ValueId], offsets: &[Ofr]) -> OpData<'a> {
        let (statics, dynamics) = Ofr::split(offsets);
        let mut ops = lead.to_vec();
        ops.extend(dynamics);
        OpData::build(name).operands(&ops).with("const_offsets", Attribute::dense_i64(&statics))
    }

    /// `lowerToScatteredLoadOp` / `lowerToScatteredStoreOp`.
    fn scattered(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let read = rw.body[op].name == "vector.transfer_read";
        let (base, _, value, _) = rw.body.xfer_parts(op);
        let vt = rw.body.xfer_vector_type(op);
        let Some(shape) = vector_shape(&vt) else { return false };
        rw.set_before(op);
        let Some((strides, offset)) = Self::memref_meta(rw, op, base) else { return false };
        let Some(offsets) = Self::transfer_offsets(rw, op, &strides, offset) else { return false };
        let flat = Self::index_ptr(rw, base);
        let mask = rw.mk(OpData::build("vector.constant_mask").with("mask_dim_sizes", Attribute::dense_i64(&shape)), shaped(ShapedKind::Vector, &shape, Type::int(1)));
        if read {
            let r = rw.mk(OpData::build("xegpu.load").operands(&[flat, offsets, mask]), vt);
            rw.replace_op(op, &[r]);
        } else {
            rw.create(OpData::build("xegpu.store").operands(&[value, flat, offsets, mask]), &[]);
            rw.erase_op(op);
        }
        true
    }

    /// The loaded or stored vector's nd descriptor at the op's indices (`LoadLowering` /
    /// `StoreLowering` / the transfers): source, its offsets and the descriptor.
    fn nd_source<'a>(rw: &mut Rw<'_, 'a>, base: ValueId, indices: &[ValueId], desc: Type<'a>, rank: usize) -> Option<(ValueId, Vec<Ofr>)> {
        let offs: Vec<Ofr> = indices.iter().map(|v| rw.ofr_of(*v)).collect();
        let (src, offs) = Self::to_rank(rw, base, offs, rank)?;
        let d = Self::nd_desc(rw, desc, src)?;
        Some((d, offs))
    }
}

#[crate::patterns]
impl VectorToXegpu {
    /// `TransferReadLowering`.
    #[rewrite("vector.transfer_read")]
    fn transfer_read_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        if !Self::transfer_ok(rw, op) {
            return false;
        }
        let oob = rw.body.xfer_out_of_bounds(op);
        let vt = rw.body.xfer_vector_type(op);
        let Some(shape) = vector_shape(&vt) else { return false };
        let (base, indices, padding, _) = rw.body.xfer_parts(op);
        let Some(map) = rw.body.affine_map(op, "permutation_map") else { return false };
        let mt = rw.body[base].ty.clone();
        // Shared local memory: `xegpu.load_matrix` of a mem_desc (1-D / 2-D, no transpose, in
        // bounds).
        if Self::shared_memory(&mt) {
            if !matches!(shape.len(), 1 | 2) || !Self::minor_identity(&map) || oob {
                return false;
            }
            rw.set_before(op);
            let Some(md) = Self::mem_desc(rw, base) else { return false };
            let offs: Vec<Ofr> = indices.iter().map(|v| rw.ofr_of(*v)).collect();
            let r = rw.mk(Self::nd_op("xegpu.load_matrix", &[md], &offs), vt);
            rw.replace_op(op, &[r]);
            return true;
        }
        if !Self::block_io(rw, op) || shape.len() > 2 {
            return !oob && Self::scattered(rw, op);
        }
        if shape.len() == 1 && !oob {
            return Self::scattered(rw, op);
        }
        if !Self::store_load_ok(&vt, &mt) {
            return false;
        }
        if oob && !Self::zero_constant(rw, padding) {
            return false;
        }
        // A transpose: two results, the last two inputs swapped.
        let n = map.dims;
        let transpose = map.results.len() == 2 && n >= 2 && map.results[0] == AffineExpr::Dim(n - 1) && map.results[1] == AffineExpr::Dim(n - 2);
        let Type::Shaped(s) = &vt else { return false };
        let elem = (*s.elem).clone();
        let mut dshape = shape.clone();
        let loaded = if transpose {
            let r = dshape.len();
            dshape.swap(r - 1, r - 2);
            shaped(ShapedKind::Vector, &dshape, elem.clone())
        } else {
            vt.clone()
        };
        let Some(desc) = tensor_desc(&dshape, &elem, oob) else { return false };
        rw.set_before(op);
        let Some((d, offs)) = Self::nd_source(rw, base, &indices, desc, shape.len()) else { return false };
        let mut r = rw.mk(Self::nd_op("xegpu.load_nd", &[d], &offs), loaded);
        if transpose {
            let perm: Vec<i64> = (0..map.results.len() as i64).rev().collect();
            r = rw.mk(OpData::build("vector.transpose").operands(&[r]).with("permutation", Attribute::dense_i64(&perm)), vt);
        }
        rw.replace_op(op, &[r]);
        true
    }

    /// `TransferWriteLowering`.
    #[rewrite("vector.transfer_write")]
    fn transfer_write_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        if !Self::transfer_ok(rw, op) {
            return false;
        }
        let oob = rw.body.xfer_out_of_bounds(op);
        let vt = rw.body.xfer_vector_type(op);
        let Some(shape) = vector_shape(&vt) else { return false };
        let (base, indices, value, _) = rw.body.xfer_parts(op);
        let mt = rw.body[base].ty.clone();
        // Shared local memory: `xegpu.store_matrix` into a mem_desc (1-D / 2-D).
        if Self::shared_memory(&mt) {
            if !matches!(shape.len(), 1 | 2) {
                return false;
            }
            rw.set_before(op);
            let Some(md) = Self::mem_desc(rw, base) else { return false };
            let offs: Vec<Ofr> = indices.iter().map(|v| rw.ofr_of(*v)).collect();
            rw.create(Self::nd_op("xegpu.store_matrix", &[value, md], &offs), &[]);
            rw.erase_op(op);
            return true;
        }
        if !Self::block_io(rw, op) || shape.len() > 2 {
            return !oob && Self::scattered(rw, op);
        }
        if !Self::store_load_ok(&vt, &mt) {
            return false;
        }
        let Some(map) = rw.body.affine_map(op, "permutation_map") else { return false };
        if !Self::minor_identity(&map) {
            return false;
        }
        let Type::Shaped(s) = &vt else { return false };
        let Some(desc) = tensor_desc(&shape, &s.elem, oob) else { return false };
        rw.set_before(op);
        let Some((d, offs)) = Self::nd_source(rw, base, &indices, desc, shape.len()) else { return false };
        rw.create(Self::nd_op("xegpu.store_nd", &[value, d], &offs), &[]);
        rw.erase_op(op);
        true
    }

    /// `LoadLowering`.
    #[rewrite("vector.load")]
    fn load_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let vt = rw.body[rw.body[op].results[0]].ty.clone();
        let Some(shape) = vector_shape(&vt) else { return false };
        let ops = rw.body[op].operands.clone();
        if !Self::store_load_ok(&vt, &rw.body[ops[0]].ty) {
            return false;
        }
        let Type::Shaped(s) = &vt else { return false };
        let Some(desc) = tensor_desc(&shape, &s.elem, shape.len() > 1) else { return false };
        rw.set_before(op);
        let Some((d, offs)) = Self::nd_source(rw, ops[0], &ops[1..], desc, shape.len()) else { return false };
        let r = rw.mk(Self::nd_op("xegpu.load_nd", &[d], &offs), vt);
        rw.replace_op(op, &[r]);
        true
    }

    /// `StoreLowering`.
    #[rewrite("vector.store")]
    fn store_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let ops = rw.body[op].operands.clone();
        let vt = rw.body[ops[0]].ty.clone();
        let Some(shape) = vector_shape(&vt) else { return false };
        if !Self::store_load_ok(&vt, &rw.body[ops[1]].ty) {
            return false;
        }
        let Type::Shaped(s) = &vt else { return false };
        let Some(desc) = tensor_desc(&shape, &s.elem, shape.len() > 1) else { return false };
        rw.set_before(op);
        let Some((d, offs)) = Self::nd_source(rw, ops[1], &ops[2..], desc, shape.len()) else { return false };
        rw.create(Self::nd_op("xegpu.store_nd", &[ops[0], d], &offs), &[]);
        rw.erase_op(op);
        true
    }

    /// `GatherLowering`: a gather of the flat address, the pass-through selected in.
    #[rewrite("vector.gather")]
    fn gather_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        // base, offsets.., indices, mask, pass_thru
        let ops = rw.body[op].operands.clone();
        let n = ops.len();
        if n < 4 || memref_of(&rw.body[ops[0]].ty).is_none() {
            return false;
        }
        let (base, offsets, indices, mask, pass) = (ops[0], &ops[1..n - 3], ops[n - 3], ops[n - 2], ops[n - 1]);
        let vt = rw.body[rw.body[op].results[0]].ty.clone();
        rw.set_before(op);
        let Some((strides, offset)) = Self::memref_meta(rw, op, base) else { return false };
        let local = Self::gather_offsets(rw, offsets, indices, &strides, offset);
        let flat = Self::index_ptr(rw, base);
        let g = rw.mk(OpData::build("xegpu.load").operands(&[flat, local, mask]), vt.clone());
        let r = rw.mk(OpData::build("arith.select").operands(&[mask, g, pass]), vt);
        rw.replace_op(op, &[r]);
        true
    }

    /// `ScatterLowering`.
    #[rewrite("vector.scatter")]
    fn scatter_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        // base, offsets.., indices, mask, value
        let ops = rw.body[op].operands.clone();
        let n = ops.len();
        if n < 4 || memref_of(&rw.body[ops[0]].ty).is_none() {
            return false;
        }
        let (base, offsets, indices, mask, value) = (ops[0], &ops[1..n - 3], ops[n - 3], ops[n - 2], ops[n - 1]);
        rw.set_before(op);
        let Some((strides, offset)) = Self::memref_meta(rw, op, base) else { return false };
        let local = Self::gather_offsets(rw, offsets, indices, &strides, offset);
        let flat = Self::index_ptr(rw, base);
        rw.create(OpData::build("xegpu.store").operands(&[value, flat, local, mask]), &[]);
        rw.erase_op(op);
        true
    }

    /// `ContractionLowering`: a row-major 2-D matmul adding into its accumulator.
    #[rewrite("vector.contract")]
    fn contraction_lowering(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let kind = b[op].get("kind").map(|a| format!("{a}"));
        if kind.as_deref().is_some_and(|k| k != "#vector.kind<add>") {
            return false;
        }
        let ops = b[op].operands.clone();
        if ops.len() != 3 || [ops[0], ops[1], ops[2]].iter().any(|v| vector_shape(&b[*v].ty).map(|s| s.len()) != Some(2)) {
            return false;
        }
        let Some(Attribute::Array(maps)) = b[op].get("indexing_maps") else { return false };
        let maps: Option<Vec<AffineMap>> = maps.iter().map(|m| AffineMap::try_from(m).ok()).collect();
        if !maps.is_some_and(|m| Self::row_major_matmul(&m)) {
            return false;
        }
        let rt = b[b[op].results[0]].ty.clone();
        rw.set_before(op);
        let r = rw.mk(OpData::build("xegpu.dpas").operands(&ops), rt);
        rw.replace_op(op, &[r]);
        true
    }
}

impl VectorToXegpu {
    /// `isZeroConstant`: an `arith.constant` integer or float zero.
    fn zero_constant(rw: &Rw<'_, '_>, v: ValueId) -> bool {
        let Some(d) = rw.body.def_named(v, "arith.constant") else { return false };
        let Some(c) = rw.body[d].get("value").and_then(|a| crate::Const::try_from(a).ok()) else { return false };
        !c.elements
            && match c.values.first() {
                Some(crate::Scalar::Int(i)) => i.is_zero(),
                Some(crate::Scalar::Float(f)) => f.is_zero(),
                _ => false,
            }
    }

    /// `isRowMajorMatmul`: `(m, k) x (k, n) -> (m, n)`.
    fn row_major_matmul(maps: &[AffineMap]) -> bool {
        let [a, b, c] = maps else { return false };
        if [a, b, c].iter().any(|m| m.results.len() != 2 || m.syms != 0) {
            return false;
        }
        let (m, n, k) = (&c.results[0], &c.results[1], &a.results[1]);
        let dims = [m, n, k].iter().filter_map(|e| if let AffineExpr::Dim(d) = e { Some(*d + 1) } else { None }).max().unwrap_or(0);
        [(a, [m, k]), (b, [k, n]), (c, [m, n])].iter().all(|(map, want)| map.dims == dims && map.results.iter().zip(want).all(|(x, y)| x == *y))
    }
}

/// `populatePrepareVectorToMMAPatterns` (without nvgpu): contractions into `(m, k) × (k, n) ⇒
/// (m, n)` form, transposes folded into the transfer reads they read.
pub struct PrepareVectorToMma;

#[crate::patterns]
impl PrepareVectorToMma {
    /// `PrepareContractToGPUMMA`: a gemm contraction's operands transposed / swapped so its maps
    /// are the row-major matmul's.
    #[rewrite("vector.contract")]
    fn prepare_contract_to_gpu_mma(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(Attribute::Array(iters)) = b[op].get("iterator_types") else { return false };
        let kinds: Vec<String> = iters.iter().map(|a| format!("{a}")).collect();
        if kinds.len() != 3 || !kinds[0].contains("parallel") || !kinds[1].contains("parallel") || !kinds[2].contains("reduction") {
            return false;
        }
        let Some(Attribute::Array(maps)) = b[op].get("indexing_maps") else { return false };
        let Some(maps) = maps.iter().map(|m| AffineMap::try_from(m).ok()).collect::<Option<Vec<AffineMap>>>() else { return false };
        // The maps' results as (m, n, k) = (d0, d1, d2) positions.
        let pairs: Option<Vec<[u32; 2]>> = maps
            .iter()
            .map(|m| match (m.dims, m.syms, m.results.as_slice()) {
                (3, 0, [AffineExpr::Dim(x), AffineExpr::Dim(y)]) => Some([*x, *y]),
                _ => None,
            })
            .collect();
        let Some(pairs) = pairs else { return false };
        let (m, n, k) = (0, 1, 2);
        let is = |want: [[u32; 2]; 3]| pairs.as_slice() == want.as_slice();
        // (transpose lhs, transpose rhs, swap first)
        let (swap, t_lhs, t_rhs) = if is([[m, k], [k, n], [m, n]]) {
            return false;
        } else if is([[m, k], [n, k], [m, n]]) {
            (false, false, true)
        } else if is([[k, m], [k, n], [m, n]]) {
            (false, true, false)
        } else if is([[k, m], [n, k], [m, n]]) {
            (false, true, true)
        } else if is([[m, k], [k, n], [n, m]]) {
            (true, true, true)
        } else if is([[m, k], [n, k], [n, m]]) {
            (true, false, true)
        } else if is([[k, m], [k, n], [n, m]]) {
            (true, true, false)
        } else if is([[k, m], [n, k], [n, m]]) {
            (true, false, false)
        } else {
            return false;
        };
        let ops = b[op].operands.clone();
        let (mut lhs, mut rhs, acc) = (ops[0], ops[1], ops[2]);
        let props: Vec<_> = b[op].all_attrs().into_iter().filter(|a| a.name != "indexing_maps").collect();
        rw.set_before(op);
        if swap {
            core::mem::swap(&mut lhs, &mut rhs);
        }
        let transpose = |rw: &mut Rw<'_, '_>, v: ValueId| {
            let Some(d) = vector_shape(&rw.body[v].ty) else { return v };
            let Type::Shaped(s) = rw.body[v].ty.clone() else { return v };
            let t = shaped(ShapedKind::Vector, &[d[1], d[0]], (*s.elem).clone());
            rw.mk(OpData::build("vector.transpose").operands(&[v]).with("permutation", Attribute::dense_i64(&[1, 0])), t)
        };
        // As upstream creates them: the rhs transpose first.
        if t_rhs {
            rhs = transpose(rw, rhs);
        }
        if t_lhs {
            lhs = transpose(rw, lhs);
        }
        let row = |rs: [u32; 2]| Attribute::from(&AffineMap { dims: 3, syms: 0, results: rs.iter().map(|d| AffineExpr::Dim(*d)).collect() });
        let mut data = OpData::build("vector.contract").operands(&[lhs, rhs, acc]).with("indexing_maps", Attribute::Array(vec![row([m, k]), row([k, n]), row([m, n])]));
        for a in props {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, data, &[ty]);
        true
    }

    /// `CombineTransferReadOpTranspose`: `transpose(transfer_read)` (through an `ext`) as one
    /// transfer read with the permutation composed.
    #[rewrite("vector.transpose")]
    fn combine_transfer_read_op_transpose(rw: &mut Rw<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let mut source = b[op].operands[0];
        let res_ty = b[b[op].results[0]].ty.clone();
        let ext = ["arith.extsi", "arith.extui", "arith.extf"].iter().find_map(|n| b.def_named(source, n));
        let mut read_ty = res_ty.clone();
        if let Some(e) = ext {
            source = b[e].operands[0];
            let Type::Shaped(s) = &b[source].ty else { return false };
            read_ty = res_ty.with_element((*s.elem).clone());
        }
        let Some(read) = b.def_named(source, "vector.transfer_read") else { return false };
        let Some(map) = b.affine_map(read, "permutation_map") else { return false };
        if map.results.is_empty() {
            return false;
        }
        let (_, _, _, mask) = b.xfer_parts(read);
        if mask.is_some() || b.xfer_out_of_bounds(read) {
            return false;
        }
        let perm = b.dense_i64(op, "permutation");
        let pmap = AffineMap { dims: perm.len() as u32, syms: 0, results: perm.iter().map(|p| AffineExpr::Dim(*p as u32)).collect() };
        let new_map = pmap.compose(&map);
        let mut data = OpData::named(b[read].name.clone()).operands(&b[read].operands.clone());
        data.properties.clone_from(&b[read].properties);
        data.set("permutation_map", Attribute::from(&new_map));
        let ext_name = ext.map(|e| b[e].name.clone());
        rw.set_before(op);
        let mut r = rw.mk(data, read_ty);
        if let Some(n) = ext_name {
            r = rw.mk(OpData::named(n).operands(&[r]), res_ty);
        }
        rw.replace_op(op, &[r]);
        true
    }
}

impl PrepareVectorToMma {
    /// `promoteAllocasToSLM`: every `memref.alloca` outside shared local memory moved into it
    /// (memory space 3), the new type carried through the side-effect-free ops that make memrefs
    /// of it.
    pub fn promote_allocas(body: &mut crate::Body<'_>, root: OpId) {
        let mut allocas = Vec::new();
        body.walk(root, &mut |o| allocas.push(o));
        let allocas: Vec<OpId> = allocas.into_iter().filter(|o| body[*o].name == "memref.alloca" && memref_of(&body[body[*o].results[0]].ty).is_some() && !VectorToXegpu::shared_memory(&body[body[*o].results[0]].ty)).collect();
        for a in allocas {
            let r = body[a].results[0];
            Self::to_slm(body, r);
        }
    }

    /// `v`'s type in memory space 3, and so on through the memref-making users.
    fn to_slm(body: &mut crate::Body<'_>, v: ValueId) {
        let ty = body[v].ty.clone();
        let Type::Shaped(mut s) = ty else { return };
        if s.kind != ShapedKind::MemRef || VectorToXegpu::shared_memory(&body[v].ty) {
            return;
        }
        // `IntegerAttr 3 : i64`, which a memref type prints (and reads) bare.
        let space = Attribute::Int { lit: "3".into(), ty: None };
        match s.memory_space().is_some() {
            true => {
                if let Some(last) = s.extras.last_mut() {
                    *last = space;
                }
            }
            false => s.extras.push(space),
        }
        body[v].ty = Type::Shaped(s);
        let mut users: Vec<OpId> = body[v].uses.iter().map(|u| u.op).collect();
        users.dedup();
        for u in users {
            if !body.is_memory_effect_free(u) {
                continue;
            }
            let results = body[u].results.clone();
            if results.iter().any(|r| matches!(&body[*r].ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef)) {
                for r in results {
                    Self::to_slm(body, r);
                }
            }
        }
    }
}
