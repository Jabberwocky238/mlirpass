//! Every pass `mlir-opt` can name, with the op it is anchored on (`Passes.td`'s `Pass<"name", "op">`).

use alloc::boxed::Box;

use mlirformat::Error;

use super::{Options, Pass, PassDecl};
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
    ($($ty:ty,)*) => {
        /// The registry: each pass's name and anchor come from its `#[pass]`.
        pub const PASSES: &[PassInfo] = &[$(PassInfo {
            name: <$ty as PassDecl>::NAME,
            anchor: <$ty as PassDecl>::ANCHOR,
            make: |o| Ok(Box::new(<$ty>::try_from(o)?)),
        },)*];
    };
}

registry! {
    ConvertArithToLlvm,
    ConvertCfToLlvm,
    FinalizeMemrefToLlvm,
    ConvertVectorToLlvm,
    ConvertVectorToScf,
    ConvertFuncToLlvm,
    ConvertIndexToLlvm,
    ConvertMathToLlvm,
    ConvertUbToLlvm,
    ConvertToLlvm,
    TosaToTensorPass,
    TosaToArithPass,
    TosaToLinalgNamedPass,
    TosaToLinalgPass,
    ConvertComplexToStandard,
    ConvertShapeToStd,
    ConvertScfToCf,
    ConvertComplexToLlvm,
    ConvertArithToEmitc,
    ConvertToEmitc,
    ConvertMemrefToEmitc,
    ConvertScfToEmitc,
    ConvertMathToEmitc,
    ConvertFuncToEmitc,
    ReconcileUnrealizedCasts,
    SetLlvmModuleDataLayout,
    Canonicalize,
    Cse,
    ExpandStridedMetadata,
    LowerAffine,
    LoopInvariantCodeMotion,
    PromoteBuffersToStack,
    RequestCWrappers,
    StripDebugInfo,
    SymbolDce,
    Sccp,
    RemoveDeadValues,
    SymbolPrivatize,
}
