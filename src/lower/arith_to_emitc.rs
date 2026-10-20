//! `arith` ⇒ `emitc`, as `ArithToEmitC.cpp`.

use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, ShapedKind, Type};

use super::emitc::Emitc;
use crate::canon::AttrExt;
use crate::{ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The arith ⇒ emitc patterns, in `populateArithToEmitCPatterns` order: each row is one op
/// family's template (`ArithOpConversion`, `IntegerOpConversion`, ..) and its target.
pub struct ArithToEmitc;

#[patterns(converter)]
#[map("arith.constant" => "emitc.constant", via = Self::constant)]
#[map("arith.addf" => "emitc.add", via = Self::plain)]
#[map("arith.divf" => "emitc.div", via = Self::plain)]
#[map("arith.divsi" => "emitc.div", via = Self::plain)]
#[map("arith.mulf" => "emitc.mul", via = Self::plain)]
#[map("arith.remsi" => "emitc.rem", via = Self::plain)]
#[map("arith.subf" => "emitc.sub", via = Self::plain)]
#[map("arith.divui" => "emitc.div", via = Self::unsigned_binary)]
#[map("arith.remui" => "emitc.rem", via = Self::unsigned_binary)]
#[map("arith.addi" => "emitc.add", via = Self::integer)]
#[map("arith.muli" => "emitc.mul", via = Self::integer)]
#[map("arith.subi" => "emitc.sub", via = Self::integer)]
#[map("arith.andi" => "emitc.bitwise_and", via = Self::bitwise)]
#[map("arith.ori" => "emitc.bitwise_or", via = Self::bitwise)]
#[map("arith.xori" => "emitc.bitwise_xor", via = Self::bitwise)]
#[map("arith.shli" => "emitc.bitwise_left_shift", via = Self::shift(true))]
#[map("arith.shrsi" => "emitc.bitwise_right_shift", via = Self::shift(false))]
#[map("arith.shrui" => "emitc.bitwise_right_shift", via = Self::shift(true))]
#[map("arith.cmpf" => "emitc.cmp", via = Self::cmpf)]
#[map("arith.cmpi" => "emitc.cmp", via = Self::cmpi)]
#[map("arith.negf" => "emitc.unary_minus", via = Self::negf)]
#[map("arith.select" => "emitc.conditional", via = Self::select)]
#[map("arith.trunci" => "emitc.cast", via = Self::cast(true))]
#[map("arith.extsi" => "emitc.cast", via = Self::cast(false))]
#[map("arith.extui" => "emitc.cast", via = Self::cast(true))]
#[map("arith.index_cast" => "emitc.cast", via = Self::cast(false))]
#[map("arith.index_castui" => "emitc.cast", via = Self::cast(true))]
#[map("arith.sitofp" => "emitc.cast", via = Self::itof)]
#[map("arith.uitofp" => "emitc.cast", via = Self::itof)]
#[map("arith.fptosi" => "emitc.cast", via = Self::ftoi)]
#[map("arith.fptoui" => "emitc.cast", via = Self::ftoi)]
#[map("arith.extf" => "emitc.cast", via = Self::fp_cast)]
#[map("arith.truncf" => "emitc.cast", via = Self::fp_cast)]
impl ArithToEmitc {
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], to: &str) -> bool {
        let (Some(ty), Some(v)) = (cr.converted_result(op), cr.rw.body[op].get("value").cloned()) else { return false };
        cr.replace_new(op, OpData::build(to).with("value", v), &[ty]);
        true
    }

    /// `ArithOpConversion`.
    fn plain(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op) else { return false };
        cr.replace_new(op, OpData::build(to).operands(&ops), &[ty]);
        true
    }

    /// `BinaryUIOpConversion`.
    fn unsigned_binary(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op).filter(|t| matches!(t, Type::Integer { .. })) else { return false };
        let u = Emitc::signedness(&ty, true);
        let (l, r) = (cr.emitc_cast(ops[0], u.clone()), cr.emitc_cast(ops[1], u.clone()));
        let v = cr.emitc(to, &[l, r], u);
        let res = cr.emitc_cast(v, ty);
        cr.replace_values(op, &[res]);
        true
    }

    /// `IntegerOpConversion`.
    fn integer(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op).filter(Emitc::integral) else { return false };
        if Emitc::i1(&ty) {
            return false;
        }
        let nsw = matches!(cr.rw.body[op].get("overflowFlags"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|b| b.contains("nsw")));
        let wraps = matches!(&ty, Type::Integer { signedness, .. } if *signedness != mlirformat::Signedness::Unsigned) && !nsw;
        let arith = if wraps { Emitc::unsigned(Emitc::width(&ty)) } else { ty.clone() };
        Self::through(cr, op, &ops, to, arith, ty);
        true
    }

    /// `BitwiseOpConversion`.
    fn bitwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op).filter(|t| matches!(t, Type::Integer { .. })) else { return false };
        if Emitc::i1(&ty) {
            cr.replace_new(op, OpData::build(to).operands(&ops), &[ty]);
            return true;
        }
        let arith = Emitc::signedness(&ty, true);
        Self::through(cr, op, &ops, to, arith, ty);
        true
    }

    /// `CmpIOpConversion`.
    fn cmpi(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.ty(ops[0]);
        if !Emitc::integral(&ty) {
            return false;
        }
        let pred = Self::predicate(cr, op);
        let arith = Emitc::signedness(&ty, pred >= 6);
        let (l, r) = (cr.emitc_cast(ops[0], arith.clone()), cr.emitc_cast(ops[1], arith));
        let p = if pred >= 6 { pred - 4 } else { pred };
        let rt = cr.ty(cr.rw.body[op].results[0]);
        cr.replace_new(op, OpData::build(to).operands(&[l, r]).with("predicate", Attribute::i64(p)), &[rt]);
        true
    }

    /// `NegFOpConversion`.
    fn negf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = cr.ty(ops[0]);
        if matches!(&ty, Type::Shaped(s) if s.kind != ShapedKind::MemRef) || !Emitc::supported_float(&ty) {
            return false;
        }
        cr.replace_new(op, OpData::build(to).operands(&ops), &[ty]);
        true
    }

    /// `SelectOpConversion`.
    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op) else { return false };
        if cr.ty(ops[0]) != Type::int(1) {
            return false;
        }
        cr.replace_new(op, OpData::build(to).operands(&ops), &[ty]);
        true
    }

    /// `ItoFCastOpConversion`.
    fn itof(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ot = cr.ty(ops[0]);
        let Some(dst) = cr.converted_result(op).filter(|t| Emitc::supported_int(&ot) && Emitc::supported_float(t)) else { return false };
        let mut v = ops[0];
        if cr.rw.body[op].name == "arith.uitofp" {
            let u = Emitc::unsigned(Emitc::width(&ot));
            if u != ot {
                v = cr.emitc(to, &[v], u);
            }
        }
        cr.replace_new(op, OpData::build(to).operands(&[v]), &[dst]);
        true
    }

    /// `FtoICastOpConversion`.
    fn ftoi(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Emitc::supported_float(&cr.ty(ops[0])) {
            return false;
        }
        let Some(dst) = cr.converted_result(op).filter(|t| Emitc::supported_int(t) && !Emitc::i1(t)) else { return false };
        let unsigned = cr.rw.body[op].name == "arith.fptoui";
        let actual = if unsigned { Emitc::unsigned(Emitc::width(&dst)) } else { dst.clone() };
        let mut v = cr.emitc(to, &ops, actual);
        if unsigned {
            v = cr.emitc(to, &[v], dst);
        }
        cr.replace_values(op, &[v]);
        true
    }

    /// `FpCastOpConversion`.
    fn fp_cast(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if !Emitc::supported_float(&cr.ty(ops[0])) || cr.rw.body[op].get("roundingmode").is_some() {
            return false;
        }
        let Some(dst) = cr.converted_result(op).filter(Emitc::supported_float) else { return false };
        cr.replace_new(op, OpData::build(to).operands(&ops), &[dst]);
        true
    }

    /// The op's integer `predicate`.
    fn predicate(cr: &Cr<'_, '_, '_>, op: OpId) -> i64 {
        match cr.rw.body[op].get("predicate") {
            Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
            _ => 0,
        }
    }

    /// The op computed in `arith`, its operands and result cast as needed.
    fn through<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, ops: &[ValueId], to: &str, arith: Type<'a>, ty: Type<'a>) {
        let (l, r) = (cr.emitc_cast(ops[0], arith.clone()), cr.emitc_cast(ops[1], arith.clone()));
        let v = cr.emitc(to, &[l, r], arith);
        let res = cr.emitc_cast(v, ty);
        cr.replace_values(op, &[res]);
    }

    /// `ShiftOpConversion`: the shift, or zero when the amount is the width or more.
    fn shift<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str, unsigned: bool) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = cr.converted_result(op).filter(Emitc::integral) else { return false };
        if Emitc::i1(&ty) {
            return false;
        }
        let arith = Emitc::signedness(&ty, unsigned);
        let lhs = cr.emitc_cast(ops[0], arith.clone());
        let rt = Emitc::signedness(&cr.ty(ops[1]), true);
        let rhs = cr.emitc_cast(ops[1], rt.clone());
        let width = if Emitc::pointer_wide(&ty) {
            let eight = cr.emitc_constant(Emitc::int(8, Type::Index), rt.clone());
            let size = cr.build(OpData::build("emitc.call_opaque").operands(&[eight]).with("callee", Attribute::string("sizeof")), rt.clone());
            cr.emitc("emitc.mul", &[eight, size], rt)
        } else {
            cr.emitc_constant(Emitc::int(i64::from(Emitc::width(&ty)), rt.clone()), rt)
        };
        let excess = cr.emitc_cmp(2, rhs, width);
        let zero = Emitc::int(0, if matches!(arith, Type::Integer { .. }) { arith.clone() } else { Type::Index });
        let poison = cr.emitc_constant(zero, arith.clone());
        let inputs = [lhs, rhs, excess, poison];
        let args: Vec<_> = inputs.iter().map(|v| (cr.ty(*v), None)).collect();
        let expr = cr.rw.create_with(OpData::build("emitc.expression").operands(&inputs), core::slice::from_ref(&arith), |b, e| {
            let r = b.add_region(e);
            b.add_block(r, &args);
        });
        let block = cr.rw.body.top_block(expr);
        let a = cr.rw.body[block].args.clone();
        let saved = cr.rw.ip;
        cr.rw.set_end(block);
        let shifted = cr.emitc(to, &a[..2], arith.clone());
        let chosen = cr.emitc("emitc.conditional", &[a[2], shifted, a[3]], arith);
        cr.rw.create(OpData::build("emitc.yield").operands(&[chosen]), &[]);
        cr.rw.ip = saved;
        let v = cr.rw.body[expr].results[0];
        let res = cr.emitc_cast(v, ty);
        cr.replace_values(op, &[res]);
        true
    }

    /// `CmpFOpConversion`, NaN checks spelled out.
    fn cmpf(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (l, r) = (ops[0], ops[1]);
        if !matches!(cr.ty(r), Type::Float(_)) {
            return false;
        }
        let pred = Self::predicate(cr, op);
        let rt = cr.ty(cr.rw.body[op].results[0]);
        // eq, gt, ge, lt, le, ne by `CmpFPredicate` order.
        const PRED: [i64; 6] = [0, 4, 5, 2, 3, 1];
        let (unordered, p) = match pred {
            0 | 15 => {
                let c = cr.emitc_constant(Attribute::Bool(pred == 15), Type::int(1));
                cr.replace_values(op, &[c]);
                return true;
            }
            7 | 14 => {
                let c = Self::nan_check(cr, l, r, pred == 14);
                cr.replace_values(op, &[c]);
                return true;
            }
            1..=6 => (false, PRED[pred as usize - 1]),
            8..=13 => (true, PRED[pred as usize - 8]),
            _ => return false,
        };
        let cmp = cr.build(OpData::build(to).operands(&[l, r]).with("predicate", Attribute::i64(p)), rt.clone());
        let check = Self::nan_check(cr, l, r, unordered);
        let join = if unordered { "emitc.logical_or" } else { "emitc.logical_and" };
        cr.replace_new(op, OpData::build(join).operands(&[check, cmp]), &[rt]);
        true
    }

    /// `createCheckIsUnordered` (either is NaN) or `createCheckIsOrdered` (neither is).
    fn nan_check(cr: &mut Cr<'_, '_, '_>, l: ValueId, r: ValueId, unordered: bool) -> ValueId {
        let pred = i64::from(unordered);
        let (a, b) = (cr.emitc_cmp(pred, l, l), cr.emitc_cmp(pred, r, r));
        cr.emitc(if unordered { "emitc.logical_or" } else { "emitc.logical_and" }, &[a, b], Type::int(1))
    }

    /// `CastConversion`.
    fn cast(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], to: &str, unsigned: bool) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ret) = cr.converted_result(op).filter(Emitc::integral) else { return false };
        let [input] = ops[..] else { return false };
        let input = &input;
        let ot = cr.ty(*input);
        if !Emitc::integral(&ot) || (Emitc::i1(&ot) && !unsigned) {
            return false;
        }
        if Emitc::i1(&ret) {
            let attr_ty = if Emitc::pointer_wide(&ot) { Type::Index } else { ot.clone() };
            let one = cr.emitc_constant(Emitc::int(1, attr_ty), ot.clone());
            let and = cr.emitc("emitc.bitwise_and", &[*input, one], ot);
            cr.replace_new(op, OpData::build(to).operands(&[and]), &[ret]);
            return true;
        }
        let truncation = matches!((&ot, &ret), (Type::Integer { width: a, .. }, Type::Integer { width: b, .. }) if a > b);
        let u = unsigned || truncation;
        let (dst, src) = (Emitc::signedness(&ret, u), Emitc::signedness(&ot, u));
        let v = cr.emitc_cast(*input, src);
        let c = cr.emitc(to, &[v], dst);
        let res = cr.emitc_cast(c, ret);
        cr.replace_values(op, &[res]);
        true
    }
}
