use std::fs;
use std::path::{Path, PathBuf};

use mlirpass::GlslFormat;
use mlirformat::glsl::{GlslDialect, GlslStage};
use mlirformat::{Item, MlirOpt, Module, Operation};

#[path = "../spirv_binary/canon.rs"]
mod common;
use common::Canon;

fn dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/glsl_source/fixtures")
}

fn shader<'o, 'a>(ops: &'o [Operation<'a>]) -> Option<&'o Operation<'a>> {
    ops.iter().find_map(|o| if o.name == "glsl.shader" { Some(o) } else { o.regions.iter().flat_map(|r| &r.blocks).find_map(|b| shader(&b.ops)) })
}

/// Each shader (`<case>.<file>.vert` / `.frag`, from mlirpass's `tests/gl`) reads as the `.mlir`
/// beside it holds
#[test]
fn reads_shaders() {
    let mut opt = MlirOpt::upstream();
    opt.load(GlslDialect);
    let filter = std::env::var("FILTER").ok();
    let mut names: Vec<String> = fs::read_dir(dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()).filter(|n| n.ends_with(".vert") || n.ends_with(".frag")).collect();
    names.sort();
    let (mut exact, mut failed) = (0, Vec::new());
    for name in names.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let src = fs::read(dir().join(name)).unwrap();
        let text = fs::read_to_string(dir().join(format!("{name}.mlir"))).unwrap();
        let m = opt.parse(&text).unwrap();
        let ops: Vec<Operation<'_>> = m.items.into_iter().filter_map(|i| if let Item::Op(o) = i { Some(o) } else { None }).collect();
        let want = Canon::of(&Module { items: vec![Item::Op(shader(&ops).unwrap().clone())] }, "");
        let stage = if name.ends_with(".vert") { GlslStage::Vertex } else { GlslStage::Fragment };
        let format = GlslFormat::new(Some(stage));
        assert!(GlslFormat::recognizes(&src) || !String::from_utf8_lossy(&src).contains("#version"), "{name}");
        let got = std::str::from_utf8(&src).map_err(|e| mlirformat::Error(e.to_string())).and_then(|s| format.read(s)).map_err(|e| e.0).map(|op| Canon::of(&Module { items: vec![Item::Op(op)] }, ""));
        match got {
            Ok(got) if got == want => exact += 1,
            Ok(got) => {
                let line = got.lines().zip(want.lines()).position(|(a, b)| a != b).unwrap_or(0);
                failed.push(format!("{name}: line {}: ours `{}` / mlirpass `{}`", line + 1, got.lines().nth(line).unwrap_or("").trim(), want.lines().nth(line).unwrap_or("").trim()));
            }
            Err(e) => failed.push(format!("{name}: {e}")),
        }
    }
    eprintln!("{exact} of {} read as mlirpass read them", exact + failed.len());
    for f in &failed {
        eprintln!("  {}", &f[..f.len().min(400)]);
    }
    assert!(failed.is_empty());
}

/// Each shader read, written back as GLSL and read again; the source written goes to
/// `target/glsl-written` with `SHOW`
#[test]
fn writes_shaders() {
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let mut names: Vec<String> = fs::read_dir(dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()).filter(|n| n.ends_with(".vert") || n.ends_with(".frag")).collect();
    names.sort();
    let (mut ok, mut failed) = (0, Vec::new());
    for name in names.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let src = fs::read_to_string(dir().join(name)).unwrap();
        let stage = if name.ends_with(".vert") { GlslStage::Vertex } else { GlslStage::Fragment };
        let format = GlslFormat::new(Some(stage));
        let written = format.read(&src).and_then(|op| GlslFormat::write(&op));
        match written {
            Ok(text) => {
                if show {
                    let out = Path::new(env!("CARGO_MANIFEST_DIR")).join("target/glsl-written");
                    fs::create_dir_all(&out).unwrap();
                    fs::write(out.join(name), &text).unwrap();
                }
                match format.read(&text) {
                    Ok(_) => ok += 1,
                    Err(e) => failed.push(format!("{name}: written source does not read back: {}", e.0)),
                }
            }
            Err(e) => failed.push(format!("{name}: {}", e.0)),
        }
    }
    eprintln!("{ok} of {} written and read back", ok + failed.len());
    for f in &failed {
        eprintln!("  {}", &f[..f.len().min(300)]);
    }
    assert!(failed.is_empty());
}
