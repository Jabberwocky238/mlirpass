#[cfg(feature = "target.emitc")]
mod emitc;
#[cfg(feature = "target.llvm")]
mod llvm;
#[cfg(feature = "target.spirv")]
mod spirv;
#[cfg(feature = "target.glsl")]
mod glsl;
#[cfg(any(feature = "target.spirv", feature = "target.glsl"))]
mod tree;

use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId};

#[cfg(feature = "target.emitc")]
pub use emitc::*;
#[cfg(feature = "target.llvm")]
pub use llvm::*;
#[cfg(feature = "target.spirv")]
pub use spirv::*;
#[cfg(feature = "target.glsl")]
pub use glsl::*;

/// A backend, one folder under `src/targets`: its name (also its `target.<name>` feature) and the
/// passes that lower its input to what it emits.
pub trait Target {
    fn name(&self) -> &'static str;

    /// A `builtin.module(..)` pipeline
    fn pipeline(&self) -> &'static str;
}

pub trait Emit {
    type Output;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Self::Output, Error>;
}

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
