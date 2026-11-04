//! `gpu` ⇒ `nvvm`, as `LowerGpuOpsToNVVMOps.cpp`: launch configuration as the PTX special
//! registers, shuffles as `nvvm.shfl.sync`, `gpu.barrier` as `nvvm.barrier0`, math as libdevice
//! calls (`populateLibDeviceConversionPatterns`).

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Type};

use super::attrs::{Dimension, ShuffleMode};
use super::libcall::LibFns;
use crate::patterns;
use crate::{ConversionRewriter, LlvmOptions, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kWarpSize`.
const WARP: i64 = 32;

/// `IndexKind`: which known size bounds an index op.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum IndexKind {
    Other,
    Block,
    Grid,
    Cluster,
}

impl IndexKind {
    /// The function attribute (`gpu.known_*_size`) and the `gpu.func` property.
    const fn known(self) -> Option<(&'static str, &'static str)> {
        match self {
            IndexKind::Block => Some(("gpu.known_block_size", "known_block_size")),
            IndexKind::Grid => Some(("gpu.known_grid_size", "known_grid_size")),
            IndexKind::Cluster => Some(("gpu.known_cluster_size", "known_cluster_size")),
            IndexKind::Other => None,
        }
    }
}

/// The libdevice functions of each op (`populateLibDeviceConversionPatterns`).
const LIBDEVICE: [(&str, LibFns); 41] = [
    ("arith.remf", LibFns::float("__nv_fmodf", "__nv_fmod")),
    ("arith.maxnumf", LibFns::float("__nv_fmaxf", "__nv_fmax")),
    ("arith.minnumf", LibFns::float("__nv_fminf", "__nv_fmin")),
    ("math.absi", LibFns::int("__nv_abs")),
    ("math.absf", LibFns::float("__nv_fabsf", "__nv_fabs")),
    ("math.acos", LibFns::float("__nv_acosf", "__nv_acos")),
    ("math.acosh", LibFns::float("__nv_acoshf", "__nv_acosh")),
    ("math.asin", LibFns::float("__nv_asinf", "__nv_asin")),
    ("math.asinh", LibFns::float("__nv_asinhf", "__nv_asinh")),
    ("math.atan", LibFns::float("__nv_atanf", "__nv_atan")),
    ("math.atan2", LibFns::float("__nv_atan2f", "__nv_atan2")),
    ("math.atanh", LibFns::float("__nv_atanhf", "__nv_atanh")),
    ("math.cbrt", LibFns::float("__nv_cbrtf", "__nv_cbrt")),
    ("math.ceil", LibFns::float("__nv_ceilf", "__nv_ceil")),
    ("math.copysign", LibFns::float("__nv_copysignf", "__nv_copysign")),
    ("math.cos", LibFns::approx("__nv_cosf", "__nv_cos", "__nv_fast_cosf")),
    ("math.cosh", LibFns::float("__nv_coshf", "__nv_cosh")),
    ("math.erf", LibFns::float("__nv_erff", "__nv_erf")),
    ("math.erfc", LibFns::float("__nv_erfcf", "__nv_erfc")),
    ("math.exp", LibFns::approx("__nv_expf", "__nv_exp", "__nv_fast_expf")),
    ("math.exp2", LibFns::float("__nv_exp2f", "__nv_exp2")),
    ("math.expm1", LibFns::float("__nv_expm1f", "__nv_expm1")),
    ("math.floor", LibFns::float("__nv_floorf", "__nv_floor")),
    ("math.fma", LibFns::float("__nv_fmaf", "__nv_fma")),
    ("math.isfinite", LibFns::float("__nv_finitef", "__nv_isfinited")),
    ("math.isinf", LibFns::float("__nv_isinff", "__nv_isinfd")),
    ("math.isnan", LibFns::float("__nv_isnanf", "__nv_isnand")),
    ("math.log", LibFns::approx("__nv_logf", "__nv_log", "__nv_fast_logf")),
    ("math.log10", LibFns::approx("__nv_log10f", "__nv_log10", "__nv_fast_log10f")),
    ("math.log1p", LibFns::float("__nv_log1pf", "__nv_log1p")),
    ("math.log2", LibFns::approx("__nv_log2f", "__nv_log2", "__nv_fast_log2f")),
    ("math.powf", LibFns::approx("__nv_powf", "__nv_pow", "__nv_fast_powf")),
    ("math.fpowi", LibFns::float("__nv_powif", "__nv_powi")),
    ("math.round", LibFns::float("__nv_roundf", "__nv_round")),
    ("math.roundeven", LibFns::float("__nv_rintf", "__nv_rint")),
    ("math.rsqrt", LibFns::float("__nv_rsqrtf", "__nv_rsqrt")),
    ("math.sin", LibFns::approx("__nv_sinf", "__nv_sin", "__nv_fast_sinf")),
    ("math.sinh", LibFns::float("__nv_sinhf", "__nv_sinh")),
    ("math.sqrt", LibFns::float("__nv_sqrtf", "__nv_sqrt")),
    ("math.tan", LibFns::approx("__nv_tanf", "__nv_tan", "__nv_fast_tanf")),
    ("math.tanh", LibFns::float("__nv_tanhf", "__nv_tanh")),
];

/// The gpu ⇒ nvvm patterns (`populateGpuToNVVMConversionPatterns`, but `gpu.func` /
/// `gpu.return` / `gpu.printf`: [`GpuToLlvm`](crate::GpuToLlvm)).
pub struct GpuToNvvm;

#[patterns(converter, options = LlvmOptions)]
impl GpuToNvvm {
    /// The index type's width: the result sign-extended or truncated from `i32`.
    fn fit(cr: &mut Cr<'_, '_, '_>, v: ValueId, o: LlvmOptions) -> ValueId {
        match o.index_bitwidth {
            32 => v,
            w if w > 32 => cr.build(OpData::build("llvm.sext").operands(&[v]), Type::int(w)),
            w => cr.build(OpData::build("llvm.trunc").operands(&[v]), Type::int(w)),
        }
    }

    fn range<'a>(lo: i64, hi: i64) -> Attribute<'a> {
        Attribute::dialect("llvm.constant_range", &format!("<i32, {lo}, {hi}>"))
    }

    /// The known size bound of `kind` on the function around `op`, in dimension `d`.
    fn known_bound(cr: &Cr<'_, '_, '_>, op: OpId, kind: IndexKind, d: Dimension) -> Option<i64> {
        let (attr, prop) = kind.known()?;
        let f = cr.parent_function(op)?;
        let b = &*cr.rw.body;
        let a = if b[f].name == "gpu.func" { b[f].get(prop) } else { b[f].get(attr) }?;
        a.dense_values()?.get(d as usize).copied()
    }

    /// `gpu::index_lowering::OpLowering`: `nvvm.read.ptx.sreg.<reg>.<dim>`, ranged by a known
    /// bound.
    fn index(cr: &mut Cr<'_, '_, '_>, op: OpId, o: LlvmOptions, reg: &str, kind: IndexKind, dim: bool) -> bool {
        let Some(d) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        let axis = ["x", "y", "z"][d as usize];
        let mut bound = Self::known_bound(cr, op, kind, d);
        if let Some(Attribute::Int { lit, .. }) = cr.rw.body[op].get("upper_bound") {
            bound = lit.parse().ok();
        }
        let mut data = OpData::build(&format!("nvvm.read.ptx.sreg.{reg}.{axis}"));
        if let Some(ub) = bound {
            let hi = if ub == i64::from(i32::MAX) { ub } else { ub + i64::from(dim) };
            data.set("range", Self::range(i64::from(dim), hi));
        }
        cr.rw.set_before(op);
        let r = cr.build(data, Type::int(32));
        let r = Self::fit(cr, r, o);
        cr.replace(op, vec![vec![r]]);
        true
    }

    #[convert("gpu.thread_id", benefit = 10)]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "tid", IndexKind::Block, false)
    }

    #[convert("gpu.block_dim", benefit = 10)]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "ntid", IndexKind::Block, true)
    }

    #[convert("gpu.cluster_id", benefit = 10)]
    fn cluster_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "clusterid", IndexKind::Other, false)
    }

    #[convert("gpu.cluster_dim", benefit = 10)]
    fn cluster_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "nclusterid", IndexKind::Other, true)
    }

    #[convert("gpu.cluster_block_id", benefit = 10)]
    fn cluster_block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "cluster.ctaid", IndexKind::Cluster, false)
    }

    #[convert("gpu.cluster_dim_blocks", benefit = 10)]
    fn cluster_dim_blocks(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "cluster.nctaid", IndexKind::Cluster, true)
    }

    #[convert("gpu.block_id", benefit = 10)]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "ctaid", IndexKind::Grid, false)
    }

    #[convert("gpu.grid_dim", benefit = 10)]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::index(cr, op, o, "nctaid", IndexKind::Grid, true)
    }

    /// `GPULaneIdOpToNVVM`.
    #[convert("gpu.lane_id", benefit = 10)]
    fn lane_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let ub = match cr.rw.body[op].get("upper_bound") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(WARP),
            _ => WARP,
        };
        cr.rw.set_before(op);
        let r = cr.build(OpData::build("nvvm.read.ptx.sreg.laneid").with("range", Self::range(0, ub)), Type::int(32));
        let r = Self::fit(cr, r, o);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `GPUShuffleOpLowering`: `nvvm.shfl.sync` over the lanes `width` keeps active.
    #[convert("gpu.shuffle", benefit = 10)]
    fn shuffle(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let Some(mode) = cr.rw.body[op].get("mode").and_then(|a| ShuffleMode::try_from(a).ok()) else { return false };
        let (value, offset, width) = (operands[0][0], operands[1][0], operands[2][0]);
        let vty = cr.rw.body[value].ty.clone();
        cr.rw.set_before(op);
        let c = |cr: &mut Cr<'_, '_, '_>, v: i64| cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32));
        let one = c(cr, 1);
        let minus_one = c(cr, -1);
        let thirty_two = c(cr, 32);
        let bin = |cr: &mut Cr<'_, '_, '_>, n: &str, a: ValueId, b: ValueId| cr.build(OpData::build(n).operands(&[a, b]), Type::int(32));
        let inactive = bin(cr, "llvm.sub", thirty_two, width);
        let active = bin(cr, "llvm.lshr", minus_one, inactive);
        let clamp = if mode == ShuffleMode::Up { inactive } else { bin(cr, "llvm.sub", width, one) };
        let pred_used = !cr.rw.body[cr.rw.body[op].results[1]].uses.is_empty();
        let kind = match mode {
            ShuffleMode::Xor => "bfly",
            ShuffleMode::Up => "up",
            ShuffleMode::Down => "down",
            ShuffleMode::Idx => "idx",
        };
        let mut data = OpData::build("nvvm.shfl.sync").operands(&[active, value, offset, clamp]).with("kind", Attribute::dialect("nvvm", &format!("<shfl_kind {kind}>")));
        let rty = if pred_used {
            data.set("return_value_and_is_valid", Attribute::Unit);
            LlvmType::literal(vec![vty.clone(), Type::int(1)])
        } else {
            vty
        };
        let s = cr.build(data, rty);
        if pred_used {
            let v = cr.extract(s, &[0]);
            let p = cr.extract(s, &[1]);
            cr.replace(op, vec![vec![v], vec![p]]);
        } else {
            cr.replace(op, vec![vec![s], Vec::new()]);
        }
        true
    }

    /// `gpu.barrier` ⇒ `nvvm.barrier0` (`GPUToNVVM.td`).
    #[convert("gpu.barrier", benefit = 10)]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        cr.replace_new(op, OpData::build("nvvm.barrier0"), &[]);
        true
    }

    /// `OpToFuncCallLowering` with `ScalarizeVectorOpLowering`, as libdevice calls.
    #[convert("arith.remf", "arith.maxnumf", "arith.minnumf", "math.absi", "math.absf", "math.acos", "math.acosh", "math.asin", "math.asinh", "math.atan", "math.atan2", "math.atanh", "math.cbrt", "math.ceil", "math.copysign", "math.cos", "math.cosh", "math.erf", "math.erfc", "math.exp", "math.exp2", "math.expm1", "math.floor", "math.fma", "math.isfinite", "math.isinf", "math.isnan", "math.log", "math.log10", "math.log1p", "math.log2", "math.powf", "math.fpowi", "math.round", "math.roundeven", "math.rsqrt", "math.sin", "math.sinh", "math.sqrt", "math.tan", "math.tanh", benefit = 10)]
    fn libdevice(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let name = cr.rw.body[op].name.clone();
        let Some((_, fns)) = LIBDEVICE.iter().find(|(n, _)| **n == *name) else { return false };
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.lib_call(op, &ops, fns)
    }
}
