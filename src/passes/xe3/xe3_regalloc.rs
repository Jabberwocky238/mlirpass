//! ⭐ `xe3-regalloc`: a kernel's virtual instructions ⇒ registers (one block, SSA: acgpu-core's [`LinearScan`]).
//!
//! A payload value is where the thread got it. An EOT message's payload goes to r112 on (src0, then src1): a value
//! made only for it is made there; anything else is copied there (`mov`). The rest take the lowest free register
//! from the end of the payload up (one GRF each), a source's register free once its last reader read it (a send's
//! only after its response has its own). Then every instruction is rewritten with its registers spelled out
//! (`asm.rs`), and the payload ops are gone.

#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

use alloc::collections::BTreeMap;

use mlirformat::Op;
use mlirformat::{Attribute, Error};
use crate::{A, Attrs, BlockId, Body, Grf, Groups, Heads, Kernels, LinearScan, OpData, OpId, Quiet, RegTarget, Rewriter, ValueId, XE3_EOT_GRF as EOT_GRF, Xe3Kernel, pass};

/// The GRF as the linear scan sees it: one file, a register a value; payloads preset, a send's response apart from
/// its payload.
struct GrfFile;

impl RegTarget for GrfFile {
    fn preset(&self, body: &Body<'_>, op: OpId) -> Result<Option<u32>, Error> {
        if body[op].name != "xe3.eu.payload" {
            return Ok(None);
        }
        let g = body[op].get("grf").map(Attrs::as_int).transpose()?.ok_or_else(|| Error("payload without grf".into()))?;
        Ok(Some(g as u32))
    }

    fn reuses_sources(&self, body: &Body<'_>, op: OpId) -> bool {
        !body[op].name.starts_with("xe3.eu.send") && body[op].name != PACK64
    }

    fn file(&self, _body: &Body<'_>, _v: ValueId) -> Result<usize, Error> {
        Ok(0)
    }

    fn size(&self, body: &Body<'_>, v: ValueId) -> Result<(u32, u32), Error> {
        Ok(match Grf::try_from(&body[v].ty).map(|g| g.0) {
            Ok("f64" | "i64") => (2, 2),
            _ => (1, 1),
        })
    }

    fn is_loop(&self, body: &Body<'_>, op: OpId) -> bool {
        matches!(&*body[op].name, "scf.for" | "scf.while")
    }
}

/// `xe3.eu.pack64(lo, hi)`: a 64-bit value of two 32-bit ones, each one's dword a lane: after the allocation the
/// two moves writing its low and high dwords (a qword apart), as one SSA definition before it. Its register is apart
/// from theirs (the first move would overwrite the other half).
pub const PACK64: &str = "xe3.eu.pack64";

/// The structured control flow ops a kernel keeps through the allocation (`xe3-control` makes them branches).
const STRUCTURED: [&str; 5] = ["scf.for", "scf.if", "scf.while", "scf.condition", "scf.yield"];

/// The source slots of an instruction.
const SOURCES: [&str; 3] = ["src0", "src1", "src2"];

/// One kernel being allocated: every change to it through a [`Rewriter`].
struct Alloc<'r, 'a> {
    rw: Rewriter<'r, 'a>,
    block: BlockId,
    reg: BTreeMap<ValueId, u8>,
}

impl<'a> Alloc<'_, 'a> {
    /// The kernel's instructions in order, into its loops and branches (not those ops themselves).
    fn ops(&self) -> Vec<OpId> {
        let mut out = Vec::new();
        Self::instructions(self.rw.body, self.block, &mut out);
        out
    }

    fn instructions(body: &Body<'_>, block: BlockId, out: &mut Vec<OpId>) {
        for op in body.ops(block) {
            if !STRUCTURED.contains(&&*body[op].name) {
                out.push(op);
            }
            for &r in &body[op].regions {
                for &b in &body[r].blocks {
                    Self::instructions(body, b, out);
                }
            }
        }
    }

    /// The structured ops of the kernel, outer before inner.
    fn structured(&self) -> Vec<OpId> {
        let mut out = Vec::new();
        let k = self.rw.body.block_owner(self.block);
        if let Some(k) = k {
            self.rw.body.walk(k, &mut |o| {
                if STRUCTURED.contains(&&*self.rw.body[o].name) {
                    out.push(o);
                }
            });
        }
        out
    }

    /// A copy of `v` (one SIMD16 move) before `before`.
    fn copy(&mut self, v: ValueId, before: OpId) -> ValueId {
        let mut mov = OpData::build("xe3.eu.mov").operands(&[v]);
        mov.set("exec", A::from(16u8).into());
        let ty = self.rw.body[v].ty.clone();
        self.rw.set_before(before);
        let m = self.rw.create(mov, &[ty]);
        self.rw.body[m].results[0]
    }

    /// The operands of terminator `t` from `from` on, each copied to a temporary and the temporary copied again (all
    /// the temporaries first: a carried register read for another is read before it is written); the second copies.
    fn twice(&mut self, t: OpId, from: usize) -> Vec<ValueId> {
        let values = self.rw.body[t].operands[from..].to_vec();
        let temps: Vec<ValueId> = values.iter().map(|v| self.copy(*v, t)).collect();
        let mut out = Vec::new();
        for (k, tmp) in temps.into_iter().enumerate() {
            let c = self.copy(tmp, t);
            self.rw.modify(t, |b| b.set_operand(t, from + k, c));
            out.push(c);
        }
        out
    }

    /// What a loop or a branch carries, a register each (the linear scan's webs). A loop: its induction variable
    /// from a copy of the lower bound; each carried value from a copy of its initial one, the body's argument, a copy
    /// of what the body yields, the result. A branch: each result from a copy of what each side yields. A loop's
    /// yields are copied twice (to temporaries, then to the carried registers), so one carried value read for another
    /// is read before it is written.
    fn webs(&mut self) -> Vec<Vec<ValueId>> {
        let mut webs = Vec::new();
        for op in self.structured() {
            match &*self.rw.body[op].name {
                "scf.for" => {
                    let body = self.rw.body.top_block(op);
                    let args = self.rw.body[body].args.to_vec();
                    let operands = self.rw.body[op].operands.to_vec();
                    // lb, ub, step, the initial values
                    let mut init = vec![operands[0]];
                    init.extend(&operands[3..]);
                    let mut carried: Vec<Vec<ValueId>> = Vec::new();
                    for (k, v) in init.into_iter().enumerate() {
                        let c = self.copy(v, op);
                        let at = if k == 0 { 0 } else { k + 2 };
                        self.rw.modify(op, |b| b.set_operand(op, at, c));
                        carried.push(vec![c, args[k]]);
                    }
                    let results = self.rw.body[op].results.to_vec();
                    if let Some(y) = self.rw.body.last_op(body).filter(|y| self.is(*y, "scf.yield")) {
                        for (k, c) in self.twice(y, 0).into_iter().enumerate() {
                            carried[k + 1].push(c);
                        }
                    }
                    for (k, r) in results.into_iter().enumerate() {
                        carried[k + 1].push(r);
                    }
                    webs.extend(carried);
                }
                "scf.while" => {
                    // carried: the initial copy, the condition region's argument, (twice) copied what the body yields;
                    // forwarded: (twice) copied what the condition passes on, the body's argument, the result
                    let [before, after] = [0, 1].map(|i| self.rw.body[self.rw.body[op].regions[i]].blocks[0]);
                    let inits = self.rw.body[op].operands.to_vec();
                    let mut carried: Vec<Vec<ValueId>> = Vec::new();
                    for (k, v) in inits.into_iter().enumerate() {
                        let c = self.copy(v, op);
                        self.rw.modify(op, |b| b.set_operand(op, k, c));
                        carried.push(vec![c, self.rw.body[before].args[k]]);
                    }
                    if let Some(y) = self.rw.body.last_op(after).filter(|y| self.is(*y, "scf.yield")) {
                        for (k, c) in self.twice(y, 0).into_iter().enumerate() {
                            carried[k].push(c);
                        }
                    }
                    let mut forwarded: Vec<Vec<ValueId>> = self.rw.body[after].args.iter().map(|a| vec![*a]).collect();
                    if let Some(c) = self.rw.body.last_op(before).filter(|c| self.is(*c, "scf.condition")) {
                        for (k, v) in self.twice(c, 1).into_iter().enumerate() {
                            forwarded[k].push(v);
                        }
                    }
                    for (k, r) in self.rw.body[op].results.iter().copied().enumerate() {
                        forwarded[k].push(r);
                    }
                    webs.extend(carried);
                    webs.extend(forwarded);
                }
                "scf.if" => {
                    let results = self.rw.body[op].results.to_vec();
                    let mut carried: Vec<Vec<ValueId>> = results.iter().map(|r| vec![*r]).collect();
                    let regions = self.rw.body[op].regions.clone();
                    for r in regions {
                        let Some(&b) = self.rw.body[r].blocks.first() else { continue };
                        let Some(y) = self.rw.body.last_op(b).filter(|y| self.is(*y, "scf.yield")) else { continue };
                        let yielded = self.rw.body[y].operands.clone();
                        for (k, v) in yielded.into_iter().enumerate() {
                            let c = self.copy(v, y);
                            self.rw.modify(y, |b| b.set_operand(y, k, c));
                            carried[k].push(c);
                        }
                    }
                    webs.extend(carried);
                }
                _ => {}
            }
        }
        webs
    }

    fn is(&self, op: OpId, name: &str) -> bool {
        self.rw.body[op].name == name
    }

    fn send(&self, op: OpId) -> bool {
        self.is(op, "xe3.eu.send") || self.is(op, "xe3.eu.sendc")
    }

    fn eot(&self, op: OpId) -> bool {
        self.send(op) && self.rw.body[op].get("eot").is_some()
    }

    /// The register type of a value (`f`, `ud`, `d`).
    fn ty(&self, v: ValueId) -> Result<&'static str, Error> {
        match Grf::try_from(&self.rw.body[v].ty)?.0 {
            "f32" => Ok("f"),
            "ui32" => Ok("ud"),
            "i32" => Ok("d"),
            "f64" => Ok("df"),
            "i64" => Ok("q"),
            e => Err(Error(format!("register of {e}"))),
        }
    }

    /// Where the messages' payloads go: an EOT one at r112 on (a value made only for it in place, else a copy). Any
    /// other's payload of several registers is copied into a run allocated with the first copy (`groups`: the copies,
    /// in order); one of a single register is its value wherever it is. Either is free once the send read it (a
    /// later writer waits for the send's `$n.src`: xe3-swsb).
    fn messages(&mut self) -> Result<(BTreeMap<ValueId, u8>, Groups), Error> {
        let mut at = BTreeMap::new();
        let mut groups = BTreeMap::new();
        let sends: Vec<OpId> = self.ops().into_iter().filter(|o| self.send(*o)).collect();
        for send in sends {
            let operands = self.rw.body[send].operands.clone();
            let eot = self.eot(send);
            if !eot && operands.len() <= 1 {
                continue;
            }
            let mut copies = Vec::new();
            for (k, v) in operands.iter().copied().enumerate() {
                let to = EOT_GRF + k as u8;
                let def = self.rw.body.def_op(v);
                let alone = self.rw.body[v].uses.len() == 1 && def.is_some_and(|d| !self.is(d, "xe3.eu.payload") && self.rw.body[d].results.len() == 1) && !at.contains_key(&v);
                if eot && alone {
                    at.insert(v, to);
                    continue;
                }
                let mut mov = OpData::build("xe3.eu.mov").operands(&[v]);
                mov.set("exec", self.rw.body[send].get("exec").cloned().unwrap_or(A::from(16u8).into()));
                let ty = self.rw.body[v].ty.clone();
                self.rw.set_before(send);
                let m = self.rw.create(mov, &[ty]);
                let copy = self.rw.body[m].results[0];
                self.rw.modify(send, |b| b.set_operand(send, k, copy));
                if eot {
                    at.insert(copy, to);
                } else {
                    copies.push(copy);
                }
            }
            if let Some(first) = copies.first() {
                groups.insert(*first, copies);
            }
        }
        Ok((at, groups))
    }

    /// Registers for every value: from `first` (the kernel's `reserve`: after its payload; r0 is the thread's) up
    /// to `top`.
    fn assign(&mut self, fixed: BTreeMap<ValueId, u8>, groups: Groups, webs: &[Vec<ValueId>], first: u8, top: u8) -> Result<(), Error> {
        #[allow(clippy::single_range_in_vec_init, reason = "the GRF is one register file: a list of one range")]
        let scan = LinearScan { files: vec![u32::from(first.max(1))..u32::from(top)], fixed: fixed.into_iter().map(|(v, r)| (v, r.into())).collect(), groups };
        self.reg = scan.run_with(&GrfFile, self.rw.body, self.block, webs)?.into_iter().map(|(v, r)| (v, r as u8)).collect();
        Ok(())
    }

    /// `v` as an operand. `retype`: what the instruction asks of its operands (see `rewrite`).
    fn operand(&self, v: ValueId, neg: bool, abs: bool, retype: Retype) -> Result<String, Error> {
        let ty = match (retype, self.ty(v)?) {
            (Retype::As(t), _) => t,
            (Retype::Unsigned, "d") => "ud",
            (_, t) => t,
        };
        Ok(format!("{}{}r{}<1;1,0>:{}", if neg { "-" } else { "" }, if abs { "(abs)" } else { "" }, self.reg[&v], ty))
    }

    /// The structured ops with their registers in place of their values (`xe3-control` reads them): a loop its
    /// induction variable `iv`, bound `ub` and `step`; a branch its condition `cond`. Their values gone, the yields too
    /// (what they yield is in the carried registers already).
    fn structure(&mut self) -> Result<(), Error> {
        for op in self.structured() {
            let name = self.rw.body[op].name.to_string();
            let operands = self.rw.body[op].operands.to_vec();
            let attrs = match &*name {
                "scf.for" => {
                    let iv = self.rw.body[self.rw.body.top_block(op)].args[0];
                    vec![("iv", self.operand(iv, false, false, Retype::Keep)?), ("ub", self.operand(operands[1], false, false, Retype::Keep)?), ("step", self.operand(operands[2], false, false, Retype::Keep)?)]
                }
                "scf.if" => vec![("cond", self.operand(operands[0], false, false, Retype::As("d"))?)],
                // the condition, on the loop (its condition op goes with the values)
                "scf.while" => {
                    let before = self.rw.body[self.rw.body[op].regions[0]].blocks[0];
                    let c = self.rw.body.last_op(before).filter(|c| self.is(*c, "scf.condition")).ok_or_else(|| Error("scf.while without its condition".into()))?;
                    vec![("cond", self.operand(self.rw.body[c].operands[0], false, false, Retype::As("d"))?)]
                }
                _ => vec![],
            };
            self.rw.modify(op, |b| {
                for (n, a) in attrs {
                    b[op].set(n, A::str(a).into());
                }
                b.set_operands(op, Vec::new());
                b[op].results.clear();
                for r in b[op].regions.clone() {
                    for blk in b[r].blocks.clone() {
                        b[blk].args.clear();
                    }
                }
            });
        }
        Ok(())
    }

    /// Every instruction with its registers; the payload ops gone.
    fn rewrite(&mut self) -> Result<(), Error> {
        let ops = self.ops();
        for &op in &ops {
            if self.is(op, "xe3.eu.payload") {
                continue;
            }
            if self.is(op, PACK64) {
                let [lo, hi] = self.rw.body[op].operands[..] else { return Err(Error("pack64 of two values".into())) };
                let r = self.rw.body[op].results[0];
                let exec = self.rw.body[op].get("exec").cloned().unwrap_or(A::from(16u8).into());
                for (half, v) in [("", lo), (".4", hi)] {
                    let mut mov = OpData::build("xe3.eu.mov");
                    mov.set("exec", exec.clone());
                    mov.set("dst", A::str(format!("r{}{half}<2>:ud", self.reg[&r])).into());
                    mov.set("src0", A::str(format!("r{}<1;1,0>:ud", self.reg[&v])).into());
                    self.rw.set_before(op);
                    self.rw.create(mov, &[]);
                }
                self.rw.modify(op, |b| {
                    b.set_operands(op, Vec::new());
                    b[op].results.clear();
                });
                self.rw.erase_op(op);
                continue;
            }
            let attrs = if self.rw.body[op].name.starts_with("xe3.eu.send") { self.send_registers(op)? } else { self.registers(op)? };
            // the attributes taken off by those are part of the same in-place change, told here
            self.rw.modify(op, |b| {
                for (n, a) in attrs {
                    b[op].set(n, a);
                }
                b.set_operands(op, Vec::new());
                b[op].results.clear();
            });
        }
        for op in ops.into_iter().filter(|o| self.is(*o, "xe3.eu.payload")).collect::<Vec<_>>() {
            self.rw.modify(op, |b| b[op].results.clear());
            self.rw.erase_op(op);
        }
        Ok(())
    }

    /// A send's registers: its payload in consecutive registers, `src0_len` of them in src0, the rest in src1.
    fn send_registers(&mut self, op: OpId) -> Result<Vec<(&'static str, Attribute<'a>)>, Error> {
        let operands = &self.rw.body[op].operands;
        let n0 = self.rw.body[op].get("src0_len").map(Attrs::as_int).transpose()?.unwrap_or(operands.len() as i64) as usize;
        let regs: Vec<u8> = operands.iter().map(|v| self.reg[v]).collect();
        let sizes: Vec<u8> = operands.iter().map(|v| GrfFile.size(self.rw.body, *v).map(|(n, _)| n as u8)).collect::<Result<_, _>>()?;
        if regs.windows(2).zip(&sizes).any(|(w, n)| w[1] != w[0] + n) {
            return Err(Error(format!("send payload not in consecutive registers: {regs:?}")));
        }
        let dst = self.rw.body[op].results.first().map_or_else(|| "null".to_owned(), |r| format!("r{}", self.reg[r]));
        let mut attrs = vec![("dst", A::str(dst).into()), ("src0", A::str(format!("r{}", regs[0])).into())];
        if let Some(r) = regs.get(n0) {
            attrs.push(("src1", A::str(format!("r{r}")).into()));
        }
        self.rw.body[op].remove("src0_len");
        Ok(attrs)
    }

    /// Any other instruction's registers: each operand in the next source slot its attributes leave open, its
    /// result the destination.
    fn registers(&mut self, op: OpId) -> Result<Vec<(&'static str, Attribute<'a>)>, Error> {
        let operands = self.rw.body[op].operands.clone();
        let retype = Retype::of(&mut self.rw.body[op]);
        let open: Vec<&str> = SOURCES.iter().copied().filter(|s| self.rw.body[op].get(s).is_none()).collect();
        // `half1`: source 1 is one 16-bit half of each dword ("lo" / "hi"), as a word (32 x 16 multiplies)
        let half1 = self.rw.body[op].get_str("half1").map(|h| if h == "hi" { ".2" } else { "" });
        self.rw.body[op].remove("half1");
        // `byte0`: source 0 is byte k of each dword, as an unsigned byte (unpacking)
        let byte0 = self.rw.body[op].get("byte0").map(Attrs::as_int).transpose()?;
        self.rw.body[op].remove("byte0");
        // `low0`: source 0 is the low 16-bit half of each dword, as a word (packing into words: a same-type move, the
        // region rules forbid a dword source with a packed word destination)
        let low0 = self.rw.body[op].remove("low0");
        // `packed0`: source 0 holds packed words (a `dst_as = "uw"` result), read as such (widening them)
        let packed0 = self.rw.body[op].remove("packed0");
        // `hi0`: source 0 is the high dwords of a 64-bit value (an f64's sign and exponent), as :ud
        let hi0 = self.rw.body[op].remove("hi0");
        // `wide0 = t`: source 0 is 32-bit elements of type t a qword apart (half of a 64-bit value's registers: a
        // conversion's 32-bit side, which the region rules want qword-aligned with the 64-bit one)
        let wide0 = self.rw.body[op].get_str("wide0").map(str::to_owned);
        self.rw.body[op].remove("wide0");
        let dst_wide = self.rw.body[op].get_str("dst_wide").map(str::to_owned);
        self.rw.body[op].remove("dst_wide");
        let mut attrs = Vec::new();
        for (slot, v) in open.into_iter().zip(operands) {
            let negated = self.rw.body[op].remove(&format!("neg{}", &slot[3..]));
            let abs = self.rw.body[op].remove(&format!("abs{}", &slot[3..]));
            let operand = match (half1, slot) {
                (Some(sub), "src1") => format!("r{}{sub}<16;8,2>:uw", self.reg[&v]),
                _ if slot == "src0" && let Some(k) = byte0 => format!("r{}.{k}<32;8,4>:ub", self.reg[&v]),
                _ if slot == "src0" && low0 => format!("r{}<16;8,2>:uw", self.reg[&v]),
                _ if slot == "src0" && packed0 => format!("r{}<1;1,0>:uw", self.reg[&v]),
                _ if slot == "src0" && let Some(t) = &wide0 => format!("r{}<2;1,0>:{t}", self.reg[&v]),
                _ if slot == "src0" && hi0 => format!("r{}.4<2;1,0>:ud", self.reg[&v]),
                _ => self.operand(v, negated, abs, retype)?,
            };
            attrs.push((slot, A::str(operand).into()));
        }
        if let Some(r) = self.rw.body[op].results.first().copied() {
            // `dst_as`: the destination as its sources' type (an integer compare's mask)
            let dst_as = self.rw.body[op].get_str("dst_as").and_then(Retype::named);
            self.rw.body[op].remove("dst_as");
            let dst = match &dst_wide {
                // `dst_wide = t`: written as 32-bit elements of type t a qword apart (see `wide0`)
                Some(t) => format!("r{}<2>:{t}", self.reg[&r]),
                None => self.operand(r, false, false, dst_as.unwrap_or(retype))?,
            };
            attrs.push(("dst", A::str(dst).into()));
        }
        Ok(attrs)
    }
}

/// How an instruction reads its registers other than as their values' types: `unsigned` (an i32 as :ud: unsigned
/// compares, shifts, min / max, conversions) or `as = "ud"` (every register as that type: bit operations on masks;
/// `dst_as = "uw"`: the destination packed words, a 16-bit message parameter).
#[derive(Clone, Copy)]
enum Retype {
    Keep,
    Unsigned,
    As(&'static str),
}

impl Retype {
    /// `as = name`: every register as that type.
    fn named(name: &str) -> Option<Retype> {
        ["ud", "f", "d", "uw", "uq", "q"].into_iter().find(|t| *t == name).map(Retype::As)
    }

    /// What `op` asks, its attribute taken off.
    fn of(op: &mut OpData<'_>) -> Retype {
        let named = op.get_str("as").and_then(Retype::named);
        op.remove("as");
        match named {
            Some(r) => r,
            None if op.remove("unsigned") => Retype::Unsigned,
            None => Retype::Keep,
        }
    }
}

/// `xe3-regalloc`: every `image.kernel` of the module.
#[pass("xe3-regalloc", on = "builtin.module")]
pub fn xe3_regalloc<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    for k in Kernels::all(body, op, Xe3Kernel::NAME) {
        // the first register after the payload (0 when the kernel does not say)
        let reserve = body.head::<Xe3Kernel>(k)?.reserve.unwrap_or(0) as u8;
        let block = body.top_block(k);
        let mut quiet = Quiet;
        let mut a = Alloc { rw: Rewriter::new(body, &mut quiet), block, reg: BTreeMap::new() };
        let webs = a.webs();
        let (fixed, groups) = a.messages()?;
        a.assign(fixed, groups, &webs, reserve, EOT_GRF)?;
        a.structure()?;
        a.rewrite()?;
    }
    Ok(())
}
