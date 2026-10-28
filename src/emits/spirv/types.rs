//! `SPIRVTypeConverter` (`SPIRVConversion.cpp`): builtin types as the SPIR-V types a target
//! allows — scalars emulated to 32 bits where the target lacks them, `index` as `i32` /
//! `i64`, memrefs as pointers to (structs wrapping) arrays in their storage class.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::{SpirvMember, SpirvType};
use mlirformat::{Attribute, Dim, FloatKind, Shaped, ShapedKind, Signedness, Type};

use super::TargetEnv;
use crate::{MemrefLayout, OpData, Rewriter, TypeConverter, ValueId};

/// `SPIRVConversionOptions`.
#[derive(Debug, Clone, Copy)]
pub struct SpirvOptions {
    /// `emulateLT32BitScalarTypes`: scalars the target lacks become 32-bit ones.
    pub emulate_lt32: bool,
    /// `emulateUnsupportedFloatTypes`: 8-bit floats become integers of their width.
    pub emulate_unsupported_floats: bool,
    /// `use64bitIndex`.
    pub index64: bool,
    /// `boolNumBits`: the bits of an `i1` in memory.
    pub bool_bits: u32,
    /// `subByteTypeStorage == Packed`.
    pub sub_byte_packed: bool,
}

impl Default for SpirvOptions {
    fn default() -> Self {
        Self { emulate_lt32: true, emulate_unsupported_floats: true, index64: false, bool_bits: 8, sub_byte_packed: true }
    }
}

/// ⭐ The SPIR-V types of a target.
pub struct SpirvTypes<'t> {
    pub env: &'t TargetEnv,
    pub opts: SpirvOptions,
}

/// `needsExplicitLayout`.
pub fn explicit_layout(storage: &str) -> bool {
    matches!(storage, "PhysicalStorageBuffer" | "PushConstant" | "StorageBuffer" | "Uniform")
}

impl<'t> SpirvTypes<'t> {
    pub fn index(&self) -> Type<'static> {
        Type::int(if self.opts.index64 { 64 } else { 32 })
    }

    fn is_float8(t: &Type<'_>) -> bool {
        matches!(t, Type::Float(FloatKind::F8E5M2 | FloatKind::F8E4M3 | FloatKind::F8E4M3FN | FloatKind::F8E5M2FNUZ | FloatKind::F8E4M3FNUZ | FloatKind::F8E4M3B11FNUZ | FloatKind::F8E3M4 | FloatKind::F8E8M0FNU))
    }

    fn ceil_div(a: i64, b: i64) -> i64 {
        (a + b - 1) / b
    }

    fn owned_shape(s: &Shaped<'_>) -> Shaped<'static> {
        match Type::Shaped(s.clone()).owned() {
            Type::Shaped(s) => s,
            _ => unreachable!("a shaped type stays shaped"),
        }
    }

    /// `getTypeNumBytes`.
    pub fn num_bytes(&self, t: &Type<'_>) -> Option<i64> {
        if TargetEnv::is_scalar(t) {
            let w = t.bit_width()?;
            return (w != 1).then_some(i64::from(w / 8));
        }
        if self.opts.emulate_unsupported_floats && matches!(t, Type::Float(_)) {
            return (t.bit_width()? == 8).then_some(1);
        }
        match t {
            Type::Complex(e) => Some(2 * self.num_bytes(e)?),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some(t.element_count()? as i64 * self.num_bytes(&s.elem)?),
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => {
                let dims = s.dims()?;
                if dims.contains(&Dim::DYNAMIC) {
                    return None;
                }
                let (strides, offset) = s.strides_and_offset()?;
                let elem = self.num_bytes(&s.elem)?;
                if dims.is_empty() {
                    return Some(elem);
                }
                if offset == Dim::DYNAMIC || strides.contains(&Dim::DYNAMIC) {
                    return None;
                }
                let size = dims.iter().zip(&strides).map(|(d, s)| d * s).max().unwrap_or(-1);
                Some((offset + size) * elem)
            }
            Type::Shaped(s) if s.kind == ShapedKind::Tensor => {
                let dims = s.dims()?;
                if dims.contains(&Dim::DYNAMIC) {
                    return None;
                }
                Some(dims.iter().product::<i64>() * self.num_bytes(&s.elem)?)
            }
            _ => None,
        }
    }

    /// `convertScalarType`.
    pub fn scalar(&self, t: &Type<'_>, storage: Option<&str>) -> Option<Type<'static>> {
        if self.env.allows_type(t, storage) {
            return Some(t.owned());
        }
        if !self.opts.emulate_lt32 || t.bit_width()? > 32 {
            return None;
        }
        Some(match t {
            Type::Float(_) => Type::Float(FloatKind::F32),
            Type::Integer { signedness, .. } => Type::Integer { signedness: *signedness, width: 32 },
            _ => return None,
        })
    }

    /// `convertSubByteIntegerType`.
    fn sub_byte(&self, t: &Type<'_>) -> Option<Type<'static>> {
        let Type::Integer { signedness, width } = t else { return None };
        (*width <= 8 && self.opts.sub_byte_packed && width.is_power_of_two()).then_some(Type::Integer { signedness: *signedness, width: 32 })
    }

    /// The shape `s` with `index` / 8-bit float elements as they convert.
    fn element_converted(&self, s: &Shaped<'_>) -> Shaped<'static> {
        let mut s = Self::owned_shape(s);
        if *s.elem == Type::Index {
            s.elem = self.index().into();
        } else if self.opts.emulate_unsupported_floats && Self::is_float8(&s.elem) {
            s.elem = Type::int(8).into();
        }
        s
    }

    /// `convertVectorType`.
    pub fn vector(&self, s: &Shaped<'_>, storage: Option<&str>) -> Option<Type<'static>> {
        let s = self.element_converted(s);
        let t = Type::Shaped(s.clone());
        let single = s.shape.as_ref().is_some_and(|d| d.len() <= 1) && t.element_count() == Some(1);
        if !TargetEnv::is_scalar(&s.elem) {
            let elem = self.sub_byte(&s.elem)?;
            if single {
                return Some(elem);
            }
            if t.element_count()? > 4 {
                return None;
            }
            return Some(Type::Shaped(Shaped { elem: elem.into(), ..s }));
        }
        if single {
            return self.scalar(&s.elem, storage);
        }
        if !TargetEnv::is_valid_vector(&t) {
            return None;
        }
        if self.env.allows_type(&t, storage) {
            return Some(t);
        }
        let elem = self.scalar(&s.elem, storage)?;
        Some(Type::Shaped(Shaped { elem: elem.into(), ..s }))
    }

    /// `convertComplexType`.
    fn complex(&self, e: &Type<'_>, storage: Option<&str>) -> Option<Type<'static>> {
        if !TargetEnv::is_scalar(e) {
            return None;
        }
        let elem = self.scalar(e, storage)?;
        (elem == e.owned()).then(|| Type::vector(&[2], &[false], elem))
    }

    /// `convertTensorType`.
    fn tensor(&self, s: &Shaped<'_>) -> Option<Type<'static>> {
        let s = self.element_converted(s);
        if s.dims()?.contains(&Dim::DYNAMIC) || !TargetEnv::is_scalar(&s.elem) {
            return None;
        }
        let count = self.num_bytes(&Type::Shaped(s.clone()))? / self.num_bytes(&s.elem)?;
        if count == 0 || count > i64::from(u32::MAX) {
            return None;
        }
        let elem = self.scalar(&s.elem, None)?;
        self.num_bytes(&elem)?;
        Some(SpirvType::array(count as u32, elem, 0))
    }

    /// `wrapInStructAndGetPointer`.
    fn wrapped(elem: Type<'static>, storage: &str) -> Type<'static> {
        let member = SpirvMember { ty: elem, offset: explicit_layout(storage).then_some(0), decorations: Vec::new() };
        SpirvType::ptr(SpirvType::Struct { name: None, members: Some(vec![member]), decorations: Vec::new() }.into(), storage)
    }

    /// The pointer to the array of `count` elements (`None`: a runtime array) of `elem`.
    fn array_ptr(&self, elem: Type<'static>, size: i64, count: Option<i64>, storage: &str) -> Option<Type<'static>> {
        let stride = if explicit_layout(storage) { size as u32 } else { 0 };
        let kernel = self.env.allows_cap("Kernel");
        let Some(n) = count else {
            if kernel {
                return Some(SpirvType::ptr(elem, storage));
            }
            return Some(Self::wrapped(SpirvType::rtarray(elem, stride), storage));
        };
        let arr = SpirvType::array(n as u32, elem, stride);
        Some(if kernel { SpirvType::ptr(arr, storage) } else { Self::wrapped(arr, storage) })
    }

    /// The storage class of a memref (`#spirv.storage_class<..>` memory space).
    pub fn storage_class(s: &Shaped<'_>) -> Option<alloc::string::String> {
        let Some(Attribute::Extended { ext, .. }) = s.memory_space() else { return None };
        if ext.name != "spirv.storage_class" {
            return None;
        }
        Some(alloc::string::String::from(ext.body.as_deref()?.trim_start_matches('<').trim_end_matches('>')))
    }

    /// `convertMemrefType` (and its bool and sub-byte variants).
    pub fn memref(&self, s: &Shaped<'_>) -> Option<Type<'static>> {
        let storage = Self::storage_class(s)?;
        let st = Some(&*storage);
        let fixed = !s.dims()?.contains(&Dim::DYNAMIC);
        let elements = Type::Shaped(s.clone()).element_count().unwrap_or(0) as i64;
        if storage == "Image" {
            return None;
        }
        if let Type::Integer { width, signedness } = &*s.elem {
            if *width == 1 {
                if self.opts.bool_bits != 8 {
                    return None;
                }
                let elem = self.scalar(&Type::int(8), st)?;
                let size = self.num_bytes(&elem)?;
                if !fixed {
                    return self.array_ptr(elem, size, None, &storage);
                }
                if elements == 0 {
                    return None;
                }
                let bytes = Self::ceil_div(elements * 8, 8);
                return self.array_ptr(elem, size, Some(Self::ceil_div(bytes, size)), &storage);
            }
            if *width < 8 {
                let elem = self.sub_byte(&Type::Integer { signedness: *signedness, width: *width })?;
                let size = self.num_bytes(&elem)?;
                if !fixed {
                    return self.array_ptr(elem, size, None, &storage);
                }
                if elements == 0 {
                    return None;
                }
                let bytes = Self::ceil_div(elements * i64::from(*width), 8);
                return self.array_ptr(elem, size, Some(Self::ceil_div(bytes, size)), &storage);
            }
        }
        let mut s = Self::owned_shape(s);
        let elem = match &*s.elem {
            Type::Shaped(v) if v.kind == ShapedKind::Vector => self.vector(v, st)?,
            Type::Complex(e) => self.complex(e, st)?,
            e if TargetEnv::is_scalar(e) => self.scalar(e, st)?,
            Type::Index => {
                s.elem = self.index().into();
                self.index()
            }
            Type::Float(_) => {
                s = self.element_converted(&s);
                (*s.elem).clone()
            }
            _ => return None,
        };
        let size = self.num_bytes(&elem)?;
        if !fixed {
            return self.array_ptr(elem, size, None, &storage);
        }
        let bytes = self.num_bytes(&Type::Shaped(s))?;
        if bytes == 0 {
            return None;
        }
        self.array_ptr(elem, size, Some(Self::ceil_div(bytes, size)), &storage)
    }

    /// `convertType`, as the conversions registered last to first try it.
    pub fn convert(&self, t: &Type<'_>) -> Option<Type<'static>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => self.memref(s),
            Type::Shaped(s) if s.kind == ShapedKind::Tensor => self.tensor(s),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => self.vector(s, None),
            Type::Complex(e) => self.complex(e, None),
            Type::Float(_) if TargetEnv::is_scalar(t) => self.scalar(t, None),
            Type::Float(_) if t.bit_width() == Some(8) && self.opts.emulate_unsupported_floats && Self::is_float8(t) => Some(Type::int(8)),
            Type::Float(_) => None,
            Type::Integer { .. } if TargetEnv::is_scalar(t) => self.scalar(t, None),
            Type::Integer { width, .. } if *width < 8 => self.sub_byte(t),
            Type::Integer { .. } => None,
            Type::Index => Some(self.index()),
            t if TargetEnv::is_spirv_type(t) => Some(t.owned()),
            _ => None,
        }
    }

    /// The `TypeConverter`, with `castToSourceType` as its source materialization.
    pub fn converter(&'t self) -> TypeConverter<'t> {
        let mut tc = TypeConverter::default();
        tc.conversion(move |t| Some(self.convert(t).map(|t| vec![t])));
        tc.source(move |rw, ty, inputs| {
            self.cast_to_source(rw, ty, inputs).or_else(|| {
                let o = rw.create(OpData::build("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
                Some(rw.body[o].results[0])
            })
        });
        // `addTargetMaterialization`: an `unrealized_conversion_cast`.
        tc.target(|rw, types, inputs, _| {
            let o = rw.create(OpData::build("builtin.unrealized_conversion_cast").operands(inputs), types);
            Some(rw.body[o].results.clone())
        });
        tc
    }

    /// `castToSourceType`: an integer narrowed back with `spirv.IEqual` (to `i1`) or
    /// `spirv.SConvert` / `spirv.UConvert`; `None`: anything else, left to a cast.
    fn cast_to_source<'a>(&self, rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        let [input] = inputs else { return None };
        let in_t = rw.body[*input].ty.clone();
        let (Type::Integer { width: iw, .. }, Type::Integer { width: w, signedness }) = (&in_t, ty) else { return None };
        if !TargetEnv::is_scalar(ty) || iw < w {
            return None;
        }
        let value = |rw: &mut Rewriter<'_, 'a>, d: OpData<'a>, t: Type<'a>| {
            let o = rw.create(d, &[t]);
            rw.body[o].results[0]
        };
        if *w == 1 {
            let one = value(rw, OpData::build("spirv.Constant").with("value", Attribute::integer(1, in_t.clone())), in_t);
            return Some(value(rw, OpData::build("spirv.IEqual").operands(&[*input, one]), Type::I1));
        }
        if !self.env.allows_type(ty, None) {
            return None;
        }
        let op = if *signedness == Signedness::Signed { "spirv.SConvert" } else { "spirv.UConvert" };
        Some(value(rw, OpData::build(op).operands(&[*input]), ty.clone()))
    }
}
