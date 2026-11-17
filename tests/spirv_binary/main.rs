//! SPIR-V: reading, writing and reading then writing as `mlir-translate` does, and writing as GLSL

use std::path::{Path, PathBuf};

mod canon;
mod glsl;
mod read;
mod roundtrip;
mod write;

/// `tests/spirv_binary/fixtures/<name>`
fn fixtures(name: &str) -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/spirv_binary/fixtures").join(name)
}
