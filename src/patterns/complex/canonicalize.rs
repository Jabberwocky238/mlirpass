//! `complex` canonicalization (`ComplexOps.cpp`): its folds, the bitcast and negated-component
//! patterns, and constant materialization.

use alloc::vec;

use mlirformat::{ApFloat, Attribute, Type};

use crate::{Body, Fmf, Fold, Folded, OpData, OpId, ValueId};

/// The `complex` ops that fold.
#[derive(Clone, Copy)]
enum Op {
    Constant,
    Bitcast,
    Create,
    Re,
    Im,
    Add,
    Sub,
    Neg,
    Log,
    Exp,
    Conj,
    Mul,
    Div,
}

impl Op {
    const TABLE: [(&str, Op); 13] = [
        ("complex.constant", Op::Constant),
        ("complex.bitcast", Op::Bitcast),
        ("complex.create", Op::Create),
        ("complex.re", Op::Re),
        ("complex.im", Op::Im),
        ("complex.add", Op::Add),
        ("complex.sub", Op::Sub),
        ("complex.neg", Op::Neg),
        ("complex.log", Op::Log),
        ("complex.exp", Op::Exp),
        ("complex.conj", Op::Conj),
        ("complex.mul", Op::Mul),
        ("complex.div", Op::Div),
    ];

    fn of(name: &str) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == name).map(|(_, k)| *k)
    }
}

/// `complex`'s folds, patterns and constant materialization.
pub struct ComplexCanon;

/// One part of a complex float constant: the value, or, in a format [`ApFloat`] does not
/// hold (`f80`, `f128`), the decimal literal.
#[derive(Clone, Copy)]
enum Part<'s> {
    Value(ApFloat),
    Literal(&'s str),
}

impl Part<'_> {
    /// The literal's significant digits and the power of ten of the last one (`None`: hex).
    fn decimal(lit: &str) -> Option<(alloc::string::String, i64)> {
        let lit = lit.trim_start_matches(['-', '+']);
        if lit.starts_with("0x") {
            return None;
        }
        let (mant, exp) = lit.split_once(['e', 'E']).unwrap_or((lit, "0"));
        let exp: i64 = exp.parse().ok()?;
        let (int, frac) = mant.split_once('.').unwrap_or((mant, ""));
        let digits: alloc::string::String = int.chars().chain(frac.chars()).collect();
        digits.chars().all(|c| c.is_ascii_digit()).then_some(())?;
        Some((digits, exp - frac.len() as i64))
    }

    fn is_zero(self) -> bool {
        match self {
            Part::Value(f) => f.is_zero(),
            Part::Literal(l) => Self::decimal(l).is_some_and(|(d, _)| d.chars().all(|c| c == '0')),
        }
    }

    /// Exactly `1`.
    fn is_one(self) -> bool {
        match self {
            Part::Value(f) => f.to_f64() == 1.0,
            Part::Literal(l) => {
                if l.starts_with('-') {
                    return false;
                }
                let Some((d, exp)) = Self::decimal(l) else { return false };
                let d = d.trim_start_matches('0');
                let trailing = d.len() - d.trim_end_matches('0').len();
                d.trim_end_matches('0') == "1" && exp + trailing as i64 == 0
            }
        }
    }

    fn is_nan(self) -> bool {
        match self {
            Part::Value(f) => f.is_nan(),
            Part::Literal(l) => l.contains("nan"),
        }
    }
}

impl ComplexCanon {
    /// A complex float constant `[re, im]`'s parts (untyped literals are `f64`).
    fn parts<'s>(a: Option<&'s Attribute<'_>>) -> Option<[Part<'s>; 2]> {
        let Some(Attribute::Array(xs)) = a else { return None };
        let [re, im] = &xs[..] else { return None };
        let part = |x: &'s Attribute<'_>| -> Option<Part<'s>> {
            // A float printed as its bits reads back as an integer literal of the float type.
            let (Attribute::Float { lit, ty } | Attribute::Int { lit, ty: ty @ Some(Type::Float(_)) }) = x else { return None };
            let kind = match ty {
                None => mlirformat::FloatKind::F64,
                Some(Type::Float(k)) => *k,
                Some(_) => return None,
            };
            Some(if ApFloat::supported(kind) { Part::Value(ApFloat::parse(kind, lit)?) } else { Part::Literal(lit) })
        };
        Some([part(re)?, part(im)?])
    }

    /// The parts of the `complex.constant` defining `v`.
    fn constant_parts<'s>(b: &'s Body<'_>, v: ValueId) -> Option<[Part<'s>; 2]> {
        Self::parts(b.def_named(v, "complex.constant").and_then(|c| b[c].get("value")))
    }

    pub fn fold<'a>(b: &mut Body<'a>, op: OpId, c: &[Option<Attribute<'a>>]) -> Fold<'a> {
        let Some(k) = Op::of(&b[op].name) else { return Fold::Failed };
        let d = &b[op];
        let value = |v: ValueId| Folded::Value(v).into();
        let def = |i: usize, name: &str| b.def_named(d.operands[i], name);
        match k {
            Op::Constant => d.get("value").cloned().map_or(Fold::Failed, |a| Folded::Attr(a).into()),
            Op::Bitcast if b[d.operands[0]].ty == b[d.results[0]].ty => value(d.operands[0]),
            Op::Create => match (def(0, "complex.re"), def(1, "complex.im")) {
                (Some(re), Some(im)) if b[re].operands[0] == b[im].operands[0] => value(b[re].operands[0]),
                _ => Fold::Failed,
            },
            Op::Re | Op::Im => {
                let i = usize::from(matches!(k, Op::Im));
                if let Some(Attribute::Array(xs)) = &c[0]
                    && xs.len() == 2
                {
                    return Folded::Attr(xs[i].clone()).into();
                }
                def(0, "complex.create").map_or(Fold::Failed, |cr| value(b[cr].operands[i]))
            }
            Op::Add => {
                let (l, r) = (d.operands[0], d.operands[1]);
                if let Some(s) = b.def_named(l, "complex.sub")
                    && r == b[s].operands[1]
                {
                    return value(b[s].operands[0]);
                }
                if let Some(s) = b.def_named(r, "complex.sub")
                    && l == b[s].operands[1]
                {
                    return value(b[s].operands[0]);
                }
                if Self::constant_parts(b, r).is_some_and(|p| p.iter().all(|f| f.is_zero())) {
                    return value(l);
                }
                Fold::Failed
            }
            Op::Sub => {
                let (l, r) = (d.operands[0], d.operands[1]);
                if let Some(a) = b.def_named(l, "complex.add")
                    && r == b[a].operands[1]
                {
                    return value(b[a].operands[0]);
                }
                if Self::constant_parts(b, r).is_some_and(|p| p.iter().all(|f| f.is_zero())) {
                    return value(l);
                }
                Fold::Failed
            }
            // An op undoing the one before it.
            Op::Neg | Op::Log | Op::Exp | Op::Conj => {
                let undoes = match k {
                    Op::Log => "complex.exp",
                    Op::Exp => "complex.log",
                    _ => &d.name,
                };
                def(0, undoes).map_or(Fold::Failed, |p| value(b[p].operands[0]))
            }
            Op::Mul => match Self::constant_parts(b, d.operands[1]) {
                Some([re, im]) if im.is_zero() && re.is_one() => value(d.operands[0]),
                _ => Fold::Failed,
            },
            Op::Div => {
                let lhs = Self::parts(c[0].as_ref());
                if let (Some([re, im]), Some(Attribute::Array(xs))) = (lhs, &c[0])
                    && (re.is_nan() || im.is_nan())
                {
                    let nan = xs[usize::from(!re.is_nan())].clone();
                    return Folded::Attr(Attribute::Array(vec![nan.clone(), nan])).into();
                }
                let Some([re, im]) = Self::parts(c[1].as_ref()) else { return Fold::Failed };
                if !im.is_zero() || !re.is_one() {
                    return Fold::Failed;
                }
                if lhs.is_some() || Fmf::from(d.get("fastmath")).nnan() {
                    return value(d.operands[0]);
                }
                Fold::Failed
            }
            Op::Bitcast => Fold::Failed,
        }
    }

    /// `ComplexDialect::materializeConstant`.
    pub fn materialize<'a>(value: &Attribute<'a>, ty: &Type<'a>) -> Option<OpData<'a>> {
        Body::complex_constant(value, ty).or_else(|| crate::ArithCanon::materialize(value, ty))
    }
}

#[crate::patterns]
impl ComplexCanon {
    /// `MergeComplexBitcast`: a bitcast of a bitcast is one, `arith`'s when neither end is
    /// complex.
    #[rewrite("complex.bitcast")]
    fn merge_complex_bitcast(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let ty = b[b[op].results[0]].ty.clone();
        let src = b[op].operands[0];
        let (name, from) = if let Some(d) = b.def_named(src, "complex.bitcast") {
            let from = b[d].operands[0];
            let complex = matches!(ty, Type::Complex(_)) || matches!(b[from].ty, Type::Complex(_));
            (if complex { "complex.bitcast" } else { "arith.bitcast" }, from)
        } else if let Some(d) = b.def_named(src, "arith.bitcast") {
            ("complex.bitcast", b[d].operands[0])
        } else {
            return false;
        };
        rw.replace_with(op, OpData::build(name).operands(&[from]), &[ty]);
        true
    }

    /// `MergeArithBitcast`: an `arith.bitcast` of a `complex.bitcast` is one.
    #[rewrite("arith.bitcast")]
    fn merge_arith_bitcast(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        let b = &*rw.body;
        let Some(d) = b.def_named(b[op].operands[0], "complex.bitcast") else { return false };
        let (from, ty) = (b[d].operands[0], b[b[op].results[0]].ty.clone());
        rw.replace_with(op, OpData::build("complex.bitcast").operands(&[from]), &[ty]);
        true
    }

    /// `FoldComponentNeg<ReOp, 0>` / `<ImOp, 1>`: a part of the negation of a `complex.create`
    /// is that part negated.
    #[rewrite("complex.re", name = "FoldComponentNegRe")]
    fn fold_component_neg_re(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        Self::component_neg(rw, op, 0)
    }

    #[rewrite("complex.im", name = "FoldComponentNegIm")]
    fn fold_component_neg_im(rw: &mut crate::Rewriter<'_, '_>, op: OpId) -> bool {
        Self::component_neg(rw, op, 1)
    }
}

impl ComplexCanon {
    fn component_neg(rw: &mut crate::Rewriter<'_, '_>, op: OpId, part: usize) -> bool {
        let b = &*rw.body;
        let Some(neg) = b.def_named(b[op].operands[0], "complex.neg") else { return false };
        let Some(create) = b.def_named(b[neg].operands[0], "complex.create") else { return false };
        let (v, ty) = (b[create].operands[part], b[b[op].results[0]].ty.clone());
        rw.replace_with(op, OpData::build("arith.negf").operands(&[v]).with("fastmath", Fmf::NONE.attr()), &[ty]);
        true
    }

    pub fn canonicalization(set: &mut crate::PatternSet) {
        set.add(MergeComplexBitcast).add(MergeArithBitcast).add(FoldComponentNegIm).add(FoldComponentNegRe);
    }
}
