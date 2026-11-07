//! ⭐ Structured control flow on Xe3, as Mesa emits it (brw_to_binary.cpp, gen_control_flow.cpp): the hardware keeps
//! the per-lane masks, so a condition may differ between lanes.
//!
//! - `xe3-control` (after `xe3-regalloc`, which leaves the structured ops with their registers): an `scf.if` becomes
//!   `cmp.nz` of its condition into f0.0, `(f0.0) if`, the then-part, `else`, the else-part, `endif`; an `scf.for`
//!   becomes a loop header (`xe3.ctl.do`: there is no DO instruction), `cmp.ge` of the induction variable and the
//!   bound, `(f0.0) break` (the lanes that are done leave), the body, the step added, `while` (back while any lane is
//!   left). What the ops carry is in its registers already.
//! - `xe3-branches` (after `xe3-swsb`, which adds instructions): every branch's JIP / UIP, bytes from itself, as
//!   `gen_compute_jips_and_uips`; the loop headers dropped.

#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

use mlirformat::Op;
use mlirformat::{Attribute, Error};
use crate::{A, BlockId, Body, Kernels, OpData, OpId, Quiet, Rewriter, Xe3Kernel, pass};

/// A loop header: where its `while` jumps back to (not an instruction).
pub const DO: &str = "xe3.ctl.do";

/// The instructions that branch, and the loop header: `xe3-swsb` waits for everything before each.
pub fn is_control(name: &str) -> bool {
    name == DO || ["if", "else", "endif", "break", "while"].iter().any(|n| name.strip_prefix("xe3.eu.") == Some(n))
}

struct Control<'r, 'a> {
    rw: Rewriter<'r, 'a>,
}

impl<'a> Control<'_, 'a> {
    /// `name` with `attrs` (SIMD16), before `before`.
    fn put(&mut self, before: OpId, name: &str, attrs: &[(&str, A)]) {
        let mut data = OpData::build(name).with("exec", A::from(16u8).into());
        for (n, a) in attrs {
            data.set(n, a.clone().into());
        }
        self.rw.set_before(before);
        self.rw.create(data, &[]);
    }

    fn get(&self, op: OpId, name: &str) -> Result<String, Error> {
        self.rw.body[op].get_str(name).map(str::to_owned).ok_or_else(|| Error(format!("{}: no {name} (run xe3-regalloc)", self.rw.body[op].name)))
    }

    /// Block `b`'s ops moved before `before`, its yield gone.
    fn inline(&mut self, b: BlockId, before: OpId) {
        let parent = self.rw.body[before].parent.expect("placed");
        let yields: Vec<OpId> = self.rw.body.ops(b).filter(|o| matches!(&*self.rw.body[*o].name, "scf.yield" | "scf.condition")).collect();
        self.rw.inline_block_before(b, parent, Some(before), &[]);
        for y in yields {
            self.rw.erase_op(y);
        }
    }

    fn lower(&mut self, op: OpId) -> Result<(), Error> {
        let flag = ("flag", A::str("f0.0"));
        let null = ("dst", A::str("null<1;1,0>:d"));
        let regions = self.rw.body[op].regions.to_vec();
        let entry = |rw: &Rewriter<'_, 'a>, i: usize| regions.get(i).and_then(|r| rw.body[*r].blocks.first().copied());
        match &*self.rw.body[op].name {
            "scf.for" => {
                let (iv, ub, step) = (self.get(op, "iv")?, self.get(op, "ub")?, self.get(op, "step")?);
                let iv_dst = iv.clone();
                self.rw.set_before(op);
                self.rw.create(OpData::build(DO), &[]);
                self.put(op, "xe3.eu.cmp", &[null.clone(), ("src0", A::str(iv.clone())), ("src1", A::str(ub)), ("cond", A::str("ge")), flag.clone()]);
                self.put(op, "xe3.eu.break", &[("pred", A::str("normal")), flag.clone()]);
                if let Some(b) = entry(&self.rw, 0) {
                    self.inline(b, op);
                }
                self.put(op, "xe3.eu.add", &[("dst", A::str(iv_dst)), ("src0", A::str(iv)), ("src1", A::str(step))]);
                self.put(op, "xe3.eu.while", &[]);
            }
            "scf.while" => {
                let cond = self.get(op, "cond")?;
                self.rw.set_before(op);
                self.rw.create(OpData::build(DO), &[]);
                if let Some(b) = entry(&self.rw, 0) {
                    self.inline(b, op);
                }
                // the lanes whose condition is false leave (what they forwarded is in the results' registers)
                self.put(op, "xe3.eu.cmp", &[null.clone(), ("src0", A::str(cond)), ("src1", A::str("0x0:d")), ("cond", A::str("z")), flag.clone()]);
                self.put(op, "xe3.eu.break", &[("pred", A::str("normal")), flag]);
                if let Some(b) = entry(&self.rw, 1) {
                    self.inline(b, op);
                }
                self.put(op, "xe3.eu.while", &[]);
            }
            "scf.if" => {
                let cond = self.get(op, "cond")?;
                self.put(op, "xe3.eu.cmp", &[null.clone(), ("src0", A::str(cond)), ("src1", A::str("0x0:d")), ("cond", A::str("nz")), flag.clone()]);
                self.put(op, "xe3.eu.if", &[("pred", A::str("normal")), flag]);
                if let Some(b) = entry(&self.rw, 0) {
                    self.inline(b, op);
                }
                // an else-part with more than its yield
                if let Some(b) = entry(&self.rw, 1).filter(|b| self.rw.body.ops(*b).any(|o| self.rw.body[o].name != "scf.yield")) {
                    self.put(op, "xe3.eu.else", &[]);
                    self.inline(b, op);
                }
                self.put(op, "xe3.eu.endif", &[]);
            }
            name => return Err(Error(format!("xe3-control: {name}"))),
        }
        self.rw.erase_op(op);
        Ok(())
    }
}

/// `xe3-control`: every kernel's structured ops as branches.
#[pass("xe3-control", on = "builtin.module")]
pub fn xe3_control<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Xe3Kernel::NAME) {
        // inner ones first: an outer op then moves what they became
        let mut ops = Vec::new();
        body.walk_post(k, &mut |o| {
            if matches!(&*body[o].name, "scf.for" | "scf.if" | "scf.while") {
                ops.push(o);
            }
        });
        let mut quiet = Quiet;
        let mut c = Control { rw: Rewriter::new(body, &mut quiet) };
        for o in ops {
            c.lower(o)?;
        }
    }
    Ok(())
}

/// `xe3-branches`: JIP and UIP of every branch, in bytes from itself (16 an instruction), as Mesa's
/// gen_compute_jips_and_uips: an `if` to its `else` + 1 (UIP its `endif`), or to its `endif`; `else` to its
/// `endif`; `endif` to the end of the scope it is in (the next `else` / `endif` / `while` out), or the next
/// instruction; `break` to the end of its scope (UIP its loop's `while`); `while` back to its loop's header.
#[pass("xe3-branches", on = "builtin.module")]
pub fn xe3_branches<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, Xe3Kernel::NAME) {
        let block = rw.body.top_block(k);
        let ops = rw.body.block_ops(block);
        // instruction indices (a header is the index of the instruction after it)
        let mut insts: Vec<(OpId, String)> = Vec::new();
        let mut headers = Vec::new();
        for &o in &ops {
            let name = rw.body[o].name.to_string();
            if name == DO {
                headers.push(insts.len());
                continue;
            }
            insts.push((o, name));
        }
        let kind = |i: usize| insts[i].1.strip_prefix("xe3.eu.").unwrap_or("");
        let mut jip: Vec<Option<i64>> = vec![None; insts.len()];
        let mut uip: Vec<Option<i64>> = vec![None; insts.len()];
        // structure: ifs to their else / endif, loops (header, while), breaks to their while
        let (mut ifs, mut loops): (Vec<(usize, Option<usize>)>, Vec<usize>) = (Vec::new(), Vec::new());
        let mut header = headers.iter().copied().peekable();
        for i in 0..insts.len() {
            while header.peek() == Some(&i) {
                loops.push(i);
                header.next();
            }
            match kind(i) {
                "if" => ifs.push((i, None)),
                "else" => ifs.last_mut().ok_or_else(|| Error("else without if".into()))?.1 = Some(i),
                "endif" => match ifs.pop().ok_or_else(|| Error("endif without if".into()))? {
                    (f, None) => (jip[f], uip[f]) = (Some(i as i64), Some(i as i64)),
                    (f, Some(e)) => {
                        (jip[f], uip[f]) = (Some(e as i64 + 1), Some(i as i64));
                        (jip[e], uip[e]) = (Some(i as i64), Some(i as i64));
                    }
                },
                "while" => {
                    let h = loops.pop().ok_or_else(|| Error("while without its loop".into()))?;
                    jip[i] = Some(h as i64);
                    // its breaks' UIP
                    for (b, u) in uip.iter_mut().enumerate().take(i).skip(h) {
                        if kind(b) == "break" && u.is_none() {
                            *u = Some(i as i64);
                        }
                    }
                }
                _ => {}
            }
        }
        // the rest: out of the innermost scope, walking back
        let mut scopes: Vec<Option<usize>> = vec![None];
        for i in (0..insts.len()).rev() {
            match kind(i) {
                // a scope starts at an if (and at a loop header, below)
                "if" => {
                    scopes.pop();
                }
                "else" => *scopes.last_mut().ok_or_else(|| Error("unbalanced branches".into()))? = Some(i),
                "endif" => {
                    jip[i] = Some(scopes.last().copied().flatten().unwrap_or(i + 1) as i64);
                    scopes.push(Some(i));
                }
                "while" => scopes.push(Some(i)),
                "break" => jip[i] = Some(scopes.last().copied().flatten().ok_or_else(|| Error("break outside a loop".into()))? as i64),
                _ => {}
            }
            for _ in headers.iter().filter(|h| **h == i) {
                scopes.pop();
            }
        }
        for (i, (o, _)) in insts.iter().enumerate() {
            let o = *o;
            let set = |rw: &mut Rewriter<'_, '_>, name: &str, to: Option<i64>| {
                if let Some(t) = to {
                    let bytes = 16 * (t - i as i64);
                    rw.modify(o, |b| b[o].set(name, Attribute::Int { lit: bytes.to_string().into(), ty: None }));
                }
            };
            set(&mut rw, "jip", jip[i]);
            set(&mut rw, "uip", uip[i]);
        }
        for &o in &ops {
            if rw.body[o].name == DO {
                rw.erase_op(o);
            }
        }
    }
    Ok(())
}
