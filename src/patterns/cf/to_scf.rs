use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Str, Type};

use crate::cfg_to_scf::{At, CfgToScfInterface};
use crate::{BlockId, Body, OpData, OpId, RegionId, ValueId};

#[derive(Debug, Default, Clone, Copy)]
pub struct ControlFlowToScf;

impl ControlFlowToScf {
    fn make<'a>(body: &mut Body<'a>, at: At, mut data: OpData<'a>, loc: Option<Str<'a>>, types: &[Type<'a>]) -> OpId {
        data.loc = loc;
        let op = body.create(data, types);
        at.place(body, op)
    }

    fn take_blocks(body: &mut Body<'_>, op: OpId, blocks: Vec<BlockId>) -> RegionId {
        let r = body.add_region(op);
        for b in blocks {
            let at = body[r].blocks.len();
            body.region_insert(r, at, b);
            body[b].parent = Some(r);
        }
        r
    }

    fn i32_attr<'a>(v: i64) -> Attribute<'a> {
        Attribute::Int { lit: format!("{v}").into(), ty: Some(Type::int(32)) }
    }
}

impl<'a> CfgToScfInterface<'a> for ControlFlowToScf {
    fn can_convert_multi_successor(&self, body: &Body<'a>, op: OpId) -> bool {
        matches!(&*body[op].name, "cf.cond_br" | "cf.switch")
    }

    fn branch_region_op(&mut self, body: &mut Body<'a>, at: At, cond: OpId, result_types: &[Type<'a>], regions: Vec<Vec<BlockId>>) -> Result<OpId, Error> {
        let loc = body[cond].loc.clone();
        match &*body[cond].name {
            "cf.cond_br" => {
                let c = body[cond].operands[0];
                let op = Self::make(body, at, OpData::build("scf.if").operands(&[c]), loc, result_types);
                for blocks in regions {
                    Self::take_blocks(body, op, blocks);
                }
                Ok(op)
            }
            "cf.switch" => {
                let flag = body[cond].operands[0];
                let cast = Self::make(body, at, OpData::build("arith.index_castui").operands(&[flag]), loc.clone(), &[Type::Index]);
                let cv = body[cast].results[0];
                let cases: Vec<i64> = match body[cond].get("case_values") {
                    Some(a) => mlirformat::Const::try_from(a).map(|c| c.values.iter().filter_map(|v| v.int()).map(|i| i.unsigned() as i64).collect()).unwrap_or_default(),
                    None => Vec::new(),
                };
                let op = Self::make(body, at, OpData::build("scf.index_switch").operands(&[cv]).with("cases", Attribute::dense_i64(&cases)), loc, result_types);
                for blocks in regions {
                    Self::take_blocks(body, op, blocks);
                }
                Ok(op)
            }
            other => {
                let msg = format!("'{other}' op Cannot convert unknown control flow op to structured control flow");
                body.emit_error(cond, msg.clone());
                Err(Error(msg))
            }
        }
    }

    fn branch_region_terminator(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, _op: OpId, _replaced: Option<OpId>, results: &[ValueId]) -> Result<(), Error> {
        Self::make(body, at, OpData::build("scf.yield").operands(results), loc, &[]);
        Ok(())
    }

    fn do_while_loop(&mut self, body: &mut Body<'a>, at: At, replaced: OpId, init: &[ValueId], condition: ValueId, next: &[ValueId], loop_body: Vec<BlockId>) -> Result<OpId, Error> {
        let loc = body[replaced].loc.clone();
        let types = body.types(init);
        let op = Self::make(body, at, OpData::build("scf.while").operands(init), loc.clone(), &types);
        let before = Self::take_blocks(body, op, loop_body);
        let last = *body[before].blocks.last().expect("the latch");
        let trunc = Self::make(body, At::end(last), OpData::build("arith.trunci").operands(&[condition]), loc.clone(), &[Type::int(1)]);
        let tv = body[trunc].results[0];
        let mut operands = Vec::from([tv]);
        operands.extend_from_slice(next);
        Self::make(body, At::end(last), OpData::build("scf.condition").operands(&operands), loc.clone(), &[]);
        let after = body.add_region(op);
        let args: Vec<_> = types.iter().map(|t| (t.clone(), loc.clone())).collect();
        let ab = body.add_block(after, &args);
        let aargs = body[ab].args.to_vec();
        Self::make(body, At::end(ab), OpData::build("scf.yield").operands(&aargs), loc, &[]);
        Ok(op)
    }

    fn switch_value(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, value: u32) -> ValueId {
        let op = Self::make(body, at, OpData::build("arith.constant").with("value", Self::i32_attr(i64::from(value))), loc, &[Type::int(32)]);
        body[op].results[0]
    }

    fn cfg_switch(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, flag: ValueId, case_values: &[u32], case_dests: &[BlockId], case_args: &[Vec<ValueId>], default: BlockId, default_args: &[ValueId]) -> OpId {
        let mut operands = Vec::from([flag]);
        operands.extend_from_slice(default_args);
        let case_total: usize = case_args.iter().map(Vec::len).sum();
        case_args.iter().for_each(|a| operands.extend_from_slice(a));
        let mut data = OpData::build("cf.switch").operands(&operands);
        if !case_values.is_empty() {
            let ty = body[flag].ty.clone();
            let width = ty.int_width().map_or(32, |(w, _)| w);
            let values = case_values.iter().map(|v| mlirformat::Scalar::Int(mlirformat::ApInt::new(width, i128::from(*v)))).collect();
            let c = mlirformat::Const { ty: Type::vector(&[case_values.len() as i64], &[false], ty), values, elements: true };
            data.set("case_values", Attribute::from(c));
        }
        data.set("case_operand_segments", Attribute::DenseArray { ty: Type::int(32), values: case_args.iter().map(|a| format!("{}", a.len()).into()).collect() });
        data.set("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: [1, default_args.len(), case_total].iter().map(|n| format!("{n}").into()).collect() });
        data.successors = core::iter::once(default).chain(case_dests.iter().copied()).collect();
        Self::make(body, at, data, loc, &[])
    }

    fn undef_value(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, ty: &Type<'a>) -> ValueId {
        let op = Self::make(body, at, OpData::build("ub.poison").with("value", Attribute::dialect("ub.poison", "")), loc, core::slice::from_ref(ty));
        body[op].results[0]
    }

    fn unreachable_terminator(&mut self, body: &mut Body<'a>, at: At, loc: Option<Str<'a>>, region: RegionId) -> Result<OpId, Error> {
        let parent = body[region].parent;
        if body[parent].name != "func.func" {
            let msg = format!("Cannot create unreachable terminator for '{}'", body[parent].name);
            body.emit_error(parent, msg.clone());
            return Err(Error(msg));
        }
        let results = match body[parent].get("function_type") {
            Some(Attribute::Type(Type::Function(ft))) => ft.results.clone(),
            _ => Vec::new(),
        };
        let values: Vec<ValueId> = results.iter().map(|t| {
            let here = At { block: at.block, before: at.before };
            self.undef_value(body, here, loc.clone(), t)
        }).collect();
        Ok(Self::make(body, at, OpData::build("func.return").operands(&values), loc, &[]))
    }
}
