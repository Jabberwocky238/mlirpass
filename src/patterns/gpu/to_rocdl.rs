//! `gpu` ⇒ `rocdl`, as `LowerGpuOpsToROCDLOps.cpp`: launch configuration as the ROCDL id ops,
//! the lane id through `mbcnt`, shuffles through `ds_bpermute`, broadcasts as `readlane`.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use super::attrs::{BroadcastType, ShuffleMode};
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

    #[convert("gpu.block_dim")]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        cr.gpu_index(op, o.llvm, "rocdl.workgroup.dim", IndexKind::Block, true)
    }

    #[convert("gpu.grid_dim")]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: GpuRocdlOptions) -> bool {
        cr.gpu_index(op, o.llvm, "rocdl.grid.dim", IndexKind::Grid, true)
    }

    /// `gpu.barrier` ⇒ `rocdl.barrier` (`GPUToROCDL.td`).
    #[convert("gpu.barrier")]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: GpuRocdlOptions) -> bool {
        cr.replace_new(op, OpData::build("rocdl.barrier"), &[]);
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
            let parts = cr.decompose(src, Type::int(32));
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
        let parts = cr.decompose(value, i32t.clone());
        let swizzled: Vec<ValueId> = parts.into_iter().map(|p| cr.build(OpData::build("rocdl.ds_bpermute").operands(&[aligned, p]), Type::int(32))).collect();
        let ty = cr.rw.body[value].ty.clone();
        let r = cr.compose(&swizzled, ty);
        cr.replace(op, vec![vec![r], vec![active]]);
        true
    }
}
