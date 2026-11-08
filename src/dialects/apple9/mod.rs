//! ⭐ Apple9 (the GPU of Apple M3 / M4) as MLIR: the `apple9` dialect.
//!
//! ```text
//!   apple9.<form>   an instruction, by its fields (registers r0 ..: 32-bit GPRs)       ⇒ its bytes ([`Apple9Isa`])
//!   apple9.kernel   one shader's instructions and what running it needs
//! ```
//!
//! ```text
//!   apple9.kernel @k {stage = "compute", params = 2, gprs = 33} {     one shader's instructions, in order
//!     apple9.iadd {dst = 4, a = 2, b = 3, wait = 32}                 an instruction (registers allocated)
//!   }
//! ```
//!
//! Before its registers are allocated an instruction is virtual: its SSA operands are its sources in the order
//! [`Apple9Op::sources`] names them, its results (`!apple9.r<i32 | f32>`) its destination (a load's: its components'
//! registers, one after another).
//!
//! Apple9 is not Apple7 (M1, the `agx` dialect: Mesa's AGX2 model): the encodings differ. There is no Mesa model of
//! Apple9; see [`Apple9Isa`] for where each form comes from and how it was checked.

mod isa;

pub use isa::{APPLE9_GPRS, Apple9Isa, Apple9Op};

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Region, Type};

use crate::{OpRows, RegType, ShaderStage};

/// ⭐ The register type of a virtual instruction's values: `!apple9.r<elem>`, a 32-bit GPR (a thread each).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct Apple9Type<'e>(pub &'e str);

impl<'a> From<Apple9Type<'_>> for Type<'a> {
    fn from(r: Apple9Type<'_>) -> Self {
        RegType { name: "apple9.r", elem: r.0 }.into()
    }
}

impl<'t> TryFrom<&'t Type<'_>> for Apple9Type<'t> {
    type Error = Error;

    fn try_from(t: &'t Type<'_>) -> Result<Apple9Type<'t>, Error> {
        match RegType::try_from(t)? {
            RegType { name: "apple9.r", elem } => Ok(Apple9Type(elem)),
            _ => Err(Error(format!("{t} is not an apple9 register"))),
        }
    }
}

/// ⭐ The `apple9` dialect: load it with `MlirOpt::load(Apple9Dialect)`.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Apple9Dialect;

impl Apple9Dialect {
    /// The declared attributes of the ops that are not instructions.
    pub const INHERENT: &[(&str, &[&str])] = &[("apple9.kernel", &["sym_name", "stage", "params", "gprs"])];
}

impl mlirformat::Dialect for Apple9Dialect {
    fn namespace(&self) -> &'static str {
        "apple9"
    }

    fn ops(&self) -> Vec<mlirformat::Template> {
        [PseudoOps.ops(), IsaOps.ops()].concat()
    }

    fn op_infos(&self) -> Vec<mlirformat::OpInfo> {
        OpRows::of(&self.ops(), Self::INHERENT)
    }
}

/// ⭐ `apple9.kernel @k {stage, params, gprs, shared} {...}`: one shader's instructions, in order, and what running it
/// needs: its `params` (32-bit words: the parameter buffer's), the GPRs it uses (`gprs`: r0 .. r(gprs - 1)), the bytes of
/// threadgroup memory it uses (`shared`), the invocations of its workgroup (`workgroup`: 32, or 16, two a hardware
/// workgroup).
#[mlirformat::mlir::op("apple9.kernel", format = "$sym_name attr-dict-with-keyword $body")]
pub struct Apple9Kernel<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub stage: Option<ShaderStage>,
    pub params: Option<u32>,
    pub gprs: Option<u32>,
    pub shared: Option<u32>,
    pub workgroup: Option<u32>,
    pub body: Region<'a>,
}

/// The ops of the dialect that are not instructions.
#[mlirformat::mlir::dialect("apple9", ops = [Apple9Kernel])]
struct PseudoOps;

crate::attr_ops! { "apple9" IsaOps;
    Apple9GetSr "apple9.get_sr", Apple9GetSr16 "apple9.get_sr16", Apple9Mov "apple9.mov", Apple9MovImm "apple9.mov_imm",
    Apple9Iadd "apple9.iadd", Apple9Isub "apple9.isub", Apple9Imad "apple9.imad", Apple9Shl "apple9.shl",
    Apple9Shr "apple9.shr", Apple9Asr "apple9.asr", Apple9And "apple9.and", Apple9Or "apple9.or", Apple9Xor "apple9.xor",
    Apple9Smin "apple9.smin", Apple9Smax "apple9.smax", Apple9Umin "apple9.umin", Apple9Umax "apple9.umax",
    Apple9Select "apple9.select", Apple9I2f "apple9.i2f", Apple9F2i "apple9.f2i", Apple9Fadd "apple9.fadd",
    Apple9Fmul "apple9.fmul", Apple9Fsub "apple9.fsub", Apple9Fma "apple9.fma", Apple9Fmin "apple9.fmin",
    Apple9Fmax "apple9.fmax", Apple9Rcp "apple9.rcp", Apple9Rsq "apple9.rsq", Apple9Floor "apple9.floor",
    Apple9Ceil "apple9.ceil", Apple9Trunc "apple9.trunc", Apple9Roundeven "apple9.roundeven", Apple9Load "apple9.load",
    Apple9Store "apple9.store", Apple9Atomic "apple9.atomic", Apple9Cmpxchg "apple9.cmpxchg", Apple9SharedAtomic "apple9.shared_atomic", Apple9SharedLoad "apple9.shared_load",
    Apple9SharedStore "apple9.shared_store", Apple9Barrier "apple9.barrier", Apple9Pred "apple9.pred",
    Apple9Push "apple9.push", Apple9Else "apple9.else", Apple9Pop "apple9.pop", Apple9LoopPush "apple9.loop_push",
    Apple9LoopUpdate "apple9.loop_update", Apple9LoopPop "apple9.loop_pop", Apple9JmpAny "apple9.jmp_any",
    Apple9JmpNone "apple9.jmp_none", Apple9Label "apple9.label", Apple9Halt "apple9.halt",
}
