//! Building GFX10 instruction ops, and reading one's fields back.

use alloc::vec::Vec;

use mlirformat::rdna2::{Rdna2Fields as Fields, Rdna2Flag as Flag, Rdna2Opcode as Opcode, Rdna2Operand as Operand, Rdna2Slot as Slot};
use mlirformat::{Attribute, Error, Type};

use crate::{Body, OpData, OpId, ValueId};

pub struct Rdna2Build<'a> {
    data: OpData<'a>,
    results: Vec<Type<'a>>,
}

impl<'a> Rdna2Build<'a> {
    pub fn new<O: mlirformat::Op>(op: Opcode, operands: &[ValueId], slots: &[Slot], results: Vec<Type<'a>>) -> Self {
        let mut data = OpData::build(O::NAME).operands(operands).with("op", Attribute::Str { lit: op.name().into(), ty: None });
        if !slots.is_empty() {
            data.set("slots", Attribute::Array(slots.iter().map(|s| Attribute::Str { lit: s.key().into(), ty: None }).collect()));
        }
        Rdna2Build { data, results }
    }

    pub fn source(mut self, slot: Slot, o: Operand) -> Self {
        self.data.set(slot.key(), o.into());
        self
    }

    pub fn flag(mut self, f: Flag) -> Self {
        self.data.set(f.key(), Attribute::Unit);
        self
    }

    pub fn simm16(mut self, v: i64) -> Self {
        self.data.set("simm16", Attribute::integer(v.into(), Type::int(64)));
        self
    }

    pub fn split(self) -> (OpData<'a>, Vec<Type<'a>>) {
        (self.data, self.results)
    }
}

/// An instruction op's fields
pub struct Rdna2Isa;

impl Rdna2Isa {
    pub fn read(body: &Body<'_>, op: OpId) -> Result<Option<Fields>, Error> {
        let d = &body[op];
        Fields::of(&d.name, d.properties.iter().chain(&d.attributes), d.results.len())
    }
}
