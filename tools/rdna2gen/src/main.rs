//! Mesa's AMD register database ⇒ the rdna2 dialect's register and packet ops: reads data/amd/gfx103.json (every
//! register of GFX10.3, its MMIO byte offset and fields; a few GFX10 code uses from gfx9.json, `FROM_GFX9`), data/amd/pkt3.json (the PM4 packets' dwords, those of
//! gfx103), data/amd/sid.h (the PM4 type-3 opcodes, `PKT3_*`), and writes
//! `src/dialects/rdna2/regs.gen.rs`:
//!
//! - `RDNA2_ITEMS`: every register's layout (one dword: fields' first bit and width; `num` its byte offset), sorted by op
//!   name, for `Layouts::pack`; a register without fields has one, `value`, all 32 bits;
//! - a typed op per register: `rdna2.reg.*` for MMIO registers, `rdna2.pkt.*` for packet dwords, each field an
//!   `Fill` (a number or a place); `Rdna2Regs::verify` reads an op as its typed op;
//! - `RDNA2_PM4_OPCODES`: every PM4 packet's opcode, sorted by op name, and a typed op `rdna2.pm4.*` per packet (`body`,
//!   `predicate`, `compute`; the four `SET_{CONFIG,SH,CONTEXT,UCONFIG}_REG` hold their registers in a region and are
//!   declared by hand, `SETS`); `Rdna2Packets::verify`;
//! - the enum values as constants `RDNA2_*`, like Mesa's `V_*` defines (a name two enums give different values is prefixed with
//!   its enum; the packets' are always prefixed, their names are generic; one starting with a digit gets `_`).
//!
//! `cargo run -p rdna2gen -- data/amd/gfx103.json data/amd/gfx9.json data/amd/pkt3.json data/amd/sid.h
//! src/dialects/rdna2/regs.gen.rs`

use std::collections::{BTreeMap, HashMap};
use std::fmt::Write;

use serde::Deserialize;

/// The chip the tables are for.
const CHIP: &str = "gfx103";
/// Registers GFX10 code uses that Mesa's gfx103 database leaves to the older chips' (its combined amdgfxregs.h has
/// them from there, same address and fields): taken from gfx9.json.
const FROM_GFX9: &[&str] = &["COMPUTE_STATIC_THREAD_MGMT_SE0", "COMPUTE_STATIC_THREAD_MGMT_SE1", "COMPUTE_STATIC_THREAD_MGMT_SE2", "COMPUTE_STATIC_THREAD_MGMT_SE3"];
/// Registers that hold an address shifted right (the database gives them as a plain value): their one field
/// `address`, the byte address, stored `>> n` (radv: `radeon_set_sh_reg(pgm_lo, va >> 8)`).
const ADDRESSES: &[(&str, u32)] = &[("COMPUTE_PGM_LO", 8)];

/// Packets whose ops the dialect declares itself (with a region of registers).
const SETS: &[&str] = &["rdna2.pm4.set_config_reg", "rdna2.pm4.set_sh_reg", "rdna2.pm4.set_context_reg", "rdna2.pm4.set_uconfig_reg"];

#[derive(Deserialize)]
struct Db {
    enums: BTreeMap<String, Enum>,
    register_mappings: Vec<Mapping>,
    register_types: BTreeMap<String, RegType>,
}

#[derive(Deserialize)]
struct Enum {
    entries: Vec<Entry>,
}

#[derive(Deserialize)]
struct Entry {
    name: String,
    value: u64,
}

#[derive(Deserialize)]
struct Mapping {
    name: String,
    chips: Vec<String>,
    map: Map,
    type_ref: Option<String>,
}

#[derive(Deserialize)]
struct Map {
    at: u32,
    to: String,
}

#[derive(Deserialize)]
struct RegType {
    fields: Vec<RegField>,
}


#[derive(Deserialize)]
struct RegField {
    name: String,
    bits: [u32; 2],
    enum_ref: Option<String>,
}

/// One register as the table spells it.
struct Item {
    name: String,
    /// `reg` (MMIO) or `pkt` (a packet dword).
    space: &'static str,
    op: String,
    num: u32,
    /// (name, first bit, width, type)
    fields: Vec<(String, u32, u32, String)>,
}

impl Item {
    /// `mapping` of `db`, in op space `space` (`reg`, `pkt`).
    fn new(db: &Db, m: &Mapping, space: &'static str) -> Item {
        let fields = match (&m.type_ref, ADDRESSES.iter().find(|(n, _)| *n == m.name)) {
            (_, Some((_, shift))) => vec![("address".to_owned(), 0, 32, format!("Ty::Shr({shift})"))],
            (Some(t), None) => db.register_types[t].fields.iter().map(|f| (f.name.to_lowercase(), f.bits[0], f.bits[1] - f.bits[0] + 1, "Ty::Uint".to_owned())).collect(),
            (None, None) => vec![("value".to_owned(), 0, 32, "Ty::Uint".to_owned())],
        };
        Item { name: m.name.clone(), space, op: format!("rdna2.{space}.{}", m.name.to_lowercase()), num: m.map.at, fields }
    }

    /// The op's Rust type: `Reg` / `Pkt` and the name in camel case.
    fn ty(&self) -> String {
        format!("{}{}", if self.space == "reg" { "Reg" } else { "Pkt" }, camel(&self.name))
    }
}

/// `SNAKE_case` ⇒ `SnakeCase`.
fn camel(name: &str) -> String {
    name.split('_').map(|w| w[..1].to_uppercase() + &w[1..].to_lowercase()).collect()
}

/// The enum constants: (name, value), deduplicated as the module doc says.
struct Consts(BTreeMap<String, u64>);

impl Consts {
    fn new(regs: &Db, pkt: &Db, pkt_enums: &[&str]) -> Consts {
        let mut by_name: HashMap<&str, Vec<(&str, u64)>> = HashMap::new();
        for (e, en) in &regs.enums {
            for x in &en.entries {
                by_name.entry(&x.name).or_default().push((e, x.value));
            }
        }
        let mut out = BTreeMap::new();
        for (name, uses) in &by_name {
            let same = uses.iter().all(|u| u.1 == uses[0].1);
            for (e, v) in uses {
                let key = if same { (*name).to_owned() } else { format!("{}_{name}", e.to_uppercase()) };
                out.insert(key, *v);
            }
        }
        for e in pkt_enums {
            for x in &pkt.enums[*e].entries {
                out.insert(format!("{e}_{}", x.name), x.value);
            }
        }
        Consts(out)
    }
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let [_, regs, gfx9, pkt, sid, output] = &args[..] else { panic!("usage: rdna2gen <gfx103.json> <gfx9.json> <pkt3.json> <sid.h> <out.rs>") };
    let read = |p: &str| -> Db { serde_json::from_str(&std::fs::read_to_string(p).unwrap()).unwrap() };
    let (regs, gfx9, pkt) = (read(regs), read(gfx9), read(pkt));

    let mine = |m: &&Mapping| m.chips.iter().any(|c| c == CHIP);
    let mut items: Vec<Item> = regs.register_mappings.iter().filter(mine).map(|m| Item::new(&regs, m, "reg")).collect();
    for name in FROM_GFX9 {
        assert!(items.iter().all(|i| i.name != *name), "{name} is in gfx103.json now");
        let m = gfx9.register_mappings.iter().find(|m| m.name == *name && m.chips.iter().any(|c| c == "gfx9")).unwrap_or_else(|| panic!("{name} not in gfx9.json"));
        items.push(Item::new(&gfx9, m, "reg"));
    }
    let pkts: Vec<&Mapping> = pkt.register_mappings.iter().filter(mine).filter(|m| m.map.to == "pkt3").collect();
    items.extend(pkts.iter().map(|m| Item::new(&pkt, m, "pkt")));
    items.sort_by(|a, b| a.op.cmp(&b.op));
    let pkt_enums: Vec<&str> = pkts
        .iter()
        .filter_map(|m| m.type_ref.as_ref())
        .flat_map(|t| pkt.register_types[t].fields.iter().filter_map(|f| f.enum_ref.as_deref()))
        .collect();

    // `#define PKT3_<NAME> 0x<opcode>` (an opcode is a byte; masks such as PKT3_IT_OPCODE_C are not)
    let opcodes: BTreeMap<String, u32> = std::fs::read_to_string(sid)
        .unwrap()
        .lines()
        .filter_map(|l| {
            let mut w = l.split_whitespace();
            let (Some("#define"), Some(name), Some(v)) = (w.next(), w.next(), w.next()) else { return None };
            let opcode = u32::from_str_radix(v.strip_prefix("0x")?, 16).ok().filter(|&o| o <= 0xff)?;
            Some((format!("rdna2.pm4.{}", name.strip_prefix("PKT3_")?.to_lowercase()), opcode))
        })
        .collect();

    let mut out = String::new();
    out.push_str("// @generated by tools/rdna2gen from data/amd/gfx103.json, gfx9.json, pkt3.json, sid.h (RDNA2). Do not edit.\n//\n");
    out.push_str("// Register layouts are Mesa's register database (src/amd/registers, Copyright Advanced Micro Devices, MIT license).\n\n");
    out.push_str("use alloc::vec::Vec;\n\nuse super::Word;\nuse crate::{PackField as Field, PackItem as Item, PackTy as Ty};\n\n");
    out.push_str("/// Every register's layout, sorted by op name; `num` is its byte offset (MMIO), or its place among the packets.\n");
    out.push_str("pub const RDNA2_ITEMS: &[Item] = &[\n");
    for i in &items {
        writeln!(out, "    Item {{\n        name: \"{}\",\n        op: \"{}\",\n        length: 1,\n        bias: 0,\n        num: {:#x},\n        fields: &[", i.name, i.op, i.num).unwrap();
        for (n, bit, width, ty) in &i.fields {
            writeln!(out, "            Field::new(\"{n}\", {bit}, {width}, {ty}),").unwrap();
        }
        out.push_str("        ],\n        group: None,\n    },\n");
    }
    out.push_str("];\n\n/// Every PM4 type-3 packet's opcode, sorted by op name.\npub const RDNA2_PM4_OPCODES: &[(&str, u32)] = &[\n");
    for (op, opcode) in &opcodes {
        writeln!(out, "    (\"{op}\", {opcode:#04x}),").unwrap();
    }
    out.push_str("];\n\n");
    // a typed op a register / packet dword: its fields, each a number or a place
    for i in &items {
        writeln!(out, "/// `{}`: {}.\n#[mlirformat::mlir::op(\"{}\", format = \"attr-dict\")]\n#[derive(Default)]\npub struct {} {{", i.op, i.name, i.op, i.ty()).unwrap();
        for (n, ..) in &i.fields {
            let ident = if matches!(n.as_str(), "type" | "priv") { format!("r#{n}") } else { n.clone() };
            writeln!(out, "    pub {ident}: Option<crate::Fill>,").unwrap();
        }
        out.push_str("}\n\n");
    }
    out.push_str("/// The registers' and packet dwords' typed ops.\npub struct Rdna2Regs;\n\nimpl Rdna2Regs {\n    /// ⭐ Reads op `op` of `body` as its register's typed op (`None`: not a register).\n    pub fn verify(body: &crate::Body<'_>, op: crate::OpId) -> Option<Result<(), mlirformat::Error>> {\n        use crate::Heads;\n        Some(match &*body[op].name {\n");
    for i in &items {
        writeln!(out, "            \"{}\" => body.head::<{}>(op).map(drop),", i.op, i.ty()).unwrap();
    }
    out.push_str("            _ => return None,\n        })\n    }\n}\n\n#[mlirformat::mlir::dialect(\"rdna2\", ops = [");
    out.push_str(&items.iter().map(Item::ty).collect::<Vec<_>>().join(", "));
    out.push_str("])]\npub(crate) struct TypedRegOps;\n\n");
    // a typed op a packet (the four SET_*_REG hold their registers in a region: declared by hand)
    let packets: Vec<&String> = opcodes.keys().filter(|o| !SETS.contains(&o.as_str())).collect();
    for op in &packets {
        writeln!(out, "/// `{op}`: its body, and the header's predicate / compute bits.\n#[mlirformat::mlir::op(\"{op}\", format = \"attr-dict\")]\n#[derive(Default)]\npub struct Pm4{} {{\n    pub body: Vec<Word>,\n    pub predicate: bool,\n    pub compute: bool,\n}}\n", camel(&op["rdna2.pm4.".len()..])).unwrap();
    }
    out.push_str("/// The packets' typed ops.\npub struct Rdna2Packets;\n\nimpl Rdna2Packets {\n    /// ⭐ Reads op `op` of `body` as its packet's typed op (`None`: not a packet).\n    pub fn verify(body: &crate::Body<'_>, op: crate::OpId) -> Option<Result<(), mlirformat::Error>> {\n        use crate::Heads;\n        Some(match &*body[op].name {\n");
    for op in &packets {
        writeln!(out, "            \"{op}\" => body.head::<Pm4{}>(op).map(drop),", camel(&op["rdna2.pm4.".len()..])).unwrap();
    }
    out.push_str("            _ => return None,\n        })\n    }\n}\n\n#[mlirformat::mlir::dialect(\"rdna2\", ops = [");
    out.push_str(&packets.iter().map(|op| format!("Pm4{}", camel(&op["rdna2.pm4.".len()..]))).collect::<Vec<_>>().join(", "));
    out.push_str("])]\npub(crate) struct PacketOps;\n");
    // what the typed ops declare (they live in `<{...}>`): a register's fields, a packet's body and bits
    out.push_str("\n/// The registers' and packets' declared attributes, for the dialect's `op_infos`.\npub const RDNA2_INHERENT: &[(&str, &[&str])] = &[\n");
    for i in &items {
        let names: Vec<String> = i.fields.iter().map(|(n, ..)| format!("\"{n}\"")).collect();
        writeln!(out, "    (\"{}\", &[{}]),", i.op, names.join(", ")).unwrap();
    }
    for op in &packets {
        writeln!(out, "    (\"{op}\", &[\"body\", \"predicate\", \"compute\"]),").unwrap();
    }
    out.push_str("];\n");

    for (name, v) in &Consts::new(&regs, &pkt, &pkt_enums).0 {
        let lead = if name.starts_with(|c: char| c.is_ascii_digit()) { "_" } else { "" };
        writeln!(out, "pub const RDNA2_{lead}{}: u32 = {v:#x};", name.to_uppercase()).unwrap();
    }
    std::fs::write(output, out).unwrap();
}
