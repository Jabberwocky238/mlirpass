//! The libm call `math` and `complex` share (`ScalarOpToLibmCall`): an op as a `func.call` of its `float` /
//! `double` function, declared at the start of the nearest symbol table.

use mlirformat::{Attribute, FloatKind, FunctionType, Type};

use crate::{ConversionRewriter as Cr, OpData, OpId};

/// The libm call both share.
pub(crate) struct Libm;

impl Libm {
    /// f64 ⇒ `Some(true)`, f32 ⇒ `Some(false)`, anything else ⇒ `None`.
    pub(crate) fn float(t: &Type<'_>) -> Option<bool> {
        match t {
            Type::Float(FloatKind::F64) => Some(true),
            Type::Float(FloatKind::F32) => Some(false),
            _ => None,
        }
    }

    /// The op as a call of `float,double`'s function, declared (private; `readnone` for math)
    /// at the start of the nearest symbol table when it is not yet.
    pub(crate) fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, to: &str, double: Option<bool>, readnone: bool) -> bool {
        let (Some(double), Some((float_fn, double_fn))) = (double, to.split_once(',')) else { return false };
        let name = if double { double_fn } else { float_fn };
        let b = &*cr.rw.body;
        let mut table = b.parent_op(op);
        while let Some(t) = table.filter(|t| !b.is_symbol_table(*t)) {
            table = b.parent_op(t);
        }
        let Some(table) = table else { return false };
        let operands = b[op].operands.clone();
        let results = b.types(&b[op].results);
        if b.lookup(table, name).is_none() {
            let ty = FunctionType { inputs: b.types(&operands), results: results.clone() };
            let mut data = OpData::build("func.func").with("sym_name", Attribute::str(name)).with("function_type", Attribute::Type(Type::Function(alloc::boxed::Box::new(ty)))).with("sym_visibility", Attribute::str("private"));
            if readnone {
                data.set("llvm.readnone", Attribute::Unit);
            }
            let f = cr.rw.body.create(data, &[]);
            cr.rw.body.add_region(f);
            let top = cr.rw.body[cr.rw.body[table].regions[0]].blocks[0];
            let first = cr.rw.body.first_op(top);
            cr.rw.move_before(f, top, first);
        }
        cr.replace_new(op, OpData::build("func.call").operands(&operands).with("callee", Attribute::SymbolRef(alloc::vec![alloc::string::String::from(name).into()])), &results);
        true
    }
}
