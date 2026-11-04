//! `amdgpu` ⇒ `rocdl`, as `AMDGPUToROCDL.cpp` (the cross-lane ops so far).

use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Type};

use crate::patterns;
use crate::{AmdChipset, AmdgpuRocdlOptions, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);
/// `kGfx90a`.
const GFX90A: AmdChipset = AmdChipset::new(9, 0, 0xa);

/// `amdgpu::sched_barrier_opt_enum` bits.
const SCHED_BARRIER_OPTS: [(&str, u32); 12] = [
    ("none", 0),
    ("non_mem_non_sideffect", 1),
    ("valu", 2),
    ("salu", 4),
    ("mfma_wmma", 8),
    ("all_vmem", 16),
    ("vmem_read", 32),
    ("vmem_write", 64),
    ("all_ds", 128),
    ("ds_read", 256),
    ("ds_write", 512),
    ("transcendental", 1024),
];

/// `amdgpu::DPPPerm` with its `DppCtrl` base (`SIDefines.h`); the row ops add their argument.
const DPP_PERMS: [(&str, u32); 12] = [
    ("quad_perm", 0),
    ("row_shl", 0x100),
    ("row_shr", 0x110),
    ("row_ror", 0x120),
    ("wave_shl", 0x130),
    ("wave_shr", 0x138),
    ("wave_ror", 0x13C),
    ("wave_rol", 0x134),
    ("row_mirror", 0x140),
    ("row_half_mirror", 0x141),
    ("row_bcast_15", 0x142),
    ("row_bcast_31", 0x143),
];

/// `LLVM::AtomicOrdering` of the LDS barrier fences.
#[derive(Debug, Clone, Copy)]
enum Ordering {
    Acquire = 4,
    Release = 5,
}

/// The counters `amdgpu.memory_counter_wait` names, with their gfx12 wait ops.
const WAIT_COUNTERS: [(&str, &str); 5] = [("ds", "rocdl.s.wait.dscnt"), ("load", "rocdl.s.wait.loadcnt"), ("store", "rocdl.s.wait.storecnt"), ("exp", "rocdl.s.wait.expcnt"), ("tensor", "rocdl.s.wait.tensorcnt")];

/// The amdgpu ⇒ rocdl patterns (`populateAMDGPUToROCDLConversionPatterns`).
pub struct AmdgpuToRocdl;

#[patterns(converter, options = AmdgpuRocdlOptions, extra = Self::others)]
impl AmdgpuToRocdl {
    /// The rule sets of the other files.
    fn others(patterns: &mut crate::ConversionPatterns<'_>, tc: usize, o: AmdgpuRocdlOptions) {
        super::cvt_to_rocdl::AmdgpuCvtToRocdl::populate(patterns, tc, o);
        super::mem_to_rocdl::AmdgpuMemToRocdl::populate(patterns, tc, o);
        super::buffer_to_rocdl::AmdgpuBufferToRocdl::populate(patterns, tc, o);
    }

    fn int_attr(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<i64> {
        match cr.rw.body[op].get(name)? {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            _ => None,
        }
    }

    fn flag(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> bool {
        matches!(cr.rw.body[op].get(name), Some(Attribute::Bool(true) | Attribute::Unit))
    }

    fn i32(v: i64) -> Attribute<'static> {
        Attribute::of_int(v.into(), Type::int(32))
    }

    /// `SchedBarrierOpLowering`: the option bits as the mask.
    #[convert("amdgpu.sched_barrier")]
    fn sched_barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: AmdgpuRocdlOptions) -> bool {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("opts") else { return false };
        let Some(body) = ext.body.as_deref().and_then(|b| b.strip_prefix('<')?.strip_suffix('>')) else { return false };
        let mut mask = 0;
        for name in body.split('|').map(str::trim) {
            let Some((_, bit)) = SCHED_BARRIER_OPTS.iter().find(|(n, _)| *n == name) else { return false };
            mask |= bit;
        }
        cr.replace_new(op, OpData::build("rocdl.sched.barrier").with("mask", Self::i32(mask.into())), &[]);
        true
    }

    fn fence(cr: &mut Cr<'_, '_, '_>, ordering: Ordering) -> OpId {
        let data = OpData::build("llvm.fence")
            .with("ordering", Attribute::i64(ordering as i64))
            .with("syncscope", Attribute::str("workgroup"))
            .with("llvm.mmra", Attribute::dialect("llvm.mmra_tag", "<\"amdgpu-synchronize-as\":\"local\">"));
        cr.rw.create(data, &[])
    }

    /// `LDSBarrierOpLowering`: an LDS-only release / barrier / acquire.
    #[convert("amdgpu.lds_barrier")]
    fn lds_barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
        cr.rw.set_before(op);
        Self::fence(cr, Ordering::Release);
        if chipset < GFX90A {
            let data = OpData::build("llvm.inline_asm")
                .with("asm_dialect", Attribute::i64(0))
                .with("asm_string", Attribute::str(";;;WARNING: BREAKS DEBUG WATCHES\ns_barrier"))
                .with("constraints", Attribute::str(""))
                .with("has_side_effects", Attribute::Unit)
                .with("tail_call_kind", Attribute::dialect("llvm.tailcallkind", "<none>"));
            cr.rw.create(data, &[]);
        } else if chipset.major < 12 {
            cr.rw.create(OpData::build("rocdl.s.barrier"), &[]);
        } else {
            cr.rw.create(OpData::build("rocdl.s.barrier.signal").with("id", Self::i32(-1)), &[]);
            cr.rw.create(OpData::build("rocdl.s.barrier.wait").with("id", Attribute::of_int((-1).into(), Type::int(16))), &[]);
        }
        Self::fence(cr, Ordering::Acquire);
        cr.erase(op);
        true
    }

    /// `encodeWaitcnt`: the pre-gfx12 `s_waitcnt` bitfield.
    fn waitcnt(chipset: AmdChipset, vm: i64, exp: i64, lgkm: i64) -> Option<i64> {
        let (exp, vm) = (exp.min(7), vm.min(if chipset.major < 9 { 15 } else { 63 }));
        match chipset.major {
            ..9 => Some(vm | (exp << 4) | (lgkm.min(15) << 8)),
            9 | 10 => Some((vm & 0xF) | ((vm >> 4) << 14) | (exp << 4) | (lgkm.min(if chipset.major == 9 { 15 } else { 63 }) << 8)),
            11 => Some((vm << 10) | exp | (lgkm.min(63) << 4)),
            _ => None,
        }
    }

    /// `MemoryCounterWaitOpLowering`: the gfx12 per-counter waits, else one `s_waitcnt`.
    #[convert("amdgpu.memory_counter_wait")]
    fn memory_counter_wait(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
        let count = |cr: &Cr<'_, '_, '_>, n: &str| Self::int_attr(cr, op, n);
        if chipset.major >= 12 {
            cr.rw.set_before(op);
            for (n, wait) in WAIT_COUNTERS {
                if let Some(c) = count(cr, n) {
                    cr.rw.create(OpData::build(wait).with("count", Attribute::of_int(c.into(), Type::int(16))), &[]);
                }
            }
            cr.erase(op);
            return true;
        }
        if count(cr, "tensor").is_some() {
            return false;
        }
        let or_max = |v: Option<i64>| v.unwrap_or(1024);
        let vm = match (count(cr, "load"), count(cr, "store")) {
            (Some(l), Some(s)) => l + s,
            (l, s) => or_max(l.or(s)),
        };
        let Some(bits) = Self::waitcnt(chipset, vm, or_max(count(cr, "exp")), or_max(count(cr, "ds"))) else { return false };
        cr.replace_new(op, OpData::build("rocdl.s.waitcnt").with("bitfield", Self::i32(bits)), &[]);
        true
    }

    /// `dpp_ctrl` of `amdgpu.dpp`'s `kind` and `permArgument`.
    fn dpp_ctrl(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<u32> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("kind") else { return None };
        let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim();
        let kind = body.strip_prefix("dpp_perm").map_or(body, str::trim);
        let &(name, base) = DPP_PERMS.iter().find(|(n, _)| *n == kind)?;
        let arg = cr.rw.body[op].get("permArgument");
        Some(match (name, arg) {
            ("quad_perm", Some(Attribute::Array(lanes))) => lanes.iter().enumerate().try_fold(0, |acc, (i, l)| match l {
                Attribute::Int { lit, .. } => Some(acc | (lit.parse::<u32>().ok()? << (i * 2))),
                _ => None,
            })?,
            ("row_shl" | "row_shr" | "row_ror", Some(Attribute::Int { lit, .. })) => base + lit.parse::<u32>().ok()?,
            ("quad_perm" | "row_shl" | "row_shr" | "row_ror", _) => return None,
            _ => base,
        })
    }

    /// `convertOperand`: a value of `w` ≤ 16 bits as the low lanes of `wide` (an i32).
    fn dword<'a>(cr: &mut Cr<'_, 'a, '_>, mut v: ValueId, w: u32, float: bool, wide: Type<'a>) -> ValueId {
        if w > 16 {
            return v;
        }
        let int = Type::int(w);
        if float {
            v = cr.build(OpData::build("llvm.bitcast").operands(&[v]), int.clone());
        }
        let vt = Type::vector(&[i64::from(32 / w)], &[false], int);
        let u = cr.build(OpData::build("llvm.mlir.undef"), vt.clone());
        let c = cr.llvm_constant(Self::i32(0), Type::int(32));
        let v = cr.build(OpData::build("llvm.insertelement").operands(&[u, v, c]), vt);
        cr.build(OpData::build("llvm.bitcast").operands(&[v]), wide)
    }

    /// `AMDGPUDPPLowering`: `rocdl.update.dpp`, sub-dword values widened to an i32.
    #[convert("amdgpu.dpp")]
    fn dpp(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: AmdgpuRocdlOptions) -> bool {
        let (old, src) = (operands[0][0], operands[1][0]);
        let src_ty = cr.rw.body[cr.rw.body[op].operands[1]].ty.clone();
        let Some(w) = src_ty.bit_width() else { return false };
        let float = matches!(src_ty, Type::Float(_));
        let wide = match (w < 32, float) {
            (true, _) => Type::int(32),
            (false, true) => src_ty.clone(),
            (false, false) => Type::int(w),
        };
        let int = Type::int(w);
        let (Some(ctrl), Some(row), Some(bank)) = (Self::dpp_ctrl(cr, op), Self::int_attr(cr, op, "row_mask"), Self::int_attr(cr, op, "bank_mask")) else { return false };
        let bound = Self::flag(cr, op, "bound_ctrl");
        cr.rw.set_before(op);
        let src = Self::dword(cr, src, w, float, wide.clone());
        let old = Self::dword(cr, old, w, float, wide.clone());
        let data = OpData::build("rocdl.update.dpp")
            .operands(&[old, src])
            .with("dppCtrl", Self::i32(ctrl.into()))
            .with("rowMask", Self::i32(row))
            .with("bankMask", Self::i32(bank))
            .with("boundCtrl", Attribute::Bool(bound));
        let mut r = cr.build(data, wide.clone());
        if w < 32 {
            r = cr.build(OpData::build("llvm.trunc").operands(&[r]), int);
            if float {
                r = cr.build(OpData::build("llvm.bitcast").operands(&[r]), src_ty);
            }
        }
        cr.replace(op, alloc::vec![alloc::vec![r]]);
        true
    }

    /// `AMDGPUSwizzleBitModeLowering`: `rocdl.ds_swizzle` of each dword.
    #[convert("amdgpu.swizzle_bitmode")]
    fn swizzle_bitmode(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: AmdgpuRocdlOptions) -> bool {
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
    fn permlane_swap(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let chipset = o.chipset;
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
