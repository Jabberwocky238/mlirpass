//! `quant` folds (`QuantOps.cpp`): a cast undoing the cast before it gives back that cast's
//! input.

use crate::{Body, Fold, Folded, OpId};

/// The `quant` casts that fold, each with the cast it undoes.
#[derive(Clone, Copy)]
enum Cast {
    /// `quant.dcast` of a `quant.qcast`: always the same type back.
    Dequantize,
    /// `quant.qcast` of a `quant.dcast`, when the types agree.
    Quantize,
    /// `quant.scast` of a `quant.scast`, when the types agree.
    Storage,
}

impl Cast {
    const TABLE: [(&str, Cast); 3] = [("quant.dcast", Cast::Dequantize), ("quant.qcast", Cast::Quantize), ("quant.scast", Cast::Storage)];

    fn of(name: &str) -> Option<Self> {
        Self::TABLE.iter().find(|(n, _)| *n == name).map(|(_, c)| *c)
    }

    /// The op name of the cast this one undoes.
    fn undoes(self) -> &'static str {
        match self {
            Cast::Dequantize => "quant.qcast",
            Cast::Quantize => "quant.dcast",
            Cast::Storage => "quant.scast",
        }
    }
}

/// `quant`'s folds.
pub struct QuantCanon;

impl QuantCanon {
    pub fn fold<'a>(b: &mut Body<'a>, op: OpId) -> Fold<'a> {
        let Some(cast) = Cast::of(&b[op].name) else { return Fold::Failed };
        let Some(src) = b.def_named(b[op].operands[0], cast.undoes()) else { return Fold::Failed };
        let input = b[src].operands[0];
        if b[input].ty != b[b[op].results[0]].ty {
            return Fold::Failed;
        }
        Fold::Results(alloc::vec![Folded::Value(input)])
    }
}
