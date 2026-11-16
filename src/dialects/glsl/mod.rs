mod emit;
mod lex;
mod syntax;

pub use emit::GlslReader;

use alloc::vec::Vec;

use mlirformat::{Attribute, Region, Type, Value};
use serde::{Deserialize, Serialize};

use crate::OpRows;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct GlslDialect;

impl mlirformat::Dialect for GlslDialect {
    fn namespace(&self) -> &'static str {
        "glsl"
    }

    fn ops(&self) -> Vec<mlirformat::Template> {
        GlslOps.ops()
    }

    fn op_infos(&self) -> Vec<mlirformat::OpInfo> {
        OpRows::of(&self.ops(), GlslDialect::INHERENT)
    }
}

impl GlslDialect {
    pub const INHERENT: &[(&str, &[&str])] = &[
        ("glsl.shader", &["stage", "version", "es"]),
        ("glsl.global", &["sym_name", "ty", "storage", "location", "binding", "interpolation", "centroid", "invariant", "precision", "builtin"]),
        ("glsl.load", &["var"]),
        ("glsl.store", &["var"]),
        ("glsl.construct", &[]),
        ("glsl.builtin", &["func"]),
        ("glsl.derivative", &["kind"]),
        ("glsl.texture", &["lod", "offset", "proj"]),
        ("glsl.texel_fetch", &["offset"]),
        ("glsl.texture_size", &[]),
        ("glsl.discard", &[]),
    ];
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum GlslStage {
    Vertex,
    Fragment,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Storage {
    In,
    Out,
    Uniform,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Interpolation {
    Smooth,
    Flat,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Precision {
    Lowp,
    Mediump,
    Highp,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum BuiltinVar {
    Position,
    PointSize,
    VertexId,
    InstanceId,
    FragCoord,
    FrontFacing,
    PointCoord,
    FragDepth,
    FragColor,
    FragData,
}

impl BuiltinVar {
    pub const ALL: [BuiltinVar; 10] = [
        BuiltinVar::Position,
        BuiltinVar::PointSize,
        BuiltinVar::VertexId,
        BuiltinVar::InstanceId,
        BuiltinVar::FragCoord,
        BuiltinVar::FrontFacing,
        BuiltinVar::PointCoord,
        BuiltinVar::FragDepth,
        BuiltinVar::FragColor,
        BuiltinVar::FragData,
    ];

    pub const fn glsl(self) -> &'static str {
        match self {
            BuiltinVar::Position => "gl_Position",
            BuiltinVar::PointSize => "gl_PointSize",
            BuiltinVar::VertexId => "gl_VertexID",
            BuiltinVar::InstanceId => "gl_InstanceID",
            BuiltinVar::FragCoord => "gl_FragCoord",
            BuiltinVar::FrontFacing => "gl_FrontFacing",
            BuiltinVar::PointCoord => "gl_PointCoord",
            BuiltinVar::FragDepth => "gl_FragDepth",
            BuiltinVar::FragColor => "gl_FragColor",
            BuiltinVar::FragData => "gl_FragData",
        }
    }
}

impl TryFrom<&str> for BuiltinVar {
    type Error = mlirformat::Error;

    fn try_from(name: &str) -> Result<Self, Self::Error> {
        BuiltinVar::ALL.into_iter().find(|b| b.glsl() == name).ok_or_else(|| mlirformat::Error(alloc::format!("{name} is not a GLSL built-in variable")))
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "snake_case")]
pub enum Builtin {
    Radians,
    Degrees,
    Sin,
    Cos,
    Tan,
    Asin,
    Acos,
    Atan,
    Atan2,
    Sinh,
    Cosh,
    Tanh,
    Asinh,
    Acosh,
    Atanh,
    Exp,
    Log,
    Exp2,
    Log2,
    Sqrt,
    InverseSqrt,
    Abs,
    Floor,
    Trunc,
    Round,
    RoundEven,
    Ceil,
    Min,
    Max,
    UMin,
    UMax,
    UClamp,
    Pow,
    Sign,
    Fract,
    Mod,
    Clamp,
    Mix,
    Step,
    Smoothstep,
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
    MatrixTimesMatrix,
    MatrixTimesVector,
    VectorTimesMatrix,
    MatrixTimesScalar,
    PackSnorm2x16,
    UnpackSnorm2x16,
    PackUnorm2x16,
    UnpackUnorm2x16,
    PackHalf2x16,
    UnpackHalf2x16,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Derivative {
    Dfdx,
    Dfdy,
    Fwidth,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Lod {
    Implicit,
    Bias,
    Explicit,
    Grad,
}

impl Lod {
    pub const fn operands(self) -> usize {
        match self {
            Lod::Implicit => 0,
            Lod::Bias | Lod::Explicit => 1,
            Lod::Grad => 2,
        }
    }
}

#[mlirformat::mlir::op("glsl.shader", format = "$stage attr-dict-with-keyword $body")]
pub struct GlslShader<'a> {
    pub stage: GlslStage,
    pub version: u32,
    pub es: bool,
    pub body: Region<'a>,
}

#[mlirformat::mlir::op("glsl.global", format = "$storage $sym_name `:` $ty attr-dict")]
pub struct GlslGlobal<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    #[attr]
    pub ty: Type<'a>,
    pub storage: Storage,
    pub location: Option<u32>,
    pub binding: Option<u32>,
    pub interpolation: Option<Interpolation>,
    pub centroid: bool,
    pub invariant: bool,
    pub precision: Option<Precision>,
    pub builtin: Option<BuiltinVar>,
}

#[mlirformat::mlir::op("glsl.load", format = "$var (`[` $indices^ `:` type($indices) `]`)? attr-dict `:` type($result)", results(result))]
pub struct GlslLoad<'a> {
    pub var: Attribute<'a>,
    #[slot(index_types)]
    pub indices: Vec<Value<'a>>,
    pub index_types: Vec<Type<'a>>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("glsl.store", format = "$value `,` $var (`[` $indices^ `:` type($indices) `]`)? attr-dict `:` type($value)")]
pub struct GlslStore<'a> {
    #[slot(ty)]
    pub value: Value<'a>,
    pub var: Attribute<'a>,
    #[slot(index_types)]
    pub indices: Vec<Value<'a>>,
    pub index_types: Vec<Type<'a>>,
    pub ty: Type<'a>,
}

#[mlirformat::mlir::op("glsl.construct", format = "`(` $parts `:` type($parts) `)` attr-dict `->` type($result)", results(result))]
pub struct GlslConstruct<'a> {
    #[slot(part_types)]
    pub parts: Vec<Value<'a>>,
    pub part_types: Vec<Type<'a>>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("glsl.builtin", format = "$func $args attr-dict `:` type($args) `->` type($result)", results(result))]
pub struct GlslCall<'a> {
    pub func: Builtin,
    #[slot(arg_types)]
    pub args: Vec<Value<'a>>,
    pub arg_types: Vec<Type<'a>>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("glsl.derivative", format = "$kind $value attr-dict `:` type($value)", results(result))]
pub struct GlslDeriv<'a> {
    pub kind: Derivative,
    #[slot(result)]
    pub value: Value<'a>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op(
    "glsl.texture",
    format = "$lod $sampler `,` $coord (`,` $extras^ `:` type($extras))? attr-dict `:` type($sampler) `,` type($coord) `->` type($result)",
    results(result)
)]
pub struct GlslTexture<'a> {
    pub lod: Lod,
    pub offset: bool,
    pub proj: bool,
    #[slot(sampler_ty)]
    pub sampler: Value<'a>,
    #[slot(coord_ty)]
    pub coord: Value<'a>,
    #[slot(extra_types)]
    pub extras: Vec<Value<'a>>,
    pub sampler_ty: Type<'a>,
    pub coord_ty: Type<'a>,
    pub extra_types: Vec<Type<'a>>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op(
    "glsl.texel_fetch",
    format = "$sampler `,` $coord `,` $level (`,` $extras^ `:` type($extras))? attr-dict `:` type($sampler) `,` type($coord) `,` type($level) `->` type($result)",
    results(result)
)]
pub struct GlslTexelFetch<'a> {
    pub offset: bool,
    #[slot(sampler_ty)]
    pub sampler: Value<'a>,
    #[slot(coord_ty)]
    pub coord: Value<'a>,
    #[slot(level_ty)]
    pub level: Value<'a>,
    #[slot(extra_types)]
    pub extras: Vec<Value<'a>>,
    pub sampler_ty: Type<'a>,
    pub coord_ty: Type<'a>,
    pub level_ty: Type<'a>,
    pub extra_types: Vec<Type<'a>>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("glsl.texture_size", format = "$sampler `,` $level attr-dict `:` type($sampler) `,` type($level) `->` type($result)", results(result))]
pub struct GlslTextureSize<'a> {
    #[slot(sampler_ty)]
    pub sampler: Value<'a>,
    #[slot(level_ty)]
    pub level: Value<'a>,
    pub sampler_ty: Type<'a>,
    pub level_ty: Type<'a>,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("glsl.discard", format = "attr-dict")]
pub struct GlslDiscard {}

#[mlirformat::mlir::dialect("glsl", ops = [GlslShader, GlslGlobal, GlslLoad, GlslStore, GlslConstruct, GlslCall, GlslDeriv, GlslTexture, GlslTexelFetch, GlslTextureSize, GlslDiscard])]
struct GlslOps;
