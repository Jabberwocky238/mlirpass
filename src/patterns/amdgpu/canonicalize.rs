//! `amdgpu` canonicalization, as `AMDGPUOps.cpp`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Const, Dim, Type};

use crate::{ApFloat, ApInt, Body, MemrefLayout, OpData, OpId, Scalar, ValueId};

/// The raw buffer ops, and which of their operand groups is the memref.
const RAW_BUFFER_OPS: [(&str, usize); 7] = [
    ("amdgpu.raw_buffer_load", 0),
    ("amdgpu.raw_buffer_store", 1),
    ("amdgpu.raw_buffer_atomic_fadd", 1),
    ("amdgpu.raw_buffer_atomic_fmax", 1),
    ("amdgpu.raw_buffer_atomic_smax", 1),
    ("amdgpu.raw_buffer_atomic_umin", 1),
    ("amdgpu.raw_buffer_atomic_cmpswap", 2),
];

/// The counters of `amdgpu.memory_counter_wait`.
const WAIT_COUNTERS: [&str; 5] = ["load", "store", "ds", "exp", "tensor"];

/// How many scales one `amdgpu.scaled_mfma` operand packs.
const PACKED_SCALES: i64 = 4;

impl Body<'_> {
    /// The operands of group `g` of `op` by its `operandSegmentSizes`.
    fn amdgpu_group(&self, op: OpId, g: usize) -> &[ValueId] {
        let sizes = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let start: usize = sizes.iter().take(g).sum();
        let n = sizes.get(g).copied().unwrap_or(0);
        self[op].operands.get(start..start + n).unwrap_or(&[])
    }

    /// `getConstantUint32`: an i32 constant, zero-extended.
    fn const_u32(&self, v: ValueId) -> Option<i64> {
        if self[v].ty != Type::int(32) {
            return None;
        }
        let c = Const::try_from(&self.constant_of(v)?).ok()?;
        Some(c.as_int()?.unsigned() as i64)
    }

    /// `staticallyOutOfBounds`: a bounds-checked access to a static buffer at constant indices
    /// past its end.
    fn raw_buffer_out_of_bounds(&self, op: OpId, memref_group: usize) -> bool {
        if matches!(self[op].get("boundsCheck"), Some(Attribute::Bool(false))) {
            return false;
        }
        let Some(&mem) = self.amdgpu_group(op, memref_group).first() else { return false };
        let Type::Shaped(s) = &self[mem].ty else { return false };
        let Some(shape) = s.shape.as_ref().filter(|d| d.iter().all(|d| matches!(d, Dim::Static(_)))) else { return false };
        let Some((strides, offset)) = s.strides_and_offset() else { return false };
        let index_offset = match self[op].get("indexOffset") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
            _ => 0,
        };
        let mut result = offset + index_offset;
        if let Some(&sgpr) = self.amdgpu_group(op, memref_group + 2).first() {
            let Some(v) = self.const_u32(sgpr) else { return false };
            result += v;
        }
        let indices = self.amdgpu_group(op, memref_group + 1);
        if strides.len() != indices.len() {
            return false;
        }
        for (stride, idx) in strides.iter().zip(indices) {
            let Some(v) = self.const_u32(*idx) else { return false };
            result += stride * v;
        }
        if result > i64::from(u32::MAX) {
            return false;
        }
        let elements: i64 = shape.iter().map(|d| if let Dim::Static(n) = d { *n } else { 0 }).product();
        result >= elements
    }

    /// An integer attribute's value.
    fn amdgpu_int(&self, op: OpId, name: &str) -> Option<i64> {
        match self[op].get(name)? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }
}

/// `amdgpu` canonicalization patterns.
pub struct AmdgpuCanon;

#[crate::patterns]
impl AmdgpuCanon {
    /// `RemoveStaticallyOobBufferLoads` / `RemoveStaticallyOobBufferWrites`: an access past
    /// the end loads zero, or stores nothing.
    #[rewrite("_")]
    fn remove_statically_oob_buffer_ops(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(&(_, g)) = RAW_BUFFER_OPS.iter().find(|(n, _)| *n == b[op].name) else { return false };
        if !b.raw_buffer_out_of_bounds(op, g) {
            return false;
        }
        match b[op].results.first() {
            Some(r) if b[op].name != "amdgpu.raw_buffer_store" => {
                let ty = b[*r].ty.clone();
                let Some(zero) = Self::zero(&ty) else { return false };
                rw.replace_with(op, OpData::build("arith.constant").with("value", zero), &[ty]);
            }
            _ => rw.erase_op(op),
        }
        true
    }

    /// `eraseRedundantLDSBarrierOps`: a barrier right before another.
    #[rewrite("amdgpu.lds_barrier")]
    fn erase_redundant_lds_barrier(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        if !rw.body.next_op(op).is_some_and(|n| rw.body[n].name == "amdgpu.lds_barrier") {
            return false;
        }
        rw.erase_op(op);
        true
    }

    /// `FuseMemoryCounterWaitOp`: two adjacent waits as one, each counter the smaller.
    #[rewrite("amdgpu.memory_counter_wait")]
    fn fuse_memory_counter_wait(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(next) = b.next_op(op).filter(|n| b[*n].name == "amdgpu.memory_counter_wait") else { return false };
        let merged: Vec<(&str, Option<i64>)> = WAIT_COUNTERS
            .iter()
            .map(|c| {
                let v = match (b.amdgpu_int(op, c), b.amdgpu_int(next, c)) {
                    (Some(l), Some(r)) => Some(l.min(r)),
                    (l, r) => l.or(r),
                };
                (*c, v)
            })
            .collect();
        rw.modify(op, |b| {
            for (c, v) in merged {
                if let Some(v) = v {
                    b[op].set(c, Attribute::of_int(v.into(), Type::int(32)));
                }
            }
        });
        rw.erase_op(next);
        true
    }

    /// `FoldGatherToLDSOfCast`: a `memref.cast` that only drops static information, skipped.
    #[rewrite("amdgpu.gather_to_lds")]
    fn fold_gather_to_lds_of_cast(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let sizes = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        let (src_at, dst_at) = (0, sizes.iter().take(2).sum::<usize>());
        let mut ops = b[op].operands.to_vec();
        let mut changed = false;
        for at in [src_at, dst_at] {
            if let Some(cast) = b.def_named(ops[at], "memref.cast") {
                let src = b[cast].operands[0];
                if crate::patterns::memref_cast_foldable(&b[src].ty, &b[ops[at]].ty) {
                    ops[at] = src;
                    changed = true;
                }
            }
        }
        if !changed {
            return false;
        }
        rw.modify(op, |b| b.set_operands(op, ops));
        true
    }

    /// `foldGlobalLoadAsyncToLDSConstantMask`: a constant mask either drops the load or goes.
    #[rewrite("amdgpu.global_load_async_to_lds")]
    fn fold_global_load_async_to_lds_constant_mask(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let b = &*rw.body;
        let Some(&mask) = b.amdgpu_group(op, 4).first() else { return false };
        let Some(m) = b.constant_of(mask).and_then(|a| Const::try_from(&a).ok()).and_then(|k| k.as_int()) else { return false };
        if m.is_zero() {
            rw.erase_op(op);
            return true;
        }
        let mut ops = b[op].operands.to_vec();
        ops.retain(|v| *v != mask);
        let mut sizes = b.segments(op, "operandSegmentSizes").unwrap_or_default();
        if let Some(last) = sizes.last_mut() {
            *last = 0;
        }
        rw.modify(op, |b| {
            b.set_operands(op, ops);
            b.set_segments(op, "operandSegmentSizes", &sizes);
        });
        true
    }

    /// `PackScales`: each scale inserted from one element of a static vector of 4 or more
    /// becomes the 4-element slice holding it, the index selecting it.
    #[rewrite("amdgpu.scaled_mfma")]
    fn pack_scales(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let mut picks = Vec::new();
        for at in [3usize, 4] {
            let b = &*rw.body;
            let Some(insert) = b.def_named(b[op].operands[at], "vector.insert") else { return false };
            let stored = b[insert].operands[0];
            if matches!(&b[stored].ty, Type::Shaped(_)) {
                return false;
            }
            let Some(extract) = b.def_named(stored, "vector.extract") else { return false };
            let src = b[extract].operands[0];
            let Type::Shaped(s) = &b[src].ty else { return false };
            let Some(shape) = s.shape.as_ref().and_then(|d| d.iter().map(|d| if let Dim::Static(n) = d { Some(*n) } else { None }).collect::<Option<Vec<i64>>>()) else { return false };
            let n: i64 = shape.iter().product();
            if n < PACKED_SCALES {
                return false;
            }
            let pos: Vec<i64> = match b[extract].get("static_position") {
                Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
                _ => return false,
            };
            let idx = pos.iter().zip(&shape).fold(0i64, |acc, (p, d)| acc * d + p);
            let (mut offset, mut opsel) = (idx - idx % PACKED_SCALES, idx % PACKED_SCALES);
            if n - offset < PACKED_SCALES {
                opsel = PACKED_SCALES - (n - idx);
                offset = n - PACKED_SCALES;
            }
            picks.push((at, src, s.elem.as_ref().clone(), n, offset, opsel));
        }
        rw.set_before(op);
        let mut news = Vec::new();
        for (at, src, elem, n, offset, opsel) in picks {
            let flat = Type::vector(&[n], &[false], elem.clone());
            let cast = rw.create(OpData::build("vector.shape_cast").operands(&[src]), &[flat]);
            let flat_v = rw.body[cast].results[0];
            let slice_ty = Type::vector(&[PACKED_SCALES], &[false], elem);
            let data = OpData::build("vector.extract_strided_slice")
                .operands(&[flat_v])
                .with("offsets", Self::i64_array(offset))
                .with("sizes", Self::i64_array(PACKED_SCALES))
                .with("strides", Self::i64_array(1));
            let slice = rw.create(data, &[slice_ty]);
            news.push((at, rw.body[slice].results[0], opsel));
        }
        rw.modify(op, |b| {
            for (at, v, opsel) in news {
                b.set_operand(op, at, v);
                b[op].set(if at == 3 { "scalesIdxA" } else { "scalesIdxB" }, Attribute::of_int(opsel.into(), Type::int(32)));
            }
        });
        true
    }
}

impl AmdgpuCanon {
    /// A one-element `I64ArrayAttr`.
    fn i64_array(v: i64) -> Attribute<'static> {
        Attribute::Array(vec![Attribute::Int { lit: alloc::format!("{v}").into(), ty: None }])
    }

    /// `getZeroAttr` of a scalar or vector integer / float type.
    fn zero<'a>(ty: &Type<'a>) -> Option<Attribute<'a>> {
        let elem = ty.element_type();
        let s = match elem {
            Type::Float(k) => Scalar::Float(ApFloat::from_f64(*k, 0.0)?),
            t => Scalar::Int(ApInt::zero(t.int_width()?.0)),
        };
        Some(if matches!(ty, Type::Shaped(_)) { Const::splat(s, ty.clone()).into() } else { Const::scalar(s, ty.clone()).into() })
    }

    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(RemoveStaticallyOobBufferOps);
        set.add(EraseRedundantLdsBarrier);
        set.add(FuseMemoryCounterWait);
        set.add(FoldGatherToLdsOfCast);
        set.add(FoldGlobalLoadAsyncToLdsConstantMask);
        set.add(PackScales);
    }
}
