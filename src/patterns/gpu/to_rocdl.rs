//! `gpu` ⇒ `rocdl`, as `LowerGpuOpsToROCDLOps.cpp`: launch configuration as the ROCDL id ops,
//! the lane id through `mbcnt`, shuffles through `ds_bpermute`, broadcasts as `readlane`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use super::attrs::{AddressSpace, BarrierScope, BroadcastType, Dimension, ShuffleMode};
use super::index::{constant_range, IndexKind};
use crate::patterns;
use crate::{AmdChipset, ConversionRewriter, LlvmOptions, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// What the patterns need: the converter's options and the chipset.
#[derive(Debug, Clone, Copy)]
pub struct GpuRocdlOptions {
    pub llvm: LlvmOptions,
    pub chipset: AmdChipset,
}

/// The first chipset generation with split barriers and `wave.id`.
const GFX12: u32 = 12;
/// The first chipset with cluster barriers (gfx1250).
const CLUSTER_BARRIERS: AmdChipset = AmdChipset { major: 12, minor: 5, stepping: 0 };
/// The barrier id of the whole workgroup / the whole cluster.
const WHOLE_WORKGROUP_BARRIER: i64 = -1;
const WHOLE_CLUSTER_BARRIER: i64 = -3;
/// `LLVM::AtomicOrdering::release` / `acquire`.
/// The wait class of the last named barrier the wave joined.
const NAMED_BARRIER_WAIT: i64 = 1;
/// The global a named barrier lives in, and its type.
const NAMED_BARRIER_GLOBAL: &str = "__named_barrier";
const NAMED_BARRIER_TYPE: &str = "amdgcn.named.barrier";
/// `ROCDLDialect::kSharedMemoryAddressSpace`.
const LDS_ADDRESS_SPACE: u32 = 3;
const ORDERING_RELEASE: i64 = 5;
const ORDERING_ACQUIRE: i64 = 4;
/// `IntegerOverflowFlags::nsw | nuw` of the llvm ops.
const LLVM_NSW_NUW: i64 = 3;
/// The most threads per block dimension on AMD GPUs.
const MAX_THREADS_PER_BLOCK_DIM: i64 = 1024;

/// The gpu ⇒ rocdl patterns (`populateGpuToROCDLConversionPatterns`, but `gpu.func` /
/// `gpu.return` / `gpu.printf`: [`GpuToLlvm`](crate::GpuToLlvm), math: [`MathToRocdl`](crate::MathToRocdl)).
pub struct GpuToRocdl;

#[patterns(converter, options = GpuRocdlOptions)]
impl GpuToRocdl {
    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        cr.gpu_index(op, o.llvm, "rocdl.workitem.id", IndexKind::Block, false)
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        cr.gpu_index(op, o.llvm, "rocdl.workgroup.id", IndexKind::Grid, false)
    }

    /// `GPUDimOpToOcklCall<gpu::BlockDimOp>`.
    #[convert("gpu.block_dim")]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        Self::dim_call(cr, op, o, IndexKind::Block)
    }

    /// `GPUDimOpToOcklCall<gpu::GridDimOp>`.
    #[convert("gpu.grid_dim")]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        Self::dim_call(cr, op, o, IndexKind::Grid)
    }

    /// `GPUBarrierOpLowering`: fences around the barrier for the address spaces it orders
    /// (all of them when none are named), `wave.barrier` for a subgroup, `s.barrier` (gfx12+:
    /// signal / wait -1) for a workgroup, signal / wait -3 for a cluster (gfx1250+).
    #[convert("gpu.barrier")]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        let b = &*cr.rw.body;
        let scope = b[op].get("scope").and_then(|a| BarrierScope::try_from(a).ok()).unwrap_or(BarrierScope::Workgroup);
        let spaces: Option<Vec<AddressSpace>> = match b[op].get("address_spaces") {
            Some(Attribute::Array(xs)) => xs.iter().map(|x| AddressSpace::try_from(x).ok()).collect(),
            _ => None,
        };
        let gfx12 = o.chipset.major >= GFX12;
        if let Some(named) = operands.iter().find_map(|v| v.first().copied()) {
            // A named barrier (workgroup scope, gfx12+): joined, signalled keeping its count,
            // then the named-barrier wait class waited on.
            if scope != BarrierScope::Workgroup || !gfx12 {
                return false;
            }
            cr.rw.set_before(op);
            Self::fence(cr, spaces.as_deref(), "workgroup", ORDERING_RELEASE);
            cr.rw.create(OpData::build("rocdl.s.barrier.join").operands(&[named]), &[]);
            cr.rw.create(OpData::build("rocdl.s.barrier.signal.var").operands(&[named]).with("memberCnt", Attribute::of_int(0, Type::int(32))), &[]);
            cr.rw.create(OpData::build("rocdl.s.barrier.wait").with("id", Attribute::of_int(NAMED_BARRIER_WAIT.into(), Type::int(16))), &[]);
            Self::fence(cr, spaces.as_deref(), "workgroup", ORDERING_ACQUIRE);
            cr.erase(op);
            return true;
        }
        let (sync, ops): (&str, Vec<OpData<'_>>) = match scope {
            BarrierScope::Subgroup => ("wavefront", vec![OpData::build("rocdl.wave.barrier")]),
            BarrierScope::Cluster => {
                if o.chipset < CLUSTER_BARRIERS {
                    return false;
                }
                ("cluster", Self::signal_wait(WHOLE_CLUSTER_BARRIER))
            }
            BarrierScope::Workgroup if gfx12 => ("workgroup", Self::signal_wait(WHOLE_WORKGROUP_BARRIER)),
            BarrierScope::Workgroup => ("workgroup", vec![OpData::build("rocdl.s.barrier")]),
        };
        cr.rw.set_before(op);
        Self::fence(cr, spaces.as_deref(), sync, ORDERING_RELEASE);
        for d in ops {
            cr.rw.create(d, &[]);
        }
        Self::fence(cr, spaces.as_deref(), sync, ORDERING_ACQUIRE);
        cr.erase(op);
        true
    }

    /// `GPUInitializeNamedBarrierOpLowering` (gfx12+): an LDS `amdgcn.named.barrier` global in
    /// the function's symbol table, initialized with the constant member count.
    #[convert("gpu.initialize_named_barrier")]
    fn initialize_named_barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        if o.chipset.major < GFX12 {
            return false;
        }
        let b = &*cr.rw.body;
        let Some(count) = b.int_constant(b[op].operands[0]) else { return false };
        let mut func = b.parent_op(op);
        while let Some(f) = func.filter(|f| !b.has(*f, crate::Trait::FunctionOpInterface)) {
            func = b.parent_op(f);
        }
        let Some(table) = func.and_then(|f| b.parent_op(f)).filter(|t| b.is_symbol_table(*t)) else { return false };
        let name = b.unique_symbol(table, NAMED_BARRIER_GLOBAL, None);
        let target = Type::Extended(mlirformat::Extended { name: "llvm.target".into(), body: Some(alloc::format!("<\"{NAMED_BARRIER_TYPE}\", 0>").into()), params: Vec::new() });
        let lds = Type::from(LlvmType::Ptr(LDS_ADDRESS_SPACE));
        let loc = b[op].loc.clone();
        // (appended to the symbol table's body, as `SymbolTable::insert` does)
        let saved = cr.rw.ip;
        let block = cr.rw.body.top_block(table);
        cr.rw.set_end(block);
        let data = OpData { loc: loc.clone(), ..OpData::build("llvm.mlir.global") }
            .with("addr_space", Attribute::of_int(LDS_ADDRESS_SPACE.into(), Type::int(32)))
            .with("global_type", Attribute::Type(target.clone()))
            .with("linkage", Attribute::dialect("llvm.linkage", "<internal>"))
            .with("sym_name", Attribute::str(&name));
        let global = cr.rw.create_with(data, &[], |b, g| {
            let r = b.add_region(g);
            b.add_block(r, &[]);
        });
        let init = cr.rw.body[cr.rw.body[global].regions[0]].blocks[0];
        cr.rw.set_start(init);
        let poison = cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.mlir.poison") }, &[target]);
        let pv = cr.rw.body[poison].results[0];
        cr.rw.create(OpData { loc, ..OpData::build("llvm.return").operands(&[pv]) }, &[]);
        cr.rw.ip = saved;
        cr.rw.set_before(op);
        let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![name.into()])), lds);
        cr.rw.create(OpData::build("rocdl.s.barrier.init").operands(&[addr]).with("memberCnt", Attribute::of_int(count, Type::int(32))), &[]);
        cr.replace(op, vec![vec![addr]]);
        true
    }

    /// `GPUSubgroupIdOpToROCDL`: gfx12+ reads `wave.id`; before, the linearized thread id over
    /// the wavefront size.
    #[convert("gpu.subgroup_id")]
    fn subgroup_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        let i32t = Type::int(32);
        cr.rw.set_before(op);
        let id = if o.chipset.major >= GFX12 {
            let mut d = OpData::build("rocdl.wave.id");
            if let Some(Attribute::Int { lit, .. }) = cr.rw.body[op].get("upper_bound") {
                d.set("range", constant_range(0, lit.parse().unwrap_or(0)));
            }
            cr.build(d, i32t.clone())
        } else {
            let mut tid = Vec::new();
            for (axis, d) in [("x", Dimension::X), ("y", Dimension::Y), ("z", Dimension::Z)] {
                let mut data = OpData::build(&alloc::format!("rocdl.workitem.id.{axis}"));
                if let Some(ub) = cr.known_bound(op, IndexKind::Block, d) {
                    data.set("range", constant_range(0, ub));
                }
                tid.push(cr.build(data, i32t.clone()));
            }
            let flags = || Attribute::of_int(LLVM_NSW_NUW.into(), Type::int(32));
            let mut dim = Vec::new();
            for d in [Dimension::X, Dimension::Y] {
                let v = Self::known_or_ockl(cr, op, IndexKind::Block, d, None);
                dim.push(cr.build(OpData::build("llvm.trunc").operands(&[v]).with("overflowFlags", flags()), i32t.clone()));
            }
            let arith = |cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId| cr.build(OpData::build(name).operands(&[a, b]).with("overflowFlags", flags()), Type::int(32));
            let yz = arith(cr, "llvm.mul", dim[1], tid[2]);
            let inner = arith(cr, "llvm.add", tid[1], yz);
            let xi = arith(cr, "llvm.mul", dim[0], inner);
            let linear = arith(cr, "llvm.add", tid[0], xi);
            let size = cr.build(OpData::build("rocdl.wavefrontsize"), i32t.clone());
            cr.build(OpData::build("llvm.udiv").operands(&[linear, size]), i32t)
        };
        let r = cr.fit_index(id, o.llvm);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `GPUBallotOpToROCDL`: `rocdl.ballot` of an `i32` or `i64`.
    #[convert("gpu.ballot")]
    fn ballot(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuRocdlOptions) -> bool {
        let t = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        if !matches!(t.bit_width(), Some(32 | 64)) || !matches!(t, Type::Integer { .. }) {
            return false;
        }
        cr.replace_new(op, OpData::build("rocdl.ballot").operands(&[operands[0][0]]), &[t]);
        true
    }

    /// `getLaneId`: `mbcnt.hi(-1, mbcnt.lo(-1, 0))`.
    fn lane(cr: &mut Cr<'_, '_, '_>) -> ValueId {
        let i32t = Type::int(32);
        let zero = cr.build(OpData::build("arith.constant").with("value", Attribute::of_int(0, i32t.clone())), i32t.clone());
        let minus1 = cr.build(OpData::build("arith.constant").with("value", Attribute::of_int(-1, i32t.clone())), i32t.clone());
        let res_attrs = |hi: i64| Attribute::Array(vec![Attribute::Dict(vec![
            mlirformat::NamedAttr { name: "llvm.noundef".into(), value: None },
            mlirformat::NamedAttr { name: "llvm.range".into(), value: Some(constant_range(0, hi)) },
        ])]);
        let lo = cr.build(OpData::build("rocdl.mbcnt.lo").operands(&[minus1, zero]).with("res_attrs", res_attrs(32)), i32t.clone());
        cr.build(OpData::build("rocdl.mbcnt.hi").operands(&[minus1, lo]).with("res_attrs", res_attrs(64)), i32t)
    }

    /// `GPULaneIdOpToROCDL`.
    #[convert("gpu.lane_id")]
    fn lane_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        cr.rw.set_before(op);
        let l = Self::lane(cr);
        let l = cr.fit_index(l, o.llvm);
        cr.replace(op, vec![vec![l]]);
        true
    }

    /// `GPUSubgroupSizeOpToROCDL`: `rocdl.wavefrontsize`, ranged by an upper bound.
    #[convert("gpu.subgroup_size")]
    fn subgroup_size(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        let mut data = OpData::build("rocdl.wavefrontsize");
        if let Some(Attribute::Int { lit, .. }) = cr.rw.body[op].get("upper_bound") {
            let ub: i64 = lit.parse().unwrap_or(0);
            data.set("range", constant_range(if o.chipset.major < 10 { 64 } else { 32 }, ub + 1));
        }
        cr.rw.set_before(op);
        let r = cr.build(data, Type::int(32));
        let r = cr.fit_index(r, o.llvm);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `isSupportedReadLaneType`.
    fn readlane_type(t: &Type<'_>) -> bool {
        match t {
            Type::Float(FloatKind::F16 | FloatKind::BF16 | FloatKind::F32 | FloatKind::F64) => true,
            Type::Integer { width, .. } => matches!(width, 16 | 32 | 64),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let n: i64 = s.dims().unwrap_or_default().iter().product();
                matches!(*s.elem, Type::Integer { width: 32, .. }) || (n == 2 && matches!(*s.elem, Type::Float(FloatKind::F16 | FloatKind::BF16) | Type::Integer { width: 16, .. }))
            }
            t => matches!(LlvmType::try_from(t), Ok(LlvmType::Ptr(_))),
        }
    }

    /// `GPUSubgroupBroadcastOpToROCDL`.
    #[convert("gpu.subgroup_broadcast")]
    fn subgroup_broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuRocdlOptions) -> bool {
        let src = operands[0][0];
        let lane = operands.get(1).and_then(|l| l.first()).copied();
        let specific = cr.rw.body[op].get("broadcast_type").and_then(|a| BroadcastType::try_from(a).ok()) == Some(BroadcastType::SpecificLane);
        cr.rw.set_before(op);
        let read = |cr: &mut Cr<'_, '_, '_>, v: ValueId| {
            let t = cr.rw.body[v].ty.clone();
            match (specific, lane) {
                (true, Some(l)) => cr.build(OpData::build("rocdl.readlane").operands(&[v, l]), t),
                _ => cr.build(OpData::build("rocdl.readfirstlane").operands(&[v]), t),
            }
        };
        let ty = cr.rw.body[src].ty.clone();
        let r = if Self::readlane_type(&ty) {
            read(cr, src)
        } else {
            let Some(parts) = cr.decompose(src, Type::int(32), true) else { return false };
            let read: Vec<ValueId> = parts.into_iter().map(|p| read(cr, p)).collect();
            cr.compose(&read, ty)
        };
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `GPUShuffleOpLowering`: `ds_bpermute` of each dword from the lane the mode picks.
    #[convert("gpu.shuffle")]
    fn shuffle(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GpuRocdlOptions) -> bool {
        let Some(mode) = cr.rw.body[op].get("mode").and_then(|a| ShuffleMode::try_from(a).ok()) else { return false };
        let (value, offset, width) = (operands[0][0], operands[1][0], operands[2][0]);
        let i32t = Type::int(32);
        cr.rw.set_before(op);
        let src_lane = Self::lane(cr);
        let c = |cr: &mut Cr<'_, '_, '_>, v: i64| cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32));
        let bin = |cr: &mut Cr<'_, '_, '_>, n: &str, a: ValueId, b: ValueId| cr.build(OpData::build(n).operands(&[a, b]), Type::int(32));
        let zero = c(cr, 0);
        let negw = bin(cr, "llvm.sub", zero, width);
        let add = bin(cr, "llvm.add", src_lane, width);
        let bound = bin(cr, "llvm.and", add, negw);
        let dst = match mode {
            ShuffleMode::Up => bin(cr, "llvm.sub", src_lane, offset),
            ShuffleMode::Down => bin(cr, "llvm.add", src_lane, offset),
            ShuffleMode::Xor => bin(cr, "llvm.xor", src_lane, offset),
            ShuffleMode::Idx => offset,
        };
        // `slt` 2.
        let active = cr.build(OpData::build("llvm.icmp").operands(&[dst, bound]).with("predicate", Attribute::i64(2)), Type::int(1));
        let sel = cr.build(OpData::build("llvm.select").operands(&[active, dst, src_lane]), i32t.clone());
        let two = c(cr, 2);
        let aligned = bin(cr, "llvm.shl", sel, two);
        let Some(parts) = cr.decompose(value, i32t.clone(), false) else { return false };
        let swizzled: Vec<ValueId> = parts.into_iter().map(|p| cr.build(OpData::build("rocdl.ds_bpermute").operands(&[aligned, p]), Type::int(32))).collect();
        let ty = cr.rw.body[value].ty.clone();
        let r = cr.compose(&swizzled, ty);
        cr.replace(op, vec![vec![r], vec![active]]);
        true
    }
}

impl GpuToRocdl {
    /// `rocdl.s.barrier.signal` and `rocdl.s.barrier.wait` of barrier `id`.
    fn signal_wait<'a>(id: i64) -> Vec<OpData<'a>> {
        vec![
            OpData::build("rocdl.s.barrier.signal").with("id", Attribute::of_int(id.into(), Type::int(32))),
            OpData::build("rocdl.s.barrier.wait").with("id", Attribute::of_int(id.into(), Type::int(16))),
        ]
    }

    /// `emitFences`: an `llvm.fence` at `scope` for `spaces` (global and LDS when none), tagged
    /// with the one it is limited to.
    fn fence(cr: &mut Cr<'_, '_, '_>, spaces: Option<&[AddressSpace]>, scope: &str, ordering: i64) {
        let (global, lds) = match spaces {
            Some(s) => (s.contains(&AddressSpace::Global), s.contains(&AddressSpace::Workgroup)),
            None => (true, true),
        };
        if !global && !lds {
            return;
        }
        let mut d = OpData::build("llvm.fence").with("ordering", Attribute::i64(ordering)).with("syncscope", Attribute::str(scope));
        match (global, lds) {
            (false, true) => d.set("llvm.mmra", Attribute::dialect("llvm.mmra_tag", "<\"amdgpu-synchronize-as\":\"local\">")),
            (true, false) => d.set("llvm.mmra", Attribute::dialect("llvm.mmra_tag", "<\"amdgpu-synchronize-as\":\"global\">")),
            _ => {}
        }
        cr.rw.create(d, &[]);
    }

    /// `getKnownOrOcklDim`: a known size as an `i64` constant, else a call of
    /// `__ockl_get_local_size` / `__ockl_get_num_groups` ranged by the op's bound (a block's
    /// by the hardware limit).
    fn known_or_ockl(cr: &mut Cr<'_, '_, '_>, op: OpId, kind: IndexKind, d: Dimension, bound: Option<i64>) -> ValueId {
        let i64t = Type::int(64);
        if let Some(k) = cr.known_bound(op, kind, d) {
            return cr.llvm_constant(Attribute::of_int(k.into(), i64t.clone()), i64t);
        }
        let name = if kind == IndexKind::Block { "__ockl_get_local_size" } else { "__ockl_get_num_groups" };
        if let Some(module) = cr.module_of(op) {
            if cr.rw.body.lookup(module, name).is_none() {
                let loc = cr.rw.body[op].loc.clone();
                if let Some(f) = cr.llvm_func(module, name, vec![Type::int(32)], i64t.clone(), false) {
                    cr.rw.body[f].loc = loc;
                }
            }
        }
        let arg = cr.llvm_constant(Attribute::of_int((d as i64).into(), Type::int(32)), Type::int(32));
        let call = cr.llvm_call(name, &[arg], &[i64t]);
        let hi = match (bound, kind) {
            (Some(b), _) => Some(b + 1),
            (None, IndexKind::Block) => Some(MAX_THREADS_PER_BLOCK_DIM + 1),
            _ => None,
        };
        if let Some(hi) = hi {
            let range = Attribute::dialect("llvm.constant_range", &alloc::format!("<i64, 1, {hi}>"));
            cr.rw.body[call].set("res_attrs", Attribute::Array(vec![Attribute::Dict(vec![mlirformat::NamedAttr { name: "llvm.range".into(), value: Some(range) }])]));
        }
        cr.rw.body[call].results[0]
    }

    /// `GPUDimOpToOcklCall`: the size, fitted to the index width.
    fn dim_call(cr: &mut Cr<'_, '_, '_>, op: OpId, o: GpuRocdlOptions, kind: IndexKind) -> bool {
        let Some(d) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        let bound = match cr.rw.body[op].get("upper_bound") {
            Some(Attribute::Int { lit, .. }) => lit.parse().ok(),
            _ => None,
        };
        cr.rw.set_before(op);
        let v = Self::known_or_ockl(cr, op, kind, d, bound);
        let r = match o.llvm.index_bitwidth {
            64 => v,
            w => cr.build(OpData::build("llvm.trunc").operands(&[v]), Type::int(w)),
        };
        cr.replace(op, vec![vec![r]]);
        true
    }
}
