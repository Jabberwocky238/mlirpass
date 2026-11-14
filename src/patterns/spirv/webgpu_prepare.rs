use mlirformat::{Attribute, Const, Scalar, Type};

use crate::{OpData, OpId, Rewriter, ValueId};

fn scalar_or_splat<'a>(ty: &Type<'a>, v: i128) -> Attribute<'a> {
    let w = ty.element_type().bit_width().unwrap_or(32);
    match ty {
        Type::Shaped(_) => Const::splat(Scalar::Int(mlirformat::ApInt::new(w, v)), ty.clone()).into(),
        t => Attribute::integer(v, t.clone()),
    }
}

fn i32_operands(rw: &Rewriter<'_, '_>, op: OpId) -> Option<(ValueId, ValueId, Type<'static>)> {
    let [l, r] = rw.body[op].operands[..] else { return None };
    let ty = rw.body[l].ty.owned();
    (matches!(ty.element_type(), Type::Integer { width: 32, .. })).then_some((l, r, ty))
}

impl<'a> Rewriter<'_, 'a> {
    fn spirv(&mut self, name: &str, ops: &[ValueId], ty: &Type<'a>) -> ValueId {
        let o = self.create(OpData::build(name).operands(ops), core::slice::from_ref(ty));
        self.body[o].results[0]
    }

    fn spirv_constant(&mut self, ty: &Type<'a>, v: i128) -> ValueId {
        let o = self.create(OpData::build("spirv.Constant").with("value", scalar_or_splat(ty, v)), core::slice::from_ref(ty));
        self.body[o].results[0]
    }

    fn extended_mul(&mut self, op: OpId, lhs: ValueId, rhs: ValueId, ty: &Type<'a>, signed: bool) {
        let mask = self.spirv_constant(ty, (1 << 16) - 1);
        let c16 = self.spirv_constant(ty, 16);
        let c0 = self.spirv_constant(ty, 0);
        let low = |rw: &mut Self, v| rw.spirv("spirv.BitwiseAnd", &[v, mask], ty);
        let high = |rw: &mut Self, v| rw.spirv("spirv.ShiftRightLogical", &[v, c16], ty);
        let sign = |rw: &mut Self, v| {
            let s = rw.spirv("spirv.ShiftRightArithmetic", &[v, c16], ty);
            rw.spirv("spirv.ShiftRightLogical", &[s, c16], ty)
        };
        let (ll, lh) = (low(self, lhs), high(self, lhs));
        let le = if signed { sign(self, lhs) } else { c0 };
        let (rl, rh) = (low(self, rhs), high(self, rhs));
        let re = if signed { sign(self, rhs) } else { c0 };
        let (ld, rd) = ([ll, lh, le, le], [rl, rh, re, re]);
        let mut res = [c0; 4];
        for (i, l) in ld.iter().enumerate() {
            for (j, r) in rd.iter().enumerate() {
                if i + j >= 4 || *l == c0 || *r == c0 {
                    continue;
                }
                let mul = self.spirv("spirv.IMul", &[*l, *r], ty);
                let cur = self.create_or_fold(OpData::build("spirv.IAdd").operands(&[res[i + j], mul]), core::slice::from_ref(ty))[0];
                res[i + j] = low(self, cur);
                if i + j + 1 != 4 {
                    let h = high(self, cur);
                    res[i + j + 1] = self.create_or_fold(OpData::build("spirv.IAdd").operands(&[res[i + j + 1], h]), core::slice::from_ref(ty))[0];
                }
            }
        }
        let combine = |rw: &mut Self, l, h| {
            let hb = rw.spirv("spirv.ShiftLeftLogical", &[h, c16], ty);
            rw.spirv("spirv.BitwiseOr", &[l, hb], ty)
        };
        let (lo, hi) = (combine(self, res[0], res[1]), combine(self, res[2], res[3]));
        let rt = self.body[self.body[op].results[0]].ty.clone();
        let v = self.spirv("spirv.CompositeConstruct", &[lo, hi], &rt);
        self.replace_op(op, &[v]);
    }
}

pub struct WebgpuPrepare;

#[crate::patterns]
impl WebgpuPrepare {
    #[rewrite("spirv.SMulExtended")]
    fn expand_s_mul_extended_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
        rw.set_before(op);
        rw.extended_mul(op, l, r, &ty, true);
        true
    }

    #[rewrite("spirv.UMulExtended")]
    fn expand_u_mul_extended_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
        rw.set_before(op);
        rw.extended_mul(op, l, r, &ty, false);
        true
    }

    #[rewrite("spirv.IAddCarry")]
    fn expand_add_carry_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        expand_carry_borrow(rw, op, false)
    }

    #[rewrite("spirv.ISubBorrow")]
    fn expand_sub_borrow_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        expand_carry_borrow(rw, op, true)
    }

    #[rewrite("spirv.IsInf")]
    fn expand_is_inf_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.Constant").with("value", scalar_or_splat(&ty, 0)), &[ty]);
        true
    }

    #[rewrite("spirv.IsNan")]
    fn expand_is_nan_pattern(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId) -> bool {
        let ty = rw.body[rw.body[op].results[0]].ty.clone();
        rw.replace_with(op, OpData::build("spirv.Constant").with("value", scalar_or_splat(&ty, 0)), &[ty]);
        true
    }
}

fn expand_carry_borrow(rw: &mut crate::Rewriter<'_, '_>, op: crate::OpId, sub: bool) -> bool {
    let Some((l, r, ty)) = i32_operands(rw, op) else { return false };
    rw.set_before(op);
    let one = rw.spirv_constant(&ty, 1);
    let zero = rw.spirv_constant(&ty, 0);
    let out = rw.spirv(if sub { "spirv.ISub" } else { "spirv.IAdd" }, &[l, r], &ty);
    let wrapped = if sub { [l, r] } else { [out, l] };
    let cmp = rw.spirv("spirv.ULessThan", &wrapped, &ty.with_element(Type::I1));
    let flag = rw.spirv("spirv.Select", &[cmp, one, zero], &ty);
    let rt = rw.body[rw.body[op].results[0]].ty.clone();
    let v = rw.spirv("spirv.CompositeConstruct", &[out, flag], &rt);
    rw.replace_op(op, &[v]);
    true
}
