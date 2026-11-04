//! ⭐ SPIR-V out of MLIR (`mlir/lib/Target/SPIRV`): the binary serializer, on tables generated
//! from the dialect's ODS (`scripts/spirv_tables.py`), and GLSL source.

mod abi;
mod glsl;
mod lower;
mod serialize;
mod target;
mod transforms;
mod types;
#[path = "spirv/tables.gen.rs"]
mod tables;

use alloc::vec::Vec;

use mlirformat::Attribute;

pub use abi::VulkanLayout;
pub use glsl::SpirvGlsl;
pub use lower::ClientApi;
pub(crate) use lower::symbol_text as spirv_symbol_text;
pub(crate) use transforms::{Regex, insertion_chain, is_composite, splat};
pub(crate) use abi::Abi;
pub use serialize::SpirvBinary;
pub use target::{Needs, TargetEnv};
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
