//! ⭐ Out of MLIR, as `mlir-translate`'s translations: a target turns an op (a module) into what
//! it emits — SPIR-V words, GLSL text, or a format of one's own ([`Emit`]).
//!
//! The backends, one cargo feature each: `llvm` (the LLVM dialect lowerings and its folds),
//! `emitc` (the EmitC lowerings) and `spirv` (the SPIR-V lowerings, binary and GLSL emit).

#[cfg(feature = "emitc")]
mod emitc;
#[cfg(feature = "llvm")]
mod llvm;
#[cfg(feature = "spirv")]
mod spirv;

use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId};

#[cfg(feature = "emitc")]
pub use emitc::*;
#[cfg(feature = "llvm")]
pub use llvm::*;
#[cfg(feature = "spirv")]
pub use spirv::*;

/// ⭐ A target `op` translates into.
pub trait Emit {
    type Output;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Self::Output, Error>;
}

/// MLIR's string escapes undone: `\\`, `\"`, `\n`, `\t` and `\XX`.
pub fn unescape(s: &str) -> Vec<u8> {
    let b = s.as_bytes();
    let mut out = Vec::new();
    let mut i = 0;
    while i < b.len() {
        if b[i] != b'\\' || i + 1 >= b.len() {
            out.push(b[i]);
            i += 1;
            continue;
        }
        match b[i + 1] {
            b'n' => out.push(b'\n'),
            b't' => out.push(b'\t'),
            b'\\' | b'"' => out.push(b[i + 1]),
            _ if i + 2 < b.len() => {
                let hex = core::str::from_utf8(&b[i + 1..i + 3]).ok().and_then(|h| u8::from_str_radix(h, 16).ok());
                match hex {
                    Some(v) => {
                        out.push(v);
                        i += 3;
                        continue;
                    }
                    None => out.push(b[i + 1]),
                }
            }
            c => out.push(c),
        }
        i += 2;
    }
    out
}
