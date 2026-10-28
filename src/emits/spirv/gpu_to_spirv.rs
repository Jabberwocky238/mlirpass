//! `gpu` ⇒ `spirv`, as `GPUToSPIRV.cpp`: kernels as entry functions with their ABI, launch
//! configuration as builtin variables, `gpu.module` as `spirv.module`.

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::{Attribute, FunctionType, NamedAttr, Type};

use super::lower::symbol_text;
use crate::{ConversionRewriter, OpData, OpId, SignatureConversion, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// What the gpu patterns need of the target and the type converter.
#[derive(Debug, Clone, Copy)]
pub struct GpuSpirvOptions {
    /// `use64bitIndex`.
    pub index64: bool,
    /// The target allows `Shader` (builtins read as `i32`).
    pub shader: bool,
    /// The target allows `Kernel`.
    pub kernel: bool,
    /// `needsInterfaceVarABIAttrs`: arguments get a default ABI when none is given.
    pub interface_abi: bool,
    /// The resource limits' `subgroup_size`.
    pub subgroup_size: u32,
    /// `getAddressingModel` of the target.
    pub addressing: &'static str,
}

impl GpuSpirvOptions {
    fn index<'a>(self) -> Type<'a> {
        Type::int(if self.index64 { 64 } else { 32 })
    }
}

/// The gpu ⇒ spirv patterns (`populateGPUToSPIRVPatterns`).
pub struct GpuToSpirv;

#[patterns(converter, options = GpuSpirvOptions)]
impl GpuToSpirv {
    /// The `#gpu<dim x>` of a launch configuration op, as 0, 1, 2.
    fn dim(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<i64> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("dimension") else { return None };
        match ext.body.as_deref()?.trim_start_matches('<').trim_end_matches('>').trim().strip_prefix("dim ")? {
            "x" => Some(0),
            "y" => Some(1),
            "z" => Some(2),
            _ => None,
        }
    }

    /// `LaunchConfigConversion` (and, for `gpu.block_dim` with a known workgroup size,
    /// `WorkGroupSizeConversion`, its higher-benefit rival).
    #[lowering("gpu.block_id", "gpu.grid_dim", "gpu.block_dim", "gpu.thread_id", "gpu.global_id")]
    fn launch_config<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        let Some(d) = Self::dim(cr, op) else { return false };
        let name = cr.rw.body[op].name.clone();
        if name == "gpu.block_dim"
            && let Some(size) = Self::workgroup_size(cr, op)
        {
            let r = cr.rw.body[op].results[0];
            let Some(t) = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[r].ty)) else { return false };
            let c = cr.spirv_const(t.clone(), Attribute::integer(i128::from(size[d as usize]), t));
            cr.replace_values(op, &[c]);
            return true;
        }
        let builtin = match &*name {
            "gpu.block_id" => "WorkgroupId",
            "gpu.grid_dim" => "NumWorkgroups",
            "gpu.block_dim" => "WorkgroupSize",
            "gpu.thread_id" => "LocalInvocationId",
            _ => "GlobalInvocationId",
        };
        let ty = if o.shader { Type::int(32) } else { o.index() };
        let Some(vector) = cr.builtin_value(op, builtin, ty.clone()) else { return false };
        let mut v = cr.build(OpData::build("spirv.CompositeExtract").operands(&[vector]).with("indices", Attribute::Array(vec![Attribute::integer(i128::from(d), Type::int(32))])), ty.clone());
        if o.shader && ty != o.index() {
            v = cr.build(OpData::build("spirv.UConvert").operands(&[v]), o.index());
        }
        cr.replace_values(op, &[v]);
        true
    }

    /// `lookupLocalWorkGroupSize`: the `workgroup_size` of the enclosing function's
    /// `spirv.entry_point_abi`.
    fn workgroup_size(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<Vec<i64>> {
        let b = &cr.rw.body;
        let mut at = b.parent_op(op);
        while let Some(f) = at {
            if matches!(&*b[f].name, "gpu.func" | "spirv.func" | "func.func") {
                let Some(Attribute::Extended { ext, .. }) = b[f].get("spirv.entry_point_abi") else { return None };
                let body = ext.body.as_deref()?;
                let list = body.split("workgroup_size").nth(1)?.split('[').nth(1)?.split(']').next()?;
                return list.split(',').map(|x| x.trim().parse().ok()).collect();
            }
            at = b.parent_op(f);
        }
        None
    }

    /// `SingleDimLaunchConfigConversion`.
    #[lowering("gpu.subgroup_id", "gpu.num_subgroups", "gpu.subgroup_size", "gpu.lane_id")]
    fn single_dim<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        let builtin = match &*cr.rw.body[op].name {
            "gpu.subgroup_id" => "SubgroupId",
            "gpu.num_subgroups" => "NumSubgroups",
            "gpu.subgroup_size" => "SubgroupSize",
            _ => "SubgroupLocalInvocationId",
        };
        let Some(mut v) = cr.builtin_value(op, builtin, Type::int(32)) else { return false };
        if o.index() != Type::int(32) {
            v = cr.build(OpData::build("spirv.UConvert").operands(&[v]), o.index());
        }
        cr.replace_values(op, &[v]);
        true
    }

    /// The case of a `#gpu<mnemonic case>` attribute.
    fn gpu_case(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<alloc::string::String> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get(name) else { return None };
        let body = ext.body.as_deref()?.trim_start_matches('<').trim_end_matches('>');
        Some(alloc::string::String::from(body.rsplit(' ').next()?.trim()))
    }

    /// `arith.cmpi` of `l`, `r` with predicate number `p`.
    fn cmpi<'a>(cr: &mut Cr<'_, 'a, '_>, p: i128, l: ValueId, r: ValueId) -> ValueId {
        cr.build(OpData::build("arith.cmpi").operands(&[l, r]).with("predicate", Attribute::integer(p, Type::int(64))), Type::I1)
    }

    /// `gpu.lane_id` bounded by `width`.
    fn lane_id<'a>(cr: &mut Cr<'_, 'a, '_>, width: i128) -> ValueId {
        cr.build(OpData::build("gpu.lane_id").with("upper_bound", Attribute::integer(width, Type::Index)), Type::Index)
    }

    /// `GPUShuffleConversion`.
    #[lowering("gpu.shuffle")]
    fn shuffle<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let width_v = cr.rw.body[op].operands[2];
        let Some(width) = cr.rw.body.int_constant(width_v).filter(|w| *w == i128::from(o.subgroup_size)) else { return false };
        let Some(mode) = Self::gpu_case(cr, op, "mode") else { return false };
        let (value, offset) = (ops[0], ops[1]);
        let ty = cr.rw.body[value].ty.clone();
        let target = match &*mode {
            "xor" => "spirv.GroupNonUniformShuffleXor",
            "idx" => "spirv.GroupNonUniformShuffle",
            "down" => "spirv.GroupNonUniformShuffleDown",
            "up" => "spirv.GroupNonUniformShuffleUp",
            _ => return false,
        };
        let r = cr.build(OpData::build(target).operands(&[value, offset]).with("execution_scope", Cr::spirv_enum("scope", "Subgroup")), ty);
        let valid = match &*mode {
            "down" => {
                let lane = Self::lane_id(cr, width);
                let sum = cr.build(OpData::build("arith.addi").operands(&[lane, offset]), Type::Index);
                Self::cmpi(cr, 6, sum, ops[2])
            }
            "up" => {
                let lane = Self::lane_id(cr, width);
                let diff = cr.build(OpData::build("arith.subi").operands(&[lane, offset]), Type::Index);
                let zero = cr.build(OpData::build("arith.constant").with("value", Attribute::integer(0, Type::int(32))), Type::int(32));
                Self::cmpi(cr, 5, diff, zero)
            }
            _ => cr.spirv_int_like(&Type::I1, 1),
        };
        cr.replace_values(op, &[r, valid]);
        true
    }

    /// `GPURotateConversion`.
    #[lowering("gpu.rotate")]
    fn rotate<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let attr = |n: &str| cr.rw.body[op].get(n).cloned();
        let (Some(offset), Some(width_a)) = (attr("offset"), attr("width")) else { return false };
        let Some(width) = mlirformat::Const::try_from(&width_a).ok().and_then(|c| c.as_int()).map(|i| i.signed()) else { return false };
        if width > i128::from(o.subgroup_size) {
            return false;
        }
        let i32t = Type::int(32);
        let off = cr.build(OpData::build("arith.constant").with("value", offset), i32t.clone());
        let wv = cr.build(OpData::build("arith.constant").with("value", width_a), i32t);
        let ty = cr.rw.body[ops[0]].ty.clone();
        let r = cr.build(OpData::build("spirv.GroupNonUniformRotateKHR").operands(&[ops[0], off, wv]).with("execution_scope", Cr::spirv_enum("scope", "Subgroup")), ty);
        let valid = if width == i128::from(o.subgroup_size) {
            cr.spirv_int_like(&Type::I1, 1)
        } else {
            let lane = Self::lane_id(cr, width);
            Self::cmpi(cr, 6, lane, wv)
        };
        cr.replace_values(op, &[r, valid]);
        true
    }

    /// `createGroupReduceOp`: `spirv.Group*` (uniform) or `spirv.GroupNonUniform*`.
    fn group_reduce<'a>(cr: &mut Cr<'_, 'a, '_>, arg: ValueId, kind: &str, workgroup: bool, uniform: bool, cluster: Option<i128>) -> Option<ValueId> {
        let ty = cr.rw.body[arg].ty.clone();
        let float = matches!(ty, Type::Float(_));
        if !float && !matches!(ty, Type::Integer { .. }) || ty == Type::I1 {
            return None;
        }
        let (u, nu) = match (kind, float) {
            ("add", false) => ("IAdd", "IAdd"),
            ("add", true) => ("FAdd", "FAdd"),
            ("mul", false) => ("KHR.GroupIMul", "IMul"),
            ("mul", true) => ("KHR.GroupFMul", "FMul"),
            ("minui", false) => ("UMin", "UMin"),
            ("minsi", false) => ("SMin", "SMin"),
            ("minnumf" | "minimumf", true) => ("FMin", "FMin"),
            ("maxui", false) => ("UMax", "UMax"),
            ("maxsi", false) => ("SMax", "SMax"),
            ("maxnumf" | "maximumf", true) => ("FMax", "FMax"),
            _ => return None,
        };
        let scope = Cr::spirv_enum("scope", if workgroup { "Workgroup" } else { "Subgroup" });
        let group = Cr::spirv_enum("group_operation", if cluster.is_some() { "ClusteredReduce" } else { "Reduce" });
        if uniform {
            let name = if u.starts_with("KHR.") { format!("spirv.{u}") } else { format!("spirv.Group{u}") };
            return Some(cr.build(OpData::build(&name).operands(&[arg]).with("execution_scope", scope).with("group_operation", group), ty));
        }
        let mut operands = vec![arg];
        if let Some(c) = cluster {
            operands.push(cr.spirv_const(Type::int(32), Attribute::integer(c, Type::int(32))));
        }
        Some(cr.build(OpData::build(&format!("spirv.GroupNonUniform{nu}")).operands(&operands).with("execution_scope", scope).with("group_operation", group), ty))
    }

    /// `GPUAllReduceConversion`.
    #[lowering("gpu.all_reduce")]
    fn all_reduce<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(kind) = Self::gpu_case(cr, op, "op") else { return false };
        let uniform = cr.rw.body[op].get("uniform").is_some();
        let Some(v) = Self::group_reduce(cr, ops[0], &kind, true, uniform, None) else { return false };
        cr.replace_values(op, &[v]);
        true
    }

    /// `GPUSubgroupReduceConversion`.
    #[lowering("gpu.subgroup_reduce")]
    fn subgroup_reduce<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let int = |n: &str| cr.rw.body[op].get(n).and_then(|a| mlirformat::Const::try_from(a).ok()).and_then(|c| c.as_int()).map(|i| i.signed());
        if int("cluster_stride").is_some_and(|s| s > 1) || !super::TargetEnv::is_scalar(&cr.rw.body[ops[0]].ty) {
            return false;
        }
        let cluster = int("cluster_size");
        let Some(kind) = Self::gpu_case(cr, op, "op") else { return false };
        let uniform = cr.rw.body[op].get("uniform").is_some();
        let Some(v) = Self::group_reduce(cr, ops[0], &kind, false, uniform, cluster) else { return false };
        cr.replace_values(op, &[v]);
        true
    }

    /// `makeVarName`: `prefix` and the first number no symbol of `table` has.
    fn var_name(cr: &Cr<'_, '_, '_>, table: crate::BlockId, prefix: &str) -> alloc::string::String {
        let b = &cr.rw.body;
        let taken = |n: &str| b[table].ops.iter().any(|o| b[*o].get("sym_name").and_then(symbol_text).as_deref() == Some(n));
        (0..).map(|i| format!("{prefix}{i}")).find(|n| !taken(n)).expect("a free name")
    }

    /// `GPUPrintfConversion`: the format string as a constant global, `spirv.CL.printf`.
    #[lowering("gpu.printf")]
    fn printf<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuSpirvOptions) -> bool {
        let Some(args) = Cr::one_to_one(operands) else { return false };
        let b = &cr.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at.filter(|o| b[*o].name != "spirv.module") {
            at = b.parent_op(o);
        }
        let Some(module) = at else { return false };
        let table = b.top_block(module);
        let Some(Attribute::Str { lit, .. }) = b[op].get("format").cloned() else { return false };
        let mut bytes = crate::unescape(&lit);
        bytes.push(0);
        let var = Self::var_name(cr, table, "printfMsg");
        let i8t = Type::int(8);
        let saved = cr.rw.ip;
        cr.rw.set_start(table);
        let mut parts = Vec::new();
        for c in bytes {
            let name = Self::var_name(cr, table, &format!("{var}_sc"));
            cr.rw.create(OpData::build("spirv.SpecConstant").with("sym_name", Attribute::str(&name)).with("default_value", Attribute::integer(i128::from(c as i8), i8t.clone())), &[]);
            parts.push(Attribute::SymbolRef(vec![name.into()]));
        }
        let arr = mlirformat::spirv_types::SpirvType::array(parts.len() as u32, i8t.clone(), 0);
        let scc = format!("{var}_scc");
        cr.rw.create(OpData::build("spirv.SpecConstantComposite").with("type", Attribute::Type(arr.clone())).with("sym_name", Attribute::str(&scc)).with("constituents", Attribute::Array(parts)), &[]);
        let ptr = mlirformat::spirv_types::SpirvType::ptr(arr, "UniformConstant");
        let mut g = OpData::build("spirv.GlobalVariable").with("type", Attribute::Type(ptr.clone())).with("sym_name", Attribute::str(&var)).with("initializer", Attribute::SymbolRef(vec![scc.into()]));
        g.attributes.push(NamedAttr { name: "Constant".into(), value: None });
        cr.rw.create(g, &[]);
        cr.rw.ip = saved;
        let addr = cr.build(OpData::build("spirv.mlir.addressof").with("variable", Attribute::SymbolRef(vec![var.into()])), ptr);
        let fmt = cr.build(OpData::build("spirv.Bitcast").operands(&[addr]), mlirformat::spirv_types::SpirvType::ptr(i8t, "UniformConstant"));
        let mut ops = vec![fmt];
        ops.extend(args);
        cr.build(OpData::build("spirv.CL.printf").operands(&ops), Type::int(32));
        cr.erase(op);
        true
    }

    /// `GPUBarrierConversion`.
    #[lowering("gpu.barrier")]
    fn barrier<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: GpuSpirvOptions) -> bool {
        let scope = Cr::spirv_enum("scope", "Workgroup");
        let data = OpData::build("spirv.ControlBarrier").with("execution_scope", scope.clone()).with("memory_scope", scope).with("memory_semantics", Cr::spirv_enum("memory_semantics", "AcquireRelease|WorkgroupMemory"));
        cr.replace_new(op, data, &[]);
        true
    }

    /// `GPUReturnOpConversion`.
    #[lowering("gpu.return")]
    fn ret<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuSpirvOptions) -> bool {
        if !operands.is_empty() {
            return false;
        }
        cr.replace_new(op, OpData::build("spirv.Return"), &[]);
        true
    }

    /// `GPUModuleConversion`.
    #[lowering("gpu.module")]
    fn module<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        let memory = if o.kernel {
            "OpenCL"
        } else if o.shader {
            "GLSL450"
        } else {
            return false;
        };
        let addressing = o.addressing;
        let Some(name) = cr.rw.body[op].get("sym_name").and_then(symbol_text) else { return false };
        let mut data = OpData::build("spirv.module")
            .with("addressing_model", Cr::spirv_enum("addressing_model", addressing))
            .with("memory_model", Cr::spirv_enum("memory_model", memory))
            .with("sym_name", Attribute::str(&format!("__spv__{name}")));
        let env = cr.rw.body[op].get("spirv.target_env").cloned().or_else(|| match cr.rw.body[op].get("targets") {
            Some(Attribute::Array(ts)) => ts.iter().find(|t| matches!(t, Attribute::Extended { ext, .. } if ext.name == "spirv.target_env")).cloned(),
            _ => None,
        });
        if let Some(env) = env {
            data.set("spirv.target_env", env);
        }
        let region = cr.rw.body[op].regions[0];
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, m| {
            b.add_region(m);
        });
        let into = cr.rw.body[new].regions[0];
        cr.inline_region(region, into, None);
        cr.erase(op);
        true
    }

    /// `getDefaultABIAttrs`, or the arguments' own `spirv.interface_var_abi`.
    fn arg_abi<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, inputs: &[Type<'a>], o: GpuSpirvOptions) -> Option<Vec<Option<Attribute<'a>>>> {
        let given: Vec<Option<Attribute<'a>>> = (0..inputs.len()).map(|i| Self::arg_attr(cr, op, i, "spirv.interface_var_abi")).collect();
        if o.interface_abi && given.iter().all(Option::is_none) {
            return Some(
                inputs
                    .iter()
                    .enumerate()
                    .map(|(i, t)| {
                        let scalar = matches!(t, Type::Integer { .. } | Type::Index | Type::Float(_));
                        let sc = if scalar { ", StorageBuffer" } else { "" };
                        Some(Attribute::dialect("spirv.interface_var_abi", &format!("<(0, {i}){sc}>")))
                    })
                    .collect(),
            );
        }
        if !o.interface_abi && given.iter().all(Option::is_none) {
            return Some(Vec::new());
        }
        given.iter().all(Option::is_some).then_some(given)
    }

    fn arg_attr<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, i: usize, name: &str) -> Option<Attribute<'a>> {
        let Some(Attribute::Array(dicts)) = cr.rw.body[op].get("arg_attrs") else { return None };
        let Some(Attribute::Dict(d)) = dicts.get(i) else { return None };
        d.iter().find(|a| a.name == name).and_then(|a| a.value.clone())
    }

    /// `GPUFuncOpConversion` (`lowerAsEntryFunction`).
    #[lowering("gpu.func")]
    fn func<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuSpirvOptions) -> bool {
        if cr.rw.body[op].get("gpu.kernel").is_none() {
            return false;
        }
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(abi) = Self::arg_abi(cr, op, &fty.inputs, o) else { return false };
        let Some(entry) = cr.rw.body[op].get("spirv.entry_point_abi").cloned() else { return false };
        if !fty.results.is_empty() || (!abi.is_empty() && abi.len() != fty.inputs.len()) {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            let Some(c) = tc.convert(t) else { return false };
            sig.add_inputs(i, vec![c]);
        }
        let new_ty = Type::Function(FunctionType { inputs: sig.converted_types().to_vec(), results: Vec::new() });
        let mut data = OpData::build("spirv.func")
            .with("sym_name", cr.rw.body[op].get("sym_name").cloned().unwrap_or(Attribute::Unit))
            .with("function_type", Attribute::Type(new_ty))
            .with("function_control", Cr::spirv_enum("function_control", "None"));
        for a in cr.all_attrs(op) {
            if a.name != "function_type" && a.name != "sym_name" && a.name != "gpu.kernel" {
                data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
            }
        }
        if !abi.is_empty() {
            let mut dicts: Vec<Attribute<'a>> = match data.get("arg_attrs") {
                Some(Attribute::Array(d)) => d.clone(),
                _ => vec![Attribute::Dict(Vec::new()); fty.inputs.len()],
            };
            for (d, a) in dicts.iter_mut().zip(abi) {
                let Attribute::Dict(entries) = d else { return false };
                entries.retain(|e| e.name != "spirv.interface_var_abi");
                entries.push(NamedAttr { name: "spirv.interface_var_abi".into(), value: a });
                entries.sort_by(|x, y| x.name.cmp(&y.name));
            }
            data.set("arg_attrs", Attribute::Array(dicts));
        }
        data.set("spirv.entry_point_abi", entry);
        let region = cr.rw.body[op].regions[0];
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        let into = cr.rw.body[new].regions[0];
        cr.inline_region(region, into, None);
        let Some(current) = cr.current else { return false };
        if cr.convert_region_types(into, current, Some(&sig)).is_none() {
            return false;
        }
        cr.erase(op);
        true
    }
}

/// `convert-gpu-to-spirv`.
#[crate::pass("convert-gpu-to-spirv", on = "builtin.module")]
pub struct ConvertGpuToSpirv {
    #[opt("use-64bit-index")]
    index64: bool,
}

impl ConvertGpuToSpirv {
    /// `lookupTargetEnvOrDefault`: the module's own `targets` first.
    fn target_env(body: &crate::Body<'_>, gm: OpId) -> super::TargetEnv {
        if let Some(Attribute::Array(ts)) = body[gm].get("targets")
            && let Some(env) = ts.iter().find_map(|t| super::TargetEnv::parse(&format!("{t}")).filter(|_| format!("{t}").starts_with("#spirv.target_env")))
        {
            return env;
        }
        super::TargetEnv::lookup(body, gm)
    }
}

impl crate::Run for ConvertGpuToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: OpId) -> Result<(), mlirformat::Error> {
        let modules: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "gpu.module").collect();
        let mut clones = Vec::new();
        for gm in &modules {
            let kernel = Self::target_env(body, *gm).allows_cap("Kernel");
            let c = body.clone_op(*gm, &mut crate::Mapping::default());
            if kernel {
                let blk = body.top_block(*gm);
                body.insert(c, blk, Some(0));
            } else {
                body.insert_before(c, *gm);
            }
            clones.push(c);
        }
        for gm in clones {
            let env = Self::target_env(body, gm);
            let api = if env.allows_cap("Kernel") { super::ClientApi::OpenCl } else { super::ClientApi::Vulkan };
            if let Some(bad) = api.map_memory_spaces(body, gm).first() {
                return Err(mlirformat::Error(format!("'{}' op failed to legalize memory space", body[*bad].name)));
            }
            let opts = super::SpirvOptions { index64: self.index64, ..super::SpirvOptions::default() };
            let types = super::SpirvTypes { env: &env, opts };
            let mut tc = types.converter();
            super::WmmaToSpirv::convert_types(&mut tc);
            let gpu = GpuSpirvOptions { index64: self.index64, shader: env.allows_cap("Shader"), kernel: env.allows_cap("Kernel"), interface_abi: env.shader(), subgroup_size: env.subgroup_size(), addressing: env.addressing_model(self.index64) };
            let mut patterns = crate::ConversionPatterns::default();
            let i = patterns.converter(&tc);
            GpuToSpirv::populate(&mut patterns, i, gpu);
            super::WmmaToSpirv::populate(&mut patterns, i, super::MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
            super::ScfToSpirv::populate(&mut patterns, i);
            super::ArithToSpirv::populate(&mut patterns, i, super::ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: true });
            super::MemrefToSpirv::populate(&mut patterns, i, super::MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
            super::FuncToSpirv::populate(&mut patterns, i);
            super::VectorToSpirv::populate(&mut patterns, i, super::VectorSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel") });
            let target = env.conversion_target();
            crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[gm], crate::Mode::Full)?;
        }
        for gm in modules {
            if !Self::target_env(body, gm).allows_cap("Kernel") {
                continue;
            }
            let funcs: Vec<OpId> = body.ops_in(gm).into_iter().filter(|o| body[*o].name == "gpu.func").collect();
            for f in funcs {
                let mut data = OpData::build("func.func");
                for a in ["sym_name", "function_type"] {
                    data.set(a, body[f].get(a).cloned().unwrap_or(Attribute::Unit));
                }
                data.set("gpu.kernel", Attribute::Unit);
                let Some(Attribute::Type(Type::Function(fty))) = body[f].get("function_type").cloned() else { continue };
                let new = body.create(data, &[]);
                let r = body.add_region(new);
                let args: Vec<_> = fty.inputs.iter().map(|t| (t.clone(), body[f].loc.clone())).collect();
                let blk = body.add_block(r, &args);
                let ret = body.create(OpData::build("func.return"), &[]);
                body.insert(ret, blk, None);
                body.insert_before(new, f);
                body.erase(f);
            }
        }
        Ok(())
    }
}
