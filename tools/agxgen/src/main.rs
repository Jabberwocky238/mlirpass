//! Mesa's asahi genxml ⇒ the agx dialect's ops: reads data/apple/cmdbuf.xml (every AGX struct: the words of the
//! VDM / CDM control streams, of the PPP state, the texture / sampler / PBE descriptors, the USC words) and writes
//! `src/dialects/agx/cmdbuf.gen.rs`:
//!
//! - `ITEMS`: every struct's layout (fields' first bit, width, type, default), sorted by op name, for
//!   `Layouts::pack`; `num` is the struct's length in bytes (Mesa's `AGX_*_LENGTH`; a few are not whole dwords);
//! - a typed op per struct: `agx.<name>`, the name as Mesa's C names it (`safe_name`, lower case), its settable
//!   fields typed (bool, float, or `crate::Fill`: a number or a place);
//! - the enum values as constants, as Mesa's (`AGX_<ENUM>_<VALUE>` without `AGX_`).
//!
//! A field's type follows gen_pack.py: bool; uint / hex / address / an enum ⇒ unsigned; float; half; lod; `exact` ⇒ fixed
//! to that value; the modifiers `shr(n)`, `minus(n)`, `log2`, `groups(n)` ⇒ their types, with gen_pack.py's defaults
//! (what encodes to zero).
//!
//! It also reads data/apple/agx2-isa.json (Mesa's model of the USC instruction set, dumped by scripts/agx_isa_dump.py)
//! and writes `src/dialects/agx/usc.gen.rs`: `UscOp`, every instruction, and `USC` its lengths, exact bits,
//! modifiers, immediates and operands (in `UscOp`'s order); `Enc`, every operand encoding, and its cases; `UscMod`,
//! the modifiers' names; an operand enum an encoding (a variant a case); a typed op an instruction.
//!
//! `cargo run -p agxgen -- data/apple/cmdbuf.xml src/dialects/agx/cmdbuf.gen.rs data/apple/agx2-isa.json
//! src/dialects/agx/usc.gen.rs`

use std::collections::BTreeMap;
use std::fmt::Write;

use serde::Deserialize;

/// data/apple/agx2-isa.json.
#[derive(Deserialize)]
struct Isa {
    instructions: Vec<Ins>,
    encodings: BTreeMap<String, Vec<Case>>,
}

#[derive(Deserialize)]
struct Ins {
    name: String,
    lengths: Vec<u32>,
    length_bit: Option<u32>,
    mask: String,
    value: String,
    modifiers: Vec<Part>,
    immediates: Vec<Part>,
    dests: Vec<Part>,
    sources: Vec<Part>,
}

#[derive(Deserialize)]
struct Case {
    mask: String,
    value: String,
    field: Option<Part>,
    modifiers: Vec<Part>,
}

/// A field: its name (none for an operand), kind, bit ranges, shift.
#[derive(Deserialize)]
struct Part {
    #[serde(default)]
    name: String,
    kind: String,
    bits: Vec<[u32; 2]>,
    #[serde(default)]
    shift: u32,
}

impl Part {
    /// `operand`: an instruction's destination or source (its kind an operand encoding).
    fn rust(&self, operand: bool) -> String {
        let bits: Vec<String> = self.bits.iter().map(|[a, b]| format!("({a}, {b})")).collect();
        let kind = match self.kind.as_str() {
            k if operand => format!("Kind::Operand(Enc::{})", Name::camel(k)),
            "int" => "Kind::Int".to_owned(),
            "signed" => "Kind::Signed".to_owned(),
            k => format!("Kind::Model(\"{k}\")"),
        };
        format!("UscField {{ name: \"{}\", kind: {kind}, bits: &[{}], shift: {} }}", self.name, bits.join(", "), self.shift)
    }
}

/// FNV-1a, 64 bits (the agx dialect hashes a mnemonic the same way to look it up).
fn fnv1a(s: &str) -> u64 {
    s.bytes().fold(0xcbf2_9ce4_8422_2325, |h, b| (h ^ u64::from(b)).wrapping_mul(0x0100_0000_01b3))
}

/// gen_pack.py `safe_name`: its substitutions, then `_` before a leading non-letter.
struct Name;

impl Name {
    const SUBSTITUTIONS: &[(char, &str)] = &[
        (' ', "_"), ('/', "_"), ('[', ""), (']', ""), ('(', ""), (')', ""), ('-', "_"), (':', ""), ('.', ""), (',', ""),
        ('=', ""), ('>', ""), ('#', ""), ('&', ""), ('*', ""), ('"', ""), ('+', ""), ('\'', ""), ('?', ""),
    ];

    fn safe(name: &str) -> String {
        let mut out = String::new();
        for c in name.chars() {
            match Name::SUBSTITUTIONS.iter().find(|(k, _)| *k == c) {
                Some((_, r)) => out.push_str(r),
                None => out.push(c),
            }
        }
        if !out.starts_with(|c: char| c.is_alphabetic()) {
            out.insert(0, '_');
        }
        out
    }

    /// The op's Rust type: the name in camel case.
    fn camel(name: &str) -> String {
        name.split('_').filter(|w| !w.is_empty()).map(|w| w[..1].to_uppercase() + &w[1..]).collect()
    }
}

/// A field as the table spells it.
struct Field {
    name: String,
    bit: u32,
    width: u32,
    ty: String,
    default: u64,
}

struct Reader<'x> {
    /// enum ⇒ (value name ⇒ value)
    enums: BTreeMap<&'x str, Vec<(&'x str, u64)>>,
}

impl Reader<'_> {
    /// gen_pack.py: int(value, 0).
    fn num(v: &str) -> u64 {
        v.strip_prefix("0x").map_or_else(|| v.parse::<u64>(), |h| u64::from_str_radix(h, 16)).unwrap()
    }

    fn field(&self, f: roxmltree::Node<'_, '_>) -> Field {
        let a = |k: &str| f.attribute(k);
        let start = a("start").unwrap();
        let bit = match start.split_once(':') {
            Some((w, b)) => w.parse::<u32>().unwrap() * 32 + b.parse::<u32>().unwrap(),
            None => start.parse().unwrap(),
        };
        let width: u32 = a("size").unwrap().parse().unwrap();
        let ty = a("type").unwrap();
        let base = match ty {
            "bool" => "Bool",
            "float" => "Float",
            "half" => "Half",
            "lod" => "Lod",
            "uint" | "hex" | "address" => "Uint",
            e if self.enums.contains_key(e) => "Uint",
            other => panic!("field {}: type {other}", a("name").unwrap()),
        };
        if let Some(x) = a("exact") {
            let v = match ty {
                "bool" => u64::from(x == "true"),
                // gen_pack.py names it by its C name, upper case: `AGX_<ENUM>_<VALUE>`
                e if self.enums.contains_key(e) => self.enums[e].iter().find(|(n, _)| Name::safe(n).to_uppercase() == Name::safe(x).to_uppercase()).unwrap_or_else(|| panic!("{e} has no {x}")).1,
                _ => Reader::num(x),
            };
            return Field { name: Name::safe(a("name").unwrap()).to_lowercase(), bit, width, ty: "Ty::Exact".into(), default: v };
        }
        let (ty, default) = match a("modifier") {
            None => (format!("Ty::{base}"), 0),
            Some("log2") => ("Ty::Log2".into(), 1),
            Some(m) => {
                let (k, n) = m.strip_suffix(')').and_then(|m| m.split_once('(')).unwrap_or_else(|| panic!("modifier {m}"));
                let n: u32 = n.parse().unwrap();
                match k {
                    "shr" => (format!("Ty::Shr({n})"), 0),
                    "minus" => (format!("Ty::Minus({n})"), u64::from(n)),
                    "groups" => (format!("Ty::Groups({n})"), (1u64 << width) * u64::from(n)),
                    _ => panic!("modifier {m}"),
                }
            }
        };
        Field { name: Name::safe(a("name").unwrap()).to_lowercase(), bit, width, ty, default }
    }
}

impl Isa {
    /// usc.gen.rs.
    fn write(mut self, output: &str) {
        let parts = |v: &[Part], operand: bool| v.iter().map(|p| p.rust(operand)).collect::<Vec<_>>().join(", ");
        self.instructions.sort_by(|a, b| a.name.cmp(&b.name));
        let mut out = String::new();
        out.push_str("// @generated by tools/agxgen from data/apple/agx2-isa.json (AGX2 USC; scripts/agx_isa_dump.py dumps Mesa's\n");
        out.push_str("// src/asahi/isa model). Do not edit: `cargo run -p agxgen -- data/apple/cmdbuf.xml src/dialects/agx/cmdbuf.gen.rs\n");
        out.push_str("// data/apple/agx2-isa.json src/dialects/agx/usc.gen.rs`.\n//\n");
        out.push_str("// The instruction set is Mesa's model of it (src/asahi/isa AGX2.xml, isa.py; Copyright Valve Corporation, MIT license).\n\n");
        out.push_str("#[allow(unused_imports, reason = \"what the encodings use\")]\nuse alloc::{format, vec, vec::Vec};\n\nuse super::{Kind, UscCase, UscField, UscIns};\n\n");
        // the instructions
        out.push_str("/// Every USC instruction (`agx.usc.<name>`), in [`USC`]'s order.\n#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]\npub enum UscOp {\n");
        for i in &self.instructions {
            writeln!(out, "    {},", Name::camel(&i.name)).unwrap();
        }
        out.push_str("}\n\nimpl UscOp {\n    /// Its mnemonic (Mesa's name).\n    pub const fn name(self) -> &'static str {\n        match self {\n");
        for i in &self.instructions {
            writeln!(out, "            Self::{} => \"{}\",", Name::camel(&i.name), i.name).unwrap();
        }
        out.push_str("        }\n    }\n\n    /// Its encoding.\n    pub const fn ins(self) -> &'static UscIns<'static> {\n        &USC[self as usize]\n    }\n}\n\n");
        out.push_str("/// Every instruction by the FNV-1a hash of its mnemonic, sorted (for [`UscOp`]'s `TryFrom<&str>`).\npub const USC_HASHES: &[(u64, UscOp)] = &[\n");
        let mut hashed: Vec<(u64, &Ins)> = self.instructions.iter().map(|i| (fnv1a(&i.name), i)).collect();
        hashed.sort_by_key(|(h, _)| *h);
        assert!(hashed.windows(2).all(|w| w[0].0 != w[1].0), "two mnemonics with one hash");
        for (h, i) in hashed {
            writeln!(out, "    ({h:#018x}, UscOp::{}),", Name::camel(&i.name)).unwrap();
        }
        out.push_str("];\n\n/// Every USC instruction's encoding, in [`UscOp`]'s order.\npub const USC: &[UscIns] = &[\n");
        for i in &self.instructions {
            let lengths: Vec<String> = i.lengths.iter().map(u32::to_string).collect();
            writeln!(out, "    UscIns {{\n        op: \"agx.usc.{}\",\n        lengths: &[{}],\n        length_bit: {:?},", i.name, lengths.join(", "), i.length_bit).unwrap();
            writeln!(out, "        mask: {},\n        value: {},", i.mask, i.value).unwrap();
            for (k, v, operand) in [("modifiers", &i.modifiers, false), ("immediates", &i.immediates, false), ("dests", &i.dests, true), ("sources", &i.sources, true)] {
                writeln!(out, "        {k}: &[{}],", parts(v, operand)).unwrap();
            }
            out.push_str("    },\n");
        }
        // the operand encodings
        out.push_str("];\n\n/// Every operand encoding.\n#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]\npub enum Enc {\n");
        for kind in self.encodings.keys() {
            writeln!(out, "    {},", Name::camel(kind)).unwrap();
        }
        out.push_str("}\n\nimpl Enc {\n    /// Its name in Mesa's model.\n    pub const fn name(self) -> &'static str {\n        match self {\n");
        for kind in self.encodings.keys() {
            writeln!(out, "            Self::{} => \"{kind}\",", Name::camel(kind)).unwrap();
        }
        out.push_str("        }\n    }\n\n    /// Its cases, in the order a decoder tries them.\n    pub const fn cases(self) -> &'static [UscCase<'static>] {\n        match self {\n");
        for (kind, cases) in &self.encodings {
            writeln!(out, "            Self::{} => &[", Name::camel(kind)).unwrap();
            for c in cases {
                let field = c.field.as_ref().map_or("None".to_owned(), |f| format!("Some({})", f.rust(false)));
                writeln!(out, "                UscCase {{ mask: {}, value: {}, field: {field}, modifiers: &[{}] }},", c.mask, c.value, parts(&c.modifiers, false)).unwrap();
            }
            out.push_str("            ],\n");
        }
        out.push_str("        }\n    }\n}\n\n");
        self.typed(&mut out);
        std::fs::write(output, out).unwrap();
    }

    /// A case's variant names, unique within its encoding: its value field's (`Reg`, `Imm`, `None`), with the case's
    /// index where two cases share one.
    fn variants(cases: &[Case]) -> Vec<String> {
        let base: Vec<String> = cases.iter().map(|c| Name::camel(c.field.as_ref().map_or("none", |f| f.name.as_str()))).collect();
        base.iter().enumerate().map(|(k, b)| if base.iter().filter(|x| *x == b).count() > 1 { format!("{b}{k}") } else { b.clone() }).collect()
    }

    /// The typed half: `UscMod`, an operand enum an encoding, an op an instruction.
    fn typed(&self, out: &mut String) {
        // the modifiers and immediates by name
        let mut mods: Vec<&str> = self.instructions.iter().flat_map(|i| i.modifiers.iter().chain(&i.immediates)).map(|m| m.name.as_str()).collect();
        mods.sort();
        mods.dedup();
        out.push_str("/// Every instruction modifier and immediate (an op's property).\n#[derive(Clone, Copy, Debug, PartialEq, Eq)]\npub enum UscMod {\n");
        for m in &mods {
            writeln!(out, "    {},", Name::camel(m)).unwrap();
        }
        out.push_str("}\n\nimpl UscMod {\n    /// The property's name.\n    pub const fn key(self) -> &'static str {\n        match self {\n");
        for m in &mods {
            writeln!(out, "            Self::{} => \"{m}\",", Name::camel(m)).unwrap();
        }
        out.push_str("        }\n    }\n}\n\n");
        // an enum an operand encoding
        for (kind, cases) in &self.encodings {
            let ty = format!("{}Operand", Name::camel(kind));
            let variants = Isa::variants(cases);
            let fields = |c: &Case| c.field.iter().chain(&c.modifiers).map(|f| f.name.clone()).collect::<Vec<_>>();
            writeln!(out, "/// A `{kind}` operand: one variant a case.\n#[derive(Clone, Copy, Debug, PartialEq, Eq)]\npub enum {ty} {{").unwrap();
            for (c, v) in cases.iter().zip(&variants) {
                let f = fields(c);
                if f.is_empty() {
                    writeln!(out, "    {v},").unwrap();
                } else {
                    writeln!(out, "    {v} {{ {} }},", f.iter().map(|n| format!("{n}: u32")).collect::<Vec<_>>().join(", ")).unwrap();
                }
            }
            writeln!(out, "}}\n\nimpl super::UscOperand for {ty} {{\n    const ENC: Enc = Enc::{};\n\n    fn parts(&self) -> (usize, Vec<u32>) {{\n        match *self {{", Name::camel(kind)).unwrap();
            for (k, (c, v)) in cases.iter().zip(&variants).enumerate() {
                let f = fields(c);
                if f.is_empty() {
                    writeln!(out, "            Self::{v} => ({k}, Vec::new()),").unwrap();
                } else {
                    writeln!(out, "            Self::{v} {{ {} }} => ({k}, vec![{}]),", f.join(", "), f.join(", ")).unwrap();
                }
            }
            out.push_str("        }\n    }\n\n    fn of_parts(case: usize, values: &[u32]) -> Result<Self, mlirformat::Error> {\n        Ok(match (case, values) {\n");
            for (k, (c, v)) in cases.iter().zip(&variants).enumerate() {
                let f = fields(c);
                if f.is_empty() {
                    writeln!(out, "            ({k}, []) => Self::{v},").unwrap();
                } else {
                    writeln!(out, "            ({k}, &[{}]) => Self::{v} {{ {} }},", f.join(", "), f.join(", ")).unwrap();
                }
            }
            writeln!(out, "            _ => return Err(mlirformat::Error(format!(\"{kind}: case {{case}} with {{}} values\", values.len()))),\n        }})\n    }}\n}}\n").unwrap();
            // the register it names and a memory operand's mask (agx-wait reads them)
            for field in ["reg", "mask"] {
                writeln!(out, "impl {ty} {{\n    /// Its `{field}` field, if its case has one.\n    pub fn {field}(&self) -> Option<u32> {{").unwrap();
                let has: Vec<&String> = cases.iter().zip(&variants).filter(|(c, _)| fields(c).iter().any(|f| f == field)).map(|(_, v)| v).collect();
                if has.is_empty() {
                    out.push_str("        None\n");
                } else {
                    out.push_str("        match *self {\n");
                    for v in &has {
                        writeln!(out, "            Self::{v} {{ {field}, .. }} => Some({field}),").unwrap();
                    }
                    if has.len() < cases.len() {
                        out.push_str("            _ => None,\n");
                    }
                    out.push_str("        }\n");
                }
                out.push_str("    }\n}\n\n");
            }
            writeln!(out, "impl serde::Serialize for {ty} {{\n    fn serialize<S: serde::Serializer>(&self, s: S) -> Result<S::Ok, S::Error> {{\n        super::Usc::serialize_operand(self, s)\n    }}\n}}\n").unwrap();
            writeln!(out, "impl<'de> serde::Deserialize<'de> for {ty} {{\n    fn deserialize<D: serde::Deserializer<'de>>(d: D) -> Result<Self, D::Error> {{\n        super::Usc::deserialize_operand(d)\n    }}\n}}\n").unwrap();
        }
        // an operand's register and mask by its encoding
        out.push_str("impl Enc {\n    /// ⭐ The `reg` and `mask` fields of operand `a` of this encoding (its dictionary read as its typed enum).\n    pub fn regs(self, a: &mlirformat::Attribute<'_>) -> Result<(Option<u32>, Option<u32>), mlirformat::Error> {\n        match self {\n");
        for kind in self.encodings.keys() {
            let ty = format!("{}Operand", Name::camel(kind));
            writeln!(out, "            Self::{} => super::Usc::of_attr::<{ty}>(a).map(|o| (o.reg(), o.mask())),", Name::camel(kind)).unwrap();
        }
        out.push_str("        }\n    }\n}\n\n");
        // an op an instruction
        let format = "(`(` $operands^ `:` type($operands) `)`)? attr-dict (`->` type($results)^)?";
        for i in &self.instructions {
            let ty = format!("Usc{}", Name::camel(&i.name));
            writeln!(out, "/// `agx.usc.{}`.\n#[mlirformat::mlir::op(\"agx.usc.{}\", format = \"{format}\", results(results))]\npub struct {ty}<'a> {{", i.name, i.name).unwrap();
            if i.length_bit.is_some() {
                out.push_str("    /// The long form (1).\n    pub long: Option<i64>,\n");
            }
            for m in i.modifiers.iter().chain(&i.immediates) {
                writeln!(out, "    pub {}: Option<i64>,", m.name).unwrap();
            }
            for (k, d) in i.dests.iter().enumerate() {
                writeln!(out, "    pub d{k}: Option<{}Operand>,", Name::camel(&d.kind)).unwrap();
            }
            for (k, src) in i.sources.iter().enumerate() {
                writeln!(out, "    pub s{k}: Option<{}Operand>,", Name::camel(&src.kind)).unwrap();
                // a float source's negation / absolute value, before the allocation spells them into the operand
                if self.encodings[&src.kind].iter().any(|c| c.modifiers.iter().any(|m| m.name == "neg")) {
                    writeln!(out, "    pub neg{k}: bool,\n    pub abs{k}: bool,").unwrap();
                }
            }
            out.push_str("    #[slot(types)]\n    pub operands: Vec<mlirformat::Value<'a>>,\n    pub types: Vec<mlirformat::Type<'a>>,\n    pub slots: Option<Vec<super::Slot>>,\n    pub results: Vec<mlirformat::Type<'a>>,\n}\n\n");
        }
        out.push_str("impl UscOp {\n    /// ⭐ Reads op `op` of `body` as this instruction's typed op: its fields as the op declares them.\n    pub fn verify(self, body: &crate::Body<'_>, op: crate::OpId) -> Result<(), mlirformat::Error> {\n        use crate::Heads;\n        match self {\n");
        for i in &self.instructions {
            writeln!(out, "            Self::{} => body.head::<Usc{}>(op).map(drop),", Name::camel(&i.name), Name::camel(&i.name)).unwrap();
        }
        out.push_str("        }\n    }\n}\n\n");
        out.push_str("/// The USC instructions' ops.\n#[mlirformat::mlir::dialect(\"agx\", ops = [");
        out.push_str(&self.instructions.iter().map(|i| format!("Usc{}", Name::camel(&i.name))).collect::<Vec<_>>().join(", "));
        out.push_str("])]\npub(crate) struct UscOps;\n");
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let [_, input, output, isa, usc] = &args[..] else { panic!("usage: agxgen <cmdbuf.xml> <cmdbuf.gen.rs> <agx2-isa.json> <usc.gen.rs>") };
    Isa::write(serde_json::from_str(&std::fs::read_to_string(isa).unwrap()).unwrap(), usc);
    let text = std::fs::read_to_string(input).unwrap();
    let doc = roxmltree::Document::parse(&text).unwrap();
    let root = doc.root_element();

    let mut r = Reader { enums: BTreeMap::new() };
    for e in root.children().filter(|c| c.has_tag_name("enum")) {
        let values = e.children().filter(|v| v.has_tag_name("value")).map(|v| (v.attribute("name").unwrap(), Reader::num(v.attribute("value").unwrap()))).collect();
        r.enums.insert(e.attribute("name").unwrap(), values);
    }

    // (op, name, bytes, fields)
    let mut items: Vec<(String, String, u32, Vec<Field>)> = Vec::new();
    for s in root.children().filter(|c| c.has_tag_name("struct")) {
        let name = s.attribute("name").unwrap();
        let fields: Vec<Field> = s.children().filter(|c| c.has_tag_name("field")).map(|f| r.field(f)).collect();
        // gen_pack.py Group.get_length: the size, else up to the byte of the last bit
        let bytes = s.attribute("size").map_or_else(|| fields.iter().map(|f| (f.bit + f.width - 1) / 8 + 1).max().unwrap_or(0), |v| v.parse().unwrap());
        items.push((format!("agx.{}", Name::safe(name).to_lowercase()), name.to_owned(), bytes, fields));
    }
    items.sort_by(|a, b| a.0.cmp(&b.0));

    let mut out = String::new();
    out.push_str("// @generated by tools/agxgen from cmdbuf.xml (AGX). Do not edit.\n//\n");
    out.push_str("// Struct layouts are Mesa's asahi genxml (src/asahi/genxml, Copyright Alyssa Rosenzweig, Valve Corporation, MIT license).\n\n");
    out.push_str("#[allow(unused_imports, reason = \"what the structs use\")]\nuse alloc::vec::Vec;\n\nuse crate::{PackField as Field, PackItem as Item, PackTy as Ty};\n\n");
    out.push_str("/// Every struct's layout, sorted by op name; `num` is its length in bytes.\npub const AGX_ITEMS: &[Item] = &[\n");
    for (op, name, bytes, fields) in &items {
        writeln!(out, "    Item {{\n        name: \"{name}\",\n        op: \"{op}\",\n        length: {},\n        bias: 0,\n        num: {bytes},\n        fields: &[", bytes.div_ceil(4)).unwrap();
        for f in fields {
            let default = if f.default != 0 { format!(".with_default({:#x})", f.default) } else { String::new() };
            writeln!(out, "            Field::new(\"{}\", {}, {}, {}){default},", f.name, f.bit, f.width, f.ty).unwrap();
        }
        out.push_str("        ],\n        group: None,\n    },\n");
    }
    out.push_str("];\n\n");
    // a typed op a struct: its settable fields (an exact one is fixed), a bool / a float / a number or a place
    for (op, name, _, fields) in &items {
        writeln!(out, "/// `{op}`: Mesa's {name}.\n#[mlirformat::mlir::op(\"{op}\", format = \"attr-dict\")]\n#[derive(Default)]\npub struct {} {{", Name::camel(&op["agx.".len()..])).unwrap();
        for f in fields.iter().filter(|f| f.ty != "Ty::Exact") {
            let ty = match f.ty.as_str() {
                "Ty::Bool" => "bool",
                "Ty::Float" | "Ty::Half" | "Ty::Lod" => "crate::Real",
                _ => "crate::Fill",
            };
            let ident = if f.name == "type" { "r#type".to_owned() } else { f.name.clone() };
            writeln!(out, "    pub {ident}: Option<{ty}>,").unwrap();
        }
        out.push_str("}\n\n");
    }
    out.push_str("/// The structs' typed ops.\npub struct AgxStructs;\n\nimpl AgxStructs {\n    /// ⭐ Reads op `op` of `body` as its struct's typed op (`None`: not a struct).\n    pub fn verify(body: &crate::Body<'_>, op: crate::OpId) -> Option<Result<(), mlirformat::Error>> {\n        use crate::Heads;\n        Some(match &*body[op].name {\n");
    for (op, ..) in &items {
        writeln!(out, "            \"{op}\" => body.head::<{}>(op).map(drop),", Name::camel(&op["agx.".len()..])).unwrap();
    }
    out.push_str("            _ => return None,\n        })\n    }\n}\n\n");
    out.push_str("/// The structs' ops.\n#[mlirformat::mlir::dialect(\"agx\", ops = [");
    out.push_str(&items.iter().map(|(op, ..)| Name::camel(&op["agx.".len()..])).collect::<Vec<_>>().join(", "));
    out.push_str("])]\npub(crate) struct StructOps;\n\n");
    let mut consts = BTreeMap::new();
    for (e, values) in &r.enums {
        // gen_pack.py emit_enum: `agx_<enum>_<value>` upper case (the Format enum without its name)
        let prefix = if *e == "Format" { String::new() } else { format!("{}_", Name::safe(e)) };
        for (v, x) in values {
            consts.insert(Name::safe(&format!("{prefix}{v}")).to_uppercase(), *x);
        }
    }
    for (name, v) in consts {
        writeln!(out, "pub const AGX_{name}: u32 = {v:#x};").unwrap();
    }
    std::fs::write(output, out).unwrap();
}
