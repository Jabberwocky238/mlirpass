//! `math` ⇒ `emitc`, as `MathToEmitC.cpp`: libm calls through `emitc.call_opaque`.

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, Type};

use crate::patterns;

use crate::{ConversionRewriter, OpData, OpId, ValueId};

/// The math ⇒ emitc patterns, as `populateConvertMathToEmitCPatterns` lists them: each a
/// libm call (`LowerToEmitCCallOpaque`); the option is `cpp11` (`std::` calls, else C99's).
pub struct MathToEmitc;

#[patterns(options = bool)]
#[map("math.floor" => "floor", via = Self::call_opaque)]
#[map("math.round" => "round", via = Self::call_opaque)]
#[map("math.exp" => "exp", via = Self::call_opaque)]
#[map("math.cos" => "cos", via = Self::call_opaque)]
#[map("math.sin" => "sin", via = Self::call_opaque)]
#[map("math.acos" => "acos", via = Self::call_opaque)]
#[map("math.asin" => "asin", via = Self::call_opaque)]
#[map("math.atan2" => "atan2", via = Self::call_opaque)]
#[map("math.ceil" => "ceil", via = Self::call_opaque)]
#[map("math.absf" => "fabs", via = Self::call_opaque)]
#[map("math.powf" => "pow", via = Self::call_opaque)]
impl MathToEmitc {
    /// `LowerToEmitCCallOpaque`: `emitc.call_opaque` of `callee` on f32 / f64.
    fn call_opaque(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>], callee: &str, cpp11: bool) -> bool {
        let b = &*cr.rw.body;
        let f32_or_f64 = |v: &ValueId| matches!(b[*v].ty, Type::Float(FloatKind::F32 | FloatKind::F64));
        if !b[op].operands.iter().chain(&b[op].results).all(f32_or_f64) {
            return false;
        }
        let callee = match (cpp11, &b[b[op].operands[0]].ty) {
            (true, _) => format!("std::{callee}"),
            (false, Type::Float(FloatKind::F32)) => format!("{callee}f"),
            _ => callee.into(),
        };
        let ops = b[op].operands.clone();
        let types = b.types(&b[op].results.clone());
        cr.replace_new(op, OpData::build("emitc.call_opaque").operands(&ops).with("callee", Attribute::str(&callee)), &types);
        true
    }
}
