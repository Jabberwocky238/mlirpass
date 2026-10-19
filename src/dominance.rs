//! Dominance within a region, as `mlir/IR/Dominance.cpp` over LLVM's `DominatorTree`.
//!
//! The order of a node's children is LLVM's: by depth-first preorder from the entry block,
//! successors visited in their order. Passes that walk the tree (CSE) depend on it.

use alloc::collections::BTreeMap;
use alloc::vec;
use alloc::vec::Vec;

use crate::{Body, BlockId, RegionId, Trait};

/// The dominator tree of one region's reachable blocks.
#[derive(Debug, Clone)]
pub struct DomTree {
    pub root: BlockId,
    idom: BTreeMap<BlockId, BlockId>,
    children: BTreeMap<BlockId, Vec<BlockId>>,
}

impl DomTree {
    /// The immediate dominator (`None`: the root, or unreachable).
    pub fn idom(&self, b: BlockId) -> Option<BlockId> {
        self.idom.get(&b).copied().filter(|d| *d != b)
    }

    pub fn children(&self, b: BlockId) -> &[BlockId] {
        self.children.get(&b).map_or(&[], Vec::as_slice)
    }

    pub fn reachable(&self, b: BlockId) -> bool {
        self.idom.contains_key(&b)
    }

    /// Whether `a` dominates `b` (reflexive).
    pub fn dominates(&self, a: BlockId, mut b: BlockId) -> bool {
        loop {
            if a == b {
                return true;
            }
            match self.idom(b) {
                Some(d) => b = d,
                None => return false,
            }
        }
    }
}

impl Body<'_> {
    /// The blocks `b`'s terminator may branch to.
    pub fn successors(&self, b: BlockId) -> &[BlockId] {
        self[b].ops.last().map_or(&[], |t| &self[*t].successors)
    }

    /// Whether values in `region` obey SSA dominance (not a graph region): `RegionKindInterface`,
    /// whose C++ `getRegionKind` says graph for the ops named here.
    pub fn has_ssa_dominance(&self, region: RegionId) -> bool {
        let op = self[region].parent;
        !self.has(op, Trait::HasOnlyGraphRegion) && !matches!(&*self[op].name, "ml_program.func" | "test.graph_region" | "test.isolated_graph_region")
    }

    /// ⭐ The dominator tree of `region` (which must have a block).
    pub fn dom_tree(&self, region: RegionId) -> DomTree {
        let root = self[region].blocks[0];
        // Depth-first preorder, as LLVM's `runDFS`.
        let mut order = Vec::new();
        let mut number = BTreeMap::new();
        let mut stack = vec![root];
        while let Some(b) = stack.pop() {
            if number.contains_key(&b) {
                continue;
            }
            number.insert(b, order.len());
            order.push(b);
            stack.extend(self.successors(b).iter().rev().filter(|s| !number.contains_key(*s)));
        }
        // Predecessors among the reachable blocks.
        let mut preds: BTreeMap<BlockId, Vec<BlockId>> = BTreeMap::new();
        for b in &order {
            for s in self.successors(*b) {
                preds.entry(*s).or_default().push(*b);
            }
        }
        // Cooper, Harvey & Kennedy, over reverse postorder.
        let rpo = self.reverse_postorder(root, &number);
        let rpo_index: BTreeMap<BlockId, usize> = rpo.iter().enumerate().map(|(i, b)| (*b, i)).collect();
        let mut idom: BTreeMap<BlockId, BlockId> = BTreeMap::from([(root, root)]);
        let intersect = |idom: &BTreeMap<BlockId, BlockId>, mut a: BlockId, mut b: BlockId| {
            while a != b {
                while rpo_index[&a] > rpo_index[&b] {
                    a = idom[&a];
                }
                while rpo_index[&b] > rpo_index[&a] {
                    b = idom[&b];
                }
            }
            a
        };
        let mut changed = true;
        while changed {
            changed = false;
            for b in rpo.iter().skip(1) {
                let ps = preds.get(b).map_or(&[][..], Vec::as_slice);
                let mut new = None;
                for p in ps.iter().filter(|p| idom.contains_key(*p)) {
                    new = Some(match new {
                        None => *p,
                        Some(n) => intersect(&idom, *p, n),
                    });
                }
                if let Some(n) = new
                    && idom.get(b) != Some(&n)
                {
                    idom.insert(*b, n);
                    changed = true;
                }
            }
        }
        let mut children: BTreeMap<BlockId, Vec<BlockId>> = BTreeMap::new();
        for b in order.iter().skip(1) {
            children.entry(idom[b]).or_default().push(*b);
        }
        DomTree { root, idom, children }
    }

    fn reverse_postorder(&self, root: BlockId, reachable: &BTreeMap<BlockId, usize>) -> Vec<BlockId> {
        let mut post = Vec::new();
        let mut seen = BTreeMap::new();
        // (block, next successor to visit)
        let mut stack = vec![(root, 0usize)];
        seen.insert(root, ());
        while let Some((b, i)) = stack.pop() {
            match self.successors(b).get(i) {
                Some(s) => {
                    stack.push((b, i + 1));
                    if reachable.contains_key(s) && seen.insert(*s, ()).is_none() {
                        stack.push((*s, 0));
                    }
                }
                None => post.push(b),
            }
        }
        post.reverse();
        post
    }
}
