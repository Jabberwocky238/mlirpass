//! Lowerings given as functions: what `#[patterns]` / `#[lowering]` generate, and the
//! [`ConversionRewriter`] builders they are written with.

use alloc::vec::Vec;

use mlirformat::{Attribute, Error, NamedAttr, Type};

use crate::pass;
use crate::{Body, ConversionPattern, ConversionRewriter, OpData, OpId, TypedOp, ValueId};

/// Something a typed `#[lowering]` reads off the op it lowers (its fast-math flags, ..).
pub(crate) trait FromOp {
    fn from_op(cr: &ConversionRewriter<'_, '_, '_>, op: OpId) -> Self;
}

/// What a typed `#[lowering]` returns: the op's replacement, or failure.
pub trait Replacement {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool;
}

impl Replacement for ValueId {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &[self]);
        true
    }
}

impl Replacement for Option<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        self.is_some_and(|v| v.replace(cr, op))
    }
}

impl Replacement for Vec<ValueId> {
    fn replace(self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId) -> bool {
        cr.replace_values(op, &self);
        true
    }
}

/// A lowering that needs the pass options `O`.
pub struct OptLowering<O> {
    pub root: &'static str,
    pub opts: O,
    pub f: for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>], O) -> bool,
}

impl<O: Copy> ConversionPattern for OptLowering<O> {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands, self.opts)
    }
}

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// Builds `data` with one result of type `ty` at the insertion point; the result.
    pub fn build(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.rw.create(data, &[ty]);
        self.rw.body[o].results[0]
    }

    /// Builds mlirformat's typed op `op` at the insertion point; its first result.
    pub fn emit(&mut self, op: &impl TypedOp) -> ValueId {
        let o = self.rw.emit(op);
        self.rw.body[o].results[0]
    }

    /// The single remapped value of each operand (`getOneToOneAdaptorOperands`).
    pub fn one_to_one(operands: &[Vec<ValueId>]) -> Option<Vec<ValueId>> {
        operands.iter().map(|o| (o.len() == 1).then(|| o[0])).collect()
    }

    /// The op's attributes, inherent and discardable, sorted (`getAttrs()`).
    pub fn all_attrs(&self, op: OpId) -> Vec<NamedAttr<'a>> {
        let d = &self.rw.body[op];
        let mut out: Vec<NamedAttr<'a>> = match &d.properties {
            Some(Attribute::Dict(p)) => p.clone(),
            _ => Vec::new(),
        };
        out.extend(d.attributes.iter().cloned());
        out.sort_by(|a, b| a.name.cmp(&b.name));
        out
    }
}

/// A conversion pattern given as a root, a benefit and a function.
pub struct Lowering {
    pub root: &'static str,
    pub benefit: u16,
    pub f: LowerFn,
}

/// What a [`Lowering`] runs.
pub type LowerFn = for<'r, 'a, 'p> fn(&mut ConversionRewriter<'r, 'a, 'p>, OpId, &[Vec<ValueId>]) -> bool;

impl ConversionPattern for Lowering {
    fn name(&self) -> &str {
        self.root
    }

    fn root(&self) -> Option<&str> {
        Some(self.root)
    }

    fn benefit(&self) -> u16 {
        self.benefit
    }

    fn rewrite(&self, cr: &mut ConversionRewriter<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        (self.f)(cr, op, operands)
    }
}

/// `reconcile-unrealized-casts`.
#[pass("reconcile-unrealized-casts")]
pub fn reconcile_unrealized_casts<'a>(body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
    let casts: Vec<OpId> = body.ops_in(op).into_iter().filter(|o| body[*o].name == "builtin.unrealized_conversion_cast").collect();
    body.reconcile_casts(&casts);
    Ok(())
}

crate::pass_set! {
    /// The dialect conversion framework's own passes.
    ConversionPasses: ReconcileUnrealizedCasts
}
