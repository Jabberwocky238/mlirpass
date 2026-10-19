//! ⭐ Lowerings, as `mlir/lib/Conversion`: one file per source dialect and target.

mod arith_to_llvm;

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, NamedAttr, Shaped, ShapedKind, Type};

use crate::canon::AttrExt;
use crate::{Action, ConversionRewriter, ConversionTarget, LlvmType, OpData, OpId, TypeConverter, ValueId};

pub use arith_to_llvm::ArithToLlvm;

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
        Ok(Self { options: LlvmOptions { index_bitwidth: if bits == 0 { 64 } else { bits }, ..LlvmOptions::default() } })
    }
}

impl Pass for ConvertArithToLlvm {
    fn name(&self) -> &str {
        "convert-arith-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(self.options);
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToLlvm::populate(&mut patterns, i);
        let target = llvm_target();
        Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
    }
}

/// `convert-to-llvm`: every dialect's `ConvertToLLVMPatternInterface` patterns (or those of
/// `filter-dialects`), against a target where the llvm dialect is legal.
pub struct ConvertToLlvm {
    filter: Vec<String>,
    rollback: bool,
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
        Ok(Self { filter, rollback: o.flag("allow-pattern-rollback", true)? })
    }
}

/// The dialects that implement `ConvertToLLVMPatternInterface`, by namespace.
const TO_LLVM: &[&str] = &["arith"];

impl Pass for ConvertToLlvm {
    fn name(&self) -> &str {
        "convert-to-llvm"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let tc = LlvmConverter::build(LlvmOptions::default());
        let mut patterns = ConversionPatterns::default();
        let i = patterns.converter(&tc);
        let dialects: Vec<&str> = if self.filter.is_empty() { TO_LLVM.to_vec() } else { self.filter.iter().map(String::as_str).collect() };
        for d in dialects {
            match d {
                "arith" => ArithToLlvm::populate(&mut patterns, i),
                d if TO_LLVM.contains(&d) => {}
                d => return Err(Error(format!("dialect does not implement ConvertToLLVMPatternInterface: {d}"))),
            }
        }
        let mut target = ConversionTarget::default();
        target.legal_dialect("llvm");
        Converter::new(&target, &patterns, ConversionConfig { rollback: self.rollback, ..ConversionConfig::default() }).apply(body, &[op], Mode::Partial)
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
