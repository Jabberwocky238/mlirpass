//! ⭐ `apple9-wait`: an asynchronous result (a special register read, a load) completes on a slot of its own: the lowest
//! one with nothing pending (two pending results on one slot are not both waited for by a wait for it: measured, as
//! Metal gives each its own); with all six pending, the instruction waits for them first. An instruction that touches a
//! pending register waits for its slot, in its own wait field when it has one ([`Apple9Op::waits`]), else by an `iadd`
//! of r63 just before (it only waits).

use alloc::collections::BTreeMap;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Op};

use crate::{A, APPLE9_WAIT_GPR, Apple9Kernel, Apple9Op, Attrs, Body, Kernels, OpData, OpId, Quiet, Rewriter, WithAttrs, pass};

/// The registers an allocated instruction reads, and those it writes.
fn touches(body: &Body<'_>, op: OpId, inst: Apple9Op) -> Result<(Vec<u32>, Vec<u32>), Error> {
    let a = body[op].all_attrs();
    let int = |n: &str| Attrs(&a).get(n).map(Attrs::as_int).transpose().map(|v| v.unwrap_or(0) as u32);
    let n = int("components")?.max(1);
    let mut read = Vec::new();
    for s in inst.sources() {
        let r = int(s)?;
        if *s == "data" {
            read.extend(r..r + n);
        } else {
            read.push(r);
        }
    }
    let written = if inst.has_dst() {
        let d = int("dst")?;
        if inst == Apple9Op::Load { (d..d + n).collect() } else { vec![d] }
    } else {
        Vec::new()
    };
    Ok((read, written))
}

/// `apple9-wait`.
#[pass("apple9-wait", on = "builtin.module")]
pub fn apple9_wait<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Apple9Kernel::NAME) {
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        // pending: register ⇒ the slot its value completes on
        let mut pending: BTreeMap<u32, u32> = BTreeMap::new();
        for i in rw.body.block_ops(rw.body.top_block(k)) {
            let Some(inst) = Apple9Op::of(&rw.body[i].name) else { continue };
            let (read, written) = touches(rw.body, i, inst)?;
            let mut mask: u32 = read.iter().chain(&written).filter_map(|r| pending.get(r)).fold(0, |m, s| m | 1 << (s - 1));
            // its own slot: the lowest free one; none free, everything pending is waited for first
            let free = (1..=6).find(|s| !pending.values().any(|p| p == s));
            if inst.completes() && free.is_none() {
                mask |= pending.values().fold(0, |m, s| m | 1 << (s - 1));
            }
            let slot = inst.completes().then(|| free.unwrap_or(1));
            if mask != 0 {
                if inst.waits() {
                    let have = Attrs(&rw.body[i].all_attrs()).get("wait").map(Attrs::as_int).transpose()?.unwrap_or(0) as u32;
                    rw.modify(i, |b| b[i].set("wait", Attribute::from(A::from(have | mask))));
                } else {
                    let r = A::from(APPLE9_WAIT_GPR);
                    let attrs = vec![("dst", r.clone()), ("a", r.clone()), ("b", r), ("wait", A::from(mask))];
                    rw.set_before(i);
                    rw.create(OpData::build(Apple9Op::Iadd.name()).with_attrs(attrs), &[]);
                }
                pending.retain(|_, s| mask & (1 << (*s - 1)) == 0);
            }
            for r in &written {
                pending.remove(r);
            }
            if let Some(s) = slot {
                rw.modify(i, |b| b[i].set("slot", Attribute::from(A::from(s))));
            }
            if let Some(s) = slot {
                for r in written {
                    pending.insert(r, s);
                }
            }
        }
    }
    Ok(())
}
