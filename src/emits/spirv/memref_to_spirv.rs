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
        let scope = match SpirvTypes::storage_class(&s).as_deref() {
            Some("StorageBuffer") => "Device",
            Some("Workgroup") => "Workgroup",
            _ => return false,
        };
        for (name, val) in [("spirv.AtomicAnd", clear), ("spirv.AtomicOr", v)] {
            let data = OpData::build(name).operands(&[adjusted, val]).with("memory_scope", Cr::spirv_enum("scope", scope)).with("semantics", Cr::spirv_enum("memory_semantics", "AcquireRelease"));
            cr.build(data, dst.clone());
        }
        cr.erase(op);
        cr.erase(chain);
        true
    }
}

impl MemrefToSpirv {
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
