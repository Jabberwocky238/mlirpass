use alloc::string::String;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::emitc_types::EmitcType;
use mlirformat::{Attribute, Extended, FunctionType, Type};

use crate::{ConversionRewriter, OpData, OpId, SignatureConversion, ValueId, Visibility};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub struct FuncToEmitc;

#[patterns(converter, options = bool)]
impl FuncToEmitc {
    #[convert("func.call")]
    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], cpp: bool) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let results = cr.rw.body[op].results.clone();
        if results.len() > 1 && cpp {
            return false;
        }
        let Some(types) = Self::converted(cr, &cr.rw.body.types(&results)) else { return false };
        if results.len() <= 1 {
            let mut data = OpData::build("emitc.call").operands(&ops);
            for a in cr.all_attrs(op) {
                data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
            }
            cr.replace_new(op, data, &types);
            return true;
        }
        let Some(st) = Self::multi_return_type(cr, op, &types) else { return false };
        cr.rw.set_before(op);
        let callee = cr.rw.body[op].get("callee").cloned().unwrap_or(Attribute::Unit);
        let call = cr.rw.create(OpData::build("emitc.call").operands(&ops).with("callee", callee), &[st]);
        let packed = cr.rw.body[call].results[0];
        let mut values = Vec::new();
        for (i, (r, t)) in results.iter().zip(&types).enumerate() {
            if !cr.rw.body[*r].uses.is_empty() {
                let m = cr.rw.create(OpData::build("emitc.member").operands(&[packed]).with("member", Attribute::str(&Self::field(i))), &[t.clone()]);
                values.push(alloc::vec![cr.rw.body[m].results[0]]);
            } else {
                values.push(Vec::new());
            }
        }
        cr.replace(op, values);
        true
    }

    #[convert("func.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], cpp: bool) -> bool {
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        if fty.results.len() > 1 && cpp {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            let Some(c) = tc.convert(t) else { return false };
            sig.add_inputs(i, alloc::vec![c]);
        }
        let Some(converted) = Self::converted(cr, &fty.results) else { return false };
        let results = match converted.as_slice() {
            [] | [_] => converted,
            _ => match Self::multi_return_type(cr, op, &converted) {
                Some(st) => alloc::vec![st],
                None => return false,
            },
        };
        let new_ty = Type::Function(alloc::boxed::Box::new(FunctionType { inputs: sig.converted_types().to_vec(), results }));
        let mut data = OpData::build("emitc.func").with("sym_name", cr.rw.body[op].get("sym_name").cloned().unwrap_or(Attribute::Unit)).with("function_type", Attribute::Type(new_ty));
        for a in cr.all_attrs(op) {
            if a.name != "function_type" && a.name != "sym_name" {
                data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
            }
        }
        let region = cr.rw.body[op].regions[0];
        let declaration = cr.rw.body[region].blocks.is_empty();
        let private = cr.rw.body.visibility(op) == Visibility::Private;
        if declaration || private {
            data.set("specifiers", Attribute::Array(alloc::vec![Attribute::str(if declaration { "extern" } else { "static" })]));
        }
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        if !declaration {
            let into = cr.rw.body[new].regions[0];
            cr.inline_region(region, into, None);
            let Some(current) = cr.current else { return false };
            if cr.convert_region_types(into, current, Some(&sig)).is_none() {
                return false;
            }
        }
        cr.erase(op);
        true
    }

    #[convert("func.return")]
    fn ret(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], cpp: bool) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if ops.len() > 1 && cpp {
            return false;
        }
        let types = cr.rw.body.types(&ops);
        if types.iter().any(Self::array) {
            return false;
        }
        if ops.len() <= 1 {
            cr.replace_new(op, OpData::build("emitc.return").operands(&ops), &[]);
            return true;
        }
        let Some(st) = Self::multi_return_type(cr, op, &types) else { return false };
        cr.rw.set_before(op);
        let var = cr.rw.create(OpData::build("emitc.variable").with("value", Attribute::dialect("emitc.opaque", "<\"\">")), &[EmitcType::lvalue(&st)]);
        let lv = cr.rw.body[var].results[0];
        for (i, (v, t)) in ops.iter().zip(&types).enumerate() {
            let m = cr.rw.create(OpData::build("emitc.member").operands(&[lv]).with("member", Attribute::str(&Self::field(i))), &[EmitcType::lvalue(t)]);
            let field = cr.rw.body[m].results[0];
            cr.rw.create(OpData::build("emitc.assign").operands(&[field, *v]), &[]);
        }
        let load = cr.rw.create(OpData::build("emitc.load").operands(&[lv]), &[st]);
        let packed = cr.rw.body[load].results[0];
        cr.replace_new(op, OpData::build("emitc.return").operands(&[packed]), &[]);
        true
    }
}

impl FuncToEmitc {
    fn field(i: usize) -> String {
        alloc::format!("field{i}")
    }

    fn array(t: &Type<'_>) -> bool {
        matches!(t, Type::Extended(e) if e.name == "emitc.array")
    }

    fn converted<'a>(cr: &Cr<'_, 'a, '_>, types: &[Type<'a>]) -> Option<Vec<Type<'a>>> {
        let tc = cr.type_converter()?;
        types.iter().map(|t| tc.convert(t).filter(|c| !Self::array(c))).collect()
    }

    fn multi_return_type<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, types: &[Type<'a>]) -> Option<Type<'a>> {
        let mut name = String::from("return");
        for t in types {
            name.push('_');
            name.extend(alloc::format!("{t}").chars().map(|c| if c.is_ascii_alphanumeric() { c } else { '_' }));
        }
        let body = &*cr.rw.body;
        let mut child = op;
        let table = loop {
            let parent = body.parent_op(child)?;
            if body.is_symbol_table(parent) {
                break parent;
            }
            child = parent;
        };
        match body.find_symbol(table, &name) {
            Some(class) => {
                if body[class].name != "emitc.class" || !matches!(body[class].get("class_type"), Some(Attribute::Int { lit, .. }) if lit == "1") {
                    return None;
                }
                let fields: Vec<OpId> = body.ops_in(class).into_iter().filter(|f| body.parent_op(*f) == Some(class)).collect();
                if fields.iter().any(|f| body[*f].name == "emitc.func") {
                    return None;
                }
                let fields: Vec<OpId> = fields.into_iter().filter(|f| body[*f].name == "emitc.field").collect();
                let same = fields.len() == types.len()
                    && fields.iter().zip(types).enumerate().all(|(i, (f, t))| body[*f].get_str("sym_name") == Some(&Self::field(i)) && body[*f].get("type") == Some(&Attribute::Type(t.clone())));
                if !same {
                    return None;
                }
            }
            None => {
                let saved = cr.rw.ip;
                cr.rw.set_before(child);
                let class = cr.rw.create_with(OpData::build("emitc.class").with("sym_name", Attribute::str(&name)).with("class_type", Attribute::integer(1, Type::int(32))), &[], |b, c| {
                    let r = b.add_region(c);
                    b.add_block(r, &[]);
                });
                let block = cr.rw.body[cr.rw.body[class].regions[0]].blocks[0];
                cr.rw.set_start(block);
                for (i, t) in types.iter().enumerate() {
                    cr.rw.create(OpData::build("emitc.field").with("sym_name", Attribute::str(&Self::field(i))).with("type", Attribute::Type(t.clone())), &[]);
                }
                cr.rw.ip = saved;
            }
        }
        Some(Type::Extended(alloc::boxed::Box::new(Extended { name: mlirformat::Str::Borrowed("emitc.opaque"), body: Some(mlirformat::Str::Owned(alloc::format!("<\"struct {name}\">"))), params: Vec::new() })))
    }
}
