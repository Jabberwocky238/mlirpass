//! ⭐ SPIR-V out of MLIR (`mlir/lib/Target/SPIRV`): the binary serializer, on tables generated
//! from the dialect's ODS (`scripts/spirv_tables.py`), and GLSL source.

mod abi;
mod arith_to_spirv;
mod cf_to_spirv;
mod complex_to_spirv;
mod func_to_spirv;
mod glsl;
mod gpu_to_spirv;
mod index_to_spirv;
mod lower;
mod math_to_spirv;
mod memref_to_spirv;
mod scf_to_spirv;
mod serialize;
mod target;
mod transforms;
mod tensor_to_spirv;
mod types;
mod ub_to_spirv;
mod unify_aliased;
mod vector_to_spirv;
mod wmma_to_spirv;
#[path = "spirv/tables.gen.rs"]
mod tables;

use alloc::vec::Vec;

use mlirformat::Attribute;

pub use abi::{SpirvLowerAbiAttrs, SpirvUpdateVce, VulkanLayout};
pub use transforms::{DecorateSpirvCompositeTypeLayout, SpirvCanonicalizeGl, SpirvPromoteToReplicatedConstants, SpirvRewriteInserts, SpirvWebgpuPrepare};
pub use arith_to_spirv::{ArithSpirvOptions, ArithToSpirv};
pub use cf_to_spirv::CfToSpirv;
pub use complex_to_spirv::ComplexToSpirv;
pub use func_to_spirv::FuncToSpirv;
pub use glsl::SpirvGlsl;
pub use gpu_to_spirv::{ConvertGpuToSpirv, GpuSpirvOptions, GpuToSpirv};
pub use index_to_spirv::IndexToSpirv;
pub use lower::ClientApi;
pub use math_to_spirv::MathToSpirv;
pub use memref_to_spirv::{MemrefSpirvOptions, MemrefToSpirv};
pub use scf_to_spirv::ScfToSpirv;
pub use serialize::SpirvBinary;
pub use target::{Needs, TargetEnv};
pub use tensor_to_spirv::TensorToSpirv;
pub use ub_to_spirv::UbToSpirv;
pub use unify_aliased::SpirvUnifyAliasedResource;
pub use vector_to_spirv::{VectorSpirvOptions, VectorToSpirv};
pub use wmma_to_spirv::WmmaToSpirv;
pub use types::{SpirvOptions, SpirvTypes, explicit_layout};

/// What an op or an enum case needs of the target (`SPIRVAvailability.td`): versions (the
/// minor of `1.x`), and extensions and capabilities as a conjunction of disjunctions.
pub struct Avail<'t> {
    pub min: Option<u8>,
    pub max: Option<u8>,
    pub exts: &'t [&'t [&'t str]],
    pub caps: &'t [&'t [&'t str]],
}

/// One case of a SPIR-V enum.
pub struct Case<'t> {
    pub name: &'t str,
    pub value: u32,
    pub avail: Avail<'t>,
    /// `Capability` cases: the capabilities this one implies.
    pub implies: &'t [&'t str],
}

/// One SPIR-V enum: its cases and values (`SPIRVBase.td`).
pub struct EnumSpec<'t> {
    pub class: &'t str,
    /// A bit enum: `A|B` is the union.
    pub bits: bool,
    pub cases: &'t [Case<'t>],
}

impl EnumSpec<'_> {
    /// The enum named `class` (`StorageClass`, `Decoration`, `Opcode`, ...).
    pub fn of(class: &str) -> Option<&EnumSpec<'_>> {
        tables::ENUMS.iter().find(|e| e.class == class)
    }

    /// The value of case `name` (`symbolize*`); a bit enum's `A|B` ors its cases.
    pub fn value(&self, name: &str) -> Option<u32> {
        let case = |n: &str| self.case(n).map(|c| c.value);
        if self.bits {
            name.split('|').try_fold(0, |acc, n| Some(acc | case(n)?))
        } else {
            case(name)
        }
    }

    /// Case `name`.
    pub fn case(&self, name: &str) -> Option<&Case<'_>> {
        self.cases.iter().find(|c| c.name == name.trim())
    }

    /// The cases a value holds: itself, or (a bit enum) each set bit.
    pub fn cases_of(&self, value: u32) -> Vec<&Case<'_>> {
        if self.bits {
            (0..32).filter(|b| value & (1 << b) != 0).filter_map(|b| self.cases.iter().find(|c| c.value == 1 << b)).collect()
        } else {
            self.cases.iter().filter(|c| c.value == value).take(1).collect()
        }
    }

    /// `Opcode`'s value of `OpFoo`.
    pub fn opcode(name: &str) -> u32 {
        Self::of("Opcode").and_then(|e| e.value(name)).unwrap_or_else(|| panic!("no opcode {name}"))
    }

    /// The value an enum attribute `#spirv.<mnemonic><Case>` holds.
    pub fn attr_value(a: &Attribute<'_>) -> Option<u32> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let mnemonic = ext.name.strip_prefix("spirv.")?;
        let class = tables::ENUM_ATTRS.iter().find(|(m, _)| *m == mnemonic)?.1;
        let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?;
        Self::of(class)?.value(body)
    }
}

/// What an instruction is: a core opcode, or an extended instruction of a set.
pub enum Code<'t> {
    Op(u32),
    Ext(&'t str, u32),
    /// No instruction of its own (`spirv.mlir.loop`, `spirv.module`).
    None,
}

/// An ODS operand group.
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Group {
    One,
    Optional,
    Variadic,
}

/// How an attribute argument serializes (`emitAttributeSerialization`).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AttrKind {
    /// An enum, as the <id> of an i32 constant of its value.
    ConstId,
    /// An enum, as its value.
    Enum,
    I32Array,
    I32,
    /// A type, as its <id>.
    Type,
}

/// One ODS argument, in definition order.
pub enum Arg<'t> {
    /// ODS operand group `i`.
    Operands(u8),
    /// An attribute; `None` on the ops whose serialization is written by hand; the enum class
    /// it carries, if it is an enum.
    Attr(&'t str, Option<AttrKind>, Option<&'t str>),
}

/// One op's binary form (`SPIRVSerialization.inc`).
pub struct OpSpec<'t> {
    pub name: &'t str,
    pub code: Code<'t>,
    /// Serialized from the table (else by hand, or not at all).
    pub autogen: bool,
    /// No attribute and no variable-length operand: `processOpWithoutGrammarAttr`.
    pub plain: bool,
    pub results: u8,
    pub groups: &'t [Group],
    pub args: &'t [Arg<'t>],
    pub avail: Avail<'t>,
    /// `OpTrait::spirv::UnsignedOp`.
    pub unsigned: bool,
}

impl OpSpec<'_> {
    /// The op named `name` (`spirv.IAdd`).
    pub fn of(name: &str) -> Option<&OpSpec<'_>> {
        tables::OPS.binary_search_by(|o| o.name.cmp(name)).ok().map(|i| &tables::OPS[i])
    }
}

impl TargetEnv {
    /// `SPIRVConversionTarget`: a `spirv` op is legal when the target has what it needs.
    pub fn conversion_target(&self) -> crate::ConversionTarget<'_> {
        let mut t = crate::ConversionTarget::default();
        t.dialect("spirv", crate::Action::Dynamic(alloc::boxed::Box::new(move |b: &crate::Body<'_>, op| Some(self.op_legal(b, op)))));
        t
    }
}

/// `convert-func-to-spirv`.
#[crate::pass("convert-func-to-spirv")]
pub struct ConvertFuncToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertFuncToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        FuncToSpirv::populate(&mut patterns, i);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `convert-cf-to-spirv`.
#[crate::pass("convert-cf-to-spirv")]
pub struct ConvertCfToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertCfToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        CfToSpirv::populate(&mut patterns, i);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `convert-index-to-spirv`.
#[crate::pass("convert-index-to-spirv")]
pub struct ConvertIndexToSpirv {
    #[opt("use-64bit-index")]
    index64: bool,
}

impl crate::Run for ConvertIndexToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { index64: self.index64, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        IndexToSpirv::populate(&mut patterns, i);
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast").legal_dialect("spirv").illegal_dialect("index");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `convert-math-to-spirv`.
#[crate::pass("convert-math-to-spirv")]
pub fn convert_math_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    MathToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}

/// `convert-tensor-to-spirv`.
#[crate::pass("convert-tensor-to-spirv")]
pub struct ConvertTensorToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertTensorToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: self.emulate_floats });
        FuncToSpirv::populate(&mut patterns, i);
        TensorToSpirv::populate(&mut patterns, i, 64);
        let target = env.conversion_target();
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `convert-complex-to-spirv`.
#[crate::pass("convert-complex-to-spirv")]
pub fn convert_complex_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ComplexToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}

/// `convert-arith-to-spirv`.
#[crate::pass("convert-arith-to-spirv")]
pub struct ConvertArithToSpirv {
    #[opt("emulate-lt-32-bit-scalar-types", default = true)]
    emulate_lt32: bool,
    #[opt("emulate-unsupported-float-types", default = true)]
    emulate_floats: bool,
}

impl crate::Run for ConvertArithToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { emulate_lt32: self.emulate_lt32, emulate_unsupported_floats: self.emulate_floats, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: self.emulate_floats });
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast").illegal_dialect("arith");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `convert-memref-to-spirv`.
#[crate::pass("convert-memref-to-spirv")]
pub struct ConvertMemrefToSpirv {
    #[opt("bool-num-bits", default = 8)]
    bool_bits: u32,
    #[opt("use-64bit-index")]
    index64: bool,
}

impl crate::Run for ConvertMemrefToSpirv {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let env = TargetEnv::lookup(body, op);
        let types = SpirvTypes { env: &env, opts: SpirvOptions { bool_bits: self.bool_bits, index64: self.index64, ..SpirvOptions::default() } };
        let tc = types.converter();
        let mut patterns = crate::ConversionPatterns::default();
        let i = patterns.converter(&tc);
        MemrefToSpirv::populate(&mut patterns, i, MemrefSpirvOptions { index64: self.index64, kernel: env.allows_cap("Kernel"), bool_bits: self.bool_bits });
        let mut target = env.conversion_target();
        target.legal_op("builtin.unrealized_conversion_cast");
        crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
    }
}

/// `map-memref-spirv-storage-class`.
#[crate::pass("map-memref-spirv-storage-class")]
pub struct MapMemrefSpirvStorageClass {
    #[opt("client-api", default = alloc::string::String::from("vulkan"))]
    client_api: alloc::string::String,
}

impl crate::Run for MapMemrefSpirvStorageClass {
    fn run<'a>(&self, body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
        let mut api = match &*self.client_api {
            "vulkan" => ClientApi::Vulkan,
            "opencl" => ClientApi::OpenCl,
            a => return Err(mlirformat::Error(alloc::format!("Invalid clienAPI: {a}"))),
        };
        // `lookupTargetEnv`: a target, when there is one, decides.
        let mut at = Some(op);
        while let Some(o) = at {
            if body.is_symbol_table(o)
                && let Some(t) = body[o].get("spirv.target_env").and_then(|a| TargetEnv::parse(&alloc::format!("{a}")))
            {
                if t.allows_cap("Kernel") {
                    api = ClientApi::OpenCl;
                } else if t.allows_cap("Shader") {
                    api = ClientApi::Vulkan;
                }
                break;
            }
            at = body.parent_op(o);
        }
        match api.map_memory_spaces(body, op).first() {
            Some(bad) => Err(mlirformat::Error(alloc::format!("'{}' op failed to legalize memory space", body[*bad].name))),
            None => Ok(()),
        }
    }
}

/// `convert-scf-to-spirv`.
#[crate::pass("convert-scf-to-spirv")]
pub fn convert_scf_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    ScfToSpirv::populate(&mut patterns, i);
    ArithToSpirv::populate(&mut patterns, i, ArithSpirvOptions { no_wrap: env.allows_ext("SPV_KHR_no_integer_wrap_decoration"), emulate_floats: true });
    FuncToSpirv::populate(&mut patterns, i);
    MemrefToSpirv::populate(&mut patterns, i, MemrefSpirvOptions { index64: false, kernel: env.allows_cap("Kernel"), bool_bits: 8 });
    IndexToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}

/// `convert-vector-to-spirv`.
#[crate::pass("convert-vector-to-spirv")]
pub fn convert_vector_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    VectorToSpirv::populate(&mut patterns, i, VectorSpirvOptions { index64: false, kernel: env.allows_cap("Kernel") });
    UbToSpirv::populate(&mut patterns, i);
    let mut target = env.conversion_target();
    target.legal_op("builtin.unrealized_conversion_cast");
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}

/// `convert-ub-to-spirv`.
#[crate::pass("convert-ub-to-spirv")]
pub fn convert_ub_to_spirv<'a>(body: &mut crate::Body<'a>, op: crate::OpId) -> Result<(), mlirformat::Error> {
    let env = TargetEnv::lookup(body, op);
    let types = SpirvTypes { env: &env, opts: SpirvOptions::default() };
    let tc = types.converter();
    let mut patterns = crate::ConversionPatterns::default();
    let i = patterns.converter(&tc);
    UbToSpirv::populate(&mut patterns, i);
    let target = env.conversion_target();
    crate::Converter::new(&target, &patterns, crate::ConversionConfig::default()).apply(body, &[op], crate::Mode::Partial)
}

crate::pass_set! {
    /// Every lowering to `spirv`.
    SpirvPasses: SpirvWebgpuPrepare, SpirvUnifyAliasedResource, SpirvPromoteToReplicatedConstants, SpirvRewriteInserts, DecorateSpirvCompositeTypeLayout, SpirvCanonicalizeGl, ConvertCfToSpirv, ConvertComplexToSpirv, ConvertIndexToSpirv, ConvertMathToSpirv, ConvertTensorToSpirv, ConvertVectorToSpirv, ConvertUbToSpirv, SpirvLowerAbiAttrs, SpirvUpdateVce, ConvertScfToSpirv, ConvertArithToSpirv, ConvertFuncToSpirv, ConvertGpuToSpirv, ConvertMemrefToSpirv, MapMemrefSpirvStorageClass
}
