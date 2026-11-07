//! ⭐ Out of MLIR, as `mlir-translate`'s translations: a target turns an op (a module) into what
//! it emits — SPIR-V words, GLSL text, or a format of one's own ([`Emit`]).
//!
//! The backends, one cargo feature each: `llvm` (the LLVM dialect lowerings and its folds),
//! `emitc` (the EmitC lowerings) and `spirv` (the SPIR-V lowerings, binary and GLSL emit).

#[cfg(feature = "target.emitc")]
mod emitc;
#[cfg(feature = "target.llvm")]
mod llvm;
#[cfg(feature = "target.rdna2")]
mod rdna2;
#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
mod regalloc;
#[cfg(any(feature = "dialect.agx", feature = "dialect.rdna2", feature = "dialect.xe3"))]
mod shader;
#[cfg(feature = "target.spirv")]
mod spirv;

use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId};

#[cfg(feature = "target.emitc")]
pub use emitc::*;
#[cfg(feature = "target.llvm")]
pub use llvm::*;
#[cfg(feature = "target.rdna2")]
pub use rdna2::*;
#[cfg(any(feature = "target.agx", feature = "target.rdna2", feature = "target.xe3"))]
pub use regalloc::*;
#[cfg(any(feature = "dialect.agx", feature = "dialect.rdna2", feature = "dialect.xe3"))]
pub use shader::*;
#[cfg(feature = "target.spirv")]
pub use spirv::*;

/// ⭐ A target `op` translates into.
pub trait Emit {
    type Output;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Self::Output, Error>;
}

/// MLIR's string escaping (`llvm::printEscapedString`) of raw bytes: printable ASCII as it is (but `"`), `\\` doubled,
/// the rest `\XX`.
pub fn escape(bytes: &[u8]) -> alloc::string::String {
    let mut lit = alloc::string::String::with_capacity(bytes.len());
    for &b in bytes {
        match b {
            b'\\' => lit.push_str("\\\\"),
            b' '..=b'~' if b != b'"' => lit.push(b as char),
            b => lit.push_str(&alloc::format!("\\{b:02X}")),
        }
    }
    lit
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
