//! `gpu` ⇒ `nvvm`, as `LowerGpuOpsToNVVMOps.cpp`: launch configuration as the PTX special
//! registers, shuffles as `nvvm.shfl.sync`, `gpu.barrier` as `nvvm.barrier0`, math as libdevice
//! calls (`populateLibDeviceConversionPatterns`).

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Type};

use super::attrs::{AllReduceOp, ShuffleMode};
use super::index::IndexKind;
use crate::LibFns;
use crate::patterns;
use crate::{ConversionRewriter, LlvmOptions, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kWarpSize`.
const WARP: i64 = 32;

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
    #[convert("gpu.thread_id", benefit = 10)]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.tid", IndexKind::Block, false)
    }

    #[convert("gpu.block_dim", benefit = 10)]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.ntid", IndexKind::Block, true)
    }

    #[convert("gpu.cluster_id", benefit = 10)]
    fn cluster_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.clusterid", IndexKind::Other, false)
    }

    #[convert("gpu.cluster_dim", benefit = 10)]
    fn cluster_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.nclusterid", IndexKind::Other, true)
    }

    #[convert("gpu.cluster_block_id", benefit = 10)]
    fn cluster_block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.cluster.ctaid", IndexKind::Cluster, false)
    }

    #[convert("gpu.cluster_dim_blocks", benefit = 10)]
    fn cluster_dim_blocks(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.cluster.nctaid", IndexKind::Cluster, true)
    }

    #[convert("gpu.block_id", benefit = 10)]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.ctaid", IndexKind::Grid, false)
    }

    #[convert("gpu.grid_dim", benefit = 10)]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        cr.gpu_index(op, o, "nvvm.read.ptx.sreg.nctaid", IndexKind::Grid, true)
    }

    /// `GPULaneIdOpToNVVM`.
    #[convert("gpu.lane_id", benefit = 10)]
    fn lane_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let ub = match cr.rw.body[op].get("upper_bound") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(WARP),
            _ => WARP,
        };
        cr.rw.set_before(op);
        let r = cr.build(OpData::build("nvvm.read.ptx.sreg.laneid").with("range", crate::constant_range(0, ub)), Type::int(32));
        let r = cr.fit_index(r, o);
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

    /// `SincosOpLowering`: `__nv_sincos{f}` writing through two stack slots at the start of the
    /// function.
    #[convert("math.sincos", benefit = 10)]
    fn sincos<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        use mlirformat::FloatKind;
        let input = operands[0][0];
        let in_ty = cr.rw.body[input].ty.clone();
        let Some(scope) = cr.parent_function(op) else { return false };
        cr.rw.set_before(op);
        let converted = if matches!(in_ty, Type::Float(FloatKind::F16 | FloatKind::BF16)) { cr.build(OpData::build("llvm.fpext").operands(&[input]), Type::Float(FloatKind::F32)) } else { input };
        let cty = cr.rw.body[converted].ty.clone();
        let name = match cty {
            Type::Float(FloatKind::F32) if crate::Fmf::of(cr, op).afn() => "__nv_fast_sincosf",
            Type::Float(FloatKind::F32) => "__nv_sincosf",
            Type::Float(FloatKind::F64) => "__nv_sincos",
            _ => return false,
        };
        let ptr: Type<'a> = LlvmType::ptr();
        let saved = cr.rw.ip;
        let entry = cr.rw.body[cr.rw.body[scope].regions[0]].blocks[0];
        cr.rw.set_start(entry);
        let one = cr.llvm_constant(Attribute::of_int(1, Type::int(32)), Type::int(32));
        let alloca = |cr: &mut Cr<'_, 'a, '_>| cr.build(OpData::build("llvm.alloca").operands(&[one]).with("elem_type", Attribute::Type(cty.clone())), LlvmType::ptr());
        let sin_p = alloca(cr);
        let cos_p = alloca(cr);
        cr.rw.ip = saved;
        let fty: Type<'a> = LlvmType::Func { ret: LlvmType::void().into(), params: vec![cty.clone(), ptr.clone(), ptr], vararg: false }.into();
        if cr.declare_before_function(op, name, fty).is_none() {
            return false;
        }
        cr.llvm_call(name, &[converted, sin_p, cos_p], &[]);
        let load = |cr: &mut Cr<'_, 'a, '_>, p: ValueId| cr.build(OpData::build("llvm.load").operands(&[p]).with("ordering", Attribute::i64(0)), cty.clone());
        let trunc = |cr: &mut Cr<'_, 'a, '_>, v: ValueId| if cty != in_ty { cr.build(OpData::build("llvm.fptrunc").operands(&[v]), in_ty.clone()) } else { v };
        let (s, c) = (load(cr, sin_p), load(cr, cos_p));
        let (s, c) = (trunc(cr, s), trunc(cr, c));
        cr.replace(op, vec![vec![s], vec![c]]);
        true
    }

    /// `gpu.barrier` ⇒ `nvvm.barrier0` (`GPUToNVVM.td`).
    #[convert("gpu.barrier", benefit = 10)]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        cr.replace_new(op, OpData::build("nvvm.barrier0"), &[]);
        true
    }

    /// `ScalarizeVectorOpLowering` of the libdevice ops.
    #[convert("arith.remf", "arith.maxnumf", "arith.minnumf", "math.absi", "math.absf", "math.acos", "math.acosh", "math.asin", "math.asinh", "math.atan", "math.atan2", "math.atanh", "math.cbrt", "math.ceil", "math.copysign", "math.cos", "math.cosh", "math.erf", "math.erfc", "math.exp", "math.exp2", "math.expm1", "math.floor", "math.fma", "math.isfinite", "math.isinf", "math.isnan", "math.log", "math.log10", "math.log1p", "math.log2", "math.powf", "math.fpowi", "math.round", "math.roundeven", "math.rsqrt", "math.sin", "math.sinh", "math.sqrt", "math.tan", "math.tanh", benefit = 10)]
    fn scalarize_libdevice(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.scalarize(op, &ops)
    }

    /// `OpToFuncCallLowering`, as libdevice calls.
    #[convert("arith.remf", "arith.maxnumf", "arith.minnumf", "math.absi", "math.absf", "math.acos", "math.acosh", "math.asin", "math.asinh", "math.atan", "math.atan2", "math.atanh", "math.cbrt", "math.ceil", "math.copysign", "math.cos", "math.cosh", "math.erf", "math.erfc", "math.exp", "math.exp2", "math.expm1", "math.floor", "math.fma", "math.isfinite", "math.isinf", "math.isnan", "math.log", "math.log10", "math.log1p", "math.log2", "math.powf", "math.fpowi", "math.round", "math.roundeven", "math.rsqrt", "math.sin", "math.sinh", "math.sqrt", "math.tan", "math.tanh", benefit = 10)]
    fn libdevice(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let name = cr.rw.body[op].name.clone();
        let Some((_, fns)) = LIBDEVICE.iter().find(|(n, _)| **n == *name) else { return false };
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.lib_call(op, &ops, fns)
    }
}

/// `populateGpuSubgroupReduceOpLoweringPattern` (`has-redux`).
pub struct GpuReduxToNvvm;

#[patterns(converter)]
impl GpuReduxToNvvm {
    /// `GPUSubgroupReduceOpLowering`: a uniform, unclustered `i32` reduction as `nvvm.redux.sync`.
    #[convert("gpu.subgroup_reduce")]
    fn subgroup_reduce(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        if b[op].get("cluster_size").is_some() || b[op].get("uniform").is_none() {
            return false;
        }
        let value = b[op].operands[0];
        if !matches!(b[value].ty, Type::Integer { width: 32, .. }) {
            return false;
        }
        let kind = match b[op].get("op").and_then(|a| AllReduceOp::try_from(a).ok()) {
            Some(AllReduceOp::Add) => "add",
            Some(AllReduceOp::MinSi | AllReduceOp::MinNumF) => "min",
            Some(AllReduceOp::MaxSi | AllReduceOp::MaxNumF) => "max",
            Some(AllReduceOp::And) => "and",
            Some(AllReduceOp::Or) => "or",
            Some(AllReduceOp::Xor) => "xor",
            _ => return false,
        };
        cr.rw.set_before(op);
        let offset = cr.llvm_constant(Attribute::of_int(-1, Type::int(32)), Type::int(32));
        let data = OpData::build("nvvm.redux.sync").operands(&[value, offset]).with("kind", Attribute::dialect("nvvm", &format!("<redux_kind {kind}>"))).with("abs", Attribute::Bool(false)).with("nan", Attribute::Bool(false));
        let r = cr.build(data, Type::int(32));
        cr.replace(op, vec![vec![r]]);
        true
    }
}

/// `AssertOpToAssertfailLowering`: a failed `cf.assert` calls `__assertfail`.
pub struct AssertToNvvm;

#[patterns(converter)]
impl AssertToNvvm {
    /// The file, line and function of a location (`FileLineColRange`, or one inside a `NameLoc`).
    fn where_from(loc: Option<&str>) -> (alloc::string::String, i64, alloc::string::String) {
        let unknown = || alloc::string::String::from("(unknown)");
        let Some(mut l) = loc.map(str::trim) else { return (unknown(), 0, unknown()) };
        // `CallSiteLoc`: the callee.
        while let Some(rest) = l.strip_prefix("callsite(") {
            l = rest.split(" at ").next().unwrap_or(rest).trim();
        }
        let file_line = |s: &str| -> Option<(alloc::string::String, i64)> {
            let s = s.trim().strip_prefix('"')?;
            let end = s.find('"')?;
            let line = s[end + 1..].strip_prefix(':')?.split(':').next()?.parse().ok()?;
            Some((alloc::string::String::from(&s[..end]), line))
        };
        if let Some((f, n)) = file_line(l) {
            return (f, n, unknown());
        }
        if let Some(s) = l.strip_prefix('"') {
            // `NameLoc`: `"name"(child)`.
            if let Some(end) = s.find('"') {
                let name = alloc::string::String::from(&s[..end]);
                let child = s[end + 1..].trim().strip_prefix('(').and_then(|c| c.strip_suffix(')'));
                let (f, n) = child.and_then(file_line).unwrap_or_else(|| (unknown(), 0));
                return (f, n, name);
            }
        }
        (unknown(), 0, unknown())
    }

    #[convert("cf.assert", benefit = 10)]
    fn assert<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let mut module = b.parent_op(op);
        while let Some(m) = module.filter(|m| b[*m].name != "gpu.module") {
            module = b.parent_op(m);
        }
        let Some(module) = module else { return false };
        let Some(Attribute::Str { lit, .. }) = b[op].get("msg") else { return false };
        let msg = crate::unescape(lit);
        let loc = b[op].loc.clone();
        let ptr: Type<'a> = LlvmType::ptr();
        let (i32t, i64t) = (Type::int(32), Type::int(64));
        let params = vec![ptr.clone(), ptr.clone(), i32t.clone(), ptr.clone(), i64t.clone()];
        let f = match cr.rw.body.lookup(module, "__assertfail") {
            Some(f) => f,
            None => match cr.llvm_func(module, "__assertfail", params, LlvmType::void(), false) {
                Some(f) => {
                    cr.rw.body[f].loc = loc.clone();
                    f
                }
                None => return false,
            },
        };
        cr.modify(f, |b| b[f].set("passthrough", Attribute::Array(vec![Attribute::str("noreturn")])));
        let before = cr.rw.body[op].parent.expect("in a block");
        let assert_block = cr.rw.split_block(before, op);
        let next = cr.rw.body[assert_block].ops.iter().position(|o| *o == op).and_then(|i| cr.rw.body[assert_block].ops.get(i + 1).copied());
        let after = match next {
            Some(n) => cr.rw.split_block(assert_block, n),
            None => {
                let region = cr.rw.body[assert_block].parent.expect("in a region");
                let nb = cr.rw.body.add_block(region, &[]);
                let blocks = &mut cr.rw.body[region].blocks;
                blocks.pop();
                let pos = blocks.iter().position(|x| *x == assert_block).expect("in region");
                blocks.insert(pos + 1, nb);
                nb
            }
        };
        cr.rw.set_end(before);
        cr.rw.create(OpData::build("cf.cond_br").operands(&[operands[0][0]]).segments(&[1, 0, 0]).successors(&[after, assert_block]), &[]);
        cr.rw.set_end(assert_block);
        cr.rw.create(OpData::build("cf.br").successors(&[after]), &[]);
        let (file, line, func) = Self::where_from(loc.as_deref());
        cr.rw.set_before(op);
        let global = |cr: &mut Cr<'_, 'a, '_>, prefix: &str, bytes: &[u8]| {
            let (g, arr) = crate::GpuToLlvm::string_constant(cr, module, prefix, bytes, 0, loc.clone());
            cr.rw.set_before(op);
            let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![alloc::borrow::Cow::Owned(g)])), LlvmType::ptr());
            cr.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::dense_i32(&[0, 0])), LlvmType::ptr())
        };
        let m = global(cr, "assert_message_", &msg);
        let fi = global(cr, "assert_file_", file.as_bytes());
        let fu = global(cr, "assert_func_", func.as_bytes());
        let l = cr.llvm_constant(Attribute::of_int(line.into(), i32t.clone()), i32t);
        let one = cr.llvm_constant(Attribute::of_int(1, i64t.clone()), i64t);
        cr.llvm_call("__assertfail", &[m, fi, l, fu, one], &[]);
        cr.erase(op);
        true
    }
}
