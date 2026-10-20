//! `arith` ⇒ `llvm`, as `ArithToLLVM.cpp` (with the ceil / floor division expansions
//! `populateCeilFloorDivExpandOpsPatterns` adds first).

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::{ops, patterns};
use mlirformat::arith::CmpIPredicate;
use mlirformat::{arith, Attribute, NamedAttr, Type};

use super::llvm_fastmath;
use crate::{ApInt, Const, ConversionRewriter, OpData, OpId, Scalar, ValueId};
use mlirformat::llvm_types::LlvmType;

/// Builds the arith expansions of `ceildiv` / `floordiv` over values of type `ty`.
struct Ar<'c, 'r, 'a, 'p> {
    cr: &'c mut ConversionRewriter<'r, 'a, 'p>,
    ty: Type<'a>,
}

impl Ar<'_, '_, '_, '_> {
    /// An `arith.constant` of `v` (an `int`, or a splat) of the type.
    fn int(&mut self, v: i128) -> ValueId {
        let ty = self.ty.clone();
        let e = ty.element_type().clone();
        let w = e.int_width().map_or(64, |w| w.0);
        let value: Attribute = match &ty {
            Type::Shaped(_) => Const::splat(Scalar::Int(ApInt::new(w, v)), ty.clone()).into(),
            _ => Const::int(ApInt::new(w, v), e).into(),
        };
        self.cr.emit(&arith::Constant::new(value, ty))
    }

    fn cmp(&mut self, pred: i64, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.cr.rw.body[l].ty.clone().with_element(Type::I1);
        self.cr.build(OpData::build("arith.cmpi").operands(&[l, r]).with("predicate", Attribute::i64(pred)), ty)
    }

    fn arith(&mut self, name: &str, l: ValueId, r: ValueId) -> ValueId {
        let ty = self.cr.rw.body[l].ty.clone();
        self.cr.build(OpData::build(name).operands(&[l, r]), ty)
    }

    fn add(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.addi", l, r)
    }

    fn sub(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.subi", l, r)
    }

    fn mul(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.muli", l, r)
    }

    fn div(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.divsi", l, r)
    }

    fn divui(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.divui", l, r)
    }

    fn and(&mut self, l: ValueId, r: ValueId) -> ValueId {
        self.arith("arith.andi", l, r)
    }

    fn select(&mut self, c: ValueId, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.ty.clone();
        self.cr.build(OpData::build("arith.select").operands(&[c, a, b]), ty)
    }
}

/// The arith ⇒ llvm patterns, in `populateArithToLLVMConversionPatterns` order.
pub struct ArithToLlvm;

#[patterns(converter, builder = Self::ar)]
#[map("arith.truncf" => "llvm.fptrunc", fp, unconstrained)]
#[map("arith.addf" => "llvm.fadd", fastmath, fp)]
#[map("arith.addi" => "llvm.add", overflow)]
#[map("arith.andi" => "llvm.and")]
#[map("arith.bitcast" => "llvm.bitcast")]
#[map("arith.divf" => "llvm.fdiv", fastmath, fp)]
#[map("arith.divsi" => "llvm.sdiv")]
#[map("arith.divui" => "llvm.udiv")]
#[map("arith.extf" => "llvm.fpext", fp)]
#[map("arith.extsi" => "llvm.sext")]
#[map("arith.extui" => "llvm.zext")]
#[map("arith.fptosi" => "llvm.fptosi", fp)]
#[map("arith.fptoui" => "llvm.fptoui", fp)]
#[map("arith.maximumf" => "llvm.intr.maximum", fastmath, fp)]
#[map("arith.maxnumf" => "llvm.intr.maxnum", fastmath, fp)]
#[map("arith.maxsi" => "llvm.intr.smax")]
#[map("arith.maxui" => "llvm.intr.umax")]
#[map("arith.minimumf" => "llvm.intr.minimum", fastmath, fp)]
#[map("arith.minnumf" => "llvm.intr.minnum", fastmath, fp)]
#[map("arith.minsi" => "llvm.intr.smin")]
#[map("arith.minui" => "llvm.intr.umin")]
#[map("arith.mulf" => "llvm.fmul", fastmath, fp)]
#[map("arith.muli" => "llvm.mul", overflow)]
#[map("arith.negf" => "llvm.fneg", fastmath, fp)]
#[map("arith.ori" => "llvm.or")]
#[map("arith.remf" => "llvm.frem", fastmath, fp)]
#[map("arith.remsi" => "llvm.srem")]
#[map("arith.remui" => "llvm.urem")]
#[map("arith.select" => "llvm.select")]
#[map("arith.shli" => "llvm.shl", overflow)]
#[map("arith.shrsi" => "llvm.ashr")]
#[map("arith.shrui" => "llvm.lshr")]
#[map("arith.sitofp" => "llvm.sitofp")]
#[map("arith.subf" => "llvm.fsub", fastmath, fp)]
#[map("arith.subi" => "llvm.sub", overflow)]
#[map("arith.trunci" => "llvm.trunc", overflow)]
#[map("arith.uitofp" => "llvm.uitofp", fp)]
#[map("arith.xori" => "llvm.xor")]
impl ArithToLlvm {
    /// `IdentityBitcastLowering`: a bitcast between types that convert alike.
    #[lowering("arith.bitcast", benefit = 10)]
    fn identity_bitcast(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([src]) = ConversionRewriter::one_to_one(operands).as_deref().map(|s| <[ValueId; 1]>::try_from(s).ok()).flatten() else { return false };
        let res = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty));
        if res.as_ref() != Some(&cr.rw.body[src].ty) {
            return false;
        }
        cr.replace_values(op, &[src]);
        true
    }

    #[lowering("arith.constant")]
    fn constant(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(operands) = ConversionRewriter::one_to_one(operands) else { return false };
        let attrs = cr.all_attrs(op);
        cr.one_to_one_rewrite(op, "llvm.mlir.constant", &operands, &attrs)
    }

    /// `IndexCastOpLowering`: an extension, a truncation, or nothing.
    fn index_cast(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], ext: &str) -> bool {
        let Some([src]) = ConversionRewriter::one_to_one(operands).and_then(|s| <[ValueId; 1]>::try_from(s).ok()) else { return false };
        let Some(tc) = cr.type_converter() else { return false };
        let b = &*cr.rw.body;
        let res_ty = b[b[op].results[0]].ty.clone();
        let in_ty = b[b[op].operands[0]].ty.clone();
        let (Some(t), Some(s)) = (tc.convert(res_ty.element_type()), tc.convert(in_ty.element_type())) else { return false };
        let (tb, sb) = (t.bit_width(), s.bit_width());
        if tb == sb {
            cr.replace_values(op, &[src]);
            return true;
        }
        let name = if tb < sb { "llvm.trunc" } else { ext };
        if !matches!(LlvmType::try_from(&cr.rw.body[src].ty), Ok(LlvmType::Array(..))) {
            let Some(target) = tc.convert(&res_ty) else { return false };
            cr.replace_new(op, OpData::build(name).operands(&[src]), &[target]);
            return true;
        }
        if !matches!(res_ty, Type::Shaped(_)) {
            return false;
        }
        cr.unroll_vectors(op, &[src], |cr, ty, p| cr.build(OpData::build(name).operands(p), ty))
    }

    #[lowering("arith.index_cast")]
    fn index_cast_si(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::index_cast(cr, op, operands, "llvm.sext")
    }

    #[lowering("arith.index_castui")]
    fn index_cast_ui(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::index_cast(cr, op, operands, "llvm.zext")
    }

    #[lowering("arith.addui_extended")]
    fn addui_extended(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[0]].ty.clone();
        if !LlvmType::compatible(&ty) || matches!(LlvmType::try_from(&ty), Ok(LlvmType::Array(..))) {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let b = &*cr.rw.body;
        let (sum_ty, ovf_ty) = (b[b[op].results[0]].ty.clone(), b[b[op].results[1]].ty.clone());
        let Some(ovf) = tc.convert(&ovf_ty) else { return false };
        let st = LlvmType::literal(vec![sum_ty, ovf]);
        let r = cr.build(OpData::build("llvm.intr.uadd.with.overflow").operands(&ops), st);
        let (s, o) = (cr.extract(r, &[0]), cr.extract(r, &[1]));
        cr.replace_values(op, &[s, o]);
        true
    }

    fn mul_extended(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], signed: bool) -> bool {
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        let ty = cr.rw.body[ops[0]].ty.clone();
        if !LlvmType::compatible(&ty) || matches!(LlvmType::try_from(&ty), Ok(LlvmType::Array(..))) {
            return false;
        }
        let Some(w) = ty.bit_width() else { return false };
        let (wide, shift): (Type, Attribute) = match &ty {
            Type::Integer { .. } => (Type::int(2 * w), Const::int(ApInt::new(2 * w, w as i128), Type::int(2 * w)).into()),
            _ => {
                let wt = ty.with_element(Type::int(2 * w));
                (wt.clone(), Const::splat(Scalar::Int(ApInt::new(2 * w, w as i128)), wt).into())
            }
        };
        let ext = if signed { "llvm.sext" } else { "llvm.zext" };
        let l = cr.build(OpData::build(ext).operands(&[ops[0]]), wide.clone());
        let r = cr.build(OpData::build(ext).operands(&[ops[1]]), wide.clone());
        let m = cr.build(OpData::build("llvm.mul").operands(&[l, r]), wide.clone());
        let low = cr.build(OpData::build("llvm.trunc").operands(&[m]), ty.clone());
        let s = cr.llvm_constant(shift, wide.clone());
        let h = cr.build(OpData::build("llvm.lshr").operands(&[m, s]), wide);
        let high = cr.build(OpData::build("llvm.trunc").operands(&[h]), ty);
        cr.replace_values(op, &[low, high]);
        true
    }

    #[lowering("arith.mulsi_extended")]
    fn mulsi_extended(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::mul_extended(cr, op, operands, true)
    }

    #[lowering("arith.mului_extended")]
    fn mului_extended(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::mul_extended(cr, op, operands, false)
    }

    /// `CmpIOpLowering` / `CmpFOpLowering`: the predicates share their case values.
    fn cmp(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], float: bool) -> bool {
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        if float && cr.unsupported_float(&cr.rw.body[cr.rw.body[op].operands[0]].ty.clone()) {
            return false;
        }
        let Some(tc) = cr.type_converter() else { return false };
        let b = &*cr.rw.body;
        let res_ty = b[b[op].results[0]].ty.clone();
        let pred = b[op].get("predicate").cloned().unwrap_or(Attribute::i64(0));
        let fmf = float.then(|| llvm_fastmath(b[op].get("fastmath")));
        let name = if float { "llvm.fcmp" } else { "llvm.icmp" };
        let data = |operands: &[ValueId]| {
            let mut d = OpData::build(name).operands(operands).with("predicate", pred.clone());
            if let Some(f) = &fmf {
                d = d.with("fastmathFlags", f.clone());
            }
            d
        };
        if !matches!(LlvmType::try_from(&cr.rw.body[ops[0]].ty), Ok(LlvmType::Array(..))) {
            let Some(t) = tc.convert(&res_ty) else { return false };
            cr.replace_new(op, data(&ops), &[t]);
            return true;
        }
        if !matches!(res_ty, Type::Shaped(_)) {
            return false;
        }
        cr.unroll_vectors(op, &ops, |cr, ty, p| cr.build(data(p), ty))
    }

    #[lowering("arith.cmpi")]
    fn cmpi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::cmp(cr, op, operands, false)
    }

    #[lowering("arith.cmpf")]
    fn cmpf(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::cmp(cr, op, operands, true)
    }

    /// The expansion builder: arith ops of the op's operand type.
    fn ar<'c, 'r, 'a, 'p>(cr: &'c mut ConversionRewriter<'r, 'a, 'p>, op: OpId) -> Ar<'c, 'r, 'a, 'p> {
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        Ar { cr, ty }
    }

    /// `CeilDivUIOpConverter`.
    #[lowering("arith.ceildivui", untyped)]
    #[ops(b)]
    fn ceildivui(b: &mut Ar<'_, '_, '_, '_>, x: ValueId, y: ValueId) -> ValueId {
        let zero = b.int(0);
        let is_zero = b.cmp(CmpIPredicate::eq as i64, x, zero);
        let one = b.int(1);
        let q = b.divui(x - one, y);
        b.select(is_zero, zero, q + one)
    }

    /// `CeilDivSIOpConverter`.
    #[lowering("arith.ceildivsi", untyped)]
    #[ops(b)]
    fn ceildivsi(b: &mut Ar<'_, '_, '_, '_>, x: ValueId, y: ValueId) -> ValueId {
        let zero = b.int(0);
        let one = b.int(1);
        let q = x / y;
        let inexact = b.cmp(CmpIPredicate::ne as i64, x, q * y);
        let same_sign = b.cmp(CmpIPredicate::eq as i64, b.cmp(CmpIPredicate::slt as i64, x, zero), b.cmp(CmpIPredicate::slt as i64, y, zero));
        let cond = inexact & same_sign;
        b.select(cond, q + one, q)
    }

    /// `FloorDivSIOpConverter`.
    #[lowering("arith.floordivsi", untyped)]
    #[ops(b)]
    fn floordivsi(b: &mut Ar<'_, '_, '_, '_>, x: ValueId, y: ValueId) -> ValueId {
        let q = x / y;
        let inexact = b.cmp(CmpIPredicate::ne as i64, x, q * y);
        let zero = b.int(0);
        let opposite = b.cmp(CmpIPredicate::ne as i64, b.cmp(CmpIPredicate::slt as i64, x, zero), b.cmp(CmpIPredicate::slt as i64, y, zero));
        let cond = inexact & opposite;
        let minus_one = b.int(-1);
        b.select(cond, q + minus_one, q)
    }

    /// `ConstrainedTruncFOpLowering` (the `#[map]` row is `TruncFOpLowering`, without one).
    #[lowering("arith.truncf")]
    fn truncf(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(mode) = cr.rw.body[op].get("roundingmode").cloned() else { return false };
        if cr.unsupported_fp_op(op) {
            return false;
        }
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        // `AttrConverterConstrainedFPToLLVM`: arith's rounding mode as LLVM's, exceptions ignored.
        let llvm_mode = match mode {
            Attribute::Int { lit, .. } => match &*lit {
                "1" => 3,
                "2" => 2,
                "3" => 0,
                "4" => 4,
                _ => 1,
            },
            _ => 1,
        };
        let mut attrs: Vec<NamedAttr> = cr.all_attrs(op).into_iter().filter(|a| a.name != "roundingmode").collect();
        attrs.push(NamedAttr { name: "roundingmode".into(), value: Some(Attribute::i64(llvm_mode)) });
        attrs.push(NamedAttr { name: "fpExceptionBehavior".into(), value: Some(Attribute::i64(0)) });
        cr.vector_one_to_one(op, "llvm.intr.experimental.constrained.fptrunc", &ops, &attrs)
    }
}

