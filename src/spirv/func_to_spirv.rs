//! `func` ⇒ `spirv`, as `FuncToSPIRV.cpp` and `FuncOpConversion` (`SPIRVConversion.cpp`).

use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::{Attribute, FunctionType, Type};

use crate::{ConversionRewriter, OpData, OpId, SignatureConversion, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The func ⇒ spirv patterns (`populateFuncToSPIRVPatterns` and
/// `populateBuiltinFuncToSPIRVPatterns`).
pub struct FuncToSpirv;

#[patterns(converter)]
impl FuncToSpirv {
    /// `ReturnOpPattern`.
    #[lowering("func.return")]
    fn ret(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        match ops[..] {
            [] => cr.replace_new(op, OpData::build("spirv.Return"), &[]),
            [v] => cr.replace_new(op, OpData::build("spirv.ReturnValue").operands(&[v]), &[]),
            _ => return false,
        };
        true
    }

    /// `CallOpPattern`.
    #[lowering("func.call")]
    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let results = cr.rw.body[op].results.clone();
        if results.len() > 1 {
            return false;
        }
        let mut types = Vec::new();
        if let Some(r) = results.first() {
            let Some(t) = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[*r].ty)) else { return false };
            types.push(t);
        }
        let mut data = OpData::build("spirv.FunctionCall").operands(&ops);
        for a in cr.all_attrs(op) {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        cr.replace_new(op, data, &types);
        true
    }

    /// `FuncOpConversion`.
    #[lowering("func.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        if fty.results.len() > 1 {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            let Some(c) = tc.convert(t) else { return false };
            sig.add_inputs(i, vec![c]);
        }
        let results = match fty.results.first() {
            Some(t) => match tc.convert(t) {
                Some(c) => vec![c],
                None => return false,
            },
            None => Vec::new(),
        };
        let new_ty = Type::Function(FunctionType { inputs: sig.converted_types().to_vec(), results });
        let mut data = OpData::build("spirv.func")
            .with("sym_name", cr.rw.body[op].get("sym_name").cloned().unwrap_or(Attribute::Unit))
            .with("function_type", Attribute::Type(new_ty))
            .with("function_control", Attribute::dialect("spirv.function_control", "<None>"));
        for a in cr.all_attrs(op) {
            if a.name != "function_type" && a.name != "sym_name" {
                data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
            }
        }
        let region = cr.rw.body[op].regions[0];
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        let into = cr.rw.body[new].regions[0];
        cr.inline_region(region, into, None);
        let Some(current) = cr.current else { return false };
        if cr.convert_region_types(into, current, Some(&sig)).is_none() {
            return false;
        }
        cr.erase(op);
        true
    }
}
