use alloc::borrow::ToOwned;
use alloc::boxed::Box;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use core::str::FromStr;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Dim, Error, Op, ShapedKind, Type};

use crate::patterns;
use crate::{Body, Builtin, BuiltinVar, Call, Construct, ConversionRewriter, Global, GlslStage, Heads, Interpolation, Load, OpData, OpId, Quiet, Rewriter, Shader, Storage, Store, Symbol, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum GlslClient {
    #[default]
    Opengl,
    Vulkan,
}

impl FromStr for GlslClient {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, ()> {
        match s {
            "opengl" => Ok(GlslClient::Opengl),
            "vulkan" => Ok(GlslClient::Vulkan),
            _ => Err(()),
        }
    }
}

impl GlslClient {
    const fn built_in(self, b: BuiltinVar) -> Option<&'static str> {
        match (self, b) {
            (_, BuiltinVar::Position) => Some("Position"),
            (_, BuiltinVar::PointSize) => Some("PointSize"),
            (GlslClient::Opengl, BuiltinVar::VertexId) => Some("VertexId"),
            (GlslClient::Vulkan, BuiltinVar::VertexId) => Some("VertexIndex"),
            (GlslClient::Opengl, BuiltinVar::InstanceId) => Some("InstanceId"),
            (GlslClient::Vulkan, BuiltinVar::InstanceId) => Some("InstanceIndex"),
            (_, BuiltinVar::FragCoord) => Some("FragCoord"),
            (_, BuiltinVar::FrontFacing) => Some("FrontFacing"),
            (_, BuiltinVar::PointCoord) => Some("PointCoord"),
            (_, BuiltinVar::FragDepth) => Some("FragDepth"),
            (_, BuiltinVar::FragColor | BuiltinVar::FragData) => None,
        }
    }

    const fn origin(self) -> &'static str {
        match self {
            GlslClient::Opengl => "OriginLowerLeft",
            GlslClient::Vulkan => "OriginUpperLeft",
        }
    }
}

impl GlslStage {
    const fn execution_model(self) -> &'static str {
        match self {
            GlslStage::Vertex => "Vertex",
            GlslStage::Fragment => "Fragment",
        }
    }
}

impl Storage {
    fn class(self, ty: &Type<'_>) -> Result<&'static str, Error> {
        let opaque = matches!(SpirvType::try_from(ty), Ok(SpirvType::SampledImage(_) | SpirvType::Image { .. } | SpirvType::Sampler));
        match self {
            Storage::In => Ok("Input"),
            Storage::Out => Ok("Output"),
            Storage::Uniform if opaque => Ok("UniformConstant"),
            Storage::Uniform => Err(Error(format!("a uniform of {ty} outside a block is not lowered yet"))),
        }
    }

    const fn interface(self) -> bool {
        matches!(self, Storage::In | Storage::Out)
    }
}

impl Builtin {
    const fn spirv(self, float: bool) -> Option<&'static str> {
        Some(match (self, float) {
            (Builtin::Pow, true) => "spirv.GL.Pow",
            (Builtin::Sign, true) => "spirv.GL.FSign",
            (Builtin::Sign, false) => "spirv.GL.SSign",
            (Builtin::Clamp, true) => "spirv.GL.FClamp",
            (Builtin::Clamp, false) => "spirv.GL.SClamp",
            (Builtin::Fract, true) => "spirv.GL.Fract",
            (Builtin::Mod, true) => "spirv.FMod",
            (Builtin::Mix, true) => "spirv.GL.FMix",
            (Builtin::Step, true) => "spirv.GL.Step",
            (Builtin::Smoothstep, true) => "spirv.GL.SmoothStep",
            (Builtin::IsNan, true) => "spirv.IsNan",
            (Builtin::IsInf, true) => "spirv.IsInf",
            (Builtin::Length, true) => "spirv.GL.Length",
            (Builtin::Distance, true) => "spirv.GL.Distance",
            (Builtin::Dot, true) => "spirv.Dot",
            (Builtin::Cross, true) => "spirv.GL.Cross",
            (Builtin::Normalize, true) => "spirv.GL.Normalize",
            (Builtin::Reflect, true) => "spirv.GL.Reflect",
            (Builtin::OuterProduct, true) => "spirv.OuterProduct",
            (Builtin::Transpose, true) => "spirv.Transpose",
            (Builtin::MatrixTimesMatrix, true) => "spirv.MatrixTimesMatrix",
            (Builtin::MatrixTimesVector, true) => "spirv.MatrixTimesVector",
            (Builtin::VectorTimesMatrix, true) => "spirv.VectorTimesMatrix",
            (Builtin::MatrixTimesScalar, true) => "spirv.MatrixTimesScalar",
            (Builtin::PackHalf2x16, _) => "spirv.GL.PackHalf2x16",
            (Builtin::UnpackHalf2x16, _) => "spirv.GL.UnpackHalf2x16",
            _ => return None,
        })
    }

    const fn splats(self) -> bool {
        matches!(self, Builtin::Clamp | Builtin::Mix | Builtin::Step | Builtin::Smoothstep | Builtin::Mod)
    }
}

pub struct GlslToSpirv;

impl GlslToSpirv {
    const ENTRY: &str = "main";

    fn sym<'a>(name: &str) -> Attribute<'a> {
        Attribute::SymbolRef(vec![String::from(name).into()])
    }

    fn i32_attr<'a>(v: u32) -> Attribute<'a> {
        Attribute::of_int(i128::from(v), Type::int(32))
    }

    fn ptr<'a>(pointee: Type<'a>, class: &str) -> Type<'a> {
        SpirvType::Ptr { pointee: Box::new(pointee), storage: class.to_owned() }.into()
    }

    pub fn modules(body: &mut Body<'_>, root: OpId, client: GlslClient) -> Result<Vec<OpId>, Error> {
        let mut shaders = Vec::new();
        body.walk(root, &mut |o| shaders.push(o));
        shaders.retain(|&o| &*body[o].name == Shader::NAME);
        shaders.into_iter().map(|s| Self::module(body, s, client)).collect()
    }

    fn variable<'a>(g: &Global<'a>, name: &str, client: GlslClient) -> Result<OpData<'a>, Error> {
        let class = g.storage.class(&g.ty)?;
        let mut data = OpData::build("spirv.GlobalVariable").with("sym_name", Attribute::str(name)).with("type", Attribute::Type(Self::ptr(g.ty.clone(), class)));
        match g.builtin.map(|b| (b, client.built_in(b))) {
            Some((_, Some(spirv))) => data = data.with("built_in", Attribute::str(spirv)),
            Some((BuiltinVar::FragColor, None)) => data = data.with("location", Self::i32_attr(0)),
            Some((b, None)) => return Err(Error(format!("{} is not lowered yet", b.glsl()))),
            None => {}
        }
        if let Some(l) = g.location {
            data = data.with("location", Self::i32_attr(l));
        }
        if let Some(b) = g.binding {
            data = data.with("binding", Self::i32_attr(b)).with("descriptor_set", Self::i32_attr(0));
        }
        if g.interpolation == Some(Interpolation::Flat) {
            data = data.with("flat", Attribute::Unit);
        }
        if g.centroid {
            data = data.with("centroid", Attribute::Unit);
        }
        if g.invariant {
            data = data.with("invariant", Attribute::Unit);
        }
        Ok(data)
    }

    fn module(body: &mut Body<'_>, shader: OpId, client: GlslClient) -> Result<OpId, Error> {
        let head = body.head::<Shader>(shader)?;
        let inner: Vec<OpId> = body.ops(body.top_block(shader)).collect();
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        rw.set_before(shader);
        let module = OpData::build("spirv.module")
            .with("addressing_model", Attribute::dialect("spirv.addressing_model", "<Logical>"))
            .with("memory_model", Attribute::dialect("spirv.memory_model", "<GLSL450>"))
            .with("vce_triple", Attribute::dialect("spirv.vce", "<v1.0, [Shader], []>"));
        let m = rw.create_with(module, &[], |b, op| {
            let r = b.add_region(op);
            b.add_block(r, &[]);
        });
        let block = rw.body.top_block(m);
        let mut interface = Vec::new();
        for o in inner {
            if &*rw.body[o].name == Global::NAME {
                let g = rw.body.head::<Global>(o)?;
                let name = Symbol::defined(&g.sym_name)?.to_owned();
                let var = Self::variable(&g, &name, client)?;
                if g.storage.interface() {
                    interface.push(Self::sym(&name));
                }
                rw.set_end(block);
                rw.create(var, &[]);
                rw.erase_op(o);
            } else {
                rw.move_before(o, block, None);
            }
        }
        rw.set_end(block);
        let ep = OpData::build("spirv.EntryPoint")
            .with("execution_model", Attribute::dialect("spirv.execution_model", &format!("<{}>", head.stage.execution_model())))
            .with("fn", Self::sym(Self::ENTRY))
            .with("interface", Attribute::Array(interface));
        rw.create(ep, &[]);
        if head.stage == GlslStage::Fragment {
            let mode = OpData::build("spirv.ExecutionMode")
                .with("execution_mode", Attribute::dialect("spirv.execution_mode", &format!("<{}>", client.origin())))
                .with("fn", Self::sym(Self::ENTRY))
                .with("values", Attribute::Array(Vec::new()));
            rw.create(mode, &[]);
        }
        rw.erase_op(shader);
        Ok(m)
    }

    fn var_name<'s>(a: &'s Attribute<'_>) -> Option<&'s str> {
        match a {
            Attribute::SymbolRef(p) if p.len() == 1 => Some(p[0].trim_matches('"')),
            _ => None,
        }
    }

    fn global<'a>(body: &Body<'a>, from: OpId, name: &str) -> Option<(Type<'a>, String)> {
        let mut at = from;
        let module = loop {
            at = body.parent_op(at)?;
            if &*body[at].name == "spirv.module" {
                break at;
            }
        };
        body.ops(body.top_block(module)).find_map(|o| {
            let found = &*body[o].name == "spirv.GlobalVariable" && body[o].get("sym_name").and_then(|s| s.text().ok()).as_deref() == Some(name);
            match (found, body[o].get("type")) {
                (true, Some(Attribute::Type(t))) => match SpirvType::try_from(t) {
                    Ok(SpirvType::Ptr { pointee, storage }) => Some((*pointee, storage)),
                    _ => None,
                },
                _ => None,
            }
        })
    }

    fn pointer<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, var: &Attribute<'_>, indices: &[ValueId], elem: &Type<'a>) -> Option<ValueId> {
        let name = Self::var_name(var)?.to_owned();
        let (pointee, class) = Self::global(&cr.rw.body, op, &name)?;
        let base = cr.build(OpData::build("spirv.mlir.addressof").with("variable", Self::sym(&name)), Self::ptr(pointee, &class));
        if indices.is_empty() {
            return Some(base);
        }
        let mut operands = vec![base];
        operands.extend_from_slice(indices);
        Some(cr.build(OpData::build("spirv.AccessChain").operands(&operands), Self::ptr(elem.clone(), &class)))
    }

    fn lanes(t: &Type<'_>) -> Option<usize> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => match s.shape.as_deref() {
                Some([Dim::Static(n)]) => usize::try_from(*n).ok(),
                _ => None,
            },
            Type::Integer { .. } | Type::Float(_) => Some(1),
            _ => None,
        }
    }

    fn ty_of<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    fn splat<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, to: &Type<'a>) -> ValueId {
        match Self::lanes(to) {
            Some(n) if n > 1 && Self::lanes(&Self::ty_of(cr, v)) == Some(1) => cr.build(OpData::build("spirv.CompositeConstruct").operands(&vec![v; n]), to.clone()),
            _ => v,
        }
    }
}

#[patterns(converter)]
impl GlslToSpirv {
    #[convert("glsl.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Ok(l) = cr.rw.body.head::<Load>(op) else { return false };
        let Some(indices) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(ptr) = Self::pointer(cr, op, &l.var, &indices, &ty) else { return false };
        cr.replace_new(op, OpData::build("spirv.Load").operands(&[ptr]), &[ty]);
        true
    }

    #[convert("glsl.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Ok(s) = cr.rw.body.head::<Store>(op) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some((&value, indices)) = ops.split_first() else { return false };
        let ty = Self::ty_of(cr, value);
        let Some(ptr) = Self::pointer(cr, op, &s.var, indices, &ty) else { return false };
        cr.replace_new(op, OpData::build("spirv.Store").operands(&[ptr, value]), &[]);
        true
    }

    #[convert("glsl.construct")]
    fn construct(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        if cr.rw.body.head::<Construct>(op).is_err() {
            return false;
        }
        let Some(parts) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(n) = Self::lanes(&ty) else { return false };
        let elem = ty.element_type().clone();
        let types: Vec<Type<'_>> = parts.iter().map(|&p| Self::ty_of(cr, p)).collect();
        if types.iter().any(|t| *t.element_type() != elem) {
            return false;
        }
        let Some(counts) = types.iter().map(Self::lanes).collect::<Option<Vec<usize>>>() else { return false };
        let data = match (&parts[..], &counts[..]) {
            ([p], [1]) if n > 1 => OpData::build("spirv.CompositeConstruct").operands(&vec![*p; n]),
            ([p], [1]) => {
                cr.replace_values(op, &[*p]);
                return true;
            }
            ([p], [_]) if n == 1 => OpData::build("spirv.CompositeExtract").operands(&[*p]).with("indices", Attribute::Array(vec![Self::i32_attr(0)])),
            ([p], [m]) if *m > n => OpData::build("spirv.VectorShuffle").operands(&[*p, *p]).with("components", Attribute::Array((0..n).map(|i| Self::i32_attr(i as u32)).collect())),
            _ if counts.iter().sum::<usize>() == n => OpData::build("spirv.CompositeConstruct").operands(&parts),
            _ => return false,
        };
        cr.replace_new(op, data, &[ty]);
        true
    }

    #[convert("glsl.builtin")]
    fn builtin(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Ok(c) = cr.rw.body.head::<Call>(op) else { return false };
        let Some(mut args) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(&first) = args.first() else { return false };
        let float = matches!(Self::ty_of(cr, first).element_type(), Type::Float(_));
        let Some(name) = c.func.spirv(float) else { return false };
        if c.func.splats() {
            let wide = args.iter().map(|&a| Self::ty_of(cr, a)).max_by_key(|t| Self::lanes(t).unwrap_or(1));
            if let Some(wide) = wide {
                args = args.into_iter().map(|a| Self::splat(cr, a, &wide)).collect();
            }
        }
        cr.replace_new(op, OpData::build(name).operands(&args), &[ty]);
        true
    }
}
