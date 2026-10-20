//! The passes a pipeline can name, with the op each is anchored on (`Passes.td`'s
//! `Pass<"name", "op">`). Nothing is global: a [`PassRegistry`] is handed to whoever parses a
//! pipeline; [`Passes`] is the default one, [`Passes::upstream`] every pass this crate has.

use alloc::boxed::Box;
use alloc::collections::BTreeMap;

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

/// ⭐ What a pipeline can name.
pub trait PassRegistry {
    /// The pass named `name`, if registered.
    fn pass(&self, name: &str) -> Option<&PassInfo>;
}

/// The default [`PassRegistry`]: passes by name.
#[derive(Default)]
pub struct Passes {
    by_name: BTreeMap<&'static str, PassInfo>,
}

impl Passes {
    /// Knows no pass.
    pub fn new() -> Self {
        Self::default()
    }

    /// Registers pass `T` under its `#[pass]` name and anchor.
    pub fn register<T>(&mut self) -> &mut Self
    where
        T: PassDecl + Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static,
    {
        fn make<T: Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static>(o: &Options<'_>) -> Result<Box<dyn Pass>, Error> {
            Ok(Box::new(T::try_from(o)?))
        }
        self.by_name.insert(T::NAME, PassInfo { name: T::NAME, anchor: T::ANCHOR, make: make::<T> });
        self
    }

    /// Every pass this crate implements.
    pub fn upstream() -> Self {
        let mut p = Self::new();
        p.register::<ConvertArithToLlvm>();
        p.register::<ConvertCfToLlvm>();
        p.register::<FinalizeMemrefToLlvm>();
        p.register::<ConvertVectorToLlvm>();
        p.register::<ConvertVectorToScf>();
        p.register::<ConvertFuncToLlvm>();
        p.register::<ConvertIndexToLlvm>();
        p.register::<ConvertMathToLlvm>();
        p.register::<ConvertUbToLlvm>();
        p.register::<ConvertToLlvm>();
        p.register::<TosaToTensorPass>();
        p.register::<TosaToArithPass>();
        p.register::<TosaToLinalgNamedPass>();
        p.register::<TosaToLinalgPass>();
        p.register::<ConvertComplexToStandard>();
        p.register::<ConvertShapeToStd>();
        p.register::<ConvertScfToCf>();
        p.register::<ConvertComplexToLlvm>();
        p.register::<ConvertArithToEmitc>();
        p.register::<ConvertToEmitc>();
        p.register::<ConvertMemrefToEmitc>();
        p.register::<ConvertScfToEmitc>();
        p.register::<ConvertMathToEmitc>();
        p.register::<ConvertFuncToEmitc>();
        p.register::<ReconcileUnrealizedCasts>();
        p.register::<SetLlvmModuleDataLayout>();
        p.register::<Canonicalize>();
        p.register::<Cse>();
        p.register::<ExpandStridedMetadata>();
        p.register::<LowerAffine>();
        p.register::<LoopInvariantCodeMotion>();
        p.register::<PromoteBuffersToStack>();
        p.register::<RequestCWrappers>();
        p.register::<StripDebugInfo>();
        p.register::<SymbolDce>();
        p.register::<Sccp>();
        p.register::<BufferResultsToOutParams>();
        p.register::<ConvertMathToFuncs>();
        p.register::<RemoveDeadValues>();
        p.register::<SymbolPrivatize>();
        p
    }
}

impl PassRegistry for Passes {
    fn pass(&self, name: &str) -> Option<&PassInfo> {
        self.by_name.get(name)
    }
}
