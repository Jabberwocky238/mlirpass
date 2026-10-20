//! `math` / `complex` ⇒ libm calls, as `MathToLibm.cpp` and `ComplexToLibm.cpp`: each op a
//! `func.call` of its `float` / `double` function, declared at the start of the module.

use alloc::vec::Vec;

use mlirformat::{Attribute, Error, FloatKind, FunctionType, Type};
use mlirpass_macros::{pass, patterns};

use super::vector_transforms::{vshape, zeros, VectorBuild};
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionRewriter as Cr, ConversionTarget, Converter, Lowering, Mode, OpData, OpId, ValueId};

/// The math ⇒ libm patterns; `to` is `float,double`. Each op has three, as C++: the call
/// (`ScalarOpToLibmCall`), and the vector unrolling and f32 promotion that make its scalar
/// form (which the call then lowers: another pattern, so no recursion).
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
    /// `ScalarOpToLibmCall`.
    fn math(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], to: &str) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        Libm::call(cr, op, to, Libm::float(&ty), true)
    }

    /// The other two of each op.
    fn reshape(p: &mut ConversionPatterns<'_>) {
        for root in Self::ROOTS {
            p.add(Lowering { root, benefit: 1, f: Self::unroll });
            p.add(Lowering { root, benefit: 1, f: Self::promote });
        }
    }

    /// `VecOpToScalarOp`: element by element into a zero vector.
    fn unroll(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.owned();
        let Some((shape, _)) = vshape(&ty) else { return false };
        let elem = super::vector_transforms::elem(&ty).clone();
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

    /// `PromoteOpToF32`: computed in f32, truncated back.
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

/// The complex ⇒ libm patterns; `to` is `float,double`.
pub struct ComplexToLibm;

#[patterns]
#[map("complex.pow" => "cpowf,cpow", via = Self::complex)]
#[map("complex.sqrt" => "csqrtf,csqrt", via = Self::complex)]
#[map("complex.tanh" => "ctanhf,ctanh", via = Self::complex)]
#[map("complex.cos" => "ccosf,ccos", via = Self::complex)]
#[map("complex.sin" => "csinf,csin", via = Self::complex)]
#[map("complex.conj" => "conjf,conj", via = Self::complex)]
#[map("complex.log" => "clogf,clog", via = Self::complex)]
#[map("complex.abs" => "cabsf,cabs", via = Self::complex)]
#[map("complex.angle" => "cargf,carg", via = Self::complex)]
#[map("complex.tan" => "ctanf,ctan", via = Self::complex)]
impl ComplexToLibm {
    /// `ScalarOpToLibmCall` (`ComplexTypeResolver` / `FloatTypeResolver`).
    fn complex(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], to: &str) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let double = match &ty {
            Type::Complex(e) => Libm::float(e),
            t => Libm::float(t),
        };
        Libm::call(cr, op, to, double, false)
    }
}

/// The libm call both share.
struct Libm;

impl Libm {
    /// f64 ⇒ `Some(true)`, f32 ⇒ `Some(false)`, anything else ⇒ `None`.
    fn float(t: &Type<'_>) -> Option<bool> {
        match t {
            Type::Float(FloatKind::F64) => Some(true),
            Type::Float(FloatKind::F32) => Some(false),
            _ => None,
        }
    }

    /// The op as a call of `float,double`'s function, declared (private; `readnone` for math)
    /// at the start of the nearest symbol table when it is not yet.
    fn call(cr: &mut Cr<'_, '_, '_>, op: OpId, to: &str, double: Option<bool>, readnone: bool) -> bool {
        let (Some(double), Some((float_fn, double_fn))) = (double, to.split_once(',')) else { return false };
        let name = if double { double_fn } else { float_fn };
        let b = &*cr.rw.body;
        let mut table = b.parent_op(op);
        while let Some(t) = table.filter(|t| !b.is_symbol_table(*t)) {
            table = b.parent_op(t);
        }
        let Some(table) = table else { return false };
        let operands = b[op].operands.clone();
        let results = b.types(&b[op].results);
        if b.lookup(table, name).is_none() {
            let ty = FunctionType { inputs: b.types(&operands), results: results.clone() };
            let mut data = OpData::build("func.func").with("sym_name", Attribute::str(name)).with("function_type", Attribute::Type(Type::Function(ty))).with("sym_visibility", Attribute::str("private"));
            if readnone {
                data.set("llvm.readnone", Attribute::Unit);
            }
            let f = cr.rw.body.create(data, &[]);
            cr.rw.body.add_region(f);
            let top = cr.rw.body[cr.rw.body[table].regions[0]].blocks[0];
            let first = cr.rw.body[top].ops.first().copied();
            cr.rw.move_before(f, top, first);
        }
        cr.replace_new(op, OpData::build("func.call").operands(&operands).with("callee", Attribute::SymbolRef(alloc::vec![alloc::string::String::from(name).into()])), &results);
        true
    }
}

/// `convert-math-to-libm`.
#[pass("convert-math-to-libm", on = "builtin.module")]
pub fn convert_math_to_libm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    MathToLibm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("builtin").legal_dialect("func").legal_dialect("vector").illegal_dialect("math");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-complex-to-libm`.
#[pass("convert-complex-to-libm", on = "builtin.module")]
pub fn convert_complex_to_libm<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ComplexToLibm::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("func");
    for r in ComplexToLibm::ROOTS {
        target.illegal_op(r);
    }
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
