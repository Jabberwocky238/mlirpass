//! `spirv.module` ⇒ SPIR-V binary, as `Serializer.cpp` / `SerializeOps.cpp`: the words
//! `mlir-translate --serialize-spirv` writes, in the same order with the same <id>s.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::{SpirvDecoration, SpirvType};
use mlirformat::{Attribute, Const, Error, FloatKind, NamedAttr, Scalar, ShapedKind, Signedness, Type};

use super::{Arg, AttrKind, Code, EnumSpec, Group, OpSpec};
use crate::{Body, BlockId, Emit, OpId, ValueId};

/// `SerializationOptions`: `emitSymbolName` (debug info is not emitted).
#[derive(Debug, Clone, Copy)]
pub struct SpirvBinary {
    /// `OpName` for functions, globals, spec constants and identified structs.
    pub symbol_names: bool,
}

impl Default for SpirvBinary {
    fn default() -> Self {
        Self { symbol_names: true }
    }
}

impl SpirvBinary {
    /// The words as the bytes of a `.spv` file (little endian).
    pub fn bytes(words: &[u32]) -> Vec<u8> {
        words.iter().flat_map(|w| w.to_le_bytes()).collect()
    }
}

impl Emit for SpirvBinary {
    type Output = Vec<u32>;

    /// `spirv::serialize`: `op` is a `spirv.module`.
    fn emit(&self, body: &Body<'_>, op: OpId) -> Result<Vec<u32>, Error> {
        let mut s = Serializer::new(body, op, *self);
        s.serialize()?;
        Ok(s.collect())
    }
}

/// A constant as `constIDMap` tells constants apart: the attribute (value and type).
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord)]
enum ConstKey {
    /// An integer (`BoolAttr` is the `i1` one): its type and bits.
    Int(String, u128),
    Float(String, u64),
    /// Anything else, by its text.
    Text(String),
}

/// The merge instruction a header block emits (`emitSelectionMerge` / `emitLoopMerge`).
#[derive(Clone, Copy)]
enum Merge {
    Selection { merge: u32, control: u32 },
    Loop { merge: u32, cont: u32, control: u32 },
}

fn err<T>(msg: impl Into<String>) -> Result<T, Error> {
    Err(Error(msg.into()))
}

struct Serializer<'b, 'a> {
    body: &'b Body<'a>,
    module: OpId,
    opts: SpirvBinary,
    next_id: u32,
    capabilities: Vec<u32>,
    extensions: Vec<u32>,
    extended_sets: Vec<u32>,
    memory_model: Vec<u32>,
    entry_points: Vec<u32>,
    execution_modes: Vec<u32>,
    names: Vec<u32>,
    decorations: Vec<u32>,
    types_globals: Vec<u32>,
    functions: Vec<u32>,
    graphs: Vec<u32>,
    /// Forward-declared pointers to an identified struct, by struct name.
    recursive_structs: BTreeMap<String, Vec<(u32, u32)>>,
    /// The decorations of the identified structs met so far: a name-only reference inside
    /// one is the same type as its definition.
    struct_decorations: BTreeMap<String, Vec<SpirvDecoration>>,
    function_header: Vec<u32>,
    function_body: Vec<u32>,
    type_ids: BTreeMap<String, u32>,
    const_ids: BTreeMap<ConstKey, u32>,
    replicate_ids: BTreeMap<(String, String), u32>,
    graph_const_ids: BTreeMap<ConstKey, u32>,
    spec_const_ids: BTreeMap<String, u32>,
    global_var_ids: BTreeMap<String, u32>,
    func_ids: BTreeMap<String, u32>,
    block_ids: BTreeMap<BlockId, u32>,
    undef_ids: BTreeMap<String, u32>,
    value_ids: BTreeMap<ValueId, u32>,
    /// `replaceAllUsesWith` of a selection's / loop's results by its merge's operands.
    aliases: BTreeMap<ValueId, ValueId>,
    ext_sets: BTreeMap<String, u32>,
    /// Phi operands defined later in the function: where their <id> goes.
    deferred_phis: BTreeMap<ValueId, Vec<usize>>,
}

impl<'b, 'a> Serializer<'b, 'a> {
    fn new(body: &'b Body<'a>, module: OpId, opts: SpirvBinary) -> Self {
        Self {
            body,
            module,
            opts,
            next_id: 1,
            capabilities: Vec::new(),
            extensions: Vec::new(),
            extended_sets: Vec::new(),
            memory_model: Vec::new(),
            entry_points: Vec::new(),
            execution_modes: Vec::new(),
            names: Vec::new(),
            decorations: Vec::new(),
            types_globals: Vec::new(),
            functions: Vec::new(),
            graphs: Vec::new(),
            recursive_structs: BTreeMap::new(),
            struct_decorations: BTreeMap::new(),
            function_header: Vec::new(),
            function_body: Vec::new(),
            type_ids: BTreeMap::new(),
            const_ids: BTreeMap::new(),
            replicate_ids: BTreeMap::new(),
            graph_const_ids: BTreeMap::new(),
            spec_const_ids: BTreeMap::new(),
            global_var_ids: BTreeMap::new(),
            func_ids: BTreeMap::new(),
            block_ids: BTreeMap::new(),
            undef_ids: BTreeMap::new(),
            value_ids: BTreeMap::new(),
            aliases: BTreeMap::new(),
            ext_sets: BTreeMap::new(),
            deferred_phis: BTreeMap::new(),
        }
    }

    fn next(&mut self) -> u32 {
        let id = self.next_id;
        self.next_id += 1;
        id
    }

    /// `encodeInstructionInto`.
    fn encode(out: &mut Vec<u32>, opcode: &str, operands: &[u32]) {
        out.push(((1 + operands.len() as u32) << 16) | EnumSpec::opcode(opcode));
        out.extend_from_slice(operands);
    }

    fn encode_code(out: &mut Vec<u32>, opcode: u32, operands: &[u32]) {
        out.push(((1 + operands.len() as u32) << 16) | opcode);
        out.extend_from_slice(operands);
    }

    /// `encodeStringLiteralInto`: the bytes, nul-terminated, padded to words.
    fn string(out: &mut Vec<u32>, s: &str) {
        let mut bytes = s.as_bytes().to_vec();
        bytes.resize((s.len() / 4 + 1) * 4, 0);
        out.extend(bytes.chunks(4).map(|c| u32::from_le_bytes([c[0], c[1], c[2], c[3]])));
    }

    fn enum_value(class: &str, name: &str) -> Result<u32, Error> {
        EnumSpec::of(class).and_then(|e| e.value(name)).ok_or_else(|| Error(format!("unknown {class} {name}")))
    }

    fn attr(&self, op: OpId, name: &str) -> Option<&'b Attribute<'a>> {
        self.body[op].get(name)
    }

    fn symbol(&self, op: OpId, name: &str) -> Result<String, Error> {
        match self.attr(op, name) {
            Some(Attribute::SymbolRef(p)) => Ok(p.iter().map(|s| &**s).collect::<Vec<_>>().join("::")),
            Some(Attribute::Str { lit, .. }) => Ok(String::from(&**lit)),
            _ => err(format!("'{}' has no symbol `{name}`", self.body[op].name)),
        }
    }

    fn enum_attr(&self, op: OpId, name: &str) -> Result<u32, Error> {
        self.attr(op, name).and_then(EnumSpec::attr_value).ok_or_else(|| Error(format!("'{}' has no enum `{name}`", self.body[op].name)))
    }

    /// An integer attribute's value, zero-extended.
    fn int_attr(a: &Attribute<'_>) -> Option<u64> {
        let c = Const::try_from(a).ok()?;
        Some(c.as_int()?.bits() as u64)
    }

    // ---- module ------------------------------------------------------------------------

    /// The `#spirv.vce<vX.Y, [caps], [exts]>` triple: version, capabilities, extensions.
    fn vce(&self) -> Result<(u32, Vec<String>, Vec<String>), Error> {
        let Some(Attribute::Extended { ext, .. }) = self.attr(self.module, "vce_triple") else { return err("spirv.module without vce_triple") };
        let body = ext.body.as_deref().unwrap_or("").trim_start_matches('<').trim_end_matches('>');
        let (version, rest) = body.split_once(',').ok_or_else(|| Error(String::from("bad vce")))?;
        let minor = version.trim().strip_prefix("v1.").and_then(|m| m.parse::<u32>().ok()).ok_or_else(|| Error(format!("bad version {version}")))?;
        let lists: Vec<Vec<String>> = rest
            .split(']')
            .filter_map(|l| l.trim_start_matches([',', ' ']).strip_prefix('['))
            .map(|l| l.split(',').map(str::trim).filter(|s| !s.is_empty()).map(String::from).collect())
            .collect();
        let [caps, exts] = <[Vec<String>; 2]>::try_from(lists).map_err(|_| Error(String::from("bad vce lists")))?;
        Ok((minor, caps, exts))
    }

    fn serialize(&mut self) -> Result<(), Error> {
        let (_, caps, exts) = self.vce()?;
        for c in &caps {
            let v = Self::enum_value("Capability", c)?;
            Self::encode(&mut self.capabilities, "OpCapability", &[v]);
        }
        // `SmallSet<Extension, 4>`: insertion order while small, by value once it grows.
        let mut seen: Vec<&String> = Vec::new();
        for e in &exts {
            if !seen.contains(&e) {
                seen.push(e);
            }
        }
        if seen.len() > 4 {
            seen.sort_by_key(|e| Self::enum_value("Extension", e).unwrap_or(u32::MAX));
        }
        for e in seen {
            let mut ops = Vec::new();
            Self::string(&mut ops, e);
            Self::encode(&mut self.extensions, "OpExtension", &ops);
        }
        let mm = self.enum_attr(self.module, "memory_model")?;
        let am = self.enum_attr(self.module, "addressing_model")?;
        Self::encode(&mut self.memory_model, "OpMemoryModel", &[am, mm]);
        // `moveFuncDeclarationsToTop`.
        let ops = self.body[self.body.top_block(self.module)].ops.clone();
        let order = Self::declarations_first(self.body, &ops);
        for op in order {
            self.operation(op)?;
        }
        Ok(())
    }

    /// The module's ops with the function declarations after the first op moved before it.
    fn declarations_first(body: &Body<'_>, ops: &[OpId]) -> Vec<OpId> {
        let decl = |o: &OpId| body[*o].name == "spirv.func" && body[body[*o].regions[0]].blocks.is_empty();
        let Some((first, rest)) = ops.split_first() else { return Vec::new() };
        let mut out: Vec<OpId> = rest.iter().copied().filter(decl).collect();
        out.push(*first);
        out.extend(rest.iter().copied().filter(|o| !decl(o)));
        out
    }

    fn collect(self) -> Vec<u32> {
        let (minor, ..) = self.vce().unwrap_or((0, Vec::new(), Vec::new()));
        let mut out = vec![0x0723_0203, (1 << 16) | (minor << 8), (22 << 16) | 22, self.next_id, 0];
        for part in [&self.capabilities, &self.extensions, &self.extended_sets, &self.memory_model, &self.entry_points, &self.execution_modes, &self.names, &self.decorations, &self.types_globals, &self.functions, &self.graphs] {
            out.extend_from_slice(part);
        }
        out
    }

    fn function_id(&mut self, name: &str) -> u32 {
        if let Some(id) = self.func_ids.get(name) {
            return *id;
        }
        let id = self.next();
        self.func_ids.insert(String::from(name), id);
        id
    }

    fn name(&mut self, id: u32, name: &str) {
        if !self.opts.symbol_names {
            return;
        }
        let mut ops = vec![id];
        Self::string(&mut ops, name);
        Self::encode(&mut self.names, "OpName", &ops);
    }

    // ---- decorations -------------------------------------------------------------------

    /// `getDecorationName`: the decoration an attribute name stands for.
    fn decoration_name(attr: &str) -> String {
        match attr {
            "fp_fast_math_mode" => String::from("FPFastMathMode"),
            "fp_rounding_mode" => String::from("FPRoundingMode"),
            "cache_control_load_intel" => String::from("CacheControlLoadINTEL"),
            "cache_control_store_intel" => String::from("CacheControlStoreINTEL"),
            a => Self::camel(a),
        }
    }

    /// `convertToCamelFromSnakeCase(s, /*capitalizeFirst=*/true)`.
    fn camel(s: &str) -> String {
        let mut out = String::new();
        let mut up = true;
        for c in s.chars() {
            if c == '_' {
                up = true;
            } else if up {
                out.extend(c.to_uppercase());
                up = false;
            } else {
                out.push(c);
            }
        }
        out
    }

    fn emit_decoration(&mut self, target: u32, decoration: u32, params: &[u32]) {
        let mut ops = vec![target, decoration];
        ops.extend_from_slice(params);
        Self::encode(&mut self.decorations, "OpDecorate", &ops);
    }

    /// `processDecoration`: a non-argument attribute as the decoration it names.
    fn decoration(&mut self, id: u32, attr: &NamedAttr<'_>) -> Result<(), Error> {
        let name = Self::decoration_name(&attr.name);
        let Some(deco) = EnumSpec::of("Decoration").and_then(|e| e.value(&name)) else {
            return err(format!("non-argument attributes expected to have snake-case-ified decoration name, unhandled attribute with name : {}", attr.name));
        };
        let value = attr.value.clone().unwrap_or(Attribute::Unit);
        self.decoration_attr(id, &name, deco, &value)
    }

    /// `processDecorationAttr`.
    fn decoration_attr(&mut self, id: u32, name: &str, deco: u32, attr: &Attribute<'_>) -> Result<(), Error> {
        let mut args = Vec::new();
        match name {
            "LinkageAttributes" => {
                let Attribute::Extended { ext, .. } = attr else { return err("expected linkage attributes") };
                let body = ext.body.as_deref().unwrap_or("");
                let lname = body.split('"').nth(1).ok_or_else(|| Error(String::from("linkage_name")))?;
                let ltype = body.rsplit_once("linkage_type").map(|(_, t)| t.trim_start_matches([' ', '=', '<']).trim_end_matches(['>', ' '])).ok_or_else(|| Error(String::from("linkage_type")))?;
                Self::string(&mut args, lname);
                args.push(Self::enum_value("LinkageType", ltype)?);
            }
            "FPFastMathMode" | "FPRoundingMode" => args.push(EnumSpec::attr_value(attr).ok_or_else(|| Error(format!("expected {name}Attr attribute")))?),
            "Binding" | "DescriptorSet" | "Location" | "Index" => args.push(Self::int_attr(attr).ok_or_else(|| Error(format!("expected integer attribute for {name}")))? as u32),
            "BuiltIn" => {
                let Attribute::Str { lit, .. } = attr else { return err("expected string attribute for BuiltIn") };
                args.push(Self::enum_value("BuiltIn", lit)?);
            }
            "Aliased" | "AliasedPointer" | "Flat" | "NonReadable" | "NonWritable" | "NoPerspective" | "NoSignedWrap" | "NoUnsignedWrap" | "RelaxedPrecision" | "Restrict" | "RestrictPointer" | "NoContraction" | "Constant" | "Block" | "Invariant" | "Patch" | "Coherent" => {
                let ok = matches!(attr, Attribute::Unit) || matches!(attr, Attribute::Extended { ext, .. } if ext.name == "spirv.decoration");
                if !ok {
                    return err(format!("expected unit attribute or decoration attribute for {name}"));
                }
            }
            "CacheControlLoadINTEL" | "CacheControlStoreINTEL" => {
                let Attribute::Array(list) = attr else { return err(format!("expecting array attribute of {name}")) };
                let (class, field) = if name == "CacheControlLoadINTEL" { ("LoadCacheControl", "load_cache_control") } else { ("StoreCacheControl", "store_cache_control") };
                for a in list {
                    let Attribute::Extended { ext, .. } = a else { return err(format!("expecting array attribute of {name}")) };
                    let body = ext.body.as_deref().unwrap_or("");
                    let field_of = |f: &str| body.split(f).nth(1).map(|v| v.trim_start_matches([' ', '=']).split([',', '>']).next().unwrap_or("").trim());
                    let level: u32 = field_of("cache_level").and_then(|v| v.parse().ok()).ok_or_else(|| Error(String::from("cache_level")))?;
                    let control = Self::enum_value(class, field_of(field).unwrap_or(""))?;
                    self.emit_decoration(id, deco, &[level, control]);
                }
                return Ok(());
            }
            _ => return err(format!("unhandled decoration {name}")),
        }
        self.emit_decoration(id, deco, &args);
        Ok(())
    }

    fn member_decoration(&mut self, struct_id: u32, member: u32, deco: u32, value: Option<u32>) {
        let mut ops = vec![struct_id, member, deco];
        ops.extend(value);
        Self::encode(&mut self.decorations, "OpMemberDecorate", &ops);
    }

    // ---- types -------------------------------------------------------------------------

    /// A type as `typeIDMap` tells types apart: identified structs by name.
    fn key(t: &Type<'_>) -> String {
        match SpirvType::try_from(t) {
            Ok(s) => format!("{}", Type::from(Self::named_structs(s))),
            Err(()) => match t {
                Type::Function(f) => {
                    let list = |ts: &[Type<'_>]| ts.iter().map(Self::key).collect::<Vec<_>>().join(", ");
                    format!("({}) -> ({})", list(&f.inputs), list(&f.results))
                }
                t => format!("{t}"),
            },
        }
    }

    /// `t` with every identified struct (at any depth) by name only.
    fn named_structs(t: SpirvType<'_>) -> SpirvType<'static> {
        let inner = |t: &Type<'_>| -> Type<'static> {
            match SpirvType::try_from(t) {
                Ok(s) => Self::named_structs(s).into(),
                Err(()) => {
                    let text = format!("{t}");
                    mlirformat::Parser::read(&text, |p| p.ty()).ok().map(|t| t.owned()).unwrap_or(Type::NoneType)
                }
            }
        };
        match t {
            SpirvType::Struct { name: Some(n), .. } => SpirvType::Struct { name: Some(n), members: None, decorations: Vec::new() },
            SpirvType::Struct { name: None, members, decorations } => SpirvType::Struct {
                name: None,
                members: members.map(|ms| ms.into_iter().map(|m| mlirformat::spirv_types::SpirvMember { ty: inner(&m.ty), offset: m.offset, decorations: m.decorations }).collect()),
                decorations,
            },
            SpirvType::Array { len, elem, stride } => SpirvType::Array { len, elem: inner(&elem).into(), stride },
            SpirvType::RuntimeArray { elem, stride } => SpirvType::RuntimeArray { elem: inner(&elem).into(), stride },
            SpirvType::Ptr { pointee, storage } => SpirvType::Ptr { pointee: inner(&pointee).into(), storage },
            SpirvType::Image { elem, params } => SpirvType::Image { elem: inner(&elem).into(), params },
            SpirvType::SampledImage(i) => SpirvType::SampledImage(inner(&i).into()),
            SpirvType::CoopMatrix { rows, cols, elem, scope, usage } => SpirvType::CoopMatrix { rows, cols, elem: inner(&elem).into(), scope, usage },
            SpirvType::Matrix { cols, column } => SpirvType::Matrix { cols, column: inner(&column).into() },
            SpirvType::TensorArm { shape, elem } => SpirvType::TensorArm { shape, elem: inner(&elem).into() },
        }
    }

    fn type_id(&mut self, t: &Type<'_>) -> Result<u32, Error> {
        self.type_in(t, &mut Vec::new())
    }

    /// `processTypeImpl`: `ctx` holds the identified structs being serialized around `t`.
    fn type_in(&mut self, t: &Type<'_>, ctx: &mut Vec<String>) -> Result<u32, Error> {
        let t = match t {
            Type::Integer { signedness: Signedness::Unsigned, width } => Type::int(*width),
            t => t.clone(),
        };
        let key = Self::key(&t);
        if let Some(id) = self.type_ids.get(&key) {
            return Ok(*id);
        }
        let id = self.next();
        let mut ops = vec![id];
        let Some(opcode) = self.prepare_type(&t, id, &mut ops, ctx)? else { return Ok(id) };
        self.type_ids.insert(key, id);
        Self::encode(&mut self.types_globals, opcode, &ops);
        if let Ok(SpirvType::Struct { name: Some(n), .. }) = SpirvType::try_from(&t)
            && let Some(ptrs) = self.recursive_structs.get_mut(&n).map(core::mem::take)
        {
            for (ptr, storage) in ptrs {
                Self::encode(&mut self.types_globals, "OpTypePointer", &[ptr, storage, id]);
            }
        }
        Ok(id)
    }

    /// `prepareFunctionType` / `prepareBasicType`: the opcode and operands of type `t` with
    /// result `id`; `None`: serialization deferred (a forward pointer).
    fn prepare_type(&mut self, t: &Type<'_>, id: u32, ops: &mut Vec<u32>, ctx: &mut Vec<String>) -> Result<Option<&'static str>, Error> {
        let op = match t {
            Type::Function(f) => {
                let ret = f.results.first().cloned().unwrap_or(Type::NoneType);
                ops.push(self.type_id(&ret)?);
                for i in &f.inputs {
                    ops.push(self.type_id(i)?);
                }
                "OpTypeFunction"
            }
            Type::NoneType => "OpTypeVoid",
            Type::Integer { width: 1, .. } => "OpTypeBool",
            Type::Integer { signedness, width } => {
                ops.extend([*width, u32::from(*signedness == Signedness::Signed)]);
                "OpTypeInt"
            }
            Type::Float(k) => {
                ops.push(t.bit_width().ok_or_else(|| Error(format!("unhandled type in serialization: {t}")))?);
                if *k == FloatKind::BF16 {
                    ops.push(Self::enum_value("FPEncoding", "BFloat16KHR")?);
                }
                "OpTypeFloat"
            }
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let elem = self.type_in(&s.elem, ctx)?;
                ops.extend([elem, t.element_count().unwrap_or(0) as u32]);
                "OpTypeVector"
            }
            t => return self.prepare_spirv_type(t, id, ops, ctx).map(|o| o),
        };
        Ok(Some(op))
    }

    fn prepare_spirv_type(&mut self, t: &Type<'_>, id: u32, ops: &mut Vec<u32>, ctx: &mut Vec<String>) -> Result<Option<&'static str>, Error> {
        let Ok(st) = SpirvType::try_from(t) else { return err(format!("unhandled type in serialization: {t}")) };
        let op = match st {
            SpirvType::Image { elem, params } => {
                ops.push(self.type_id(&elem)?);
                for (class, p) in ["Dim", "ImageDepthInfo", "ImageArrayedInfo", "ImageSamplingInfo", "ImageSamplerUseInfo", "ImageFormat"].iter().zip(&params) {
                    ops.push(Self::enum_value(class, p)?);
                }
                "OpTypeImage"
            }
            SpirvType::Array { len, elem, stride } => {
                let e = self.type_in(&elem, ctx)?;
                ops.push(e);
                ops.push(self.const_int(Type::int(32), len.into(), false)?);
                if stride != 0 {
                    self.emit_decoration(id, Self::enum_value("Decoration", "ArrayStride")?, &[stride]);
                }
                "OpTypeArray"
            }
            SpirvType::Ptr { pointee, storage } => {
                let sc = Self::enum_value("StorageClass", &storage)?;
                let pointee_struct = match SpirvType::try_from(&*pointee) {
                    Ok(SpirvType::Struct { name, members, decorations }) => Some((name, members, decorations)),
                    _ => None,
                };
                let mut pointee_id = 0;
                let mut defer = false;
                match &pointee_struct {
                    Some((Some(n), ..)) if ctx.contains(n) => {
                        Self::encode(&mut self.types_globals, "OpTypeForwardPointer", &[id, sc]);
                        defer = true;
                        self.recursive_structs.entry(n.clone()).or_default().push((id, sc));
                    }
                    _ => pointee_id = self.type_in(&pointee, ctx)?,
                }
                ops.extend([sc, pointee_id]);
                // `isInterfaceStructPtrType`: such a struct gets `Block` if it lacks it.
                let block = |decos: &[SpirvDecoration]| decos.iter().any(|d| d.name == "Block");
                if let Some((name, members, decos)) = &pointee_struct
                    && matches!(&*storage, "PhysicalStorageBuffer" | "PushConstant" | "StorageBuffer" | "Uniform")
                    && !match (name, members) {
                        (Some(n), None) => self.struct_decorations.get(n).is_some_and(|d| block(d)),
                        _ => block(decos),
                    }
                {
                    let target = self.type_ids.get(&Self::key(&pointee)).copied().unwrap_or(0);
                    self.emit_decoration(target, Self::enum_value("Decoration", "Block")?, &[]);
                }
                if defer {
                    return Ok(None);
                }
                "OpTypePointer"
            }
            SpirvType::RuntimeArray { elem, stride } => {
                ops.push(self.type_in(&elem, ctx)?);
                if stride != 0 {
                    self.emit_decoration(id, Self::enum_value("Decoration", "ArrayStride")?, &[stride]);
                }
                "OpTypeRuntimeArray"
            }
            SpirvType::SampledImage(image) => {
                ops.push(self.type_id(&image)?);
                "OpTypeSampledImage"
            }
            SpirvType::Struct { name, members, decorations } => {
                let Some(members) = members else { return err(format!("struct {name:?} used before its body")) };
                if let Some(n) = &name {
                    self.name(id, n);
                    ctx.push(n.clone());
                    self.struct_decorations.insert(n.clone(), decorations.clone());
                }
                let has_offset = members.iter().any(|m| m.offset.is_some());
                let offset = Self::enum_value("Decoration", "Offset")?;
                for (i, m) in members.iter().enumerate() {
                    ops.push(self.type_in(&m.ty, ctx)?);
                    if has_offset {
                        self.member_decoration(id, i as u32, offset, Some(m.offset.unwrap_or(0)));
                    }
                }
                for (i, m) in members.iter().enumerate() {
                    for d in &m.decorations {
                        let v = d.value.as_deref().map(|v| v.trim().parse::<i64>().map(|x| x as u32)).transpose().map_err(|_| Error(format!("bad member decoration {}", d.name)))?;
                        self.member_decoration(id, i as u32, Self::enum_value("Decoration", &d.name)?, v);
                    }
                }
                for SpirvDecoration { name: dn, value } in &decorations {
                    let value = match value {
                        Some(v) => mlirformat::Parser::read(v, |p| p.attr()).ok().map(|a| a.owned()).ok_or_else(|| Error(format!("bad decoration value {v}")))?,
                        None => Attribute::Unit,
                    };
                    self.decoration_attr(id, dn, Self::enum_value("Decoration", dn)?, &value)?;
                }
                if let Some(n) = &name {
                    ctx.retain(|c| c != n);
                }
                "OpTypeStruct"
            }
            SpirvType::CoopMatrix { rows, cols, elem, scope, usage } => {
                let e = self.type_in(&elem, ctx)?;
                let scope = Self::enum_value("Scope", &scope)?;
                let usage = Self::enum_value("CooperativeMatrixUseKHR", &usage)?;
                ops.push(e);
                for v in [scope, rows, cols, usage] {
                    ops.push(self.const_int(Type::int(32), v.into(), false)?);
                }
                "OpTypeCooperativeMatrixKHR"
            }
            SpirvType::Matrix { cols, column } => {
                ops.extend([self.type_in(&column, ctx)?, cols]);
                "OpTypeMatrix"
            }
            SpirvType::TensorArm { shape, elem } => {
                ops.push(self.type_in(&elem, ctx)?);
                if let Some(dims) = shape {
                    let rank = dims.len() as u32;
                    ops.push(self.const_int(Type::int(32), rank.into(), false)?);
                    if rank > 0 && dims.iter().all(|d| *d > 0) {
                        let arr = SpirvType::array(rank, Type::int(32), 0);
                        let shape_id = if rank == 1 {
                            let tid = self.type_id(&arr)?;
                            let rid = self.next();
                            let c = self.const_int(Type::int(32), dims[0] as u128, false)?;
                            Self::encode(&mut self.types_globals, "OpConstantComposite", &[tid, rid, c]);
                            rid
                        } else {
                            let elems: Vec<Attribute<'static>> = dims.iter().map(|d| Attribute::integer(i128::from(*d), Type::int(32))).collect();
                            self.array_const(&arr, &elems)?
                        };
                        ops.push(shape_id);
                    }
                }
                "OpTypeTensorARM"
            }
        };
        Ok(Some(op))
    }

    // ---- constants ---------------------------------------------------------------------

    fn const_key(a: &Attribute<'_>) -> ConstKey {
        match (a, Const::try_from(a)) {
            (Attribute::Bool(b), _) => ConstKey::Int(String::from("i1"), u128::from(*b)),
            (_, Ok(c)) if !c.elements => match c.values[0] {
                Scalar::Int(i) => ConstKey::Int(format!("{}", c.ty), i.bits()),
                Scalar::Float(f) => ConstKey::Float(format!("{}", c.ty), f.bits),
            },
            _ => ConstKey::Text(format!("{a}")),
        }
    }

    /// `prepareConstant`.
    fn constant(&mut self, ty: &Type<'_>, value: &Attribute<'_>) -> Result<u32, Error> {
        if let Some(id) = self.scalar_const(value, false)? {
            return Ok(id);
        }
        let key = Self::const_key(value);
        if let Some(id) = self.const_ids.get(&key) {
            return Ok(*id);
        }
        self.type_id(ty)?;
        let id = match value {
            Attribute::Array(elems) => self.array_const(ty, elems)?,
            a => {
                let c = Self::dense(a).ok_or_else(|| Error(format!("cannot serialize attribute: {a}")))?;
                let rank = c.ty.shape().map_or(0, |s| s.len());
                self.dense_const(ty, &c, 0, &mut vec![0; rank])?
            }
        };
        self.const_ids.insert(key, id);
        Ok(id)
    }

    /// A dense attribute's elements; one typed by a shaped SPIR-V type (`!spirv.arm.tensor`,
    /// `!spirv.coopmatrix`) reads as the builtin tensor of its shape.
    fn dense<'x>(a: &Attribute<'x>) -> Option<Const<'x>> {
        if let Ok(c) = Const::try_from(a) {
            return Some(c);
        }
        let Attribute::Builtin { name, body, ty: Some(ty) } = a else { return None };
        let (shape, elem) = match SpirvType::try_from(ty).ok()? {
            SpirvType::TensorArm { shape: Some(s), elem } => (s, elem),
            SpirvType::CoopMatrix { rows, cols, elem, .. } => (vec![i64::from(rows), i64::from(cols)], elem),
            _ => return None,
        };
        let tensor = Type::tensor(&shape, (*elem).clone());
        Const::try_from(&Attribute::Builtin { name: name.clone(), body: body.clone(), ty: Some(tensor) }).ok()
    }

    /// `prepareArrayConstant`.
    fn array_const(&mut self, ty: &Type<'_>, elems: &[Attribute<'_>]) -> Result<u32, Error> {
        let tid = self.type_id(ty)?;
        let id = self.next();
        let mut ops = vec![tid, id];
        let elem = Self::composite_element(ty)?;
        for e in elems {
            ops.push(self.constant(&elem, e)?);
        }
        Self::encode(&mut self.types_globals, "OpConstantComposite", &ops);
        Ok(id)
    }

    /// `CompositeType::getElementType(0)`.
    fn composite_element(ty: &Type<'_>) -> Result<Type<'static>, Error> {
        match ty {
            Type::Shaped(s) => Ok(s.elem.owned()),
            t => SpirvType::try_from(t).ok().and_then(|s| s.element().map(|e| e.owned())).ok_or_else(|| Error(format!("not a composite: {t}"))),
        }
    }

    /// `prepareDenseElementsConstant`: the element at `index` once `dim` reaches the rank.
    fn dense_const(&mut self, ty: &Type<'_>, c: &Const<'_>, dim: usize, index: &mut Vec<usize>) -> Result<u32, Error> {
        let shape: Vec<i64> = c.ty.shape().map(|s| s.iter().map(|d| i64::from(d)).collect()).unwrap_or_default();
        if dim == shape.len() {
            let flat = index.iter().zip(&shape).fold(0usize, |acc, (i, n)| acc * *n as usize + i);
            let elem = c.ty.element_type().owned();
            return match c.at(flat) {
                Scalar::Int(i) if elem == Type::I1 => self.bool_const(i.bits() != 0, false),
                Scalar::Int(i) => self.const_int(elem, i.bits(), false),
                Scalar::Float(f) => self.const_float(elem, f.bits, false),
            };
        }
        let tid = self.type_id(ty)?;
        let id = self.next();
        let mut ops = vec![tid, id];
        let mut elem = Self::composite_element(ty)?;
        let st = SpirvType::try_from(ty).ok();
        if let Some(SpirvType::TensorArm { shape: Some(s), elem: e }) = &st
            && s.len() > 1
        {
            elem = SpirvType::TensorArm { shape: Some(s[1..].to_vec()), elem: e.clone() }.into();
        }
        if matches!(st, Some(SpirvType::CoopMatrix { .. })) {
            if !c.is_splat() {
                return err("cannot serialize a non-splat value for a cooperative matrix type");
            }
            let rank = shape.len();
            ops.push(self.dense_const(&elem, c, rank, index)?);
        } else if matches!(st, Some(SpirvType::TensorArm { .. })) && c.values.iter().all(Self::is_zero) {
            Self::encode(&mut self.types_globals, "OpConstantNull", &[tid, id]);
            return Ok(id);
        } else {
            for i in 0..shape[dim] as usize {
                index[dim] = i;
                ops.push(self.dense_const(&elem, c, dim + 1, index)?);
            }
        }
        Self::encode(&mut self.types_globals, "OpConstantComposite", &ops);
        Ok(id)
    }

    fn is_zero(s: &Scalar) -> bool {
        match s {
            Scalar::Int(i) => i.bits() == 0,
            Scalar::Float(f) => f.bits << 1 == 0 || f.to_f64() == 0.0,
        }
    }

    /// `prepareConstantScalar`: `None` when `value` is no scalar.
    fn scalar_const(&mut self, value: &Attribute<'_>, spec: bool) -> Result<Option<u32>, Error> {
        if let Attribute::Bool(b) = value {
            return self.bool_const(*b, spec).map(Some);
        }
        let Ok(c) = Const::try_from(value) else { return Ok(None) };
        if c.elements || !matches!(value, Attribute::Int { .. } | Attribute::Float { .. }) {
            return Ok(None);
        }
        match c.values[0] {
            Scalar::Int(i) if c.ty == Type::I1 => self.bool_const(i.bits() != 0, spec).map(Some),
            Scalar::Int(i) => self.const_int(c.ty.clone(), i.bits(), spec).map(Some),
            Scalar::Float(f) => self.const_float(c.ty.clone(), f.bits, spec).map(Some),
        }
    }

    fn bool_const(&mut self, b: bool, spec: bool) -> Result<u32, Error> {
        let key = ConstKey::Int(String::from("i1"), u128::from(b));
        if !spec && let Some(id) = self.const_ids.get(&key) {
            return Ok(*id);
        }
        let tid = self.type_id(&Type::I1)?;
        let id = self.next();
        let op = match (b, spec) {
            (true, false) => "OpConstantTrue",
            (false, false) => "OpConstantFalse",
            (true, true) => "OpSpecConstantTrue",
            (false, true) => "OpSpecConstantFalse",
        };
        Self::encode(&mut self.types_globals, op, &[tid, id]);
        if !spec {
            self.const_ids.insert(key, id);
        }
        Ok(id)
    }

    /// `prepareConstantInt`: `bits` of an integer of type `ty`.
    fn const_int(&mut self, ty: Type<'_>, bits: u128, spec: bool) -> Result<u32, Error> {
        let key = ConstKey::Int(format!("{ty}"), bits);
        if !spec && let Some(id) = self.const_ids.get(&key) {
            return Ok(*id);
        }
        let tid = self.type_id(&ty)?;
        let id = self.next();
        let Type::Integer { signedness, width } = ty else { return err(format!("not an integer type: {ty}")) };
        let signed = signedness == Signedness::Signed;
        let ext = |w: u32| -> u64 {
            let v = bits & ((1u128 << w) - 1);
            if signed && w < 64 && v >> (w - 1) & 1 == 1 { (v as u64) | (!0u64 << w) } else { v as u64 }
        };
        let op = if spec { "OpSpecConstant" } else { "OpConstant" };
        match width {
            8 | 16 | 32 => Self::encode(&mut self.types_globals, op, &[tid, id, ext(width) as u32]),
            64 => {
                let v = ext(64);
                Self::encode(&mut self.types_globals, op, &[tid, id, v as u32, (v >> 32) as u32]);
            }
            w => return err(format!("cannot serialize {w}-bit integer literal")),
        }
        if !spec {
            self.const_ids.insert(key, id);
        }
        Ok(id)
    }

    /// `prepareConstantFp`.
    fn const_float(&mut self, ty: Type<'_>, bits: u64, spec: bool) -> Result<u32, Error> {
        let key = ConstKey::Float(format!("{ty}"), bits);
        if !spec && let Some(id) = self.const_ids.get(&key) {
            return Ok(*id);
        }
        let tid = self.type_id(&ty)?;
        let id = self.next();
        let op = if spec { "OpSpecConstant" } else { "OpConstant" };
        match ty {
            Type::Float(FloatKind::F32 | FloatKind::F16 | FloatKind::BF16) => Self::encode(&mut self.types_globals, op, &[tid, id, bits as u32]),
            Type::Float(FloatKind::F64) => Self::encode(&mut self.types_globals, op, &[tid, id, bits as u32, (bits >> 32) as u32]),
            t => return err(format!("cannot serialize {t}-typed float literal")),
        }
        if !spec {
            self.const_ids.insert(key, id);
        }
        Ok(id)
    }

    /// `prepareConstantCompositeReplicate`.
    fn replicate_const(&mut self, ty: &Type<'_>, value: &Attribute<'_>) -> Result<u32, Error> {
        let key = (format!("{value}"), Self::key(ty));
        if let Some(id) = self.replicate_ids.get(&key) {
            return Ok(*id);
        }
        let tid = self.type_id(ty)?;
        let value_ty = Self::value_type(value);
        let elem = Self::composite_element(ty)?;
        let cid = if value_ty.as_ref().is_some_and(|v| Self::key(v) == Self::key(&elem)) { self.constant(&elem, value)? } else { self.replicate_const(&elem, value)? };
        let id = self.next();
        let zero = Self::dense(value).is_some_and(|c| c.values.iter().all(Self::is_zero));
        if matches!(SpirvType::try_from(ty), Ok(SpirvType::TensorArm { .. })) && zero {
            Self::encode(&mut self.types_globals, "OpConstantNull", &[tid, id]);
        } else {
            Self::encode(&mut self.types_globals, "OpConstantCompositeReplicateEXT", &[tid, id, cid]);
        }
        self.replicate_ids.insert(key, id);
        Ok(id)
    }

    /// `getValueType`: a typed attribute's type; an array's as `!spirv.array`.
    fn value_type(a: &Attribute<'_>) -> Option<Type<'static>> {
        match a {
            Attribute::Array(es) => Some(SpirvType::array(es.len() as u32, Self::value_type(es.first()?)?, 0)),
            Attribute::Bool(_) => Some(Type::I1),
            a => Const::try_from(a).ok().map(|c| c.ty.owned()),
        }
    }

    // ---- values ------------------------------------------------------------------------

    fn resolve(&self, mut v: ValueId) -> ValueId {
        while let Some(t) = self.aliases.get(&v) {
            v = *t;
        }
        v
    }

    /// `getValueID`: 0 when not yet defined.
    fn value_id(&self, v: ValueId) -> u32 {
        self.value_ids.get(&self.resolve(v)).copied().unwrap_or(0)
    }

    fn block_id(&mut self, b: BlockId) -> u32 {
        if let Some(id) = self.block_ids.get(&b) {
            return *id;
        }
        let id = self.next();
        self.block_ids.insert(b, id);
        id
    }

    // ---- operations --------------------------------------------------------------------

    /// `processOperation`.
    fn operation(&mut self, op: OpId) -> Result<(), Error> {
        let name = self.body[op].name.clone();
        match &*name {
            "spirv.mlir.addressof" => {
                let var = self.symbol(op, "variable")?;
                let id = self.global_var_ids.get(&var).copied().ok_or_else(|| Error(format!("unknown result <id> for variable {var}")))?;
                self.value_ids.insert(self.body[op].results[0], id);
            }
            "spirv.mlir.referenceof" => {
                let c = self.symbol(op, "spec_const")?;
                let id = self.spec_const_ids.get(&c).copied().ok_or_else(|| Error(format!("unknown result <id> for specialization constant {c}")))?;
                self.value_ids.insert(self.body[op].results[0], id);
            }
            "spirv.Branch" => {
                let t = self.block_id(self.body[op].successors[0]);
                Self::encode(&mut self.function_body, "OpBranch", &[t]);
            }
            "spirv.BranchConditional" => {
                let cond = self.value_id(self.body[op].operands[0]);
                let (t, f) = (self.block_id(self.body[op].successors[0]), self.block_id(self.body[op].successors[1]));
                let mut ops = vec![cond, t, f];
                if let Some(Attribute::Array(ws)) = self.attr(op, "branch_weights") {
                    ops.extend(ws.iter().filter_map(Self::int_attr).map(|w| w as u32));
                }
                Self::encode(&mut self.function_body, "OpBranchConditional", &ops);
            }
            "spirv.Switch" => self.switch(op)?,
            "spirv.Constant" => {
                let ty = self.body[self.body[op].results[0]].ty.clone();
                let value = self.attr(op, "value").cloned().ok_or_else(|| Error(String::from("spirv.Constant without value")))?;
                let id = self.constant(&ty, &value)?;
                self.value_ids.insert(self.body[op].results[0], id);
            }
            "spirv.EXT.ConstantCompositeReplicate" => {
                let ty = self.body[self.body[op].results[0]].ty.clone();
                let value = self.attr(op, "value").cloned().unwrap_or(Attribute::Unit);
                let id = self.replicate_const(&ty, &value)?;
                self.value_ids.insert(self.body[op].results[0], id);
            }
            "spirv.func" => self.function(op)?,
            "spirv.ARM.Graph" => self.graph(op)?,
            "spirv.ARM.GraphEntryPoint" => {
                let g = self.symbol(op, "fn")?;
                let mut ops = vec![self.function_id(&g)];
                Self::string(&mut ops, &g);
                if let Some(Attribute::Array(vars)) = self.attr(op, "interface") {
                    for v in vars {
                        let Attribute::SymbolRef(p) = v else { continue };
                        ops.push(self.global_var_ids.get(&*p[0]).copied().ok_or_else(|| Error(String::from("referencing undefined global variable")))?);
                    }
                }
                Self::encode(&mut self.graphs, "OpGraphEntryPointARM", &ops);
            }
            "spirv.ARM.GraphOutputs" => {
                for (i, v) in self.body[op].operands.clone().into_iter().enumerate() {
                    self.type_id(&self.body[v].ty.clone())?;
                    let out = self.value_id(v);
                    let index = self.const_int(Type::int(32), i as u128, false)?;
                    Self::encode(&mut self.function_body, "OpGraphSetOutputARM", &[out, index]);
                }
            }
            "spirv.ARM.GraphConstant" => {
                let r = self.body[op].results[0];
                let id = self.graph_constant(&self.body[r].ty.clone(), op)?;
                self.value_ids.insert(r, id);
            }
            "spirv.GlobalVariable" => self.global_variable(op)?,
            "spirv.Variable" => self.variable(op)?,
            "spirv.mlir.selection" => self.selection(op)?,
            "spirv.mlir.loop" => self.loop_op(op)?,
            "spirv.SpecConstant" => {
                let value = self.attr(op, "default_value").cloned().unwrap_or(Attribute::Unit);
                let id = self.scalar_const(&value, true)?.ok_or_else(|| Error(String::from("bad spec constant")))?;
                if let Some(spec) = self.attr(op, "spec_id").and_then(Self::int_attr) {
                    self.emit_decoration(id, Self::enum_value("Decoration", "SpecId")?, &[spec as u32]);
                }
                let n = self.symbol(op, "sym_name")?;
                self.spec_const_ids.insert(n.clone(), id);
                self.name(id, &n);
            }
            "spirv.SpecConstantComposite" | "spirv.EXT.SpecConstantCompositeReplicate" => {
                let Some(Attribute::Type(ty)) = self.attr(op, "type").cloned() else { return err("spec constant composite without type") };
                let tid = self.type_id(&ty)?;
                let replicate = name == "spirv.EXT.SpecConstantCompositeReplicate";
                let parts: Vec<String> = match self.attr(op, if replicate { "constituent" } else { "constituents" }) {
                    Some(Attribute::Array(cs)) => cs.iter().filter_map(|c| if let Attribute::SymbolRef(p) = c { Some(String::from(&*p[0])) } else { None }).collect(),
                    Some(Attribute::SymbolRef(p)) => vec![String::from(&*p[0])],
                    _ => Vec::new(),
                };
                let id = self.next();
                let mut ops = vec![tid, id];
                for p in parts {
                    ops.push(self.spec_const_ids.get(&p).copied().ok_or_else(|| Error(format!("unknown result <id> for specialization constant {p}")))?);
                }
                Self::encode(&mut self.types_globals, if replicate { "OpSpecConstantCompositeReplicateEXT" } else { "OpSpecConstantComposite" }, &ops);
                let n = self.symbol(op, "sym_name")?;
                self.spec_const_ids.insert(n.clone(), id);
                self.name(id, &n);
            }
            "spirv.SpecConstantOperation" => {
                let tid = self.type_id(&self.body[self.body[op].results[0]].ty.clone())?;
                let id = self.next();
                let block = self.body[self.body[op].regions[0]].blocks[0];
                let enclosed = self.body[block].ops[0];
                let opname = format!("Op{}", self.body[enclosed].name.strip_prefix("spirv.").unwrap_or(""));
                let code = EnumSpec::of("Opcode").and_then(|e| e.value(&opname)).ok_or_else(|| Error(format!("Couldn't find op code for op {}", self.body[enclosed].name)))?;
                let mut ops = vec![tid, id, code];
                ops.extend(self.body[enclosed].operands.iter().map(|v| self.value_id(*v)));
                Self::encode(&mut self.types_globals, "OpSpecConstantOp", &ops);
                self.value_ids.insert(self.body[op].results[0], id);
            }
            "spirv.Undef" => {
                let ty = self.body[self.body[op].results[0]].ty.clone();
                let key = format!("{ty}");
                let id = match self.undef_ids.get(&key) {
                    Some(id) => *id,
                    None => {
                        let id = self.next();
                        self.undef_ids.insert(key, id);
                        let tid = self.type_id(&ty)?;
                        Self::encode(&mut self.types_globals, "OpUndef", &[tid, id]);
                        id
                    }
                };
                self.value_ids.insert(self.body[op].results[0], id);
            }
            _ => self.autogen(op)?,
        }
        Ok(())
    }

    /// `dispatchToAutogenSerialization`, and the `processOp` written by hand.
    fn autogen(&mut self, op: OpId) -> Result<(), Error> {
        let name = self.body[op].name.clone();
        let spec = OpSpec::of(&name).ok_or_else(|| Error(format!("'{name}' unhandled operation serialization")))?;
        if !spec.autogen {
            return match &*name {
                "spirv.EntryPoint" => self.entry_point(op),
                "spirv.ExecutionMode" => self.execution_mode(op),
                "spirv.FunctionCall" => self.function_call(op),
                "spirv.CopyMemory" => self.copy_memory(op),
                "spirv.GenericCastToPtrExplicit" => self.generic_cast_to_ptr_explicit(op),
                _ => err(format!("'{name}' unsupported op serialization")),
            };
        }
        if spec.plain {
            return self.without_grammar_attr(op, &spec.code);
        }
        let mut ops = Vec::new();
        let mut elided: Vec<&str> = Vec::new();
        let mut result = 0;
        if spec.results == 1 {
            let r = self.body[op].results[0];
            ops.push(self.type_id(&self.body[r].ty.clone())?);
            result = self.next();
            self.value_ids.insert(r, result);
            ops.push(result);
        }
        let groups = self.groups(op, spec.groups);
        for a in spec.args {
            match a {
                Arg::Operands(g) => {
                    for v in self.body[op].operands[groups[*g as usize].clone()].to_vec() {
                        ops.push(self.value_id(v));
                    }
                }
                Arg::Attr(n, kind, _) => {
                    if let Some(attr) = self.attr(op, n) {
                        match kind {
                            Some(AttrKind::ConstId) => {
                                let v = EnumSpec::attr_value(attr).ok_or_else(|| Error(format!("bad enum {n}")))?;
                                ops.push(self.const_int(Type::int(32), v.into(), false)?);
                            }
                            Some(AttrKind::Enum) => ops.push(EnumSpec::attr_value(attr).ok_or_else(|| Error(format!("bad enum {n}")))?),
                            Some(AttrKind::I32Array) => {
                                let Attribute::Array(es) = attr else { return err(format!("bad array {n}")) };
                                ops.extend(es.iter().filter_map(Self::int_attr).map(|v| v as u32));
                            }
                            Some(AttrKind::I32) => ops.push(Self::int_attr(attr).ok_or_else(|| Error(format!("bad integer {n}")))? as u32),
                            Some(AttrKind::Type) => {
                                let Attribute::Type(t) = attr else { return err(format!("bad type {n}")) };
                                ops.push(self.type_id(&t.clone())?);
                            }
                            None => return err(format!("unhandled attribute {n}")),
                        }
                    }
                    elided.push(n);
                }
            }
        }
        match spec.code {
            Code::Ext(set, code) => self.ext_inst(set, code, &ops)?,
            Code::Op(code) => Self::encode_code(&mut self.function_body, code, &ops),
            Code::None => return err(format!("'{name}' unhandled operation serialization")),
        }
        if spec.results == 1 {
            for a in self.body[op].all_attrs() {
                if !elided.contains(&&*a.name) {
                    self.decoration(result, &a)?;
                }
            }
        }
        Ok(())
    }

    /// The operand range of each ODS group (`getODSOperands`).
    fn groups(&self, op: OpId, groups: &[Group]) -> Vec<core::ops::Range<usize>> {
        let n = self.body[op].operands.len();
        let sizes: Vec<usize> = match self.body.segments(op, "operandSegmentSizes") {
            Some(s) => s,
            None => {
                let fixed = groups.iter().filter(|g| **g == Group::One).count();
                let variable = groups.len() - fixed;
                let rest = n.saturating_sub(fixed);
                groups.iter().map(|g| if *g == Group::One { 1 } else if variable > 0 { rest / variable } else { 0 }).collect()
            }
        };
        let mut at = 0;
        sizes
            .iter()
            .map(|s| {
                let r = at..(at + s).min(n);
                at += s;
                r
            })
            .collect()
    }

    /// `processOpWithoutGrammarAttr`.
    fn without_grammar_attr(&mut self, op: OpId, code: &Code<'_>) -> Result<(), Error> {
        let mut ops = Vec::new();
        let mut result = 0;
        let has_result = !self.body[op].results.is_empty();
        if has_result {
            let r = self.body[op].results[0];
            ops.push(self.type_id(&self.body[r].ty.clone())?);
            result = self.next();
            ops.push(result);
            self.value_ids.insert(r, result);
        }
        for v in self.body[op].operands.clone() {
            ops.push(self.value_id(v));
        }
        match code {
            Code::Ext(set, c) => self.ext_inst(set, *c, &ops)?,
            Code::Op(c) => Self::encode_code(&mut self.function_body, *c, &ops),
            Code::None => return err("unhandled operation serialization"),
        }
        if has_result {
            for a in self.body[op].all_attrs() {
                self.decoration(result, &a)?;
            }
        }
        Ok(())
    }

    /// `encodeExtensionInstruction`.
    fn ext_inst(&mut self, set: &str, code: u32, ops: &[u32]) -> Result<(), Error> {
        let set_id = match self.ext_sets.get(set) {
            Some(id) => *id,
            None => {
                let id = self.next();
                self.ext_sets.insert(String::from(set), id);
                let mut import = vec![id];
                Self::string(&mut import, set);
                Self::encode(&mut self.extended_sets, "OpExtInstImport", &import);
                id
            }
        };
        if ops.len() < 2 {
            return err("extended instructions must have a result encoding");
        }
        let mut all = ops[..2].to_vec();
        all.extend([set_id, code]);
        all.extend_from_slice(&ops[2..]);
        Self::encode(&mut self.function_body, "OpExtInst", &all);
        Ok(())
    }

    fn switch(&mut self, op: OpId) -> Result<(), Error> {
        let sel = self.value_id(self.body[op].operands[0]);
        let succs = self.body[op].successors.clone();
        let mut ops = vec![sel, self.block_id(succs[0])];
        if let Some(lits) = self.attr(op, "literals").and_then(|a| Const::try_from(a).ok()) {
            for (i, t) in succs[1..].iter().enumerate() {
                let v = lits.at(i).int().map_or(0, |x| x.bits() as u64);
                ops.push(v as u32);
                ops.push(self.block_id(*t));
            }
        }
        Self::encode(&mut self.function_body, "OpSwitch", &ops);
        Ok(())
    }

    fn entry_point(&mut self, op: OpId) -> Result<(), Error> {
        let model = self.enum_attr(op, "execution_model")?;
        let f = self.symbol(op, "fn")?;
        let fid = self.func_ids.get(&f).copied().ok_or_else(|| Error(format!("missing <id> for function {f}")))?;
        let mut ops = vec![model, fid];
        Self::string(&mut ops, &f);
        if let Some(Attribute::Array(vars)) = self.attr(op, "interface") {
            for v in vars {
                let Attribute::SymbolRef(p) = v else { continue };
                ops.push(self.global_var_ids.get(&*p[0]).copied().ok_or_else(|| Error(String::from("referencing undefined global variable")))?);
            }
        }
        Self::encode(&mut self.entry_points, "OpEntryPoint", &ops);
        Ok(())
    }

    fn execution_mode(&mut self, op: OpId) -> Result<(), Error> {
        let f = self.symbol(op, "fn")?;
        let fid = self.func_ids.get(&f).copied().ok_or_else(|| Error(format!("missing <id> for function {f}")))?;
        let mut ops = vec![fid, self.enum_attr(op, "execution_mode")?];
        if let Some(Attribute::Array(vs)) = self.attr(op, "values") {
            ops.extend(vs.iter().filter_map(Self::int_attr).map(|v| v as u32));
        }
        Self::encode(&mut self.execution_modes, "OpExecutionMode", &ops);
        Ok(())
    }

    fn function_call(&mut self, op: OpId) -> Result<(), Error> {
        let callee = self.symbol(op, "callee")?;
        let ret = self.body[op].results.first().map_or(Type::NoneType, |r| self.body[*r].ty.clone());
        let rt = self.type_id(&ret)?;
        let fid = self.function_id(&callee);
        let id = self.next();
        let mut ops = vec![rt, id, fid];
        ops.extend(self.body[op].operands.iter().map(|v| self.value_id(*v)));
        if let Some(r) = self.body[op].results.first() {
            self.value_ids.insert(*r, id);
        }
        Self::encode(&mut self.function_body, "OpFunctionCall", &ops);
        Ok(())
    }

    fn copy_memory(&mut self, op: OpId) -> Result<(), Error> {
        let mut ops: Vec<u32> = self.body[op].operands.iter().map(|v| self.value_id(*v)).collect();
        for (n, is_enum) in [("memory_access", true), ("alignment", false), ("source_memory_access", true), ("source_alignment", false)] {
            if let Some(a) = self.attr(op, n) {
                ops.push(if is_enum { EnumSpec::attr_value(a) } else { Self::int_attr(a).map(|v| v as u32) }.ok_or_else(|| Error(format!("bad {n}")))?);
            }
        }
        Self::encode(&mut self.function_body, "OpCopyMemory", &ops);
        Ok(())
    }

    fn generic_cast_to_ptr_explicit(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.body[op].results[0];
        let ty = self.body[r].ty.clone();
        let mut ops = vec![self.type_id(&ty)?];
        let id = self.next();
        ops.push(id);
        self.value_ids.insert(r, id);
        ops.extend(self.body[op].operands.iter().map(|v| self.value_id(*v)));
        let Ok(SpirvType::Ptr { storage, .. }) = SpirvType::try_from(&ty) else { return err("expected a pointer result") };
        ops.push(Self::enum_value("StorageClass", &storage)?);
        Self::encode(&mut self.function_body, "OpGenericCastToPtrExplicit", &ops);
        Ok(())
    }

    fn global_variable(&mut self, op: OpId) -> Result<(), Error> {
        let Some(Attribute::Type(ty)) = self.attr(op, "type").cloned() else { return err("spirv.GlobalVariable without type") };
        let tid = self.type_id(&ty)?;
        let id = self.next();
        let name = self.symbol(op, "sym_name")?;
        self.name(id, &name);
        self.global_var_ids.insert(name, id);
        let Ok(SpirvType::Ptr { storage, .. }) = SpirvType::try_from(&ty) else { return err("expected a pointer type") };
        let mut ops = vec![tid, id, Self::enum_value("StorageClass", &storage)?];
        if let Some(Attribute::SymbolRef(init)) = self.attr(op, "initializer") {
            let init = String::from(&*init[0]);
            let id = self.global_var_ids.get(&init).or_else(|| self.spec_const_ids.get(&init)).copied().ok_or_else(|| Error(String::from("invalid usage of undefined variable as initializer")))?;
            ops.push(id);
        }
        Self::encode(&mut self.types_globals, "OpVariable", &ops);
        for a in self.body[op].all_attrs() {
            if !matches!(&*a.name, "type" | "sym_name" | "initializer") {
                self.decoration(id, &a)?;
            }
        }
        Ok(())
    }

    fn variable(&mut self, op: OpId) -> Result<(), Error> {
        let r = self.body[op].results[0];
        let mut ops = vec![self.type_id(&self.body[r].ty.clone())?];
        let id = self.next();
        self.value_ids.insert(r, id);
        ops.push(id);
        if self.attr(op, "storage_class").is_some() {
            ops.push(self.enum_attr(op, "storage_class")?);
        }
        ops.extend(self.body[op].operands.iter().map(|v| self.value_id(*v)));
        Self::encode(&mut self.function_header, "OpVariable", &ops);
        for a in self.body[op].all_attrs() {
            if a.name != "storage_class" {
                self.decoration(id, &a)?;
            }
        }
        Ok(())
    }

    // ---- functions and control flow ----------------------------------------------------

    /// `prepareGraphType`: a graph's type is not a function's, though both print alike.
    fn graph_type_id(&mut self, f: &mlirformat::FunctionType<'_>) -> Result<u32, Error> {
        let key = format!("graph {}", Self::key(&Type::Function(f.clone())));
        if let Some(id) = self.type_ids.get(&key) {
            return Ok(*id);
        }
        let id = self.next();
        let mut ops = vec![id, f.inputs.len() as u32];
        for t in f.inputs.iter().chain(&f.results) {
            ops.push(self.type_id(t)?);
        }
        self.type_ids.insert(key, id);
        Self::encode(&mut self.types_globals, "OpTypeGraphARM", &ops);
        Ok(id)
    }

    /// `prepareGraphConstantId`.
    fn graph_constant(&mut self, ty: &Type<'_>, op: OpId) -> Result<u32, Error> {
        let attr = self.attr(op, "graph_constant_id").cloned().ok_or_else(|| Error(String::from("no graph_constant_id")))?;
        let key = Self::const_key(&attr);
        if let Some(id) = self.graph_const_ids.get(&key) {
            return Ok(*id);
        }
        let tid = self.type_id(ty)?;
        let id = self.next();
        let c = Const::try_from(&attr).ok().and_then(|c| c.as_int()).ok_or_else(|| Error(String::from("bad graph_constant_id")))?;
        if c.width > 32 {
            return err(format!("Too wide attribute for OpGraphConstantARM: {} bits", c.width));
        }
        Self::encode(&mut self.types_globals, "OpGraphConstantARM", &[tid, id, c.signed() as i32 as u32]);
        self.graph_const_ids.insert(key, id);
        Ok(id)
    }

    /// `processGraphARMOp`.
    fn graph(&mut self, op: OpId) -> Result<(), Error> {
        let Some(Attribute::Type(Type::Function(f))) = self.attr(op, "function_type").cloned() else { return err("spirv.ARM.Graph without function_type") };
        if f.results.is_empty() {
            return err("cannot serialize graph with no return types");
        }
        let name = self.symbol(op, "sym_name")?;
        let gid = self.function_id(&name);
        let tid = self.graph_type_id(&f)?;
        Self::encode(&mut self.function_header, "OpGraphARM", &[tid, gid]);
        let entry = self.body[self.body[op].regions[0]].blocks[0];
        for (i, arg) in self.body[entry].args.clone().into_iter().enumerate() {
            let at = self.type_id(&self.body[arg].ty.clone())?;
            let id = self.next();
            self.value_ids.insert(arg, id);
            let index = self.const_int(Type::int(32), i as u128, false)?;
            Self::encode(&mut self.function_header, "OpGraphInputARM", &[at, id, index]);
        }
        self.block(entry, true, None)?;
        for b in self.pretty_order(entry, &[]) {
            if b != entry {
                self.block(b, false, None)?;
            }
        }
        Self::encode(&mut self.function_body, "OpGraphEndARM", &[]);
        let header = core::mem::take(&mut self.function_header);
        let body = core::mem::take(&mut self.function_body);
        self.graphs.extend(header);
        self.graphs.extend(body);
        Ok(())
    }

    fn function(&mut self, op: OpId) -> Result<(), Error> {
        let Some(Attribute::Type(fty)) = self.attr(op, "function_type").cloned() else { return err("spirv.func without function_type") };
        let Type::Function(f) = &fty else { return err("bad function_type") };
        let fn_tid = self.type_id(&fty)?;
        if f.results.len() > 1 {
            return err("cannot serialize function with multiple return types");
        }
        let res_tid = self.type_id(&f.results.first().cloned().unwrap_or(Type::NoneType))?;
        let name = self.symbol(op, "sym_name")?;
        let fid = self.function_id(&name);
        let control = self.attr(op, "function_control").and_then(EnumSpec::attr_value).unwrap_or(0);
        Self::encode(&mut self.function_header, "OpFunction", &[res_tid, fid, control, fn_tid]);
        self.name(fid, &name);
        let region = self.body[op].regions[0];
        let blocks = self.body[region].blocks.clone();
        if blocks.is_empty() {
            let import = self.attr(op, "linkage_attributes").is_some_and(|a| matches!(a, Attribute::Extended { ext, .. } if ext.body.as_deref().is_some_and(|b| b.contains("Import"))));
            if !import {
                return err("'spirv.module' cannot contain external functions without 'Import' linkage_attributes (LinkageAttributes)");
            }
            self.parameters(op, &f.inputs, None)?;
        } else {
            let args = self.body[blocks[0]].args.clone();
            self.parameters(op, &f.inputs, Some(&args))?;
            let entry = self.block_id(blocks[0]);
            Self::encode(&mut self.function_header, "OpLabel", &[entry]);
            self.block(blocks[0], true, None)?;
            for b in self.pretty_order(blocks[0], &[]) {
                if b != blocks[0] {
                    self.block(b, false, None)?;
                }
            }
            for (v, at) in core::mem::take(&mut self.deferred_phis) {
                let id = self.value_id(v);
                for i in at {
                    self.function_body[i] = id;
                }
            }
        }
        for a in self.body[op].all_attrs() {
            if EnumSpec::of("Decoration").and_then(|e| e.value(&Self::camel(&a.name))).is_some() {
                self.decoration(fid, &a)?;
            }
        }
        Self::encode(&mut self.function_body, "OpFunctionEnd", &[]);
        let header = core::mem::take(&mut self.function_header);
        let body = core::mem::take(&mut self.function_body);
        self.functions.extend(header);
        self.functions.extend(body);
        Ok(())
    }

    /// `processFuncParameter`; `args`: the entry block's (none for a declaration).
    fn parameters(&mut self, op: OpId, inputs: &[Type<'_>], args: Option<&[ValueId]>) -> Result<(), Error> {
        let arg_attrs = match self.attr(op, "arg_attrs") {
            Some(Attribute::Array(a)) => a.clone(),
            _ => Vec::new(),
        };
        for (i, t) in inputs.iter().enumerate() {
            let tid = self.type_id(t)?;
            let id = self.next();
            if let Some(Attribute::Dict(d)) = arg_attrs.get(i) {
                for a in d.iter().filter(|a| a.name == "spirv.decoration") {
                    if let Some(v @ Attribute::Extended { ext, .. }) = &a.value {
                        let deco = ext.body.as_deref().unwrap_or("").trim_start_matches('<').trim_end_matches('>');
                        let deco = String::from(deco);
                        let value = Self::enum_value("Decoration", &deco)?;
                        self.decoration_attr(id, &deco, value, v)?;
                    }
                }
            }
            if let Some(args) = args {
                self.value_ids.insert(args[i], id);
            }
            Self::encode(&mut self.function_header, "OpFunctionParameter", &[tid, id]);
        }
        Ok(())
    }

    /// `visitInPrettyBlockOrder`: depth first from `header` over successors, preorder, not
    /// entering `skip`.
    fn pretty_order(&self, header: BlockId, skip: &[BlockId]) -> Vec<BlockId> {
        let mut seen: BTreeSet<BlockId> = skip.iter().copied().collect();
        let mut out = Vec::new();
        if !seen.insert(header) {
            return out;
        }
        out.push(header);
        let mut stack = vec![(header, 0usize)];
        while let Some((b, i)) = stack.last_mut() {
            let succs = self.successors(*b);
            if *i < succs.len() {
                let s = succs[*i];
                *i += 1;
                if seen.insert(s) {
                    out.push(s);
                    stack.push((s, 0));
                }
            } else {
                stack.pop();
            }
        }
        out
    }

    fn successors(&self, b: BlockId) -> Vec<BlockId> {
        self.body[b].ops.last().map(|t| self.body[*t].successors.clone()).unwrap_or_default()
    }

    /// `processBlock`.
    fn block(&mut self, b: BlockId, omit_label: bool, mut merge: Option<Merge>) -> Result<(), Error> {
        if !omit_label {
            let id = self.block_id(b);
            Self::encode(&mut self.function_body, "OpLabel", &[id]);
        }
        self.phis(b)?;
        let ops = self.body[b].ops.clone();
        if let Some(m) = merge
            && ops.iter().any(|o| matches!(&*self.body[*o].name, "spirv.mlir.loop" | "spirv.mlir.selection"))
        {
            self.emit_merge(m);
            merge = None;
            let id = self.next();
            Self::encode(&mut self.function_body, "OpBranch", &[id]);
            Self::encode(&mut self.function_body, "OpLabel", &[id]);
        }
        let Some((last, rest)) = ops.split_last() else { return Ok(()) };
        for o in rest {
            self.operation(*o)?;
        }
        if let Some(m) = merge {
            self.emit_merge(m);
        }
        self.operation(*last)
    }

    fn emit_merge(&mut self, m: Merge) {
        match m {
            Merge::Selection { merge, control } => Self::encode(&mut self.function_body, "OpSelectionMerge", &[merge, control]),
            Merge::Loop { merge, cont, control } => Self::encode(&mut self.function_body, "OpLoopMerge", &[merge, cont, control]),
        }
    }

    /// `getStructuredControlFlowOpMergeBlock`.
    fn merge_block(&self, op: OpId) -> Option<BlockId> {
        matches!(&*self.body[op].name, "spirv.mlir.loop" | "spirv.mlir.selection").then(|| *self.body[self.body[op].regions[0]].blocks.last().expect("merge block"))
    }

    /// `getPhiIncomingBlock`.
    fn phi_incoming(&self, b: BlockId) -> BlockId {
        let region = self.body[b].parent.expect("in a region");
        if self.body[region].blocks[0] == b {
            let parent = self.body[region].parent;
            if self.body[parent].name == "spirv.mlir.loop" {
                let outer = self.body[parent].parent.expect("placed");
                let ops = &self.body[outer].ops;
                let at = ops.iter().position(|o| *o == parent).expect("in its block");
                return ops[..at].iter().rev().find_map(|o| self.merge_block(*o)).unwrap_or(outer);
            }
        }
        self.body[b].ops.iter().rev().find_map(|o| self.merge_block(*o)).unwrap_or(b)
    }

    /// The branches to `b`, as its use list has them (the latest use first).
    fn predecessors(&self, b: BlockId) -> Vec<OpId> {
        let region = self.body[b].parent.expect("in a region");
        let mut uses = Vec::new();
        for blk in &self.body[region].blocks {
            if let Some(t) = self.body[*blk].ops.last() {
                uses.extend(self.body[*t].successors.iter().filter(|s| **s == b).map(|_| *t));
            }
        }
        uses.reverse();
        uses
    }

    /// `emitPhiForBlockArguments`.
    fn phis(&mut self, b: BlockId) -> Result<(), Error> {
        let region = self.body[b].parent.expect("in a region");
        if self.body[b].args.is_empty() || self.body[region].blocks[0] == b {
            return Ok(());
        }
        let mut preds = Vec::new();
        for t in self.predecessors(b) {
            if !matches!(&*self.body[t].name, "spirv.Branch" | "spirv.BranchConditional" | "spirv.Switch") {
                return err(format!("'{}' unimplemented terminator for Phi creation", self.body[t].name));
            }
            let from = self.body[t].parent.expect("placed");
            let i = self.body[t].successors.iter().position(|s| *s == b).expect("a successor");
            let range = self.body.successor_operands(t, i).unwrap_or(0..0);
            preds.push((self.phi_incoming(from), self.body[t].operands[range].to_vec()));
        }
        for (i, arg) in self.body[b].args.clone().into_iter().enumerate() {
            let tid = self.type_id(&self.body[arg].ty.clone())?;
            let id = self.next();
            let mut ops = vec![tid, id];
            for (pred, values) in &preds {
                let v = values[i];
                let pid = self.block_id(*pred);
                let vid = self.value_id(v);
                if vid == 0 {
                    self.deferred_phis.entry(self.resolve(v)).or_default().push(self.function_body.len() + 1 + ops.len());
                }
                ops.extend([vid, pid]);
            }
            Self::encode(&mut self.function_body, "OpPhi", &ops);
            self.value_ids.insert(arg, id);
        }
        Ok(())
    }

    fn alias_results(&mut self, op: OpId, merge: BlockId) {
        let m = *self.body[merge].ops.last().expect("spirv.mlir.merge");
        for (r, v) in self.body[op].results.clone().into_iter().zip(self.body[m].operands.clone()) {
            self.aliases.insert(r, v);
        }
    }

    fn selection(&mut self, op: OpId) -> Result<(), Error> {
        let blocks = self.body[self.body[op].regions[0]].blocks.clone();
        for b in &blocks {
            self.block_id(*b);
        }
        let (header, merge) = (blocks[0], *blocks.last().expect("merge block"));
        let (hid, mid) = (self.block_id(header), self.block_id(merge));
        self.alias_results(op, merge);
        Self::encode(&mut self.function_body, "OpBranch", &[hid]);
        let control = self.attr(op, "selection_control").and_then(EnumSpec::attr_value).unwrap_or(0);
        self.block(header, false, Some(Merge::Selection { merge: mid, control }))?;
        for b in self.pretty_order(header, &[merge]) {
            if b != header {
                self.block(b, false, None)?;
            }
        }
        Self::encode(&mut self.function_body, "OpLabel", &[mid]);
        self.phis(merge)
    }

    fn loop_op(&mut self, op: OpId) -> Result<(), Error> {
        let blocks = self.body[self.body[op].regions[0]].blocks.clone();
        for b in &blocks[1..] {
            self.block_id(*b);
        }
        let (header, cont, merge) = (blocks[1], blocks[blocks.len() - 2], blocks[blocks.len() - 1]);
        let (hid, cid, mid) = (self.block_id(header), self.block_id(cont), self.block_id(merge));
        self.alias_results(op, merge);
        Self::encode(&mut self.function_body, "OpBranch", &[hid]);
        let control = self.attr(op, "loop_control").and_then(EnumSpec::attr_value).unwrap_or(0);
        self.block(header, false, Some(Merge::Loop { merge: mid, cont: cid, control }))?;
        for b in self.pretty_order(header, &[cont, merge]) {
            if b != header {
                self.block(b, false, None)?;
            }
        }
        self.block(cont, false, None)?;
        Self::encode(&mut self.function_body, "OpLabel", &[mid]);
        Ok(())
    }
}
