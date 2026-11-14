use alloc::collections::BTreeMap;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, FunctionType, Type};
use crate::pass;

use crate::{Body, OpData, OpId, Run, ValueId, Visibility};

#[pass("drop-equivalent-buffer-results", on = "builtin.module")]
pub struct DropEquivalentBufferResults {
    #[opt("modify-public-functions")]
    modify_public: bool,
}

impl DropEquivalentBufferResults {
    fn skip(&self, b: &Body<'_>, f: OpId) -> bool {
        (b.visibility(f) == Visibility::Public && !self.modify_public) || b[b[f].regions[0]].blocks.is_empty()
    }

    fn is_argument(b: &Body<'_>, mut v: ValueId, arg: ValueId) -> bool {
        while let Some(c) = b.def_named(v, "memref.cast") {
            v = b[c].operands[0];
        }
        v == arg
    }

    fn kept<T>(xs: Vec<T>, dropped: &BTreeMap<usize, usize>) -> Vec<T> {
        xs.into_iter().enumerate().filter(|(i, _)| !dropped.contains_key(i)).map(|(_, x)| x).collect()
    }

    fn drop_results(b: &mut Body<'_>, f: OpId) -> BTreeMap<usize, usize> {
        let region = b[f].regions[0];
        let returns: Vec<OpId> = b[region].blocks.iter().filter_map(|k| b.last_op(*k)).filter(|t| b[*t].name == "func.return").collect();
        let mut to_arg = BTreeMap::new();
        if returns.is_empty() {
            return to_arg;
        }
        let Some(Attribute::Type(Type::Function(ft))) = b[f].get("function_type").cloned() else { return to_arg };
        let args = b[b[region].blocks[0]].args.clone();
        for i in 0..ft.results.len() {
            let ops: Vec<ValueId> = returns.iter().map(|r| b[*r].operands[i]).collect();
            if let Some(a) = args.iter().position(|a| ops.iter().all(|o| Self::is_argument(b, *o, *a))) {
                to_arg.insert(i, a);
            }
        }
        b[f].set("function_type", Attribute::Type(Type::Function(alloc::boxed::Box::new(FunctionType { inputs: ft.inputs.clone(), results: Self::kept(ft.results.clone(), &to_arg) }))));
        if let Some(Attribute::Array(xs)) = b[f].get("res_attrs").cloned() {
            b[f].set("res_attrs", Attribute::Array(Self::kept(xs, &to_arg)));
        }
        for r in returns {
            let ops = Self::kept(b[r].operands.to_vec(), &to_arg);
            b.set_operands(r, ops);
        }
        to_arg
    }
}

impl Run for DropEquivalentBufferResults {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut calls: BTreeMap<OpId, Vec<OpId>> = BTreeMap::new();
        let mut all = Vec::new();
        body.walk_post(op, &mut |o| {
            if body[o].name == "func.call" {
                all.push(o);
            }
        });
        for call in all {
            let Some(Attribute::SymbolRef(p)) = body[call].get("callee") else { continue };
            let [name] = &p[..] else { continue };
            let Some(callee) = body.lookup(op, name.trim_matches('"')).filter(|c| body[*c].name == "func.func") else { continue };
            if (body.visibility(callee) == Visibility::Public && !self.modify_public) || body[body[callee].regions[0]].blocks.is_empty() {
                continue;
            }
            calls.entry(callee).or_default().push(call);
        }
        let top = body[body[op].regions[0]].blocks[0];
        for f in body.block_ops(top) {
            if body[f].name != "func.func" || self.skip(body, f) {
                continue;
            }
            let to_arg = Self::drop_results(body, f);
            for call in calls.remove(&f).unwrap_or_default() {
                let results = body[call].results.clone();
                let keep: Vec<ValueId> = results.iter().enumerate().filter(|(i, _)| !to_arg.contains_key(i)).map(|(_, r)| *r).collect();
                let types: Vec<Type<'a>> = keep.iter().map(|v| body[*v].ty.clone()).collect();
                let callee = body[call].get("callee").cloned().expect("callee");
                let mut data = OpData::build("func.call").operands(&body[call].operands).with("callee", callee);
                data.loc = body[call].loc.clone();
                let n = body.create(data, &types);
                body.insert_before(n, call);
                let new_results = body[n].results.clone();
                for (r, nr) in keep.iter().zip(new_results) {
                    body.replace_all_uses(*r, nr);
                }
                for (i, a) in &to_arg {
                    let mut v = body[call].operands[*a];
                    let want = body[results[*i]].ty.clone();
                    if body[v].ty != want {
                        let c = body.create(OpData::build("memref.cast").operands(&[v]), &[want]);
                        body.insert_before(c, call);
                        v = body[c].results[0];
                    }
                    body.replace_all_uses(results[*i], v);
                }
                body.erase(call);
            }
        }
        Ok(())
    }
}
