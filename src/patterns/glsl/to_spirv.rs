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
use crate::{Attrs, Body, Builtin, BuiltinVar, GlslCall, GlslConstruct, ConversionRewriter, GlslDeriv, Derivative, GlslGlobal, GlslStage, Heads, Interpolation, GlslLoad, Lod, OpData, OpId, Quiet, Rewriter, GlslShader, Storage, GlslStore, Symbol, GlslTexelFetch, GlslTexture, ValueId};

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

/// What a shader stage is in SPIR-V
trait StageSpirv {
    fn execution_model(self) -> &'static str;
}

impl StageSpirv for GlslStage {
    fn execution_model(self) -> &'static str {
        match self {
            GlslStage::Vertex => "Vertex",
            GlslStage::Fragment => "Fragment",
        }
    }
}

/// Where a GLSL global lives in SPIR-V
trait StorageSpirv {
    fn class(self, ty: &Type<'_>, client: GlslClient) -> Result<&'static str, Error>;
    fn interface(self) -> bool;
}

impl StorageSpirv for Storage {
    fn class(self, ty: &Type<'_>, client: GlslClient) -> Result<&'static str, Error> {
        let spirv = SpirvType::try_from(ty);
        let opaque = matches!(spirv, Ok(SpirvType::SampledImage(_) | SpirvType::Image { .. } | SpirvType::Sampler));
        let block = matches!(&spirv, Ok(SpirvType::Struct { decorations, .. }) if decorations.iter().any(|d| d.name == GlslToSpirv::BLOCK));
        match (self, client) {
            (Storage::In, _) => Ok("Input"),
            (Storage::Out, _) => Ok("Output"),
            (Storage::Private, _) => Ok("Private"),
            (Storage::Uniform, _) if block => Ok("Uniform"),
            (Storage::Uniform, _) if opaque => Ok("UniformConstant"),
            (Storage::Uniform, GlslClient::Opengl) => Ok("UniformConstant"),
            (Storage::Uniform, GlslClient::Vulkan) => Err(Error(format!("a uniform of {ty} outside a block has no Vulkan form"))),
        }
    }

    fn interface(self) -> bool {
        matches!(self, Storage::In | Storage::Out)
    }
}

/// A derivative as a SPIR-V op
trait DerivativeSpirv {
    fn spirv(self) -> &'static str;
}

impl DerivativeSpirv for Derivative {
    fn spirv(self) -> &'static str {
        match self {
            Derivative::Dfdx => "spirv.DPdx",
            Derivative::Dfdy => "spirv.DPdy",
            Derivative::Fwidth => "spirv.Fwidth",
        }
    }
}

/// A texture lookup as a SPIR-V op
trait LodSpirv {
    fn spirv(self, proj: bool, dref: bool) -> &'static str;
    fn operand(self) -> Option<&'static str>;
}

impl LodSpirv for Lod {
    fn spirv(self, proj: bool, dref: bool) -> &'static str {
        let explicit = matches!(self, Lod::Explicit | Lod::Grad);
        match (explicit, proj, dref) {
            (false, false, false) => "spirv.ImageSampleImplicitLod",
            (true, false, false) => "spirv.ImageSampleExplicitLod",
            (false, true, false) => "spirv.ImageSampleProjImplicitLod",
            (true, true, false) => "spirv.ImageSampleProjExplicitLod",
            (false, false, true) => "spirv.ImageSampleDrefImplicitLod",
            (true, false, true) => "spirv.ImageSampleDrefExplicitLod",
            (false, true, true) => "spirv.ImageSampleProjDrefImplicitLod",
            (true, true, true) => "spirv.ImageSampleProjDrefExplicitLod",
        }
    }

    fn operand(self) -> Option<&'static str> {
        match self {
            Lod::Implicit => None,
            Lod::Bias => Some("Bias"),
            Lod::Explicit => Some("Lod"),
            Lod::Grad => Some("Grad"),
        }
    }
}

/// A built-in function as a SPIR-V op
trait BuiltinSpirv {
    fn spirv(self, float: bool) -> Option<&'static str>;
    fn splats(self) -> bool;
}

impl BuiltinSpirv for Builtin {
    fn spirv(self, float: bool) -> Option<&'static str> {
        Some(match (self, float) {
            (Builtin::Radians, true) => "spirv.GL.Radians",
            (Builtin::Degrees, true) => "spirv.GL.Degrees",
            (Builtin::Sin, true) => "spirv.GL.Sin",
            (Builtin::Cos, true) => "spirv.GL.Cos",
            (Builtin::Tan, true) => "spirv.GL.Tan",
            (Builtin::Asin, true) => "spirv.GL.Asin",
            (Builtin::Acos, true) => "spirv.GL.Acos",
            (Builtin::Atan, true) => "spirv.GL.Atan",
            (Builtin::Atan2, true) => "spirv.GL.Atan2",
            (Builtin::Sinh, true) => "spirv.GL.Sinh",
            (Builtin::Cosh, true) => "spirv.GL.Cosh",
            (Builtin::Tanh, true) => "spirv.GL.Tanh",
            (Builtin::Asinh, true) => "spirv.GL.Asinh",
            (Builtin::Acosh, true) => "spirv.GL.Acosh",
            (Builtin::Atanh, true) => "spirv.GL.Atanh",
            (Builtin::Exp, true) => "spirv.GL.Exp",
            (Builtin::Log, true) => "spirv.GL.Log",
            (Builtin::Exp2, true) => "spirv.GL.Exp2",
            (Builtin::Log2, true) => "spirv.GL.Log2",
            (Builtin::Sqrt, true) => "spirv.GL.Sqrt",
            (Builtin::InverseSqrt, true) => "spirv.GL.InverseSqrt",
            (Builtin::Abs, true) => "spirv.GL.FAbs",
            (Builtin::Abs, false) => "spirv.GL.SAbs",
            (Builtin::Floor, true) => "spirv.GL.Floor",
            (Builtin::Trunc, true) => "spirv.GL.Trunc",
            (Builtin::Round, true) => "spirv.GL.Round",
            (Builtin::RoundEven, true) => "spirv.GL.RoundEven",
            (Builtin::Ceil, true) => "spirv.GL.Ceil",
            (Builtin::Min, true) => "spirv.GL.FMin",
            (Builtin::Min, false) => "spirv.GL.SMin",
            (Builtin::Max, true) => "spirv.GL.FMax",
            (Builtin::Max, false) => "spirv.GL.SMax",
            (Builtin::UMin, false) => "spirv.GL.UMin",
            (Builtin::UMax, false) => "spirv.GL.UMax",
            (Builtin::UClamp, false) => "spirv.GL.UClamp",
            (Builtin::Faceforward, true) => "spirv.GL.FaceForward",
            (Builtin::Refract, true) => "spirv.GL.Refract",
            (Builtin::Determinant, true) => "spirv.GL.Determinant",
            (Builtin::Inverse, true) => "spirv.GL.MatrixInverse",
            (Builtin::PackSnorm2x16, _) => "spirv.GL.PackSnorm2x16",
            (Builtin::UnpackSnorm2x16, _) => "spirv.GL.UnpackSnorm2x16",
            (Builtin::PackUnorm2x16, _) => "spirv.GL.PackUnorm2x16",
            (Builtin::UnpackUnorm2x16, _) => "spirv.GL.UnpackUnorm2x16",
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

    fn splats(self) -> bool {
        matches!(self, Builtin::Clamp | Builtin::Mix | Builtin::Step | Builtin::Smoothstep | Builtin::Mod)
    }
}

pub struct GlslToSpirv;

impl GlslToSpirv {
    const ENTRY: &str = "main";
    const BLOCK: &str = "Block";
    const SAMPLE_BASE: usize = 2;
    const KILL: &str = "spirv.Kill";

    const FETCH_OPERANDS: usize = 2;
    const CONST_OFFSET: &str = "ConstOffset";

    fn mask(lod: Option<&str>, offset: bool) -> Option<String> {
        let parts: Vec<&str> = lod.into_iter().chain(offset.then_some(Self::CONST_OFFSET)).collect();
        (!parts.is_empty()).then(|| parts.join("|"))
    }

    fn sampled_as<'a>(cr: &Cr<'_, 'a, '_>, sampler: ValueId, result: &Type<'a>) -> Type<'a> {
        let elem = match SpirvType::try_from(&Self::ty_of(cr, sampler)) {
            Ok(SpirvType::SampledImage(image)) => match SpirvType::try_from(&*image) {
                Ok(SpirvType::Image { elem, .. }) => *elem,
                _ => return result.clone(),
            },
            _ => return result.clone(),
        };
        match result {
            Type::Shaped(sh) if *sh.elem != elem && matches!(elem, Type::Integer { .. }) => Type::vector(&[Self::lanes(result).map_or(1, |n| n as i64)], &[], elem),
            _ => result.clone(),
        }
    }

    fn image_of<'a>(cr: &mut Cr<'_, 'a, '_>, sampled: ValueId) -> Option<ValueId> {
        let Ok(SpirvType::SampledImage(image)) = SpirvType::try_from(&Self::ty_of(cr, sampled)) else { return None };
        Some(cr.build(OpData::build("spirv.Image").operands(&[sampled]), *image))
    }

    fn image_operands<'a>(o: &str) -> Attribute<'a> {
        Attribute::dialect_with("spirv.image_operands", o)
    }

    fn sym<'a>(name: &str) -> Attribute<'a> {
        Attribute::SymbolRef(vec![String::from(name).into()])
    }

    fn ptr<'a>(pointee: Type<'a>, class: &str) -> Type<'a> {
        SpirvType::Ptr { pointee: Box::new(pointee), storage: class.to_owned() }.into()
    }

    pub fn modules(body: &mut Body<'_>, root: OpId, client: GlslClient) -> Result<Vec<OpId>, Error> {
        let mut shaders = Vec::new();
        body.walk(root, &mut |o| shaders.push(o));
        shaders.retain(|&o| &*body[o].name == GlslShader::NAME);
        shaders.into_iter().map(|s| Self::module(body, s, client)).collect()
    }

    fn variable<'a>(g: &GlslGlobal<'a>, name: &str, client: GlslClient) -> Result<OpData<'a>, Error> {
        let class = g.storage.class(&g.ty, client)?;
        let mut data = OpData::build("spirv.GlobalVariable").with("sym_name", Attribute::str(name)).with("type", Attribute::Type(Self::ptr(g.ty.clone(), class)));
        match g.builtin.map(|b| (b, client.built_in(b))) {
            Some((_, Some(spirv))) => data = data.with("built_in", Attribute::str(spirv)),
            Some((BuiltinVar::FragColor, None)) => data = data.with("location", Attribute::i32(0)),
            Some((b, None)) => return Err(Error(format!("{} is not lowered yet", b.glsl()))),
            None => {}
        }
        if let Some(l) = g.location {
            data = data.with("location", Attribute::i32(l.into()));
        }
        if let Some(b) = g.binding {
            data = data.with("binding", Attribute::i32(b.into())).with("descriptor_set", Attribute::i32(0));
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
        let head = body.head::<GlslShader>(shader)?;
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
            if &*rw.body[o].name == GlslGlobal::NAME {
                let g = rw.body.head::<GlslGlobal>(o)?;
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
            .with("execution_model", Attribute::dialect_with("spirv.execution_model", head.stage.execution_model()))
            .with("fn", Self::sym(Self::ENTRY))
            .with("interface", Attribute::Array(interface));
        rw.create(ep, &[]);
        if head.stage == GlslStage::Fragment {
            let mode = OpData::build("spirv.ExecutionMode")
                .with("execution_mode", Attribute::dialect_with("spirv.execution_mode", client.origin()))
                .with("fn", Self::sym(Self::ENTRY))
                .with("values", Attribute::Array(Vec::new()));
            rw.create(mode, &[]);
        }
        rw.erase_op(shader);
        Ok(m)
    }

    pub fn seal_kills(body: &mut Body<'_>, modules: &[OpId]) {
        let mut kills = Vec::new();
        for &m in modules {
            body.walk(m, &mut |o| kills.push(o));
        }
        kills.retain(|&o| &*body[o].name == Self::KILL);
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        for k in kills {
            let mut dead = Vec::new();
            let mut at = rw.body.next_op(k);
            while let Some(o) = at {
                dead.push(o);
                at = rw.body.next_op(o);
            }
            for o in dead.into_iter().rev() {
                rw.erase_op(o);
            }
        }
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

    fn constant(body: &Body<'_>, v: ValueId) -> Option<usize> {
        let d = body.def_op(v)?;
        if !matches!(&*body[d].name, "arith.constant" | "spirv.Constant") {
            return None;
        }
        usize::try_from(Attrs::as_int(body[d].get("value")?).ok()?).ok()
    }

    fn element<'a>(body: &Body<'a>, t: &Type<'a>, index: ValueId) -> Option<Type<'a>> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Array { elem, .. } | SpirvType::RuntimeArray { elem, .. }) => Some(*elem),
            Ok(SpirvType::Matrix { column, .. }) => Some(*column),
            Ok(SpirvType::Struct { members: Some(m), .. }) => m.get(Self::constant(body, index)?).map(|m| m.ty.clone()),
            _ => matches!(t, Type::Shaped(s) if s.kind == ShapedKind::Vector).then(|| t.element_type().clone()),
        }
    }

    fn pointer<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, var: &Attribute<'_>, indices: &[ValueId]) -> Option<(ValueId, Type<'a>)> {
        let name = Self::var_name(var)?.to_owned();
        let (pointee, class) = Self::global(&cr.rw.body, op, &name)?;
        let base = cr.build(OpData::build("spirv.mlir.addressof").with("variable", Self::sym(&name)), Self::ptr(pointee.clone(), &class));
        if indices.is_empty() {
            return Some((base, pointee));
        }
        let elem = indices.iter().try_fold(pointee, |t, &i| Self::element(&cr.rw.body, &t, i))?;
        let mut operands = vec![base];
        operands.extend_from_slice(indices);
        Some((cr.build(OpData::build("spirv.AccessChain").operands(&operands), Self::ptr(elem.clone(), &class)), elem))
    }

    const UNIFORM: &str = "Uniform";

    fn holds_struct(t: &Type<'_>) -> bool {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Struct { .. }) => true,
            Ok(SpirvType::Array { elem, .. }) => Self::holds_struct(&elem),
            _ => false,
        }
    }

    fn gather<'a>(cr: &mut Cr<'_, 'a, '_>, (base, class): (ValueId, &str), at: &mut Vec<ValueId>, ty: &Type<'a>) -> ValueId {
        let parts: Option<Vec<Type<'a>>> = match SpirvType::try_from(ty) {
            Ok(SpirvType::Struct { members: Some(m), .. }) => Some(m.into_iter().map(|x| x.ty).collect()),
            Ok(SpirvType::Array { len, elem, .. }) if Self::holds_struct(&elem) => Some((0..len).map(|_| (*elem).clone()).collect()),
            _ => None,
        };
        let Some(parts) = parts else {
            let mut operands = vec![base];
            operands.extend_from_slice(at);
            let ptr = cr.build(OpData::build("spirv.AccessChain").operands(&operands), Self::ptr(ty.clone(), class));
            return cr.build(OpData::build("spirv.Load").operands(&[ptr]), ty.clone());
        };
        let mut pieces = Vec::new();
        for (k, t) in parts.iter().enumerate() {
            let i = cr.spirv_const(Type::int(32), Attribute::of_int(k as i128, Type::int(32)));
            at.push(i);
            pieces.push(Self::gather(cr, (base, class), at, t));
            at.pop();
        }
        cr.build(OpData::build("spirv.CompositeConstruct").operands(&pieces), ty.clone())
    }

    fn extract<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, i: usize, ty: &Type<'a>) -> ValueId {
        cr.build(OpData::build("spirv.CompositeExtract").operands(&[v]).with("indices", Attribute::int_array_of(32, &[i as i64])), ty.clone())
    }

    fn columns<'a>(t: &Type<'a>) -> Option<(usize, Type<'a>)> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Matrix { cols, column }) => Some((cols as usize, *column)),
            _ => None,
        }
    }

    fn sum_columns<'a>(cr: &mut Cr<'_, 'a, '_>, m: ValueId, (cols, column): &(usize, Type<'a>), scale: ValueId) -> ValueId {
        let scalar = Self::scalar(column);
        let mut terms = (0..*cols).map(|i| (i, Self::extract(cr, m, i, column), Self::extract(cr, scale, i, &scalar))).collect::<Vec<_>>().into_iter();
        let term = |cr: &mut Cr<'_, 'a, '_>, (_, c, k): (usize, ValueId, ValueId)| cr.build(OpData::build("spirv.VectorTimesScalar").operands(&[c, k]), column.clone());
        let Some(first) = terms.next() else { return m };
        let first = term(cr, first);
        terms.fold(first, |acc, t| {
            let p = term(cr, t);
            cr.build(OpData::build("spirv.FAdd").operands(&[acc, p]), column.clone())
        })
    }

    fn as_opengl<'a>(cr: &mut Cr<'_, 'a, '_>, func: Builtin, args: &[ValueId], ty: &Type<'a>) -> Option<ValueId> {
        let [a, b] = <[ValueId; 2]>::try_from(args).ok()?;
        match func {
            Builtin::MatrixTimesVector => {
                let shape = Self::columns(&Self::ty_of(cr, a))?;
                Some(Self::sum_columns(cr, a, &shape, b))
            }
            Builtin::MatrixTimesMatrix => {
                let shape = Self::columns(&Self::ty_of(cr, a))?;
                let (cols, b_column) = Self::columns(&Self::ty_of(cr, b))?;
                let out: Vec<ValueId> = (0..cols)
                    .map(|j| {
                        let bj = Self::extract(cr, b, j, &b_column);
                        Self::sum_columns(cr, a, &shape, bj)
                    })
                    .collect();
                Some(cr.build(OpData::build("spirv.CompositeConstruct").operands(&out), ty.clone()))
            }
            Builtin::VectorTimesMatrix => {
                let (cols, column) = Self::columns(&Self::ty_of(cr, b))?;
                let scalar = Self::scalar(&column);
                let out: Vec<ValueId> = (0..cols)
                    .map(|i| {
                        let c = Self::extract(cr, b, i, &column);
                        cr.build(OpData::build("spirv.Dot").operands(&[a, c]), scalar.clone())
                    })
                    .collect();
                Some(cr.build(OpData::build("spirv.CompositeConstruct").operands(&out), ty.clone()))
            }
            _ => None,
        }
    }

    fn cast<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, to: &Type<'a>) -> ValueId {
        let from = Self::ty_of(cr, v);
        if from == *to {
            return v;
        }
        let parts: Option<Vec<Type<'a>>> = match (SpirvType::try_from(&from), SpirvType::try_from(to)) {
            (Ok(SpirvType::Struct { members: Some(_), .. }), Ok(SpirvType::Struct { members: Some(m), .. })) => Some(m.into_iter().map(|x| x.ty).collect()),
            (Ok(SpirvType::Array { .. }), Ok(SpirvType::Array { len, elem, .. })) => Some((0..len).map(|_| (*elem).clone()).collect()),
            (Ok(SpirvType::Matrix { .. }), Ok(SpirvType::Matrix { cols, column })) => Some((0..cols).map(|_| (*column).clone()).collect()),
            _ => None,
        };
        let bool_of = |t: &Type<'_>| *t.element_type() == Type::I1;
        if bool_of(to) && !bool_of(&from) {
            let zero = crate::ArithToSpirv::splat(&from, |_| mlirformat::Scalar::Int(mlirformat::ApInt::from_bits(32, 0)));
            let zero = cr.spirv_const(from.clone(), zero);
            return cr.build(OpData::build("spirv.INotEqual").operands(&[v, zero]), to.clone());
        }
        let Some(parts) = parts else { return cr.build(OpData::build("spirv.Bitcast").operands(&[v]), to.clone()) };
        let src: Vec<Type<'a>> = match SpirvType::try_from(&from) {
            Ok(SpirvType::Struct { members: Some(m), .. }) => m.into_iter().map(|x| x.ty).collect(),
            Ok(SpirvType::Array { elem, .. }) => (0..parts.len()).map(|_| (*elem).clone()).collect(),
            Ok(SpirvType::Matrix { column, .. }) => (0..parts.len()).map(|_| (*column).clone()).collect(),
            _ => return v,
        };
        let pieces: Vec<ValueId> = parts
            .iter()
            .zip(src)
            .enumerate()
            .map(|(k, (t, s))| {
                let x = Self::extract(cr, v, k, &s);
                Self::cast(cr, x, t)
            })
            .collect();
        cr.build(OpData::build("spirv.CompositeConstruct").operands(&pieces), to.clone())
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

    fn scalar<'a>(t: &Type<'a>) -> Type<'a> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Matrix { column, .. }) => column.element_type().clone(),
            _ => t.element_type().clone(),
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

#[patterns(converter, options = GlslClient)]
impl GlslToSpirv {
    #[convert("glsl.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Ok(l) = cr.rw.body.head::<GlslLoad>(op) else { return false };
        let Some(indices) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(name) = Self::var_name(&l.var).map(str::to_owned) else { return false };
        let Some((pointee, class)) = Self::global(&cr.rw.body, op, &name) else { return false };
        let Some(elem) = indices.iter().try_fold(pointee.clone(), |t, &i| Self::element(&cr.rw.body, &t, i)) else { return false };
        let loaded = if class == Self::UNIFORM && !indices.is_empty() && Self::holds_struct(&elem) {
            let base = cr.build(OpData::build("spirv.mlir.addressof").with("variable", Self::sym(&name)), Self::ptr(pointee, &class));
            Self::gather(cr, (base, &class), &mut indices.clone(), &elem)
        } else {
            let Some((ptr, declared)) = Self::pointer(cr, op, &l.var, &indices) else { return false };
            cr.build(OpData::build("spirv.Load").operands(&[ptr]), declared)
        };
        let v = Self::cast(cr, loaded, &ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("glsl.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Ok(s) = cr.rw.body.head::<GlslStore>(op) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some((&value, indices)) = ops.split_first() else { return false };
        let Some((ptr, declared)) = Self::pointer(cr, op, &s.var, indices) else { return false };
        let value = Self::cast(cr, value, &declared);
        cr.replace_new(op, OpData::build("spirv.Store").operands(&[ptr, value]), &[]);
        true
    }

    #[convert("glsl.construct")]
    fn construct(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        if cr.rw.body.head::<GlslConstruct>(op).is_err() {
            return false;
        }
        let Some(parts) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        if let Some((cols, column)) = Self::columns(&ty) {
            if parts.len() != cols || parts.iter().any(|&p| Self::ty_of(cr, p) != column) {
                return false;
            }
            cr.replace_new(op, OpData::build("spirv.CompositeConstruct").operands(&parts), &[ty]);
            return true;
        }
        let Some(n) = Self::lanes(&ty) else { return false };
        let elem = ty.element_type().clone();
        let types: Vec<Type<'_>> = parts.iter().map(|&p| Self::ty_of(cr, p)).collect();
        if types.iter().any(|t| *t.element_type() != elem) {
            return false;
        }
        let Some(counts) = types.iter().map(Self::lanes).collect::<Option<Vec<usize>>>() else { return false };
        let data = match (&parts[..], &counts[..]) {
            ([p], [1]) if n > 1 => OpData::build("spirv.CompositeConstruct").operands(&vec![*p; n]),
            ([p], [1]) | ([p], _) if Self::ty_of(cr, *p) == ty => {
                cr.replace_values(op, &[*p]);
                return true;
            }
            ([p], [_]) if n == 1 => OpData::build("spirv.CompositeExtract").operands(&[*p]).with("indices", Attribute::int_array_of(32, &[0])),
            ([p], [m]) if *m > n => OpData::build("spirv.VectorShuffle").operands(&[*p, *p]).with("components", Attribute::Array((0..n).map(|i| Attribute::i32(i as i64)).collect())),
            _ if counts.iter().sum::<usize>() == n => OpData::build("spirv.CompositeConstruct").operands(&parts),
            _ => return false,
        };
        cr.replace_new(op, data, &[ty]);
        true
    }

    #[convert("glsl.builtin")]
    fn builtin(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], client: GlslClient) -> bool {
        let Ok(c) = cr.rw.body.head::<GlslCall>(op) else { return false };
        let Some(mut args) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let Some(&first) = args.first() else { return false };
        let float = matches!(Self::scalar(&Self::ty_of(cr, first)), Type::Float(_));
        if client == GlslClient::Opengl
            && let Some(v) = Self::as_glsl_compiler(cr, c.func, &args, &ty).or_else(|| Self::as_opengl(cr, c.func, &args, &ty))
        {
            cr.replace_values(op, &[v]);
            return true;
        }
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

    #[convert("glsl.texture")]
    fn texture(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Ok(t) = cr.rw.body.head::<GlslTexture>(op) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        if ops.len() != Self::SAMPLE_BASE + usize::from(t.dref) + t.lod.operands() + usize::from(t.offset) {
            return false;
        }
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let mut data = OpData::build(t.lod.spirv(t.proj, t.dref)).operands(&ops);
        if let Some(o) = Self::mask(t.lod.operand(), t.offset) {
            data = data.with("image_operands", Self::image_operands(&o));
        }
        let sampled = Self::sampled_as(cr, ops[0], &ty);
        let v = cr.build(data, sampled);
        let v = Self::cast(cr, v, &ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("glsl.texel_fetch")]
    fn texel_fetch(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Ok(t) = cr.rw.body.head::<GlslTexelFetch>(op) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some((&sampled, rest)) = ops.split_first() else { return false };
        if rest.len() != Self::FETCH_OPERANDS + usize::from(t.offset) {
            return false;
        }
        let Some(image) = Self::image_of(cr, sampled) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        let mut args = vec![image];
        args.extend_from_slice(rest);
        let Some(mask) = Self::mask(Lod::Explicit.operand(), t.offset) else { return false };
        let fetched = Self::sampled_as(cr, sampled, &ty);
        let v = cr.build(OpData::build("spirv.ImageFetch").operands(&args).with("image_operands", Self::image_operands(&mask)), fetched);
        let v = Self::cast(cr, v, &ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("glsl.texture_size")]
    fn texture_size(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Ok([sampled, level]) = <[ValueId; 2]>::try_from(ops) else { return false };
        let Some(image) = Self::image_of(cr, sampled) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        cr.replace_new(op, OpData::build("spirv.ImageQuerySizeLod").operands(&[image, level]), &[ty]);
        true
    }

    #[convert("glsl.derivative")]
    fn derivative(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Ok(d) = cr.rw.body.head::<GlslDeriv>(op) else { return false };
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let r = cr.rw.body[op].results[0];
        let Some(ty) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
        cr.replace_new(op, OpData::build(d.kind.spirv()).operands(&ops), &[ty]);
        true
    }

    /// `c ? x : y` on vectors with a scalar `c`: GLSL picks whole vectors, SPIR-V before 1.4 picks lane by lane, so
    /// every lane gets `c`
    #[convert("arith.select", benefit = 2)]
    fn select_lanes(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: GlslClient) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let ty = Self::ty_of(cr, ops[1]);
        let (Some(n), Some(1)) = (Self::lanes(&ty), Self::lanes(&Self::ty_of(cr, ops[0]))) else { return false };
        let Type::Shaped(s) = &ty else { return false };
        if n < 2 {
            return false;
        }
        let lanes = Type::Shaped(Box::new(mlirformat::Shaped { elem: Type::I1.into(), ..*s.clone() }));
        let c = cr.build(OpData::build("spirv.CompositeConstruct").operands(&vec![ops[0]; n]), lanes);
        let v = cr.build(OpData::build("spirv.Select").operands(&[c, ops[1], ops[2]]), ty);
        cr.replace_values(op, &[v]);
        true
    }

    #[convert("glsl.discard")]
    fn discard(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], _: GlslClient) -> bool {
        cr.replace_new(op, OpData::build(Self::KILL), &[]);
        true
    }
}
