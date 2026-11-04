//! The `spirv` dialect's own transforms: `spirv-canonicalize-gl`,
//! `decorate-spirv-composite-type-layout`, `spirv-rewrite-inserts`,
//! `spirv-promote-to-replicated-constants` and `spirv-webgpu-prepare`; and the gpu side's
//! `spirv-attach-target`: what their passes (`passes/spirv/`) share.

use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Const, Scalar, Type};

use super::VulkanLayout;
use crate::{Body, OpId};


impl VulkanLayout {
    /// `VulkanLayoutUtils::isLegalType`: a pointer to a struct in an explicitly laid out
    /// storage class has offsets (or no members).
    pub(crate) fn is_legal(t: &Type<'_>) -> bool {
        let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(t) else { return true };
        let Ok(SpirvType::Struct { members, .. }) = SpirvType::try_from(&*pointee) else { return true };
        if !matches!(&*storage, "Uniform" | "StorageBuffer" | "PushConstant" | "PhysicalStorageBuffer") {
            return true;
        }
        let ms = members.unwrap_or_default();
        ms.is_empty() || ms.iter().any(|m| m.offset.is_some())
    }
}


/// `spirv::CompositeType::getNumElements` (`None`: not a composite with a count).
fn composite_len(t: &Type<'_>) -> Option<usize> {
    match SpirvType::try_from(t) {
        Ok(SpirvType::Array { len, .. }) => Some(len as usize),
        Ok(SpirvType::Struct { members: Some(ms), .. }) => Some(ms.len()),
        Ok(SpirvType::Matrix { cols, .. }) => Some(cols as usize),
        Ok(SpirvType::TensorArm { shape: Some(dims), .. }) => Some(dims.iter().product::<i64>() as usize),
        Ok(_) => None,
        Err(()) => matches!(t, Type::Shaped(_)).then(|| t.element_count()).flatten(),
    }
}

/// The single index of a `spirv.CompositeInsert`.
fn insert_index(body: &Body<'_>, op: OpId) -> Option<i64> {
    let Some(Attribute::Array(idx)) = body[op].get("indices") else { return None };
    let [i] = &idx[..] else { return None };
    Const::try_from(i).ok()?.as_int().map(|v| v.signed() as i64)
}

/// `collectInsertionChain`: the inserts filling a composite element by element, ending at `op`.
pub(crate) fn insertion_chain(body: &Body<'_>, mut op: OpId) -> Option<Vec<OpId>> {
    let ty = &body[body[op].operands[1]].ty;
    if matches!(SpirvType::try_from(ty), Ok(SpirvType::CoopMatrix { .. })) {
        return None;
    }
    let n = composite_len(ty)?;
    let mut index = insert_index(body, op)?;
    if index + 1 != n as i64 {
        return None;
    }
    let mut chain = alloc::vec![op; n];
    loop {
        chain[index as usize] = op;
        if index == 0 {
            return Some(chain);
        }
        op = body.def_op(body[op].operands[1]).filter(|d| body[*d].name == "spirv.CompositeInsert")?;
        index -= 1;
        if insert_index(body, op)? != index {
            return None;
        }
    }
}


/// `isa<spirv::CompositeType>`.
pub(crate) fn is_composite(t: &Type<'_>) -> bool {
    match SpirvType::try_from(t) {
        Ok(SpirvType::Array { .. } | SpirvType::RuntimeArray { .. } | SpirvType::Struct { .. } | SpirvType::Matrix { .. } | SpirvType::CoopMatrix { .. } | SpirvType::TensorArm { .. }) => true,
        Ok(_) => false,
        Err(()) => super::TargetEnv::is_valid_vector(t),
    }
}

/// `getSplatAttrAndNumElements`: the value a composite constant repeats, and how often.
pub(crate) fn splat<'a>(value: &Attribute<'a>, ty: Option<&Type<'a>>) -> Option<(Attribute<'a>, usize)> {
    if !is_composite(ty?) {
        return None;
    }
    if let Attribute::Array(es) = value {
        let first = es.first()?;
        if !es.iter().all(|e| e == first) {
            return None;
        }
        // The innermost repeated value of an array of composites.
        let inner_ty = element_type(first);
        return Some(match splat(first, inner_ty.as_ref()) {
            Some((a, n)) => (a, n * es.len()),
            None => (first.clone(), es.len()),
        });
    }
    // A `dense<..> : !spirv.arm.tensor<..>` reads as the tensor of its shape.
    let c = Const::try_from(value).ok().or_else(|| {
        let Attribute::Builtin { name, body, ty: Some(t) } = value else { return None };
        let Ok(SpirvType::TensorArm { shape: Some(dims), elem }) = SpirvType::try_from(t) else { return None };
        let c = Const::try_from(&Attribute::Builtin { name: name.clone(), body: body.clone(), ty: Some(Type::tensor(&dims, (*elem).clone())) }).ok()?;
        Some(Const { ty: t.clone(), ..c })
    })?;
    if !c.elements || !c.is_splat() {
        return None;
    }
    let elem = match SpirvType::try_from(&c.ty) {
        Ok(SpirvType::TensorArm { elem, .. }) => (*elem).clone(),
        _ => c.ty.element_type().clone(),
    };
    let one = match c.at(0) {
        Scalar::Int(v) if elem == Type::I1 => Attribute::Bool(!v.is_zero()),
        v => Const::scalar(v, elem).into(),
    };
    let n = match SpirvType::try_from(&c.ty) {
        Ok(SpirvType::CoopMatrix { rows, cols, .. }) => (rows * cols) as usize,
        Ok(_) => composite_len(&c.ty)?,
        Err(()) => c.ty.element_count()?,
    };
    Some((one, n))
}

/// `getArrayElemType`: a typed attribute's type, an array attribute's as a `spirv.array`.
fn element_type<'a>(a: &Attribute<'a>) -> Option<Type<'a>> {
    match a {
        Attribute::Array(es) => Some(SpirvType::Array { len: es.len() as u32, elem: element_type(es.first()?)?.into(), stride: 0 }.into()),
        a => Const::try_from(a).ok().map(|c| c.ty),
    }
}




/// The `llvm::Regex` subset module matchers use: literals, `.`, `*`, `+`, `?`, `^`, `$`;
/// [`Regex::search`] matches anywhere, as `Regex::match` does.
pub(crate) struct Regex<'p>(pub(crate) &'p [u8]);

impl Regex<'_> {
    pub(crate) fn search(&self, s: &str) -> bool {
        let s = s.as_bytes();
        if let Some(p) = self.0.strip_prefix(b"^") {
            return Regex(p).here(s);
        }
        (0..=s.len()).any(|i| self.here(&s[i..]))
    }

    /// Whether the pattern matches a prefix of `s`.
    fn here(&self, s: &[u8]) -> bool {
        let p = self.0;
        let Some(&c) = p.first() else { return true };
        if c == b'$' && p.len() == 1 {
            return s.is_empty();
        }
        let one = |x: Option<&u8>| x.is_some_and(|x| c == b'.' || *x == c);
        match p.get(1) {
            Some(b'*') => (0..=s.len()).take_while(|n| *n == 0 || one(s.get(n - 1))).any(|n| s[..n].iter().all(|x| one(Some(x))) && Regex(&p[2..]).here(&s[n..])),
            Some(b'+') => one(s.first()) && Regex(&[&[c, b'*'][..], &p[2..]].concat()).here(&s[1..]),
            Some(b'?') => (one(s.first()) && Regex(&p[2..]).here(&s[1..])) || Regex(&p[2..]).here(s),
            _ => one(s.first()) && Regex(&p[1..]).here(&s[1..]),
        }
    }
}

