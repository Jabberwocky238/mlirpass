use std::fs;
use std::path::{Path, PathBuf};

use mlirpass::{SpirvReader, SpirvWriter};

fn dir() -> PathBuf {
    crate::fixtures("modules")
}

/// Each `.spv` read and written again comes out as `mlir-translate --deserialize-spirv |
/// mlir-translate --serialize-spirv` writes it (`.rt.spv`; not always the `.spv` itself: a loop
/// read back gains an entry block). Where mlir-translate cannot read its own text back there is
/// no `.rt.spv`, and the module only has to write.
#[test]
fn read_then_write_as_mlir_translate() {
    let mut stems: Vec<String> = fs::read_dir(dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".spv").filter(|s| !s.ends_with(".rt")).map(str::to_owned)).collect();
    stems.sort();
    let mut bad = Vec::new();
    for stem in &stems {
        let bytes = fs::read(dir().join(format!("{stem}.spv"))).unwrap();
        let want = fs::read(dir().join(format!("{stem}.rt.spv"))).ok();
        match SpirvReader::default().read(&bytes).and_then(|op| SpirvWriter::default().words(&op).map(|w| SpirvWriter::bytes(&w))) {
            Ok(again) if want.as_ref().is_none_or(|w| *w == again) => {}
            Ok(again) => {
                if std::env::var_os("SHOW").is_some() {
                    let out = Path::new(env!("CARGO_MANIFEST_DIR")).join("target/spirv-rt");
                    fs::create_dir_all(&out).unwrap();
                    fs::write(out.join(format!("{stem}.spv")), &again).unwrap();
                }
                bad.push(format!("{stem}: mlir-translate {} words, ours {}", want.map_or(0, |w| w.len()) / 4, again.len() / 4));
            }
            Err(e) => bad.push(format!("{stem}: {}", e.0)),
        }
    }
    eprintln!("{} of {} round-trip byte for byte", stems.len() - bad.len(), stems.len());
    assert!(bad.is_empty(), "{}", bad.join("\n"));
}
