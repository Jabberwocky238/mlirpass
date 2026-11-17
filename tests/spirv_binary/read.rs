use std::fs;
use std::path::Path;

use mlirpass::SpirvReader;
use mlirformat::{Item, MlirOpt, Module};

use crate::canon::Canon;

/// Names restart at each function
const SPIRV_FUNC: &str = "\"spirv.func\"";



/// Every `.read.mlir` in `dir` is what `mlir-translate --deserialize-spirv` (23.1.5) made of the
/// `.spv` beside it, read here with `reader`.
fn reads_as_mlir_translate(dir: &Path, reader: SpirvReader) {
    let opt = MlirOpt::upstream();
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let mut stems: Vec<String> = fs::read_dir(dir).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".spv").filter(|s| !s.ends_with(".rt")).map(str::to_owned)).collect();
    stems.sort();
    let (mut exact, mut failed) = (0, Vec::new());
    for stem in stems.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let bytes = fs::read(dir.join(format!("{stem}.spv"))).unwrap();
        assert!(SpirvReader::recognizes(&bytes));
        let text = fs::read_to_string(dir.join(format!("{stem}.read.mlir"))).unwrap();
        let want = Canon::of(&opt.parse(&text).unwrap(), SPIRV_FUNC);
        let got = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| reader.read(&bytes))).map_err(|_| String::from("panicked")).and_then(|r| r.map_err(|e| e.0)).map(|op| Canon::of(&Module { items: vec![Item::Op(op)] }, SPIRV_FUNC));
        match got {
            Ok(got) if got == want => exact += 1,
            Ok(got) => {
                let line = got.lines().zip(want.lines()).position(|(a, b)| a != b).unwrap_or(0);
                if show {
                    let out = Path::new(env!("CARGO_MANIFEST_DIR")).join("target/spirv-read");
                    fs::create_dir_all(&out).unwrap();
                    fs::write(out.join(format!("{stem}.got.mlir")), &got).unwrap();
                    fs::write(out.join(format!("{stem}.want.mlir")), &want).unwrap();
                }
                failed.push(format!("{stem}: line {}: ours `{}` / mlir-translate `{}`", line + 1, got.lines().nth(line).unwrap_or("").trim(), want.lines().nth(line).unwrap_or("").trim()));
            }
            Err(e) => failed.push(format!("{stem}: {e}")),
        }
    }
    eprintln!("{exact} of {} read as mlir-translate does", exact + failed.len());
    for f in &failed {
        eprintln!("  {}", &f[..f.len().min(300)]);
    }
    assert!(failed.is_empty() || filter.is_some(), "{} of {} differ from mlir-translate", failed.len(), exact + failed.len());
}

#[test]
fn structured() {
    reads_as_mlir_translate(&crate::fixtures("modules"), SpirvReader::default());
}

/// `--spirv-structurize-control-flow=false`: loops and selections left as plain blocks, which
/// also reads what structurization cannot (the GL shader's loops left early)
#[test]
fn unstructured() {
    reads_as_mlir_translate(&crate::fixtures("unstructured"), SpirvReader { structurize: false });
}
