//! Building USC instruction ops: an instruction, its operands in their slots, its modifiers.

use alloc::vec::Vec;

use mlirformat::agx::{AgxSlot as Slot, Usc, UscMod, UscOp, UscOperand};
use mlirformat::{Attribute, Type};

use crate::{OpData, ValueId};

pub struct UscBuild<'a> {
    data: OpData<'a>,
    results: Vec<Type<'a>>,
}

impl<'a> UscBuild<'a> {
    pub fn new(op: UscOp, operands: &[ValueId], slots: &[Slot], results: Vec<Type<'a>>) -> Self {
        let mut data = OpData::build(op.ins().op).operands(operands);
        if !slots.is_empty() {
            data.set("slots", Slot::attr(slots));
        }
        UscBuild { data, results }
    }

    pub fn modifier(mut self, m: UscMod, v: i64) -> Self {
        self.data.set(m.key(), Attribute::integer(v.into(), Type::int(64)));
        self
    }

    pub fn operand<O: UscOperand>(mut self, slot: Slot, o: &O) -> Self {
        self.data.set(slot.key(), Usc::attr(o));
        self
    }

    pub fn neg(mut self, slot: Slot) -> Self {
        if let Some(k) = slot.index() {
            self.data.set(Slot::NEG[k], Attribute::Unit);
        }
        self
    }

    pub fn split(self) -> (OpData<'a>, Vec<Type<'a>>) {
        (self.data, self.results)
    }
}
