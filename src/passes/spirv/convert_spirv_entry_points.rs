use alloc::boxed::Box;
use alloc::borrow::ToOwned;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Error, Extended, FunctionType, NamedAttr, Type};

use crate::{Attrs, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpData, OpId, Quiet, Rewriter, SpirvToArith, ValueId, pass};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
enum Class {
    Input,
    Output,
    Resource,
}

#[derive(Clone)]
struct Var<'a> {
    ty: Type<'a>,
    ptr: Type<'a>,
    class: Class,
    storage: String,
    location: Option<i64>,
    position: bool,
    set: i64,
    binding: i64,
}

impl<'a> Var<'a> {
    fn of(body: &Body<'a>, g: OpId) -> Result<(String, Var<'a>), Error> {
        let name = body[g].get_str("sym_name").ok_or_else(|| Error("spirv.GlobalVariable without a name".into()))?.to_owned();
        let Some(Attribute::Type(t)) = body[g].get("type") else { return Err(Error(format!("@{name}: no type"))) };
        let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(t) else { return Err(Error(format!("@{name}: not a pointer"))) };
        let a = body[g].all_attrs();
        let a = Attrs(&a);
        let class = match &*storage {
            "Input" => Class::Input,
            "Output" => Class::Output,
            _ => Class::Resource,
        };
        let position = matches!(a.get("built_in"), Some(Attribute::Str { lit, .. }) if lit == "Position");
        let var = Var { ty: (*pointee).clone(), ptr: t.clone(), class, storage: storage.to_string(), location: a.int("location")?, position, set: a.int("descriptor_set")?.unwrap_or(0), binding: a.int("binding")?.unwrap_or(0) };
        Ok((name, var))
    }

    fn abi(&self) -> Attribute<'a> {
        Attribute::Extended { ext: Box::new(Extended { name: String::from("spirv.interface_var_abi").into(), body: Some(format!("<({}, {}), {}>", self.set, self.binding, self.storage).into()), params: Vec::new() }), ty: None }
    }
}

struct Entry<'r, 'b, 'a> {
    rw: &'b mut Rewriter<'r, 'a>,
    vars: &'b BTreeMap<String, Var<'a>>,
}

impl<'a> Entry<'_, '_, 'a> {
    fn func(&mut self, f: OpId, model: Attribute<'a>, interface: &[String], before: OpId) -> Result<OpId, Error> {
        let var = |n: &String| self.vars.get(n).cloned().map(|v| (n.clone(), v)).ok_or_else(|| Error(format!("no variable @{n}")));
        let vars = interface.iter().map(var).collect::<Result<Vec<_>, _>>()?;
        let (mut inputs, mut outputs): (Vec<_>, Vec<_>) = vars.into_iter().filter(|(_, v)| v.class != Class::Resource).partition(|(_, v)| v.class == Class::Input);
        inputs.sort_by_key(|(_, v)| v.location);
        outputs.sort_by_key(|(_, v)| (!v.position, v.location));
        let from = self.rw.body.top_block(f);
        let mut used: Vec<(String, Var<'a>)> = Vec::new();
        for op in self.rw.body.block_ops(from) {
            if self.rw.body[op].name == "spirv.mlir.addressof" {
                let a = self.rw.body[op].all_attrs();
                let n = Attrs(&a).symbol("variable")?.to_owned();
                let (n, v) = var(&n)?;
                if v.class == Class::Resource && used.iter().all(|(u, _)| *u != n) {
                    used.push((n, v));
                }
            }
        }
        used.sort_by_key(|(_, v)| (v.storage == "PushConstant", v.set, v.binding));
        let mut args: Vec<Type<'a>> = inputs.iter().map(|(_, v)| v.ty.clone()).collect();
        args.extend(used.iter().map(|(_, v)| v.ptr.clone()));
        let fty = FunctionType { inputs: args.clone(), results: outputs.iter().map(|(_, v)| v.ty.clone()).collect() };
        let name = self.rw.body[f].get("sym_name").cloned().ok_or_else(|| Error("spirv.func without a name".into()))?;
        let mut data = OpData::build("func.func").with("sym_name", name).with("function_type", Attribute::Type(Type::Function(Box::new(fty))));
        data.set("spirv.execution_model", model);
        if !used.is_empty() {
            let dict = |a: Option<Attribute<'a>>| Attribute::Dict(a.into_iter().map(|v| NamedAttr { name: String::from("spirv.interface_var_abi").into(), value: Some(v) }).collect());
            let attrs = inputs.iter().map(|_| dict(None)).chain(used.iter().map(|(_, v)| dict(Some(v.abi())))).collect();
            data.set("arg_attrs", Attribute::Array(attrs));
        }
        self.rw.set_before(before);
        let new = self.rw.create_with(data, &[], |b, new| {
            let region = b.add_region(new);
            b.add_block(region, &args.iter().map(|t| (t.clone(), None)).collect::<Vec<_>>());
        });
        let block = self.rw.body.top_block(new);
        let ops = self.rw.body.block_ops(from);
        self.rw.inline_block_before(from, block, None, &[]);

        let mut ptrs: BTreeMap<ValueId, String> = BTreeMap::new();
        let mut stored: BTreeMap<String, ValueId> = BTreeMap::new();
        for op in ops {
            match &*self.rw.body[op].name {
                "spirv.mlir.addressof" => {
                    let a = self.rw.body[op].all_attrs();
                    let v = Attrs(&a).symbol("variable")?.to_owned();
                    let r = self.rw.body[op].results[0];
                    if let Some(k) = used.iter().position(|(n, _)| *n == v) {
                        let arg = self.rw.body[block].args[inputs.len() + k];
                        self.rw.replace_all_uses(r, arg);
                    } else {
                        ptrs.insert(r, v);
                    }
                    self.rw.erase_op(op);
                }
                "spirv.Load" => {
                    let Some(v) = ptrs.get(&self.rw.body[op].operands[0]) else { continue };
                    let i = inputs.iter().position(|(n, _)| n == v).ok_or_else(|| Error(format!("spirv.Load of @{v}: not an input")))?;
                    let (arg, r) = (self.rw.body[block].args[i], self.rw.body[op].results[0]);
                    self.rw.replace_all_uses(r, arg);
                    self.rw.erase_op(op);
                }
                "spirv.Store" => {
                    let Some(v) = ptrs.get(&self.rw.body[op].operands[0]) else { continue };
                    stored.insert(v.clone(), self.rw.body[op].operands[1]);
                    self.rw.erase_op(op);
                }
                "spirv.Return" => {
                    let values = outputs.iter().map(|(n, _)| stored.get(n).copied().ok_or_else(|| Error(format!("output @{n} never stored")))).collect::<Result<Vec<_>, _>>()?;
                    self.rw.set_before(op);
                    self.rw.create(OpData::build("func.return").operands(&values), &[]);
                    self.rw.erase_op(op);
                }
                _ => {}
            }
        }
        Ok(new)
    }
}

#[pass("convert-spirv-entry-points", on = "builtin.module")]
pub fn convert_spirv_entry_points<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut modules = Vec::new();
    body.walk(op, &mut |m| {
        if body[m].name == "spirv.module" && body.parent_op(m).is_some_and(|p| body[p].name == "gpu.module") {
            modules.push(m);
        }
    });
    let mut funcs = Vec::new();
    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for m in modules {
        let inner = rw.body.top_block(m);
        let ops = rw.body.block_ops(inner);
        let vars: BTreeMap<String, Var<'a>> = ops.iter().filter(|g| rw.body[**g].name == "spirv.GlobalVariable").map(|g| Var::of(rw.body, *g)).collect::<Result<_, _>>()?;
        let entries: Vec<OpId> = ops.iter().copied().filter(|e| rw.body[*e].name == "spirv.EntryPoint").collect();
        for e in entries {
            let a = rw.body[e].all_attrs();
            let a = Attrs(&a);
            let model = a.get("execution_model").cloned().ok_or_else(|| Error("entry point without an execution model".into()))?;
            let name = a.symbol("fn")?;
            let f = ops.iter().copied().find(|f| rw.body[*f].name == "spirv.func" && rw.body[*f].get_str("sym_name") == Some(name));
            let f = f.ok_or_else(|| Error(format!("entry point: no spirv.func @{name}")))?;
            let interface: Vec<String> = a.array("interface")?.iter().map(|i| Attrs::as_symbol(i).map(str::to_owned)).collect::<Result<_, _>>()?;
            funcs.push(Entry { rw: &mut rw, vars: &vars }.func(f, model, &interface, m)?);
        }
        rw.erase_op(m);
    }
    let mut patterns = ConversionPatterns::default();
    SpirvToArith::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("math").legal_dialect("vector").legal_dialect("func").legal_dialect("spirv");
    for o in SpirvToArith::ROOTS {
        target.illegal_op(o);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &funcs, Mode::Partial)
}
