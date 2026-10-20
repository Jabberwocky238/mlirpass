//! `arith` ⇒ `llvm`, as `ArithToLLVM.cpp` (with the ceil / floor division expansions
//! `populateCeilFloorDivExpandOpsPatterns` adds first).

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, NamedAttr, Type};

use super::llvm_fastmath;
use crate::canon::AttrExt;
use crate::{ApInt, Const, ConversionRewriter, LlvmType, OpData, OpId, Scalar, ValueId, attr};

/// The arith ⇒ llvm patterns, in `populateArithToLLVMConversionPatterns` order.
pub struct ArithToLlvm;

#[patterns(converter)]
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
        let (Some(t), Some(s)) = (tc.convert(attr::element_type(&res_ty)), tc.convert(attr::element_type(&in_ty))) else { return false };
        let (tb, sb) = (attr::bit_width(&t), attr::bit_width(&s));
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
        let Some(w) = attr::bit_width(&ty) else { return false };
        let (wide, shift): (Type, Attribute) = match &ty {
            Type::Integer { .. } => (Type::int(2 * w), Const::int(ApInt::new(2 * w, w as i128), Type::int(2 * w)).into()),
            _ => {
                let wt = attr::with_element(&ty, Type::int(2 * w));
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

    /// An `arith.constant` of `v` (an `int`, or a splat) of type `ty`.
    fn arith_const(cr: &mut ConversionRewriter<'_, '_, '_>, ty: &Type<'_>, v: i128) -> ValueId {
        let e = attr::element_type(ty).clone().owned_type();
        let w = attr::int_width(&e).map_or(64, |w| w.0);
        let value: Attribute = match ty {
            Type::Shaped(_) => Const::splat(Scalar::Int(ApInt::new(w, v)), ty.clone().owned_type()).into(),
            _ => Const::int(ApInt::new(w, v), e).into(),
        };
        cr.build(OpData::build("arith.constant").with("value", value), ty.clone().owned_type())
    }

    fn cmpi_op(cr: &mut ConversionRewriter<'_, '_, '_>, pred: i64, l: ValueId, r: ValueId) -> ValueId {
        let ty = attr::with_element(&cr.rw.body[l].ty.clone(), Type::I1);
        cr.build(OpData::build("arith.cmpi").operands(&[l, r]).with("predicate", Attribute::i64(pred)), ty)
    }

    fn arith(cr: &mut ConversionRewriter<'_, '_, '_>, name: &str, ops: &[ValueId]) -> ValueId {
        let ty = cr.rw.body[ops[0]].ty.clone();
        cr.build(OpData::build(name).operands(ops), ty)
    }

    /// `CeilDivUIOpConverter`.
    #[lowering("arith.ceildivui", untyped)]
    fn ceildivui(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (a, b) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let ty = cr.rw.body[a].ty.clone();
        let zero = Self::arith_const(cr, &ty, 0);
        let cmp = Self::cmpi_op(cr, 0, a, zero);
        let one = Self::arith_const(cr, &ty, 1);
        let minus = Self::arith(cr, "arith.subi", &[a, one]);
        let q = Self::arith(cr, "arith.divui", &[minus, b]);
        let plus = Self::arith(cr, "arith.addi", &[q, one]);
        cr.replace_new(op, OpData::build("arith.select").operands(&[cmp, zero, plus]), &[ty]);
        true
    }

    /// `CeilDivSIOpConverter`.
    #[lowering("arith.ceildivsi", untyped)]
    fn ceildivsi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (a, b) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let zero = Self::arith_const(cr, &ty, 0);
        let one = Self::arith_const(cr, &ty, 1);
        let q = Self::arith(cr, "arith.divsi", &[a, b]);
        let p = Self::arith(cr, "arith.muli", &[q, b]);
        let ne = Self::cmpi_op(cr, 1, a, p);
        let an = Self::cmpi_op(cr, 2, a, zero);
        let bn = Self::cmpi_op(cr, 2, b, zero);
        let same = Self::cmpi_op(cr, 0, an, bn);
        let cond = Self::arith(cr, "arith.andi", &[ne, same]);
        let plus = Self::arith(cr, "arith.addi", &[q, one]);
        cr.replace_new(op, OpData::build("arith.select").operands(&[cond, plus, q]), &[ty]);
        true
    }

    /// `FloorDivSIOpConverter`.
    #[lowering("arith.floordivsi", untyped)]
    fn floordivsi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (a, b) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let q = Self::arith(cr, "arith.divsi", &[a, b]);
        let p = Self::arith(cr, "arith.muli", &[q, b]);
        let ne = Self::cmpi_op(cr, 1, a, p);
        let zero = Self::arith_const(cr, &ty, 0);
        let an = Self::cmpi_op(cr, 2, a, zero);
        let bn = Self::cmpi_op(cr, 2, b, zero);
        let opposite = Self::cmpi_op(cr, 1, an, bn);
        let cond = Self::arith(cr, "arith.andi", &[ne, opposite]);
        let minus = Self::arith_const(cr, &ty, -1);
        let qm = Self::arith(cr, "arith.addi", &[q, minus]);
        cr.replace_new(op, OpData::build("arith.select").operands(&[cond, qm, q]), &[ty]);
        true
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

/// `Type::owned`, as a method on types.
trait OwnedType {
    fn owned_type(self) -> Type<'static>;
}

impl OwnedType for Type<'_> {
    fn owned_type(self) -> Type<'static> {
        crate::Owned::owned(&self)
    }
}
