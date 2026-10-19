//! `symbol-dce`: erases the symbols nothing live can reach, as `SymbolDCE.cpp`.

use alloc::collections::BTreeSet;
use alloc::format;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{Body, OpId, Options, Pass, Trait, Visibility};

pub struct SymbolDce;

impl TryFrom<&Options<'_>> for SymbolDce {
    type Error = Error;
    fn try_from(o: &Options<'_>) -> Result<Self, Error> {
        o.only("symbol-dce", &[])?;
        Ok(Self)
    }
}

impl Pass for SymbolDce {
    fn name(&self) -> &str {
        "symbol-dce"
    }

    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        if !body.is_symbol_table(op) {
            return Err(Error(format!("'{}' op  was scheduled to run under SymbolDCE, but does not define a symbol table", body[op].name)));
        }
        // A top-level table is hidden; one nested in the IR only when it is a private symbol.
        let hidden = body.parent_op(op).is_none() || !body.has(op, Trait::SymbolOpInterface) || body.visibility(op) == Visibility::Private;
        let mut live = BTreeSet::new();
        body.liveness(op, hidden, &mut live)?;
        let tables: Vec<_> = body.ops_in(op).into_iter().filter(|o| body.is_symbol_table(*o)).collect();
        for table in tables {
            let Some(region) = body[table].regions.first().copied() else { continue };
            let dead: Vec<_> = body[region].blocks.iter().flat_map(|b| &body[*b].ops).copied().filter(|o| body.has(*o, Trait::SymbolOpInterface) && !live.contains(o)).collect();
            dead.into_iter().for_each(|o| body.erase(o));
        }
        Ok(())
    }
}

impl Body<'_> {
    /// `SymbolDCE::computeLiveness`: the symbols of `table` (and the tables nested in it) that
    /// are live. `hidden`: no parent scope can see into `table`.
    fn liveness(&self, table: OpId, hidden: bool, live: &mut BTreeSet<OpId>) -> Result<(), Error> {
        let mut work = Vec::new();
        let region = self[table].regions[0];
        for op in self[region].blocks.iter().flat_map(|b| &self[*b].ops).copied() {
            if !self.has(op, Trait::SymbolOpInterface) {
                work.push(op);
                continue;
            }
            // `canDiscardOnUseEmpty` defaults to «not public»; no upstream symbol overrides it.
            let vis = self.visibility(op);
            let discardable = (hidden || vis == Visibility::Private) && vis != Visibility::Public;
            if !discardable && live.insert(op) {
                work.push(op);
            }
        }
        while let Some(op) = work.pop() {
            if self.is_symbol_table(op) {
                let inner = hidden || !self.has(op, Trait::SymbolOpInterface) || self.visibility(op) == Visibility::Private;
                self.liveness(op, inner, live)?;
            } else {
                // Uses inside a non-table op count as if they were at the top level.
                work.extend(self.children(op).into_iter().filter(|o| !self[*o].regions.is_empty()));
            }
            let Some(parent) = self.parent_op(op).filter(|p| self.is_symbol_table(*p)) else { continue };
            let uses = self.symbol_uses(op).ok_or_else(|| Error(format!("'{}' op operation contains potentially unknown symbol table, meaning that we can't reliable compute symbol uses", self[op].name)))?;
            for u in uses {
                for sym in self.lookup_path(parent, &u.path).unwrap_or_default() {
                    if live.insert(sym) {
                        work.push(sym);
                    }
                }
            }
        }
        Ok(())
    }
}
