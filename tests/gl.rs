use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

use mlirpass::mlirformat::MlirOpt;
use mlirpass::{Body, Ctx, Emit, GlslDialect, GlslReader, GlslStage, Interfaces, PassManager, Passes, SpirvBinary};

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

struct Lowered {
    vert: Vec<u8>,
    frag: Vec<u8>,
    shown: String,
    offsets: Vec<(i128, i128)>,
}

impl Lowered {
    const BLOCK: &str = "gl_DefaultUniformBlock";

    fn offsets(body: &Body<'_>) -> Result<Vec<(i128, i128)>, String> {
        let mut found = Vec::new();
        body.walk(body.root, &mut |o| found.push(o));
        let Some(pairs) = found.into_iter().find_map(|o| body[o].get("offsets").filter(|_| body[o].get("sym_name").is_some_and(|n| n.to_string().contains(Lowered::BLOCK)))) else { return Ok(Vec::new()) };
        let mlirpass::mlirformat::Attribute::Array(pairs) = pairs else { return Err(format!("offsets: {pairs}")) };
        pairs
            .iter()
            .map(|p| match p {
                mlirpass::mlirformat::Attribute::Array(lo) if lo.len() == 2 => Ok((lo[0].int().map_err(|e| e.to_string())?, lo[1].int().map_err(|e| e.to_string())?)),
                p => Err(format!("offsets: {p}")),
            })
            .collect()
    }

    fn new(vert: &str, frag: &str, block: Option<u32>, unreadable: bool) -> Result<Lowered, String> {
        let mut opt = MlirOpt::upstream();
        opt.load(GlslDialect);
        let interfaces = Interfaces::upstream();
        let passes = Passes::upstream();
        let pipeline = |p: &str| PassManager::parse(&passes, &format!("builtin.module({p})")).map_err(|e| e.to_string());
        let link = pipeline(&block.map_or_else(|| String::from("glsl-link"), |b| format!("glsl-link, glsl-default-block{{binding={b}}}")))?;
        let spirv = pipeline("convert-glsl-to-spirv{client=opengl}")?;
        let mut body = Body::new(Ctx::new(&opt, &interfaces));
        GlslReader::read(&mut body, vert, GlslStage::Vertex).map_err(|e| format!("vertex {e}"))?;
        GlslReader::read(&mut body, frag, GlslStage::Fragment).map_err(|e| format!("fragment {e}"))?;
        let root = body.root;
        link.run(&mut body, root).map_err(|e| e.to_string())?;
        let offsets = Lowered::offsets(&body)?;
        spirv.run(&mut body, root).map_err(|e| e.to_string())?;
        let shown = body.show(&opt, false, |_| true);
        let mut modules = Vec::new();
        body.walk(root, &mut |o| modules.push(o));
        modules.retain(|&o| &*body[o].name == "spirv.module");
        let mut stages = Vec::new();
        let mut unread: Vec<String> = Vec::new();
        for m in modules {
            let words = SpirvBinary::default().emit(&body, m).map_err(|e| format!("{e}\n{shown}"))?;
            let bytes = SpirvBinary::bytes(&words);
            if let Err(e) = SpirvBinary::default().read(Ctx::new(&opt, &interfaces), &bytes) {
                unread.push(e.0);
                SpirvBinary { structurize: false, ..SpirvBinary::default() }.read(Ctx::new(&opt, &interfaces), &bytes).map_err(|e| format!("reading the SPIR-V back unstructured: {e}"))?;
            }
            stages.push(bytes);
        }
        match (unread.first(), unreadable) {
            (Some(e), false) => return Err(format!("reading the SPIR-V back: {e}")),
            (None, true) => return Err(String::from("reads back now: drop its `unreadable` file")),
            _ => {}
        }
        match <[Vec<u8>; 2]>::try_from(stages) {
            Ok([vert, frag]) => Ok(Lowered { vert, frag, shown, offsets }),
            Err(s) => Err(format!("{} spirv modules, not a vertex and a fragment shader\n{shown}", s.len())),
        }
    }

    fn write(&self, gl: &Gl, name: &str) -> Result<(PathBuf, PathBuf), String> {
        let (vs, fs_) = (gl.out.join(format!("{name}.vert.spv")), gl.out.join(format!("{name}.frag.spv")));
        fs::write(&vs, &self.vert).map_err(|e| e.to_string())?;
        fs::write(&fs_, &self.frag).map_err(|e| e.to_string())?;
        valid(&vs)?;
        valid(&fs_)?;
        Ok((vs, fs_))
    }

    /// Rewrites the `uniform` lines of `res` as one `words` buffer laid out as the default block says.
    fn words(&self, res: &str, binding: u32) -> Result<String, String> {
        let mut words: Vec<i32> = Vec::new();
        let mut kept = Vec::new();
        for line in res.lines() {
            let f: Vec<&str> = line.split_whitespace().collect();
            let ["uniform", _, at, ty, values @ ..] = f.as_slice() else {
                kept.push(line);
                continue;
            };
            let at: i128 = at.parse().map_err(|_| format!("location in `{line}`"))?;
            let off = self.offsets.iter().find(|(l, _)| *l == at).ok_or_else(|| format!("location {at} is not in the default block"))?.1;
            let first = usize::try_from(off).map_err(|e| e.to_string())? / FLOAT;
            for (i, v) in values.iter().enumerate() {
                let word = if *ty == "i" { v.parse::<i32>().map_err(|e| e.to_string())? } else { v.parse::<f32>().map_err(|e| e.to_string())?.to_bits().cast_signed() };
                if words.len() <= first + i {
                    words.resize(first + i + 1, 0);
                }
                words[first + i] = word;
            }
        }
        words.resize(words.len().next_multiple_of(Lowered::VEC4_WORDS) + Lowered::VEC4_WORDS * Lowered::VEC4_WORDS, 0);
        let mut out: Vec<String> = kept.into_iter().map(String::from).collect();
        out.push(format!("words {binding} {}", words.iter().map(i32::to_string).collect::<Vec<_>>().join(" ")));
        Ok(out.join("\n") + "\n")
    }

    const VEC4_WORDS: usize = 4;
}

fn valid(spv: &Path) -> Result<(), String> {
    let Ok(o) = Command::new("spirv-val").args(["--target-env", "opengl4.5"]).arg(spv).output() else { return Ok(()) };
    if o.status.success() { Ok(()) } else { Err(format!("spirv-val: {}", String::from_utf8_lossy(&o.stderr).trim())) }
}

fn glslang(src: &Path, out: &Path) -> Result<(), String> {
    let o = Command::new("glslangValidator").arg("-G").arg(src).arg("-o").arg(out).output().map_err(|e| format!("glslangValidator: {e}"))?;
    if o.status.success() { Ok(()) } else { Err(format!("glslangValidator: {}", String::from_utf8_lossy(&o.stdout).trim())) }
}

fn ulps(a: &[u8], b: &[u8]) -> u32 {
    let bits = |c: &[u8]| i32::from_le_bytes([c[0], c[1], c[2], c[3]]);
    a.chunks(FLOAT).zip(b.chunks(FLOAT)).map(|(x, y)| (bits(x), bits(y))).map(|(x, y)| if (x < 0) == (y < 0) { x.abs_diff(y) } else { u32::MAX }).max().unwrap_or(0)
}

fn reassociated(dir: &Path) -> Vec<(String, u32)> {
    let Ok(text) = fs::read_to_string(dir.join("reassociated")) else { return Vec::new() };
    text.lines().filter_map(|l| l.split_once(' ')).filter_map(|(n, u)| Some((String::from(n), u.trim().parse().ok()?))).collect()
}

fn differing(a: &[u8], b: &[u8]) -> usize {
    a.chunks(FLOAT).zip(b.chunks(FLOAT)).filter(|(x, y)| x != y).count()
}

struct Case {
    name: String,
    vert: PathBuf,
    frag: PathBuf,
    res: Option<PathBuf>,
    allowed: Option<u32>,
    /// Its SPIR-V reads back only unstructured, as with `mlir-translate --deserialize-spirv`
    /// (the case dir's `unreadable` file says why)
    unreadable: bool,
}

impl Case {
    const DEFAULT_BLOCK: u32 = 7;

    fn all(root: &Path) -> Vec<Case> {
        let mut dirs: Vec<PathBuf> = fs::read_dir(root).unwrap().filter_map(|e| e.ok().map(|e| e.path())).filter(|p| p.is_dir()).collect();
        dirs.sort();
        let mut out = Vec::new();
        for dir in dirs {
            let mut frags: Vec<PathBuf> = fs::read_dir(&dir).unwrap().filter_map(|e| e.ok().map(|e| e.path())).filter(|p| p.extension().is_some_and(|x| x == "frag")).collect();
            frags.sort();
            let res = Some(dir.join("resources")).filter(|r| r.exists());
            let allowed = reassociated(&dir);
            let unreadable = dir.join("unreadable").exists();
            let dir_name = dir.file_name().unwrap().to_string_lossy().into_owned();
            for frag in frags {
                let stem = frag.file_stem().unwrap().to_string_lossy().into_owned();
                let name = if stem == "shader" { dir_name.clone() } else { format!("{dir_name}.{stem}") };
                let allowed = allowed.iter().find(|(s, _)| *s == stem).map(|(_, u)| *u);
                out.push(Case { name, vert: dir.join("shader.vert"), frag, res: res.clone(), allowed, unreadable });
            }
        }
        out
    }

    /// Loose uniforms packed by `glsl-default-block` must draw exactly what they drew as loose uniforms.
    fn default_block(&self, gl: &Gl, res: Option<&Path>, ours: &[u8]) -> Result<(), String> {
        let Some(text) = res.map(fs::read_to_string).transpose().map_err(|e| e.to_string())? else { return Ok(()) };
        if !text.lines().any(|l| l.starts_with("uniform ")) {
            return Ok(());
        }
        let name = format!("{}.default_block", self.name);
        let read = |f: &Path| fs::read_to_string(f).map_err(|e| e.to_string());
        let lowered = Lowered::new(&read(&self.vert)?, &read(&self.frag)?, Some(Case::DEFAULT_BLOCK), self.unreadable).map_err(|e| format!("default block: {e}"))?;
        let (vs, fs_) = lowered.write(gl, &name)?;
        let words = gl.out.join(format!("{name}.resources"));
        fs::write(&words, lowered.words(&text, Case::DEFAULT_BLOCK)?).map_err(|e| e.to_string())?;
        let drawn = gl.draw("spirv", &vs, &fs_, &format!("{name}.bin"), Some(&words))?;
        match differing(ours, &drawn) {
            0 => Ok(()),
            n => Err(format!("default block: {n} floats differ from loose uniforms")),
        }
    }

    /// The shaders read and written back as GLSL (`GlslFormat`) must draw what the source drew; where
    /// Mesa reassociates the source, what our SPIR-V draws (glslang's), within the ulps allowed
    fn written(&self, gl: &Gl, res: Option<&Path>, reference: &[u8], ours: &[u8]) -> Result<(), String> {
        use mlirpass::GlslFormat;
        let name = &self.name;
        let mut paths = Vec::new();
        for (src, stage, ext) in [(&self.vert, GlslStage::Vertex, "vert"), (&self.frag, GlslStage::Fragment, "frag")] {
            let format = GlslFormat::new(Some(stage));
            let text = fs::read_to_string(src).map_err(|e| e.to_string())?;
            let out = format.read(&text).and_then(|op| GlslFormat::write(&op)).map_err(|e| format!("writing GLSL: {}", e.0))?;
            let path = gl.out.join(format!("{name}.written.{ext}"));
            fs::write(&path, out).map_err(|e| e.to_string())?;
            paths.push(path);
        }
        let drawn = gl.draw("written", &paths[0], &paths[1], &format!("{name}.written.bin"), res).map_err(|e| format!("written GLSL: {e}"))?;
        match (differing(reference, &drawn), self.allowed) {
            (0, _) => Ok(()),
            (_, Some(max)) if differing(ours, &drawn) == 0 && ulps(reference, &drawn) <= max => Ok(()),
            (n, _) => Err(format!("written GLSL: {n} floats differ from the source's")),
        }
    }

    fn run(&self, gl: &Gl, show: bool) -> Result<String, String> {
        let (name, res) = (&self.name, self.res.as_deref());
        let reference = gl.draw("glsl", &self.vert, &self.frag, &format!("{name}.glsl.bin"), res)?;
        let read = |f: &Path| fs::read_to_string(f).map_err(|e| e.to_string());
        let lowered = Lowered::new(&read(&self.vert)?, &read(&self.frag)?, None, self.unreadable)?;
        if show {
            println!("{name}:\n{}", lowered.shown);
        }
        let (vs, fs_) = lowered.write(gl, name)?;
        let ours = gl.draw("spirv", &vs, &fs_, &format!("{name}.spirv.bin"), res)?;
        self.written(gl, res, &reference, &ours)?;
        self.default_block(gl, res, &ours)?;
        let n = differing(&reference, &ours);
        let Some(max) = self.allowed else {
            return if n == 0 { Ok(String::from("bit for bit")) } else { Err(format!("{n} of {} floats differ", reference.len() / FLOAT)) };
        };
        if n == 0 {
            return Ok(String::from("bit for bit"));
        }
        let (gv, gf) = (gl.out.join(format!("{name}.glslang.vert.spv")), gl.out.join(format!("{name}.glslang.frag.spv")));
        glslang(&self.vert, &gv)?;
        glslang(&self.frag, &gf)?;
        let theirs = gl.draw("spirv", &gv, &gf, &format!("{name}.glslang.bin"), res)?;
        match (differing(&theirs, &ours), ulps(&reference, &ours)) {
            (0, u) if u <= max => Ok(format!("bit for bit with glslang; {n} floats within {u} ulp of OpenGL (Mesa reassociates)")),
            (0, u) => Err(format!("bit for bit with glslang, but {u} ulp from OpenGL (allowed {max})")),
            (k, _) => Err(format!("{k} floats differ from glslang, {n} from OpenGL")),
        }
    }
}

#[test]
fn glsl_draws_as_opengl() {
    let Some(gl) = Gl::new() else {
        eprintln!("cc, EGL or GL missing: skipped");
        return;
    };
    let show = std::env::var_os("SHOW").is_some();
    let cases = Case::all(&Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/gl"));
    let threads = std::thread::available_parallelism().map_or(1, |n| n.get());
    let next = std::sync::atomic::AtomicUsize::new(0);
    let mut results: Vec<(usize, Result<String, String>)> = std::thread::scope(|s| {
        let workers: Vec<_> = (0..threads)
            .map(|_| {
                s.spawn(|| {
                    let mut done = Vec::new();
                    loop {
                        let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                        let Some(c) = cases.get(i) else { return done };
                        done.push((i, c.run(&gl, show)));
                    }
                })
            })
            .collect();
        workers.into_iter().flat_map(|w| w.join().unwrap()).collect()
    });
    results.sort_by_key(|r| r.0);
    let mut bad = Vec::new();
    for (i, r) in results {
        let name = &cases[i].name;
        println!("{name}: {}", r.as_ref().map_or_else(|e| e.as_str(), |m| m.as_str()));
        if let Err(e) = r {
            bad.push(format!("{name}: {e}"));
        }
    }
    assert!(bad.is_empty(), "{}", bad.join("\n"));
}
