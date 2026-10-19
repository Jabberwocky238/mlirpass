//! ⭐ Lowerings, as `mlir/lib/Conversion`: one file per source dialect and target.

mod arith_to_llvm;
mod cf_to_llvm;
mod func_to_llvm;
mod index_to_llvm;
mod math_to_llvm;
mod memref_desc;
mod memref_to_llvm;

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::canon::AttrExt;
use crate::{Action, ConversionRewriter, ConversionTarget, LlvmType, OpData, OpId, TypeConverter, ValueId};

pub use arith_to_llvm::ArithToLlvm;
pub use cf_to_llvm::{AssertLowering, CfToLlvm};
pub use func_to_llvm::FuncToLlvm;
pub use index_to_llvm::{IndexToLlvm, UbToLlvm};
pub use math_to_llvm::MathToLlvm;
pub use memref_desc::DYNAMIC;
pub use memref_to_llvm::{MemrefOptions, MemrefToLlvm};

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

use crate::{Body, ConversionConfig, ConversionPatterns, Converter, LlvmConverter, LlvmOptions, Mode, Options, Pass};

/// `convert-arith-to-llvm`.
pub struct ConvertArithToLlvm {
    options: LlvmOptions,
}

impl TryFrom<&Options<'_>> for ConvertArithToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("convert-arith-to-llvm", &["index-bitwidth"])?;
        let bits: u32 = o.value("index-bitwidth", 0)?;
        Ok(Self { options: LlvmOptions { index_bitwidth: bits, ..LlvmOptions::default() } })
    }
}

impl Pass for ConvertArithToLlvm {
    fn name(&self) -> &str {
        "convert-arith-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(self.options.at(body, op));
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
        pub struct $ty {
            options: LlvmOptions,
        }

        impl TryFrom<&Options<'_>> for $ty {
            type Error = Error;
            fn try_from(o: &Options<'_>) -> Result<Self, Error> {
                o.only($name, &["index-bitwidth"])?;
                let bits: u32 = o.value("index-bitwidth", 0)?;
                Ok(Self { options: LlvmOptions { index_bitwidth: bits, ..LlvmOptions::default() } })
            }
        }

        impl Pass for $ty {
            fn name(&self) -> &str {
                $name
            }

            fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
                let tc = LlvmConverter::build(self.options.at(body, op));
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
pub struct ConvertMathToLlvm {
    approximate_log1p: bool,
}

impl TryFrom<&Options<'_>> for ConvertMathToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("convert-math-to-llvm", &["approximate-log1p"])?;
        Ok(Self { approximate_log1p: o.flag("approximate-log1p", true)? })
    }
}

impl Pass for ConvertMathToLlvm {
    fn name(&self) -> &str {
        "convert-math-to-llvm"
    }

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
pub struct ConvertCfToLlvm {
    options: LlvmOptions,
    counter: core::cell::Cell<u32>,
}

impl TryFrom<&Options<'_>> for ConvertCfToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("convert-cf-to-llvm", &["index-bitwidth"])?;
        let bits: u32 = o.value("index-bitwidth", 0)?;
        Ok(Self { options: LlvmOptions { index_bitwidth: bits, ..LlvmOptions::default() }, counter: core::cell::Cell::new(0) })
    }
}

impl Pass for ConvertCfToLlvm {
    fn name(&self) -> &str {
        "convert-cf-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(self.options.at(body, op));
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
pub struct ConvertFuncToLlvm {
    options: LlvmOptions,
}

impl TryFrom<&Options<'_>> for ConvertFuncToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("convert-func-to-llvm", &["use-bare-ptr-memref-call-conv", "index-bitwidth"])?;
        let bits: u32 = o.value("index-bitwidth", 0)?;
        let bare_ptr = o.flag("use-bare-ptr-memref-call-conv", false)?;
        Ok(Self { options: LlvmOptions { index_bitwidth: bits, bare_ptr, ..LlvmOptions::default() } })
    }
}

impl Pass for ConvertFuncToLlvm {
    fn name(&self) -> &str {
        "convert-func-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(self.options.at(body, op));
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToLlvm::populate(&mut patterns, i, self.options.at(body, op));
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `finalize-memref-to-llvm`.
pub struct FinalizeMemrefToLlvm {
    options: MemrefOptions,
}

impl TryFrom<&Options<'_>> for FinalizeMemrefToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("finalize-memref-to-llvm", &["use-aligned-alloc", "index-bitwidth", "use-generic-functions"])?;
        let bits: u32 = o.value("index-bitwidth", 0)?;
        let llvm = LlvmOptions { index_bitwidth: bits, ..LlvmOptions::default() };
        Ok(Self { options: MemrefOptions { llvm, aligned_alloc: o.flag("use-aligned-alloc", false)?, generic: o.flag("use-generic-functions", false)? } })
    }
}

impl Pass for FinalizeMemrefToLlvm {
    fn name(&self) -> &str {
        "finalize-memref-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let options = MemrefOptions { llvm: self.options.llvm.at(body, op), ..self.options };
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
pub struct ConvertToLlvm {
    filter: Vec<String>,
    rollback: bool,
    counter: core::cell::Cell<u32>,
}

impl TryFrom<&Options<'_>> for ConvertToLlvm {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("convert-to-llvm", &["filter-dialects", "dynamic", "allow-pattern-rollback"])?;
        let filter: Vec<String> = o.list("filter-dialects").into_iter().map(String::from).collect();
        // A dialect whose lowering is not ported yet makes the pass unsupported, not wrong.
        if let Some(d) = filter.iter().find(|d| !TO_LLVM.contains(&d.as_str())) {
            return Err(Error(format!("convert-to-llvm: the {d} lowering is not ported")));
        }
        Ok(Self { filter, rollback: o.flag("allow-pattern-rollback", true)?, counter: core::cell::Cell::new(0) })
    }
}

/// The dialects that implement `ConvertToLLVMPatternInterface`, by namespace.
const TO_LLVM: &[&str] = &["arith", "cf", "func", "index", "math", "memref", "ub"];

impl Pass for ConvertToLlvm {
    fn name(&self) -> &str {
        "convert-to-llvm"
    }

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
                "func" => FuncToLlvm::populate(&mut patterns, i, LlvmOptions::derived().at(body, op)),
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
pub struct SetLlvmModuleDataLayout {
    layout: String,
}

impl TryFrom<&Options<'_>> for SetLlvmModuleDataLayout {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("set-llvm-module-datalayout", &["data-layout"])?;
        Ok(Self { layout: o.value("data-layout", String::new())? })
    }
}

impl Pass for SetLlvmModuleDataLayout {
    fn name(&self) -> &str {
        "set-llvm-module-datalayout"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        body[op].set("llvm.data_layout", Attribute::string(&self.layout));
        Ok(())
    }
}

/// `reconcile-unrealized-casts`.
pub struct ReconcileUnrealizedCasts;

impl TryFrom<&Options<'_>> for ReconcileUnrealizedCasts {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("reconcile-unrealized-casts", &[])?;
        Ok(Self)
    }
}

impl Pass for ReconcileUnrealizedCasts {
    fn name(&self) -> &str {
        "reconcile-unrealized-casts"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let casts: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "builtin.unrealized_conversion_cast").collect();
        body.reconcile_casts(&casts);
        Ok(())
    }
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
