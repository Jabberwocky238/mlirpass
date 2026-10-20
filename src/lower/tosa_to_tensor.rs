//! `tosa` ⇒ `tensor`, as `TosaToTensor.cpp` (with `populateTosaTypeConversion`).

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Dim, Shaped, ShapedKind, Signedness, Type};

use super::vector_transforms::{dense_i64, index_attr};
use crate::canon::MemrefOfr as Ofr;
use crate::{Const, ConversionRewriter, DYNAMIC, OpData, OpId, Rewriter, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The tosa ⇒ tensor patterns and their helpers.
pub struct TosaToTensor;

#[patterns(converter)]
impl TosaToTensor {
    /// `populateTosaTypeConversion`: unsigned integers become signless, in tensors too.
    pub fn converter<'c>() -> TypeConverter<'c> {
        fn scalar<'a>(t: &Type<'a>) -> Type<'a> {
            match t {
                Type::Integer { signedness: Signedness::Unsigned, width } => Type::int(*width),
                t => t.clone(),
            }
        }
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Some(Some(vec![scalar(t)])));
        tc.conversion(|t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::Tensor => Some(Some(vec![Type::Shaped(Shaped { elem: scalar(&s.elem).into(), ..s.clone() })])),
            _ => None,
        });
        fn cast<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
            let [_] = inputs else { return None };
            let c = rw.create(OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
            Some(rw.body[c].results[0])
        }
        tc.source(|rw, ty, inputs| cast(rw, ty, inputs));
        tc.target(|rw, tys, inputs, _| match tys {
            [ty] => cast(rw, ty, inputs).map(|v| vec![v]),
            _ => None,
        });
        tc
    }

    fn dims(t: &Type<'_>) -> Option<Vec<i64>> {
        crate::attr::shape_of(t).map(|d| d.iter().map(|d| if let Dim::Static(n) = d { *n } else { DYNAMIC }).collect())
    }

    /// `TensorType::clone(shape)`.
    fn with_shape<'a>(t: &Type<'a>, dims: &[i64]) -> Type<'a> {
        let Type::Shaped(s) = t else { return t.clone() };
        let shape = dims.iter().map(|d| if *d == DYNAMIC { Dim::Dynamic } else { Dim::Static(*d) }).collect();
        Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(shape), elem: s.elem.clone(), extras: if s.shape.is_some() { s.extras.clone() } else { Vec::new() } })
    }

    /// The values of the `tosa.const_shape` defining `v`.
    pub fn const_shape(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<Vec<i64>> {
        let b = &*cr.rw.body;
        let d = b.def_named(v, "tosa.const_shape")?;
        let c = Const::try_from(b[d].get("values")?).ok()?;
        let n = crate::attr::element_count(&c.ty)?;
        (0..n).map(|i| c.at(i).int().map(|x| x.signed() as i64)).collect()
    }

    /// `inferReshapeExpandedType`.
    fn expanded_type<'a>(input: &Type<'a>, shape: &[i64]) -> Type<'a> {
        if shape.is_empty() {
            return Self::with_shape(input, &[]);
        }
        let dims = Self::dims(input);
        let fixed = dims.as_ref().is_some_and(|d| !d.contains(&DYNAMIC));
        let total: i64 = if fixed { dims.as_ref().expect("ranked").iter().product() } else { -1 };
        let mut res: Vec<i64> = shape
            .iter()
            .map(|s| {
                if *s >= 0 {
                    return *s;
                }
                if !fixed {
                    return DYNAMIC;
                }
                let rest = -shape.iter().product::<i64>();
                if rest == 0 { 0 } else { total / rest }
            })
            .collect();
        if !fixed && !res.contains(&DYNAMIC) {
            res[0] = DYNAMIC;
        }
        Self::with_shape(input, &res)
    }

    /// `inferReshapeCollapsedType`.
    fn collapsed_type<'a>(lhs: &Type<'a>, rhs: &Type<'a>) -> Type<'a> {
        let (l, r) = (Self::dims(lhs).unwrap_or_default(), Self::dims(rhs).unwrap_or_default());
        if l.is_empty() || r.is_empty() {
            return Self::with_shape(lhs, &[]);
        }
        if l.contains(&DYNAMIC) || r.contains(&DYNAMIC) {
            return Self::with_shape(lhs, &[DYNAMIC]);
        }
        let mut out = Vec::new();
        let (mut li, mut ri) = (0, 0);
        while li < l.len() && ri < r.len() {
            let (mut rs, mut ls) = (r[ri], l[li]);
            while ls != rs && li < l.len() && ri < r.len() {
                if ls < rs {
                    li += 1;
                    if li < l.len() {
                        ls *= l[li];
                    }
                } else {
                    ri += 1;
                    if ri < r.len() {
                        rs *= r[ri];
                    }
                }
            }
            if ls == rs {
                out.push(ls);
            }
            ri += 1;
            li += 1;
        }
        Self::with_shape(lhs, &out)
    }

    /// `createReassociationMapForCollapse`.
    fn reassociation(src: &Type<'_>, dst: &Type<'_>) -> Vec<Vec<i64>> {
        let (s, d) = (Self::dims(src).unwrap_or_default(), Self::dims(dst).unwrap_or_default());
        if s.is_empty() || d.is_empty() {
            return Vec::new();
        }
        if s.contains(&DYNAMIC) || d.contains(&DYNAMIC) {
            return vec![(0..s.len() as i64).collect()];
        }
        let mut map = vec![Vec::new(); d.len()];
        let (mut si, mut di) = (0, 0);
        while si < s.len() && di < d.len() {
            let ds = d[di];
            let mut ss = s[si];
            while ss < ds && si < s.len() {
                map[di].push(si as i64);
                si += 1;
                ss *= s.get(si).copied().unwrap_or(1);
            }
            if ss == ds {
                map[di].push(si as i64);
                si += 1;
                if di == d.len() - 1 || d[di + 1] != 1 {
                    while si < s.len() && s[si] == 1 {
                        map[di].push(si as i64);
                        si += 1;
                    }
                }
            }
            di += 1;
        }
        map
    }

    fn fold1<'a>(cr: &mut Cr<'_, 'a, '_>, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        cr.rw.create_or_fold(data, &[ty])[0]
    }

    fn cidx(cr: &mut Cr<'_, '_, '_>, v: i64) -> ValueId {
        cr.build(OpData::build("arith.constant").with("value", index_attr(v)), Type::Index)
    }

    /// `tensor::getMixedSize`: static sizes as constants, dynamic ones by `tensor.dim`.
    fn mixed_sizes(cr: &mut Cr<'_, '_, '_>, v: ValueId) -> Vec<Ofr> {
        let dims = Self::dims(&cr.rw.body[v].ty).unwrap_or_default();
        dims.iter()
            .enumerate()
            .map(|(i, d)| {
                if *d != DYNAMIC {
                    return Ofr::C(*d);
                }
                let k = Self::cidx(cr, i as i64);
                let r = Self::fold1(cr, OpData::build("tensor.dim").operands(&[v, k]), Type::Index);
                cr.rw.body.ofr_int(Ofr::V(r)).map_or(Ofr::V(r), Ofr::C)
            })
            .collect()
    }

    /// `getValueOrCreateConstantIndexOp`.
    fn value_of(cr: &mut Cr<'_, '_, '_>, o: Ofr) -> ValueId {
        match o {
            Ofr::V(v) => v,
            Ofr::C(c) => Self::cidx(cr, c),
        }
    }

    /// `tensor.expand_shape` built from the source and reassociation alone (output shape
    /// inferred by `inferExpandShapeOutputShape`), then folded.
    pub fn expand<'a>(cr: &mut Cr<'_, 'a, '_>, ty: Type<'a>, src: ValueId, r: &[Vec<i64>], fold: bool) -> ValueId {
        let input = Self::mixed_sizes(cr, src);
        let out = Self::dims(&ty).unwrap_or_default();
        let mut shape: Option<Vec<Ofr>> = None;
        if input.is_empty() {
            shape = Some(vec![Ofr::C(1); out.len()]);
        } else if !out.contains(&DYNAMIC) {
            shape = Some(out.iter().map(|d| Ofr::C(*d)).collect());
        } else {
            let mut s: Vec<Ofr> = out.iter().map(|d| Ofr::C(*d)).collect();
            let mut ok = true;
            for (g, group) in r.iter().enumerate() {
                let mut prod = 1i64;
                let mut dynamic = None;
                for i in group {
                    let d = out[*i as usize];
                    if d == DYNAMIC {
                        if dynamic.is_some() {
                            ok = false;
                        }
                        dynamic = Some(*i as usize);
                    } else {
                        prod *= d;
                    }
                }
                let (true, Some(at)) = (ok, dynamic) else { continue };
                let size = match input[g] {
                    Ofr::V(v) => v,
                    Ofr::C(c) => Self::cidx(cr, c),
                };
                let p = Self::cidx(cr, prod);
                let q = Self::fold1(cr, OpData::build("arith.divsi").operands(&[size, p]), Type::Index);
                s[at] = Ofr::V(q);
            }
            if ok {
                shape = Some(s);
            }
        }
        let shape = shape.unwrap_or_default();
        let mut ops = vec![src];
        let mut statics = Vec::new();
        for o in &shape {
            match o {
                Ofr::C(c) => statics.push(*c),
                Ofr::V(v) => {
                    statics.push(DYNAMIC);
                    ops.push(*v);
                }
            }
        }
        let data = OpData::build("tensor.expand_shape").operands(&ops).with("reassociation", crate::canon::Reshape::attr(&r.to_vec())).with("static_output_shape", dense_i64(&statics));
        if fold { Self::fold1(cr, data, ty) } else { cr.build(data, ty) }
    }

    #[lowering("tosa.reshape")]
    fn reshape(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let Some(rt) = cr.type_converter().and_then(|tc| tc.convert(&cr.rw.body[r].ty)) else { return false };
        let input = o[0][0];
        let it = cr.rw.body[input].ty.clone();
        if !matches!(&it, Type::Shaped(s) if s.kind == ShapedKind::Tensor) {
            return false;
        }
        let shape_v = cr.rw.body[op].operands[1];
        let Some(shape) = Self::const_shape(cr, shape_v) else { return false };
        let in_ty = if shape.is_empty() { Self::with_shape(&it, &vec![1; Self::dims(&it).map_or(0, |d| d.len())]) } else { it.clone() };
        let ex = Self::expanded_type(&in_ty, &shape);
        let co = Self::collapsed_type(&in_ty, &ex);
        let cast = Self::fold1(cr, OpData::build("tensor.cast").operands(&[input]), in_ty.clone());
        let cr_re = Self::reassociation(&cr.rw.body[cast].ty.clone(), &co);
        let collapsed = Self::fold1(cr, OpData::build("tensor.collapse_shape").operands(&[cast]).with("reassociation", crate::canon::Reshape::attr(&cr_re)), co.clone());
        let ex_re = Self::reassociation(&ex, &cr.rw.body[collapsed].ty.clone());
        let expanded = Self::expand(cr, ex, collapsed, &ex_re, true);
        let res = Self::fold1(cr, OpData::build("tensor.cast").operands(&[expanded]), rt);
        cr.replace_values(op, &[res]);
        true
    }

    #[lowering("tosa.slice")]
    fn slice(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let input = o[0][0];
        let b = &*cr.rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some(rdims) = Self::dims(&rt) else { return false };
        let (start_v, size_v) = (b[op].operands[1], b[op].operands[2]);
        let (Some(starts), Some(sizes0)) = (Self::const_shape(cr, start_v), Self::const_shape(cr, size_v)) else { return false };
        let strides = vec![1i64; rdims.len()];
        let mut sizes = Vec::new();
        let mut dynamic = Vec::new();
        for (i, s) in sizes0.iter().enumerate() {
            sizes.push(if *s == -1 { DYNAMIC } else { *s });
            if *s != -1 {
                continue;
            }
            let k = Self::cidx(cr, i as i64);
            let d = cr.build(OpData::build("tensor.dim").operands(&[input, k]), Type::Index);
            let off = Self::cidx(cr, starts[i]);
            dynamic.push(cr.build(OpData::build("arith.subi").operands(&[d, off]), Type::Index));
        }
        let mut ops = vec![input];
        ops.extend(&dynamic);
        let data = OpData::build("tensor.extract_slice").operands(&ops).segments(&[1, 0, dynamic.len(), 0]).with("static_offsets", dense_i64(&starts)).with("static_sizes", dense_i64(&sizes)).with("static_strides", dense_i64(&strides));
        let new = cr.build(data, rt);
        for v in [start_v, size_v] {
            if cr.rw.body[v].uses.len() == 1
                && let Some(d) = cr.rw.body.def_op(v)
            {
                cr.erase(d);
            }
        }
        cr.replace_values(op, &[new]);
        true
    }

    #[lowering("tosa.pad")]
    fn pad(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (input, padding, pad_const) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let rt = b[b[op].results[0]].ty.clone();
        let Some(vals) = Self::const_shape(cr, padding) else { return false };
        let rank = Self::dims(&cr.rw.body[input].ty).map_or(0, |d| d.len());
        let zero = Self::cidx(cr, 0);
        let et = crate::attr::element_type(&cr.rw.body[pad_const].ty).clone();
        let pc = Self::fold1(cr, OpData::build("tensor.extract").operands(&[pad_const, zero]), et.clone());
        let mut low = Vec::new();
        let mut high = Vec::new();
        for i in 0..rank {
            low.push(Self::cidx(cr, vals[2 * i]));
            high.push(Self::cidx(cr, vals[2 * i + 1]));
        }
        let mut ops = vec![input];
        ops.extend(&low);
        ops.extend(&high);
        let data = OpData::build("tensor.pad").operands(&ops).segments(&[1, rank, rank]).with("static_low", dense_i64(&vec![DYNAMIC; rank])).with("static_high", dense_i64(&vec![DYNAMIC; rank]));
        let new = cr.rw.create_with(data, core::slice::from_ref(&rt), |b, p| {
            let r = b.add_region(p);
            let args: Vec<_> = (0..rank).map(|_| (Type::Index, None)).collect();
            let blk = b.add_block(r, &args);
            let y = b.create(OpData::build("tensor.yield").operands(&[pc]), &[]);
            b.insert(y, blk, None);
        });
        let v = cr.rw.body[new].results[0];
        cr.replace_values(op, &[v]);
        true
    }

    #[lowering("tosa.concat")]
    fn concat(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let rt = b[b[op].results[0]].ty.clone();
        let Some(rdims) = Self::dims(&rt) else { return false };
        let axis = match b[op].get("axis") {
            Some(Attribute::Int { lit, .. }) => lit.parse::<usize>().unwrap_or(0),
            _ => 0,
        };
        let args: Vec<ValueId> = o.iter().map(|v| v[0]).collect();
        let axis_v = Self::cidx(cr, axis as i64);
        let rank = rdims.len();
        let strides = vec![Ofr::C(1); rank];
        let mut offsets = vec![Ofr::C(0); rank];
        let mut sizes = Self::mixed_sizes(cr, args[0]);
        let mut axis_offsets = vec![Ofr::C(0), sizes[axis]];
        for a in &args[1..] {
            let size = Self::fold1(cr, OpData::build("tensor.dim").operands(&[*a, axis_v]), Type::Index);
            let cur = *axis_offsets.last().expect("an offset");
            let cur = Self::value_of(cr, cur);
            let total = Self::fold1(cr, OpData::build("arith.addi").operands(&[cur, size]), Type::Index);
            axis_offsets.push(cr.rw.body.ofr_int(Ofr::V(total)).map_or(Ofr::V(total), Ofr::C));
        }
        sizes[axis] = *axis_offsets.last().expect("an offset");
        let mut dyn_dims = Vec::new();
        for (i, d) in rdims.iter().enumerate() {
            if *d == DYNAMIC {
                dyn_dims.push(Self::value_of(cr, sizes[i]));
            }
        }
        let empty_ty = Type::Shaped(Shaped { extras: Vec::new(), ..match &rt {
            Type::Shaped(s) => s.clone(),
            _ => return false,
        } });
        let mut result = cr.build(OpData::build("tensor.empty").operands(&dyn_dims), empty_ty);
        for (a, off) in args.iter().zip(axis_offsets) {
            let sz = Self::mixed_sizes(cr, *a);
            offsets[axis] = off;
            let ty = cr.rw.body[result].ty.clone();
            let data = Self::slice_data("tensor.insert_slice", &[*a, result], [&offsets, &sz, &strides]);
            result = Self::fold1(cr, data, ty);
        }
        cr.replace_values(op, &[result]);
        true
    }

    fn slice_data<'a>(name: &str, lead: &[ValueId], lists: [&[Ofr]; 3]) -> OpData<'a> {
        let mut ops = lead.to_vec();
        let mut segs = vec![1usize; lead.len()];
        let mut data = OpData::build(name);
        for (l, n) in lists.iter().zip(["static_offsets", "static_sizes", "static_strides"]) {
            let mut st = Vec::new();
            let mut k = 0;
            for o in l.iter() {
                match o {
                    Ofr::C(c) => st.push(*c),
                    Ofr::V(v) => {
                        st.push(DYNAMIC);
                        ops.push(*v);
                        k += 1;
                    }
                }
            }
            segs.push(k);
            data.set(n, dense_i64(&st));
        }
        data.operands(&ops).segments(&segs)
    }

}
