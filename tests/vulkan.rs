//! MLIR's own Vulkan execution tests (`mlir/test/Integration/GPU/Vulkan`, see
//! `scripts/vulkan_fixtures.py`), run: kernels through `convert-gpu-to-spirv`,
//! `spirv-lower-abi-attrs`, `spirv-update-vce`, then both as mlirpass's SPIR-V binary and as
//! mlirpass's GLSL compiled by glslang, on lavapipe; the host side (`@main`: allocations,
//! fills, launches, prints) interpreted here. What `printMemref*` would print must pass the
//! test's own FileCheck lines.
//!
//! Skipped without a C compiler, glslang or lavapipe. `FILTER=<substring>` narrows the tests;
//! `SHOW=1` prints what each run printed.

mod common;

use std::collections::BTreeMap;
use std::fs;
use std::path::{Path, PathBuf};
use std::process::Command;

use common::Fixtures;
use mlirpass::mlirformat::{Attribute, Const, Scalar, Type};
use mlirpass::{Body, Ctx, Emit, Interfaces, Invocation, OpId, Passes, Serial, SpirvBinary, SpirvGlsl, ValueId};

const LAVAPIPE: &str = "/usr/share/vulkan/icd.d/lvp_icd.json";

/// A host buffer: a memref's elements, as the device sees them.
#[derive(Clone)]
struct Buf {
    elem: Type<'static>,
    shape: Vec<i64>,
    data: Vec<u8>,
}

#[derive(Clone)]
enum Val {
    Scalar(Scalar, Type<'static>),
    Elements(Vec<Scalar>, Type<'static>),
    Buf(usize),
}

impl Buf {
    fn size(t: &Type<'_>) -> usize {
        (t.bit_width().unwrap_or(32) as usize).div_ceil(8)
    }

    fn put(&mut self, i: usize, s: Scalar) {
        let n = Self::size(&self.elem);
        let bits: u128 = match s {
            Scalar::Int(v) => v.bits(),
            Scalar::Float(f) => match self.elem {
                Type::Float(k) => u128::from(mlirpass::mlirformat::ApFloat::from_f64(k, f.to_f64()).expect("a float").bits),
                _ => u128::from(f.bits),
            },
        };
        self.data[i * n..(i + 1) * n].copy_from_slice(&bits.to_le_bytes()[..n]);
    }

    fn get(&self, i: usize) -> String {
        let n = Self::size(&self.elem);
        let mut b = [0u8; 16];
        b[..n].copy_from_slice(&self.data[i * n..(i + 1) * n]);
        let raw = u128::from_le_bytes(b);
        match &self.elem {
            Type::Float(_) => {
                let x = if n == 8 { f64::from_bits(raw as u64) } else { f64::from(f32::from_bits(raw as u32)) };
                Self::fmt_g(x)
            }
            t => {
                let w = t.bit_width().unwrap_or(32);
                let v = if w < 128 && raw >> (w - 1) & 1 == 1 { raw as i128 - (1i128 << w) } else { raw as i128 };
                format!("{v}")
            }
        }
    }

    /// C++ `std::ostream << double` (`%g`, 6 significant digits).
    fn fmt_g(x: f64) -> String {
        if x == 0.0 {
            return String::from(if x.is_sign_negative() { "-0" } else { "0" });
        }
        if !x.is_finite() {
            return String::from(if x.is_nan() { "nan" } else if x > 0.0 { "inf" } else { "-inf" });
        }
        let sci = format!("{x:.5e}");
        let (mant, exp) = sci.split_once('e').expect("exponent");
        let exp: i32 = exp.parse().expect("exponent");
        let trim = |s: String| if s.contains('.') { s.trim_end_matches('0').trim_end_matches('.').to_owned() } else { s };
        if (-4..6).contains(&exp) {
            trim(format!("{x:.*}", (5 - exp).max(0) as usize))
        } else {
            format!("{}e{}{:02}", trim(mant.to_owned()), if exp < 0 { '-' } else { '+' }, exp.abs())
        }
    }

    /// `printMemref*`: `MemRefDataPrinter` over a row-major memref.
    fn print(&self) -> String {
        let rank = self.shape.len() as i64;
        let strides: Vec<i64> = (0..self.shape.len()).map(|i| self.shape[i + 1..].iter().product()).collect();
        let mut out = format!(
            "Unranked Memref base@ = 0x0 rank = {rank} offset = 0 sizes = [{}] strides = [{}] data = \n",
            self.shape.iter().map(|d| d.to_string()).collect::<Vec<_>>().join(", "),
            strides.iter().map(|d| d.to_string()).collect::<Vec<_>>().join(", ")
        );
        if rank == 0 {
            out.push('[');
        }
        self.print_dim(&mut out, rank, rank, 0, &self.shape, &strides);
        if rank == 0 {
            out.push(']');
        }
        out.push('\n');
        out
    }

    fn print_dim(&self, os: &mut String, dim: i64, rank: i64, offset: i64, sizes: &[i64], strides: &[i64]) {
        if dim == 0 {
            os.push_str(&self.get(offset as usize));
            return;
        }
        os.push('[');
        self.print_dim(os, dim - 1, rank, offset, &sizes[1..], &strides[1..]);
        if sizes[0] <= 1 {
            os.push(']');
            return;
        }
        os.push_str(", ");
        if dim > 1 {
            os.push('\n');
        }
        for i in 1..sizes[0] - 1 {
            os.push_str(&" ".repeat((rank - dim + 1) as usize));
            self.print_dim(os, dim - 1, rank, offset + i * strides[0], &sizes[1..], &strides[1..]);
            os.push_str(", ");
            if dim > 1 {
                os.push('\n');
            }
        }
        os.push_str(&" ".repeat((rank - dim + 1) as usize));
        self.print_dim(os, dim - 1, rank, offset + (sizes[0] - 1) * strides[0], &sizes[1..], &strides[1..]);
        os.push(']');
    }
}

/// FileCheck's default: horizontal whitespace runs are one space.
fn squash(s: &str) -> String {
    let mut out = String::new();
    let mut space = false;
    for c in s.chars() {
        if c == ' ' || c == '\t' {
            space = true;
            continue;
        }
        if space && !out.ends_with('\n') && c != '\n' {
            out.push(' ');
        }
        space = false;
        out.push(c);
    }
    out
}

/// `CHECK:` / `CHECK-COUNT-N:` in order over `output`.
fn file_check(checks: &[String], output: &str) -> Result<(), String> {
    let text = squash(output);
    let mut at = 0;
    for c in checks {
        let (count, pat) = match c.strip_prefix("CHECK-COUNT-") {
            Some(rest) => {
                let (n, p) = rest.split_once(':').expect("CHECK-COUNT-N:");
                (n.parse::<usize>().expect("a count"), p)
            }
            None => (1, c.strip_prefix("CHECK:").unwrap_or(c)),
        };
        let pat = squash(pat.trim());
        for _ in 0..count {
            match text[at..].find(&pat) {
                Some(i) => at += i + pat.len(),
                None => return Err(format!("no match for `{c}`")),
            }
        }
    }
    Ok(())
}

struct Host<'b, 'a> {
    body: &'b Body<'a>,
    bufs: Vec<Buf>,
    vals: BTreeMap<ValueId, Val>,
    out: String,
}

impl<'b, 'a> Host<'b, 'a> {
    fn scalar(&self, v: ValueId) -> Result<(Scalar, Type<'static>), String> {
        match self.vals.get(&v) {
            Some(Val::Scalar(s, t)) => Ok((*s, t.clone())),
            _ => Err(String::from("not a scalar")),
        }
    }

    fn buf(&self, v: ValueId) -> Result<usize, String> {
        match self.vals.get(&v) {
            Some(Val::Buf(i)) => Ok(*i),
            _ => Err(String::from("not a memref")),
        }
    }

    fn int(&self, v: ValueId) -> Result<i64, String> {
        match self.scalar(v)?.0 {
            Scalar::Int(i) => Ok(i.signed() as i64),
            Scalar::Float(_) => Err(String::from("not an integer")),
        }
    }

    /// Runs `@main`; `launch` runs one kernel on the buffers.
    fn run(&mut self, main: OpId, launch: &mut dyn FnMut(&str, &str, [i64; 3], &mut [Buf]) -> Result<(), String>) -> Result<(), String> {
        let b = self.body;
        let block = b[b[main].regions[0]].blocks[0];
        for op in b[block].ops.clone() {
            let d = &b[op];
            let res = d.results.first().copied();
            match &*d.name {
                "arith.constant" => {
                    let c = Const::try_from(d.get("value").ok_or("no value")?).map_err(|_| String::from("bad constant"))?;
                    let ty = c.ty.owned();
                    let v = if c.elements { Val::Elements(c.values.clone(), ty) } else { Val::Scalar(c.values[0], ty) };
                    self.vals.insert(res.unwrap(), v);
                }
                "memref.alloc" => {
                    let t = b[res.unwrap()].ty.clone();
                    let shape: Vec<i64> = t.shape().ok_or("unranked alloc")?.iter().map(|d| i64::from(d)).collect();
                    let elem = t.element_type().owned();
                    let n: i64 = shape.iter().product();
                    self.bufs.push(Buf { data: vec![0; n as usize * Buf::size(&elem)], elem, shape });
                    self.vals.insert(res.unwrap(), Val::Buf(self.bufs.len() - 1));
                }
                "memref.cast" => {
                    let i = self.buf(d.operands[0])?;
                    self.vals.insert(res.unwrap(), Val::Buf(i));
                }
                "vector.store" => {
                    let Some(Val::Elements(es, _)) = self.vals.get(&d.operands[0]).cloned() else { return Err(String::from("vector.store of what")) };
                    let i = self.buf(d.operands[1])?;
                    let idx: Vec<i64> = d.operands[2..].iter().map(|v| self.int(*v)).collect::<Result<_, _>>()?;
                    let shape = self.bufs[i].shape.clone();
                    let lin = idx.iter().zip(0..).fold(0i64, |acc, (x, k)| acc + x * shape[k + 1..].iter().product::<i64>());
                    for (j, e) in es.iter().enumerate() {
                        self.bufs[i].put(lin as usize + j, *e);
                    }
                }
                "func.call" => {
                    let callee = match d.get("callee") {
                        Some(Attribute::SymbolRef(p)) => p[0].to_string(),
                        _ => return Err(String::from("call of what")),
                    };
                    let i = self.buf(d.operands[0])?;
                    if callee.starts_with("fillResource") {
                        let (s, _) = self.scalar(d.operands[1])?;
                        let n = self.bufs[i].data.len() / Buf::size(&self.bufs[i].elem);
                        for k in 0..n {
                            self.bufs[i].put(k, s);
                        }
                    } else if callee.starts_with("printMemref") {
                        self.out.push_str(&self.bufs[i].print());
                    } else {
                        return Err(format!("call to @{callee}"));
                    }
                }
                "gpu.launch_func" => {
                    let seg = b.segments(op, "operandSegmentSizes").ok_or("no segments")?;
                    let start = |g: usize| seg[..g].iter().sum::<usize>();
                    let grid = [self.int(d.operands[start(1)])?, self.int(d.operands[start(2)])?, self.int(d.operands[start(3)])?];
                    let Some(Attribute::SymbolRef(k)) = d.get("kernel") else { return Err(String::from("no kernel")) };
                    let (module, kernel) = (k[0].to_string(), k[1].to_string());
                    let args: Vec<ValueId> = d.operands[start(11)..start(11) + seg[11]].to_vec();
                    let mut bufs = Vec::new();
                    for a in &args {
                        match self.vals.get(a) {
                            Some(Val::Buf(i)) => bufs.push(self.bufs[*i].clone()),
                            Some(Val::Scalar(s, _)) => {
                                let mut sb = Buf { elem: Type::int(32), shape: vec![1], data: vec![0; 4] };
                                sb.put(0, *s);
                                bufs.push(sb);
                            }
                            _ => return Err(String::from("kernel argument of what")),
                        }
                    }
                    launch(&module, &kernel, grid, &mut bufs)?;
                    for (a, nb) in args.iter().zip(bufs) {
                        if let Some(Val::Buf(i)) = self.vals.get(a) {
                            self.bufs[*i].data = nb.data;
                        }
                    }
                }
                "func.return" => break,
                n => return Err(format!("host op '{n}'")),
            }
        }
        Ok(())
    }
}

/// Runs `spv` on lavapipe over `bufs`.
fn device(vkrun: &Path, dir: &Path, spv: &[u8], entry: &str, grid: [i64; 3], bufs: &mut [Buf]) -> Result<(), String> {
    let shader = dir.join("shader.spv");
    fs::write(&shader, spv).map_err(|e| e.to_string())?;
    let files: Vec<PathBuf> = (0..bufs.len()).map(|i| dir.join(format!("buf{i}.bin"))).collect();
    for (f, b) in files.iter().zip(bufs.iter()) {
        fs::write(f, &b.data).map_err(|e| e.to_string())?;
    }
    let out = Command::new(vkrun).env("VK_ICD_FILENAMES", LAVAPIPE).arg(&shader).arg(entry).args(grid.iter().map(|g| g.to_string())).args(&files).output().map_err(|e| e.to_string())?;
    if !out.status.success() {
        return Err(format!("vkrun: {}", String::from_utf8_lossy(&out.stderr).trim()));
    }
    for (f, b) in files.iter().zip(bufs.iter_mut()) {
        b.data = fs::read(f).map_err(|e| e.to_string())?;
    }
    Ok(())
}

fn tool(cmd: &str) -> bool {
    Command::new(cmd).arg("--version").output().is_ok()
}

#[test]
fn vulkan_integration() {
    if !tool("cc") || !tool("glslangValidator") || !Path::new(LAVAPIPE).exists() {
        eprintln!("cc, glslangValidator or lavapipe missing: skipped");
        return;
    }
    let target = Path::new(env!("CARGO_MANIFEST_DIR")).join("target/vulkan");
    fs::create_dir_all(&target).unwrap();
    let vkrun = target.join("vkrun");
    let built = Command::new("cc").args(["-O1", "-o"]).arg(&vkrun).arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/support/vkrun.c")).arg("-lvulkan").status().unwrap();
    assert!(built.success(), "vkrun does not build");

    let (opt, interfaces, passes) = (mlirpass::mlirformat::MlirOpt::upstream(), Interfaces::upstream(), Passes::upstream());
    let ctx = Ctx::new(&opt, &interfaces);
    let filter = std::env::var("FILTER").ok();
    let show = std::env::var_os("SHOW").is_some();
    let mut stems: Vec<String> = fs::read_dir(Fixtures::dir()).unwrap().filter_map(|e| e.ok()?.file_name().into_string().ok()?.strip_suffix(".check").map(str::to_owned)).collect();
    stems.sort();
    let (mut passed, mut failed) = (0, Vec::new());
    for stem in stems.iter().filter(|s| filter.as_deref().is_none_or(|f| s.contains(f))) {
        let check = fs::read_to_string(Fixtures::dir().join(format!("{stem}.check"))).unwrap();
        let checks: Vec<String> = check.lines().filter(|l| l.starts_with("CHECK")).map(str::to_owned).collect();
        let text = fs::read_to_string(Fixtures::dir().join(format!("{stem}.in.mlir"))).unwrap();
        let dir = target.join(stem);
        fs::create_dir_all(&dir).unwrap();
        let result = (|| -> Result<(String, String), String> {
            if check.lines().next().is_some_and(|l| l.trim() != "PIPELINE:") {
                return Err(format!("runner pipeline option `{}`", check.lines().next().unwrap_or("")));
            }
            let mut body = Body::parse(ctx, &text).map_err(|e| e.0)?;
            let pipeline = "--pass-pipeline=builtin.module(convert-gpu-to-spirv,spirv.module(spirv-lower-abi-attrs,spirv-update-vce))";
            let inv = Invocation::parse(&passes, &[pipeline]).map_err(|e| e.0)?;
            let root = body.root;
            inv.pipeline.run_on(&mut body, root, &Serial).map_err(|e| e.0)?;
            let top = body.top_block(root);
            let module_of = |name: &str| body[top].ops.iter().copied().find(|o| body[*o].name == "spirv.module" && body[*o].get("sym_name").is_some_and(|a| matches!(a, Attribute::Str { lit, .. } if **lit == *format!("__spv__{name}"))));
            let main = body[top].ops.iter().copied().find(|o| body[*o].name == "func.func" && matches!(body[*o].get("sym_name"), Some(Attribute::Str { lit, .. }) if &**lit == "main")).ok_or("no @main")?;
            let mut outputs = Vec::new();
            for glsl in [false, true] {
                let mut host = Host { body: &body, bufs: Vec::new(), vals: BTreeMap::new(), out: String::new() };
                host.run(main, &mut |module, kernel, grid, bufs| {
                    let m = module_of(module).ok_or_else(|| format!("no spirv.module for @{module}"))?;
                    if !glsl {
                        let words = SpirvBinary::default().emit(&body, m).map_err(|e| e.0)?;
                        return device(&vkrun, &dir, &SpirvBinary::bytes(&words), kernel, grid, bufs);
                    }
                    let src = SpirvGlsl.emit(&body, m).map_err(|e| e.0)?;
                    let comp = dir.join("kernel.comp");
                    fs::write(&comp, &src).map_err(|e| e.to_string())?;
                    let spv = dir.join("glsl.spv");
                    let out = Command::new("glslangValidator").args(["-V", "--target-env", "vulkan1.1", "-o"]).arg(&spv).arg(&comp).output().map_err(|e| e.to_string())?;
                    if !out.status.success() {
                        return Err(format!("glslang: {}", String::from_utf8_lossy(&out.stdout).lines().filter(|l| l.contains("ERROR")).collect::<Vec<_>>().join(" | ")));
                    }
                    device(&vkrun, &dir, &fs::read(&spv).map_err(|e| e.to_string())?, "main", grid, bufs)
                })?;
                outputs.push(host.out);
            }
            Ok((outputs.remove(0), outputs.remove(0)))
        })();
        match result {
            Ok((spv, glsl)) => {
                if show {
                    eprintln!("{stem} (SPIR-V):\n{spv}{stem} (GLSL):\n{glsl}");
                }
                match (file_check(&checks, &spv), file_check(&checks, &glsl)) {
                    (Ok(()), Ok(())) => passed += 1,
                    (a, g) => failed.push(format!("{stem}: SPIR-V {}, GLSL {}", a.err().unwrap_or_else(|| "ok".into()), g.err().unwrap_or_else(|| "ok".into()))),
                }
            }
            Err(e) => failed.push(format!("{stem}: {e}")),
        }
    }
    eprintln!("{passed} of {} Vulkan tests pass their checks, as SPIR-V and as GLSL", passed + failed.len());
    for f in &failed {
        eprintln!("  {f}");
    }
}
