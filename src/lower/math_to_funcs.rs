//! `convert-math-to-funcs`, as `MathToFuncs.cpp`: `math.ipowi`, `math.fpowi` and `math.ctlz`
//! as calls to functions generated into the module (vectors scalarized first).

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Error, FunctionType, Type};
use crate::{blocks, pass, patterns};

use crate::{ApFloat, BlockId, Body, Const, ConversionConfig, ConversionPatterns, ConversionRewriter, ConversionTarget, Converter, Mode, OpData, OpId, RegionId, Run, Scalar, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `arith::CmpIPredicate`s.
const EQ: i64 = 0;
const NE: i64 = 1;
const SLE: i64 = 3;

/// An `ImplicitLocOpBuilder` inside one generated function: ops go to the end of `at`.
struct Fb<'b, 'a> {
    b: &'b mut Body<'a>,
    region: RegionId,
    at: BlockId,
}

impl<'a> Fb<'_, 'a> {
    fn op(&mut self, data: OpData<'a>, types: &[Type<'a>]) -> OpId {
        let o = self.b.create(data, types);
        self.b.insert(o, self.at, None);
        o
    }

    fn v(&mut self, name: &str, ops: &[ValueId], ty: Type<'a>) -> ValueId {
        let o = self.op(OpData::build(name).operands(ops), &[ty]);
        self.b[o].results[0]
    }

    fn bin(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.b[a].ty.clone();
        self.v(name, &[a, b], ty)
    }

    /// An arith op, its float or integer form by the operands' type.
    fn arith(&mut self, float: &str, int: &str, a: ValueId, b: ValueId) -> ValueId {
        let name = if matches!(self.b[a].ty, Type::Float(_)) { float } else { int };
        self.bin(name, a, b)
    }

    fn sub(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.arith("arith.subf", "arith.subi", a, b)
    }

    fn mul(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.arith("arith.mulf", "arith.muli", a, b)
    }

    fn div(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.arith("arith.divf", "arith.divsi", a, b)
    }

    fn and(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.bin("arith.andi", a, b)
    }

    /// `>>`: the logical shift.
    fn shr(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.bin("arith.shrui", a, b)
    }

    fn select(&mut self, c: ValueId, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.b[a].ty.clone();
        self.v("arith.select", &[c, a, b], ty)
    }

    fn constant(&mut self, value: Attribute<'a>, ty: &Type<'a>) -> ValueId {
        let o = self.op(OpData::build("arith.constant").with("value", value), &[ty.clone()]);
        self.b[o].results[0]
    }

    fn int(&mut self, v: i128, ty: &Type<'a>) -> ValueId {
        let o = self.op(OpData::build("arith.constant").with("value", Attribute::integer(v, ty.clone())), &[ty.clone()]);
        self.b[o].results[0]
    }

    fn cmpi(&mut self, pred: i64, a: ValueId, b: ValueId) -> ValueId {
        let o = self.op(OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), &[Type::int(1)]);
        self.b[o].results[0]
    }

    /// `createBlock(region)`: a new last block, where ops now go.
    fn block(&mut self, types: &[Type<'a>]) -> BlockId {
        let args: Vec<_> = types.iter().map(|t| (t.clone(), None)).collect();
        self.at = self.b.add_block(self.region, &args);
        self.at
    }

    fn arg(&self, b: BlockId, i: usize) -> ValueId {
        self.b[b].args[i]
    }

    fn ret(&mut self, vals: &[ValueId]) {
        self.op(OpData::build("func.return").operands(vals), &[]);
    }

    fn br(&mut self, dest: BlockId, args: &[ValueId]) {
        self.op(OpData::build("cf.br").operands(args).successors(&[dest]), &[]);
    }

    fn cond_br(&mut self, c: ValueId, t: BlockId, ta: &[ValueId], f: BlockId, fa: &[ValueId]) {
        let mut ops = vec![c];
        ops.extend(ta);
        ops.extend(fa);
        self.op(OpData::build("cf.cond_br").operands(&ops).successors(&[t, f]).segments(&[1, ta.len(), fa.len()]), &[]);
    }

    /// Ends `block` with `f` (ops then go back to where they were).
    fn at_end(&mut self, block: BlockId, f: impl FnOnce(&mut Self)) {
        let saved = self.at;
        self.at = block;
        f(self);
        self.at = saved;
    }
}

/// The math ⇒ func patterns and generated functions.
pub struct MathToFuncs;

impl MathToFuncs {
    fn elem<'a>(t: &Type<'a>) -> Type<'a> {
        t.element_type().clone()
    }

    fn width(t: &Type<'_>) -> u32 {
        t.bit_width().unwrap_or(0)
    }

    /// A private `linkonce_odr` function `name : ty` at the end of `module`, with its entry block.
    fn function<'b, 'a>(b: &'b mut Body<'a>, module: OpId, name: &str, ty: FunctionType<'a>) -> Fb<'b, 'a> {
        let inputs = ty.inputs.clone();
        let data = OpData::build("func.func")
            .with("sym_name", Attribute::str(name))
            .with("function_type", Attribute::Type(Type::Function(ty)))
            .with("llvm.linkage", Attribute::dialect("llvm.linkage", "<linkonce_odr>"))
            .with("sym_visibility", Attribute::str("private"));
        let f = b.create(data, &[]);
        let top = b[b[module].regions[0]].blocks[0];
        b.insert(f, top, None);
        let region = b.add_region(f);
        let args: Vec<_> = inputs.into_iter().map(|t| (t, None)).collect();
        let at = b.add_block(region, &args);
        Fb { b, region, at }
    }

    /// `createElementIPowIFunc`: the blocks in their order (C++ creates them out of it).
    fn ipowi<'a>(b: &mut Body<'a>, module: OpId, t: Type<'a>) {
        let mut f = Self::function(b, module, &format!("__mlir_math_ipowi_{t}"), FunctionType { inputs: vec![t.clone(), t.clone()], results: vec![t.clone()] });
        blocks!(f;
            entry(base: t.clone(), power: t.clone()) {
                let zero = f.int(0, &t);
                let one = f.int(1, &t);
                let minus_one = f.int(-1, &t);
                let p_is_zero = f.cmpi(EQ, power, zero);
                f.cond_br(p_is_zero, ret_one, &[], p_non_zero, &[]);
            }
            ret_one {
                f.ret(&[one]);
            }
            p_non_zero {
                let p_is_neg = f.cmpi(SLE, power, zero);
                f.cond_br(p_is_neg, negative, &[], header, &[one, base, power]);
            }
            negative {
                let b_is_zero = f.cmpi(EQ, base, zero);
                f.cond_br(b_is_zero, div_by_zero, &[], b_non_zero, &[]);
            }
            div_by_zero {
                f.ret(&[one / zero]);
            }
            b_non_zero {
                let b_is_one = f.cmpi(EQ, base, one);
                f.cond_br(b_is_one, ret_one2, &[], b_not_one, &[]);
            }
            ret_one2 {
                f.ret(&[one]);
            }
            b_not_one {
                let b_is_minus_one = f.cmpi(EQ, base, minus_one);
                f.cond_br(b_is_minus_one, minus_one_base, &[], ret_zero, &[]);
            }
            minus_one_base {
                let p_is_odd = f.cmpi(NE, power & one, zero);
                f.cond_br(p_is_odd, ret_minus_one, &[], ret_one3, &[]);
            }
            ret_minus_one {
                f.ret(&[minus_one]);
            }
            ret_one3 {
                f.ret(&[one]);
            }
            ret_zero {
                f.ret(&[zero]);
            }
            header(result: t.clone(), base_tmp: t.clone(), power_tmp: t.clone()) {
                let odd = f.cmpi(NE, power_tmp & one, zero);
                f.cond_br(odd, times_base, &[], next, &[result]);
            }
            times_base {
                f.br(next, &[result * base_tmp]);
            }
            next(new_result: t.clone()) {
                let new_power = power_tmp >> one;
                let done = f.cmpi(EQ, new_power, zero);
                f.cond_br(done, ret_result, &[], latch, &[]);
            }
            ret_result {
                f.ret(&[new_result]);
            }
            latch {
                f.br(header, &[new_result, base_tmp * base_tmp, new_power]);
            }
        );
    }

    /// `createElementFPowIFunc`: the blocks in their order.
    fn fpowi<'a>(b: &mut Body<'a>, module: OpId, ft: FunctionType<'a>) {
        let (bt, pt) = (ft.inputs[0].clone(), ft.inputs[1].clone());
        let Type::Float(k) = bt else { return };
        let w = Self::width(&pt);
        let (min, max) = (-(1i128 << (w - 1)), (1i128 << (w - 1)) - 1);
        let one: Attribute = Const::scalar(Scalar::Float(ApFloat::from_f64(k, 1.0).expect("a float")), bt.clone()).into();
        let mut f = Self::function(b, module, &format!("__mlir_math_fpowi_{bt}_{pt}"), ft);
        blocks!(f;
            entry(base: bt.clone(), power: pt.clone()) {
                let one_b = f.constant(one, &bt);
                let zero_p = f.int(0, &pt);
                let one_p = f.int(1, &pt);
                let min_p = f.int(min, &pt);
                let max_p = f.int(max, &pt);
                let p_is_zero = f.cmpi(EQ, power, zero_p);
                f.cond_br(p_is_zero, ret_one, &[], p_non_zero, &[]);
            }
            ret_one {
                f.ret(&[one_b]);
            }
            p_non_zero {
                let p_is_neg = f.cmpi(SLE, power, zero_p);
                let p_is_min = f.cmpi(EQ, power, min_p);
                let neg_p = zero_p - power;
                let p_init = f.select(p_is_neg, neg_p, power);
                let p_init = f.select(p_is_min, max_p, p_init);
                f.br(header, &[one_b, base, p_init]);
            }
            header(result: bt.clone(), base_tmp: bt.clone(), power_tmp: pt.clone()) {
                let odd = f.cmpi(NE, power_tmp & one_p, zero_p);
                f.cond_br(odd, times_base, &[], next, &[result]);
            }
            times_base {
                f.br(next, &[result * base_tmp]);
            }
            next(new_result: bt.clone()) {
                let new_power = power_tmp >> one_p;
                let done = f.cmpi(EQ, new_power, zero_p);
                f.cond_br(done, exit, &[new_result], latch, &[]);
            }
            latch {
                f.br(header, &[new_result, base_tmp * base_tmp, new_power]);
            }
            exit(r: bt.clone()) {
                f.cond_br(p_is_min, times_once_more, &[], adjusted, &[r]);
            }
            times_once_more {
                f.br(adjusted, &[r * base]);
            }
            adjusted(r2: bt.clone()) {
                f.cond_br(p_is_neg, reciprocal, &[], ret, &[r2]);
            }
            reciprocal {
                f.br(ret, &[one_b / r2]);
            }
            ret(rv: bt.clone()) {
                f.ret(&[rv]);
            }
        );
    }

    /// `createCtlzFunc`.
    fn ctlz<'a>(b: &mut Body<'a>, module: OpId, t: Type<'a>) {
        let w = Self::width(&t);
        let mut f = Self::function(b, module, &format!("__mlir_math_ctlz_{t}"), FunctionType { inputs: vec![t.clone()], results: vec![t.clone()] });
        let entry = f.at;
        let arg = f.arg(entry, 0);
        let bw = f.int(i128::from(w), &t);
        let zero = f.int(0, &t);
        let eq = f.cmpi(0, arg, zero);
        let i = f.op(OpData::build("scf.if").operands(&[eq]), core::slice::from_ref(&t));
        let [tr, er] = [0, 1].map(|_| f.b.add_region(i));
        let tb = f.b.add_block(tr, &[]);
        let eb = f.b.add_block(er, &[]);
        f.at_end(tb, |f| {
            f.op(OpData::build("scf.yield").operands(&[bw]), &[]);
        });
        f.at = eb;
        let one_i = f.int(1, &Type::Index);
        let one = f.int(1, &t);
        let bw_i = f.int(i128::from(w), &Type::Index);
        let n = f.int(0, &t);
        let lp = f.op(OpData::build("scf.for").operands(&[one_i, bw_i, one_i, arg, n]), &[t.clone(), t.clone()]);
        let lr = f.b.add_region(lp);
        let lb = f.b.add_block(lr, &[(Type::Index, None), (t.clone(), None), (t.clone(), None)]);
        f.at_end(lb, |f| {
            let (ai, ni) = (f.arg(lb, 1), f.arg(lb, 2));
            let neg = f.cmpi(2, ai, zero);
            let inner = f.op(OpData::build("scf.if").operands(&[neg]), &[t.clone(), t.clone()]);
            let [tr, er] = [0, 1].map(|_| f.b.add_region(inner));
            let tb = f.b.add_block(tr, &[]);
            let eb = f.b.add_block(er, &[]);
            f.at_end(tb, |f| {
                f.op(OpData::build("scf.yield").operands(&[ai, ni]), &[]);
            });
            f.at_end(eb, |f| {
                let nn = f.bin("arith.addi", ni, one);
                let an = f.bin("arith.shli", ai, one);
                f.op(OpData::build("scf.yield").operands(&[an, nn]), &[]);
            });
            let rs = f.b[inner].results.clone();
            f.op(OpData::build("scf.yield").operands(&rs), &[]);
        });
        let r1 = f.b[lp].results[1];
        f.op(OpData::build("scf.yield").operands(&[r1]), &[]);
        f.at = entry;
        let r = f.b[i].results[0];
        f.ret(&[r]);
    }

    /// The function a call replaces `op` with, by name.
    fn callee<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, name: &str) -> Option<(OpId, Vec<Type<'a>>)> {
        let b = &*cr.rw.body;
        let mut t = b.parent_op(op);
        while let Some(o) = t {
            if b.is_symbol_table(o) {
                let f = b.lookup(o, name)?;
                let Some(Attribute::Type(Type::Function(ft))) = b[f].get("function_type") else { return None };
                return Some((f, ft.results.clone()));
            }
            t = b.parent_op(o);
        }
        None
    }

    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, name: &str) -> bool {
        let Some((_, results)) = Self::callee(cr, op, name) else { return false };
        let ops = cr.rw.body[op].operands.clone();
        cr.replace_new(op, OpData::build("func.call").operands(&ops).with("callee", Attribute::SymbolRef(vec![String::from(name).into()])), &results);
        true
    }

    fn is_vector(cr: &Cr<'_, '_, '_>, op: OpId) -> bool {
        let r = cr.rw.body[op].results[0];
        matches!(&cr.rw.body[r].ty, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector)
    }
}

#[patterns(convert_ctlz: bool)]
impl MathToFuncs {
    /// `VecOpToScalarOp`: one scalar op per element.
    #[lowering("math.ipowi", "math.fpowi", "math.ctlz")]
    fn scalarize(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !Self::is_vector(cr, op) {
            return false;
        }
        let vt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let et = Self::elem(&vt);
        let shape = vt.dims().unwrap_or_default();
        let zero: Attribute = match &et {
            Type::Float(k) => Const::splat(Scalar::Float(ApFloat::from_f64(*k, 0.0).expect("a float")), vt.clone()).into(),
            _ => Const::splat(Scalar::Int(crate::ApInt::new(Self::width(&et), 0)), vt.clone()).into(),
        };
        let mut result = cr.emit(&arith::Constant::new(zero, vt.clone()));
        let n: i64 = shape.iter().product();
        let name = cr.rw.body[op].name.clone();
        let inputs = cr.rw.body[op].operands.clone();
        for lin in 0..n {
            let mut pos = vec![0i64; shape.len()];
            let mut rest = lin;
            for d in (0..shape.len()).rev() {
                pos[d] = rest % shape[d];
                rest /= shape[d];
            }
            let ops: Vec<ValueId> = inputs
                .iter()
                .map(|v| {
                    let ty = Self::elem(&cr.rw.body[*v].ty);
                    cr.build(OpData::build("vector.extract").operands(&[*v]).with("static_position", Attribute::dense_i64(&pos)), ty)
                })
                .collect();
            let s = cr.build(OpData::build(&name).operands(&ops), et.clone());
            result = cr.build(OpData::build("vector.insert").operands(&[s, result]).with("static_position", Attribute::dense_i64(&pos)), vt.clone());
        }
        cr.replace_values(op, &[result]);
        true
    }

    /// `IPowIOpLowering`.
    #[lowering("math.ipowi")]
    fn ipowi_call(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let t = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !matches!(t, Type::Integer { .. }) {
            return false;
        }
        Self::call(cr, op, &format!("__mlir_math_ipowi_{t}"))
    }

    /// `FPowIOpLowering`.
    #[lowering("math.fpowi")]
    fn fpowi_call(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if Self::is_vector(cr, op) {
            return false;
        }
        let b = &*cr.rw.body;
        let (bt, pt) = (b[b[op].operands[0]].ty.clone(), b[b[op].operands[1]].ty.clone());
        Self::call(cr, op, &format!("__mlir_math_fpowi_{bt}_{pt}"))
    }

    /// `CtlzOpLowering`.
    #[lowering("math.ctlz", when = convert_ctlz)]
    fn ctlz_call(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if Self::is_vector(cr, op) {
            return false;
        }
        let t = Self::elem(&cr.rw.body[cr.rw.body[op].results[0]].ty);
        Self::call(cr, op, &format!("__mlir_math_ctlz_{t}"))
    }
}

#[pass("convert-math-to-funcs", on = "builtin.module")]
pub struct ConvertMathToFuncs {
    #[opt("min-width-of-fpowi-exponent", default = 1)]
    min_width: u32,
    #[opt("convert-ctlz")]
    convert_ctlz: bool,
}

impl ConvertMathToFuncs {
    fn int_result(b: &Body<'_>, op: OpId) -> bool {
        matches!(b[b[op].results[0]].ty.element_type(), Type::Integer { .. })
    }

    fn fpowi_ok(&self, b: &Body<'_>, op: OpId) -> bool {
        let e = b[b[op].operands[1]].ty.element_type();
        matches!(e, Type::Integer { .. }) && MathToFuncs::width(e) >= self.min_width
    }

    /// `generateOpImplementations`: one function per (op, type), in post-order of first use.
    fn generate(&self, b: &mut Body<'_>, module: OpId) {
        let mut ops = Vec::new();
        b.walk_post(module, &mut |o| ops.push(o));
        let mut made: Vec<String> = Vec::new();
        for o in ops {
            let key = match &*b[o].name {
                "math.ctlz" if self.convert_ctlz && Self::int_result(b, o) => format!("ctlz {}", MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.ipowi" if Self::int_result(b, o) => format!("ipowi {}", MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.fpowi" if self.fpowi_ok(b, o) => format!("fpowi {} {}", MathToFuncs::elem(&b[b[o].operands[0]].ty), MathToFuncs::elem(&b[b[o].operands[1]].ty)),
                _ => continue,
            };
            if made.contains(&key) {
                continue;
            }
            made.push(key);
            match &*b[o].name {
                "math.ctlz" => MathToFuncs::ctlz(b, module, MathToFuncs::elem(&b[b[o].results[0]].ty)),
                "math.ipowi" => MathToFuncs::ipowi(b, module, MathToFuncs::elem(&b[b[o].results[0]].ty)),
                _ => {
                    let ft = FunctionType { inputs: b[o].operands.iter().map(|v| MathToFuncs::elem(&b[*v].ty)).collect(), results: vec![MathToFuncs::elem(&b[b[o].results[0]].ty)] };
                    MathToFuncs::fpowi(b, module, ft)
                }
            }
        }
    }
}

impl Run for ConvertMathToFuncs {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        self.generate(body, op);
        let mut patterns = ConversionPatterns::default();
        MathToFuncs::populate(&mut patterns, self.convert_ctlz);
        let mut target = ConversionTarget::default();
        for d in ["arith", "cf", "func", "scf", "vector"] {
            target.legal_dialect(d);
        }
        target.dynamic_op("math.ipowi", |b, o| Some(!ConvertMathToFuncs::int_result(b, o)));
        if self.convert_ctlz {
            target.dynamic_op("math.ctlz", |b, o| Some(!ConvertMathToFuncs::int_result(b, o)));
        }
        let min = self.min_width;
        target.dynamic_op("math.fpowi", move |b, o| {
            let e = b[b[o].operands[1]].ty.element_type();
            Some(!(matches!(e, Type::Integer { .. }) && MathToFuncs::width(e) >= min))
        });
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}
