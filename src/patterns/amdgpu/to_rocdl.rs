//! `amdgpu` ⇒ `rocdl`, as `AMDGPUToROCDL.cpp` (the cross-lane ops so far).

use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Type};

use crate::patterns;
use crate::{AmdChipset, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);

/// The amdgpu ⇒ rocdl patterns (`populateAMDGPUToROCDLConversionPatterns`).
pub struct AmdgpuToRocdl;

#[patterns(converter, options = AmdChipset)]
impl AmdgpuToRocdl {
    fn int_attr(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<i64> {
        match cr.rw.body[op].get(name)? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    fn flag(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> bool {
        matches!(cr.rw.body[op].get(name), Some(Attribute::Bool(true) | Attribute::Unit))
    }

    /// `AMDGPUSwizzleBitModeLowering`: `rocdl.ds_swizzle` of each dword.
    #[convert("amdgpu.swizzle_bitmode")]
    fn swizzle_bitmode(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: AmdChipset) -> bool {
        let src = operands[0][0];
        let (Some(and), Some(or), Some(xor)) = (Self::int_attr(cr, op, "and_mask"), Self::int_attr(cr, op, "or_mask"), Self::int_attr(cr, op, "xor_mask")) else { return false };
        cr.rw.set_before(op);
        let parts = cr.decompose(src, Type::int(32));
        let mask = cr.llvm_constant(Attribute::of_int((and | (or << 5) | (xor << 10)).into(), Type::int(32)), Type::int(32));
        let swizzled: Vec<ValueId> = parts.iter().map(|v| {
            let t = cr.rw.body[*v].ty.clone();
            cr.build(OpData::build("rocdl.ds_swizzle").operands(&[*v, mask]), t)
        }).collect();
        let ty = cr.rw.body[src].ty.clone();
        let r = cr.compose(&swizzled, ty);
        cr.replace(op, alloc::vec![alloc::vec![r]]);
        true
    }

    /// `AMDGPUPermlaneLowering`: `rocdl.permlane{16,32}.swap` of each dword (gfx950+).
    #[convert("amdgpu.permlane_swap")]
    fn permlane_swap(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        if chipset < GFX950 {
            return false;
        }
        let src = operands[0][0];
        let name = match Self::int_attr(cr, op, "row_length") {
            Some(16) => "rocdl.permlane16.swap",
            Some(32) => "rocdl.permlane32.swap",
            _ => return false,
        };
        let (fi, bound) = (Self::flag(cr, op, "fetch_inactive"), Self::flag(cr, op, "bound_ctrl"));
        cr.rw.set_before(op);
        let parts = cr.decompose(src, Type::int(32));
        let mut permuted = Vec::new();
        for v in parts {
            let t = cr.rw.body[v].ty.clone();
            let pair = LlvmType::literal(alloc::vec![t.clone(), t]);
            let r = cr.build(OpData::build(name).operands(&[v, v]).with("fi", Attribute::Bool(fi)).with("boundControl", Attribute::Bool(bound)), pair);
            let d0 = cr.extract(r, &[0]);
            let d1 = cr.extract(r, &[1]);
            let eq = cr.build(OpData::build("llvm.icmp").operands(&[d0, v]).with("predicate", Attribute::i64(0)), Type::int(1));
            let t = cr.rw.body[d0].ty.clone();
            permuted.push(cr.build(OpData::build("llvm.select").operands(&[eq, d1, d0]), t));
        }
        let ty = cr.rw.body[src].ty.clone();
        let r = cr.compose(&permuted, ty);
        cr.replace(op, alloc::vec![alloc::vec![r]]);
        true
    }
}
