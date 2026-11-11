//! `nvgpu` ⇒ `nvvm`, as `NVGPUToNVVM.cpp`: mma / ldmatrix fragments unpacked into the scalars
//! the NVVM ops take, async copies, mbarriers, TMA, and the warpgroup GEMM unrolled into wgmma
//! instructions.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, Shaped, ShapedKind, Signedness, Type};

use super::types::{NvgpuType, Swizzle};
use crate::patterns;
use crate::{ConversionRewriter, LlvmOptions, MemrefToLlvm, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `exclude4LSB`: the bits a matrix descriptor leaves out.
const EXCLUDE_4LSB: u32 = 4;
/// `kWarpSize`.
const WARP_SIZE: i64 = 32;

/// `NVVM::MMATypes`, the PTX types of mma operands.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum MmaType {
    F16,
    Bf16,
    F32,
    Tf32,
    F64,
    S8,
    S4,
    S32,
}

impl MmaType {
    const fn name(self) -> &'static str {
        match self {
            MmaType::F16 => "f16",
            MmaType::Bf16 => "bf16",
            MmaType::F32 => "f32",
            MmaType::Tf32 => "tf32",
            MmaType::F64 => "f64",
            MmaType::S8 => "s8",
            MmaType::S4 => "s4",
            MmaType::S32 => "s32",
        }
    }

    /// `getNvvmMmaType`: a multiplicand.
    fn multiplicand(t: &Type<'_>) -> Option<Self> {
        Some(match t.element_type() {
            Type::Integer { width: 8, .. } => MmaType::S8,
            Type::Integer { width: 4, .. } => MmaType::S4,
            Type::Float(FloatKind::F16) => MmaType::F16,
            Type::Float(FloatKind::BF16) => MmaType::Bf16,
            Type::Float(FloatKind::F64) => MmaType::F64,
            Type::Float(FloatKind::F32) => MmaType::Tf32,
            _ => return None,
        })
    }

    /// `MmaOp::inferOperandMMAType(t, /*isAccumulator=*/true)`.
    fn accumulator(t: &Type<'_>) -> Option<Self> {
        Some(match t.element_type() {
            Type::Float(FloatKind::F16) => MmaType::F16,
            Type::Float(FloatKind::F32) => MmaType::F32,
            Type::Float(FloatKind::F64) => MmaType::F64,
            Type::Integer { width: 32, .. } => MmaType::S32,
            Type::Shaped(s) if s.kind == ShapedKind::Vector && matches!(*s.elem, Type::Float(FloatKind::F16)) => MmaType::F16,
            _ => return None,
        })
    }
}

impl From<MmaType> for Attribute<'static> {
    fn from(t: MmaType) -> Self {
        Attribute::dialect("nvvm.mma_type", &format!("<{}>", t.name()))
    }
}

/// `NVVM::WGMMATypes` of an element type (`f32`: tf32 for the inputs, f32 for the result).
fn wgmma_type(t: &Type<'_>, result: bool) -> Option<&'static str> {
    Some(match t {
        Type::Float(FloatKind::F32 | FloatKind::TF32) => {
            if result {
                "f32"
            } else {
                "tf32"
            }
        }
        Type::Float(FloatKind::F16) => "f16",
        Type::Float(FloatKind::BF16) => "bf16",
        Type::Float(FloatKind::F8E4M3FN) => "e4m3",
        Type::Float(FloatKind::F8E5M2) => "e5m2",
        Type::Integer { width: 1, .. } => "b1",
        Type::Integer { width: 8, signedness: Signedness::Unsigned } => "u8",
        Type::Integer { width: 8, .. } => "s8",
        Type::Integer { width: 32, .. } => "s32",
        _ => return None,
    })
}

/// `elementTypeAsLLVMConstant`: `CUtensorMapDataType`.
fn tensor_map_data_type(t: &Type<'_>) -> Option<i64> {
    Some(match t {
        Type::Integer { width: 8, signedness: Signedness::Unsigned } => 0,
        Type::Integer { width: 16, signedness: Signedness::Unsigned } => 1,
        Type::Integer { width: 32, signedness: Signedness::Unsigned } => 2,
        Type::Integer { width: 64, signedness: Signedness::Unsigned } => 4,
        Type::Integer { width: 32, signedness: Signedness::Signless } => 3,
        Type::Integer { width: 64, signedness: Signedness::Signless } => 5,
        Type::Float(FloatKind::F16) => 6,
        Type::Float(FloatKind::F32) => 7,
        Type::Float(FloatKind::F64) => 8,
        Type::Float(FloatKind::BF16) => 9,
        _ => return None,
    })
}

/// The nvgpu ⇒ nvvm patterns (`populateNVGPUToNVVMConversionPatterns`).
pub struct NvgpuToNvvm;

#[patterns(converter, options = LlvmOptions)]
impl NvgpuToNvvm {
    // ---- helpers ----------------------------------------------------------------------------

    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    fn nv(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<NvgpuType<'static>> {
        NvgpuType::parse(&cr.rw.body[v].ty, cr.rw.body.ctx.opt)
    }

    fn int(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<i64> {
        match cr.rw.body[op].get(name)? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    fn unit(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> bool {
        matches!(cr.rw.body[op].get(name), Some(Attribute::Unit | Attribute::Bool(true)))
    }

    pub(super) fn c<'a>(cr: &mut Cr<'_, 'a, '_>, v: i64, w: u32) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(w)), Type::int(w))
    }

    /// `makeI64Const`: an i64 constant holding an i32 attribute.
    fn c64(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(64))
    }

    fn op1<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, a: ValueId, t: Type<'a>) -> ValueId {
        cr.build(OpData::build(name).operands(&[a]), t)
    }

    fn op2(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let t = Self::ty(cr, a);
        cr.build(OpData::build(name).operands(&[a, b]), t)
    }

    /// An `llvm.add` / `mul` / `shl` with no overflow flags.
    fn arith(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let t = Self::ty(cr, a);
        cr.build(OpData::build(name).operands(&[a, b]).with("overflowFlags", Attribute::of_int(0, Type::int(32))), t)
    }

    /// `truncToI32`.
    fn trunc32(cr: &mut Cr<'_, '_, '_>, v: ValueId) -> ValueId {
        match Self::ty(cr, v).int_width() {
            Some((w, _)) if w <= 32 => v,
            _ => cr.build(OpData::build("llvm.trunc").operands(&[v]).with("overflowFlags", Attribute::of_int(0, Type::int(32))), Type::int(32)),
        }
    }

    fn memref<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<Shaped<'a>> {
        match &cr.rw.body[v].ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(*s.clone()),
            _ => None,
        }
    }

    /// `getStridedElementPtr` of memref operand `orig` (converted `desc`).
    fn element_ptr(cr: &mut Cr<'_, '_, '_>, o: LlvmOptions, orig: ValueId, desc: ValueId, indices: &[ValueId]) -> Option<ValueId> {
        let s = Self::memref(cr, orig)?;
        MemrefToLlvm::strided_ptr(cr, o, &s, desc, indices, 0)
    }

    /// `getMbarrierPtr`: barrier `id` of the group `orig` (converted `desc`).
    fn mbarrier_ptr(cr: &mut Cr<'_, '_, '_>, o: LlvmOptions, orig: ValueId, desc: ValueId, id: ValueId) -> Option<ValueId> {
        let Some(NvgpuType::MbarrierGroup { shared, barriers }) = Self::nv(cr, orig) else { return None };
        let s = NvgpuType::mbarrier_memref(shared, barriers);
        MemrefToLlvm::strided_ptr(cr, o, &s, desc, &[id], 0)
    }

    /// The operand groups of `op` by `operandSegmentSizes`.
    fn groups<'v>(cr: &Cr<'_, '_, '_>, op: OpId, operands: &'v [Vec<ValueId>]) -> Vec<&'v [Vec<ValueId>]> {
        let sizes = cr.rw.body.segments(op, "operandSegmentSizes").unwrap_or_else(|| vec![1; operands.len()]);
        let mut rest = operands;
        sizes.into_iter().map(|n| {
            let (g, r) = rest.split_at(n.min(rest.len()));
            rest = r;
            g
        }).collect()
    }

    fn firsts(g: &[Vec<ValueId>]) -> Vec<ValueId> {
        g.iter().filter_map(|v| v.first().copied()).collect()
    }

    fn mem_scope(scope: &str) -> Attribute<'static> {
        Attribute::dialect("nvvm.mem_scope", &format!("<{scope}>"))
    }

    // ---- mma.sync / ldmatrix -------------------------------------------------------------

    /// `unpackOperandVector`.
    fn unpack(cr: &mut Cr<'_, '_, '_>, v: ValueId, ptx: MmaType) -> Vec<ValueId> {
        let t = Self::ty(cr, v);
        let Ok(LlvmType::Array(n, elem)) = LlvmType::try_from(&t) else { return vec![v] };
        let elem: Type<'_> = (*elem).clone();
        let inner = match &elem {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some((elem.element_count().unwrap_or(0), (*s.elem).clone())),
            _ => None,
        };
        let mut out = Vec::new();
        for i in 0..n as i64 {
            let x = cr.extract(v, &[i]);
            let to_i32 = match &inner {
                Some((4, Type::Integer { width: 8, .. })) | Some((8, Type::Integer { width: 4, .. })) => true,
                Some((1, Type::Float(FloatKind::F32))) => ptx == MmaType::Tf32,
                Some((2, Type::Float(FloatKind::BF16))) => ptx == MmaType::Bf16,
                _ => false,
            };
            if to_i32 {
                out.push(Self::op1(cr, "llvm.bitcast", x, Type::int(32)));
                continue;
            }
            match &inner {
                Some((k, e @ (Type::Integer { width: 32, .. } | Type::Float(FloatKind::F64 | FloatKind::F32)))) => {
                    for idx in 0..*k as i64 {
                        let c = Self::c(cr, idx, 64);
                        out.push(cr.build(OpData::build("llvm.extractelement").operands(&[x, c]), e.clone()));
                    }
                }
                _ => out.push(x),
            }
        }
        out
    }

    /// `inferIntrinsicResultType`.
    fn intrinsic_result<'a>(t: &Type<'a>) -> Type<'a> {
        let Ok(LlvmType::Array(n, elem)) = LlvmType::try_from(t) else { return t.clone() };
        let n = n as usize;
        let v = |k: i64, e: Type<'static>| Type::vector(&[k], &[false], e);
        let f32t = Type::Float(FloatKind::F32);
        let f64t = Type::Float(FloatKind::F64);
        let e: Type<'a> = (*elem).clone();
        if e == v(2, Type::Float(FloatKind::F16)) {
            LlvmType::literal(vec![e; n])
        } else if e == v(2, Type::int(32)) {
            LlvmType::literal(vec![Type::int(32); n * 2])
        } else if e == v(2, f64t.clone()) {
            LlvmType::literal(vec![f64t.clone(), f64t])
        } else if e == v(2, f32t.clone()) {
            LlvmType::literal(vec![f32t; n * 2])
        } else if e == v(1, f32t.clone()) {
            LlvmType::literal(vec![f32t; n])
        } else {
            t.clone()
        }
    }

    /// `convertIntrinsicResult`: the intrinsic's struct repacked as the fragment array.
    fn intrinsic_to_fragment<'a>(cr: &mut Cr<'_, 'a, '_>, res_ty: &Type<'a>, r: ValueId) -> ValueId {
        let Ok(LlvmType::Array(_, elem)) = LlvmType::try_from(res_ty) else { return r };
        let elem: Type<'a> = (*elem).clone();
        let st = Self::ty(cr, r);
        let Ok(LlvmType::Struct { body: Some(body), .. }) = LlvmType::try_from(&st) else { return r };
        let members = body.len();
        let v = |k: i64, e: Type<'static>| Type::vector(&[k], &[false], e);
        let mut elements = Vec::new();
        if elem == v(2, Type::Float(FloatKind::F16)) || elem == v(1, Type::Float(FloatKind::F32)) {
            for i in 0..members as i64 {
                let x = cr.extract(r, &[i]);
                // `createOrFold` of a bitcast to its own type folds away.
                elements.push(if Self::ty(cr, x) == elem { x } else { Self::op1(cr, "llvm.bitcast", x, elem.clone()) });
            }
        }
        if elem == v(2, Type::int(32)) || elem == v(2, Type::Float(FloatKind::F64)) || elem == v(2, Type::Float(FloatKind::F32)) {
            for i in 0..(members / 2) as i64 {
                let mut vec = cr.poison(elem.clone());
                let x1 = cr.extract(r, &[i * 2]);
                let x2 = cr.extract(r, &[i * 2 + 1]);
                let c0 = Self::c(cr, 0, 32);
                vec = cr.build(OpData::build("llvm.insertelement").operands(&[vec, x1, c0]), elem.clone());
                let c1 = Self::c(cr, 1, 32);
                vec = cr.build(OpData::build("llvm.insertelement").operands(&[vec, x2, c1]), elem.clone());
                elements.push(vec);
            }
        }
        let mut out = cr.poison(res_ty.clone());
        for (i, e) in elements.into_iter().enumerate() {
            out = cr.insert_value(out, e, &[i as i64]);
        }
        out
    }

    /// `MmaLdMatrixOpToNVVM`.
    #[convert("nvgpu.ldmatrix")]
    fn ldmatrix(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let res = Self::ty(cr, cr.rw.body[op].results[0]);
        let (Some(dims), Some(final_ty)) = (res.dims(), cr.converted(&res)) else { return false };
        let inner = Type::vector(&[dims[1]], &[false], res.element_type().clone());
        let regs = dims[0];
        let ld_ty = if regs > 1 { LlvmType::literal(vec![Type::int(32); regs as usize]) } else { Type::int(32) };
        let Some(tiles) = Self::int(cr, op, "numTiles") else { return false };
        let transpose = Self::unit(cr, op, "transpose");
        let src = cr.rw.body[op].operands[0];
        let indices: Vec<ValueId> = Self::firsts(&operands[1..]);
        cr.rw.set_before(op);
        let Some(ptr) = Self::element_ptr(cr, o, src, operands[0][0], &indices) else { return false };
        let data = OpData::build("nvvm.ldmatrix")
            .operands(&[ptr])
            .with("num", Attribute::of_int(tiles.into(), Type::int(32)))
            .with("layout", Attribute::dialect("nvvm.mma_layout", if transpose { "<col>" } else { "<row>" }))
            .with("shape", Attribute::dialect("nvvm.ld_st_matrix_shape", "<m = 8, n = 8>"))
            .with("eltType", Attribute::dialect("nvvm.ld_st_matrix_elt_type", "<b16>"));
        let ld = cr.build(data, ld_ty);
        let mut out = cr.poison(final_ty);
        for i in 0..regs {
            let reg = if regs > 1 { cr.extract(ld, &[i]) } else { ld };
            let cast = Self::op1(cr, "llvm.bitcast", reg, inner.clone());
            out = cr.insert_value(out, cast, &[i]);
        }
        cr.replace(op, vec![vec![out]]);
        true
    }

    /// `mmaShape` as `[m, n, k]`.
    fn mma_shape(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<[i64; 3]> {
        let Some(Attribute::Array(a)) = cr.rw.body[op].get("mmaShape") else { return None };
        let v: Vec<i64> = a.iter().filter_map(|x| if let Attribute::Int { lit, .. } = x { lit.parse().ok() } else { None }).collect();
        v.try_into().ok()
    }

    /// The PTX types of an mma op: A, B, C, and the integer overflow mode.
    fn mma_types(cr: &Cr<'_, '_, '_>, op: OpId, b_from_a: bool) -> Option<(MmaType, MmaType, MmaType, bool)> {
        let ops = &cr.rw.body[op].operands;
        let (a, b, c) = (Self::ty(cr, ops[0]), Self::ty(cr, ops[if b_from_a { 0 } else { 1 }]), Self::ty(cr, ops[2]));
        if matches!(a.element_type(), Type::Float(FloatKind::F32)) && !Self::unit(cr, op, "tf32Enabled") {
            return None;
        }
        Some((MmaType::multiplicand(&a)?, MmaType::multiplicand(&b)?, MmaType::accumulator(c.element_type())?, matches!(a.element_type(), Type::Integer { .. })))
    }

    /// `MmaSyncOptoNVVM`.
    #[convert("nvgpu.mma.sync")]
    fn mma_sync(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        // Upstream reads B's type from A.
        let Some((pa, pb, pc, int)) = Self::mma_types(cr, op, true) else { return false };
        let Some([m, n, k]) = Self::mma_shape(cr, op) else { return false };
        let res = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(desired) = cr.converted(&res) else { return false };
        cr.rw.set_before(op);
        let a = Self::unpack(cr, operands[0][0], pa);
        let b = Self::unpack(cr, operands[1][0], pb);
        let c = Self::unpack(cr, operands[2][0], pc);
        let intrinsic = Self::intrinsic_result(&desired);
        let mut args = a.clone();
        args.extend(&b);
        args.extend(&c);
        let mut data = OpData::build("nvvm.mma.sync")
            .operands(&args)
            .with("shape", Attribute::dialect("nvvm.shape", &format!("<m = {m}, n = {n}, k = {k}>")))
            .with("layoutA", Attribute::dialect("nvvm.mma_layout", "<row>"))
            .with("layoutB", Attribute::dialect("nvvm.mma_layout", "<col>"))
            .with("multiplicandAPtxType", pa.into())
            .with("multiplicandBPtxType", pb.into())
            .segments(&[a.len(), b.len(), c.len()]);
        if int {
            data.set("intOverflowBehavior", Attribute::dialect("nvvm.mma_int_overflow", "<satfinite>"));
        }
        let r = cr.build(data, intrinsic);
        let r = Self::intrinsic_to_fragment(cr, &desired, r);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `buildMmaSparseAsmString`.
    fn sparse_asm(shape: [i64; 3], sizes: [usize; 3], [pa, pb, pc, pd]: [MmaType; 4], int: bool, selector: i64) -> String {
        let [m, n, k] = shape;
        let mut s = format!("mma.sp.sync.aligned.m{m}n{n}k{k}.row.col.");
        if int {
            s.push_str("satfinite.");
        }
        s.push_str(&format!("{}.{}.{}.{} ", pd.name(), pa.name(), pb.name(), pc.name()));
        let [na, nb, nc] = sizes;
        let mut arg = 0;
        for size in [nc, na, nb, nc] {
            s.push('{');
            for i in 0..size {
                s.push_str(&format!("${arg}{}", if i + 1 < size { "," } else { "" }));
                arg += 1;
            }
            s.push_str("},");
        }
        s.push_str(&format!("${arg},0x{selector};"));
        s
    }

    /// `NVGPUMmaSparseSyncLowering`: `mma.sp.sync` as inline PTX.
    #[convert("nvgpu.mma.sp.sync")]
    fn mma_sparse(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let Some((pa, pb, pc, int)) = Self::mma_types(cr, op, false) else { return false };
        let Some(shape) = Self::mma_shape(cr, op) else { return false };
        let selector = Self::int(cr, op, "sparsitySelector").unwrap_or(0);
        let res = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(desired) = cr.converted(&res) else { return false };
        if Self::ty(cr, operands[3][0]) != Type::vector(&[2], &[false], Type::int(16)) {
            return false;
        }
        cr.rw.set_before(op);
        let a = Self::unpack(cr, operands[0][0], pa);
        let b = Self::unpack(cr, operands[1][0], pb);
        let c = Self::unpack(cr, operands[2][0], pc);
        let intrinsic = Self::intrinsic_result(&desired);
        let meta = Self::op1(cr, "llvm.bitcast", operands[3][0], Type::int(32));
        let asm = Self::sparse_asm(shape, [a.len(), b.len(), c.len()], [pa, pb, pc, pc], int, selector);
        let mut constraints = String::new();
        for _ in 0..c.len() {
            constraints.push_str("=r,");
        }
        for _ in 0..a.len() + b.len() + c.len() {
            constraints.push_str("r,");
        }
        constraints.push('r');
        let mut args = a;
        args.extend(b);
        args.extend(c);
        args.push(meta);
        let data = OpData::build("llvm.inline_asm")
            .operands(&args)
            .with("asm_dialect", Attribute::i64(0))
            .with("asm_string", Attribute::str(&asm))
            .with("constraints", Attribute::str(&constraints))
            .with("has_side_effects", Attribute::Unit)
            .with("tail_call_kind", Attribute::dialect("llvm.tailcallkind", "<none>"));
        let r = cr.build(data, intrinsic);
        let r = Self::intrinsic_to_fragment(cr, &desired, r);
        cr.replace(op, vec![vec![r]]);
        true
    }

    // ---- async copies -----------------------------------------------------------------------

    /// `NVGPUAsyncCopyLowering`: `cp.async` into shared memory; the token is a dummy 0.
    #[convert("nvgpu.device_async_copy")]
    fn async_copy(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let g = Self::groups(cr, op, operands);
        let orig = cr.rw.body[op].operands.clone();
        let src_at = g[0].len() + g[1].len();
        let (Some(dst_s), Some(src_s)) = (Self::memref(cr, orig[0]), Self::memref(cr, orig[src_at])) else { return false };
        if o.address_space(&dst_s).is_none() || o.address_space(&src_s).is_none() {
            return false;
        }
        let Some(dst_elements) = Self::int(cr, op, "dstElements") else { return false };
        let (Some(dst_bits), Some(src_bits)) = (dst_s.elem.bit_width(), src_s.elem.bit_width()) else { return false };
        let size = i64::from(dst_bits) * dst_elements / 8;
        let bypass = Self::unit(cr, op, "bypassL1");
        cr.rw.set_before(op);
        let Some(dst) = Self::element_ptr(cr, o, orig[0], g[0][0][0], &Self::firsts(g[1])) else { return false };
        let Some(src) = Self::element_ptr(cr, o, orig[src_at], g[2][0][0], &Self::firsts(g[3])) else { return false };
        let src = Self::op1(cr, "llvm.addrspacecast", src, LlvmType::Ptr(1).into());
        let mut args = vec![dst, src];
        if let Some(n) = g.get(4).and_then(|e| e.first()).and_then(|v| v.first()).copied() {
            let c3 = Self::c(cr, 3, 32);
            let bits = Self::c(cr, i64::from(src_bits), 32);
            let n = cr.build(OpData::build("llvm.trunc").operands(&[n]).with("overflowFlags", Attribute::of_int(0, Type::int(32))), Type::int(32));
            let mul = Self::arith(cr, "llvm.mul", bits, n);
            args.push(Self::op2(cr, "llvm.lshr", mul, c3));
        }
        let modifier = if bypass && size == 16 { "<load_cache_modifier cg>" } else { "<load_cache_modifier ca>" };
        let data = OpData::build("nvvm.cp.async.shared.global").operands(&args).with("size", Attribute::of_int(size.into(), Type::int(32))).with("modifier", Attribute::dialect("nvvm", modifier));
        cr.rw.create(data, &[]);
        let zero = Self::c(cr, 0, 32);
        cr.replace(op, vec![vec![zero]]);
        true
    }

    /// `NVGPUAsyncCreateGroupLowering`.
    #[convert("nvgpu.device_async_create_group")]
    fn async_create_group(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        cr.rw.set_before(op);
        cr.rw.create(OpData::build("nvvm.cp.async.commit.group"), &[]);
        let zero = Self::c(cr, 0, 32);
        cr.replace(op, vec![vec![zero]]);
        true
    }

    /// `NVGPUAsyncWaitLowering`.
    #[convert("nvgpu.device_async_wait")]
    fn async_wait(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let n = Self::int(cr, op, "numGroups").unwrap_or(0);
        cr.rw.set_before(op);
        cr.rw.create(OpData::build("nvvm.cp.async.wait.group").with("n", Attribute::of_int(n.into(), Type::int(32))), &[]);
        cr.erase(op);
        true
    }

    // ---- mbarriers ----------------------------------------------------------------------------

    /// `NVGPUMBarrierCreateLowering`: a private `__mbarrier` global at the front of the module.
    #[convert("nvgpu.mbarrier.create")]
    fn mbarrier_create(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let res = cr.rw.body[op].results[0];
        let Some(NvgpuType::MbarrierGroup { shared, barriers }) = Self::nv(cr, res) else { return false };
        let ty = Type::Shaped(alloc::boxed::Box::new(NvgpuType::mbarrier_memref(shared, barriers)));
        let Some(func) = cr.rw.body.parent_op(op) else { return false };
        let body = &cr.rw.body;
        let mut m = func;
        let mut module = None;
        let mut gpu = None;
        while let Some(p) = body.parent_op(m) {
            if gpu.is_none() && body[p].name == "gpu.module" {
                gpu = Some(p);
            }
            if module.is_none() && body[p].name == "builtin.module" {
                module = Some(p);
            }
            m = p;
        }
        let Some(module) = gpu.or(module) else { return false };
        // `SymbolTable::insert` with a fresh table: `_0`, `_1`, … until unique.
        let mut name = String::from("__mbarrier");
        let mut k = 0;
        while cr.rw.body.lookup(module, &name).is_some() {
            name = format!("__mbarrier_{k}");
            k += 1;
        }
        let saved = cr.rw.ip;
        let block = cr.rw.body.top_block(module);
        cr.rw.set_start(block);
        let data = OpData::build("memref.global")
            .with("sym_name", Attribute::str(&name))
            .with("sym_visibility", Attribute::str("private"))
            .with("type", Attribute::Type(ty.clone()))
            .with("alignment", Attribute::of_int(8, Type::int(64)));
        let loc = cr.rw.body[func].loc.clone();
        let g = cr.rw.create(data, &[]);
        cr.rw.body[g].loc = loc;
        cr.rw.ip = saved;
        cr.replace_new(op, OpData::build("memref.get_global").with("name", Attribute::SymbolRef(vec![name.into()])), &[ty]);
        true
    }

    /// `NVGPUMBarrierGetLowering`.
    #[convert("nvgpu.mbarrier.get")]
    fn mbarrier_get(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        let res = Self::ty(cr, cr.rw.body[op].results[0]);
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[1][0]) else { return false };
        let r = Self::op1(cr, "llvm.ptrtoint", p, res);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `NVGPUMBarrierInitLowering`.
    #[convert("nvgpu.mbarrier.init")]
    fn mbarrier_init(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[2][0]) else { return false };
        let count = Self::trunc32(cr, operands[1][0]);
        let mut args = vec![p, count];
        args.extend(operands.get(3).and_then(|v| v.first()));
        cr.replace_new(op, OpData::build("nvvm.mbarrier.init").operands(&args), &[]);
        true
    }

    /// `NVGPUMBarrierArriveLowering`.
    #[convert("nvgpu.mbarrier.arrive")]
    fn mbarrier_arrive(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[1][0]) else { return false };
        let data = OpData::build("nvvm.mbarrier.arrive").operands(&[p]).with("scope", Self::mem_scope("cta")).with("relaxed", Attribute::Bool(false));
        cr.replace_new(op, data, &[Type::int(64)]);
        true
    }

    /// `NVGPUMBarrierArriveNoCompleteLowering`.
    #[convert("nvgpu.mbarrier.arrive.nocomplete")]
    fn mbarrier_arrive_nocomplete(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[1][0]) else { return false };
        let count = Self::trunc32(cr, operands[2][0]);
        cr.replace_new(op, OpData::build("nvvm.mbarrier.arrive.nocomplete").operands(&[p, count]), &[Type::int(64)]);
        true
    }

    /// `NVGPUMBarrierTestWaitLowering`.
    #[convert("nvgpu.mbarrier.test.wait")]
    fn mbarrier_test_wait(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[2][0]) else { return false };
        let data = OpData::build("nvvm.mbarrier.test.wait").operands(&[p, operands[1][0]]).with("scope", Self::mem_scope("cta")).with("relaxed", Attribute::Bool(false));
        cr.replace_new(op, data, &[Type::int(1)]);
        true
    }

    /// `NVGPUMBarrierArriveExpectTxLowering`.
    #[convert("nvgpu.mbarrier.arrive.expect_tx")]
    fn mbarrier_arrive_expect_tx(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[2][0]) else { return false };
        let tx = Self::trunc32(cr, operands[1][0]);
        let mut args = vec![p, tx];
        args.extend(operands.get(3).and_then(|v| v.first()));
        // (its builder gives it the i64 state result, unused, but with a predicate)
        let predicated = args.len() > 2;
        let data = OpData::build("nvvm.mbarrier.arrive.expect_tx").operands(&args).with("scope", Self::mem_scope("cta")).with("relaxed", Attribute::Bool(false));
        let types = if predicated { Vec::new() } else { vec![Type::int(64)] };
        cr.rw.create(data, &types);
        cr.erase(op);
        true
    }

    /// `NVGPUMBarrierTryWaitParityLowering`.
    #[convert("nvgpu.mbarrier.try_wait.parity")]
    fn mbarrier_try_wait_parity(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let group = cr.rw.body[op].operands[0];
        cr.rw.set_before(op);
        let Some(p) = Self::mbarrier_ptr(cr, o, group, operands[0][0], operands[3][0]) else { return false };
        let ticks = Self::trunc32(cr, operands[2][0]);
        let phase = Self::op1(cr, "llvm.zext", operands[1][0], Type::int(32));
        cr.replace_new(op, OpData::build("nvvm.mbarrier.try_wait.parity").operands(&[p, phase, ticks]), &[]);
        true
    }

    // ---- TMA ----------------------------------------------------------------------------------

    /// `NVGPUTmaAsyncLoadOpLowering`.
    #[convert("nvgpu.tma.async.load")]
    fn tma_load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let g = Self::groups(cr, op, operands);
        let orig = cr.rw.body[op].operands.clone();
        let (dst, bars, desc, coords, id) = (g[0][0][0], g[1][0][0], g[2][0][0], Self::firsts(g[3]), g[4][0][0]);
        let (mask, pred) = (Self::firsts(g[5]), Self::firsts(g[6]));
        cr.rw.set_before(op);
        let Some(dest) = Self::element_ptr(cr, o, orig[0], dst, &[]) else { return false };
        let dest = Self::op1(cr, "llvm.addrspacecast", dest, LlvmType::Ptr(7).into());
        let Some(bar) = Self::mbarrier_ptr(cr, o, orig[1], bars, id) else { return false };
        let coords: Vec<ValueId> = coords.into_iter().map(|c| Self::trunc32(cr, c)).collect();
        let mut args = vec![dest, desc];
        args.extend(&coords);
        args.push(bar);
        args.extend(&mask);
        args.extend(&pred);
        let data = OpData::build("nvvm.cp.async.bulk.tensor.shared.cluster.global")
            .operands(&args)
            .with("mode", Attribute::dialect("nvvm.tma_load_mode", "<tile>"))
            .with("isCTAOnly", Attribute::Bool(false))
            .segments(&[1, 1, coords.len(), 1, 0, mask.len(), 0, pred.len()]);
        cr.replace_new(op, data, &[]);
        true
    }

    /// `NVGPUTmaAsyncStoreOpLowering`.
    #[convert("nvgpu.tma.async.store")]
    fn tma_store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let g = Self::groups(cr, op, operands);
        let orig = cr.rw.body[op].operands.clone();
        let (src, desc, coords, pred) = (g[0][0][0], g[1][0][0], Self::firsts(g[2]), Self::firsts(g[3]));
        cr.rw.set_before(op);
        let Some(src) = Self::element_ptr(cr, o, orig[0], src, &[]) else { return false };
        let coords: Vec<ValueId> = coords.into_iter().map(|c| Self::trunc32(cr, c)).collect();
        let mut args = vec![desc, src];
        args.extend(&coords);
        args.extend(&pred);
        let data = OpData::build("nvvm.cp.async.bulk.tensor.global.shared.cta")
            .operands(&args)
            .with("mode", Attribute::dialect("nvvm.tma_store_mode", "<tile>"))
            .segments(&[1, 1, coords.len(), 0, pred.len()]);
        cr.replace_new(op, data, &[]);
        true
    }

    /// `NVGPUTmaCreateDescriptorOpLowering`: `mgpuTensorMapEncodeTiledMemref` on the host.
    #[convert("nvgpu.tma.create.descriptor")]
    fn tma_create_descriptor(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let (tensor, res) = (cr.rw.body[op].operands[0], cr.rw.body[op].results[0]);
        let Some(data_type) = tensor_map_data_type(Self::ty(cr, tensor).element_type()) else { return false };
        let Some(NvgpuType::TensorMap { swizzle, l2promo, oob, interleave, .. }) = Self::nv(cr, res) else { return false };
        let ptr: Type<'_> = LlvmType::ptr();
        cr.rw.set_before(op);
        let elem = Self::c64(cr, data_type);
        // `promoteOperands`: an unranked descriptor as its rank and pointer.
        let desc = operands[0][0];
        let rank = cr.extract(desc, &[0]);
        let dptr = cr.extract(desc, &[1]);
        let five = Self::c64(cr, 5);
        let boxes = cr.build(OpData::build("llvm.alloca").operands(&[five]).with("elem_type", Attribute::Type(Type::int(64))), ptr.clone());
        for (i, v) in Self::firsts(&operands[1..]).into_iter().enumerate() {
            let idx = Self::c64(cr, i as i64);
            let gep = MemrefToLlvm::gep(cr, ptr.clone(), ptr.clone(), boxes, &[crate::LlvmGep::V(idx)], 0);
            cr.rw.create(OpData::build("llvm.store").operands(&[v, gep]).with("ordering", Attribute::i64(0)), &[]);
        }
        let mut args = vec![rank, dptr, elem];
        for v in [interleave, swizzle as i64, l2promo, oob] {
            args.push(Self::c64(cr, v));
        }
        args.push(boxes);
        let name = "mgpuTensorMapEncodeTiledMemref";
        let Some(module) = cr.rw.body.parent_op(op).and_then(|f| Self::enclosing_module(cr, f)) else { return false };
        if cr.rw.body.lookup(module, name).is_none() {
            let i64t = Type::int(64);
            let fty: Type<'_> = LlvmType::Func { ret: ptr.clone().into(), params: vec![i64t.clone(), ptr.clone(), i64t.clone(), i64t.clone(), i64t.clone(), i64t.clone(), i64t, ptr.clone()], vararg: false }.into();
            let saved = cr.rw.ip;
            let block = cr.rw.body.top_block(module);
            cr.rw.set_end(block);
            let data = OpData::build("llvm.func").with("function_type", Attribute::Type(fty)).with("sym_name", Attribute::str(name));
            cr.rw.create_with(data, &[], |b, f| {
                b.add_region(f);
            });
            cr.rw.ip = saved;
        }
        let call = cr.llvm_call(name, &args, &[ptr]);
        let r = cr.rw.body[call].results[0];
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// The `builtin.module` around `op`.
    fn enclosing_module(cr: &Cr<'_, '_, '_>, mut op: OpId) -> Option<OpId> {
        let body = &cr.rw.body;
        loop {
            if body[op].name == "builtin.module" {
                return Some(op);
            }
            op = body.parent_op(op)?;
        }
    }

    /// `NVGPUTmaFenceOpLowering`.
    #[convert("nvgpu.tma.fence.descriptor")]
    fn tma_fence(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        cr.rw.set_before(op);
        let size = Self::c(cr, 128, 32);
        let data = OpData::build("nvvm.fence.proxy.acquire")
            .operands(&[operands[0][0], size])
            .with("scope", Self::mem_scope("sys"))
            .with("fromProxy", Attribute::dialect("nvvm.proxy_kind", "<generic>"))
            .with("toProxy", Attribute::dialect("nvvm.proxy_kind", "<tensormap>"));
        cr.replace_new(op, data, &[]);
        true
    }

    /// `NVGPUTmaPrefetchOpLowering`.
    #[convert("nvgpu.tma.prefetch.descriptor")]
    fn tma_prefetch(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let args: Vec<ValueId> = operands.iter().filter_map(|v| v.first().copied()).collect();
        cr.replace_new(op, OpData::build("nvvm.prefetch").operands(&args).with("tensormap", Attribute::Unit), &[]);
        true
    }

    // ---- warpgroup ----------------------------------------------------------------------------

    /// `NVGPUGenerateWarpgroupDescriptorLowering`.
    #[convert("nvgpu.warpgroup.generate.descriptor")]
    fn warpgroup_descriptor(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let (tensor, map) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let Some(NvgpuType::TensorMap { swizzle, tensor: mt, .. }) = Self::nv(cr, map) else { return false };
        let (layout, sw): (i64, i64) = match swizzle {
            Swizzle::B128 => (128, 1),
            Swizzle::B64 => (64, 2),
            Swizzle::B32 => (32, 3),
            Swizzle::None => (1, 0),
        };
        let Some(size_n) = mt.dims().and_then(|d| d.first().copied()) else { return false };
        cr.rw.set_before(op);
        let k = |cr: &mut Cr<'_, '_, '_>, v: i64| cr.llvm_constant(Attribute::of_int(v.into(), Type::int(64)), Type::int(64));
        let stride = k(cr, (layout << 3) >> EXCLUDE_4LSB);
        let lead = k(cr, (size_n * layout) >> EXCLUDE_4LSB);
        let Some(base) = Self::element_ptr(cr, o, tensor, operands[0][0], &[]) else { return false };
        let base = Self::op1(cr, "llvm.ptrtoint", base, Type::int(64));
        let shl = |cr: &mut Cr<'_, '_, '_>, v: ValueId, s: i64| {
            let c = k(cr, s);
            Self::arith(cr, "llvm.shl", v, c)
        };
        let t = shl(cr, base, 46);
        let c50 = k(cr, 50);
        let base14 = Self::op2(cr, "llvm.lshr", t, c50);
        let mut dsc = k(cr, 0);
        let fields = [(None, sw, 62), (None, 0, 49), (Some(stride), 0, 32), (Some(lead), 0, 16), (Some(base14), 0, 0)];
        for (v, c, bit) in fields {
            let v = match v {
                Some(v) => v,
                None => k(cr, c),
            };
            let s = shl(cr, v, bit);
            dsc = Self::op2(cr, "llvm.or", dsc, s);
        }
        cr.replace(op, vec![vec![dsc]]);
        true
    }

    /// The tensor memref type of a `!nvgpu.warpgroup.descriptor` operand.
    fn wg_tensor(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<Type<'static>> {
        match Self::nv(cr, v)? {
            NvgpuType::WarpgroupDescriptor { tensor } => Some(tensor),
            _ => None,
        }
    }

    /// `NVGPUWarpgroupMmaOpLowering` (`WarpgroupGemm`).
    #[convert("nvgpu.warpgroup.mma")]
    fn warpgroup_mma(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let orig = cr.rw.body[op].operands.clone();
        let (Some(ta), Some(tb)) = (Self::wg_tensor(cr, orig[0]), Self::wg_tensor(cr, orig[1])) else { return false };
        let Some(NvgpuType::WarpgroupAccumulator { fragmented }) = Self::nv(cr, orig[2]) else { return false };
        let (Some(da), Some(db)) = (ta.dims(), tb.dims()) else { return false };
        let (ea, eb, ed) = (ta.element_type().clone(), tb.element_type().clone(), fragmented.element_type().clone());
        let (total_m, total_n, total_k) = (da[0], db[1], da[1]);
        let wk: i64 = match &ea {
            Type::Float(FloatKind::TF32) => 8,
            Type::Float(FloatKind::F16 | FloatKind::BF16) => 16,
            Type::Float(FloatKind::F8E4M3FN | FloatKind::F8E5M2) | Type::Integer { width: 16, .. } => 32,
            Type::Integer { width: 1, .. } => 256,
            _ => return false,
        };
        let (wm, wn) = (64, total_n);
        let (it_m, it_n, it_k) = (total_m / wm, total_n / wn, total_k / wk);
        let (Some(type_a), Some(type_b), Some(type_d)) = (wgmma_type(&ea, false), wgmma_type(&eb, false), wgmma_type(&ed, true)) else { return false };
        let (Some(ba), Some(bb)) = (ea.bit_width(), eb.bit_width()) else { return false };
        let (byte_a, byte_b) = (i64::from(ba / 8), i64::from(bb / 8));
        let layout = |t: bool| Attribute::dialect("nvvm.mma_layout", if t { "<col>" } else { "<row>" });
        let (lay_a, lay_b) = (layout(Self::unit(cr, op, "transposeA")), layout(!Self::unit(cr, op, "transposeB")));
        let wait = Self::int(cr, op, "waitGroup").unwrap_or(1);
        let (desc_a, desc_b, mat_c) = (operands[0][0], operands[1][0], operands[2][0]);
        cr.rw.set_before(op);
        cr.rw.create(OpData::build("nvvm.wgmma.fence.aligned"), &[]);
        let c_ty = Self::ty(cr, mat_c);
        let mut result = cr.poison(c_ty.clone());
        let mut results = Vec::new();
        for i in 0..it_m {
            let mut c = cr.extract(mat_c, &[i]);
            for _j in 0..it_n {
                for k in 0..it_k {
                    let inc_a = (((wk * k) + (total_k * da[1] * i)) * byte_a) >> EXCLUDE_4LSB;
                    let a = if inc_a == 0 {
                        desc_a
                    } else {
                        let v = Self::c64(cr, inc_a);
                        Self::arith(cr, "llvm.add", desc_a, v)
                    };
                    let inc_b = (db[0] * wk * k * byte_b) >> EXCLUDE_4LSB;
                    let b = if inc_b == 0 {
                        desc_b
                    } else {
                        let v = Self::c64(cr, inc_b);
                        Self::arith(cr, "llvm.add", desc_b, v)
                    };
                    let t = Self::ty(cr, c);
                    let data = OpData::build("nvvm.wgmma.mma_async")
                        .operands(&[c, a, b])
                        .with("shape", Attribute::dialect("nvvm.shape", &format!("<m = {wm}, n = {wn}, k = {wk}>")))
                        .with("typeA", Attribute::dialect("nvvm.wgmma_type", &format!("<{type_a}>")))
                        .with("typeB", Attribute::dialect("nvvm.wgmma_type", &format!("<{type_b}>")))
                        .with("typeD", Attribute::dialect("nvvm.wgmma_type", &format!("<{type_d}>")))
                        .with("scaleD", Attribute::dialect("nvvm.wgmma_scale_out", "<one>"))
                        .with("scaleA", Attribute::dialect("nvvm.wgmma_scale_in", "<one>"))
                        .with("scaleB", Attribute::dialect("nvvm.wgmma_scale_in", "<one>"))
                        .with("layoutA", lay_a.clone())
                        .with("layoutB", lay_b.clone())
                        .with("satfinite", Attribute::dialect("nvvm.mma_int_overflow", "<wrapped>"));
                    c = cr.build(data, t);
                }
            }
            results.push(c);
        }
        for (i, r) in results.into_iter().enumerate() {
            result = cr.insert_value(result, r, &[i as i64]);
        }
        cr.rw.create(OpData::build("nvvm.wgmma.commit.group.sync.aligned"), &[]);
        cr.rw.create(OpData::build("nvvm.wgmma.wait.group.sync.aligned").with("group", Attribute::of_int(wait.into(), Type::int(64))), &[]);
        cr.replace(op, vec![vec![result]]);
        true
    }

    /// `storeFragmentedMatrix`: one 64-row block of the accumulator into `memref` at row `offset`.
    fn store_fragment(cr: &mut Cr<'_, '_, '_>, d: ValueId, memref: ValueId, offset: i64) {
        let i32t = Type::int(32);
        let k = |cr: &mut Cr<'_, '_, '_>, v: i64| Self::c(cr, v, 32);
        let (c1, c2, c4, c8, c16, warp) = (k(cr, 1), k(cr, 2), k(cr, 4), k(cr, 8), k(cr, 16), k(cr, WARP_SIZE));
        let tid = cr.build(OpData::build("nvvm.read.ptx.sreg.tid.x"), i32t);
        let lane = Self::op2(cr, "llvm.urem", tid, warp);
        let warp_id = Self::op2(cr, "llvm.udiv", tid, warp);
        let lane4 = Self::op2(cr, "llvm.udiv", lane, c4);
        let lane4mod = Self::op2(cr, "llvm.urem", lane, c4);
        let tj = Self::arith(cr, "llvm.mul", lane4mod, c2);
        let wm = Self::arith(cr, "llvm.mul", warp_id, c16);
        let mut ti = Self::arith(cr, "llvm.add", lane4, wm);
        if offset != 0 {
            let o = k(cr, offset);
            ti = Self::arith(cr, "llvm.add", ti, o);
        }
        let members = match LlvmType::try_from(&Self::ty(cr, d)) {
            Ok(LlvmType::Struct { body: Some(b), .. }) => b.len(),
            _ => 0,
        };
        let stores = members / 4;
        let index_cast = |cr: &mut Cr<'_, '_, '_>, v: ValueId| cr.build(OpData::build("arith.index_cast").operands(&[v]), Type::Index);
        for i in 0..2 {
            let ci = k(cr, i as i64);
            let m = Self::arith(cr, "llvm.mul", ci, c8);
            let idx = Self::arith(cr, "llvm.add", ti, m);
            for j in 0..stores {
                let cj = k(cr, j as i64);
                let m = Self::arith(cr, "llvm.mul", cj, c8);
                let idy = Self::arith(cr, "llvm.add", tj, m);
                let at = (i * 2 + j * 4) as i64;
                let x = index_cast(cr, idx);
                let y0 = index_cast(cr, idy);
                let y1 = Self::arith(cr, "llvm.add", idy, c1);
                let y1 = index_cast(cr, y1);
                let d0 = cr.extract(d, &[at]);
                let d1 = cr.extract(d, &[at + 1]);
                for (v, y) in [(d0, y0), (d1, y1)] {
                    cr.rw.create(OpData::build("memref.store").operands(&[v, memref, x, y]).with("nontemporal", Attribute::Bool(false)), &[]);
                }
            }
        }
    }

    /// `NVGPUWarpgroupMmaStoreOpLowering`.
    #[convert("nvgpu.warpgroup.mma.store")]
    fn warpgroup_store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let d = operands[0][0];
        let memref = cr.rw.body[op].operands[1];
        let Ok(LlvmType::Struct { body: Some(blocks), .. }) = LlvmType::try_from(&Self::ty(cr, d)) else { return false };
        let sizes: Vec<usize> = blocks.iter().map(|b| match LlvmType::try_from(b) {
            Ok(LlvmType::Struct { body: Some(m), .. }) => m.len(),
            _ => 0,
        }).collect();
        cr.rw.set_before(op);
        let mut offset = 0;
        for (i, n) in sizes.into_iter().enumerate() {
            let inner = cr.extract(d, &[i as i64]);
            Self::store_fragment(cr, inner, memref, offset);
            offset += n as i64;
        }
        cr.erase(op);
        true
    }

    /// `NVGPUWarpgroupMmaInitAccumulatorOpLowering`: an all-zero accumulator.
    #[convert("nvgpu.warpgroup.mma.init.accumulator")]
    fn warpgroup_init(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let res = Self::ty(cr, cr.rw.body[op].results[0]);
        let Some(pack) = cr.converted(&res) else { return false };
        let Ok(LlvmType::Struct { body: Some(blocks), .. }) = LlvmType::try_from(&pack) else { return false };
        let blocks: Vec<Type<'_>> = blocks.to_vec();
        let Some(Ok(LlvmType::Struct { body: Some(m), .. })) = blocks.first().map(LlvmType::try_from) else { return false };
        let Some(elem) = m.first().cloned() else { return false };
        let zero_attr = match &elem {
            Type::Float(_) => Attribute::Float { lit: "0.000000e+00".into(), ty: Some(elem.clone()) },
            _ => Attribute::of_int(0, elem.clone()),
        };
        cr.rw.set_before(op);
        let zero = cr.llvm_constant(zero_attr, elem);
        let mut packed = cr.poison(pack);
        let mut inner = Vec::new();
        for (i, b) in blocks.iter().enumerate() {
            let n = match LlvmType::try_from(b) {
                Ok(LlvmType::Struct { body: Some(m), .. }) => m.len(),
                _ => 0,
            };
            let mut s = cr.extract(packed, &[i as i64]);
            for k in 0..n {
                s = cr.insert_value(s, zero, &[k as i64]);
            }
            inner.push(s);
        }
        for (i, s) in inner.into_iter().enumerate() {
            packed = cr.insert_value(packed, s, &[i as i64]);
        }
        cr.replace(op, vec![vec![packed]]);
        true
    }

    // The canonicalizations come before the lowerings: upstream's legalization graph tries the
    // pattern added last first among equals.
    /// `NVGPUTruncfCanonicalizePattern`.
    #[rewrite("nvgpu.truncf", name = "NvgpuTruncfCanonicalize")]
    fn truncf_canonicalize(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        Self::canonicalize_fp(rw, op, true)
    }

    /// `NVGPUExtfCanonicalizePattern`.
    #[rewrite("nvgpu.extf", name = "NvgpuExtfCanonicalize")]
    fn extf_canonicalize(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        Self::canonicalize_fp(rw, op, false)
    }

    /// `NVGPUTruncfOpLowering`.
    #[convert("nvgpu.truncf")]
    fn truncf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let random = operands.get(1).and_then(|g| g.first().copied());
        Self::lower_truncf(cr, op, operands[0][0], random)
    }

    /// `NVGPUExtfOpLowering`.
    #[convert("nvgpu.extf")]
    fn extf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        Self::lower_extf(cr, op, operands[0][0])
    }

    /// `rcp.approx.ftz.f` of each element of the 1-D vector `v`.
    fn rcp_1d<'a>(cr: &mut Cr<'_, 'a, '_>, t: Type<'a>, v: ValueId) -> ValueId {
        let n = t.element_count().unwrap_or(0);
        let mut out = cr.poison(t.clone());
        for i in 0..n as i64 {
            let idx = Self::c(cr, i, 64);
            let e = cr.build(OpData::build("llvm.extractelement").operands(&[v, idx]), Type::Float(FloatKind::F32));
            let r = cr.build(OpData::build("nvvm.rcp.approx.ftz.f").operands(&[e]), Type::Float(FloatKind::F32));
            out = cr.build(OpData::build("llvm.insertelement").operands(&[out, r, idx]), t.clone());
        }
        out
    }

    /// `NVGPURcpOpLowering`: `rcp.approx.ftz.f` of each element.
    #[convert("nvgpu.rcp")]
    fn rcp(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let src = operands[0][0];
        let in_ty = Self::ty(cr, cr.rw.body[op].operands[0]);
        cr.rw.set_before(op);
        if in_ty.dims().is_some_and(|d| d.len() == 1) {
            let r = Self::rcp_1d(cr, in_ty, src);
            cr.replace(op, vec![vec![r]]);
            return true;
        }
        cr.unroll_vectors(op, &[src], |cr, t, pieces| Self::rcp_1d(cr, t, pieces[0]))
    }
}
