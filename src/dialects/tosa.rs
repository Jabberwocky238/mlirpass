use mlirformat::Attribute;

use crate::{Body, OpId, OpInterfaces};

pub struct TosaDialect;

impl OpInterfaces for TosaDialect {
    fn namespace(&self) -> &str {
        "tosa"
    }

    fn constant_value<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Attribute<'a>> {
        let d = &b[op];
        match &*d.name {
            "tosa.const" | "tosa.const_shape" => d.get("values").cloned(),
            _ => d.get("value").cloned(),
        }
    }

    fn reify<'a>(&self, rw: &mut crate::Rewriter<'_, 'a>, op: OpId) -> Option<alloc::vec::Vec<alloc::vec::Vec<crate::MemrefOfr>>> {
        use crate::MemrefOfr as Ofr;
        if rw.body[op].name != "tosa.transpose" {
            return None;
        }
        let input = rw.body[op].operands[0];
        let dims = rw.body[input].ty.dims()?;
        let perms = rw.body.dense_i64(op, "perms");
        let mut out = alloc::vec![Ofr::C(0); dims.len()];
        for &dim in &perms {
            let from = usize::try_from(*perms.get(usize::try_from(dim).ok()?)?).ok()?;
            out[usize::try_from(dim).ok()?] = if dims[from] == mlirformat::Dim::DYNAMIC {
                let k = rw.value_of(Ofr::C(from as i64));
                let d = rw.create(crate::OpData::build("tensor.dim").operands(&[input, k]), &[mlirformat::Type::Index]);
                Ofr::V(rw.body[d].results[0])
            } else {
                Ofr::C(dims[from])
            };
        }
        Some(alloc::vec![out])
    }
}
