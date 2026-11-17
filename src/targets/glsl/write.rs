use alloc::boxed::Box;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::{String, ToString};
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpFPredicate, CmpIPredicate};
use mlirformat::glsl::{Builtin, Derivative, GlslCall, GlslDeriv, GlslGlobal, GlslShader, GlslStage, GlslTexture, Interpolation, Lod, Precision, Storage};
use mlirformat::spirv_types::{SpirvMember, SpirvType};
use mlirformat::{Attribute, Const, Error, FloatKind, Operation, Scalar, Signedness, Type};

use mlirformat::{BlockId, Ir, OpId, RegionId, ValueId};

fn err<T>(msg: impl Into<String>) -> Result<T, Error> {
    Err(Error(format!("glsl: {}", msg.into())))
}

/// The version GLSL ES 1.00 is (`#version 100`): attributes and varyings, `texture2D`, no layouts
const ES100: u32 = 100;
/// The version from which integers may be unsigned and floats are written from their bits
const ES300: u32 = 300;
/// The GLSL letters of a vector's lanes
const LANES: [char; 4] = ['x', 'y', 'z', 'w'];
/// The largest vector
const VEC_MAX: usize = 4;
/// The value `vector.extract` has in `static_position` for a lane given as an operand
const DYNAMIC_LANE: i64 = i64::MIN;
/// The attribute a selection's header branch carries: its merge block's index in the region
const SELECTION_MERGE: &str = "selection_merge";
/// A uniform block is named after its instance and this (the two may not share a name)
const BLOCK_SUFFIX: &str = "_Block";
/// A struct's name is this and a hash of its layout-free type
const STRUCT_PREFIX: &str = "S_";
/// FNV-1a, 32 bits: a struct's name from its type
const FNV_OFFSET: u32 = 0x811c_9dc5;
const FNV_PRIME: u32 = 0x0100_0193;

/// Where a branch leads inside a loop: the loop's continue block, its merge block, and how leaving
/// it is spelled from where the branch is
#[derive(Clone, Copy)]
struct Loop {
    header: BlockId,
    cont: BlockId,
    merge: BlockId,
}

/// A sampler type's shape
struct SamplerShape {
    prefix: &'static str,
    dim: &'static str,
    shadow: bool,
    arrayed: bool,
}

/// Writes a `glsl.shader` op as GLSL source
pub struct Writer<'o, 'a> {
    ir: Ir<'o, 'a>,
    stage: GlslStage,
    version: u32,
    es: bool,
    /// Each value's defining op
    def: BTreeMap<ValueId, OpId>,
    /// Globals by name: their type, whether a uniform block, whether an interface (in / out /
    /// uniform), where a signless `i32` is a `uint`
    globals: BTreeMap<String, (Type<'a>, bool, bool)>,
    /// Structs, by their layout-free type: name and definition, in dependency order
    structs: Vec<(String, String)>,
    struct_names: BTreeMap<String, String>,
    samplers: BTreeSet<String>,
    // Per function
    exprs: BTreeMap<ValueId, String>,
    decls: Vec<String>,
    body: Vec<String>,
    depth: usize,
    temps: usize,
}

impl<'o, 'a> Writer<'o, 'a> {
    pub fn new(shader: &'o Operation<'a>) -> Result<Self, Error> {
        if shader.name != "glsl.shader" {
            return err(format!("writing GLSL takes a glsl.shader op, not {}", shader.name));
        }
        let head = GlslShader::try_from(shader)?;
        let ir = Ir::new(shader)?;
        let mut def = BTreeMap::new();
        let (ops, ..) = ir.counts();
        for o in 0..ops {
            let id = OpId(o as u32);
            for r in &ir[id].results {
                def.insert(*r, id);
            }
        }
        Ok(Writer { ir, stage: head.stage, version: head.version, es: head.es, def, globals: BTreeMap::new(), structs: Vec::new(), struct_names: BTreeMap::new(), samplers: BTreeSet::new(), exprs: BTreeMap::new(), decls: Vec::new(), body: Vec::new(), depth: 0, temps: 0 })
    }

    fn modern(&self) -> bool {
        self.version >= ES300 || !self.es
    }

    pub fn write(mut self) -> Result<String, Error> {
        let top = self.ir.top_block(self.ir.root);
        let mut globals = Vec::new();
        let mut funcs = Vec::new();
        let mut protos = Vec::new();
        for o in self.ir[top].ops.clone() {
            match self.ir[o].name {
                "glsl.global" => {
                    if let Some(g) = self.global(o)? {
                        globals.push(g);
                    }
                }
                "func.func" => {
                    let (proto, text) = self.function(o)?;
                    protos.extend(proto);
                    funcs.push(text);
                }
                other => return err(format!("a {other} at a shader's top level")),
            }
        }
        let mut out = format!("#version {}{}\n", self.version, if self.es && self.version >= ES300 { " es" } else { "" });
        if self.es {
            out.push_str("precision highp float;\nprecision highp int;\n");
            for s in &self.samplers {
                out.push_str(&format!("precision highp {s};\n"));
            }
        }
        for (_, def) in &self.structs {
            out.push_str(def);
        }
        for g in globals {
            out.push_str(&g);
        }
        for p in protos {
            out.push_str(&p);
        }
        for f in funcs {
            out.push_str(&f);
        }
        Ok(out)
    }

    // Types

    /// The type without layout (offsets, strides, decorations): what names a struct
    fn bare(t: &Type<'_>) -> Type<'static> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Struct { members: Some(ms), .. }) => SpirvType::Struct { name: None, members: Some(ms.iter().map(|m| SpirvMember { ty: Self::bare(&m.ty), offset: None, decorations: Vec::new() }).collect()), decorations: Vec::new() }.into(),
            Ok(SpirvType::Array { len, elem, .. }) => SpirvType::Array { len, elem: Box::new(Self::bare(&elem)), stride: 0 }.into(),
            Ok(SpirvType::Matrix { cols, column }) => SpirvType::Matrix { cols, column: Box::new(Self::bare(&column)) }.into(),
            _ => mlirformat::IntoStatic::into_static(t.clone()),
        }
    }

    fn scalar(t: &Type<'_>, global: bool) -> Result<&'static str, Error> {
        Ok(match t {
            Type::Float(FloatKind::F32) => "float",
            Type::Integer { width: 1, .. } => "bool",
            Type::Integer { signedness: Signedness::Signless, width: 32 } if global => "uint",
            Type::Integer { width: 32, .. } => "int",
            _ => return err(format!("no GLSL scalar is {t}")),
        })
    }

    /// The type's name; an array's is its element's, its sizes are `dims`
    fn ty(&mut self, t: &Type<'a>, global: bool) -> Result<String, Error> {
        let (base, dims) = self.declarator(t, global)?;
        Ok(format!("{base}{dims}"))
    }

    /// A declaration's type and the array sizes that follow its name
    fn declarator(&mut self, t: &Type<'a>, global: bool) -> Result<(String, String), Error> {
        if let Ok(st) = SpirvType::try_from(t) {
            return Ok(match st {
                SpirvType::Array { len, elem, .. } => {
                    let (b, d) = self.declarator(&elem, global)?;
                    (b, format!("[{len}]{d}"))
                }
                SpirvType::Matrix { cols, column } => {
                    let rows = Self::lanes(&column);
                    (if rows as u32 == cols { format!("mat{cols}") } else { format!("mat{cols}x{rows}") }, String::new())
                }
                SpirvType::Struct { members: Some(ms), .. } => (self.structure(t, &ms, global)?, String::new()),
                SpirvType::SampledImage(img) => {
                    let s = Self::sampler(&img)?;
                    let name = format!("{}sampler{}{}{}", s.prefix, s.dim, if s.arrayed { "Array" } else { "" }, if s.shadow { "Shadow" } else { "" });
                    self.samplers.insert(name.clone());
                    (name, String::new())
                }
                other => return err(format!("no GLSL type is {}", Type::from(other))),
            });
        }
        Ok(match t {
            Type::Shaped(s) => {
                let n = Self::lanes(t);
                let prefix = match &*s.elem {
                    Type::Float(_) => "",
                    Type::Integer { width: 1, .. } => "b",
                    Type::Integer { signedness: Signedness::Signless, .. } if global => "u",
                    _ => "i",
                };
                (format!("{prefix}vec{n}"), String::new())
            }
            t => (String::from(Self::scalar(t, global)?), String::new()),
        })
    }

    fn lanes(t: &Type<'_>) -> usize {
        match t {
            Type::Shaped(s) => s.shape.as_ref().and_then(|d| d.first()).map_or(1, |d| match d {
                mlirformat::Dim::Static(n) | mlirformat::Dim::Scalable(n) => *n as usize,
                mlirformat::Dim::Dynamic => 1,
            }),
            _ => 1,
        }
    }

    fn sampler(img: &Type<'_>) -> Result<SamplerShape, Error> {
        let Ok(SpirvType::Image { elem, params }) = SpirvType::try_from(img) else { return err(format!("{img} is not an image")) };
        let prefix = match &*elem {
            Type::Float(_) => "",
            Type::Integer { signedness: Signedness::Signless, .. } => "u",
            _ => "i",
        };
        let dim = match (params[0].as_str(), params[2].as_str()) {
            ("Dim2D", _) => "2D",
            ("Dim3D", _) => "3D",
            ("Cube", _) => "Cube",
            (d, _) => return err(format!("no GLSL sampler is {d}")),
        };
        Ok(SamplerShape { prefix, dim, shadow: params[1] == "IsDepth", arrayed: params[2] == "Arrayed" })
    }

    fn structure(&mut self, t: &Type<'a>, members: &[SpirvMember<'a>], global: bool) -> Result<String, Error> {
        let key = Self::bare(t).to_string();
        if let Some(n) = self.struct_names.get(&key) {
            return Ok(n.clone());
        }
        let mut hash = FNV_OFFSET;
        for b in key.bytes() {
            hash = (hash ^ u32::from(b)).wrapping_mul(FNV_PRIME);
        }
        let name = format!("{STRUCT_PREFIX}{hash:08x}");
        let mut def = format!("struct {name} {{\n");
        for (k, m) in members.iter().enumerate() {
            let (b, d) = self.declarator(&m.ty, global)?;
            def.push_str(&format!("    {b} m{k}{d};\n"));
        }
        def.push_str("};\n");
        self.struct_names.insert(key, name.clone());
        self.structs.push((name.clone(), def));
        Ok(name)
    }

    // Globals

    fn global(&mut self, o: OpId) -> Result<Option<String>, Error> {
        let g = GlslGlobal::try_from(self.ir[o].op)?;
        let name = match &g.sym_name {
            Attribute::Str { .. } => g.sym_name.text()?,
            other => other.to_string().trim_start_matches('@').to_string(),
        };
        let block = matches!(SpirvType::try_from(&g.ty), Ok(SpirvType::Struct { ref decorations, .. }) if decorations.iter().any(|d| d.name == "Block"));
        let interface = g.storage != Storage::Private;
        self.globals.insert(name.clone(), (g.ty.clone(), block, interface));
        if g.builtin.is_some() {
            return Ok(None);
        }
        let modern = self.modern() && self.version != ES100;
        let mut layout = Vec::new();
        if modern {
            if block {
                layout.push(String::from("std140"));
            }
            if let Some(l) = g.location {
                layout.push(format!("location = {l}"));
            }
            if let Some(b) = g.binding {
                layout.push(format!("binding = {b}"));
            }
        }
        let mut q = String::new();
        if !layout.is_empty() {
            q.push_str(&format!("layout({}) ", layout.join(", ")));
        }
        if g.invariant {
            q.push_str("invariant ");
        }
        match g.interpolation {
            Some(Interpolation::Flat) => q.push_str("flat "),
            Some(Interpolation::Smooth) => q.push_str("smooth "),
            None => {}
        }
        if g.centroid {
            q.push_str("centroid ");
        }
        q.push_str(match (g.storage, modern, self.stage) {
            (Storage::In, true, _) => "in ",
            (Storage::Out, true, _) => "out ",
            (Storage::In, false, GlslStage::Vertex) => "attribute ",
            (Storage::In | Storage::Out, false, _) => "varying ",
            (Storage::Uniform, ..) => "uniform ",
            (Storage::Private, ..) => "",
        });
        if let Some(p) = g.precision {
            q.push_str(match p {
                Precision::Lowp => "lowp ",
                Precision::Mediump => "mediump ",
                Precision::Highp => "highp ",
            });
        }
        let ty = g.ty.clone();
        if block {
            let Ok(SpirvType::Struct { members: Some(ms), .. }) = SpirvType::try_from(&ty) else { unreachable!("a block is a struct") };
            let mut text = format!("{q}{name}{BLOCK_SUFFIX} {{\n");
            for (k, m) in ms.iter().enumerate() {
                let (b, d) = self.declarator(&m.ty, true)?;
                text.push_str(&format!("    {b} m{k}{d};\n"));
            }
            text.push_str(&format!("}} {name};\n"));
            return Ok(Some(text));
        }
        let (b, d) = self.declarator(&ty, interface)?;
        Ok(Some(format!("{q}{b} {name}{d};\n")))
    }

    // Functions

    fn line(&mut self, s: impl Into<String>) {
        let pad = "    ".repeat(self.depth + 1);
        self.body.push(format!("{pad}{}", s.into()));
    }

    fn symbol(a: &Attribute<'_>) -> Result<String, Error> {
        let s = match a {
            Attribute::Str { .. } => a.text()?,
            Attribute::SymbolRef(p) => p.first().map(|x| x.trim_start_matches('@').trim_matches('"').to_string()).unwrap_or_default(),
            other => return err(format!("{other} is not a symbol")),
        };
        Ok(String::from(s.split('.').next().unwrap_or(&s)))
    }

    /// The function's prototype (unless `main`) and its text
    fn function(&mut self, o: OpId) -> Result<(Option<String>, String), Error> {
        let n = &self.ir[o];
        let name = Self::symbol(n.get("sym_name").ok_or_else(|| Error(String::from("glsl: a function without a name")))?)?;
        let Some(Attribute::Type(Type::Function(fty))) = n.get("function_type").cloned() else { return err(format!("{name}: no function type")) };
        let entry = self.ir.top_block(o);
        self.exprs.clear();
        self.decls.clear();
        self.body.clear();
        self.depth = 0;
        let mut params = Vec::new();
        for (k, a) in self.ir[entry].args.clone().into_iter().enumerate() {
            let ty = self.ir[a].ty.clone();
            let pname = format!("_a{k}");
            let text = match SpirvType::try_from(&ty) {
                Ok(SpirvType::Ptr { pointee, .. }) => {
                    let (b, d) = self.declarator(&pointee, false)?;
                    format!("inout {b} {pname}{d}")
                }
                _ => {
                    let (b, d) = self.declarator(&ty, false)?;
                    format!("{b} {pname}{d}")
                }
            };
            params.push(text);
            self.exprs.insert(a, pname);
        }
        let ret = match fty.results.first() {
            Some(t) => {
                let t = t.clone();
                self.ty(&t, false)?
            }
            None => String::from("void"),
        };
        let region = self.ir[o].regions[0];
        self.region(region, None)?;
        let sig = format!("{ret} {name}({})", params.join(", "));
        let mut text = format!("{sig} {{\n");
        for d in &self.decls {
            text.push_str(&format!("    {d}\n"));
        }
        for l in &self.body {
            text.push_str(l);
            text.push('\n');
        }
        text.push_str("}\n");
        let proto = (name != "main").then(|| format!("{sig};\n"));
        Ok((proto, text))
    }

    fn region(&mut self, r: RegionId, lp: Option<Loop>) -> Result<(), Error> {
        let first = self.ir[r].blocks[0];
        self.blocks(r, first, &[], lp)
    }

    fn block_at(&self, r: RegionId, k: i64) -> Result<BlockId, Error> {
        self.ir[r].blocks.get(k as usize).copied().ok_or_else(|| Error(String::from("glsl: a merge block out of its region")))
    }

    /// Writes the blocks from `b` on until one of `stop`, following branches
    fn blocks(&mut self, r: RegionId, mut b: BlockId, stop: &[BlockId], lp: Option<Loop>) -> Result<(), Error> {
        loop {
            if stop.contains(&b) {
                return Ok(());
            }
            if self.jump(r, b, lp)? {
                return Ok(());
            }
            let ops = self.ir[b].ops.clone();
            let Some((&term, body)) = ops.split_last() else { return Ok(()) };
            for o in body {
                self.op(*o)?;
            }
            let t = &self.ir[term];
            match t.name {
                "spirv.Branch" => b = t.successors[0],
                "spirv.BranchConditional" => {
                    let (c, yes, no) = (self.value(t.operands[0])?, t.successors[0], t.successors[1]);
                    match t.get(SELECTION_MERGE) {
                        Some(m) => {
                            let k = Self::int(m).ok_or_else(|| Error(String::from("glsl: a selection merge that is not a block")))?;
                            let merge = self.block_at(r, k)?;
                            let mut inner = stop.to_vec();
                            inner.push(merge);
                            self.line(format!("if ({c}) {{"));
                            self.depth += 1;
                            self.blocks(r, yes, &inner, lp)?;
                            self.depth -= 1;
                            if no != merge {
                                self.line("} else {");
                                self.depth += 1;
                                self.blocks(r, no, &inner, lp)?;
                                self.depth -= 1;
                            }
                            self.line("}");
                            b = merge;
                        }
                        None => {
                            let exits = |x: BlockId| lp.is_some_and(|l| x == l.cont || x == l.merge);
                            match (exits(yes), exits(no)) {
                                (true, true) => {
                                    self.line(format!("if ({c}) {{"));
                                    self.depth += 1;
                                    self.jump(r, yes, lp)?;
                                    self.depth -= 1;
                                    self.line("} else {");
                                    self.depth += 1;
                                    self.jump(r, no, lp)?;
                                    self.depth -= 1;
                                    self.line("}");
                                    return Ok(());
                                }
                                (false, true) => {
                                    self.line(format!("if (!({c})) {{"));
                                    self.depth += 1;
                                    self.jump(r, no, lp)?;
                                    self.depth -= 1;
                                    self.line("}");
                                    b = yes;
                                }
                                (true, false) => {
                                    self.line(format!("if ({c}) {{"));
                                    self.depth += 1;
                                    self.jump(r, yes, lp)?;
                                    self.depth -= 1;
                                    self.line("}");
                                    b = no;
                                }
                                (false, false) => return err("a two-way branch with no merge and no loop exit"),
                            }
                        }
                    }
                }
                _ => {
                    self.op(term)?;
                    return Ok(());
                }
            }
        }
    }

    /// A branch to `b` that leaves the loop (`break`) or goes on to its next iteration (the
    /// continue block's code, then `continue`); whether it was one
    fn jump(&mut self, r: RegionId, b: BlockId, lp: Option<Loop>) -> Result<bool, Error> {
        let Some(l) = lp else { return Ok(false) };
        if b == l.merge {
            self.line("break;");
            return Ok(true);
        }
        if b == l.cont {
            self.blocks(r, l.cont, &[l.header], None)?;
            self.line("continue;");
            return Ok(true);
        }
        Ok(false)
    }

    fn int(a: &Attribute<'_>) -> Option<i64> {
        match Const::try_from(&Self::typed_int(a)).ok()?.values[0] {
            Scalar::Int(i) => Some(i.signed() as i64),
            _ => None,
        }
    }

    fn typed_int<'x>(a: &Attribute<'x>) -> Attribute<'x> {
        match a {
            Attribute::Int { lit, ty: None } => Attribute::Int { lit: lit.clone(), ty: Some(Type::int(64)) },
            other => other.clone(),
        }
    }

    /// A temporary holding `v`, declared at the function's start
    fn temp(&mut self, v: ValueId) -> Result<String, Error> {
        let ty = self.ir[v].ty.clone();
        let (b, d) = self.declarator(&ty, false)?;
        let name = format!("_t{}", self.temps);
        self.temps += 1;
        self.decls.push(format!("{b} {name}{d};"));
        self.exprs.insert(v, name.clone());
        Ok(name)
    }

    fn value(&self, v: ValueId) -> Result<String, Error> {
        self.exprs.get(&v).cloned().ok_or_else(|| Error(String::from("glsl: a value used before it is written")))
    }

    fn values(&self, vs: &[ValueId]) -> Result<Vec<String>, Error> {
        vs.iter().map(|v| self.value(*v)).collect()
    }

    /// `x` as an unsigned value of `ty`'s shape, or back
    fn unsigned(ty: &Type<'_>, x: &str) -> String {
        match Self::lanes(ty) {
            1 if !matches!(ty, Type::Shaped(_)) => format!("uint({x})"),
            n => format!("uvec{n}({x})"),
        }
    }

    fn signed(ty: &Type<'_>, x: &str) -> String {
        match ty {
            Type::Shaped(_) => format!("ivec{}({x})", Self::lanes(ty)),
            _ => format!("int({x})"),
        }
    }

    /// The GLSL type of `ty` as a constructor
    fn ctor(&mut self, ty: &Type<'a>) -> Result<String, Error> {
        self.ty(ty, false)
    }

    fn assign(&mut self, v: ValueId, expr: String) -> Result<(), Error> {
        let t = self.temp(v)?;
        self.line(format!("{t} = {expr};"));
        Ok(())
    }

    fn op(&mut self, o: OpId) -> Result<(), Error> {
        let n = &self.ir[o];
        let (name, operands, results) = (n.name, n.operands.clone(), n.results.clone());
        let rty = results.first().map(|r| self.ir[*r].ty.clone());
        let arg = |w: &Self, k: usize| w.value(operands[k]);
        match name {
            "arith.constant" => {
                let value = n.get("value").cloned().ok_or_else(|| Error(String::from("glsl: a constant without a value")))?;
                let ty = rty.clone().unwrap_or(Type::I1);
                let text = self.constant(&value, &ty)?;
                self.exprs.insert(results[0], text);
            }
            "spirv.Variable" => {
                let ty = rty.clone().unwrap_or(Type::I1);
                let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&ty) else { return err("a variable that is not a pointer") };
                let (b, d) = self.declarator(&pointee, false)?;
                let name = format!("_v{}", self.temps);
                self.temps += 1;
                self.decls.push(format!("{b} {name}{d};"));
                self.exprs.insert(results[0], name);
            }
            "spirv.AccessChain" => {
                let base = self.value(operands[0])?;
                let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&self.ir[operands[0]].ty.clone()) else { return err("an access chain off a non-pointer") };
                let path = self.path(&pointee, &operands[1..])?;
                self.exprs.insert(results[0], format!("{base}{path}"));
            }
            "spirv.Load" => {
                let p = arg(self, 0)?;
                self.assign(results[0], p)?;
            }
            "spirv.Store" => {
                let (p, v) = (arg(self, 0)?, arg(self, 1)?);
                self.line(format!("{p} = {v};"));
            }
            "glsl.load" | "glsl.store" => {
                let var = Self::symbol(n.get("var").ok_or_else(|| Error(String::from("glsl: a load without a variable")))?)?;
                let (gty, _, interface) = self.globals.get(&var).cloned().ok_or_else(|| Error(format!("glsl: no global {var}")))?;
                let idx = if name == "glsl.load" { &operands[..] } else { &operands[1..] };
                let path = self.path(&gty, idx)?;
                let elem = self.element(&gty, idx);
                let uint = interface && Self::is_uint(&elem);
                let builtin = self.builtin_name(&var).unwrap_or(var.clone());
                let lv = format!("{builtin}{path}");
                if name == "glsl.load" {
                    let ty = rty.clone().unwrap_or(Type::I1);
                    if Self::opaque(&elem) {
                        self.exprs.insert(results[0], lv);
                    } else if uint {
                        let e = Self::signed(&ty, &lv);
                        self.assign(results[0], e)?;
                    } else {
                        self.assign(results[0], lv)?;
                    }
                } else {
                    let v = arg(self, 0)?;
                    let v = if uint { Self::unsigned(&elem, &v) } else { v };
                    self.line(format!("{lv} = {v};"));
                }
            }
            "glsl.construct" | "spirv.CompositeConstruct" => {
                let ty = rty.clone().unwrap_or(Type::I1);
                let c = self.ctor(&ty)?;
                let parts = self.values(&operands)?.join(", ");
                self.assign(results[0], format!("{c}({parts})"))?;
            }
            "spirv.CompositeExtract" => {
                let base = arg(self, 0)?;
                let ty = self.ir[operands[0]].ty.clone();
                let Some(Attribute::Array(ix)) = n.get("indices").cloned() else { return err("an extract without indices") };
                let mut path = String::new();
                let mut cur = ty;
                for i in &ix {
                    let k = Self::int(i).ok_or_else(|| Error(String::from("glsl: an extract index that is not an integer")))?;
                    let (step, next) = Self::step(&cur, &format!("{k}"), Some(k))?;
                    path.push_str(&step);
                    cur = next;
                }
                self.assign(results[0], format!("{base}{path}"))?;
            }
            "vector.extract" => {
                let base = arg(self, 0)?;
                let pos = match n.get("static_position") {
                    Some(Attribute::DenseArray { values, .. }) => values.first().and_then(|v| v.parse::<i64>().ok()).unwrap_or(DYNAMIC_LANE),
                    _ => DYNAMIC_LANE,
                };
                let e = if pos == DYNAMIC_LANE { format!("{base}[{}]", arg(self, 1)?) } else { format!("{base}.{}", LANES[pos as usize]) };
                self.assign(results[0], e)?;
            }
            "vector.insert" => {
                let (x, vec) = (arg(self, 0)?, arg(self, 1)?);
                let pos = match n.get("static_position") {
                    Some(Attribute::DenseArray { values, .. }) => values.first().and_then(|v| v.parse::<i64>().ok()).unwrap_or(DYNAMIC_LANE),
                    _ => DYNAMIC_LANE,
                };
                let t = self.temp(results[0])?;
                self.line(format!("{t} = {vec};"));
                let lane = if pos == DYNAMIC_LANE { format!("[{}]", arg(self, 2)?) } else { format!(".{}", LANES[pos as usize]) };
                self.line(format!("{t}{lane} = {x};"));
            }
            "vector.shuffle" => {
                let (a, b) = (arg(self, 0)?, arg(self, 1)?);
                let la = Self::lanes(&self.ir[operands[0]].ty);
                let Some(Attribute::DenseArray { values, .. }) = n.get("mask").cloned() else { return err("a shuffle without a mask") };
                let mask: Vec<usize> = values.iter().map(|v| v.parse().unwrap_or(0)).collect();
                let ty = rty.clone().unwrap_or(Type::I1);
                let e = if operands[0] == operands[1] || mask.iter().all(|m| *m < la) {
                    let sw: String = mask.iter().map(|m| LANES[*m % VEC_MAX]).collect();
                    format!("{a}.{sw}")
                } else {
                    let c = self.ctor(&ty)?;
                    let parts: Vec<String> = mask.iter().map(|m| if *m < la { format!("{a}.{}", LANES[*m]) } else { format!("{b}.{}", LANES[*m - la]) }).collect();
                    format!("{c}({})", parts.join(", "))
                };
                self.assign(results[0], e)?;
            }
            "arith.select" => {
                let (c, a, b) = (arg(self, 0)?, arg(self, 1)?, arg(self, 2)?);
                let e = if matches!(self.ir[operands[0]].ty, Type::Shaped(_)) { format!("mix({b}, {a}, {c})") } else { format!("{c} ? {a} : {b}") };
                self.assign(results[0], e)?;
            }
            "arith.addf" | "arith.addi" => self.binary(o, "+")?,
            "arith.subf" | "arith.subi" => self.binary(o, "-")?,
            "arith.mulf" | "arith.muli" => self.binary(o, "*")?,
            "arith.divf" | "arith.divsi" => self.binary(o, "/")?,
            "arith.remsi" => self.binary(o, "%")?,
            "arith.shli" => self.binary(o, "<<")?,
            "arith.shrsi" => self.binary(o, ">>")?,
            "arith.divui" => self.unsigned_binary(o, "/")?,
            "arith.remui" => self.unsigned_binary(o, "%")?,
            "arith.shrui" => self.unsigned_binary(o, ">>")?,
            "arith.andi" | "arith.ori" | "arith.xori" => {
                let bool_ = match &self.ir[operands[0]].ty {
                    Type::Shaped(sh) => matches!(*sh.elem, Type::Integer { width: 1, .. }),
                    t => matches!(t, Type::Integer { width: 1, .. }),
                };
                let (a, b) = (arg(self, 0)?, arg(self, 1)?);
                let ty = self.ir[operands[0]].ty.clone();
                let e = match (name, bool_, matches!(ty, Type::Shaped(_))) {
                    ("arith.andi", true, false) => format!("{a} && {b}"),
                    ("arith.ori", true, false) => format!("{a} || {b}"),
                    ("arith.xori", true, false) => format!("{a} != {b}"),
                    ("arith.xori", true, true) => format!("notEqual({a}, {b})"),
                    ("arith.andi", true, true) => {
                        let n = Self::lanes(&ty);
                        format!("bvec{n}(uvec{n}({a}) & uvec{n}({b}))")
                    }
                    ("arith.ori", true, true) => {
                        let n = Self::lanes(&ty);
                        format!("bvec{n}(uvec{n}({a}) | uvec{n}({b}))")
                    }
                    ("arith.andi", ..) => format!("{a} & {b}"),
                    ("arith.ori", ..) => format!("{a} | {b}"),
                    _ => format!("{a} ^ {b}"),
                };
                self.assign(results[0], e)?;
            }
            "arith.negf" => {
                let a = arg(self, 0)?;
                self.assign(results[0], format!("-{a}"))?;
            }
            "arith.cmpf" | "arith.cmpi" => {
                let (a, b) = (arg(self, 0)?, arg(self, 1)?);
                let ty = self.ir[operands[0]].ty.clone();
                let p = n.get("predicate").cloned().ok_or_else(|| Error(String::from("glsl: a comparison without a predicate")))?;
                let k = Self::int(&p).ok_or_else(|| Error(String::from("glsl: a predicate that is not an integer")))?;
                let (op, func, unsigned) = Self::predicate(name == "arith.cmpf", k)?;
                let (a, b) = if unsigned { (Self::unsigned(&ty, &a), Self::unsigned(&ty, &b)) } else { (a, b) };
                let e = if matches!(ty, Type::Shaped(_)) { format!("{func}({a}, {b})") } else { format!("{a} {op} {b}") };
                self.assign(results[0], e)?;
            }
            "arith.sitofp" | "arith.fptosi" | "arith.extsi" | "arith.extui" | "arith.trunci" => {
                let ty = rty.clone().unwrap_or(Type::I1);
                let c = self.ctor(&ty)?;
                let a = arg(self, 0)?;
                self.assign(results[0], format!("{c}({a})"))?;
            }
            "arith.uitofp" => {
                let ty = rty.clone().unwrap_or(Type::I1);
                let c = self.ctor(&ty)?;
                let a = Self::unsigned(&self.ir[operands[0]].ty.clone(), &arg(self, 0)?);
                self.assign(results[0], format!("{c}({a})"))?;
            }
            "arith.fptoui" => {
                let ty = rty.clone().unwrap_or(Type::I1);
                let a = arg(self, 0)?;
                let e = Self::signed(&ty, &Self::unsigned(&ty, &a));
                self.assign(results[0], e)?;
            }
            "arith.bitcast" => {
                let a = arg(self, 0)?;
                let ty = rty.clone().unwrap_or(Type::I1);
                let float = matches!(ty, Type::Float(_)) || matches!(&ty, Type::Shaped(s) if matches!(*s.elem, Type::Float(_)));
                let e = if float { format!("intBitsToFloat({a})") } else { format!("floatBitsToInt({a})") };
                self.assign(results[0], e)?;
            }
            "glsl.builtin" => self.builtin(o)?,
            "glsl.derivative" => {
                let d = GlslDeriv::try_from(self.ir[o].op)?;
                let f = match d.kind {
                    Derivative::Dfdx => "dFdx",
                    Derivative::Dfdy => "dFdy",
                    Derivative::Fwidth => "fwidth",
                };
                let a = arg(self, 0)?;
                self.assign(results[0], format!("{f}({a})"))?;
            }
            "glsl.texture" => self.texture(o)?,
            "glsl.texel_fetch" => {
                let vs = self.values(&operands)?;
                let offset = n.get("offset").is_some();
                let f = if offset { "texelFetchOffset" } else { "texelFetch" };
                let e = self.sampled(operands[0], format!("{f}({})", vs.join(", ")), rty.clone())?;
                self.assign(results[0], e)?;
            }
            "glsl.texture_size" => {
                let vs = self.values(&operands)?;
                self.assign(results[0], format!("textureSize({})", vs.join(", ")))?;
            }
            "glsl.discard" => self.line("discard;"),
            "func.call" => {
                let callee = Self::symbol(n.get("callee").ok_or_else(|| Error(String::from("glsl: a call without a callee")))?)?;
                let args = self.values(&operands)?.join(", ");
                match results.first() {
                    Some(r) => self.assign(*r, format!("{callee}({args})"))?,
                    None => self.line(format!("{callee}({args});")),
                }
            }
            "func.return" | "spirv.Return" | "spirv.ReturnValue" => match operands.first() {
                Some(v) => {
                    let v = self.value(*v)?;
                    self.line(format!("return {v};"));
                }
                None => self.line("return;"),
            },
            "spirv.Unreachable" | "spirv.mlir.merge" | "scf.yield" | "scf.condition" => {}
            "scf.if" => {
                let c = arg(self, 0)?;
                let rs = n.regions.clone();
                self.line(format!("if ({c}) {{"));
                self.depth += 1;
                self.region(rs[0], None)?;
                self.depth -= 1;
                let has_else = rs.get(1).is_some_and(|r| self.ir[*r].blocks.first().is_some_and(|b| self.ir[*b].ops.len() > 1));
                if has_else {
                    self.line("} else {");
                    self.depth += 1;
                    self.region(rs[1], None)?;
                    self.depth -= 1;
                }
                self.line("}");
            }
            "scf.while" => {
                let rs = n.regions.clone();
                self.line("for (;;) {");
                self.depth += 1;
                self.region(rs[0], None)?;
                let before = self.ir[rs[0]].blocks[0];
                let cond = self.ir.last_op(before).ok_or_else(|| Error(String::from("glsl: a while without a condition")))?;
                let c = self.value(self.ir[cond].operands[0])?;
                self.line(format!("if (!({c})) {{ break; }}"));
                self.region(rs[1], None)?;
                self.depth -= 1;
                self.line("}");
            }
            "spirv.mlir.loop" => self.flat_loop(o)?,
            other => return err(format!("writing {other} is not supported")),
        }
        Ok(())
    }

    fn binary(&mut self, o: OpId, op: &str) -> Result<(), Error> {
        let n = &self.ir[o];
        let (a, b, r) = (self.value(n.operands[0])?, self.value(n.operands[1])?, n.results[0]);
        self.assign(r, format!("{a} {op} {b}"))
    }

    fn unsigned_binary(&mut self, o: OpId, op: &str) -> Result<(), Error> {
        let n = &self.ir[o];
        let (a, b, r) = (self.value(n.operands[0])?, self.value(n.operands[1])?, n.results[0]);
        let ty = self.ir[r].ty.clone();
        let rhs_ty = self.ir[n.operands[1]].ty.clone();
        let e = Self::signed(&ty, &format!("{} {op} {}", Self::unsigned(&ty, &a), Self::unsigned(&rhs_ty, &b)));
        self.assign(r, e)
    }

    /// `(operator, vector function, compares as unsigned)` of a predicate
    fn predicate(float: bool, k: i64) -> Result<(&'static str, &'static str, bool), Error> {
        let lt = ("<", "lessThan");
        let le = ("<=", "lessThanEqual");
        let gt = (">", "greaterThan");
        let ge = (">=", "greaterThanEqual");
        let eq = ("==", "equal");
        let ne = ("!=", "notEqual");
        use CmpFPredicate as F;
        use CmpIPredicate as I;
        let floats = [(F::oeq, eq), (F::ueq, eq), (F::one, ne), (F::une, ne), (F::olt, lt), (F::ult, lt), (F::ole, le), (F::ule, le), (F::ogt, gt), (F::ugt, gt), (F::oge, ge), (F::uge, ge)];
        let ints = [(I::eq, eq, false), (I::ne, ne, false), (I::slt, lt, false), (I::sle, le, false), (I::sgt, gt, false), (I::sge, ge, false), (I::ult, lt, true), (I::ule, le, true), (I::ugt, gt, true), (I::uge, ge, true)];
        let ((op, f), u) = if float {
            (floats.iter().find(|(p, _)| *p as i64 == k).map(|(_, x)| *x).ok_or_else(|| Error(format!("glsl: float predicate {k}")))?, false)
        } else {
            ints.iter().find(|(p, ..)| *p as i64 == k).map(|(_, x, u)| (*x, *u)).ok_or_else(|| Error(format!("glsl: integer predicate {k}")))?
        };
        Ok((op, f, u))
    }

    fn builtin(&mut self, o: OpId) -> Result<(), Error> {
        let call = GlslCall::try_from(self.ir[o].op)?;
        let n = &self.ir[o];
        let (operands, r) = (n.operands.clone(), n.results[0]);
        let vs = self.values(&operands)?;
        let ty = self.ir[r].ty.clone();
        let tys: Vec<Type<'a>> = operands.iter().map(|v| self.ir[*v].ty.clone()).collect();
        let call_of = |f: &str| format!("{f}({})", vs.join(", "));
        let e = match call.func {
            Builtin::MatrixTimesMatrix | Builtin::MatrixTimesVector | Builtin::VectorTimesMatrix | Builtin::MatrixTimesScalar => format!("{} * {}", vs[0], vs[1]),
            Builtin::UMin | Builtin::UMax | Builtin::UClamp => {
                let f = match call.func {
                    Builtin::UMin => "min",
                    Builtin::UMax => "max",
                    _ => "clamp",
                };
                let args: Vec<String> = vs.iter().zip(&tys).map(|(v, t)| Self::unsigned(t, v)).collect();
                Self::signed(&ty, &format!("{f}({})", args.join(", ")))
            }
            Builtin::PackSnorm2x16 | Builtin::PackUnorm2x16 | Builtin::PackHalf2x16 => Self::signed(&ty, &call_of(Self::builtin_name_of(call.func))),
            Builtin::UnpackSnorm2x16 | Builtin::UnpackUnorm2x16 | Builtin::UnpackHalf2x16 => format!("{}({})", Self::builtin_name_of(call.func), Self::unsigned(&tys[0], &vs[0])),
            f => call_of(Self::builtin_name_of(f)),
        };
        self.assign(r, e)
    }

    fn builtin_name_of(f: Builtin) -> &'static str {
        match f {
            Builtin::Radians => "radians",
            Builtin::Degrees => "degrees",
            Builtin::Sin => "sin",
            Builtin::Cos => "cos",
            Builtin::Tan => "tan",
            Builtin::Asin => "asin",
            Builtin::Acos => "acos",
            Builtin::Atan | Builtin::Atan2 => "atan",
            Builtin::Sinh => "sinh",
            Builtin::Cosh => "cosh",
            Builtin::Tanh => "tanh",
            Builtin::Asinh => "asinh",
            Builtin::Acosh => "acosh",
            Builtin::Atanh => "atanh",
            Builtin::Exp => "exp",
            Builtin::Log => "log",
            Builtin::Exp2 => "exp2",
            Builtin::Log2 => "log2",
            Builtin::Sqrt => "sqrt",
            Builtin::InverseSqrt => "inversesqrt",
            Builtin::Abs => "abs",
            Builtin::Floor => "floor",
            Builtin::Trunc => "trunc",
            Builtin::Round => "round",
            Builtin::RoundEven => "roundEven",
            Builtin::Ceil => "ceil",
            Builtin::Min | Builtin::UMin => "min",
            Builtin::Max | Builtin::UMax => "max",
            Builtin::UClamp | Builtin::Clamp => "clamp",
            Builtin::Pow => "pow",
            Builtin::Sign => "sign",
            Builtin::Fract => "fract",
            Builtin::Mod => "mod",
            Builtin::Mix => "mix",
            Builtin::Step => "step",
            Builtin::Smoothstep => "smoothstep",
            Builtin::IsNan => "isnan",
            Builtin::IsInf => "isinf",
            Builtin::Length => "length",
            Builtin::Distance => "distance",
            Builtin::Dot => "dot",
            Builtin::Cross => "cross",
            Builtin::Normalize => "normalize",
            Builtin::Faceforward => "faceforward",
            Builtin::Reflect => "reflect",
            Builtin::Refract => "refract",
            Builtin::MatrixCompMult => "matrixCompMult",
            Builtin::OuterProduct => "outerProduct",
            Builtin::Transpose => "transpose",
            Builtin::Determinant => "determinant",
            Builtin::Inverse => "inverse",
            Builtin::PackSnorm2x16 => "packSnorm2x16",
            Builtin::UnpackSnorm2x16 => "unpackSnorm2x16",
            Builtin::PackUnorm2x16 => "packUnorm2x16",
            Builtin::UnpackUnorm2x16 => "unpackUnorm2x16",
            Builtin::PackHalf2x16 => "packHalf2x16",
            Builtin::UnpackHalf2x16 => "unpackHalf2x16",
            Builtin::MatrixTimesMatrix | Builtin::MatrixTimesVector | Builtin::VectorTimesMatrix | Builtin::MatrixTimesScalar => "*",
        }
    }

    /// A lookup's value: unsigned samplers give unsigned results, held as signed
    fn sampled(&self, sampler: ValueId, call: String, ty: Option<Type<'a>>) -> Result<String, Error> {
        let img = match SpirvType::try_from(&self.ir[sampler].ty) {
            Ok(SpirvType::SampledImage(i)) => i,
            _ => return err("a lookup off a non-sampler"),
        };
        let s = Self::sampler(&img)?;
        Ok(match (s.prefix, ty) {
            ("u", Some(t)) => Self::signed(&t, &call),
            _ => call,
        })
    }

    fn texture(&mut self, o: OpId) -> Result<(), Error> {
        let t = GlslTexture::try_from(self.ir[o].op)?;
        let n = &self.ir[o];
        let (operands, r) = (n.operands.clone(), n.results[0]);
        let vs = self.values(&operands)?;
        let img = match SpirvType::try_from(&self.ir[operands[0]].ty) {
            Ok(SpirvType::SampledImage(i)) => i,
            _ => return err("a lookup off a non-sampler"),
        };
        let shape = Self::sampler(&img)?;
        let (sampler, mut coord) = (vs[0].clone(), vs[1].clone());
        let mut rest = &vs[2..];
        if t.dref {
            let dref = rest[0].clone();
            rest = &rest[1..];
            let n = Self::lanes(&self.ir[operands[1]].ty);
            coord = if t.proj {
                let lanes: Vec<String> = (0..n - 1).map(|i| format!("{coord}.{}", LANES[i])).collect();
                format!("vec4({}, {dref}, {coord}.{})", lanes.join(", "), LANES[n - 1])
            } else {
                format!("vec{}({coord}, {dref})", n + 1)
            };
        }
        let (lod_args, offset) = if t.offset { (&rest[..rest.len() - 1], Some(rest[rest.len() - 1].clone())) } else { (rest, None) };
        let old = self.version == ES100;
        let base = if old {
            match (shape.dim, t.proj, t.lod) {
                ("Cube", _, Lod::Explicit) => String::from("textureCubeLod"),
                ("Cube", ..) => String::from("textureCube"),
                (_, true, Lod::Explicit) => String::from("texture2DProjLod"),
                (_, true, _) => String::from("texture2DProj"),
                (_, false, Lod::Explicit) => String::from("texture2DLod"),
                _ => String::from("texture2D"),
            }
        } else {
            let mut f = String::from(if t.proj { "textureProj" } else { "texture" });
            match t.lod {
                Lod::Explicit => f.push_str("Lod"),
                Lod::Grad => f.push_str("Grad"),
                _ => {}
            }
            if offset.is_some() {
                f.push_str("Offset");
            }
            f
        };
        let mut args = vec![sampler, coord];
        match t.lod {
            Lod::Bias => {
                args.extend(offset.clone());
                args.extend(lod_args.iter().cloned());
            }
            _ => {
                args.extend(lod_args.iter().cloned());
                args.extend(offset);
            }
        }
        let e = self.sampled(operands[0], format!("{base}({})", args.join(", ")), Some(self.ir[r].ty.clone()))?;
        self.assign(r, e)
    }

    /// `spirv.mlir.loop`: entry, header, the body's blocks, continue, merge
    fn flat_loop(&mut self, o: OpId) -> Result<(), Error> {
        let r = self.ir[o].regions[0];
        let blocks = self.ir[r].blocks.clone();
        let [entry, header, .., cont, merge] = blocks[..] else { return err("a loop region of fewer than four blocks") };
        let entry_term = self.ir.last_op(entry).ok_or_else(|| Error(String::from("glsl: an empty loop entry")))?;
        if self.ir[entry_term].successors.first() != Some(&header) {
            return err("a loop entry that does not go to its header");
        }
        self.line("for (;;) {");
        self.depth += 1;
        self.blocks(r, header, &[], Some(Loop { header, cont, merge }))?;
        self.depth -= 1;
        self.line("}");
        Ok(())
    }

    // Values

    /// The element `idx` reaches in a value of type `t`
    fn element(&self, t: &Type<'a>, idx: &[ValueId]) -> Type<'a> {
        let mut cur = t.clone();
        for v in idx {
            let k = self.const_of(*v);
            match Self::step(&cur, "", k) {
                Ok((_, next)) => cur = next,
                Err(_) => break,
            }
        }
        cur
    }

    fn is_uint(t: &Type<'_>) -> bool {
        match t {
            Type::Integer { signedness: Signedness::Signless, width: 32 } => true,
            Type::Shaped(s) => matches!(*s.elem, Type::Integer { signedness: Signedness::Signless, width: 32 }),
            _ => false,
        }
    }

    /// Opaque or aggregate of opaque: what cannot be copied into a temporary
    fn opaque(t: &Type<'_>) -> bool {
        match SpirvType::try_from(t) {
            Ok(SpirvType::SampledImage(_)) => true,
            Ok(SpirvType::Array { elem, .. }) => Self::opaque(&elem),
            _ => false,
        }
    }

    fn builtin_name(&self, var: &str) -> Option<String> {
        var.starts_with("gl_").then(|| String::from(var))
    }

    fn const_of(&self, v: ValueId) -> Option<i64> {
        let o = self.def.get(&v)?;
        (self.ir[*o].name == "arith.constant").then(|| self.ir[*o].get("value").and_then(Self::int)).flatten()
    }

    /// The text indexing `idx` into a value of type `t`
    fn path(&self, t: &Type<'a>, idx: &[ValueId]) -> Result<String, Error> {
        let mut out = String::new();
        let mut cur = t.clone();
        for v in idx {
            let k = self.const_of(*v);
            let text = self.value(*v)?;
            let (step, next) = Self::step(&cur, &text, k)?;
            out.push_str(&step);
            cur = next;
        }
        Ok(out)
    }

    /// One step into `t`: by `index` (text), a struct by its constant `k`
    fn step(t: &Type<'a>, index: &str, k: Option<i64>) -> Result<(String, Type<'a>), Error> {
        if let Ok(st) = SpirvType::try_from(t) {
            return Ok(match st {
                SpirvType::Array { elem, .. } => (format!("[{index}]"), *elem),
                SpirvType::Matrix { column, .. } => (format!("[{index}]"), *column),
                SpirvType::Struct { members: Some(ms), .. } => {
                    let k = k.ok_or_else(|| Error(String::from("glsl: a struct member chosen by a non-constant")))?;
                    let m = ms.into_iter().nth(k as usize).ok_or_else(|| Error(String::from("glsl: a struct member out of range")))?;
                    (format!(".m{k}"), m.ty)
                }
                other => return err(format!("indexing {}", Type::from(other))),
            });
        }
        match t {
            Type::Shaped(s) => Ok((format!("[{index}]"), (*s.elem).clone())),
            other => err(format!("indexing {other}")),
        }
    }

    fn constant(&mut self, value: &Attribute<'a>, ty: &Type<'a>) -> Result<String, Error> {
        let c = Const::try_from(value).map_err(|_| Error(format!("glsl: constant {value}")))?;
        let elem = match ty {
            Type::Shaped(s) => (*s.elem).clone(),
            t => t.clone(),
        };
        let lit = |s: Scalar, w: &Self| w.scalar_literal(s, &elem);
        if !matches!(ty, Type::Shaped(_)) {
            return lit(c.values[0], self);
        }
        let n = Self::lanes(ty);
        let ctor = self.ctor(ty)?;
        let parts: Vec<String> = if c.values.len() == 1 { vec![lit(c.values[0], self)?] } else { c.values.iter().take(n).map(|v| lit(*v, self)).collect::<Result<_, _>>()? };
        Ok(format!("{ctor}({})", parts.join(", ")))
    }

    fn scalar_literal(&self, s: Scalar, ty: &Type<'_>) -> Result<String, Error> {
        Ok(match (s, ty) {
            (Scalar::Int(i), Type::Integer { width: 1, .. }) => String::from(if i.is_zero() { "false" } else { "true" }),
            (Scalar::Int(i), _) => {
                let v = i.signed() as i64;
                if v == i64::from(i32::MIN) { String::from("(-2147483647 - 1)") } else if v < 0 { format!("({v})") } else { format!("{v}") }
            }
            (Scalar::Float(f), _) => {
                let x = f32::from_bits(f.bits as u32);
                if x.is_finite() {
                    let t = format!("{x:?}");
                    if x.is_sign_negative() { format!("({t})") } else { t }
                } else if self.version >= ES300 || !self.es {
                    format!("uintBitsToFloat({}u)", f.bits as u32)
                } else {
                    return err("an infinite or NaN float in GLSL ES 1.00");
                }
            }
            _ => return err(format!("a constant of type {ty}")),
        })
    }
}
