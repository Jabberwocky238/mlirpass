//! ⭐ Running passes in parallel, as MLIR's `OpToOpPassAdaptor` over a thread pool: the ops a nested
//! pipeline runs on that are `IsolatedFromAbove` (functions) are independent, so each is moved into
//! a body of its own, run as a [`Task`] by an [`Executor`], and moved back in its place.
//!
//! ```text
//! Task       one unit of work: a closure, run once, on any thread
//! Executor   runs a batch of tasks to completion: [`Serial`] (in order, this thread),
//!            [`ThreadPool`] (a fixed number of workers taking the next task as they finish)
//! ```
//!
//! ```text
//! calibrate  the first ops' pipelines run in place, timed; the rest go to the threads only when
//!            running an op costs more than moving it out and back (`PassManager::calibrate`)
//! split_off  in each task: the op copied out of the shared body (read only, in parallel)
//! graft      after the batch: each body's arenas appended whole (`Body::absorb`, ids shifted),
//!            the op swapped into its old slot; nothing is looked up or copied op by op
//! ```
//!
//! Results do not depend on the executor: a task only sees its own body, and bodies go back in
//! their original order.

use alloc::boxed::Box;
use alloc::vec::Vec;
#[cfg(feature = "std")]
use core::num::NonZeroUsize;
#[cfg(feature = "std")]
use core::sync::atomic::{AtomicUsize, Ordering};
#[cfg(feature = "std")]
use std::sync::Mutex;

use crate::{Body, OpData, OpId, Shift, Trait, ValueId};

/// ⭐ A unit of work: run once, on whichever thread the executor picks.
pub type Task<'s> = Box<dyn FnOnce() + Send + 's>;

/// ⭐ What runs a batch of independent tasks, each to completion.
pub trait Executor: Sync {
    /// Runs every task; returns once all have run.
    fn execute<'s>(&self, tasks: Vec<Task<'s>>);

    /// How many tasks may run at once (1: no point splitting work up).
    fn width(&self) -> usize;
}

/// One task after the other, on the calling thread (`--mlir-disable-threading`).
#[derive(Debug, Clone, Copy, Default)]
pub struct Serial;

impl Executor for Serial {
    fn execute<'s>(&self, tasks: Vec<Task<'s>>) {
        tasks.into_iter().for_each(|t| t());
    }

    fn width(&self) -> usize {
        1
    }
}

impl<'a> Body<'a> {
    /// Whether `op` can be run on alone: `IsolatedFromAbove` (no value from outside used in it).
    pub fn isolated(&self, op: OpId) -> bool {
        self.has(op, Trait::IsIsolatedFromAbove)
    }

    /// `op` (isolated) moved into a body of its own, under a module carrying the discardable
    /// attributes of `op`'s ancestors (the nearest wins: what `DataLayout::closest` reads); the
    /// body and the op there.
    pub fn split_off(&self, op: OpId) -> (Self, OpId) {
        let mut sub = Body::new(self.ctx);
        let mut ancestors = Vec::new();
        let mut at = self.parent_op(op);
        while let Some(a) = at {
            ancestors.push(a);
            at = self.parent_op(a);
        }
        for a in ancestors.into_iter().rev() {
            for n in &self[a].attributes {
                let root = sub.root;
                sub[root].set(&n.name, n.value.clone().unwrap_or(mlirformat::Attribute::Unit));
            }
        }
        let moved = sub.transplant(self, op);
        let block = sub.top_block(sub.root);
        sub.insert(moved, block, None);
        (sub, moved)
    }

    /// `op` (at `at` in its block) replaced by `from`'s `with`, moved over whole
    /// (`split_off`'s inverse): `from`'s arenas join this body's, nothing is copied.
    pub fn graft(&mut self, op: OpId, at: usize, from: Body<'a>, with: OpId) {
        let new = with.shift(&self.absorb(from));
        self.detach(new);
        let results = self[new].results.clone();
        self.swap_in(op, at, new);
        // What `op` used and defined is now `new`'s.
        if !self[op].operands.is_empty() {
            self.set_operands(op, Vec::new());
        }
        if !results.is_empty() {
            for (r, w) in self[op].results.clone().into_iter().zip(&results) {
                self.replace_all_uses(r, *w);
            }
        }
    }

    /// A detached copy of `from`'s `op` (and everything in it) in this body. Operands are set once
    /// every value exists, so forward references (graph regions, successors) need no care.
    fn transplant(&mut self, from: &Body<'a>, op: OpId) -> OpId {
        let mut values: Vec<(ValueId, ValueId)> = Vec::new();
        let mut blocks = Vec::new();
        let mut made = Vec::new();
        let new = self.shell(from, op, &mut values, &mut blocks, &mut made);
        values.sort_unstable();
        blocks.sort_unstable();
        let value = |v: ValueId| values.binary_search_by_key(&v, |p| p.0).map(|i| values[i].1).expect("an isolated op uses only its own values");
        for (old, new) in made {
            let operands = from[old].operands.iter().map(|v| value(*v)).collect();
            self.set_operands(new, operands);
            self[new].successors = from[old].successors.iter().map(|b| blocks[blocks.binary_search_by_key(b, |p| p.0).expect("a successor in the op")].1).collect();
        }
        new
    }

    /// `from`'s `op` without its operands, its regions filled the same way; records what maps where.
    fn shell(&mut self, from: &Body<'a>, op: OpId, values: &mut Vec<(ValueId, ValueId)>, blocks: &mut Vec<(crate::BlockId, crate::BlockId)>, made: &mut Vec<(OpId, OpId)>) -> OpId {
        let d = &from[op];
        let data = OpData { operands: Vec::new(), results: Vec::new(), successors: Vec::new(), regions: Vec::new(), parent: None, defaults: false, ..d.clone() };
        let new = self.push_op(data, &from.types(&d.results));
        for (a, b) in d.results.iter().zip(self[new].results.clone()) {
            self[b].loc = from[*a].loc.clone();
            values.push((*a, b));
        }
        made.push((op, new));
        for r in &d.regions {
            let nr = self.add_region(new);
            for b in &from[*r].blocks {
                let args: Vec<_> = from[*b].args.iter().map(|a| (from[*a].ty.clone(), from[*a].loc.clone())).collect();
                let nb = self.add_block(nr, &args);
                values.extend(from[*b].args.iter().copied().zip(self[nb].args.clone()));
                blocks.push((*b, nb));
                for o in &from[*b].ops {
                    let c = self.shell(from, *o, values, blocks, made);
                    self.insert(c, nb, None);
                }
            }
        }
        new
    }
}

// The thread-pool [`Executor`]: a fixed number of workers, each taking the next
// task as it finishes one (`llvm::ThreadPool` with `parallelForEach`'s work sharing). Workers are
// scoped to a batch, so tasks may borrow what outlives the call.

#[cfg(feature = "std")]
/// ⭐ Runs tasks on `threads` workers.
#[derive(Debug, Clone, Copy)]
pub struct ThreadPool {
    threads: NonZeroUsize,
}

#[cfg(feature = "std")]
impl ThreadPool {
    pub fn new(threads: NonZeroUsize) -> Self {
        Self { threads }
    }
}

#[cfg(feature = "std")]
impl Default for ThreadPool {
    /// As many workers as the machine runs threads.
    fn default() -> Self {
        Self::new(std::thread::available_parallelism().unwrap_or(NonZeroUsize::MIN))
    }
}

#[cfg(feature = "std")]
impl Executor for ThreadPool {
    fn execute<'s>(&self, tasks: Vec<Task<'s>>) {
        let workers = self.threads.get().min(tasks.len());
        if workers <= 1 {
            return tasks.into_iter().for_each(|t| t());
        }
        let slots: Vec<Mutex<Option<Task<'s>>>> = tasks.into_iter().map(|t| Mutex::new(Some(t))).collect();
        let next = AtomicUsize::new(0);
        std::thread::scope(|s| {
            for _ in 0..workers {
                s.spawn(|| {
                    while let Some(slot) = slots.get(next.fetch_add(1, Ordering::Relaxed)) {
                        if let Some(t) = slot.lock().unwrap_or_else(|e| e.into_inner()).take() {
                            t();
                        }
                    }
                });
            }
        });
    }

    fn width(&self) -> usize {
        self.threads.get()
    }
}
