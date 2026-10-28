//! `cf` ⇒ `spirv`, as `ControlFlowToSPIRV.cpp`.

use alloc::vec::Vec;

use crate::patterns;

use crate::{BlockId, ConversionRewriter, OpData, OpId, Quiet, Rewriter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The cf ⇒ spirv patterns (`populateControlFlowToSPIRVPatterns`).
pub struct CfToSpirv;

#[patterns(converter)]
impl CfToSpirv {
    /// `legalizeBlockArguments`: each argument of an illegal type gets the converted type, its
    /// uses a source materialization back (built at the start of the block, outside the
    /// rewriter's bookkeeping, as the C++ `OpBuilder` is).
    fn legalize_args(cr: &mut Cr<'_, '_, '_>, block: BlockId) -> bool {
        let Some(tc) = cr.type_converter() else { return false };
        let Some(&first) = cr.rw.body[block].ops.first() else { return false };
        for v in cr.rw.body[block].args.clone() {
            let ty = cr.rw.body[v].ty.clone();
            if tc.is_legal(&ty) {
                continue;
            }
            let Some(new) = tc.convert(&ty) else { return false };
            cr.rw.body[v].ty = new;
            let mut quiet = Quiet;
            let mut rw = Rewriter::new(cr.rw.body, &mut quiet);
            rw.set_before(first);
            let Some(cast) = tc.materialize_source(&mut rw, &ty, &[v]) else { return false };
            let def = rw.body.def_op(cast);
            rw.replace_uses_if(v, cast, |_, u| Some(u.op) != def);
        }
        true
    }

    /// `BranchOpPattern`.
    #[lowering("cf.br")]
    fn br(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(args) = ConversionRewriter::one_to_one(operands) else { return false };
        let dest = cr.rw.body[op].successors[0];
        if !Self::legalize_args(cr, dest) {
            return false;
        }
        cr.replace_new(op, OpData::build("spirv.Branch").operands(&args).successors(&[dest]), &[]);
        true
    }

    /// `CondBranchOpPattern`.
    #[lowering("cf.cond_br")]
    fn cond_br(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = ConversionRewriter::one_to_one(operands) else { return false };
        let b = &*cr.rw.body;
        let (tr, fr) = (b.successor_operands(op, 0).expect("cond_br"), b.successor_operands(op, 1).expect("cond_br"));
        let [t, f] = b[op].successors[..] else { return false };
        if !Self::legalize_args(cr, t) || !Self::legalize_args(cr, f) {
            return false;
        }
        let (ta, fa) = (&ops[tr], &ops[fr]);
        let data = OpData::build("spirv.BranchConditional").operands(&[&ops[..1], ta, fa].concat()).successors(&[t, f]).segments(&[1, ta.len(), fa.len()]);
        cr.replace_new(op, data, &[]);
        true
    }
}
