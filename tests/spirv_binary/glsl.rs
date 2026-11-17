use std::fs;
use std::path::PathBuf;

use mlirpass::SpirvGlsl;
use mlirformat::{Item, MlirOpt, Operation};

fn dir() -> PathBuf {
    crate::fixtures("modules")
}

fn find<'o, 'a>(ops: &'o [Operation<'a>]) -> Option<&'o Operation<'a>> {
    ops.iter().find_map(|o| if o.name == "spirv.module" { Some(o) } else { o.regions.iter().flat_map(|r| &r.blocks).find_map(|b| find(&b.ops)) })
}

/// Each `.glsl` holds the GLSL written for the `spirv.module` of the `.in.mlir` beside it (or why
/// GLSL cannot say what it does), and the stage its entry point is
#[test]
fn writes_spirv_as_glsl() {
    let opt = MlirOpt::upstream();
    let filter = std::env::var("FILTER").ok();
    let mut stems: Vec<String> = fs::read_dir(dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".glsl").map(str::to_owned)).collect();
    stems.sort();
    let (mut exact, mut failed) = (0, Vec::new());
    for stem in stems.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let want = fs::read_to_string(dir().join(format!("{stem}.glsl"))).unwrap();
        let text = fs::read_to_string(dir().join(format!("{stem}.in.mlir"))).unwrap();
        let m = opt.parse(&text).unwrap();
        let ops: Vec<Operation<'_>> = m.items.into_iter().filter_map(|i| if let Item::Op(o) = i { Some(o) } else { None }).collect();
        let module = find(&ops).unwrap();
        let body = SpirvGlsl::text(module).unwrap_or_else(|e| format!("error: {}\n", e.0));
        let got = format!("// stage: {}\n{body}", SpirvGlsl::stage(module).unwrap_or("none"));
        if got == want {
            exact += 1;
        } else {
            let line = got.lines().zip(want.lines()).position(|(a, b)| a != b).unwrap_or(0);
            failed.push(format!("{stem}: line {}: `{}` / `{}`", line + 1, got.lines().nth(line).unwrap_or(""), want.lines().nth(line).unwrap_or("")));
        }
    }
    eprintln!("{exact} of {} as before", exact + failed.len());
    for f in &failed {
        eprintln!("  {}", &f[..f.len().min(300)]);
    }
    assert!(failed.is_empty());
}
