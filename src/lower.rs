//! ⭐ Lowerings, as `mlir/lib/Conversion`: one file per source dialect and target.

mod affine_to_std;
mod bufferization_to_memref;
mod complex_to_std;
mod linalg_build;
mod math_to_funcs;
mod scf_to_cf;
mod shape_to_std;
mod tensor_to_linalg;
mod to_libm;
mod tosa_to_arith;
mod tosa_to_linalg;
mod tosa_to_linalg_named;
mod tosa_to_scf;
mod tosa_to_tensor;
mod vector_to_scf;
mod vector_transforms;


use mlirformat::Error;

use crate::pass;
use crate::{Action, Body, ConversionConfig, ConversionPatterns, ConversionTarget, Converter, Mode, OpId, Run};

pub use affine_to_std::AffineToStd;
pub use bufferization_to_memref::{BufferizationToMemref, ConvertBufferizationToMemref};
pub use complex_to_std::{ComplexToStd, Cx as ComplexCx, Fmf as ComplexFmf};
pub use math_to_funcs::{ConvertMathToFuncs, MathToFuncs};
pub use scf_to_cf::ScfToCf;
pub use shape_to_std::ShapeToStd;
pub use tensor_to_linalg::{ConvertTensorToLinalg, TensorToLinalg};
pub use to_libm::{ComplexToLibm, ConvertComplexToLibm, ConvertMathToLibm, MathToLibm};
pub use tosa_to_arith::TosaToArith;
pub use tosa_to_linalg::TosaToLinalg;
pub use tosa_to_linalg_named::TosaToLinalgNamed;
pub use tosa_to_scf::{TosaToScf, TosaToScfPass};
pub use tosa_to_tensor::TosaToTensor;
pub use vector_to_scf::{ConvertVectorToScf, VectorToScfOptions};
pub use vector_transforms::{Build, pre_patterns as vector_pre_patterns, transfer_read_to_load, transfer_write_to_store};

/// `lower-affine`.
#[pass("lower-affine")]
pub fn lower_affine<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    AffineToStd::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("memref").legal_dialect("scf").legal_dialect("vector");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-complex-to-standard`.
#[pass("convert-complex-to-standard")]
pub struct ConvertComplexToStandard {
    #[opt("complex-range", default = ComplexRange::Improved, from_str)]
    range: ComplexRange,
}

/// `complex::ComplexRangeFlags`.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum ComplexRange {
    Improved,
    Basic,
    None,
}

impl core::str::FromStr for ComplexRange {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "improved" => Ok(Self::Improved),
            "basic" => Ok(Self::Basic),
            "none" => Ok(Self::None),
            _ => Err(()),
        }
    }
}

impl Run for ConvertComplexToStandard {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        ComplexToStd::populate(&mut patterns, self.range == ComplexRange::Improved);
        let mut target = ConversionTarget::default();
        target.legal_dialect("arith").legal_dialect("math").legal_op("complex.create").legal_op("complex.im").legal_op("complex.re");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `tosa-to-linalg-named`.
#[pass("tosa-to-linalg-named", on = "func.func")]
pub struct TosaToLinalgNamedPass {
    #[opt("prefer-conv2d-kernel-layout-hwcf")]
    hwcf: bool,
}

impl Run for TosaToLinalgNamedPass {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = TosaToTensor::converter();
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        TosaToLinalgNamed::populate(&mut patterns, i, self.hwcf);
        let mut target = ConversionTarget::default();
        target.legal_dialect("linalg").legal_dialect("tosa").legal_dialect("tensor").legal_dialect("scf");
        for o in ["tosa.conv2d", "tosa.conv3d", "tosa.depthwise_conv2d", "tosa.max_pool2d", "tosa.avg_pool2d", "tosa.matmul", "tosa.transpose"] {
            target.illegal_op(o);
        }
        target.unknown(Action::Legal);
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Full)
    }
}

/// `convert-scf-to-cf`.
#[pass("convert-scf-to-cf", extra = ["allow-pattern-rollback"])]
pub fn convert_scf_to_cf<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ScfToCf::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    for o in ["scf.forall", "scf.for", "scf.if", "scf.index_switch", "scf.parallel", "scf.while", "scf.execute_region"] {
        target.illegal_op(o);
    }
    target.unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-shape-to-std`.
#[pass("convert-shape-to-std", on = "builtin.module")]
pub fn convert_shape_to_std<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    ShapeToStd::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("scf").legal_dialect("tensor").legal_op("shape.cstr_require").legal_op("func.func").legal_op("builtin.module");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `tosa-to-linalg`.
#[pass("tosa-to-linalg", on = "func.func", ty = TosaToLinalgPass)]
pub fn tosa_to_linalg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = TosaToTensor::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    TosaToLinalg::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("linalg").legal_dialect("tensor").legal_dialect("scf").illegal_dialect("tosa");
    for o in ["tosa.apply_scale", "tosa.if", "tosa.const", "tosa.const_shape", "tosa.while", "tosa.concat", "tosa.slice", "tosa.reshape", "tosa.pad"] {
        target.legal_op(o);
    }
    target.unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Full)
}

/// `tosa-to-arith`.
#[pass("tosa-to-arith")]
pub struct TosaToArithPass {
    #[opt("include-apply-rescale")]
    rescale: bool,
    #[opt("use-32-bit")]
    use_32: bool,
}

impl Run for TosaToArithPass {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        TosaToArith::populate(&mut patterns, self.rescale, self.use_32);
        let mut target = ConversionTarget::default();
        target.illegal_op("tosa.const").legal_dialect("arith");
        if self.rescale {
            target.illegal_op("tosa.apply_scale");
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `tosa-to-tensor`.
#[pass("tosa-to-tensor", ty = TosaToTensorPass)]
pub fn tosa_to_tensor<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = TosaToTensor::converter();
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    TosaToTensor::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.illegal_op("tosa.concat").illegal_op("tosa.reshape").illegal_op("tosa.slice").illegal_op("tosa.pad").legal_dialect("arith").legal_dialect("tensor");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

crate::pass_set! {
    /// The lowerings between dialects.
    LowerPasses: ConvertBufferizationToMemref, ConvertComplexToLibm, ConvertComplexToStandard, ConvertMathToFuncs, ConvertMathToLibm, ConvertScfToCf, ConvertShapeToStd, ConvertTensorToLinalg, ConvertVectorToScf, LowerAffine, TosaToArithPass, TosaToLinalgNamedPass, TosaToLinalgPass, TosaToScfPass, TosaToTensorPass
}
