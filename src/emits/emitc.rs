//! ⭐ What the lowerings to `emitc` share: the EmitC type converter and the
//! `ConvertToEmitCPatternInterface`s (rules in `patterns/<d>/to_emitc.rs`, passes in `passes/`).

mod interfaces;
mod types;




pub use interfaces::ToEmitcInterfaces;
pub use types::Emitc;
