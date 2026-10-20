//! `convert-shape-to-std`, as `ShapeToStandard.cpp`: extent tensors and sizes as `tensor`,
//! `arith` and `scf`.

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{arith, Attribute, Type};

use super::linalg_build::{dims_of, tensor_type};
use super::vector_transforms::index_attr;
use crate::canon::AttrExt;
use crate::{ConversionRewriter, DYNAMIC, OpData, OpId, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The shape ⇒ standard patterns.
pub struct ShapeToStd;

#[patterns]
impl ShapeToStd {
    fn make1<'a>(cr: &mut Cr<'_, 'a, '_>, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        cr.build(data, ty)
    }

    fn yield_(cr: &mut Cr<'_, '_, '_>, name: &str, v: &[ValueId]) {
        cr.rw.create(OpData::build(name).operands(v), &[]);
    }

    /// An op built with its regions' contents first, as builders with body callbacks do.
    fn with_body<'a>(cr: &mut Cr<'_, 'a, '_>, data: OpData<'a>, types: &[Type<'a>], blocks: &[Vec<Type<'a>>], fill: &mut dyn FnMut(&mut Cr<'_, 'a, '_>, usize, &[ValueId])) -> OpId {
        let op = cr.rw.body.create(data, types);
        let mut made = Vec::new();
        for args in blocks {
            let r = cr.rw.body.add_region(op);
            let a: Vec<_> = args.iter().map(|t| (t.clone(), None)).collect();
            made.push(cr.rw.body.add_block(r, &a));
        }
        let saved = cr.rw.ip;
        for (k, blk) in made.into_iter().enumerate() {
            cr.rw.set_end(blk);
            let args = cr.rw.body[blk].args.clone();
            fill(cr, k, &args);
        }
        cr.rw.ip = saved;
        cr.rw.insert(op)
    }

    /// `scf::ForOp::create` with a body builder returning what it yields.
    fn scf_for<'a>(cr: &mut Cr<'_, 'a, '_>, lb: ValueId, ub: ValueId, step: ValueId, inits: &[ValueId], body: &mut dyn FnMut(&mut Cr<'_, 'a, '_>, ValueId, &[ValueId]) -> Vec<ValueId>) -> OpId {
        let types = cr.rw.body.types(inits);
        let mut ops = vec![lb, ub, step];
        ops.extend(inits);
        let mut args = vec![Type::Index];
        args.extend(types.clone());
        Self::with_body(cr, OpData::build("scf.for").operands(&ops), &types, &[args], &mut |cr, _, a| {
            let y = body(cr, a[0], &a[1..]);
            Self::yield_(cr, "scf.yield", &y);
        })
    }

    /// `scf::IfOp::create` with then and else builders.
    fn scf_if<'a>(cr: &mut Cr<'_, 'a, '_>, cond: ValueId, types: &[Type<'a>], then: &mut dyn FnMut(&mut Cr<'_, 'a, '_>) -> Option<ValueId>, other: &mut dyn FnMut(&mut Cr<'_, 'a, '_>) -> Option<ValueId>) -> OpId {
        Self::with_body(cr, OpData::build("scf.if").operands(&[cond]), types, &[Vec::new(), Vec::new()], &mut |cr, k, _| {
            let v = if k == 0 { then(cr) } else { other(cr) };
            Self::yield_(cr, "scf.yield", &v.into_iter().collect::<Vec<_>>());
        })
    }

    fn is(t: &Type<'_>, name: &str) -> bool {
        matches!(t, Type::Extended(e) if e.name == name)
    }

    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    fn result_ty<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Type<'a> {
        Self::ty(cr, cr.rw.body[op].results[0])
    }

    fn cidx(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        Self::make1(cr, OpData::build("arith.constant").with("value", index_attr(v)), Type::Index)
    }

    fn cmpi(cr: &mut Cr<'_, '_, '_>, pred: i64, a: ValueId, b: ValueId) -> ValueId {
        Self::make1(cr, OpData::build("arith.cmpi").operands(&[a, b]).with("predicate", Attribute::i64(pred)), Type::int(1))
    }

    fn bin(cr: &mut Cr<'_, '_, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        Self::make1(cr, OpData::build(name).operands(&[a, b]), ty)
    }

    fn boolean(cr: &mut Cr<'_, '_, '_>, v: bool) -> ValueId {
        Self::make1(cr, OpData::build("arith.constant").with("value", Attribute::Bool(v)), Type::int(1))
    }

    fn extract(cr: &mut Cr<'_, '_, '_>, t: ValueId, i: ValueId) -> ValueId {
        Self::make1(cr, OpData::build("tensor.extract").operands(&[t, i]), Type::Index)
    }

    fn dim(cr: &mut Cr<'_, '_, '_>, t: ValueId, i: ValueId) -> ValueId {
        Self::make1(cr, OpData::build("tensor.dim").operands(&[t, i]), Type::Index)
    }

    fn extent_tensor<'a>() -> Type<'a> {
        tensor_type(&[DYNAMIC], Type::Index)
    }

    /// The ranks of `shapes`, and their differences to the greatest one.
    fn ranks(cr: &mut Cr<'_, '_, '_>, shapes: &[ValueId], zero: ValueId) -> (ValueId, Vec<ValueId>) {
        let ranks: Vec<ValueId> = shapes.iter().map(|s| Self::dim(cr, *s, zero)).collect();
        let mut max = ranks[0];
        for r in &ranks[1..] {
            max = Self::bin(cr, "arith.maxui", *r, max);
        }
        let diffs = ranks.iter().map(|r| Self::bin(cr, "arith.subi", max, *r)).collect();
        (max, diffs)
    }

    /// `getBroadcastedDim`.
    fn broadcasted_dim(cr: &mut Cr<'_, '_, '_>, shapes: &[ValueId], diffs: &[ValueId], d: ValueId) -> ValueId {
        let one = Self::cidx(cr, 1);
        let mut dim = one;
        for (s, diff) in shapes.iter().zip(diffs) {
            let oob = Self::cmpi(cr, 6, d, *diff);
            let prev = dim;
            let op = Self::scf_if(cr, oob, &[Type::Index], &mut |_| Some(prev), &mut |cr| {
                let ld = Self::bin(cr, "arith.subi", d, *diff);
                let e = Self::extract(cr, *s, ld);
                let is_one = Self::cmpi(cr, 0, e, one);
                Some(Self::make1(cr, OpData::build("arith.select").operands(&[is_one, prev, e]), Type::Index))
            });
            dim = cr.rw.body[op].results[0];
        }
        dim
    }

    #[lowering("shape.any")]
    fn any(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        cr.replace_values(op, &[o[0][0]]);
        true
    }

    #[lowering("shape.add", "shape.mul")]
    fn binary(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let rt = Self::result_ty(cr, op);
        if Self::is(&rt, "shape.size") {
            return false;
        }
        let name = if cr.rw.body[op].name == "shape.add" { "arith.addi" } else { "arith.muli" };
        cr.replace_new(op, OpData::build(name).operands(&[o[0][0], o[1][0]]), &[rt]);
        true
    }

    #[lowering("shape.broadcast")]
    fn broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let rt = Self::result_ty(cr, op);
        if Self::is(&rt, "shape.shape") {
            return false;
        }
        let shapes: Vec<ValueId> = o.iter().map(|v| v[0]).collect();
        let zero = Self::cidx(cr, 0);
        let (max, diffs) = Self::ranks(cr, &shapes, zero);
        let g = Self::with_body(cr, OpData::build("tensor.generate").operands(&[max]), &[Self::extent_tensor()], &[vec![Type::Index]], &mut |cr, _, a| {
            let d = Self::broadcasted_dim(cr, &shapes, &diffs, a[0]);
            Self::yield_(cr, "tensor.yield", &[d]);
        });
        let mut r = cr.rw.body[g].results[0];
        if rt != Self::extent_tensor() {
            r = Self::make1(cr, OpData::build("tensor.cast").operands(&[r]), rt);
        }
        cr.replace_values(op, &[r]);
        true
    }

    #[lowering("shape.const_shape")]
    fn const_shape(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let rt = Self::result_ty(cr, op);
        if Self::is(&rt, "shape.shape") {
            return false;
        }
        let Some(c) = cr.rw.body[op].get("shape").and_then(|a| crate::Const::try_from(a).ok()) else { return false };
        let n = crate::attr::element_count(&c.ty).unwrap_or(0);
        let ext: Vec<ValueId> = (0..n).map(|i| Self::cidx(cr, c.at(i).int().map_or(0, |x| x.unsigned() as i64))).collect();
        let t = tensor_type(&[n as i64], Type::Index);
        let fe = Self::make1(cr, OpData::build("tensor.from_elements").operands(&ext), t.clone());
        cr.replace_new(op, OpData::build("tensor.cast").operands(&[fe]), &[t]);
        true
    }

    #[lowering("shape.const_size")]
    fn const_size(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(v) = cr.rw.body[op].get("value").and_then(|a| crate::Const::try_from(a).ok()).and_then(|c| c.at(0).int()) else { return false };
        cr.replace_by(op, &arith::Constant::new(index_attr(v.signed() as i64), Type::Index));
        true
    }

    #[lowering("shape.is_broadcastable")]
    fn is_broadcastable(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].operands.iter().any(|v| Self::is(&cr.rw.body[*v].ty, "shape.shape")) {
            return false;
        }
        let shapes: Vec<ValueId> = o.iter().map(|v| v[0]).collect();
        let zero = Self::cidx(cr, 0);
        let one = Self::cidx(cr, 1);
        let (max, diffs) = Self::ranks(cr, &shapes, zero);
        let t = Self::boolean(cr, true);
        let f = Self::scf_for(cr, zero, max, one, &[t], &mut |cr, iv, args| {
            let bd = Self::broadcasted_dim(cr, &shapes, &diffs, iv);
            let mut ok = args[0];
            for (s, diff) in shapes.iter().zip(&diffs) {
                let oob = Self::cmpi(cr, 6, iv, *diff);
                let prev = ok;
                let i = Self::scf_if(cr, oob, &[Type::int(1)], &mut |_| Some(prev), &mut |cr| {
                    let od = Self::bin(cr, "arith.subi", iv, *diff);
                    let e = Self::extract(cr, *s, od);
                    let eq1 = Self::cmpi(cr, 0, e, one);
                    let eqb = Self::cmpi(cr, 0, e, bd);
                    let or = Self::bin(cr, "arith.ori", eq1, eqb);
                    Some(Self::bin(cr, "arith.andi", prev, or))
                });
                ok = cr.rw.body[i].results[0];
            }
            vec![ok]
        });
        let r = cr.rw.body[f].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    #[lowering("shape.dim")]
    fn dim_op(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let (v, i) = (cr.rw.body[op].operands[0], cr.rw.body[op].operands[1]);
        let rt = Self::result_ty(cr, op);
        let st = match &cr.rw.body[v].ty {
            t if crate::attr::shape_of(t).is_some() => tensor_type(&[dims_of(t).len() as i64], Type::Index),
            Type::Shaped(_) => Self::extent_tensor(),
            _ => Type::Extended(mlirformat::Extended { name: "shape.shape".into(), body: None, params: Vec::new() }),
        };
        let s = Self::make1(cr, OpData::build("shape.shape_of").operands(&[v]), st);
        cr.replace_new(op, OpData::build("shape.get_extent").operands(&[s, i]), &[rt]);
        true
    }

    #[lowering("shape.get_extent")]
    fn get_extent(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if Self::is(&Self::result_ty(cr, op), "shape.size") {
            return false;
        }
        let b = &*cr.rw.body;
        if let Some(s) = b.def_named(b[op].operands[0], "shape.shape_of") {
            let arg = b[s].operands[0];
            if matches!(b[arg].ty, Type::Shaped(_)) {
                cr.replace_new(op, OpData::build("tensor.dim").operands(&[arg, o[1][0]]), &[Type::Index]);
                return true;
            }
        }
        cr.replace_new(op, OpData::build("tensor.extract").operands(&[o[0][0], o[1][0]]), &[Type::Index]);
        true
    }

    #[lowering("shape.rank")]
    fn rank(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if Self::is(&Self::result_ty(cr, op), "shape.size") {
            return false;
        }
        let z = Self::cidx(cr, 0);
        cr.replace_new(op, OpData::build("tensor.dim").operands(&[o[0][0], z]), &[Type::Index]);
        true
    }

    #[lowering("shape.reduce")]
    fn reduce(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        if Self::is(&b[b[op].operands[0]].ty, "shape.shape") {
            return false;
        }
        let shape = o[0][0];
        let inits = b[op].operands[1..].to_vec();
        let block = b.top_block(op);
        let (bargs, bops) = (b[block].args.clone(), b[block].ops.clone());
        let zero = Self::cidx(cr, 0);
        let one = Self::cidx(cr, 1);
        let rank = Self::dim(cr, shape, zero);
        let f = Self::scf_for(cr, zero, rank, one, &inits, &mut |cr, iv, args| {
            let e = Self::extract(cr, shape, iv);
            let mut map = crate::Mapping::default();
            let mut mapped = vec![iv, e];
            mapped.extend(args);
            for (a, m) in bargs.iter().zip(mapped) {
                map.map(*a, m);
            }
            let (term, rest) = bops.split_last().expect("a terminator");
            for n in rest {
                cr.rw.clone(*n, &mut map);
            }
            cr.rw.body[*term].operands.iter().map(|v| map.get(*v)).collect()
        });
        let r = cr.rw.body[f].results.clone();
        cr.replace_values(op, &r);
        true
    }

    #[lowering("shape.shape_eq")]
    fn shape_eq(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].operands.iter().any(|v| Self::is(&cr.rw.body[*v].ty, "shape.shape")) {
            return false;
        }
        if o.len() <= 1 {
            cr.replace_by(op, &arith::Constant::new(Attribute::Bool(true), Type::int(1)));
            return true;
        }
        let zero = Self::cidx(cr, 0);
        let first = o[0][0];
        let frank = Self::dim(cr, first, zero);
        let mut result: Option<ValueId> = None;
        for s in &o[1..] {
            let shape = s[0];
            let rank = Self::dim(cr, shape, zero);
            let eq = Self::cmpi(cr, 0, frank, rank);
            let same = Self::scf_if(cr, 
                eq,
                &[Type::int(1)],
                &mut |cr| {
                    let one = Self::cidx(cr, 1);
                    let init = Self::boolean(cr, true);
                    let l = Self::scf_for(cr, zero, frank, one, &[init], &mut |cr, iv, a| {
                        let le = Self::extract(cr, first, iv);
                        let re = Self::extract(cr, shape, iv);
                        let e = Self::cmpi(cr, 0, le, re);
                        vec![Self::bin(cr, "arith.andi", a[0], e)]
                    });
                    Some(cr.rw.body[l].results[0])
                },
                &mut |cr| Some(Self::boolean(cr, false)),
            );
            let sv = cr.rw.body[same].results[0];
            result = Some(match result {
                None => sv,
                Some(r) => Self::bin(cr, "arith.andi", r, sv),
            });
        }
        cr.replace_values(op, &[result.expect("two shapes")]);
        true
    }

    #[lowering("shape.shape_of")]
    fn shape_of(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let rt = Self::result_ty(cr, op);
        if Self::is(&rt, "shape.shape") {
            return false;
        }
        let t = o[0][0];
        let tt = Self::ty(cr, t);
        if let Some(dims) = crate::attr::shape_of(&tt).filter(|_| matches!(&tt, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor)).map(|_| dims_of(&tt)) {
            let ext: Vec<ValueId> = dims
                .iter()
                .enumerate()
                .map(|(i, d)| {
                    if *d == DYNAMIC {
                        let k = Self::cidx(cr, i as i64);
                        Self::dim(cr, t, k)
                    } else {
                        Self::cidx(cr, *d)
                    }
                })
                .collect();
            let fe = Self::make1(cr, OpData::build("tensor.from_elements").operands(&ext), tensor_type(&[dims.len() as i64], Type::Index));
            cr.replace_new(op, OpData::build("tensor.cast").operands(&[fe]), &[rt]);
            return true;
        }
        let rank = Self::make1(cr, OpData::build("tensor.rank").operands(&[t]), Type::Index);
        let g = Self::with_body(cr, OpData::build("tensor.generate").operands(&[rank]), &[Self::extent_tensor()], &[vec![Type::Index]], &mut |cr, _, a| {
            let d = Self::dim(cr, t, a[0]);
            Self::yield_(cr, "tensor.yield", &[d]);
        });
        let r = cr.rw.body[g].results[0];
        cr.replace_values(op, &[r]);
        true
    }

    #[lowering("shape.split_at")]
    fn split_at(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let vals = [b[op].operands[0], b[op].results[0], b[op].results[1]];
        if vals.iter().any(|v| Self::is(&b[*v].ty, "shape.shape")) {
            return false;
        }
        let (operand, index) = (o[0][0], o[1][0]);
        let zero = Self::cidx(cr, 0);
        let rank = Self::dim(cr, operand, zero);
        let add = Self::bin(cr, "arith.addi", index, rank);
        let neg = Self::cmpi(cr, 2, index, zero);
        let idx = Self::make1(cr, OpData::build("arith.select").operands(&[neg, add, index]), Type::Index);
        let one = Self::cidx(cr, 1);
        let slice = |cr: &mut Cr<'_, '_, '_>, off: ValueId, size: ValueId| {
            let data = OpData::build("tensor.extract_slice")
                .operands(&[operand, off, size, one])
                .segments(&[1, 1, 1, 1])
                .with("static_offsets", super::vector_transforms::dense_i64(&[DYNAMIC]))
                .with("static_sizes", super::vector_transforms::dense_i64(&[DYNAMIC]))
                .with("static_strides", super::vector_transforms::dense_i64(&[DYNAMIC]));
            Self::make1(cr, data, Self::extent_tensor())
        };
        let head = slice(cr, zero, idx);
        let ts = Self::bin(cr, "arith.subi", rank, idx);
        let tail = slice(cr, idx, ts);
        cr.replace_values(op, &[head, tail]);
        true
    }

    #[lowering("shape.to_extent_tensor")]
    fn to_extent_tensor(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let t = Self::ty(cr, o[0][0]);
        if crate::attr::shape_of(&t).is_none() || !matches!(&t, Type::Shaped(s) if s.kind == mlirformat::ShapedKind::Tensor) {
            return false;
        }
        let rt = Self::result_ty(cr, op);
        cr.replace_new(op, OpData::build("tensor.cast").operands(&[o[0][0]]), &[rt]);
        true
    }

    /// The DRR `CstrBroadcastableToRequire` / `CstrEqToRequire`.
    #[lowering("shape.cstr_broadcastable", "shape.cstr_eq")]
    fn cstr(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let shapes = b[op].operands.clone();
        let wt = Self::result_ty(cr, op);
        let (name, msg) = if b[op].name == "shape.cstr_broadcastable" { ("shape.is_broadcastable", "required broadcastable shapes") } else { ("shape.shape_eq", "required equal shapes") };
        let c = Self::make1(cr, OpData::build(name).operands(&shapes), Type::int(1));
        cr.replace_new(op, OpData::build("shape.cstr_require").operands(&[c]).with("msg", Attribute::Str { lit: msg.into(), ty: None }), &[wt]);
        true
    }

}
