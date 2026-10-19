//! What the `*-to-emitc` lowerings share: the EmitC types (`EmitC.cpp`), the type converters
//! (`TypeConversions.cpp`) and builders for the ops they create.

use alloc::borrow::Cow;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Extended, FloatKind, ShapedKind, Signedness, Type};

use crate::canon::AttrExt;
use crate::{ConversionRewriter, OpData, OpId, Rewriter, TypeConverter, ValueId};

/// The EmitC type predicates and constructors.
pub struct Emitc;

impl Emitc {
    fn named<'a>(name: &'static str) -> Type<'a> {
        Type::Extended(Extended { name: Cow::Borrowed(name), body: None, params: Vec::new() })
    }

    pub fn size_t<'a>() -> Type<'a> {
        Self::named("emitc.size_t")
    }

    pub fn ptrdiff_t<'a>() -> Type<'a> {
        Self::named("emitc.ptrdiff_t")
    }

    /// The `emitc.` type `t` names, if any.
    fn kind<'x>(t: &'x Type<'_>) -> Option<&'x str> {
        match t {
            Type::Extended(e) => e.name.strip_prefix("emitc."),
            _ => None,
        }
    }

    /// `isPointerWideType`: `size_t`, `ssize_t` or `ptrdiff_t`.
    pub fn pointer_wide(t: &Type<'_>) -> bool {
        matches!(Self::kind(t), Some("size_t" | "ssize_t" | "ptrdiff_t"))
    }

    /// An integer or a pointer-wide type.
    pub fn integral(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { .. }) || Self::pointer_wide(t)
    }

    /// `isSupportedIntegerType`.
    pub fn supported_int(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { width: 1 | 8 | 16 | 32 | 64, .. })
    }

    /// `isSupportedFloatType`.
    pub fn supported_float(t: &Type<'_>) -> bool {
        matches!(t, Type::Float(FloatKind::F16 | FloatKind::BF16 | FloatKind::F32 | FloatKind::F64))
    }

    /// `isSupportedEmitCType`.
    pub fn supported(t: &Type<'_>) -> bool {
        match t {
            Type::Index => true,
            Type::Integer { .. } => Self::supported_int(t),
            Type::Float(_) => Self::supported_float(t),
            Type::Shaped(s) if s.kind == ShapedKind::Tensor => {
                let fixed = s.shape.as_ref().is_some_and(|d| d.iter().all(|d| matches!(d, Dim::Static(_))));
                fixed && Self::kind(&s.elem) != Some("array") && Self::supported(&s.elem)
            }
            Type::Tuple(ts) => ts.iter().all(|t| Self::kind(t) != Some("array") && Self::supported(t)),
            t => matches!(Self::kind(t), Some("opaque" | "ptr" | "array" | "size_t" | "ssize_t" | "ptrdiff_t")),
        }
    }

    /// `x` 1-bit: `Type::isInteger(1)`.
    pub fn i1(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { width: 1, .. })
    }

    /// `adaptIntegralTypeSignedness`: `t` with unsigned or signed semantics, if integral.
    pub fn signedness<'a>(t: &Type<'a>, unsigned: bool) -> Type<'a> {
        match t {
            Type::Integer { signedness, width } if (*signedness == Signedness::Unsigned) != unsigned => {
                Type::Integer { signedness: if unsigned { Signedness::Unsigned } else { Signedness::Signed }, width: *width }
            }
            t if Self::pointer_wide(t) && (Self::kind(t) == Some("size_t")) != unsigned => {
                if unsigned { Self::size_t() } else { Self::ptrdiff_t() }
            }
            t => t.clone(),
        }
    }

    /// `getIntegerType(width, /*isSigned=*/false)`.
    pub fn unsigned<'a>(width: u32) -> Type<'a> {
        Type::Integer { signedness: Signedness::Unsigned, width }
    }

    /// The width of an integer type.
    pub fn width(t: &Type<'_>) -> u32 {
        match t {
            Type::Integer { width, .. } => *width,
            _ => 0,
        }
    }

    /// An integer attribute `v : ty`.
    pub fn int<'a>(v: i64, ty: Type<'a>) -> Attribute<'a> {
        Attribute::Int { lit: Cow::Owned(alloc::format!("{v}")), ty: Some(ty) }
    }

    /// `materializeAsUnrealizedCast`.
    fn cast<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        let [_] = inputs else { return None };
        let c = rw.create(OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
        Some(rw.body[c].results[0])
    }

    /// The converter `convert-arith-to-emitc` starts from (every type legal) or
    /// `convert-to-emitc`'s (the types EmitC supports).
    pub fn converter<'c>(supported_only: bool) -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        if supported_only {
            tc.conversion(|t| Some(Self::supported(t).then(|| vec![t.clone()])));
        } else {
            tc.conversion(|t| Some(Some(vec![t.clone()])));
        }
        tc
    }

    /// `populateEmitCSizeTTypeConversions`: `index` is `!emitc.size_t`.
    pub fn size_t_conversions(tc: &mut TypeConverter<'_>) {
        tc.conversion(|t| matches!(t, Type::Index).then(|| Some(vec![Self::size_t()])));
        tc.source(|rw, ty, inputs| Self::cast(rw, ty, inputs));
        tc.target(|rw, tys, inputs, _| match tys {
            [ty] => Self::cast(rw, ty, inputs).map(|v| vec![v]),
            _ => None,
        });
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// The type of `v`.
    pub fn ty(&self, v: ValueId) -> Type<'a> {
        self.rw.body[v].ty.clone()
    }

    /// The converted type of `op`'s only result.
    pub fn converted_result(&self, op: OpId) -> Option<Type<'a>> {
        let r = self.rw.body[op].results[0];
        self.type_converter()?.convert(&self.rw.body[r].ty)
    }

    /// `emitc.<name>` of `operands`, one result of `ty`.
    pub fn emitc(&mut self, name: &str, operands: &[ValueId], ty: Type<'a>) -> ValueId {
        self.build(OpData::build(name).operands(operands), ty)
    }

    /// `emitc.constant value : ty`.
    pub fn emitc_constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        self.build(OpData::build("emitc.constant").with("value", value), ty)
    }

    /// `emitc.cmp` with the `CmpPredicate` `pred` and an `i1` result.
    pub fn emitc_cmp(&mut self, pred: i64, l: ValueId, r: ValueId) -> ValueId {
        self.build(OpData::build("emitc.cmp").operands(&[l, r]).with("predicate", Attribute::i64(pred)), Type::int(1))
    }

    /// `adaptValueType`: `createOrFold<emitc::CastOp>`.
    pub fn emitc_cast(&mut self, v: ValueId, ty: Type<'a>) -> ValueId {
        self.rw.create_or_fold(OpData::build("emitc.cast").operands(&[v]), &[ty])[0]
    }
}
