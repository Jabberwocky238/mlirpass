use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec::Vec;

use alloc::format;

use mlirformat::{Error, FloatKind, Type};
use mlirformat::Attribute;

use crate::{Attrs, Body, BlockId, OpId, ValueId};

#[derive(Clone, Copy, Debug)]
pub struct Interval {
    pub value: ValueId,
    pub lo: u32,
    pub hi: u32,
    pub float: bool,
    pub across_call: bool,
}

impl Interval {
    const PSEUDO: [&str; 3] = [Template::HOLE, Template::SLOT, Template::JUMP];

    fn clobbers(body: &Body<'_>, op: OpId) -> bool {
        body[op].name == "llvm.call" && !body[op].get("callee").and_then(|a| Attrs::as_symbol(a).ok()).is_some_and(|c| Self::PSEUDO.iter().any(|p| c.starts_with(p)))
    }

    pub fn of(body: &Body<'_>, blocks: &[BlockId]) -> Result<Vec<Interval>, Error> {
        let mut index: BTreeMap<ValueId, u32> = BTreeMap::new();
        let mut values: Vec<ValueId> = Vec::new();
        let mut def: Vec<u32> = Vec::new();
        let mut used: Vec<u32> = Vec::new();
        let block_at: BTreeMap<BlockId, usize> = blocks.iter().enumerate().map(|(i, &b)| (b, i)).collect();
        let (mut start, mut end) = (alloc::vec![0u32; blocks.len()], alloc::vec![0u32; blocks.len()]);
        let mut calls = Vec::new();
        let mut uses: Vec<Vec<u32>> = alloc::vec![Vec::new(); blocks.len()];
        let mut defs: Vec<Vec<u32>> = alloc::vec![Vec::new(); blocks.len()];
        let mut succs: Vec<Vec<usize>> = alloc::vec![Vec::new(); blocks.len()];
        let mut pos = 0u32;
        let define = |v: ValueId, at: u32, index: &mut BTreeMap<ValueId, u32>, values: &mut Vec<ValueId>, def: &mut Vec<u32>, used: &mut Vec<u32>| -> u32 {
            let k = u32::try_from(values.len()).unwrap_or(u32::MAX);
            index.insert(v, k);
            values.push(v);
            def.push(at);
            used.push(at);
            k
        };
        for (bi, &b) in blocks.iter().enumerate() {
            start[bi] = pos;
            for &a in body[b].args.iter() {
                let k = define(a, pos, &mut index, &mut values, &mut def, &mut used);
                defs[bi].push(k);
            }
            for op in body.block_ops(b) {
                pos += 1;
                for &r in body[op].results.iter() {
                    let k = define(r, pos, &mut index, &mut values, &mut def, &mut used);
                    defs[bi].push(k);
                }
                if Self::clobbers(body, op) {
                    calls.push(pos);
                }
                succs[bi] = body[op].successors.iter().filter_map(|s| block_at.get(s).copied()).collect();
            }
            end[bi] = pos;
            pos += 1;
        }
        let mut seen = alloc::vec![u32::MAX; values.len()];
        for (bi, &b) in blocks.iter().enumerate() {
            let mut at = start[bi];
            for &k in &defs[bi] {
                seen[k as usize] = u32::try_from(bi).unwrap_or(u32::MAX);
            }
            for op in body.block_ops(b) {
                at += 1;
                for &v in body[op].operands.iter() {
                    let k = *index.get(&v).ok_or_else(|| Error("a value defined outside the function".into()))?;
                    used[k as usize] = used[k as usize].max(at);
                    let local = seen[k as usize] == u32::try_from(bi).unwrap_or(u32::MAX) && def[k as usize] < at;
                    if !local {
                        uses[bi].push(k);
                    }
                }
            }
        }
        let n = values.len();
        let words = n.div_ceil(64);
        let bits = |list: &[u32]| {
            let mut w = alloc::vec![0u64; words];
            for &k in list {
                w[k as usize / 64] |= 1 << (k % 64);
            }
            w
        };
        let gen_: Vec<Vec<u64>> = uses.iter().map(|u| bits(u)).collect();
        let kill: Vec<Vec<u64>> = defs.iter().map(|d| bits(d)).collect();
        let mut live_in = alloc::vec![alloc::vec![0u64; words]; blocks.len()];
        let mut live_out = alloc::vec![alloc::vec![0u64; words]; blocks.len()];
        loop {
            let mut changed = false;
            for i in (0..blocks.len()).rev() {
                let mut out = alloc::vec![0u64; words];
                for &s in &succs[i] {
                    for (o, x) in out.iter_mut().zip(&live_in[s]) {
                        *o |= *x;
                    }
                }
                let inn: Vec<u64> = gen_[i].iter().zip(&out).zip(&kill[i]).map(|((g, o), k)| g | (o & !k)).collect();
                if out != live_out[i] || inn != live_in[i] {
                    changed = true;
                    live_out[i] = out;
                    live_in[i] = inn;
                }
            }
            if !changed {
                break;
            }
        }
        let (mut lo, mut hi): (Vec<u32>, Vec<u32>) = (def.clone(), def.iter().zip(&used).map(|(d, u)| (*d).max(*u)).collect());
        for i in 0..blocks.len() {
            for (wi, (&li, &lo_)) in live_in[i].iter().zip(&live_out[i]).enumerate() {
                let mut w = li;
                while w != 0 {
                    let k = wi * 64 + w.trailing_zeros() as usize;
                    w &= w - 1;
                    lo[k] = lo[k].min(start[i]);
                    hi[k] = hi[k].max(start[i]);
                }
                let mut w = lo_;
                while w != 0 {
                    let k = wi * 64 + w.trailing_zeros() as usize;
                    w &= w - 1;
                    hi[k] = hi[k].max(end[i]);
                }
            }
        }
        let mut out = Vec::with_capacity(n);
        for (k, &value) in values.iter().enumerate() {
            let float = matches!(body[value].ty, Type::Float(FloatKind::F64));
            let first = calls.partition_point(|&c| c <= lo[k]);
            let across_call = calls.get(first).is_some_and(|&c| c < hi[k]);
            out.push(Interval { value, lo: lo[k], hi: hi[k], float, across_call });
        }
        out.sort_by_key(|iv| (iv.lo, iv.hi));
        Ok(out)
    }
}

pub struct Template;

impl Template {
    /// Below the frame pointer a stencil's caller has pushed its five callee-saved registers; spills
    /// start under them.
    pub const SAVED_END: i32 = -8 * 5;
    pub const SPILL_TOP: i32 = Self::SAVED_END;
    pub const SPILL_WORDS: i32 = 16;
    pub const ATTR: &str = "stencil";
    pub const HOLE: &str = "hole.";
    pub const SLOT: &str = "slot.";
    pub const JUMP: &str = "jump.";

    pub fn callee<'s>(body: &'s Body<'_>, op: OpId) -> Option<&'s str> {
        (body[op].name == "llvm.call").then(|| body[op].get("callee").and_then(|a| Attrs::as_symbol(a).ok())).flatten()
    }

    pub fn slots(body: &Body<'_>, f: OpId) -> Option<BTreeMap<ValueId, String>> {
        if !body[f].has_flag(Self::ATTR) {
            return None;
        }
        let region = body[f].regions[0];
        let frame = body[region].blocks.first().and_then(|b| body[*b].args.get(1).copied());
        let mut slots: BTreeMap<ValueId, String> = BTreeMap::new();
        for &b in body[region].blocks.iter() {
            for op in body.block_ops(b) {
                let virt = match Self::callee(body, op) {
                    Some(c) if c.starts_with(Self::SLOT) => Some(String::from(c)),
                    _ => match (&*body[op].name, body[op].operands.first(), body[op].operands.get(1)) {
                        ("llvm.add", Some(&a), Some(o)) if Some(a) == frame => slots.get(o).cloned(),
                        ("llvm.add", Some(o), Some(&a)) if Some(a) == frame => slots.get(o).cloned(),
                        ("llvm.inttoptr", Some(a), _) => slots.get(a).cloned(),
                        _ => None,
                    },
                };
                if let (Some(name), Some(&r)) = (virt, body[op].results.first()) {
                    slots.insert(r, name);
                }
            }
        }
        Some(slots)
    }

    pub fn stencils(body: &Body<'_>, root: OpId) -> Vec<(String, OpId)> {
        let mut out = Vec::new();
        for &region in body[root].regions.iter() {
            for &block in body[region].blocks.iter() {
                for f in body.block_ops(block) {
                    if body[f].name == "llvm.func" && body[f].has_flag(Self::ATTR)
                        && let Some(name) = body[f].get_str("sym_name")
                    {
                        out.push((String::from(name), f));
                    }
                }
            }
        }
        out
    }
}

/// What a template's call names: a frame slot, a constant or address filled in when copied,
/// a jump to the next stencil, or a runtime function.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Callee<'s> {
    Slot(&'s str),
    Hole(&'s str),
    Jump(&'s str),
    Runtime(&'s str),
}

impl<'s> From<&'s str> for Callee<'s> {
    fn from(name: &'s str) -> Self {
        if name.starts_with(Template::SLOT) {
            Callee::Slot(name)
        } else if name.starts_with(Template::HOLE) {
            Callee::Hole(name)
        } else if name.starts_with(Template::JUMP) {
            Callee::Jump(name)
        } else {
            Callee::Runtime(name)
        }
    }
}

/// A compare's `predicate` attribute.
pub struct Pred;

impl Pred {
    pub fn of<P: TryFrom<i64, Error = i64>>(body: &Body<'_>, op: OpId) -> Result<P, Error> {
        let a = body[op].get("predicate").ok_or_else(|| Error(format!("{} without a predicate", body[op].name)))?;
        P::try_from(Attrs::as_int(a)?).map_err(|v| Error(format!("predicate {v} out of range")))
    }
}

/// An `llvm.mlir.constant`'s bits.
pub struct Constant;

impl Constant {
    /// The value's bits as a `t` (an integer masked to its width, a float's IEEE bits).
    pub fn bits(body: &Body<'_>, op: OpId, t: crate::targets::Mvt) -> Result<u64, Error> {
        let value = body[op].get("value").ok_or_else(|| Error("llvm.mlir.constant without a value".into()))?;
        let bits: u64 = match (value, t) {
            (Attribute::Bool(b), _) => u64::from(*b),
            (Attribute::Float { lit, .. }, crate::targets::Mvt::F32) => match lit.strip_prefix("0x").or_else(|| lit.strip_prefix("0X")) {
                Some(h) => u64::from_str_radix(h, 16).map_err(|_| Error(format!("bad float {lit}")))?,
                None => u64::from(lit.parse::<f32>().map_err(|_| Error(format!("bad float {lit}")))?.to_bits()),
            },
            (Attribute::Float { lit, .. }, _) => match lit.strip_prefix("0x").or_else(|| lit.strip_prefix("0X")) {
                Some(h) => u64::from_str_radix(h, 16).map_err(|_| Error(format!("bad float {lit}")))?,
                None => lit.parse::<f64>().map_err(|_| Error(format!("bad float {lit}")))?.to_bits(),
            },
            (Attribute::Int { lit, .. }, _) => match lit.strip_prefix("0x") {
                Some(h) => u64::from_str_radix(h, 16).map_err(|_| Error(format!("bad integer {lit}")))?,
                None => Attrs::as_int(value)?.cast_unsigned(),
            },
            (a, _) => return Err(Error(format!("constant {a} is not supported"))),
        };
        Ok(match t.bits() {
            64 => bits,
            w => bits & ((1u64 << w) - 1),
        })
    }
}

/// The function's `llvm.alloca`s of a constant count: each one's result, size and alignment, for
/// the frame to hold.
pub struct Allocas;

impl Allocas {
    pub fn of(body: &Body<'_>, blocks: &[BlockId]) -> Result<Vec<(ValueId, u64, u64)>, Error> {
        let mut out = Vec::new();
        for &b in blocks {
            for op in body.block_ops(b) {
                if body[op].name != "llvm.alloca" {
                    continue;
                }
                let elem = match body[op].get("elem_type") {
                    Some(Attribute::Type(t)) => t.clone(),
                    _ => return Err(Error("llvm.alloca without an element type".into())),
                };
                let count = body[op]
                    .operands
                    .first()
                    .and_then(|&n| body.def_op(n))
                    .filter(|&d| body[d].name == "llvm.mlir.constant")
                    .map(|d| Constant::bits(body, d, crate::targets::Mvt::I64))
                    .transpose()?
                    .ok_or_else(|| Error("llvm.alloca of a count not constant".into()))?;
                let dl = crate::DataLayout::closest(body, op);
                let align = body[op].get("alignment").and_then(|a| Attrs::as_int(a).ok()).map_or(dl.abi_align(&elem), |a| a.cast_unsigned()).max(1);
                out.push((body[op].results[0], dl.size(&elem) * count, align));
            }
        }
        Ok(out)
    }
}
