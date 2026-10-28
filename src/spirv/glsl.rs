//! `spirv.module` ⇒ GLSL 4.50 (Vulkan): the shader a `Shader`-capability module is, written
//! back as source. Structured control flow (`spirv.mlir.selection` / `spirv.mlir.loop`)
//! becomes `if` / `switch` / `while`, pointers become the lvalues they point at, interface
//! blocks keep their offsets and strides (checked against std430 / std140). What GLSL cannot
//! say (`Kernel` modules, physical pointers, images, unstructured branches) is an error, never
//! approximated.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::fmt::Write;

use mlirformat::spirv_types::{SpirvMember, SpirvType};
use mlirformat::{ApFloat, Attribute, Const, Error, FloatKind, Scalar, ShapedKind, Signedness, Type};

use super::EnumSpec;
use crate::{Body, BlockId, Emit, OpId, ValueId};

/// GLSL out of a `spirv.module`.
#[derive(Debug, Clone, Copy)]
pub struct SpirvGlsl;

impl Emit for SpirvGlsl {
    type Output = String;

    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<String, Error> {
        Glsl::new(body, op).module()
    }
}

fn unsupported<T>(what: impl core::fmt::Display) -> Result<T, Error> {
    Err(Error(format!("GLSL cannot express {what}")))
}

/// What a value is in GLSL.
#[derive(Clone)]
enum Val {
    /// An expression (a variable, a literal).
    Expr(String),
    /// A pointer: the lvalue it points at; `cast`: a builtin read through a cast to the SPIR-V
    /// type (`gl_GlobalInvocationID` is `uvec3`, its SPIR-V variable `vector<3xi32>`).
    Place { lvalue: String, pointee: Type<'static>, cast: bool },
}

/// The structured construct a branch is in.
enum Frame {
    Selection { merge: BlockId },
    Loop { header: BlockId, cont: BlockId, merge: BlockId },
    Switch { merge: BlockId },
}

/// std430 / std140 size and alignment.
#[derive(Clone, Copy)]
struct Layout {
    size: u32,
    align: u32,
}

struct Glsl<'b, 'a> {
    body: &'b Body<'a>,
    module: OpId,
    exts: BTreeSet<&'static str>,
    /// Struct declarations, in order of first use, by type key.
    structs: Vec<(String, String, String)>,
    globals: String,
    funcs: String,
    vals: BTreeMap<ValueId, Val>,
    next: u32,
    frames: Vec<Frame>,
    /// Blocks on the current branch path (an unstructured cycle is an error).
    path: Vec<BlockId>,
}

impl<'b, 'a> Glsl<'b, 'a> {
    fn new(body: &'b Body<'a>, module: OpId) -> Self {
        Self { body, module, exts: BTreeSet::new(), structs: Vec::new(), globals: String::new(), funcs: String::new(), vals: BTreeMap::new(), next: 0, frames: Vec::new(), path: Vec::new() }
    }

    fn fresh(&mut self, prefix: &str) -> String {
        self.next += 1;
        format!("{prefix}{}", self.next)
    }

    fn attr(&self, op: OpId, name: &str) -> Option<&'b Attribute<'a>> {
        self.body[op].get(name)
    }

    fn symbol(&self, op: OpId, name: &str) -> Result<String, Error> {
        match self.attr(op, name) {
            Some(Attribute::SymbolRef(p)) => Ok(String::from(&*p[0])),
            Some(Attribute::Str { lit, .. }) => Ok(String::from(&**lit)),
            _ => Err(Error(format!("'{}' has no symbol `{name}`", self.body[op].name))),
        }
    }

    /// A symbol as a GLSL identifier: `kind` keeps functions and globals apart and off the
    /// reserved names (`main`, `gl_*`, keywords).
    fn ident(kind: &str, s: &str) -> String {
        let mut out = String::from(kind);
        for c in s.chars() {
            out.push(if c.is_ascii_alphanumeric() { c } else { '_' });
        }
        while out.contains("__") {
            out = out.replace("__", "_");
        }
        out
    }

    fn enum_case(a: Option<&Attribute<'_>>) -> Option<String> {
        let Some(Attribute::Extended { ext, .. }) = a else { return None };
        Some(String::from(ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?))
    }

    fn int_attr(a: Option<&Attribute<'_>>) -> Option<i64> {
        Const::try_from(a?).ok()?.as_int().map(|i| i.signed() as i64)
    }

    // ---- types -------------------------------------------------------------------------

    fn scalar(&mut self, t: &Type<'_>) -> Result<&'static str, Error> {
        Ok(match t {
            Type::Integer { width: 1, .. } => "bool",
            Type::Integer { signedness, width } => {
                let u = *signedness == Signedness::Unsigned;
                match width {
                    32 => {
                        if u {
                            "uint"
                        } else {
                            "int"
                        }
                    }
                    64 => {
                        self.exts.insert("GL_EXT_shader_explicit_arithmetic_types_int64");
                        if u { "uint64_t" } else { "int64_t" }
                    }
                    16 => {
                        self.exts.insert("GL_EXT_shader_explicit_arithmetic_types_int16");
                        if u { "uint16_t" } else { "int16_t" }
                    }
                    8 => {
                        self.exts.insert("GL_EXT_shader_explicit_arithmetic_types_int8");
                        if u { "uint8_t" } else { "int8_t" }
                    }
                    _ => return unsupported(t),
                }
            }
            Type::Float(FloatKind::F32) => "float",
            Type::Float(FloatKind::F64) => "double",
            Type::Float(FloatKind::F16) => {
                self.exts.insert("GL_EXT_shader_explicit_arithmetic_types_float16");
                "float16_t"
            }
            t => return unsupported(t),
        })
    }

    /// The vector type of `n` elements of scalar `s`.
    fn vector(s: &str, n: usize) -> String {
        let prefix = match s {
            "bool" => "bvec",
            "int" => "ivec",
            "uint" => "uvec",
            "float" => "vec",
            "double" => "dvec",
            "int64_t" => "i64vec",
            "uint64_t" => "u64vec",
            "int16_t" => "i16vec",
            "uint16_t" => "u16vec",
            "int8_t" => "i8vec",
            "uint8_t" => "u8vec",
            _ => "f16vec",
        };
        format!("{prefix}{n}")
    }

    /// The unsigned type of the same shape (`ivec3` ⇒ `uvec3`).
    fn unsigned(t: &str) -> String {
        for (s, u) in [("int64_t", "uint64_t"), ("int16_t", "uint16_t"), ("int8_t", "uint8_t"), ("int", "uint"), ("ivec", "uvec"), ("i64vec", "u64vec"), ("i16vec", "u16vec"), ("i8vec", "u8vec")] {
            if let Some(rest) = t.strip_prefix(s) {
                return format!("{u}{rest}");
            }
        }
        String::from(t)
    }

    fn ty(&mut self, t: &Type<'_>) -> Result<String, Error> {
        if let Type::Shaped(s) = t
            && s.kind == ShapedKind::Vector
        {
            let n = t.element_count().unwrap_or(0) as usize;
            let e = self.scalar(&s.elem)?;
            return Ok(Self::vector(e, n));
        }
        let Ok(st) = SpirvType::try_from(t) else { return Ok(String::from(self.scalar(t)?)) };
        Ok(match st {
            SpirvType::Array { len, elem, .. } => format!("{}[{len}]", self.ty(&elem)?),
            SpirvType::RuntimeArray { elem, .. } => format!("{}[]", self.ty(&elem)?),
            SpirvType::Matrix { cols, column } => {
                let rows = column.element_count().unwrap_or(0);
                let e = self.scalar(column.element_type())?;
                match e {
                    "float" => format!("mat{cols}x{rows}"),
                    "double" => format!("dmat{cols}x{rows}"),
                    _ => return unsupported(t),
                }
            }
            SpirvType::Struct { members: Some(ms), .. } => self.struct_name(t, &ms)?,
            _ => return unsupported(t),
        })
    }

    /// The name of a struct type, declared on first use.
    fn struct_name(&mut self, t: &Type<'_>, members: &[SpirvMember<'_>]) -> Result<String, Error> {
        let key = format!("{t}");
        if let Some((_, n, _)) = self.structs.iter().find(|s| s.0 == key) {
            return Ok(n.clone());
        }
        let mut decl = String::new();
        for (i, m) in members.iter().enumerate() {
            let mt = self.ty(&m.ty)?;
            let _ = writeln!(decl, "  {mt} m{i};");
        }
        let name = format!("S{}", self.structs.len());
        self.structs.push((key, name.clone(), decl));
        Ok(name)
    }

    /// `layout` std430 (`std140`: arrays and structs round up to 16) of `t`, checking every
    /// explicit offset and stride inside against it.
    fn layout(&self, t: &Type<'_>, std140: bool) -> Result<Layout, Error> {
        let round = |x: u32, a: u32| x.div_ceil(a) * a;
        if let Type::Shaped(s) = t
            && s.kind == ShapedKind::Vector
        {
            let e = self.layout(&s.elem, std140)?;
            let n = t.element_count().unwrap_or(0) as u32;
            return Ok(Layout { size: e.size * n, align: e.size * if n == 3 { 4 } else { n } });
        }
        if let Some(w) = t.bit_width()
            && !matches!(t, Type::Extended(_))
        {
            let size = if w == 1 { 4 } else { w / 8 };
            return Ok(Layout { size, align: size });
        }
        match SpirvType::try_from(t) {
            Ok(SpirvType::Array { len, elem, stride }) => {
                let e = self.layout(&elem, std140)?;
                let a = if std140 { round(e.align, 16) } else { e.align };
                let natural = round(e.size, a);
                if stride != natural {
                    return unsupported(format_args!("array stride {stride} (std{} gives {natural})", if std140 { 140 } else { 430 }));
                }
                Ok(Layout { size: natural * len, align: a })
            }
            Ok(SpirvType::RuntimeArray { elem, stride }) => {
                let e = self.layout(&elem, std140)?;
                let a = if std140 { round(e.align, 16) } else { e.align };
                if stride != round(e.size, a) {
                    return unsupported(format_args!("runtime array stride {stride}"));
                }
                Ok(Layout { size: 0, align: a })
            }
            Ok(SpirvType::Struct { members: Some(ms), .. }) => {
                let (mut at, mut align) = (0u32, 1u32);
                for m in &ms {
                    let l = self.layout(&m.ty, std140)?;
                    at = round(at, l.align);
                    if m.offset.is_some_and(|o| o != at) {
                        return unsupported(format_args!("member offset {:?} (std{} gives {at})", m.offset, if std140 { 140 } else { 430 }));
                    }
                    at += l.size;
                    align = align.max(l.align);
                }
                if std140 {
                    align = round(align, 16);
                }
                Ok(Layout { size: round(at, align), align })
            }
            _ => unsupported(t),
        }
    }

    // ---- literals ----------------------------------------------------------------------

    fn float_lit(&mut self, kind: FloatKind, bits: u64) -> Result<String, Error> {
        let f = ApFloat::from_bits(kind, bits).ok_or_else(|| Error(String::from("bad float")))?;
        let x = f.to_f64();
        Ok(match kind {
            FloatKind::F32 => {
                let v = f32::from_bits(bits as u32);
                if v.is_finite() { format!("{v:?}") } else { format!("uintBitsToFloat({:#x}u)", bits as u32) }
            }
            FloatKind::F64 => {
                if x.is_finite() { format!("{x:?}lf") } else { format!("uint64BitsToDouble({bits:#x}ul)") }
            }
            FloatKind::F16 => {
                self.exts.insert("GL_EXT_shader_explicit_arithmetic_types_float16");
                format!("float16_t({x:?})")
            }
            k => return unsupported(format_args!("{k:?} literals")),
        })
    }

    fn scalar_lit(&mut self, s: Scalar, t: &Type<'_>) -> Result<String, Error> {
        Ok(match (s, t) {
            (Scalar::Int(i), Type::Integer { width: 1, .. }) => String::from(if i.bits() != 0 { "true" } else { "false" }),
            (Scalar::Int(i), Type::Integer { signedness, width }) => {
                let ty = self.scalar(t)?;
                let unsigned = *signedness == Signedness::Unsigned;
                match (width, unsigned) {
                    (32, false) if i.signed() == i128::from(i32::MIN) => String::from("int(0x80000000u)"),
                    (32, false) => format!("{}", i.signed()),
                    (32, true) => format!("{}u", i.bits()),
                    (64, false) => format!("{}l", i.signed()),
                    (64, true) => format!("{}ul", i.bits()),
                    _ => format!("{ty}({})", if unsigned { i.bits() as i128 } else { i.signed() }),
                }
            }
            (Scalar::Float(f), Type::Float(k)) => self.float_lit(*k, f.bits)?,
            _ => return unsupported(t),
        })
    }

    /// A constant of type `t` (scalar, vector, array, matrix) as an expression.
    fn constant(&mut self, t: &Type<'_>, a: &Attribute<'_>) -> Result<String, Error> {
        if let Attribute::Bool(b) = a {
            return Ok(String::from(if *b { "true" } else { "false" }));
        }
        if let Attribute::Array(es) = a {
            let elem = SpirvType::try_from(t).ok().and_then(|s| s.element().map(|e| e.owned())).ok_or_else(|| Error(format!("not a composite: {t}")))?;
            let parts = es.iter().map(|e| self.constant(&elem, e)).collect::<Result<Vec<_>, _>>()?;
            return Ok(format!("{}({})", self.ty(t)?, parts.join(", ")));
        }
        let c = Const::try_from(a).map_err(|_| Error(format!("GLSL cannot express constant {a}")))?;
        if !c.elements {
            return self.scalar_lit(c.values[0], &c.ty);
        }
        let shape: Vec<usize> = c.ty.shape().map(|s| s.iter().map(|d| i64::from(d) as usize).collect()).unwrap_or_default();
        let elem = c.ty.element_type().owned();
        self.dense(t, &c, &elem, &shape, 0, 0)
    }

    fn dense(&mut self, t: &Type<'_>, c: &Const<'_>, elem: &Type<'_>, shape: &[usize], dim: usize, base: usize) -> Result<String, Error> {
        if dim == shape.len() {
            return self.scalar_lit(c.at(base), elem);
        }
        let inner_t = match t {
            Type::Shaped(s) => s.elem.owned(),
            t => SpirvType::try_from(t).ok().and_then(|s| s.element().map(|e| e.owned())).ok_or_else(|| Error(format!("not a composite: {t}")))?,
        };
        let stride: usize = shape[dim + 1..].iter().product();
        let parts = (0..shape[dim]).map(|i| self.dense(&inner_t, c, elem, shape, dim + 1, base + i * stride)).collect::<Result<Vec<_>, _>>()?;
        Ok(format!("{}({})", self.ty(t)?, parts.join(", ")))
    }

    // ---- module ------------------------------------------------------------------------

    fn module(mut self) -> Result<String, Error> {
        let vce = format!("{}", self.attr(self.module, "vce_triple").ok_or_else(|| Error(String::from("no vce_triple")))?);
        if !vce.contains("Shader") || vce.contains("Kernel") || vce.contains("Addresses") {
            return unsupported("a module without the Shader capability (or with Kernel / Addresses)");
        }
        if Self::enum_case(self.attr(self.module, "addressing_model")).as_deref() != Some("Logical") {
            return unsupported("a non-Logical addressing model");
        }
        let ops = self.body[self.body.top_block(self.module)].ops.clone();
        let mut entry: Option<(String, String)> = None;
        let mut local_size = None;
        for op in &ops {
            match &*self.body[*op].name {
                "spirv.GlobalVariable" => self.global(*op)?,
                "spirv.EntryPoint" => {
                    if entry.is_some() {
                        return unsupported("several entry points in one shader");
                    }
                    let model = Self::enum_case(self.attr(*op, "execution_model")).unwrap_or_default();
                    entry = Some((model, self.symbol(*op, "fn")?));
                }
                "spirv.ExecutionMode" => match Self::enum_case(self.attr(*op, "execution_mode")).as_deref() {
                    Some("LocalSize") => {
                        let Some(Attribute::Array(vs)) = self.attr(*op, "values") else { return unsupported("LocalSize without values") };
                        local_size = Some(vs.iter().map(|v| Self::int_attr(Some(v)).unwrap_or(1)).collect::<Vec<_>>());
                    }
                    m => return unsupported(format_args!("execution mode {m:?}")),
                },
                "spirv.SpecConstant" => {
                    let value = self.attr(*op, "default_value").cloned().unwrap_or(Attribute::Unit);
                    let ty = match &value {
                        Attribute::Bool(_) => Type::I1,
                        v => Const::try_from(v).map_err(|_| Error(format!("bad spec constant {v}")))?.ty.owned(),
                    };
                    let (t, lit) = (self.ty(&ty)?, self.constant(&ty, &value)?);
                    let id = Self::ident("c_", &self.symbol(*op, "sym_name")?);
                    let layout = Self::int_attr(self.attr(*op, "spec_id")).map(|n| format!("layout(constant_id = {n}) ")).unwrap_or_default();
                    let _ = writeln!(self.globals, "{layout}const {t} {id} = {lit};");
                }
                "spirv.SpecConstantComposite" => {
                    let Some(Attribute::Type(ty)) = self.attr(*op, "type").cloned() else { return unsupported("a spec constant composite without a type") };
                    let Some(Attribute::Array(cs)) = self.attr(*op, "constituents") else { return unsupported("a spec constant composite without constituents") };
                    let parts: Vec<String> = cs.iter().filter_map(|c| if let Attribute::SymbolRef(p) = c { Some(Self::ident("c_", &p[0])) } else { None }).collect();
                    let t = self.ty(&ty)?;
                    let id = Self::ident("c_", &self.symbol(*op, "sym_name")?);
                    let _ = writeln!(self.globals, "const {t} {id} = {t}({});", parts.join(", "));
                }
                "spirv.func" => {}
                n => return unsupported(format_args!("'{n}' at module scope")),
            }
        }
        let funcs: Vec<OpId> = ops.iter().copied().filter(|o| self.body[*o].name == "spirv.func").collect();
        let mut protos = String::new();
        for f in &funcs {
            let _ = writeln!(protos, "{};", self.signature(*f)?);
        }
        for f in &funcs {
            self.function(*f)?;
        }
        let mut out = String::from("#version 450\n");
        for e in &self.exts {
            let _ = writeln!(out, "#extension {e} : require");
        }
        if let Some(ls) = &local_size {
            let _ = writeln!(out, "layout(local_size_x = {}, local_size_y = {}, local_size_z = {}) in;", ls[0], ls[1], ls[2]);
        }
        for (_, name, decl) in &self.structs {
            let _ = write!(out, "struct {name} {{\n{decl}}};\n");
        }
        out.push_str(&self.globals);
        out.push_str(&protos);
        out.push_str(&self.funcs);
        if let Some((model, f)) = entry {
            if !matches!(&*model, "GLCompute" | "Vertex" | "Fragment") {
                return unsupported(format_args!("execution model {model}"));
            }
            let _ = writeln!(out, "void main() {{\n  {}();\n}}", Self::ident("f_", &f));
        }
        Ok(out)
    }

    /// `gl_*` for a `built_in` decoration: the GLSL variable and its type.
    fn builtin(name: &str) -> Result<(&'static str, &'static str), Error> {
        Ok(match name {
            "GlobalInvocationId" => ("gl_GlobalInvocationID", "uvec3"),
            "LocalInvocationId" => ("gl_LocalInvocationID", "uvec3"),
            "WorkgroupId" => ("gl_WorkGroupID", "uvec3"),
            "NumWorkgroups" => ("gl_NumWorkGroups", "uvec3"),
            "WorkgroupSize" => ("gl_WorkGroupSize", "uvec3"),
            "LocalInvocationIndex" => ("gl_LocalInvocationIndex", "uint"),
            "Position" => ("gl_Position", "vec4"),
            "FragCoord" => ("gl_FragCoord", "vec4"),
            "VertexIndex" => ("gl_VertexIndex", "int"),
            "InstanceIndex" => ("gl_InstanceIndex", "int"),
            n => return unsupported(format_args!("builtin {n}")),
        })
    }

    fn global(&mut self, op: OpId) -> Result<(), Error> {
        let Some(Attribute::Type(ptr)) = self.attr(op, "type") else { return unsupported("a global without a type") };
        let Ok(SpirvType::Ptr { pointee, storage }) = SpirvType::try_from(ptr) else { return unsupported(ptr) };
        let name = self.symbol(op, "sym_name")?;
        let pointee = pointee.owned();
        if let Some(Attribute::Str { lit, .. }) = self.attr(op, "built_in") {
            let (var, _) = Self::builtin(lit)?;
            self.vals.insert(self.global_key(&name), Val::Place { lvalue: String::from(var), pointee, cast: true });
            return Ok(());
        }
        if self.attr(op, "initializer").is_some() {
            return unsupported("a global with an initializer");
        }
        let id = Self::ident("g_", &name);
        let set = Self::int_attr(self.attr(op, "descriptor_set"));
        let binding = Self::int_attr(self.attr(op, "binding"));
        let mut layout: Vec<String> = Vec::new();
        layout.extend(set.map(|s| format!("set = {s}")));
        layout.extend(binding.map(|b| format!("binding = {b}")));
        match &*storage {
            "StorageBuffer" | "Uniform" | "PushConstant" => {
                let Ok(SpirvType::Struct { members: Some(ms), .. }) = SpirvType::try_from(&pointee) else { return unsupported(format_args!("{storage} variable of {pointee}")) };
                let std140 = storage == "Uniform";
                self.layout(&pointee, std140)?;
                layout.insert(0, String::from(if std140 { "std140" } else { "std430" }));
                if storage == "PushConstant" {
                    layout.push(String::from("push_constant"));
                }
                let kw = if storage == "StorageBuffer" { "buffer" } else { "uniform" };
                let mut members = String::new();
                for (i, m) in ms.iter().enumerate() {
                    let mt = self.ty(&m.ty)?;
                    let mut q = String::new();
                    for d in &m.decorations {
                        match &*d.name {
                            "NonWritable" if kw == "buffer" => q.push_str("readonly "),
                            "NonReadable" if kw == "buffer" => q.push_str("writeonly "),
                            "Restrict" => q.push_str("restrict "),
                            "Coherent" => q.push_str("coherent "),
                            "Volatile" => q.push_str("volatile "),
                            "NonWritable" | "NonReadable" | "Offset" => {}
                            n => return unsupported(format_args!("member decoration {n}")),
                        }
                    }
                    let off = m.offset.map(|o| format!("layout(offset = {o}) ")).unwrap_or_default();
                    let _ = writeln!(members, "  {off}{q}{mt} m{i};");
                }
                let _ = write!(self.globals, "layout({}) {kw} {id}_block {{\n{members}}} {id};\n", layout.join(", "));
            }
            "Workgroup" => {
                let t = self.ty(&pointee)?;
                let _ = writeln!(self.globals, "shared {t} {id};");
            }
            "Private" => {
                let t = self.ty(&pointee)?;
                let _ = writeln!(self.globals, "{t} {id};");
            }
            "Input" | "Output" => {
                let Some(loc) = Self::int_attr(self.attr(op, "location")) else { return unsupported("an interface variable without a location") };
                let t = self.ty(&pointee)?;
                let _ = writeln!(self.globals, "layout(location = {loc}) {} {t} {id};", if storage == "Input" { "in" } else { "out" });
            }
            s => return unsupported(format_args!("storage class {s}")),
        }
        self.vals.insert(self.global_key(&name), Val::Place { lvalue: id, pointee, cast: false });
        Ok(())
    }

    /// Globals live in `vals` under a key no SSA value has: past the end, by symbol order.
    fn global_key(&self, name: &str) -> ValueId {
        let globals: Vec<String> = self.body[self.body.top_block(self.module)].ops.iter().filter(|o| self.body[**o].name == "spirv.GlobalVariable").filter_map(|o| self.symbol(*o, "sym_name").ok()).collect();
        let i = globals.iter().position(|g| g == name).unwrap_or(0);
        ValueId(u32::MAX - i as u32)
    }

    // ---- functions ---------------------------------------------------------------------

    fn signature(&mut self, f: OpId) -> Result<String, Error> {
        let Some(Attribute::Type(Type::Function(ft))) = self.attr(f, "function_type") else { return unsupported("a function without a type") };
        let ret = match ft.results.first() {
            Some(t) => self.ty(t)?,
            None => String::from("void"),
        };
        let mut params = Vec::new();
        for (i, t) in ft.inputs.iter().enumerate() {
            params.push(match SpirvType::try_from(t) {
                Ok(SpirvType::Ptr { pointee, storage }) if storage == "Function" => format!("inout {} p{i}", self.ty(&pointee)?),
                Ok(SpirvType::Ptr { .. }) => return unsupported("a pointer parameter outside Function storage"),
                _ => format!("{} p{i}", self.ty(t)?),
            });
        }
        Ok(format!("{ret} {}({})", Self::ident("f_", &self.symbol(f, "sym_name")?), params.join(", ")))
    }

    fn function(&mut self, f: OpId) -> Result<(), Error> {
        let region = self.body[f].regions[0];
        let blocks = self.body[region].blocks.clone();
        if blocks.is_empty() {
            return unsupported("a function declaration (GLSL has no linkage)");
        }
        let sig = self.signature(f)?;
        let Some(Attribute::Type(Type::Function(ft))) = self.attr(f, "function_type").cloned() else { unreachable!() };
        for (i, a) in self.body[blocks[0]].args.clone().into_iter().enumerate() {
            let v = match SpirvType::try_from(&ft.inputs[i]) {
                Ok(SpirvType::Ptr { pointee, .. }) => Val::Place { lvalue: format!("p{i}"), pointee: pointee.owned(), cast: false },
                _ => Val::Expr(format!("p{i}")),
            };
            self.vals.insert(a, v);
        }
        // Block arguments (phis) of every block below the entry: variables of the function.
        let mut decls = String::new();
        for op in self.body.ops_in(f) {
            for r in self.body[op].regions.clone() {
                for b in self.body[r].blocks.clone() {
                    self.block_vars(b, &mut decls)?;
                }
            }
        }
        for b in blocks.iter().skip(1) {
            self.block_vars(*b, &mut decls)?;
        }
        let mut code = String::new();
        self.chain(blocks[0], &mut code, 1)?;
        let _ = write!(self.funcs, "{sig} {{\n{decls}{code}}}\n");
        Ok(())
    }

    fn block_vars(&mut self, b: BlockId, decls: &mut String) -> Result<(), Error> {
        for a in self.body[b].args.clone() {
            if self.vals.contains_key(&a) {
                continue;
            }
            let t = self.ty(&self.body[a].ty.clone())?;
            let n = self.fresh("phi");
            let _ = writeln!(decls, "  {t} {n};");
            self.vals.insert(a, Val::Expr(n));
        }
        Ok(())
    }

    fn pad(n: usize) -> String {
        "  ".repeat(n)
    }

    fn expr(&self, v: ValueId) -> Result<String, Error> {
        match self.vals.get(&v) {
            Some(Val::Expr(e)) => Ok(e.clone()),
            Some(Val::Place { .. }) => unsupported("a pointer as a value"),
            None => Err(Error(String::from("use before def"))),
        }
    }

    /// Block `b` and the blocks it branches on to, until the construct around it ends.
    fn chain(&mut self, b: BlockId, out: &mut String, depth: usize) -> Result<(), Error> {
        if self.path.contains(&b) {
            return unsupported("an unstructured cycle");
        }
        self.path.push(b);
        let ops = self.body[b].ops.clone();
        let Some((last, rest)) = ops.split_last() else { return unsupported("an empty block") };
        for o in rest {
            self.op(*o, out, depth)?;
        }
        self.terminator(*last, out, depth)?;
        self.path.pop();
        Ok(())
    }

    /// Passes `values` to `target`'s arguments.
    fn assign_args(&mut self, target: BlockId, values: &[ValueId], out: &mut String, depth: usize) -> Result<(), Error> {
        let args = self.body[target].args.clone();
        // All reads before any write: arguments may swap.
        let reads: Vec<String> = values.iter().map(|v| self.expr(*v)).collect::<Result<_, _>>()?;
        if args.len() > 1 {
            let mut tmps = Vec::new();
            for (a, r) in args.iter().zip(&reads) {
                let t = self.ty(&self.body[*a].ty.clone())?;
                let n = self.fresh("t");
                let _ = writeln!(out, "{}{t} {n} = {r};", Self::pad(depth));
                tmps.push(n);
            }
            for (a, n) in args.iter().zip(tmps) {
                let _ = writeln!(out, "{}{} = {n};", Self::pad(depth), self.expr(*a)?);
            }
        } else {
            for (a, r) in args.iter().zip(reads) {
                let _ = writeln!(out, "{}{} = {r};", Self::pad(depth), self.expr(*a)?);
            }
        }
        Ok(())
    }

    /// A branch to `target` with `values`, inside the current constructs.
    fn branch(&mut self, target: BlockId, values: &[ValueId], out: &mut String, depth: usize) -> Result<(), Error> {
        self.assign_args(target, values, out, depth)?;
        let p = Self::pad(depth);
        for (i, f) in self.frames.iter().enumerate().rev() {
            match *f {
                Frame::Selection { merge } if merge == target => return Ok(()),
                Frame::Switch { merge } if merge == target => {
                    let _ = writeln!(out, "{p}break;");
                    return Ok(());
                }
                Frame::Loop { merge, header, cont } => {
                    let inner_switch = self.frames[i + 1..].iter().any(|f| matches!(f, Frame::Switch { .. }));
                    if target == merge || target == header {
                        if inner_switch {
                            return unsupported("a loop exit inside a switch");
                        }
                        let _ = writeln!(out, "{p}{};", if target == merge { "break" } else { "continue" });
                        return Ok(());
                    }
                    if target == cont {
                        // The continue block inline, then its back edge.
                        let saved = core::mem::take(&mut self.path);
                        let r = self.chain(cont, out, depth);
                        self.path = saved;
                        return r;
                    }
                }
                _ => {}
            }
        }
        self.chain(target, out, depth)
    }

    fn terminator(&mut self, t: OpId, out: &mut String, depth: usize) -> Result<(), Error> {
        let p = Self::pad(depth);
        let d = &self.body[t];
        match &*d.name {
            "spirv.Return" => {
                let _ = writeln!(out, "{p}return;");
            }
            "spirv.ReturnValue" => {
                let _ = writeln!(out, "{p}return {};", self.expr(d.operands[0])?);
            }
            "spirv.Unreachable" => {}
            "spirv.Kill" => {
                let _ = writeln!(out, "{p}discard;");
            }
            "spirv.Branch" => self.branch(d.successors[0], &d.operands.clone(), out, depth)?,
            "spirv.BranchConditional" => {
                let c = self.expr(d.operands[0])?;
                let (tt, ff) = (d.successors[0], d.successors[1]);
                let tv = self.body.successor_operands(t, 0).map(|r| d.operands[r].to_vec()).unwrap_or_default();
                let fv = self.body.successor_operands(t, 1).map(|r| d.operands[r].to_vec()).unwrap_or_default();
                let _ = writeln!(out, "{p}if ({c}) {{");
                self.branch(tt, &tv, out, depth + 1)?;
                let _ = writeln!(out, "{p}}} else {{");
                self.branch(ff, &fv, out, depth + 1)?;
                let _ = writeln!(out, "{p}}}");
            }
            "spirv.mlir.merge" => {}
            n => return unsupported(format_args!("terminator '{n}'")),
        }
        Ok(())
    }

    /// The results of a construct: the merge block's merge operands.
    fn construct_results(&mut self, op: OpId, merge: BlockId, out: &mut String, depth: usize) -> Result<(), Error> {
        let ops = self.body[merge].ops.clone();
        let Some((last, rest)) = ops.split_last() else { return Ok(()) };
        for o in rest {
            self.op(*o, out, depth)?;
        }
        for (r, v) in self.body[op].results.clone().into_iter().zip(self.body[*last].operands.clone()) {
            let e = self.expr(v)?;
            self.define(r, e, out, depth)?;
        }
        Ok(())
    }

    fn selection(&mut self, op: OpId, out: &mut String, depth: usize) -> Result<(), Error> {
        let blocks = self.body[self.body[op].regions[0]].blocks.clone();
        let (header, merge) = (blocks[0], *blocks.last().expect("merge"));
        let term = *self.body[header].ops.last().expect("terminator");
        if self.body[term].name == "spirv.Switch" {
            let ops = self.body[header].ops.clone();
            for o in &ops[..ops.len() - 1] {
                self.op(*o, out, depth)?;
            }
            let d = &self.body[term];
            let sel = self.expr(d.operands[0])?;
            let succs = d.successors.clone();
            let lits = self.attr(term, "literals").and_then(|a| Const::try_from(a).ok());
            let p = Self::pad(depth);
            let _ = writeln!(out, "{p}switch ({sel}) {{");
            self.frames.push(Frame::Switch { merge });
            for (i, s) in succs.iter().enumerate() {
                let label = if i == 0 { String::from("default") } else { format!("case {}", lits.as_ref().map_or(0, |l| l.at(i - 1).int().map_or(0, |x| x.signed()))) };
                let vals = self.body.successor_operands(term, i).map(|r| self.body[term].operands[r].to_vec()).unwrap_or_default();
                let _ = writeln!(out, "{p}  {label}: {{");
                self.branch(*s, &vals, out, depth + 2)?;
                let _ = writeln!(out, "{p}  }}");
            }
            self.frames.pop();
            let _ = writeln!(out, "{p}}}");
        } else {
            self.frames.push(Frame::Selection { merge });
            let saved = core::mem::take(&mut self.path);
            let r = self.chain(header, out, depth);
            self.path = saved;
            self.frames.pop();
            r?;
        }
        self.construct_results(op, merge, out, depth)
    }

    fn loop_op(&mut self, op: OpId, out: &mut String, depth: usize) -> Result<(), Error> {
        let blocks = self.body[self.body[op].regions[0]].blocks.clone();
        let (entry, header, cont, merge) = (blocks[0], blocks[1], blocks[blocks.len() - 2], blocks[blocks.len() - 1]);
        let e = *self.body[entry].ops.last().expect("terminator");
        self.assign_args(header, &self.body[e].operands.clone(), out, depth)?;
        let p = Self::pad(depth);
        let _ = writeln!(out, "{p}while (true) {{");
        self.frames.push(Frame::Loop { header, cont, merge });
        let saved = core::mem::take(&mut self.path);
        let r = self.chain(header, out, depth + 1);
        self.path = saved;
        self.frames.pop();
        r?;
        let _ = writeln!(out, "{p}}}");
        self.construct_results(op, merge, out, depth)
    }

    /// `T vN = e;` for result `r`.
    fn define(&mut self, r: ValueId, e: String, out: &mut String, depth: usize) -> Result<(), Error> {
        let t = self.ty(&self.body[r].ty.clone())?;
        let n = self.fresh("v");
        let _ = writeln!(out, "{}{t} {n} = {e};", Self::pad(depth));
        self.vals.insert(r, Val::Expr(n));
        Ok(())
    }

    /// The lvalue `ptr` points at, its pointee, and whether reading it casts.
    fn place(&self, ptr: ValueId) -> Result<(String, Type<'static>, bool), Error> {
        match self.vals.get(&ptr) {
            Some(Val::Place { lvalue, pointee, cast }) => Ok((lvalue.clone(), pointee.clone(), *cast)),
            _ => unsupported("a pointer that is no variable"),
        }
    }

    fn op(&mut self, op: OpId, out: &mut String, depth: usize) -> Result<(), Error> {
        let d = &self.body[op];
        let name = d.name.clone();
        let p = Self::pad(depth);
        let res = d.results.first().copied();
        let operands = d.operands.clone();
        match &*name {
            "spirv.mlir.selection" => return self.selection(op, out, depth),
            "spirv.mlir.loop" => return self.loop_op(op, out, depth),
            "spirv.Constant" => {
                let r = res.expect("result");
                let t = self.body[r].ty.clone();
                let v = self.attr(op, "value").cloned().unwrap_or(Attribute::Unit);
                let e = self.constant(&t, &v)?;
                self.vals.insert(r, Val::Expr(e));
            }
            "spirv.Undef" => {
                let r = res.expect("result");
                let t = self.ty(&self.body[r].ty.clone())?;
                let n = self.fresh("u");
                let _ = writeln!(out, "{p}{t} {n};");
                self.vals.insert(r, Val::Expr(n));
            }
            "spirv.mlir.referenceof" => {
                let c = Self::ident("c_", &self.symbol(op, "spec_const")?);
                self.vals.insert(res.expect("result"), Val::Expr(c));
            }
            "spirv.SpecConstantOperation" => {
                let block = self.body[self.body[op].regions[0]].blocks[0];
                let inner = self.body[block].ops[0];
                let ir = self.body[inner].results[0];
                let e = self.value_expr(inner, ir)?;
                self.define(res.expect("result"), e, out, depth)?;
            }
            "spirv.mlir.addressof" => {
                let g = self.symbol(op, "variable")?;
                let v = self.vals.get(&self.global_key(&g)).cloned().ok_or_else(|| Error(format!("unknown global {g}")))?;
                self.vals.insert(res.expect("result"), v);
            }
            "spirv.Variable" => {
                let r = res.expect("result");
                let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&self.body[r].ty) else { return unsupported("a variable that is no pointer") };
                let t = self.ty(&pointee)?;
                let n = self.fresh("var");
                match operands.first() {
                    Some(i) => {
                        let _ = writeln!(out, "{p}{t} {n} = {};", self.expr(*i)?);
                    }
                    None => {
                        let _ = writeln!(out, "{p}{t} {n};");
                    }
                }
                self.vals.insert(r, Val::Place { lvalue: n, pointee: pointee.owned(), cast: false });
            }
            "spirv.AccessChain" | "spirv.InBoundsPtrAccessChain" if name == "spirv.AccessChain" => {
                let (mut lv, mut t, cast) = self.place(operands[0])?;
                for i in &operands[1..] {
                    match SpirvType::try_from(&t) {
                        Ok(SpirvType::Struct { members: Some(ms), .. }) => {
                            let k = self.body.int_constant(*i).ok_or_else(|| Error(String::from("struct index not constant")))? as usize;
                            lv = format!("{lv}.m{k}");
                            t = ms[k].ty.owned();
                        }
                        Ok(st @ (SpirvType::Array { .. } | SpirvType::RuntimeArray { .. } | SpirvType::Matrix { .. })) => {
                            lv = format!("{lv}[{}]", self.expr(*i)?);
                            t = st.element().expect("element").owned();
                        }
                        _ => match &t {
                            Type::Shaped(s) => {
                                lv = format!("{lv}[{}]", self.expr(*i)?);
                                t = s.elem.owned();
                            }
                            t => return unsupported(format_args!("an access chain into {t}")),
                        },
                    }
                }
                self.vals.insert(res.expect("result"), Val::Place { lvalue: lv, pointee: t, cast });
            }
            "spirv.Load" => {
                let (lv, _, cast) = self.place(operands[0])?;
                let r = res.expect("result");
                let e = if cast { format!("{}({lv})", self.ty(&self.body[r].ty.clone())?) } else { lv };
                self.define(r, e, out, depth)?;
            }
            "spirv.Store" => {
                let (lv, _, cast) = self.place(operands[0])?;
                if cast {
                    return unsupported("a store to a builtin");
                }
                let _ = writeln!(out, "{p}{lv} = {};", self.expr(operands[1])?);
            }
            "spirv.CopyMemory" => {
                let (dst, ..) = self.place(operands[0])?;
                let (src, ..) = self.place(operands[1])?;
                let _ = writeln!(out, "{p}{dst} = {src};");
            }
            "spirv.FunctionCall" => {
                let callee = Self::ident("f_", &self.symbol(op, "callee")?);
                let mut args = Vec::new();
                for a in &operands {
                    args.push(match self.vals.get(a) {
                        Some(Val::Place { lvalue, cast: false, .. }) => lvalue.clone(),
                        _ => self.expr(*a)?,
                    });
                }
                let call = format!("{callee}({})", args.join(", "));
                match res {
                    Some(r) => self.define(r, call, out, depth)?,
                    None => {
                        let _ = writeln!(out, "{p}{call};");
                    }
                }
            }
            "spirv.ControlBarrier" => {
                let _ = writeln!(out, "{p}barrier();");
            }
            "spirv.MemoryBarrier" => {
                let _ = writeln!(out, "{p}memoryBarrier();");
            }
            "spirv.CompositeInsert" => {
                let r = res.expect("result");
                let t = self.ty(&self.body[r].ty.clone())?;
                let n = self.fresh("v");
                let _ = writeln!(out, "{p}{t} {n} = {};", self.expr(operands[1])?);
                let path = self.indices(op, &self.body[operands[1]].ty.clone())?;
                let _ = writeln!(out, "{p}{n}{path} = {};", self.expr(operands[0])?);
                self.vals.insert(r, Val::Expr(n));
            }
            "spirv.VectorInsertDynamic" => {
                let r = res.expect("result");
                let t = self.ty(&self.body[r].ty.clone())?;
                let n = self.fresh("v");
                let _ = writeln!(out, "{p}{t} {n} = {};", self.expr(operands[0])?);
                let _ = writeln!(out, "{p}{n}[{}] = {};", self.expr(operands[2])?, self.expr(operands[1])?);
                self.vals.insert(r, Val::Expr(n));
            }
            n if n.starts_with("spirv.Atomic") => {
                let (lv, _, cast) = self.place(operands[0])?;
                if cast {
                    return unsupported("an atomic on a builtin");
                }
                let rest = operands[1..].iter().map(|v| self.expr(*v)).collect::<Result<Vec<_>, _>>()?;
                let r = res.expect("result");
                let rt = self.ty(&self.body[r].ty.clone())?;
                let u = |e: &str| format!("{}({e})", Self::unsigned(&rt));
                let e = match n {
                    "spirv.AtomicIAdd" => format!("atomicAdd({lv}, {})", rest[0]),
                    "spirv.AtomicISub" => format!("atomicAdd({lv}, -({}))", rest[0]),
                    "spirv.AtomicAnd" => format!("atomicAnd({lv}, {})", rest[0]),
                    "spirv.AtomicOr" => format!("atomicOr({lv}, {})", rest[0]),
                    "spirv.AtomicXor" => format!("atomicXor({lv}, {})", rest[0]),
                    "spirv.AtomicSMin" => format!("atomicMin({lv}, {})", rest[0]),
                    "spirv.AtomicSMax" => format!("atomicMax({lv}, {})", rest[0]),
                    "spirv.AtomicExchange" => format!("atomicExchange({lv}, {})", rest[0]),
                    "spirv.AtomicCompareExchange" => format!("atomicCompSwap({lv}, {}, {})", rest[1], rest[0]),
                    "spirv.AtomicIIncrement" => format!("atomicAdd({lv}, 1)"),
                    "spirv.AtomicIDecrement" => format!("atomicAdd({lv}, -1)"),
                    "spirv.AtomicUMin" | "spirv.AtomicUMax" if rt == "uint" => format!("atomic{}({lv}, {})", if n.ends_with("Min") { "Min" } else { "Max" }, u(&rest[0])),
                    n => return unsupported(format_args!("'{n}'")),
                };
                self.define(r, e, out, depth)?;
            }
            _ => {
                let Some(r) = res else { return unsupported(format_args!("'{name}'")) };
                let e = self.value_expr(op, r)?;
                self.define(r, e, out, depth)?;
            }
        }
        Ok(())
    }

    /// `[i][j]` / `.mK` for the `indices` of a composite of type `t`.
    fn indices(&mut self, op: OpId, t: &Type<'_>) -> Result<String, Error> {
        let Some(Attribute::Array(is)) = self.attr(op, "indices") else { return unsupported("no indices") };
        let mut t = t.owned();
        let mut out = String::new();
        for i in is {
            let k = Self::int_attr(Some(i)).ok_or_else(|| Error(String::from("bad index")))? as usize;
            match SpirvType::try_from(&t) {
                Ok(SpirvType::Struct { members: Some(ms), .. }) => {
                    let _ = write!(out, ".m{k}");
                    t = ms[k].ty.owned();
                }
                Ok(st) => {
                    let _ = write!(out, "[{k}]");
                    t = st.element().ok_or_else(|| Error(String::from("bad composite")))?.owned();
                }
                Err(()) => {
                    let _ = write!(out, "[{k}]");
                    t = t.element_type().owned();
                }
            }
        }
        Ok(out)
    }

    /// The expression an op with a result computes.
    fn value_expr(&mut self, op: OpId, r: ValueId) -> Result<String, Error> {
        let d = &self.body[op];
        let name = String::from(&*d.name);
        let a: Vec<String> = d.operands.iter().map(|v| self.expr(*v)).collect::<Result<_, _>>()?;
        let rt_type = self.body[r].ty.clone();
        let rt = self.ty(&rt_type)?;
        let in_t = match d.operands.first() {
            Some(v) => self.ty(&self.body[*v].ty.clone())?,
            None => String::new(),
        };
        let vector = in_t.contains("vec");
        let u = |e: &str, t: &str| format!("{}({e})", Self::unsigned(t));
        let bin = |o: &str| format!("({} {o} {})", a[0], a[1]);
        let cmp = |o: &str, f: &str| if vector { format!("{f}({}, {})", a[0], a[1]) } else { format!("({} {o} {})", a[0], a[1]) };
        let ucmp = |o: &str, f: &str| {
            let (x, y) = (u(&a[0], &in_t), u(&a[1], &in_t));
            if vector { format!("{f}({x}, {y})") } else { format!("({x} {o} {y})") }
        };
        let call = |f: &str| format!("{f}({})", a.join(", "));
        let e = match name.strip_prefix("spirv.").unwrap_or("") {
            "IAdd" | "FAdd" => bin("+"),
            "ISub" | "FSub" => bin("-"),
            "IMul" | "FMul" => bin("*"),
            "SDiv" | "FDiv" => bin("/"),
            "UDiv" => format!("{rt}({} / {})", u(&a[0], &rt), u(&a[1], &rt)),
            "UMod" => format!("{rt}({} % {})", u(&a[0], &rt), u(&a[1], &rt)),
            "SRem" => format!("({0} - {1} * ({0} / {1}))", a[0], a[1]),
            "FRem" => format!("({0} - {1} * trunc({0} / {1}))", a[0], a[1]),
            "FMod" => call("mod"),
            "SNegate" | "FNegate" => format!("(-{})", a[0]),
            "Not" => format!("(~{})", a[0]),
            "BitwiseAnd" => bin("&"),
            "BitwiseOr" => bin("|"),
            "BitwiseXor" => bin("^"),
            "ShiftLeftLogical" => bin("<<"),
            "ShiftRightArithmetic" => bin(">>"),
            "ShiftRightLogical" => format!("{rt}({} >> {})", u(&a[0], &rt), a[1]),
            "LogicalAnd" if !vector => bin("&&"),
            "LogicalOr" if !vector => bin("||"),
            "LogicalAnd" => format!("{rt}(uvec{0}({1}) & uvec{0}({2}))", rt.trim_start_matches("bvec"), a[0], a[1]),
            "LogicalOr" => format!("{rt}(uvec{0}({1}) | uvec{0}({2}))", rt.trim_start_matches("bvec"), a[0], a[1]),
            "LogicalNot" => if vector { call("not") } else { format!("(!{})", a[0]) },
            "LogicalEqual" | "IEqual" | "FOrdEqual" => cmp("==", "equal"),
            "LogicalNotEqual" | "INotEqual" | "FUnordNotEqual" => cmp("!=", "notEqual"),
            "SLessThan" | "FOrdLessThan" => cmp("<", "lessThan"),
            "SLessThanEqual" | "FOrdLessThanEqual" => cmp("<=", "lessThanEqual"),
            "SGreaterThan" | "FOrdGreaterThan" => cmp(">", "greaterThan"),
            "SGreaterThanEqual" | "FOrdGreaterThanEqual" => cmp(">=", "greaterThanEqual"),
            "ULessThan" => ucmp("<", "lessThan"),
            "ULessThanEqual" => ucmp("<=", "lessThanEqual"),
            "UGreaterThan" => ucmp(">", "greaterThan"),
            "UGreaterThanEqual" => ucmp(">=", "greaterThanEqual"),
            "FUnordLessThan" if !vector => format!("(!({} >= {}))", a[0], a[1]),
            "FUnordGreaterThan" if !vector => format!("(!({} <= {}))", a[0], a[1]),
            "FUnordLessThanEqual" if !vector => format!("(!({} > {}))", a[0], a[1]),
            "FUnordGreaterThanEqual" if !vector => format!("(!({} < {}))", a[0], a[1]),
            "FUnordEqual" if !vector => format!("(!({0} != {1}) || isnan({0}) || isnan({1}))", a[0], a[1]),
            "FOrdNotEqual" if !vector => format!("({0} != {1} && !isnan({0}) && !isnan({1}))", a[0], a[1]),
            "IsNan" => call("isnan"),
            "IsInf" => call("isinf"),
            "Select" => {
                let cond_t = self.ty(&self.body[d.operands[0]].ty.clone())?;
                if cond_t.contains("vec") { format!("mix({}, {}, {})", a[2], a[1], a[0]) } else { format!("({} ? {} : {})", a[0], a[1], a[2]) }
            }
            "ConvertFToS" | "ConvertSToF" | "FConvert" | "SConvert" => format!("{rt}({})", a[0]),
            "ConvertFToU" => format!("{rt}({}({}))", Self::unsigned(&rt), a[0]),
            "ConvertUToF" => format!("{rt}({})", u(&a[0], &in_t)),
            "UConvert" => format!("{rt}({}({}))", Self::unsigned(&rt), u(&a[0], &in_t)),
            "Bitcast" => {
                let from_f = in_t.contains("vec") && !in_t.starts_with(['i', 'u', 'b']) || in_t == "float";
                let to_f = rt.contains("vec") && !rt.starts_with(['i', 'u', 'b']) || rt == "float";
                match (from_f, to_f) {
                    (true, false) => format!("{rt}(floatBitsToInt({}))", a[0]),
                    (false, true) => format!("intBitsToFloat({}({}))", in_t.replacen("uint", "int", 1).replacen("uvec", "ivec", 1), a[0]),
                    _ => format!("{rt}({})", a[0]),
                }
            }
            "CompositeConstruct" => format!("{rt}({})", a.join(", ")),
            "CompositeExtract" => format!("{}{}", a[0], self.indices(op, &self.body[d.operands[0]].ty.clone())?),
            "VectorExtractDynamic" => format!("{}[{}]", a[0], a[1]),
            "VectorShuffle" => {
                let Some(Attribute::Array(cs)) = self.attr(op, "components") else { return unsupported("VectorShuffle without components") };
                let n1 = self.body[d.operands[0]].ty.element_count().unwrap_or(0) as i64;
                let parts: Vec<String> = cs.iter().map(|c| Self::int_attr(Some(c)).unwrap_or(0)).map(|k| match k {
                        // -1: an undefined component; any value will do.
                        k if k < 0 => format!("{}[0]", a[0]),
                        k if k < n1 => format!("{}[{k}]", a[0]),
                        k => format!("{}[{}]", a[1], k - n1),
                    }).collect();
                format!("{rt}({})", parts.join(", "))
            }
            "Dot" => call("dot"),
            "MatrixTimesMatrix" | "MatrixTimesVector" | "VectorTimesMatrix" | "MatrixTimesScalar" | "VectorTimesScalar" => bin("*"),
            "Transpose" => call("transpose"),
            "BitCount" => format!("{rt}(bitCount({}))", a[0]),
            "BitReverse" => call("bitfieldReverse"),
            "BitFieldInsert" => call("bitfieldInsert"),
            "BitFieldSExtract" => call("bitfieldExtract"),
            "BitFieldUExtract" => format!("{rt}(bitfieldExtract({}, {}, {}))", u(&a[0], &rt), a[1], a[2]),
            gl => match gl.strip_prefix("GL.") {
                Some(f) => {
                    let g = match f {
                        "FAbs" | "SAbs" => "abs",
                        "FSign" | "SSign" => "sign",
                        "Floor" => "floor",
                        "Ceil" => "ceil",
                        "Round" => "round",
                        "RoundEven" => "roundEven",
                        "Trunc" => "trunc",
                        "Fract" => "fract",
                        "Sqrt" => "sqrt",
                        "InverseSqrt" => "inversesqrt",
                        "Exp" => "exp",
                        "Log" => "log",
                        "Exp2" => "exp2",
                        "Log2" => "log2",
                        "Pow" => "pow",
                        "Sin" => "sin",
                        "Cos" => "cos",
                        "Tan" => "tan",
                        "Asin" => "asin",
                        "Acos" => "acos",
                        "Atan" => "atan",
                        "Atan2" => "atan",
                        "Sinh" => "sinh",
                        "Cosh" => "cosh",
                        "Tanh" => "tanh",
                        "Asinh" => "asinh",
                        "Acosh" => "acosh",
                        "Atanh" => "atanh",
                        "FMin" | "SMin" => "min",
                        "FMax" | "SMax" => "max",
                        "FClamp" | "SClamp" => "clamp",
                        "FMix" => "mix",
                        "Fma" => "fma",
                        "Step" => "step",
                        "SmoothStep" => "smoothstep",
                        "Ldexp" => "ldexp",
                        "Length" => "length",
                        "Distance" => "distance",
                        "Cross" => "cross",
                        "Normalize" => "normalize",
                        "Reflect" => "reflect",
                        "FindILsb" => "findLSB",
                        "FindSMsb" => "findMSB",
                        "UMin" | "UMax" | "UClamp" => {
                            let args: Vec<String> = a.iter().map(|x| u(x, &rt)).collect();
                            return Ok(format!("{rt}({}({}))", if f == "UMin" { "min" } else if f == "UMax" { "max" } else { "clamp" }, args.join(", ")));
                        }
                        f => return unsupported(format_args!("'spirv.GL.{f}'")),
                    };
                    call(g)
                }
                None => return unsupported(format_args!("'{name}'")),
            },
        };
        Ok(e)
    }
}

impl SpirvGlsl {
    /// The glslang stage of `module`'s entry point (`comp`, `vert`, `frag`), if it has one.
    pub fn stage(body: &Body<'_>, module: OpId) -> Option<&'static str> {
        let ep = body[body.top_block(module)].ops.iter().find(|o| body[**o].name == "spirv.EntryPoint")?;
        let model = EnumSpec::attr_value(body[*ep].get("execution_model")?)?;
        let case = |n: &str| EnumSpec::of("ExecutionModel").and_then(|e| e.value(n));
        [("GLCompute", "comp"), ("Vertex", "vert"), ("Fragment", "frag")].into_iter().find(|(n, _)| case(n) == Some(model)).map(|(_, s)| s)
    }
}
