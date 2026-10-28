//! SPIR-V serialization against `mlir-translate --serialize-spirv` 22.1.8: every chunk of
//! `mlir/test/Target/SPIRV` (see `scripts/spirv_fixtures.py`), byte for byte.
//!
//! `FILTER=<substring>` narrows the chunks; `SHOW=1` prints where each mismatch starts and
//! writes what mlirpass serialized to `target/spirv-got/`.

mod common;

use std::fs;

use common::Fixtures;
use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Emit, Interfaces, SpirvBinary};

#[test]
fn serialize_spirv() {
    let (opt, interfaces) = (MlirOpt::upstream(), Interfaces::upstream());
    let ctx = Ctx::new(&opt, &interfaces);
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let mut stems: Vec<String> = fs::read_dir(Fixtures::dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".spv").map(str::to_owned)).collect();
    stems.sort();
    let (mut exact, mut failed) = (0, Vec::new());
    for stem in stems.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let want = fs::read(Fixtures::dir().join(format!("{stem}.spv"))).unwrap();
        let text = fs::read_to_string(Fixtures::dir().join(format!("{stem}.in.mlir"))).unwrap();
        let got = Body::parse(ctx, &text).and_then(|body| {
            let module = body.ops_in(body.root).into_iter().find(|o| body[*o].name == "spirv.module").ok_or("no spirv.module")?;
            SpirvBinary::default().emit(&body, module).map(|w| SpirvBinary::bytes(&w))
        });
        match got {
            Ok(got) if got == want => exact += 1,
            Ok(got) => {
                if show {
                    let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("target/spirv-got");
                    fs::create_dir_all(&dir).unwrap();
                    fs::write(dir.join(format!("{stem}.spv")), &got).unwrap();
                }
                let word = |b: &[u8], i: usize| b.get(i * 4..i * 4 + 4).map(|w| u32::from_le_bytes(w.try_into().unwrap()));
                let at = (0..).find(|i| word(&got, *i) != word(&want, *i)).unwrap();
                failed.push(format!("{stem}: word {at}: mlir-translate {:08x?}, mlirpass {:08x?} ({} vs {} words)", word(&want, at), word(&got, at), want.len() / 4, got.len() / 4));
            }
            Err(e) => failed.push(format!("{stem}: {e}")),
        }
    }
    eprintln!("{exact} of {} chunks serialize byte for byte", exact + failed.len());
    for f in failed.iter().take(if show { usize::MAX } else { 20 }) {
        eprintln!("  {f}");
    }
}
