//! What the ops with offsets, sizes and strides share (`OffsetSizeAndStrideOpInterface`,
//! `ViewLikeInterface.cpp`): their mixed static / dynamic lists, folding them, and bounds.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Dim, Type};

use crate::{Body, MemrefOfr as Ofr, OpData, OpId, ValueId};

impl Ofr {
    /// `verifyInBoundsSlice`.
    pub fn in_bounds(shape: &[i64], offsets: &[Ofr], sizes: &[Ofr], strides: &[Ofr]) -> bool {
        let st = |o: &Ofr| if let Ofr::C(c) = o { *c } else { Dim::DYNAMIC };
        for (i, s) in shape.iter().enumerate() {
            let (Some(o), Some(z), Some(t)) = (offsets.get(i).map(st), sizes.get(i).map(st), strides.get(i).map(st)) else { continue };
            if *s == Dim::DYNAMIC || o == Dim::DYNAMIC {
                continue;
            }
            if o >= *s {
                return false;
            }
            if z == Dim::DYNAMIC || t == Dim::DYNAMIC {
                continue;
            }
            if o + (z - 1) * t >= *s {
                return false;
            }
        }
        true
    }

    /// `foldDynamicIndexList`.
    pub fn fold_list(b: &Body<'_>, list: &mut [Ofr], non_negative: bool, non_zero: bool) -> bool {
        let mut changed = false;
        for o in list.iter_mut() {
            let Ofr::V(v) = *o else { continue };
            let Some(c) = b.const_index(v) else { continue };
            if (non_negative && c < 0) || (non_zero && c == 0) {
                continue;
            }
            *o = Ofr::C(c);
            changed = true;
        }
        changed
    }

    /// Mixed values as static values and the dynamic ones.
    pub(crate) fn split(list: &[Ofr]) -> (Vec<i64>, Vec<ValueId>) {
        let mut st = Vec::new();
        let mut dy = Vec::new();
        for o in list {
            match o {
                Ofr::C(c) => st.push(*c),
                Ofr::V(v) => {
                    st.push(Dim::DYNAMIC);
                    dy.push(*v);
                }
            }
        }
        (st, dy)
    }
}

impl Ofr {
    /// `getMixedValues`: `statics`, each dynamic one taken in turn from `dynamic`.
    pub fn mixed(statics: &[i64], dynamic: &[ValueId]) -> Vec<Ofr> {
        let mut d = dynamic.iter();
        statics.iter().map(|s| if *s == Dim::DYNAMIC { d.next().map_or(Ofr::C(Dim::DYNAMIC), |v| Ofr::V(*v)) } else { Ofr::C(*s) }).collect()
    }
}

impl<'a> OpData<'a> {
    /// An op with leading operands and mixed lists stored as `names`.
    pub(crate) fn mixed(name: &str, lead: &[ValueId], lists: &[&[Ofr]], names: &[&str]) -> Self {
        let mut ops = lead.to_vec();
        let mut segs = vec![1usize; lead.len()];
        let mut data = OpData::build(name);
        for (l, n) in lists.iter().zip(names) {
            let (st, dy) = Ofr::split(l);
            segs.push(dy.len());
            ops.extend(dy);
            data.set(n, Attribute::dense_i64(&st));
        }
        data.operands(&ops).segments(&segs)
    }

    pub fn sliced(name: &str, lead: &[ValueId], l: &[Vec<Ofr>; 3]) -> Self {
        OpData::mixed(name, lead, &[&l[0], &l[1], &l[2]], &["static_offsets", "static_sizes", "static_strides"])
    }
}

impl Body<'_> {
    /// The offsets, sizes and strides of a slice op, after its leading operands.
    pub fn slice_lists(&self, op: OpId) -> [Vec<Ofr>; 3] {
        let segs = self.segments(op, "operandSegmentSizes").unwrap_or_default();
        let lead = segs.len().saturating_sub(3);
        let mut at: usize = segs[..lead].iter().sum();
        let mut out: [Vec<Ofr>; 3] = Default::default();
        for (k, name) in ["static_offsets", "static_sizes", "static_strides"].iter().enumerate() {
            let n = segs.get(lead + k).copied().unwrap_or(0);
            let mut d = self[op].operands[at..at + n].iter();
            out[k] = self.dense_i64(op, name).into_iter().map(|s| if s == Dim::DYNAMIC { Ofr::V(*d.next().expect("dynamic")) } else { Ofr::C(s) }).collect();
            at += n;
        }
        out
    }
}

impl crate::Rewriter<'_, '_> {
    /// `getValueOrCreateConstantIndexOp`.
    pub fn value_of(&mut self, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::C(c) => {
                let k = self.emit(&arith::Constant::new(Attribute::index(c), Type::Index));
                self.body[k].results[0]
            }
        }
    }

    /// `createOrFoldDimOp`: `tensor.dim` (`memref.dim` of a memref) of `v` at `i`, its index a
    /// constant built first (`DimOp::build`), folded.
    pub fn fold_dim(&mut self, v: ValueId, i: usize) -> ValueId {
        let k = self.value_of(Ofr::C(i as i64));
        let name = if self.body.is_memref(v) { "memref.dim" } else { "tensor.dim" };
        self.create_or_fold(OpData::build(name).operands(&[v, k]), &[Type::Index])[0]
    }

    /// `getMixedSize` (`createFoldedDimOp`): size `i` of `v`, static or its folded dim.
    pub fn mixed_size(&mut self, v: ValueId, i: usize) -> Ofr {
        match self.body[v].ty.dims().unwrap_or_default().get(i) {
            Some(d) if *d != Dim::DYNAMIC => Ofr::C(*d),
            _ => Ofr::V(self.fold_dim(v, i)),
        }
    }

    /// `getMixedSizes`.
    pub fn mixed_sizes(&mut self, v: ValueId) -> Vec<Ofr> {
        (0..self.body[v].ty.dims().unwrap_or_default().len()).map(|i| self.mixed_size(v, i)).collect()
    }

    /// `reifyDimOfResult` of `op`, through its dialect's
    /// [`OpInterfaces::reify_dim`](crate::OpInterfaces::reify_dim).
    pub fn reify_dim(&mut self, op: OpId, result: usize, dim: usize) -> Option<Ofr> {
        let i = self.body.ctx.interfaces.of(&self.body[op].name)?;
        i.reify_dim(self, op, result, dim)
    }
}
