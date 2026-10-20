//! `buffer-results-to-out-params`, as `BufferResultsToOutParams.cpp`: memref results become
//! arguments the caller allocates.

use alloc::collections::BTreeMap;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, FunctionType, NamedAttr, Shaped, Type};
use mlirpass_macros::pass;

use crate::{Body, Def, LlvmOptions, OpData, OpId, Run, ValueId, Visibility, DYNAMIC};

#[pass("buffer-results-to-out-params", on = "builtin.module")]
pub struct BufferResultsToOutParams {
    #[opt("add-result-attr")]
    add_result_attr: bool,
    #[opt("hoist-static-allocs")]
    hoist_static: bool,
    #[opt("hoist-dynamic-allocs")]
    hoist_dynamic: bool,
    #[opt("modify-public-functions")]
    modify_public: bool,
}

/// What the rewrite needs of a memref type.
struct Memref;

impl Memref {
    fn shaped<'x, 'a>(t: &'x Type<'a>) -> Option<&'x Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == mlirformat::ShapedKind::MemRef => Some(s),
            _ => None,
        }
    }

    /// `hasFullyDynamicLayoutMap`.
    fn fully_dynamic(s: &Shaped<'_>) -> bool {
        LlvmOptions::default().strides_and_offset(s).is_some_and(|(st, off)| st.iter().all(|x| *x == DYNAMIC) && off == DYNAMIC)
    }

    fn static_shape(s: &Shaped<'_>) -> bool {
        s.shape.as_ref().is_some_and(|d| d.iter().all(|x| matches!(x, mlirformat::Dim::Static(_))))
    }

    /// The type without its layout (`MemRefType::get(shape, elem, {}, space)`).
    fn without_layout<'a>(s: &Shaped<'a>) -> Type<'a> {
        let extras = s.extras.iter().filter(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")).cloned().collect();
        Type::Shaped(Shaped { extras, ..s.clone() })
    }
}

impl BufferResultsToOutParams {
    fn skip(&self, b: &Body<'_>, f: OpId) -> bool {
        (b.visibility(f) == Visibility::Public && !self.modify_public) || b[b[f].regions[0]].blocks.is_empty()
    }

    fn function_type<'a>(b: &Body<'a>, f: OpId) -> FunctionType<'a> {
        match b[f].get("function_type") {
            Some(Attribute::Type(Type::Function(t))) => t.clone(),
            _ => FunctionType { inputs: Vec::new(), results: Vec::new() },
        }
    }

    /// The dictionaries of `arg_attrs` / `res_attrs`, `n` of them.
    fn dicts<'a>(b: &Body<'a>, f: OpId, name: &str, n: usize) -> Vec<Attribute<'a>> {
        match b[f].get(name) {
            Some(Attribute::Array(xs)) => xs.clone(),
            _ => vec![Attribute::Dict(Vec::new()); n],
        }
    }

    fn set_dicts<'a>(b: &mut Body<'a>, f: OpId, name: &str, xs: Vec<Attribute<'a>>) {
        if xs.iter().all(|x| matches!(x, Attribute::Dict(d) if d.is_empty())) {
            b[f].remove(name);
        } else {
            b[f].set(name, Attribute::Array(xs));
        }
    }

    /// `updateFuncOp`: the memref results become trailing arguments.
    fn update_func(&self, b: &mut Body<'_>, f: OpId) -> Result<Vec<ValueId>, Error> {
        let ft = Self::function_type(b, f);
        let mut erased = Vec::new();
        for (i, t) in ft.results.iter().enumerate() {
            if let Some(s) = Memref::shaped(t) {
                if !crate::MemrefToLlvm::identity_layout(s) && !Memref::fully_dynamic(s) {
                    return Err(Error("cannot create out param for result with unsupported layout".into()));
                }
                erased.push(i);
            }
        }
        let types: Vec<Type> = erased.iter().map(|i| ft.results[*i].clone()).collect();
        let mut inputs = ft.inputs.clone();
        inputs.extend(types.iter().cloned());
        let results: Vec<Type> = ft.results.iter().enumerate().filter(|(i, _)| !erased.contains(i)).map(|(_, t)| t.clone()).collect();
        b[f].set("function_type", Attribute::Type(Type::Function(FunctionType { inputs, results })));
        let res = Self::dicts(b, f, "res_attrs", ft.results.len());
        let mut args = Self::dicts(b, f, "arg_attrs", ft.inputs.len());
        for i in &erased {
            let mut d = match &res[*i] {
                Attribute::Dict(d) => d.clone(),
                _ => Vec::new(),
            };
            if self.add_result_attr {
                d.push(NamedAttr { name: "bufferize.result".into(), value: None });
            }
            args.push(Attribute::Dict(d));
        }
        Self::set_dicts(b, f, "arg_attrs", args);
        if b[f].get("res_attrs").is_some() {
            let kept = res.into_iter().enumerate().filter(|(i, _)| !erased.contains(i)).map(|(_, x)| x).collect();
            Self::set_dicts(b, f, "res_attrs", kept);
        }
        let entry = b[b[f].regions[0]].blocks[0];
        Ok(types.into_iter().map(|t| b.add_arg(entry, t)).collect())
    }

    /// `getDynamicSize`: the index operands of an allocation, when all are `f`'s arguments.
    fn dynamic_size(b: &Body<'_>, v: ValueId, f: OpId) -> Vec<ValueId> {
        let Some(def) = b.def_op(v) else { return Vec::new() };
        let entry = b[b[f].regions[0]].blocks[0];
        let mut out = Vec::new();
        for s in &b[def].operands {
            if b[*s].ty != Type::Index {
                continue;
            }
            match b[*s].def {
                Def::Arg(blk, _) if blk == entry => out.push(*s),
                _ => return Vec::new(),
            }
        }
        out
    }

    /// `updateReturnOps`; the dynamic sizes of the hoisted allocations.
    fn update_returns(&self, b: &mut Body<'_>, f: OpId, out: &[ValueId]) -> Vec<Vec<ValueId>> {
        let rets: Vec<OpId> = b.ops_in(f).into_iter().filter(|o| b[*o].name == "func.return").collect();
        let mut first = None;
        for r in rets {
            let ops = b[r].operands.clone();
            let (copy, keep): (Vec<ValueId>, Vec<ValueId>) = ops.iter().partition(|v| Memref::shaped(&b[**v].ty).is_some());
            let mut sizes = Vec::new();
            for (orig, arg) in copy.iter().zip(out) {
                let s = Memref::shaped(&b[*orig].ty).expect("a memref").clone();
                let st = Memref::static_shape(&s);
                let hoist = (self.hoist_static && st) || (self.hoist_dynamic && !st);
                let alloc = b.def_op(*orig).filter(|d| matches!(&*b[*d].name, "memref.alloc" | "memref.alloca" | "memref.realloc"));
                match alloc {
                    Some(d) if hoist => {
                        let ds = if !st { Self::dynamic_size(b, *orig, f) } else { Vec::new() };
                        b.replace_all_uses(*orig, *arg);
                        if !st {
                            sizes.push(ds);
                        }
                        b.erase(d);
                    }
                    _ => {
                        let c = b.create(OpData::build("memref.copy").operands(&[*orig, *arg]), &[]);
                        b.insert_before(c, r);
                    }
                }
            }
            let n = b.create(OpData::build("func.return").operands(&keep), &[]);
            b.insert_before(n, r);
            b.erase(r);
            first.get_or_insert(sizes);
        }
        first.unwrap_or_default()
    }

    /// `updateCalls`.
    fn update_calls(&self, b: &mut Body<'_>, module: OpId, sizes: &BTreeMap<OpId, Vec<Vec<ValueId>>>) -> Result<(), Error> {
        let mut calls = Vec::new();
        b.walk_post(module, &mut |o| {
            if b[o].name == "func.call" {
                calls.push(o);
            }
        });
        for call in calls {
            let name = match b[call].get("callee") {
                Some(Attribute::SymbolRef(p)) if p.len() == 1 => alloc::string::String::from(p[0].trim_matches('"')),
                _ => continue,
            };
            let Some(callee) = b.lookup(module, &name).filter(|c| b[*c].name == "func.func") else {
                return Err(Error(format!("cannot find callee '@{name}' in symbol table")));
            };
            if self.skip(b, callee) {
                continue;
            }
            let results = b[call].results.clone();
            let (outs, keep): (Vec<ValueId>, Vec<ValueId>) = results.iter().partition(|v| Memref::shaped(&b[**v].ty).is_some());
            let ds = sizes.get(&callee).cloned().unwrap_or_default();
            let mut k = 0;
            let mut params = Vec::new();
            for m in outs {
                let s = Memref::shaped(&b[m].ty).expect("a memref").clone();
                let st = Memref::static_shape(&s);
                let mut d = ds.get(k).cloned().unwrap_or_default();
                if !st && d.is_empty() {
                    return Err(Error("cannot create out param for dynamically shaped result".into()));
                }
                if st {
                    d.clear();
                } else {
                    k += 1;
                    let entry = b[b[callee].regions[0]].blocks[0];
                    let cargs = b[entry].args.clone();
                    d = d.iter().flat_map(|v| b[call].operands.iter().zip(&cargs).filter(|(_, a)| *a == v).map(|(o, _)| *o).collect::<Vec<_>>()).collect();
                }
                let at = Memref::without_layout(&s);
                let a = b.create(OpData::build("memref.alloc").operands(&d).segments(&[d.len(), 0]), &[at]);
                b.insert_before(a, call);
                let mut p = b[a].results[0];
                if !crate::MemrefToLlvm::identity_layout(&s) {
                    let c = b.create(OpData::build("memref.cast").operands(&[p]), &[b[m].ty.clone()]);
                    b.insert_before(c, call);
                    p = b[c].results[0];
                }
                b.replace_all_uses(m, p);
                params.push(p);
            }
            let mut ops = b[call].operands.clone();
            ops.extend(params);
            let callee_attr = b[call].get("callee").cloned().expect("callee");
            let types: Vec<Type> = keep.iter().map(|v| b[*v].ty.clone()).collect();
            let n = b.create(OpData::build("func.call").operands(&ops).with("callee", callee_attr), &types);
            b.insert_before(n, call);
            for (o, r) in keep.iter().zip(b[n].results.clone()) {
                b.replace_all_uses(*o, r);
            }
            b.erase(call);
        }
        Ok(())
    }
}

impl Run for BufferResultsToOutParams {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut sizes = BTreeMap::new();
        let top = body[body[op].regions[0]].blocks[0];
        for f in body[top].ops.clone() {
            if body[f].name != "func.func" || self.skip(body, f) {
                continue;
            }
            let out = self.update_func(body, f)?;
            let s = self.update_returns(body, f, &out);
            sizes.entry(f).or_insert(s);
        }
        self.update_calls(body, op, &sizes)
    }
}
