//! Every pass `mlir-opt` can name, with the op it is anchored on (`Passes.td`'s `Pass<"name", "op">`).

use alloc::boxed::Box;

use mlirformat::Error;

use super::{Options, Pass};
use crate::lower::*;
use crate::transforms::*;

/// A registered pass.
pub struct PassInfo {
    pub name: &'static str,
    /// The op it runs on; `None`: any op.
    pub anchor: Option<&'static str>,
    pub make: fn(&Options<'_>) -> Result<Box<dyn Pass>, Error>,
}

impl PassInfo {
    pub fn find(name: &str) -> Option<&'static PassInfo> {
        PASSES.iter().find(|p| p.name == name)
    }
}

macro_rules! registry {
    (@anchor) => { None };
    (@anchor $on:literal) => { Some($on) };
    ($($name:literal $(on $on:literal)? => $ty:ty,)*) => {
        /// The registry, by `mlir-opt` argument.
        pub const PASSES: &[PassInfo] = &[$(PassInfo {
            name: $name,
            anchor: registry!(@anchor $($on)?),
            make: |o| Ok(Box::new(<$ty>::try_from(o)?)),
        },)*];
    };
}

registry! {
    "convert-arith-to-llvm" => ConvertArithToLlvm,
    "convert-cf-to-llvm" => ConvertCfToLlvm,
    "finalize-memref-to-llvm" => FinalizeMemrefToLlvm,
    "convert-vector-to-llvm" => ConvertVectorToLlvm,
    "convert-vector-to-scf" => ConvertVectorToScf,
    "convert-func-to-llvm" on "builtin.module" => ConvertFuncToLlvm,
    "convert-index-to-llvm" => ConvertIndexToLlvm,
    "convert-math-to-llvm" => ConvertMathToLlvm,
    "convert-ub-to-llvm" => ConvertUbToLlvm,
    "convert-to-llvm" => ConvertToLlvm,
    "tosa-to-tensor" => TosaToTensorPass,
    "tosa-to-arith" => TosaToArithPass,
    "convert-complex-to-standard" => ConvertComplexToStandard,
    "convert-arith-to-emitc" => ConvertArithToEmitc,
    "convert-to-emitc" => ConvertToEmitc,
    "convert-memref-to-emitc" on "builtin.module" => ConvertMemrefToEmitc,
    "convert-scf-to-emitc" => ConvertScfToEmitc,
    "convert-math-to-emitc" => ConvertMathToEmitc,
    "convert-func-to-emitc" on "builtin.module" => ConvertFuncToEmitc,
    "reconcile-unrealized-casts" => ReconcileUnrealizedCasts,
    "set-llvm-module-datalayout" on "builtin.module" => SetLlvmModuleDataLayout,
    "canonicalize" => Canonicalize,
    "cse" => Cse,
    "expand-strided-metadata" => ExpandStridedMetadata,
    "lower-affine" => LowerAffine,
    "loop-invariant-code-motion" => LoopInvariantCodeMotion,
    "promote-buffers-to-stack" on "func.func" => PromoteBuffersToStack,
    "llvm-request-c-wrappers" on "func.func" => RequestCWrappers,
    "strip-debuginfo" => StripDebugInfo,
    "symbol-dce" => SymbolDce,
    "symbol-privatize" => SymbolPrivatize,
}
