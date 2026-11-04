//! `amdgpu` memory ops ⇒ `rocdl`, as `AMDGPUToROCDL.cpp`'s `TransposeLoadOpLowering` and
//! `GatherToLDSOpLowering`: an element pointer into the memref, one intrinsic.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Shaped, ShapedKind, Type};

use super::AmdgpuOperands;
use crate::patterns;
use crate::{AmdChipset, AmdgpuRocdlOptions, ConversionRewriter, MemrefToLlvm, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);

/// The `ds_read_tr*` intrinsic of each element width, and whether it returns dwords.
const TRANSPOSE_LOADS: [(u32, &str, bool); 4] = [(4, "rocdl.ds.read.tr4.b64", true), (6, "rocdl.ds.read.tr6.b96", true), (8, "rocdl.ds.read.tr8.b64", true), (16, "rocdl.ds.read.tr16.b64", false)];

/// The amdgpu memory ops.
pub struct AmdgpuMemToRocdl;

#[patterns(converter, options = AmdgpuRocdlOptions)]
impl AmdgpuMemToRocdl {
    fn memref<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<Shaped<'a>> {
        match &cr.rw.body[v].ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s.clone()),
            _ => None,
        }
    }

    /// `getStridedElementPtr` of original operand `k` (a memref) at operand group `g`.
    fn element_ptr(cr: &mut Cr<'_, '_, '_>, op: OpId, seg: &AmdgpuOperands<'_>, k: usize, g: usize, o: AmdgpuRocdlOptions) -> Option<ValueId> {
        let mem = cr.rw.body[op].operands.get(k).copied()?;
        let s = Self::memref(cr, mem)?;
        let desc = seg.one(g)?;
        let indices: Vec<ValueId> = seg.group(g + 1).collect();
        MemrefToLlvm::strided_ptr(cr, o.llvm, &s, desc, &indices, 0)
    }

    /// `TransposeLoadOpLowering` (gfx950).
    #[convert("amdgpu.transpose_load")]
    fn transpose_load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if o.chipset != GFX950 {
            return false;
        }
        let body = &cr.rw.body;
        let (src, res_ty) = (body[op].operands[0], body[body[op].results[0]].ty.clone());
        let Some(s) = Self::memref(cr, src) else { return false };
        if s.elem.bit_width().is_none_or(|w| w < 8) {
            return false;
        }
        let (Some(n), Some(w)) = (res_ty.element_count(), res_ty.element_type().bit_width()) else { return false };
        let Some(&(_, name, dwords)) = TRANSPOSE_LOADS.iter().find(|(bits, ..)| *bits == w) else { return false };
        let Some(llvm_ty) = cr.converted(&res_ty) else { return false };
        let seg = AmdgpuOperands::new(cr, op, operands);
        cr.rw.set_before(op);
        let Some(ptr) = Self::element_ptr(cr, op, &seg, 0, 0, o) else { return false };
        let r = if dwords {
            let dw = Type::vector(&[(n as i64 * i64::from(w)) / 32], &[false], Type::int(32));
            let r = cr.build(OpData::build(name).operands(&[ptr]), dw);
            cr.build(OpData::build("llvm.bitcast").operands(&[r]), llvm_ty)
        } else {
            cr.build(OpData::build(name).operands(&[ptr]), llvm_ty)
        };
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `GatherToLDSOpLowering` (gfx9 / gfx10; 12- and 16-byte loads on gfx950).
    #[convert("amdgpu.gather_to_lds")]
    fn gather_to_lds(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if !(9..=10).contains(&o.chipset.major) {
            return false;
        }
        let Some(Attribute::Type(t)) = cr.rw.body[op].get("transferType") else { return false };
        let Some(width) = t.element_count().zip(t.element_type().bit_width()).map(|(n, w)| n as u32 * w / 8) else { return false };
        if ![1, 2, 4, 12, 16].contains(&width) || (o.chipset != GFX950 && width >= 12) {
            return false;
        }
        let seg = AmdgpuOperands::new(cr, op, operands);
        let dst = seg.groups.first().map_or(0, |g| g.len()) + seg.groups.get(1).map_or(0, |g| g.len());
        cr.rw.set_before(op);
        let (Some(src), Some(dst)) = (Self::element_ptr(cr, op, &seg, 0, 0, o), Self::element_ptr(cr, op, &seg, dst, 2, o)) else { return false };
        let i32a = |v: u32| Attribute::of_int(v.into(), Type::int(32));
        let data = OpData::build("rocdl.load.to.lds").operands(&[src, dst]).with("size", i32a(width)).with("offset", i32a(0)).with("aux", i32a(0));
        cr.replace_new(op, data, &[]);
        true
    }
}
