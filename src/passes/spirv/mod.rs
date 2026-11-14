#[cfg(feature = "target.spirv")]
mod spirv_canonicalize_gl;
#[cfg(feature = "target.spirv")]
pub use spirv_canonicalize_gl::*;

#[cfg(feature = "target.spirv")]
mod decorate_spirv_composite_type_layout;
#[cfg(feature = "target.spirv")]
pub use decorate_spirv_composite_type_layout::*;

#[cfg(feature = "target.spirv")]
mod spirv_rewrite_inserts;
#[cfg(feature = "target.spirv")]
pub use spirv_rewrite_inserts::*;

#[cfg(feature = "target.spirv")]
mod spirv_promote_to_replicated_constants;
#[cfg(feature = "target.spirv")]
pub use spirv_promote_to_replicated_constants::*;

#[cfg(feature = "target.spirv")]
mod spirv_webgpu_prepare;
#[cfg(feature = "target.spirv")]
pub use spirv_webgpu_prepare::*;

#[cfg(feature = "target.spirv")]
mod spirv_attach_target;
#[cfg(feature = "target.spirv")]
pub use spirv_attach_target::*;

#[cfg(feature = "target.spirv")]
mod spirv_lower_abi_attrs;
#[cfg(feature = "target.spirv")]
pub use spirv_lower_abi_attrs::*;

#[cfg(feature = "target.spirv")]
mod spirv_update_vce;
#[cfg(feature = "target.spirv")]
pub use spirv_update_vce::*;

#[cfg(feature = "target.spirv")]
mod spirv_unify_aliased_resource;
#[cfg(feature = "target.spirv")]
pub use spirv_unify_aliased_resource::*;

#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
mod convert_spirv_entry_points;
#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
pub use convert_spirv_entry_points::*;
