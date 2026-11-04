//! `llvm` passes.

mod llvm_request_c_wrappers;
pub use llvm_request_c_wrappers::*;

mod convert_to_llvm;
pub use convert_to_llvm::*;

mod set_llvm_module_datalayout;
pub use set_llvm_module_datalayout::*;

/// The `llvm` passes.
#[crate::pass_set(ConvertToLlvm, RequestCWrappers, SetLlvmModuleDataLayout)]
pub struct LlvmPasses;
