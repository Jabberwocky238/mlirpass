//! `amdgpu` matrix ops ⇒ `rocdl`, as `AMDGPUToROCDL.cpp`'s `MFMAOpLowering`,
//! `ScaledMFMAOpLowering`, `SparseMFMAOpLowering` and `WMMAOpLowering`: the intrinsic picked by
//! element types, shape and chipset, the operands packed the way the intrinsic takes them.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use super::cvt_to_rocdl::Small;
use crate::patterns;
use crate::{AmdChipset, AmdgpuRocdlOptions, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

const GFX908: AmdChipset = AmdChipset::new(9, 0, 8);
const GFX90A: AmdChipset = AmdChipset::new(9, 0, 0xa);
const GFX942: AmdChipset = AmdChipset::new(9, 4, 2);
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);
const GFX1250: AmdChipset = AmdChipset::new(12, 5, 0);

/// The element types the matrix intrinsics distinguish; `Fp8` / `Bf8` as the chipset reads them.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum El {
    F32,
    F16,
    Bf16,
    F64,
    I4,
    I8,
    I32,
    Fp8,
    Bf8,
}

impl El {
    fn of(t: &Type<'_>, small: impl Fn(&Type<'_>) -> Option<Small>) -> Option<Self> {
        Some(match t.element_type() {
            Type::Float(FloatKind::F32) => El::F32,
            Type::Float(FloatKind::F16) => El::F16,
            Type::Float(FloatKind::BF16) => El::Bf16,
            Type::Float(FloatKind::F64) => El::F64,
            Type::Integer { width: 4, .. } => El::I4,
            Type::Integer { width: 8, .. } => El::I8,
            Type::Integer { width: 32, .. } => El::I32,
            e => match small(e)? {
                Small::Fp8 => El::Fp8,
                Small::Bf8 => El::Bf8,
                Small::Fp4 => return None,
            },
        })
    }
}

/// When an intrinsic is there.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Since {
    Any,
    Chip(AmdChipset),
    /// `reducePrecision` on gfx942 and later.
    Xf32,
}

/// `mfmaOpToIntrinsic`, in its order: A and D element types, m n k blocks.
const MFMA: &[(El, El, [u32; 4], Since, &str)] = &[
    (El::F32, El::F32, [32, 32, 4, 1], Since::Xf32, "rocdl.mfma.f32.32x32x4.xf32"),
    (El::F32, El::F32, [16, 16, 8, 1], Since::Xf32, "rocdl.mfma.f32.16x16x8.xf32"),
    (El::F32, El::F32, [32, 32, 1, 2], Since::Any, "rocdl.mfma.f32.32x32x1f32"),
    (El::F32, El::F32, [16, 16, 1, 4], Since::Any, "rocdl.mfma.f32.16x16x1f32"),
    (El::F32, El::F32, [4, 4, 1, 16], Since::Any, "rocdl.mfma.f32.4x4x1f32"),
    (El::F32, El::F32, [32, 32, 2, 1], Since::Any, "rocdl.mfma.f32.32x32x2f32"),
    (El::F32, El::F32, [16, 16, 4, 1], Since::Any, "rocdl.mfma.f32.16x16x4f32"),
    (El::F16, El::F32, [32, 32, 16, 1], Since::Chip(GFX950), "rocdl.mfma.f32.32x32x16.f16"),
    (El::F16, El::F32, [16, 16, 32, 1], Since::Chip(GFX950), "rocdl.mfma.f32.16x16x32.f16"),
    (El::F16, El::F32, [32, 32, 4, 2], Since::Any, "rocdl.mfma.f32.32x32x4f16"),
    (El::F16, El::F32, [16, 16, 4, 4], Since::Any, "rocdl.mfma.f32.16x16x4f16"),
    (El::F16, El::F32, [4, 4, 4, 16], Since::Any, "rocdl.mfma.f32.4x4x4f16"),
    (El::F16, El::F32, [32, 32, 8, 1], Since::Any, "rocdl.mfma.f32.32x32x8f16"),
    (El::F16, El::F32, [16, 16, 16, 1], Since::Any, "rocdl.mfma.f32.16x16x16f16"),
    (El::Bf16, El::F32, [32, 32, 16, 1], Since::Chip(GFX950), "rocdl.mfma.f32.32x32x16.bf16"),
    (El::Bf16, El::F32, [16, 16, 32, 1], Since::Chip(GFX950), "rocdl.mfma.f32.16x16x32.bf16"),
    (El::Bf16, El::F32, [32, 32, 4, 2], Since::Chip(GFX90A), "rocdl.mfma.f32.32x32x4bf16.1k"),
    (El::Bf16, El::F32, [16, 16, 4, 4], Since::Chip(GFX90A), "rocdl.mfma.f32.16x16x4bf16.1k"),
    (El::Bf16, El::F32, [4, 4, 4, 16], Since::Chip(GFX90A), "rocdl.mfma.f32.4x4x4bf16.1k"),
    (El::Bf16, El::F32, [32, 32, 8, 1], Since::Chip(GFX90A), "rocdl.mfma.f32.32x32x8bf16.1k"),
    (El::Bf16, El::F32, [16, 16, 16, 1], Since::Chip(GFX90A), "rocdl.mfma.f32.16x16x16bf16.1k"),
    (El::Bf16, El::F32, [32, 32, 2, 2], Since::Any, "rocdl.mfma.f32.32x32x2bf16"),
    (El::Bf16, El::F32, [16, 16, 2, 4], Since::Any, "rocdl.mfma.f32.16x16x2bf16"),
    (El::Bf16, El::F32, [4, 4, 2, 16], Since::Any, "rocdl.mfma.f32.4x4x2bf16"),
    (El::Bf16, El::F32, [32, 32, 4, 1], Since::Any, "rocdl.mfma.f32.32x32x4bf16"),
    (El::Bf16, El::F32, [16, 16, 8, 1], Since::Any, "rocdl.mfma.f32.16x16x8bf16"),
    (El::I8, El::I32, [32, 32, 32, 1], Since::Chip(GFX950), "rocdl.mfma.i32.32x32x32.i8"),
    (El::I8, El::I32, [16, 16, 64, 1], Since::Chip(GFX950), "rocdl.mfma.i32.16x16x64.i8"),
    (El::I8, El::I32, [32, 32, 4, 2], Since::Any, "rocdl.mfma.i32.32x32x4i8"),
    (El::I8, El::I32, [16, 16, 4, 4], Since::Any, "rocdl.mfma.i32.16x16x4i8"),
    (El::I8, El::I32, [4, 4, 4, 16], Since::Any, "rocdl.mfma.i32.4x4x4i8"),
    (El::I8, El::I32, [32, 32, 8, 1], Since::Any, "rocdl.mfma.i32.32x32x8i8"),
    (El::I8, El::I32, [16, 16, 16, 1], Since::Any, "rocdl.mfma.i32.16x16x16i8"),
    (El::I8, El::I32, [32, 32, 16, 1], Since::Chip(GFX942), "rocdl.mfma.i32.32x32x16.i8"),
    (El::I8, El::I32, [16, 16, 32, 1], Since::Chip(GFX942), "rocdl.mfma.i32.16x16x32.i8"),
    (El::F64, El::F64, [16, 16, 4, 1], Since::Chip(GFX90A), "rocdl.mfma.f64.16x16x4f64"),
    (El::F64, El::F64, [4, 4, 4, 4], Since::Chip(GFX90A), "rocdl.mfma.f64.4x4x4f64"),
    // fp8 / bf8 A: the B type picks the second half of the name.
    (El::Bf8, El::Bf8, [16, 16, 32, 1], Since::Any, "rocdl.mfma.f32.16x16x32.bf8.bf8"),
    (El::Bf8, El::Fp8, [16, 16, 32, 1], Since::Any, "rocdl.mfma.f32.16x16x32.bf8.fp8"),
    (El::Bf8, El::Bf8, [32, 32, 16, 1], Since::Any, "rocdl.mfma.f32.32x32x16.bf8.bf8"),
    (El::Bf8, El::Fp8, [32, 32, 16, 1], Since::Any, "rocdl.mfma.f32.32x32x16.bf8.fp8"),
    (El::Fp8, El::Bf8, [16, 16, 32, 1], Since::Any, "rocdl.mfma.f32.16x16x32.fp8.bf8"),
    (El::Fp8, El::Fp8, [16, 16, 32, 1], Since::Any, "rocdl.mfma.f32.16x16x32.fp8.fp8"),
    (El::Fp8, El::Bf8, [32, 32, 16, 1], Since::Any, "rocdl.mfma.f32.32x32x16.fp8.bf8"),
    (El::Fp8, El::Fp8, [32, 32, 16, 1], Since::Any, "rocdl.mfma.f32.32x32x16.fp8.fp8"),
];

/// `smfmacOpToIntrinsic`, in its order: A, B, D element types, m n k.
const SMFMAC: &[(El, El, El, [u32; 3], bool, &str)] = &[
    (El::F16, El::F16, El::F32, [16, 16, 32], false, "rocdl.smfmac.f32.16x16x32.f16"),
    (El::Bf16, El::Bf16, El::F32, [16, 16, 32], false, "rocdl.smfmac.f32.16x16x32.bf16"),
    (El::F16, El::F16, El::F32, [16, 16, 64], true, "rocdl.smfmac.f32.16x16x64.f16"),
    (El::Bf16, El::Bf16, El::F32, [16, 16, 64], true, "rocdl.smfmac.f32.16x16x64.bf16"),
    (El::I8, El::I8, El::I32, [16, 16, 64], false, "rocdl.smfmac.i32.16x16x64.i8"),
    (El::Fp8, El::Fp8, El::F32, [16, 16, 64], false, "rocdl.smfmac.f32.16x16x64.fp8.fp8"),
    (El::Fp8, El::Bf8, El::F32, [16, 16, 64], false, "rocdl.smfmac.f32.16x16x64.fp8.bf8"),
    (El::Bf8, El::Fp8, El::F32, [16, 16, 64], false, "rocdl.smfmac.f32.16x16x64.bf8.fp8"),
    (El::Bf8, El::Bf8, El::F32, [16, 16, 64], false, "rocdl.smfmac.f32.16x16x64.bf8.bf8"),
    (El::I8, El::I8, El::I32, [16, 16, 128], true, "rocdl.smfmac.i32.16x16x128.i8"),
    (El::Fp8, El::Fp8, El::F32, [16, 16, 128], true, "rocdl.smfmac.f32.16x16x128.fp8.fp8"),
    (El::Fp8, El::Bf8, El::F32, [16, 16, 128], true, "rocdl.smfmac.f32.16x16x128.fp8.bf8"),
    (El::Bf8, El::Fp8, El::F32, [16, 16, 128], true, "rocdl.smfmac.f32.16x16x128.bf8.fp8"),
    (El::Bf8, El::Bf8, El::F32, [16, 16, 128], true, "rocdl.smfmac.f32.16x16x128.bf8.bf8"),
    (El::F16, El::F16, El::F32, [32, 32, 16], false, "rocdl.smfmac.f32.32x32x16.f16"),
    (El::Bf16, El::Bf16, El::F32, [32, 32, 16], false, "rocdl.smfmac.f32.32x32x16.bf16"),
    (El::F16, El::F16, El::F32, [32, 32, 32], true, "rocdl.smfmac.f32.32x32x32.f16"),
    (El::Bf16, El::Bf16, El::F32, [32, 32, 32], true, "rocdl.smfmac.f32.32x32x32.bf16"),
    (El::I8, El::I8, El::I32, [32, 32, 32], false, "rocdl.smfmac.i32.32x32x32.i8"),
    (El::Fp8, El::Fp8, El::F32, [32, 32, 32], false, "rocdl.smfmac.f32.32x32x32.fp8.fp8"),
    (El::Fp8, El::Bf8, El::F32, [32, 32, 32], false, "rocdl.smfmac.f32.32x32x32.fp8.bf8"),
    (El::Bf8, El::Fp8, El::F32, [32, 32, 32], false, "rocdl.smfmac.f32.32x32x32.bf8.fp8"),
    (El::Bf8, El::Bf8, El::F32, [32, 32, 32], false, "rocdl.smfmac.f32.32x32x32.bf8.bf8"),
    (El::I8, El::I8, El::I32, [32, 32, 64], true, "rocdl.smfmac.i32.32x32x64.i8"),
    (El::Fp8, El::Fp8, El::F32, [32, 32, 64], true, "rocdl.smfmac.f32.32x32x64.fp8.fp8"),
    (El::Fp8, El::Bf8, El::F32, [32, 32, 64], true, "rocdl.smfmac.f32.32x32x64.fp8.bf8"),
    (El::Bf8, El::Fp8, El::F32, [32, 32, 64], true, "rocdl.smfmac.f32.32x32x64.bf8.fp8"),
    (El::Bf8, El::Bf8, El::F32, [32, 32, 64], true, "rocdl.smfmac.f32.32x32x64.bf8.bf8"),
];

/// `wmmaOpToIntrinsicRDNA`, in its order: A, B, D element types, k, RDNA3 too, RDNA4 too.
const WMMA_RDNA: &[(El, Option<El>, El, u32, bool, bool, &str)] = &[
    (El::F16, None, El::F32, 16, true, true, "rocdl.wmma.f32.16x16x16.f16"),
    (El::Bf16, None, El::F32, 16, true, true, "rocdl.wmma.f32.16x16x16.bf16"),
    (El::F16, None, El::F16, 16, true, true, "rocdl.wmma.f16.16x16x16.f16"),
    (El::Bf16, None, El::Bf16, 16, true, true, "rocdl.wmma.bf16.16x16x16.bf16"),
    (El::I8, None, El::I32, 16, true, true, "rocdl.wmma.i32.16x16x16.iu8"),
    (El::I4, None, El::I32, 16, true, false, "rocdl.wmma.i32.16x16x16.iu4"),
    (El::Fp8, Some(El::Fp8), El::F32, 16, false, true, "rocdl.wmma.f32.16x16x16.fp8_fp8"),
    (El::Fp8, Some(El::Bf8), El::F32, 16, false, true, "rocdl.wmma.f32.16x16x16.fp8_bf8"),
    (El::Bf8, Some(El::Bf8), El::F32, 16, false, true, "rocdl.wmma.f32.16x16x16.bf8_bf8"),
    (El::Bf8, Some(El::Fp8), El::F32, 16, false, true, "rocdl.wmma.f32.16x16x16.bf8_fp8"),
    (El::I4, None, El::I32, 16, false, true, "rocdl.wmma.i32.16x16x16.iu4"),
    (El::I4, None, El::I32, 32, false, true, "rocdl.wmma.i32.16x16x32.iu4"),
];

/// `amdgpu::MFMAPermB`.
const MFMA_PERM_B: [&str; 8] = ["none", "bcast_first_32", "bcast_second_32", "rotate_16_right", "bcast_first_16", "bcast_second_16", "bcast_third_16", "bcast_fourth_16"];

/// The chips with sparse WMMA.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SparseGen {
    Rdna4,
    Gfx1250,
}

/// An element type of a sparse WMMA row.
#[derive(Clone, Copy, PartialEq, Eq)]
enum SEl {
    F16,
    Bf16,
    F32,
    I4,
    I8,
    I32,
    Fp8,
    Bf8,
}

impl SEl {
    fn is(self, t: &Type<'_>) -> bool {
        match (self, t) {
            (SEl::F16, Type::Float(FloatKind::F16)) | (SEl::Bf16, Type::Float(FloatKind::BF16)) | (SEl::F32, Type::Float(FloatKind::F32)) => true,
            (SEl::Fp8, Type::Float(FloatKind::F8E4M3FN)) | (SEl::Bf8, Type::Float(FloatKind::F8E5M2)) => true,
            (SEl::I4, Type::Integer { width: 4, .. }) | (SEl::I8, Type::Integer { width: 8, .. }) | (SEl::I32, Type::Integer { width: 32, .. }) => true,
            _ => false,
        }
    }
}

/// `SparseWMMAOpInfo` of one row of `sparseWMMAOpToIntrinsic`.
#[derive(Clone, Copy)]
struct SparseWmma {
    chip: SparseGen,
    k: u32,
    a: SEl,
    b: SEl,
    d: SEl,
    name: &'static str,
    sign: bool,
    reuse: bool,
    clamp: bool,
}

macro_rules! swmmac {
    ($($chip:ident $k:literal $a:ident $b:ident $d:ident $name:literal $sign:literal $reuse:literal $clamp:literal;)*) => {
        &[$(SparseWmma { chip: SparseGen::$chip, k: $k, a: SEl::$a, b: SEl::$b, d: SEl::$d, name: $name, sign: $sign, reuse: $reuse, clamp: $clamp }),*]
    };
}

/// `sparseWMMAOpToIntrinsic`, in its order (gfx1250's i8 ⇒ f16 row names the bf8 intrinsic,
/// as upstream does).
const SPARSE_WMMA: &[SparseWmma] = swmmac! {
    Rdna4 32 F16 F16 F32 "rocdl.swmmac.f32.16x16x32.f16" false false false;
    Rdna4 32 Bf16 Bf16 F32 "rocdl.swmmac.f32.16x16x32.bf16" false false false;
    Rdna4 32 F16 F16 F16 "rocdl.swmmac.f16.16x16x32.f16" false false false;
    Rdna4 32 Bf16 Bf16 Bf16 "rocdl.swmmac.bf16.16x16x32.bf16" false false false;
    Rdna4 32 I8 I8 I32 "rocdl.swmmac.i32.16x16x32.iu8" true false true;
    Rdna4 32 I4 I4 I32 "rocdl.swmmac.i32.16x16x32.iu4" true false true;
    Rdna4 32 Fp8 Fp8 F32 "rocdl.swmmac.f32.16x16x32.fp8.fp8" false false false;
    Rdna4 32 Fp8 Bf8 F32 "rocdl.swmmac.f32.16x16x32.fp8.bf8" false false false;
    Rdna4 32 Bf8 Fp8 F32 "rocdl.swmmac.f32.16x16x32.bf8.fp8" false false false;
    Rdna4 32 Bf8 Bf8 F32 "rocdl.swmmac.f32.16x16x32.bf8.bf8" false false false;
    Rdna4 64 I4 I4 I32 "rocdl.swmmac.i32.16x16x64.iu4" true false true;
    Gfx1250 64 F16 F16 F32 "rocdl.swmmac.f32.16x16x64.f16" true true false;
    Gfx1250 64 Bf16 Bf16 F32 "rocdl.swmmac.f32.16x16x64.bf16" true true false;
    Gfx1250 64 F16 F16 F16 "rocdl.swmmac.f16.16x16x64.f16" true true false;
    Gfx1250 64 Bf16 Bf16 Bf16 "rocdl.swmmac.bf16.16x16x64.bf16" true true false;
    Gfx1250 128 Fp8 Fp8 F32 "rocdl.swmmac.f32.16x16x128.fp8.fp8" false true false;
    Gfx1250 128 Fp8 Bf8 F32 "rocdl.swmmac.f32.16x16x128.fp8.bf8" false true false;
    Gfx1250 128 Bf8 Fp8 F32 "rocdl.swmmac.f32.16x16x128.bf8.fp8" false true false;
    Gfx1250 128 Bf8 Bf8 F32 "rocdl.swmmac.f32.16x16x128.bf8.bf8" false true false;
    Gfx1250 128 Fp8 Fp8 F16 "rocdl.swmmac.f16.16x16x128.fp8.fp8" false true false;
    Gfx1250 128 Fp8 Bf8 F16 "rocdl.swmmac.f16.16x16x128.fp8.bf8" false true false;
    Gfx1250 128 Bf8 Fp8 F16 "rocdl.swmmac.f16.16x16x128.bf8.fp8" false true false;
    Gfx1250 128 Bf8 Bf8 F16 "rocdl.swmmac.f16.16x16x128.bf8.bf8" false true false;
    Gfx1250 128 I8 I8 F16 "rocdl.swmmac.f16.16x16x128.bf8.bf8" false true false;
    Gfx1250 128 I8 I8 I32 "rocdl.swmmac.i32.16x16x128.iu8" true true true;
};

/// The amdgpu matrix ops.
pub struct AmdgpuMmaToRocdl;

#[patterns(converter, options = AmdgpuRocdlOptions)]
impl AmdgpuMmaToRocdl {
    fn c32(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32))
    }

    fn bitcast<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, t: Type<'a>) -> ValueId {
        cr.build(OpData::build("llvm.bitcast").operands(&[v]), t)
    }

    fn int(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> i64 {
        super::AmdgpuOperands::int(cr, op, name).unwrap_or(0)
    }

    fn unit(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> bool {
        matches!(cr.rw.body[op].get(name), Some(Attribute::Unit | Attribute::Bool(true)))
    }

    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    /// A vector's length and element type.
    fn vector<'t, 'a>(t: &'t Type<'a>) -> Option<(i64, &'t Type<'a>)> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some((t.element_count()? as i64, &s.elem)),
            _ => None,
        }
    }

    /// `t` with its bf16 elements as i16.
    fn bf16_as_i16<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        Self::vector(t).filter(|(_, e)| matches!(e, Type::Float(FloatKind::BF16))).map(|_| t.with_element(Type::int(16)))
    }

    /// `packSmallFloatVectorOperand` (`sparse`: `convertSparseMFMAVectorOperand`).
    fn pack(cr: &mut Cr<'_, '_, '_>, v: ValueId, allow_bf16: bool, sparse: bool) -> ValueId {
        let t = Self::ty(cr, v);
        let Some((n, e)) = Self::vector(&t) else { return v };
        if !allow_bf16 && let Some(i16s) = Self::bf16_as_i16(&t) {
            return Self::bitcast(cr, v, i16s);
        }
        let Some((w, _)) = e.int_width().filter(|_| matches!(e, Type::Integer { .. })) else { return v };
        if !sparse && w == 8 && n <= 8 {
            return Self::bitcast(cr, v, Type::int((n * 8) as u32));
        }
        if w <= 8 {
            let words = ((n * i64::from(w)) as u64).div_ceil(32) as i64;
            let packed = if words > 1 { Type::vector(&[words], &[false], Type::int(32)) } else { Type::int(32) };
            return Self::bitcast(cr, v, packed);
        }
        v
    }

    fn chip_el(chipset: AmdChipset, t: &Type<'_>) -> Option<El> {
        El::of(t, |e| Small::of_chipset(chipset, e))
    }

    /// `mfmaOpToIntrinsic`.
    fn mfma_intrinsic(cr: &Cr<'_, '_, '_>, op: OpId, chipset: AmdChipset, [m, n, k, b]: [u32; 4]) -> Option<&'static str> {
        let ops = &cr.rw.body[op].operands;
        let (a, bt, d) = (Self::ty(cr, ops[0]), Self::ty(cr, ops[1]), Self::ty(cr, ops[2]));
        let (a, d) = (Self::chip_el(chipset, &a)?, Self::chip_el(chipset, &d)?);
        let small = matches!(a, El::Fp8 | El::Bf8);
        // fp8 rows key on B in the D slot; D must be f32.
        let second = if small {
            if d != El::F32 {
                return None;
            }
            Self::chip_el(chipset, &bt)?
        } else {
            d
        };
        let reduce = Self::unit(cr, op, "reducePrecision");
        MFMA.iter().find(|(ra, rd, shape, since, _)| {
            *ra == a && *rd == second && *shape == [m, n, k, b] && match since {
                Since::Any => true,
                Since::Chip(c) => chipset >= *c,
                Since::Xf32 => reduce && chipset >= GFX942,
            }
        }).map(|r| r.4)
    }

    /// `smallFloatTypeToMatrixFormat`: the `#rocdl<matrix_format ..>` case.
    fn matrix_format(t: &Type<'_>) -> Option<&'static str> {
        match t.element_type() {
            Type::Float(FloatKind::F8E4M3FN) => Some("fp8_e4m3"),
            Type::Float(FloatKind::F8E5M2) => Some("fp8_e5m2"),
            Type::Float(FloatKind::F6E2M3FN) => Some("fp6_e2m3"),
            Type::Float(FloatKind::F6E3M2FN) => Some("fp6_e3m2"),
            Type::Float(FloatKind::F4E2M1FN) => Some("fp4_e2m1"),
            _ => None,
        }
    }

    /// `#rocdl<matrix_format f>`.
    fn matrix_format_attr(f: &str) -> Attribute<'static> {
        Attribute::dialect("rocdl", &alloc::format!("<matrix_format {f}>"))
    }

    /// `#rocdl<mfma_neg_modifier ..>` of negation bits (A, B, C from bit 0).
    fn neg_modifier(bits: i64) -> Attribute<'static> {
        let names: Vec<&str> = ["neg_a", "neg_b", "neg_c"].iter().enumerate().filter(|(i, _)| bits >> i & 1 == 1).map(|(_, n)| *n).collect();
        let body = if names.is_empty() { alloc::string::String::from("none") } else { names.join("|") };
        Attribute::dialect("rocdl", &alloc::format!("<mfma_neg_modifier {body}>"))
    }

    /// `mfmaOpToScaledIntrinsic`.
    fn scaled_intrinsic(cr: &Cr<'_, '_, '_>, op: OpId, chipset: AmdChipset, [m, n, k, b]: [u32; 4]) -> Option<(&'static str, &'static str, &'static str)> {
        let ops = &cr.rw.body[op].operands;
        if chipset < GFX950 || !matches!(Self::ty(cr, ops[2]).element_type(), Type::Float(FloatKind::F32)) {
            return None;
        }
        let (ac, bc) = (Self::matrix_format(&Self::ty(cr, ops[0]))?, Self::matrix_format(&Self::ty(cr, ops[1]))?);
        match [m, n, k, b] {
            [32, 32, 64, 1] => Some(("rocdl.mfma.scale.f32.32x32x64.f8f6f4", ac, bc)),
            [16, 16, 128, 1] => Some(("rocdl.mfma.scale.f32.16x16x128.f8f6f4", ac, bc)),
            _ => None,
        }
    }

    fn shape(cr: &Cr<'_, '_, '_>, op: OpId) -> [u32; 4] {
        let blocks = super::AmdgpuOperands::int(cr, op, "blocks").unwrap_or(1);
        [Self::int(cr, op, "m"), Self::int(cr, op, "n"), Self::int(cr, op, "k"), blocks].map(|v| v as u32)
    }

    /// `blgp` with the negation bits.
    fn blgp(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<i64> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("blgp") else { return Some(0) };
        let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim();
        let name = body.strip_prefix("mfma_perm_b").map_or(body, str::trim);
        MFMA_PERM_B.iter().position(|p| *p == name).map(|p| p as i64)
    }

    /// `MFMAOpLowering`.
    #[convert("amdgpu.mfma")]
    fn mfma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
        if chipset.major != 9 || chipset < GFX908 {
            return false;
        }
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        let raw_out = Self::bf16_as_i16(&out).unwrap_or_else(|| out.clone());
        let Some(mut blgp) = Self::blgp(cr, op) else { return false };
        let negate = [Self::unit(cr, op, "negateA"), Self::unit(cr, op, "negateB"), Self::unit(cr, op, "negateC")];
        if negate.iter().any(|n| *n) {
            if chipset < GFX942 {
                return false;
            }
            blgp |= negate.iter().enumerate().map(|(i, n)| i64::from(*n) << i).sum::<i64>();
        }
        let shape = Self::shape(cr, op);
        let plain = Self::mfma_intrinsic(cr, op, chipset, shape);
        let scaled = Self::scaled_intrinsic(cr, op, chipset, shape);
        let (cbsz, abid) = (Self::int(cr, op, "cbsz"), Self::int(cr, op, "abid"));
        let name = match (plain, scaled) {
            (Some(n), _) => n,
            (None, Some((n, ..))) => {
                if abid > 0 || blgp > 0 || cbsz > 0 {
                    return false;
                }
                n
            }
            (None, None) => return false,
        };
        let allow_bf16 = chipset >= GFX950 && (plain.is_none() || name.contains("16x16x32.bf16") || name.contains("32x32x16.bf16"));
        cr.rw.set_before(op);
        let a = Self::pack(cr, operands[0][0], allow_bf16, false);
        let b = Self::pack(cr, operands[1][0], allow_bf16, false);
        let mut data = OpData::build(name).operands(&[a, b, operands[2][0]]);
        match (plain, scaled) {
            (None, Some((_, ac, bc))) => {
                let zero = Self::c32(cr, 0);
                data = data.operands(&[a, b, operands[2][0], zero, zero]);
                data.set("cbsz", Self::matrix_format_attr(ac));
                data.set("blgp", Self::matrix_format_attr(bc));
                data.set("opselA", Attribute::of_int(0, Type::int(32)));
                data.set("opselB", Attribute::of_int(0, Type::int(32)));
            }
            _ => {
                let f64_dest = matches!(d_ty.element_type(), Type::Float(FloatKind::F64));
                data.set("cbsz", Attribute::of_int(cbsz.into(), Type::int(32)));
                data.set("abid", Attribute::of_int(abid.into(), Type::int(32)));
                let perm = MFMA_PERM_B.get(blgp as usize).copied().unwrap_or("none");
                data.set("blgp", if f64_dest { Self::neg_modifier(blgp) } else { Attribute::dialect("rocdl", &alloc::format!("<mfma_perm_b {perm}>")) });
            }
        }
        let mut r = cr.build(data, raw_out.clone());
        if raw_out != out {
            r = Self::bitcast(cr, r, out);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `castScaleOperand`: an i8 zero-extended, 4 / 8 bytes as one integer.
    fn scale(cr: &mut Cr<'_, '_, '_>, v: ValueId) -> ValueId {
        let t = Self::ty(cr, v);
        match Self::vector(&t) {
            Some((n, _)) => Self::bitcast(cr, v, Type::int(if n == 4 { 32 } else { 64 })),
            None => cr.build(OpData::build("llvm.zext").operands(&[v]), Type::int(32)),
        }
    }

    /// `ScaledMFMAOpLowering`.
    #[convert("amdgpu.scaled_mfma")]
    fn scaled_mfma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if o.chipset.major != 9 || o.chipset < GFX950 {
            return false;
        }
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        let [m, n, k, _] = Self::shape(cr, op);
        let Some((name, ac, bc)) = Self::scaled_intrinsic(cr, op, o.chipset, [m, n, k, 1]) else { return false };
        let (ia, ib) = (Self::int(cr, op, "scalesIdxA"), Self::int(cr, op, "scalesIdxB"));
        cr.rw.set_before(op);
        let a = Self::pack(cr, operands[0][0], true, false);
        let b = Self::pack(cr, operands[1][0], true, false);
        let sa = Self::scale(cr, operands[3][0]);
        let sb = Self::scale(cr, operands[4][0]);
        let data = OpData::build(name)
            .operands(&[a, b, operands[2][0], sa, sb])
            .with("cbsz", Self::matrix_format_attr(ac))
            .with("blgp", Self::matrix_format_attr(bc))
            .with("opselA", Attribute::of_int(ia.into(), Type::int(32)))
            .with("opselB", Attribute::of_int(ib.into(), Type::int(32)));
        let r = cr.build(data, out);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `SparseMFMAOpLowering` (gfx942+).
    #[convert("amdgpu.sparse_mfma")]
    fn sparse_mfma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
        if chipset.major != 9 || chipset < GFX942 {
            return false;
        }
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        let ops = cr.rw.body[op].operands.clone();
        let els: Option<Vec<El>> = ops[..3].iter().map(|v| Self::chip_el(chipset, &Self::ty(cr, *v))).collect();
        let Some(&[a, b, d]) = els.as_deref() else { return false };
        let [m, n, k, _] = Self::shape(cr, op);
        let Some(name) = SMFMAC.iter().find(|r| (r.0, r.1, r.2, r.3) == (a, b, d, [m, n, k]) && (!r.4 || chipset >= GFX950)).map(|r| r.5) else { return false };
        // (the gfx942 bf16 forms take bf16 as i16 even on gfx950)
        let gfx942_bf16 = matches!(name, "rocdl.smfmac.f32.16x16x32.bf16" | "rocdl.smfmac.f32.32x32x16.bf16");
        let gfx950 = chipset >= GFX950 && !gfx942_bf16;
        cr.rw.set_before(op);
        let av = Self::pack(cr, operands[0][0], gfx950, true);
        let bv = Self::pack(cr, operands[1][0], gfx950, true);
        let mut idx = operands[3][0];
        if Self::ty(cr, idx) != Type::int(32) {
            idx = Self::bitcast(cr, idx, Type::int(32));
        }
        let (cbsz, abid) = (Self::int(cr, op, "cbsz"), Self::int(cr, op, "abid"));
        let data = OpData::build(name).operands(&[av, bv, operands[2][0], idx]).with("cbsz", Attribute::of_int(cbsz.into(), Type::int(32))).with("abid", Attribute::of_int(abid.into(), Type::int(32)));
        let r = cr.build(data, out);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `wmmaPushInputOperand`: 8-bit and narrower inputs packed into dwords, with their sign.
    fn wmma_input(cr: &mut Cr<'_, '_, '_>, v: ValueId, mlir: &Type<'_>, unsigned: bool, sign: &'static str, attrs: &mut Vec<(&'static str, Attribute<'static>)>) -> ValueId {
        let t = Self::ty(cr, v);
        let Some((n, e)) = Self::vector(&t) else { return v };
        let Some(w) = e.bit_width().filter(|w| *w <= 8) else { return v };
        if matches!(mlir.element_type(), Type::Integer { .. }) {
            attrs.push((sign, Attribute::Bool(!unsigned)));
        }
        let bits = n * i64::from(w);
        let packed = if bits <= 32 { Type::int(bits as u32) } else { Type::vector(&[bits / 32], &[false], Type::int(32)) };
        let mut r = Self::bitcast(cr, v, packed);
        if bits < 32 {
            r = cr.build(OpData::build("llvm.zext").operands(&[r]), Type::int(32));
        }
        r
    }

    /// `WMMAOpLowering` (gfx11, gfx12.0).
    #[convert("amdgpu.wmma")]
    fn wmma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
        let (rdna3, rdna4) = (chipset.major == 11, chipset.major == 12 && chipset.minor == 0);
        if !rdna3 && !rdna4 {
            return false;
        }
        let ops = cr.rw.body[op].operands.clone();
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        let ocp = |e: &Type<'_>| match e {
            Type::Float(FloatKind::F8E4M3FN) => Some(Small::Fp8),
            Type::Float(FloatKind::F8E5M2) => Some(Small::Bf8),
            _ => None,
        };
        let (ma, mb) = (Self::ty(cr, ops[0]), Self::ty(cr, ops[1]));
        let (Some(a), Some(b), Some(d)) = (El::of(&ma, ocp), El::of(&mb, ocp), El::of(&d_ty, ocp)) else { return false };
        let k = Self::int(cr, op, "k") as u32;
        let Some(name) = WMMA_RDNA.iter().find(|r| r.0 == a && r.1.is_none_or(|rb| rb == b) && r.2 == d && r.3 == k && if rdna3 { r.4 } else { r.5 }).map(|r| r.6) else { return false };
        let sub = Self::int(cr, op, "subwordOffset");
        if chipset.major >= 12 && sub != 0 {
            return false;
        }
        let raw_out = Self::bf16_as_i16(&out).unwrap_or_else(|| out.clone());
        cr.rw.set_before(op);
        let mut vals = [operands[0][0], operands[1][0], operands[2][0]];
        for v in &mut vals {
            let t = Self::ty(cr, *v);
            if let Some(i16s) = Self::bf16_as_i16(&t) {
                *v = Self::bitcast(cr, *v, i16s);
            }
        }
        let mut attrs = Vec::new();
        let a = Self::wmma_input(cr, vals[0], &ma, Self::unit(cr, op, "unsignedA"), "signA", &mut attrs);
        let b = Self::wmma_input(cr, vals[1], &mb, Self::unit(cr, op, "unsignedB"), "signB", &mut attrs);
        match Self::vector(&Self::ty(cr, vals[2])).map(|(_, e)| e.clone()) {
            Some(Type::Float(FloatKind::F16 | FloatKind::BF16) | Type::Integer { width: 16, .. }) => attrs.push(("opsel", Attribute::Bool(sub != 0))),
            Some(Type::Integer { width: 32, .. }) => attrs.push(("clamp", Attribute::Bool(Self::unit(cr, op, "clamp")))),
            _ => {}
        }
        let mut data = OpData::build(name).operands(&[a, b, vals[2]]);
        for (n, v) in attrs {
            data.set(n, v);
        }
        let mut r = cr.build(data, raw_out.clone());
        if raw_out != out {
            r = Self::bitcast(cr, r, out);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `dotOpToIntrinsic`: the intrinsic, whether it takes signs (`sudot*`) and whether it
    /// takes a clamp.
    fn dot_intrinsic(cr: &Cr<'_, '_, '_>, op: OpId, chipset: AmdChipset) -> Option<(&'static str, bool, bool)> {
        let ops = &cr.rw.body[op].operands;
        let (at, bt, dest) = (Self::ty(cr, ops[0]), Self::ty(cr, ops[1]), Self::ty(cr, ops[2]));
        let (a, b) = (at.element_type(), bt.element_type());
        let (ua, ub) = (Self::unit(cr, op, "unsignedA"), Self::unit(cr, op, "unsignedB"));
        use FloatKind::*;
        let f = |t: &Type<'_>| if let Type::Float(k) = t { Some(*k) } else { None };
        match (f(a), f(b), f(&dest)) {
            (Some(F16), Some(F16), Some(F32)) if chipset.has_dot10() => return Some(("rocdl.fdot2", false, true)),
            (Some(F16), Some(F16), Some(F16)) if chipset.has_dot9() => return Some(("rocdl.fdot2.f16.f16", false, false)),
            (Some(F16), Some(F16), _) => return None,
            (Some(BF16), Some(BF16), Some(F32)) if chipset.has_dot12() => return Some(("rocdl.fdot2.f32.bf16", false, true)),
            (Some(BF16), Some(BF16), Some(BF16)) if chipset.has_dot9() => return Some(("rocdl.fdot2.bf16.bf16", false, false)),
            (Some(BF16), Some(BF16), _) => return None,
            (Some(x @ (F8E4M3FN | F8E5M2)), Some(y @ (F8E4M3FN | F8E5M2)), Some(F32)) => {
                if !chipset.has_dot11() {
                    return None;
                }
                let n = |k: FloatKind| if k == F8E4M3FN { "fp8" } else { "bf8" };
                return Some((match (n(x), n(y)) {
                    ("fp8", "fp8") => "rocdl.dot4.f32.fp8.fp8",
                    ("fp8", _) => "rocdl.dot4.f32.fp8.bf8",
                    (_, "fp8") => "rocdl.dot4.f32.bf8.fp8",
                    _ => "rocdl.dot4.f32.bf8.bf8",
                }, false, false));
            }
            _ => {}
        }
        let (Type::Integer { width, .. }, Type::Integer { .. }, Type::Integer { width: 32, .. }) = (a, b, &dest) else { return None };
        if ua != ub {
            return chipset.has_dot8().then_some(match width {
                8 => "rocdl.sudot4",
                4 => "rocdl.sudot8",
                _ => return None,
            }).map(|n| (n, true, true));
        }
        let (name, supported) = match width {
            16 => (if ua { "rocdl.udot2" } else { "rocdl.sdot2" }, chipset.has_dot1()),
            8 => (if ua { "rocdl.udot4" } else { "rocdl.sdot4" }, if ua { chipset.has_dot7() } else { chipset.has_dot1() || chipset.has_dot8() }),
            4 => (if ua { "rocdl.udot8" } else { "rocdl.sdot8" }, if ua { chipset.has_dot7() } else { chipset.has_dot1() || chipset.has_dot8() }),
            _ => return None,
        };
        supported.then_some((name, false, true))
    }

    /// `DotOpLowering`: 8-bit and narrower sources packed in dwords.
    #[convert("amdgpu.dot")]
    fn dot(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let Some((name, signs, clamp)) = Self::dot_intrinsic(cr, op, o.chipset) else { return false };
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        cr.rw.set_before(op);
        let a = Self::pack(cr, operands[0][0], true, true);
        let b = Self::pack(cr, operands[1][0], true, true);
        let mut data = OpData::build(name).operands(&[a, b, operands[2][0]]);
        if signs {
            data.set("signA", Attribute::Bool(!Self::unit(cr, op, "unsignedA")));
            data.set("signB", Attribute::Bool(!Self::unit(cr, op, "unsignedB")));
        }
        if clamp {
            data.set("clamp", Attribute::Bool(Self::unit(cr, op, "clamp")));
        }
        let r = cr.build(data, out);
        cr.replace(op, vec![vec![r]]);
        true
    }


    /// `sparseWMMAOpToIntrinsic`: the intrinsic, and whether it takes signs, reuse flags and a
    /// clamp; RDNA4 (`k` 32 / 64) or gfx1250 wave32 (`k` 64 / 128).
    fn sparse_wmma_intrinsic(cr: &Cr<'_, '_, '_>, op: OpId, chipset: AmdChipset) -> Option<SparseWmma> {
        let ops = &cr.rw.body[op].operands;
        let [a, b, d] = [ops[0], ops[1], ops[2]].map(|v| Self::ty(cr, v).element_type().clone());
        let [m, n, k, _] = Self::shape(cr, op);
        if (m, n) != (16, 16) {
            return None;
        }
        let chip = if chipset.major == 12 && chipset.minor == 0 {
            SparseGen::Rdna4
        } else if chipset == GFX1250 && !Self::unit(cr, op, "wave64") {
            SparseGen::Gfx1250
        } else {
            return None;
        };
        SPARSE_WMMA.iter().find(|r| r.chip == chip && r.k == k && r.a.is(&a) && r.b.is(&b) && r.d.is(&d)).copied()
    }

    /// `SparseWMMAOpLowering`.
    #[convert("amdgpu.sparse_wmma")]
    fn sparse_wmma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let d_ty = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(out) = cr.converted(&d_ty) else { return false };
        let Some(w) = Self::sparse_wmma_intrinsic(cr, op, o.chipset) else { return false };
        let [ua, ub, ra, rb, cl] = ["unsignedA", "unsignedB", "reuseA", "reuseB", "clamp"].map(|n| Self::unit(cr, op, n));
        if (ua || ub) && !w.sign || (ra || rb) && !w.reuse || cl && !w.clamp {
            return false;
        }
        let gfx1250 = o.chipset.major == 12 && o.chipset.minor >= 5;
        cr.rw.set_before(op);
        let a = Self::pack(cr, operands[0][0], gfx1250, true);
        let b = Self::pack(cr, operands[1][0], gfx1250, true);
        let c = if gfx1250 { operands[2][0] } else { Self::pack(cr, operands[2][0], false, true) };
        let raw_out = Self::ty(cr, c);
        let idx = Self::bitcast(cr, operands[3][0], Type::int(32));
        let mut r = cr.build(OpData::build(w.name).operands(&[a, b, c, idx]), raw_out.clone());
        // A flag passed on is the unit attribute itself, which an i1 property does not take:
        // that property ends up unset (the others keep their defaults).
        let given = [("signA", ua && w.sign), ("signB", ub && w.sign), ("reuseA", ra && w.reuse), ("reuseB", rb && w.reuse), ("clamp", cl && w.clamp)];
        if let Some(lowered) = cr.rw.body.def_op(r) {
            for (prop, _) in given.iter().filter(|(_, g)| *g) {
                cr.rw.body[lowered].remove(prop);
            }
        }
        if raw_out != out {
            r = Self::bitcast(cr, r, out);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

}
