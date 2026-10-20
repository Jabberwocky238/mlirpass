//! ⭐ What each dialect contributes to canonicalization: op folds, canonicalization patterns, and
//! how it materializes a folded constant. One file per dialect.

/// Declares rewrite patterns: one unit struct each, rooted at an op name, with a benefit (DRR
/// patterns: the number of ops they match) and a body that matches and rewrites.
macro_rules! rewrites {
    ($($(#[$m:meta])* $name:ident($root:literal, $benefit:literal) |$rw:ident, $op:ident| $body:block)*) => {$(
        $(#[$m])*
        pub struct $name;

        impl $crate::Pattern for $name {
            fn name(&self) -> &str {
                stringify!($name)
            }

            fn root(&self) -> Option<&str> {
                Some($root)
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
mod llvm;
mod memref;
mod reshape;
mod scf;
mod shape;
mod tensor;
mod tosa;
mod vector;

use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use crate::{Body, Fold, OpData, OpId, PatternSet, ValueId};

pub use memref::Ofr as MemrefOfr;
pub use reshape::Reshape;

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
/// context, [`OpRegistry::defaults`](mlirformat::OpRegistry::defaults)).
fn builder_sets<'a>(name: &str) -> Vec<(&'static str, Attribute<'a>)> {
    match name {
        "vector.load" | "vector.store" | "memref.load" | "memref.store" => alloc::vec![("nontemporal", Attribute::Bool(false))],
        "llvm.call" => alloc::vec![("op_bundle_sizes", Attribute::DenseArray { ty: Type::int(32), values: Vec::new() })],
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
    let opts = crate::LlvmOptions::default();
    let (Some((sst, so)), Some((dst_, doff))) = (opts.strides_and_offset(s), opts.strides_and_offset(d)) else { return false };
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
    let opts = crate::LlvmOptions::default();
    let (Some((sst, so)), Some((dst_, doff))) = (opts.strides_and_offset(s), opts.strides_and_offset(d)) else { return false };
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
        Some("scf") => scf::fold(body, op),
        Some("affine") => affine::fold(body, op),
        Some("memref") => memref::fold(body, op),
        Some("llvm") => llvm::fold(body, op, consts),
        Some("vector") => vector::Folder { b: body, op, c: consts }.fold(),
        Some("shape") => shape::fold(body, op, consts),
        Some("tensor") => tensor::fold(body, op, consts),
        Some("tosa") => tosa::fold(body, op, consts),
        _ => Fold::Failed,
    }
}

/// `Dialect::materializeConstant` of dialect `ns`.
pub fn materialize<'a>(ns: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    match ns {
        "arith" => arith::materialize(value, ty),
        "affine" => affine::materialize(value, ty),
        "memref" => memref::materialize(value, ty),
        "llvm" => llvm::materialize(value, ty),
        "vector" => vector::materialize(value, ty),
        "shape" => shape::materialize(value, ty),
        "tensor" => arith::materialize(value, ty),
        "tosa" => tosa::materialize(value, ty),
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
    memref::patterns(&mut set);
    scf::patterns(&mut set);
    shape::patterns(&mut set);
    tensor::patterns(&mut set);
    tosa::patterns(&mut set);
    vector::patterns(&mut set);
    set
}
