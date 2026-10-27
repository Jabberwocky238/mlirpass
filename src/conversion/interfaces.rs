//! The dialect conversion interfaces `convert-to-*` gather (`ConvertToLLVMPatternInterface`,
//! `ConvertToEmitCPatternInterface`, ...): which dialects have one, and what each adds. Nothing
//! is global: a pass holds the manager it asks.

use alloc::vec::Vec;

use crate::ConversionPatterns;

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
