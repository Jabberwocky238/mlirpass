use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{Body, Const, Fold, Folded, OpData, OpId, Scalar};
use mlirformat::llvm_types::LlvmType;

fn positions(b: &Body<'_>, op: OpId) -> Vec<i64> {
    b[op].get("position").and_then(Attribute::dense_values).unwrap_or_default()
}

fn set_positions(b: &mut Body<'_>, op: OpId, p: &[i64]) {
    b[op].set("position", Attribute::dense_i64(&p));
}

fn extract_value<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let container = b[op].operands[0];
    if let Some(prev) = b.def_named(container, "llvm.extractvalue") {
        let mut p = positions(b, prev);
        p.extend(positions(b, op));
        let c = b[prev].operands[0];
        set_positions(b, op, &p);
        b.set_operand(op, 0, c);
        return Fold::InPlace;
    }
    if let Some(mut attr) = b.constant_of(container) {
        for p in positions(b, op) {
            match element_at(attr, p) {
                Some(x) => attr = x,
                None => return Fold::Failed,
            }
        }
        return Folded::Attr(attr).into();
    }
    let mut cur = container;
    let mut extract = positions(b, op);
    while let Some(ins) = b.def_named(cur, "llvm.insertvalue") {
        let ip = positions(b, ins);
        if extract == ip {
            return Folded::Value(b[ins].operands[1]).into();
        }
        if extract.len() > ip.len() && extract[..ip.len()] == ip[..] {
            cur = b[ins].operands[1];
            extract.drain(..ip.len());
            continue;
        }
        if ip.len() > extract.len() && ip[..extract.len()] == extract[..] {
            break;
        }
        cur = b[ins].operands[0];
    }
    if cur == container {
        return Fold::Failed;
    }
    set_positions(b, op, &extract);
    b.set_operand(op, 0, cur);
    Fold::InPlace
}

fn element_at(attr: Attribute<'_>, i: i64) -> Option<Attribute<'_>> {
    let i = usize::try_from(i).ok()?;
    match attr {
        Attribute::Array(xs) => xs.into_iter().nth(i),
        Attribute::Extended { ref ext, .. } if matches!(&*ext.name, "llvm.zero" | "llvm.undef" | "llvm.poison") => Some(attr),
        a => {
            let c = Const::elements_attr(&a)?;
            if c.ty.shape().is_none_or(|d| d.len() != 1) || i >= c.ty.element_count()? {
                return None;
            }
            let elem = c.ty.element_type().clone();
            Some(Const::scalar(c.at(i), elem).into())
        }
    }
}

fn icmp<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let pred = b[op].get("predicate").and_then(|a| if let Attribute::Int { lit, .. } = a { lit.parse::<i64>().ok() } else { None });
    let Some(pred @ (0 | 1)) = pred else { return Fold::Failed };
    let (l, r) = (b[op].operands[0], b[op].operands[1]);
    let ty = b[b[op].results[0]].ty.clone();
    let boolean = |v: bool| match &ty {
        Type::Shaped(_) => Const::splat(Scalar::Int(crate::ApInt::new(1, i128::from(v))), ty.clone()).into(),
        _ => Attribute::Bool(v),
    };
    if l == r {
        return Folded::Attr(boolean(pred == 0)).into();
    }
    if b.def_named(l, "llvm.alloca").is_some() && b.def_named(r, "llvm.mlir.zero").is_some() {
        return Folded::Attr(boolean(pred == 1)).into();
    }
    if b.def_named(l, "llvm.mlir.zero").is_some() && b.def_named(r, "llvm.alloca").is_some() {
        b.set_operand(op, 0, r);
        b.set_operand(op, 1, l);
        return Fold::InPlace;
    }
    Fold::Failed
}

fn chainable_cast<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
    let arg = b[op].operands[0];
    let rt = b[b[op].results[0]].ty.clone();
    if b[arg].ty == rt {
        return Folded::Value(arg).into();
    }
    let name = b[op].name.clone();
    if let Some(prev) = b.def_named(arg, &name) {
        let inner = b[prev].operands[0];
        if b[inner].ty == rt {
            return Folded::Value(inner).into();
        }
        b.set_operand(op, 0, inner);
        return Fold::InPlace;
    }
    Fold::Failed
}

fn gep<'a>(b: &mut Body<'a>, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
    const DYN: i64 = i32::MIN as i64;
    let raw: Vec<i64> = match b[op].get("rawConstantIndices") {
        Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
        _ => return Fold::Failed,
    };
    let base = b[op].operands[0];
    let dynamic: Vec<_> = b[op].operands[1..].to_vec();
    let const_of = |k: usize| consts.get(1 + k).cloned().flatten().and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int()).map(|i| i.signed());
    let rt = b[b[op].results[0]].ty.clone();
    if b[base].ty == rt && raw.len() == 1 {
        let v = if raw[0] == DYN { const_of(0) } else { Some(i128::from(raw[0])) };
        if v == Some(0) {
            return Folded::Value(base).into();
        }
    }
    let mut changed = false;
    let mut new_raw = Vec::new();
    let mut new_dyn = Vec::new();
    let mut k = 0;
    for r in &raw {
        if *r != DYN {
            new_raw.push(*r);
            continue;
        }
        match const_of(k).filter(|v| *v >= i128::from(i32::MIN) && *v <= i128::from(i32::MAX)) {
            Some(v) => {
                new_raw.push(v as i64);
                changed = true;
            }
            None => {
                new_raw.push(DYN);
                new_dyn.push(dynamic[k]);
            }
        }
        k += 1;
    }
    if !changed {
        return Fold::Failed;
    }
    let mut ops = alloc::vec![base];
    ops.extend(new_dyn);
    b.set_operands(op, ops);
    b[op].set("rawConstantIndices", Attribute::dense_i32(&new_raw));
    Fold::InPlace
}

pub struct LlvmCanon;

const METADATA_ATTRS: [&str; 4] = ["llvm.md_string", "llvm.md_constant", "llvm.md_func", "llvm.md_node"];

impl LlvmCanon {
    pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        match value {
            Attribute::SymbolRef(_) if matches!(LlvmType::try_from(ty), Ok(LlvmType::Ptr(_))) => Some(OpData::build("llvm.mlir.addressof").with("global_name", value.clone())),
            Attribute::Extended { ext, .. } if ext.name == "llvm.undef" => Some(OpData::build("llvm.mlir.undef")),
            Attribute::Extended { ext, .. } if ext.name == "llvm.poison" => Some(OpData::build("llvm.mlir.poison")),
            Attribute::Extended { ext, .. } if ext.name == "llvm.zero" => Some(OpData::build("llvm.mlir.zero")),
            Attribute::Extended { ext, .. } if METADATA_ATTRS.contains(&&*ext.name) && matches!(LlvmType::try_from(ty), Ok(LlvmType::Metadata)) => {
                Some(OpData::build("llvm.mlir.metadata_as_value").with("metadata", value.clone()))
            }
            Attribute::Int { .. } | Attribute::Float { .. } | Attribute::Bool(_) | Attribute::Builtin { .. } => Some(OpData::build("llvm.mlir.constant").with("value", value.clone())),
            _ => None,
        }
    }

    pub fn fold<'a>(b: &mut Body<'a>, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let name = b[op].name.clone();
        match &*name {
            "llvm.extractvalue" => extract_value(b, op),
            "llvm.icmp" => icmp(b, op),
            "llvm.mlir.addressof" => match b[op].get("global_name") {
                Some(a) => Folded::Attr(a.clone()).into(),
                None => Fold::Failed,
            },
            "llvm.mlir.undef" => Folded::Attr(Attribute::dialect("llvm.undef", "")).into(),
            "llvm.mlir.poison" => Folded::Attr(Attribute::dialect("llvm.poison", "")).into(),
            "llvm.mlir.zero" => {
                let ty = b[b[op].results[0]].ty.clone();
                let zero = match &ty {
                    Type::Integer { .. } | Type::Index => Some(Attribute::Int { lit: "0".into(), ty: Some(ty.clone()) }),
                    Type::Float(_) => Some(Attribute::Float { lit: "0.000000e+00".into(), ty: Some(ty.clone()) }),
                    _ => None,
                };
                Folded::Attr(zero.unwrap_or_else(|| Attribute::dialect("llvm.zero", ""))).into()
            }
            "llvm.mlir.metadata_as_value" => match b[op].get("metadata") {
                Some(a) => Folded::Attr(a.clone()).into(),
                None => Fold::Failed,
            },
            "llvm.mlir.constant" => match b[op].get("value") {
                Some(a) => Folded::Attr(a.clone()).into(),
                None => Fold::Failed,
            },
            "llvm.bitcast" | "llvm.addrspacecast" => chainable_cast(b, op),
            "llvm.zext" => {
                let ty = b[b[op].results[0]].ty.clone();
                let Some(c) = consts.first().cloned().flatten().and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements) else { return Fold::Failed };
                let Some(Scalar::Int(i)) = c.values.first().copied() else { return Fold::Failed };
                let w = ty.int_width().map_or(64, |w| w.0);
                Folded::Attr(Const::int(i.zext(w), ty).into()).into()
            }
            "llvm.shl" | "llvm.or" => {
                let ty = b[b[op].results[0]].ty.clone();
                let int = |k: usize| consts.get(k).cloned().flatten().and_then(|a| Const::try_from(&a).ok()).filter(|c| !c.elements).and_then(|c| c.as_int());
                let Some(r) = int(1) else { return Fold::Failed };
                if name == "llvm.shl" {
                    let w = ty.int_width().map_or(64, |w| w.0);
                    if r.unsigned() >= u128::from(w) {
                        return Fold::Failed;
                    }
                }
                let Some(l) = int(0) else { return Fold::Failed };
                let v = if name == "llvm.shl" { l.shl(r.unsigned() as u32) } else { l.or(r) };
                Folded::Attr(Const::int(v, ty).into()).into()
            }
            "llvm.getelementptr" => gep(b, op, consts),
            "llvm.shufflevector" => {
                let v1 = b[op].operands[0];
                let single = matches!(&b[v1].ty, Type::Shaped(s) if s.shape.as_deref() == Some(&[mlirformat::Dim::Static(1)][..]));
                if single && b.dense_i64(op, "mask") == [0] {
                    Folded::Value(v1).into()
                } else {
                    Fold::Failed
                }
            }
            _ => Fold::Failed,
        }
    }
}
