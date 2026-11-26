//! What the CPU targets share: the tables `scripts/isel.py` generates from LLVM's fast instruction
//! selectors (`Fast`, the `Isd` nodes, instruction operands), the llvm dialect ops each node is,
//! and the stencil conventions and liveness both backends use.

#[path = "isd.gen.rs"]
mod isd;
mod dag;
mod select;
mod template;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Error, FloatKind, Type};

use crate::{Body, OpId};

pub use isd::*;
pub use dag::*;
pub use select::*;
pub use template::*;

/// LLVM's simple value types, the scalar ones.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Mvt {
    I1,
    I8,
    I16,
    I32,
    I64,
    F32,
    F64,
}

impl Mvt {
    pub const fn bits(self) -> u32 {
        match self {
            Mvt::I1 => 1,
            Mvt::I8 => 8,
            Mvt::I16 => 16,
            Mvt::I32 | Mvt::F32 => 32,
            Mvt::I64 | Mvt::F64 => 64,
        }
    }

    pub const fn is_float(self) -> bool {
        matches!(self, Mvt::F32 | Mvt::F64)
    }

    /// The type an integer of this width is selected as: `i1` as `i8`, as LLVM promotes it.
    pub const fn legal(self) -> Mvt {
        match self {
            Mvt::I1 => Mvt::I8,
            t => t,
        }
    }

    /// The narrowest integer type holding `bits`.
    pub fn int(bits: u32) -> Result<Mvt, Error> {
        Ok(match bits {
            1 => Mvt::I1,
            2..=8 => Mvt::I8,
            9..=16 => Mvt::I16,
            17..=32 => Mvt::I32,
            33..=64 => Mvt::I64,
            _ => return Err(Error(alloc::format!("i{bits} is wider than a register"))),
        })
    }
}

impl TryFrom<&Type<'_>> for Mvt {
    type Error = Error;

    fn try_from(t: &Type<'_>) -> Result<Mvt, Error> {
        match t {
            Type::Integer { width, .. } => Mvt::int(*width),
            Type::Index => Ok(Mvt::I64),
            Type::Float(FloatKind::F32) => Ok(Mvt::F32),
            Type::Float(FloatKind::F64) => Ok(Mvt::F64),
            t if matches!(LlvmType::try_from(t), Ok(LlvmType::Ptr(_))) => Ok(Mvt::I64),
            t => Err(Error(alloc::format!("values of type {t} are not supported"))),
        }
    }
}

/// A fast-selector pattern's operands: registers, an immediate last, or one immediate (`i`) or
/// float immediate (`f`).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kinds {
    R,
    Rr,
    Rrr,
    Ri,
    I,
    F,
}

/// What a pattern emits: an instruction whose result is in the class, or a sub-register.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum FastEmit<O, C, S> {
    Inst(O, C),
    Extract(S),
}

/// One pattern of LLVM's fast instruction selector: `node` over `vt` giving `ret`, its operands
/// `kinds` and immediate predicate; the node operands `copies` go to physical registers first,
/// `args` are the ones the instruction takes, in order.
#[derive(Clone, Copy, Debug)]
pub struct Fast<'t, O, C, P, S, R> {
    pub node: Isd,
    pub vt: Mvt,
    pub ret: Mvt,
    pub kinds: Kinds,
    pub pred: Option<P>,
    pub copies: &'t [(u8, R)],
    pub args: &'t [u8],
    pub emit: FastEmit<O, C, S>,
}

impl<'t, O: Copy, C: Copy, P: Copy, S: Copy, R: Copy> Fast<'t, O, C, P, S, R> {
    /// The first pattern for the node, types and kinds whose immediate predicate holds.
    pub fn find(all: &'t [Self], node: Isd, vt: Mvt, ret: Mvt, kinds: Kinds, imm: Option<i64>, holds: impl Fn(P, i64) -> bool) -> Option<&'t Self> {
        all.iter().find(|f| {
            f.node == node && f.vt == vt && f.ret == ret && f.kinds == kinds && f.pred.is_none_or(|p| imm.is_some_and(|i| holds(p, i)))
        })
    }
}

/// An instruction operand as the instruction lists it.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum OperandKind {
    Reg,
    Imm,
    Mem,
    PcRel,
    Cond,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct MachineOperand<C, E> {
    pub kind: OperandKind,
    pub class: Option<C>,
    /// How many machine operands it is (a memory reference is five on x86).
    pub subs: u8,
    pub encoder: E,
}

impl Isd {
    /// The node an llvm dialect op is, as `SelectionDAGBuilder` builds it, for the ops a fast
    /// selector's patterns take as they are.
    pub fn of(body: &Body<'_>, op: OpId) -> Option<Isd> {
        Some(match &*body[op].name {
            "llvm.add" => Isd::Add,
            "llvm.sub" => Isd::Sub,
            "llvm.mul" => Isd::Mul,
            "llvm.and" => Isd::And,
            "llvm.or" => Isd::Or,
            "llvm.xor" => Isd::Xor,
            "llvm.shl" => Isd::Shl,
            "llvm.lshr" => Isd::Srl,
            "llvm.ashr" => Isd::Sra,
            "llvm.sdiv" => Isd::Sdiv,
            "llvm.udiv" => Isd::Udiv,
            "llvm.fadd" => Isd::Fadd,
            "llvm.fsub" => Isd::Fsub,
            "llvm.fmul" => Isd::Fmul,
            "llvm.fdiv" => Isd::Fdiv,
            "llvm.fneg" => Isd::Fneg,
            "llvm.sext" => Isd::SignExtend,
            "llvm.zext" => Isd::ZeroExtend,
            "llvm.trunc" => Isd::Truncate,
            "llvm.fpext" => Isd::FpExtend,
            "llvm.fptrunc" => Isd::FpRound,
            "llvm.sitofp" => Isd::SintToFp,
            "llvm.uitofp" => Isd::UintToFp,
            "llvm.fptosi" => Isd::FpToSint,
            "llvm.fptoui" => Isd::FpToUint,
            "llvm.bitcast" => Isd::Bitcast,
            "llvm.intr.sqrt" => Isd::Fsqrt,
            "llvm.intr.fabs" => Isd::Fabs,
            "llvm.intr.floor" => Isd::Ffloor,
            "llvm.intr.ceil" => Isd::Fceil,
            "llvm.intr.trunc" => Isd::Ftrunc,
            "llvm.intr.bswap" => Isd::Bswap,
            "llvm.intr.ctlz" => Isd::Ctlz,
            _ => return None,
        })
    }
}
