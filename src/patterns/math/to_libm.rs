use alloc::vec::Vec;

use mlirformat::{FloatKind, Type};
use crate::patterns;

use crate::patterns::{vshape, zeros, VectorBuild};
use crate::{ConversionPatterns, ConversionRewriter as Cr, Libm, Lowering, OpData, OpId, ValueId};

pub struct MathToLibm;

#[patterns(extra = Self::reshape)]
#[map("math.absf" => "fabsf,fabs", via = Self::math)]
#[map("math.acos" => "acosf,acos", via = Self::math)]
#[map("math.acosh" => "acoshf,acosh", via = Self::math)]
#[map("math.asin" => "asinf,asin", via = Self::math)]
#[map("math.asinh" => "asinhf,asinh", via = Self::math)]
#[map("math.atan2" => "atan2f,atan2", via = Self::math)]
#[map("math.atan" => "atanf,atan", via = Self::math)]
#[map("math.atanh" => "atanhf,atanh", via = Self::math)]
#[map("math.cbrt" => "cbrtf,cbrt", via = Self::math)]
#[map("math.ceil" => "ceilf,ceil", via = Self::math)]
#[map("math.cos" => "cosf,cos", via = Self::math)]
#[map("math.cosh" => "coshf,cosh", via = Self::math)]
#[map("math.erf" => "erff,erf", via = Self::math)]
#[map("math.erfc" => "erfcf,erfc", via = Self::math)]
#[map("math.exp" => "expf,exp", via = Self::math)]
#[map("math.exp2" => "exp2f,exp2", via = Self::math)]
#[map("math.expm1" => "expm1f,expm1", via = Self::math)]
#[map("math.floor" => "floorf,floor", via = Self::math)]
#[map("math.fma" => "fmaf,fma", via = Self::math)]
#[map("math.log" => "logf,log", via = Self::math)]
#[map("math.log2" => "log2f,log2", via = Self::math)]
#[map("math.log10" => "log10f,log10", via = Self::math)]
#[map("math.log1p" => "log1pf,log1p", via = Self::math)]
#[map("math.powf" => "powf,pow", via = Self::math)]
#[map("math.roundeven" => "roundevenf,roundeven", via = Self::math)]
#[map("math.round" => "roundf,round", via = Self::math)]
#[map("math.sin" => "sinf,sin", via = Self::math)]
#[map("math.sinh" => "sinhf,sinh", via = Self::math)]
#[map("math.sqrt" => "sqrtf,sqrt", via = Self::math)]
#[map("math.rsqrt" => "rsqrtf,rsqrt", via = Self::math)]
#[map("math.tan" => "tanf,tan", via = Self::math)]
#[map("math.tanh" => "tanhf,tanh", via = Self::math)]
#[map("math.trunc" => "truncf,trunc", via = Self::math)]
impl MathToLibm {
    fn math(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], to: &str) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        Libm::call(cr, op, to, Libm::float(&ty), true)
    }

    fn reshape(p: &mut ConversionPatterns<'_>) {
        for root in Self::ROOTS {
            p.add(Lowering { root, benefit: 1, f: Self::unroll });
            p.add(Lowering { root, benefit: 1, f: Self::promote });
        }
    }

    fn unroll(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.owned();
        let Some((shape, _)) = vshape(&ty) else { return false };
        let elem = crate::patterns::elem(&ty).clone();
        let mut result = cr.constant(zeros(&ty), ty.clone());
        let operands = cr.rw.body[op].operands.clone();
        let name = alloc::string::String::from(&*cr.rw.body[op].name);
        let count: i64 = shape.iter().product();
        for linear in 0..count {
            let mut pos = Vec::new();
            let mut rest = linear;
            for (i, _) in shape.iter().enumerate() {
                let stride: i64 = shape[i + 1..].iter().product();
                pos.push(rest / stride);
                rest %= stride;
            }
            let scalars: Vec<ValueId> = operands.iter().map(|v| cr.vextract_(*v, &pos)).collect();
            let s = cr.build(OpData::build(&name).operands(&scalars), elem.clone());
            result = cr.vinsert(s, result, &pos);
        }
        cr.replace_values(op, &[result]);
        true
    }

    fn promote(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.owned();
        if !matches!(ty, Type::Float(FloatKind::F16 | FloatKind::BF16)) {
            return false;
        }
        let f32 = Type::Float(FloatKind::F32);
        let operands = cr.rw.body[op].operands.clone();
        let ext: Vec<ValueId> = operands.iter().map(|v| cr.build(OpData::build("arith.extf").operands(&[*v]), f32.clone())).collect();
        let name = alloc::string::String::from(&*cr.rw.body[op].name);
        let r = cr.build(OpData::build(&name).operands(&ext), f32);
        cr.replace_new(op, OpData::build("arith.truncf").operands(&[r]), &[ty]);
        true
    }
}
