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
    fn linearize<'a>(cr: &mut Cr<'_, 'a, '_>, indices: &[ValueId], strides: &[i64], offset: i64, ty: &Type<'a>) -> ValueId {
        let mut lin = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(offset), ty.clone()));
        for (i, s) in indices.iter().zip(strides) {
            let stride = cr.spirv_const(ty.clone(), Attribute::integer(i128::from(*s), ty.clone()));
            let update = cr.spirv_fold_int("spirv.IMul", *i, stride);
            lin = cr.spirv_fold_int("spirv.IAdd", update, lin);
        }
        lin
    }

    /// `getElementPtr` (`getVulkanElementPtr` / `getOpenCLElementPtr`).
    fn element_ptr<'a>(cr: &mut Cr<'_, 'a, '_>, s: &Shaped<'a>, base: ValueId, indices: &[ValueId], o: MemrefSpirvOptions) -> Option<ValueId> {
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
        cr.build(OpData::build("spirv.INotEqual").operands(&[v, zero]), Type::I1)
    }

    /// `castBoolToIntN`.
    fn bool_to_int<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, ty: Type<'a>) -> ValueId {
        if cr.rw.body[v].ty == ty {
            return v;
        }
        let zero = cr.spirv_const(ty.clone(), Attribute::integer(0, ty.clone()));
        let one = cr.spirv_const(ty.clone(), Attribute::integer(1, ty.clone()));
        cr.build(OpData::build("spirv.Select").operands(&[v, one, zero]), ty)
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

    /// `LoadOpPattern`, and `IntLoadOpPattern` where the element keeps its width (`i1` as
    /// `boolNumBits`-wide integers).
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
        let mut src_bits = s.elem.bit_width().unwrap_or(32);
        let bool_ = src_bits == 1;
        if bool_ {
            src_bits = o.bool_bits;
        }
        let elem = if int {
            let Some(ptr_t) = cr.converted(&mt) else { return false };
            let Some(e) = Self::pointee_elem(&ptr_t, o.kernel) else { return false };
            if e.bit_width() != Some(src_bits) {
                return false;
            }
            Some(e)
        } else {
            None
        };
        let Some(ptr) = Self::element_ptr(cr, &s, ops[0], &ops[1..], o) else { return false };
        let Some(req) = Self::requirements(cr, op, ptr) else { return false };
        let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&cr.rw.body[ptr].ty) else { return false };
        let mut data = OpData::build("spirv.Load").operands(&[ptr]);
        for (k, v) in req {
            data.set(k, v);
        }
        let mut v = cr.build(data, elem.unwrap_or_else(|| (*pointee).owned()));
        if bool_ {
            v = Self::int_to_bool(cr, v);
        }
        cr.replace_values(op, &[v]);
        true
    }

    /// `StoreOpPattern`, and `IntStoreOpPattern` where the element keeps its width.
    #[lowering("memref.store")]
    fn store<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefSpirvOptions) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let m = cr.rw.body[op].operands[1];
        let mt = cr.rw.body[m].ty.clone();
        let Some(s) = Self::memref(&mt).cloned() else { return false };
        let int = matches!(*s.elem, Type::Integer { signedness: mlirformat::Signedness::Signless, .. });
        let mut value = ops[0];
        if int {
            if matches!(SpirvTypes::storage_class(&s).as_deref(), None | Some("Image")) {
                return false;
            }
            let src_bits = if s.elem.bit_width() == Some(1) { o.bool_bits } else { s.elem.bit_width().unwrap_or(32) };
            let Some(ptr_t) = cr.converted(&mt) else { return false };
            let Some(e) = Self::pointee_elem(&ptr_t, o.kernel) else { return false };
            if e.bit_width() != Some(src_bits) {
                return false;
            }
            if s.elem.bit_width() == Some(1) {
                value = Self::bool_to_int(cr, value, e);
            }
        }
        let Some(ptr) = Self::element_ptr(cr, &s, ops[1], &ops[2..], o) else { return false };
        let Some(req) = Self::requirements(cr, op, ptr) else { return false };
        let mut data = OpData::build("spirv.Store").operands(&[ptr, value]);
        for (k, v) in req {
            data.set(k, v);
        }
        cr.replace_new(op, data, &[]);
        true
    }
}
