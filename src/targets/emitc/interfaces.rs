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

struct ToEmitc {
    ns: &'static str,
    size_t: bool,
    types: Option<fn(&mut TypeConverter<'_>, bool)>,
    populate: for<'p> fn(&mut ConversionPatterns<'p>, usize, Option<bool>),
}

pub struct ToEmitcInterfaces {
    by_dialect: Vec<ToEmitc>,
}

impl ToEmitcInterfaces {
    pub fn new() -> Self {
        Self { by_dialect: Vec::new() }
    }

    pub fn register(&mut self, ns: &'static str, size_t: bool, types: Option<fn(&mut TypeConverter<'_>, bool)>, populate: for<'p> fn(&mut ConversionPatterns<'p>, usize, Option<bool>)) -> &mut Self {
        self.by_dialect.push(ToEmitc { ns, size_t, types, populate });
        self
    }

    pub fn uses_size_t(&self, ns: &str) -> bool {
        self.by_dialect.iter().any(|d| d.ns == ns && d.size_t)
    }

    pub fn types(&self, ns: &str, tc: &mut TypeConverter<'_>, size_t: bool) {
        if let Some(f) = self.by_dialect.iter().find(|d| d.ns == ns).and_then(|d| d.types) {
            f(tc, size_t);
        }
    }
}

impl Default for ToEmitcInterfaces {
    fn default() -> Self {
        #[allow(unused_mut)]
        let mut s = Self::new();
        #[cfg(feature = "dialect.arith")]
        s.register("arith", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i, _| ArithToEmitc::populate(p, i));
        #[cfg(feature = "dialect.func")]
        s.register("func", false, None, |p, i, cpp| FuncToEmitc::populate(p, i, cpp.unwrap_or(true)));
        #[cfg(feature = "dialect.memref")]
        s.register("memref", false, None, |p, i, _| MemrefToEmitc::populate(p, i));
        #[cfg(feature = "dialect.scf")]
        s.register("scf", true, Some(|tc, _| Emitc::size_t_conversions(tc)), |p, i, _| ScfToEmitc::populate(p, i));
        s.register("test", false, Some(|tc, _| Emitc::test_conversions(tc)), |_, _, _| {});
        s
    }
}

impl DialectInterfaces for ToEmitcInterfaces {
    type Env<'e> = Option<bool>;

    fn dialects(&self) -> Vec<&'static str> {
        self.by_dialect.iter().map(|d| d.ns).collect()
    }

    fn populate<'p>(&self, ns: &str, patterns: &mut ConversionPatterns<'p>, tc: usize, cpp: &Option<bool>) {
        if let Some(d) = self.by_dialect.iter().find(|d| d.ns == ns) {
            (d.populate)(patterns, tc, *cpp);
        }
    }
}
