use alloc::borrow::Cow;
use alloc::format;
use alloc::string::ToString;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, NamedAttr, Type};
use serde::{Deserialize, Deserializer, Serialize, Serializer};

use super::{Enc, USC_HASHES, UscMod, UscOp};
use crate::{Attrs, OpData, ValueId};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Kind {
    Int,
    Signed,
    Model(&'static str),
    Operand(Enc),
}

#[derive(Clone, Copy, Debug)]
pub struct UscField<'t> {
    pub name: &'t str,
    pub kind: Kind,
    pub bits: &'t [(u32, u32)],
    pub shift: u32,
}

#[derive(Clone, Copy, Debug)]
pub struct UscIns<'t> {
    pub op: &'t str,
    pub lengths: &'t [u32],
    pub length_bit: Option<u32>,
    pub mask: u128,
    pub value: u128,
    pub modifiers: &'t [UscField<'t>],
    pub immediates: &'t [UscField<'t>],
    pub dests: &'t [UscField<'t>],
    pub sources: &'t [UscField<'t>],
}

#[derive(Clone, Copy, Debug)]
pub struct UscCase<'t> {
    pub mask: u128,
    pub value: u128,
    pub field: Option<UscField<'t>>,
    pub modifiers: &'t [UscField<'t>],
}

impl UscField<'_> {
    fn width(&self) -> u32 {
        self.bits.iter().map(|(a, b)| b - a + 1).sum()
    }

    fn deposit(&self, v: u128) -> Result<u128, Error> {
        let w = self.width();
        if w < 128 && v >> w != 0 {
            return Err(Error(format!("{}: {v:#x} does not fit {w} bits", self.name)));
        }
        let mut out = 0;
        let mut at = 0;
        for &(a, b) in self.bits {
            let n = b - a + 1;
            out |= ((v >> at) & ((1u128 << n) - 1)) << a;
            at += n;
        }
        Ok(out)
    }

    fn raw(&self, a: &Attribute<'_>) -> Result<u128, Error> {
        let v = Attrs::as_int(a).or_else(|_| match a {
            Attribute::Unit | Attribute::Bool(true) => Ok(1),
            Attribute::Bool(false) => Ok(0),
            _ => Err(Error(format!("{}: {a} is not a number", self.name))),
        })?;
        let w = self.width() + self.shift;
        let v = if v < 0 { (v as i128 & ((1i128 << w) - 1)) as u128 } else { v as u128 };
        if v & ((1 << self.shift) - 1) != 0 {
            return Err(Error(format!("{}: {v:#x} is not a multiple of {}", self.name, 1u32 << self.shift)));
        }
        Ok(v >> self.shift)
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Slot {
    D0,
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
}

impl Slot {
    pub const NEG: [&str; 3] = ["neg0", "neg1", "neg2"];
    pub const ABS: [&str; 3] = ["abs0", "abs1", "abs2"];

    const ALL: [Slot; 7] = [Slot::D0, Slot::S0, Slot::S1, Slot::S2, Slot::S3, Slot::S4, Slot::S5];

    pub const fn key(self) -> &'static str {
        match self {
            Slot::D0 => "d0",
            Slot::S0 => "s0",
            Slot::S1 => "s1",
            Slot::S2 => "s2",
            Slot::S3 => "s3",
            Slot::S4 => "s4",
            Slot::S5 => "s5",
        }
    }

    pub const fn source(k: usize) -> Option<Slot> {
        match k {
            0 => Some(Slot::S0),
            1 => Some(Slot::S1),
            2 => Some(Slot::S2),
            3 => Some(Slot::S3),
            4 => Some(Slot::S4),
            5 => Some(Slot::S5),
            _ => None,
        }
    }

    pub const fn index(self) -> Option<usize> {
        match self {
            Slot::D0 => None,
            s => Some(s as usize - 1),
        }
    }
}

impl TryFrom<&str> for Slot {
    type Error = Error;

    fn try_from(k: &str) -> Result<Slot, Error> {
        Slot::ALL.into_iter().find(|s| s.key() == k).ok_or_else(|| Error(format!("{k}: not a slot")))
    }
}

impl Serialize for Slot {
    fn serialize<S: Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {
        s.serialize_str(self.key())
    }
}

impl<'de> Deserialize<'de> for Slot {
    fn deserialize<D: Deserializer<'de>>(d: D) -> Result<Self, D::Error> {
        let k = <Cow<'de, str>>::deserialize(d)?;
        Slot::try_from(&*k).map_err(serde::de::Error::custom)
    }
}

pub trait UscOperand: Sized {
    const ENC: Enc;
    fn parts(&self) -> (usize, Vec<u32>);
    fn of_parts(case: usize, values: &[u32]) -> Result<Self, Error>;
}

impl Usc {
    pub fn case_bits(enc: Enc, k: usize, values: &[u32]) -> Result<u128, Error> {
        let case = enc.cases().get(k).ok_or_else(|| Error(format!("{} has no case {k}", enc.name())))?;
        let mut v = case.value;
        for (f, x) in case.field.iter().chain(case.modifiers).zip(values) {
            v |= f.deposit(u128::from(*x) >> f.shift)?;
        }
        Ok(v)
    }

    pub fn attr<O: UscOperand>(o: &O) -> Attribute<'static> {
        let (k, values) = o.parts();
        let case = &O::ENC.cases()[k];
        let int = |v: u64| Attribute::Int { lit: v.to_string().into(), ty: None };
        let mut d = vec![NamedAttr { name: "case".into(), value: Some(int(k as u64)) }];
        d.extend(case.field.iter().chain(case.modifiers).zip(&values).filter(|(_, x)| **x != 0).map(|(f, x)| NamedAttr { name: f.name.into(), value: Some(int(u64::from(*x))) }));
        Attribute::Dict(d)
    }

    pub fn of_attr<O: UscOperand>(a: &Attribute<'_>) -> Result<O, Error> {
        let Attribute::Dict(entries) = a else { return Err(Error(format!("{}: {a} is not an operand dictionary", O::ENC.name()))) };
        let num = |v: &Option<Attribute<'_>>| match v {
            None | Some(Attribute::Unit) => Ok(1),
            Some(a) => Attrs::as_int(a),
        };
        let mut k = 0;
        for e in entries.iter().filter(|e| e.name == "case") {
            k = num(&e.value)? as usize;
        }
        let case = O::ENC.cases().get(k).ok_or_else(|| Error(format!("{} has no case {k}", O::ENC.name())))?;
        let fields: Vec<&UscField<'_>> = case.field.iter().chain(case.modifiers).collect();
        let mut values = vec![0u32; fields.len()];
        for e in entries.iter().filter(|e| e.name != "case") {
            let at = fields.iter().position(|f| f.name == e.name).ok_or_else(|| Error(format!("{} case {k} has no {}", O::ENC.name(), e.name)))?;
            values[at] = u32::try_from(num(&e.value)?).map_err(|e| Error(e.to_string()))?;
        }
        O::of_parts(k, &values)
    }

    pub fn serialize_operand<O: UscOperand, S: Serializer>(o: &O, s: S) -> Result<S::Ok, S::Error> {
        Usc::attr(o).serialize(s)
    }

    pub fn deserialize_operand<'de, O: UscOperand, D: Deserializer<'de>>(d: D) -> Result<O, D::Error> {
        Usc::of_attr(&Attribute::deserialize(d)?).map_err(<D::Error as serde::de::Error>::custom)
    }

    pub fn slots(d: &OpData<'_>) -> Result<Vec<Slot>, Error> {
        match d.get("slots") {
            None => Ok(Vec::new()),
            Some(Attribute::Array(s)) => s
                .iter()
                .map(|x| match x {
                    Attribute::Str { lit, .. } => Slot::try_from(&**lit),
                    _ => Err(Error(format!("slot {x}"))),
                })
                .collect(),
            Some(a) => Err(Error(format!("slots = {a}"))),
        }
    }
}

pub struct UscBuild<'a> {
    data: OpData<'a>,
    results: Vec<Type<'a>>,
}

impl<'a> UscBuild<'a> {
    pub fn new(op: UscOp, operands: &[ValueId], slots: &[Slot], results: Vec<Type<'a>>) -> Self {
        let mut data = OpData::build(op.ins().op).operands(operands);
        if !slots.is_empty() {
            data.set("slots", Attribute::Array(slots.iter().map(|s| Attribute::Str { lit: s.key().into(), ty: None }).collect()));
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

pub struct Usc;

impl Usc {
    pub fn op(name: &str) -> Option<UscOp> {
        let m = name.strip_prefix("agx.usc.")?;
        let h = m.bytes().fold(0xcbf2_9ce4_8422_2325, |h, b| (h ^ u64::from(b)).wrapping_mul(0x0100_0000_01b3));
        USC_HASHES.binary_search_by_key(&h, |(k, _)| *k).ok().map(|k| USC_HASHES[k].1).filter(|o| o.name() == m)
    }

    pub fn get(name: &str) -> Option<&'static UscIns<'static>> {
        Usc::op(name).map(UscOp::ins)
    }

    fn operand(enc: Enc, a: &Attribute<'_>) -> Result<u128, Error> {
        let kind = enc.name();
        let Attribute::Dict(d) = a else { return Err(Error(format!("{kind}: {a} is not an operand dictionary"))) };
        let d = Attrs(d);
        let k = d.need_int("case")? as usize;
        let case = enc.cases().get(k).ok_or_else(|| Error(format!("{kind} has no case {k}")))?;
        let mut v = case.value;
        for n in d.0 {
            let f = match &*n.name {
                "case" => continue,
                name => case.field.iter().chain(case.modifiers).find(|f| f.name == name),
            };
            let f = f.ok_or_else(|| Error(format!("{kind} case {k} has no {}", n.name)))?;
            let x = n.value.as_ref().map_or(Ok(1), |x| f.raw(x))?;
            v |= f.deposit(x)?;
        }
        if v & case.mask != case.value {
            return Err(Error(format!("{kind} case {k}: a field sets its exact bits")));
        }
        Ok(v)
    }

    pub fn encode(op: &str, attrs: &[NamedAttr<'_>]) -> Result<Vec<u8>, Error> {
        let ins = Usc::get(op).ok_or_else(|| Error(format!("{op}: not a USC instruction")))?;
        let mut v = ins.value;
        let mut long = false;
        for n in attrs {
            let name = &*n.name;
            if name == "long" {
                long = true;
                continue;
            }
            let index = |prefix: &str| name.strip_prefix(prefix).and_then(|k| k.parse::<usize>().ok());
            let (field, operand) = match (index("d"), index("s")) {
                (Some(k), _) => (ins.dests.get(k), true),
                (_, Some(k)) => (ins.sources.get(k), true),
                _ => (ins.modifiers.iter().chain(ins.immediates).find(|f| f.name == name), false),
            };
            let f = field.ok_or_else(|| Error(format!("{op} has no {name}")))?;
            let x = match (&n.value, operand) {
                (Some(a), true) => match f.kind {
                    Kind::Operand(e) => Usc::operand(e, a)?,
                    k => return Err(Error(format!("{op}: {name} is a {k:?}, not an operand"))),
                },
                (Some(a), false) => f.raw(a)?,
                (None, false) => 1,
                (None, true) => return Err(Error(format!("{op}: {name} without a value"))),
            };
            v |= f.deposit(x)?;
        }
        if v & ins.mask != ins.value {
            return Err(Error(format!("{op}: a field sets its exact bits")));
        }
        let fits = |v: u128, n: u32| n >= 16 || v >> (n * 8) == 0;
        let (n, v) = match (ins.lengths, ins.length_bit) {
            ([short, l], Some(bit)) if long || !fits(v, *short) => (*l, v | 1 << bit),
            _ if long => return Err(Error(format!("{op} has no long form"))),
            ([short, ..], _) => (*short, v),
            ([], _) => return Err(Error(format!("{op}: no length"))),
        };
        if !fits(v, n) {
            return Err(Error(format!("{op}: bits past its {n} bytes")));
        }
        Ok(v.to_le_bytes()[..n as usize].to_vec())
    }
}
