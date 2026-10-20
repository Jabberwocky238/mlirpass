//! The dialect conversion interfaces `convert-to-llvm` and `convert-to-emitc` gather
//! (`ConvertToLLVMPatternInterface`, `ConvertToEmitCPatternInterface`): which dialects have
//! one, and what each adds. Nothing is global: a pass holds the manager it asks.

use alloc::vec::Vec;
use core::cell::Cell;

use super::*;
use crate::{ConversionPatterns, LlvmOptions, TypeConverter};

/// ⭐ Dialects' conversion interfaces: what each registered dialect adds to the patterns.
pub trait DialectInterfaces {
    /// What the patterns are built with.
    type Env<'e>;

    /// The dialects that have one, in registration order.
    fn dialects(&self) -> Vec<&'static str>;

    fn knows(&self, ns: &str) -> bool {
        self.dialects().contains(&ns)
    }

    /// Adds dialect `ns`'s patterns (nothing when it has no interface).
    fn populate<'p>(&self, ns: &str, patterns: &mut ConversionPatterns<'p>, tc: usize, env: &Self::Env<'p>);
}

/// What `convert-to-llvm` builds its patterns with.
pub struct LlvmEnv<'p> {
    pub llvm: LlvmOptions,
    /// Unique names for the globals the lowerings create.
    pub counter: &'p Cell<u32>,
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

/// One dialect's `ConvertToEmitCPatternInterface`: the types it adds to the converter (told
/// whether `size_t` is in use), and its patterns.
struct ToEmitc {
    ns: &'static str,
    /// Its conversions need `size_t`.
    size_t: bool,
    types: Option<fn(&mut TypeConverter<'_>, bool)>,
    populate: for<'p> fn(&mut ConversionPatterns<'p>, usize),
}

/// The `ConvertToEmitCPatternInterface`s; [`Default`]: the upstream dialects this crate lowers.
pub struct ToEmitcInterfaces {
    by_dialect: Vec<ToEmitc>,
}

impl ToEmitcInterfaces {
    pub fn new() -> Self {
        Self { by_dialect: Vec::new() }
    }

    pub fn register(&mut self, ns: &'static str, size_t: bool, types: Option<fn(&mut TypeConverter<'_>, bool)>, populate: for<'p> fn(&mut ConversionPatterns<'p>, usize)) -> &mut Self {
        self.by_dialect.push(ToEmitc { ns, size_t, types, populate });
        self
    }

    /// Whether dialect `ns`'s conversions need `size_t`.
    pub fn uses_size_t(&self, ns: &str) -> bool {
        self.by_dialect.iter().any(|d| d.ns == ns && d.size_t)
    }

    /// Adds dialect `ns`'s type conversions to `tc`.
    pub fn types(&self, ns: &str, tc: &mut TypeConverter<'_>, size_t: bool) {
        if let Some(f) = self.by_dialect.iter().find(|d| d.ns == ns).and_then(|d| d.types) {
            f(tc, size_t);
        }
    }
}

impl Default for ToEmitcInterfaces {
    fn default() -> Self {
        let mut s = Self::new();
        s.register("arith", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i| ArithToEmitc::populate(p, i))
            .register("func", false, None, |p, i| FuncToEmitc::populate(p, i))
            .register("memref", false, Some(|tc, size_t| Emitc::memref_conversions(tc, size_t)), |p, i| MemrefToEmitc::populate(p, i))
            .register("scf", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i| ScfToEmitc::populate(p, i));
        s
    }
}

impl DialectInterfaces for ToEmitcInterfaces {
    type Env<'e> = ();

    fn dialects(&self) -> Vec<&'static str> {
        self.by_dialect.iter().map(|d| d.ns).collect()
    }

    fn populate<'p>(&self, ns: &str, patterns: &mut ConversionPatterns<'p>, tc: usize, _: &()) {
        if let Some(d) = self.by_dialect.iter().find(|d| d.ns == ns) {
            (d.populate)(patterns, tc);
        }
    }
}
