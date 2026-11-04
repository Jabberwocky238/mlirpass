//! `ConvertToEmitCPatternInterface`: what each dialect adds to `convert-to-emitc`.

use alloc::vec::Vec;

use crate::{ConversionPatterns, DialectInterfaces, TypeConverter};

#[cfg(any(feature = "dialect.arith", feature = "dialect.memref", feature = "dialect.scf"))]
use crate::Emitc;
#[cfg(feature = "dialect.arith")]
use crate::ArithToEmitc;
#[cfg(feature = "dialect.func")]
use crate::FuncToEmitc;
#[cfg(feature = "dialect.memref")]
use crate::MemrefToEmitc;
#[cfg(feature = "dialect.scf")]
use crate::ScfToEmitc;

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
        // (none without a dialect feature)
        #[allow(unused_mut)]
        let mut s = Self::new();
        #[cfg(feature = "dialect.arith")]
        s.register("arith", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i| ArithToEmitc::populate(p, i));
        #[cfg(feature = "dialect.func")]
        s.register("func", false, None, |p, i| FuncToEmitc::populate(p, i));
        #[cfg(feature = "dialect.memref")]
        s.register("memref", false, Some(|tc, size_t| Emitc::memref_conversions(tc, size_t)), |p, i| MemrefToEmitc::populate(p, i));
        #[cfg(feature = "dialect.scf")]
        s.register("scf", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i| ScfToEmitc::populate(p, i));
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
