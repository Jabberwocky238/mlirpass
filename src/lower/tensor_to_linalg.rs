//! `tensor` ⇒ `linalg`, as `TensorToLinalg.cpp`: `tensor.pad` decomposed
//! (`DecomposePadOpPattern`) into an empty tensor, a fill and an insertion of the source.

use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Error, Type};
use mlirpass_macros::{pass, patterns};

use super::linalg_build::Named;
use crate::canon::MemrefOfr as Ofr;
use crate::{Body, ConversionConfig, ConversionPatterns, ConversionRewriter as Cr, ConversionTarget, Converter, Mode, OpData, OpId, Trait, ValueId};

/// The tensor ⇒ linalg patterns.
pub struct TensorToLinalg;

#[patterns]
impl TensorToLinalg {
    /// `DecomposePadOpPattern`, when the padding value is a constant (`linalg.fill`).
    #[lowering("tensor.pad")]
    fn pad(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(pad_value) = Self::constant_padding(cr, op) else { return false };
        let src = cr.rw.body[op].operands[0];
        let (low, high) = (Self::mixed(cr.rw.body, op, "static_low", 1), Self::mixed(cr.rw.body, op, "static_high", 2));
        let rt = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let dims = rt.dims().unwrap_or_default();
        let mut dynamic = Vec::new();
        for (d, _) in dims.iter().enumerate().filter(|(_, n)| **n == Dim::DYNAMIC) {
            let size = cr.mixed_size(src, d);
            let size = Self::idx(cr, size);
            let (l, h) = (Self::idx(cr, low[d]), Self::idx(cr, high[d]));
            let plus_low = cr.rw.create_or_fold(OpData::build("arith.addi").operands(&[size, l]), &[Type::Index])[0];
            dynamic.push(cr.rw.create_or_fold(OpData::build("arith.addi").operands(&[plus_low, h]), &[Type::Index])[0]);
        }
        let Type::Shaped(s) = &rt else { return false };
        let empty = cr.empty(&dims, (*s.elem).clone(), &dynamic);
        // A constant inside the pad's block moves out, before the pad.
        if let Some(def) = cr.rw.body.def_op(pad_value).filter(|d| cr.rw.body[*d].parent == cr.rw.body[op].regions.first().and_then(|r| cr.rw.body[*r].blocks.first().copied())) {
            let block = cr.rw.body[op].parent.expect("tensor.pad is in a block");
            cr.rw.move_before(def, block, Some(op));
        }
        let fill = cr.named("linalg.fill", Named::Fill, &[pad_value], &[empty], core::slice::from_ref(&rt), Vec::new());
        let fill = cr.rw.body[fill].results[0];
        let sizes = cr.mixed_sizes(src);
        let ones = sizes.iter().map(|_| Ofr::C(1)).collect();
        cr.replace_new(op, OpData::sliced("tensor.insert_slice", &[src, fill], &[low, sizes, ones]), &[rt]);
        true
    }
}

impl TensorToLinalg {
    /// `PadOp::getConstantPaddingValue`: what the block yields, if defined outside it or by a
    /// constant.
    fn constant_padding(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<ValueId> {
        let b = &*cr.rw.body;
        let block = *b[*b[op].regions.first()?].blocks.first()?;
        let y = *b[block].ops.last()?;
        let v = *b[y].operands.first()?;
        match b.def_op(v) {
            Some(d) if b[d].parent == Some(block) => b.has(d, Trait::ConstantLike).then_some(v),
            _ if b[block].args.contains(&v) => None,
            _ => Some(v),
        }
    }

    /// `getMixedPadImpl`: the static entries, and the dynamic ones as constants when they are.
    fn mixed(b: &Body<'_>, op: OpId, name: &str, segment: usize) -> Vec<Ofr> {
        let Some(Attribute::DenseArray { values, .. }) = b[op].get(name) else { return Vec::new() };
        let sizes: Vec<usize> = match b[op].get("operandSegmentSizes") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().filter_map(|v| v.parse().ok()).collect(),
            _ => return Vec::new(),
        };
        let start: usize = sizes.iter().take(segment).sum();
        let mut dynamic = b[op].operands[start..].iter();
        values.iter().filter_map(|v| v.parse::<i64>().ok()).map(|v| match v {
            Dim::DYNAMIC => {
                let d = *dynamic.next().expect("a value per dynamic entry");
                b.const_index(d).map_or(Ofr::V(d), Ofr::C)
            }
            c => Ofr::C(c),
        }).collect()
    }

    /// `getIdxValue`: a value as is, a constant as a new `arith.constant`.
    fn idx(cr: &mut Cr<'_, '_, '_>, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::C(c) => cr.cidx(c),
        }
    }
}

/// `convert-tensor-to-linalg`.
#[pass("convert-tensor-to-linalg", on = "builtin.module")]
pub fn convert_tensor_to_linalg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut patterns = ConversionPatterns::default();
    TensorToLinalg::populate(&mut patterns);
    let mut target = ConversionTarget::default();
    target.legal_dialect("arith").legal_dialect("linalg").legal_dialect("tensor").illegal_op("tensor.pad");
    Converter::new(&target, &patterns, ConversionConfig::default()).apply(body, &[op], Mode::Partial)
}
