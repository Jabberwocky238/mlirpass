//! ⭐ The aliases `mlir-opt` prints (`AliasInitializer`): the builtin dialect's, `#map` for an
//! affine map and `#set` for an integer set. Aliases are inlined on import ([`Body::import`]);
//! printing makes them again, named and ordered as the C++ printer does.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Attribute;

use crate::{Body, OpId};

/// An attribute the builtin dialect names (`BuiltinOpAsmDialectInterface::getAlias`).
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
enum AliasKind {
    Map,
    Set,
}

impl AliasKind {
    const ALL: [Self; 2] = [Self::Map, Self::Set];

    /// How its text starts.
    fn keyword(self) -> &'static str {
        match self {
            Self::Map => "affine_map<",
            Self::Set => "affine_set<",
        }
    }

    /// The alias it gets (`OverridableAlias`).
    fn alias(self) -> &'static str {
        match self {
            Self::Map => "map",
            Self::Set => "set",
        }
    }
}

/// The aliased attributes of one printing, by their text, in the order the printer first
/// visits them (`AliasInitializer::visit`); `taken`: alias names already defined.
pub(crate) struct Aliases {
    seen: Vec<(AliasKind, String)>,
    known: BTreeSet<String>,
    taken: BTreeSet<String>,
}

impl Aliases {
    pub(crate) fn new(taken: impl IntoIterator<Item = String>) -> Self {
        Self { seen: Vec::new(), known: BTreeSet::new(), taken: taken.into_iter().collect() }
    }

    /// Each `affine_map<...>` / `affine_set<...>` in `text`, outside string literals. A body
    /// holds no `<`; its `->` and `>=` are not the closing `>`.
    fn spans(text: &str) -> Vec<(Range<usize>, AliasKind)> {
        let bytes = text.as_bytes();
        let mut out = Vec::new();
        let mut i = 0;
        while i < bytes.len() {
            match bytes[i] {
                b'"' => {
                    i += 1;
                    while i < bytes.len() && bytes[i] != b'"' {
                        i += if bytes[i] == b'\\' { 2 } else { 1 };
                    }
                    i += 1;
                }
                b'a' if !(i > 0 && (bytes[i - 1].is_ascii_alphanumeric() || b"_$.#!".contains(&bytes[i - 1]))) => {
                    let Some(kind) = AliasKind::ALL.into_iter().find(|k| text[i..].starts_with(k.keyword())) else {
                        i += 1;
                        continue;
                    };
                    let mut j = i + kind.keyword().len();
                    while j < bytes.len() && !(bytes[j] == b'>' && bytes[j - 1] != b'-' && bytes.get(j + 1) != Some(&b'=')) {
                        j += 1;
                    }
                    if j >= bytes.len() {
                        break;
                    }
                    out.push((i..j + 1, kind));
                    i = j + 1;
                }
                _ => i += 1,
            }
        }
        out
    }

    /// Visits the aliased attributes in `text`, in order.
    pub(crate) fn visit(&mut self, text: &str) {
        for (r, kind) in Self::spans(text) {
            if self.known.insert(String::from(&text[r.clone()])) {
                self.seen.push((kind, String::from(&text[r])));
            }
        }
    }

    /// The generic printer's order (`DummyAliasOperationPrinter::printGenericOp`): an op's
    /// regions (each block's argument types, then its ops), its operand types, result types,
    /// then its attributes, properties among them, sorted by name.
    pub(crate) fn visit_generic(&mut self, b: &Body<'_>, op: OpId) {
        for r in &b[op].regions {
            for blk in &b[*r].blocks {
                for a in &b[*blk].args {
                    self.visit(&format!("{}", b[*a].ty));
                }
                for o in &b[*blk].ops {
                    self.visit_generic(b, *o);
                }
            }
        }
        for v in b[op].operands.iter().chain(&b[op].results) {
            self.visit(&format!("{}", b[*v].ty));
        }
        let (properties, attributes) = b.placed(&b[op]);
        let mut attrs: Vec<(&str, Option<&Attribute<'_>>)> = match &properties {
            Some(Attribute::Dict(ps)) => ps.iter().map(|a| (&*a.name, a.value.as_ref())).collect(),
            _ => Vec::new(),
        };
        attrs.extend(attributes.iter().map(|a| (&*a.name, a.value.as_ref())));
        attrs.sort_by(|x, y| x.0.cmp(y.0));
        for (_, a) in attrs {
            if let Some(a) = a {
                self.visit(&format!("{a}"));
            }
        }
    }

    /// `initializeAliases` and the printing: the aliases sorted by name (stably: in visiting
    /// order), numbered `map`, `map1`, ... past the names `taken`; their definitions first, then
    /// `text` with each aliased attribute by its alias.
    pub(crate) fn apply(mut self, text: &str) -> String {
        if self.seen.is_empty() {
            return String::from(text);
        }
        self.seen.sort_by_key(|(k, _)| *k);
        let mut counts: BTreeMap<&str, u32> = BTreeMap::new();
        let mut names: BTreeMap<&str, String> = BTreeMap::new();
        let mut out = String::new();
        for (kind, attr) in &self.seen {
            let base = kind.alias();
            let name = if self.taken.insert(String::from(base)) {
                String::from(base)
            } else {
                // `uniqueAliasNameIndex`: the next count not taken.
                let count = counts.entry(base).or_insert(1);
                loop {
                    let probe = format!("{base}{count}");
                    *count += 1;
                    if self.taken.insert(probe.clone()) {
                        break probe;
                    }
                }
            };
            out += &format!("#{name} = {attr}\n");
            names.insert(attr, name);
        }
        let mut at = 0;
        for (r, _) in Self::spans(text) {
            out += &text[at..r.start];
            match names.get(&text[r.clone()]) {
                Some(n) => {
                    out.push('#');
                    out += n;
                }
                None => out += &text[r.clone()],
            }
            at = r.end;
        }
        out += &text[at..];
        out
    }
}
