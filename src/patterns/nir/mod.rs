//! Mesa's NIR algebraic rules on mlirformat's nir dialect (scripts/nir_algebraic.py writes the tables from
//! nir_opt_algebraic.py)
#[path = "algebraic.gen.rs"]
mod algebraic;

use mlirformat::nir::NirBase;

/// A constant of a rule: an integer, a float (its f64 bits, as Mesa writes it) or a boolean
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum NirConst {
    Int(i128),
    Float(u64),
    Bool(bool),
}

/// A node of a rule's search or replace tree, as Mesa's nir_algebraic.py parsed it. `bits`: n bits; -(i + 1):
/// variable i's bit size; 0: the search's (in a replace) or any (in a search).
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum NirPat<'n> {
    Expr {
        op: &'n str,
        bits: i8,
        /// `~op`: only where the instruction is not exact
        inexact: bool,
        /// `!op`: the replacement is exact
        exact: bool,
        ignore_exact: bool,
        nsz: bool,
        nnan: bool,
        ninf: bool,
        contract: bool,
        /// `op(cond)`: a predicate the matched instruction must satisfy
        cond: Option<&'n str>,
        /// `op.x`: the replacement is one component of the result
        swizzle: Option<u8>,
        srcs: &'n [NirPat<'n>],
    },
    Var {
        index: u8,
        /// `#a`: only a constant matches
        constant: bool,
        bits: i8,
        /// `a@type`: the value's type
        ty: Option<NirBase>,
        /// `a(cond)`: a predicate the matched value must satisfy
        cond: Option<&'n str>,
        /// `a.xy`: these components
        swizzle: Option<&'n str>,
    },
    Const {
        value: NirConst,
        bits: i8,
    },
}

/// One rule: replace what matches `search` with `replace` where `condition` (Mesa's C, over the driver's options)
/// holds
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct NirRule<'n> {
    pub search: NirPat<'n>,
    pub replace: NirPat<'n>,
    pub condition: &'n str,
}

/// Mesa's rule tables, one per pass (algebraic.gen.rs)
pub struct NirRules;
