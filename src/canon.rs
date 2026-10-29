//! ⭐ What each dialect contributes to canonicalization: op folds, canonicalization patterns, and
//! how it materializes a folded constant. One file per dialect.

/// Declares rewrite patterns: one unit struct each, rooted at an op name, with a benefit (DRR
/// patterns: the number of ops they match) and a body that matches and rewrites.
/// A root of `_` matches any op (`OpInterfaceRewritePattern`s).
macro_rules! rewrites {
    (@root _) => { None };
    (@root $root:literal) => { Some($root) };
    ($($(#[$m:meta])* $name:ident($root:tt, $benefit:literal) |$rw:ident, $op:ident| $body:block)*) => {$(
        $(#[$m])*
        pub struct $name;

        impl $crate::Pattern for $name {
            fn name(&self) -> &str {
                stringify!($name)
            }

            fn root(&self) -> Option<&str> {
                rewrites!(@root $root)
            }

            fn benefit(&self) -> u16 {
                $benefit
            }

            #[allow(unused_variables)]
            fn rewrite(&self, $rw: &mut $crate::Rewriter<'_, '_>, $op: $crate::OpId) -> bool $body
        }
    )*};
}

mod affine;
mod arith;
mod cf;
mod func;
mod gpu;
mod linalg;
mod math;
mod memref;
mod reshape;
mod scf;
mod shape;
mod spirv;
mod tensor;
mod test;
mod tosa;
mod vector;

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use crate::{Body, MemrefLayout, OpData, OpId, PatternSet, Trait, ValueId};

pub use memref::Ofr as MemrefOfr;
pub use reshape::Reshape;
#[cfg(feature = "spirv")]
pub(crate) use spirv::gl_patterns as spirv_gl_patterns;

impl<'a> OpData<'a> {
    /// A detached op named `name` as its ODS builder makes it: its default-valued properties
    /// (added from the context when it is created in a [`Body`](crate::Body)) and what the
    /// builder sets.
    pub fn build(name: &str) -> Self {
        let mut d = OpData::named(String::from(name));
        for (k, v) in builder_sets(name) {
            d.set(k, v);
        }
        d.defaults = true;
        d
    }

    pub fn operands(mut self, v: &[ValueId]) -> Self {
        self.operands = v.to_vec();
        self
    }

    pub fn with(mut self, name: &str, value: Attribute<'a>) -> Self {
        self.set(name, value);
        self
    }

    /// A unit attribute (inherent or not).
    pub fn flag(mut self, name: &str) -> Self {
        self.set(name, Attribute::Unit);
        self
    }

    /// Adds attributes `a` (each as [`OpData::set`] does).
    pub fn attrs(mut self, a: Vec<NamedAttr<'a>>) -> Self {
        for n in a {
            self.set(&n.name, n.value.unwrap_or(Attribute::Unit));
        }
        self
    }
}

/// What the C++ builders of op `name` set besides its declared defaults (those come from the
/// context, [`MlirOpt::defaults`](mlirformat::MlirOpt::defaults)).
fn builder_sets<'a>(name: &str) -> Vec<(&'static str, Attribute<'a>)> {
    match name {
        "vector.load" | "vector.store" | "memref.load" | "memref.store" => alloc::vec![("nontemporal", Attribute::Bool(false))],
        "llvm.call" | "llvm.call_intrinsic" => alloc::vec![("op_bundle_sizes", Attribute::DenseArray { ty: Type::int(32), values: Vec::new() })],
        _ => Vec::new(),
    }
}

/// `memref::CastOp::canFoldIntoConsumerOp`: a cast from `src` to the less static `dst`.
pub fn memref_cast_foldable(src: &Type<'_>, dst: &Type<'_>) -> bool {
    let (Type::Shaped(s), Type::Shaped(d)) = (src, dst) else { return false };
    if s.kind != mlirformat::ShapedKind::MemRef || d.kind != s.kind || s.elem != d.elem {
        return false;
    }
    let (Some(ss), Some(ds)) = (&s.shape, &d.shape) else { return false };
    if ss.len() != ds.len() {
        return false;
    }
    let (Some((sst, so)), Some((dst_, doff))) = (s.strides_and_offset(), d.strides_and_offset()) else { return false };
    let more_static = |a: i64, b: i64| a == mlirformat::Dim::DYNAMIC && b != mlirformat::Dim::DYNAMIC;
    let dim = |x: &mlirformat::Dim| if let mlirformat::Dim::Static(n) = x { *n } else { mlirformat::Dim::DYNAMIC };
    !(ss.iter().zip(ds).any(|(a, b)| more_static(dim(a), dim(b))) || more_static(so, doff) || sst.iter().zip(&dst_).any(|(a, b)| more_static(*a, *b)))
}

/// `memref::CastOp::areCastCompatible` for ranked memrefs: same element type and memory
/// space, same rank, and no static size, stride or offset that differ.
pub fn memref_cast_compatible(a: &Type<'_>, b: &Type<'_>) -> bool {
    let (Type::Shaped(s), Type::Shaped(d)) = (a, b) else { return false };
    let space = |t: &mlirformat::Shaped<'_>| t.extras.iter().find(|x| !matches!(x, Attribute::Builtin { name, .. } if name == "strided" || name == "affine_map")).map(Attribute::owned);
    if s.elem != d.elem || space(s) != space(d) {
        return false;
    }
    let (Some(ss), Some(ds)) = (&s.shape, &d.shape) else { return false };
    if ss.len() != ds.len() {
        return false;
    }
    let ok = |x: i64, y: i64| x == mlirformat::Dim::DYNAMIC || y == mlirformat::Dim::DYNAMIC || x == y;
    let dim = |x: &mlirformat::Dim| if let mlirformat::Dim::Static(n) = x { *n } else { mlirformat::Dim::DYNAMIC };
    let (Some((sst, so)), Some((dst_, doff))) = (s.strides_and_offset(), d.strides_and_offset()) else { return false };
    ok(so, doff) && sst.iter().zip(&dst_).all(|(x, y)| ok(*x, *y)) && ss.iter().zip(ds).all(|(x, y)| ok(dim(x), dim(y)))
}

impl<'a> Body<'a> {
    /// The op defining `v`, if it is named `name`.
    pub fn def_named(&self, v: ValueId, name: &str) -> Option<OpId> {
        self.def_op(v).filter(|o| self[*o].name == name)
    }
}

/// The fold hook of `op`, by its dialect.
pub fn fold<'a>(body: &mut Body<'a>, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
    match body[op].name.split_once('.').map(|(ns, _)| ns) {
        Some("arith") => arith::Folder { b: body, op, c: consts }.fold(),
        Some("math") => arith::Folder { b: body, op, c: consts }.math(),
        Some("scf") => scf::fold(body, op),
        Some("gpu") => gpu::fold(body, op),
        Some("builtin") => body.fold_unrealized_cast(op),
        Some("affine") => affine::fold(body, op),
        Some("memref") => memref::fold(body, op),
        #[cfg(feature = "llvm")]
        Some("llvm") => crate::llvm_fold(body, op, consts),
        Some("vector") => vector::Folder { b: body, op, c: consts }.fold(),
        Some("shape") => shape::fold(body, op, consts),
        Some("tensor") => tensor::fold(body, op, consts),
        Some("tosa") => tosa::fold(body, op, consts),
        Some("linalg") => linalg::fold(body, op, consts),
        Some("spirv") => spirv::Folder { b: body, op, c: consts }.fold(),
        _ => Fold::Failed,
    }
}

impl<'a> Body<'a> {
    /// `UnrealizedConversionCastOp::fold`: a cast to its own types, or back through a cast
    /// all of whose results it takes, is its inputs.
    fn fold_unrealized_cast(&self, op: OpId) -> Fold<'a> {
        if self[op].name != "builtin.unrealized_conversion_cast" {
            return Fold::Failed;
        }
        let (ins, outs) = (&self[op].operands, &self[op].results);
        let values = |vs: &[ValueId]| Fold::Results(vs.iter().map(|v| Folded::Value(*v)).collect());
        if self.types(ins) == self.types(outs) {
            return values(ins);
        }
        let Some(inner) = ins.first().and_then(|v| self.def_op(*v)).filter(|d| self[*d].name == "builtin.unrealized_conversion_cast") else { return Fold::Failed };
        if self[inner].results != *ins || self.types(&self[inner].operands) != self.types(outs) {
            return Fold::Failed;
        }
        values(&self[inner].operands)
    }
}

/// `Dialect::materializeConstant` of dialect `ns`.
pub fn materialize<'a>(ns: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    match ns {
        "arith" => arith::materialize(value, ty),
        // `MathDialect::materializeConstant`: poison as `ub.poison`, the rest as arith does.
        "math" if value.is_poison() => Some(OpData::build("ub.poison").with("value", value.clone())),
        "math" => arith::materialize(value, ty),
        "affine" => affine::materialize(value, ty),
        "memref" => memref::materialize(value, ty),
        #[cfg(feature = "llvm")]
        "llvm" => crate::llvm_materialize(value, ty),
        "vector" => vector::materialize(value, ty),
        "shape" => shape::materialize(value, ty),
        "tensor" | "linalg" => arith::materialize(value, ty),
        "tosa" => tosa::materialize(value, ty),
        "spirv" => spirv::materialize(value, ty),
        "ub" => value.is_poison().then(|| OpData::build("ub.poison").with("value", value.clone())),
        _ => None,
    }
}

/// `populateVectorToVectorCanonicalizationPatterns`.
pub fn vector_to_vector_canonicalization(set: &mut PatternSet) {
    set.add(vector::CreateMaskFolder);
    set.add(vector::MaskedLoadFolder);
    set.add(vector::MaskedStoreFolder);
    set.add(vector::GatherFolder);
    set.add(vector::ScatterFolder);
    set.add(vector::ExpandLoadFolder);
    set.add(vector::CompressStoreFolder);
    set.add(vector::StridedSliceConstantMaskFolder);
    set.add(vector::TransposeFolder);
}

/// Every dialect's and op's canonicalization patterns, in registration order.
pub fn patterns() -> PatternSet {
    let mut set = PatternSet::default();
    affine::patterns(&mut set);
    arith::patterns(&mut set);
    cf::patterns(&mut set);
    func::patterns(&mut set);
    gpu::patterns(&mut set);
    linalg::patterns(&mut set);
    memref::patterns(&mut set);
    scf::patterns(&mut set);
    shape::patterns(&mut set);
    spirv::patterns(&mut set);
    tensor::patterns(&mut set);
    test::patterns(&mut set);
    tosa::patterns(&mut set);
    vector::patterns(&mut set);
    set
}

// Folding, as `Operation::fold` and `Dialect::materializeConstant`.
//
// An op folds through its own hook (per dialect, in [`crate::canon`]) and, when that fails or
// folds to the op itself, through its traits' (`IsCommutative`, `IsInvolution`, `IsIdempotent`).

/// One folded result: an existing value, or a constant still to be materialized.
#[derive(Debug, Clone, PartialEq)]
pub enum Folded<'a> {
    Value(ValueId),
    Attr(Attribute<'a>),
}

/// What a fold hook did.
#[derive(Debug, Clone, PartialEq)]
pub enum Fold<'a> {
    Failed,
    /// The op changed in place.
    InPlace,
    Results(Vec<Folded<'a>>),
}

impl<'a> From<Folded<'a>> for Fold<'a> {
    fn from(f: Folded<'a>) -> Self {
        Fold::Results(alloc::vec![f])
    }
}

impl<'a> From<Option<Folded<'a>>> for Fold<'a> {
    fn from(f: Option<Folded<'a>>) -> Self {
        f.map_or(Fold::Failed, Fold::from)
    }
}

impl<'a> From<ValueId> for Folded<'a> {
    fn from(v: ValueId) -> Self {
        Folded::Value(v)
    }
}

impl<'a> From<Attribute<'a>> for Folded<'a> {
    fn from(a: Attribute<'a>) -> Self {
        Folded::Attr(a)
    }
}

impl<'a> Body<'a> {
    /// `m_Constant`: the value of a `ConstantLike` op.
    pub fn constant_value(&self, op: OpId) -> Option<Attribute<'a>> {
        if !self.has(op, Trait::ConstantLike) {
            return None;
        }
        match self.interfaces(op) {
            Some(i) => i.constant_value(self, op),
            None => self[op].get("value").cloned(),
        }
    }

    /// The constant behind `v`, if its defining op is one.
    pub fn constant_of(&self, v: ValueId) -> Option<Attribute<'a>> {
        self.def_op(v).and_then(|o| self.constant_value(o))
    }

    /// The integer constant behind `v` (a scalar, not a splat).
    pub fn int_constant(&self, v: ValueId) -> Option<i128> {
        crate::Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?.as_int().map(|i| i.signed())
    }

    /// Each operand's constant value, as fold hooks receive them.
    pub fn operand_constants(&self, op: OpId) -> Vec<Option<Attribute<'a>>> {
        self[op].operands.iter().map(|v| self.constant_of(*v)).collect()
    }

    /// ⭐ `Operation::fold`.
    pub fn fold(&mut self, op: OpId) -> Fold<'a> {
        if !self.registered(op) {
            return Fold::Failed;
        }
        let consts = self.operand_constants(op);
        self.fold_with(op, &consts)
    }

    /// `Operation::fold(operands)`: folding with the given operand constants.
    pub fn fold_with(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        if !self.registered(op) {
            return Fold::Failed;
        }
        let consts = consts.to_vec();
        let own = crate::canon::fold(self, op, &consts);
        let to_self = matches!(&own, Fold::Results(r) if self[op].results.len() == 1 && r.first() == Some(&Folded::Value(self[op].results[0])));
        match own {
            Fold::Failed => self.fold_traits(op, &consts),
            _ if to_self => match self.fold_traits(op, &consts) {
                Fold::Failed => Fold::InPlace,
                f => f,
            },
            f => f,
        }
    }

    /// The traits' folds, in trait order: the first that succeeds wins.
    fn fold_traits(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let traits = self[op].info.map_or(&[][..], |i| i.traits);
        for t in traits {
            let f = match t {
                Trait::IsCommutative => self.fold_commutative(op, consts),
                Trait::IsInvolution => self.fold_involution(op),
                Trait::IsIdempotent => self.fold_idempotent(op),
                Trait::CastOpInterface => self.fold_cast(op),
                _ => Fold::Failed,
            };
            if f != Fold::Failed {
                return f;
            }
        }
        Fold::Failed
    }

    /// Constant operands move to the end, keeping their order.
    fn fold_commutative(&mut self, op: OpId, consts: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let operands = self[op].operands.clone();
        if operands.len() < 2 {
            return Fold::Failed;
        }
        let first = consts.iter().position(Option::is_some).unwrap_or(operands.len());
        let (head, tail) = operands.split_at(first);
        let tail_consts = &consts[first..];
        let mut moved: Vec<ValueId> = head.to_vec();
        moved.extend(tail.iter().zip(tail_consts).filter(|(_, c)| c.is_none()).map(|(v, _)| *v));
        moved.extend(tail.iter().zip(tail_consts).filter(|(_, c)| c.is_some()).map(|(v, _)| *v));
        if moved == operands {
            return Fold::Failed;
        }
        self.set_operands(op, moved);
        Fold::InPlace
    }

    /// `foldCastInterfaceOp`: a cast whose operand types are its result types is a no-op.
    fn fold_cast(&self, op: OpId) -> Fold<'a> {
        let d = &self[op];
        if d.operands.is_empty() || self.types(&d.operands) != self.types(&d.results) {
            return Fold::Failed;
        }
        Fold::Results(d.operands.iter().map(|v| Folded::Value(*v)).collect())
    }

    /// `op(op(x)) = x`.
    fn fold_involution(&self, op: OpId) -> Fold<'a> {
        let [x] = self[op].operands[..] else { return Fold::Failed };
        match self.def_op(x) {
            Some(inner) if self[inner].name == self[op].name => Folded::Value(self[inner].operands[0]).into(),
            _ => Fold::Failed,
        }
    }

    /// `op(op(x)) = op(x)` (and `op(x, x) = x` for two operands).
    fn fold_idempotent(&self, op: OpId) -> Fold<'a> {
        match self[op].operands[..] {
            [x] => match self.def_op(x) {
                Some(inner) if self[inner].name == self[op].name => Folded::Value(x).into(),
                _ => Fold::Failed,
            },
            [x, y] if x == y => Folded::Value(x).into(),
            _ => Fold::Failed,
        }
    }

    /// ⭐ `Dialect::materializeConstant` for the dialect of op `of`: the op to build, if the
    /// dialect can hold `value` as a `ty`.
    pub fn materialize(&self, of: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        crate::canon::materialize(of.split_once('.').map_or(of, |(ns, _)| ns), value, ty)
    }
}
