//! What the `*-to-emitc` lowerings share: the type converters (`TypeConversions.cpp`) and
//! builders for the ops they create; the EmitC types are mlirformat's [`EmitcType`].

use alloc::vec;

use mlirformat::{Attribute, Shaped, ShapedKind, Signedness, Type};
use mlirformat::emitc_types::EmitcType;

use crate::{ConversionRewriter, MemrefLayout, OpData, Rewriter, TypeConverter, ValueId};

/// The EmitC conversions and the type helpers they need.
pub struct Emitc;

impl Emitc {
    /// `isMemRefTypeLegalForEmitC`: static (rank 0 too), identity layout, not empty.
    pub fn memref_legal(s: &Shaped<'_>) -> bool {
        let dims = s.dims().unwrap_or_default();
        s.kind == ShapedKind::MemRef && s.shape.is_some() && dims.iter().all(|d| *d > 0) && s.identity_layout()
    }

    /// `EmitCTypeConverter`'s memrefs: a legal one is an array, of rank 0 a pointer; `size_t`
    /// says whether `index` elements convert too.
    pub fn memref_conversions(tc: &mut TypeConverter<'_>, size_t: bool) {
        tc.conversion_with(move |convert, t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && Self::memref_legal(s) => {
                let elem = match &*s.elem {
                    Type::Index if size_t => EmitcType::size_t(),
                    e => match convert(e) {
                        Some(c) => c,
                        None => return Some(None),
                    },
                };
                let dims = s.dims().unwrap_or_default();
                Some(Some(vec![if dims.is_empty() { EmitcType::ptr(&elem) } else { EmitcType::array(&dims, &elem) }]))
            }
            _ => None,
        });
        tc.source(|rw, ty, inputs| Self::cast(rw, ty, inputs));
        tc.target(|rw, tys, inputs, _| match tys {
            [ty] => Self::cast(rw, ty, inputs).map(|v| vec![v]),
            _ => None,
        });
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
            t if EmitcType::pointer_wide(t) && (EmitcType::kind(t) == Some("size_t")) != unsigned => {
                if unsigned { EmitcType::size_t() } else { EmitcType::ptrdiff_t() }
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
        Attribute::Int { lit: mlirformat::Str::Owned(alloc::format!("{v}")), ty: Some(ty) }
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
            tc.conversion(|t| Some(EmitcType::supported(t).then(|| vec![t.clone()])));
        } else {
            tc.conversion(|t| Some(Some(vec![t.clone()])));
        }
        tc
    }

    /// `EmitCTypeConverter`: the types EmitC supports as they are, legal memrefs as arrays
    /// (`index` elements as `size_t` when `size_t`).
    pub fn type_converter<'c>(size_t: bool) -> TypeConverter<'c> {
        let mut tc = Self::converter(true);
        Self::memref_conversions(&mut tc, size_t);
        tc
    }

    /// `TestToEmitCDialectInterface`: `!test.memref_element` is `!emitc.opaque<"TestElementT">`.
    pub fn test_conversions(tc: &mut TypeConverter<'_>) {
        tc.conversion(|t| match t {
            Type::Extended(e) if e.name == "test.memref_element" => Some(Some(vec![Type::Extended(alloc::boxed::Box::new(mlirformat::Extended { name: mlirformat::Str::Borrowed("emitc.opaque"), body: Some(mlirformat::Str::Borrowed("<\"TestElementT\">")), params: alloc::vec::Vec::new() }))])),
            _ => None,
        });
    }

    /// `populateEmitCSizeTTypeConversions`: `index` is `!emitc.size_t`.
    pub fn size_t_conversions(tc: &mut TypeConverter<'_>) {
        tc.conversion(|t| matches!(t, Type::Index).then(|| Some(vec![EmitcType::size_t()])));
        tc.source(|rw, ty, inputs| Self::cast(rw, ty, inputs));
        tc.target(|rw, tys, inputs, _| match tys {
            [ty] => Self::cast(rw, ty, inputs).map(|v| vec![v]),
            _ => None,
        });
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
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
