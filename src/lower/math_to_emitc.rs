//! `math` ⇒ `emitc`, as `MathToEmitC.cpp`: libm calls through `emitc.call_opaque`.

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, FloatKind, Type};

use crate::canon::AttrExt;
use crate::{ConversionPattern, ConversionPatterns, ConversionRewriter, OpData, OpId, ValueId};

/// The ops and the functions they call, as `populateConvertMathToEmitCPatterns` lists them.
const CALLS: [(&str, &str); 11] = [
    ("math.floor", "floor"),
    ("math.round", "round"),
    ("math.exp", "exp"),
    ("math.cos", "cos"),
    ("math.sin", "sin"),
    ("math.acos", "acos"),
    ("math.asin", "asin"),
    ("math.atan2", "atan2"),
    ("math.ceil", "ceil"),
    ("math.absf", "fabs"),
    ("math.powf", "pow"),
];

/// `LowerToEmitCCallOpaque`.
struct MathToEmitcPattern {
    root: &'static str,
    callee: &'static str,
    cpp11: bool,
}

impl ConversionPattern for MathToEmitcPattern {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let f32_or_f64 = |v: &ValueId| matches!(b[*v].ty, Type::Float(FloatKind::F32 | FloatKind::F64));
        if !b[op].operands.iter().chain(&b[op].results).all(f32_or_f64) {
            return false;
        }
        let callee = match (self.cpp11, &b[b[op].operands[0]].ty) {
            (true, _) => format!("std::{}", self.callee),
            (false, Type::Float(FloatKind::F32)) => format!("{}f", self.callee),
            _ => self.callee.into(),
        };
        let ops = b[op].operands.clone();
        let types = b.types(&b[op].results.clone());
        cr.replace_new(op, OpData::build("emitc.call_opaque").operands(&ops).with("callee", Attribute::string(&callee)), &types);
        true
    }
}

/// The math ⇒ emitc patterns.
pub struct MathToEmitc;

impl MathToEmitc {
    /// `populateConvertMathToEmitCPatterns`; `cpp11`: `std::` calls, else C99's.
    pub fn populate(patterns: &mut ConversionPatterns<'_>, cpp11: bool) {
        for (root, callee) in CALLS {
            patterns.add(MathToEmitcPattern { root, callee, cpp11 });
        }
    }

    /// The ops the pass makes illegal.
    pub fn roots() -> impl Iterator<Item = &'static str> {
        CALLS.iter().map(|(r, _)| *r)
    }
}
