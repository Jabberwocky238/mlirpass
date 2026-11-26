//! The x86-64 SelectionDAG selector of `O1` and up: a block's ops seen as the nodes
//! `X86ISelLowering` leaves (`icmp` + `cond_br` as `X86brcond` over `X86cmp`, `select` as
//! `X86cmov`, ...), each root matched against the generated patterns in LLVM's order (whole
//! trees: a load folded into its user, an address into the access, a constant into the
//! immediate form, a compare into the branch), and the match emitted as the pattern's result.
//! Ops no pattern takes go to the fast selector.

use alloc::vec::Vec;

use mlirformat::Error;
use mlirformat::llvm::ICmpPredicate;
use smallvec::SmallVec;

use super::encode::{Cc, Mem, X};
use super::isel::{Class, Complex, Opcode, PATTERNS, Pred, Reg, SubReg, XForm};
use super::{Lower, Pool};
use crate::targets::machine::{Base, Cap, Kid, Lowering, Match as M, Pred as Predicate, Selector, View};
use crate::targets::{DagDst, DagPattern, Mvt, Sd};
use crate::{BlockId, HoleKind, OpId, ValueId};

type Dst<'t> = DagDst<'t, Opcode, Reg, SubReg, XForm>;
pub type Match = M<Reg>;

/// The x86-64 side of the selection: the nodes `X86ISelLowering` leaves, `selectAddr`, the
/// predicates.
pub struct X86;

impl Lowering for X86 {
    type Opcode = Opcode;
    type Class = Class;
    type Reg = Reg;
    type Pred = Pred;
    type Complex = Complex;
    type SubReg = SubReg;
    type XForm = XForm;

    const FLAGS: Reg = Reg::EFLAGS;
    const COND: Sd = Sd::Timm;

    fn patterns<'t>() -> &'t [DagPattern<'t, Opcode, Class, Reg, Pred, Complex, SubReg, XForm>] {
        PATTERNS
    }

    fn is_float(c: Class) -> bool {
        c.is_float()
    }

    fn view(s: &Selector<'_, '_, X86>, k: Kid) -> Option<View> {
        let body = s.body;
        let kids = |ks: &[Kid]| ks.iter().copied().collect::<SmallVec<[Kid; 4]>>();
        let cc = |op: OpId| Predicate::of::<ICmpPredicate>(body, op).ok().map(|p| Lower::icmp_cc(p) as u8);
        match k {
            Kid::Root(op) => {
                let d = &body[op];
                match &*d.name {
                    "llvm.store" if !s.is_slot(d.operands[1]) => Some(View { op: Sd::St, vt: None, kids: kids(&[Kid::V(d.operands[0]), Kid::V(d.operands[1])]) }),
                    "llvm.cond_br" if d.operands.len() == 1 => {
                        let (c, t) = (d.operands[0], d.successors[0]);
                        match s.single_icmp(c, op) {
                            Some(i) => Some(View { op: Sd::X86brcond, vt: None, kids: kids(&[Kid::Bb(t), Kid::Cond(cc(i)?), Kid::Cmp(i)]) }),
                            None => Some(View { op: Sd::X86brcond, vt: None, kids: kids(&[Kid::Bb(t), Kid::Cond(Cc::Ne as u8), Kid::Test(c)]) }),
                        }
                    }
                    _ => None,
                }
            }
            Kid::Cmp(op) => Some(View { op: Sd::X86cmp, vt: Some(Mvt::I32), kids: kids(&[Kid::V(body[op].operands[0]), Kid::V(body[op].operands[1])]) }),
            Kid::Test(v) => Some(View { op: Sd::X86cmp, vt: Some(Mvt::I32), kids: kids(&[Kid::V(v), Kid::Const(0)]) }),
            Kid::V(v) => {
                let op = body.def_op(v)?;
                let d = &body[op];
                let a = |i: usize| Kid::V(d.operands[i]);
                let vt = Some(s.exact(v)?);
                let bin = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0), a(1)]) });
                let un = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0)]) });
                let shift = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0), Kid::Amt(d.operands[1])]) });
                match &*d.name {
                    "llvm.add" => bin(Sd::Add),
                    "llvm.sub" => bin(Sd::Sub),
                    "llvm.mul" => bin(Sd::Mul),
                    "llvm.and" => bin(Sd::And),
                    "llvm.or" => bin(Sd::Or),
                    "llvm.xor" => bin(Sd::Xor),
                    "llvm.shl" => shift(Sd::Shl),
                    "llvm.lshr" => shift(Sd::Srl),
                    "llvm.ashr" => shift(Sd::Sra),
                    "llvm.load" if !s.is_slot(d.operands[0]) => un(Sd::Ld),
                    "llvm.icmp" => Some(View { op: Sd::X86setcc, vt: Some(Mvt::I8), kids: kids(&[Kid::Cond(cc(op)?), Kid::Cmp(op)]) }),
                    "llvm.select" => {
                        let c = d.operands[0];
                        let (t, f) = (a(1), a(2));
                        match s.single_icmp(c, op) {
                            Some(i) => Some(View { op: Sd::X86cmov, vt, kids: kids(&[f, t, Kid::Cond(cc(i)?), Kid::Cmp(i)]) }),
                            None => Some(View { op: Sd::X86cmov, vt, kids: kids(&[f, t, Kid::Cond(Cc::Ne as u8), Kid::Test(c)]) }),
                        }
                    }
                    "llvm.zext" => s.exact(d.operands[0]).and_then(|_| un(Sd::Zext)),
                    "llvm.sext" => s.exact(d.operands[0]).and_then(|_| un(Sd::Sext)),
                    "llvm.trunc" => s.exact(d.operands[0]).and_then(|_| un(Sd::Trunc)),
                    "llvm.fadd" => bin(Sd::Fadd),
                    "llvm.fsub" => bin(Sd::Fsub),
                    "llvm.fmul" => bin(Sd::Fmul),
                    "llvm.fdiv" => bin(Sd::Fdiv),
                    "llvm.intr.sqrt" => un(Sd::Fsqrt),
                    "llvm.sitofp" => s.exact(d.operands[0]).and_then(|_| un(Sd::SintToFp)),
                    "llvm.fptosi" => un(Sd::FpToSint),
                    "llvm.fpext" => un(Sd::Fpextend),
                    "llvm.fptrunc" => un(Sd::Fpround),
                    "llvm.bitcast" => un(Sd::Bitconvert),
                    "llvm.mlir.constant" => Some(View { op: if vt.is_some_and(Mvt::is_float) { Sd::Fpimm } else { Sd::Imm }, vt, kids: SmallVec::new() }),
                    _ => None,
                }
            }
            Kid::Amt(v) => s.constant(v).map(|_| View { op: Sd::Imm, vt: Some(Mvt::I8), kids: SmallVec::new() }),
            Kid::Cond(_) => Some(View { op: Sd::Timm, vt: Some(Mvt::I8), kids: SmallVec::new() }),
            Kid::Bb(_) => Some(View { op: Sd::Bb, vt: None, kids: SmallVec::new() }),
            Kid::Const(_) => None,
        }
    }

    /// `ImmLeaf` predicates.
    fn imm(p: Pred, c: i64) -> bool {
        match p {
            Pred::I64immSExt32 | Pred::I64relocImmSExt32 => i32::try_from(c).is_ok(),
            Pred::I64immZExt32 => u32::try_from(c).is_ok(),
            Pred::Immff00Ffff => (0xff00..=0xffff).contains(&c),
            Pred::ImmSu | Pred::I64immSExt32Su | Pred::I64relocImmSExt32Su | Pred::RelocImm8Su | Pred::RelocImm16Su | Pred::RelocImm32Su => true,
            _ => false,
        }
    }

    fn node(p: Pred, s: &Selector<'_, '_, X86>, def: Option<OpId>, root: OpId) -> bool {
        match p {
            // Loads are plain and unindexed; stores neither truncate nor skip the cache.
            Pred::Unindexedload | Pred::Load | Pred::Loadi8 | Pred::Loadi16 | Pred::Loadi32 | Pred::Unindexedstore | Pred::Store => true,
            Pred::Extload | Pred::Extloadi1 | Pred::Extloadi8 | Pred::Extloadi16 | Pred::Extloadi64i32 => false,
            Pred::Sextload | Pred::Sextloadi8 | Pred::Sextloadi16 | Pred::Sextloadi32 => false,
            Pred::Zextload | Pred::Zextloadi1 | Pred::Zextloadi8 | Pred::Zextloadi16 | Pred::Zextloadi32 => false,
            Pred::Nontemporalstore => false,
            // Every integer is kept zero-extended in its register.
            Pred::Def32 => true,
            Pred::AndSu | Pred::SrlSu | Pred::TruncSu => s.single_use(def, root),
            Pred::ShiftMask16 | Pred::ShiftMask32 | Pred::ShiftMask64 => false,
            p => def.and_then(|d| s.constant(s.body[d].results[0])).is_some_and(|c| Self::imm(p, c)),
        }
    }

    /// `selectAddr` / `selectLEAAddr` (an address worth an `lea`: more than a base) /
    /// `selectRelocImm` (a constant).
    fn complex(s: &Selector<'_, '_, X86>, pat: Complex, names: &[u8], k: Kid, root: OpId, m: &mut Match) -> bool {
        let (Kid::V(p), [name]) = (k, names) else { return false };
        match pat {
            Complex::Addr | Complex::Lea64addr => {
                let a = s.address(p, root, m);
                if matches!(pat, Complex::Lea64addr) && a.index.is_none() && a.disp == 0 {
                    return false;
                }
                m.set(*name, Cap::Addr(a));
                true
            }
            Complex::Lea64Iaddr => false,
            Complex::RelocImm => match s.constant(p) {
                Some(c) => {
                    m.set(*name, Cap::Imm(c));
                    true
                }
                None => false,
            },
        }
    }
}

/// An operand a result node gives.
#[derive(Clone, Copy, Debug)]
enum Out {
    R(Reg),
    I(i64),
    M(Mem, Option<ValueId>),
    C(Cc),
    B(BlockId),
    None,
}

impl Lower<'_, '_> {
    /// Emits the match of `root`.
    pub fn emit_match(&mut self, root: OpId, m: &Match) -> Result<(), Error> {
        // The result computed where it lives: no operand of this op is there (it is live here).
        let into = match self.body[root].results.first().map(|&r| self.slot(r)) {
            Some(Ok(super::Loc::Gpr(u) | super::Loc::Xmm(u))) => Some(u),
            _ => None,
        };
        let out = self.emit_pattern(m, into)?;
        let body = self.body;
        if body[root].results.len() == 1 {
            let r = body[root].results[0];
            match out {
                Out::R(reg) => self.write(r, reg)?,
                o => return Err(Error(alloc::format!("{}: a result {o:?}", body[root].name))),
            }
        }
        if body[root].name == "llvm.cond_br" {
            let f = body[root].successors[1];
            self.jump_to(f);
        }
        Ok(())
    }

    /// The flags a match reads first, then its result.
    fn emit_pattern(&mut self, m: &Match, into: Option<Reg>) -> Result<Out, Error> {
        let mut temps: Vec<Reg> = [Reg::RAX, Reg::RDX, Reg::RSI, Reg::RDI, Reg::R8, Reg::R9, Reg::RCX].into_iter().filter(|t| !m.phys.iter().any(|(r, _)| r.unit() == *t)).collect();
        let mut ftemps: Vec<Reg> = Pool::FTEMPS.to_vec();
        if let Some(f) = &m.flags {
            self.emit_pattern(f, None)?;
        }
        for &(r, v) in &m.phys {
            self.read_into(v, r.unit())?;
        }
        self.emit_dst(&PATTERNS[m.pat].dst, m, &mut temps, &mut ftemps, into)
    }

    fn take(temps: &mut Vec<Reg>) -> Result<Reg, Error> {
        if temps.is_empty() {
            return Err(Error("out of temporaries".into()));
        }
        Ok(temps.remove(0))
    }

    fn reg_of(&mut self, v: ValueId, class: Class, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>) -> Result<Reg, Error> {
        let t = if class.is_float() { Self::take(ftemps)? } else { Self::take(temps)? };
        self.read(v, t, class)
    }

    fn dst_operand(&mut self, d: &Dst<'_>, m: &Match, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>, class: Option<Class>) -> Result<Out, Error> {
        Ok(match *d {
            DagDst::Ref(i) => match m.caps.get(usize::from(i)).copied().unwrap_or(Cap::None) {
                Cap::Val(v) => match class {
                    Some(c) => Out::R(self.reg_of(v, c, temps, ftemps)?),
                    None => Out::R(self.reg_of(v, Class::GR64, temps, ftemps)?),
                },
                Cap::Imm(c) => Out::I(c),
                Cap::Cond(c) => Out::C(Cc::from(c)),
                Cap::Bb(b) => Out::B(b),
                Cap::Addr(a) => {
                    let (base, slot) = match a.base {
                        Base::Slot(p) => (Pool::FRAME, Some(p)),
                        Base::Val(p) => (self.reg_of(p, Class::GR64, temps, ftemps)?, None),
                    };
                    let index = match a.index {
                        Some((i, s)) => Some((self.reg_of(i, Class::GR64, temps, ftemps)?, s)),
                        None => None,
                    };
                    let mem = Mem { base, index, disp: a.disp, wide: slot.is_some() };
                    Out::M(mem, slot)
                }
                Cap::None | Cap::Shifted(..) => return Err(Error("a result refers to an operand not matched".into())),
            },
            DagDst::Int(n) => Out::I(n),
            DagDst::Phys(r) => Out::R(r),
            DagDst::XForm(x, inner) => match (x, self.dst_operand(inner, m, temps, ftemps, None)?) {
                (XForm::GetLo32XForm, Out::I(c)) => Out::I(i64::from(c as u32)),
                (XForm::InvCondXFORM, Out::C(c)) => Out::C(c.invert()),
                (x, o) => return Err(Error(alloc::format!("{x:?} of {o:?}"))),
            },
            DagDst::Extract(inner, _) | DagDst::SubregToReg(inner, _) | DagDst::Copy(inner) => self.dst_operand(inner, m, temps, ftemps, class)?,
            DagDst::Insert(base, inner, _) => match base {
                DagDst::ImplicitDef(_) => self.dst_operand(inner, m, temps, ftemps, class)?,
                _ => return Err(Error("INSERT_SUBREG into a value".into())),
            },
            DagDst::ImplicitDef(_) => Out::R(Self::take(temps)?),
            DagDst::Inst { .. } => self.emit_dst(d, m, temps, ftemps, None)?,
        })
    }

    fn emit_dst(&mut self, d: &Dst<'_>, m: &Match, temps: &mut Vec<Reg>, ftemps: &mut Vec<Reg>, into: Option<Reg>) -> Result<Out, Error> {
        let DagDst::Inst { op, kids, .. } = *d else { return self.dst_operand(d, m, temps, ftemps, None) };
        // `X86InstrInfo::expandPostRAPseudo`: `MOV32r0` is `xor r, r`.
        if op == Opcode::MOV32r0 {
            let r = Class::GR32.of(match into {
                Some(u) if !u.is_xmm() => u,
                _ => Self::take(temps)?,
            });
            self.inst(Opcode::XOR32rr, &[X::R(r), X::R(r), X::R(r)]);
            return Ok(Out::R(r));
        }
        // The assembler's relaxation: a jump to a block may be far.
        let op = match op {
            Opcode::JCC_1 => Opcode::JCC_4,
            o => o,
        };
        let desc = op.desc();
        let outs = usize::from(desc.outs);
        if desc.operands.len() != outs + kids.len() {
            return Err(Error(alloc::format!("{}: {} operands for {}", op.name(), kids.len(), desc.operands.len() - outs)));
        }
        let tied = desc.tied.contains(&(1, 0));
        let mut ops: Vec<X> = Vec::new();
        let mut dst = None;
        let mut fixup = None;
        let mut hole = None;
        if outs == 1 {
            let c = desc.operands[0].class.ok_or_else(|| Error(alloc::format!("{}: a result without a class", op.name())))?;
            let unit = match into {
                Some(u) if u.is_xmm() == c.is_float() => u,
                _ if c.is_float() => Self::take(ftemps)?,
                _ => Self::take(temps)?,
            };
            dst = Some(c.of(unit));
            ops.push(X::R(c.of(unit)));
        }
        for (n, k) in kids.iter().enumerate() {
            let o = desc.operands[outs + n];
            let out = self.dst_operand(k, m, temps, ftemps, o.class)?;
            let x = match out {
                Out::R(r) => {
                    let r = o.class.map_or(r, |c| c.of(r));
                    if tied && outs + n == 1 {
                        let d = dst.expect("a tied result");
                        self.copy(d, r);
                        X::R(d)
                    } else {
                        X::R(r)
                    }
                }
                Out::I(i) => X::I(i),
                Out::M(mem, slot) => {
                    hole = slot;
                    X::M(mem)
                }
                Out::C(c) => X::C(c),
                Out::B(b) => {
                    fixup = Some(b);
                    X::Rel
                }
                Out::None => return Err(Error(alloc::format!("{}: an empty operand", op.name()))),
            };
            ops.push(x);
        }
        let placed = self.inst(op, &ops);
        if let (Some(b), Some(at)) = (fixup, placed.imm) {
            self.fixups.push((at, b));
        }
        if let (Some(p), Some(at)) = (hole, placed.disp) {
            let name = self.frame_slot(p).unwrap_or_default();
            self.hole(at, HoleKind::Disp32, name);
        }
        Ok(match dst {
            Some(r) => Out::R(r),
            None => desc.defs.iter().copied().find(|r| *r != Reg::EFLAGS).map_or(Out::None, Out::R),
        })
    }
}

impl From<u8> for Cc {
    fn from(c: u8) -> Cc {
        const ALL: [Cc; 16] = [Cc::O, Cc::No, Cc::B, Cc::Ae, Cc::E, Cc::Ne, Cc::Be, Cc::A, Cc::S, Cc::Ns, Cc::P, Cc::Np, Cc::L, Cc::Ge, Cc::Le, Cc::G];
        ALL[usize::from(c & 15)]
    }
}

impl Cc {
    /// `X86::GetOppositeBranchCondition`.
    pub const fn invert(self) -> Cc {
        match self {
            Cc::O => Cc::No,
            Cc::No => Cc::O,
            Cc::B => Cc::Ae,
            Cc::Ae => Cc::B,
            Cc::E => Cc::Ne,
            Cc::Ne => Cc::E,
            Cc::Be => Cc::A,
            Cc::A => Cc::Be,
            Cc::S => Cc::Ns,
            Cc::Ns => Cc::S,
            Cc::P => Cc::Np,
            Cc::Np => Cc::P,
            Cc::L => Cc::Ge,
            Cc::Ge => Cc::L,
            Cc::Le => Cc::G,
            Cc::G => Cc::Le,
        }
    }
}
