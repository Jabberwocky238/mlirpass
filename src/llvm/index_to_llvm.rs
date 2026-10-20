//! `index` ⇒ `llvm`, as `IndexToLLVM.cpp`; and `ub` ⇒ `llvm`, as `UBToLLVM.cpp`.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirpass_macros::{ops, patterns};
use mlirformat::{Attribute, Type};

use crate::{ConversionRewriter, OpData, OpId, ValueId};

/// `LLVM::ICmpPredicate`s.
const EQ: i64 = 0;
const NE: i64 = 1;
const SLT: i64 = 2;
const SGT: i64 = 4;

/// Builds llvm integer arithmetic over values of type `ty`.
struct Ll<'c, 'r, 'a, 'p> {
    cr: &'c mut ConversionRewriter<'r, 'a, 'p>,
    ty: Type<'a>,
}

impl Ll<'_, '_, '_, '_> {
    /// `LLVM::ConstantOp::create(type, int)`.
    fn int(&mut self, v: i64) -> ValueId {
        let ty = self.ty.clone();
        self.cr.llvm_constant(Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(ty.clone()) }, ty)
    }

    fn bin(&mut self, name: &str, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.cr.rw.body[l].ty.clone();
        self.cr.build(OpData::build(name).operands(&[l, r]), ty)
    }

    fn add(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.bin("llvm.add", l, r)
    }

    fn sub(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.bin("llvm.sub", l, r)
    }

    fn div(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.bin("llvm.sdiv", l, r)
    }

    fn udiv(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.bin("llvm.udiv", l, r)
    }

    fn and(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.bin("llvm.and", l, r)
    }

    fn icmp(&mut self, pred: i64, l: ValueId, r: ValueId) -> ValueId {
        self.cr.build(OpData::build("llvm.icmp").operands(&[l, r]).with("predicate", Attribute::i64(pred)), Type::I1)
    }

    fn select(&mut self, c: ValueId, t: ValueId, f: ValueId) -> ValueId {
        let ty = self.cr.rw.body[t].ty.clone();
        self.cr.build(OpData::build("llvm.select").operands(&[c, t, f]), ty)
    }
}

/// The index ⇒ llvm patterns.
pub struct IndexToLlvm;

#[patterns(converter, builder = Self::ll)]
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
    /// The expansion builder over the converted operand type.
    fn ll<'c, 'r, 'a, 'p>(cr: &'c mut ConversionRewriter<'r, 'a, 'p>, op: OpId) -> Ll<'c, 'r, 'a, 'p> {
        let t = cr.rw.body[op].operands.first().map_or(Type::Index, |v| cr.rw.body[*v].ty.clone());
        let ty = cr.type_converter().and_then(|tc| tc.convert(&t)).unwrap_or(t);
        Ll { cr, ty }
    }

    /// `ConvertIndexCeilDivS`.
    #[lowering("index.ceildivs")]
    #[ops(b)]
    fn ceildivs(b: &mut Ll<'_, '_, '_, '_>, n: ValueId, m: ValueId) -> ValueId {
        let zero = b.int(0);
        let pos_one = b.int(1);
        let neg_one = b.int(-1);
        let m_pos = b.icmp(SGT, m, zero);
        let x = b.select(m_pos, neg_one, pos_one);
        let pos_res = (n + x) / m + pos_one;
        let neg_res = zero - (zero - n) / m;
        let same = b.icmp(EQ, b.icmp(SGT, n, zero), m_pos);
        let cmp = same & b.icmp(NE, n, zero);
        b.select(cmp, pos_res, neg_res)
    }

    /// `ConvertIndexCeilDivU`.
    #[lowering("index.ceildivu")]
    #[ops(b)]
    fn ceildivu(b: &mut Ll<'_, '_, '_, '_>, n: ValueId, m: ValueId) -> ValueId {
        let zero = b.int(0);
        let one = b.int(1);
        let plus = b.udiv(n - one, m) + one;
        let cmp = b.icmp(EQ, n, zero);
        b.select(cmp, zero, plus)
    }

    /// `ConvertIndexFloorDivS`.
    #[lowering("index.floordivs")]
    #[ops(b)]
    fn floordivs(b: &mut Ll<'_, '_, '_, '_>, n: ValueId, m: ValueId) -> ValueId {
        let zero = b.int(0);
        let pos_one = b.int(1);
        let neg_one = b.int(-1);
        let m_neg = b.icmp(SLT, m, zero);
        let x = b.select(m_neg, pos_one, neg_one);
        let neg_res = neg_one - (x - n) / m;
        let pos_res = n / m;
        let cmp = b.icmp(NE, b.icmp(SLT, n, zero), m_neg) & b.icmp(NE, n, zero);
        b.select(cmp, neg_res, pos_res)
    }

    fn cast(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], ext: &str) -> bool {
        let Some([input]) = ConversionRewriter::one_to_one(operands).and_then(|v| <[ValueId; 1]>::try_from(v).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let Some(out) = tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty.clone()) else { return false };
        let in_ty = cr.rw.body[input].ty.clone();
        if in_ty == out {
            cr.replace_values(op, &[input]);
        } else {
            let name = if in_ty.bit_width() > out.bit_width() { "llvm.trunc" } else { ext };
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
    fn sizeof(b: &mut Ll<'_, '_, '_, '_>) -> ValueId {
        let bits = b.ty.bit_width().unwrap_or(64) as i64;
        b.int(bits)
    }

    #[lowering("index.constant")]
    fn constant(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(ty) = tc.convert(&Type::Index) else { return false };
        let w = ty.bit_width().unwrap_or(64);
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
        if !cr.rw.body[op].get("value").is_some_and(Attribute::is_poison) {
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
