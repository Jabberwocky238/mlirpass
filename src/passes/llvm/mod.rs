//! `llvm` passes.

use crate::{ConvertArithToLlvm, ConvertCfToLlvm, ConvertComplexToLlvm, ConvertFuncToLlvm, ConvertIndexToLlvm, ConvertMathToLlvm, ConvertUbToLlvm, ConvertVectorToLlvm, FinalizeMemrefToLlvm};
mod llvm_request_c_wrappers;
pub use llvm_request_c_wrappers::*;

mod convert_to_llvm;
pub use convert_to_llvm::*;

mod set_llvm_module_datalayout;
pub use set_llvm_module_datalayout::*;

/// Every lowering to `llvm`.
#[crate::pass_set(ConvertArithToLlvm, ConvertCfToLlvm, ConvertComplexToLlvm, ConvertFuncToLlvm, ConvertIndexToLlvm, ConvertMathToLlvm, ConvertToLlvm, ConvertUbToLlvm, ConvertVectorToLlvm, FinalizeMemrefToLlvm, RequestCWrappers, SetLlvmModuleDataLayout)]
pub struct LlvmPasses;
