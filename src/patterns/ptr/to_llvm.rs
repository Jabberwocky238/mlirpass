//! `ptr` to LLVM (`PtrToLLVM.cpp`): pointers are `!llvm.ptr`, a memref's metadata the
//! descriptor fields that are not static, and the ops pointer arithmetic on them.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, MlirOpt, Parser, Shaped, ShapedKind, Type};

use crate::patterns;
use crate::{ConversionRewriter, LlvmOptions, MemrefLayout, OpData, OpId, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `!ptr.ptr`'s only memory space this lowering knows, and the LLVM address space it is.
const GENERIC_SPACE: &str = "<#ptr.generic_space>";
const GENERIC_ADDRESS_SPACE: u32 = 0;

/// `ptr::PtrAddFlags` ⇒ `LLVM::GEPNoWrapFlags`.
const PTR_ADD_FLAGS: [(i64, i64); 4] = [
    // none ⇒ none, nusw ⇒ nusw, nuw ⇒ nuw, inbounds ⇒ inbounds (`inbounds_flag | nusw`).
    (0, 0),
    (1, 2),
    (2, 4),
    (3, 3),
];

/// `LLVM::GEPOp::kDynamicIndex`.
const GEP_DYNAMIC: i64 = i32::MIN as i64;

/// The memref descriptor's field positions.
const ALLOCATED: i64 = 0;
const ALIGNED: i64 = 1;
const OFFSET: i64 = 2;
const SIZES: i64 = 3;
const STRIDES: i64 = 4;

/// `ptr` to LLVM.
pub struct PtrToLlvm;

impl PtrToLlvm {
    /// The memref a `ptr.ptr_metadata<...>` type is of.
    fn metadata_memref(t: &Type<'_>, opt: &MlirOpt) -> Option<Shaped<'static>> {
        let Type::Extended(e) = t else { return None };
        if e.name != "ptr.ptr_metadata" {
            return None;
        }
        let inner = e.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?;
        match Parser::new(inner, opt).ty().ok()?.owned() {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Some(*s),
            _ => None,
        }
    }

    /// `createMemRefMetadataType`: the allocated pointer, then the dynamic offset, sizes and
    /// strides.
    pub fn metadata_type<'a>(o: LlvmOptions, s: &Shaped<'a>) -> Option<Type<'a>> {
        let space = o.address_space(s)?;
        let (strides, offset) = s.strides_and_offset()?;
        let idx = o.index();
        let mut fields: Vec<Type<'a>> = vec![LlvmType::Ptr(space).into()];
        if offset == Dim::DYNAMIC {
            fields.push(idx.clone());
        }
        fields.extend(s.shape.as_ref()?.iter().filter(|d| **d == mlirformat::Dim::Dynamic).map(|_| idx.clone()));
        fields.extend(strides.iter().filter(|s| **s == Dim::DYNAMIC).map(|_| idx.clone()));
        Some(LlvmType::literal(fields))
    }

    /// The type conversions: `!ptr.ptr<#ptr.generic_space>` ⇒ `!llvm.ptr`, a memref's metadata
    /// ⇒ its struct.
    pub fn convert<'a>(tc: &mut TypeConverter<'a>, o: LlvmOptions, opt: &'a MlirOpt) {
        tc.conversion(move |t| {
            let Type::Extended(e) = t else { return None };
            match &*e.name {
                "ptr.ptr" => Some((e.body.as_deref() == Some(GENERIC_SPACE)).then(|| vec![LlvmType::Ptr(GENERIC_ADDRESS_SPACE).into()])),
                "ptr.ptr_metadata" => Some(Self::metadata_memref(t, opt).and_then(|s| Self::metadata_type(o, &s)).map(|t| vec![t])),
                _ => None,
            }
        });
    }

    fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Some(s),
            _ => None,
        }
    }

    fn gep<'a>(cr: &mut Cr<'_, 'a, '_>, elem: Type<'a>, base: ValueId, dynamic: Option<ValueId>, constant: i64, flags: i64) -> ValueId {
        let mut operands = vec![base];
        operands.extend(dynamic);
        let raw = if dynamic.is_some() { GEP_DYNAMIC } else { constant };
        let raw = Attribute::DenseArray { ty: Type::int(32), values: vec![alloc::format!("{raw}").into()].into() };
        let ty = cr.rw.body[base].ty.clone();
        let data = OpData::build("llvm.getelementptr").operands(&operands).with("elem_type", Attribute::Type(elem)).with("rawConstantIndices", raw).with("noWrapFlags", Attribute::Int { lit: alloc::format!("{flags}").into(), ty: Some(Type::int(32)) });
        cr.build(data, ty)
    }
}

#[patterns(converter, options = LlvmOptions)]
impl PtrToLlvm {
    /// `FromPtrOpConversion`: a descriptor of the pointer and the metadata's fields, the static
    /// ones constants.
    #[convert("ptr.from_ptr")]
    fn from_ptr(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let rt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(m) = Self::memref(&rt).cloned() else { return false };
        let Some(&md) = operands.get(1).and_then(|g| g.first()) else { return false };
        let Some(desc_ty) = cr.converted(&rt) else { return false };
        let Some((strides, offset)) = m.strides_and_offset() else { return false };
        let shape = m.dims().unwrap_or_default();
        let idx = o.index();
        cr.rw.set_before(op);
        let mut desc = cr.build(OpData::build("llvm.mlir.poison"), desc_ty);
        let allocated = cr.extract(md, &[0]);
        desc = cr.insert_value(desc, allocated, &[ALLOCATED]);
        desc = cr.insert_value(desc, operands[0][0], &[ALIGNED]);
        let mut field = 1;
        let mut take = |cr: &mut Cr<'_, '_, '_>, dynamic: bool, value: i64| {
            if dynamic {
                let v = cr.extract(md, &[field]);
                field += 1;
                v
            } else {
                cr.index_const(&idx, value)
            }
        };
        let off = take(cr, offset == Dim::DYNAMIC, offset);
        desc = cr.insert_value(desc, off, &[OFFSET]);
        for (i, d) in shape.iter().enumerate() {
            let v = take(cr, *d == Dim::DYNAMIC, *d);
            desc = cr.insert_value(desc, v, &[SIZES, i as i64]);
        }
        for (i, s) in strides.iter().enumerate() {
            let v = take(cr, *s == Dim::DYNAMIC, *s);
            desc = cr.insert_value(desc, v, &[STRIDES, i as i64]);
        }
        cr.replace(op, vec![vec![desc]]);
        true
    }

    /// `GetMetadataOpConversion`: the allocated pointer and the dynamic fields of the
    /// descriptor.
    #[convert("ptr.get_metadata")]
    fn get_metadata(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        let src = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let Some(m) = Self::memref(&src).cloned() else { return false };
        let Some(md_ty) = Self::metadata_type(o, &m) else { return false };
        let Some((strides, offset)) = m.strides_and_offset() else { return false };
        let shape = m.dims().unwrap_or_default();
        let desc = operands[0][0];
        cr.rw.set_before(op);
        let mut s = cr.build(OpData::build("llvm.mlir.undef"), md_ty);
        let allocated = cr.extract(desc, &[ALLOCATED]);
        s = cr.insert_value(s, allocated, &[0]);
        let mut field = 1;
        let mut put = |cr: &mut Cr<'_, '_, '_>, s: ValueId, pos: &[i64]| {
            let v = cr.extract(desc, pos);
            let r = cr.insert_value(s, v, &[field]);
            field += 1;
            r
        };
        if offset == Dim::DYNAMIC {
            s = put(cr, s, &[OFFSET]);
        }
        for (i, d) in shape.iter().enumerate().filter(|(_, d)| **d == Dim::DYNAMIC) {
            let _ = d;
            s = put(cr, s, &[SIZES, i as i64]);
        }
        for (i, _) in strides.iter().enumerate().filter(|(_, s)| **s == Dim::DYNAMIC) {
            s = put(cr, s, &[STRIDES, i as i64]);
        }
        cr.replace(op, vec![vec![s]]);
        true
    }

    /// `PtrAddOpConversion`: a byte-wise `llvm.getelementptr`.
    #[convert("ptr.ptr_add")]
    fn ptr_add(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let (base, offset) = (operands[0][0], operands[1][0]);
        if !matches!(LlvmType::try_from(&cr.rw.body[base].ty), Ok(LlvmType::Ptr(_))) {
            return false;
        }
        let flag = match cr.rw.body[op].get("flags") {
            Some(Attribute::Int { lit, .. }) => lit.parse::<i64>().unwrap_or(0),
            _ => 0,
        };
        let Some(&(_, flags)) = PTR_ADD_FLAGS.iter().find(|(p, _)| *p == flag) else { return false };
        cr.rw.set_before(op);
        let r = Self::gep(cr, Type::int(8), base, Some(offset), 0, flags);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `ToPtrOpConversion`: the aligned pointer.
    #[convert("ptr.to_ptr")]
    fn to_ptr(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let src = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if Self::memref(&src).is_none() {
            return false;
        }
        cr.rw.set_before(op);
        let r = cr.extract(operands[0][0], &[ALIGNED]);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `TypeOffsetOpConversion`: the address of element 1 from null.
    #[convert("ptr.type_offset")]
    fn type_offset(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let Some(Attribute::Type(t)) = cr.rw.body[op].get("elementType").cloned() else { return false };
        let Some(elem) = cr.converted(&t) else { return false };
        let rt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(rt) = cr.converted(&rt) else { return false };
        cr.rw.set_before(op);
        let zero = cr.build(OpData::build("llvm.mlir.zero"), LlvmType::ptr());
        let p = Self::gep(cr, elem, zero, None, 1, 0);
        let r = cr.build(OpData::build("llvm.ptrtoint").operands(&[p]), rt);
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `ConstantOpConversion`: null, or an address as `llvm.inttoptr`.
    #[convert("ptr.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        let rt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(rt) = cr.converted(&rt) else { return false };
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("value").cloned() else { return false };
        cr.rw.set_before(op);
        let r = match &*ext.name {
            "ptr.null" => cr.build(OpData::build("llvm.mlir.zero"), rt),
            "ptr.address" => {
                // `#ptr.address<N>`: an `APInt` of 64 bits (the default).
                /// The width `#ptr.address` parses its value with.
                const ADDRESS_BITS: u32 = 64;
                let Some(n) = ext.body.as_deref().and_then(|b| b.strip_prefix('<')?.strip_suffix('>')?.trim().parse::<i64>().ok()) else { return false };
                let ty = Type::int(ADDRESS_BITS);
                let c = cr.llvm_constant(Attribute::of_int(n.into(), ty.clone()), ty);
                cr.build(OpData::build("llvm.inttoptr").operands(&[c]), rt)
            }
            _ => return false,
        };
        cr.replace(op, vec![vec![r]]);
        true
    }
}
