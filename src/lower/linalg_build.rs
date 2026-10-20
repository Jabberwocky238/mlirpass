//! Builders of `linalg` structured ops for the lowerings that create them: the ops with their
//! regions (`RegionBuilderHelper` and the OpDSL bodies of the named ops), `linalg.generic`,
//! and the tensor ops around them.

use alloc::borrow::Cow;
use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{arith, Attribute, Dim, Shaped, ShapedKind, Type};

use super::vector_transforms::{dense_i64, index_attr};
use crate::canon::{AttrExt, MemrefOfr as Ofr, map_attr};
use crate::{AffineMap, ConversionRewriter, DYNAMIC, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The bodies of the named structured ops (OpDSL assignments).
#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Named {
    /// `linalg.fill`: `O = cast(value)`.
    Fill,
    /// `O = I` (`linalg.transpose`, `linalg.copy`).
    Copy,
    /// `O += cast(I) * cast(K)`.
    MulAdd,
    /// `O += (cast(I) - cast(IZp)) * (cast(K) - cast(KZp))`.
    MulAddZp,
    /// `O = max_signed(O, cast(I))`.
    MaxS,
    /// `O = max_unsigned(O, cast_unsigned(I))`.
    MaxU,
    /// `O = O + cast(I)`.
    Sum,
}

/// `BinaryFn`.
#[derive(Clone, Copy)]
pub enum Bin {
    Add,
    Sub,
    Mul,
    MaxS,
    MaxU,
}

/// Static and dynamic sizes as `tensor.empty` / `tensor::getMixedSizes` take them.
pub fn tensor_type<'a>(dims: &[i64], elem: Type<'a>) -> Type<'a> {
    let shape = dims.iter().map(|d| if *d == DYNAMIC { Dim::Dynamic } else { Dim::Static(*d) }).collect();
    Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(shape), elem: elem.into(), extras: Vec::new() })
}

pub fn dims_of(t: &Type<'_>) -> Vec<i64> {
    crate::attr::shape_of(t).map_or_else(Vec::new, |d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
}

/// `#linalg.iterator_type<...>` values.
pub fn iterators<'a>(kinds: &[bool]) -> Attribute<'a> {
    Attribute::Array(kinds.iter().map(|par| Attribute::dialect("linalg.iterator_type", if *par { "<parallel>" } else { "<reduction>" })).collect())
}

/// `dense<v> : tensor<Nxi64>` (`getI64TensorAttr`) or `vector<Nxi64>` (`getI64VectorAttr`).
pub fn i64_elements<'a>(v: &[i64], vector: bool) -> Attribute<'a> {
    let kind = if vector { ShapedKind::Vector } else { ShapedKind::Tensor };
    let ty = Type::Shaped(Shaped { kind, shape: Some(vec![Dim::Static(v.len() as i64)]), elem: Type::int(64).into(), extras: Vec::new() });
    let values = v.iter().map(|x| crate::Scalar::Int(crate::ApInt::new(64, i128::from(*x)))).collect();
    crate::Const { ty, values, elements: true }.into()
}

impl<'a> Cr<'_, 'a, '_> {
    pub fn cidx(&mut self, v: i64) -> ValueId {
        self.emit(&arith::Constant::new(index_attr(v), Type::Index))
    }

    pub fn constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        self.emit(&arith::Constant::new(value, ty))
    }

    pub fn op1(&mut self, name: &str, ops: &[ValueId], ty: Type<'a>) -> ValueId {
        self.build(OpData::build(name).operands(ops), ty)
    }

    /// A binary op typed as its first operand.
    pub fn bin(&mut self, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.rw.body[a].ty.clone();
        self.op1(name, &[a, b], ty)
    }

    /// `tensor.dim %v, i` (built, not folded).
    pub fn tdim(&mut self, v: ValueId, i: i64) -> ValueId {
        let k = self.cidx(i);
        self.op1("tensor.dim", &[v, k], Type::Index)
    }

    /// `tensor.empty` of static `dims` (dynamic ones from `dynamic`).
    pub fn empty(&mut self, dims: &[i64], elem: Type<'a>, dynamic: &[ValueId]) -> ValueId {
        self.op1("tensor.empty", dynamic, tensor_type(dims, elem))
    }

    /// `tensor.empty` of mixed sizes.
    pub fn empty_mixed(&mut self, sizes: &[Ofr], elem: Type<'a>) -> ValueId {
        let dims: Vec<i64> = sizes.iter().map(|s| if let Ofr::C(c) = s { *c } else { DYNAMIC }).collect();
        let dynamic: Vec<ValueId> = sizes.iter().filter_map(|s| if let Ofr::V(v) = s { Some(*v) } else { None }).collect();
        self.empty(&dims, elem, &dynamic)
    }

    /// `tensor::getMixedSizes` (dynamic sizes by a folded `tensor.dim`).
    pub fn mixed_sizes(&mut self, v: ValueId) -> Vec<Ofr> {
        (0..dims_of(&self.rw.body[v].ty).len()).map(|i| self.mixed_size(v, i)).collect()
    }

    /// `tensor::getMixedSize`.
    pub fn mixed_size(&mut self, v: ValueId, i: usize) -> Ofr {
        let d = dims_of(&self.rw.body[v].ty)[i];
        if d != DYNAMIC {
            return Ofr::C(d);
        }
        let k = self.cidx(i as i64);
        let r = self.rw.create_or_fold(OpData::build("tensor.dim").operands(&[v, k]), &[Type::Index])[0];
        self.rw.body.ofr_int(Ofr::V(r)).map_or(Ofr::V(r), Ofr::C)
    }

    /// A structured op with a region whose block takes each operand's element type, filled by
    /// `body` (which returns what `linalg.yield` yields).
    pub fn structured(&mut self, name: &str, inputs: &[ValueId], outputs: &[ValueId], results: &[Type<'a>], props: Vec<(&str, Attribute<'a>)>, body: &mut dyn FnMut(&mut Self, &[ValueId]) -> Vec<ValueId>) -> OpId {
        let mut ops = inputs.to_vec();
        ops.extend(outputs);
        let mut data = OpData::build(name).operands(&ops);
        if name != "linalg.transpose" && name != "linalg.broadcast" && name != "linalg.reduce" {
            data = data.segments(&[inputs.len(), outputs.len()]);
        }
        for (k, v) in props {
            data.set(k, v);
        }
        let args: Vec<(Type<'a>, Option<_>)> = ops.iter().map(|v| (crate::attr::element_type(&self.rw.body[*v].ty).clone(), None)).collect();
        let op = self.rw.create_with(data, results, |b, o| {
            let r = b.add_region(o);
            b.add_block(r, &args);
        });
        let block = self.rw.body.top_block(op);
        let saved = self.rw.ip;
        self.rw.set_end(block);
        let a = self.rw.body[block].args.clone();
        let y = body(self, &a);
        self.rw.create(OpData::build("linalg.yield").operands(&y), &[]);
        self.rw.ip = saved;
        op
    }

    /// `linalg.generic` with all-parallel or given iterators.
    pub fn generic(&mut self, results: &[Type<'a>], inputs: &[ValueId], outputs: &[ValueId], maps: &[AffineMap], iters: &[bool], body: &mut dyn FnMut(&mut Self, &[ValueId]) -> Vec<ValueId>) -> OpId {
        let props = vec![("indexing_maps", Attribute::Array(maps.iter().map(map_attr).collect())), ("iterator_types", iterators(iters))];
        self.structured("linalg.generic", inputs, outputs, results, props, body)
    }

    /// A named op with its OpDSL body.
    pub fn named(&mut self, name: &str, kind: Named, inputs: &[ValueId], outputs: &[ValueId], results: &[Type<'a>], props: Vec<(&str, Attribute<'a>)>) -> OpId {
        self.structured(name, inputs, outputs, results, props, &mut |cr, a| cr.named_body(kind, a))
    }

    fn named_body(&mut self, kind: Named, a: &[ValueId]) -> Vec<ValueId> {
        let out = *a.last().expect("an output");
        let ot = self.rw.body[out].ty.clone();
        match kind {
            Named::Fill => vec![self.cast_scalar(a[0], &ot, false)],
            Named::Copy => vec![a[0]],
            Named::MulAdd => {
                let v1 = self.cast_scalar(a[0], &ot, false);
                let v2 = self.cast_scalar(a[1], &ot, false);
                let v3 = self.binary(Bin::Mul, v1, v2);
                vec![self.binary(Bin::Add, out, v3)]
            }
            Named::MulAddZp => {
                let v1 = self.cast_scalar(a[0], &ot, false);
                let v2 = self.cast_scalar(a[2], &ot, false);
                let v3 = self.binary(Bin::Sub, v1, v2);
                let v4 = self.cast_scalar(a[1], &ot, false);
                let v5 = self.cast_scalar(a[3], &ot, false);
                let v6 = self.binary(Bin::Sub, v4, v5);
                let v7 = self.binary(Bin::Mul, v3, v6);
                vec![self.binary(Bin::Add, out, v7)]
            }
            Named::MaxS => {
                let v1 = self.cast_scalar(a[0], &ot, false);
                vec![self.binary(Bin::MaxS, out, v1)]
            }
            Named::MaxU => {
                let v1 = self.cast_scalar(a[0], &ot, true);
                vec![self.binary(Bin::MaxU, out, v1)]
            }
            Named::Sum => {
                let v1 = self.cast_scalar(a[0], &ot, false);
                vec![self.binary(Bin::Add, out, v1)]
            }
        }
    }

    /// `RegionBuilderHelper::buildBinaryFn`.
    pub fn binary(&mut self, f: Bin, a: ValueId, b: ValueId) -> ValueId {
        let ty = self.rw.body[a].ty.clone();
        let float = matches!(ty, Type::Float(_));
        let boolean = matches!(ty, Type::Integer { width: 1, .. });
        let name = match (f, float, boolean) {
            (Bin::Add, true, _) => "arith.addf",
            (Bin::Add, _, true) => "arith.ori",
            (Bin::Add, ..) => "arith.addi",
            (Bin::Sub, true, _) => "arith.subf",
            (Bin::Sub, ..) => "arith.subi",
            (Bin::Mul, true, _) => "arith.mulf",
            (Bin::Mul, _, true) => "arith.andi",
            (Bin::Mul, ..) => "arith.muli",
            (Bin::MaxS, true, _) => "arith.maximumf",
            (Bin::MaxS, ..) => "arith.maxsi",
            (Bin::MaxU, ..) => "arith.maxui",
        };
        self.op1(name, &[a, b], ty)
    }

    /// `convertScalarToDtype`.
    pub fn cast_scalar(&mut self, v: ValueId, to: &Type<'a>, unsigned: bool) -> ValueId {
        let from = self.rw.body[v].ty.clone();
        if &from == to {
            return v;
        }
        let width = |t: &Type<'_>| crate::bit_width(t).unwrap_or(0);
        let name = match (&from, to) {
            (Type::Float(_), Type::Integer { .. }) => if unsigned { "arith.fptoui" } else { "arith.fptosi" },
            (Type::Index, Type::Integer { .. }) | (Type::Integer { .. }, Type::Index) => "arith.index_cast",
            (Type::Integer { .. }, Type::Integer { .. }) => {
                if width(to) > width(&from) {
                    if unsigned { "arith.extui" } else { "arith.extsi" }
                } else if width(to) < width(&from) {
                    "arith.trunci"
                } else {
                    return v;
                }
            }
            (Type::Integer { .. }, Type::Float(_)) => if unsigned { "arith.uitofp" } else { "arith.sitofp" },
            (Type::Float(_), Type::Float(_)) => {
                if width(to) > width(&from) {
                    "arith.extf"
                } else if width(to) < width(&from) {
                    "arith.truncf"
                } else {
                    return v;
                }
            }
            _ => return v,
        };
        self.op1(name, &[v], to.clone())
    }

    /// `tensor.pad` of `input` by static `low`/`high`, padded with the constant `value`.
    pub fn pad_static(&mut self, input: ValueId, low: &[i64], high: &[i64], value: ValueId, ty: Type<'a>) -> ValueId {
        let rank = low.len();
        let data = OpData::build("tensor.pad").operands(&[input]).segments(&[1, 0, 0]).with("static_low", dense_i64(low)).with("static_high", dense_i64(high));
        let op = self.rw.create_with(data, core::slice::from_ref(&ty), |b, p| {
            let r = b.add_region(p);
            let args: Vec<_> = (0..rank).map(|_| (Type::Index, None)).collect();
            let blk = b.add_block(r, &args);
            let y = b.create(OpData::build("tensor.yield").operands(&[value]), &[]);
            b.insert(y, blk, None);
        });
        self.rw.body[op].results[0]
    }

    /// `tensor.collapse_shape`.
    pub fn collapse(&mut self, v: ValueId, r: &[Vec<i64>], ty: Type<'a>) -> ValueId {
        self.build(OpData::build("tensor.collapse_shape").operands(&[v]).with("reassociation", crate::canon::Reshape::attr(&r.to_vec())), ty)
    }

    /// `linalg.index`.
    pub fn index(&mut self, d: i64) -> ValueId {
        self.build(OpData::build("linalg.index").with("dim", Attribute::i64(d)), Type::Index)
    }
}

/// An integer attribute `v : ty`.
pub fn int_attr<'a>(v: i128, ty: &Type<'a>) -> Attribute<'a> {
    match ty {
        Type::Integer { width: 1, .. } => Attribute::Bool(v != 0),
        _ => Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(ty.clone()) },
    }
}
