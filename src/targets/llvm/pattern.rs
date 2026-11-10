//! `ConvertOpToLLVMPattern`'s helpers, as `LLVMCommon/Pattern.cpp` and `VectorPattern.cpp`:
//! an op rewritten one to one into an llvm op, n-d vectors unrolled into 1-d ones.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, NamedAttr, Type};

use crate::{ConversionRewriter, OpData, OpId, TypeConverter, ValueId};

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// `packOperationResults`.
    fn pack_results(tc: &TypeConverter<'_>, types: &[Type<'a>]) -> Option<Type<'a>> {
        match types {
            [t] => tc.convert(t),
            ts => {
                let conv = ts.iter().map(|t| tc.convert(t).filter(LlvmType::compatible)).collect::<Option<Vec<_>>>()?;
                Some(LlvmType::literal(conv))
            }
        }
    }

    /// `oneToOneRewrite`: `op` as `target` with the same operands and the attributes given.
    pub fn one_to_one_rewrite(&mut self, op: OpId, target: &str, operands: &[ValueId], attrs: &[NamedAttr<'a>]) -> bool {
        let Some(tc) = self.type_converter() else { return false };
        let types = self.rw.body.types(&self.rw.body[op].results.clone());
        let mut data = OpData::build(target).operands(operands);
        for a in attrs {
            data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
        }
        if types.is_empty() {
            self.rw.create(data, &[]);
            self.erase(op);
            return true;
        }
        let Some(packed) = Self::pack_results(tc, &types) else { return false };
        let n = self.build(data, packed);
        if types.len() == 1 {
            self.replace_values(op, &[n]);
            return true;
        }
        let results: Vec<ValueId> = (0..types.len()).map(|i| self.extract(n, &[i as i64])).collect();
        self.replace_values(op, &results);
        true
    }

    /// `handleMultidimensionalVectors`: the op unrolled over the outer dimensions of an n-d
    /// vector, each 1-d piece built by `make`.
    pub fn unroll_vectors(&mut self, op: OpId, operands: &[ValueId], mut make: impl FnMut(&mut Self, Type<'a>, &[ValueId]) -> ValueId) -> bool {
        let Some(tc) = self.type_converter() else { return false };
        let res_ty = self.rw.body[self.rw.body[op].results[0]].ty.clone();
        let Some(nd) = tc.convert(&res_ty).filter(LlvmType::compatible) else { return false };
        let mut sizes = Vec::new();
        let mut t = nd.clone();
        while let Ok(LlvmType::Array(n, e)) = LlvmType::try_from(&t) {
            sizes.push(n as i64);
            t = *e;
        }
        let one_d = t;
        let mut desc = self.poison(nd);
        let total: i64 = sizes.iter().product();
        for linear in 0..total {
            let mut pos = vec![0i64; sizes.len()];
            let mut rest = linear;
            for (i, s) in sizes.iter().enumerate().rev() {
                pos[i] = rest % s;
                rest /= s;
            }
            let pieces: Vec<ValueId> = operands.iter().map(|v| self.extract(*v, &pos)).collect();
            let v = make(self, one_d.clone(), &pieces);
            desc = self.insert_value(desc, v, &pos);
        }
        self.replace_values(op, &[desc]);
        true
    }

    /// `vectorOneToOneRewrite`.
    pub fn vector_one_to_one(&mut self, op: OpId, target: &str, operands: &[ValueId], attrs: &[NamedAttr<'a>]) -> bool {
        if operands.is_empty() || !operands.iter().all(|v| LlvmType::compatible(&self.rw.body[*v].ty)) {
            return false;
        }
        if !matches!(LlvmType::try_from(&self.rw.body[operands[0]].ty), Ok(LlvmType::Array(..))) {
            return self.one_to_one_rewrite(op, target, operands, attrs);
        }
        let attrs = attrs.to_vec();
        self.unroll_vectors(op, operands, |cr, ty, pieces| {
            let mut data = OpData::build(target).operands(pieces);
            for a in &attrs {
                data.set(&a.name, a.value.clone().unwrap_or(Attribute::Unit));
            }
            cr.build(data, ty)
        })
    }

    /// `getBitWidth` of an int, float or vector type.
    fn value_bits(t: &Type<'_>) -> u32 {
        match t {
            Type::Shaped(s) => s.dims().unwrap_or_default().iter().product::<i64>() as u32 * s.elem.bit_width().unwrap_or(0),
            t => t.bit_width().unwrap_or(0),
        }
    }

    fn i32_const(&mut self, v: i64) -> ValueId {
        self.llvm_constant(Attribute::of_int(v.into(), Type::int(32)), Type::int(32))
    }

    /// An int, float or vector type: what has a fixed bit width.
    fn sized_leaf(t: &Type<'_>) -> bool {
        matches!(t, Type::Integer { .. } | Type::Float(_)) || matches!(t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Vector)
    }

    /// The fields of an LLVM array or struct type.
    fn aggregate_fields<'t>(t: &Type<'t>) -> Option<Vec<Type<'t>>> {
        match LlvmType::try_from(t).ok()? {
            LlvmType::Array(n, e) => Some(vec![(*e).clone(); n as usize]),
            LlvmType::Struct { body: Some(body), .. } => Some(body),
            _ => None,
        }
    }

    /// `isFixedSizeAggregate`: every leaf of `t` is `dst` or has a fixed bit width.
    fn fixed_size_aggregate(t: &Type<'_>, dst: &Type<'_>) -> bool {
        if t == dst {
            return true;
        }
        match Self::aggregate_fields(t) {
            Some(fields) => fields.iter().all(|f| Self::fixed_size_aggregate(f, dst)),
            None => Self::sized_leaf(t),
        }
    }

    /// `LLVM::decomposeValue`: `src` as values of `dst` (aggregates field by field; leaves
    /// bitcast, zero-extended, or split through a vector); `None` when a leaf has no fixed size
    /// and `variable` does not let it through as it is.
    pub fn decompose(&mut self, src: ValueId, dst: Type<'a>, variable: bool) -> Option<Vec<ValueId>> {
        if !variable && !Self::fixed_size_aggregate(&self.rw.body[src].ty.clone(), &dst) {
            return None;
        }
        let mut out = Vec::new();
        self.decompose_into(src, &dst, &mut out);
        Some(out)
    }

    fn decompose_into(&mut self, src: ValueId, dst: &Type<'a>, out: &mut Vec<ValueId>) {
        let st = self.rw.body[src].ty.clone();
        if st == *dst {
            out.push(src);
            return;
        }
        if let Some(fields) = Self::aggregate_fields(&st) {
            for (i, f) in fields.into_iter().enumerate() {
                let e = self.build(OpData::build("llvm.extractvalue").operands(&[src]).with("position", Attribute::dense_i64(&[i as i64])), f);
                self.decompose_into(e, dst, out);
            }
            return;
        }
        if !Self::sized_leaf(&st) {
            out.push(src);
            return;
        }
        let (sb, db) = (Self::value_bits(&st), Self::value_bits(dst));
        if sb == db {
            out.push(self.build(OpData::build("llvm.bitcast").operands(&[src]), dst.clone()));
            return;
        }
        if db > sb {
            let mut v = src;
            if st != Type::int(sb) {
                v = self.build(OpData::build("llvm.bitcast").operands(&[v]), Type::int(sb));
            }
            out.push(self.build(OpData::build("llvm.zext").operands(&[v]), Type::int(db)));
            return;
        }
        let n = i64::from(sb.div_ceil(db));
        let rounded = n as u32 * db;
        let mut v = src;
        // (padded out when it does not split evenly)
        if rounded != sb {
            if st != Type::int(sb) {
                v = self.build(OpData::build("llvm.bitcast").operands(&[v]), Type::int(sb));
            }
            v = self.build(OpData::build("llvm.zext").operands(&[v]), Type::int(rounded));
        }
        let vt = Type::vector(&[n], &[], dst.clone());
        let v = self.build(OpData::build("llvm.bitcast").operands(&[v]), vt);
        for i in 0..n {
            let idx = self.i32_const(i);
            out.push(self.build(OpData::build("llvm.extractelement").operands(&[v, idx]), dst.clone()));
        }
    }

    /// `LLVM::composeValue`: the inverse of [`decompose`](Self::decompose).
    pub fn compose(&mut self, src: &[ValueId], dst: Type<'a>) -> ValueId {
        let mut at = 0;
        self.compose_from(src, &mut at, &dst)
    }

    fn compose_from(&mut self, src: &[ValueId], at: &mut usize, dst: &Type<'a>) -> ValueId {
        if let Some(fields) = Self::aggregate_fields(dst) {
            let mut r = self.poison(dst.clone());
            for (i, f) in fields.iter().enumerate() {
                let v = self.compose_from(src, at, f);
                r = self.build(OpData::build("llvm.insertvalue").operands(&[r, v]).with("position", Attribute::dense_i64(&[i as i64])), dst.clone());
            }
            return r;
        }
        if !Self::sized_leaf(dst) {
            *at += 1;
            return src[*at - 1];
        }
        let db = Self::value_bits(dst);
        let front = src[*at];
        let ft = self.rw.body[front].ty.clone();
        if ft == *dst {
            *at += 1;
            return front;
        }
        if Self::sized_leaf(&ft) && Self::value_bits(&ft) >= db {
            *at += 1;
            let sb = Self::value_bits(&ft);
            let mut r = front;
            if db < sb {
                if ft != Type::int(sb) {
                    r = self.build(OpData::build("llvm.bitcast").operands(&[r]), Type::int(sb));
                }
                r = self.build(OpData::build("llvm.trunc").operands(&[r]), Type::int(db));
            }
            if self.rw.body[r].ty != *dst {
                r = self.build(OpData::build("llvm.bitcast").operands(&[r]), dst.clone());
            }
            return r;
        }
        let eb = Self::value_bits(&ft);
        let n = i64::from(db.div_ceil(eb));
        let rounded = n as u32 * eb;
        let vt = Type::vector(&[n], &[], ft);
        let mut r = self.poison(vt.clone());
        for i in 0..n {
            let idx = self.i32_const(i);
            r = self.build(OpData::build("llvm.insertelement").operands(&[r, src[*at], idx]), vt.clone());
            *at += 1;
        }
        // (the padding of the decomposition undone)
        if rounded != db {
            r = self.build(OpData::build("llvm.bitcast").operands(&[r]), Type::int(rounded));
            r = self.build(OpData::build("llvm.trunc").operands(&[r]), Type::int(db));
            if Type::int(db) != *dst {
                r = self.build(OpData::build("llvm.bitcast").operands(&[r]), dst.clone());
            }
        } else if vt != *dst {
            r = self.build(OpData::build("llvm.bitcast").operands(&[r]), dst.clone());
        }
        r
    }
}
