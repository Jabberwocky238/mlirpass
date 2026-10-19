//! `arith` ⇒ `llvm`, as `ArithToLLVM.cpp` (with the ceil / floor division expansions
//! `populateCeilFloorDivExpandOpsPatterns` adds first).

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, NamedAttr, Type};

use super::{Lowering, llvm_fastmath, llvm_overflow};
use crate::canon::AttrExt;
use crate::{ApInt, Const, ConversionPattern, ConversionPatterns, ConversionRewriter, LlvmType, OpData, OpId, Scalar, ValueId, attr};

/// How an op's attributes carry over (`AttrConvert*`).
#[derive(Clone, Copy, PartialEq, Eq)]
enum Attrs {
    PassThrough,
    FastMath,
    Overflow,
}

/// `VectorConvertToLLVMPattern<From, To, Attrs, FailOnUnsupportedFP>`.
struct OneToOne {
    from: &'static str,
    to: &'static str,
    attrs: Attrs,
    fail_on_unsupported_fp: bool,
    /// `ConstrainedVectorConvertToLLVMPattern`: only without a rounding mode.
    unconstrained: bool,
}

impl ConversionPattern for OneToOne {
    fn name(&self) -> &str {
        self.to
    }

    fn root(&self) -> Option<&str> {
        Some(self.from)
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        if self.unconstrained && cr.rw.body[op].get("roundingmode").is_some() {
            return false;
        }
        if self.fail_on_unsupported_fp {
            let b = &*cr.rw.body;
            let types: Vec<Type> = b[op].operands.iter().chain(&b[op].results).map(|v| b[*v].ty.clone()).collect();
            if types.iter().any(|t| cr.unsupported_float(t)) {
                return false;
            }
        }
        let Some(operands) = ConversionRewriter::one_to_one(operands) else { return false };
        let mut attrs = cr.all_attrs(op);
        match self.attrs {
            Attrs::PassThrough => {}
            Attrs::FastMath => {
                if let Some(i) = attrs.iter().position(|a| a.name == "fastmath") {
                    let a = attrs.remove(i);
                    attrs.push(NamedAttr { name: "fastmathFlags".into(), value: Some(llvm_fastmath(a.value.as_ref())) });
                }
            }
            Attrs::Overflow => {
                if let Some(i) = attrs.iter().position(|a| a.name == "overflowFlags") {
                    let a = attrs.remove(i);
                    attrs.push(NamedAttr { name: "overflowFlags".into(), value: Some(llvm_overflow(a.value.as_ref())) });
                }
            }
        }
        cr.vector_one_to_one(op, self.to, &operands, &attrs)
    }
}

/// The patterns without special cases, as one table.
macro_rules! one_to_one {
    ($($from:literal => $to:literal $attrs:ident $($fp:ident)?;)*) => {
        const ONE_TO_ONE: &[(&str, &str, Attrs, bool)] = &[$(($from, $to, Attrs::$attrs, one_to_one!(@fp $($fp)?)),)*];
    };
    (@fp) => { false };
    (@fp fp) => { true };
}

one_to_one! {
    "arith.addf" => "llvm.fadd" FastMath fp;
    "arith.addi" => "llvm.add" Overflow;
    "arith.andi" => "llvm.and" PassThrough;
    "arith.bitcast" => "llvm.bitcast" PassThrough;
    "arith.divf" => "llvm.fdiv" FastMath fp;
    "arith.divsi" => "llvm.sdiv" PassThrough;
    "arith.divui" => "llvm.udiv" PassThrough;
    "arith.extf" => "llvm.fpext" PassThrough fp;
    "arith.extsi" => "llvm.sext" PassThrough;
    "arith.extui" => "llvm.zext" PassThrough;
    "arith.fptosi" => "llvm.fptosi" PassThrough fp;
    "arith.fptoui" => "llvm.fptoui" PassThrough fp;
    "arith.maximumf" => "llvm.intr.maximum" FastMath fp;
    "arith.maxnumf" => "llvm.intr.maxnum" FastMath fp;
    "arith.maxsi" => "llvm.intr.smax" PassThrough;
    "arith.maxui" => "llvm.intr.umax" PassThrough;
    "arith.minimumf" => "llvm.intr.minimum" FastMath fp;
    "arith.minnumf" => "llvm.intr.minnum" FastMath fp;
    "arith.minsi" => "llvm.intr.smin" PassThrough;
    "arith.minui" => "llvm.intr.umin" PassThrough;
    "arith.mulf" => "llvm.fmul" FastMath fp;
    "arith.muli" => "llvm.mul" Overflow;
    "arith.negf" => "llvm.fneg" FastMath fp;
    "arith.ori" => "llvm.or" PassThrough;
    "arith.remf" => "llvm.frem" FastMath fp;
    "arith.remsi" => "llvm.srem" PassThrough;
    "arith.remui" => "llvm.urem" PassThrough;
    "arith.select" => "llvm.select" PassThrough;
    "arith.shli" => "llvm.shl" Overflow;
    "arith.shrsi" => "llvm.ashr" PassThrough;
    "arith.shrui" => "llvm.lshr" PassThrough;
    "arith.sitofp" => "llvm.sitofp" PassThrough;
    "arith.subf" => "llvm.fsub" FastMath fp;
    "arith.subi" => "llvm.sub" Overflow;
    "arith.trunci" => "llvm.trunc" Overflow;
    "arith.uitofp" => "llvm.uitofp" PassThrough fp;
    "arith.xori" => "llvm.xor" PassThrough;
}

/// The arith ⇒ llvm patterns, in `populateArithToLLVMConversionPatterns` order.
pub struct ArithToLlvm;

impl ArithToLlvm {
    /// `IdentityBitcastLowering`: a bitcast between types that convert alike.
    fn identity_bitcast(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some([src]) = ConversionRewriter::one_to_one(operands).as_deref().map(|s| <[ValueId; 1]>::try_from(s).ok()).flatten() else { return false };
        let res = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[cr.rw.body[op].results[0]].ty));
        if res.as_ref() != Some(&cr.rw.body[src].ty) {
            return false;
        }
        cr.replace_values(op, &[src]);
        true
    }

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

    fn index_cast_si(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::index_cast(cr, op, operands, "llvm.sext")
    }

    fn index_cast_ui(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::index_cast(cr, op, operands, "llvm.zext")
    }

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

    fn mulsi_extended(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::mul_extended(cr, op, operands, true)
    }

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

    fn cmpi(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::cmp(cr, op, operands, false)
    }

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

    /// `populateCeilFloorDivExpandOpsPatterns` then `populateArithToLLVMConversionPatterns`.
    pub fn populate(patterns: &mut ConversionPatterns<'_>, tc: usize) {
        for (root, f) in [("arith.ceildivsi", Self::ceildivsi as for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>]) -> bool), ("arith.ceildivui", Self::ceildivui), ("arith.floordivsi", Self::floordivsi)] {
            patterns.add(Lowering { root, benefit: 1, f });
        }
        patterns.add_with(tc, Lowering { root: "arith.bitcast", benefit: 10, f: Self::identity_bitcast });
        let special: [(&str, for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>]) -> bool); 9] = [
            ("arith.addui_extended", Self::addui_extended),
            ("arith.constant", Self::constant),
            ("arith.cmpf", Self::cmpf),
            ("arith.cmpi", Self::cmpi),
            ("arith.index_cast", Self::index_cast_si),
            ("arith.index_castui", Self::index_cast_ui),
            ("arith.mulsi_extended", Self::mulsi_extended),
            ("arith.mului_extended", Self::mului_extended),
            ("arith.truncf", Self::truncf),
        ];
        for (from, to, attrs, fp) in ONE_TO_ONE {
            patterns.add_with(tc, OneToOne { from, to, attrs: *attrs, fail_on_unsupported_fp: *fp, unconstrained: false });
        }
        for (root, f) in special {
            patterns.add_with(tc, Lowering { root, benefit: 1, f });
        }
    }

    /// `TruncFOpLowering` without a rounding mode, `ConstrainedTruncFOpLowering` with one.
    fn truncf(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(mode) = cr.rw.body[op].get("roundingmode").cloned() else {
            return OneToOne { from: "arith.truncf", to: "llvm.fptrunc", attrs: Attrs::PassThrough, fail_on_unsupported_fp: true, unconstrained: true }.rewrite(cr, op, operands);
        };
        let b = &*cr.rw.body;
        let types: Vec<Type> = b[op].operands.iter().chain(&b[op].results).map(|v| b[*v].ty.clone()).collect();
        if types.iter().any(|t| cr.unsupported_float(t)) {
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
