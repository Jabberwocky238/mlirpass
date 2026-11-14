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
pub(crate) use transforms::{insertion_chain, is_composite, splat};
pub(crate) use abi::Abi;
pub use serialize::SpirvBinary;
pub use target::{Needs, TargetEnv};
pub use types::{SpirvOptions, SpirvTypes, explicit_layout};

pub struct Avail<'t> {
    pub min: Option<u8>,
    pub max: Option<u8>,
    pub exts: &'t [&'t [&'t str]],
    pub caps: &'t [&'t [&'t str]],
}

pub struct Case<'t> {
    pub name: &'t str,
    pub value: u32,
    pub avail: Avail<'t>,
    pub implies: &'t [&'t str],
}

pub struct EnumSpec<'t> {
    pub class: &'t str,
    pub bits: bool,
    pub cases: &'t [Case<'t>],
}

impl EnumSpec<'_> {
    pub fn of(class: &str) -> Option<&EnumSpec<'_>> {
        tables::ENUMS.iter().find(|e| e.class == class)
    }

    pub fn value(&self, name: &str) -> Option<u32> {
        let case = |n: &str| self.case(n).map(|c| c.value);
        if self.bits {
            name.split('|').try_fold(0, |acc, n| Some(acc | case(n)?))
        } else {
            case(name)
        }
    }

    pub fn case(&self, name: &str) -> Option<&Case<'_>> {
        self.cases.iter().find(|c| c.name == name.trim())
    }

    pub fn cases_of(&self, value: u32) -> Vec<&Case<'_>> {
        if self.bits {
            (0..32).filter(|b| value & (1 << b) != 0).filter_map(|b| self.cases.iter().find(|c| c.value == 1 << b)).collect()
        } else {
            self.cases.iter().filter(|c| c.value == value).take(1).collect()
        }
    }

    pub fn opcode(name: &str) -> u32 {
        Self::of("Opcode").and_then(|e| e.value(name)).unwrap_or_else(|| panic!("no opcode {name}"))
    }

    pub fn attr_value(a: &Attribute<'_>) -> Option<u32> {
        let Attribute::Extended { ext, .. } = a else { return None };
        let mnemonic = ext.name.strip_prefix("spirv.")?;
        let class = tables::ENUM_ATTRS.iter().find(|(m, _)| *m == mnemonic)?.1;
        let body = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?;
        Self::of(class)?.value(body)
    }
}

pub enum Code<'t> {
    Op(u32),
    Ext(&'t str, u32),
    None,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Group {
    One,
    Optional,
    Variadic,
}

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum AttrKind {
    ConstId,
    Enum,
    I32Array,
    I32,
    Type,
}

pub enum Arg<'t> {
    Operands(u8),
    Attr(&'t str, Option<AttrKind>, Option<&'t str>),
}

pub struct OpSpec<'t> {
    pub name: &'t str,
    pub code: Code<'t>,
    pub autogen: bool,
    pub plain: bool,
    pub results: u8,
    pub groups: &'t [Group],
    pub args: &'t [Arg<'t>],
    pub avail: Avail<'t>,
    pub unsigned: bool,
}

impl OpSpec<'_> {
    pub fn of(name: &str) -> Option<&OpSpec<'_>> {
        tables::OPS.binary_search_by(|o| o.name.cmp(name)).ok().map(|i| &tables::OPS[i])
    }
}

impl TargetEnv {
    pub fn conversion_target(&self) -> crate::ConversionTarget<'_> {
        let mut t = crate::ConversionTarget::default();
        t.dialect("spirv", crate::Action::Dynamic(alloc::boxed::Box::new(move |b: &crate::Body<'_>, op| Some(self.op_legal(b, op)))));
        t
    }
}
