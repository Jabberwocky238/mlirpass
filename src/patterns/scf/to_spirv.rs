use alloc::vec;
use alloc::vec::Vec;

use crate::patterns;
use mlirformat::spirv_types::SpirvType;
use mlirformat::{Attribute, Type};

use crate::{BlockId, ConversionRewriter, OpData, OpId, RegionId, SignatureConversion, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub struct ScfToSpirv;

impl ScfToSpirv {
    fn construct<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, name: &str, control: (&str, &str)) -> (OpId, RegionId) {
        cr.rw.set_before(op);
        let hint = cr.rw.body[op].get(&alloc::format!("spirv.{}", control.0)).cloned();
        let value = hint.unwrap_or_else(|| Cr::spirv_enum(control.1, "None"));
        let new = cr.rw.create_with(OpData::build(name).with(control.0, value), &[], |b, o| {
            b.add_region(o);
        });
        let region = cr.rw.body[new].regions[0];
        (new, region)
    }

    fn block_at<'a>(cr: &mut Cr<'_, 'a, '_>, region: RegionId, index: usize, types: &[Type<'a>]) -> BlockId {
        let b = cr.rw.create_block(region, types);
        let blocks = &mut cr.rw.body[region].blocks;
        blocks.pop();
        blocks.insert(index, b);
        b
    }

    fn entry_and_merge<'a>(cr: &mut Cr<'_, 'a, '_>, region: RegionId) -> (BlockId, BlockId) {
        let entry = cr.rw.create_block(region, &[]);
        let merge = cr.rw.create_block(region, &[]);
        cr.rw.create(OpData::build("spirv.mlir.merge"), &[]);
        (entry, merge)
    }

    fn br<'a>(cr: &mut Cr<'_, 'a, '_>, at: BlockId, to: BlockId, args: &[ValueId]) {
        cr.rw.set_end(at);
        let mut data = OpData::build("spirv.Branch").operands(args);
        data.successors = smallvec::smallvec![to];
        cr.rw.create(data, &[]);
    }

    fn cond_br<'a>(cr: &mut Cr<'_, 'a, '_>, at: BlockId, cond: ValueId, t: BlockId, f: BlockId) {
        cr.rw.set_end(at);
        let mut data = OpData::build("spirv.BranchConditional").operands(&[cond]).with("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: vec!["1".into(), "0".into(), "0".into()].into() });
        data.successors = smallvec::smallvec![t, f];
        cr.rw.create(data, &[]);
    }

    fn outputs<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, new: OpId, types: &[Type<'a>]) {
        let mut results = Vec::new();
        for t in types {
            cr.rw.set_before(new);
            let ptr = SpirvType::ptr(t.clone(), "Function");
            let var = cr.build(OpData::build("spirv.Variable").with("storage_class", Cr::spirv_enum("storage_class", "Function")), ptr);
            cr.rw.set_after(new);
            results.push(cr.build(OpData::build("spirv.Load").operands(&[var]), t.clone()));
        }
        cr.replace_values(op, &results);
    }

    fn output_vars(cr: &Cr<'_, '_, '_>, parent: OpId, n: usize) -> Option<Vec<ValueId>> {
        let b = &cr.rw.body;
        let ops = &b.block_ops(b[parent].parent?);
        let at = ops.iter().position(|o| *o == parent)?;
        let vars = ops[..at].iter().rev().take(n).rev().copied().collect::<Vec<_>>();
        (vars.len() == n && vars.iter().all(|v| b[*v].name == "spirv.Variable")).then(|| vars.iter().map(|v| b[*v].results[0]).collect())
    }
}

#[patterns(converter)]
impl ScfToSpirv {
    #[convert("scf.for")]
    fn for_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let (lb, ub, step, inits) = (ops[0], ops[1], ops[2], ops[3..].to_vec());
        let (new, region) = Self::construct(cr, op, "spirv.mlir.loop", ("loop_control", "loop_control"));
        let (entry, merge) = Self::entry_and_merge(cr, region);
        let mut types = vec![cr.rw.body[lb].ty.clone()];
        types.extend(inits.iter().map(|v| cr.rw.body[*v].ty.clone()));
        let header = Self::block_at(cr, region, 1, &types);
        let iv = cr.rw.body[header].args[0];
        let for_region = cr.rw.body[op].regions[0];
        let body = cr.rw.body[for_region].blocks[0];
        let mut sig = SignatureConversion::new(cr.rw.body[body].args.len());
        for (i, a) in cr.rw.body[header].args.clone().into_iter().enumerate() {
            sig.remap_values(i, vec![a]);
        }
        let body = cr.apply_signature_conversion(body, &sig, None);
        cr.inline_region(for_region, region, Some(merge));
        let mut args = vec![lb];
        args.extend(inits.iter().copied());
        Self::br(cr, entry, header, &args);
        cr.rw.set_end(header);
        let unsigned = cr.rw.body[op].get("unsignedCmp").is_some_and(|a| matches!(a, Attribute::Unit | Attribute::Bool(true)));
        let cmp = cr.build(OpData::build(if unsigned { "spirv.ULessThan" } else { "spirv.SLessThan" }).operands(&[iv, ub]), Type::I1);
        Self::cond_br(cr, header, cmp, body, merge);
        let blocks = cr.rw.body[region].blocks.clone();
        let cont = blocks[blocks.len() - 2];
        cr.rw.set_end(cont);
        let next = cr.build(OpData::build("spirv.IAdd").operands(&[iv, step]), cr.rw.body[iv].ty.clone());
        Self::br(cr, cont, header, &[next]);
        let init_types: Vec<Type<'a>> = inits.iter().map(|v| cr.rw.body[*v].ty.clone()).collect();
        Self::outputs(cr, op, new, &init_types);
        true
    }

    #[convert("scf.if")]
    fn if_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let mut types = Vec::new();
        for r in cr.rw.body[op].results.clone() {
            let Some(t) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
            types.push(t);
        }
        let (new, region) = Self::construct(cr, op, "spirv.mlir.selection", ("selection_control", "selection_control"));
        let merge = cr.rw.create_block(region, &[]);
        cr.rw.create(OpData::build("spirv.mlir.merge"), &[]);
        let header = Self::block_at(cr, region, 0, &[]);
        let [then_r, else_r] = [0, 1].map(|i| cr.rw.body[op].regions[i]);
        let then_block = cr.rw.body[then_r].blocks[0];
        let then_last = *cr.rw.body[then_r].blocks.last().expect("then");
        Self::br(cr, then_last, merge, &[]);
        cr.inline_region(then_r, region, Some(merge));
        let mut else_block = merge;
        if !cr.rw.body[else_r].blocks.is_empty() {
            else_block = cr.rw.body[else_r].blocks[0];
            let else_last = *cr.rw.body[else_r].blocks.last().expect("else");
            Self::br(cr, else_last, merge, &[]);
            cr.inline_region(else_r, region, Some(merge));
        }
        Self::cond_br(cr, header, ops[0], then_block, else_block);
        Self::outputs(cr, op, new, &types);
        true
    }

    #[convert("scf.index_switch")]
    fn index_switch<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let mut types = Vec::new();
        for r in cr.rw.body[op].results.clone() {
            let Some(t) = cr.converted(&cr.rw.body[r].ty.clone()) else { return false };
            types.push(t);
        }
        let selector = ops[0];
        let Type::Integer { width, .. } = cr.rw.body[selector].ty else { return false };
        let cases = cr.rw.body.dense_i64(op, "cases");
        let (new, region) = Self::construct(cr, op, "spirv.mlir.selection", ("selection_control", "selection_control"));
        let merge = cr.rw.create_block(region, &[]);
        cr.rw.create(OpData::build("spirv.mlir.merge"), &[]);
        let header = Self::block_at(cr, region, 0, &[]);
        let regions = cr.rw.body[op].regions.clone();
        let inline = |cr: &mut Cr<'_, 'a, '_>, r: RegionId| {
            let first = cr.rw.body[r].blocks[0];
            let last = *cr.rw.body[r].blocks.last().expect("a block");
            Self::br(cr, last, merge, &[]);
            cr.inline_region(r, region, Some(merge));
            first
        };
        let case_blocks: Vec<BlockId> = regions[1..].iter().map(|r| inline(cr, *r)).collect();
        let default = inline(cr, regions[0]);
        cr.rw.set_end(header);
        let lit = Type::vector(&[cases.len() as i64], &[], Type::int(width));
        let values = cases.iter().map(|c| mlirformat::Scalar::Int(mlirformat::ApInt::new(width, i128::from(*c)))).collect();
        let mut data = OpData::build("spirv.Switch")
            .operands(&[selector])
            .with("case_operand_segments", Attribute::dense_i32(&vec![0; cases.len()]))
            .with("operandSegmentSizes", Attribute::dense_i32(&[1, 0, 0]));
        if !cases.is_empty() {
            data.set("literals", mlirformat::Const { ty: lit, values, elements: true }.into());
        }
        data.successors = core::iter::once(default).chain(case_blocks).collect();
        cr.rw.create(data, &[]);
        Self::outputs(cr, op, new, &types);
        true
    }

    #[convert("scf.yield")]
    fn yield_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(parent) = cr.rw.body.parent_op(op) else { return false };
        let pname = cr.rw.body[parent].name.clone();
        if pname.starts_with("scf.") && !matches!(&*pname, "scf.if" | "scf.for" | "scf.while" | "scf.index_switch") {
            return false;
        }
        if !ops.is_empty() {
            let Some(vars) = Self::output_vars(cr, parent, ops.len()) else { return false };
            cr.rw.set_before(op);
            for (var, v) in vars.iter().zip(&ops) {
                cr.rw.create(OpData::build("spirv.Store").operands(&[*var, *v]), &[]);
            }
            if pname == "spirv.mlir.loop" {
                let block = cr.rw.body[op].parent.expect("placed");
                let br = cr.rw.body.last_op(block).expect("terminator");
                if cr.rw.body[br].name != "spirv.Branch" {
                    return false;
                }
                let mut args = cr.rw.body[br].operands.clone();
                args.extend(ops.iter().copied());
                let target = cr.rw.body[br].successors[0];
                cr.rw.set_before(br);
                let mut data = OpData::build("spirv.Branch").operands(&args);
                data.successors = smallvec::smallvec![target];
                cr.rw.create(data, &[]);
                cr.erase(br);
            }
        }
        cr.erase(op);
        true
    }

    #[convert("scf.while")]
    fn while_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let Some(inits) = Cr::one_to_one(operands) else { return false };
        let Some(current) = cr.current else { return false };
        let [before_r, after_r] = [0, 1].map(|i| cr.rw.body[op].regions[i]);
        if cr.convert_region_types(before_r, current, None).is_none() || cr.convert_region_types(after_r, current, None).is_none() {
            return false;
        }
        let (new, region) = Self::construct(cr, op, "spirv.mlir.loop", ("loop_control", "loop_control"));
        let (entry, merge) = Self::entry_and_merge(cr, region);
        let before = cr.rw.body[before_r].blocks[0];
        let after = cr.rw.body[after_r].blocks[0];
        let cond = cr.rw.body.last_op(before).expect("scf.condition");
        let yield_ = cr.rw.body.last_op(after).expect("scf.yield");
        let Some(cond_ops) = cr.remap(&cr.rw.body[cond].operands.clone(), None) else { return false };
        let Some(cond_ops) = Cr::one_to_one(&cond_ops) else { return false };
        let Some(yield_ops) = cr.remap(&cr.rw.body[yield_].operands.clone(), None) else { return false };
        let Some(yield_ops) = Cr::one_to_one(&yield_ops) else { return false };
        let (cond_v, cond_args) = (cond_ops[0], cond_ops[1..].to_vec());
        cr.inline_region(before_r, region, Some(merge));
        cr.inline_region(after_r, region, Some(merge));
        Self::br(cr, entry, before, &inits);
        let mut results = Vec::new();
        for a in &cond_args {
            let t = cr.rw.body[*a].ty.clone();
            cr.rw.set_before(new);
            let var = cr.build(OpData::build("spirv.Variable").with("storage_class", Cr::spirv_enum("storage_class", "Function")), SpirvType::ptr(t.clone(), "Function"));
            cr.rw.set_after(new);
            results.push(cr.build(OpData::build("spirv.Load").operands(&[var]), t));
            cr.rw.set_before(cond);
            cr.rw.create(OpData::build("spirv.Store").operands(&[var, *a]), &[]);
        }
        cr.rw.set_before(cond);
        let mut ops = vec![cond_v];
        ops.extend(cond_args.iter().copied());
        let mut data = OpData::build("spirv.BranchConditional").operands(&ops).with("operandSegmentSizes", Attribute::DenseArray { ty: Type::int(32), values: vec!["1".into(), alloc::format!("{}", cond_args.len()).into(), "0".into()].into() });
        data.successors = smallvec::smallvec![after, merge];
        cr.rw.create(data, &[]);
        cr.erase(cond);
        cr.rw.set_before(yield_);
        let mut data = OpData::build("spirv.Branch").operands(&yield_ops);
        data.successors = smallvec::smallvec![before];
        cr.rw.create(data, &[]);
        cr.erase(yield_);
        cr.replace_values(op, &results);
        true
    }
}
