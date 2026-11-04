//! `ConvertToLLVMPatternInterface`: what each dialect adds to `convert-to-llvm`.

use alloc::vec::Vec;
use core::sync::atomic::AtomicU32;

use crate::{ConversionPatterns, ConversionTarget, DialectInterfaces, LlvmOptions};
#[cfg(feature = "dialect.arith")]
use crate::ArithToLlvm;
#[cfg(feature = "dialect.cf")]
use crate::{AssertLowering, CfToLlvm};
#[cfg(feature = "dialect.complex")]
use crate::ComplexToLlvm;
#[cfg(feature = "dialect.func")]
use crate::FuncToLlvm;
#[cfg(feature = "dialect.index")]
use crate::IndexToLlvm;
#[cfg(feature = "dialect.math")]
use crate::MathToLlvm;
#[cfg(feature = "dialect.memref")]
use crate::{MemrefOptions, MemrefToLlvm};
#[cfg(feature = "dialect.ub")]
use crate::UbToLlvm;
#[cfg(feature = "dialect.vector")]
use crate::{VectorOptions, VectorToLlvm};
#[cfg(feature = "dialect.nvvm")]
use crate::NvvmToLlvm;
#[cfg(feature = "dialect.xevm")]
use crate::XevmToLlvm;

/// What `convert-to-llvm` builds its patterns with.
pub struct LlvmEnv<'p> {
    pub llvm: LlvmOptions,
    /// Unique names for the globals the lowerings create.
    pub counter: &'p AtomicU32,
}

type ToLlvmFn = for<'p> fn(&mut ConversionPatterns<'p>, usize, &LlvmEnv<'p>);

/// What a dialect's interface marks legal or illegal in the target (`populateConvertToLLVMConversionPatterns`'
/// target argument), after the llvm dialect is made legal.
type ToLlvmTargetFn = fn(&mut ConversionTarget<'_>);

/// The `ConvertToLLVMPatternInterface`s; [`Default`]: the upstream dialects this crate lowers.
pub struct ToLlvmInterfaces {
    by_dialect: Vec<(&'static str, ToLlvmFn)>,
    targets: Vec<(&'static str, ToLlvmTargetFn)>,
}

impl ToLlvmInterfaces {
    pub fn new() -> Self {
        Self { by_dialect: Vec::new(), targets: Vec::new() }
    }

    /// Dialect `ns`'s legality in the target too.
    pub fn register_target(&mut self, ns: &'static str, f: ToLlvmTargetFn) -> &mut Self {
        self.targets.push((ns, f));
        self
    }

    /// What dialect `ns` makes of the target.
    pub fn target(&self, ns: &str, target: &mut ConversionTarget<'_>) {
        for (_, f) in self.targets.iter().filter(|(n, _)| *n == ns) {
            f(target);
        }
    }

    pub fn register(&mut self, ns: &'static str, f: ToLlvmFn) -> &mut Self {
        self.by_dialect.push((ns, f));
        self
    }
}

impl Default for ToLlvmInterfaces {
    fn default() -> Self {
        #[cfg(feature = "dialect.arith")]
        fn arith<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            ArithToLlvm::populate(p, i);
        }
        #[cfg(feature = "dialect.cf")]
        fn cf<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            CfToLlvm::populate(p, i);
            p.add_with(i, AssertLowering(e.counter));
        }
        #[cfg(feature = "dialect.complex")]
        fn complex<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            ComplexToLlvm::populate(p, i, false);
        }
        #[cfg(feature = "dialect.func")]
        fn func<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            FuncToLlvm::populate(p, i, e.llvm);
        }
        #[cfg(feature = "dialect.index")]
        fn index<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            IndexToLlvm::populate(p, i);
        }
        #[cfg(feature = "dialect.math")]
        fn math<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            MathToLlvm::populate(p, i, true);
        }
        #[cfg(feature = "dialect.memref")]
        fn memref<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            MemrefToLlvm::populate(p, i, MemrefOptions { llvm: e.llvm, aligned_alloc: false, generic: false });
        }
        #[cfg(feature = "dialect.ub")]
        fn ub<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            UbToLlvm::populate(p, i);
        }
        #[cfg(feature = "dialect.vector")]
        fn vector<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            VectorToLlvm::populate(p, i, VectorOptions { llvm: e.llvm, reassociate_fp_reductions: false, force_32bit_indices: true, use_vector_alignment: false, counter: e.counter });
        }
        #[cfg(feature = "dialect.nvvm")]
        fn nvvm<'p>(p: &mut ConversionPatterns<'p>, _: usize, _: &LlvmEnv<'p>) {
            NvvmToLlvm::populate(p);
        }
        #[cfg(feature = "dialect.xevm")]
        fn xevm<'p>(p: &mut ConversionPatterns<'p>, _: usize, _: &LlvmEnv<'p>) {
            XevmToLlvm::populate(p);
        }
        // (none without a dialect feature)
        #[allow(unused_mut)]
        let mut s = Self::new();
        #[cfg(feature = "dialect.arith")]
        s.register("arith", arith);
        #[cfg(feature = "dialect.cf")]
        s.register("cf", cf);
        #[cfg(feature = "dialect.complex")]
        s.register("complex", complex);
        #[cfg(feature = "dialect.func")]
        s.register("func", func);
        #[cfg(feature = "dialect.index")]
        s.register("index", index);
        #[cfg(feature = "dialect.math")]
        s.register("math", math);
        #[cfg(feature = "dialect.memref")]
        s.register("memref", memref);
        #[cfg(feature = "dialect.ub")]
        s.register("ub", ub);
        #[cfg(feature = "dialect.vector")]
        s.register("vector", vector);
        #[cfg(feature = "dialect.nvvm")]
        s.register("nvvm", nvvm);
        #[cfg(feature = "dialect.xevm")]
        s.register("xevm", xevm).register_target("xevm", XevmToLlvm::target);
        s
    }
}

impl DialectInterfaces for ToLlvmInterfaces {
    type Env<'e> = LlvmEnv<'e>;

    fn dialects(&self) -> Vec<&'static str> {
        self.by_dialect.iter().map(|(ns, _)| *ns).collect()
    }

    fn populate<'p>(&self, ns: &str, patterns: &mut ConversionPatterns<'p>, tc: usize, env: &LlvmEnv<'p>) {
        if let Some((_, f)) = self.by_dialect.iter().find(|(n, _)| *n == ns) {
            f(patterns, tc, env);
        }
    }
}
