mod abi;
mod glsl;
mod lower;
mod serialize;
mod target;
mod transforms;
mod types;

pub use abi::VulkanLayout;
pub use glsl::SpirvGlsl;
pub use lower::ClientApi;
pub(crate) use lower::symbol_text as spirv_symbol_text;
pub(crate) use transforms::{insertion_chain, is_composite, splat};
pub(crate) use abi::Abi;
pub use mlirbinary::{Arg, AttrKind, Avail, Case, Code, EnumSpec, Group, OpSpec};
pub use serialize::SpirvBinary;
pub use target::{Needs, TargetEnv};
pub use types::{SpirvOptions, SpirvTypes, explicit_layout};

impl TargetEnv {
    pub fn conversion_target(&self) -> crate::ConversionTarget<'_> {
        let mut t = crate::ConversionTarget::default();
        t.dialect("spirv", crate::Action::Dynamic(alloc::boxed::Box::new(move |b: &crate::Body<'_>, op| Some(self.op_legal(b, op)))));
        t
    }
}
