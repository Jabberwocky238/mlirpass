//! The AArch64 SelectionDAG selector of `O1` and up: a block's ops seen as the nodes
//! `AArch64ISelLowering` leaves (`icmp` as `AArch64sub_flag` read by `AArch64csel` /
//! `AArch64brcond`), the complex patterns of `AArch64ISelDAGToDAG` (addressing modes, shifted
//! registers, add/sub immediates), the predicates and operand transforms of the patterns.

use alloc::vec::Vec;

use mlirformat::Error;
use mlirformat::llvm::ICmpPredicate;
use smallvec::SmallVec;

use super::encode::A;
use super::isel::{Class, Complex, Opcode, PATTERNS, Pred, Reg, SubReg, XForm};
use super::{Lower, Pool};
use crate::targets::machine::{Cap, Kid, Lowering, Match as M, Pred as Predicate, Selector, View};
use crate::targets::{DagDst, DagPattern, Mvt, Sd};
use crate::{BlockId, OpId, ValueId};

type Dst<'t> = DagDst<'t, Opcode, Reg, SubReg, XForm>;
pub type Match = M<Reg>;

/// The AArch64 side of the selection.
pub struct AArch64;

/// The largest unsigned 12-bit immediate (`add`, scaled loads), and its shifted form's shift.
const IMM12: i64 = 1 << 12;
const IMM12_SHIFT: u32 = 12;
/// `AArch64_AM::ShiftExtendType`s of a shifted register, and where the type sits in the operand.
const LSL: i64 = 0;
const LSR: i64 = 1;
const ASR: i64 = 2;
const SHIFT_TYPE_AT: u32 = 6;

impl Lowering for AArch64 {
    type Opcode = Opcode;
    type Class = Class;
    type Reg = Reg;
    type Pred = Pred;
    type Complex = Complex;
    type SubReg = SubReg;
    type XForm = XForm;

    const FLAGS: Reg = Reg::NZCV;
    const COND: Sd = Sd::Imm;

    fn patterns<'t>() -> &'t [DagPattern<'t, Opcode, Class, Reg, Pred, Complex, SubReg, XForm>] {
        PATTERNS
    }

    fn is_float(c: Class) -> bool {
        c.is_float()
    }

    fn view(s: &Selector<'_, '_, AArch64>, k: Kid) -> Option<View> {
        let body = s.body;
        let kids = |ks: &[Kid]| ks.iter().copied().collect::<SmallVec<[Kid; 4]>>();
        let cc = |op: OpId| Predicate::of::<ICmpPredicate>(body, op).ok().map(Lower::icmp_cond);
        // A compare's type: the operands', at least 32 bits (an `i8` compares as `i32`).
        let cmp_vt = |v: ValueId| s.exact(v).filter(|t| matches!(t, Mvt::I32 | Mvt::I64));
        match k {
            Kid::Root(op) => {
                let d = &body[op];
                match &*d.name {
                    "llvm.store" if !s.is_slot(d.operands[1]) => Some(View { op: Sd::St, vt: None, kids: kids(&[Kid::V(d.operands[0]), Kid::V(d.operands[1])]) }),
                    "llvm.cond_br" if d.operands.len() == 1 => {
                        let (c, t) = (d.operands[0], d.successors[0]);
                        let i = s.single_icmp(c, op)?;
                        cmp_vt(body[i].operands[0])?;
                        Some(View { op: Sd::AArch64brcond, vt: None, kids: kids(&[Kid::Bb(t), Kid::Cond(cc(i)? as u8), Kid::Cmp(i)]) })
                    }
                    _ => None,
                }
            }
            Kid::Cmp(op) => {
                let (a, b) = (body[op].operands[0], body[op].operands[1]);
                Some(View { op: Sd::AArch64subFlag, vt: Some(cmp_vt(a)?), kids: kids(&[Kid::V(a), Kid::V(b)]) })
            }
            Kid::Test(v) => Some(View { op: Sd::AArch64subFlag, vt: Some(cmp_vt(v)?), kids: kids(&[Kid::V(v), Kid::Const(0)]) }),
            Kid::V(v) => {
                let op = body.def_op(v)?;
                let d = &body[op];
                let a = |i: usize| Kid::V(d.operands[i]);
                let vt = Some(s.exact(v)?);
                let bin = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0), a(1)]) });
                let un = |sd: Sd| Some(View { op: sd, vt, kids: kids(&[a(0)]) });
                let wide = vt.is_some_and(|t| matches!(t, Mvt::I32 | Mvt::I64 | Mvt::F32 | Mvt::F64));
                match &*d.name {
                    // Narrower integers are the 32-bit ones they are promoted to: not these nodes.
                    _ if !wide && d.name != "llvm.load" && d.name != "llvm.trunc" => None,
                    "llvm.add" => bin(Sd::Add),
                    "llvm.sub" => bin(Sd::Sub),
                    "llvm.mul" => bin(Sd::Mul),
                    "llvm.and" => bin(Sd::And),
                    "llvm.or" => bin(Sd::Or),
                    "llvm.xor" => bin(Sd::Xor),
                    "llvm.shl" => bin(Sd::Shl),
                    "llvm.lshr" => bin(Sd::Srl),
                    "llvm.ashr" => bin(Sd::Sra),
                    "llvm.load" if !s.is_slot(d.operands[0]) && wide => un(Sd::Ld),
                    "llvm.icmp" => {
                        cmp_vt(d.operands[0])?;
                        let c = cc(op)?.invert();
                        Some(View { op: Sd::AArch64csel, vt: Some(Mvt::I32), kids: kids(&[Kid::Const(0), Kid::Const(1), Kid::Cond(c as u8), Kid::Cmp(op)]) })
                    }
                    "llvm.select" => {
                        let i = s.single_icmp(d.operands[0], op)?;
                        cmp_vt(body[i].operands[0])?;
                        Some(View { op: Sd::AArch64csel, vt, kids: kids(&[a(1), a(2), Kid::Cond(cc(i)? as u8), Kid::Cmp(i)]) })
                    }
                    "llvm.zext" => s.exact(d.operands[0]).filter(|t| matches!(t, Mvt::I32)).and_then(|_| un(Sd::Zext)),
                    "llvm.sext" => s.exact(d.operands[0]).filter(|t| matches!(t, Mvt::I32)).and_then(|_| un(Sd::Sext)),
                    "llvm.trunc" => (vt == Some(Mvt::I32) && s.exact(d.operands[0]) == Some(Mvt::I64)).then(|| un(Sd::Trunc)).flatten(),
                    "llvm.fadd" => bin(Sd::Fadd),
                    "llvm.fsub" => bin(Sd::Fsub),
                    "llvm.fmul" => bin(Sd::Fmul),
                    "llvm.fdiv" => bin(Sd::Fdiv),
                    "llvm.intr.sqrt" => un(Sd::Fsqrt),
                    "llvm.sitofp" => s.exact(d.operands[0]).filter(|t| matches!(t, Mvt::I32 | Mvt::I64)).and_then(|_| un(Sd::SintToFp)),
                    "llvm.uitofp" => s.exact(d.operands[0]).filter(|t| matches!(t, Mvt::I32 | Mvt::I64)).and_then(|_| un(Sd::UintToFp)),
                    "llvm.fptosi" => un(Sd::FpToSint),
                    "llvm.fptoui" => un(Sd::FpToUint),
                    "llvm.fpext" => un(Sd::Fpextend),
                    "llvm.fptrunc" => un(Sd::Fpround),
                    "llvm.bitcast" => un(Sd::Bitconvert),
                    "llvm.mlir.constant" => Some(View { op: if vt.is_some_and(Mvt::is_float) { Sd::Fpimm } else { Sd::Imm }, vt, kids: SmallVec::new() }),
                    _ => None,
                }
            }
            Kid::Amt(_) | Kid::Const(_) => None,
            Kid::Cond(_) => Some(View { op: Sd::Imm, vt: Some(Mvt::I32), kids: SmallVec::new() }),
            Kid::Bb(_) => Some(View { op: Sd::Bb, vt: None, kids: SmallVec::new() }),
        }
    }

    fn imm(p: Pred, c: i64) -> bool {
        match p {
            Pred::Imm031 => (0..32).contains(&c),
            Pred::Imm063 => (0..64).contains(&c),
            Pred::LogicalImm32 => Logical::encode(c.cast_unsigned() & u64::from(u32::MAX), 32).is_some(),
            Pred::LogicalImm64 => Logical::encode(c.cast_unsigned(), 64).is_some(),
            Pred::Fpimm32 => FpImm::f32(c.cast_unsigned()).is_some(),
            Pred::Fpimm64 => FpImm::f64(c.cast_unsigned()).is_some(),
            _ => false,
        }
    }

    fn node(p: Pred, s: &Selector<'_, '_, AArch64>, def: Option<OpId>, _root: OpId) -> bool {
        match p {
            // Loads are plain and unindexed; stores do not truncate.
            Pred::Unindexedload | Pred::Load | Pred::Unindexedstore | Pred::Store => true,
            Pred::Extload | Pred::Extloadi1 | Pred::Extloadi8 | Pred::Extloadi16 | Pred::Extloadi32 => false,
            Pred::Sextload | Pred::Sextloadi8 | Pred::Sextloadi16 | Pred::Sextloadi32 => false,
            Pred::Zextload | Pred::Zextloadi1 | Pred::Zextloadi8 | Pred::Zextloadi16 | Pred::Zextloadi32 => false,
            Pred::Truncstore | Pred::Truncstorei8 | Pred::Truncstorei16 | Pred::Truncstorei32 => false,
            Pred::OrDisjoint | Pred::Smullwithsignbits | Pred::Top32Zero | Pred::Topbitsallzero32 | Pred::Topbitsallzero64 | Pred::TruncIsWorthFoldingALU => false,
            Pred::CopyFromSP | Pred::Simdimmtype10 | Pred::Anonymous14228 | Pred::Fpimm32SIMDModImmType4 => false,
            Pred::Fpimm32XForm | Pred::Fpimm64XForm | Pred::Fpimm32SIMDModImmType4XForm | Pred::LogicalImm32XFORM | Pred::LogicalImm64XFORM => false,
            p => def.and_then(|d| s.constant(s.body[d].results[0])).is_some_and(|c| Self::imm(p, c)),
        }
    }

    fn complex(s: &Selector<'_, '_, AArch64>, pat: Complex, names: &[u8], k: Kid, root: OpId, m: &mut Match) -> bool {
        let v = match k {
            Kid::V(v) => v,
            Kid::Const(0) if matches!(pat, Complex::AddsubShiftedImm32 | Complex::AddsubShiftedImm64) => {
                m.set(names[0], Cap::Imm(0));
                return true;
            }
            _ => return false,
        };
        match pat {
            Complex::AmIndexed8 | Complex::AmIndexed16 | Complex::AmIndexed32 | Complex::AmIndexed64 => {
                let size: i32 = match pat {
                    Complex::AmIndexed8 => 1,
                    Complex::AmIndexed16 => 2,
                    Complex::AmIndexed32 => 4,
                    _ => 8,
                };
                let a = s.address(v, root, m);
                let ok = a.index.is_none() && a.disp % size == 0 && (0..IMM12).contains(&i64::from(a.disp / size));
                let (base, off) = match (a.base, ok) {
                    (crate::targets::machine::Base::Val(b), true) => (b, a.disp / size),
                    _ => {
                        let g = s.body.def_op(v);
                        m.folded.retain(|&f| Some(f) != g);
                        (v, 0)
                    }
                };
                m.set(names[0], Cap::Val(base));
                m.set(names[1], Cap::Imm(off.into()));
                true
            }
            Complex::RoXindexed8 | Complex::RoXindexed16 | Complex::RoXindexed32 | Complex::RoXindexed64 => {
                let size: u8 = match pat {
                    Complex::RoXindexed8 => 1,
                    Complex::RoXindexed16 => 2,
                    Complex::RoXindexed32 => 4,
                    _ => 8,
                };
                let a = s.address(v, root, m);
                match (a.base, a.index, a.disp) {
                    (crate::targets::machine::Base::Val(b), Some((i, scale)), 0) if scale == size || scale == 1 => {
                        m.set(names[0], Cap::Val(b));
                        m.set(names[1], Cap::Val(i));
                        // `ro_Xextend`: {sign, shift}; an X index is `lsl`, shifted by the size.
                        m.set(names[2], Cap::Imm(i64::from(scale == size && size > 1)));
                        true
                    }
                    _ => false,
                }
            }
            Complex::AddsubShiftedImm32 | Complex::AddsubShiftedImm64 | Complex::NegAddsubShiftedImm32 | Complex::NegAddsubShiftedImm64 => {
                let Some(mut c) = s.constant(v) else { return false };
                if matches!(pat, Complex::NegAddsubShiftedImm32 | Complex::NegAddsubShiftedImm64) {
                    c = c.wrapping_neg();
                    if c == 0 {
                        return false;
                    }
                }
                let enc = if (0..IMM12).contains(&c) {
                    c
                } else if c & (IMM12 - 1) == 0 && (0..IMM12).contains(&(c >> IMM12_SHIFT)) {
                    (c >> IMM12_SHIFT) | IMM12
                } else {
                    return false;
                };
                m.set(names[0], Cap::Imm(enc));
                true
            }
            Complex::ArithShiftedReg32 | Complex::ArithShiftedReg64 | Complex::LogicalShiftedReg32 | Complex::LogicalShiftedReg64 => {
                let Some(d) = s.body.def_op(v) else { return false };
                let ty = match &*s.body[d].name {
                    "llvm.shl" => LSL,
                    "llvm.lshr" => LSR,
                    "llvm.ashr" => ASR,
                    _ => return false,
                };
                let bits = s.exact(v).map_or(0, |t| i64::from(t.bits()));
                let (x, amt) = (s.body[d].operands[0], s.body[d].operands[1]);
                match s.constant(amt) {
                    Some(c) if (0..bits).contains(&c) && s.foldable(d, root) => {
                        m.folded.push(d);
                        m.set(names[0], Cap::Shifted(x, ty << SHIFT_TYPE_AT | c));
                        true
                    }
                    _ => false,
                }
            }
            _ => false,
        }
    }
}

/// `AArch64_AM::processLogicalImmediate`: the `N:immr:imms` of a bitmask immediate.
pub struct Logical;

impl Logical {
    fn shifted_mask(v: u64) -> bool {
        let x = (v.wrapping_sub(1)) | v;
        v != 0 && x != 0 && (x.wrapping_add(1) & x) == 0
    }

    pub fn encode(imm: u64, reg: u32) -> Option<u64> {
        let all = if reg == 64 { u64::MAX } else { (1u64 << reg) - 1 };
        if imm == 0 || imm == u64::MAX || (reg != 64 && (imm >> reg != 0 || imm == all)) {
            return None;
        }
        let mut size = reg;
        loop {
            size /= 2;
            let mask = (1u64 << size) - 1;
            if (imm & mask) != ((imm >> size) & mask) {
                size *= 2;
                break;
            }
            if size <= 2 {
                break;
            }
        }
        let mask = u64::MAX >> (64 - size);
        let mut imm = imm & mask;
        let (i, cto);
        if Self::shifted_mask(imm) {
            i = imm.trailing_zeros();
            cto = (imm >> i).trailing_ones();
        } else {
            imm |= !mask;
            if !Self::shifted_mask(!imm) {
                return None;
            }
            let clo = imm.leading_ones();
            i = 64 - clo;
            cto = clo + imm.trailing_ones() - (64 - size);
        }
        let immr = u64::from((size - i) & (size - 1));
        let mut nimms = !(u64::from(size) - 1) << 1;
        nimms |= u64::from(cto - 1);
        let n = ((nimms >> 6) & 1) ^ 1;
        Some(n << 12 | immr << 6 | (nimms & 0x3f))
    }
}

/// `AArch64_AM::getFP32Imm` / `getFP64Imm`: the 8-bit form of an `fmov` immediate.
pub struct FpImm;

impl FpImm {
    /// Exponents the 3-bit field holds: `-3..=4`.
    const EXP: core::ops::RangeInclusive<i64> = -3..=4;

    fn pack(sign: u64, exp: i64, mantissa: u64) -> Option<i64> {
        if !Self::EXP.contains(&exp) {
            return None;
        }
        let e = ((exp + 3) & 7) ^ 4;
        Some((sign << 7) as i64 | e << 4 | mantissa as i64)
    }

    pub fn f32(bits: u64) -> Option<i64> {
        let sign = (bits >> 31) & 1;
        let exp = ((bits >> 23) & 0xff) as i64 - 127;
        let mantissa = bits & 0x7f_ffff;
        if mantissa & 0x7_ffff != 0 {
            return None;
        }
        Self::pack(sign, exp, mantissa >> 19)
    }

    pub fn f64(bits: u64) -> Option<i64> {
        let sign = (bits >> 63) & 1;
        let exp = ((bits >> 52) & 0x7ff) as i64 - 1023;
        let mantissa = bits & 0xf_ffff_ffff_ffff;
        if mantissa & 0xffff_ffff_ffff != 0 {
            return None;
        }
        Self::pack(sign, exp, mantissa >> 48)
    }
}

/// An operand a result node gives.
#[derive(Clone, Copy, Debug)]
enum Out {
    R(Reg),
    I(i64),
    /// A register and its shift (`arith_shifted_reg`: two machine operands).
    Rs(Reg, i64),
    B(BlockId),
    None,
}

impl Lower<'_, '_> {
    pub fn emit_match(&mut self, root: OpId, m: &Match) -> Result<(), Error> {
        let into = match self.body[root].results.first().map(|&r| self.slot(r)) {
            Some(Ok(super::Loc::Gpr(u) | super::Loc::Fpr(u))) => Some(u),
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

    fn emit_pattern(&mut self, m: &Match, into: Option<Reg>) -> Result<Out, Error> {
        let mut temps: Vec<Reg> = [Reg::X16, Reg::X17, Reg::X15, Reg::X7, Reg::X6, Reg::X5, Reg::X4].to_vec();
        let mut ftemps: Vec<Reg> = Pool::FTEMPS.to_vec();
        if let Some(f) = &m.flags {
            self.emit_pattern(f, None)?;
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
                Cap::Val(v) => Out::R(self.reg_of(v, class.unwrap_or(Class::GPR64), temps, ftemps)?),
                Cap::Shifted(v, sh) => Out::Rs(self.reg_of(v, class.unwrap_or(Class::GPR64), temps, ftemps)?, sh),
                Cap::Imm(c) => Out::I(c),
                Cap::Cond(c) => Out::I(i64::from(c)),
                Cap::Bb(b) => Out::B(b),
                c => return Err(Error(alloc::format!("a result operand {c:?}"))),
            },
            DagDst::Int(n) => Out::I(n),
            DagDst::Phys(r) => Out::R(r),
            DagDst::XForm(x, inner) => match (x, self.dst_operand(inner, m, temps, ftemps, None)?) {
                (XForm::I32shiftA, Out::I(c)) => Out::I((32 - c) & 31),
                (XForm::I32shiftB, Out::I(c)) => Out::I(31 - c),
                (XForm::I64shiftA, Out::I(c)) => Out::I((64 - c) & 63),
                (XForm::I64shiftB, Out::I(c)) => Out::I(63 - c),
                (XForm::I64shiftSextI32, Out::I(c)) => Out::I((63 - c).min(31)),
                (XForm::LogicalImm32XFORM, Out::I(c)) => Out::I(Logical::encode(c.cast_unsigned() & u64::from(u32::MAX), 32).map_or(0, u64::cast_signed)),
                (XForm::LogicalImm64XFORM, Out::I(c)) => Out::I(Logical::encode(c.cast_unsigned(), 64).map_or(0, u64::cast_signed)),
                (XForm::Fpimm32XForm, Out::I(c)) => Out::I(FpImm::f32(c.cast_unsigned()).unwrap_or(0)),
                (XForm::Fpimm64XForm, Out::I(c)) => Out::I(FpImm::f64(c.cast_unsigned()).unwrap_or(0)),
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
        // `AArch64ExpandPseudo`: `ADDXrr` is `ADDXrs` with no shift.
        let (op, extra) = match super::isel::EXPAND.iter().find(|(p, _)| *p == op) {
            Some(&(_, real)) => (real, true),
            None => (op, false),
        };
        let desc = op.desc();
        let outs = usize::from(desc.outs);
        let mut ops: Vec<A> = Vec::new();
        let mut dst = None;
        let mut fixup = None;
        if outs == 1 {
            let c = desc.operands[0].class.ok_or_else(|| Error(alloc::format!("{}: a result without a class", op.name())))?;
            let unit = match into {
                Some(u) if u.is_fpr() == c.is_float() => u,
                _ if c.is_float() => Self::take(ftemps)?,
                _ => Self::take(temps)?,
            };
            dst = Some(c.of(unit));
            ops.push(A::R(c.of(unit)));
        }
        for k in kids {
            let o = desc.operands.get(ops.len()).copied();
            let out = self.dst_operand(k, m, temps, ftemps, o.and_then(|o| o.class))?;
            match out {
                Out::R(r) => ops.push(A::R(o.and_then(|o| o.class).map_or(r, |c| c.of(r)))),
                Out::Rs(r, sh) => {
                    ops.push(A::R(o.and_then(|o| o.class).map_or(r, |c| c.of(r))));
                    ops.push(A::I(sh));
                }
                Out::I(i) => ops.push(A::I(i)),
                Out::B(b) => {
                    fixup = Some(b);
                    ops.push(A::Rel);
                }
                Out::None => return Err(Error(alloc::format!("{}: an empty operand", op.name()))),
            }
        }
        if extra {
            ops.push(A::I(0));
        }
        if ops.len() != desc.operands.len() {
            return Err(Error(alloc::format!("{}: {} operands for {}", op.name(), ops.len(), desc.operands.len())));
        }
        let placed = self.inst(op, &ops);
        if let Some(b) = fixup {
            self.fixups.push((placed, b));
        }
        Ok(match dst {
            Some(r) => Out::R(r),
            None => Out::None,
        })
    }
}
