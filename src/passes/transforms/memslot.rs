use alloc::collections::{BTreeMap, BTreeSet};
use alloc::vec::Vec;

use mlirformat::{Attribute, Type};

use crate::{BlockId, Body, DataLayout, OpId, RegionId, Rewriter, Use, ValueId};

#[derive(Debug, Clone, PartialEq)]
pub struct MemorySlot<'a> {
    pub ptr: ValueId,
    pub elem: Type<'a>,
}

#[derive(Debug, Clone, PartialEq)]
pub struct DestructurableMemorySlot<'a> {
    pub slot: MemorySlot<'a>,
    pub subelements: Vec<(Attribute<'a>, Type<'a>)>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Deletion {
    Keep,
    Delete,
}

#[allow(unused_variables)]
pub trait Promotable {
    fn dialect(&self) -> &str;

    fn promotable_slots<'a>(&self, b: &Body<'a>, op: OpId) -> Option<Vec<MemorySlot<'a>>> {
        None
    }

    fn default_value<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>) -> ValueId {
        unreachable!("{}: not a promotable allocation", self.dialect())
    }

    fn handle_block_argument<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>, arg: ValueId) {}

    fn handle_promotion_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &MemorySlot<'a>, default: Option<ValueId>) -> Option<OpId> {
        None
    }

    fn is_mem_op(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    fn loads_from<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        false
    }

    fn stores_to<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>) -> bool {
        false
    }

    fn stored<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId) -> ValueId {
        unreachable!("{}: not a promotable memory op", self.dialect())
    }

    fn can_uses_be_removed<'a>(&self, b: &Body<'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], new_blocking: &mut Vec<Use>) -> Option<bool> {
        None
    }

    fn remove_blocking_uses<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: Option<&MemorySlot<'a>>, blocking: &[Use], reaching: Option<ValueId>) -> Deletion {
        Deletion::Keep
    }

    fn requires_replaced_values(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    fn visit_replaced_values<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, replaced: &[(OpId, ValueId)]) {}

    fn slot_aliases<'a>(&self, b: &Body<'a>, op: OpId, operand: usize, parent: &MemorySlot<'a>) -> Option<Vec<MemorySlot<'a>>> {
        None
    }

    fn project_to_alias<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, parent: &MemorySlot<'a>, alias: &MemorySlot<'a>, value: ValueId) -> ValueId {
        value
    }

    fn project_to_slot<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, parent: &MemorySlot<'a>, alias: &MemorySlot<'a>, value: ValueId, reaching: ValueId) -> ValueId {
        value
    }

    fn is_region_op(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    fn region_promotable<'a>(&self, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>, region: RegionId, stores: bool) -> Option<bool> {
        None
    }

    fn setup_promotion<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId, stores: bool) -> Vec<(RegionId, ValueId)> {
        Vec::new()
    }

    fn finalize_promotion<'a>(&self, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &MemorySlot<'a>, reaching: ValueId, stores: bool, at_end: &BTreeMap<BlockId, Option<ValueId>>) -> ValueId {
        reaching
    }
}

impl Body<'_> {
    pub fn use_list(&self, v: ValueId) -> Vec<Use> {
        self[v].uses.iter().rev().copied().collect()
    }

    pub fn topological_sort(&self, ops: &[OpId]) -> Vec<OpId> {
        if ops.len() <= 1 {
            return ops.to_vec();
        }
        let mut top = ops[0];
        while let Some(p) = self.parent_op(top) {
            top = p;
        }
        let mut out = Vec::new();
        let mut stack = alloc::vec![top];
        while let Some(op) = stack.pop() {
            if ops.contains(&op) {
                out.push(op);
            }
            for r in self[op].regions.iter().rev() {
                for blk in self.blocks_by_dominance(*r).into_iter().rev() {
                    stack.extend(self.block_ops(blk).iter().rev());
                }
            }
        }
        out
    }

    pub fn is_volatile(&self, op: OpId) -> bool {
        match self[op].get("volatile_").or_else(|| self[op].get("isVolatile")) {
            Some(Attribute::Bool(v)) => *v,
            Some(Attribute::Int { lit, .. }) => lit != "0" && lit != "false",
            Some(_) => true,
            None => false,
        }
    }

    pub fn mem_intr_len(&self, op: OpId) -> Option<u64> {
        let len = match self[op].get("len") {
            Some(a) => a.clone(),
            None => self.constant_of(*self[op].operands.get(2)?)?,
        };
        let i = crate::Const::try_from(&len).ok().filter(|c| !c.elements)?.as_int()?;
        (i.width <= 64).then(|| i.unsigned() as u64)
    }

    pub fn forward_slice(&self, v: ValueId) -> Vec<OpId> {
        let mut post = Vec::new();
        let mut seen = BTreeSet::new();
        let mut stack: Vec<(OpId, bool)> = self[v].uses.iter().rev().map(|u| (u.op, false)).collect();
        stack.reverse();
        while let Some((op, done)) = stack.pop() {
            if done {
                post.push(op);
                continue;
            }
            if !seen.insert(op) {
                continue;
            }
            stack.push((op, true));
            let users: Vec<OpId> = self[op].results.iter().flat_map(|r| self[*r].uses.iter().rev().map(|u| u.op)).collect();
            stack.extend(users.into_iter().rev().filter(|u| !seen.contains(u)).map(|u| (u, false)));
        }
        post.reverse();
        post
    }

    pub fn blocks_by_dominance(&self, region: RegionId) -> Vec<BlockId> {
        let mut out: Vec<BlockId> = Vec::new();
        for b in self[region].blocks.clone() {
            if out.contains(&b) {
                continue;
            }
            let mut rpo = self.post_order(b);
            rpo.retain(|x| !out.contains(x));
            rpo.reverse();
            out.extend(rpo);
        }
        out
    }

    pub fn promotable<'d>(&self, dialects: &[&'d dyn Promotable], op: OpId) -> Option<&'d dyn Promotable> {
        let ns = self[op].name.split_once('.').map(|(ns, _)| ns)?;
        dialects.iter().copied().find(|d| d.dialect() == ns)
    }
}

#[derive(Clone, Copy)]
pub struct Slots<'s> {
    pub dialects: &'s [&'s dyn Destructurable],
    pub layout: &'s DataLayout,
}

impl Slots<'_> {
    pub fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        self.dialects.iter().find_map(|d| d.subelements(ty))
    }

    pub fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        self.dialects.iter().find_map(|d| d.type_at(ty, index))
    }
}

#[allow(unused_variables)]
pub trait Destructurable {
    fn dialect(&self) -> &str;

    fn subelements<'a>(&self, ty: &Type<'a>) -> Option<Vec<(Attribute<'a>, Type<'a>)>> {
        None
    }

    fn type_at<'a>(&self, ty: &Type<'a>, index: &Attribute<'a>) -> Option<Type<'a>> {
        None
    }

    fn destructurable_slots<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId) -> Option<Vec<DestructurableMemorySlot<'a>>> {
        None
    }

    fn destructure<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>, used: &[Attribute<'a>], allocators: &mut Vec<OpId>) -> Vec<(Attribute<'a>, MemorySlot<'a>)> {
        unreachable!("{}: not a destructurable allocation", self.dialect())
    }

    fn handle_destructuring_complete<'a>(&self, rw: &mut Rewriter<'_, 'a>, alloc: OpId, slot: &DestructurableMemorySlot<'a>) -> Option<OpId> {
        None
    }

    fn ensure_only_safe_accesses<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &MemorySlot<'a>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> Option<bool> {
        None
    }

    fn is_accessor(&self, b: &Body<'_>, op: OpId) -> bool {
        false
    }

    fn can_rewire<'a>(&self, cx: Slots<'_>, b: &Body<'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, used: &mut Vec<Attribute<'a>>, must_be_safe: &mut Vec<MemorySlot<'a>>) -> bool {
        false
    }

    fn rewire<'a>(&self, cx: Slots<'_>, rw: &mut Rewriter<'_, 'a>, op: OpId, slot: &DestructurableMemorySlot<'a>, subslots: &[(Attribute<'a>, MemorySlot<'a>)]) -> Deletion {
        Deletion::Keep
    }
}

impl Body<'_> {
    pub fn destructurable<'d>(&self, dialects: &[&'d dyn Destructurable], op: OpId) -> Option<&'d dyn Destructurable> {
        let ns = self[op].name.split_once('.').map(|(ns, _)| ns)?;
        dialects.iter().copied().find(|d| d.dialect() == ns)
    }
}

#[cfg(feature = "dialect.memref")]
pub struct MemrefSlots;
