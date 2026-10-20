//! ⭐ Lowerings, as `mlir/lib/Conversion`: one file per source dialect and target.

mod affine_to_std;
mod arith_to_emitc;
mod arith_to_llvm;
mod cf_to_llvm;
mod complex_to_std;
mod emitc;
mod func_to_emitc;
mod func_to_llvm;
mod index_to_llvm;
mod linalg_build;
mod math_to_emitc;
mod math_to_funcs;
mod math_to_llvm;
mod memref_desc;
mod memref_to_emitc;
mod memref_to_llvm;
mod scf_to_cf;
mod scf_to_emitc;
mod shape_to_std;
mod tosa_to_arith;
mod tosa_to_linalg;
mod tosa_to_linalg_named;
mod tosa_to_tensor;
mod vector_to_llvm;
mod vector_to_scf;
mod vector_transforms;

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::canon::AttrExt;
use crate::{Action, ConversionRewriter, ConversionTarget, LlvmType, OpData, OpId, TypeConverter, ValueId};

pub use affine_to_std::AffineToStd;
pub use arith_to_emitc::ArithToEmitc;
pub use arith_to_llvm::ArithToLlvm;
pub use cf_to_llvm::{AssertLowering, CfToLlvm};
pub use complex_to_std::{ComplexToLlvm, ComplexToStd};
pub use emitc::Emitc;
pub use func_to_emitc::FuncToEmitc;
pub use func_to_llvm::FuncToLlvm;
pub use index_to_llvm::{IndexToLlvm, UbToLlvm};
pub use math_to_emitc::MathToEmitc;
pub use math_to_funcs::{ConvertMathToFuncs, MathToFuncs};
pub use math_to_llvm::MathToLlvm;
pub use memref_desc::DYNAMIC;
pub use memref_to_emitc::MemrefToEmitc;
pub use memref_to_llvm::{MemrefOptions, MemrefToLlvm};
pub use scf_to_cf::ScfToCf;
pub use scf_to_emitc::ScfToEmitc;
pub use shape_to_std::ShapeToStd;
pub use vector_to_llvm::{VectorOptions, VectorToLlvm};
pub use tosa_to_arith::TosaToArith;
pub use tosa_to_linalg::TosaToLinalg;
pub use tosa_to_linalg_named::TosaToLinalgNamed;
pub use tosa_to_tensor::TosaToTensor;
pub use vector_to_scf::{ConvertVectorToScf, VectorToScfOptions};
pub use vector_transforms::{Build, transfer_read_to_load, transfer_write_to_store};

/// Fast-math flags, by name, in LLVM's bit order.
const LLVM_FASTMATH: [&str; 7] = ["nnan", "ninf", "nsz", "arcp", "contract", "afn", "reassoc"];

/// `#arith.fastmath<...>` ⇒ `#llvm.fastmath<...>` (`convertArithFastMathAttrToLLVM`).
pub fn llvm_fastmath<'a>(arith: Option<&Attribute<'_>>) -> Attribute<'a> {
    let names: Vec<&str> = match arith {
        Some(Attribute::Extended { ext, .. }) => {
            let body = ext.body.as_deref().unwrap_or("<none>");
            body.trim_start_matches('<').trim_end_matches('>').split(',').map(str::trim).collect()
        }
        _ => Vec::new(),
    };
    let all = names.contains(&"fast");
    let set: Vec<&str> = LLVM_FASTMATH.iter().copied().filter(|f| all || names.contains(f)).collect();
    let body = match set.len() {
        0 => String::from("<none>"),
        7 => String::from("<fast>"),
        _ => format!("<{}>", set.join(", ")),
    };
    Attribute::dialect("llvm.fastmath", &body)
}

/// `#arith.overflow<...>` ⇒ the LLVM `overflowFlags` property (`nsw` = 1, `nuw` = 2).
pub fn llvm_overflow<'a>(arith: Option<&Attribute<'_>>) -> Attribute<'a> {
    let body = match arith {
        Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().unwrap_or(""),
        _ => "",
    };
    let v = i64::from(body.contains("nsw")) | (i64::from(body.contains("nuw")) << 1);
    Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::int(32)) }
}

/// `LLVMConversionTarget`: the llvm dialect and unrealized casts are legal.
pub fn llvm_target<'c>() -> ConversionTarget<'c> {
    let mut t = ConversionTarget::default();
    t.legal_dialect("llvm").op("builtin.unrealized_conversion_cast", Action::Legal);
    t
}

/// Something a typed `#[lowering]` reads off the op it lowers (its fast-math flags, ..).
trait FromOp {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self;
}

/// What a typed `#[lowering]` returns: the op's replacement, or failure.
trait Replacement {
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
struct OptLowering<O> {
    root: &'static str,
    opts: O,
    f: for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>], O) -> bool,
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

/// `array<i64: ...>`.
fn positions<'a>(p: &[i64]) -> Attribute<'a> {
    Attribute::DenseArray { ty: Type::int(64), values: p.iter().map(|x| Cow::Owned(format!("{x}"))).collect() }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// Builds `data` with one result of type `ty` at the insertion point; the result.
    pub fn build(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.rw.create(data, &[ty]);
        self.rw.body[o].results[0]
    }

    /// `llvm.extractvalue` of `agg` at `pos`.
    pub fn extract(&mut self, agg: ValueId, pos: &[i64]) -> ValueId {
        let mut ty = self.rw.body[agg].ty.clone();
        for p in pos {
            ty = match LlvmType::try_from(&ty) {
                Ok(LlvmType::Array(_, e)) => *e,
                Ok(LlvmType::Struct { body: Some(b), .. }) => b[*p as usize].clone(),
                _ => ty,
            };
        }
        self.build(OpData::build("llvm.extractvalue").operands(&[agg]).with("position", positions(pos)), ty)
    }

    /// `llvm.insertvalue` of `v` into `agg` at `pos`.
    pub fn insert_value(&mut self, agg: ValueId, v: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.rw.body[agg].ty.clone();
        self.build(OpData::build("llvm.insertvalue").operands(&[agg, v]).with("position", positions(pos)), ty)
    }

    /// `llvm.mlir.poison : ty`.
    pub fn poison(&mut self, ty: Type<'a>) -> ValueId {
        self.build(OpData::build("llvm.mlir.poison"), ty)
    }

    /// `llvm.mlir.constant`.
    pub fn llvm_constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        self.build(OpData::build("llvm.mlir.constant").with("value", value), ty)
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

    /// `isUnsupportedFloatingPointType`: a float (element) type the converter does not keep a float.
    pub fn unsupported_float(&self, t: &Type<'a>) -> bool {
        let e = crate::attr::element_type(t);
        if !matches!(e, Type::Float(_)) {
            return false;
        }
        self.type_converter().and_then(|tc| tc.convert(e)).is_none_or(|c| !matches!(c, Type::Float(_)))
    }

    /// `FailOnUnsupportedFP`: whether an operand or result has an unsupported float type.
    pub fn unsupported_fp_op(&self, op: OpId) -> bool {
        let b = &*self.rw.body;
        b[op].operands.iter().chain(&b[op].results).any(|v| self.unsupported_float(&b[*v].ty))
    }

    /// `AttrConvertFastMathToLLVM`: `fastmath` becomes `fastmathFlags`.
    pub fn fastmath_to_llvm(attrs: &mut Vec<NamedAttr<'a>>) {
        if let Some(i) = attrs.iter().position(|a| a.name == "fastmath") {
            let a = attrs.remove(i);
            attrs.push(NamedAttr { name: "fastmathFlags".into(), value: Some(llvm_fastmath(a.value.as_ref())) });
        }
    }

    /// `AttrConvertOverflowToLLVM`: `overflowFlags` as the LLVM property.
    pub fn overflow_to_llvm(attrs: &mut Vec<NamedAttr<'a>>) {
        if let Some(i) = attrs.iter().position(|a| a.name == "overflowFlags") {
            let a = attrs.remove(i);
            attrs.push(NamedAttr { name: "overflowFlags".into(), value: Some(llvm_overflow(a.value.as_ref())) });
        }
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

use crate::{Body, ConversionConfig, ConversionPatterns, Converter, LlvmConverter, LlvmOptions, Mode, Run};

/// `convert-arith-to-llvm`.
#[pass("convert-arith-to-llvm")]
pub struct ConvertArithToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertArithToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToLlvm::populate(&mut patterns, i);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// A `convert-X-to-llvm` pass: an `index-bitwidth` option, a pattern population and a target.
macro_rules! to_llvm_pass {
    ($($(#[$m:meta])* $ty:ident = $name:literal: $populate:path, |$t:ident| $target:block;)*) => {$(
        $(#[$m])*
        #[pass($name)]
        pub struct $ty {
            #[opt("index-bitwidth")]
            index_bitwidth: u32,
        }

        impl Run for $ty {
            fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
                let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
                let mut patterns = ConversionPatterns::default();
                let i = patterns.converter(&tc);
                $populate(&mut patterns, i);
                let mut $t = ConversionTarget::default();
                $target
                Converter::new(&$t, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
            }
        }
    )*};
}

to_llvm_pass! {
    /// `convert-index-to-llvm`.
    ConvertIndexToLlvm = "convert-index-to-llvm": IndexToLlvm::populate, |t| {
        t.illegal_dialect("index").legal_dialect("llvm");
    };
    /// `convert-ub-to-llvm`.
    ConvertUbToLlvm = "convert-ub-to-llvm": UbToLlvm::populate, |t| {
        t.legal_dialect("llvm").op("builtin.unrealized_conversion_cast", Action::Legal);
    };
}

/// `convert-math-to-llvm`.
#[pass("convert-math-to-llvm")]
pub struct ConvertMathToLlvm {
    #[opt("approximate-log1p", default = true)]
    approximate_log1p: bool,
}

impl Run for ConvertMathToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MathToLlvm::populate(&mut patterns, i, self.approximate_log1p);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-cf-to-llvm`.
#[pass("convert-cf-to-llvm")]
pub struct ConvertCfToLlvm {
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    counter: core::cell::Cell<u32>,
}

impl Run for ConvertCfToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::bitwidth(self.index_bitwidth).at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        CfToLlvm::populate(&mut patterns, i);
        patterns.add_with(i, AssertLowering(&self.counter));
        let mut target = llvm_target();
        target.unknown(Action::Dynamic(alloc::boxed::Box::new(|b: &Body<'_>, o: OpId| Some(!b[o].name.starts_with("cf.")))));
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-func-to-llvm`.
#[pass("convert-func-to-llvm", on = "builtin.module")]
pub struct ConvertFuncToLlvm {
    #[opt("use-bare-ptr-memref-call-conv")]
    bare_ptr: bool,
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
}

impl Run for ConvertFuncToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let options = LlvmOptions { index_bitwidth: self.index_bitwidth, bare_ptr: self.bare_ptr }.at(body, op);
        let tc = LlvmConverter::build(options);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToLlvm::populate(&mut patterns, i, options);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `finalize-memref-to-llvm`.
#[pass("finalize-memref-to-llvm")]
pub struct FinalizeMemrefToLlvm {
    #[opt("use-aligned-alloc")]
    aligned_alloc: bool,
    #[opt("index-bitwidth")]
    index_bitwidth: u32,
    #[opt("use-generic-functions")]
    generic: bool,
}

impl Run for FinalizeMemrefToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let options = MemrefOptions { llvm: LlvmOptions::bitwidth(self.index_bitwidth).at(body, op), aligned_alloc: self.aligned_alloc, generic: self.generic };
        let tc = LlvmConverter::build(options.llvm);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToLlvm::populate(&mut patterns, i, options);
        let mut target = llvm_target();
        target.legal_op("func.func");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-to-llvm`: every dialect's `ConvertToLLVMPatternInterface` patterns (or those of
/// `filter-dialects`), against a target where the llvm dialect is legal.
#[pass("convert-to-llvm", extra = ["dynamic"], check = Self::check)]
pub struct ConvertToLlvm {
    #[opt("filter-dialects")]
    filter: Vec<String>,
    #[opt("allow-pattern-rollback", default = true)]
    rollback: bool,
    counter: core::cell::Cell<u32>,
}

impl ConvertToLlvm {
    /// A dialect whose lowering is not ported yet makes the pass unsupported, not wrong.
    fn check(&self) -> Result<(), Error> {
        match self.filter.iter().find(|d| !TO_LLVM.contains(&d.as_str())) {
            Some(d) => Err(Error(format!("convert-to-llvm: the {d} lowering is not ported"))),
            None => Ok(()),
        }
    }
}

/// The dialects that implement `ConvertToLLVMPatternInterface`, by namespace.
const TO_LLVM: &[&str] = &["arith", "cf", "complex", "func", "index", "math", "memref", "ub", "vector"];

impl Run for ConvertToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        let dialects: Vec<&str> = if self.filter.is_empty() { TO_LLVM.to_vec() } else { self.filter.iter().map(String::as_str).collect() };
        for d in dialects {
            match d {
                "arith" => ArithToLlvm::populate(&mut patterns, i),
                "index" => IndexToLlvm::populate(&mut patterns, i),
                "math" => MathToLlvm::populate(&mut patterns, i, true),
                "ub" => UbToLlvm::populate(&mut patterns, i),
                "complex" => ComplexToLlvm::populate(&mut patterns, i, false),
                "func" => FuncToLlvm::populate(&mut patterns, i, LlvmOptions::derived().at(body, op)),
                "vector" => VectorToLlvm::populate(&mut patterns, i, VectorOptions { llvm: LlvmOptions::derived().at(body, op), reassociate_fp_reductions: false, force_32bit_indices: true, use_vector_alignment: false, counter: &self.counter }),
                "memref" => MemrefToLlvm::populate(&mut patterns, i, MemrefOptions { llvm: LlvmOptions::derived().at(body, op), aligned_alloc: false, generic: false }),
                "cf" => {
                    CfToLlvm::populate(&mut patterns, i);
                    patterns.add_with(i, AssertLowering(&self.counter));
                }
                d if TO_LLVM.contains(&d) => {}
                d => return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}"))),
            }
        }
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm");
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
    }
}

/// `set-llvm-module-datalayout`.
#[pass("set-llvm-module-datalayout")]
pub struct SetLlvmModuleDataLayout {
    #[opt("data-layout")]
    layout: String,
}

impl Run for SetLlvmModuleDataLayout {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        body[op].set("llvm.data_layout", Attribute::string(&self.layout));
        Ok(())
    }
}

/// `convert-vector-to-llvm`: the vector-to-vector lowerings greedily, then the conversion.
#[pass("convert-vector-to-llvm", check = Self::check)]
pub struct ConvertVectorToLlvm {
    #[opt("reassociate-fp-reductions")]
    reassociate: bool,
    #[opt("force-32bit-vector-indices", default = true)]
    force32: bool,
    #[opt("use-vector-alignment")]
    vector_alignment: bool,
    #[opt("vector-contract-lowering", default = "dot".into())]
    contract_lowering: String,
    #[opt("vector-transpose-lowering", default = "eltwise".into())]
    transpose_lowering: String,
    #[opt("enable-amx")]
    amx: bool,
    #[opt("enable-arm-neon")]
    arm_neon: bool,
    #[opt("enable-arm-sve")]
    arm_sve: bool,
    #[opt("enable-arm-i8mm")]
    arm_i8mm: bool,
    #[opt("enable-arm-bf16")]
    arm_bf16: bool,
    #[opt("enable-x86vector")]
    x86vector: bool,
    counter: core::cell::Cell<u32>,
}

impl ConvertVectorToLlvm {
    /// What is not ported makes the pass unsupported, not wrong.
    fn check(&self) -> Result<(), Error> {
        let flags = [("enable-amx", self.amx), ("enable-arm-neon", self.arm_neon), ("enable-arm-sve", self.arm_sve), ("enable-arm-i8mm", self.arm_i8mm), ("enable-arm-bf16", self.arm_bf16), ("enable-x86vector", self.x86vector)];
        if let Some((f, _)) = flags.iter().find(|f| f.1) {
            return Err(Error(format!("convert-vector-to-llvm: {f} is not ported")));
        }
        for (k, v, default) in [("vector-contract-lowering", &self.contract_lowering, "dot"), ("vector-transpose-lowering", &self.transpose_lowering, "eltwise")] {
            if v != default {
                return Err(Error(format!("convert-vector-to-llvm: {k} is not ported")));
            }
        }
        Ok(())
    }
}

impl Run for ConvertVectorToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let pre = vector_transforms::pre_patterns(self.force32);
        for r in body[op].regions.clone() {
            body.apply_greedily(r, &pre, &crate::GreedyConfig::default());
        }
        let opts = LlvmOptions::default();
        let tc = LlvmConverter::build(opts);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        patterns.add(Lowering { root: "vector.transfer_read", benefit: 1, f: |cr, op, _| transfer_read_to_load(cr, op, None) });
        patterns.add(Lowering { root: "vector.transfer_write", benefit: 1, f: |cr, op, _| transfer_write_to_store(cr, op, None) });
        VectorToLlvm::populate(&mut patterns, i, VectorOptions { llvm: opts, reassociate_fp_reductions: self.reassociate, force_32bit_indices: self.force32, use_vector_alignment: self.vector_alignment, counter: &self.counter });
        let mut target = llvm_target();
        target.legal_dialect("arith").legal_dialect("memref");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

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
const TO_EMITC: &[&str] = &["arith", "func", "memref", "scf"];
/// Those ported so far.
const TO_EMITC_PORTED: &[&str] = &["arith", "func", "memref", "scf"];

/// `convert-to-emitc`: every dialect's `ConvertToEmitCPatternInterface` patterns (or those of
/// `filter-dialects`) with the types EmitC supports.
#[pass("convert-to-emitc", check = Self::check)]
pub struct ConvertToEmitc {
    #[opt("filter-dialects")]
    filter: Vec<String>,
}

impl ConvertToEmitc {
    /// A dialect whose lowering is not ported yet makes the pass unsupported, not wrong.
    fn check(&self) -> Result<(), Error> {
        let wanted: Vec<&str> = if self.filter.is_empty() { TO_EMITC.to_vec() } else { self.filter.iter().map(String::as_str).collect() };
        match wanted.iter().find(|d| TO_EMITC.contains(d) && !TO_EMITC_PORTED.contains(d)) {
            Some(d) => Err(Error(format!("convert-to-emitc: the {d} lowering is not ported"))),
            None => Ok(()),
        }
    }
}

impl Run for ConvertToEmitc {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let dialects: Vec<&str> = if self.filter.is_empty() { TO_EMITC.to_vec() } else { self.filter.iter().map(String::as_str).collect() };
        if let Some(d) = dialects.iter().find(|d| !TO_EMITC.contains(d)) {
            return Err(Error(format!("dialect does not implement ConvertToEmitCPatternInterface: {d}")));
        }
        let mut tc = Emitc::converter(true);
        let size_t = dialects.iter().any(|d| matches!(*d, "arith" | "scf"));
        for d in &dialects {
            match *d {
                "arith" | "scf" => Emitc::size_t_conversions(&mut tc),
                "memref" => Emitc::memref_conversions(&mut tc, size_t),
                _ => {}
            }
        }
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        for d in dialects {
            match d {
                "arith" => ArithToEmitc::populate(&mut patterns, i),
                "func" => FuncToEmitc::populate(&mut patterns, i),
                "scf" => ScfToEmitc::populate(&mut patterns, i),
                "memref" => MemrefToEmitc::populate(&mut patterns, i),
                _ => {}
            }
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
enum ComplexRange {
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

/// `convert-complex-to-llvm`.
#[pass("convert-complex-to-llvm")]
pub struct ConvertComplexToLlvm {
    #[opt("complex-range", default = ComplexRange::Basic, from_str)]
    range: ComplexRange,
}

impl Run for ConvertComplexToLlvm {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::derived().at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ComplexToLlvm::populate(&mut patterns, i, self.range == ComplexRange::Improved);
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm").illegal_dialect("complex");
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
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

// ---- LLVM functions, globals and calls ----------------------------------------------------

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// The `builtin.module` around `op`.
    pub fn module_of(&self, op: OpId) -> Option<OpId> {
        let mut at = self.rw.body.parent_op(op);
        while let Some(o) = at {
            if self.rw.body[o].name == "builtin.module" {
                return Some(o);
            }
            at = self.rw.body.parent_op(o);
        }
        None
    }

    /// `lookupOrCreateFn`: the `llvm.func` `name` of `module`, declared at its start if missing.
    pub fn llvm_func(&mut self, module: OpId, name: &str, params: Vec<Type<'a>>, ret: Type<'a>, vararg: bool) -> Option<OpId> {
        let fty: Type<'a> = LlvmType::Func { ret: ret.into(), params, vararg }.into();
        if let Some(f) = self.rw.body.lookup(module, name).filter(|f| self.rw.body[*f].name == "llvm.func") {
            return (self.rw.body[f].get("function_type") == Some(&Attribute::Type(fty))).then_some(f);
        }
        let saved = self.rw.ip;
        let block = self.rw.body.top_block(module);
        self.rw.set_start(block);
        let loc = self.rw.body[module].loc.clone();
        let data = OpData { loc, ..OpData::build("llvm.func").with("function_type", Attribute::Type(fty)).with("sym_name", Attribute::string(name)) };
        let f = self.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        self.rw.ip = saved;
        Some(f)
    }

    /// `llvm.call @callee(args)`.
    pub fn llvm_call(&mut self, callee: &str, args: &[ValueId], results: &[Type<'a>]) -> OpId {
        let data = OpData::build("llvm.call").operands(args).with("callee", Attribute::SymbolRef(vec![Cow::Owned(String::from(callee))])).segments(&[args.len(), 0]);
        self.rw.create(data, results)
    }

    /// `ensureSymbolNameIsUnique` with the process-wide counter it keeps.
    fn unique_symbol(&self, module: OpId, base: &str, counter: &core::cell::Cell<u32>) -> String {
        let mut name = String::from(base);
        while self.rw.body.lookup(module, &name).is_some() {
            name = format!("{base}_{}", counter.get());
            counter.set(counter.get() + 1);
        }
        name
    }

    /// `createPrintStrCall`: a private constant global holding `bytes` (NUL-terminated here),
    /// and a call of `runtime` (`printString` by default) on its address.
    pub fn print_str_call(&mut self, module: OpId, symbol: &str, bytes: &[u8], runtime: &str, counter: &core::cell::Cell<u32>) -> Option<()> {
        let mut data: Vec<u8> = bytes.to_vec();
        data.push(0);
        let n = data.len();
        let arr = LlvmType::array(n as u64, Type::int(8));
        let tensor = Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(vec![Dim::Static(n as i64)]), elem: Type::int(8).into(), extras: Vec::new() });
        let value = crate::Const { ty: tensor, values: data.iter().map(|b| crate::Scalar::Int(crate::ApInt::new(8, *b as i8 as i128))).collect(), elements: true };
        let name = self.unique_symbol(module, symbol, counter);
        let saved = self.rw.ip;
        let block = self.rw.body.top_block(module);
        self.rw.set_start(block);
        let loc = saved.and_then(|ip| ip.before).and_then(|o| self.rw.body[o].loc.clone());
        let g = OpData { loc, ..OpData::build("llvm.mlir.global").flag("constant").with("global_type", Attribute::Type(arr.clone())).with("linkage", Attribute::dialect("llvm.linkage", "<private>")).with("sym_name", Attribute::string(&name)).with("value", value.into()) };
        self.rw.create_with(g, &[], |b, g| {
            b.add_region(g);
        });
        self.rw.ip = saved;
        let addr = self.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(name)])), LlvmType::ptr());
        let gep = self.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::DenseArray { ty: Type::int(32), values: vec![Cow::Borrowed("0")] }), LlvmType::ptr());
        self.llvm_func(module, runtime, vec![LlvmType::ptr()], LlvmType::void(), false)?;
        self.llvm_call(runtime, &[gep], &[]);
        Some(())
    }
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
