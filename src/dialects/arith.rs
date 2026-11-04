//! The `arith` dialect's op interfaces.

use crate::{Body, DialectInliner, InlineAll, OpId, OpInterfaces};

/// The `arith` dialect.
pub struct ArithDialect;

impl OpInterfaces for ArithDialect {
    fn namespace(&self) -> &str {
        "arith"
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }

    /// Every op inlines (`ArithInlinerInterface`).
    fn inliner(&self) -> Option<&dyn DialectInliner> {
        Some(&InlineAll { calls: false, regions: false })
    }

    fn speculatability(&self, b: &Body<'_>, op: OpId) -> Option<bool> {
        let divisor = || b.int_constant(b[op].operands[1]);
        match &*b[op].name {
            "arith.divui" | "arith.ceildivui" => divisor().filter(|v| *v != 0).map(|_| false),
            "arith.divsi" | "arith.ceildivsi" => divisor().filter(|v| *v != 0 && *v != -1).map(|_| false),
            _ => None,
        }
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::format;
    use alloc::string::String;
    use alloc::vec;
    use alloc::vec::Vec;

    use mlirformat::{Attribute, Error, Shaped, ShapedKind, Type};

    use super::ArithDialect;
    use crate::{buffer_of, buffer_type, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, OpData, OpId, Operand, Rewriter, ValueId};

    /// `arith.constant` (of a tensor), `arith.index_cast`, `arith.select`.
    struct Constant;
    struct IndexCast;
    struct Select;

    impl ArithDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "arith.constant" => &Constant,
                "arith.index_cast" => &IndexCast,
                "arith.select" => &Select,
                _ => return None,
            })
        }
    }

    /// The module around `op`.
    fn module_of(b: &Body<'_>, op: OpId) -> Option<OpId> {
        let mut at = b.parent_op(op);
        while let Some(p) = at {
            if b[p].name == "builtin.module" {
                return Some(p);
            }
            at = b.parent_op(p);
        }
        None
    }

    impl Bufferizable for Constant {
        fn writable(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: ValueId) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let r = rw.body[op].results[0];
            let Type::Shaped(t) = rw.body[r].ty.clone() else { return Err(Error("expected a tensor".into())) };
            if t.shape.is_none() {
                return Err(Error("expected a ranked tensor".into()));
            }
            let Some(space) = o.default_memory_space(&t) else { return Err(Error(format!("'{}' op could not infer memory space", rw.body[op].name))) };
            let Some(module) = module_of(rw.body, op) else { return Err(Error("no module".into())) };
            let value = rw.body[op].get("value").cloned().expect("a value");
            let alignment = o.buffer_alignment;
            let block = rw.body[rw.body[module].regions[0]].blocks[0];
            // An existing global of this value and alignment.
            let existing = rw.body[block].ops.iter().copied().find(|g| {
                let g = &rw.body[*g];
                g.name == "memref.global"
                    && g.get("initial_value") == Some(&value)
                    && g.get("alignment").map_or(0, |a| if let Attribute::Int { lit, .. } = a { lit.parse().unwrap_or(0) } else { 0 }) == alignment
            });
            let (name, ty) = match existing {
                Some(g) => {
                    let name = String::from(rw.body.sym_name(g).unwrap_or_default());
                    let ty = match rw.body[g].get("type") {
                        Some(Attribute::Type(ty)) => ty.clone(),
                        _ => return Err(Error("a global without a type".into())),
                    };
                    (name, ty)
                }
                None => {
                    let dims = t.dims().unwrap_or_default();
                    let shape: Vec<String> = dims.iter().map(|d| format!("{d}")).collect();
                    let base = format!("__constant_{}x{}", shape.join("x"), t.elem);
                    let mut name = base.clone();
                    let mut k = 0;
                    while rw.body.lookup(module, &name).is_some() {
                        name = format!("{base}_{k}");
                        k += 1;
                    }
                    let ty = BufferizationOptions::identity(&Shaped { kind: ShapedKind::Tensor, ..t.clone() }, space);
                    let mut data = OpData::build("memref.global")
                        .with("sym_name", Attribute::str(&name))
                        .with("sym_visibility", Attribute::str(&String::from("private")))
                        .with("type", Attribute::Type(ty.clone()))
                        .with("initial_value", value)
                        .flag("constant");
                    if alignment > 0 {
                        data.set("alignment", Attribute::integer(alignment as i128, Type::int(64)));
                    }
                    data.loc.clone_from(&rw.body[op].loc);
                    let saved = rw.ip;
                    rw.set_start(block);
                    rw.create(data, &[]);
                    rw.ip = saved;
                    (name, ty)
                }
            };
            let g = rw.create(OpData::build("memref.get_global").with("name", Attribute::SymbolRef(vec![name.into()])), &[ty]);
            let v = rw.body[g].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for IndexCast {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> Vec<AliasingValue> {
            vec![AliasingValue::equivalent(b[op].results[0])]
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let src = rw.body[op].operands[0];
            let source = buffer_of(rw, o, src)?;
            let elem = rw.body[rw.body[op].results[0]].ty.element_type().clone();
            let Type::Shaped(m) = rw.body[source].ty.clone() else { return Err(Error("expected a memref".into())) };
            let ty = Type::Shaped(Shaped { elem: elem.into(), ..m });
            let c = rw.create(OpData::build("arith.index_cast").operands(&[source]), &[ty]);
            let v = rw.body[c].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for Select {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn aliasing_values(&self, _: &AnalysisState<'_>, b: &Body<'_>, (op, _): Operand) -> Vec<AliasingValue> {
            vec![AliasingValue { value: b[op].results[0], relation: crate::BufferRelation::Equivalent, definite: false }]
        }

        /// Both sides' buffer type when they agree, else fully dynamic.
        fn buffer_type<'a>(&self, o: &BufferizationOptions, b: &Body<'a>, v: ValueId, stack: &mut Vec<ValueId>) -> Result<Type<'a>, Error> {
            let op = b.owner_of(v);
            let t = crate::buffer_type_in(o, b, b[op].operands[1], stack)?;
            let f = crate::buffer_type_in(o, b, b[op].operands[2], stack)?;
            if t == f {
                return Ok(t);
            }
            let (Type::Shaped(tm), Type::Shaped(fm)) = (&t, &f) else { return Err(Error("expected memrefs".into())) };
            let space = |m: &Shaped<'a>| m.extras.iter().find(|a| !a.is_layout()).cloned();
            if space(tm) != space(fm) {
                return Err(Error(format!("'{}' op inconsistent memory space on true/false operands", b[op].name)));
            }
            Ok(BufferizationOptions::fully_dynamic(&Shaped { kind: ShapedKind::Tensor, extras: Vec::new(), ..tm.clone() }, space(tm)))
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let cond = rw.body[op].operands[0];
            if rw.body[cond].ty != Type::int(1) {
                return Err(Error(format!("'{}' op only i1 condition values are supported", rw.body[op].name)));
            }
            let (tv, fv) = (rw.body[op].operands[1], rw.body[op].operands[2]);
            let mut t = buffer_of(rw, o, tv)?;
            let mut f = buffer_of(rw, o, fv)?;
            if rw.body[t].ty != rw.body[f].ty {
                let target = buffer_type(o, rw.body, rw.body[op].results[0])?;
                for x in [&mut t, &mut f] {
                    if rw.body[*x].ty != target {
                        let c = rw.create(OpData::build("memref.cast").operands(&[*x]), &[target.clone()]);
                        *x = rw.body[c].results[0];
                    }
                }
            }
            let ty = rw.body[t].ty.clone();
            let s = rw.create(OpData::build("arith.select").operands(&[cond, t, f]), &[ty]);
            let v = rw.body[s].results[0];
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }
}
