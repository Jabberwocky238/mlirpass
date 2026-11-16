use alloc::boxed::Box;
use alloc::collections::BTreeMap;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpFPredicate, CmpIPredicate};
use mlirformat::spirv_types::{SpirvDecoration, SpirvMember, SpirvType};
use mlirformat::{ApFloat, ApInt, Attribute, Const, Error, FloatKind, FunctionType, Op, Scalar as Lit, Signedness, Type};

use super::lex::{Lexed, Version};
use super::syntax::{BinOp, BlockLayout, Decl, Expr, Item, ParamQual, Parser, Qual, SamplerDim, Scalar, Stmt, StorageQual, StructDef, Ty, UnOp};
use crate::{A, BlockId, OpHead, Body, Builtin, BuiltinVar, Derivative, GlslStage, Lod, OpData, OpId, Quiet, Rewriter, Storage, ValueId};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Func {
    Unary(Builtin),
    Binary(Builtin),
    Abs,
    Sign,
    Atan,
    Min,
    Max,
    Clamp,
    Mix,
    Step,
    Smoothstep,
    Fma,
    IsNan,
    IsInf,
    Length,
    Distance,
    Dot,
    Cross,
    Normalize,
    Faceforward,
    Reflect,
    Refract,
    MatrixCompMult,
    OuterProduct,
    Transpose,
    Determinant,
    Inverse,
    Compare(BinOp),
    Any,
    All,
    Not,
    Sample { lod: Lod, offset: bool, proj: bool },
    Fetch { offset: bool },
    Size,
    Derivative(Derivative),
    BitsToFloat,
    FloatBitsTo(Scalar),
}

impl Func {
    const SAMPLE_BASE: usize = 2;
    const FETCH_OFFSET_AT: usize = 3;
    const PROJ_VEC4: u32 = 4;

    fn offset_at(self) -> Option<usize> {
        match self {
            Func::Sample { lod: Lod::Implicit, offset: true, .. } => Some(Func::SAMPLE_BASE),
            Func::Sample { lod, offset: true, .. } => Some(Func::SAMPLE_BASE + lod.operands()),
            Func::Fetch { offset: true } => Some(Func::FETCH_OFFSET_AT),
            _ => None,
        }
    }
}

impl SamplerDim {
    const fn coordinates(self) -> u32 {
        match self {
            SamplerDim::D2 => 2,
            SamplerDim::D3 | SamplerDim::Cube | SamplerDim::D2Array => 3,
        }
    }

    const fn size_lanes(self) -> u32 {
        match self {
            SamplerDim::D2 | SamplerDim::Cube => 2,
            SamplerDim::D3 | SamplerDim::D2Array => 3,
        }
    }
}

impl TryFrom<&str> for Func {
    type Error = ();

    fn try_from(name: &str) -> Result<Self, ()> {
        Ok(match name {
            "radians" => Func::Unary(Builtin::Radians),
            "degrees" => Func::Unary(Builtin::Degrees),
            "sin" => Func::Unary(Builtin::Sin),
            "cos" => Func::Unary(Builtin::Cos),
            "tan" => Func::Unary(Builtin::Tan),
            "asin" => Func::Unary(Builtin::Asin),
            "acos" => Func::Unary(Builtin::Acos),
            "sinh" => Func::Unary(Builtin::Sinh),
            "cosh" => Func::Unary(Builtin::Cosh),
            "tanh" => Func::Unary(Builtin::Tanh),
            "asinh" => Func::Unary(Builtin::Asinh),
            "acosh" => Func::Unary(Builtin::Acosh),
            "atanh" => Func::Unary(Builtin::Atanh),
            "exp" => Func::Unary(Builtin::Exp),
            "log" => Func::Unary(Builtin::Log),
            "exp2" => Func::Unary(Builtin::Exp2),
            "log2" => Func::Unary(Builtin::Log2),
            "sqrt" => Func::Unary(Builtin::Sqrt),
            "inversesqrt" => Func::Unary(Builtin::InverseSqrt),
            "floor" => Func::Unary(Builtin::Floor),
            "trunc" => Func::Unary(Builtin::Trunc),
            "round" => Func::Unary(Builtin::Round),
            "roundEven" => Func::Unary(Builtin::RoundEven),
            "ceil" => Func::Unary(Builtin::Ceil),
            "fract" => Func::Unary(Builtin::Fract),
            "pow" => Func::Binary(Builtin::Pow),
            "mod" => Func::Binary(Builtin::Mod),
            "abs" => Func::Abs,
            "sign" => Func::Sign,
            "atan" => Func::Atan,
            "min" => Func::Min,
            "max" => Func::Max,
            "clamp" => Func::Clamp,
            "mix" => Func::Mix,
            "step" => Func::Step,
            "smoothstep" => Func::Smoothstep,
            "fma" => Func::Fma,
            "isnan" => Func::IsNan,
            "isinf" => Func::IsInf,
            "length" => Func::Length,
            "distance" => Func::Distance,
            "dot" => Func::Dot,
            "cross" => Func::Cross,
            "normalize" => Func::Normalize,
            "faceforward" => Func::Faceforward,
            "reflect" => Func::Reflect,
            "refract" => Func::Refract,
            "matrixCompMult" => Func::MatrixCompMult,
            "outerProduct" => Func::OuterProduct,
            "transpose" => Func::Transpose,
            "determinant" => Func::Determinant,
            "inverse" => Func::Inverse,
            "lessThan" => Func::Compare(BinOp::Lt),
            "lessThanEqual" => Func::Compare(BinOp::Le),
            "greaterThan" => Func::Compare(BinOp::Gt),
            "greaterThanEqual" => Func::Compare(BinOp::Ge),
            "equal" => Func::Compare(BinOp::Eq),
            "notEqual" => Func::Compare(BinOp::Ne),
            "any" => Func::Any,
            "all" => Func::All,
            "not" => Func::Not,
            "texture" | "texture2D" | "textureCube" => Func::Sample { lod: Lod::Implicit, offset: false, proj: false },
            "textureOffset" => Func::Sample { lod: Lod::Implicit, offset: true, proj: false },
            "textureProj" | "texture2DProj" => Func::Sample { lod: Lod::Implicit, offset: false, proj: true },
            "textureProjOffset" => Func::Sample { lod: Lod::Implicit, offset: true, proj: true },
            "textureLod" | "texture2DLod" | "textureCubeLod" => Func::Sample { lod: Lod::Explicit, offset: false, proj: false },
            "textureLodOffset" => Func::Sample { lod: Lod::Explicit, offset: true, proj: false },
            "textureProjLod" | "texture2DProjLod" => Func::Sample { lod: Lod::Explicit, offset: false, proj: true },
            "textureProjLodOffset" => Func::Sample { lod: Lod::Explicit, offset: true, proj: true },
            "textureGrad" => Func::Sample { lod: Lod::Grad, offset: false, proj: false },
            "textureGradOffset" => Func::Sample { lod: Lod::Grad, offset: true, proj: false },
            "textureProjGrad" => Func::Sample { lod: Lod::Grad, offset: false, proj: true },
            "textureProjGradOffset" => Func::Sample { lod: Lod::Grad, offset: true, proj: true },
            "texelFetch" => Func::Fetch { offset: false },
            "texelFetchOffset" => Func::Fetch { offset: true },
            "textureSize" => Func::Size,
            "dFdx" => Func::Derivative(Derivative::Dfdx),
            "dFdy" => Func::Derivative(Derivative::Dfdy),
            "fwidth" => Func::Derivative(Derivative::Fwidth),
            "intBitsToFloat" | "uintBitsToFloat" => Func::BitsToFloat,
            "floatBitsToInt" => Func::FloatBitsTo(Scalar::Int),
            "floatBitsToUint" => Func::FloatBitsTo(Scalar::Uint),
            _ => return Err(()),
        })
    }
}

impl Scalar {
    fn mlir<'a>(self, global: bool) -> Type<'a> {
        match (self, global) {
            (Scalar::Float, _) => Type::Float(FloatKind::F32),
            (Scalar::Bool, _) => Type::I1,
            (Scalar::Int, true) => Type::Integer { signedness: Signedness::Signed, width: Ty::WORD },
            (Scalar::Int | Scalar::Uint, _) => Type::int(Ty::WORD),
        }
    }
}

impl Ty {
    const WORD: u32 = 32;
    const STD140_VEC4: u32 = 16;
    const SCALAR_BYTES: u32 = 4;

    fn mlir<'a>(&self, global: bool) -> Result<Type<'a>, Error> {
        Ok(match self {
            Ty::Void => return Err(Error(String::from("glsl: void is not a value type"))),
            Ty::Scalar(s) => s.mlir(global),
            Ty::Vec(s, n) => Type::vector(&[i64::from(*n)], &[], s.mlir(global)),
            Ty::Mat(c, r) => SpirvType::Matrix { cols: *c, column: Box::new(Ty::Vec(Scalar::Float, *r).mlir(global)?) }.into(),
            Ty::Array(e, n) => SpirvType::Array { len: *n, elem: Box::new(e.mlir(global)?), stride: 0 }.into(),
            Ty::Struct(d) => {
                let members = d.members.iter().map(|(t, _)| Ok(SpirvMember { ty: t.mlir(global)?, offset: None, decorations: Vec::new() })).collect::<Result<Vec<_>, Error>>()?;
                SpirvType::Struct { name: None, members: Some(members), decorations: Vec::new() }.into()
            }
            Ty::Sampler(s, dim, shadow) => {
                let (d, arrayed) = match dim {
                    SamplerDim::D2 => ("Dim2D", "NonArrayed"),
                    SamplerDim::D3 => ("Dim3D", "NonArrayed"),
                    SamplerDim::Cube => ("Cube", "NonArrayed"),
                    SamplerDim::D2Array => ("Dim2D", "Arrayed"),
                };
                let depth = if *shadow { "IsDepth" } else { "NoDepth" };
                let params = [d, depth, arrayed, "SingleSampled", "NeedSampler", "Unknown"].map(String::from);
                SpirvType::SampledImage(Box::new(SpirvType::Image { elem: Box::new(s.mlir(true)), params }.into())).into()
            }
        })
    }

    fn round(x: u32, a: u32) -> u32 {
        x.div_ceil(a) * a
    }

    fn std140(&self) -> Result<(u32, u32), Error> {
        Ok(match self {
            Ty::Scalar(_) => (Ty::SCALAR_BYTES, Ty::SCALAR_BYTES),
            Ty::Vec(_, 2) => (2 * Ty::SCALAR_BYTES, 2 * Ty::SCALAR_BYTES),
            Ty::Vec(_, n) => (Ty::STD140_VEC4, n * Ty::SCALAR_BYTES),
            Ty::Mat(c, _) => (Ty::STD140_VEC4, c * Ty::STD140_VEC4),
            Ty::Array(e, n) => (Ty::STD140_VEC4, e.stride140()? * n),
            Ty::Struct(d) => {
                let (_, align, size) = Ty::struct140(d)?;
                (align, size)
            }
            _ => return Err(Error(format!("glsl: {self:?} cannot be a block member"))),
        })
    }

    fn stride140(&self) -> Result<u32, Error> {
        let (a, size) = self.std140()?;
        Ok(Ty::round(size.max(a), Ty::STD140_VEC4))
    }

    fn struct140(d: &StructDef) -> Result<(Vec<u32>, u32, u32), Error> {
        let mut offsets = Vec::new();
        let (mut at, mut align) = (0, Ty::STD140_VEC4);
        for (t, _) in &d.members {
            let (a, size) = t.std140()?;
            at = Ty::round(at, a);
            offsets.push(at);
            at += size;
            align = align.max(a);
        }
        let align = Ty::round(align, Ty::STD140_VEC4);
        Ok((offsets, align, Ty::round(at, align)))
    }

    fn laid_type<'a>(&self) -> Result<Type<'a>, Error> {
        Ok(match self {
            Ty::Array(e, n) => SpirvType::Array { len: *n, elem: Box::new(e.laid_type()?), stride: e.stride140()? }.into(),
            Ty::Struct(d) => {
                let (offsets, _, _) = Ty::struct140(d)?;
                let members = d.members.iter().zip(offsets).map(|((t, _), o)| t.block_member(o)).collect::<Result<Vec<_>, _>>()?;
                SpirvType::Struct { name: None, members: Some(members), decorations: Vec::new() }.into()
            }
            t => t.mlir(true)?,
        })
    }

    fn innermost(&self) -> &Ty {
        match self {
            Ty::Array(e, _) => e.innermost(),
            t => t,
        }
    }

    fn block_member<'a>(&self, offset: u32) -> Result<SpirvMember<'a>, Error> {
        let decorations = match self.innermost() {
            Ty::Mat(..) => vec![SpirvDecoration { name: String::from("ColMajor"), value: None }, SpirvDecoration { name: String::from("MatrixStride"), value: Some(format!("{}", Ty::STD140_VEC4)) }],
            _ => Vec::new(),
        };
        Ok(SpirvMember { ty: self.laid_type()?, offset: Some(offset), decorations })
    }

    fn element(&self) -> Option<Ty> {
        match self {
            Ty::Vec(s, _) => Some(Ty::Scalar(*s)),
            Ty::Mat(_, r) => Some(Ty::Vec(Scalar::Float, *r)),
            Ty::Array(e, _) => Some((**e).clone()),
            _ => None,
        }
    }
}

impl BuiltinVar {
    fn ty(self) -> Ty {
        match self {
            BuiltinVar::Position | BuiltinVar::FragCoord | BuiltinVar::FragColor | BuiltinVar::FragData => Ty::Vec(Scalar::Float, 4),
            BuiltinVar::PointSize | BuiltinVar::FragDepth => Ty::FLOAT,
            BuiltinVar::VertexId | BuiltinVar::InstanceId => Ty::INT,
            BuiltinVar::FrontFacing => Ty::BOOL,
            BuiltinVar::PointCoord => Ty::Vec(Scalar::Float, 2),
        }
    }

    fn storage(self) -> Storage {
        match self {
            BuiltinVar::Position | BuiltinVar::PointSize | BuiltinVar::FragDepth | BuiltinVar::FragColor | BuiltinVar::FragData => Storage::Out,
            _ => Storage::In,
        }
    }
}

#[derive(Debug, Clone)]
enum Name<'s> {
    Local(ValueId, Ty),
    Global(String, Ty),
    Member(String, u32, Ty),
    Block(String, Vec<(Ty, &'s str)>),
    Const(Expr<'s>, Ty),
}

#[derive(Debug, Clone)]
enum Place {
    Local(ValueId, Vec<ValueId>, Ty),
    Global(String, Vec<ValueId>, Ty),
}

impl Place {
    fn ty(&self) -> &Ty {
        match self {
            Place::Local(.., t) | Place::Global(.., t) => t,
        }
    }

    fn indexed(self, i: ValueId, ty: Ty) -> Place {
        match self {
            Place::Local(p, mut ix, _) => {
                ix.push(i);
                Place::Local(p, ix, ty)
            }
            Place::Global(g, mut ix, _) => {
                ix.push(i);
                Place::Global(g, ix, ty)
            }
        }
    }
}

#[derive(Clone)]
struct Signature {
    params: Vec<(ParamQual, Ty)>,
    ret: Ty,
    symbol: String,
    defined: bool,
}

enum Arg {
    Value(ValueId, Ty),
    Place(Place, Option<Vec<u32>>, Ty),
}

impl Arg {
    fn ty(&self) -> &Ty {
        match self {
            Arg::Value(_, t) | Arg::Place(_, _, t) => t,
        }
    }
}

pub struct GlslReader;

struct Emitter<'r, 'a, 's> {
    rw: Rewriter<'r, 'a>,
    stage: GlslStage,
    shader: BlockId,
    first_func: Option<OpId>,
    globals: BTreeMap<&'s str, Name<'s>>,
    builtins: BTreeMap<&'s str, ()>,
    funcs: BTreeMap<&'s str, Vec<Signature>>,
    scopes: Vec<BTreeMap<&'s str, Name<'s>>>,
    entry: Option<BlockId>,
    inits: Vec<(&'s str, Expr<'s>, Ty)>,
    loops: Vec<Exit>,
    tests: Vec<Option<Expr<'s>>>,
    merges: Vec<(OpId, BlockId)>,
    ret: Ty,
    dead: bool,
}

#[derive(Debug, Clone, Copy)]
struct Exit {
    cont: BlockId,
    merge: BlockId,
}

impl GlslReader {
    const LOOP_BLOCKS: usize = 5;
    const MAIN: &'static str = "main";

    pub fn read<'a>(body: &mut Body<'a>, src: &str, stage: GlslStage) -> Result<OpId, Error> {
        let text = Lexed::text(src)?;
        let lexed = Lexed::read(&text)?;
        let items = Parser::new(&lexed.tokens).items()?;
        let mut quiet = Quiet;
        let root = body.top_block(body.root);
        let mut rw = Rewriter::new(body, &mut quiet);
        rw.set_end(root);
        let Version { number, es } = lexed.version;
        let shader = OpData::head(&crate::GlslShader::new(stage, number, es, mlirformat::Region { blocks: Vec::new() }))?;
        let op = rw.create_with(shader, &[], |b, op| {
            let r = b.add_region(op);
            b.add_block(r, &[]);
        });
        let block = rw.body.top_block(op);
        let mut e = Emitter { rw, stage, shader: block, first_func: None, globals: BTreeMap::new(), builtins: BTreeMap::new(), funcs: BTreeMap::new(), scopes: Vec::new(), entry: None, inits: Vec::new(), loops: Vec::new(), tests: Vec::new(), merges: Vec::new(), ret: Ty::Void, dead: false };
        let (funcs, decls): (Vec<&Item<'_>>, Vec<&Item<'_>>) = items.iter().partition(|i| matches!(i, Item::Func { .. }));
        for item in decls.into_iter().chain(funcs) {
            e.item(item)?;
        }
        Ok(op)
    }
}

impl<'r, 'a, 's> Emitter<'r, 'a, 's> {
    fn err<T>(msg: impl Into<String>) -> Result<T, Error> {
        Err(Error(format!("glsl: {}", msg.into())))
    }

    fn word(v: u32) -> Attribute<'a> {
        Attribute::of_int(i128::from(v), Type::int(Ty::WORD))
    }

    fn create(&mut self, data: OpData<'a>, ty: Option<Type<'a>>) -> Option<ValueId> {
        let op = self.rw.create(data, ty.as_slice());
        self.rw.body[op].results.first().copied()
    }

    fn op(&mut self, name: &'static str, operands: &[ValueId], ty: Type<'a>) -> ValueId {
        let op = self.rw.create(OpData::build(name).operands(operands), &[ty]);
        self.rw.body[op].results[0]
    }

    fn ty_of(&self, v: ValueId) -> Type<'a> {
        self.rw.body[v].ty.clone()
    }

    fn i32(&mut self, v: i64) -> ValueId {
        let ty = Type::int(Ty::WORD);
        self.create(OpData::build("arith.constant").with("value", Attribute::of_int(i128::from(v), Type::int(Ty::WORD))), Some(ty)).unwrap_or_else(|| unreachable!())
    }

    fn float(&mut self, v: f32) -> ValueId {
        let ty = Type::Float(FloatKind::F32);
        let value: Attribute<'a> = Const::scalar(Lit::Float(ApFloat { kind: FloatKind::F32, bits: u64::from(v.to_bits()) }), ty.clone()).into();
        self.create(OpData::build("arith.constant").with("value", value), Some(ty)).unwrap_or_else(|| unreachable!())
    }

    fn constant(&mut self, s: Scalar, bits: u32) -> ValueId {
        match s {
            Scalar::Float => self.float(f32::from_bits(bits)),
            Scalar::Int | Scalar::Uint => self.i32(i64::from(bits as i32)),
            Scalar::Bool => {
                let v = Attribute::of_int(i128::from(bits != 0), Type::I1);
                self.create(OpData::build("arith.constant").with("value", v), Some(Type::I1)).unwrap_or_else(|| unreachable!())
            }
        }
    }

    fn in_block<T>(&mut self, block: BlockId, f: impl FnOnce(&mut Self) -> Result<T, Error>) -> Result<T, Error> {
        let saved = self.rw.ip;
        self.rw.set_end(block);
        let out = f(self);
        self.rw.ip = saved;
        out
    }

    fn with_regions(&mut self, data: OpData<'a>, types: &[Type<'a>], regions: usize) -> (OpId, Vec<BlockId>) {
        let op = self.rw.create_with(data, types, |b, op| {
            for _ in 0..regions {
                let r = b.add_region(op);
                b.add_block(r, &[]);
            }
        });
        let blocks = self.rw.body[op].regions.iter().map(|&r| self.rw.body[r].blocks[0]).collect();
        (op, blocks)
    }

    fn lookup(&self, name: &str) -> Option<Name<'s>> {
        self.scopes.iter().rev().find_map(|s| s.get(name)).or_else(|| self.globals.get(name)).cloned()
    }

    fn global(&mut self, name: &str, ty: Type<'a>, storage: Storage, attrs: Vec<(&'static str, Attribute<'a>)>) -> Result<(), Error> {
        let mut data = OpData::build(crate::GlslGlobal::NAME).with("sym_name", Attribute::str(name)).with("ty", Attribute::Type(ty)).with("storage", A::from(storage as i64).into());
        for (k, v) in attrs {
            data = data.with(k, v);
        }
        let saved = self.rw.ip;
        match self.first_func {
            Some(f) => self.rw.set_before(f),
            None => self.rw.set_end(self.shader),
        }
        self.rw.create(data, &[]);
        self.rw.ip = saved;
        Ok(())
    }

    fn builtin(&mut self, name: &'s str, b: BuiltinVar) -> Result<Name<'s>, Error> {
        if self.builtins.insert(name, ()).is_none() {
            let attrs = vec![("builtin", A::from(b as i64).into())];
            self.global(name, b.ty().mlir(true)?, b.storage(), attrs)?;
        }
        Ok(Name::Global(String::from(name), b.ty()))
    }

    fn item(&mut self, item: &Item<'s>) -> Result<(), Error> {
        match item {
            Item::Invariant(_) => Self::err("invariant redeclarations are not supported yet"),
            Item::Global { qual, decl } => self.global_decl(qual, decl),
            Item::Block { qual, name, members, instance } => self.block(qual, name, members, *instance),
            Item::Func { ret, name, params, body, .. } => {
                let quals: Vec<(ParamQual, Ty)> = params.iter().map(|p| (p.qual, p.ty.clone())).collect();
                let list = self.funcs.entry(name).or_default();
                let at = list.iter().position(|s| s.params.iter().map(|p| &p.1).eq(quals.iter().map(|p| &p.1)));
                let symbol = match at {
                    Some(k) if list[k].ret != *ret || list[k].params != quals => return Self::err(format!("{name}: redeclared with another return type or qualifiers")),
                    Some(k) if list[k].defined && body.is_some() => return Self::err(format!("{name}: defined twice")),
                    Some(k) => {
                        list[k].defined |= body.is_some();
                        list[k].symbol.clone()
                    }
                    None => {
                        let symbol = if list.is_empty() { String::from(*name) } else { format!("{name}.{}", list.len()) };
                        list.push(Signature { params: quals, ret: ret.clone(), symbol: symbol.clone(), defined: body.is_some() });
                        symbol
                    }
                };
                match body {
                    Some(b) => self.function(ret, &symbol, params, b),
                    None => Ok(()),
                }
            }
        }
    }

    fn global_decl(&mut self, qual: &Qual, decl: &Decl<'s>) -> Result<(), Error> {
        let storage = match (qual.storage, self.stage) {
            (Some(StorageQual::Const), _) => {
                let Some(init) = decl.init.clone() else { return Self::err(format!("const {} needs a value", decl.name)) };
                self.globals.insert(decl.name, Name::Const(init, decl.ty.clone()));
                return Ok(());
            }
            (Some(StorageQual::In), _) | (Some(StorageQual::Varying), GlslStage::Fragment) => Storage::In,
            (Some(StorageQual::Out), _) | (Some(StorageQual::Varying), GlslStage::Vertex) => Storage::Out,
            (Some(StorageQual::Uniform), _) => Storage::Uniform,
            (None, _) => {
                self.global(decl.name, decl.ty.mlir(false)?, Storage::Private, Vec::new())?;
                self.globals.insert(decl.name, Name::Global(String::from(decl.name), decl.ty.clone()));
                if let Some(init) = &decl.init {
                    self.inits.push((decl.name, init.clone(), decl.ty.clone()));
                }
                return Ok(());
            }
        };
        if decl.init.is_some() {
            return Self::err(format!("{}: initializers on in / out / uniform", decl.name));
        }
        let mut attrs = Vec::new();
        if let Some(l) = qual.location {
            attrs.push(("location", Emitter::word(l)));
        }
        if let Some(b) = qual.binding {
            attrs.push(("binding", Emitter::word(b)));
        }
        if let Some(i) = qual.interpolation {
            attrs.push(("interpolation", A::from(i as i64).into()));
        }
        if qual.centroid {
            attrs.push(("centroid", Attribute::Unit));
        }
        if qual.invariant {
            attrs.push(("invariant", Attribute::Unit));
        }
        if let Some(p) = qual.precision {
            attrs.push(("precision", A::from(p as i64).into()));
        }
        self.global(decl.name, decl.ty.mlir(true)?, storage, attrs)?;
        self.globals.insert(decl.name, Name::Global(String::from(decl.name), decl.ty.clone()));
        Ok(())
    }

    fn block(&mut self, qual: &Qual, name: &'s str, members: &[(Ty, &'s str)], instance: Option<(&'s str, Option<u32>)>) -> Result<(), Error> {
        if matches!(qual.layout, Some(BlockLayout::Packed | BlockLayout::Shared)) || instance.is_some_and(|(_, n)| n.is_some()) {
            return Self::err(format!("block {name}: only std140 blocks, not arrays of blocks, are supported yet"));
        }
        let mut offset: u32 = 0;
        let mut laid = Vec::new();
        for (ty, _) in members {
            let (align, size) = ty.std140()?;
            offset = offset.div_ceil(align) * align;
            laid.push(ty.block_member(offset)?);
            offset += size;
        }
        let ty: Type<'a> = SpirvType::Struct { name: None, members: Some(laid), decorations: vec![SpirvDecoration { name: String::from("Block"), value: None }] }.into();
        let sym = String::from(instance.map_or(name, |(i, _)| i));
        let attrs = qual.binding.map(|b| ("binding", Emitter::word(b))).into_iter().collect();
        self.global(&sym, ty, Storage::Uniform, attrs)?;
        match instance {
            Some((i, _)) => {
                self.globals.insert(i, Name::Block(sym, members.to_vec()));
            }
            None => {
                for (k, (t, n)) in members.iter().enumerate() {
                    self.globals.insert(n, Name::Member(sym.clone(), u32::try_from(k).unwrap_or(u32::MAX), t.clone()));
                }
            }
        }
        Ok(())
    }

    fn variable(&mut self, ty: &Ty) -> Result<ValueId, Error> {
        let ptr: Type<'a> = SpirvType::Ptr { pointee: Box::new(ty.mlir(false)?), storage: String::from("Function") }.into();
        let data = OpData::build("spirv.Variable").with("storage_class", Attribute::dialect("spirv.storage_class", "<Function>"));
        let entry = self.entry.ok_or_else(|| Error(String::from("glsl: a local outside a function")))?;
        let saved = self.rw.ip;
        self.rw.set_start(entry);
        let v = self.create(data, Some(ptr)).unwrap_or_else(|| unreachable!());
        self.rw.ip = saved;
        Ok(v)
    }

    fn put(&mut self, ptr: ValueId, v: ValueId) {
        self.create(OpData::build("spirv.Store").operands(&[ptr, v]), None);
    }

    fn here(&self) -> Result<BlockId, Error> {
        self.rw.ip.map(|ip| ip.block).ok_or_else(|| Error(String::from("glsl: no insertion point")))
    }

    fn fresh(&mut self) -> Result<BlockId, Error> {
        let region = self.rw.body[self.here()?].parent.ok_or_else(|| Error(String::from("glsl: a block outside a region")))?;
        Ok(self.rw.body.add_block(region, &[]))
    }

    fn goto(&mut self, to: BlockId) {
        if !self.dead {
            self.create(OpData::build("spirv.Branch").successors(&[to]), None);
        }
        self.dead = true;
    }

    fn enter(&mut self, b: BlockId) {
        self.rw.set_end(b);
        self.dead = false;
    }

    fn branch_if(&mut self, c: ValueId, yes: BlockId, no: BlockId) -> OpId {
        self.rw.create(OpData::build("spirv.BranchConditional").operands(&[c]).successors(&[yes, no]).segments(&[1, 0, 0]), &[])
    }

    fn jumpy(&self, s: &Stmt<'s>) -> bool {
        (!self.loops.is_empty() && s.leaves_loop()) || s.returns()
    }

    fn pointer(ty: &Ty) -> Result<Type<'a>, Error> {
        Ok(SpirvType::Ptr { pointee: Box::new(ty.mlir(false)?), storage: String::from("Function") }.into())
    }

    fn function(&mut self, ret: &Ty, name: &str, params: &[super::syntax::Param<'s>], body: &[Stmt<'s>]) -> Result<(), Error> {
        let inputs = params.iter().map(|p| if p.qual == ParamQual::In { p.ty.mlir(false) } else { Self::pointer(&p.ty) }).collect::<Result<Vec<_>, _>>()?;
        let results = if *ret == Ty::Void { Vec::new() } else { vec![ret.mlir(false)?] };
        let fty = Type::Function(Box::new(FunctionType { inputs: inputs.clone(), results }));
        let data = OpData::build("func.func").with("sym_name", Attribute::str(name)).with("function_type", Attribute::Type(fty));
        let shader = self.shader;
        let func = self.in_block(shader, |e| {
            Ok(e.rw.create_with(data, &[], |b, op| {
                let r = b.add_region(op);
                b.add_block(r, &inputs.iter().map(|t| (t.clone(), None)).collect::<Vec<_>>());
            }))
        })?;
        self.first_func.get_or_insert(func);
        let entry = self.rw.body.top_block(func);
        self.entry = Some(entry);
        self.ret = ret.clone();
        let saved = self.rw.ip;
        self.enter(entry);
        let mut scope = BTreeMap::new();
        for (k, p) in params.iter().enumerate() {
            let arg = self.rw.body[entry].args[k];
            let slot = match p.qual {
                ParamQual::In => {
                    let slot = self.variable(&p.ty)?;
                    self.put(slot, arg);
                    slot
                }
                ParamQual::Out | ParamQual::InOut => arg,
            };
            scope.insert(p.name, Name::Local(slot, p.ty.clone()));
        }
        self.scopes = vec![scope];
        if name == GlslReader::MAIN {
            for (g, init, ty) in self.inits.clone() {
                let v = self.rvalue_of(&init, &ty)?;
                self.create(OpData::build(crate::GlslStore::NAME).operands(&[v]).with("var", Attribute::SymbolRef(vec![String::from(g).into()])), None);
            }
        }
        self.stmts(body)?;
        if !self.dead {
            if *ret != Ty::Void {
                return Self::err(format!("{name}: a function returning a value must end with return"));
            }
            self.create(OpData::build("func.return"), None);
        }
        self.scopes.clear();
        self.rw.ip = saved;
        self.entry = None;
        for (br, merge) in core::mem::take(&mut self.merges) {
            let region = self.rw.body[merge].parent.ok_or_else(|| Error(String::from("glsl: a merge outside a region")))?;
            let at = self.rw.body[region].blocks.iter().position(|b| *b == merge).ok_or_else(|| Error(String::from("glsl: a lost merge block")))?;
            self.rw.body[br].set(crate::SpirvBinary::SELECTION_MERGE, Attribute::i64(i64::try_from(at).unwrap_or(i64::MAX)));
        }
        Ok(())
    }

    fn stmts(&mut self, stmts: &[Stmt<'s>]) -> Result<(), Error> {
        for s in stmts {
            if self.dead {
                break;
            }
            self.stmt(s)?;
        }
        Ok(())
    }

    fn scoped(&mut self, f: impl FnOnce(&mut Self) -> Result<(), Error>) -> Result<(), Error> {
        self.scopes.push(BTreeMap::new());
        let out = f(self);
        self.scopes.pop();
        out
    }

    fn yield_end(&mut self, block: BlockId) {
        self.in_block(block, |e| {
            e.create(OpData::build("scf.yield"), None);
            Ok(())
        })
        .unwrap_or_else(|_: Error| unreachable!());
    }

    fn stmt(&mut self, s: &Stmt<'s>) -> Result<(), Error> {
        match s {
            Stmt::Decl(ds) => {
                for d in ds {
                    let slot = self.variable(&d.ty)?;
                    if let Some(init) = &d.init {
                        let v = self.rvalue_of(init, &d.ty)?;
                        self.put(slot, v);
                    }
                    self.scopes.last_mut().ok_or_else(|| Error(String::from("glsl: no scope")))?.insert(d.name, Name::Local(slot, d.ty.clone()));
                }
                Ok(())
            }
            Stmt::Expr(e) => self.expr(e).map(|_| ()),
            Stmt::Block(b) => self.scoped(|e| e.stmts(b)),
            Stmt::If(c, a, b) if self.jumpy(s) => {
                let c = self.rvalue_of(c, &Ty::BOOL)?;
                let yes = self.fresh()?;
                let no = match b {
                    Some(_) => Some(self.fresh()?),
                    None => None,
                };
                let join = self.fresh()?;
                let br = self.branch_if(c, yes, no.unwrap_or(join));
                self.merges.push((br, join));
                self.enter(yes);
                self.scoped(|e| e.stmt(a))?;
                self.goto(join);
                if let (Some(no), Some(b)) = (no, b) {
                    self.enter(no);
                    self.scoped(|e| e.stmt(b))?;
                    self.goto(join);
                }
                self.enter(join);
                if !self.flowed_into(join) {
                    self.create(OpData::build("spirv.Unreachable"), None);
                    self.dead = true;
                }
                Ok(())
            }
            Stmt::If(c, a, b) => {
                let c = self.rvalue_of(c, &Ty::BOOL)?;
                let (_, blocks) = self.with_regions(OpData::build("scf.if").operands(&[c]), &[], 2);
                self.in_block(blocks[0], |e| e.scoped(|e| e.stmt(a)))?;
                self.yield_end(blocks[0]);
                if let Some(b) = b {
                    self.in_block(blocks[1], |e| e.scoped(|e| e.stmt(b)))?;
                }
                self.yield_end(blocks[1]);
                Ok(())
            }
            Stmt::While(c, body) => self.lp(None, Some(c), None, body),
            Stmt::For { init, cond, step, body } => self.scoped(|e| {
                if let Some(i) = init {
                    e.stmt(i)?;
                }
                e.lp(None, cond.as_ref(), step.as_ref(), body)
            }),
            Stmt::DoWhile(body, c) => self.lp(Some(body), Some(c), None, &Stmt::Block(Vec::new())),
            Stmt::Discard => {
                if self.stage != GlslStage::Fragment {
                    return Self::err("discard outside a fragment shader");
                }
                self.create(OpData::build(crate::GlslDiscard::NAME), None);
                Ok(())
            }
            Stmt::Return(v, line) => {
                let ret = self.ret.clone();
                match (v, &ret) {
                    (Some(x), t) if *t != Ty::Void => {
                        let v = self.rvalue_of(x, t)?;
                        self.create(OpData::build("spirv.ReturnValue").operands(&[v]), None);
                    }
                    (None, Ty::Void) => {
                        self.create(OpData::build("spirv.Return"), None);
                    }
                    _ => return Self::err(format!("line {line}: return does not match the function's type")),
                }
                self.dead = true;
                Ok(())
            }
            Stmt::Break(line) | Stmt::Continue(line) => {
                let Some(x) = self.loops.last().copied() else { return Self::err(format!("line {line}: break / continue outside a loop")) };
                match (s, self.tests.last().cloned().flatten()) {
                    (Stmt::Break(_), _) => self.goto(x.merge),
                    (_, Some(test)) => self.test_then(&test, x)?,
                    _ => self.goto(x.cont),
                }
                Ok(())
            }
        }
    }

    fn test_then(&mut self, test: &Expr<'s>, exit: Exit) -> Result<(), Error> {
        let c = self.rvalue_of(test, &Ty::BOOL)?;
        self.branch_if(c, exit.cont, exit.merge);
        self.dead = true;
        Ok(())
    }

    fn flowed_into(&self, b: BlockId) -> bool {
        let Some(region) = self.rw.body[b].parent else { return false };
        self.rw.body[region].blocks.iter().filter_map(|blk| self.rw.body.last_op(*blk)).any(|t| self.rw.body[t].successors.contains(&b))
    }

    fn lp(&mut self, first: Option<&Stmt<'s>>, cond: Option<&Expr<'s>>, step: Option<&Expr<'s>>, body: &Stmt<'s>) -> Result<(), Error> {
        if [first, Some(body)].into_iter().flatten().any(|b| b.leaves_loop() || b.returns()) {
            return self.flat_loop(first, cond, step, body);
        }
        let (_, blocks) = self.with_regions(OpData::build("scf.while"), &[], 2);
        self.in_block(blocks[0], |e| {
            if let Some(f) = first {
                e.scoped(|e| e.stmt(f))?;
            }
            let c = match cond {
                Some(c) => e.rvalue_of(c, &Ty::BOOL)?,
                None => e.constant(Scalar::Bool, 1),
            };
            e.create(OpData::build("scf.condition").operands(&[c]), None);
            Ok(())
        })?;
        self.in_block(blocks[1], |e| {
            e.scoped(|e| e.stmt(body))?;
            if let Some(s) = step {
                e.expr(s)?;
            }
            e.create(OpData::build("scf.yield"), None);
            Ok(())
        })
    }

    fn flat_loop(&mut self, first: Option<&Stmt<'s>>, cond: Option<&Expr<'s>>, step: Option<&Expr<'s>>, body: &Stmt<'s>) -> Result<(), Error> {
        let data = OpData::build("spirv.mlir.loop").with("loop_control", Attribute::dialect("spirv.loop_control", "<None>"));
        let op = self.rw.create_with(data, &[], |b, op| {
            let r = b.add_region(op);
            for _ in 0..GlslReader::LOOP_BLOCKS {
                b.add_block(r, &[]);
            }
        });
        let region = self.rw.body[op].regions[0];
        let [entry, header, start, cont, merge]: [BlockId; GlslReader::LOOP_BLOCKS] = self.rw.body[region].blocks[..].try_into().map_err(|_| Error(String::from("glsl: loop blocks")))?;
        let outer = self.rw.ip;
        let outer_dead = self.dead;
        self.enter(entry);
        self.goto(header);
        self.enter(header);
        match (first, cond) {
            (Some(_), _) | (None, None) => self.goto(start),
            (None, Some(c)) => {
                let c = self.rvalue_of(c, &Ty::BOOL)?;
                self.branch_if(c, start, merge);
                self.dead = true;
            }
        }
        let exit = Exit { cont, merge };
        let test = first.and(cond).cloned();
        self.loops.push(exit);
        self.tests.push(test.clone());
        self.enter(start);
        let looped = self.scoped(|e| {
            if let Some(f) = first {
                e.stmt(f)?;
            }
            e.stmt(body)?;
            match &test {
                Some(t) if !e.dead => e.test_then(t, exit),
                _ => Ok(()),
            }
        });
        self.loops.pop();
        self.tests.pop();
        looped?;
        self.goto(cont);
        self.enter(cont);
        if let Some(s) = step {
            self.expr(s)?;
        }
        self.goto(header);
        self.enter(merge);
        self.create(OpData::build("spirv.mlir.merge"), None);
        let blocks = &mut self.rw.body[region].blocks;
        blocks.retain(|b| *b != cont && *b != merge);
        blocks.extend([cont, merge]);
        self.rw.ip = outer;
        self.dead = outer_dead;
        Ok(())
    }

    fn rvalue_of(&mut self, e: &Expr<'s>, want: &Ty) -> Result<ValueId, Error> {
        let (v, t) = self.expr(e)?;
        if t != *want {
            return Self::err(format!("expected {want:?}, found {t:?} in {e:?}"));
        }
        Ok(v)
    }

    fn place(&mut self, e: &Expr<'s>) -> Result<Option<(Place, Option<Vec<u32>>)>, Error> {
        Ok(Some(match e {
            Expr::Var(name, line) => match self.lookup(name) {
                Some(Name::Local(p, t)) => (Place::Local(p, Vec::new(), t), None),
                Some(Name::Global(g, t)) => (Place::Global(g, Vec::new(), t), None),
                Some(Name::Member(g, k, t)) => {
                    let i = self.i32(i64::from(k));
                    (Place::Global(g, vec![i], t), None)
                }
                Some(Name::Block(..) | Name::Const(..)) => return Ok(None),
                None => match BuiltinVar::try_from(*name) {
                    Ok(b) => {
                        let Name::Global(g, t) = self.builtin(name, b)? else { unreachable!() };
                        (Place::Global(g, Vec::new(), t), None)
                    }
                    Err(_) => return Self::err(format!("line {line}: unknown name {name}")),
                },
            },
            Expr::Index(base, i) => {
                let Some((p, None)) = self.place(base)? else { return Ok(None) };
                let Some(elem) = p.ty().element() else { return Self::err(format!("{:?} cannot be indexed", p.ty())) };
                let (i, it) = self.expr(i)?;
                if !matches!(it, Ty::Scalar(Scalar::Int | Scalar::Uint)) {
                    return Self::err("an index must be an int");
                }
                (p.indexed(i, elem), None)
            }
            Expr::Field(base, f, line) => {
                if let Expr::Var(name, _) = &**base
                    && let Some(Name::Block(g, members)) = self.lookup(name)
                {
                    let Some(k) = members.iter().position(|(_, n)| n == f) else { return Self::err(format!("line {line}: no member {f} in {name}")) };
                    let i = self.i32(i64::try_from(k).unwrap_or(i64::MAX));
                    return Ok(Some((Place::Global(g, vec![i], members[k].0.clone()), None)));
                }
                let Some((p, None)) = self.place(base)? else { return Ok(None) };
                match p.ty().clone() {
                    Ty::Struct(d) => {
                        let Some((k, t)) = d.member(f) else { return Self::err(format!("line {line}: no member {f} in struct {}", d.name)) };
                        let t = t.clone();
                        let i = self.i32(i64::from(k));
                        (p.indexed(i, t), None)
                    }
                    Ty::Vec(_, n) => (p, Some(Self::swizzle(f, n)?)),
                    t => return Self::err(format!("line {line}: .{f} on {t:?}")),
                }
            }
            _ => return Ok(None),
        }))
    }

    fn swizzle(f: &str, n: u32) -> Result<Vec<u32>, Error> {
        const SETS: [&str; 3] = ["xyzw", "rgba", "stpq"];
        let set = SETS.iter().find(|s| f.chars().all(|c| s.contains(c))).ok_or_else(|| Error(format!("glsl: bad swizzle .{f}")))?;
        let lanes: Vec<u32> = f.chars().filter_map(|c| set.find(c)).map(|i| u32::try_from(i).unwrap_or(u32::MAX)).collect();
        if lanes.iter().any(|&l| l >= n) || lanes.len() > 4 {
            return Self::err(format!("swizzle .{f} out of range"));
        }
        Ok(lanes)
    }

    fn load(&mut self, p: &Place) -> Result<ValueId, Error> {
        let ty = p.ty().mlir(false)?;
        Ok(match p {
            Place::Local(ptr, ix, t) => {
                let ptr = self.chain(*ptr, ix, t)?;
                self.op("spirv.Load", &[ptr], ty)
            }
            Place::Global(g, ix, _) => {
                let data = OpData::build(crate::GlslLoad::NAME).operands(ix).with("var", Attribute::SymbolRef(vec![g.clone().into()]));
                self.create(data, Some(ty)).unwrap_or_else(|| unreachable!())
            }
        })
    }

    fn chain(&mut self, ptr: ValueId, ix: &[ValueId], t: &Ty) -> Result<ValueId, Error> {
        if ix.is_empty() {
            return Ok(ptr);
        }
        let pty: Type<'a> = SpirvType::Ptr { pointee: Box::new(t.mlir(false)?), storage: String::from("Function") }.into();
        let mut ops = vec![ptr];
        ops.extend_from_slice(ix);
        Ok(self.op("spirv.AccessChain", &ops, pty))
    }

    fn store(&mut self, p: &Place, v: ValueId) -> Result<(), Error> {
        match p {
            Place::Local(ptr, ix, t) => {
                let ptr = self.chain(*ptr, ix, t)?;
                self.create(OpData::build("spirv.Store").operands(&[ptr, v]), None);
            }
            Place::Global(g, ix, _) => {
                let mut ops = vec![v];
                ops.extend_from_slice(ix);
                self.create(OpData::build(crate::GlslStore::NAME).operands(&ops).with("var", Attribute::SymbolRef(vec![g.clone().into()])), None);
            }
        }
        Ok(())
    }

    fn read(&mut self, p: &Place, lanes: Option<&[u32]>) -> Result<(ValueId, Ty), Error> {
        let v = self.load(p)?;
        match lanes {
            None => Ok((v, p.ty().clone())),
            Some(l) => {
                let s = p.ty().scalar().unwrap_or(Scalar::Float);
                Ok((self.shuffle(v, l, s)?, Ty::of(s, u32::try_from(l.len()).unwrap_or(u32::MAX))))
            }
        }
    }

    fn shuffle(&mut self, v: ValueId, lanes: &[u32], s: Scalar) -> Result<ValueId, Error> {
        if let [l] = lanes {
            return Ok(self.extract(v, *l, s));
        }
        let ty = Ty::Vec(s, u32::try_from(lanes.len()).unwrap_or(u32::MAX)).mlir(false)?;
        let mask = Attribute::DenseArray { ty: Type::int(64), values: lanes.iter().map(|l| format!("{l}").into()).collect::<Vec<_>>().into() };
        Ok(self.create(OpData::build("vector.shuffle").operands(&[v, v]).with("mask", mask), Some(ty)).unwrap_or_else(|| unreachable!()))
    }

    fn extract(&mut self, v: ValueId, lane: u32, s: Scalar) -> ValueId {
        let data = OpData::build("vector.extract").operands(&[v]).with("static_position", Attribute::DenseArray { ty: Type::int(64), values: vec![format!("{lane}").into()].into() });
        self.create(data, Some(s.mlir(false))).unwrap_or_else(|| unreachable!())
    }

    fn write(&mut self, p: &Place, lanes: Option<&[u32]>, v: ValueId) -> Result<(), Error> {
        let Some(lanes) = lanes else { return self.store(p, v) };
        let old = self.load(p)?;
        let s = p.ty().scalar().unwrap_or(Scalar::Float);
        let mut cur = old;
        for (k, &l) in lanes.iter().enumerate() {
            let x = if lanes.len() == 1 { v } else { self.extract(v, u32::try_from(k).unwrap_or(u32::MAX), s) };
            let data = OpData::build("vector.insert").operands(&[x, cur]).with("static_position", Attribute::DenseArray { ty: Type::int(64), values: vec![format!("{l}").into()].into() });
            cur = self.create(data, Some(p.ty().mlir(false)?)).unwrap_or_else(|| unreachable!());
        }
        self.store(p, cur)
    }

    fn splat(&mut self, v: ValueId, s: Scalar, n: u32) -> Result<ValueId, Error> {
        if n == 1 {
            return Ok(v);
        }
        let ty = Ty::Vec(s, n).mlir(false)?;
        Ok(self.create(OpData::build(crate::GlslConstruct::NAME).operands(&[v]), Some(ty)).unwrap_or_else(|| unreachable!()))
    }

    fn expr(&mut self, e: &Expr<'s>) -> Result<(ValueId, Ty), Error> {
        match e {
            Expr::Float(v) => Ok((self.float(*v), Ty::FLOAT)),
            Expr::Int(v, s) => Ok((self.constant(*s, *v), Ty::Scalar(*s))),
            Expr::Bool(b) => Ok((self.constant(Scalar::Bool, u32::from(*b)), Ty::BOOL)),
            Expr::Var(name, _) if let Some(Name::Const(init, t)) = self.lookup(name) => {
                let v = self.rvalue_of(&init, &t)?;
                Ok((v, t))
            }
            Expr::Var(..) | Expr::Index(..) | Expr::Field(..) => match self.place(e)? {
                Some((p, lanes)) => self.read(&p, lanes.as_deref()),
                None => self.computed(e),
            },
            Expr::Length(base) => {
                let n = match self.expr(base)?.1 {
                    Ty::Array(_, n) | Ty::Vec(_, n) | Ty::Mat(n, _) => n,
                    t => return Self::err(format!(".length() of {t:?}")),
                };
                Ok((self.constant(Scalar::Int, n), Ty::INT))
            }
            Expr::Unary(op, x) => self.unary(*op, x),
            Expr::Binary(op, a, b) => self.binary(*op, a, b),
            Expr::Assign(op, t, v) => {
                let Some((p, lanes)) = self.place(t)? else { return Self::err(format!("cannot assign to {t:?}")) };
                let (v, vt) = match op {
                    None => self.expr(v)?,
                    Some(op) => {
                        let cur = self.read(&p, lanes.as_deref())?;
                        let rhs = self.expr(v)?;
                        self.arith(*op, cur, rhs)?
                    }
                };
                let target = lanes.as_ref().map_or_else(|| p.ty().clone(), |l| Ty::of(p.ty().scalar().unwrap_or(Scalar::Float), u32::try_from(l.len()).unwrap_or(u32::MAX)));
                if vt != target {
                    return Self::err(format!("assigning {vt:?} to {target:?}"));
                }
                self.write(&p, lanes.as_deref(), v)?;
                Ok((v, vt))
            }
            Expr::Step { inc, post, target } => {
                let Some((p, lanes)) = self.place(target)? else { return Self::err(format!("cannot step {target:?}")) };
                let (old, t) = self.read(&p, lanes.as_deref())?;
                let s = t.scalar().ok_or_else(|| Error(String::from("glsl: ++ / -- on a non-number")))?;
                let one = match s {
                    Scalar::Float => self.float(1.0),
                    _ => self.i32(1),
                };
                let one = self.splat(one, s, t.lanes())?;
                let (new, _) = self.arith(if *inc { BinOp::Add } else { BinOp::Sub }, (old, t.clone()), (one, t.clone()))?;
                self.write(&p, lanes.as_deref(), new)?;
                Ok((if *post { old } else { new }, t))
            }
            Expr::Select(c, a, b) => {
                let c = self.rvalue_of(c, &Ty::BOOL)?;
                if a.pure() && b.pure() {
                    let (a, t) = self.expr(a)?;
                    let b = self.rvalue_of(b, &t)?;
                    let ty = self.ty_of(a);
                    return Ok((self.op("arith.select", &[c, a, b], ty), t));
                }
                self.branch(c, a, b)
            }
            Expr::Comma(a, b) => {
                self.expr(a)?;
                self.expr(b)
            }
            Expr::Call(name, args, line) => self.call(name, args, *line),
            Expr::Ctor(ty, args, _) => self.construct(ty, args),
        }
    }

    fn computed(&mut self, e: &Expr<'s>) -> Result<(ValueId, Ty), Error> {
        match e {
            Expr::Index(base, i) => {
                let (v, t) = self.expr(base)?;
                let (i, _) = self.expr(i)?;
                let Some(elem) = t.element() else { return Self::err(format!("{t:?} cannot be indexed")) };
                let data = OpData::build("vector.extract").operands(&[v, i]).with("static_position", Attribute::DenseArray { ty: Type::int(64), values: vec![format!("{}", i64::MIN).into()].into() });
                match t {
                    Ty::Vec(..) => Ok((self.create(data, Some(elem.mlir(false)?)).unwrap_or_else(|| unreachable!()), elem)),
                    _ => Self::err("indexing a temporary matrix or array is not supported yet"),
                }
            }
            Expr::Field(base, f, _) => {
                let (v, t) = self.expr(base)?;
                match t {
                    Ty::Struct(d) => {
                        let Some((k, mt)) = d.member(f) else { return Self::err(format!("no member {f} in struct {}", d.name)) };
                        let mt = mt.clone();
                        Ok((self.part(v, k, &mt)?, mt))
                    }
                    Ty::Vec(s, n) => {
                        let lanes = Self::swizzle(f, n)?;
                        let v = self.shuffle(v, &lanes, s)?;
                        Ok((v, Ty::of(s, u32::try_from(lanes.len()).unwrap_or(u32::MAX))))
                    }
                    t => Self::err(format!(".{f} on {t:?}")),
                }
            }
            Expr::Var(name, _) => Self::err(format!("{name} is not a value")),
            _ => self.expr(e),
        }
    }

    fn branch(&mut self, c: ValueId, a: &Expr<'s>, b: &Expr<'s>) -> Result<(ValueId, Ty), Error> {
        let block = self.rw.ip;
        let probe = self.with_regions(OpData::build("scf.if").operands(&[c]), &[], 2);
        let (av, t) = self.in_block(probe.1[0], |e| e.expr(a))?;
        let ty = self.ty_of(av);
        self.rw.erase_op(probe.0);
        self.rw.ip = block;
        let (op, blocks) = self.with_regions(OpData::build("scf.if").operands(&[c]), core::slice::from_ref(&ty), 2);
        for (blk, x) in blocks.iter().zip([a, b]) {
            self.in_block(*blk, |e| {
                let v = e.rvalue_of(x, &t)?;
                e.create(OpData::build("scf.yield").operands(&[v]), None);
                Ok(())
            })?;
        }
        Ok((self.rw.body[op].results[0], t))
    }

    fn unary(&mut self, op: UnOp, x: &Expr<'s>) -> Result<(ValueId, Ty), Error> {
        let (v, t) = self.expr(x)?;
        let s = t.scalar().ok_or_else(|| Error(format!("glsl: {op:?} on {t:?}")))?;
        let ty = self.ty_of(v);
        Ok((
            match (op, s) {
                (UnOp::Plus, _) => v,
                (UnOp::Neg, Scalar::Float) if !matches!(t, Ty::Mat(..)) => self.op("arith.negf", &[v], ty),
                (UnOp::Neg, Scalar::Int | Scalar::Uint) => {
                    let z = self.i32(0);
                    let z = self.splat(z, s, t.lanes())?;
                    self.op("arith.subi", &[z, v], ty)
                }
                (UnOp::Not, Scalar::Bool) if t == Ty::BOOL => {
                    let one = self.constant(Scalar::Bool, 1);
                    self.op("arith.xori", &[v, one], ty)
                }
                (UnOp::BitNot, Scalar::Int | Scalar::Uint) => {
                    let m = self.i32(-1);
                    let m = self.splat(m, s, t.lanes())?;
                    self.op("arith.xori", &[v, m], ty)
                }
                _ => return Self::err(format!("{op:?} on {t:?}")),
            },
            t,
        ))
    }

    fn widen(&mut self, a: (ValueId, Ty), b: (ValueId, Ty)) -> Result<(ValueId, ValueId, Ty), Error> {
        Ok(match (&a.1, &b.1) {
            (x, y) if x == y => (a.0, b.0, a.1),
            (Ty::Vec(s, n), Ty::Scalar(t)) if s == t => {
                let w = self.splat(b.0, *t, *n)?;
                (a.0, w, a.1)
            }
            (Ty::Scalar(s), Ty::Vec(t, n)) if s == t => {
                let w = self.splat(a.0, *s, *n)?;
                (w, b.0, b.1)
            }
            (x, y) => return Self::err(format!("mismatched operands {x:?} and {y:?}")),
        })
    }

    fn builtin_call(&mut self, f: Builtin, args: &[ValueId], ty: Type<'a>) -> ValueId {
        self.create(OpData::build(crate::GlslCall::NAME).operands(args).with("func", A::from(f as i64).into()), Some(ty)).unwrap_or_else(|| unreachable!())
    }

    fn arith(&mut self, op: BinOp, a: (ValueId, Ty), b: (ValueId, Ty)) -> Result<(ValueId, Ty), Error> {
        if matches!(a.1, Ty::Mat(..)) || matches!(b.1, Ty::Mat(..)) {
            return match op {
                BinOp::Mul => self.mat_mul(a, b),
                BinOp::Add | BinOp::Sub | BinOp::Div => self.mat_columns(op, a, b),
                _ => Self::err(format!("{op:?} on matrices")),
            };
        }
        let shift = matches!(op, BinOp::Shl | BinOp::Shr);
        let (x, y, t) = if shift && b.1 != a.1 && matches!(b.1, Ty::Scalar(_)) {
            let s = a.1.scalar().unwrap_or(Scalar::Int);
            let w = self.splat(b.0, s, a.1.lanes())?;
            (a.0, w, a.1)
        } else {
            self.widen(a, b)?
        };
        let s = t.scalar().ok_or_else(|| Error(format!("glsl: {op:?} on {t:?}")))?;
        let ty = self.ty_of(x);
        let name = match (op, s) {
            (BinOp::Add, Scalar::Float) => "arith.addf",
            (BinOp::Sub, Scalar::Float) => "arith.subf",
            (BinOp::Mul, Scalar::Float) => "arith.mulf",
            (BinOp::Div, Scalar::Float) => "arith.divf",
            (BinOp::Add, Scalar::Int | Scalar::Uint) => "arith.addi",
            (BinOp::Sub, Scalar::Int | Scalar::Uint) => "arith.subi",
            (BinOp::Mul, Scalar::Int | Scalar::Uint) => "arith.muli",
            (BinOp::Div, Scalar::Int) => "arith.divsi",
            (BinOp::Div, Scalar::Uint) => "arith.divui",
            (BinOp::Rem, Scalar::Int) => "arith.remsi",
            (BinOp::Rem, Scalar::Uint) => "arith.remui",
            (BinOp::BitAnd, Scalar::Int | Scalar::Uint) => "arith.andi",
            (BinOp::BitOr, Scalar::Int | Scalar::Uint) => "arith.ori",
            (BinOp::BitXor, Scalar::Int | Scalar::Uint) => "arith.xori",
            (BinOp::Shl, Scalar::Int | Scalar::Uint) => "arith.shli",
            (BinOp::Shr, Scalar::Int) => "arith.shrsi",
            (BinOp::Shr, Scalar::Uint) => "arith.shrui",
            (BinOp::And, Scalar::Bool) => "arith.andi",
            (BinOp::Or, Scalar::Bool) => "arith.ori",
            (BinOp::Xor, Scalar::Bool) => "arith.xori",
            _ => return self.compare(op, (x, t.clone()), (y, t)),
        };
        Ok((self.op(name, &[x, y], ty), t))
    }

    fn compare(&mut self, op: BinOp, a: (ValueId, Ty), b: (ValueId, Ty)) -> Result<(ValueId, Ty), Error> {
        let (x, y, t) = self.widen(a, b)?;
        let s = t.scalar().ok_or_else(|| Error(format!("glsl: {op:?} on {t:?}")))?;
        let lanes = t.lanes();
        let bty = Ty::of(Scalar::Bool, lanes);
        let pred = match (op, s) {
            (BinOp::Lt, Scalar::Float) => CmpFPredicate::olt as i64,
            (BinOp::Gt, Scalar::Float) => CmpFPredicate::ogt as i64,
            (BinOp::Le, Scalar::Float) => CmpFPredicate::ole as i64,
            (BinOp::Ge, Scalar::Float) => CmpFPredicate::oge as i64,
            (BinOp::Eq, Scalar::Float) => CmpFPredicate::oeq as i64,
            (BinOp::Ne, Scalar::Float) => CmpFPredicate::une as i64,
            (BinOp::Lt, Scalar::Int) => CmpIPredicate::slt as i64,
            (BinOp::Gt, Scalar::Int) => CmpIPredicate::sgt as i64,
            (BinOp::Le, Scalar::Int) => CmpIPredicate::sle as i64,
            (BinOp::Ge, Scalar::Int) => CmpIPredicate::sge as i64,
            (BinOp::Lt, Scalar::Uint) => CmpIPredicate::ult as i64,
            (BinOp::Gt, Scalar::Uint) => CmpIPredicate::ugt as i64,
            (BinOp::Le, Scalar::Uint) => CmpIPredicate::ule as i64,
            (BinOp::Ge, Scalar::Uint) => CmpIPredicate::uge as i64,
            (BinOp::Eq, _) => CmpIPredicate::eq as i64,
            (BinOp::Ne, _) => CmpIPredicate::ne as i64,
            _ => return Self::err(format!("{op:?} on {t:?}")),
        };
        let name = if s == Scalar::Float { "arith.cmpf" } else { "arith.cmpi" };
        let bt = bty.mlir(false)?;
        let v = self.create(OpData::build(name).operands(&[x, y]).with("predicate", Attribute::i64(pred)), Some(bt)).unwrap_or_else(|| unreachable!());
        Ok((v, bty))
    }

    fn not(&mut self, v: ValueId) -> ValueId {
        let one = self.constant(Scalar::Bool, 1);
        self.op("arith.xori", &[v, one], Type::I1)
    }

    fn part(&mut self, v: ValueId, k: u32, ty: &Ty) -> Result<ValueId, Error> {
        let data = OpData::build("spirv.CompositeExtract").operands(&[v]).with("indices", Attribute::Array(vec![Emitter::word(k)]));
        Ok(self.create(data, Some(ty.mlir(false)?)).unwrap_or_else(|| unreachable!()))
    }

    fn equal(&mut self, a: ValueId, b: ValueId, ty: &Ty) -> Result<ValueId, Error> {
        let parts: Vec<Ty> = match ty {
            Ty::Struct(d) => d.members.iter().map(|(t, _)| t.clone()).collect(),
            Ty::Array(e, n) => (0..*n).map(|_| (**e).clone()).collect(),
            Ty::Mat(c, r) => (0..*c).map(|_| Ty::Vec(Scalar::Float, *r)).collect(),
            t => {
                let (v, bt) = self.compare(BinOp::Eq, (a, t.clone()), (b, t.clone()))?;
                return Ok(if bt.lanes() > 1 { self.reduce(v, bt.lanes(), true) } else { v });
            }
        };
        let mut acc = None;
        for (k, t) in parts.iter().enumerate() {
            let k = u32::try_from(k).unwrap_or(u32::MAX);
            let (x, y) = (self.part(a, k, t)?, self.part(b, k, t)?);
            let e = self.equal(x, y, t)?;
            acc = Some(match acc {
                None => e,
                Some(prev) => self.op("arith.andi", &[prev, e], Type::I1),
            });
        }
        acc.ok_or_else(|| Error(String::from("glsl: comparing an empty aggregate")))
    }

    fn reduce(&mut self, v: ValueId, n: u32, all: bool) -> ValueId {
        let mut acc = self.extract(v, 0, Scalar::Bool);
        for l in 1..n {
            let x = self.extract(v, l, Scalar::Bool);
            acc = self.op(if all { "arith.andi" } else { "arith.ori" }, &[acc, x], Type::I1);
        }
        acc
    }

    fn binary(&mut self, op: BinOp, a: &Expr<'s>, b: &Expr<'s>) -> Result<(ValueId, Ty), Error> {
        if matches!(op, BinOp::And | BinOp::Or) && !b.pure() {
            let c = self.rvalue_of(a, &Ty::BOOL)?;
            let (yes, no) = if op == BinOp::And { (b, &Expr::Bool(false)) } else { (&Expr::Bool(true), b) };
            return self.branch(c, yes, no);
        }
        let x = self.expr(a)?;
        let y = self.expr(b)?;
        match op {
            BinOp::Eq | BinOp::Ne if matches!(x.1, Ty::Struct(_) | Ty::Array(..) | Ty::Mat(..)) => {
                if x.1 != y.1 {
                    return Self::err(format!("comparing {:?} with {:?}", x.1, y.1));
                }
                let v = self.equal(x.0, y.0, &x.1)?;
                Ok((if op == BinOp::Eq { v } else { self.not(v) }, Ty::BOOL))
            }
            BinOp::Eq | BinOp::Ne if x.1.lanes() > 1 => {
                let (v, t) = self.compare(op, x, y)?;
                Ok((self.reduce(v, t.lanes(), op == BinOp::Eq), Ty::BOOL))
            }
            BinOp::Lt | BinOp::Gt | BinOp::Le | BinOp::Ge | BinOp::Eq | BinOp::Ne => self.compare(op, x, y),
            _ => self.arith(op, x, y),
        }
    }

    fn mat_mul(&mut self, a: (ValueId, Ty), b: (ValueId, Ty)) -> Result<(ValueId, Ty), Error> {
        let (f, t) = match (&a.1, &b.1) {
            (Ty::Mat(c, r), Ty::Vec(Scalar::Float, n)) if c == n => (Builtin::MatrixTimesVector, Ty::Vec(Scalar::Float, *r)),
            (Ty::Vec(Scalar::Float, n), Ty::Mat(c, r)) if r == n => (Builtin::VectorTimesMatrix, Ty::Vec(Scalar::Float, *c)),
            (Ty::Mat(c, r), Ty::Mat(c2, r2)) if c == r2 => (Builtin::MatrixTimesMatrix, Ty::Mat(*c2, *r)),
            (Ty::Mat(..), Ty::Scalar(Scalar::Float)) => (Builtin::MatrixTimesScalar, a.1.clone()),
            (Ty::Scalar(Scalar::Float), Ty::Mat(..)) => {
                let ty = b.1.mlir(false)?;
                return Ok((self.builtin_call(Builtin::MatrixTimesScalar, &[b.0, a.0], ty), b.1));
            }
            (x, y) => return Self::err(format!("cannot multiply {x:?} by {y:?}")),
        };
        let ty = t.mlir(false)?;
        Ok((self.builtin_call(f, &[a.0, b.0], ty), t))
    }

    fn convert(&mut self, v: ValueId, from: Scalar, to: Scalar, lanes: u32) -> Result<ValueId, Error> {
        let ty = Ty::of(to, lanes).mlir(false)?;
        Ok(match (from, to) {
            (Scalar::Float, Scalar::Float) | (Scalar::Int | Scalar::Uint, Scalar::Int | Scalar::Uint) => v,
            (Scalar::Int, Scalar::Float) => self.op("arith.sitofp", &[v], ty),
            (Scalar::Uint, Scalar::Float) => self.op("arith.uitofp", &[v], ty),
            (Scalar::Float, Scalar::Int) => self.op("arith.fptosi", &[v], ty),
            (Scalar::Float, Scalar::Uint) => self.op("arith.fptoui", &[v], ty),
            (Scalar::Bool, _) => {
                let (one, zero) = match to {
                    Scalar::Float => (self.float(1.0), self.float(0.0)),
                    _ => (self.i32(1), self.i32(0)),
                };
                let one = self.splat(one, to, lanes)?;
                let zero = self.splat(zero, to, lanes)?;
                self.op("arith.select", &[v, one, zero], ty)
            }
            (_, Scalar::Bool) => {
                let zero = match from {
                    Scalar::Float => self.float(0.0),
                    _ => self.i32(0),
                };
                let zero = self.splat(zero, from, lanes)?;
                let t = Ty::of(from, lanes);
                return self.compare(BinOp::Ne, (v, t.clone()), (zero, t)).map(|r| r.0);
            }
        })
    }

    fn components(&mut self, args: &[Expr<'s>], s: Scalar) -> Result<Vec<(ValueId, u32)>, Error> {
        let vals = args.iter().map(|a| self.expr(a)).collect::<Result<Vec<_>, _>>()?;
        self.components_of(&vals, s)
    }

    fn column(&mut self, m: ValueId, k: u32, rows: u32) -> Result<ValueId, Error> {
        let col = Ty::Vec(Scalar::Float, rows).mlir(false)?;
        let data = OpData::build("spirv.CompositeExtract").operands(&[m]).with("indices", Attribute::Array(vec![Emitter::word(k)]));
        Ok(self.create(data, Some(col)).unwrap_or_else(|| unreachable!()))
    }

    fn components_of(&mut self, vals: &[(ValueId, Ty)], s: Scalar) -> Result<Vec<(ValueId, u32)>, Error> {
        let mut parts = Vec::new();
        for (v, t) in vals {
            match *t {
                Ty::Scalar(from) | Ty::Vec(from, _) => {
                    let n = t.lanes();
                    parts.push((self.convert(*v, from, s, n)?, n));
                }
                Ty::Mat(c, r) => {
                    for k in 0..c {
                        let cv = self.column(*v, k, r)?;
                        parts.push((self.convert(cv, Scalar::Float, s, r)?, r));
                    }
                }
                ref t => return Self::err(format!("{t:?} in a constructor")),
            }
        }
        Ok(parts)
    }

    fn matrix(&mut self, cols: &[ValueId], c: u32, r: u32) -> Result<ValueId, Error> {
        let mty = Ty::Mat(c, r).mlir(false)?;
        Ok(self.create(OpData::build(crate::GlslConstruct::NAME).operands(cols), Some(mty)).unwrap_or_else(|| unreachable!()))
    }

    fn vector_of(&mut self, lanes: &[ValueId], s: Scalar) -> Result<ValueId, Error> {
        let ty = Ty::of(s, u32::try_from(lanes.len()).unwrap_or(u32::MAX)).mlir(false)?;
        Ok(match lanes {
            [one] => *one,
            _ => self.create(OpData::build(crate::GlslConstruct::NAME).operands(lanes), Some(ty)).unwrap_or_else(|| unreachable!()),
        })
    }

    fn mat_columns(&mut self, op: BinOp, a: (ValueId, Ty), b: (ValueId, Ty)) -> Result<(ValueId, Ty), Error> {
        let (c, r) = match (&a.1, &b.1) {
            (Ty::Mat(c, r), Ty::Mat(c2, r2)) if (c, r) == (c2, r2) => (*c, *r),
            (Ty::Mat(c, r), Ty::Scalar(Scalar::Float)) | (Ty::Scalar(Scalar::Float), Ty::Mat(c, r)) => (*c, *r),
            (x, y) => return Self::err(format!("{op:?} on {x:?} and {y:?}")),
        };
        let col = Ty::Vec(Scalar::Float, r);
        let side = |e: &mut Self, (v, t): &(ValueId, Ty), k: u32| -> Result<(ValueId, Ty), Error> {
            Ok(match t {
                Ty::Mat(..) => (e.column(*v, k, r)?, col.clone()),
                t => (*v, t.clone()),
            })
        };
        let mut cols = Vec::new();
        for k in 0..c {
            let x = side(self, &a, k)?;
            let y = side(self, &b, k)?;
            cols.push(self.arith(op, x, y)?.0);
        }
        Ok((self.matrix(&cols, c, r)?, Ty::Mat(c, r)))
    }

    fn assemble(&mut self, parts: &[(ValueId, u32)], s: Scalar, n: u32) -> Result<ValueId, Error> {
        let mut flat = Vec::new();
        for &(v, k) in parts {
            if flat.len() >= n as usize {
                break;
            }
            if k == 1 {
                flat.push(v);
            } else if flat.len() + k as usize <= n as usize && parts.iter().map(|p| p.1).sum::<u32>() == n {
                flat.push(v);
            } else {
                for l in 0..k {
                    flat.push(self.extract(v, l, s));
                }
            }
        }
        let have: u32 = flat.iter().map(|&v| match &self.rw.body[v].ty {
            Type::Shaped(sh) => sh.shape.as_ref().and_then(|d| d.first()).map_or(1, |d| match d {
                mlirformat::Dim::Static(n) => u32::try_from(*n).unwrap_or(1),
                _ => 1,
            }),
            _ => 1,
        }).sum();
        if have < n {
            return Self::err(format!("not enough components for a {n}-vector"));
        }
        flat.truncate(flat.len() - (have - n) as usize);
        if n == 1 || (flat.len() == 1 && have == n) {
            return Ok(flat[0]);
        }
        let ty = Ty::Vec(s, n).mlir(false)?;
        Ok(self.create(OpData::build(crate::GlslConstruct::NAME).operands(&flat), Some(ty)).unwrap_or_else(|| unreachable!()))
    }

    fn construct(&mut self, ty: &Ty, args: &[Expr<'s>]) -> Result<(ValueId, Ty), Error> {
        match ty {
            Ty::Scalar(s) | Ty::Vec(s, _) => {
                let parts = self.components(args, *s)?;
                let v = match parts[..] {
                    [(v, 1)] => self.splat(v, *s, ty.lanes())?,
                    _ => self.assemble(&parts, *s, ty.lanes())?,
                };
                Ok((v, ty.clone()))
            }
            Ty::Mat(c, r) => {
                let (c, r) = (*c, *r);
                let vals = args.iter().map(|a| self.expr(a)).collect::<Result<Vec<_>, _>>()?;
                let cols: Vec<ValueId> = match &vals[..] {
                    [(d, Ty::Scalar(from))] => {
                        let d = self.convert(*d, *from, Scalar::Float, 1)?;
                        let z = self.float(0.0);
                        (0..c).map(|k| self.vector_of(&(0..r).map(|l| if l == k { d } else { z }).collect::<Vec<_>>(), Scalar::Float)).collect::<Result<_, _>>()?
                    }
                    [(m, Ty::Mat(c2, r2))] => {
                        let (m, c2, r2) = (*m, *c2, *r2);
                        let (one, zero) = (self.float(1.0), self.float(0.0));
                        let mut cols = Vec::new();
                        for k in 0..c {
                            let src = if k < c2 { Some(self.column(m, k, r2)?) } else { None };
                            let mut lanes = Vec::new();
                            for l in 0..r {
                                lanes.push(match src {
                                    Some(v) if l < r2 => self.extract(v, l, Scalar::Float),
                                    _ if l == k => one,
                                    _ => zero,
                                });
                            }
                            cols.push(self.vector_of(&lanes, Scalar::Float)?);
                        }
                        cols
                    }
                    _ => {
                        let parts = self.components_of(&vals, Scalar::Float)?;
                        let mut scalars = Vec::new();
                        for (v, k) in parts {
                            if k == 1 {
                                scalars.push(v);
                            } else {
                                for l in 0..k {
                                    scalars.push(self.extract(v, l, Scalar::Float));
                                }
                            }
                        }
                        if scalars.len() != (c * r) as usize {
                            return Self::err(format!("mat{c}x{r} takes {} components, got {}", c * r, scalars.len()));
                        }
                        scalars.chunks(r as usize).map(|ch| self.vector_of(ch, Scalar::Float)).collect::<Result<_, _>>()?
                    }
                };
                Ok((self.matrix(&cols, c, r)?, ty.clone()))
            }
            Ty::Array(e, n) => {
                let vals = args.iter().map(|a| self.expr(a)).collect::<Result<Vec<_>, _>>()?;
                if vals.len() != *n as usize || vals.iter().any(|(_, t)| t != &**e) {
                    return Self::err(format!("{ty:?} takes {n} values of {e:?}"));
                }
                let parts: Vec<ValueId> = vals.iter().map(|v| v.0).collect();
                let aty = ty.mlir(false)?;
                Ok((self.create(OpData::build("spirv.CompositeConstruct").operands(&parts), Some(aty)).unwrap_or_else(|| unreachable!()), ty.clone()))
            }
            Ty::Struct(d) => {
                let vals = args.iter().map(|a| self.expr(a)).collect::<Result<Vec<_>, _>>()?;
                if vals.len() != d.members.len() || vals.iter().zip(&d.members).any(|((_, t), (m, _))| t != m) {
                    return Self::err(format!("{}(...) takes {:?}", d.name, d.members.iter().map(|m| &m.0).collect::<Vec<_>>()));
                }
                let parts: Vec<ValueId> = vals.iter().map(|v| v.0).collect();
                let sty = ty.mlir(false)?;
                Ok((self.create(OpData::build("spirv.CompositeConstruct").operands(&parts), Some(sty)).unwrap_or_else(|| unreachable!()), ty.clone()))
            }
            t => Self::err(format!("constructing {t:?} is not supported yet")),
        }
    }

    fn const_ints(&self, e: &Expr<'s>) -> Option<Vec<i64>> {
        match e {
            Expr::Int(v, Scalar::Int) => Some(vec![i64::from(*v as i32)]),
            Expr::Unary(UnOp::Neg, x) => Some(self.const_ints(x)?.into_iter().map(|v| -v).collect()),
            Expr::Unary(UnOp::Plus, x) => self.const_ints(x),
            Expr::Var(name, _) => match self.lookup(name)? {
                Name::Const(init, _) => self.const_ints(&init),
                _ => None,
            },
            Expr::Ctor(ty @ (Ty::Vec(Scalar::Int, _) | Ty::Scalar(Scalar::Int)), args, _) => {
                let parts = args.iter().map(|a| self.const_ints(a)).collect::<Option<Vec<_>>>()?;
                let n = ty.lanes() as usize;
                Some(match &parts[..] {
                    [one] if one.len() == 1 => vec![one[0]; n],
                    _ => parts.into_iter().flatten().take(n).collect(),
                })
            }
            _ => None,
        }
    }

    fn const_offset(&mut self, e: &Expr<'s>, line: u32) -> Result<(ValueId, Ty), Error> {
        let Some(vals) = self.const_ints(e) else { return Self::err(format!("line {line}: a texture offset must be a constant integer expression")) };
        let n = u32::try_from(vals.len()).unwrap_or(u32::MAX);
        let t = Ty::of(Scalar::Int, n);
        if let [v] = vals[..] {
            return Ok((self.i32(v), t));
        }
        let ty = t.mlir(false)?;
        let values = vals.iter().map(|&v| Lit::Int(ApInt::from_bits(Ty::WORD, u128::from(v as i32 as u32)))).collect();
        let value: Attribute<'a> = Const { ty: ty.clone(), values, elements: true }.into();
        Ok((self.create(OpData::build("arith.constant").with("value", value), Some(ty)).unwrap_or_else(|| unreachable!()), t))
    }

    fn call(&mut self, name: &'s str, args: &[Expr<'s>], line: u32) -> Result<(ValueId, Ty), Error> {
        if let Some(list) = self.funcs.get(name) {
            let cands: Vec<Signature> = list.iter().filter(|s| s.params.len() == args.len()).cloned().collect();
            let mut vals = Vec::new();
            for (i, a) in args.iter().enumerate() {
                let by_ref = cands.iter().any(|c| c.params[i].0 != ParamQual::In);
                vals.push(match (by_ref, self.place(a)?) {
                    (true, Some((p, lanes))) => {
                        let ty = lanes.as_ref().map_or_else(|| p.ty().clone(), |l| Ty::of(p.ty().scalar().unwrap_or(Scalar::Float), u32::try_from(l.len()).unwrap_or(u32::MAX)));
                        Arg::Place(p, lanes, ty)
                    }
                    (_, Some((p, lanes))) => {
                        let (v, t) = self.read(&p, lanes.as_deref())?;
                        Arg::Value(v, t)
                    }
                    (_, None) => {
                        let (v, t) = self.expr(a)?;
                        Arg::Value(v, t)
                    }
                });
            }
            let fits = |c: &Signature| c.params.iter().zip(&vals).all(|((q, t), a)| t == a.ty() && (*q == ParamQual::In || matches!(a, Arg::Place(..))));
            let Some(sig) = cands.iter().find(|c| fits(c)).cloned() else {
                return Self::err(format!("line {line}: no {name} takes {:?}", vals.iter().map(Arg::ty).collect::<Vec<_>>()));
            };
            let mut operands = Vec::new();
            let mut back = Vec::new();
            for ((q, t), a) in sig.params.iter().zip(&vals) {
                match (q, a) {
                    (ParamQual::In, Arg::Value(v, _)) => operands.push(*v),
                    (ParamQual::In, Arg::Place(p, lanes, _)) => operands.push(self.read(p, lanes.as_deref())?.0),
                    (_, Arg::Place(p, lanes, _)) => {
                        let tmp = self.variable(t)?;
                        if *q == ParamQual::InOut {
                            let (v, _) = self.read(p, lanes.as_deref())?;
                            self.put(tmp, v);
                        }
                        operands.push(tmp);
                        back.push((tmp, p.clone(), lanes.clone(), t.clone()));
                    }
                    (_, Arg::Value(..)) => return Self::err(format!("line {line}: an out argument of {name} must be assignable")),
                }
            }
            let results = if sig.ret == Ty::Void { Vec::new() } else { vec![sig.ret.mlir(false)?] };
            let op = self.rw.create(OpData::build("func.call").operands(&operands).with("callee", Attribute::SymbolRef(vec![sig.symbol.clone().into()])), &results);
            let v = self.rw.body[op].results.first().copied();
            for (tmp, p, lanes, t) in back {
                let ty = t.mlir(false)?;
                let v = self.op("spirv.Load", &[tmp], ty);
                self.write(&p, lanes.as_deref(), v)?;
            }
            return match v {
                Some(v) => Ok((v, sig.ret)),
                None => Ok((self.constant(Scalar::Bool, 0), Ty::Void)),
            };
        }
        let Ok(f) = Func::try_from(name) else { return Self::err(format!("line {line}: unknown function {name}")) };
        let offset_at = f.offset_at();
        let mut vals = Vec::new();
        for (i, a) in args.iter().enumerate() {
            vals.push(if Some(i) == offset_at { self.const_offset(a, line)? } else { self.expr(a)? });
        }
        self.intrinsic(f, vals, line)
    }

    fn same(&mut self, f: Builtin, vals: &[(ValueId, Ty)]) -> Result<(ValueId, Ty), Error> {
        let t = vals.iter().map(|v| v.1.clone()).max_by_key(Ty::lanes).ok_or_else(|| Error(String::from("glsl: no arguments")))?;
        let s = t.scalar().unwrap_or(Scalar::Float);
        let mut args = Vec::new();
        for (v, vt) in vals {
            args.push(match vt {
                Ty::Scalar(x) if t.lanes() > 1 && *x == s => self.splat(*v, s, t.lanes())?,
                x if *x == t => *v,
                x => return Self::err(format!("{f:?}: argument {x:?} does not match {t:?}")),
            });
        }
        let ty = t.mlir(false)?;
        Ok((self.builtin_call(f, &args, ty), t))
    }

    fn intrinsic(&mut self, f: Func, vals: Vec<(ValueId, Ty)>, line: u32) -> Result<(ValueId, Ty), Error> {
        let first = vals.first().map(|v| v.1.clone()).unwrap_or(Ty::Void);
        let s = first.scalar();
        let float = s == Some(Scalar::Float);
        let scalar_of = |t: &Ty| Ty::Scalar(t.scalar().unwrap_or(Scalar::Float));
        Ok(match (f, &vals[..]) {
            (Func::Unary(b), [_]) if float => self.same(b, &vals)?,
            (Func::Binary(b), [_, _]) if float => self.same(b, &vals)?,
            (Func::Abs, [_]) => self.same(Builtin::Abs, &vals)?,
            (Func::Sign, [_]) => self.same(Builtin::Sign, &vals)?,
            (Func::Atan, [_]) if float => self.same(Builtin::Atan, &vals)?,
            (Func::Atan, [_, _]) if float => self.same(Builtin::Atan2, &vals)?,
            (Func::Min, [_, _]) => self.same(if s == Some(Scalar::Uint) { Builtin::UMin } else { Builtin::Min }, &vals)?,
            (Func::Max, [_, _]) => self.same(if s == Some(Scalar::Uint) { Builtin::UMax } else { Builtin::Max }, &vals)?,
            (Func::Clamp, [_, _, _]) => self.same(if s == Some(Scalar::Uint) { Builtin::UClamp } else { Builtin::Clamp }, &vals)?,
            (Func::Mix, [x, y, (a, Ty::Scalar(Scalar::Bool) | Ty::Vec(Scalar::Bool, _))]) => {
                let ty = self.ty_of(x.0);
                (self.op("arith.select", &[*a, y.0, x.0], ty), x.1.clone())
            }
            (Func::Mix, [_, _, _]) if float => self.same(Builtin::Mix, &vals)?,
            (Func::Step, [_, _]) if float => self.same(Builtin::Step, &vals)?,
            (Func::Smoothstep, [_, _, _]) if float => self.same(Builtin::Smoothstep, &vals)?,
            (Func::IsNan | Func::IsInf, [(v, t)]) if float => {
                let bt = Ty::of(Scalar::Bool, t.lanes());
                let ty = bt.mlir(false)?;
                (self.builtin_call(if f == Func::IsNan { Builtin::IsNan } else { Builtin::IsInf }, &[*v], ty), bt)
            }
            (Func::Length, [(v, t)]) if float => (self.builtin_call(Builtin::Length, &[*v], Type::Float(FloatKind::F32)), scalar_of(t)),
            (Func::Dot, [(a, Ty::Scalar(Scalar::Float)), (b, Ty::Scalar(Scalar::Float))]) => (self.op("arith.mulf", &[*a, *b], Type::Float(FloatKind::F32)), Ty::FLOAT),
            (Func::Distance | Func::Dot, [(a, ta), (b, tb)]) if float && ta == tb => {
                let b_ = if f == Func::Dot { Builtin::Dot } else { Builtin::Distance };
                (self.builtin_call(b_, &[*a, *b], Type::Float(FloatKind::F32)), Ty::FLOAT)
            }
            (Func::Cross, [_, _]) => self.same(Builtin::Cross, &vals)?,
            (Func::Normalize, [_]) if float => self.same(Builtin::Normalize, &vals)?,
            (Func::Reflect, [_, _]) => self.same(Builtin::Reflect, &vals)?,
            (Func::Faceforward, [_, _, _]) => self.same(Builtin::Faceforward, &vals)?,
            (Func::Refract, [(i, t), (n, _), (eta, Ty::Scalar(Scalar::Float))]) => {
                let ty = t.mlir(false)?;
                (self.builtin_call(Builtin::Refract, &[*i, *n, *eta], ty), t.clone())
            }
            (Func::MatrixCompMult, [a @ (_, Ty::Mat(..)), b]) if a.1 == b.1 => {
                let Ty::Mat(c, r) = a.1 else { unreachable!() };
                let mut cols = Vec::new();
                for k in 0..c {
                    let x = self.column(a.0, k, r)?;
                    let y = self.column(b.0, k, r)?;
                    let col = Ty::Vec(Scalar::Float, r);
                    cols.push(self.arith(BinOp::Mul, (x, col.clone()), (y, col))?.0);
                }
                (self.matrix(&cols, c, r)?, a.1.clone())
            }
            (Func::Transpose, [(m, Ty::Mat(c, r))]) => {
                let t = Ty::Mat(*r, *c);
                let ty = t.mlir(false)?;
                (self.builtin_call(Builtin::Transpose, &[*m], ty), t)
            }
            (Func::Determinant, [(m, Ty::Mat(c, r))]) if c == r => (self.builtin_call(Builtin::Determinant, &[*m], Type::Float(FloatKind::F32)), Ty::FLOAT),
            (Func::Inverse, [(m, t @ Ty::Mat(c, r))]) if c == r => {
                let ty = t.mlir(false)?;
                (self.builtin_call(Builtin::Inverse, &[*m], ty), t.clone())
            }
            (Func::OuterProduct, [(a, Ty::Vec(Scalar::Float, r)), (b, Ty::Vec(Scalar::Float, c))]) => {
                let t = Ty::Mat(*c, *r);
                let ty = t.mlir(false)?;
                (self.builtin_call(Builtin::OuterProduct, &[*a, *b], ty), t)
            }
            (Func::Compare(op), [a, b]) if a.1.lanes() > 1 => self.compare(op, a.clone(), b.clone())?,
            (Func::Any | Func::All, [(v, Ty::Vec(Scalar::Bool, n))]) => (self.reduce(*v, *n, f == Func::All), Ty::BOOL),
            (Func::Not, [(v, t @ Ty::Vec(Scalar::Bool, n))]) => {
                let one = self.constant(Scalar::Bool, 1);
                let ones = self.splat(one, Scalar::Bool, *n)?;
                let ty = t.mlir(false)?;
                (self.op("arith.xori", &[*v, ones], ty), t.clone())
            }
            (Func::Sample { lod, offset, proj }, [(sm, Ty::Sampler(s, dim, shadow)), (p, pt), rest @ ..]) => {
                let n = dim.coordinates();
                let (p, dref) = &match (proj, *shadow, pt) {
                    (false, false, _) => (*p, None),
                    (true, false, Ty::Vec(Scalar::Float, Func::PROJ_VEC4)) if n + 1 < Func::PROJ_VEC4 => {
                        let lanes: Vec<u32> = (0..n).chain([Func::PROJ_VEC4 - 1]).collect();
                        (self.shuffle(*p, &lanes, Scalar::Float)?, None)
                    }
                    (true, false, _) => (*p, None),
                    (false, true, Ty::Vec(Scalar::Float, m)) if *m == n + 1 => {
                        let coord: Vec<u32> = (0..n).collect();
                        (self.shuffle(*p, &coord, Scalar::Float)?, Some(self.extract(*p, n, Scalar::Float)))
                    }
                    (true, true, Ty::Vec(Scalar::Float, Func::PROJ_VEC4)) if n + 2 == Func::PROJ_VEC4 => {
                        let lanes: Vec<u32> = (0..n).chain([Func::PROJ_VEC4 - 1]).collect();
                        (self.shuffle(*p, &lanes, Scalar::Float)?, Some(self.extract(*p, n, Scalar::Float)))
                    }
                    (_, true, t) => return Self::err(format!("line {line}: a shadow lookup on {dim:?} takes vec{}, not {t:?}", n + 1 + u32::from(proj))),
                };
                let (lod_args, off) = match (lod, offset, rest) {
                    (Lod::Implicit, true, [o, tail @ ..]) => (tail, Some(o)),
                    (Lod::Implicit, false, tail) => (tail, None),
                    (_, true, [args @ .., o]) => (args, Some(o)),
                    (_, false, args) => (args, None),
                    (_, true, []) => return Self::err(format!("line {line}: a texture offset is missing")),
                };
                let lod = match (lod, lod_args.len()) {
                    (Lod::Implicit, 0) => Lod::Implicit,
                    (Lod::Implicit, 1) if self.stage == GlslStage::Fragment => Lod::Bias,
                    (Lod::Explicit, 1) => Lod::Explicit,
                    (Lod::Grad, 2) => Lod::Grad,
                    _ => return Self::err(format!("line {line}: a texture call with {} level arguments", lod_args.len())),
                };
                let t = if *shadow { Ty::FLOAT } else { Ty::Vec(*s, 4) };
                let ty = t.mlir(false)?;
                let mut ops = vec![*sm, *p];
                ops.extend(*dref);
                ops.extend(lod_args.iter().map(|r| r.0));
                ops.extend(off.map(|o| o.0));
                let mut data = OpData::build(crate::GlslTexture::NAME).operands(&ops).with("lod", A::from(lod as i64).into());
                if dref.is_some() {
                    data = data.with("dref", Attribute::Unit);
                }
                if offset {
                    data = data.with("offset", Attribute::Unit);
                }
                if proj {
                    data = data.with("proj", Attribute::Unit);
                }
                (self.create(data, Some(ty)).unwrap_or_else(|| unreachable!()), t)
            }
            (Func::Fetch { offset }, [(sm, Ty::Sampler(s, _, false)), (p, _), (l, Ty::Scalar(Scalar::Int)), rest @ ..]) if rest.len() == usize::from(offset) => {
                let t = Ty::Vec(*s, 4);
                let ty = t.mlir(false)?;
                let mut ops = vec![*sm, *p, *l];
                ops.extend(rest.iter().map(|r| r.0));
                let mut data = OpData::build(crate::GlslTexelFetch::NAME).operands(&ops);
                if offset {
                    data = data.with("offset", Attribute::Unit);
                }
                (self.create(data, Some(ty)).unwrap_or_else(|| unreachable!()), t)
            }
            (Func::Size, [(sm, Ty::Sampler(_, dim, _)), (l, Ty::Scalar(Scalar::Int))]) => {
                let t = Ty::Vec(Scalar::Int, dim.size_lanes());
                let ty = t.mlir(false)?;
                (self.create(OpData::build(crate::GlslTextureSize::NAME).operands(&[*sm, *l]), Some(ty)).unwrap_or_else(|| unreachable!()), t)
            }
            (Func::Derivative(d), [(v, t)]) if float => {
                let ty = t.mlir(false)?;
                (self.create(OpData::build(crate::GlslDeriv::NAME).operands(&[*v]).with("kind", A::from(d as i64).into()), Some(ty)).unwrap_or_else(|| unreachable!()), t.clone())
            }
            (Func::BitsToFloat, [(v, t)]) if matches!(s, Some(Scalar::Int | Scalar::Uint)) => {
                let out = Ty::of(Scalar::Float, t.lanes());
                let ty = out.mlir(false)?;
                (self.op("arith.bitcast", &[*v], ty), out)
            }
            (Func::FloatBitsTo(to), [(v, t)]) if float => {
                let out = Ty::of(to, t.lanes());
                let ty = out.mlir(false)?;
                (self.op("arith.bitcast", &[*v], ty), out)
            }
            (f, _) => return Self::err(format!("line {line}: {f:?} on {:?} is not supported yet", vals.iter().map(|v| &v.1).collect::<Vec<_>>())),
        })
    }
}
