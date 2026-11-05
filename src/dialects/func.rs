//! The `func` dialect's op interfaces.

use core::ops::Range;

use crate::{BlockId, Body, DialectInliner, OpData, OpId, OpInterfaces, ValueId};

/// The `func` dialect.
pub struct FuncDialect;

impl OpInterfaces for FuncDialect {
    fn namespace(&self) -> &str {
        "func"
    }

    /// `OpAsmOpInterface::getAsmResultNames`.
    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        if b[op].name == "func.constant" { b.result_named(op, "f") } else { alloc::vec::Vec::new() }
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(self)
    }

    fn call_args(&self, b: &Body<'_>, call: OpId) -> Option<Range<usize>> {
        (b[call].name == "func.call_indirect").then(|| 1..b[call].operands.len())
    }

    fn indirect_callee(&self, b: &Body<'_>, call: OpId) -> Option<ValueId> {
        (b[call].name == "func.call_indirect").then(|| b[call].operands[0])
    }
}

/// `FuncInlinerInterface`.
impl DialectInliner for FuncDialect {
    /// Neither a `no_inline` call nor a `no_inline` function.
    fn legal_call(&self, b: &Body<'_>, call: OpId, callable: OpId) -> bool {
        !(b[call].name == "func.call" && b[call].get("no_inline").is_some()) && !(b[callable].name == "func.func" && b[callable].get("no_inline").is_some())
    }

    fn legal_region(&self, _: &Body<'_>, _: crate::RegionId) -> bool {
        true
    }

    fn legal_op(&self, _: &Body<'_>, _: OpId) -> bool {
        true
    }

    /// `func.return` as a `cf.br` to `dest`.
    fn branch_terminator(&self, b: &mut Body<'_>, op: OpId, dest: BlockId) {
        if b[op].name != "func.return" {
            return;
        }
        let mut data = OpData::build("cf.br").operands(&b[op].operands.clone());
        data.successors = smallvec::smallvec![dest];
        data.loc = b[op].loc.clone();
        let br = b.create(data, &[]);
        b.insert_before(br, op);
        b.erase(op);
    }

    fn replace_with_terminator(&self, b: &mut Body<'_>, op: OpId, results: &[ValueId]) {
        for (r, v) in results.iter().zip(b[op].operands.clone()) {
            b.replace_all_uses(*r, v);
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::vec::Vec;

    use mlirformat::{Attribute, Error, FunctionType, Type};

    use super::FuncDialect;
    use crate::{buffer_of, buffer_type, bufferize_block_signature, callee, cast_or_realloc, func_arg_attr, func_signature, is_tensor, replace_with_buffers, return_ops, AliasingValue, AnalysisState, Body, BufferRelation, Bufferizable, BufferizationOptions, Def, LayoutMapOption, OpData, OpId, Operand, Rewriter, ValueId};

    /// `func.func`, `func.return`, `func.call`.
    struct Func;
    struct Return;
    struct Call;

    impl FuncDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "func.func" => &Func,
                "func.return" => &Return,
                "func.call" => &Call,
                _ => return None,
            })
        }
    }

    impl BufferizationOptions {
        /// `functionArgTypeConverterFn`: identity or fully dynamic, per
        /// `function-boundary-type-conversion` (inference starts fully dynamic).
        pub(crate) fn function_arg_type<'a>(&self, t: &Type<'a>) -> Type<'a> {
            let Type::Shaped(s) = t else { return Self::tensor_like(t).unwrap_or_else(|| t.clone()) };
            let space = self.default_memory_space(s).flatten();
            match self.function_boundary_layout {
                LayoutMapOption::Identity => Self::identity(s, space),
                _ => Self::fully_dynamic(s, space),
            }
        }

        /// `getBufferizedFunctionArgType`: with the argument's `bufferization.buffer_layout`.
        fn bufferized_arg_type<'a>(&self, b: &Body<'a>, f: OpId, i: usize) -> Type<'a> {
            let t = func_signature(b, f).0[i].clone();
            if !is_tensor(&t) {
                return t;
            }
            let m = self.function_arg_type(&t);
            match (func_arg_attr(b, f, i, "bufferization.buffer_layout"), &m, &t) {
                (Some(layout), Type::Shaped(ms), Type::Shaped(ts)) => {
                    let space = ms.extras.iter().find(|a| !a.is_layout()).cloned();
                    Self::memref(ts, Some(layout.clone()), space)
                }
                _ => m,
            }
        }
    }

    impl Bufferizable for Func {
        fn tensor_semantics(&self, b: &Body<'_>, op: OpId) -> bool {
            let (i, r) = func_signature(b, op);
            i.iter().chain(&r).any(is_tensor) || b[op].regions.iter().any(|r| b[*r].blocks.iter().any(|blk| b[*blk].args.iter().any(|a| is_tensor(&b[*a].ty))))
        }

        fn aliasing_operands(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> Vec<crate::AliasingOperand> {
            AnalysisState::branch_aliasing_operands(b, v)
        }

        fn unstructured_control_flow(&self, _: &Body<'_>, _: OpId) -> bool {
            true
        }

        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let f = b.owner_of(v);
            match b[v].def {
                Def::Arg(blk, i) if b[b[f].regions[0]].blocks.first() == Some(&blk) => Ok(o.bufferized_arg_type(b, f, i as usize)),
                _ => AnalysisState::unstructured_buffer_type(o, b, v, stack),
            }
        }

        /// An entry argument is writable unless its `bufferization.writable` says not.
        fn writable(&self, _: &AnalysisState<'_>, b: &Body<'_>, v: ValueId) -> bool {
            let f = b.owner_of(v);
            match b[v].def {
                Def::Arg(blk, i) if b[b[f].regions[0]].blocks.first() == Some(&blk) => !matches!(func_arg_attr(b, f, i as usize, "bufferization.writable"), Some(Attribute::Bool(false))),
                _ => true,
            }
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let (inputs, results) = func_signature(rw.body, op);
            let args: Vec<Type<'_>> = (0..inputs.len()).map(|i| o.bufferized_arg_type(rw.body, op, i)).collect();
            let rets: Vec<Type<'_>> = results.iter().map(|t| if is_tensor(t) { o.function_arg_type(t) } else { t.clone() }).collect();
            let ty = Attribute::Type(Type::Function(FunctionType { inputs: args, results: rets.clone() }));
            if rw.body[op].regions.first().is_none_or(|r| rw.body[*r].blocks.is_empty()) {
                rw.modify(op, |b| b[op].set("function_type", ty));
                return Ok(());
            }
            let blocks = rw.body[rw.body[op].regions[0]].blocks.to_vec();
            for blk in blocks {
                bufferize_block_signature(rw, o, blk)?;
            }
            for r in return_ops(rw.body, op) {
                let operands = rw.body[r].operands.to_vec();
                let mut new = Vec::new();
                rw.set_before(r);
                for (v, t) in operands.iter().zip(&rets) {
                    if !is_tensor(&rw.body[*v].ty) {
                        new.push(*v);
                        continue;
                    }
                    let m = rw.create(OpData::build("bufferization.to_buffer").operands(&[*v]), core::slice::from_ref(t));
                    new.push(rw.body[m].results[0]);
                }
                rw.modify(r, |b| b.set_operands(r, new));
            }
            rw.modify(op, |b| b[op].set("function_type", ty));
            Ok(())
        }
    }

    impl Bufferizable for Return {
        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn bufferize(&self, _: &mut Rewriter<'_, '_>, _: &BufferizationOptions, _: OpId) -> Result<(), Error> {
            Ok(())
        }
    }

    impl Bufferizable for Call {
        fn reads(&self, s: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            match callee(b, op) {
                Some(f) if s.func_analyzed(f) => s.func_reads(f, i),
                _ => true,
            }
        }

        fn writes(&self, s: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> bool {
            match callee(b, op) {
                Some(f) if s.func_analyzed(f) => s.func_writes(f, i),
                _ => true,
            }
        }

        fn aliasing_values(&self, s: &AnalysisState<'_>, b: &Body<'_>, (op, i): Operand) -> Vec<AliasingValue> {
            let Some(f) = callee(b, op).filter(|f| s.func_analyzed(*f)) else {
                // `unknownGetAliasingValues`.
                return b[op].results.iter().filter(|v| is_tensor(&b[**v].ty)).map(|v| AliasingValue::unknown(*v, false)).collect();
            };
            let returns = s.func_aliasing(f, i);
            let equivalent = if returns.len() == 1 { s.func_equivalent(f, returns[0]) } else { None };
            returns
                .into_iter()
                .map(|r| AliasingValue { value: b[op].results[r], relation: if equivalent.is_some() { BufferRelation::Equivalent } else { BufferRelation::Unknown }, definite: equivalent.is_some() })
                .collect()
        }

        /// The callee's result type, bufferized at the boundary.
        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, _: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let Def::Result(op, k) = b[v].def else { return Err(Error("expected a result".into())) };
            let f = callee(b, op).ok_or_else(|| Error("no callee".into()))?;
            let t = func_signature(b, f).1[k as usize].clone();
            Ok(if is_tensor(&t) { o.function_arg_type(&t) } else { t })
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let results = rw.body[op].results.to_vec();
            let mut types = Vec::new();
            for r in &results {
                types.push(if is_tensor(&rw.body[*r].ty) { buffer_type(o, rw.body, *r)? } else { rw.body[*r].ty.clone() });
            }
            let f = callee(rw.body, op).ok_or_else(|| Error("no callee".into()))?;
            let inputs = func_signature(rw.body, f).0;
            let operands = rw.body[op].operands.to_vec();
            let mut new = Vec::new();
            for (k, v) in operands.iter().enumerate() {
                if !is_tensor(&rw.body[*v].ty) {
                    new.push(*v);
                    continue;
                }
                let mut buffer = buffer_of(rw, o, *v)?;
                let want = if is_tensor(&inputs[k]) {
                    let arg = rw.body[rw.body[rw.body[f].regions[0]].blocks.first().copied().ok_or_else(|| Error("external".into()))?].args[k];
                    buffer_type(o, rw.body, arg)?
                } else {
                    inputs[k].clone()
                };
                if rw.body[buffer].ty != want {
                    buffer = cast_or_realloc(rw, o, buffer, &want).ok_or_else(|| Error("cannot cast".into()))?;
                }
                new.push(buffer);
            }
            let old = rw.body[op].clone();
            let mut data = OpData::named(old.name.clone()).operands(&new);
            data.properties.clone_from(&old.properties);
            data.attributes.clone_from(&old.attributes);
            let c = rw.create(data, &types);
            let nr = rw.body[c].results.to_vec();
            replace_with_buffers(rw, op, &nr);
            Ok(())
        }
    }
}
