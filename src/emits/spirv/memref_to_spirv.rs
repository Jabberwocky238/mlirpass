//! `memref` ⇒ `spirv`, as `MemRefToSPIRV.cpp` and the element pointers of
//! `SPIRVConversion.cpp` (`getElementPtr`, `linearizeIndex`).

use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Shaped, ShapedKind, Type};

use super::SpirvTypes;
use crate::{ConversionRewriter, MemrefLayout, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// What the memref patterns need of the target and the type converter.
#[derive(Debug, Clone, Copy)]
pub struct MemrefSpirvOptions {
    pub index64: bool,
    /// The target allows `Kernel` (OpenCL element pointers).
    pub kernel: bool,
    /// `boolNumBits`.
    pub bool_bits: u32,
}

impl MemrefSpirvOptions {
    fn index<'a>(self) -> Type<'a> {
        Type::int(if self.index64 { 64 } else { 32 })
    }
}

/// The memref ⇒ spirv patterns (`populateMemRefToSPIRVPatterns`).
pub struct MemrefToSpirv;

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// `createOrFold<spirv::IMulOp>` / `<spirv::IAddOp>` (and the other integer ops).
    pub fn spirv_fold_int(&mut self, name: &str, lhs: ValueId, rhs: ValueId) -> ValueId {
        let ty = self.rw.body[lhs].ty.clone();
        self.create_or_fold(OpData::build(name).operands(&[lhs, rhs]), ty)
    }

    /// `OpBuilder::createOrFold`: the op folded away when it folds (to an operand, or to a
    /// constant materialized in its place), else built.
    pub fn create_or_fold(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let ns = alloc::string::String::from(data.name.split_once('.').map_or("", |(n, _)| n));
        let probe = self.rw.body.create(data.clone(), core::slice::from_ref(&ty));
        let folded = self.rw.body.fold(probe);
        self.rw.body.erase(probe);
        match folded {
            crate::Fold::Results(r) if r.len() == 1 => match &r[0] {
                crate::Folded::Value(v) => return *v,
                crate::Folded::Attr(a) => {
                    if let Some(d) = self.rw.body.materialize(&ns, a, &ty) {
                        return self.build(d, ty);
                    }
                }
            },
            _ => {}
        }
        self.build(data, ty)
    }
}

impl MemrefToSpirv {
    fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s),
            _ => None,
        }
    }

    /// `linearizeIndex`.
    pub(crate) fn linearize<'a>(cr: &mut Cr<'_, 'a, '_>, indices: &[ValueId], strides: &[i64], offset: i64, ty: &Type<'a>) -> ValueId {
        let mut lin = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(offset), ty.clone()));
        for (i, s) in indices.iter().zip(strides) {
            let stride = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(*s), ty.clone()));
            let update = cr.spirv_fold_int("spirv.IMul", *i, stride);
            lin = cr.spirv_fold_int("spirv.IAdd", update, lin);
        }
        lin
    }

    /// `getElementPtr` (`getVulkanElementPtr` / `getOpenCLElementPtr`).
    pub(crate) fn element_ptr<'a>(cr: &mut Cr<'_, 'a, '_>, s: &Shaped<'a>, base: ValueId, indices: &[ValueId], o: MemrefSpirvOptions) -> Option<ValueId> {
        let (strides, offset) = s.strides_and_offset()?;
        if strides.contains(&mlirformat::Dim::DYNAMIC) || offset == mlirformat::Dim::DYNAMIC {
            return None;
        }
        let ity = o.index();
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        let SpirvType::Ptr { pointee, storage } = SpirvType::try_from(&cr.rw.body[base].ty).ok()? else { return None };
        if o.kernel {
            let lin = if rank == 0 { cr.spirv_const(ity.clone(), Attribute::integer(0, ity.clone())) } else { Self::linearize(cr, indices, &strides, offset, &ity) };
            return match SpirvType::try_from(&*pointee) {
                Ok(SpirvType::Array { elem, .. }) => Some(cr.build(OpData::build("spirv.AccessChain").operands(&[base, lin]), SpirvType::ptr((*elem).clone(), &storage))),
                _ => Some(cr.build(OpData::build("spirv.PtrAccessChain").operands(&[base, lin]), cr.rw.body[base].ty.clone())),
            };
        }
        let zero = cr.spirv_const(ity.clone(), Attribute::integer(0, ity.clone()));
        let lin = if rank == 0 { zero } else { Self::linearize(cr, indices, &strides, offset, &ity) };
        let Ok(SpirvType::Struct { members: Some(ms), .. }) = SpirvType::try_from(&*pointee) else { return None };
        let elem = match SpirvType::try_from(&ms[0].ty) {
            Ok(SpirvType::Array { elem, .. } | SpirvType::RuntimeArray { elem, .. }) => (*elem).clone(),
            _ => return None,
        };
        Some(cr.build(OpData::build("spirv.AccessChain").operands(&[base, zero, lin]), SpirvType::ptr(elem, &storage)))
    }

    /// `calculateMemoryRequirements`: `memory_access` and `alignment` of a load / store.
    fn requirements<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, ptr: ValueId) -> Option<Vec<(&'static str, Attribute<'a>)>> {
        let nontemporal = matches!(cr.rw.body[op].get("nontemporal"), Some(Attribute::Bool(true)));
        let preferred = cr.rw.body[op].get("alignment").and_then(|a| mlirformat::Const::try_from(a).ok()).and_then(|c| c.as_int()).map_or(0, |i| i.bits() as u64);
        if preferred >= u64::from(u32::MAX) {
            return None;
        }
        let SpirvType::Ptr { pointee, storage } = SpirvType::try_from(&cr.rw.body[ptr].ty).ok()? else { return None };
        if preferred == 0 && storage != "PhysicalStorageBuffer" {
            return Some(if nontemporal { vec![("memory_access", Cr::spirv_enum("memory_access", "Nontemporal"))] } else { Vec::new() });
        }
        if !super::TargetEnv::is_scalar(&pointee) {
            return None;
        }
        let size = u64::from(pointee.bit_width()? / 8);
        let access = if nontemporal { "Aligned|Nontemporal" } else { "Aligned" };
        let align = if preferred != 0 { preferred } else { size };
        Some(vec![("memory_access", Cr::spirv_enum("memory_access", access)), ("alignment", Attribute::integer(i128::from(align), Type::int(32)))])
    }

    /// `isAllocationSupported`.
    fn allocation_supported(cr: &Cr<'_, '_, '_>, op: OpId, t: &Type<'_>) -> bool {
        let Some(s) = Self::memref(t) else { return false };
        let want = if cr.rw.body[op].name == "memref.alloca" { "Function" } else { "Workgroup" };
        if SpirvTypes::storage_class(s).as_deref() != Some(want) || s.dims().is_none_or(|d| d.contains(&mlirformat::Dim::DYNAMIC)) {
            return false;
        }
        let elem = match &*s.elem {
            Type::Shaped(v) if v.kind == ShapedKind::Vector => (*v.elem).clone(),
            e => e.clone(),
        };
        matches!(elem, Type::Integer { .. } | Type::Float(_))
    }

    /// `castIntNToBool`.
    fn int_to_bool<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId) -> ValueId {
        let ty = cr.rw.body[v].ty.clone();
        if ty == Type::I1 {
            return v;
        }
        let zero = cr.spirv_const(ty.clone(), Attribute::integer(0, ty));
        cr.create_or_fold(OpData::build("spirv.INotEqual").operands(&[v, zero]), Type::I1)
    }

    /// `castBoolToIntN`.
    fn bool_to_int<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, ty: Type<'a>) -> ValueId {
        if cr.rw.body[v].ty == ty {
            return v;
        }
        let zero = cr.spirv_const(ty.clone(), Attribute::integer(0, ty.clone()));
        let one = cr.spirv_const(ty.clone(), Attribute::integer(1, ty.clone()));
        cr.create_or_fold(OpData::build("spirv.Select").operands(&[v, one, zero]), ty)
    }

    /// The element type a memref's converted pointer points into.
    fn pointee_elem<'a>(ptr: &Type<'a>, kernel: bool) -> Option<Type<'a>> {
        let SpirvType::Ptr { pointee, .. } = SpirvType::try_from(ptr).ok()? else { return None };
        if kernel {
            return Some(match SpirvType::try_from(&*pointee) {
                Ok(SpirvType::Array { elem, .. }) => (*elem).owned(),
                _ => (*pointee).owned(),
            });
        }
        let Ok(SpirvType::Struct { members: Some(ms), .. }) = SpirvType::try_from(&*pointee) else { return None };
        match SpirvType::try_from(&ms[0].ty) {
            Ok(SpirvType::Array { elem, .. } | SpirvType::RuntimeArray { elem, .. }) => Some((*elem).owned()),
            _ => None,
        }
    }
}

#[patterns(converter, options = MemrefSpirvOptions)]
impl MemrefToSpirv {
    /// `AllocaOpPattern`.
    #[lowering("memref.alloca")]
    fn alloca<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let r = cr.rw.body[op].results[0];
        let t = cr.rw.body[r].ty.clone();
        if !Self::allocation_supported(cr, op, &t) {
            return false;
        }
        let Some(ptr) = cr.converted(&t) else { return false };
        let v = cr.build(OpData::build("spirv.Variable").with("storage_class", Cr::spirv_enum("storage_class", "Function")), ptr);
        cr.replace_values(op, &[v]);
        true
    }

    /// `AllocOpPattern`: a `__workgroup_mem__<n>` global.
    #[lowering("memref.alloc")]
    fn alloc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let r = cr.rw.body[op].results[0];
        let t = cr.rw.body[r].ty.clone();
        if !Self::allocation_supported(cr, op, &t) {
            return false;
        }
        let Some(ptr) = cr.converted(&t) else { return false };
        let b = &cr.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at.filter(|o| !b.is_symbol_table(*o)) {
            at = b.parent_op(o);
        }
        let Some(table) = at else { return false };
        let block = b.top_block(table);
        let n = b[block].ops.iter().filter(|o| b[**o].name == "spirv.GlobalVariable").count();
        let name = format!("__workgroup_mem__{n}");
        let saved = cr.rw.ip;
        cr.rw.set_start(block);
        cr.rw.create(OpData::build("spirv.GlobalVariable").with("sym_name", Attribute::str(&name)).with("type", Attribute::Type(ptr.clone())), &[]);
        cr.rw.ip = saved;
        let v = cr.build(OpData::build("spirv.mlir.addressof").with("variable", Attribute::SymbolRef(vec![name.into()])), ptr);
        cr.replace_values(op, &[v]);
        true
    }

    /// `AtomicRMWOpPattern`: the integer kinds, as `spirv.Atomic*` on the element.
    #[lowering("memref.atomic_rmw")]
    fn atomic_rmw<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let r = cr.rw.body[op].results[0];
        if matches!(cr.rw.body[r].ty, Type::Float(_)) {
            return false;
        }
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let m = cr.rw.body[op].operands[1];
        let Some(s) = Self::memref(&cr.rw.body[m].ty).cloned() else { return false };
        let Some(scope) = Self::atomic_scope(&s) else { return false };
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(ptr) = Self::element_ptr(cr, &s, ops[1], &ops[2..], o) else { return false };
        let kind = cr.rw.body[op].get("kind").and_then(|a| mlirformat::Const::try_from(a).ok()).and_then(|c| c.as_int()).map(|i| i.signed());
        // `arith::AtomicRMWKind`.
        let name = match kind {
            Some(1) => "spirv.AtomicIAdd",
            Some(6) => "spirv.AtomicSMax",
            Some(7) => "spirv.AtomicUMax",
            Some(10) => "spirv.AtomicSMin",
            Some(11) => "spirv.AtomicUMin",
            Some(14) => "spirv.AtomicOr",
            Some(2) => "spirv.AtomicAnd",
            _ => return false,
        };
        let data = OpData::build(name).operands(&[ptr, ops[0]]).with("memory_scope", Cr::spirv_enum("scope", scope)).with("semantics", Cr::spirv_enum("memory_semantics", "AcquireRelease"));
        cr.replace_new(op, data, &[ty]);
        true
    }

    /// `DeallocOpPattern`.
    #[lowering("memref.dealloc")]
    fn dealloc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let m = cr.rw.body[op].operands[0];
        let t = cr.rw.body[m].ty.clone();
        if !Self::allocation_supported(cr, op, &t) {
            return false;
        }
        cr.erase(op);
        true
    }

    /// `LoadOpPattern` / `IntLoadOpPattern`: a narrower integer (`i1` as `boolNumBits`-wide)
    /// in wider words is loaded whole, shifted and sign-extended out.
    #[lowering("memref.load")]
    fn load<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let m = cr.rw.body[op].operands[0];
        let mt = cr.rw.body[m].ty.clone();
        let Some(s) = Self::memref(&mt).cloned() else { return false };
        if matches!(SpirvTypes::storage_class(&s).as_deref(), None | Some("Image")) {
            return false;
        }
        let int = matches!(*s.elem, Type::Integer { signedness: mlirformat::Signedness::Signless, .. });
        let Some(ptr) = Self::element_ptr(cr, &s, ops[0], &ops[1..], o) else { return false };
        if !int {
            let Some(req) = Self::requirements(cr, op, ptr) else { return false };
            let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&cr.rw.body[ptr].ty) else { return false };
            let v = cr.build(Self::with_req(OpData::build("spirv.Load").operands(&[ptr]), req), (*pointee).owned());
            cr.replace_values(op, &[v]);
            return true;
        }
        let bool_ = s.elem.bit_width() == Some(1);
        let src_bits = if bool_ { o.bool_bits } else { s.elem.bit_width().unwrap_or(32) };
        let Some(dst) = cr.converted(&mt).and_then(|t| Self::pointee_elem(&t, o.kernel)) else { return false };
        let dst_bits = dst.bit_width().unwrap_or(32);
        if src_bits == dst_bits {
            let Some(req) = Self::requirements(cr, op, ptr) else { return false };
            let mut v = cr.build(Self::with_req(OpData::build("spirv.Load").operands(&[ptr]), req), dst);
            if bool_ {
                v = Self::int_to_bool(cr, v);
            }
            cr.replace_values(op, &[v]);
            return true;
        }
        if o.kernel {
            return false;
        }
        let Some(chain) = cr.rw.body.def_op(ptr).filter(|d| cr.rw.body[*d].name == "spirv.AccessChain") else { return false };
        let last = *cr.rw.body[chain].operands.last().expect("indices");
        let adjusted = Self::adjust_chain(cr, chain, src_bits, dst_bits);
        let Some(req) = Self::requirements(cr, op, adjusted) else { return false };
        let word = cr.build(Self::with_req(OpData::build("spirv.Load").operands(&[adjusted]), req), dst.clone());
        let offset = Self::bit_offset(cr, last, src_bits, dst_bits);
        let mut r = cr.create_or_fold(OpData::build("spirv.ShiftRightArithmetic").operands(&[word, offset]), dst.clone());
        let mask = Self::int_const(cr, &dst, (1i128 << src_bits) - 1);
        r = cr.create_or_fold(OpData::build("spirv.BitwiseAnd").operands(&[r, mask]), dst.clone());
        let shift = Self::int_const(cr, &dst, i128::from(dst_bits - src_bits));
        r = cr.create_or_fold(OpData::build("spirv.ShiftLeftLogical").operands(&[r, shift]), dst.clone());
        r = cr.create_or_fold(OpData::build("spirv.ShiftRightArithmetic").operands(&[r, shift]), dst);
        cr.replace_values(op, &[r]);
        cr.erase(chain);
        true
    }

    /// `ImageLoadOpPattern`: a scalar out of a sampled image, fetched as a texel's red.
    #[lowering("memref.load")]
    fn image_load<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let m = cr.rw.body[op].operands[0];
        let mt = cr.rw.body[m].ty.clone();
        let Some(s) = Self::memref(&mt).cloned() else { return false };
        if SpirvTypes::storage_class(&s).as_deref() != Some("Image") {
            return false;
        }
        let Some(req) = Self::requirements(cr, op, ops[0]) else { return false };
        let Some(rank) = s.shape.as_ref().map(Vec::len) else { return false };
        if !super::TargetEnv::is_scalar(&s.elem) {
            return false;
        }
        let Some(SpirvType::Ptr { pointee, .. }) = cr.converted(&mt).and_then(|t| SpirvType::try_from(&t).ok()) else { return false };
        let Ok(SpirvType::SampledImage(image)) = SpirvType::try_from(&*pointee) else { return false };
        let sampled = cr.build(Self::with_req(OpData::build("spirv.Load").operands(&[ops[0]]), req), (*pointee).owned());
        let img = cr.build(OpData::build("spirv.Image").operands(&[sampled]), (*image).owned());
        let coords = match rank {
            1 => ops[1],
            _ => {
                // `extractLoadCoordsForComposite`: in layout order, fastest moving first.
                let perm: Vec<usize> = match s.layout() {
                    None => (0..rank).collect(),
                    Some(Attribute::Builtin { name, body, .. }) if name == "affine_map" => {
                        let Some(map) = mlirformat::AffineMap::parse(body) else { return false };
                        let Some(perm) = map.results.iter().map(|e| match e { mlirformat::AffineExpr::Dim(d) => Some(*d as usize), _ => None }).collect::<Option<Vec<_>>>() else { return false };
                        if perm.len() != rank || map.dims as usize != rank {
                            return false;
                        }
                        perm
                    }
                    _ => return false,
                };
                let mut coords = vec![ops[1]; rank];
                for (pos, d) in perm.iter().enumerate() {
                    coords[pos] = ops[1 + d];
                }
                coords.reverse();
                let ity = cr.rw.body[ops[1]].ty.clone();
                cr.build(OpData::build("spirv.CompositeConstruct").operands(&coords), Type::vector(&[rank as i64], &[], ity))
            }
        };
        let elem = (*s.elem).clone();
        let texel = cr.build(OpData::build("spirv.ImageFetch").operands(&[img, coords]), Type::vector(&[4], &[], elem.clone()));
        let v = cr.build(OpData::build("spirv.CompositeExtract").operands(&[texel]).with("indices", Attribute::Array(vec![Attribute::integer(0, Type::int(32))])), elem);
        cr.replace_values(op, &[v]);
        true
    }

    /// `StoreOpPattern` / `IntStoreOpPattern`: a narrower integer in wider words is stored
    /// by clearing its bits and or-ing them in, atomically.
    #[lowering("memref.store")]
    fn store<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let m = cr.rw.body[op].operands[1];
        let mt = cr.rw.body[m].ty.clone();
        let Some(s) = Self::memref(&mt).cloned() else { return false };
        let int = matches!(*s.elem, Type::Integer { signedness: mlirformat::Signedness::Signless, .. });
        let Some(ptr) = Self::element_ptr(cr, &s, ops[1], &ops[2..], o) else { return false };
        if !int {
            let Some(req) = Self::requirements(cr, op, ptr) else { return false };
            cr.replace_new(op, Self::with_req(OpData::build("spirv.Store").operands(&[ptr, ops[0]]), req), &[]);
            return true;
        }
        let bool_ = s.elem.bit_width() == Some(1);
        let src_bits = if bool_ { o.bool_bits } else { s.elem.bit_width().unwrap_or(32) };
        let Some(dst) = cr.converted(&mt).and_then(|t| Self::pointee_elem(&t, o.kernel)) else { return false };
        let dst_bits = dst.bit_width().unwrap_or(32);
        if src_bits == dst_bits {
            let Some(req) = Self::requirements(cr, op, ptr) else { return false };
            let value = if bool_ { Self::bool_to_int(cr, ops[0], dst) } else { ops[0] };
            cr.replace_new(op, Self::with_req(OpData::build("spirv.Store").operands(&[ptr, value]), req), &[]);
            return true;
        }
        if o.kernel {
            return false;
        }
        let Some(chain) = cr.rw.body.def_op(ptr).filter(|d| cr.rw.body[*d].name == "spirv.AccessChain") else { return false };
        let last = *cr.rw.body[chain].operands.last().expect("indices");
        let offset = Self::bit_offset(cr, last, src_bits, dst_bits);
        let mask = Self::int_const(cr, &dst, (1i128 << src_bits) - 1);
        let clear = cr.create_or_fold(OpData::build("spirv.ShiftLeftLogical").operands(&[mask, offset]), dst.clone());
        let clear = cr.create_or_fold(OpData::build("spirv.Not").operands(&[clear]), dst.clone());
        // `shiftValue`.
        let mut v = ops[0];
        let vbits = cr.rw.body[v].ty.bit_width().unwrap_or(32);
        if vbits == 1 {
            v = Self::bool_to_int(cr, v, dst.clone());
        } else {
            if vbits < dst_bits {
                v = cr.build(OpData::build("spirv.UConvert").operands(&[v]), Type::int(dst_bits));
            }
            v = cr.create_or_fold(OpData::build("spirv.BitwiseAnd").operands(&[v, mask]), dst.clone());
        }
        let v = cr.create_or_fold(OpData::build("spirv.ShiftLeftLogical").operands(&[v, offset]), dst.clone());
        let adjusted = Self::adjust_chain(cr, chain, src_bits, dst_bits);
        let Some(scope) = Self::atomic_scope(&s) else { return false };
        for (name, val) in [("spirv.AtomicAnd", clear), ("spirv.AtomicOr", v)] {
            let data = OpData::build(name).operands(&[adjusted, val]).with("memory_scope", Cr::spirv_enum("scope", scope)).with("semantics", Cr::spirv_enum("memory_semantics", "AcquireRelease"));
            cr.build(data, dst.clone());
        }
        cr.erase(op);
        cr.erase(chain);
        true
    }

    /// `MemorySpaceCastOpPattern`: through a generic pointer (kernels only).
    #[lowering("memref.memory_space_cast")]
    fn memory_space_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        if !o.kernel {
            return false;
        }
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (src, r) = (cr.rw.body[op].operands[0], cr.rw.body[op].results[0]);
        let (Some(st), Some(rt)) = (Self::memref(&cr.rw.body[src].ty).cloned(), Self::memref(&cr.rw.body[r].ty).cloned()) else { return false };
        let (Some(ssc), Some(rsc)) = (SpirvTypes::storage_class(&st), SpirvTypes::storage_class(&rt)) else { return false };
        let Some(result_ptr) = cr.converted(&Type::Shaped(rt)) else { return false };
        let mut generic = result_ptr.clone();
        if ssc != "Generic" && rsc != "Generic" {
            let mut via = st.clone();
            via.extras.retain(|a| a.is_layout());
            via.extras.push(Cr::spirv_enum("storage_class", "Generic"));
            let Some(g) = cr.converted(&Type::Shaped(via)) else { return false };
            generic = g;
        }
        let mut v = ops[0];
        if ssc != "Generic" {
            v = cr.build(OpData::build("spirv.PtrCastToGeneric").operands(&[v]), generic);
        }
        if rsc != "Generic" {
            v = cr.build(OpData::build("spirv.GenericCastToPtr").operands(&[v]), result_ptr);
        }
        cr.replace_values(op, &[v]);
        true
    }

    /// `ReinterpretCastPattern`: the same pointer, offset by the cast's offset.
    #[lowering("memref.reinterpret_cast")]
    fn reinterpret_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let src = ops[0];
        let st = cr.rw.body[src].ty.clone();
        if !matches!(SpirvType::try_from(&st), Ok(SpirvType::Ptr { .. })) {
            return false;
        }
        let r = cr.rw.body[op].results[0];
        if cr.converted(&cr.rw.body[r].ty.clone()).as_ref() != Some(&st) {
            return false;
        }
        let Some(statics) = cr.rw.body[op].get("static_offsets").and_then(Attribute::dense_values) else { return false };
        let Some(&first) = statics.first() else { return false };
        let offset = if first == mlirformat::Dim::DYNAMIC {
            let Some(segs) = cr.rw.body.segments(op, "operandSegmentSizes") else { return false };
            let Some(&v) = ops.get(segs[0]) else { return false };
            Some(v)
        } else if first == 0 {
            None
        } else {
            let Some(ity) = cr.converted(&Type::Index) else { return false };
            Some(cr.spirv_const(ity.clone(), Attribute::integer(i128::from(first), ity)))
        };
        match offset {
            None => cr.replace_values(op, &[src]),
            Some(off) => {
                cr.replace_new(op, OpData::build("spirv.InBoundsPtrAccessChain").operands(&[src, off]), &[st]);
            }
        }
        true
    }

    /// `CastPattern`: nothing to do once both sides convert alike.
    #[lowering("memref.cast")]
    fn cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        if cr.converted(&cr.rw.body[r].ty.clone()).as_ref() != Some(&cr.rw.body[ops[0]].ty) {
            return false;
        }
        cr.replace_values(op, &ops);
        true
    }

    /// `ExtractAlignedPointerAsIndexOpPattern`.
    #[lowering("memref.extract_aligned_pointer_as_index")]
    fn extract_aligned_pointer<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], _: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ity) = cr.converted(&Type::Index) else { return false };
        cr.replace_new(op, OpData::build("spirv.ConvertPtrToU").operands(&ops), &[ity]);
        true
    }
}

impl MemrefToSpirv {
    /// `getAtomicOpScope`.
    fn atomic_scope(s: &Shaped<'_>) -> Option<&'static str> {
        match SpirvTypes::storage_class(s).as_deref() {
            Some("StorageBuffer") => Some("Device"),
            Some("Workgroup") => Some("Workgroup"),
            _ => None,
        }
    }
    fn with_req<'a>(mut data: OpData<'a>, req: Vec<(&str, Attribute<'a>)>) -> OpData<'a> {
        for (k, v) in req {
            data.set(k, v);
        }
        data
    }

    /// `createOrFold<spirv::ConstantOp>` of an integer.
    fn int_const<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>, v: i128) -> ValueId {
        cr.spirv_const(ty.clone(), Attribute::integer(v, ty.clone()))
    }

    /// `getOffsetForBitwidth`: `(index % (dst / src)) * src`.
    fn bit_offset<'a>(cr: &mut Cr<'_, 'a, '_>, index: ValueId, src: u32, dst: u32) -> ValueId {
        let ty = cr.rw.body[index].ty.clone();
        let per = Self::int_const(cr, &ty, i128::from(dst / src));
        let bits = Self::int_const(cr, &ty, i128::from(src));
        let m = cr.create_or_fold(OpData::build("spirv.UMod").operands(&[index, per]), ty.clone());
        cr.create_or_fold(OpData::build("spirv.IMul").operands(&[m, bits]), ty)
    }

    /// `adjustAccessChainForBitwidth`: the chain's last index divided by `dst / src`.
    fn adjust_chain<'a>(cr: &mut Cr<'_, 'a, '_>, chain: OpId, src: u32, dst: u32) -> ValueId {
        let mut indices = cr.rw.body[chain].operands.clone();
        let base = indices.remove(0);
        let last = *indices.last().expect("indices");
        let ty = cr.rw.body[last].ty.clone();
        let per = Self::int_const(cr, &ty, i128::from(dst / src));
        *indices.last_mut().expect("indices") = cr.create_or_fold(OpData::build("spirv.SDiv").operands(&[last, per]), ty);
        let t = cr.rw.body[cr.rw.body[chain].results[0]].ty.clone();
        let mut all = vec![base];
        all.extend(indices);
        cr.build(OpData::build("spirv.AccessChain").operands(&all), t)
    }
}
