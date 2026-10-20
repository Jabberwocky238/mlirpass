//! `tosa` ⇒ `arith`, as `TosaToArith.cpp`: constants and `apply_scale`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Shaped, Type};

use crate::canon::AttrExt;
use crate::{ApInt, Const, ConversionRewriter, OpData, OpId, Scalar, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `apply_scale` builders over a result (container) type.
struct Sc<'c, 'r, 'a, 'p> {
    cr: &'c mut Cr<'r, 'a, 'p>,
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
        self.cr.build(OpData::build("arith.constant").with("value", attr), ty.clone())
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
}

/// The tosa ⇒ arith patterns.
pub struct TosaToArith;

#[patterns(rescale: bool, use_32: bool)]
impl TosaToArith {
    #[lowering("tosa.const")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(v) = cr.rw.body[op].get("values").cloned() else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        cr.replace_new(op, OpData::build("arith.constant").with("value", v), &[ty]);
        true
    }

    /// The `DOUBLE_ROUND` / `SINGLE_ROUND` rounding mode (`None` for others).
    fn double_round(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<bool> {
        let Some(Attribute::Extended { ext, .. }) = cr.rw.body[op].get("rounding_mode") else { return None };
        match ext.body.as_deref()? {
            b if b.contains("DOUBLE_ROUND") => Some(true),
            b if b.contains("SINGLE_ROUND") => Some(false),
            _ => None,
        }
    }

    /// `ApplyScaleGenericOpConverter`.
    #[lowering("tosa.apply_scale", benefit = 100, when = rescale)]
    fn generic(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(double) = Self::double_round(cr, op) else { return false };
        let b = &*cr.rw.body;
        let (value, mult, shift) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let rt = b[b[op].results[0]].ty.clone();
        let vt = b[value].ty.clone();
        let mut s = Sc { cr };
        let (i32t, i64t) = (Sc::container(Type::int(32), &rt), Sc::container(Type::int(64), &rt));
        let zero = s.cst(&vt, 0);
        let one64 = s.cst(&i64t, 1);
        let thirty_one = s.cst(&i32t, 31);
        let shift32 = s.op("arith.extui", &[shift], &i32t);
        let value64 = if crate::attr::element_type(&vt) != &Type::int(64) { s.op("arith.extsi", &[value], &i64t) } else { value };
        let m64 = s.op("arith.extsi", &[mult], &i64t);
        let mut mul = s.same("arith.muli", value64, m64);
        let shift64 = s.op("arith.extui", &[shift32], &i64t);
        let mut round = s.same("arith.shli", one64, shift64);
        round = s.same("arith.shrui", round, one64);
        mul = s.same("arith.addi", mul, round);
        if double {
            let up = s.cst(&i64t, 1 << 30);
            let down = s.cst(&i64t, -(1 << 30));
            let pos = s.cmp(5, value, zero);
            let dir = s.select(pos, up, down);
            let val = s.same("arith.addi", dir, mul);
            let valid = s.cmp(4, shift32, thirty_one);
            mul = s.select(valid, val, mul);
        }
        let r64 = s.same("arith.shrsi", mul, shift64);
        let r32 = s.op("arith.trunci", &[r64], &i32t);
        cr.replace_values(op, &[r32]);
        true
    }

    /// `ApplyScale32BitOpConverter`.
    #[lowering("tosa.apply_scale", benefit = 200, when = rescale && use_32)]
    fn bits32(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(double) = Self::double_round(cr, op) else { return false };
        let b = &*cr.rw.body;
        let (value, mult, shift) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        if crate::attr::int_width(crate::attr::element_type(&b[value].ty)).is_some_and(|w| w.0 > 32) {
            return false;
        }
        let rt = b[b[op].results[0]].ty.clone();
        let mut s = Sc { cr };
        let i32t = Sc::container(Type::int(32), &rt);
        let shift32 = s.op("arith.extui", &[shift], &i32t);
        let zero = s.cst(&i32t, 0);
        let one = s.cst(&i32t, 1);
        let two = s.cst(&i32t, 2);
        let thirty = s.cst(&i32t, 30);
        let thirty_two = s.cst(&i32t, 32);
        let vt = s.cr.rw.body[value].ty.clone();
        let ext = s.cr.rw.create(OpData::build("arith.mulsi_extended").operands(&[value, mult]), &[vt.clone(), vt]);
        let (mut low, mut high) = (s.cr.rw.body[ext].results[0], s.cr.rw.body[ext].results[1]);
        let over = s.cmp(5, shift32, thirty_two);
        let round_high = s.cmp(4, shift32, thirty_two);
        let mut shl = s.same("arith.subi", thirty_two, shift32);
        let mut shr = s.same("arith.subi", shift32, thirty_two);
        shl = s.select(over, zero, shl);
        shr = s.select(over, shr, zero);
        if double {
            let neg_one = s.cst(&i32t, -1);
            let pos = s.cmp(5, value, zero);
            let mut dir = s.select(pos, one, neg_one);
            dir = s.select(over, dir, zero);
            let shift_low = s.same("arith.shrui", low, thirty);
            let rounded = s.same("arith.addi", shift_low, dir);
            let carry = s.same("arith.shrsi", rounded, two);
            let shift_round = s.same("arith.shli", dir, thirty);
            low = s.same("arith.addi", low, shift_round);
            high = s.same("arith.addi", high, carry);
        }
        let sub = s.same("arith.subi", shift32, one);
        let mut bit = s.same("arith.shli", one, sub);
        bit = s.select(round_high, zero, bit);
        let new_low = s.same("arith.addi", low, bit);
        let was = s.cmp(8, low, new_low);
        low = new_low;
        let r32 = s.op("arith.extui", &[was], &i32t);
        high = s.same("arith.addi", high, r32);
        let sub = s.same("arith.subi", shr, one);
        let mut bit = s.same("arith.shli", one, sub);
        bit = s.select(round_high, bit, zero);
        high = s.same("arith.addi", high, bit);
        high = s.same("arith.shli", high, shl);
        high = s.same("arith.shrsi", high, shr);
        low = s.same("arith.shrui", low, shift32);
        low = s.select(over, zero, low);
        let mut result = s.same("arith.addi", low, high);
        if crate::attr::element_type(&rt) != &Type::int(32) {
            result = s.op("arith.trunci", &[result], &rt);
        }
        cr.replace_values(op, &[result]);
        true
    }

}
