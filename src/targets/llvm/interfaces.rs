//! `ConvertToLLVMPatternInterface`: what each dialect adds to `convert-to-llvm`.

use alloc::vec::Vec;
use core::sync::atomic::AtomicU32;

use crate::{ArithToLlvm, AssertLowering, CfToLlvm, ComplexToLlvm, ConversionPatterns, DialectInterfaces, FuncToLlvm, IndexToLlvm, LlvmOptions, MathToLlvm, MemrefOptions, MemrefToLlvm, UbToLlvm, VectorOptions, VectorToLlvm};

/// What `convert-to-llvm` builds its patterns with.
pub struct LlvmEnv<'p> {
    pub llvm: LlvmOptions,
    /// Unique names for the globals the lowerings create.
    pub counter: &'p AtomicU32,
}

type ToLlvmFn = for<'p> fn(&mut ConversionPatterns<'p>, usize, &LlvmEnv<'p>);

/// The `ConvertToLLVMPatternInterface`s; [`Default`]: the upstream dialects this crate lowers.
pub struct ToLlvmInterfaces {
    by_dialect: Vec<(&'static str, ToLlvmFn)>,
}

impl ToLlvmInterfaces {
    pub fn new() -> Self {
        Self { by_dialect: Vec::new() }
    }

    pub fn register(&mut self, ns: &'static str, f: ToLlvmFn) -> &mut Self {
        self.by_dialect.push((ns, f));
        self
    }
}

impl Default for ToLlvmInterfaces {
    fn default() -> Self {
        fn arith<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            ArithToLlvm::populate(p, i);
        }
        fn cf<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            CfToLlvm::populate(p, i);
            p.add_with(i, AssertLowering(e.counter));
        }
        fn complex<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            ComplexToLlvm::populate(p, i, false);
        }
        fn func<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            FuncToLlvm::populate(p, i, e.llvm);
        }
        fn index<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            IndexToLlvm::populate(p, i);
        }
        fn math<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            MathToLlvm::populate(p, i, true);
        }
        fn memref<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            MemrefToLlvm::populate(p, i, MemrefOptions { llvm: e.llvm, aligned_alloc: false, generic: false });
        }
        fn ub<'p>(p: &mut ConversionPatterns<'p>, i: usize, _: &LlvmEnv<'p>) {
            UbToLlvm::populate(p, i);
        }
        fn vector<'p>(p: &mut ConversionPatterns<'p>, i: usize, e: &LlvmEnv<'p>) {
            VectorToLlvm::populate(p, i, VectorOptions { llvm: e.llvm, reassociate_fp_reductions: false, force_32bit_indices: true, use_vector_alignment: false, counter: e.counter });
        }
        let mut s = Self::new();
        s.register("arith", arith).register("cf", cf).register("complex", complex).register("func", func).register("index", index).register("math", math).register("memref", memref).register("ub", ub).register("vector", vector);
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
