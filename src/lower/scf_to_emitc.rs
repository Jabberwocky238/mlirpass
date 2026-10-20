//! `scf` ⇒ `emitc`, as `SCFToEmitC.cpp`: results and loop-carried values live in variables.

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Type};

use super::emitc::Emitc;
use crate::canon::AttrExt;
use crate::{ConversionRewriter, OpData, OpId, RegionId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// Variables and the types they hold.
type Vars<'a> = Vec<(ValueId, Type<'a>)>;

/// The scf ⇒ emitc patterns.
pub struct ScfToEmitc;

#[patterns(converter)]
impl ScfToEmitc {
    /// An uninitialized `emitc.variable` of `ty`.
    fn variable<'a>(cr: &mut Cr<'_, 'a, '_>, ty: &Type<'a>) -> ValueId {
        let data = OpData::build("emitc.variable").with("value", Attribute::dialect("emitc.opaque", "<\"\">"));
        cr.build(data, Emitc::lvalue(ty))
    }

    /// `createVariablesForResults`: one variable per result, before `op`.
    fn result_vars<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId) -> Option<Vars<'a>> {
        let results = cr.rw.body[op].results.clone();
        if results.is_empty() {
            return Some(Vec::new());
        }
        let saved = cr.rw.ip;
        cr.rw.set_before(op);
        let mut vars = Vec::new();
        for r in results {
            let ty = cr.type_converter()?.convert(&cr.ty(r))?;
            vars.push((Self::variable(cr, &ty), ty));
        }
        cr.rw.ip = saved;
        Some(vars)
    }

    /// `assignValues`.
    fn assign(cr: &mut Cr<'_, '_, '_>, values: &[ValueId], vars: &Vars<'_>) {
        for (v, (var, _)) in values.iter().zip(vars) {
            cr.rw.create(OpData::build("emitc.assign").operands(&[*var, *v]), &[]);
        }
    }

    /// `loadValues`.
    fn load<'a>(cr: &mut Cr<'_, 'a, '_>, vars: &Vars<'a>) -> Vec<ValueId> {
        vars.iter().map(|(var, ty)| cr.emitc("emitc.load", &[*var], ty.clone())).collect()
    }

    /// The remapped `values`, one each.
    fn remapped(cr: &mut Cr<'_, '_, '_>, values: &[ValueId]) -> Option<Vec<ValueId>> {
        cr.remap(values, None)?.into_iter().map(|v| v.first().copied()).collect()
    }

    /// `lowerYield`: the yielded values assigned to `vars`, then an `emitc.yield`.
    fn lower_yield(cr: &mut Cr<'_, '_, '_>, vars: &Vars<'_>, yield_op: OpId) -> bool {
        let saved = cr.rw.ip;
        cr.rw.set_before(yield_op);
        let operands = cr.rw.body[yield_op].operands.clone();
        let Some(values) = Self::remapped(cr, &operands) else { return false };
        Self::assign(cr, &values, vars);
        cr.rw.create(OpData::build("emitc.yield"), &[]);
        cr.erase(yield_op);
        cr.rw.ip = saved;
        true
    }

    /// The terminator of `region`'s last block.
    fn terminator(cr: &Cr<'_, '_, '_>, region: RegionId) -> Option<OpId> {
        let b = &*cr.rw.body;
        b[region].blocks.last().and_then(|blk| b[*blk].ops.last().copied())
    }

    /// `lowerRegion`: `region` moved into `into`, its yield lowered.
    fn lower_region(cr: &mut Cr<'_, '_, '_>, vars: &Vars<'_>, region: RegionId, into: RegionId) -> bool {
        cr.inline_region(region, into, None);
        let Some(t) = Self::terminator(cr, into) else { return false };
        Self::lower_yield(cr, vars, t)
    }

    /// `ForLowering`.
    #[lowering("scf.for")]
    fn for_op(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("unsignedCmp").is_some() {
            return false;
        }
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(vars) = Self::result_vars(cr, op) else { return false };
        Self::assign(cr, &ops[3..], &vars);
        let iv = cr.ty(ops[0]);
        let new = cr.rw.create_with(OpData::build("emitc.for").operands(&ops[..3]), &[], |b, f| {
            let r = b.add_region(f);
            b.add_block(r, &[(iv, None)]);
        });
        let body = cr.rw.body.top_block(new);
        let saved = cr.rw.ip;
        cr.rw.set_end(body);
        let mut replacing = vec![cr.rw.body[body].args[0]];
        replacing.extend(Self::load(cr, &vars));
        cr.rw.ip = saved;
        let region = cr.rw.body[op].regions[0];
        let Some(current) = cr.current else { return false };
        if cr.convert_region_types(region, current, None).is_none() {
            return false;
        }
        let scf_body = cr.rw.body[region].blocks[0];
        cr.merge_blocks(scf_body, body, &replacing);
        let Some(t) = cr.rw.body[body].ops.last().copied() else { return false };
        if !Self::lower_yield(cr, &vars, t) {
            return false;
        }
        let results = Self::load(cr, &vars);
        cr.replace_values(op, &results);
        true
    }

    /// `IfLowering`.
    #[lowering("scf.if")]
    fn if_op(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(vars) = Self::result_vars(cr, op) else { return false };
        let new = cr.rw.create_with(OpData::build("emitc.if").operands(&ops[..1]), &[], |b, f| {
            b.add_region(f);
            b.add_region(f);
        });
        let (from, into) = (cr.rw.body[op].regions.clone(), cr.rw.body[new].regions.clone());
        if !Self::lower_region(cr, &vars, from[0], into[0]) {
            return false;
        }
        if !cr.rw.body[from[1]].blocks.is_empty() && !Self::lower_region(cr, &vars, from[1], into[1]) {
            return false;
        }
        cr.rw.set_after(op);
        let results = Self::load(cr, &vars);
        cr.replace_values(op, &results);
        true
    }

    /// `IndexSwitchOpLowering`: the cases, then the default.
    #[lowering("scf.index_switch")]
    fn switch(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(vars) = Self::result_vars(cr, op) else { return false };
        let cases = cr.rw.body[op].get("cases").cloned().unwrap_or(Attribute::Unit);
        let from = cr.rw.body[op].regions.clone();
        let new = cr.rw.create_with(OpData::build("emitc.switch").operands(&ops[..1]).with("cases", cases), &[], |b, f| {
            for _ in &from {
                b.add_region(f);
            }
        });
        let into = cr.rw.body[new].regions.clone();
        for i in (1..from.len()).chain([0]) {
            if !Self::lower_region(cr, &vars, from[i], into[i]) {
                return false;
            }
        }
        cr.rw.set_after(op);
        let results = Self::load(cr, &vars);
        cr.replace_values(op, &results);
        true
    }

    /// `WhileLowering`: an `emitc.do` whose condition reads a variable.
    #[lowering("scf.while")]
    fn while_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(results) = Self::result_vars(cr, op) else { return false };
        // `createVariablesForLoopCarriedValues`.
        let saved = cr.rw.ip;
        cr.rw.set_before(op);
        let mut loop_vars = Vec::new();
        for init in cr.rw.body[op].operands.clone() {
            let Some(ty) = cr.type_converter().and_then(|tc| tc.convert(&cr.ty(init))) else { return false };
            let var = Self::variable(cr, &ty);
            cr.rw.create(OpData::build("emitc.assign").operands(&[var, init]), &[]);
            loop_vars.push((var, ty));
        }
        cr.rw.ip = saved;
        if !Self::do_while(cr, op, &loop_vars, &results) {
            return false;
        }
        cr.rw.set_after(op);
        let values = Self::load(cr, &results);
        cr.replace_values(op, &values);
        true
    }

    /// `lowerDoWhile`.
    fn do_while<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, loop_vars: &Vars<'a>, results: &Vars<'a>) -> bool {
        let i1 = Type::int(1);
        let cond_var = Self::variable(cr, &i1);
        let lowered = cr.rw.create_with(OpData::build("emitc.do"), &[], |b, d| {
            b.add_region(d);
            b.add_region(d);
        });
        let [before, after] = cr.rw.body[op].regions[..] else { return false };
        let Some(current) = cr.current else { return false };
        if cr.convert_region_types(before, current, None).is_none() || cr.convert_region_types(after, current, None).is_none() {
            return false;
        }
        let [body_region, cond_region] = cr.rw.body[lowered].regions[..] else { return false };
        let before_block = cr.rw.body[before].blocks[0];
        let body_block = cr.rw.body.add_block(body_region, &[]);
        cr.rw.set_start(body_block);
        let replacing = Self::load(cr, loop_vars);
        cr.merge_blocks(before_block, body_block, &replacing);
        let Some(cond_op) = Self::terminator(cr, body_region) else { return false };
        cr.rw.set_before(cond_op);
        let operands = cr.rw.body[cond_op].operands.clone();
        let Some(args) = Self::remapped(cr, &operands[1..]) else { return false };
        Self::assign(cr, &args, results);
        let Some(condition) = cr.remapped(operands[0]) else { return false };
        cr.rw.create(OpData::build("emitc.assign").operands(&[cond_var, condition]), &[]);
        let after_block = cr.rw.body[after].blocks[0];
        if cr.rw.body[after_block].ops.len() > 1 {
            let if_op = cr.rw.create_with(OpData::build("emitc.if").operands(&[condition]), &[], |b, f| {
                b.add_region(f);
                b.add_region(f);
            });
            let then = cr.rw.body[if_op].regions[0];
            let if_body = cr.rw.body.add_block(then, &[]);
            cr.rw.set_end(if_body);
            let Some(args) = Self::remapped(cr, &operands[1..]) else { return false };
            cr.merge_blocks(after_block, if_body, &args);
            let Some(y) = cr.rw.body[if_body].ops.last().copied() else { return false };
            if !Self::lower_yield(cr, loop_vars, y) {
                return false;
            }
        }
        cr.erase(cond_op);
        let cond_block = cr.rw.body.add_block(cond_region, &[]);
        cr.rw.set_start(cond_block);
        let lv = Emitc::lvalue(&i1);
        let expr = cr.rw.create_with(OpData::build("emitc.expression").operands(&[cond_var]), core::slice::from_ref(&i1), |b, e| {
            let r = b.add_region(e);
            b.add_block(r, &[(lv, None)]);
        });
        let expr_block = cr.rw.body.top_block(expr);
        cr.rw.set_start(expr_block);
        let arg = cr.rw.body[expr_block].args[0];
        let v = cr.emitc("emitc.load", &[arg], i1);
        cr.rw.create(OpData::build("emitc.yield").operands(&[v]), &[]);
        cr.rw.set_end(cond_block);
        let e = cr.rw.body[expr].results[0];
        cr.rw.create(OpData::build("emitc.yield").operands(&[e]), &[]);
        true
    }

}
