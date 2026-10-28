//! `complex` ⇒ `llvm`, as `ComplexToLLVM.cpp`, on the builder and division algorithms
//! `complex-to-standard` shares (`ComplexCommon`).

use alloc::vec::Vec;

use crate::patterns;
use mlirformat::Type;

use crate::{ComplexCx as Cx, ComplexFmf as Fmf, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `complex` ⇒ `llvm`, as `ComplexToLLVM.cpp`.
pub struct ComplexToLlvm;

#[patterns(converter, improved: bool)]
impl ComplexToLlvm {
    /// The element type, the struct type, and a builder.
    fn begin<'c, 'r, 'a, 'p>(cr: &'c mut Cr<'r, 'a, 'p>, op: OpId) -> Option<(Cx<'c, 'r, 'a, 'p>, Type<'a>)> {
        let ct = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let st = cr.type_converter()?.convert(&ct)?;
        let mut b = Cx::new(cr, ct);
        b.llvm = true;
        Some((b, st))
    }

    /// Both operands unpacked: (lhs re, lhs im, rhs re, rhs im).
    fn unpack(b: &mut Cx<'_, '_, '_, '_>, o: &[Vec<ValueId>]) -> (ValueId, ValueId, ValueId, ValueId) {
        let lr = b.field(o[0][0], 0);
        let li = b.field(o[0][0], 1);
        let rr = b.field(o[1][0], 0);
        let ri = b.field(o[1][0], 1);
        (lr, li, rr, ri)
    }

    #[lowering("complex.abs")]
    fn abs(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let fmf = Fmf::of(cr, op);
        let ct = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let mut b = Cx::new(cr, ct);
        b.llvm = true;
        let re = b.field(o[0][0], 0);
        let im = b.field(o[0][0], 1);
        let rr = b.mul(re, re, fmf);
        let ii = b.mul(im, im, fmf);
        let n = b.add(rr, ii, fmf);
        let ty = b.et.clone();
        cr.replace_new(op, OpData::build("llvm.intr.sqrt").operands(&[n]), &[ty]);
        true
    }

    #[lowering("complex.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ct = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(st) = cr.type_converter().and_then(|tc| tc.convert(&ct)) else { return false };
        let mut data = OpData::build("llvm.mlir.constant");
        if let Some(v) = cr.rw.body[op].get("value").cloned() {
            data.set("value", v);
        }
        cr.replace_new(op, data, &[st]);
        true
    }

    #[lowering("complex.create")]
    fn create(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let v = b.pack(st, o[0][0], o[1][0]);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("complex.im", "complex.re")]
    fn part(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ct = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let i = i64::from(cr.rw.body[op].name == "complex.im");
        let mut b = Cx::new(cr, ct);
        let v = b.field(o[0][0], i);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("complex.add", "complex.mul", "complex.sub")]
    fn arith(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let fmf = Fmf::of(cr, op);
        let name = cr.rw.body[op].name.clone();
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let (lr, li, rr, ri) = Self::unpack(&mut b, o);
        let poison = b.mk(OpData::build("llvm.mlir.poison"), st.clone());
        let (re, im) = match &*name {
            "complex.add" => (b.add(lr, rr, fmf), b.add(li, ri, fmf)),
            "complex.sub" => (b.sub(lr, rr, fmf), b.sub(li, ri, fmf)),
            "complex.mul" => {
                let a = b.mul(rr, lr, fmf);
                let c = b.mul(ri, li, fmf);
                let re = b.sub(a, c, fmf);
                let a = b.mul(li, rr, fmf);
                let c = b.mul(lr, ri, fmf);
                (re, b.add(a, c, fmf))
            }
            _ => return false,
        };
        let v = b.insert(poison, re, im);
        cr.replace_values(op, &[v]);
        true
    }

    fn div(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], improved: bool) -> bool {
        let fmf = Fmf::of(cr, op);
        let Some((mut b, st)) = Self::begin(cr, op) else { return false };
        let (lr, li, rr, ri) = Self::unpack(&mut b, o);
        let poison = b.mk(OpData::build("llvm.mlir.poison"), st.clone());
        let (re, im) = if improved { b.div_range_reduction(lr, li, rr, ri, fmf) } else { b.div_algebraic(lr, li, rr, ri, fmf) };
        let v = b.insert(poison, re, im);
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("complex.div", when = improved)]
    fn div_improved(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, true)
    }

    #[lowering("complex.div", when = !improved)]
    fn div_basic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::div(cr, op, o, false)
    }
}
