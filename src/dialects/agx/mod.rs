mod stream;
mod usc;

pub use stream::*;
pub use usc::{Kind as UscKind, Slot as AgxSlot, Usc, UscBuild, UscCase, UscField, UscIns, UscOperand};
use usc::{Kind, Slot};

use alloc::format;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Region, Type};

use crate::{Layouts, OpRows, RegType, ShaderStage};

pub const AGX: Layouts<'_> = Layouts(AGX_ITEMS);

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum AgxType<'e> {
    R(&'e str),
    U(&'e str),
}

impl<'a> From<AgxType<'_>> for Type<'a> {
    fn from(r: AgxType<'_>) -> Self {
        let (name, elem) = match r {
            AgxType::R(e) => ("agx.r", e),
            AgxType::U(e) => ("agx.u", e),
        };
        RegType { name, elem }.into()
    }
}

impl<'t> TryFrom<&'t Type<'_>> for AgxType<'t> {
    type Error = Error;

    fn try_from(t: &'t Type<'_>) -> Result<AgxType<'t>, Error> {
        match RegType::try_from(t)? {
            RegType { name: "agx.r", elem } => Ok(AgxType::R(elem)),
            RegType { name: "agx.u", elem } => Ok(AgxType::U(elem)),
            _ => Err(Error(format!("{t} is not a agx register"))),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub struct AgxDialect;

impl mlirformat::Dialect for AgxDialect {
    fn namespace(&self) -> &'static str {
        "agx"
    }

    fn ops(&self) -> Vec<mlirformat::Template> {
        [StructOps.ops(), UscOps.ops(), PseudoOps.ops()].concat()
    }

    fn op_infos(&self) -> Vec<mlirformat::OpInfo> {
        OpRows::of(&self.ops(), &[("agx.usc.input", &["uniform"]), ("agx.kernel", &["sym_name", "stage", "params", "gprs", "align"])])
    }
}

#[mlirformat::mlir::op("agx.usc.input", format = "attr-dict `->` type($result)", results(result))]
pub struct UscInput<'a> {
    #[attr(int = "i64")]
    pub uniform: i64,
    pub result: Type<'a>,
}

#[mlirformat::mlir::op("agx.kernel", format = "$sym_name attr-dict-with-keyword $body")]
pub struct AgxKernel<'a> {
    #[attr(symbol)]
    pub sym_name: Attribute<'a>,
    pub stage: Option<ShaderStage>,
    pub params: Option<u32>,
    pub gprs: Option<u32>,
    pub align: Option<u64>,
    pub body: Region<'a>,
}

#[mlirformat::mlir::dialect("agx", ops = [UscInput, AgxKernel])]
struct PseudoOps;

#[allow(non_snake_case, reason = "Mesa's field names")]
#[path = "cmdbuf.gen.rs"]
mod cmdbuf;
#[path = "usc.gen.rs"]
mod isa;

pub use cmdbuf::*;
use cmdbuf::StructOps;
pub use isa::*;
use isa::UscOps;
