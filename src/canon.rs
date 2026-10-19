//! ⭐ What each dialect contributes to canonicalization: op folds, canonicalization patterns, and
//! how it materializes a folded constant. One file per dialect.

mod arith;

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, Extended, NamedAttr, Type};

use crate::{Body, Fold, OpData, OpId, PatternSet, ValueId};

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
pub(crate) use rewrites;

/// Constructors for the attributes ops carry.
pub trait AttrExt<'a>: Sized {
    /// `#name<body>`: an enum or other dialect attribute.
    fn dialect(name: &str, body: &str) -> Self;
    /// `v : i64`, how ODS stores an integer enum.
    fn i64(v: i64) -> Self;
    /// A string attribute.
    fn string(s: &str) -> Self;
}

impl<'a> AttrExt<'a> for Attribute<'a> {
    fn dialect(name: &str, body: &str) -> Self {
        let body = (!body.is_empty()).then(|| Cow::Owned(String::from(body)));
        Attribute::Extended { ext: Extended { name: Cow::Owned(name.into()), body, params: Vec::new() }, ty: None }
    }

    fn i64(v: i64) -> Self {
        Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::int(64)) }
    }

    fn string(s: &str) -> Self {
        Attribute::Str { lit: Cow::Owned(s.into()), ty: None }
    }
}

impl<'a> OpData<'a> {
    /// A detached op named `name` with its default-valued properties, which ODS builders set
    /// and generic printing shows.
    pub fn build(name: &str) -> Self {
        let mut d = OpData::named(String::from(name));
        for (k, v) in defaults(name) {
            d.set(k, v);
        }
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

    pub fn attrs(mut self, a: Vec<NamedAttr<'a>>) -> Self {
        self.attributes = a;
        self
    }
}

/// The default-valued properties of op `name`.
fn defaults<'a>(name: &str) -> Vec<(&'static str, Attribute<'a>)> {
    match name {
        "arith.addi" | "arith.subi" | "arith.muli" | "arith.shli" | "arith.trunci" => alloc::vec![("overflowFlags", Attribute::dialect("arith.overflow", "<none>"))],
        "arith.addf" | "arith.subf" | "arith.mulf" | "arith.divf" | "arith.remf" | "arith.negf" | "arith.maximumf" | "arith.maxnumf" | "arith.minimumf" | "arith.minnumf" | "arith.cmpf" => alloc::vec![("fastmath", Attribute::dialect("arith.fastmath", "<none>"))],
        "ub.poison" => alloc::vec![("value", Attribute::dialect("ub.poison", ""))],
        _ => Vec::new(),
    }
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
        _ => Fold::Failed,
    }
}

/// `Dialect::materializeConstant` of dialect `ns`.
pub fn materialize<'a>(ns: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    match ns {
        "arith" => arith::materialize(value, ty),
        "ub" => crate::is_poison(value).then(|| OpData::build("ub.poison").with("value", value.clone())),
        _ => None,
    }
}

/// Every dialect's and op's canonicalization patterns, in registration order.
pub fn patterns() -> PatternSet {
    let mut set = PatternSet::default();
    arith::patterns(&mut set);
    set
}
