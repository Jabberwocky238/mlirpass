//! The `nvgpu` types, read from their printed parameters, and their LLVM forms
//! (`ConvertNVGPUToNVVMPass`'s type conversions).

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, FloatKind, MlirOpt, Parser, Shaped, ShapedKind, Type};

use crate::{GpuAddressSpace, LlvmConverter, LlvmOptions, TypeConverter};

/// `kWgmmaSizeM`: the rows one wgmma instruction covers.
pub const WGMMA_SIZE_M: i64 = 64;

/// `nvgpu::TensorMapSwizzleKind`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Swizzle {
    None = 0,
    B32 = 1,
    B64 = 2,
    B128 = 3,
}

/// `nvgpu::TensorMap{Swizzle,L2Promo,OOB,Interleave}Kind` spellings with their values.
const SWIZZLES: [(&str, Swizzle); 4] = [("none", Swizzle::None), ("swizzle_32b", Swizzle::B32), ("swizzle_64b", Swizzle::B64), ("swizzle_128b", Swizzle::B128)];
const L2PROMOS: [(&str, i64); 4] = [("none", 0), ("l2promo_64b", 1), ("l2promo_128b", 2), ("l2promo_256b", 3)];
const OOBS: [(&str, i64); 2] = [("zero", 0), ("nan", 1)];
const INTERLEAVES: [(&str, i64); 3] = [("none", 0), ("interleave_16b", 1), ("interleave_32b", 2)];

/// An `nvgpu` type.
#[derive(Debug, Clone, PartialEq)]
pub enum NvgpuType<'a> {
    DeviceAsyncToken,
    MbarrierToken,
    MbarrierGroup { shared: bool, barriers: i64 },
    WarpgroupAccumulator { fragmented: Type<'a> },
    WarpgroupDescriptor { tensor: Type<'a> },
    TensorMap { tensor: Type<'a>, swizzle: Swizzle, l2promo: i64, oob: i64, interleave: i64 },
}

/// The `key = value` parameters of a type body, split at top-level commas.
fn params(body: &str) -> Vec<(&str, &str)> {
    let body = body.trim().strip_prefix('<').and_then(|b| b.strip_suffix('>')).unwrap_or("");
    let (mut out, mut depth, mut start) = (Vec::new(), 0i32, 0);
    for (i, c) in body.char_indices() {
        match c {
            '<' | '(' | '[' | '{' => depth += 1,
            '>' | ')' | ']' | '}' => depth -= 1,
            ',' if depth == 0 => {
                out.extend(body[start..i].split_once('=').map(|(k, v)| (k.trim(), v.trim())));
                start = i + 1;
            }
            _ => {}
        }
    }
    out.extend(body[start..].split_once('=').map(|(k, v)| (k.trim(), v.trim())));
    out
}

fn ty(src: &str, opt: &MlirOpt) -> Option<Type<'static>> {
    Parser::new(src, opt).ty().ok().map(|t| t.owned())
}

fn pick<T: Copy>(table: &[(&str, T)], v: Option<&str>, default: T) -> Option<T> {
    match v {
        None => Some(default),
        Some(v) => table.iter().find(|(n, _)| *n == v).map(|(_, t)| *t),
    }
}

impl NvgpuType<'static> {
    /// `t` as an `nvgpu` type; `None` for any other type.
    pub fn parse(t: &Type<'_>, opt: &MlirOpt) -> Option<Self> {
        let Type::Extended(ext) = t else { return None };
        let ps = params(ext.body.as_deref().unwrap_or(""));
        let get = |k: &str| ps.iter().find(|(n, _)| *n == k).map(|(_, v)| *v);
        Some(match &*ext.name {
            "nvgpu.device.async.token" => NvgpuType::DeviceAsyncToken,
            "nvgpu.mbarrier.token" => NvgpuType::MbarrierToken,
            "nvgpu.mbarrier.group" => {
                // `NVGPUDialect::isSharedMemoryAddressSpace`: 3 or `#gpu.address_space<workgroup>`.
                let shared = get("memorySpace").is_some_and(|m| {
                    let a = Parser::new(m, opt).attr().ok();
                    match a {
                        Some(Attribute::Int { lit, .. }) => lit == "3",
                        Some(a) => GpuAddressSpace::try_from(&a) == Ok(GpuAddressSpace::Workgroup),
                        None => false,
                    }
                });
                let barriers = get("num_barriers").map_or(Some(1), |n| n.parse().ok())?;
                NvgpuType::MbarrierGroup { shared, barriers }
            }
            "nvgpu.warpgroup.accumulator" => NvgpuType::WarpgroupAccumulator { fragmented: ty(get("fragmented")?, opt)? },
            "nvgpu.warpgroup.descriptor" => NvgpuType::WarpgroupDescriptor { tensor: ty(get("tensor")?, opt)? },
            "nvgpu.tensormap.descriptor" => NvgpuType::TensorMap {
                tensor: ty(get("tensor")?, opt)?,
                swizzle: pick(&SWIZZLES, get("swizzle"), Swizzle::None)?,
                l2promo: pick(&L2PROMOS, get("l2promo"), 0)?,
                oob: pick(&OOBS, get("oob"), 0)?,
                interleave: pick(&INTERLEAVES, get("interleave"), 0)?,
            },
            _ => return None,
        })
    }
}

impl<'a> NvgpuType<'a> {
    /// `nvgpu::getMBarrierMemrefType`: `memref<N x i64[, 3]>`.
    pub fn mbarrier_memref(shared: bool, barriers: i64) -> Shaped<'static> {
        let extras = if shared { vec![Attribute::Int { lit: "3".into(), ty: None }] } else { Vec::new() };
        Shaped { kind: ShapedKind::MemRef, shape: Some(vec![Dim::Static(barriers)]), elem: Type::int(64).into(), extras }
    }

    /// The pass's conversion of this type.
    pub fn llvm(&self, o: LlvmOptions) -> Option<Type<'a>> {
        match self {
            NvgpuType::DeviceAsyncToken => Some(Type::int(32)),
            NvgpuType::MbarrierToken | NvgpuType::WarpgroupDescriptor { .. } => Some(Type::int(64)),
            NvgpuType::TensorMap { .. } => Some(LlvmType::ptr()),
            NvgpuType::MbarrierGroup { shared, barriers } => LlvmConverter::convert_memref(o, &Self::mbarrier_memref(*shared, *barriers)),
            NvgpuType::WarpgroupAccumulator { fragmented } => {
                let dims = fragmented.dims()?;
                let elem = fragmented.element_type().clone();
                let members = match elem {
                    Type::Float(FloatKind::F32) | Type::Integer { width: 32, .. } => dims[1] / 2,
                    Type::Float(FloatKind::F16) => dims[1] / 4,
                    _ => return None,
                };
                let inner = LlvmType::literal(vec![elem; members as usize]);
                let n = (dims[0] + WGMMA_SIZE_M - 1) / WGMMA_SIZE_M;
                Some(LlvmType::literal(vec![inner; n as usize]))
            }
        }
    }

    /// Adds the nvgpu type conversions to `tc`.
    pub fn convert(tc: &mut TypeConverter<'a>, o: LlvmOptions, opt: &'a MlirOpt) {
        tc.conversion(move |t| NvgpuType::parse(t, opt).map(|n| n.llvm(o).map(|t| vec![t])));
    }
}
