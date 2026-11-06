//! `convert-affine-for-to-gpu`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use mlirformat::{Attribute, Error, Type};
use crate::AffineExpand;
use crate::{Body, BlockId, InsertPoint, OpData, OpId, Rewriter, ValueId};

/// `convert-affine-for-to-gpu`.
#[crate::pass("convert-affine-for-to-gpu")]
pub struct ConvertAffineForToGpu {
    #[opt("gpu-block-dims", default = 1)]
    blocks: u64,
    #[opt("gpu-thread-dims", default = 1)]
    threads: u64,
}

impl ConvertAffineForToGpu {
    /// `checkAffineLoopNestMappable`.
    fn mappable(&self, body: &Body<'_>, root: OpId) -> Result<(), Error> {
        if self.blocks < 1 || self.threads < 1 {
            return Ok(());
        }
        if self.blocks > 3 {
            return Err(Error(String::from("'affine.for' op cannot map to more than 3 block dimensions")));
        }
        if self.threads > 3 {
            return Err(Error(String::from("'affine.for' op cannot map to more than 3 thread dimensions")));
        }
        let limit = body[root].regions[0];
        let mut f = root;
        let n = (self.blocks + self.threads) as usize;
        for i in 0..n {
            let segs = body.segments(f, "operandSegmentSizes").unwrap_or_default();
            let bounds = &body[f].operands[..segs[0] + segs[1]];
            let above = bounds.iter().all(|v| body.value_block(*v).and_then(|b| body[b].parent).is_none_or(|r| !Self::within(body, r, limit)));
            if !above {
                return Err(Error(String::from("'affine.for' op loops with bounds depending on other mapped loops are not supported")));
            }
            if i == n - 1 {
                break;
            }
            let blk = body[body[f].regions[0]].blocks[0];
            if body.len_ops(blk) != 2 {
                return Err(Error(String::from("'affine.for' op expected perfectly nested loops in the body")));
            }
            let nested = body.first_op(blk).expect("an op in the block");
            if body[nested].name != "affine.for" {
                return Err(Error(format!("'{}' op expected a nested loop", body[nested].name)));
            }
            f = nested;
        }
        Ok(())
    }

    fn within(body: &Body<'_>, mut r: crate::RegionId, of: crate::RegionId) -> bool {
        loop {
            if r == of {
                return true;
            }
            match body[body[r].parent].parent.and_then(|b| body[b].parent) {
                Some(up) => r = up,
                None => return false,
            }
        }
    }

    /// `AffineLoopToGpuConverter`: the bounds of the nest, a launch over them, the innermost
    /// body in it.
    fn convert(&self, rw: &mut Rewriter<'_, '_>, root: OpId) -> Option<()> {
        let n = (self.blocks + self.threads) as usize;
        let (blocks, threads) = (self.blocks as usize, self.threads as usize);
        rw.set_before(root);
        let (mut dims, mut lbs, mut ivs, mut steps) = (Vec::new(), Vec::new(), Vec::new(), Vec::new());
        let mut cur = root;
        for i in 0..n {
            let segs = rw.body.segments(cur, "operandSegmentSizes").unwrap_or_default();
            let ops = rw.body[cur].operands.clone();
            let (lbo, ubo) = (&ops[..segs[0]], &ops[segs[0]..segs[0] + segs[1]]);
            let (lbm, ubm) = (rw.body.affine_map(cur, "lowerBoundMap")?, rw.body.affine_map(cur, "upperBoundMap")?);
            let lb = rw.min_max(&lbm, lbo, true)?;
            let ub = rw.min_max(&ubm, ubo, false)?;
            let mut range = rw.arith2("arith.subi", ub, lb);
            let step_v = rw.body.for_step(cur);
            let step = rw.index_constant(step_v);
            if step_v != 1 {
                range = rw.arith2("arith.ceildivsi", range, step);
            }
            dims.push(range);
            lbs.push(lb);
            let blk = rw.body[rw.body[cur].regions[0]].blocks[0];
            ivs.push(rw.body[blk].args[0]);
            steps.push((step, step_v));
            if i != n - 1 {
                cur = rw.body.first_op(blk).expect("an op in the block");
            }
        }
        let loc = rw.body[root].loc.clone();
        let one = (blocks < 3 || threads < 3).then(|| rw.index_constant(1));
        let size = |k: usize, have: usize, off: usize| if k < have { Some(dims[off + k]) } else { one };
        let sizes: Vec<ValueId> = (0..3).map(|k| size(k, blocks, 0)).chain((0..3).map(|k| size(k, threads, blocks))).collect::<Option<_>>()?;
        let mut data = OpData::build("gpu.launch").operands(&sizes).with("operandSegmentSizes", Attribute::dense_i32(&[0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0])).with("workgroup_attributions", Attribute::integer(0, Type::int(64)));
        data.loc = loc.clone();
        let launch = rw.create_with(data, &[], |b, o| {
            let r = b.add_region(o);
            b.add_block(r, &vec![(Type::Index, loc.clone()); 12]);
        });
        let inner = rw.body[rw.body[cur].regions[0]].blocks[0];
        let term = rw.body.last_op(inner)?;
        let mut t = OpData::build("gpu.terminator");
        t.loc = rw.body[term].loc.clone();
        rw.body.erase(term);
        let t = rw.body.create(t, &[]);
        rw.body.insert(t, inner, None);
        let lblock: BlockId = rw.body[rw.body[launch].regions[0]].blocks[0];
        let front = rw.body.first_op(lblock);
        rw.body.splice(inner, None, lblock, front);
        rw.ip = Some(InsertPoint { block: lblock, before: rw.body.first_op(lblock) });
        let args = rw.body[lblock].args.clone();
        for (i, iv) in ivs.iter().enumerate() {
            let mut id = if i < blocks { args[i] } else { args[3 + i - blocks] };
            let (step, sv) = steps[i];
            if sv != 1 {
                id = rw.arith2("arith.muli", step, id);
            }
            let repl = rw.arith2("arith.addi", lbs[i], id);
            rw.body.replace_all_uses(*iv, repl);
        }
        rw.body.erase(root);
        Some(())
    }
}

impl crate::Run for ConvertAffineForToGpu {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let Some(&region) = body[op].regions.first() else { return Ok(()) };
        let loops: Vec<OpId> = body[region].blocks.iter().flat_map(|b| body.block_ops(*b)).filter(|o| body[*o].name == "affine.for").collect();
        for f in loops {
            self.mappable(body, f)?;
            let mut quiet = crate::Quiet;
            let mut rw = Rewriter::new(body, &mut quiet);
            self.convert(&mut rw, f).ok_or_else(|| Error(String::from("convert-affine-for-to-gpu failed")))?;
        }
        Ok(())
    }
}
