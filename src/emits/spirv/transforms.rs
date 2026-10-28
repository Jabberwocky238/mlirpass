//! The `spirv` dialect's own transforms: `spirv-canonicalize-gl`,
//! `decorate-spirv-composite-type-layout`, `spirv-rewrite-inserts`,
//! `spirv-promote-to-replicated-constants` and `spirv-webgpu-prepare`; and the gpu side's
//! `spirv-attach-target`.

use alloc::format;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Const, Error, Scalar, Type};

use super::VulkanLayout;
use crate::{Body, OpData, OpId, Rewriter, ValueId};

/// `spirv-canonicalize-gl`: the GLSL canonicalization patterns, greedily.
#[crate::pass("spirv-canonicalize-gl")]
pub fn spirv_canonicalize_gl<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = crate::PatternSet::default();
    crate::canon::spirv_gl_patterns(&mut patterns);
    for r in body[op].regions.clone() {
        body.apply_greedily(r, &patterns, &crate::GreedyConfig::default());
    }
    Ok(())
}

impl VulkanLayout {
    /// `VulkanLayoutUtils::isLegalType`: a pointer to a struct in an explicitly laid out
    /// storage class has offsets (or no members).
    fn is_legal(t: &Type<'_>) -> bool {
        let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(t) else { return true };
        let Ok(SpirvType::Struct { members, .. }) = SpirvType::try_from(&*pointee) else { return true };
        if !matches!(&*storage, "Uniform" | "StorageBuffer" | "PushConstant" | "PhysicalStorageBuffer") {
            return true;
        }
        let ms = members.unwrap_or_default();
        ms.is_empty() || ms.iter().any(|m| m.offset.is_some())
    }
}

/// `decorate-spirv-composite-type-layout`: each `spirv.module`'s globals of buffer structs
/// get Vulkan offsets and strides, and their `spirv.mlir.addressof`s the new type.
#[crate::pass("decorate-spirv-composite-type-layout", on = "builtin.module")]
pub fn decorate_spirv_composite_type_layout<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let modules: Vec<OpId> = body[body.top_block(module)].ops.iter().copied().filter(|o| body[*o].name == "spirv.module").collect();
    for m in modules {
        let mut retyped = Vec::new();
        for g in body[body.top_block(m)].ops.clone() {
            let Some(Attribute::Type(t)) = body[g].get("type").cloned().filter(|_| body[g].name == "spirv.GlobalVariable") else { continue };
            if VulkanLayout::is_legal(&t) {
                continue;
            }
            let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(&t) else { continue };
            let Some((decorated, ..)) = VulkanLayout::decorate(&pointee) else {
                return Err(Error(format!("'spirv.GlobalVariable' op failed to decorate (unsuported pointee type: '{pointee}')")));
            };
            let ty = SpirvType::ptr(decorated, &storage);
            body[g].set("type", Attribute::Type(ty.clone()));
            let name = body[g].get("sym_name").and_then(super::lower::symbol_text).unwrap_or_default();
            retyped.push((name, ty));
        }
        let mut addrs = Vec::new();
        body.walk(m, &mut |o| addrs.push(o));
        for o in addrs {
            if body[o].name != "spirv.mlir.addressof" {
                continue;
            }
            let Some(name) = body[o].get("variable").and_then(super::lower::symbol_text) else { continue };
            if let Some((_, ty)) = retyped.iter().find(|(n, _)| *n == name) {
                let r = body[o].results[0];
                body[r].ty = ty.clone();
            }
        }
    }
    Ok(())
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
fn insertion_chain(body: &Body<'_>, mut op: OpId) -> Option<Vec<OpId>> {
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

/// `spirv-rewrite-inserts`: a chain of inserts filling every element as one
/// `spirv.CompositeConstruct`.
#[crate::pass("spirv-rewrite-inserts", on = "spirv.module")]
pub fn spirv_rewrite_inserts<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut chains = Vec::new();
    body.walk_post(module, &mut |o| {
        if body[o].name == "spirv.CompositeInsert"
            && let Some(c) = insertion_chain(body, o)
        {
            chains.push(c);
        }
    });
    for chain in chains {
        let last = *chain.last().expect("a chain");
        let parts: Vec<ValueId> = chain.iter().map(|o| body[*o].operands[0]).collect();
        let ty = body[body[last].results[0]].ty.clone();
        let mut data = OpData::build("spirv.CompositeConstruct").operands(&parts);
        data.loc = body[last].loc.clone();
        let c = body.create(data, &[ty]);
        body.insert_before(c, last);
        let (from, to) = (body[last].results[0], body[c].results[0]);
        body.replace_all_uses(from, to);
        for o in chain.into_iter().rev() {
            if body[body[o].results[0]].uses.is_empty() {
                body.erase(o);
            }
        }
    }
    Ok(())
}

/// `isa<spirv::CompositeType>`.
fn is_composite(t: &Type<'_>) -> bool {
    match SpirvType::try_from(t) {
        Ok(SpirvType::Array { .. } | SpirvType::RuntimeArray { .. } | SpirvType::Struct { .. } | SpirvType::Matrix { .. } | SpirvType::CoopMatrix { .. } | SpirvType::TensorArm { .. }) => true,
        Ok(_) => false,
        Err(()) => super::TargetEnv::is_valid_vector(t),
    }
}

/// `getSplatAttrAndNumElements`: the value a composite constant repeats, and how often.
fn splat<'a>(value: &Attribute<'a>, ty: Option<&Type<'a>>) -> Option<(Attribute<'a>, usize)> {
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

/// `spirv-promote-to-replicated-constants`: splat composites as `SPV_EXT_replicated_composites`
/// replicates.
#[crate::pass("spirv-promote-to-replicated-constants", on = "spirv.module")]
pub fn spirv_promote_to_replicated_constants<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut ops = Vec::new();
    body.walk_post(module, &mut |o| ops.push(o));
    for o in ops {
        let replacement = match &*body[o].name {
            "spirv.Constant" => {
                let ty = body[body[o].results[0]].ty.clone();
                let Some((value, n)) = body[o].get("value").and_then(|v| splat(v, Some(&ty))) else { continue };
                if n == 1 {
                    continue;
                }
                let c = body.create(OpData::build("spirv.EXT.ConstantCompositeReplicate").with("value", value), &[ty]);
                body.insert_before(c, o);
                let (from, to) = (body[o].results[0], body[c].results[0]);
                body.replace_all_uses(from, to);
                c
            }
            "spirv.SpecConstantComposite" => {
                let Some(Attribute::Type(ty)) = body[o].get("type").cloned() else { continue };
                if !is_composite(&ty) {
                    continue;
                }
                let Some(Attribute::Array(parts)) = body[o].get("constituents").cloned() else { continue };
                if parts.len() == 1 || !parts.iter().all(|p| *p == parts[0]) || !matches!(&parts[0], Attribute::SymbolRef(s) if s.len() == 1) {
                    continue;
                }
                let Some(name) = body[o].get("sym_name").cloned() else { continue };
                let data = OpData::build("spirv.EXT.SpecConstantCompositeReplicate").with("constituent", parts[0].clone()).with("sym_name", name).with("type", Attribute::Type(ty));
                let c = body.create(data, &[]);
                body.insert_before(c, o);
                c
            }
            _ => continue,
        };
        body[replacement].loc = body[o].loc.clone();
        body.erase(o);
    }
    Ok(())
}

/// `getScalarOrSplatAttr`: `v` as an integer of `ty`, splat over a vector.
fn scalar_or_splat<'a>(ty: &Type<'a>, v: i128) -> Attribute<'a> {
    let w = ty.element_type().bit_width().unwrap_or(32);
    match ty {
        Type::Shaped(_) => Const::splat(Scalar::Int(mlirformat::ApInt::new(w, v)), ty.clone()).into(),
        t => Attribute::integer(v, t.clone()),
    }
}

/// The 32-bit integer operands of an op WGSL lacks.
fn i32_operands(rw: &Rewriter<'_, '_>, op: OpId) -> Option<(ValueId, ValueId, Type<'static>)> {
    let [l, r] = rw.body[op].operands[..] else { return None };
    let ty = rw.body[l].ty.owned();
    (matches!(ty.element_type(), Type::Integer { width: 32, .. })).then_some((l, r, ty))
}

impl<'a> Rewriter<'_, 'a> {
    fn spirv(&mut self, name: &str, ops: &[ValueId], ty: &Type<'a>) -> ValueId {
        let o = self.create(OpData::build(name).operands(ops), core::slice::from_ref(ty));
        self.body[o].results[0]
    }

    fn spirv_constant(&mut self, ty: &Type<'a>, v: i128) -> ValueId {
        let o = self.create(OpData::build("spirv.Constant").with("value", scalar_or_splat(ty, v)), core::slice::from_ref(ty));
        self.body[o].results[0]
    }

    /// `lowerExtendedMultiplication`: long multiplication in 16-bit digits.
    fn extended_mul(&mut self, op: OpId, lhs: ValueId, rhs: ValueId, ty: &Type<'a>, signed: bool) {
        let mask = self.spirv_constant(ty, (1 << 16) - 1);
        let c16 = self.spirv_constant(ty, 16);
        let c0 = self.spirv_constant(ty, 0);
        let low = |rw: &mut Self, v| rw.spirv("spirv.BitwiseAnd", &[v, mask], ty);
        let high = |rw: &mut Self, v| rw.spirv("spirv.ShiftRightLogical", &[v, c16], ty);
        let sign = |rw: &mut Self, v| {
            let s = rw.spirv("spirv.ShiftRightArithmetic", &[v, c16], ty);
            rw.spirv("spirv.ShiftRightLogical", &[s, c16], ty)
        };
        let (ll, lh) = (low(self, lhs), high(self, lhs));
        let le = if signed { sign(self, lhs) } else { c0 };
        let (rl, rh) = (low(self, rhs), high(self, rhs));
        let re = if signed { sign(self, rhs) } else { c0 };
        let (ld, rd) = ([ll, lh, le, le], [rl, rh, re, re]);
        let mut res = [c0; 4];
        for (i, l) in ld.iter().enumerate() {
            for (j, r) in rd.iter().enumerate() {
                if i + j >= 4 || *l == c0 || *r == c0 {
                    continue;
                }
                let mul = self.spirv("spirv.IMul", &[*l, *r], ty);
                let cur = self.create_or_fold(OpData::build("spirv.IAdd").operands(&[res[i + j], mul]), core::slice::from_ref(ty))[0];
                res[i + j] = low(self, cur);
                if i + j + 1 != 4 {
                    let h = high(self, cur);
                    res[i + j + 1] = self.create_or_fold(OpData::build("spirv.IAdd").operands(&[res[i + j + 1], h]), core::slice::from_ref(ty))[0];
                }
            }
        }
        let combine = |rw: &mut Self, l, h| {
            let hb = rw.spirv("spirv.ShiftLeftLogical", &[h, c16], ty);
            rw.spirv("spirv.BitwiseOr", &[l, hb], ty)
        };
        let (lo, hi) = (combine(self, res[0], res[1]), combine(self, res[2], res[3]));
        let rt = self.body[self.body[op].results[0]].ty.clone();
        let v = self.spirv("spirv.CompositeConstruct", &[lo, hi], &rt);
        self.replace_op(op, &[v]);
    }
}

rewrites! {
    /// `ExpandMulExtendedPattern<SMulExtendedOp>`.
    ExpandSMulExtendedPattern("spirv.SMulExtended", 1) |rw, op| {
        let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
        rw.set_before(op);
        rw.extended_mul(op, l, r, &ty, true);
        true
    }

    /// `ExpandMulExtendedPattern<UMulExtendedOp>`.
    ExpandUMulExtendedPattern("spirv.UMulExtended", 1) |rw, op| {
        let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
        rw.set_before(op);
        rw.extended_mul(op, l, r, &ty, false);
        true
    }

    /// `ExpandAddCarryPattern`: the carry is whether the sum wrapped below the lhs.
    ExpandAddCarryPattern("spirv.IAddCarry", 1) |rw, op| {
        let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
        rw.set_before(op);
        let one = rw.spirv_constant(&ty, 1);
        let zero = rw.spirv_constant(&ty, 0);
        let out = rw.spirv("spirv.IAdd", &[l, r], &ty);
        let cmp = rw.spirv("spirv.ULessThan", &[out, l], &ty.with_element(Type::I1));
        let carry = rw.spirv("spirv.Select", &[cmp, one, zero], &ty);
        let rt = rw.body[rw.body[op].results[0]].ty.clone();
        let v = rw.spirv("spirv.CompositeConstruct", &[out, carry], &rt);
        rw.replace_op(op, &[v]);
        true
    }

    /// `ExpandIsInfPattern` / `ExpandIsNanPattern`: values are assumed finite.
    ExpandIsInfPattern("spirv.IsInf", 1) |rw, op| {
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.Constant").with("value", scalar_or_splat(&ty, 0)), &[ty]);
        true
    }

    ExpandIsNanPattern("spirv.IsNan", 1) |rw, op| {
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.Constant").with("value", scalar_or_splat(&ty, 0)), &[ty]);
        true
    }
}

/// `spirv-webgpu-prepare`: what WGSL lacks (extended multiplication, add with carry, `IsInf`
/// / `IsNan`) expanded, greedily.
#[crate::pass("spirv-webgpu-prepare", on = "spirv.module")]
pub fn spirv_webgpu_prepare<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    let mut patterns = crate::PatternSet::default();
    patterns.add(ExpandSMulExtendedPattern);
    patterns.add(ExpandUMulExtendedPattern);
    patterns.add(ExpandAddCarryPattern);
    patterns.add(ExpandIsInfPattern);
    patterns.add(ExpandIsNanPattern);
    for r in body[module].regions.clone() {
        body.apply_greedily(r, &patterns, &crate::GreedyConfig::default());
    }
    Ok(())
}

/// The `llvm::Regex` subset module matchers use: literals, `.`, `*`, `+`, `?`, `^`, `$`;
/// [`Regex::search`] matches anywhere, as `Regex::match` does.
struct Regex<'p>(&'p [u8]);

impl Regex<'_> {
    fn search(&self, s: &str) -> bool {
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

/// `spirv-attach-target`: a `#spirv.target_env` appended to the `targets` of each
/// `gpu.module` whose name `module` matches.
#[crate::pass("spirv-attach-target")]
pub struct SpirvAttachTarget {
    #[opt("module")]
    module: alloc::string::String,
    #[opt("ver", default = alloc::string::String::from("v1.0"))]
    ver: alloc::string::String,
    #[opt("caps")]
    caps: Vec<alloc::string::String>,
    #[opt("exts")]
    exts: Vec<alloc::string::String>,
    #[opt("client_api", default = alloc::string::String::from("Unknown"))]
    client_api: alloc::string::String,
    #[opt("vendor", default = alloc::string::String::from("Unknown"))]
    vendor: alloc::string::String,
    #[opt("device_type", default = alloc::string::String::from("Unknown"))]
    device_type: alloc::string::String,
    #[opt("device_id", default = -1)]
    device_id: i64,
}

impl crate::Run for SpirvAttachTarget {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let known = |class: &str, name: &str| super::EnumSpec::of(class).is_some_and(|e| e.value(name).is_some());
        let fail = || Error(alloc::string::String::from("spirv-attach-target: invalid option"));
        for (class, v) in [("Version", &self.ver), ("ClientAPI", &self.client_api), ("Vendor", &self.vendor), ("DeviceType", &self.device_type)] {
            if !known(class, v) {
                return Err(fail());
            }
        }
        let caps: Vec<&str> = self.caps.iter().map(|c| &**c).filter(|c| known("Capability", c)).collect();
        let exts: Vec<&str> = self.exts.iter().map(|c| &**c).filter(|c| known("Extension", c)).collect();
        let mut text = format!("<#spirv.vce<{}, [{}], [{}]>, ", self.ver, caps.join(", "), exts.join(", "));
        if self.client_api != "Unknown" {
            text += &format!("{}, ", self.client_api);
        }
        if self.vendor != "Unknown" {
            text += &format!("{}:{}", self.vendor, self.device_type);
            if self.device_id >= 0 {
                text += &format!(":{}", self.device_id);
            }
            text += ", ";
        }
        text += "#spirv.resource_limits<>>";
        let target = Attribute::dialect("spirv.target_env", &text);
        let matcher = Regex(self.module.as_bytes());
        let mut modules = Vec::new();
        body.walk(op, &mut |o| {
            if body[o].name == "gpu.module" {
                modules.push(o);
            }
        });
        for m in modules {
            let name = body[m].get("sym_name").and_then(super::lower::symbol_text).unwrap_or_default();
            if !self.module.is_empty() && !matcher.search(&name) {
                continue;
            }
            let mut targets = match body[m].get("targets") {
                Some(Attribute::Array(ts)) => ts.clone(),
                _ => Vec::new(),
            };
            targets.push(target.clone());
            targets.dedup();
            body[m].set("targets", Attribute::Array(targets));
        }
        Ok(())
    }
}
