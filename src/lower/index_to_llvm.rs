//! `index` ⇒ `llvm`, as `IndexToLLVM.cpp`; and `ub` ⇒ `llvm`, as `UBToLLVM.cpp`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Type};

use crate::canon::AttrExt;
use crate::{ConversionRewriter, OpData, OpId, ValueId};

/// The index ⇒ llvm patterns.
pub struct IndexToLlvm;

#[patterns(converter)]
#[map("index.add" => "llvm.add", scalar)]
#[map("index.sub" => "llvm.sub", scalar)]
#[map("index.mul" => "llvm.mul", scalar)]
#[map("index.divs" => "llvm.sdiv", scalar)]
#[map("index.divu" => "llvm.udiv", scalar)]
#[map("index.rems" => "llvm.srem", scalar)]
#[map("index.remu" => "llvm.urem", scalar)]
#[map("index.maxs" => "llvm.intr.smax", scalar)]
#[map("index.maxu" => "llvm.intr.umax", scalar)]
#[map("index.mins" => "llvm.intr.smin", scalar)]
#[map("index.minu" => "llvm.intr.umin", scalar)]
#[map("index.shl" => "llvm.shl", scalar)]
#[map("index.shrs" => "llvm.ashr", scalar)]
#[map("index.shru" => "llvm.lshr", scalar)]
#[map("index.and" => "llvm.and", scalar)]
#[map("index.or" => "llvm.or", scalar)]
#[map("index.xor" => "llvm.xor", scalar)]
#[map("index.bool.constant" => "llvm.mlir.constant", scalar)]
impl IndexToLlvm {
    /// `LLVM::ConstantOp::create(type, int)`.
    fn int<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, ty: &Type<'a>, v: i64) -> ValueId {
        cr.llvm_constant(Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(ty.clone()) }, ty.clone())
    }

    fn bin<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, name: &str, l: ValueId, r: ValueId) -> ValueId {
        let ty = cr.rw.body[l].ty.clone();
        cr.build(OpData::build(name).operands(&[l, r]), ty)
    }

    fn icmp<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, pred: i64, l: ValueId, r: ValueId) -> ValueId {
        cr.build(OpData::build("llvm.icmp").operands(&[l, r]).with("predicate", Attribute::i64(pred)), Type::I1)
    }

    fn select<'a>(cr: &mut ConversionRewriter<'_, 'a, '_>, c: ValueId, t: ValueId, f: ValueId) -> ValueId {
        let ty = cr.rw.body[t].ty.clone();
        cr.build(OpData::build("llvm.select").operands(&[c, t, f]), ty)
    }

    #[lowering("index.ceildivs")]
    fn ceildivs(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([n, m]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 2]>::try_from(v).ok()) else { return false };
        let ty = cr.rw.body[n].ty.clone();
        let zero = Self::int(cr, &ty, 0);
        let pos_one = Self::int(cr, &ty, 1);
        let neg_one = Self::int(cr, &ty, -1);
        let m_pos = Self::icmp(cr, 4, m, zero);
        let x = Self::select(cr, m_pos, neg_one, pos_one);
        let n_plus_x = Self::bin(cr, "llvm.add", n, x);
        let div = Self::bin(cr, "llvm.sdiv", n_plus_x, m);
        let pos_res = Self::bin(cr, "llvm.add", div, pos_one);
        let neg_n = Self::bin(cr, "llvm.sub", zero, n);
        let neg_div = Self::bin(cr, "llvm.sdiv", neg_n, m);
        let neg_res = Self::bin(cr, "llvm.sub", zero, neg_div);
        let n_pos = Self::icmp(cr, 4, n, zero);
        let same = Self::icmp(cr, 0, n_pos, m_pos);
        let nonzero = Self::icmp(cr, 1, n, zero);
        let cmp = Self::bin(cr, "llvm.and", same, nonzero);
        let r = Self::select(cr, cmp, pos_res, neg_res);
        cr.replace_values(op, &[r]);
        true
    }

    #[lowering("index.ceildivu")]
    fn ceildivu(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([n, m]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 2]>::try_from(v).ok()) else { return false };
        let ty = cr.rw.body[n].ty.clone();
        let zero = Self::int(cr, &ty, 0);
        let one = Self::int(cr, &ty, 1);
        let minus = Self::bin(cr, "llvm.sub", n, one);
        let q = Self::bin(cr, "llvm.udiv", minus, m);
        let plus = Self::bin(cr, "llvm.add", q, one);
        let cmp = Self::icmp(cr, 0, n, zero);
        let r = Self::select(cr, cmp, zero, plus);
        cr.replace_values(op, &[r]);
        true
    }

    #[lowering("index.floordivs")]
    fn floordivs(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([n, m]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 2]>::try_from(v).ok()) else { return false };
        let ty = cr.rw.body[n].ty.clone();
        let zero = Self::int(cr, &ty, 0);
        let pos_one = Self::int(cr, &ty, 1);
        let neg_one = Self::int(cr, &ty, -1);
        let m_neg = Self::icmp(cr, 2, m, zero);
        let x = Self::select(cr, m_neg, pos_one, neg_one);
        let x_minus_n = Self::bin(cr, "llvm.sub", x, n);
        let div = Self::bin(cr, "llvm.sdiv", x_minus_n, m);
        let neg_res = Self::bin(cr, "llvm.sub", neg_one, div);
        let pos_res = Self::bin(cr, "llvm.sdiv", n, m);
        let n_neg = Self::icmp(cr, 2, n, zero);
        let diff = Self::icmp(cr, 1, n_neg, m_neg);
        let nonzero = Self::icmp(cr, 1, n, zero);
        let cmp = Self::bin(cr, "llvm.and", diff, nonzero);
        let r = Self::select(cr, cmp, neg_res, pos_res);
        cr.replace_values(op, &[r]);
        true
    }

    fn cast(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], ext: &str) -> bool {
        let Some([input]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let Some(out) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        let in_ty = cr.rw.body[input].ty.clone();
        if in_ty == out {
            cr.replace_values(op, &[input]);
        } else {
            let name = if crate::attr::bit_width(&in_ty) > crate::attr::bit_width(&out) { "llvm.trunc" } else { ext };
            cr.replace_new(op, OpData::build(name).operands(&[input]), &[out]);
        }
        true
    }

    #[lowering("index.casts")]
    fn casts(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::cast(cr, op, operands, "llvm.sext")
    }

    #[lowering("index.castu")]
    fn castu(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::cast(cr, op, operands, "llvm.zext")
    }

    /// `index.cmp`: the predicates share their case values with `llvm.icmp`.
    #[lowering("index.cmp")]
    fn cmp(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([l, r]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 2]>::try_from(v).ok()) else { return false };
        // `IndexCmpPredicate` cases are printed as their names; their order is eq, ne, slt,
        // sle, sgt, sge, ult, ule, ugt, uge, as `ICmpPredicate`.
        let pred = match cr.rw.body[op].get("pred") {
            Some(Attribute::Extended { ext, .. }) => {
                // `#index<cmp_predicate eq>`.
                let body = ext.body.as_deref().unwrap_or("").trim_matches(|c| c == '<' || c == '>');
                let name = body.rsplit(' ').next().unwrap_or(body);
                ["eq", "ne", "slt", "sle", "sgt", "sge", "ult", "ule", "ugt", "uge"].iter().position(|p| *p == name).unwrap_or(0) as i64
            }
            _ => return false,
        };
        cr.replace_new(op, OpData::build("llvm.icmp").operands(&[l, r]).with("predicate", Attribute::i64(pred)), &[Type::I1]);
        true
    }

    #[lowering("index.sizeof")]
    fn sizeof(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&Type::Index) else { return false };
        let bits = crate::attr::bit_width(&ty).unwrap_or(64) as i64;
        cr.rw.set_before(op);
        let c = Self::int(cr, &ty, bits);
        cr.replace_values(op, &[c]);
        true
    }

    #[lowering("index.constant")]
    fn constant(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&Type::Index) else { return false };
        let w = crate::attr::bit_width(&ty).unwrap_or(64);
        let Some(v) = cr.rw.body[op].get("value").and_then(|a| crate::Const::try_from(a).ok()).and_then(|c| c.as_int()) else { return false };
        let value: Attribute = crate::Const::int(v.trunc(w), ty.clone()).into();
        cr.replace_new(op, OpData::build("llvm.mlir.constant").with("value", value), &[ty]);
        true
    }

}

/// The ub ⇒ llvm patterns.
pub struct UbToLlvm;

#[patterns(converter)]
impl UbToLlvm {
    #[lowering("ub.poison")]
    fn poison(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !cr.rw.body[op].get("value").is_some_and(crate::is_poison) {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        cr.replace_new(op, OpData::build("llvm.mlir.poison"), &[ty]);
        true
    }

    #[lowering("ub.unreachable")]
    fn unreachable(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        cr.replace_new(op, OpData::build("llvm.unreachable"), &[]);
        true
    }

}
