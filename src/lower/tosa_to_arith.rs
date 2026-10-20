//! `tosa` ⇒ `arith`, as `TosaToArith.cpp`: constants and `apply_scale`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirpass_macros::{ops, patterns};
use mlirformat::arith::CmpIPredicate;
use mlirformat::{arith, Attribute, Shaped, Type};

use super::FromOp;
use crate::canon::AttrExt;
use crate::{ApInt, Const, ConversionRewriter, OpData, OpId, Scalar, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `apply_scale` builders over a result (container) type.
struct Sc<'c, 'r, 'a, 'p> {
    cr: &'c mut Cr<'r, 'a, 'p>,
    /// The result type.
    rt: Type<'a>,
}

impl<'a> Sc<'_, '_, 'a, '_> {
    /// `matchContainerType`.
    fn container(elem: Type<'a>, like: &Type<'a>) -> Type<'a> {
        match like {
            Type::Shaped(s) => Type::Shaped(Shaped { elem: elem.into(), ..s.clone() }),
            _ => elem,
        }
    }

    /// `getConstantValue`.
    fn cst(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        let attr: Attribute<'a> = match ty {
            Type::Shaped(s) => {
                let w = crate::attr::int_width(&s.elem).map_or(64, |w| w.0);
                Const::splat(Scalar::Int(ApInt::new(w, i128::from(v))), ty.clone()).into()
            }
            _ => Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(ty.clone()) },
        };
        self.cr.emit(&arith::Constant::new(attr, ty.clone()))
    }

    fn op(&mut self, name: &str, ops: &[ValueId], ty: &Type<'a>) -> ValueId {
        self.cr.build(OpData::build(name).operands(ops), ty.clone())
    }

    fn same(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.cr.rw.body[a].ty.clone();
        self.op(name, &[a, b], &ty)
    }

    fn cmp(&mut self, pred: i64, a: ValueId, b: ValueId) -> ValueId {
        let ty = Self::container(Type::int(1), &self.cr.rw.body[a].ty.clone());
        self.cr.build(OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), ty)
    }

    fn select(&mut self, c: ValueId, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.cr.rw.body[a].ty.clone();
        self.op("arith.select", &[c, a, b], &ty)
    }

    fn ty(&self, v: ValueId) -> Type<'a> {
        self.cr.rw.body[v].ty.clone()
    }

    fn add(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.addi", a, b)
    }

    fn sub(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.subi", a, b)
    }

    fn mul(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.muli", a, b)
    }

    fn shl(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.shli", a, b)
    }

    /// `>>`: the arithmetic shift.
    fn shr(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.shrsi", a, b)
    }

    fn shrui(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.same("arith.shrui", a, b)
    }
}

/// The `apply_scale` rounding: `Some(true)` double, `Some(false)` single, else unsupported.
struct Rounding(Option<bool>);

impl FromOp for Rounding {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("rounding_mode") else { return Self(None) };
        Self(match ext.body.as_deref() {
            Some(b) if b.contains("DOUBLE_ROUND") => Some(true),
            Some(b) if b.contains("SINGLE_ROUND") => Some(false),
            _ => None,
        })
    }
}

/// `2^30`, for the double rounding.
const HALF_ROUND: i64 = 0x4000_0000;
const MINUS_HALF_ROUND: i64 = -0x4000_0000;

/// The tosa ⇒ arith patterns.
pub struct TosaToArith;

#[patterns(rescale: bool, use_32: bool, builder = Self::sc)]
impl TosaToArith {
    #[lowering("tosa.const")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(v) = cr.rw.body[op].get("values").cloned() else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        cr.replace_by(op, &arith::Constant::new(v, ty));
        true
    }

    /// The builder over the op's result type.
    fn sc<'c, 'r, 'a, 'p>(cr: &'c mut Cr<'r, 'a, 'p>, op: OpId) -> Sc<'c, 'r, 'a, 'p> {
        let rt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        Sc { cr, rt }
    }

    /// `ApplyScaleGenericOpConverter`.
    #[lowering("tosa.apply_scale", benefit = 100, when = rescale)]
    #[ops(s)]
    fn generic(s: &mut Sc<'_, '_, '_, '_>, value: ValueId, mult: ValueId, shift: ValueId, round: Rounding) -> Option<ValueId> {
        let double = round.0?;
        let (vt, rt) = (s.ty(value), s.rt.clone());
        let (i32t, i64t) = (Sc::container(Type::int(32), &rt), Sc::container(Type::int(64), &rt));
        let zero = s.cst(&vt, 0);
        let one64 = s.cst(&i64t, 1);
        let thirty_one = s.cst(&i32t, 31);
        let shift32 = s.op("arith.extui", &[shift], &i32t);
        let value64 = if crate::attr::element_type(&vt) != &Type::int(64) { s.op("arith.extsi", &[value], &i64t) } else { value };
        let m64 = s.op("arith.extsi", &[mult], &i64t);
        let mut mul = value64 * m64;
        let shift64 = s.op("arith.extui", &[shift32], &i64t);
        mul = mul + s.shrui(one64 << shift64, one64);
        if double {
            let up = s.cst(&i64t, HALF_ROUND);
            let down = s.cst(&i64t, MINUS_HALF_ROUND);
            let pos = s.cmp(CmpIPredicate::sge as i64, value, zero);
            let val = s.select(pos, up, down) + mul;
            let valid = s.cmp(CmpIPredicate::sgt as i64, shift32, thirty_one);
            mul = s.select(valid, val, mul);
        }
        Some(s.op("arith.trunci", &[mul >> shift64], &i32t))
    }

    /// `ApplyScale32BitOpConverter`.
    #[lowering("tosa.apply_scale", benefit = 200, when = rescale && use_32)]
    #[ops(s)]
    fn bits32(s: &mut Sc<'_, '_, '_, '_>, value: ValueId, mult: ValueId, shift: ValueId, round: Rounding) -> Option<ValueId> {
        let double = round.0?;
        if crate::attr::int_width(crate::attr::element_type(&s.ty(value))).is_some_and(|w| w.0 > 32) {
            return None;
        }
        let rt = s.rt.clone();
        let i32t = Sc::container(Type::int(32), &rt);
        let shift32 = s.op("arith.extui", &[shift], &i32t);
        let zero = s.cst(&i32t, 0);
        let one = s.cst(&i32t, 1);
        let two = s.cst(&i32t, 2);
        let thirty = s.cst(&i32t, 30);
        let thirty_two = s.cst(&i32t, 32);
        let vt = s.ty(value);
        let ext = s.cr.rw.create(OpData::build("arith.mulsi_extended").operands(&[value, mult]), &[vt.clone(), vt]);
        let (mut low, mut high) = (s.cr.rw.body[ext].results[0], s.cr.rw.body[ext].results[1]);
        let over = s.cmp(CmpIPredicate::sge as i64, shift32, thirty_two);
        let round_high = s.cmp(CmpIPredicate::sgt as i64, shift32, thirty_two);
        let shl = thirty_two - shift32;
        let shr = shift32 - thirty_two;
        let shl = s.select(over, zero, shl);
        let shr = s.select(over, shr, zero);
        if double {
            let neg_one = s.cst(&i32t, -1);
            let pos = s.cmp(CmpIPredicate::sge as i64, value, zero);
            let dir = s.select(pos, one, neg_one);
            let dir = s.select(over, dir, zero);
            let carry = (s.shrui(low, thirty) + dir) >> two;
            low = low + (dir << thirty);
            high = high + carry;
        }
        let bit = one << (shift32 - one);
        let bit = s.select(round_high, zero, bit);
        let new_low = low + bit;
        let wrapped = s.cmp(CmpIPredicate::ugt as i64, low, new_low);
        low = new_low;
        high = high + s.op("arith.extui", &[wrapped], &i32t);
        let bit = one << (shr - one);
        let bit = s.select(round_high, bit, zero);
        high = (high + bit) << shl >> shr;
        low = s.shrui(low, shift32);
        low = s.select(over, zero, low);
        let result = low + high;
        Some(if crate::attr::element_type(&rt) != &Type::int(32) { s.op("arith.trunci", &[result], &rt) } else { result })
    }

}
