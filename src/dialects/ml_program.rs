use crate::OpInterfaces;

pub struct MlProgramDialect;

impl OpInterfaces for MlProgramDialect {
    fn namespace(&self) -> &str {
        "ml_program"
    }

    fn asm_result_names(&self, b: &crate::Body<'_>, op: crate::OpId) -> alloc::vec::Vec<(crate::ValueId, alloc::borrow::Cow<'static, str>)> {
        match &*b[op].name {
            "ml_program.global_load" | "ml_program.global_load_const" => match b[op].get("global") {
                Some(mlirformat::Attribute::SymbolRef(path)) => match path.last() {
                    Some(leaf) => b.result_named(op, alloc::string::String::from(leaf.trim_matches('"'))),
                    None => alloc::vec::Vec::new(),
                },
                _ => alloc::vec::Vec::new(),
            },
            _ => b.ods_result_names(op),
        }
    }

    #[cfg(feature = "dialect.bufferization")]
    fn bufferizable(&self, name: &str) -> Option<&dyn crate::Bufferizable> {
        Self::bufferizable_op(name)
    }
}

#[cfg(feature = "dialect.bufferization")]
mod bufferizable {
    use alloc::format;
    use alloc::vec::Vec;

    use mlirformat::{Attribute, Error, Type};

    use super::MlProgramDialect;
    use crate::{buffer_of, replace_with_buffers, AliasingValue, AnalysisState, Body, Bufferizable, BufferizationOptions, OpData, OpId, Operand, Rewriter, ValueId};

    struct Global;
    struct GlobalLoad;
    struct GlobalStore;

    impl MlProgramDialect {
        pub(crate) fn bufferizable_op(name: &str) -> Option<&'static dyn Bufferizable> {
            Some(match name {
                "ml_program.global" => &Global,
                "ml_program.global_load" => &GlobalLoad,
                "ml_program.global_store" => &GlobalStore,
                _ => return None,
            })
        }
    }

    fn identity<'a>(t: &Type<'a>) -> Result<Type<'a>, Error> {
        match t {
            Type::Shaped(s) => Ok(BufferizationOptions::identity(s, None)),
            _ => Err(Error("expected a tensor".into())),
        }
    }

    fn get_global<'a>(rw: &mut Rewriter<'_, 'a>, op: OpId, ty: Type<'a>) -> ValueId {
        let leaf = match rw.body[op].get("global") {
            Some(Attribute::SymbolRef(path)) => path.last().cloned().unwrap_or_default(),
            _ => Default::default(),
        };
        let g = rw.create(OpData::build("memref.get_global").with("name", Attribute::SymbolRef(alloc::vec![leaf])), &[ty]);
        rw.body[g].results[0]
    }

    impl Bufferizable for Global {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn tensor_semantics(&self, _: &Body<'_>, _: OpId) -> bool {
            true
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, _: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let d = rw.body[op].clone();
            let Some(value) = d.get("value").cloned() else { return Err(Error(format!("'{}' op global op must have a value", d.name))) };
            let Some(Attribute::Type(t)) = d.get("type") else { return Err(Error("a global without a type".into())) };
            let ty = identity(t)?;
            let mut data = OpData::build("memref.global").with("sym_name", d.get("sym_name").cloned().unwrap_or(Attribute::Unit)).with("type", Attribute::Type(ty)).with("initial_value", value);
            if let Some(v) = d.get("sym_visibility") {
                data.set("sym_visibility", v.clone());
            }
            if d.get("is_mutable").is_none() {
                data = data.flag("constant");
            }
            rw.replace_with(op, data, &[]);
            Ok(())
        }
    }

    impl Bufferizable for GlobalLoad {
        fn reads(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writes(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> bool {
            false
        }

        fn writable(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: ValueId) -> bool {
            false
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, _: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let ty = identity(&rw.body[rw.body[op].results[0]].ty.clone())?;
            let v = get_global(rw, op, ty);
            replace_with_buffers(rw, op, &[v]);
            Ok(())
        }
    }

    impl Bufferizable for GlobalStore {
        fn aliasing_values(&self, _: &AnalysisState<'_>, _: &Body<'_>, _: Operand) -> Vec<AliasingValue> {
            Vec::new()
        }

        fn bufferize(&self, rw: &mut Rewriter<'_, '_>, o: &BufferizationOptions, op: OpId) -> Result<(), Error> {
            let value = rw.body[op].operands[0];
            let ty = identity(&rw.body[value].ty.clone())?;
            let target = get_global(rw, op, ty);
            let source = buffer_of(rw, o, value)?;
            rw.mem_cpy(source, target);
            rw.erase_op(op);
            Ok(())
        }
    }
}
