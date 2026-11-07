//! ⭐ RDNA2 (GFX10.3; Radeon 610M of Ryzen 9000 HX, gfx1036) machine code as MLIR: the `rdna2` dialect's
//! instructions (`rdna2.isa.*`, one op per encoding family, [`isa`](Rdna2Isa)), the kernel holding them
//! (`rdna2.kernel`) and what a wave starts with (`rdna2.isa.input`).
//!
//! ```text
//!   rdna2.kernel @k {stage = "compute", params = 2, sgprs = 12, vgprs = 6} {   one shader's instructions, in order
//!     rdna2.isa.valu {op = "v_add_u32", dst = "v1", src0 = "v1", src1 = "v0"}  an instruction (registers allocated)
//!   }
//! ```
//!
//! A command stream (registers, PM4) is the driver's: it loads this dialect's ops into its own `rdna2` dialect
//! ([`Rdna2Dialect::ops`]).

mod isa;
#[path = "opcodes.gen.rs"]
mod opcodes;

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Region, Type};

use crate::{OpRows, RegType, ShaderStage};

pub use isa::{Build as Rdna2Build, Ds as Rdna2Ds, Family as Rdna2Family, Fields as Rdna2Fields, Flag as Rdna2Flag, Flat as Rdna2Flat, Format as Rdna2Format, Int as Rdna2Int, Isa as Rdna2Isa, Key as Rdna2Key, Operand as Rdna2Operand, Reg as Rdna2Reg, Salu as Rdna2Salu, Slot as Rdna2Slot, Smem as Rdna2Smem, Valu as Rdna2Valu, Words as Rdna2Words};
pub use opcodes::{HASHES as RDNA2_HASHES, Opcode as Rdna2Opcode};

use isa::{Format, IsaOps};
use opcodes::{HASHES, Opcode};

/// ⭐ A register type of a virtual RDNA2 instruction's values: `!rdna2.v<elem>` a VGPR (a lane each), `!rdna2.s<elem>`
/// an SGPR (a lane mask, the zero base: `i64` an aligned pair).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Rdna2Type<'e> {
    V(&'e str),
    S(&'e str),
}

impl<'a> From<Rdna2Type<'_>> for Type<'a> {
    fn from(r: Rdna2Type<'_>) -> Self {
        let (name, elem) = match r {
            Rdna2Type::V(e) => ("rdna2.v", e),
            Rdna2Type::S(e) => ("rdna2.s", e),
        };
        RegType { name, elem }.into()
    }
}

impl<'t> TryFrom<&'t Type<'_>> for Rdna2Type<'t> {
    type Error = Error;

    fn try_from(t: &'t Type<'_>) -> Result<Rdna2Type<'t>, Error> {
        match RegType::try_from(t)? {
            RegType { name: "rdna2.v", elem } => Ok(Rdna2Type::V(elem)),
            RegType { name: "rdna2.s", elem } => Ok(Rdna2Type::S(elem)),
            _ => Err(Error(format!("{t} is not a rdna2 register"))),
        }
    }
}

/// ⭐ The `rdna2` dialect's machine code: load it with `MlirOpt::load(Rdna2Dialect)`, or put [`Rdna2Dialect::ops`] in
/// a dialect of one's own that also has the command stream.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct Rdna2Dialect;

impl Rdna2Dialect {
    /// The declared attributes of [`Rdna2Dialect::ops`], for an `op_infos`.
    pub const INHERENT: &[(&str, &[&str])] = &[("rdna2.isa.input", &["reg"]), ("rdna2.kernel", &["sym_name", "stage", "params", "sgprs", "vgprs", "pad", "align"])];
}

impl mlirformat::Dialect for Rdna2Dialect {
    fn namespace(&self) -> &'static str {
        "rdna2"
    }

    fn ops(&self) -> Vec<mlirformat::Template> {
        [PseudoOps.ops(), IsaOps.ops()].concat()
    }

    fn op_infos(&self) -> Vec<mlirformat::OpInfo> {
        OpRows::of(&self.ops(), Self::INHERENT)
    }
}

/// `rdna2.isa.input {reg}`: what the wave starts with in register `reg` of its result's file (`!rdna2.s`: the
/// parameters, the workgroup ids; `!rdna2.v`: the thread id); rdna2-regalloc keeps the value there and takes the op out.
#[mlirformat::mlir::op("rdna2.isa.input", format = "attr-dict `->` type($result)", results(result))]
pub struct Rdna2Input<'a> {
    #[attr(int = "i64")]
    pub reg: i64,
    pub result: Type<'a>,
}

/// ⭐ `rdna2.kernel @k {stage, params, sgprs, vgprs, pad, align} {...}`: one shader's instructions, in order, and what
/// the driver needs to run it: its `params` (dwords, user SGPRs s0 ...), the registers it uses (COMPUTE_PGM_RSRC1),
/// the zeros it wants after it (`pad`: the instruction prefetch) and its alignment (`align`: COMPUTE_PGM_LO is
/// the address >> 8).
#[mlirformat::mlir::op("rdna2.kernel", format = "$sym_name attr-dict-with-keyword $body")]
pub struct Rdna2Kernel<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub stage: Option<ShaderStage>,
    pub params: Option<u32>,
    pub sgprs: Option<u32>,
    pub vgprs: Option<u32>,
    pub pad: Option<u64>,
    pub align: Option<u64>,
    pub body: Region<'a>,
}

/// The ops of the dialect that are not instructions.
#[mlirformat::mlir::dialect("rdna2", ops = [Rdna2Input, Rdna2Kernel])]
struct PseudoOps;
