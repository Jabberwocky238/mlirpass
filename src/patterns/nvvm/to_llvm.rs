//! `nvvm` ⇒ `llvm.inline_asm`, as `NVVMToLLVM.cpp` with `BasicPtxBuilderInterface.cpp`: the ops
//! that build their own PTX, when no intrinsic covers them.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, ShapedKind, Type};

use crate::patterns;
use crate::{ConversionRewriter, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `kSharedMemorySpace`.
const SHARED: u32 = 3;

/// `PTXRegisterMod`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Mod {
    Read,
    Write,
    ReadWrite,
}

impl Mod {
    const fn prefix(self) -> &'static str {
        match self {
            Mod::Read => "",
            Mod::Write => "=",
            Mod::ReadWrite => "+",
        }
    }
}

/// The ops with a `BasicPtxBuilderInterface`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum PtxOp {
    InlinePtx,
    MbarrierInit,
    MbarrierArriveExpectTx,
    MbarrierTryWaitParity,
    BarrierArrive,
    TmaLoad,
    TmaStore,
    Prefetch,
    Wgmma,
}

impl PtxOp {
    const TABLE: [(&'static str, Self); 9] = [
        ("nvvm.inline_ptx", Self::InlinePtx),
        ("nvvm.mbarrier.init", Self::MbarrierInit),
        ("nvvm.mbarrier.arrive.expect_tx", Self::MbarrierArriveExpectTx),
        ("nvvm.mbarrier.try_wait.parity", Self::MbarrierTryWaitParity),
        ("nvvm.barrier.arrive", Self::BarrierArrive),
        ("nvvm.cp.async.bulk.tensor.shared.cluster.global", Self::TmaLoad),
        ("nvvm.cp.async.bulk.tensor.global.shared.cta", Self::TmaStore),
        ("nvvm.prefetch", Self::Prefetch),
        ("nvvm.wgmma.mma_async", Self::Wgmma),
    ];
}

impl TryFrom<&str> for PtxOp {
    type Error = ();
    fn try_from(name: &str) -> Result<Self, ()> {
        Self::TABLE.iter().find(|(n, _)| *n == name).map(|(_, v)| *v).ok_or(())
    }
}

/// `NVVM::WGMMATypes`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum WgmmaType {
    F16,
    Tf32,
    U8,
    S8,
    B1,
    Bf16,
    E4m3,
    E5m2,
    F32,
    S32,
}

impl WgmmaType {
    const NAMES: [(&'static str, Self); 10] = [("f16", Self::F16), ("tf32", Self::Tf32), ("u8", Self::U8), ("s8", Self::S8), ("b1", Self::B1), ("bf16", Self::Bf16), ("e4m3", Self::E4m3), ("e5m2", Self::E5m2), ("f32", Self::F32), ("s32", Self::S32)];

    fn name(self) -> &'static str {
        Self::NAMES.iter().find(|(_, v)| *v == self).map_or("", |(n, _)| n)
    }
}

/// The case of `#nvvm.<attr><case>` among `names`.
fn nv_case<T: Copy>(a: Option<&Attribute<'_>>, attr: &str, names: &[(&'static str, T)]) -> Option<T> {
    let Some(Attribute::Extended { ext, .. }) = a else { return None };
    if ext.name != attr {
        return None;
    }
    let b = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?.trim();
    names.iter().find(|(n, _)| *n == b).map(|(_, v)| *v)
}

/// `#nvvm.shape<m = .., n = .., k = ..>`.
fn shape(a: Option<&Attribute<'_>>) -> Option<[i64; 3]> {
    let Some(Attribute::Extended { ext, .. }) = a else { return None };
    let b = ext.body.as_deref()?.strip_prefix('<')?.strip_suffix('>')?;
    let mut out = [0i64; 3];
    for part in b.split(',') {
        let (k, v) = part.split_once('=')?;
        let i = ["m", "n", "k"].iter().position(|x| *x == k.trim())?;
        out[i] = v.trim().parse().ok()?;
    }
    Some(out)
}

/// `PtxBuilder`.
#[derive(Default)]
struct Ptx {
    operands: Vec<ValueId>,
    mods: Vec<Mod>,
    constraints: String,
    has_result: bool,
}

impl Ptx {
    /// `getRegisterType` of a type.
    fn register(t: &Type<'_>) -> Option<char> {
        let scalar = |t: &Type<'_>| -> Option<char> {
            Some(match t {
                Type::Integer { width: 1, .. } => 'b',
                Type::Integer { width: 16, .. } => 'h',
                Type::Integer { width: 32, .. } => 'r',
                Type::Integer { width: 64, .. } => 'l',
                Type::Float(FloatKind::F32) => 'f',
                Type::Float(FloatKind::F64) => 'd',
                t => match LlvmType::try_from(t) {
                    Ok(LlvmType::Ptr(SHARED)) => 'r',
                    Ok(LlvmType::Ptr(_)) => 'l',
                    _ => return None,
                },
            })
        };
        if let Type::Shaped(v) = t
            && v.kind == ShapedKind::Vector
        {
            let lanes: i64 = v.dims()?.iter().product();
            let elem = &*v.elem;
            if lanes <= 1 {
                return scalar(elem);
            }
            let bits = elem.bit_width();
            let is_float = matches!(elem, Type::Float(_));
            let widened = match lanes {
                2 if matches!(elem, Type::Float(FloatKind::F16 | FloatKind::BF16)) => Type::Float(FloatKind::F32),
                2 if is_float && bits == Some(8) => Type::int(16),
                4 if matches!(elem, Type::Integer { width: 8, .. }) => Type::int(32),
                4 if is_float && bits == Some(8) => Type::Float(FloatKind::F32),
                4 if is_float && bits == Some(4) => Type::int(16),
                _ => elem.clone(),
            };
            return scalar(&widened);
        }
        scalar(t)
    }

    /// `PtxBuilder::insertValue`.
    fn insert(&mut self, cr: &mut Cr<'_, '_, '_>, v: ValueId, m: Mod) -> Option<()> {
        self.mods.push(m);
        let ty = cr.rw.body[v].ty.clone();
        let add = |s: &mut Self, v: ValueId| {
            if m != Mod::Write {
                s.operands.push(v);
            }
            if m != Mod::Read {
                s.has_result = true;
            }
        };
        if let Ok(LlvmType::Struct { body: Some(elems), .. }) = LlvmType::try_from(&ty) {
            if m == Mod::Write {
                add(self, v);
            }
            for (i, t) in elems.iter().enumerate() {
                if m != Mod::Write {
                    let e = cr.extract(v, &[i as i64]);
                    add(self, e);
                }
                if m == Mod::ReadWrite {
                    self.constraints += &format!("{i},");
                } else {
                    self.constraints += &format!("{}{},", m.prefix(), Self::register(t)?);
                }
            }
            return Some(());
        }
        add(self, v);
        let reg = if cr.rw.body.def_named(v, "llvm.mlir.constant").is_some() { 'n' } else { Self::register(&ty)? };
        self.constraints += &format!("{}{reg},", m.prefix());
        Some(())
    }

    /// `canonicalizeRegisterConstraints`: `+X` as `=X` and the tied indices appended.
    fn canonical(csv: &str) -> String {
        let mut out = Vec::new();
        let mut plus = Vec::new();
        for (i, t) in csv.split(',').enumerate() {
            let t = t.trim();
            match t.strip_prefix('+') {
                Some(r) => {
                    plus.push(i);
                    out.push(format!("={r}"));
                }
                None => out.push(String::from(t)),
            }
        }
        out.extend(plus.into_iter().map(|i| format!("{i}")));
        out.join(",")
    }

    /// The `{$rwN}` / `{$wN}` / `{$rN}` placeholders: kind, number, where.
    fn placeholders(ptx: &str) -> Vec<(Mod, u32, usize, usize)> {
        let b = ptx.as_bytes();
        let mut out = Vec::new();
        let mut i = 0;
        while i + 2 < b.len() {
            if b[i] == b'{' && b[i + 1] == b'$' {
                let rest = &ptx[i + 2..];
                let (kind, skip) = if rest.starts_with("rw") {
                    (Mod::ReadWrite, 2)
                } else if rest.starts_with('w') {
                    (Mod::Write, 1)
                } else if rest.starts_with('r') {
                    (Mod::Read, 1)
                } else {
                    i += 1;
                    continue;
                };
                let digits: String = rest[skip..].chars().take_while(char::is_ascii_digit).collect();
                let end = i + 2 + skip + digits.len();
                if !digits.is_empty() && b.get(end) == Some(&b'}') {
                    out.push((kind, digits.parse().unwrap_or(0), i, end + 1));
                    i = end + 1;
                    continue;
                }
            }
            i += 1;
        }
        out
    }

    /// `rewriteAsmPlaceholders`: read-writes first, then writes, then reads, each sorted.
    fn rewrite_placeholders(ptx: &str) -> String {
        let found = Self::placeholders(ptx);
        let mut ids: Vec<(Mod, u32)> = Vec::new();
        for kind in [Mod::ReadWrite, Mod::Write, Mod::Read] {
            let mut nums: Vec<u32> = found.iter().filter(|f| f.0 == kind).map(|f| f.1).collect();
            nums.sort_unstable();
            nums.dedup();
            ids.extend(nums.into_iter().map(|n| (kind, n)));
        }
        let mut out = String::new();
        let mut prev = 0;
        for (kind, n, s, e) in found {
            out += &ptx[prev..s];
            let id = ids.iter().position(|x| *x == (kind, n)).unwrap_or(0);
            out += &format!("${id}");
            prev = e;
        }
        out + &ptx[prev..]
    }

    /// `needsPackUnpack`.
    fn pack(&self, manual: bool, n_results: usize) -> bool {
        !manual && n_results + self.mods.iter().filter(|m| **m == Mod::ReadWrite).count() > 1
    }

    /// `PtxBuilder::build` then `buildAndReplaceOp`.
    fn finish<'a>(mut self, cr: &mut Cr<'_, 'a, '_>, op: OpId, ptx: String, predicate: bool, manual: bool) {
        let results = cr.rw.body[op].results.clone();
        let result_types: Vec<Type<'a>> = cr.rw.body.types(&results);
        let pack = self.pack(manual, results.len());
        let zipped: Vec<(Mod, ValueId)> = self.mods.iter().copied().zip(self.operands.iter().copied()).collect();
        let types: Vec<Type<'a>> = if !pack && results.len() == 1 {
            result_types.clone()
        } else if let (false, Some((_, v))) = (pack, zipped.iter().find(|(m, _)| *m == Mod::ReadWrite)) {
            vec![cr.rw.body[*v].ty.clone()]
        } else {
            let mut packed: Vec<Type<'a>> = zipped.iter().filter(|(m, _)| *m == Mod::ReadWrite).map(|(_, v)| cr.rw.body[*v].ty.clone()).collect();
            packed.extend(result_types.iter().cloned());
            if packed.is_empty() { Vec::new() } else { vec![LlvmType::literal(packed)] }
        };
        if self.constraints.ends_with(',') {
            self.constraints.pop();
        }
        let constraints = Self::canonical(&self.constraints);
        let mut ptx = if manual { ptx } else { Self::rewrite_placeholders(&ptx) };
        if predicate {
            ptx = format!("@%{} {ptx}", self.operands.len() - 1);
        }
        let ptx = ptx.replace('%', "$");
        let data = OpData::build("llvm.inline_asm")
            .operands(&self.operands)
            .with("asm_dialect", Attribute::i64(0))
            .with("asm_string", Attribute::str(&ptx))
            .with("constraints", Attribute::str(&constraints))
            .with("has_side_effects", Attribute::Unit)
            .with("tail_call_kind", Attribute::dialect("llvm.tailcallkind", "<none>"));
        let asm = cr.rw.create(data, &types);
        let asm_results = cr.rw.body[asm].results.clone();
        if !self.has_result {
            cr.erase(op);
            return;
        }
        if manual || !pack {
            if !asm_results.is_empty() || manual {
                cr.replace(op, asm_results.into_iter().map(|r| vec![r]).collect());
            } else {
                let rw = zipped.iter().find(|(m, _)| *m == Mod::ReadWrite).map(|(_, v)| *v);
                cr.replace(op, rw.into_iter().map(|r| vec![r]).collect());
            }
            return;
        }
        let n = match LlvmType::try_from(&types[0]) {
            Ok(LlvmType::Struct { body: Some(b), .. }) => b.len(),
            _ => 0,
        };
        let unpacked: Vec<ValueId> = (0..n).map(|i| cr.extract(asm_results[0], &[i as i64])).collect();
        let mut idx = 0;
        for (m, v) in &zipped {
            if *m != Mod::ReadWrite {
                continue;
            }
            let repl = unpacked[idx];
            idx += 1;
            cr.rw.replace_uses_if(*v, repl, |_, u| u.op != op && u.op != asm);
        }
        cr.replace(op, unpacked[idx..].iter().map(|r| vec![*r]).collect());
    }
}

/// The nvvm ⇒ llvm patterns (`populateNVVMToLLVMConversionPatterns`).
pub struct NvvmToLlvm;

#[patterns]
impl NvvmToLlvm {
    fn segments(cr: &Cr<'_, '_, '_>, op: OpId) -> Vec<usize> {
        cr.rw.body.dense_i64(op, "operandSegmentSizes").iter().map(|&n| n as usize).collect()
    }

    /// `getPredicate`.
    fn predicate(cr: &Cr<'_, '_, '_>, op: OpId, kind: PtxOp) -> Option<ValueId> {
        let ops = &cr.rw.body[op].operands;
        let last = || ops.last().copied();
        match kind {
            PtxOp::InlinePtx | PtxOp::TmaLoad | PtxOp::TmaStore => (Self::segments(cr, op).last() == Some(&1)).then(last).flatten(),
            PtxOp::MbarrierInit | PtxOp::MbarrierArriveExpectTx => (ops.len() == 3).then(last).flatten(),
            PtxOp::Prefetch => (ops.len() == 2).then(last).flatten(),
            PtxOp::MbarrierTryWaitParity | PtxOp::BarrierArrive | PtxOp::Wgmma => None,
        }
    }

    fn shared(cr: &Cr<'_, '_, '_>, v: ValueId) -> bool {
        matches!(LlvmType::try_from(&cr.rw.body[v].ty), Ok(LlvmType::Ptr(SHARED)))
    }

    /// `getPtx`.
    fn ptx(cr: &Cr<'_, '_, '_>, op: OpId, kind: PtxOp) -> Option<String> {
        let b = &*cr.rw.body;
        let ops = &b[op].operands;
        let space = |shared: bool, s: &'static str| if shared { s } else { "" };
        Some(match kind {
            PtxOp::InlinePtx => {
                let Attribute::Str { lit, .. } = b[op].get("ptxCode")? else { return None };
                String::from_utf8_lossy(&crate::unescape(lit)).into_owned()
            }
            PtxOp::MbarrierInit => format!("mbarrier.init{}.b64 [%0], %1;", space(Self::shared(cr, ops[0]), ".shared")),
            PtxOp::MbarrierArriveExpectTx => format!("mbarrier.arrive.expect_tx{}.b64 _, [%0], %1;", space(Self::shared(cr, ops[0]), ".shared")),
            PtxOp::MbarrierTryWaitParity => format!(
                "{{\n\t.reg .pred       P1; \n\tLAB_WAIT: \n\tmbarrier.try_wait.parity{}.b64 P1, [%0], %1, %2; \n\t@P1 bra.uni DONE; \n\tbra.uni     LAB_WAIT; \n\tDONE: \n\t}}",
                space(Self::shared(cr, ops[0]), ".shared")
            ),
            PtxOp::BarrierArrive => String::from(if ops.len() == 2 { "bar.arrive %0, %1;" } else { "bar.arrive 0, %0;" }),
            PtxOp::TmaLoad => {
                let s = Self::segments(cr, op);
                let (dim, im2col, mcast, l2) = (s[2], s[4], s[5] == 1, s[6] == 1);
                let mut ptx = format!("cp.async.bulk.tensor.{dim}d.shared::cluster.global.mbarrier::complete_tx::bytes");
                if im2col > 0 {
                    ptx += ".im2col";
                }
                if mcast {
                    ptx += ".multicast::cluster";
                }
                if l2 {
                    ptx += ".L2::cache_hint";
                }
                let regs = |from: usize, n: usize| (from..from + n).map(|r| format!("%{r}")).collect::<Vec<_>>().join(",");
                ptx += &format!(" [%0], [%1, {{{}}} ], [%{}]", regs(2, dim), 2 + dim);
                let mut r = 3 + dim;
                if im2col > 0 {
                    ptx += &format!(",{{{}}}", regs(r, im2col));
                    r += im2col;
                }
                if mcast {
                    ptx += &format!(", %{r}");
                    r += 1;
                }
                if l2 {
                    ptx += &format!(", %{r}");
                }
                ptx + ";"
            }
            PtxOp::TmaStore => {
                let dim = *Self::segments(cr, op).get(2)?;
                let coords = (2..2 + dim).map(|r| format!("%{r}")).collect::<Vec<_>>().join(", ");
                format!("cp.async.bulk.tensor.{dim}d.global.shared::cta.bulk_group [%0, {{{coords}}} ], [%1];")
            }
            PtxOp::Prefetch => String::from("prefetch.tensormap [%0];"),
            PtxOp::Wgmma => Self::wgmma_ptx(cr, op)?,
        })
    }

    /// The `#nvvm.wgmma_type` of attribute `name`.
    fn wgmma_type(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<WgmmaType> {
        nv_case(cr.rw.body[op].get(name), "nvvm.wgmma_type", &WgmmaType::NAMES)
    }

    /// `WgmmaMmaAsyncOp::getPtx`.
    fn wgmma_ptx(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<String> {
        let [m, n, k] = shape(cr.rw.body[op].get("shape"))?;
        let (a, bt, d) = (Self::wgmma_type(cr, op, "typeA")?, Self::wgmma_type(cr, op, "typeB")?, Self::wgmma_type(cr, op, "typeD")?);
        let f16 = matches!(a, WgmmaType::F16 | WgmmaType::Bf16);
        let regs = if d == WgmmaType::F16 { n / 4 } else { n / 2 };
        let satfinite = nv_case(cr.rw.body[op].get("satfinite"), "nvvm.mma_int_overflow", &[("satfinite", true), ("wrapped", false)]).unwrap_or(false);
        let mut s = format!("{{\n.reg .pred p;\nsetp.ne.b32 p, ${}, 0;\nwgmma.mma_async.sync.aligned.m{m}n{n}k{k}.{}.{}.{}", regs * 2 + 2, d.name(), a.name(), bt.name());
        if satfinite {
            s += ".satfinite";
        }
        s += " {";
        s += &(0..regs).map(|r| format!("${r}")).collect::<Vec<_>>().join(", ");
        s += "},";
        let rc = regs * 2;
        s += &format!(" ${rc}, ${}, p", rc + 1);
        if d != WgmmaType::S32 {
            s += &format!(", ${},  ${}", rc + 3, rc + 4);
        }
        if f16 {
            s += &format!(", ${},  ${}", rc + 5, rc + 6);
        }
        s += ";\n}\n";
        Some(s)
    }

    fn const_i32(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32))
    }

    /// `getAsmValues`: the values and their modifiers; whether the op maps registers itself.
    fn asm_values(cr: &mut Cr<'_, '_, '_>, op: OpId, kind: PtxOp) -> Option<(Vec<(ValueId, Mod)>, bool)> {
        let b = &*cr.rw.body;
        let ops = b[op].operands.clone();
        let results = b[op].results.clone();
        let mut out: Vec<(ValueId, Mod)> = Vec::new();
        match kind {
            PtxOp::MbarrierArriveExpectTx | PtxOp::TmaLoad => out.extend(ops.iter().map(|v| (*v, Mod::Read))),
            PtxOp::InlinePtx => {
                let s = Self::segments(cr, op);
                let (ro, rw) = (s[0], s[1]);
                out.extend(ops[ro..ro + rw].iter().map(|v| (*v, Mod::ReadWrite)));
                out.extend(results.iter().map(|v| (*v, Mod::Write)));
                out.extend(ops[..ro].iter().map(|v| (*v, Mod::Read)));
                if s.get(2) == Some(&1) {
                    out.push((ops[ro + rw], Mod::Read));
                }
            }
            PtxOp::Wgmma => {
                let (a, d) = (Self::wgmma_type(cr, op, "typeA")?, Self::wgmma_type(cr, op, "typeD")?);
                let get = |n: &str| cr.rw.body[op].get(n).cloned();
                let (scale_d, scale_a, scale_b, layout_a, layout_b) = (get("scaleD"), get("scaleA"), get("scaleB"), get("layoutA"), get("layoutB"));
                out.push((results[0], Mod::Write));
                out.push((ops[0], Mod::ReadWrite));
                out.push((ops[1], Mod::Read));
                out.push((ops[2], Mod::Read));
                let sd = nv_case(scale_d.as_ref(), "nvvm.wgmma_scale_out", &[("zero", 0), ("one", 1)])?;
                let c = Self::const_i32(cr, sd);
                out.push((c, Mod::Read));
                if d != WgmmaType::S32 {
                    for s in [&scale_a, &scale_b] {
                        let v = nv_case(s.as_ref(), "nvvm.wgmma_scale_in", &[("neg", -1), ("one", 1)])?;
                        let c = Self::const_i32(cr, v);
                        out.push((c, Mod::Read));
                    }
                }
                if matches!(a, WgmmaType::F16 | WgmmaType::Bf16) {
                    let la = nv_case(layout_a.as_ref(), "nvvm.mma_layout", &[("row", 0), ("col", 1)])?;
                    let lb = nv_case(layout_b.as_ref(), "nvvm.mma_layout", &[("row", 0), ("col", 1)])?;
                    let c = Self::const_i32(cr, la);
                    out.push((c, Mod::Read));
                    let c = Self::const_i32(cr, 1 - lb);
                    out.push((c, Mod::Read));
                }
                return Some((out, true));
            }
            _ => {
                out.extend(results.iter().map(|v| (*v, Mod::Write)));
                out.extend(ops.iter().map(|v| (*v, Mod::Read)));
                // Integer attributes as `i32` constants, in name order.
                let ints: Vec<i64> = cr.all_attrs(op).iter().filter_map(|a| match &a.value {
                    Some(Attribute::Int { lit, .. }) => lit.parse().ok(),
                    Some(Attribute::Bool(v)) => Some(i64::from(*v)),
                    _ => None,
                }).collect();
                for v in ints {
                    let c = Self::const_i32(cr, v);
                    out.push((c, Mod::Read));
                }
            }
        }
        Some((out, false))
    }

    /// `PtxLowering`.
    #[convert("nvvm.inline_ptx", "nvvm.mbarrier.init", "nvvm.mbarrier.arrive.expect_tx", "nvvm.mbarrier.try_wait.parity", "nvvm.barrier.arrive", "nvvm.cp.async.bulk.tensor.shared.cluster.global", "nvvm.cp.async.bulk.tensor.global.shared.cta", "nvvm.prefetch", "nvvm.wgmma.mma_async", benefit = 2)]
    fn ptx_lowering(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Ok(kind) = PtxOp::try_from(&*cr.rw.body[op].name) else { return false };
        let pred = Self::predicate(cr, op, kind);
        let intrinsic = match kind {
            PtxOp::MbarrierInit | PtxOp::MbarrierArriveExpectTx | PtxOp::TmaLoad | PtxOp::TmaStore => pred.is_none(),
            PtxOp::Prefetch => pred.is_none() || cr.rw.body[op].get("tensormap").is_none(),
            _ => false,
        };
        if intrinsic {
            return false;
        }
        let Some(ptx) = Self::ptx(cr, op, kind) else { return false };
        cr.rw.set_before(op);
        let Some((values, manual)) = Self::asm_values(cr, op, kind) else { return false };
        let mut b = Ptx::default();
        for (v, m) in values {
            if b.insert(cr, v, m).is_none() {
                return false;
            }
        }
        b.finish(cr, op, ptx, pred.is_some(), manual);
        true
    }
}
