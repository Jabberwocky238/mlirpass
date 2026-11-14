use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, Type};

use super::attrs::{AddressSpace, Dimension, ShuffleMode};
use crate::patterns;
use crate::{CConv, ConversionRewriter, LlvmOptions, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

struct SpirvFn<'s, 'a> {
    name: &'s str,
    params: Vec<Type<'a>>,
    ret: Type<'a>,
    mem_none: bool,
    convergent: bool,
}

impl<'a> SpirvFn<'_, 'a> {
    fn call(&self, cr: &mut Cr<'_, 'a, '_>, op: OpId, args: &[ValueId]) -> Option<OpId> {
        let module = cr.module_of(op)?;
        let f = match cr.rw.body.lookup(module, self.name).filter(|f| cr.rw.body[*f].name == "llvm.func") {
            Some(f) => f,
            None => {
                let fty: Type<'a> = LlvmType::Func { ret: self.ret.clone().into(), params: self.params.clone(), vararg: false }.into();
                let saved = cr.rw.ip;
                let block = cr.rw.body.top_block(module);
                cr.rw.set_start(block);
                let mut data = OpData::build("llvm.func").with("sym_name", Attribute::str(self.name)).with("function_type", Attribute::Type(fty)).with("linkage", Attribute::dialect("llvm.linkage", "<external>")).with("CConv", CConv::SpirFunc.into()).flag("no_unwind").flag("will_return");
                if self.mem_none {
                    data.set("memory_effects", Attribute::dialect("llvm.memory_effects", "<other = none, argMem = none, inaccessibleMem = none, errnoMem = none, targetMem0 = none, targetMem1 = none>"));
                }
                if self.convergent {
                    data.set("convergent", Attribute::Unit);
                }
                data.loc = cr.rw.body[module].loc.clone();
                let f = cr.rw.create_with(data, &[], |b, f| {
                    b.add_region(f);
                });
                cr.rw.ip = saved;
                f
            }
        };
        let ret = match cr.rw.body[f].get("function_type") {
            Some(Attribute::Type(t)) => match LlvmType::try_from(t) {
                Ok(LlvmType::Func { ret, .. }) if !matches!(LlvmType::try_from(&*ret), Ok(LlvmType::Void)) => vec![*ret],
                _ => Vec::new(),
            },
            _ => return None,
        };
        let copied: Vec<(&str, Attribute<'a>)> = ["CConv", "convergent", "no_unwind", "will_return", "memory_effects"].into_iter().filter_map(|n| Some((n, cr.rw.body[f].get(n)?.clone()))).collect();
        let call = cr.llvm_call(self.name, args, &ret);
        cr.modify(call, |b| {
            for (n, a) in copied {
                b[call].set(n, a);
            }
        });
        Some(call)
    }
}

impl ShuffleMode {
    const fn spirv_builtin(self) -> &'static str {
        match self {
            ShuffleMode::Idx => "sub_group_shuffle",
            ShuffleMode::Xor => "sub_group_shuffle_xor",
            ShuffleMode::Up => "sub_group_shuffle_up",
            ShuffleMode::Down => "sub_group_shuffle_down",
        }
    }
}

pub struct GpuToLlvmSpv;

const LOCAL_MEM_FENCE: i64 = 1;
const GLOBAL_MEM_FENCE: i64 = 2;

#[patterns(converter, options = LlvmOptions)]
impl GpuToLlvmSpv {
    #[convert("gpu.barrier")]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let i32t = Type::int(32);
        let flags = match cr.rw.body[op].get("address_spaces") {
            Some(Attribute::Array(xs)) => xs.iter().filter_map(|x| AddressSpace::try_from(x).ok()).fold(0, |f, s| match s {
                AddressSpace::Global => f | GLOBAL_MEM_FENCE,
                AddressSpace::Workgroup => f | LOCAL_MEM_FENCE,
                AddressSpace::Private | AddressSpace::Constant => f,
            }),
            _ => LOCAL_MEM_FENCE | GLOBAL_MEM_FENCE,
        };
        let f = SpirvFn { name: "_Z7barrierj", params: vec![i32t.clone()], ret: LlvmType::void(), mem_none: false, convergent: true };
        cr.rw.set_before(op);
        let flag = cr.llvm_constant(Attribute::of_int(flags.into(), i32t.clone()), i32t);
        if f.call(cr, op, &[flag]).is_none() {
            return false;
        }
        cr.erase(op);
        true
    }

    fn launch(cr: &mut Cr<'_, '_, '_>, op: OpId, o: LlvmOptions, name: &str) -> bool {
        let Some(dim) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        let i32t = Type::int(32);
        let f = SpirvFn { name, params: vec![i32t.clone()], ret: o.index(), mem_none: true, convergent: false };
        cr.rw.set_before(op);
        let d = cr.llvm_constant(Attribute::of_int(dim as i128, i32t.clone()), i32t);
        let Some(call) = f.call(cr, op, &[d]) else { return false };
        let r = cr.rw.body[call].results[0];
        cr.replace(op, vec![vec![r]]);
        true
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::launch(cr, op, o, "_Z12get_group_idj")
    }

    #[convert("gpu.grid_dim")]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::launch(cr, op, o, "_Z14get_num_groupsj")
    }

    #[convert("gpu.block_dim")]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::launch(cr, op, o, "_Z14get_local_sizej")
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::launch(cr, op, o, "_Z12get_local_idj")
    }

    #[convert("gpu.global_id")]
    fn global_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::launch(cr, op, o, "_Z13get_global_idj")
    }

    fn mangling(t: &Type<'_>) -> Option<&'static str> {
        Some(match t {
            Type::Float(FloatKind::F16) => "Dhj",
            Type::Float(FloatKind::F32) => "fj",
            Type::Float(FloatKind::F64) => "dj",
            Type::Integer { width: 8, .. } => "cj",
            Type::Integer { width: 16, .. } => "sj",
            Type::Integer { width: 32, .. } => "ij",
            Type::Integer { width: 64, .. } => "lj",
            _ => return None,
        })
    }

    fn subgroup_size(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<i128> {
        let b = &*cr.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at.filter(|o| b[*o].name != "llvm.func") {
            at = b.parent_op(o);
        }
        match b[at?].get("intel_reqd_sub_group_size")? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    #[convert("gpu.shuffle")]
    fn shuffle<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let width = cr.rw.body[op].operands[2];
        if Self::subgroup_size(cr, op).is_some_and(|n| cr.rw.body.int_constant(width) != Some(n)) {
            return false;
        }
        let Some(mode) = cr.rw.body[op].get("mode").and_then(|a| ShuffleMode::try_from(a).ok()) else { return false };
        let (value, offset) = (operands[0][0], operands[1][0]);
        let result_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let cast = |cr: &mut Cr<'_, 'a, '_>, v: ValueId, to: Type<'a>, name: &str| cr.build(OpData::build(name).operands(&[v]), to);
        cr.rw.set_before(op);
        let v_ty = cr.rw.body[value].ty.clone();
        let input = match &v_ty {
            Type::Float(FloatKind::BF16) => cast(cr, value, Type::int(16), "llvm.bitcast"),
            Type::Integer { width: 1, .. } => cast(cr, value, Type::int(8), "llvm.zext"),
            _ => value,
        };
        let in_ty = cr.rw.body[input].ty.clone();
        let Some(mangle) = Self::mangling(&in_ty) else { return false };
        let base = mode.spirv_builtin();
        let name = format!("_Z{}{base}{mangle}", base.len());
        let offset_ty = cr.rw.body[offset].ty.clone();
        let f = SpirvFn { name: &name, params: vec![in_ty.clone(), offset_ty], ret: in_ty, mem_none: false, convergent: true };
        let Some(call) = f.call(cr, op, &[input, offset]) else { return false };
        let r = cr.rw.body[call].results[0];
        let r = match &result_ty {
            Type::Float(FloatKind::BF16) => cast(cr, r, result_ty.clone(), "llvm.bitcast"),
            Type::Integer { width: 1, .. } => cast(cr, r, result_ty.clone(), "llvm.trunc"),
            _ => r,
        };
        let valid = cr.llvm_constant(Attribute::Bool(true), Type::int(1));
        cr.replace(op, vec![vec![r], vec![valid]]);
        true
    }

    fn subgroup(cr: &mut Cr<'_, '_, '_>, op: OpId, o: LlvmOptions, name: &str) -> bool {
        if o.index_bitwidth < 32 {
            return false;
        }
        let f = SpirvFn { name, params: Vec::new(), ret: Type::int(32), mem_none: false, convergent: false };
        cr.rw.set_before(op);
        let Some(call) = f.call(cr, op, &[]) else { return false };
        let mut r = cr.rw.body[call].results[0];
        if o.index_bitwidth > 32 {
            r = cr.build(OpData::build("llvm.zext").operands(&[r]), o.index());
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    #[convert("gpu.subgroup_id")]
    fn subgroup_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::subgroup(cr, op, o, "_Z16get_sub_group_id")
    }

    #[convert("gpu.lane_id")]
    fn lane_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::subgroup(cr, op, o, "_Z22get_sub_group_local_id")
    }

    #[convert("gpu.num_subgroups")]
    fn num_subgroups(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::subgroup(cr, op, o, "_Z18get_num_sub_groups")
    }

    #[convert("gpu.subgroup_size")]
    fn subgroup_size_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        Self::subgroup(cr, op, o, "_Z18get_sub_group_size")
    }
}
