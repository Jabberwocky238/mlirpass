//! `BranchOpInterface`: which operands of a branch go to which successor's arguments.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::Attribute;

use crate::{Body, BranchLayout as Layout, OpId};

impl Body<'_> {
    fn layout(&self, op: OpId) -> Option<Layout> {
        self.interfaces(op)?.branch_layout(self, op)
    }

    /// The sizes in dense array `name` of `op` (`operandSegmentSizes` and the like).
    pub fn segments(&self, op: OpId, name: &str) -> Option<Vec<usize>> {
        match self[op].get(name)? {
            Attribute::DenseArray { values, .. } => Some(values.iter().map(|v| v.parse().unwrap_or(0)).collect()),
            _ => None,
        }
    }

    pub fn set_segments(&mut self, op: OpId, name: &str, sizes: &[usize]) {
        let Some(Attribute::DenseArray { ty, .. }) = self[op].get(name).cloned() else { return };
        let values = sizes.iter().map(|s| Cow::Owned(format!("{s}"))).collect();
        self[op].set(name, Attribute::DenseArray { ty, values });
    }

    /// Start of operand group `g`.
    fn group_start(&self, op: OpId, g: usize) -> usize {
        self.segments(op, "operandSegmentSizes").map_or(g, |s| s.iter().take(g).sum())
    }

    /// ⭐ `getSuccessorOperands(i)`: the flat operand range forwarded to successor `i`'s
    /// arguments; `None` when `op` is not a branch this crate knows.
    pub fn successor_operands(&self, op: OpId, i: usize) -> Option<core::ops::Range<usize>> {
        let n = self[op].operands.len();
        match self.layout(op)? {
            Layout::All => Some(0..n),
            Layout::Groups { first } => {
                let sizes = self.segments(op, "operandSegmentSizes")?;
                let start = self.group_start(op, first + i);
                Some(start..start + sizes.get(first + i).copied().unwrap_or(0))
            }
            Layout::Cases { default, cases, split } => {
                if let (Some(d), 0) = (default, i) {
                    let sizes = self.segments(op, "operandSegmentSizes")?;
                    let start = self.group_start(op, d);
                    return Some(start..start + sizes[d]);
                }
                let k = i - usize::from(default.is_some());
                let parts = self.segments(op, split)?;
                let start = self.group_start(op, cases) + parts.iter().take(k).sum::<usize>();
                Some(start..start + parts.get(k).copied().unwrap_or(0))
            }
        }
    }

    /// Whether `op` implements `BranchOpInterface` (as far as this crate knows).
    pub fn is_branch(&self, op: OpId) -> bool {
        self.layout(op).is_some()
    }

    /// `SuccessorOperands` of successor `i`: the produced arguments, then the range of the
    /// forwarded operands.
    pub fn successor_layout(&self, op: OpId, i: usize) -> Option<(usize, core::ops::Range<usize>)> {
        match self.interfaces(op).and_then(|f| f.produced_successor_operands(self, op, i)) {
            Some(l) => Some(l),
            None => self.successor_operands(op, i).map(|r| (0, r)),
        }
    }

    /// Whether `op` forwards operands to its successors: a branch, or a terminator whose
    /// successor operands also produce arguments.
    pub fn forwards_to_successors(&self, op: OpId) -> bool {
        self.is_branch(op) || self.interfaces(op).is_some_and(|f| f.produced_successor_operands(self, op, 0).is_some())
    }

    /// Appends `values` to the operands forwarded to successor `i`.
    pub fn append_successor_operands(&mut self, op: OpId, i: usize, values: &[crate::ValueId]) {
        let Some(range) = self.successor_operands(op, i) else { return };
        let mut operands = self[op].operands.clone();
        operands.splice(range.end..range.end, values.iter().copied());
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, values.len() as isize);
    }

    /// Grows (or shrinks) the segment sizes of successor `i`'s operand group by `by`.
    fn resize_successor_group(&mut self, op: OpId, i: usize, by: isize) {
        let group = match self.layout(op) {
            Some(Layout::Groups { first }) => Some(first + i),
            Some(Layout::Cases { default: Some(d), .. }) if i == 0 => Some(d),
            Some(Layout::Cases { default, cases, split }) => {
                let k = i - usize::from(default.is_some());
                if let Some(mut parts) = self.segments(op, split) {
                    parts[k] = parts[k].saturating_add_signed(by);
                    self.set_segments(op, split, &parts);
                }
                Some(cases)
            }
            _ => None,
        };
        if let (Some(g), Some(mut sizes)) = (group, self.segments(op, "operandSegmentSizes")) {
            sizes[g] = sizes[g].saturating_add_signed(by);
            self.set_segments(op, "operandSegmentSizes", &sizes);
        }
    }

    /// Drops the `j`th operand forwarded to successor `i`, keeping the segment sizes right.
    pub fn erase_successor_operand(&mut self, op: OpId, i: usize, j: usize) {
        let Some(range) = self.successor_operands(op, i) else { return };
        let at = range.start + j;
        let mut operands = self[op].operands.clone();
        operands.remove(at);
        self.set_operands(op, operands);
        self.resize_successor_group(op, i, -1);
    }

    /// `BranchOpInterface`'s verifier over everything in `root`: forwarded operands have the
    /// types of their successor's arguments.
    pub fn verify_branches(&self, root: OpId) -> Result<(), mlirformat::Error> {
        for op in self.ops_in(root) {
            for (i, succ) in self[op].successors.iter().enumerate() {
                let Some(range) = self.successor_operands(op, i) else { continue };
                let args = &self[*succ].args;
                for (j, (v, a)) in self[op].operands[range].iter().zip(args).enumerate() {
                    if self[*v].ty != self[*a].ty {
                        return Err(mlirformat::Error(format!("'{}' op type mismatch for bb argument #{j} of successor #{i}", self[op].name)));
                    }
                }
            }
        }
        Ok(())
    }
}
