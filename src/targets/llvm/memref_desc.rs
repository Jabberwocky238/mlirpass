use alloc::vec::Vec;

use mlirformat::{Attribute, Dim, Shaped, Type};

use crate::{ConversionRewriter, Listener, LlvmOptions, MemrefLayout, OpData, Rewriter, ValueId};

impl<'a> ConversionRewriter<'_, 'a, '_> {
    pub fn index_const(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        self.rw.index_const(ty, v)
    }

    pub fn pack_desc(&mut self, desc_ty: Type<'a>, rank: usize, fields: &[ValueId]) -> ValueId {
        self.rw.pack_desc(desc_ty, rank, fields)
    }

    pub fn unpack_desc(&mut self, desc: ValueId, rank: usize) -> Vec<ValueId> {
        let mut out = Vec::new();
        for p in [0, 1, 2] {
            out.push(self.extract(desc, &[p]));
        }
        for i in 0..rank as i64 {
            out.push(self.extract(desc, &[3, i]));
        }
        for i in 0..rank as i64 {
            out.push(self.extract(desc, &[4, i]));
        }
        out
    }

    pub fn desc_from_static(&mut self, opts: LlvmOptions, s: &Shaped<'a>, desc_ty: Type<'a>, ptr: ValueId, aligned: ValueId) -> Option<ValueId> {
        self.rw.desc_from_static(opts, s, desc_ty, ptr, aligned)
    }
}

impl<'r, 'a, L: Listener<'a> + ?Sized> Rewriter<'r, 'a, L> {
    fn value(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }

    fn insert_at(&mut self, agg: ValueId, v: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.body[agg].ty.clone();
        let p = Attribute::dense_i64(&pos);
        self.value(OpData::build("llvm.insertvalue").operands(&[agg, v]).with("position", p), ty)
    }

    pub fn index_const(&mut self, ty: &Type<'a>, v: i64) -> ValueId {
        let value = Attribute::index(v);
        self.value(OpData::build("llvm.mlir.constant").with("value", value), ty.clone())
    }

    pub fn pack_desc(&mut self, desc_ty: Type<'a>, rank: usize, fields: &[ValueId]) -> ValueId {
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        for p in [0, 1, 2] {
            d = self.insert_at(d, fields[p], &[p as i64]);
        }
        for i in 0..rank {
            d = self.insert_at(d, fields[3 + i], &[3, i as i64]);
            d = self.insert_at(d, fields[3 + rank + i], &[4, i as i64]);
        }
        d
    }

    pub fn pack_unranked(&mut self, desc_ty: Type<'a>, fields: &[ValueId]) -> ValueId {
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        d = self.insert_at(d, fields[0], &[0]);
        self.insert_at(d, fields[1], &[1])
    }

    pub fn desc_from_static(&mut self, opts: LlvmOptions, s: &Shaped<'a>, desc_ty: Type<'a>, ptr: ValueId, aligned: ValueId) -> Option<ValueId> {
        let (strides, offset) = s.strides_and_offset()?;
        let idx = opts.index();
        let mut d = self.value(OpData::build("llvm.mlir.poison"), desc_ty);
        d = self.insert_at(d, ptr, &[0]);
        d = self.insert_at(d, aligned, &[1]);
        let o = self.index_const(&idx, offset);
        d = self.insert_at(d, o, &[2]);
        for (i, dim) in s.shape.as_ref()?.iter().enumerate() {
            let Dim::Static(n) = dim else { return None };
            let size = self.index_const(&idx, *n);
            d = self.insert_at(d, size, &[3, i as i64]);
            let st = self.index_const(&idx, strides[i]);
            d = self.insert_at(d, st, &[4, i as i64]);
        }
        Some(d)
    }
}
