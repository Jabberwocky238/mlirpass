use alloc::vec::Vec;

use mlirformat::Type;
use crate::patterns;

use crate::{ConversionRewriter as Cr, Libm, OpId, ValueId};

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
    fn complex(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], to: &str) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let double = match &ty {
            Type::Complex(e) => Libm::float(e),
            t => Libm::float(t),
        };
        Libm::call(cr, op, to, double, false)
    }
}
