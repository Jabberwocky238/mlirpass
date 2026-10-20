//! The thread-pool [`Executor`](super::Executor): a fixed number of workers, each taking the next
//! task as it finishes one (`llvm::ThreadPool` with `parallelForEach`'s work sharing). Workers are
//! scoped to a batch, so tasks may borrow what outlives the call.

use alloc::vec::Vec;
use core::num::NonZeroUsize;
use core::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Mutex;

use super::{Executor, Task};

/// ⭐ Runs tasks on `threads` workers.
#[derive(Debug, Clone, Copy)]
pub struct ThreadPool {
    threads: NonZeroUsize,
}

impl ThreadPool {
    pub fn new(threads: NonZeroUsize) -> Self {
        Self { threads }
    }
}

impl Default for ThreadPool {
    /// As many workers as the machine runs threads.
    fn default() -> Self {
        Self::new(std::thread::available_parallelism().unwrap_or(NonZeroUsize::MIN))
    }
}

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
