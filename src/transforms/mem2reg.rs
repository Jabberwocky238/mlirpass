//! `mem2reg`, as `Mem2Reg.cpp`: memory slots whose every use can be removed become SSA values.
//!
//! ```text
//! analysis   blocking uses (the forward slice of the slot pointer, each user asked whether it can
//!            drop them) ⇒ merge points (the iterated dominance frontier of the stores, pruned to
//!            the blocks where the slot is live-in) ⇒ their predecessors must be branches
//! mutation   reaching definitions down the dominator tree (merge points get a block argument)
//!            ⇒ blocking uses removed in reverse dominance order ⇒ dead branches forward the default
//! ```
//!
//! The dialects' promotion interfaces are [`Promotable`] implementations: `llvm` here
//! (below, as `LLVMMemorySlot.cpp`), `memref` in `memref_slots.rs`.

use alloc::borrow::Cow;
use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::pass;
use mlirformat::llvm_types::LlvmType;
use mlirformat::{llvm, Attribute, Error, ShapedKind, Type};

use super::memref_slots::TestSlots;
use super::memslot::{Deletion, LlvmSlots, MemorySlot, MemrefSlots, Promotable};
use crate::{BlockId, Body, DataLayout, DomTree, OpId, Quiet, RegionId, Rewriter, TypedOp, Use, ValueId};


/// `region-simplify` is accepted and, as in `Mem2Reg.cpp`, unused.
#[pass("mem2reg", ty = Mem2Reg, extra = ["region-simplify"])]
pub fn mem2reg<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let dialects: [&dyn Promotable; 3] = [&LlvmSlots, &MemrefSlots, &TestSlots];
    let promotion = Promotion { dialects: &dialects };
    for r in body[op].regions.clone() {
        if body[r].blocks.is_empty() {
            continue;
        }
        let allocators = promotion.allocators(body, r);
        promotion.promote_all(body, allocators);
    }
    Ok(())
}

/// `MemorySlotPromotionInfo`, and the promoter's state once promotion starts.
#[derive(Default)]
struct Info {
    /// Blocks where two definitions of the slot meet.
    merge_points: BTreeSet<BlockId>,
    /// Each user that must drop uses, in the order they were found, with those uses.
    blocking: Vec<(OpId, Vec<Use>)>,
    /// The slot pointer's region.
    region: Option<RegionId>,
    /// The slot's value before any store.
    default: Option<ValueId>,
    /// The slot's value just before each blocking memory op.
    reaching: BTreeMap<OpId, ValueId>,
    /// The value each storing op stores.
    replaced: BTreeMap<OpId, ValueId>,
}

impl Info {
    fn uses_of(&mut self, op: OpId) -> &mut Vec<Use> {
        let i = match self.blocking.iter().position(|(o, _)| *o == op) {
            Some(i) => i,
            None => {
                self.blocking.push((op, Vec::new()));
                self.blocking.len() - 1
            }
        };
        &mut self.blocking[i].1
    }

    fn get(&self, op: OpId) -> &[Use] {
        self.blocking.iter().find(|(o, _)| *o == op).map_or(&[], |(_, u)| u)
    }
}

/// `tryToPromoteMemorySlots` over the dialects the pass knows.
struct Promotion<'d> {
    dialects: &'d [&'d dyn Promotable],
}

impl<'d> Promotion<'d> {
    fn at(&self, b: &Body<'_>, op: OpId) -> Option<&'d dyn Promotable> {
        b.promotable(self.dialects, op)
    }

    /// The `PromotableAllocationOpInterface` ops in `region`, as `region.walk` visits them:
    /// post-order, an op's regions before the op.
    fn allocators(&self, b: &Body<'_>, region: RegionId) -> Vec<OpId> {
        let mut out = Vec::new();
        for block in &b[region].blocks {
            for op in &b[*block].ops {
                for r in &b[*op].regions {
                    out.extend(self.allocators(b, *r));
                }
                if self.at(b, *op).is_some_and(|d| d.promotable_slots(b, *op).is_some()) {
                    out.push(*op);
                }
            }
        }
        out
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        self.at(b, op).is_some_and(|d| d.is_mem_op(b, op))
    }

    /// `tryToPromoteMemorySlots`: whether any slot was promoted.
    fn promote_all(&self, body: &mut Body<'_>, mut work: Vec<OpId>) -> bool {
        let mut any = false;
        loop {
            let mut next = Vec::new();
            let mut round = false;
            for alloc in work {
                let mut changed = false;
                let slots = self.at(body, alloc).and_then(|d| d.promotable_slots(body, alloc)).unwrap_or_default();
                for slot in slots {
                    if body[slot.ptr].uses.is_empty() {
                        continue;
                    }
                    let Some(info) = self.analyze(body, &slot) else { continue };
                    if let Some(new) = self.promote(body, alloc, &slot, info) {
                        next.push(new);
                    }
                    changed = true;
                    // Promoting a slot may invalidate the allocator's other slots.
                    break;
                }
                if !changed {
                    next.push(alloc);
                }
                round |= changed;
            }
            if !round {
                return any;
            }
            any = true;
            work = next;
        }
    }

    // ---- analysis ---------------------------------------------------------------------------

    /// `MemorySlotPromotionAnalyzer::computeInfo`.
    fn analyze<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>) -> Option<Info> {
        let region = b.value_region(slot.ptr)?;
        let mut info = Info { region: Some(region), ..Info::default() };
        self.blocking_uses(b, slot, &mut info)?;
        info.merge_points = self.merge_points(b, slot, region);
        // Every predecessor of a merge point must be able to forward a value.
        let usable = info.merge_points.iter().all(|m| b.predecessors(*m).iter().all(|(t, _)| b.is_branch(*t)));
        usable.then_some(info)
    }

    /// `computeBlockingUses`.
    fn blocking_uses<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, info: &mut Info) -> Option<()> {
        let region = b.value_region(slot.ptr)?;
        if !b.has_ssa_dominance(region) {
            return None;
        }
        // MLIR's use lists are most-recent-first.
        for u in b[slot.ptr].uses.iter().rev() {
            info.uses_of(u.op).push(*u);
        }
        for user in b.forward_slice(slot.ptr) {
            let Some(uses) = info.blocking.iter().find(|(o, _)| *o == user).map(|(_, u)| u.clone()) else { continue };
            let mut sorted = uses;
            sorted.sort_by_key(|u| u.index);
            let d = self.at(b, user)?;
            let mut new = Vec::new();
            let mem = d.is_mem_op(b, user);
            if !d.can_uses_be_removed(b, user, mem.then_some(slot), &sorted, &mut new)? {
                return None;
            }
            for u in new {
                info.uses_of(u.op).push(u);
            }
        }
        // Only the slot pointer's own region is analysed.
        let outside = info.blocking.iter().any(|(o, _)| self.is_mem_op(b, *o) && b[*o].parent.and_then(|k| b[k].parent) != Some(region));
        (!outside).then_some(())
    }

    /// `computeSlotLiveIn`: blocks entered with the slot's value still to be read.
    fn live_in<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, defining: &BTreeSet<BlockId>) -> BTreeSet<BlockId> {
        let mut work = Vec::new();
        let mut seen = BTreeSet::new();
        for u in b[slot.ptr].uses.iter().rev() {
            let Some(block) = b[u.op].parent else { continue };
            if !seen.insert(block) {
                continue;
            }
            for op in &b[block].ops {
                let Some(d) = self.at(b, *op).filter(|d| d.is_mem_op(b, *op)) else { continue };
                if d.loads_from(b, *op, slot) {
                    work.push(block);
                    break;
                }
                if d.stores_to(b, *op, slot) {
                    break;
                }
            }
        }
        let mut live = BTreeSet::new();
        while let Some(block) = work.pop() {
            if !live.insert(block) {
                continue;
            }
            for (t, _) in b.predecessors(block) {
                if let Some(p) = b[t].parent.filter(|p| !defining.contains(p)) {
                    work.push(p);
                }
            }
        }
        live
    }

    /// `computeMergePoints`: the iterated dominance frontier of the stores, pruned to live-in
    /// blocks.
    fn merge_points<'a>(&self, b: &Body<'a>, slot: &MemorySlot<'a>, region: RegionId) -> BTreeSet<BlockId> {
        if b[region].blocks.len() == 1 {
            return BTreeSet::new();
        }
        let defining: BTreeSet<BlockId> = b[slot.ptr].uses.iter().filter(|u| self.at(b, u.op).is_some_and(|d| d.is_mem_op(b, u.op) && d.stores_to(b, u.op, slot))).filter_map(|u| b[u.op].parent).collect();
        let live = self.live_in(b, slot, &defining);
        let tree = b.dom_tree(region);
        let frontier = b.dominance_frontiers(region, &tree);
        let mut merge = BTreeSet::new();
        let mut work: Vec<BlockId> = defining.iter().copied().collect();
        let mut queued: BTreeSet<BlockId> = defining.clone();
        while let Some(x) = work.pop() {
            for y in frontier.get(&x).into_iter().flatten() {
                if !live.contains(y) || !merge.insert(*y) {
                    continue;
                }
                if queued.insert(*y) {
                    work.push(*y);
                }
            }
        }
        merge
    }

    // ---- mutation ---------------------------------------------------------------------------

    /// `MemorySlotPromoter::promoteSlot`; the new allocator, if any.
    fn promote<'a>(&self, body: &mut Body<'a>, alloc: OpId, slot: &MemorySlot<'a>, mut info: Info) -> Option<OpId> {
        let d = self.at(body, alloc).expect("an allocator's dialect");
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        // `getOrCreateDefaultValue`, at the start of the slot pointer's block.
        rw.set_start(rw.body.value_block(slot.ptr).expect("a placed slot"));
        let default = d.default_value(&mut rw, alloc, slot);
        info.default = Some(default);
        self.reaching_defs(&mut rw, d, alloc, slot, &mut info);
        self.remove_blocking_uses(&mut rw, slot, &info);
        // Branches of dead predecessors forward the default.
        for m in &info.merge_points {
            let n = rw.body[*m].args.len();
            for (t, i) in rw.body.predecessors(*m) {
                if rw.body.successor_operands(t, i).is_some_and(|r| r.len() + 1 == n) {
                    rw.body.append_successor_operands(t, i, &[default]);
                }
            }
        }
        d.handle_promotion_complete(&mut rw, alloc, slot, Some(default))
    }

    /// `computeReachingDefInRegion`: down the dominator tree, depth first.
    fn reaching_defs<'a>(&self, rw: &mut Rewriter<'_, 'a>, d: &dyn Promotable, alloc: OpId, slot: &MemorySlot<'a>, info: &mut Info) {
        let (region, default) = (info.region.expect("analysed"), info.default.expect("created"));
        let entry = rw.body[region].blocks[0];
        if rw.body[region].blocks.len() == 1 {
            self.reaching_in_block(rw, slot, info, entry, default);
            return;
        }
        let tree = rw.body.dom_tree(region);
        let mut stack = vec![(entry, default)];
        while let Some((block, mut def)) = stack.pop() {
            if info.merge_points.contains(&block) {
                let arg = rw.body.add_arg(block, slot.elem.clone());
                rw.body[arg].loc = rw.body[slot.ptr].loc.clone();
                rw.set_start(block);
                d.handle_block_argument(rw, alloc, slot, arg);
                def = arg;
            }
            def = self.reaching_in_block(rw, slot, info, block, def);
            if let Some(&t) = rw.body[block].ops.last()
                && rw.body.is_branch(t)
            {
                for (i, s) in rw.body[t].successors.clone().into_iter().enumerate() {
                    if info.merge_points.contains(&s) {
                        rw.body.append_successor_operands(t, i, &[def]);
                    }
                }
            }
            stack.extend(tree.children(block).iter().map(|c| (*c, def)));
        }
    }

    /// `computeReachingDefInBlock`: the definition reaching the end of `block`.
    fn reaching_in_block<'a>(&self, rw: &mut Rewriter<'_, 'a>, slot: &MemorySlot<'a>, info: &mut Info, block: BlockId, mut def: ValueId) -> ValueId {
        for op in rw.body[block].ops.clone() {
            let Some(d) = self.at(rw.body, op).filter(|d| d.is_mem_op(rw.body, op)) else { continue };
            if info.blocking.iter().any(|(o, _)| *o == op) {
                info.reaching.entry(op).or_insert(def);
            }
            if d.stores_to(rw.body, op, slot) {
                rw.set_after(op);
                def = d.stored(rw, op, slot, def);
                info.replaced.insert(op, def);
            }
        }
        def
    }

    /// `removeBlockingUses`: users in reverse dominance order, then the scheduled erasures.
    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, slot: &MemorySlot<'a>, info: &Info) {
        let order = rw.body.blocks_by_dominance(info.region.expect("analysed"));
        let mut users: Vec<OpId> = info.blocking.iter().map(|(o, _)| *o).collect();
        users.sort_by_key(|o| {
            let block = rw.body[*o].parent.expect("a placed user");
            (order.iter().position(|b| *b == block).unwrap_or(usize::MAX), rw.body.position(*o))
        });
        let mut erase = Vec::new();
        let mut replaced_list = Vec::new();
        let mut visit = Vec::new();
        for op in users.into_iter().rev() {
            let d = self.at(rw.body, op).expect("a promotable user");
            let mut uses = info.get(op).to_vec();
            uses.sort_by_key(|u| u.index);
            rw.set_after(op);
            if d.is_mem_op(rw.body, op) {
                let def = info.reaching.get(&op).copied().or(info.default).expect("created");
                if d.remove_blocking_uses(rw, op, Some(slot), &uses, Some(def)) == Deletion::Delete {
                    erase.push(op);
                }
                if d.stores_to(rw.body, op, slot)
                    && let Some(v) = info.replaced.get(&op)
                {
                    replaced_list.push((op, *v));
                }
                continue;
            }
            if d.remove_blocking_uses(rw, op, None, &uses, None) == Deletion::Delete {
                erase.push(op);
            }
            if d.requires_replaced_values(rw.body, op) {
                visit.push((d, op));
            }
        }
        for (d, op) in visit {
            rw.set_after(op);
            d.visit_replaced_values(rw, op, &replaced_list);
        }
        for op in erase {
            rw.body.drop_result_uses(op);
            rw.body.erase(op);
        }
    }
}

impl Body<'_> {
    /// The region defining `v`.
    fn value_region(&self, v: ValueId) -> Option<RegionId> {
        self.value_block(v).and_then(|b| self[b].parent)
    }

    /// Dominance frontiers of `region`'s reachable blocks (Cooper, Harvey & Kennedy).
    fn dominance_frontiers(&self, region: RegionId, tree: &DomTree) -> BTreeMap<BlockId, BTreeSet<BlockId>> {
        let mut df: BTreeMap<BlockId, BTreeSet<BlockId>> = BTreeMap::new();
        for b in self[region].blocks.iter().filter(|b| tree.reachable(**b)) {
            let preds: Vec<BlockId> = self.predecessors(*b).iter().filter_map(|(t, _)| self[*t].parent).filter(|p| tree.reachable(*p)).collect();
            if preds.len() < 2 {
                continue;
            }
            let idom = tree.idom(*b);
            for p in preds {
                let mut runner = Some(p);
                while let Some(r) = runner.filter(|r| Some(*r) != idom) {
                    df.entry(r).or_default().insert(*b);
                    runner = tree.idom(r);
                }
            }
        }
        df
    }

}

// ---- the `llvm` dialect's promotion interfaces (`LLVMMemorySlot.cpp`) ---------------------

/// How an op takes part in promotion.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Role {
    Alloca,
    Load,
    Store,
    Memset,
    /// `memcpy`-like: memcpy, memcpy.inline, memmove.
    Memcpy,
    /// Deleted once its results' uses are (`forwardToUsers`).
    Forward,
    /// Deleted outright.
    Drop,
    DbgValue,
}

impl Role {
    fn of(b: &Body<'_>, op: OpId) -> Option<Self> {
        Some(match &*b[op].name {
            "llvm.alloca" => Self::Alloca,
            "llvm.load" => Self::Load,
            "llvm.store" => Self::Store,
            "llvm.intr.memset" | "llvm.intr.memset.inline" => Self::Memset,
            "llvm.intr.memcpy" | "llvm.intr.memcpy.inline" | "llvm.intr.memmove" => Self::Memcpy,
            "llvm.bitcast" | "llvm.addrspacecast" | "llvm.intr.launder.invariant.group" | "llvm.intr.strip.invariant.group" => Self::Forward,
            "llvm.getelementptr" if b.dense_i64(op, "rawConstantIndices").iter().all(|i| *i == 0) => Self::Forward,
            "llvm.intr.lifetime.start" | "llvm.intr.lifetime.end" | "llvm.intr.invariant.start" | "llvm.intr.invariant.end" | "llvm.intr.dbg.declare" => Self::Drop,
            "llvm.intr.dbg.value" => Self::DbgValue,
            _ => return None,
        })
    }

    fn mem(self) -> bool {
        matches!(self, Self::Load | Self::Store | Self::Memset | Self::Memcpy)
    }
}

/// Type facts the conversions need.
struct Ty;

impl Ty {
    fn is_ptr(t: &Type<'_>) -> bool {
        matches!(LlvmType::try_from(t), Ok(LlvmType::Ptr(_)))
    }

    /// `isSupportedTypeForConversion`.
    fn convertible(t: &Type<'_>) -> bool {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => !Self::is_ptr(&s.elem) && !s.shape.iter().flatten().any(|d| matches!(d, mlirformat::Dim::Scalable(_))),
            _ => !matches!(LlvmType::try_from(t), Ok(LlvmType::Struct { .. } | LlvmType::Array(..))),
        }
    }

    /// `areConversionCompatible`.
    fn compatible(dl: &DataLayout, target: &Type<'_>, src: &Type<'_>, narrowing: bool) -> bool {
        if target == src {
            return true;
        }
        if !Self::convertible(target) || !Self::convertible(src) {
            return false;
        }
        let (t, s) = (dl.size(target), dl.size(src));
        if Self::is_ptr(target) && Self::is_ptr(src) {
            return t == s;
        }
        if narrowing { t <= s } else { t >= s }
    }

    fn int(bits: u64) -> Type<'static> {
        Type::int(bits as u32)
    }

    /// An integer attribute of integer type `ty` holding the low bits of `v`, as MLIR prints it.
    fn int_attr<'a>(v: u128, ty: &Type<'a>) -> Attribute<'a> {
        let Type::Integer { width: bits, .. } = ty else { unreachable!("an integer type") };
        let shift = 128 - bits;
        Attribute::Int { lit: Cow::Owned(format!("{}", ((v << shift) as i128) >> shift)), ty: Some(ty.clone()) }
    }

    fn width(t: &Type<'_>) -> Option<u64> {
        match t {
            Type::Integer { width, .. } => Some(u64::from(*width)),
            Type::Float(_) => t.bit_width().map(u64::from),
            _ => None,
        }
    }
}

impl<'a> Rewriter<'_, 'a> {
    /// `createOrFold` of a typed op; its result.
    fn slot_fold(&mut self, op: &impl TypedOp) -> ValueId {
        let (data, types) = op.split();
        self.create_or_fold(data, &types)[0]
    }

    /// `create` of a typed op; its first result.
    fn slot_emit(&mut self, op: &impl TypedOp) -> ValueId {
        let o = self.emit(op);
        self.body[o].results[0]
    }

    fn ty(&self, v: ValueId) -> Type<'a> {
        self.body[v].ty.clone()
    }

    /// `castToSameSizedInt`.
    fn to_same_sized_int(&mut self, dl: &DataLayout, v: ValueId) -> ValueId {
        let t = self.ty(v);
        if matches!(t, Type::Integer { .. }) {
            return v;
        }
        let int = Ty::int(dl.size_in_bits(&t));
        if Ty::is_ptr(&t) { self.slot_fold(&llvm::PtrToIntOp::new(v.into(), t, int)) } else { self.slot_fold(&llvm::BitcastOp::new(v.into(), t, int)) }
    }

    /// `castIntValueToSameSizedType`.
    fn int_to(&mut self, v: ValueId, target: &Type<'a>) -> ValueId {
        let t = self.ty(v);
        if &t == target {
            return v;
        }
        if Ty::is_ptr(target) { self.slot_fold(&llvm::IntToPtrOp::new(v.into(), None, t, target.clone())) } else { self.slot_fold(&llvm::BitcastOp::new(v.into(), t, target.clone())) }
    }

    /// `castSameSizedTypes`.
    fn same_sized(&mut self, dl: &DataLayout, v: ValueId, target: &Type<'a>) -> ValueId {
        let t = self.ty(v);
        if &t == target {
            return v;
        }
        if Ty::is_ptr(&t) && Ty::is_ptr(target) {
            return self.slot_fold(&llvm::AddrSpaceCastOp::new(v.into(), t, target.clone()));
        }
        let int = self.to_same_sized_int(dl, v);
        self.int_to(int, target)
    }

    /// `createExtractAndCast`: the low (little endian) or high (big endian) bits of `v`.
    fn extract_and_cast(&mut self, dl: &DataLayout, v: ValueId, target: &Type<'a>) -> ValueId {
        let vt = self.ty(v);
        let (src, dst) = (dl.size_in_bits(&vt), dl.size_in_bits(target));
        if src == dst {
            return self.same_sized(dl, v, target);
        }
        let mut int = self.to_same_sized_int(dl, v);
        if dl.big_endian() {
            // As upstream: the shift applies to `v` itself, typed as `v`.
            let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(src - dst), &vt), vt.clone()));
            int = self.slot_fold(&llvm::LShrOp::new(v.into(), by.into(), false, vt));
        }
        let it = self.ty(int);
        let trunc = self.slot_emit(&llvm::TruncOp::new(int.into(), Ty::int_attr(0, &Type::int(32)), it, Ty::int(dst)));
        self.int_to(trunc, target)
    }

    /// `createInsertAndCast`: `v` into the bits of `reaching` a store to its address writes.
    fn insert_and_cast(&mut self, dl: &DataLayout, v: ValueId, reaching: ValueId) -> ValueId {
        let rt = self.ty(reaching);
        let (value_bits, slot_bits) = (dl.size_in_bits(&self.ty(v)), dl.size_in_bits(&rt));
        if value_bits == slot_bits {
            return self.same_sized(dl, v, &rt);
        }
        let def = self.to_same_sized_int(dl, reaching);
        let value = self.to_same_sized_int(dl, v);
        let (dt, vt) = (self.ty(def), self.ty(value));
        let mut value = self.slot_fold(&llvm::ZExtOp::new(value.into(), false, vt, dt.clone()));
        let diff = slot_bits - value_bits;
        let mask = if dl.big_endian() {
            let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(diff), &dt), dt.clone()));
            value = self.slot_fold(&llvm::ShlOp::new(value.into(), by.into(), Ty::int_attr(0, &Type::int(32)), dt.clone()));
            (1u128 << diff) - 1
        } else {
            !((1u128 << value_bits) - 1)
        };
        let mask = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(mask, &dt), dt.clone()));
        let masked = self.slot_fold(&llvm::AndOp::new(def.into(), mask.into(), dt.clone()));
        let combined = self.slot_fold(&llvm::OrOp::new(masked.into(), value.into(), false, dt));
        self.int_to(combined, &rt)
    }

    /// `llvm.intr.dbg.value` of `v` for the variable `declare` describes.
    fn dbg_value(&mut self, declare: OpId, v: ValueId) {
        let var = self.body[declare].get("varInfo").cloned().expect("a declared variable");
        let expr = self.body[declare].get("locationExpr").cloned();
        let t = self.ty(v);
        self.emit(&llvm::DbgValueOp::new(v.into(), var, expr, t));
    }

    /// `memsetGetStored`: the slot's value after a memset of its whole size.
    fn memset_value(&mut self, op: OpId, slot: &MemorySlot<'a>) -> ValueId {
        let val = self.body[op].operands[1];
        let width = Ty::width(&slot.elem).expect("checked by canUsesBeRemoved");
        let int = Ty::int(width);
        let v = if let Some(byte) = self.body.const_index(val) {
            let byte = (byte as u128) & 0xff;
            let pattern = (0..width / 8).fold(0u128, |acc, k| acc | (byte << (8 * k)));
            self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(pattern, &int), int.clone()))
        } else if width == 8 {
            val
        } else {
            let mut cur = self.slot_emit(&llvm::ZExtOp::new(val.into(), false, Type::int(8), int.clone()));
            let mut covered = 8;
            while covered < width {
                let by = self.slot_emit(&llvm::ConstantOp::new(Ty::int_attr(u128::from(covered), &int), int.clone()));
                let shifted = self.slot_emit(&llvm::ShlOp::new(cur.into(), by.into(), Ty::int_attr(0, &Type::int(32)), int.clone()));
                cur = self.slot_emit(&llvm::OrOp::new(cur.into(), shifted.into(), false, int.clone()));
                covered *= 2;
            }
            cur
        };
        if matches!(slot.elem, Type::Float(_)) { self.slot_emit(&llvm::BitcastOp::new(v.into(), int, slot.elem.clone())) } else { v }
    }
}

impl Body<'_> {
    /// The single blocking use is of the slot pointer.
    fn only_slot_use(&self, slot: &MemorySlot<'_>, blocking: &[Use]) -> bool {
        matches!(blocking, [u] if self[u.op].operands[u.index as usize] == slot.ptr)
    }
}

impl Promotable for LlvmSlots {
    fn dialect(&self) -> &str {
        "llvm"
    }

    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        if Role::of(b, op)? != Role::Alloca {
            return None;
        }
        let block = b[op].parent?;
        if b[block].parent.map(|r| b[r].blocks[0]) != Some(block) {
            return Some(Vec::new());
        }
        let Some(Attribute::Type(elem)) = b[op].get("elem_type") else { return Some(Vec::new()) };
        Some(alloc::vec![MemorySlot { ptr: b[op].results[0], elem: elem.clone() }])
    }

    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, _alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        rw.slot_emit(&llvm::UndefOp::new(slot.elem.clone()))
    }

    fn handle_block_argument<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _slot: &MemorySlot<'a>, arg: ValueId) {
        let r = rw.body[alloc].results[0];
        let declares: Vec<OpId> = rw.body[r].uses.iter().rev().map(|u| u.op).filter(|o| rw.body[*o].name == "llvm.intr.dbg.declare").collect();
        for d in declares {
            rw.dbg_value(d, arg);
        }
    }

    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, _slot: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        if let Some(d) = default.filter(|d| rw.body[*d].uses.is_empty())
            && let Some(o) = rw.body.def_op(d)
        {
            rw.body.erase(o);
        }
        rw.body.drop_result_uses(alloc);
        rw.body.erase(alloc);
        None
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        Role::of(b, op).is_some_and(Role::mem)
    }

    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        match Role::of(b, op) {
            Some(Role::Load) => b[op].operands[0] == slot.ptr,
            Some(Role::Memcpy) => b[op].operands[1] == slot.ptr,
            _ => false,
        }
    }

    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        match Role::of(b, op) {
            Some(Role::Store) => b[op].operands[1] == slot.ptr,
            Some(Role::Memset | Role::Memcpy) => b[op].operands[0] == slot.ptr,
            _ => false,
        }
    }

    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId) -> ValueId {
        match Role::of(rw.body, op) {
            Some(Role::Store) => {
                let v = rw.body[op].operands[0];
                let dl = DataLayout::closest(rw.body, op);
                rw.insert_and_cast(&dl, v, reaching)
            }
            Some(Role::Memset) => rw.memset_value(op, slot),
            Some(Role::Memcpy) => {
                let src = rw.body[op].operands[1];
                let st = rw.ty(src);
                rw.slot_emit(&llvm::LoadOp::new(src.into(), None, false, false, false, false, llvm::AtomicOrdering::NotAtomic, None, None, None, None, None, None, st, slot.elem.clone()))
            }
            _ => unreachable!("not a storing op"),
        }
    }

    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], new_blocking: &mut Vec<Use>) -> Option<bool> {
        let role = Role::of(b, op)?;
        let forward = |new: &mut Vec<Use>| {
            for r in &b[op].results {
                new.extend(b[*r].uses.iter().rev().copied());
            }
            true
        };
        let dl = DataLayout::closest(b, op);
        Some(match (role, slot) {
            (Role::Forward, None) => forward(new_blocking),
            (Role::Drop, None) => true,
            (Role::DbgValue, None) => matches!(blocking, [u] if u.index == 0),
            (Role::Load, Some(s)) => b.only_slot_use(s, blocking) && b[op].operands[0] == s.ptr && Ty::compatible(&dl, &b[b[op].results[0]].ty, &s.elem, true) && b[op].get("volatile_").is_none(),
            (Role::Store, Some(s)) => {
                let (value, addr) = (b[op].operands[0], b[op].operands[1]);
                b.only_slot_use(s, blocking) && addr == s.ptr && value != s.ptr && Ty::compatible(&dl, &s.elem, &b[value].ty, false) && b[op].get("volatile_").is_none()
            }
            (Role::Memset, Some(s)) => Ty::width(&s.elem).is_some_and(|w| w % 8 == 0 && w > 0) && !b.is_volatile(op) && b.mem_intr_len(op) == Some(dl.size(&s.elem)),
            (Role::Memcpy, Some(_)) if b[op].operands[0] == b[op].operands[1] => false,
            (Role::Memcpy, Some(s)) => !b.is_volatile(op) && b.mem_intr_len(op) == Some(dl.size(&s.elem)),
            _ => return None,
        })
    }

    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: Option<&MemorySlot<'a>>, _blocking: &[Use], reaching: Option<ValueId>) -> Deletion {
        match Role::of(rw.body, op) {
            Some(Role::Load) => {
                let (r, def) = (rw.body[op].results[0], reaching.expect("a reaching definition"));
                let t = rw.ty(r);
                let dl = DataLayout::closest(rw.body, op);
                let new = rw.extract_and_cast(&dl, def, &t);
                rw.replace_all_uses(r, new);
                Deletion::Delete
            }
            Some(Role::Memcpy) => {
                let slot = slot.expect("a memory op's slot");
                if self.loads_from(rw.body, op, slot) {
                    let (def, dst) = (reaching.expect("a reaching definition"), rw.body[op].operands[0]);
                    let (vt, dt) = (rw.ty(def), rw.ty(dst));
                    rw.emit(&llvm::StoreOp::new(def.into(), dst.into(), None, false, false, false, llvm::AtomicOrdering::NotAtomic, None, None, None, None, None, vt, dt));
                }
                Deletion::Delete
            }
            Some(Role::DbgValue) => {
                // An undef keeps the variable's debug info: "optimized out".
                let v = rw.body[op].operands[0];
                rw.set_before(op);
                let t = rw.ty(v);
                let undef = rw.slot_emit(&llvm::UndefOp::new(t));
                rw.body.set_operand(op, 0, undef);
                Deletion::Keep
            }
            _ => Deletion::Delete,
        }
    }

    fn requires_replaced_values(&self, b: &Body<'_>, op: OpId) -> bool {
        b[op].name == "llvm.intr.dbg.declare"
    }

    fn visit_replaced_values<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, replaced: &[(OpId, ValueId)]) {
        for (at, v) in replaced {
            rw.set_after(*at);
            rw.dbg_value(op, *v);
        }
    }
}

