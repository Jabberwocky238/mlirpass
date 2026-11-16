use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Emit, GlslDialect, Interfaces, PassManager, Passes, SpirvBinary};

const SIZE: u32 = 64;
const FLOAT: usize = 4;

struct Gl {
    run: PathBuf,
    out: PathBuf,
}

impl Gl {
    fn new() -> Option<Gl> {
        let out = Path::new(env!("CARGO_MANIFEST_DIR")).join("target/gl");
        fs::create_dir_all(&out).ok()?;
        let run = out.join("glrun");
        let src = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/support/glrun.c");
        let built = Command::new("cc").args(["-O1", "-o"]).arg(&run).arg(src).args(["-lEGL", "-lGL"]).status().ok()?;
        built.success().then_some(Gl { run, out })
    }

    fn draw(&self, mode: &str, vert: &Path, frag: &Path, name: &str, resources: Option<&Path>) -> Result<Vec<u8>, String> {
        let px = self.out.join(name);
        let o = Command::new(&self.run).arg(mode).arg(vert).arg(frag).args([SIZE.to_string(), SIZE.to_string()]).arg(&px).args(resources).output().map_err(|e| e.to_string())?;
        if !o.status.success() {
            return Err(String::from_utf8_lossy(&o.stderr).trim().to_owned());
        }
        fs::read(&px).map_err(|e| e.to_string())
    }
}

fn lower(src: &str) -> Result<(Vec<u8>, Vec<u8>, String), String> {
    let mut opt = MlirOpt::upstream();
    opt.load(GlslDialect);
    let interfaces = Interfaces::upstream();
    let passes = Passes::upstream();
    let pm = PassManager::parse(&passes, "builtin.module(convert-glsl-to-spirv{client=opengl})").map_err(|e| e.to_string())?;
    let mut body = Body::parse(Ctx::new(&opt, &interfaces), src).map_err(|e| e.to_string())?;
    let root = body.root;
    pm.run(&mut body, root).map_err(|e| e.to_string())?;
    let shown = body.show(&opt, false, |_| true);
    let mut modules = Vec::new();
    body.walk(root, &mut |o| modules.push(o));
    modules.retain(|&o| &*body[o].name == "spirv.module");
    let mut stages = Vec::new();
    for m in modules {
        let words = SpirvBinary::default().emit(&body, m).map_err(|e| format!("{e}\n{shown}"))?;
        stages.push(SpirvBinary::bytes(&words));
    }
    match <[Vec<u8>; 2]>::try_from(stages) {
        Ok([v, f]) => Ok((v, f, shown)),
        Err(s) => Err(format!("{} spirv modules, not a vertex and a fragment shader\n{shown}", s.len())),
    }
}

fn valid(spv: &Path) -> Result<(), String> {
    let Ok(o) = Command::new("spirv-val").args(["--target-env", "opengl4.5"]).arg(spv).output() else { return Ok(()) };
    if o.status.success() { Ok(()) } else { Err(format!("spirv-val: {}", String::from_utf8_lossy(&o.stderr).trim())) }
}

fn differing(a: &[u8], b: &[u8]) -> usize {
    a.chunks(FLOAT).zip(b.chunks(FLOAT)).filter(|(x, y)| x != y).count()
}

#[test]
fn glsl_draws_as_opengl() {
    let Some(gl) = Gl::new() else {
        eprintln!("cc, EGL or GL missing: skipped");
        return;
    };
    let show = std::env::var_os("SHOW").is_some();
    let cases = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/gl");
    let mut dirs: Vec<PathBuf> = fs::read_dir(&cases).unwrap().filter_map(|e| e.ok().map(|e| e.path())).filter(|p| p.is_dir()).collect();
    dirs.sort();
    let mut bad = Vec::new();
    for dir in dirs {
        let name = dir.file_name().unwrap().to_string_lossy().into_owned();
        let res = dir.join("resources");
        let res = res.exists().then_some(res.as_path());
        let result = (|| {
            let reference = gl.draw("glsl", &dir.join("shader.vert"), &dir.join("shader.frag"), &format!("{name}.glsl.bin"), res)?;
            let (v, f, shown) = lower(&fs::read_to_string(dir.join("shader.mlir")).map_err(|e| e.to_string())?)?;
            if show {
                println!("{name}:\n{shown}");
            }
            let (vs, fs_) = (gl.out.join(format!("{name}.vert.spv")), gl.out.join(format!("{name}.frag.spv")));
            fs::write(&vs, v).map_err(|e| e.to_string())?;
            fs::write(&fs_, f).map_err(|e| e.to_string())?;
            valid(&vs)?;
            valid(&fs_)?;
            let ours = gl.draw("spirv", &vs, &fs_, &format!("{name}.spirv.bin"), res)?;
            match differing(&reference, &ours) {
                0 => Ok(()),
                n => Err(format!("{n} of {} floats differ", reference.len() / FLOAT)),
            }
        })();
        println!("{name}: {}", result.as_ref().map_or_else(|e| e.as_str(), |_| "bit for bit"));
        if let Err(e) = result {
            bad.push(format!("{name}: {e}"));
        }
    }
    assert!(bad.is_empty(), "{}", bad.join("\n"));
}
