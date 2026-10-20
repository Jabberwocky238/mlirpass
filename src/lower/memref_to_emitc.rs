//! `memref` ⇒ `emitc`, as `MemRefToEmitC.cpp` (and the pass's standard headers).

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Dim, ShapedKind, Type};
use mlirformat::emitc_types::EmitcType;

use super::emitc::Emitc;
use crate::{Body, Const, ConversionRewriter, OpData, OpId, ValueId, Visibility};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The memref ⇒ emitc patterns.
pub struct MemrefToEmitc;

#[patterns(converter)]
impl MemrefToEmitc {
    /// The memref type of `v`, if legal for EmitC.
    fn legal<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<mlirformat::Shaped<'a>> {
        match cr.ty(v) {
            Type::Shaped(s) if Emitc::memref_legal(&s) => Some(s),
            _ => None,
        }
    }

    /// Whether the type of `v` has a static shape.
    fn static_shape(cr: &Cr<'_, '_, '_>, v: ValueId) -> bool {
        matches!(cr.ty(v), Type::Shaped(s) if s.shape.is_some() && !s.dims().unwrap_or_default().contains(&Dim::DYNAMIC))
    }

    /// The `alignment` attribute.
    fn alignment(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<i64> {
        match cr.rw.body[op].get("alignment") {
            Some(Attribute::Int { lit, .. }) => lit.parse().ok(),
            _ => None,
        }
    }

    /// `convertMemRefType`: a rank-0 memref is its element.
    fn convert_memref<'a>(cr: &Cr<'_, 'a, '_>, ty: &Type<'a>) -> Option<Type<'a>> {
        let tc = cr.type_converter()?;
        match ty {
            Type::Shaped(s) if s.shape.as_ref().is_some_and(Vec::is_empty) => tc.convert(&s.elem),
            t => tc.convert(t),
        }
    }

    /// `sizeof(elem) * count`, as `calculateMemrefTotalSizeBytes`.
    fn total_size<'a>(cr: &mut Cr<'_, 'a, '_>, elem: &Type<'a>, count: i64) -> ValueId {
        let data = OpData::build("emitc.call_opaque").with("callee", Attribute::str("sizeof")).with("args", Attribute::Array(vec![Attribute::Type(elem.clone())]));
        let size = cr.build(data, EmitcType::size_t());
        let n = cr.emitc_constant(Emitc::int(count, Type::Index), Type::Index);
        cr.emitc("emitc.mul", &[size, n], EmitcType::size_t())
    }

    /// `createPointerFromEmitcArray`: the address of the first element.
    fn first_element(cr: &mut Cr<'_, '_, '_>, array: ValueId) -> Option<ValueId> {
        let ty = cr.ty(array);
        let (rank, elem) = EmitcType::array_parts(&ty)?;
        let zero = cr.emitc_constant(Emitc::int(0, Type::Index), Type::Index);
        let mut ops = vec![array];
        ops.extend(core::iter::repeat_n(zero, rank));
        let sub = cr.emitc("emitc.subscript", &ops, EmitcType::lvalue(elem));
        Some(cr.emitc("emitc.address_of", &[sub], EmitcType::ptr(elem)))
    }

    /// `emitc.subscript` of an array operand, as the loads and stores index it.
    fn subscript(cr: &mut Cr<'_, '_, '_>, array: ValueId, indices: &[ValueId]) -> Option<ValueId> {
        let ty = cr.ty(array);
        let (_, elem) = EmitcType::array_parts(&ty)?;
        let lv = EmitcType::lvalue(elem);
        let mut ops = vec![array];
        ops.extend(indices);
        Some(cr.emitc("emitc.subscript", &ops, lv))
    }

    #[lowering("memref.alloca")]
    fn alloca(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if !Self::static_shape(cr, r) || Self::alignment(cr, op).unwrap_or(1) > 1 {
            return false;
        }
        let Some(ty) = cr.converted_result(op) else { return false };
        cr.replace_new(op, OpData::build("emitc.variable").with("value", Attribute::dialect("emitc.opaque", "<\"\">")), &[ty]);
        true
    }

    #[lowering("memref.alloc")]
    fn alloc(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(s) = Self::legal(cr, cr.rw.body[op].results[0]) else { return false };
        let elem = (*s.elem).clone();
        let total = Self::total_size(cr, &elem, s.dims().unwrap_or_default().iter().product());
        let (callee, args) = match Self::alignment(cr, op) {
            Some(a) => {
                let align = cr.emitc_constant(Emitc::int(a, Type::Index), EmitcType::size_t());
                ("aligned_alloc", vec![align, total])
            }
            None => ("malloc", vec![total]),
        };
        let call = cr.build(OpData::build("emitc.call_opaque").operands(&args).with("callee", Attribute::str(callee)), EmitcType::void_ptr());
        let cast = cr.emitc("emitc.cast", &[call], EmitcType::ptr(&elem));
        cr.replace_values(op, &[cast]);
        true
    }

    #[lowering("memref.copy")]
    fn copy(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (src, dst) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let (Some(s), Some(_)) = (Self::legal(cr, src), Self::legal(cr, dst)) else { return false };
        let Some(src_ptr) = Self::first_element(cr, ops[0]) else { return false };
        let Some(dst_ptr) = Self::first_element(cr, ops[1]) else { return false };
        let size = Self::total_size(cr, &s.elem, s.dims().unwrap_or_default().iter().product());
        cr.rw.create(OpData::build("emitc.call_opaque").operands(&[dst_ptr, src_ptr, size]).with("callee", Attribute::str("memcpy")), &[]);
        cr.erase(op);
        true
    }

    #[lowering("memref.global")]
    fn global(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(Attribute::Type(ty)) = cr.rw.body[op].get("type").cloned() else { return false };
        let Type::Shaped(s) = &ty else { return false };
        if s.shape.is_none() || s.dims().unwrap_or_default().contains(&Dim::DYNAMIC) || Self::alignment(cr, op).unwrap_or(1) > 1 {
            return false;
        }
        let Some(res) = Self::convert_memref(cr, &ty) else { return false };
        let private = match cr.rw.body.visibility(op) {
            Visibility::Nested => return false,
            v => v == Visibility::Private,
        };
        let mut init = cr.rw.body[op].get("initial_value").cloned();
        if s.shape.as_ref().is_some_and(Vec::is_empty) {
            init = init.as_ref().and_then(|a| Const::try_from(a).ok()).and_then(|c| Some(Const::scalar(c.splat_value()?, (*s.elem).clone()).into()));
        }
        let name = cr.rw.body[op].get("sym_name").cloned().unwrap_or(Attribute::Unit);
        let mut data = OpData::build("emitc.global").with("sym_name", name).with("type", Attribute::Type(res));
        if let Some(i) = init.filter(|a| *a != Attribute::Unit) {
            data.set("initial_value", i);
        }
        data.set(if private { "static_specifier" } else { "extern_specifier" }, Attribute::Unit);
        if cr.rw.body[op].get("constant").is_some() {
            data.set("const_specifier", Attribute::Unit);
        }
        cr.replace_new(op, data, &[]);
        true
    }

    #[lowering("memref.get_global")]
    fn get_global(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.ty(cr.rw.body[op].results[0]);
        let Some(res) = Self::convert_memref(cr, &ty) else { return false };
        let name = cr.rw.body[op].get("name").cloned().unwrap_or(Attribute::Unit);
        let data = OpData::build("emitc.get_global").with("name", name);
        if matches!(&ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.as_ref().is_some_and(Vec::is_empty)) {
            let lv = cr.build(data, EmitcType::lvalue(&res));
            cr.replace_new(op, OpData::build("emitc.address_of").operands(&[lv]), &[EmitcType::ptr(&res)]);
        } else {
            cr.replace_new(op, data, &[res]);
        }
        true
    }

    #[lowering("memref.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op) else { return false };
        let Some(sub) = Self::subscript(cr, ops[0], &ops[1..]) else { return false };
        cr.replace_new(op, OpData::build("emitc.load").operands(&[sub]), &[ty]);
        true
    }

    #[lowering("memref.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(sub) = Self::subscript(cr, ops[1], &ops[2..]) else { return false };
        cr.replace_new(op, OpData::build("emitc.assign").operands(&[sub, ops[0]]), &[]);
        true
    }

    /// The pass's epilogue: the standard headers the calls need, at the start of `module`.
    pub fn add_headers(body: &mut Body<'_>, module: OpId, cpp: bool) {
        let ops = body.ops_in(module);
        let mut have: Vec<alloc::string::String> = ops
            .iter()
            .filter(|o| body[**o].name == "emitc.include" && body[**o].get("is_standard_include").is_some())
            .filter_map(|o| body[*o].get_str("include").map(alloc::string::String::from))
            .collect();
        let block = body.top_block(module);
        let first = body[block].ops.first().copied();
        for o in ops {
            if body[o].name != "emitc.call_opaque" {
                continue;
            }
            let header = match body[o].get_str("callee") {
                Some("aligned_alloc" | "malloc") => if cpp { "cstdlib" } else { "stdlib.h" },
                Some("memcpy") => if cpp { "cstring" } else { "string.h" },
                _ => continue,
            };
            if have.iter().any(|h| h == header) {
                continue;
            }
            let loc = body[module].loc.clone();
            let data = OpData { loc, ..OpData::build("emitc.include").with("include", Attribute::str(header)).flag("is_standard_include") };
            let inc = body.create(data, &[]);
            match first {
                Some(f) => body.insert_before(inc, f),
                None => body.insert(inc, block, None),
            }
            have.push(header.into());
        }
    }
}
