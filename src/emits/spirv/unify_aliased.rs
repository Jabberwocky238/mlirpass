//! `spirv-unify-aliased-resource` (`UnifyAliasedResourcePass.cpp`): the `aliased` buffers
//! bound to one descriptor become one, the others' loads, stores and access chains rewritten
//! to its element type.

use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Const, Error, Type};

use super::lower::symbol_text;
use crate::{Body, ConversionConfig, ConversionPattern, ConversionRewriter, ConversionTarget, Converter, Mode, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `(set, binding)`.
type Descriptor = (i64, i64);

/// `ResourceAliasAnalysis`: per descriptor, its aliased globals and the canonical one.
#[derive(Default)]
struct AliasAnalysis {
    canonical: BTreeMap<Descriptor, String>,
    descriptor: BTreeMap<String, Descriptor>,
    elem: BTreeMap<String, Type<'static>>,
}

impl AliasAnalysis {
    fn int(body: &Body<'_>, op: OpId, name: &str) -> Option<i64> {
        body[op].get(name).and_then(|a| Const::try_from(a).ok()?.as_int()).map(|i| i.signed() as i64)
    }

    /// `collectAliasedResources`: the `aliased` globals with a descriptor, in walk order.
    fn collect(body: &Body<'_>, module: OpId) -> BTreeMap<Descriptor, Vec<OpId>> {
        let mut out: BTreeMap<Descriptor, Vec<OpId>> = BTreeMap::new();
        body.walk(module, &mut |o| {
            if body[o].name == "spirv.GlobalVariable"
                && body[o].get("aliased").is_some()
                && let (Some(set), Some(binding)) = (Self::int(body, o, "descriptor_set"), Self::int(body, o, "binding"))
            {
                out.entry((set, binding)).or_default().push(o);
            }
        });
        out
    }

    /// `getRuntimeArrayElementType`: `T` of a `!spirv.ptr<!spirv.struct<(!spirv.rtarray<T>)>>`.
    fn runtime_array_elem<'a>(t: &Type<'a>) -> Option<Type<'a>> {
        let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(t) else { return None };
        let Ok(SpirvType::Struct { members: Some(ms), .. }) = SpirvType::try_from(&*pointee) else { return None };
        let [m] = &ms[..] else { return None };
        match SpirvType::try_from(&m.ty) {
            Ok(SpirvType::RuntimeArray { elem, .. }) => Some((*elem).clone()),
            _ => None,
        }
    }

    fn is_scalar(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { .. } | Type::Float(_))
    }

    fn is_vector(t: &Type<'_>) -> bool {
        matches!(t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector)
    }

    /// `getSizeInBytes` of a scalar or vector.
    fn bytes(t: &Type<'_>) -> Option<i64> {
        Some(i64::from(t.element_type().bit_width()? / 8) * t.element_count()? as i64)
    }

    /// `deduceCanonicalResource`: the smallest vector (its scalars dividing everything), else
    /// the smallest scalar dividing the others.
    fn deduce(types: &[Type<'_>]) -> Option<usize> {
        let (mut scalar_bits, mut vector_bits, mut vector_at) = (Vec::new(), Vec::new(), Vec::new());
        for (i, t) in types.iter().enumerate() {
            if Self::is_vector(t) {
                if t.element_count()? % 2 != 0 {
                    return None;
                }
                scalar_bits.push(i64::from(t.element_type().bit_width()?));
                vector_bits.push(Self::bytes(t)? * 8);
                vector_at.push(i);
            } else {
                scalar_bits.push(i64::from(t.bit_width()?));
            }
        }
        if !vector_bits.is_empty() {
            let (pos, min) = vector_bits.iter().enumerate().min_by_key(|(_, b)| **b).map(|(p, b)| (p, *b))?;
            if vector_bits.iter().any(|b| b % min != 0) {
                return None;
            }
            let index = vector_at[pos];
            let base = scalar_bits[index];
            return scalar_bits.iter().all(|b| b % base == 0).then_some(index);
        }
        let (pos, min) = scalar_bits.iter().enumerate().min_by_key(|(_, b)| **b).map(|(p, b)| (p, *b))?;
        scalar_bits.iter().all(|b| b % min == 0).then_some(pos)
    }

    fn new(body: &Body<'_>, module: OpId) -> Self {
        let mut a = Self::default();
        for (d, vars) in Self::collect(body, module) {
            let Some(types) = vars.iter().map(|v| match body[*v].get("type") {
                Some(Attribute::Type(t)) => Self::runtime_array_elem(t).filter(|e| Self::is_scalar(e) || Self::is_vector(e)),
                _ => None,
            }).collect::<Option<Vec<_>>>() else { continue };
            let Some(index) = Self::deduce(&types) else { continue };
            let name = |v: OpId| body[v].get("sym_name").and_then(symbol_text).unwrap_or_default();
            a.canonical.insert(d, name(vars[index]));
            for (v, t) in vars.iter().zip(types) {
                a.descriptor.insert(name(*v), d);
                a.elem.insert(name(*v), t.owned());
            }
        }
        a
    }

    fn canonical_of(&self, var: &str) -> Option<&str> {
        self.canonical.get(self.descriptor.get(var)?).map(String::as_str)
    }

    /// The global an `spirv.mlir.addressof` names.
    fn var_of(body: &Body<'_>, addr: OpId) -> Option<String> {
        body[addr].get("variable").and_then(symbol_text)
    }

    /// `shouldUnify`.
    fn should_unify(&self, body: &Body<'_>, op: Option<OpId>) -> bool {
        let Some(op) = op else { return false };
        match &*body[op].name {
            "spirv.GlobalVariable" => {
                let name = body[op].get("sym_name").and_then(symbol_text).unwrap_or_default();
                self.canonical_of(&name).is_some_and(|c| c != name)
            }
            "spirv.mlir.addressof" => Self::var_of(body, op).is_some_and(|v| self.canonical_of(&v).is_some_and(|c| c != v)),
            "spirv.AccessChain" | "spirv.Load" | "spirv.Store" => self.should_unify(body, body.def_op(body[op].operands[0])),
            _ => false,
        }
    }
}

/// The type an access chain from a `base` pointer through `indices` points to.
fn chain_type<'a>(body: &Body<'a>, base: &Type<'a>, indices: &[ValueId]) -> Option<Type<'a>> {
    let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(base) else { return None };
    let mut t = (*pointee).clone();
    for i in indices {
        t = match SpirvType::try_from(&t) {
            Ok(SpirvType::Struct { members: Some(ms), .. }) => {
                let k = body.constant_of(*i).and_then(|a| Const::try_from(&a).ok()?.as_int())?.signed() as usize;
                ms.get(k)?.ty.clone()
            }
            Ok(SpirvType::Array { elem, .. } | SpirvType::RuntimeArray { elem, .. }) => (*elem).clone(),
            Ok(SpirvType::Matrix { column, .. }) => (*column).clone(),
            _ => t.element_type().clone(),
        };
    }
    Some(SpirvType::ptr(t, &storage))
}

/// The rewrites of `ConvertVariable`, `ConvertAddressOf`, `ConvertAccessChain`, `ConvertLoad`
/// and `ConvertStore`, one per root.
struct Unify<'x> {
    root: &'static str,
    an: &'x AliasAnalysis,
}

impl Unify<'_> {
    fn addressof(&self, cr: &mut Cr<'_, '_, '_>, op: OpId) -> bool {
        let Some(var) = AliasAnalysis::var_of(&cr.rw.body, op) else { return false };
        let Some(dst) = self.an.canonical_of(&var) else { return false };
        // The canonical global's type, as `AddressOfOp::build` takes it.
        let b = &cr.rw.body;
        let mut module = b.parent_op(op);
        while let Some(o) = module.filter(|o| b[*o].name != "spirv.module") {
            module = b.parent_op(o);
        }
        let Some(m) = module else { return false };
        let global = b[b.top_block(m)].ops.iter().find(|g| b[**g].get("sym_name").and_then(symbol_text).as_deref() == Some(dst));
        let Some(Attribute::Type(ty)) = global.and_then(|g| b[*g].get("type").cloned()) else { return false };
        cr.replace_new(op, OpData::build("spirv.mlir.addressof").with("variable", Attribute::SymbolRef(alloc::vec![String::from(dst).into()])), &[ty]);
        true
    }

    fn access_chain(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let b = &cr.rw.body;
        let Some(addr) = b.def_op(b[op].operands[0]).filter(|d| b[*d].name == "spirv.mlir.addressof") else { return false };
        let Some(src) = AliasAnalysis::var_of(b, addr) else { return false };
        let Some(dst) = self.an.canonical_of(&src) else { return false };
        let (Some(st), Some(dt)) = (self.an.elem.get(&src).cloned(), self.an.elem.get(dst).cloned()) else { return false };
        let base = ops[0];
        let mut indices = b[op].operands[1..].to_vec();
        let same_width = AliasAnalysis::is_scalar(&st) && AliasAnalysis::is_scalar(&dt) && st.bit_width() == dt.bit_width();
        if st != dt && !same_width {
            let (Some(sb), Some(db)) = (AliasAnalysis::bytes(&st), AliasAnalysis::bytes(&dt)) else { return false };
            let old = *indices.last().expect("an index");
            let ity = cr.rw.body[old].ty.clone();
            if AliasAnalysis::is_scalar(&st) && AliasAnalysis::is_vector(&dt) {
                let ratio = cr.spirv_const(ity.clone(), Attribute::integer(i128::from(db / sb), ity.clone()));
                let div = cr.build(OpData::build("spirv.SDiv").operands(&[old, ratio]), ity.clone());
                let rem = cr.build(OpData::build("spirv.SMod").operands(&[old, ratio]), ity);
                *indices.last_mut().expect("an index") = div;
                indices.push(rem);
            } else if AliasAnalysis::is_vector(&st) == AliasAnalysis::is_vector(&dt) {
                let ratio = cr.spirv_const(ity.clone(), Attribute::integer(i128::from(sb / db), ity.clone()));
                let mul = cr.build(OpData::build("spirv.IMul").operands(&[old, ratio]), ity);
                *indices.last_mut().expect("an index") = mul;
            } else {
                return false;
            }
        }
        let base_ty = cr.rw.body[base].ty.clone();
        let Some(ty) = chain_type(&cr.rw.body, &base_ty, &indices) else { return false };
        let mut all = alloc::vec![base];
        all.extend(indices);
        cr.replace_new(op, OpData::build("spirv.AccessChain").operands(&all), &[ty]);
        true
    }

    fn load(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let pointee = |t: &Type<'_>| match SpirvType::try_from(t) {
            Ok(SpirvType::Ptr { pointee, .. }) => Some((*pointee).owned()),
            _ => None,
        };
        let (Some(st), Some(dt)) = (pointee(&cr.rw.body[cr.rw.body[op].operands[0]].ty), pointee(&cr.rw.body[ops[0]].ty)) else { return false };
        let first = cr.build(OpData::build("spirv.Load").operands(&[ops[0]]), dt.clone());
        if st == dt {
            cr.replace_values(op, &[first]);
            return true;
        }
        let (ss, ds) = (AliasAnalysis::is_scalar(&st), AliasAnalysis::is_scalar(&dt));
        if ss && ds && st.bit_width() == dt.bit_width() {
            let v = cr.build(OpData::build("spirv.Bitcast").operands(&[first]), st);
            cr.replace_values(op, &[v]);
            return true;
        }
        let (sv, dv) = (AliasAnalysis::is_vector(&st), AliasAnalysis::is_vector(&dt));
        if !((ss && ds) || (sv && dv)) {
            return false;
        }
        let (Some(sb), Some(db)) = (AliasAnalysis::bytes(&st), AliasAnalysis::bytes(&dt)) else { return false };
        let ratio = sb / db;
        if ratio > 4 {
            return false;
        }
        let Some(ac) = cr.rw.body.def_op(ops[0]).filter(|d| cr.rw.body[*d].name == "spirv.AccessChain") else { return false };
        let one = cr.spirv_const(Type::int(32), Attribute::integer(1, Type::int(32)));
        let base = cr.rw.body[ac].operands[0];
        let mut indices = cr.rw.body[ac].operands[1..].to_vec();
        let mut parts = alloc::vec![first];
        for _ in 1..ratio {
            let last = *indices.last().expect("an index");
            *indices.last_mut().expect("an index") = cr.build(OpData::build("spirv.IAdd").operands(&[last, one]), Type::int(32));
            let base_ty = cr.rw.body[base].ty.clone();
            let Some(pt) = chain_type(&cr.rw.body, &base_ty, &indices) else { return false };
            let mut all = alloc::vec![base];
            all.extend(indices.iter().copied());
            let chain = cr.build(OpData::build("spirv.AccessChain").operands(&all), pt);
            parts.push(cr.build(OpData::build("spirv.Load").operands(&[chain]), dt.clone()));
        }
        let vector_ty = if sv { st.clone() } else { Type::vector(&[ratio], &[], dt.clone()) };
        if sv && dv && st.element_type() != dt.element_type() {
            let se = st.element_type().clone();
            let count = db / i64::from(se.bit_width().unwrap_or(8) / 8);
            let cast = if count > 1 { Type::vector(&[count], &[], se) } else { se };
            for p in &mut parts {
                *p = cr.build(OpData::build("spirv.Bitcast").operands(&[*p]), cast.clone());
            }
        }
        let mut v = cr.build(OpData::build("spirv.CompositeConstruct").operands(&parts), vector_ty);
        if !sv {
            v = cr.build(OpData::build("spirv.Bitcast").operands(&[v]), st);
        }
        cr.replace_values(op, &[v]);
        true
    }

    fn store(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let pointee = |t: &Type<'_>| match SpirvType::try_from(t) {
            Ok(SpirvType::Ptr { pointee, .. }) => Some((*pointee).owned()),
            _ => None,
        };
        let (Some(st), Some(dt)) = (pointee(&cr.rw.body[cr.rw.body[op].operands[0]].ty), pointee(&cr.rw.body[ops[0]].ty)) else { return false };
        if !AliasAnalysis::is_scalar(&st) || !AliasAnalysis::is_scalar(&dt) || st.bit_width() != dt.bit_width() {
            return false;
        }
        let mut value = ops[1];
        if st != dt {
            value = cr.build(OpData::build("spirv.Bitcast").operands(&[value]), dt);
        }
        let attrs = cr.rw.body[op].all_attrs();
        let mut data = OpData::build("spirv.Store").operands(&[ops[0], value]);
        for a in attrs {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        cr.replace_new(op, data, &[]);
        true
    }
}

impl ConversionPattern for Unify<'_> {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn rewrite(&self, cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        match self.root {
            "spirv.GlobalVariable" => {
                cr.erase(op);
                true
            }
            "spirv.mlir.addressof" => self.addressof(cr, op),
            "spirv.AccessChain" => self.access_chain(cr, op, operands),
            "spirv.Load" => self.load(cr, op, operands),
            _ => self.store(cr, op, operands),
        }
    }
}

/// `spirv-unify-aliased-resource`.
#[crate::pass("spirv-unify-aliased-resource", on = "spirv.module")]
pub fn spirv_unify_aliased_resource<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
    const ROOTS: [&str; 5] = ["spirv.GlobalVariable", "spirv.mlir.addressof", "spirv.AccessChain", "spirv.Load", "spirv.Store"];
    let an = AliasAnalysis::new(body, module);
    let mut target = ConversionTarget::default();
    target.legal_dialect("spirv");
    for r in ROOTS {
        target.dynamic_op(r, |b: &Body<'_>, o| Some(!an.should_unify(b, Some(o))));
    }
    let mut patterns = crate::ConversionPatterns::default();
    for root in ROOTS {
        patterns.add(Unify { root, an: &an });
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[module], Mode::Partial)?;
    for vars in AliasAnalysis::collect(body, module).into_values() {
        if let [v] = vars[..] {
            body[v].remove("aliased");
        }
    }
    Ok(())
}
