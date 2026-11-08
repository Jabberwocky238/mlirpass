//! ⭐ `apple9-wait`: an asynchronous result is waited for before its register is read or written. A special register
//! read completes on slot 1, a load on a slot of its own (6, 5, 4, 3, 2 in turn: never one still pending); an
//! instruction that touches a pending register waits for its slot, in its own wait field when it has one
//! ([`Apple9Op::waits`]), else by an `iadd` of r63 just before (it only waits).

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
        let mut next_load = 0usize;
        const LOAD_SLOTS: [u32; 5] = [6, 5, 4, 3, 2];
        for i in rw.body.block_ops(rw.body.top_block(k)) {
            let Some(inst) = Apple9Op::of(&rw.body[i].name) else { continue };
            let (read, written) = touches(rw.body, i, inst)?;
            let mut mask: u32 = read.iter().chain(&written).filter_map(|r| pending.get(r)).fold(0, |m, s| m | 1 << (s - 1));
            // a load's own slot, not one still pending
            let slot = (inst == Apple9Op::Load).then(|| {
                let s = LOAD_SLOTS[next_load % LOAD_SLOTS.len()];
                next_load += 1;
                s
            });
            if let Some(s) = slot
                && pending.values().any(|p| *p == s)
            {
                mask |= 1 << (s - 1);
            }
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
            if let Some(s) = slot.or(inst.completes().map(u32::from)) {
                for r in written {
                    pending.insert(r, s);
                }
            }
        }
    }
    Ok(())
}
