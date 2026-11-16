use alloc::vec;
use alloc::vec::Vec;

use mlirformat::Type;

use crate::{ConversionRewriter, OpId, ValueId};

impl ConversionRewriter<'_, '_, '_> {
    pub(super) fn lane_positions(&self, op: OpId, name: &str) -> Option<Vec<usize>> {
        self.rw.body[op].get(name)?.dense_values().map(|v| v.into_iter().map(|i| i as usize).collect())
    }

    pub(super) fn lane_position(&self, op: OpId) -> Option<usize> {
        match self.lane_positions(op, "static_position")?[..] {
            [at] => Some(at),
            _ => None,
        }
    }

    pub(super) fn lanes_each(&mut self, op: OpId, o: &[Vec<ValueId>], mut f: impl FnMut(&mut Self, &[ValueId]) -> ValueId) -> bool {
        let n = o[0].len();
        if o.iter().any(|v| v.len() != n) {
            return false;
        }
        let values: Vec<ValueId> = (0..n).map(|i| f(self, &o.iter().map(|v| v[i]).collect::<Vec<_>>())).collect();
        self.replace(op, vec![values]);
        true
    }

    #[cfg(any(feature = "target.rdna2", feature = "target.agx", feature = "target.apple9"))]
    pub(super) fn lanes_same(&mut self, op: OpId, o: &[Vec<ValueId>], lanes: fn(&Type<'_>) -> Option<usize>) -> bool {
        let r = self.rw.body[op].results[0];
        if lanes(&self.rw.body[r].ty) != Some(o[0].len()) {
            return false;
        }
        self.replace(op, vec![o[0].clone()]);
        true
    }

    pub(super) fn lanes_extract(&mut self, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(v) = self.lane_position(op).and_then(|at| o[0].get(at)).copied() else { return false };
        self.replace(op, vec![vec![v]]);
        true
    }

    pub(super) fn lanes_insert(&mut self, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(at) = self.lane_position(op) else { return false };
        let ([v], Some(dest)) = (&o[0][..], o.get(1)) else { return false };
        if at >= dest.len() {
            return false;
        }
        let mut dest = dest.clone();
        dest[at] = *v;
        self.replace(op, vec![dest]);
        true
    }

    pub(super) fn lanes_from_elements(&mut self, op: OpId, o: &[Vec<ValueId>]) -> bool {
        self.replace(op, vec![o.concat()]);
        true
    }

    pub(super) fn lanes_broadcast(&mut self, op: OpId, o: &[Vec<ValueId>], lanes: fn(&Type<'_>) -> Option<usize>) -> bool {
        let r = self.rw.body[op].results[0];
        let (Some(n), [v]) = (lanes(&self.rw.body[r].ty), &o[0][..]) else { return false };
        self.replace(op, vec![vec![*v; n]]);
        true
    }

    pub(super) fn lanes_shuffle(&mut self, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(mask) = self.lane_positions(op, "mask") else { return false };
        let all = o.concat();
        let Some(values) = mask.iter().map(|i| all.get(*i).copied()).collect::<Option<Vec<_>>>() else { return false };
        self.replace(op, vec![values]);
        true
    }
}
