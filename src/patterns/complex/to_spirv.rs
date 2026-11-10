//! `complex` ⇒ `spirv`, as `ComplexToSPIRV.cpp`: a complex number is a 2-vector.

use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::patterns;

use crate::{Const, ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The complex ⇒ spirv patterns (`populateComplexToSPIRVPatterns`).
pub struct ComplexToSpirv;

impl ComplexToSpirv {
    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        let r = cr.rw.body[op].results[0];
        cr.converted(&cr.rw.body[r].ty.clone())
    }

    /// Element `i` of a complex's vector.
    fn element<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, i: i64) -> ValueId {
        let ty = cr.rw.body[v].ty.element_type().clone();
        cr.build(OpData::build("spirv.CompositeExtract").operands(&[v]).with("indices", Attribute::Array(alloc::vec![Attribute::integer(i128::from(i), Type::int(32))])), ty)
    }

    /// The `(re, im)` of the operands, in order.
    fn parts(cr: &mut Cr<'_, '_, '_>, ops: &[ValueId]) -> Vec<ValueId> {
        ops.iter().flat_map(|v| [*v, *v].into_iter().zip([0, 1])).map(|(v, i)| Self::element(cr, v, i)).collect()
    }

    fn bin<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]), ty)
    }

    /// The vector of `re`, `im` for `op`.
    fn construct<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, ty: Type<'a>, re: ValueId, im: ValueId) -> bool {
        cr.replace_new(op, OpData::build("spirv.CompositeConstruct").operands(&[re, im]), &[ty]);
        true
    }

    /// `AbsOpPattern`: `sqrt(re^2 + im^2)`.
    fn abs(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], sqrt: &str) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let p = Self::parts(cr, &ops);
        let rr = Self::bin(cr, "spirv.FMul", p[0], p[0]);
        let ii = Self::bin(cr, "spirv.FMul", p[1], p[1]);
        let sum = Self::bin(cr, "spirv.FAdd", rr, ii);
        cr.replace_new(op, OpData::build(sqrt).operands(&[sum]), &[ty]);
        true
    }

    /// `ReOpPattern` / `ImOpPattern`: element `i` of the vector.
    fn part(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], i: i64) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeExtract").operands(&ops).with("indices", Attribute::Array(alloc::vec![Attribute::integer(i128::from(i), Type::int(32))])), &[ty]);
        true
    }
}

#[patterns(converter)]
impl ComplexToSpirv {
    /// `ConstantOpPattern`: the `[re, im]` pair as a dense vector.
    #[convert("complex.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(ty @ Type::Shaped(_)) = Self::result_ty(cr, op) else { return false };
        let Some(Attribute::Array(parts)) = cr.rw.body[op].get("value") else { return false };
        let Some(values) = parts.iter().map(|p| Const::try_from(p).ok()?.splat_value()).collect::<Option<Vec<_>>>() else { return false };
        let value = match values[..] {
            [a, b] if a == b => Const::splat(a, ty.clone()),
            _ => Const { ty: ty.clone(), values, elements: true },
        };
        cr.replace_new(op, OpData::build("spirv.Constant").with("value", value.into()), &[ty]);
        true
    }

    /// `CreateOpPattern`.
    #[convert("complex.create")]
    fn create(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        cr.replace_new(op, OpData::build("spirv.CompositeConstruct").operands(&ops), &[ty]);
        true
    }

    #[convert("complex.re")]
    fn re(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::part(cr, op, operands, 0)
    }

    #[convert("complex.im")]
    fn im(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::part(cr, op, operands, 1)
    }

    /// `ElementwiseBinaryOpPattern`: add / sub part by part.
    #[convert("complex.add", "complex.sub")]
    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let name = if cr.rw.body[op].name == "complex.add" { "spirv.FAdd" } else { "spirv.FSub" };
        let p = Self::parts(cr, &ops);
        let re = Self::bin(cr, name, p[0], p[2]);
        let im = Self::bin(cr, name, p[1], p[3]);
        Self::construct(cr, op, ty, re, im)
    }

    /// `ComparisonOpPattern`: eq as both parts ordered-equal, neq as either unordered-not-equal.
    #[convert("complex.eq", "complex.neq")]
    fn compare(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let (cmp, combine) = if cr.rw.body[op].name == "complex.eq" { ("spirv.FOrdEqual", "spirv.LogicalAnd") } else { ("spirv.FUnordNotEqual", "spirv.LogicalOr") };
        let p = Self::parts(cr, &ops);
        let re = cr.build(OpData::build(cmp).operands(&[p[0], p[2]]), Type::I1);
        let im = cr.build(OpData::build(cmp).operands(&[p[1], p[3]]), Type::I1);
        cr.replace_new(op, OpData::build(combine).operands(&[re, im]), &[ty]);
        true
    }

    /// `MulOpPattern`: `(ac - bd, ad + bc)`.
    #[convert("complex.mul")]
    fn mul(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let p = Self::parts(cr, &ops);
        let (a, b, c, d) = (p[0], p[1], p[2], p[3]);
        let ac = Self::bin(cr, "spirv.FMul", a, c);
        let bd = Self::bin(cr, "spirv.FMul", b, d);
        let ad = Self::bin(cr, "spirv.FMul", a, d);
        let bc = Self::bin(cr, "spirv.FMul", b, c);
        let re = Self::bin(cr, "spirv.FSub", ac, bd);
        let im = Self::bin(cr, "spirv.FAdd", ad, bc);
        Self::construct(cr, op, ty, re, im)
    }

    /// `DivOpPattern`: `((ac + bd) / (cc + dd), (bc - ad) / (cc + dd))`.
    #[convert("complex.div")]
    fn div(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let p = Self::parts(cr, &ops);
        let (a, b, c, d) = (p[0], p[1], p[2], p[3]);
        let ac = Self::bin(cr, "spirv.FMul", a, c);
        let bd = Self::bin(cr, "spirv.FMul", b, d);
        let bc = Self::bin(cr, "spirv.FMul", b, c);
        let ad = Self::bin(cr, "spirv.FMul", a, d);
        let cc = Self::bin(cr, "spirv.FMul", c, c);
        let dd = Self::bin(cr, "spirv.FMul", d, d);
        let denom = Self::bin(cr, "spirv.FAdd", cc, dd);
        let num_re = Self::bin(cr, "spirv.FAdd", ac, bd);
        let num_im = Self::bin(cr, "spirv.FSub", bc, ad);
        let re = Self::bin(cr, "spirv.FDiv", num_re, denom);
        let im = Self::bin(cr, "spirv.FDiv", num_im, denom);
        Self::construct(cr, op, ty, re, im)
    }

    /// `NegationOpPattern`: neg negates both parts, conj the imaginary one.
    #[convert("complex.neg", "complex.conj")]
    fn negate(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(ty) = Self::result_ty(cr, op) else { return false };
        let p = Self::parts(cr, &ops);
        let et = cr.rw.body[p[0]].ty.clone();
        let re = if cr.rw.body[op].name == "complex.neg" { cr.build(OpData::build("spirv.FNegate").operands(&[p[0]]), et.clone()) } else { p[0] };
        let im = cr.build(OpData::build("spirv.FNegate").operands(&[p[1]]), et);
        Self::construct(cr, op, ty, re, im)
    }

    #[convert("complex.abs")]
    fn abs_gl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::abs(cr, op, operands, "spirv.GL.Sqrt")
    }

    #[convert("complex.abs")]
    fn abs_cl(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        Self::abs(cr, op, operands, "spirv.CL.sqrt")
    }
}
