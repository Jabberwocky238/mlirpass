//! ⭐ What each dialect contributes to canonicalization: op folds, canonicalization patterns, and
//! how it materializes a folded constant. One `canonicalize.rs` per dialect directory; this is the dispatch.


use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use crate::{Body, MemrefLayout, OpData, OpId, PatternSet, Trait, ValueId};


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
        self.operands = v.to_vec().into();
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
        "memref.load" => alloc::vec![("nontemporal", Attribute::Bool(false)), ("invariant", Attribute::Bool(false))],
        "vector.load" | "vector.store" | "memref.store" => alloc::vec![("nontemporal", Attribute::Bool(false))],
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
/// space, same rank, and no static size, stride (but along unit dimensions) or offset that
/// differ.
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
    // (a stride along a unit dimension may differ)
    let strides = sst.iter().zip(&dst_).zip(ss.iter().zip(ds)).all(|((x, y), (a, b))| dim(a) == 1 || dim(b) == 1 || ok(*x, *y));
    a == b || (ok(so, doff) && strides && ss.iter().zip(ds).all(|(x, y)| ok(dim(x), dim(y))))
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
        #[cfg(feature = "dialect.arith")]
        Some("arith") => crate::ArithFolder { b: body, op, c: consts }.fold(),
        #[cfg(feature = "dialect.math")]
        Some("math") => crate::ArithFolder { b: body, op, c: consts }.math(),
        #[cfg(feature = "dialect.scf")]
        Some("scf") => crate::ScfCanon::fold(body, op),
        #[cfg(feature = "dialect.bufferization")]
        Some("bufferization") => crate::BufferizationCanon::fold(body, op),
        #[cfg(feature = "dialect.gpu")]
        Some("gpu") => crate::GpuCanon::fold(body, op),
        Some("builtin") => body.fold_unrealized_cast(op),
        #[cfg(feature = "dialect.affine")]
        Some("affine") => crate::AffineCanon::fold(body, op),
        #[cfg(feature = "dialect.memref")]
        Some("memref") => crate::MemrefCanon::fold(body, op),
        #[cfg(feature = "dialect.llvm")]
        Some("llvm") => crate::LlvmCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.vector")]
        Some("vector") => crate::VectorFolder { b: body, op, c: consts }.fold(),
        #[cfg(feature = "dialect.index")]
        Some("index") => crate::IndexCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.ptr")]
        Some("ptr") => crate::PtrCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.quant")]
        Some("quant") => crate::QuantCanon::fold(body, op),
        #[cfg(feature = "dialect.complex")]
        Some("complex") => crate::ComplexCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.shape")]
        Some("shape") => crate::ShapeCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.tensor")]
        Some("tensor") => crate::TensorCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.tosa")]
        Some("tosa") => crate::TosaCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.linalg")]
        Some("linalg") => crate::LinalgCanon::fold(body, op, consts),
        #[cfg(feature = "dialect.spirv")]
        Some("spirv") => crate::SpirvFolder { b: body, op, c: consts }.fold(),
        // An out-of-tree dialect folds through its interfaces.
        _ => match body.ctx.interfaces.of(&body[op].name) {
            Some(i) => i.fold(body, op, consts),
            None => Fold::Failed,
        },
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

/// `Dialect::materializeConstant` of dialect `ns` (none without a dialect feature).
#[allow(unused_variables)]
pub fn materialize<'a>(ns: &str, value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
    match ns {
        #[cfg(feature = "dialect.arith")]
        "arith" => crate::ArithCanon::materialize(value, ty),
        // `MathDialect::materializeConstant`: poison as `ub.poison`, the rest as arith does.
        #[cfg(feature = "dialect.math")]
        "math" if value.is_poison() => Some(OpData::build("ub.poison").with("value", value.clone())),
        #[cfg(feature = "dialect.math")]
        "math" => crate::ArithCanon::materialize(value, ty),
        #[cfg(feature = "dialect.affine")]
        "affine" => crate::AffineCanon::materialize(value, ty),
        #[cfg(feature = "dialect.memref")]
        "memref" => crate::MemrefCanon::materialize(value, ty),
        #[cfg(feature = "dialect.llvm")]
        "llvm" => crate::LlvmCanon::materialize(value, ty),
        #[cfg(feature = "dialect.vector")]
        "vector" => crate::VectorCanon::materialize(value, ty),
        #[cfg(feature = "dialect.shape")]
        "shape" => crate::ShapeCanon::materialize(value, ty),
        #[cfg(any(feature = "dialect.tensor", feature = "dialect.linalg"))]
        "tensor" | "linalg" => crate::ArithCanon::materialize(value, ty).or_else(|| Body::complex_constant(value, ty)),
        #[cfg(feature = "dialect.tosa")]
        "tosa" => crate::TosaCanon::materialize(value, ty),
        #[cfg(feature = "dialect.spirv")]
        "spirv" => crate::SpirvCanon::materialize(value, ty),
        #[cfg(feature = "dialect.index")]
        "index" => crate::IndexCanon::materialize(value, ty),
        #[cfg(feature = "dialect.complex")]
        "complex" => crate::ComplexCanon::materialize(value, ty),
        // `EmitCDialect::materializeConstant`: any attribute.
        #[cfg(feature = "dialect.emitc")]
        "emitc" => Some(OpData::build("emitc.constant").with("value", value.clone())),
        #[cfg(feature = "dialect.ub")]
        "ub" => value.is_poison().then(|| OpData::build("ub.poison").with("value", value.clone())),
        _ => None,
    }
}


/// Every dialect's and op's canonicalization patterns, in registration order (none without a dialect feature).
#[allow(unused_mut)]
pub fn patterns() -> PatternSet {
    let mut set = PatternSet::default();
    #[cfg(feature = "dialect.amdgpu")]
    crate::AmdgpuCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.affine")]
    crate::AffineCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.arith")]
    crate::ArithCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.bufferization")]
    crate::BufferizationCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.cf")]
    crate::CfCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.complex")]
    crate::ComplexCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.acc")]
    crate::AccCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.mpi")]
    crate::MpiCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.omp")]
    crate::OmpCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.sparse_tensor")]
    crate::SparseTensorCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.func")]
    crate::FuncCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.gpu")]
    crate::GpuCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.linalg")]
    crate::LinalgCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.memref")]
    crate::MemrefCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.scf")]
    crate::ScfCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.shape")]
    crate::ShapeCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.spirv")]
    crate::SpirvCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.tensor")]
    crate::TensorCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.test")]
    crate::TestCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.tosa")]
    crate::TosaCanon::canonicalization(&mut set);
    #[cfg(feature = "dialect.vector")]
    crate::VectorCanon::canonicalization(&mut set);
    set
}

// Folding, as `Operation::fold` and `Dialect::materializeConstant`.
//
// An op folds through its own hook (per dialect, in `patterns/<dialect>/canonicalize.rs`) and, when that fails or
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

    /// `tensor::preservesStaticInformation(source, target)`: both ranked tensors alike but in
    /// shape, and no static dim of `source` dynamic in `target`.
    pub fn preserves_static(source: &Type<'_>, target: &Type<'_>) -> bool {
        use mlirformat::{Dim, ShapedKind};
        let (Type::Shaped(s), Type::Shaped(t)) = (source, target) else { return false };
        let (Some(ss), Some(ts)) = (&s.shape, &t.shape) else { return false };
        s.kind == ShapedKind::Tensor && t.kind == s.kind && s.elem == t.elem && s.extras == t.extras && ss.len() == ts.len() && !ss.iter().zip(ts).any(|(a, b)| matches!(a, Dim::Static(_)) && !matches!(b, Dim::Static(_)))
    }

    /// `complex::ConstantOp::isBuildableWith`: a `[re, im]` of `ty`'s part type, as a
    /// `complex.constant`.
    pub fn complex_constant(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        let (Attribute::Array(parts), Type::Complex(part)) = (value, ty) else { return None };
        let typed = |a: &Attribute<'a>| matches!(a, Attribute::Int { ty: Some(t), .. } | Attribute::Float { ty: Some(t), .. } if t == &**part);
        (parts.len() == 2 && parts.iter().all(typed)).then(|| OpData::build("complex.constant").with("value", value.clone()))
    }

    /// The constant behind `v`, if its defining op is one.
    pub fn constant_of(&self, v: ValueId) -> Option<Attribute<'a>> {
        self.def_op(v).and_then(|o| self.constant_value(o))
    }

    /// The integer constant behind `v` (a scalar, not a splat).
    pub fn int_constant(&self, v: ValueId) -> Option<i128> {
        crate::Const::try_from(&self.constant_of(v)?).ok().filter(|c| !c.elements)?.as_int().map(|i| i.signed())
    }

    /// `m_IntRange…` (`constant_int_range_predicate_matcher`): the range of `v` from its
    /// constant (or splat), or from the bounds `test.with_bounds` states; `None` when unknown
    /// (other `InferIntRangeInterface` ops are not inferred, which only loses precision).
    pub fn int_range(&self, v: ValueId) -> Option<IntRange> {
        let int = |a: &Attribute<'_>| crate::Const::try_from(a).ok().and_then(|c| c.as_int());
        if let Some(c) = self.constant_of(v).as_ref().and_then(int) {
            return Some(IntRange { umin: c.unsigned(), umax: c.unsigned(), smin: c.signed(), smax: c.signed() });
        }
        let op = self.def_named(v, "test.with_bounds")?;
        let bound = |n: &str| self[op].get(n).and_then(int);
        Some(IntRange { umin: bound("umin")?.unsigned(), umax: bound("umax")?.unsigned(), smin: bound("smin")?.signed(), smax: bound("smax")?.signed() })
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
        let own = fold(self, op, &consts);
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
        if moved[..] == operands[..] {
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
        materialize(of.split_once('.').map_or(of, |(ns, _)| ns), value, ty).or_else(|| self.ctx.interfaces.of(of).and_then(|i| i.materialize(value, ty)))
    }
}

/// `ConstantIntRanges`: the unsigned and the signed bounds of an integer.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct IntRange {
    pub umin: u128,
    pub umax: u128,
    pub smin: i128,
    pub smax: i128,
}

impl IntRange {
    /// `m_IntRangeWithoutZeroU`.
    pub fn without_zero_u(self) -> bool {
        self.umin > 0
    }

    /// `m_IntRangeWithoutZeroS`.
    pub fn without_zero_s(self) -> bool {
        self.smin > 0 || self.smax < 0
    }

    /// `m_IntRangeWithoutNegOneS`.
    pub fn without_neg_one_s(self) -> bool {
        self.smin > -1 || self.smax < -1
    }

    /// `getDivUISpeculatability`'s divisor: never zero.
    pub fn unsigned_divisor(self) -> bool {
        self.without_zero_u()
    }

    /// `getDivSISpeculatability`'s divisor: never zero nor minus one.
    pub fn signed_divisor(self) -> bool {
        self.without_zero_s() && self.without_neg_one_s()
    }
}
