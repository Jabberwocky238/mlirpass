//! ⭐ Lowerings, as `mlir/lib/Conversion`: one file per source dialect and target.

mod affine_to_std;
mod arith_to_emitc;
mod bufferization_to_memref;
mod complex_to_std;
mod emitc;
mod func_to_emitc;
mod interfaces;
mod linalg_build;
mod math_to_emitc;
mod math_to_funcs;
mod memref_to_emitc;
mod scf_to_cf;
mod scf_to_emitc;
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

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::{ArithToLlvm, AssertLowering, CfToLlvm, FuncToLlvm, IndexToLlvm, MathToLlvm, MemrefOptions, MemrefToLlvm, UbToLlvm, VectorOptions, VectorToLlvm};
use crate::{Action, ConversionRewriter, ConversionTarget, OpData, OpId, TypeConverter, ValueId};
use mlirformat::llvm_types::LlvmType;

pub use affine_to_std::AffineToStd;
pub use arith_to_emitc::ArithToEmitc;
pub use bufferization_to_memref::{BufferizationToMemref, ConvertBufferizationToMemref};
pub use complex_to_std::{ComplexToLlvm, ComplexToStd};
pub use emitc::Emitc;
pub use func_to_emitc::FuncToEmitc;
pub use interfaces::{DialectInterfaces, LlvmEnv, ToEmitcInterfaces, ToLlvmInterfaces};
pub use math_to_emitc::MathToEmitc;
pub use math_to_funcs::{ConvertMathToFuncs, MathToFuncs};
pub use memref_to_emitc::MemrefToEmitc;
pub use scf_to_cf::ScfToCf;
pub use scf_to_emitc::ScfToEmitc;
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

/// Something a typed `#[lowering]` reads off the op it lowers (its fast-math flags, ..).
trait FromOp {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self;
}

/// What a typed `#[lowering]` returns: the op's replacement, or failure.
pub trait Replacement {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool;
}

impl Replacement for ValueId {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &[self]);
        true
    }
}

impl Replacement for Option<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        self.is_some_and(|v| v.replace(cr, op))
    }
}

impl Replacement for Vec<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &self);
        true
    }
}

/// A lowering that needs the pass options `O`.
pub struct OptLowering<O> {
    pub root: &'static str,
    pub opts: O,
    pub f: for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>], O) -> bool,
}

impl<O: Copy> crate::ConversionPattern for OptLowering<O> {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands, self.opts)
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// Builds `data` with one result of type `ty` at the insertion point; the result.
    pub fn build(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.rw.create(data, &[ty]);
        self.rw.body[o].results[0]
    }

    /// Builds mlirformat's typed op `op` at the insertion point; its first result.
    pub fn emit(&mut self, op: &impl crate::TypedOp) -> ValueId {
        let o = self.rw.emit(op);
        self.rw.body[o].results[0]
    }

    /// The single remapped value of each operand (`getOneToOneAdaptorOperands`).
    pub fn one_to_one(operands: &[Vec<ValueId>]) -> Option<Vec<ValueId>> {
        operands.iter().map(|o| (o.len() == 1).then(|| o[0])).collect()
    }

    /// `packOperationResults`.
    fn pack_results(tc: &TypeConverter<'_>, types: &[Type<'a>]) -> Option<Type<'a>> {
        match types {
            [t] => tc.convert(t),
            ts => {
                let conv = ts.iter().map(|t| tc.convert(t).filter(LlvmType::compatible)).collect::<Option<Vec<_>>>()?;
                Some(LlvmType::literal(conv))
            }
        }
    }

    /// `oneToOneRewrite`: `op` as `target` with the same operands and the attributes given.
    pub fn one_to_one_rewrite(&mut self, op: OpId, target: &str, operands: &[ValueId], attrs: &[NamedAttr<'a>]) -> bool {
        let Some(tc) = self.type_converter() else { return false };
        let types = self.rw.body.types(&self.rw.body[op].results.clone());
        let mut data = OpData::build(target).operands(operands);
        for a in attrs {
            data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
        }
        if types.is_empty() {
            self.rw.create(data, &[]);
            self.erase(op);
            return true;
        }
        let Some(packed) = Self::pack_results(tc, &types) else { return false };
        let n = self.build(data, packed);
        if types.len() == 1 {
            self.replace_values(op, &[n]);
            return true;
        }
        let results: Vec<ValueId> = (0..types.len()).map(|i| self.extract(n, &[i as i64])).collect();
        self.replace_values(op, &results);
        true
    }

    /// `handleMultidimensionalVectors`: the op unrolled over the outer dimensions of an n-d
    /// vector, each 1-d piece built by `make`.
    pub fn unroll_vectors(&mut self, op: OpId, operands: &[ValueId], mut make: impl FnMut(&mut Self, Type<'a>, &[ValueId]) -> ValueId) -> bool {
        let Some(tc) = self.type_converter() else { return false };
        let res_ty = self.rw.body[self.rw.body[op].results[0]].ty.clone();
        let Some(nd) = tc.convert(&res_ty).filter(LlvmType::compatible) else { return false };
        let mut sizes = Vec::new();
        let mut t = nd.clone();
        while let Ok(LlvmType::Array(n, e)) = LlvmType::try_from(&t) {
            sizes.push(n as i64);
            t = *e;
        }
        let one_d = t;
        let mut desc = self.poison(nd);
        let total: i64 = sizes.iter().product();
        for linear in 0..total {
            let mut pos = vec![0i64; sizes.len()];
            let mut rest = linear;
            for (i, s) in sizes.iter().enumerate().rev() {
                pos[i] = rest % s;
                rest /= s;
            }
            let pieces: Vec<ValueId> = operands.iter().map(|v| self.extract(*v, &pos)).collect();
            let v = make(self, one_d.clone(), &pieces);
            desc = self.insert_value(desc, v, &pos);
        }
        self.replace_values(op, &[desc]);
        true
    }

    /// `vectorOneToOneRewrite`.
    pub fn vector_one_to_one(&mut self, op: OpId, target: &str, operands: &[ValueId], attrs: &[NamedAttr<'a>]) -> bool {
        if operands.is_empty() || !operands.iter().all(|v| LlvmType::compatible(&self.rw.body[*v].ty)) {
            return false;
        }
        if !matches!(LlvmType::try_from(&self.rw.body[operands[0]].ty), Ok(LlvmType::Array(..))) {
            return self.one_to_one_rewrite(op, target, operands, attrs);
        }
        let attrs = attrs.to_vec();
        self.unroll_vectors(op, operands, |cr, ty, pieces| {
            let mut data = OpData::build(target).operands(pieces);
            for a in &attrs {
                data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
            }
            cr.build(data, ty)
        })
    }

    /// The op's attributes, inherent and discardable, sorted (`getAttrs()`).
    pub fn all_attrs(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        let d = &self.rw.body[op];
        let mut out: Vec<NamedAttr<'a>> = match &d.properties {
            Some(Attribute::Dict(p)) => p.clone(),
            _ => Vec::new(),
        };
        out.extend(d.attributes.iter().cloned());
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }
}

/// A conversion pattern given as a root, a benefit and a function.
pub struct Lowering {
    pub root: &'static str,
    pub benefit: u16,
    pub f: LowerFn,
}

/// What a [`Lowering`] runs.
pub type LowerFn = for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>]) -> bool;

impl crate::ConversionPattern for Lowering {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn benefit(&self) -> u16 {
        self.benefit
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands)
    }
}

/// A 1-d vector of `n` elements of `elem`.
pub fn vector1<'a>(n: i64, elem: Type<'a>) -> Type<'a> {
    Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![Dim::Static(n)]), elem: elem.into(), extras: Vec::new() })
}

// ---- passes ------------------------------------------------------------------------------

use mlirformat::Error;

use crate::{Body, ConversionConfig, ConversionPatterns, Converter, Mode, Run};

/// `lower-affine`.
#[pass("lower-affine")]
pub fn lower_affine<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    AffineToStd::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("memref").legal_dialect("scf").legal_dialect("vector");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-arith-to-emitc`.
#[pass("convert-arith-to-emitc")]
pub fn convert_arith_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(false);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ArithToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_dialect("arith");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-func-to-emitc`.
#[pass("convert-func-to-emitc", on = "builtin.module")]
pub fn convert_func_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let tc = Emitc::converter(false);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    FuncToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.legal_dialect("emitc").illegal_op("func.call").illegal_op("func.func").illegal_op("func.return");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-math-to-emitc`.
#[pass("convert-math-to-emitc")]
pub struct ConvertMathToEmitc {
    #[opt("language-target", default = LanguageTarget::C99, from_str)]
    target: LanguageTarget,
}

/// `emitc::LanguageTarget`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum LanguageTarget {
    C99,
    Cpp11,
}

impl core::str::FromStr for LanguageTarget {
    type Err = ();
    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "c99" => Ok(Self::C99),
            "cpp11" => Ok(Self::Cpp11),
            _ => Err(()),
        }
    }
}

impl Run for ConvertMathToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut patterns = ConversionPatterns::default();
        MathToEmitc::populate(&mut patterns, self.target == LanguageTarget::Cpp11);
        let mut target = ConversionTarget::default();
        target.legal_op("emitc.call_opaque");
        for r in MathToEmitc::ROOTS {
            target.illegal_op(r);
        }
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-scf-to-emitc`.
#[pass("convert-scf-to-emitc")]
pub fn convert_scf_to_emitc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut tc = Emitc::converter(true);
    Emitc::size_t_conversions(&mut tc);
    let mut patterns = ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ScfToEmitc::populate(&mut patterns, i);
    let mut target = ConversionTarget::default();
    target.illegal_op("scf.for").illegal_op("scf.if").illegal_op("scf.index_switch").illegal_op("scf.while").unknown(Action::Legal);
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}

/// `convert-memref-to-emitc`.
#[pass("convert-memref-to-emitc", on = "builtin.module")]
pub struct ConvertMemrefToEmitc {
    #[opt("lower-to-cpp")]
    cpp: bool,
}

impl Run for ConvertMemrefToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let mut tc = Emitc::converter(true);
        Emitc::memref_conversions(&mut tc, false);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToEmitc::populate(&mut patterns, i);
        let mut target = ConversionTarget::default();
        target.illegal_dialect("memref").legal_dialect("emitc");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)?;
        MemrefToEmitc::add_headers(body, op, self.cpp);
        Ok(())
    }
}

/// The dialects that implement `ConvertToEmitCPatternInterface`, by namespace.
/// `convert-to-emitc`: every dialect's `ConvertToEmitCPatternInterface` patterns (or those of
/// `filter-dialects`) with the types EmitC supports.
#[pass("convert-to-emitc")]
pub struct ConvertToEmitc {
    #[opt("filter-dialects")]
    filter: Vec<String>,
    /// The dialects' `ConvertToEmitCPatternInterface`s.
    interfaces: ToEmitcInterfaces,
}

impl Run for ConvertToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let dialects: Vec<&str> = if self.filter.is_empty() { self.interfaces.dialects() } else { self.filter.iter().map(String::as_str).collect() };
        if let Some(d) = dialects.iter().find(|d| !self.interfaces.knows(d)) {
            return Err(Error(format!("dialect does not implement ConvertToEmitCPatternInterface: {d}")));
        }
        let mut tc = Emitc::converter(true);
        let size_t = dialects.iter().any(|d| self.interfaces.uses_size_t(d));
        for d in &dialects {
            self.interfaces.types(d, &mut tc, size_t);
        }
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        for d in dialects {
            self.interfaces.populate(d, &mut patterns, i, &());
        }
        let mut target = ConversionTarget::default();
        target.legal_dialect("emitc");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
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

/// `reconcile-unrealized-casts`.
#[pass("reconcile-unrealized-casts")]
pub fn reconcile_unrealized_casts<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let casts: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "builtin.unrealized_conversion_cast").collect();
    body.reconcile_casts(&casts);
    Ok(())
}

impl Body<'_> {
    /// The single block of a symbol table op like `builtin.module`.
    pub fn top_block(&self, op: OpId) -> crate::BlockId {
        self[self[op].regions[0]].blocks[0]
    }
}

/// MLIR's string escapes undone: `\\`, `\"`, `\n`, `\t` and `\XX`.
pub fn unescape(s: &str) -> Vec<u8> {
    let b = s.as_bytes();
    let mut out = Vec::new();
    let mut i = 0;
    while i < b.len() {
        if b[i] != b'\\' || i + 1 >= b.len() {
            out.push(b[i]);
            i += 1;
            continue;
        }
        match b[i + 1] {
            b'n' => out.push(b'\n'),
            b't' => out.push(b'\t'),
            b'\\' | b'"' => out.push(b[i + 1]),
            _ if i + 2 < b.len() => {
                let hex = core::str::from_utf8(&b[i + 1..i + 3]).ok().and_then(|h| u8::from_str_radix(h, 16).ok());
                match hex {
                    Some(v) => {
                        out.push(v);
                        i += 4;
                        continue;
                    }
                    None => out.push(b[i + 1]),
                }
            }
            c => out.push(c),
        }
        i += 2;
    }
    out
}
