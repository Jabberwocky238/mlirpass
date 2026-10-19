//! Symbols and symbol tables, as `mlir/IR/SymbolTable.cpp`.

use alloc::vec::Vec;

use mlirformat::{Attribute, Str};

use crate::{Body, OpId, OpInfo, Trait};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Visibility {
    Public,
    Private,
    Nested,
}

/// One symbol reference held by an op: `@a::@b` as `["@a", "@b"]` segments without the `@`.
#[derive(Debug, Clone, PartialEq)]
pub struct SymbolUse<'a> {
    pub user: OpId,
    pub path: Vec<Str<'a>>,
}

impl<'a> Body<'a> {
    /// `op`'s symbol name, when it is a symbol (and has one: a module may not).
    pub fn sym_name(&self, op: OpId) -> Option<&str> {
        self.has(op, Trait::SymbolOpInterface).then(|| self[op].get_str("sym_name")).flatten()
    }

    pub fn visibility(&self, op: OpId) -> Visibility {
        match self[op].get_str("sym_visibility") {
            Some("private") => Visibility::Private,
            Some("nested") => Visibility::Nested,
            _ => Visibility::Public,
        }
    }

    pub fn set_visibility(&mut self, op: OpId, v: Visibility) {
        let lit = match v {
            Visibility::Public => {
                self[op].remove("sym_visibility");
                return;
            }
            Visibility::Private => "private",
            Visibility::Nested => "nested",
        };
        self[op].set("sym_visibility", Attribute::Str { lit: lit.into(), ty: None });
    }

    /// Whether `op` defines a symbol table.
    pub fn is_symbol_table(&self, op: OpId) -> bool {
        self.has(op, Trait::SymbolTable)
    }

    /// An op that may be a symbol table nobody can tell about: one region, dialect unknown.
    pub fn maybe_unknown_symbol_table(&self, op: OpId) -> bool {
        self[op].regions.len() == 1 && !OpInfo::knows_dialect(&self[op].name)
    }

    /// The symbol named `name` directly in symbol table `table`.
    pub fn lookup(&self, table: OpId, name: &str) -> Option<OpId> {
        let region = *self[table].regions.first()?;
        self[region].blocks.iter().flat_map(|b| &self[*b].ops).copied().find(|o| self.sym_name(*o) == Some(name))
    }

    /// Every symbol along `path` from `table` (`@a::@b`: `a`, then `b` inside it); `None` when
    /// a segment is missing.
    pub fn lookup_path(&self, table: OpId, path: &[Str<'_>]) -> Option<Vec<OpId>> {
        let mut out = Vec::new();
        let mut at = table;
        for seg in path {
            at = self.lookup(at, Self::unquote(seg))?;
            out.push(at);
        }
        Some(out)
    }

    /// `"name"` ⇒ `name`; symbol references keep their quotes when they need them.
    fn unquote(s: &str) -> &str {
        s.strip_prefix('"').and_then(|s| s.strip_suffix('"')).unwrap_or(s)
    }

    fn refs_in(a: &Attribute<'a>, user: OpId, out: &mut Vec<SymbolUse<'a>>) {
        match a {
            Attribute::SymbolRef(path) => out.push(SymbolUse { user, path: path.clone() }),
            Attribute::Array(xs) => xs.iter().for_each(|x| Self::refs_in(x, user, out)),
            Attribute::Dict(d) => d.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::refs_in(x, user, out)),
            _ => {}
        }
    }

    /// The symbol references `op` itself holds, inherent and discardable alike.
    fn own_refs(&self, op: OpId, out: &mut Vec<SymbolUse<'a>>) {
        let d = &self[op];
        d.properties.iter().for_each(|p| Self::refs_in(p, op, out));
        d.attributes.iter().filter_map(|n| n.value.as_ref()).for_each(|x| Self::refs_in(x, op, out));
    }

    /// Uses nested in `regions` of `op`, not entering nested symbol tables; `None` on a
    /// potentially unknown symbol table.
    fn region_refs(&self, op: OpId, out: &mut Vec<SymbolUse<'a>>) -> Option<()> {
        let mut work: Vec<_> = self[op].regions.clone();
        while let Some(r) = work.pop() {
            for o in self[r].blocks.iter().flat_map(|b| &self[*b].ops) {
                if self.maybe_unknown_symbol_table(*o) {
                    return None;
                }
                self.own_refs(*o, out);
                if !self.is_symbol_table(*o) {
                    work.extend(self[*o].regions.iter().copied());
                }
            }
        }
        Some(())
    }

    /// ⭐ `SymbolTable::getSymbolUses(op)`: the references on `op` and nested in it, not entering
    /// nested symbol tables; `None` when an op might be an unknown symbol table.
    pub fn symbol_uses(&self, op: OpId) -> Option<Vec<SymbolUse<'a>>> {
        if self.maybe_unknown_symbol_table(op) {
            return None;
        }
        let mut out = Vec::new();
        self.own_refs(op, &mut out);
        if !self.is_symbol_table(op) {
            self.region_refs(op, &mut out)?;
        }
        Some(out)
    }
}

impl OpInfo {
    /// Whether `op`'s dialect is registered in `mlir-opt` (its ops may still be unregistered).
    pub fn knows_dialect(op: &str) -> bool {
        op.split_once('.').is_some_and(|(ns, _)| crate::DIALECTS.contains(&ns))
    }
}
