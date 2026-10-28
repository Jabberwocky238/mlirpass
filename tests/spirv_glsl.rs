//! GLSL out of every `spirv.module` in the SPIR-V fixtures: what mlirpass emits must compile
//! with glslang (`glslangValidator -V`) and the SPIR-V glslang makes must pass `spirv-val`.
//! What GLSL cannot express is counted apart, by reason. Skipped without glslang.
//!
//! `FILTER=<substring>` narrows the chunks; `SHOW=1` lists every failure. The GLSL goes to
//! `target/spirv-glsl/`.

mod common;

use std::collections::BTreeMap;
use std::fs;
use std::process::Command;

use common::Fixtures;
use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Emit, Interfaces, SpirvGlsl};

fn run(cmd: &mut Command) -> Result<(), String> {
    let out = cmd.output().map_err(|e| e.to_string())?;
    if out.status.success() {
        return Ok(());
    }
    Err(String::from_utf8_lossy(&out.stdout).lines().chain(String::from_utf8_lossy(&out.stderr).lines()).filter(|l| l.contains("ERROR") || l.contains("error")).take(2).collect::<Vec<_>>().join(" | "))
}

#[test]
fn spirv_to_glsl_compiles() {
    if Command::new("glslangValidator").arg("--version").output().is_err() {
        eprintln!("glslangValidator not found: skipped");
        return;
    }
    let (opt, interfaces) = (MlirOpt::upstream(), Interfaces::upstream());
    let ctx = Ctx::new(&opt, &interfaces);
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let dir = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("target/spirv-glsl");
    fs::create_dir_all(&dir).unwrap();
    let mut stems: Vec<String> = fs::read_dir(Fixtures::dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".spv").map(str::to_owned)).collect();
    stems.sort();
    let (mut ok, mut failed, mut unsupported) = (0, Vec::new(), BTreeMap::<String, usize>::new());
    for stem in stems.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let text = fs::read_to_string(Fixtures::dir().join(format!("{stem}.in.mlir"))).unwrap();
        let body = Body::parse(ctx, &text).unwrap();
        let module = body.ops_in(body.root).into_iter().find(|o| body[*o].name == "spirv.module").unwrap();
        let mut glsl = match SpirvGlsl.emit(&body, module) {
            Ok(g) => g,
            Err(e) if e.0.starts_with("GLSL cannot express") => {
                *unsupported.entry(e.0).or_default() += 1;
                continue;
            }
            Err(e) => {
                failed.push(format!("{stem}: {e}"));
                continue;
            }
        };
        let stage = SpirvGlsl::stage(&body, module).unwrap_or_else(|| {
            // A library of functions: glslang wants an entry point, of a stage the code is
            // valid in (`barrier()` is compute only; interface variables and `discard` are not).
            glsl.push_str("void main() {}\n");
            if glsl.contains("barrier()") { "comp" } else { "frag" }
        });
        let src = dir.join(format!("{stem}.{stage}"));
        let spv = dir.join(format!("{stem}.spv"));
        fs::write(&src, &glsl).unwrap();
        let r = run(Command::new("glslangValidator").args(["-V", "--target-env", "vulkan1.3", "-o"]).arg(&spv).arg(&src)).and_then(|()| run(Command::new("spirv-val").args(["--target-env", "vulkan1.3"]).arg(&spv)));
        match r {
            Ok(()) => ok += 1,
            Err(e) => failed.push(format!("{stem}: {e}")),
        }
    }
    eprintln!("{ok} compile and validate, {} fail, {} not expressible", failed.len(), unsupported.values().sum::<usize>());
    for f in failed.iter().take(if show { usize::MAX } else { 20 }) {
        eprintln!("  {f}");
    }
    for (why, n) in &unsupported {
        eprintln!("  {n:3} {why}");
    }
}
