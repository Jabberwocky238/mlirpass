//! `amdgpu` memory ops ⇒ `rocdl`, as `AMDGPUToROCDL.cpp`'s `TransposeLoadOpLowering` and
//! `GatherToLDSOpLowering`: an element pointer into the memref, one intrinsic.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Shaped, ShapedKind, Type};

use super::AmdgpuOperands;
use crate::patterns;
use crate::{AmdChipset, AmdgpuRocdlOptions, ConversionRewriter, MemrefToLlvm, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kGfx950`.
const GFX950: AmdChipset = AmdChipset::new(9, 5, 0);
/// `kGfx1200`.
const GFX1200: AmdChipset = AmdChipset::new(12, 0, 0);
/// `kGfx1250`.
const GFX1250: AmdChipset = AmdChipset::new(12, 5, 0);

/// The LDS transpose load of each element width on gfx950 / gfx1250+, and the elements it loads.
const TRANSPOSE_LOADS: [(u32, &str, &str, usize, usize); 4] = [
    (4, "rocdl.ds.read.tr4.b64", "rocdl.ds.load.tr4.b64", 16, 16),
    (6, "rocdl.ds.read.tr6.b96", "rocdl.ds.load.tr6.b96", 16, 16),
    (8, "rocdl.ds.read.tr8.b64", "rocdl.ds.load.tr8.b64", 8, 8),
    (16, "rocdl.ds.read.tr16.b64", "rocdl.ds.load.tr16.b128", 4, 8),
];

/// The global transpose load of each element width, and whether it needs gfx1250.
const GLOBAL_TRANSPOSE_LOADS: [(u32, &str, bool); 4] = [(4, "rocdl.global.load.tr4.b64", true), (6, "rocdl.global.load.tr6.b96", true), (8, "rocdl.global.load.tr.b64", false), (16, "rocdl.global.load.tr.b128", false)];

/// `GEPNoWrapFlags::inbounds | GEPNoWrapFlags::nuw`.
const INBOUNDS_NUW: i64 = 7;

/// `getGlobalPrefetchLLVMEncoding` as `#rocdl<gfx12_cache_policy ..>` names: the temporal hint
/// (bits 2:0) of each `amdgpu.load_temporal_hint`, then the scope (bits 4:3) of each
/// `amdgpu.cache_scope`.
const PREFETCH_HINTS: [(&str, u32); 7] = [("RT", 0), ("NT", 1), ("HT", 2), ("LU", 3), ("NT_RT", 4), ("RT_NT", 5), ("NT_HT", 6)];
const PREFETCH_SCOPES: [(&str, u32); 4] = [("WGP", 0), ("SE", 1), ("DEV", 2), ("SYS", 3)];
/// The printed groups of the temporal bits, by value, and of the scope bits.
const GFX12_TEMPORAL: [&str; 8] = ["", "nt", "ht", "lu", "nt_rt", "rt_nt", "nt_ht", "nt_wb"];
const GFX12_SCOPE: [&str; 4] = ["", "scope_se", "scope_dev", "scope_sys"];

/// The amdgpu memory ops.
pub struct AmdgpuMemToRocdl;

#[patterns(converter, options = AmdgpuRocdlOptions)]
impl AmdgpuMemToRocdl {
    fn memref<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<Shaped<'a>> {
        match &cr.rw.body[v].ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(*s.clone()),
            _ => None,
        }
    }

    /// `getStridedElementPtr` of original operand `k` (a memref) at operand group `g`.
    fn element_ptr(cr: &mut Cr<'_, '_, '_>, op: OpId, seg: &AmdgpuOperands<'_>, k: usize, g: usize, flags: i64, o: AmdgpuRocdlOptions) -> Option<ValueId> {
        let mem = cr.rw.body[op].operands.get(k).copied()?;
        let s = Self::memref(cr, mem)?;
        let desc = seg.one(g)?;
        let indices: Vec<ValueId> = seg.group(g + 1).collect();
        MemrefToLlvm::strided_ptr(cr, o.llvm, &s, desc, &indices, flags)
    }

    /// `TransposeLoadOpLowering` (gfx950, gfx1250+).
    #[convert("amdgpu.transpose_load")]
    fn transpose_load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        let new = o.chipset >= GFX1250;
        if o.chipset != GFX950 && !new {
            return false;
        }
        let body = &cr.rw.body;
        let (src, res_ty) = (body[op].operands[0], body[body[op].results[0]].ty.clone());
        let Some(s) = Self::memref(cr, src) else { return false };
        if s.elem.bit_width().is_none_or(|w| w < 8) {
            return false;
        }
        let (Some(n), Some(w)) = (res_ty.element_count(), res_ty.element_type().bit_width()) else { return false };
        let Some(&(_, old_name, new_name, old_n, new_n)) = TRANSPOSE_LOADS.iter().find(|(bits, ..)| *bits == w) else { return false };
        let (name, want) = if new { (new_name, new_n) } else { (old_name, old_n) };
        if n != want {
            return false;
        }
        let Some(llvm_ty) = cr.converted(&res_ty) else { return false };
        let seg = AmdgpuOperands::new(cr, op, operands);
        cr.rw.set_before(op);
        let Some(ptr) = Self::element_ptr(cr, op, &seg, 0, 0, 0, o) else { return false };
        let raw = Self::transpose_type(n, w, &llvm_ty);
        let mut r = cr.build(OpData::build(name).operands(&[ptr]), raw.clone());
        if raw != llvm_ty {
            r = cr.build(OpData::build("llvm.bitcast").operands(&[r]), llvm_ty);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// What a transpose load returns: dwords below 16-bit elements, else the result itself.
    fn transpose_type<'a>(n: usize, w: u32, llvm: &Type<'a>) -> Type<'a> {
        if w < 16 { Type::vector(&[(n as i64 * i64::from(w)) / 32], &[false], Type::int(32)) } else { llvm.clone() }
    }

    /// `GlobalTransposeLoadOpLowering` (gfx1200+; 4- and 6-bit on gfx1250+).
    #[convert("amdgpu.global_transpose_load")]
    fn global_transpose_load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if o.chipset < GFX1200 {
            return false;
        }
        let res_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let (Some(n), Some(w)) = (res_ty.element_count(), res_ty.element_type().bit_width()) else { return false };
        let Some(&(_, name, gfx1250)) = GLOBAL_TRANSPOSE_LOADS.iter().find(|(bits, ..)| *bits == w) else { return false };
        if gfx1250 && o.chipset < GFX1250 {
            return false;
        }
        let Some(llvm_ty) = cr.converted(&res_ty) else { return false };
        let seg = AmdgpuOperands::new(cr, op, operands);
        cr.rw.set_before(op);
        let Some(ptr) = Self::element_ptr(cr, op, &seg, 0, 0, INBOUNDS_NUW, o) else { return false };
        let r = if w == 16 {
            cr.build(OpData::build(name).operands(&[ptr]), llvm_ty)
        } else {
            let r = cr.build(OpData::build(name).operands(&[ptr]), Self::transpose_type(n, w, &llvm_ty));
            cr.build(OpData::build("llvm.bitcast").operands(&[r]), llvm_ty)
        };
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `GlobalPrefetchOpLowering` (gfx1250+): the hint and scope as a gfx12 cache policy.
    #[convert("amdgpu.global_prefetch")]
    fn global_prefetch(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if o.chipset < GFX1250 {
            return false;
        }
        let b = &*cr.rw.body;
        let case = |name: &str| match b[op].get(name) {
            Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().and_then(|s| s.trim_end_matches('>').split_whitespace().last()).map(alloc::string::String::from),
            _ => None,
        };
        let speculative = b[op].get("speculative").is_some();
        let (Some(hint), Some(scope)) = (case("temporalHint"), case("cacheScope")) else { return false };
        let (Some(&(_, mut h)), Some(&(_, sc))) = (PREFETCH_HINTS.iter().find(|(n, _)| *n == hint), PREFETCH_SCOPES.iter().find(|(n, _)| *n == scope)) else { return false };
        // (only RT and HT also run non-speculatively, with bit 0 set)
        if matches!(hint.as_str(), "RT" | "HT") && !speculative {
            h |= 1;
        }
        let names: Vec<&str> = [GFX12_TEMPORAL[h as usize], GFX12_SCOPE[sc as usize]].into_iter().filter(|n| !n.is_empty()).collect();
        let policy = if names.is_empty() { alloc::string::String::from("none") } else { names.join("|") };
        let seg = AmdgpuOperands::new(cr, op, operands);
        cr.rw.set_before(op);
        let Some(ptr) = Self::element_ptr(cr, op, &seg, 0, 0, if speculative { 0 } else { INBOUNDS_NUW }, o) else { return false };
        let data = OpData::build("rocdl.global.prefetch").operands(&[ptr]).with("cachePolicy", Attribute::dialect("rocdl", &alloc::format!("<gfx12_cache_policy {policy}>")));
        cr.replace_new(op, data, &[]);
        true
    }

    /// `GatherToLDSOpLowering` (gfx9 / gfx10; 12- and 16-byte loads on gfx950).
    #[convert("amdgpu.gather_to_lds")]
    fn gather_to_lds(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: AmdgpuRocdlOptions) -> bool {
        if !(9..=10).contains(&o.chipset.major) {
            return false;
        }
        let Some(Attribute::Type(t)) = cr.rw.body[op].get("transferType") else { return false };
        let Some(width) = t.element_count().zip(t.element_type().bit_width()).map(|(n, w)| n as u32 * w / 8) else { return false };
        if ![1, 2, 4, 12, 16].contains(&width) || (o.chipset != GFX950 && width >= 12) {
            return false;
        }
        let seg = AmdgpuOperands::new(cr, op, operands);
        let dst = seg.groups.first().map_or(0, |g| g.len()) + seg.groups.get(1).map_or(0, |g| g.len());
        cr.rw.set_before(op);
        let (Some(src), Some(dst)) = (Self::element_ptr(cr, op, &seg, 0, 0, 0, o), Self::element_ptr(cr, op, &seg, dst, 2, 0, o)) else { return false };
        let i32a = |v: u32| Attribute::of_int(v.into(), Type::int(32));
        let name = if cr.rw.body[op].get("async").is_some() { "rocdl.load.async.to.lds" } else { "rocdl.load.to.lds" };
        let data = OpData::build(name).operands(&[src, dst]).with("size", i32a(width)).with("offset", i32a(0)).with("aux", i32a(0));
        cr.replace_new(op, data, &[]);
        true
    }
}
