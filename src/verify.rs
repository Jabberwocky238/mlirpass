//! ⭐ What `mlir-opt` verifies after each pass, as far as passes can break it: branch operand
//! types (`BranchOpInterface`) and affine dimension / symbol identifiers (whose validity
//! depends on the enclosing `AffineScope`, which a lowering may change).

use alloc::format;
use alloc::string::String;

use mlirformat::Error;

use crate::{Body, OpId, ValueId};

impl Body<'_> {
    /// ⭐ The verifiers over everything in `root`.
    pub fn verify(&self, root: OpId) -> Result<(), Error> {
        self.verify_branches(root)?;
        for op in self.ops_in(root) {
            self.verify_affine(op)?;
        }
        Ok(())
    }

    /// `verifyDimAndSymbolIdentifiers`.
    fn verify_identifiers(&self, op: OpId, operands: &[ValueId], dims: usize) -> Result<(), Error> {
        let scope = self.affine_scope(op);
        for (i, v) in operands.iter().enumerate() {
            if i < dims && !self.is_valid_dim_in(*v, scope) {
                return Err(Error(format!("'{}' op operand cannot be used as a dimension id", self[op].name)));
            }
            if i >= dims && !self.is_valid_symbol_in(*v, scope) {
                return Err(Error(format!("'{}' op operand cannot be used as a symbol", self[op].name)));
            }
        }
        Ok(())
    }

    /// The affine ops' identifier checks (`verifyMemoryOpIndexing`, `AffineForOp::verify`,
    /// `AffineIfOp::verify`, `AffineApplyOp::verify`).
    fn verify_affine(&self, op: OpId) -> Result<(), Error> {
        let d = &self[op];
        let dims = |name: &str| self.affine_map(op, name).map_or(0, |m| m.dims as usize);
        match &*d.name {
            "affine.load" | "affine.vector_load" => self.verify_identifiers(op, &d.operands[1..], dims("map")),
            "affine.store" | "affine.vector_store" => self.verify_identifiers(op, &d.operands[2..], dims("map")),
            "affine.if" => self.verify_identifiers(op, &d.operands, self.integer_set(op, "condition").map_or(0, |s| s.dims as usize)),
            "affine.for" => {
                let Some(sizes) = self.segments(op, "operandSegmentSizes") else { return Ok(()) };
                let (lb, ub) = (&d.operands[..sizes[0]], &d.operands[sizes[0]..sizes[0] + sizes[1]]);
                self.verify_identifiers(op, lb, dims("lowerBoundMap"))?;
                self.verify_identifiers(op, ub, dims("upperBoundMap"))
            }
            "affine.apply" => {
                let scope = self.affine_scope(op);
                let misplaced = d.operands.iter().skip(dims("map")).any(|v| self.is_valid_dim_in(*v, scope) && !self.is_valid_symbol_in(*v, scope));
                if misplaced { Err(Error(String::from("'affine.apply' op dimensional operand cannot be used as a symbol"))) } else { Ok(()) }
            }
            _ => Ok(()),
        }
    }
}
