//! ⭐ `xe3-swsb`: the software scoreboard of every kernel (after `xe3-regalloc`).
//!
//! In-order instructions run on a pipe (float, int, long, math, by their destination type); one that reads or writes
//! a register an earlier in-order one writes, or writes one an earlier one on another pipe reads, waits for it
//! (Mesa brw_lower_scoreboard tracks reads too): `<pipe>@<distance>`, the distance counted on that pipe
//! (7 at most: waiting for a later one of the same pipe waits for it too). Dependencies on several pipes wait on all
//! (`A@<the smallest distance>`). A send runs out of order: one that does not end the thread takes an SBID (`$n`,
//! Mesa brw_lower_scoreboard: every unordered instruction but EOT), and a later instruction that writes what it reads
//! waits for `$n.src`, one that touches what it writes for `$n.dst`. An instruction waits on one token itself; more
//! tokens, or any for a send (which sets its own), are waited for by `sync.nop`s just before it; a send taking a
//! token still in flight (32 sends ago) waits for it first (Mesa brw_lower_scoreboard).

#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, boxed::Box, format, string::{String, ToString}, vec, vec::Vec};

use alloc::collections::BTreeMap;
use core::ops::Range;

use mlirformat::Op;
use mlirformat::Error;
use crate::{DO, is_control};
use crate::{Body, EuFormat as Format, EuOpcode as Opcode, EuOperand as Operand, File, Inst, Kernels, OpData, OpId, Pipe, Quiet, Rewriter, SbidMode, Swsb, SyncFn, Xe3Kernel, pass};

/// What the scoreboard needs of an instruction: the registers it reads and writes, and its pipe (`None`: out of
/// order).
struct Footprint {
    reads: Vec<Range<u32>>,
    writes: Range<u32>,
    pipe: Option<Pipe>,
}

impl Footprint {
    fn of(i: &Inst) -> Footprint {
        if i.op.format() == Format::Send {
            let (mlen, rlen) = ((i.send.desc >> 25) & 0xf, (i.send.desc >> 20) & 0x1f);
            let reads = vec![Self::regs(&i.src[0], i.exec_size, Some(mlen), false), Self::regs(&i.src[1], i.exec_size, Some(i.send.src1_len.into()), false)];
            return Footprint { reads, writes: Self::regs(&i.dst, i.exec_size, Some(rlen), true), pipe: None };
        }
        let reads = Self::sources(i).iter().map(|s| Self::regs(s, i.exec_size, None, false)).collect();
        let pipe = if i.op == Opcode::Math {
            Pipe::Math
        } else if i.dst.ty.size() == 8 {
            Pipe::Long
        } else if i.dst.ty.is_float() {
            Pipe::Float
        } else {
            Pipe::Int
        };
        Footprint { reads, writes: Self::regs(&i.dst, i.exec_size, None, true), pipe: Some(pipe) }
    }

    /// The registers an operand covers (none for an immediate, the null register or an ARF): from its sub-register
    /// to its last element's end, by its region (a destination's horizontal stride, 0 meaning 1; a source's
    /// `<vstride;width,hstride>`): a 32-bit side a qword apart spans two registers at SIMD16.
    fn regs(o: &Operand, exec: u8, count: Option<u32>, dst: bool) -> Range<u32> {
        if o.file != File::Grf {
            return 0..0;
        }
        let n = count.unwrap_or_else(|| {
            let last = u32::from(exec.max(1)) - 1;
            let r = o.region;
            let offset = if dst {
                last * u32::from(r.hstride.max(1))
            } else {
                let width = u32::from(r.width.max(1));
                (last / width) * u32::from(r.vstride) + (last % width) * u32::from(r.hstride)
            };
            (u32::from(o.subnr) + (offset + 1) * o.ty.size()).div_ceil(64).max(1)
        });
        u32::from(o.nr)..u32::from(o.nr) + n
    }

    /// The sources an in-order instruction reads.
    fn sources(i: &Inst) -> &[Operand] {
        let n = match i.op.format() {
            Format::One => 1,
            Format::Two => 2,
            _ => 3,
        };
        &i.src[..n]
    }

    /// The pipe the hardware syncs an in-order instruction's RegDist with when its SWSB names none (a RegDist and an
    /// SBID together): its sources' type, a 64-bit one long, an integer one int, else float (Mesa `inferred_sync_pipe`).
    fn inferred(i: &Inst) -> Pipe {
        let src = Self::sources(i);
        if src.iter().any(|s| s.ty.size() >= 8) {
            Pipe::Long
        } else if src.iter().any(|s| !s.ty.is_float()) {
            Pipe::Int
        } else {
            Pipe::Float
        }
    }
}

/// The scoreboard of one kernel.
#[derive(Default)]
struct Board {
    /// in-order instructions issued so far, per pipe
    issued: BTreeMap<Pipe, u32>,
    /// the last in-order writer of each register: (pipe, its number on that pipe)
    writer: BTreeMap<u32, (Pipe, u32)>,
    /// the last in-order reader of each register on each pipe (its number on that pipe)
    readers: BTreeMap<u32, BTreeMap<Pipe, u32>>,
    /// out-of-order sends in flight: token, registers read, registers written
    pending: Vec<(u8, Vec<u32>, Vec<u32>)>,
    next_token: u8,
}

impl Board {
    /// The SBID waits `i` needs (`$n.src` / `$n.dst`).
    fn token_waits(&self, reads: &[Range<u32>], writes: &Range<u32>) -> Vec<(u8, SbidMode)> {
        let mut waits = Vec::new();
        for (t, r, w) in &self.pending {
            let touches = |regs: &[u32], range: &Range<u32>| regs.iter().any(|x| range.contains(x));
            let mode = if touches(w, writes) || reads.iter().any(|rr| touches(w, rr)) {
                Some(SbidMode::Dst)
            } else if touches(r, writes) {
                Some(SbidMode::Src)
            } else {
                None
            };
            if let Some(m) = mode {
                waits.push((*t, m));
            }
        }
        waits
    }

    /// `i`'s dependencies, and the `sync.nop`s' before it.
    fn swsb(&mut self, i: &Inst) -> (Swsb, Vec<Swsb>) {
        let Footprint { reads, writes, pipe } = Footprint::of(i);
        let mut deps: BTreeMap<Pipe, u32> = BTreeMap::new();
        let mut depend = |p: Pipe, n: u32, issued: &BTreeMap<Pipe, u32>| {
            let distance = issued[&p] - n;
            let d = deps.entry(p).or_insert(distance);
            *d = (*d).min(distance);
        };
        for r in reads.iter().cloned().flatten().chain(writes.clone()) {
            if let Some((p, n)) = self.writer.get(&r) {
                depend(*p, *n, &self.issued);
            }
        }
        // write after read: a reader on another pipe may not have read yet (one on the same pipe has: in order)
        for r in writes.clone() {
            for (p, n) in self.readers.get(&r).into_iter().flatten() {
                if Some(*p) != pipe {
                    depend(*p, *n, &self.issued);
                }
            }
        }
        let mut swsb = match deps.len() {
            0 => Swsb::NONE,
            1 => {
                let (p, d) = deps.into_iter().next().unwrap();
                Swsb::regdist(p, d.min(7) as u8)
            }
            _ => Swsb::regdist(Pipe::All, deps.values().min().copied().unwrap().min(7) as u8),
        };
        let mut waits = self.token_waits(&reads, &writes);
        // waited for: `.dst` the whole send, `.src` only its reads (what it writes may still be coming)
        self.pending.retain(|(p, _, _)| !waits.iter().any(|(t, m)| t == p && *m == SbidMode::Dst));
        for (p, r, _) in &mut self.pending {
            if waits.iter().any(|(t, m)| t == p && *m == SbidMode::Src) {
                r.clear();
            }
        }
        let unordered = pipe.is_none() && !i.send.eot;
        // the instruction keeps one wait, unless it sets a token of its own
        let own = if unordered { None } else { waits.pop() };
        let mut syncs: Vec<Swsb> = waits.into_iter().map(|(sbid, mode)| Swsb { sbid, mode, ..Swsb::NONE }).collect();
        // a RegDist and an SBID in one SWSB: the RegDist on the inferred pipe (float or int), or on all of them with
        // `.dst`; else the token goes to a sync.nop (Mesa `baked_ordered_dependency_mode`, Xe2+)
        if let Some((t, m)) = own {
            let p = swsb.pipe;
            let baked = swsb.regdist == 0 || (p == Footprint::inferred(i) && matches!(p, Pipe::Float | Pipe::Int)) || (p == Pipe::All && m == SbidMode::Dst);
            if baked {
                swsb.sbid = t;
                swsb.mode = m;
            } else {
                syncs.push(Swsb { sbid: t, mode: m, ..Swsb::NONE });
            }
        }
        // a send setting its token takes a RegDist on float, int or all pipes only
        if unordered && swsb.regdist != 0 && !matches!(swsb.pipe, Pipe::Float | Pipe::Int | Pipe::All) {
            swsb.pipe = Pipe::All;
        }
        if unordered {
            let t = self.next_token;
            self.next_token = (t + 1) % 32;
            // the token still in flight (32 sends ago): wait for it before setting it again (Mesa brw_lower_scoreboard)
            if let Some(k) = self.pending.iter().position(|(p, _, _)| *p == t) {
                self.pending.remove(k);
                syncs.push(Swsb { sbid: t, mode: SbidMode::Dst, ..Swsb::NONE });
            }
            swsb.sbid = t;
            swsb.mode = SbidMode::Set;
            self.pending.push((t, reads.iter().cloned().flatten().collect(), writes.clone().collect()));
        }
        if let Some(p) = pipe {
            let n = self.issued.entry(p).or_default();
            for r in reads.iter().cloned().flatten() {
                self.readers.entry(r).or_default().insert(p, *n);
            }
            for r in writes {
                self.writer.insert(r, (p, *n));
            }
            *n += 1;
        }
        (swsb, syncs)
    }
}

/// `xe3-swsb`: every `image.kernel` of the module.
#[pass("xe3-swsb", on = "builtin.module")]
pub fn xe3_swsb<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let mut quiet = Quiet;
    let mut rw = Rewriter::new(body, &mut quiet);
    for k in Kernels::all(rw.body, op, Xe3Kernel::NAME) {
        let mut board = Board::default();
        let block = rw.body.top_block(k);
        for i in rw.body.block_ops(block) {
            // a branch, a loop header: everything before done first (the board does not follow jumps), the board anew
            if is_control(&rw.body[i].name) {
                for sync in [SyncFn::AllWr, SyncFn::AllRd] {
                    let (name, attrs) = Inst { sync, ..Inst::new(Opcode::Sync, 1) }.op();
                    let mut data = OpData::build(&name);
                    data.attributes = attrs;
                    rw.set_before(i);
                    rw.create(data, &[]);
                }
                let (name, attrs) = Inst { swsb: Swsb::regdist(Pipe::All, 1), ..Inst::new(Opcode::Sync, 1) }.op();
                let mut data = OpData::build(&name);
                data.attributes = attrs;
                rw.set_before(i);
                rw.create(data, &[]);
                board = Board::default();
                if rw.body[i].name == DO {
                    continue;
                }
            }
            let attrs = rw.body[i].all_attrs();
            let mut inst = Inst::try_from((&*rw.body[i].name, &attrs[..]))?;
            // a dependency set by hand (the cr0 prologue's sync) unless the board finds one
            let (found, syncs) = board.swsb(&inst);
            if found != Swsb::NONE {
                inst.swsb = found;
            }
            for s in syncs {
                let sync = Inst { swsb: s, ..Inst::new(Opcode::Sync, 1) };
                let (name, attrs) = sync.op();
                let mut data = OpData::build(&name);
                data.attributes = attrs;
                rw.set_before(i);
                rw.create(data, &[]);
            }
            let (_, attrs) = inst.op();
            rw.modify(i, |b| {
                b[i].properties.clear();
                b[i].attributes = attrs;
            });
        }
    }
    Ok(())
}
