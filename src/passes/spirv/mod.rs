//! `spirv` passes.

mod spirv_canonicalize_gl;
pub use spirv_canonicalize_gl::*;

mod decorate_spirv_composite_type_layout;
pub use decorate_spirv_composite_type_layout::*;

mod spirv_rewrite_inserts;
pub use spirv_rewrite_inserts::*;

mod spirv_promote_to_replicated_constants;
pub use spirv_promote_to_replicated_constants::*;

mod spirv_webgpu_prepare;
pub use spirv_webgpu_prepare::*;

mod spirv_attach_target;
pub use spirv_attach_target::*;

mod spirv_lower_abi_attrs;
pub use spirv_lower_abi_attrs::*;

mod spirv_update_vce;
pub use spirv_update_vce::*;

mod spirv_unify_aliased_resource;
pub use spirv_unify_aliased_resource::*;

/// The `spirv` passes.
#[crate::pass_set(SpirvCanonicalizeGl, DecorateSpirvCompositeTypeLayout, SpirvRewriteInserts, SpirvPromoteToReplicatedConstants, SpirvWebgpuPrepare, SpirvAttachTarget, SpirvLowerAbiAttrs, SpirvUpdateVce, SpirvUnifyAliasedResource)]
pub struct SpirvPasses;
