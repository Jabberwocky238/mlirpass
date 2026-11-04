//! `amdgpu` small-float conversions ⇒ `rocdl.cvt.*`, as `AMDGPUToROCDL.cpp`'s
//! `ExtPackedFp8OpLowering` … `PackedScaledTruncOpLowering`: the sources packed into a dword,
//! one intrinsic, the packed result bitcast back.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use super::AmdgpuOperands;
use crate::patterns;
use crate::{AmdChipset, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx942`.
const GFX942: AmdChipset = AmdChipset::new(9, 4, 2);
/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);

/// The small float formats of the conversion intrinsics, by their intrinsic spelling.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Small {
    Fp8,
    Bf8,
    Fp4,
}

impl Small {
    const fn name(self) -> &'static str {
        match self {
            Small::Fp8 => "fp8",
            Small::Bf8 => "bf8",
            Small::Fp4 => "fp4",
        }
    }

    /// `typeIsExpected{Fp8,Bf8}ForChipset`: FNUZ on gfx942, OCP from gfx950 / gfx12.
    fn of_chipset(chipset: AmdChipset, t: &Type<'_>) -> Option<Self> {
        let ocp = (chipset.major == 9 && chipset.minor >= 5) || chipset.major >= 12;
        match t {
            Type::Float(FloatKind::F8E5M2FNUZ) if chipset == GFX942 => Some(Small::Bf8),
            Type::Float(FloatKind::F8E4M3FNUZ) if chipset == GFX942 => Some(Small::Fp8),
            Type::Float(FloatKind::F8E5M2) if ocp => Some(Small::Bf8),
            Type::Float(FloatKind::F8E4M3FN) if ocp => Some(Small::Fp8),
            _ => None,
        }
    }

    /// The OCP formats of the gfx950 scaled conversions.
    fn ocp(t: &Type<'_>) -> Option<Self> {
        match t {
            Type::Float(FloatKind::F8E5M2) => Some(Small::Bf8),
            Type::Float(FloatKind::F8E4M3FN) => Some(Small::Fp8),
            Type::Float(FloatKind::F4E2M1FN) => Some(Small::Fp4),
            _ => None,
        }
    }

    /// The selector attribute of a gfx950 scaled conversion: a byte index for fp4, a half for
    /// the 8-bit formats.
    fn selector(self, half: &'static str, index: &'static str, i: i64) -> (&'static str, Attribute<'static>) {
        match self {
            Small::Fp4 => (index, Attribute::of_int(i.into(), Type::int(32))),
            _ => (half, Attribute::Bool(i != 0)),
        }
    }
}

/// The wide float formats, by their intrinsic spelling.
fn wide(t: &Type<'_>) -> Option<&'static str> {
    match t {
        Type::Float(FloatKind::F32) => Some("f32"),
        Type::Float(FloatKind::F16) => Some("f16"),
        Type::Float(FloatKind::BF16) => Some("bf16"),
        _ => None,
    }
}

/// The packed small-float conversions.
pub struct AmdgpuCvtToRocdl;

#[patterns(converter, options = AmdChipset)]
impl AmdgpuCvtToRocdl {
    fn c32(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32))
    }

    fn bitcast<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, t: Type<'a>) -> ValueId {
        cr.build(OpData::build("llvm.bitcast").operands(&[v]), t)
    }

    /// `src` (a scalar or a short vector of `n`) placed in the low lanes of a fresh `wide`,
    /// `llvm.mlir.undef` or `llvm.mlir.zero`.
    fn widen<'a>(cr: &mut Cr<'_, 'a, '_>, src: ValueId, n: Option<i64>, wide: Type<'a>, fill: &str) -> ValueId {
        let mut long = cr.build(OpData::build(fill), wide.clone());
        let elem = wide.element_type().clone();
        match n {
            None => {
                let c = Self::c32(cr, 0);
                long = cr.build(OpData::build("llvm.insertelement").operands(&[long, src, c]), wide);
            }
            Some(n) => {
                for i in 0..n {
                    let c = Self::c32(cr, i);
                    let e = cr.build(OpData::build("llvm.extractelement").operands(&[src, c]), elem.clone());
                    long = cr.build(OpData::build("llvm.insertelement").operands(&[long, e, c]), wide.clone());
                }
            }
        }
        long
    }

    fn vec_len(t: &Type<'_>) -> Option<i64> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => t.element_count().map(|n| n as i64),
            _ => None,
        }
    }

    /// `ExtPackedFp8OpLowering`.
    #[convert("amdgpu.ext_packed_fp8")]
    fn ext_packed_fp8(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        let body = &cr.rw.body;
        let (src_ty, res_ty) = (body[body[op].operands[0]].ty.clone(), body[body[op].results[0]].ty.clone());
        let Some(kind) = Small::of_chipset(chipset, src_ty.element_type()) else { return false };
        let Some(f32t) = cr.converted(&res_ty) else { return false };
        let Some(index) = AmdgpuOperands::int(cr, op, "index") else { return false };
        cr.rw.set_before(op);
        let mut src = operands[0][0];
        let n = Self::vec_len(&src_ty);
        if n.is_none_or(|n| n < 4) {
            src = Self::widen(cr, src, n, Type::vector(&[4], &[false], Type::int(8)), "llvm.mlir.undef");
        }
        let i32src = Self::bitcast(cr, src, Type::int(32));
        let data = if Self::vec_len(&res_ty).is_some() {
            OpData::build(&format!("rocdl.cvt.pk.f32.{}", kind.name())).with("wordSel", Attribute::Bool(index != 0))
        } else {
            OpData::build(&format!("rocdl.cvt.f32.{}", kind.name())).with("byteSel", Attribute::of_int(index.into(), Type::int(32)))
        };
        let r = cr.build(data.operands(&[i32src]), f32t);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `ScaledExtPackedOpLowering` (gfx950).
    #[convert("amdgpu.scaled_ext_packed")]
    fn scaled_ext_packed(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        if chipset != GFX950 {
            return false;
        }
        let body = &cr.rw.body;
        let (src_ty, res_ty) = (body[body[op].operands[0]].ty.clone(), body[body[op].results[0]].ty.clone());
        let (Some(kind), Some(dst)) = (Small::ocp(src_ty.element_type()), wide(res_ty.element_type())) else { return false };
        let Some(index) = AmdgpuOperands::int(cr, op, "index") else { return false };
        let packed = match kind {
            Small::Fp4 => Type::vector(&[8], &[false], Type::int(4)),
            _ => Type::vector(&[4], &[false], Type::int(8)),
        };
        cr.rw.set_before(op);
        let (mut src, scale) = (operands[0][0], operands[1][0]);
        let n = Self::vec_len(&src_ty).unwrap_or(1);
        if Some(n) < Self::vec_len(&packed) {
            src = Self::widen(cr, src, Some(n), packed, "llvm.mlir.zero");
        }
        let i32src = Self::bitcast(cr, src, Type::int(32));
        let (sel, attr) = kind.selector("srcLoHiSel", "srcSelIndex", index);
        let data = OpData::build(&format!("rocdl.cvt.scalef32.pk.{dst}.{}", kind.name())).operands(&[i32src, scale]).with(sel, attr);
        let r = cr.build(data, res_ty);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `PackedScaledTruncOpLowering` (gfx950).
    #[convert("amdgpu.packed_scaled_trunc")]
    fn packed_scaled_trunc(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        if chipset != GFX950 {
            return false;
        }
        let body = &cr.rw.body;
        let (src_ty, res_ty) = (body[body[op].operands[0]].ty.clone(), body[body[op].results[0]].ty.clone());
        let src_elem = src_ty.element_type().clone();
        let (Some(kind), Some(srcn)) = (Small::ocp(res_ty.element_type()), wide(&src_elem)) else { return false };
        let (Some(index), Some(res)) = (AmdgpuOperands::int(cr, op, "index"), cr.converted(&res_ty)) else { return false };
        let int_ty = match kind {
            Small::Fp4 => Type::int(32),
            _ => Type::vector(&[2], &[false], Type::int(16)),
        };
        cr.rw.set_before(op);
        let (mut src, scale) = (operands[0][0], operands[1][0]);
        let existing = match operands.get(2).and_then(|e| e.first()) {
            Some(e) => Self::bitcast(cr, *e, int_ty.clone()),
            None => cr.build(OpData::build("llvm.mlir.zero"), int_ty.clone()),
        };
        if Self::vec_len(&src_ty).is_some_and(|n| n < 2) {
            let c0 = Self::c32(cr, 0);
            let e0 = cr.build(OpData::build("llvm.extractelement").operands(&[src, c0]), src_elem.clone());
            let v2 = Type::vector(&[2], &[false], src_elem.clone());
            let z = cr.build(OpData::build("llvm.mlir.zero"), v2.clone());
            src = cr.build(OpData::build("llvm.insertelement").operands(&[z, e0, c0]), v2);
        }
        let mut ops = vec![existing];
        if srcn == "f32" {
            let (c0, c1) = (Self::c32(cr, 0), Self::c32(cr, 1));
            ops.push(cr.build(OpData::build("llvm.extractelement").operands(&[src, c0]), src_elem.clone()));
            ops.push(cr.build(OpData::build("llvm.extractelement").operands(&[src, c1]), src_elem));
        } else {
            ops.push(src);
        }
        ops.push(scale);
        let (sel, attr) = kind.selector("dstLoHiSel", "dstSelIndex", index);
        let r = cr.build(OpData::build(&format!("rocdl.cvt.scalef32.pk.{}.{srcn}", kind.name())).operands(&ops).with(sel, attr), int_ty);
        let r = Self::bitcast(cr, r, res);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `existing` as an i32, or `llvm.mlir.undef`.
    fn existing_i32(cr: &mut Cr<'_, '_, '_>, existing: Option<ValueId>) -> ValueId {
        match existing {
            Some(e) => Self::bitcast(cr, e, Type::int(32)),
            None => cr.build(OpData::build("llvm.mlir.undef"), Type::int(32)),
        }
    }

    /// `PackedTrunc2xFp8OpLowering`.
    #[convert("amdgpu.packed_trunc_2xfp8")]
    fn packed_trunc_2xfp8(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        let res_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(kind) = Small::of_chipset(chipset, res_ty.element_type()) else { return false };
        let (Some(word), Some(res)) = (AmdgpuOperands::int(cr, op, "wordIndex"), cr.converted(&res_ty)) else { return false };
        let seg = AmdgpuOperands::new(cr, op, operands);
        let (a, b, existing) = (seg.one(0), seg.one(1), seg.one(2));
        let Some(a) = a else { return false };
        cr.rw.set_before(op);
        let b = match b {
            Some(b) => b,
            None => {
                let t = cr.rw.body[a].ty.clone();
                cr.build(OpData::build("llvm.mlir.undef"), t)
            }
        };
        let existing = Self::existing_i32(cr, existing);
        let data = OpData::build(&format!("rocdl.cvt.pk.{}.f32", kind.name())).operands(&[a, b, existing]).with("wordSel", Attribute::Bool(word != 0));
        let r = cr.build(data, Type::int(32));
        let r = Self::bitcast(cr, r, res);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `PackedStochRoundFp8OpLowering`.
    #[convert("amdgpu.packed_stoch_round_fp8")]
    fn packed_stoch_round_fp8(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], chipset: AmdChipset) -> bool {
        let res_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(kind) = Small::of_chipset(chipset, res_ty.element_type()) else { return false };
        let (Some(store), Some(res)) = (AmdgpuOperands::int(cr, op, "storeIndex"), cr.converted(&res_ty)) else { return false };
        cr.rw.set_before(op);
        let existing = Self::existing_i32(cr, operands.get(2).and_then(|e| e.first()).copied());
        let data = OpData::build(&format!("rocdl.cvt.sr.{}.f32", kind.name()))
            .operands(&[operands[0][0], operands[1][0], existing])
            .with("byteSel", Attribute::of_int(store.into(), Type::int(32)));
        let r = cr.build(data, Type::int(32));
        let r = Self::bitcast(cr, r, res);
        cr.replace(op, vec![vec![r]]);
        true
    }
}
