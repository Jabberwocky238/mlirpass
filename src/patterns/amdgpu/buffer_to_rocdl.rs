//! `amdgpu` buffer ops ⇒ `rocdl`, as `AMDGPUToROCDL.cpp`'s `FatRawBufferCastLowering` and
//! `RawBufferOpLowering`: a buffer resource from the memref descriptor (`makeBufferRsrc`), then
//! the `rocdl.raw.ptr.buffer.*` intrinsic at a byte offset.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Type};

use super::AmdgpuOperands;
use crate::patterns;
use crate::{AmdChipset, AmdgpuRocdlOptions, ConversionRewriter, MemrefLayout, MemrefToLlvm, OpData, OpId, ValueId};
use mlirformat::llvm_types::LlvmType;

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx942`.
const GFX942: AmdChipset = AmdChipset::new(9, 4, 2);
/// `kGfx1250`.
const GFX1250: AmdChipset = AmdChipset::new(12, 5, 0);

/// `RawBufferOpLowering::maxVectorOpWidth`.
const MAX_VECTOR_BITS: u32 = 128;

/// The raw buffer ops, with their intrinsics.
const RAW_BUFFER_OPS: [(&str, &str); 7] = [
    ("amdgpu.raw_buffer_load", "rocdl.raw.ptr.buffer.load"),
    ("amdgpu.raw_buffer_store", "rocdl.raw.ptr.buffer.store"),
    ("amdgpu.raw_buffer_atomic_fadd", "rocdl.raw.ptr.buffer.atomic.fadd"),
    ("amdgpu.raw_buffer_atomic_fmax", "rocdl.raw.ptr.buffer.atomic.fmax"),
    ("amdgpu.raw_buffer_atomic_smax", "rocdl.raw.ptr.buffer.atomic.smax"),
    ("amdgpu.raw_buffer_atomic_umin", "rocdl.raw.ptr.buffer.atomic.umin"),
    ("amdgpu.raw_buffer_atomic_cmpswap", "rocdl.raw.ptr.buffer.atomic.cmpswap"),
];

/// The amdgpu buffer ops.
pub struct AmdgpuBufferToRocdl;

#[patterns(converter, options = AmdgpuRocdlOptions)]
impl AmdgpuBufferToRocdl {
    fn constant<'a>(cr: &mut Cr<'_, 'a, '_>, v: i64, w: u32) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(w)), Type::int(w))
    }

    /// A two-operand op with `overflowFlags` none.
    fn arith<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]).with("overflowFlags", Attribute::of_int(0, Type::int(32))), ty)
    }

    /// `convertUnsignedTo{I32,I64}`.
    fn unsigned_to<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, w: u32) -> ValueId {
        match cr.rw.body[v].ty.int_width() {
            Some((have, _)) if have == w => v,
            Some((have, _)) if have > w => cr.build(OpData::build("llvm.trunc").operands(&[v]).with("overflowFlags", Attribute::of_int(0, Type::int(32))), Type::int(w)),
            _ => cr.build(OpData::build("llvm.zext").operands(&[v]), Type::int(w)),
        }
    }

    fn memref<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<Shaped<'a>> {
        match &cr.rw.body[v].ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s.clone()),
            _ => None,
        }
    }

    /// The bytes of an element (`DataLayout::getTypeSizeInBits` / 8).
    fn byte_width(t: &Type<'_>) -> Option<i64> {
        match t {
            Type::Index => Some(8),
            t => t.bit_width().map(|w| i64::from(w.div_ceil(8))),
        }
    }

    /// `getNumRecords`.
    fn num_records(cr: &mut Cr<'_, '_, '_>, s: &Shaped<'_>, desc: ValueId, strides: &[i64], bytes: i64, chipset: AmdChipset, bounds: bool) -> ValueId {
        if chipset >= GFX1250 && !bounds {
            return Self::constant(cr, (1 << 45) - 1, 64);
        }
        let shape = s.dims().unwrap_or_default();
        if shape.iter().chain(strides).all(|d| *d != Dim::DYNAMIC) {
            let size = shape.iter().zip(strides).map(|(n, st)| n * st).fold(i64::from(shape.is_empty()), i64::max);
            return Self::constant(cr, size * bytes, 64);
        }
        let mut max: Option<ValueId> = None;
        for i in 0..shape.len() as i64 {
            let size = cr.extract(desc, &[3, i]);
            let stride = cr.extract(desc, &[4, i]);
            let dim = Self::arith(cr, "llvm.mul", size, stride);
            max = Some(match max {
                Some(m) => cr.build(OpData::build("llvm.intr.umax").operands(&[m, dim]), Type::int(64)),
                None => dim,
            });
        }
        let max = match max {
            Some(m) => Self::unsigned_to(cr, m, 64),
            None => Self::constant(cr, 0, 64),
        };
        let bytes = Self::constant(cr, bytes, 64);
        Self::arith(cr, "llvm.mul", max, bytes)
    }

    /// `makeBufferRsrc`.
    fn rsrc(cr: &mut Cr<'_, '_, '_>, base: ValueId, records: ValueId, bounds: bool, chipset: AmdChipset, swizzle: Option<ValueId>, space: u32) -> ValueId {
        let stride = match swizzle {
            Some(sw) if chipset.major == 9 && chipset >= GFX942 => {
                let z = cr.build(OpData::build("llvm.zext").operands(&[sw]), Type::int(16));
                let bit = Self::constant(cr, 1 << 14, 16);
                cr.build(OpData::build("llvm.or").operands(&[z, bit]).with("isDisjoint", Attribute::Unit), Type::int(16))
            }
            _ => Self::constant(cr, 0, 16),
        };
        let mut flags: i64 = 0;
        if chipset < GFX1250 {
            flags |= (7 << 12) | (4 << 15);
            if chipset.major >= 10 {
                flags |= (1 << 24) | ((if bounds { 3 } else { 2 }) << 28);
            }
        }
        let flags = Self::constant(cr, flags, 32);
        cr.build(OpData::build("rocdl.make.buffer.rsrc").operands(&[base, stride, records, flags]), LlvmType::Ptr(space).into())
    }

    fn bounds_check(cr: &Cr<'_, '_, '_>, op: OpId) -> bool {
        !matches!(cr.rw.body[op].get("boundsCheck"), Some(Attribute::Bool(false)))
    }

    /// `FatRawBufferCastLowering`: the descriptor with both pointers a fat buffer pointer.
    #[convert("amdgpu.fat_raw_buffer_cast")]
    fn fat_raw_buffer_cast(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let body = &cr.rw.body;
        let (src, res) = (body[op].operands[0], body[body[op].results[0]].ty.clone());
        let Some(s) = Self::memref(cr, src) else { return false };
        let (Some(bytes), Some((strides, _))) = (Self::byte_width(&s.elem), s.strides_and_offset()) else { return false };
        let Some(res_ty) = cr.converted(&res) else { return false };
        let reset = cr.rw.body[op].get("resetOffset").is_some();
        let bounds = Self::bounds_check(cr, op);
        let seg = AmdgpuOperands::new(cr, op, operands);
        let (Some(desc), valid, swizzle) = (seg.one(0), seg.one(1), seg.one(2)) else { return false };
        cr.rw.set_before(op);
        let records = match valid {
            Some(v) => v,
            None => Self::num_records(cr, &s, desc, &strides, bytes, o.chipset, bounds),
        };
        let (base, offset) = if reset {
            let Some(base) = MemrefToLlvm::buffer_ptr(cr, o.llvm, &s, desc) else { return false };
            (base, MemrefToLlvm::const_index(cr, o.llvm, 0))
        } else {
            (cr.extract(desc, &[1]), cr.extract(desc, &[2]))
        };
        let ranked = !strides.is_empty();
        let arrays = ranked.then(|| (cr.extract(desc, &[3]), cr.extract(desc, &[4])));
        let fat = Self::rsrc(cr, base, records, bounds, o.chipset, swizzle, 7);
        let mut r = cr.poison(res_ty);
        r = cr.insert_value(r, fat, &[0]);
        r = cr.insert_value(r, fat, &[1]);
        r = cr.insert_value(r, offset, &[2]);
        if let Some((sizes, strides)) = arrays {
            r = cr.insert_value(r, sizes, &[3]);
            r = cr.insert_value(r, strides, &[4]);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `getLinearIndexI32`.
    fn linear_index(cr: &mut Cr<'_, '_, '_>, desc: ValueId, indices: &[ValueId], strides: &[i64]) -> ValueId {
        let mut index: Option<ValueId> = None;
        for (i, (&idx, &st)) in indices.iter().zip(strides).enumerate() {
            let mut inc = idx;
            if st != 1 {
                let stride = if st == Dim::DYNAMIC {
                    let s = cr.extract(desc, &[4, i as i64]);
                    Self::unsigned_to(cr, s, 32)
                } else {
                    Self::constant(cr, st, 32)
                };
                inc = Self::arith(cr, "llvm.mul", inc, stride);
            }
            index = Some(match index {
                Some(acc) => Self::arith(cr, "llvm.add", acc, inc),
                None => inc,
            });
        }
        index.unwrap_or_else(|| Self::constant(cr, 0, 32))
    }

    /// The type the intrinsic moves for data of `wanted` (`llvm` converted): scalars up to 32
    /// bits, dwords beyond, integers for a compare-and-swap; `None` past 128 bits.
    fn buffer_type<'a>(cr: &Cr<'_, 'a, '_>, wanted: &Type<'a>, llvm: &Type<'a>, cmpswap: bool, packed_fadd: bool) -> Option<Type<'a>> {
        let mut t = llvm.clone();
        if cmpswap && let Type::Float(_) = wanted {
            t = Type::int(wanted.bit_width()?);
        }
        if let Type::Shaped(v) = wanted && v.kind == ShapedKind::Vector {
            let n = wanted.element_count()? as u32;
            let bits = v.elem.bit_width()?;
            let total = bits * n;
            if total > MAX_VECTOR_BITS {
                return None;
            }
            let packed = packed_fadd && n == 2;
            if !packed && bits < 32 {
                t = if total > 32 {
                    if total % 32 != 0 {
                        return None;
                    }
                    cr.converted(&Type::vector(&[i64::from(total / 32)], &[false], Type::int(32)))?
                } else {
                    Type::int(total)
                };
            }
        }
        if let Type::Shaped(v) = &t && v.kind == ShapedKind::Vector && t.element_count() == Some(1) {
            t = (*v.elem).clone();
        }
        Some(t)
    }

    /// `RawBufferOpLowering`.
    #[convert("amdgpu.raw_buffer_load", "amdgpu.raw_buffer_store", "amdgpu.raw_buffer_atomic_fadd", "amdgpu.raw_buffer_atomic_fmax", "amdgpu.raw_buffer_atomic_smax", "amdgpu.raw_buffer_atomic_umin", "amdgpu.raw_buffer_atomic_cmpswap")]
    fn raw_buffer(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if o.chipset.major < 9 {
            return false;
        }
        let name = cr.rw.body[op].name.clone();
        let Some(&(_, intrinsic)) = RAW_BUFFER_OPS.iter().find(|(n, _)| *n == &*name) else { return false };
        let seg = AmdgpuOperands::new(cr, op, operands);
        // Data operands ahead of the memref, indices and sgpr offset groups.
        let data = seg.groups.len().saturating_sub(3);
        let (store, cmp) = (seg.one(0).filter(|_| data >= 1), seg.one(1).filter(|_| data >= 2));
        let (Some(desc), indices, sgpr) = (seg.one(data), seg.group(data + 1).collect::<Vec<_>>(), seg.one(data + 2)) else { return false };
        let body = &cr.rw.body;
        let mem = body[op].operands[data];
        let wanted = match data {
            0 => body[body[op].results[0]].ty.clone(),
            _ => body[body[op].operands[0]].ty.clone(),
        };
        let Some(s) = Self::memref(cr, mem) else { return false };
        let (Some(bytes), Some((strides, _))) = (Self::byte_width(&s.elem), s.strides_and_offset()) else { return false };
        let Some(llvm) = cr.converted(&wanted) else { return false };
        let Some(buf) = Self::buffer_type(cr, &wanted, &llvm, cmp.is_some(), &*name == "amdgpu.raw_buffer_atomic_fadd") else { return false };
        let bounds = Self::bounds_check(cr, op);
        let index_offset = AmdgpuOperands::int(cr, op, "indexOffset");
        cr.rw.set_before(op);
        let width = Self::constant(cr, bytes, 32);
        let mut args = Vec::new();
        for v in [store, cmp].into_iter().flatten() {
            args.push(if buf != llvm { cr.build(OpData::build("llvm.bitcast").operands(&[v]), buf.clone()) } else { v });
        }
        let Some(ptr) = MemrefToLlvm::buffer_ptr(cr, o.llvm, &s, desc) else { return false };
        let records = Self::num_records(cr, &s, desc, &strides, bytes, o.chipset, bounds);
        let rsrc = Self::rsrc(cr, ptr, records, bounds, o.chipset, None, 8);
        args.push(rsrc);
        let mut voffset = Self::linear_index(cr, desc, &indices, &strides);
        if let Some(extra) = index_offset.filter(|i| *i > 0) {
            let c = Self::constant(cr, extra, 32);
            voffset = Self::arith(cr, "llvm.add", voffset, c);
        }
        args.push(Self::arith(cr, "llvm.mul", voffset, width));
        let sgpr = sgpr.unwrap_or_else(|| Self::constant(cr, 0, 32));
        args.push(Self::arith(cr, "llvm.mul", sgpr, width));
        let results = if cr.rw.body[op].results.is_empty() { vec![] } else { vec![buf.clone()] };
        // (aux 0: GLC / SLC / DLC off, not swizzled)
        let lowered = cr.rw.create(OpData::build(intrinsic).operands(&args).with("aux", Attribute::of_int(0, Type::int(32))), &results);
        match cr.rw.body[lowered].results.first().copied() {
            Some(mut r) => {
                if buf != llvm {
                    r = cr.build(OpData::build("llvm.bitcast").operands(&[r]), llvm);
                }
                cr.replace(op, vec![vec![r]]);
            }
            None => cr.erase(op),
        }
        true
    }
}
