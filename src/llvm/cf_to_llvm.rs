//! `cf` ⇒ `llvm`, as `ControlFlowToLLVM.cpp`.

use alloc::vec;
use alloc::vec::Vec;
use core::cell::Cell;

use mlirpass_macros::patterns;
use mlirformat::Attribute;

use crate::unescape;
use crate::{BlockId, ConversionRewriter, OpData, OpId, ValueId};
use mlirformat::llvm_types::LlvmType;

/// The cf ⇒ llvm patterns.
pub struct CfToLlvm;

#[patterns(converter)]
impl CfToLlvm {
    /// `getConvertedBlock`: `block` with argument types `expected`, converting its signature
    /// when needed.
    fn converted_block(cr: &mut ConversionRewriter<'_, '_, '_>, block: BlockId, expected: &[mlirformat::Type<'_>]) -> Option<BlockId> {
        if cr.rw.body.types(&cr.rw.body[block].args) == expected {
            return Some(block);
        }
        let tc = cr.type_converter()?;
        let sig = tc.block_signature(cr.rw.body, block)?;
        if sig.converted_types() != expected {
            return None;
        }
        let current = cr.current;
        Some(cr.apply_signature_conversion(block, &sig, current))
    }

    fn flatten(operands: &[Vec<ValueId>]) -> Vec<ValueId> {
        operands.iter().flatten().copied().collect()
    }

    #[lowering("cf.br")]
    fn br(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let flat = Self::flatten(operands);
        let types = cr.rw.body.types(&flat);
        let dest = cr.rw.body[op].successors[0];
        let Some(dest) = Self::converted_block(cr, dest, &types) else { return false };
        let attrs = cr.all_attrs(op);
        let mut data = OpData::build("llvm.br").operands(&flat).successors(&[dest]);
        for a in attrs {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        cr.replace_new(op, data, &[]);
        true
    }

    #[lowering("cf.cond_br")]
    fn cond_br(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (tr, fr) = (b.successor_operands(op, 0).expect("cond_br"), b.successor_operands(op, 1).expect("cond_br"));
        let (t, f) = (Self::flatten(&operands[tr]), Self::flatten(&operands[fr]));
        let [cond] = operands[0][..] else { return false };
        let weights = b[op].get("branch_weights").cloned();
        let discardable = b.discardable(op);
        let (tt, ft) = (cr.rw.body.types(&t), cr.rw.body.types(&f));
        // Each successor read after the previous conversion: they may be the same block.
        let td = cr.rw.body[op].successors[0];
        let Some(td) = Self::converted_block(cr, td, &tt) else { return false };
        let fd = cr.rw.body[op].successors[1];
        let Some(fd) = Self::converted_block(cr, fd, &ft) else { return false };
        let mut data = OpData::build("llvm.cond_br").operands(&[&[cond][..], &t, &f].concat()).successors(&[td, fd]).segments(&[1, t.len(), f.len()]).attrs(discardable);
        if let Some(w) = weights {
            data = data.with("branch_weights", w);
        }
        cr.replace_new(op, data, &[]);
        true
    }

    #[lowering("cf.switch")]
    fn switch(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        let b = &*cr.rw.body;
        let n = b[op].successors.len();
        let ranges: Vec<_> = (0..n).map(|i| b.successor_operands(op, i).expect("switch")).collect();
        let groups: Vec<Vec<ValueId>> = ranges.iter().map(|r| ops[r.clone()].to_vec()).collect();
        let case_values = b[op].get("case_values").cloned();
        let mut dests = Vec::new();
        for (i, g) in groups.iter().enumerate() {
            let s = cr.rw.body[op].successors[i];
            let types = cr.rw.body.types(g);
            let Some(d) = Self::converted_block(cr, s, &types) else { return false };
            dests.push(d);
        }
        let mut all = vec![ops[0]];
        all.extend(&groups[0]);
        let mut segs = Vec::new();
        for g in &groups[1..] {
            all.extend(g);
            segs.push(g.len());
        }
        let segments = Attribute::DenseArray { ty: mlirformat::Type::int(32), values: segs.iter().map(|s| alloc::borrow::Cow::Owned(alloc::format!("{s}"))).collect() };
        let mut data = OpData::build("llvm.switch").operands(&all).successors(&dests).segments(&[1, groups[0].len(), segs.iter().sum()]).with("case_operand_segments", segments);
        if let Some(cv) = case_values {
            data = data.with("case_values", cv);
        }
        cr.replace_new(op, data, &[]);
        true
    }

    /// `AssertOpLowering` (aborting): the op's block splits; a new block prints the message
    /// with `puts` and calls `abort`.
    pub fn assert(cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], counter: &Cell<u32>) -> bool {
        let [arg] = operands[0][..] else { return false };
        let Some(module) = cr.module_of(op) else { return false };
        let loc = cr.rw.body[op].loc.clone();
        let msg = match cr.rw.body[op].get("msg") {
            Some(Attribute::Str { lit, .. }) => unescape(lit),
            _ => Vec::new(),
        };
        let block = cr.rw.body[op].parent.expect("placed");
        let at = cr.rw.ip.and_then(|ip| ip.before).unwrap_or(op);
        let cont = cr.rw.split_block(block, at);
        let region = cr.rw.body[block].parent.expect("in region");
        let failure = cr.rw.create_block(region, &[]);
        if cr.print_str_call(module, "assert_msg", &msg, "puts", counter).is_none() {
            return false;
        }
        if cr.llvm_func(module, "abort", Vec::new(), LlvmType::void(), false).is_none() {
            return false;
        }
        cr.llvm_call("abort", &[], &[]);
        cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.unreachable") }, &[]);
        cr.rw.set_end(block);
        let data = OpData { loc, ..OpData::build("llvm.cond_br").operands(&[arg]).successors(&[cont, failure]).segments(&[1, 0, 0]) };
        let n = cr.rw.create(data, &[]);
        let _ = n;
        cr.erase(op);
        true
    }

}

/// `AssertOpLowering`, with the counter `ensureSymbolNameIsUnique` keeps across chunks.
pub struct AssertLowering<'c>(pub &'c Cell<u32>);

impl crate::ConversionPattern for AssertLowering<'_> {
    fn name(&self) -> &str {
        "AssertOpLowering"
    }

    fn root(&self) -> Option<&str> {
        Some("cf.assert")
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        CfToLlvm::assert(cr, op, operands, self.0)
    }
}
