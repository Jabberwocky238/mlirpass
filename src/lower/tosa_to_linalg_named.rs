//! `tosa-to-linalg-named`, as `TosaToLinalgNamed.cpp`: convolutions, matmul, pooling and
//! transposes as linalg named ops.

use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, FloatKind, Type, tosa};

use super::linalg_build::{Named, dims_of, i64_elements, int_attr, tensor_type};
use super::vector_transforms::dense_i64;
use crate::canon::MemrefOfr as Ofr;
use crate::{AffineExpr, AffineMap, ApFloat, Const, ConversionRewriter, DYNAMIC, Mapping, OpData, OpId, Scalar, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The tosa ⇒ linalg named-op patterns.
pub struct TosaToLinalgNamed;

#[patterns(converter, hwcf: bool)]
impl TosaToLinalgNamed {
    fn ints(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Vec<i64> {
        cr.rw.body.dense_i64(op, name)
    }

    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    fn elem<'a>(t: &Type<'a>) -> Type<'a> {
        crate::attr::element_type(t).clone()
    }

    /// `getZeroPoint`: the first element of a constant zero-point tensor.
    fn zero_point(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<i64> {
        let c = Const::try_from(&cr.rw.body.constant_of(v)?).ok()?;
        match c.at(0) {
            Scalar::Float(f) => Some(if f.is_zero() { 0 } else { -1 }),
            Scalar::Int(i) => Some(i.signed() as i64),
        }
    }

    /// `verifyZeroPoint`: only i8 zero points may be nonzero.
    fn zp_ok(cr: &Cr<'_, '_, '_>, v: ValueId, zp: i64) -> bool {
        zp == 0 || Self::elem(&Self::ty(cr, v)) == Type::int(8)
    }

    /// `getZeroAttr`.
    fn zero<'a>(t: &Type<'a>) -> Attribute<'a> {
        match t {
            Type::Float(k) => Const::scalar(Scalar::Float(ApFloat::from_f64(*k, 0.0).expect("a float")), t.clone()).into(),
            _ => int_attr(0, t),
        }
    }

    /// `applyPad`.
    fn apply_pad<'a>(cr: &mut Cr<'_, 'a, '_>, input: ValueId, pad: &[i64], value: Attribute<'a>) -> ValueId {
        if pad.iter().all(|p| *p == 0) {
            return input;
        }
        let it = Self::ty(cr, input);
        let shape = dims_of(&it);
        let padded: Vec<i64> = shape.iter().enumerate().map(|(i, d)| if *d == DYNAMIC { *d } else { d + pad[2 * i] + pad[2 * i + 1] }).collect();
        let low: Vec<i64> = (0..shape.len()).map(|i| pad[2 * i]).collect();
        let high: Vec<i64> = (0..shape.len()).map(|i| pad[2 * i + 1]).collect();
        let et = Self::elem(&it);
        let pv = cr.constant(value, et.clone());
        cr.pad_static(input, &low, &high, pv, tensor_type(&padded, et))
    }

    /// `getBroadcastingMap`.
    fn broadcasting_map(cr: &Cr<'_, '_, '_>, source: ValueId, result: ValueId) -> AffineMap {
        let (rr, sd) = (dims_of(&Self::ty(cr, result)).len() as u32, dims_of(&Self::ty(cr, source)));
        let results = if sd.len() == 1 && sd[0] == 1 { vec![AffineExpr::Const(0)] } else { (0..sd.len() as u32).map(|d| AffineExpr::Dim(d + rr - sd.len() as u32)).collect() };
        AffineMap { dims: rr, syms: 0, results }
    }

    /// `linalgBroadcastAndMaybeExt`.
    fn broadcast_ext(cr: &mut Cr<'_, '_, '_>, source: ValueId, result: ValueId) -> ValueId {
        let rt = Self::ty(cr, result);
        let rank = dims_of(&rt).len();
        let maps = [Self::broadcasting_map(cr, source, result), AffineMap::identity(rank as u32)];
        let float = matches!(Self::elem(&rt), Type::Float(_));
        let g = cr.generic(core::slice::from_ref(&rt), &[source], &[result], &maps, &vec![true; rank], &mut |cr, a| {
            let rt = Self::ty(cr, a[1]);
            let v = if Self::ty(cr, a[0]) != rt { cr.op1(if float { "arith.extf" } else { "arith.extsi" }, &[a[0]], rt) } else { a[0] };
            vec![v]
        });
        cr.rw.body[g].results[0]
    }

    /// `getConvOrPoolOutputDim`.
    fn output_dim(cr: &mut Cr<'_, '_, '_>, input: ValueId, before: i64, after: i64, kernel: ValueId, stride: i64, dilation: i64) -> ValueId {
        let one = cr.constant(int_attr(1, &Type::Index), Type::Index);
        let pb = cr.cidx(before);
        let a = cr.bin("arith.addi", input, pb);
        let pa = cr.cidx(after);
        let a = cr.bin("arith.addi", a, pa);
        let k1 = cr.bin("arith.subi", kernel, one);
        let d = cr.cidx(dilation);
        let dk = cr.bin("arith.muli", d, k1);
        let dk1 = cr.bin("arith.addi", dk, one);
        let s = cr.bin("arith.subi", a, dk1);
        let st = cr.cidx(stride);
        let q = cr.bin("arith.divui", s, st);
        cr.bin("arith.addi", q, one)
    }

    /// `inferDynamicDimsForConv`.
    fn conv_dyn_dims(cr: &mut Cr<'_, '_, '_>, input: ValueId, weight: ValueId, rdims: &[i64], pad: &[i64], stride: &[i64], dil: &[i64], in_dims: &[i64], k_dims: &[i64]) -> Vec<ValueId> {
        let mut dims: Vec<Option<ValueId>> = vec![None; rdims.len()];
        for i in 0..in_dims.len() {
            let (id, kd) = (in_dims[i] as usize, k_dims[i]);
            if rdims[id] == DYNAMIC {
                let init = cr.tdim(input, id as i64);
                let kern = cr.tdim(weight, kd);
                dims[id] = Some(Self::output_dim(cr, init, pad[2 * i], pad[2 * i + 1], kern, stride[i], dil[i]));
            }
        }
        let rank = dims_of(&Self::ty(cr, input)).len();
        for i in 0..rank {
            if rdims[i] == DYNAMIC && dims[i].is_none() {
                dims[i] = Some(cr.tdim(input, i as i64));
            }
        }
        dims.into_iter().flatten().collect()
    }

    /// `tosa.transpose` moving the leading dim of the weight last.
    fn transpose_weight<'a>(cr: &mut Cr<'_, 'a, '_>, weight: ValueId, rank: usize) -> ValueId {
        let wt = Self::ty(cr, weight);
        let shape = dims_of(&wt);
        let perm: Vec<i64> = (1..rank as i64).chain([0]).collect();
        let ns: Vec<i64> = perm.iter().map(|p| shape[*p as usize]).collect();
        let perms = Attribute::DenseArray { ty: Type::int(32), values: perm.iter().map(|p| alloc::format!("{p}").into()).collect() };
        cr.emit(&tosa::TransposeOp::new(weight.into(), perms, wt.clone(), tensor_type(&ns, Self::elem(&wt))))
    }

    fn acc_type<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Type<'a>> {
        match cr.rw.body[op].get("acc_type") {
            Some(Attribute::Type(t)) => Some(t.clone()),
            _ => None,
        }
    }

    /// `ConvConverter`.
    fn conv(cr: &mut Cr<'_, '_, '_>, op: OpId, names: (&str, &str)) -> bool {
        let b = &*cr.rw.body;
        let (mut input, mut weight, bias) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let (izv, wzv) = (b[op].operands[3], b[op].operands[4]);
        let it = Self::ty(cr, input);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let ie = Self::elem(&it);
        let (pad_a, stride, dil) = (Self::ints(cr, op, "pad"), Self::ints(cr, op, "stride"), Self::ints(cr, op, "dilation"));
        let Some(acc) = Self::acc_type(cr, op) else { return false };
        let rdims = dims_of(&rt);
        let acc_ty = tensor_type(&rdims, acc.clone());
        let (Some(izp), Some(wzp)) = (Self::zero_point(cr, izv), Self::zero_point(cr, wzv)) else { return false };
        if !Self::zp_ok(cr, izv, izp) || !Self::zp_ok(cr, wzv, wzp) {
            return false;
        }
        let has_zp = izp != 0 || wzp != 0;
        let static_ = |t: &Type<'_>| !dims_of(t).contains(&DYNAMIC);
        if !static_(&Self::ty(cr, weight)) || !static_(&Self::ty(cr, bias)) {
            return false;
        }
        if matches!(ie, Type::Integer { signedness: mlirformat::Signedness::Unsigned, .. }) {
            return false;
        }
        let sizes: Vec<i64> = (1..rdims.len() as i64 - 1).collect();
        let dyn_dims = Self::conv_dyn_dims(cr, input, weight, &rdims, &pad_a, &stride, &dil, &sizes, &sizes);
        let mut zero_attr = Self::zero(&ie);
        if has_zp {
            let w = crate::bit_width(&ie).unwrap_or(8);
            let (lo, hi) = (-(1i64 << (w - 1)), (1i64 << (w - 1)) - 1);
            if izp < lo || izp > hi {
                return false;
            }
            zero_attr = int_attr(i128::from(izp), &ie);
        }
        let mut pad = vec![0, 0];
        pad.extend(&pad_a);
        pad.extend([0, 0]);
        input = Self::apply_pad(cr, input, &pad, zero_attr);
        let rank = dims_of(&it).len();
        let (op_name, q_name) = names;
        if (rank == 4 && op_name == "linalg.conv_2d_nhwc_hwcf") || rank == 5 {
            weight = Self::transpose_weight(cr, weight, rank);
        }
        let props = |s: &[i64], d: &[i64]| vec![("strides", i64_elements(s, false)), ("dilations", i64_elements(d, false))];
        let empty = cr.empty(&rdims, acc.clone(), &dyn_dims);
        let bb = Self::broadcast_ext(cr, bias, empty);
        let conv = if has_zp {
            let i = cr.constant(int_attr(i128::from(izp), &Type::int(32)), Type::int(32));
            let k = cr.constant(int_attr(i128::from(wzp), &Type::int(32)), Type::int(32));
            let c = Self::yaml_named(cr, q_name, Named::MulAddZp, &[input, weight, i, k], &[bb], &rt, props(&stride, &dil), &stride, &dil);
            cr.rw.body[c].results[0]
        } else {
            let c = Self::yaml_named(cr, op_name, Named::MulAdd, &[input, weight], &[bb], &acc_ty, props(&stride, &dil), &stride, &dil);
            let mut v = cr.rw.body[c].results[0];
            if rt != acc_ty {
                v = cr.emit(&tosa::CastOp::new(v.into(), Self::ty(cr, v), rt));
            }
            v
        };
        cr.replace_values(op, &[conv]);
        true
    }

    #[lowering("tosa.conv2d", when = !hwcf, untyped)]
    fn conv2d_fhwc(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::conv(cr, op, ("linalg.conv_2d_nhwc_fhwc", "linalg.conv_2d_nhwc_fhwc_q"))
    }

    #[lowering("tosa.conv2d", when = hwcf, untyped)]
    fn conv2d_hwcf(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::conv(cr, op, ("linalg.conv_2d_nhwc_hwcf", "linalg.conv_2d_nhwc_hwcf_q"))
    }

    #[lowering("tosa.conv3d", untyped)]
    fn conv3d(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::conv(cr, op, ("linalg.conv_3d_ndhwc_dhwcf", "linalg.conv_3d_ndhwc_dhwcf_q"))
    }

    /// `DepthwiseConvConverter`.
    #[lowering("tosa.depthwise_conv2d", untyped)]
    fn depthwise(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (mut input, weight, bias) = (b[op].operands[0], b[op].operands[1], b[op].operands[2]);
        let (izv, wzv) = (b[op].operands[3], b[op].operands[4]);
        let it = Self::ty(cr, input);
        let rt = Self::ty(cr, cr.rw.body[op].results[0]);
        let rdims = dims_of(&rt);
        let rank = rdims.len();
        let (ie, re) = (Self::elem(&it), Self::elem(&rt));
        let (pad_a, stride, dil) = (Self::ints(cr, op, "pad"), Self::ints(cr, op, "stride"), Self::ints(cr, op, "dilation"));
        let Some(acc) = Self::acc_type(cr, op) else { return false };
        let static_ = |t: &Type<'_>| !dims_of(t).contains(&DYNAMIC);
        if !static_(&Self::ty(cr, weight)) || !static_(&Self::ty(cr, bias)) {
            return false;
        }
        let dyn_dims = Self::conv_dyn_dims(cr, input, weight, &rdims, &pad_a, &stride, &dil, &[1, 2], &[0, 1]);
        let (Some(izp), Some(wzp)) = (Self::zero_point(cr, izv), Self::zero_point(cr, wzv)) else { return false };
        if !Self::zp_ok(cr, izv, izp) || !Self::zp_ok(cr, wzv, wzp) {
            return false;
        }
        let null = izp == 0 && wzp == 0;
        let ws = dims_of(&Self::ty(cr, weight));
        let mut zero_attr = Self::zero(&ie);
        if !null {
            let w = crate::bit_width(&ie).unwrap_or(8);
            if izp < -(1i64 << (w - 1)) || izp > (1i64 << (w - 1)) - 1 {
                return false;
            }
            zero_attr = int_attr(i128::from(izp), &ie);
        }
        let mut pad = vec![0, 0];
        pad.extend(&pad_a);
        pad.extend([0, 0]);
        input = Self::apply_pad(cr, input, &pad, zero_attr);
        let conv_dims = [rdims[0], rdims[1], rdims[2], ws[2], ws[3]];
        let conv_ty = tensor_type(&conv_dims, acc.clone());
        let empty = cr.empty(&conv_dims, acc.clone(), &dyn_dims);
        let zero = cr.constant(Self::zero(&acc), acc.clone());
        let fill = cr.named("linalg.fill", Named::Fill, &[zero], &[empty], &[conv_ty.clone()], Vec::new());
        let zt = cr.rw.body[fill].results[0];
        let bias_empty = cr.empty(&rdims, re.clone(), &dyn_dims);
        let maps = [Self::broadcasting_map(cr, bias, bias_empty), AffineMap::identity(rank as u32), AffineMap::identity(rank as u32)];
        let props = vec![("strides", i64_elements(&stride, false)), ("dilations", i64_elements(&dil, false))];
        let reassoc: Vec<Vec<i64>> = (0..rank as i64).map(|i| if i as usize == rank - 1 { vec![i, i + 1] } else { vec![i] }).collect();
        let float = matches!(ie, Type::Float(_));
        let result = if null {
            let c = Self::yaml_named(cr, "linalg.depthwise_conv_2d_nhwc_hwcm", Named::MulAdd, &[input, weight], &[zt], &conv_ty, props, &stride, &dil);
            let mut v = cr.rw.body[c].results[0];
            if acc != re {
                v = cr.emit(&tosa::CastOp::new(v.into(), Self::ty(cr, v), tensor_type(&conv_dims, re.clone())));
            }
            let r = cr.collapse(v, &reassoc, rt.clone());
            let g = cr.generic(core::slice::from_ref(&rt), &[bias, r], &[bias_empty], &maps, &vec![true; rank], &mut |cr, a| vec![cr.bin(if float { "arith.addf" } else { "arith.addi" }, a[0], a[1])]);
            cr.rw.body[g].results[0]
        } else {
            let i = cr.constant(int_attr(i128::from(izp), &Type::int(32)), Type::int(32));
            let k = cr.constant(int_attr(i128::from(wzp), &Type::int(32)), Type::int(32));
            let c = Self::yaml_named(cr, "linalg.depthwise_conv_2d_nhwc_hwcm_q", Named::MulAddZp, &[input, weight, i, k], &[zt], &conv_ty, props, &stride, &dil);
            let v = cr.rw.body[c].results[0];
            let r = cr.collapse(v, &reassoc, rt.clone());
            // `linalgIntBroadcastExtSIAdd`.
            let g = cr.generic(core::slice::from_ref(&rt), &[bias, r], &[bias_empty], &maps, &vec![true; rank], &mut |cr, a| {
                let rt = Self::ty(cr, a[1]);
                let bv = if Self::ty(cr, a[0]) != rt { cr.op1("arith.extsi", &[a[0]], rt) } else { a[0] };
                vec![cr.bin("arith.addi", bv, a[1])]
            });
            cr.rw.body[g].results[0]
        };
        cr.replace_values(op, &[result]);
        true
    }

    /// The default `indexing_maps` of `linalg.batch_matmul`.
    fn batch_matmul_maps<'a>() -> Attribute<'a> {
        let m = |r: [u32; 3]| crate::canon::map_attr(&AffineMap { dims: 4, syms: 0, results: r.iter().map(|d| AffineExpr::Dim(*d)).collect() });
        Attribute::Array(vec![m([0, 1, 3]), m([0, 3, 2]), m([0, 1, 2])])
    }

    /// `MatMulConverter`.
    #[lowering("tosa.matmul", untyped)]
    fn matmul(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (a0, a1, azv, bzv) = (b[op].operands[0], b[op].operands[1], b[op].operands[2], b[op].operands[3]);
        let ot = Self::ty(cr, cr.rw.body[op].results[0]);
        let od = dims_of(&ot);
        let mut dyn_dims = Vec::new();
        for (i, (src, d)) in [(a0, 0), (a0, 1), (a1, 2)].iter().enumerate() {
            if od[i] == DYNAMIC {
                dyn_dims.push(cr.tdim(*src, *d));
            }
        }
        let oe = Self::elem(&ot);
        let zero = cr.constant(Self::zero(&oe), oe.clone());
        let empty = cr.empty(&od, oe, &dyn_dims);
        let fill = cr.named("linalg.fill", Named::Fill, &[zero], &[empty], core::slice::from_ref(&ot), Vec::new());
        let zt = cr.rw.body[fill].results[0];
        let (Some(az), Some(bz)) = (Self::zero_point(cr, azv), Self::zero_point(cr, bzv)) else { return false };
        if !Self::zp_ok(cr, azv, az) || !Self::zp_ok(cr, bzv, bz) {
            return false;
        }
        let (a, bb) = (o[0][0], o[1][0]);
        let r = if az == 0 && bz == 0 {
            cr.named("linalg.batch_matmul", Named::MulAdd, &[a, bb], &[zt], core::slice::from_ref(&ot), vec![("indexing_maps", Self::batch_matmul_maps())])
        } else {
            let ac = cr.constant(int_attr(i128::from(az), &Type::int(32)), Type::int(32));
            let bc = cr.constant(int_attr(i128::from(bz), &Type::int(32)), Type::int(32));
            Self::yaml_named(cr, "linalg.quantized_batch_matmul", Named::MulAddZp, &[a, bb, ac, bc], &[zt], &ot, Vec::new(), &[], &[])
        };
        let v = cr.rw.body[r].results[0];
        cr.replace_values(op, &[v]);
        true
    }

    /// `linalg.memoized_indexing_maps` of the OpDSL named ops, which compute their maps from
    /// `strides` / `dilations` (scalar operands, such as zero points, take `() -> ()`).
    fn memoized<'a>(name: &str, stride: &[i64], dil: &[i64]) -> Option<Attribute<'a>> {
        let d = AffineExpr::Dim;
        let at = |o: u32, k: u32, i: usize| d(o).mul_const(stride[i]).add(d(k).mul_const(dil[i]));
        let ds = |v: &[u32]| v.iter().map(|x| d(*x)).collect::<Vec<_>>();
        let (n, maps): (u32, Vec<Vec<AffineExpr>>) = match name.trim_end_matches("_q") {
            "linalg.conv_2d_nhwc_fhwc" => (7, vec![vec![d(0), at(1, 4, 0), at(2, 5, 1), d(6)], ds(&[3, 4, 5, 6]), ds(&[0, 1, 2, 3])]),
            "linalg.conv_2d_nhwc_hwcf" => (7, vec![vec![d(0), at(1, 4, 0), at(2, 5, 1), d(6)], ds(&[4, 5, 6, 3]), ds(&[0, 1, 2, 3])]),
            "linalg.conv_3d_ndhwc_dhwcf" => (9, vec![vec![d(0), at(1, 5, 0), at(2, 6, 1), at(3, 7, 2), d(8)], ds(&[5, 6, 7, 8, 4]), ds(&[0, 1, 2, 3, 4])]),
            "linalg.depthwise_conv_2d_nhwc_hwcm" => (7, vec![vec![d(0), at(1, 5, 0), at(2, 6, 1), d(3)], ds(&[5, 6, 3, 4]), ds(&[0, 1, 2, 3, 4])]),
            "linalg.quantized_batch_matmul" => (4, vec![ds(&[0, 1, 3]), ds(&[0, 3, 2]), ds(&[0, 1, 2])]),
            n if n.starts_with("linalg.pooling_nhwc") => (6, vec![vec![d(0), at(1, 4, 0), at(2, 5, 1), d(3)], ds(&[4, 5]), ds(&[0, 1, 2, 3])]),
            _ => return None,
        };
        let mut maps: Vec<AffineMap> = maps.into_iter().map(|r| AffineMap { dims: n, syms: 0, results: r }.simplified()).collect();
        if name.ends_with("_q") || name == "linalg.quantized_batch_matmul" {
            let unit = AffineMap { dims: n, syms: 0, results: Vec::new() };
            maps.insert(2, unit.clone());
            maps.insert(3, unit);
        }
        Some(Attribute::Array(maps.iter().map(crate::canon::map_attr).collect()))
    }

    /// A named op with its OpDSL body, memoized maps attached as verification leaves them.
    fn yaml_named<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, kind: Named, inputs: &[ValueId], outputs: &[ValueId], rt: &Type<'a>, props: Vec<(&str, Attribute<'a>)>, stride: &[i64], dil: &[i64]) -> OpId {
        let p = cr.named(name, kind, inputs, outputs, core::slice::from_ref(rt), props);
        if let Some(m) = Self::memoized(name, stride, dil) {
            cr.rw.body[p].attributes.push(mlirformat::NamedAttr { name: "linalg.memoized_indexing_maps".into(), value: Some(m) });
        }
        p
    }

    fn pooling<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, kind: Named, inputs: &[ValueId], init: ValueId, rt: &Type<'a>, stride: &[i64]) -> OpId {
        let props = vec![("strides", i64_elements(stride, true)), ("dilations", i64_elements(&[1, 1], true))];
        Self::yaml_named(cr, name, kind, inputs, &[init], rt, props, stride, &[1, 1])
    }

    /// `MaxPool2dConverter`.
    #[lowering("tosa.max_pool2d")]
    fn max_pool(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let input = o[0][0];
        let it = Self::ty(cr, input);
        let ot = Self::ty(cr, cr.rw.body[op].results[0]);
        let unsigned = matches!(Self::elem(&ot), Type::Integer { signedness: mlirformat::Signedness::Unsigned, .. });
        let Some(rt) = cr.type_converter().and_then(|tc| tc.convert(&ot)) else { return false };
        let re = Self::elem(&it);
        let (kernel, pad_a, stride) = (Self::ints(cr, op, "kernel"), Self::ints(cr, op, "pad"), Self::ints(cr, op, "stride"));
        // `computeDynamicOutputSizes`.
        let rd = dims_of(&ot);
        let mut dyn_dims = Vec::new();
        if rd[0] == DYNAMIC {
            dyn_dims.push(cr.tdim(input, 0));
        }
        for dim in [1usize, 2] {
            if rd[dim] != DYNAMIC {
                continue;
            }
            let i = dim - 1;
            let ihw = cr.tdim(input, dim as i64);
            let khw = cr.cidx(kernel[i]);
            dyn_dims.push(Self::output_dim(cr, ihw, pad_a[2 * i], pad_a[2 * i + 1], khw, stride[i], 1));
        }
        if rd[3] == DYNAMIC {
            dyn_dims.push(cr.tdim(input, 3));
        }
        let initial: Attribute = match &re {
            Type::Float(k @ (FloatKind::F32 | FloatKind::BF16 | FloatKind::F16)) => Const::scalar(Scalar::Float(ApFloat::largest(*k, true)), re.clone()).into(),
            Type::Integer { width, .. } if unsigned => int_attr(0, &Type::int(*width)).with_ty(&re),
            Type::Integer { width, .. } => int_attr(-(1i128 << (width - 1)), &re),
            _ => return false,
        };
        let mut pad = vec![0, 0];
        pad.extend(&pad_a);
        pad.extend([0, 0]);
        let padded = Self::apply_pad(cr, input, &pad, initial.clone());
        let iv = cr.constant(initial, re.clone());
        let empty = cr.empty(&dims_of(&rt), Self::elem(&rt), &dyn_dims);
        let fill = cr.named("linalg.fill", Named::Fill, &[iv], &[empty], core::slice::from_ref(&rt), Vec::new());
        let filled = cr.rw.body[fill].results[0];
        let window = cr.empty(&kernel, re.clone(), &[]);
        if unsigned {
            let p = Self::pooling(cr, "linalg.pooling_nhwc_max_unsigned", Named::MaxU, &[padded, window], filled, &rt, &stride);
            let v = cr.rw.body[p].results[0];
            cr.replace_values(op, &[v]);
            return true;
        }
        let p = Self::pooling(cr, "linalg.pooling_nhwc_max", Named::MaxS, &[padded, window], filled, &rt, &stride);
        let v = cr.rw.body[p].results[0];
        let ignore = matches!(cr.rw.body[op].get("nan_mode"), Some(Attribute::Extended { ext, .. }) if ext.body.as_deref().is_some_and(|b| b.contains("IGNORE")));
        if !matches!(re, Type::Float(_)) || !ignore {
            cr.replace_values(op, &[v]);
            return true;
        }
        let maps: Vec<AffineMap> = match &cr.rw.body[p].attributes.last().and_then(|a| a.value.clone()) {
            Some(Attribute::Array(ms)) => ms.iter().filter_map(|m| if let Attribute::Builtin { body, .. } = m { AffineMap::parse(body) } else { None }).collect(),
            _ => Vec::new(),
        };
        let region = cr.rw.body[p].regions[0];
        let block = cr.rw.body[region].blocks[0];
        let (old_args, max_op) = (cr.rw.body[block].args.clone(), cr.rw.body[block].ops[0]);
        let g = cr.generic(core::slice::from_ref(&rt), &[padded, window], &[filled], &maps, &[true, true, true, true, false, false], &mut |cr, a| {
            let mut m = Mapping::default();
            for (x, y) in old_args.iter().zip(a) {
                m.map(*x, *y);
            }
            let c = cr.rw.clone(max_op, &mut m);
            let nan = cr.build(OpData::build("arith.cmpf").operands(&[a[0], a[0]]).with("predicate", Attribute::i64(14)), Type::int(1));
            let r = cr.rw.body[c].results[0];
            let last = *a.last().expect("an output");
            vec![cr.op1("arith.select", &[nan, last, r], Self::ty(cr, r))]
        });
        let gv = cr.rw.body[g].results[0];
        cr.erase(p);
        cr.replace_values(op, &[gv]);
        true
    }

    /// `checkHasDynamicBatchDims`.
    pub fn dynamic_batch(cr: &mut Cr<'_, '_, '_>, params: &[ValueId]) -> Option<Vec<ValueId>> {
        let dynamic: Vec<Vec<i64>> = params.iter().map(|p| dims_of(&Self::ty(cr, *p))).filter(|d| d.contains(&DYNAMIC)).collect();
        if dynamic.is_empty() {
            return Some(Vec::new());
        }
        if dynamic.iter().any(|d| d[1..].contains(&DYNAMIC)) {
            return None;
        }
        Some(vec![cr.tdim(params[0], 0)])
    }

    /// `AvgPool2dConverter`.
    #[lowering("tosa.avg_pool2d", untyped)]
    fn avg_pool(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let (input, izv, ozv, out) = (b[op].operands[0], b[op].operands[1], b[op].operands[2], b[op].results[0]);
        let it = Self::ty(cr, input);
        let ie = Self::elem(&it);
        let rt = Self::ty(cr, out);
        let re = Self::elem(&rt);
        let Some(acc) = Self::acc_type(cr, op) else { return false };
        let acc_ty = tensor_type(&dims_of(&rt), acc.clone());
        let Some(dyn_dims) = Self::dynamic_batch(cr, &[input, out]) else { return false };
        let (Some(izp), Some(ozp)) = (Self::zero_point(cr, izv), Self::zero_point(cr, ozv)) else { return false };
        let (pad_a, kernel, stride) = (Self::ints(cr, op, "pad"), Self::ints(cr, op, "kernel"), Self::ints(cr, op, "stride"));
        let mut pad = vec![0, 0];
        pad.extend(&pad_a);
        pad.extend([0, 0]);
        let padded = Self::apply_pad(cr, input, &pad, Self::zero(&ie));
        let iv = cr.constant(Self::zero(&acc), acc.clone());
        let empty = cr.empty(&dims_of(&acc_ty), acc.clone(), &dyn_dims);
        let fill = cr.named("linalg.fill", Named::Fill, &[iv], &[empty], core::slice::from_ref(&acc_ty), Vec::new());
        let filled = cr.rw.body[fill].results[0];
        let window = cr.empty(&kernel, acc.clone(), &[]);
        let p = Self::pooling(cr, "linalg.pooling_nhwc_sum", Named::Sum, &[padded, window], filled, &acc_ty, &stride);
        let pool = cr.rw.body[p].results[0];
        let ih = cr.tdim(pool, 1);
        let iw = cr.tdim(pool, 2);
        let one = cr.cidx(1);
        let ih = cr.bin("arith.subi", ih, one);
        let iw = cr.bin("arith.subi", iw, one);
        let gempty = cr.empty(&dims_of(&rt), re.clone(), &dyn_dims);
        let rank = dims_of(&rt).len() as u32;
        let id = AffineMap::identity(rank);
        let g = cr.generic(core::slice::from_ref(&rt), &[pool], &[gempty], &[id.clone(), id], &vec![true; rank as usize], &mut |cr, a| {
            let zero = cr.cidx(0);
            let pad_fn = |cr: &mut Cr<'_, '_, '_>, valid: ValueId, pos: ValueId, p: i64| -> ValueId {
                if p == 0 {
                    return valid;
                }
                let pv = cr.cidx(p);
                let dpos = cr.bin("arith.subi", pos, pv);
                let off = cr.bin("arith.minsi", dpos, zero);
                cr.bin("arith.addi", valid, off)
            };
            let coverage = |cr: &mut Cr<'_, '_, '_>, i: usize, isize: ValueId| -> ValueId {
                let sv = cr.cidx(stride[i - 1]);
                let mut val = cr.cidx(kernel[i - 1]);
                let mut left = cr.index(i as i64);
                let mut right = cr.bin("arith.subi", isize, left);
                left = cr.bin("arith.muli", left, sv);
                right = cr.bin("arith.muli", right, sv);
                val = pad_fn(cr, val, left, pad[i * 2]);
                val = pad_fn(cr, val, right, pad[i * 2 + 1]);
                cr.bin("arith.maxsi", one, val)
            };
            let kh = coverage(cr, 1, ih);
            let kw = coverage(cr, 2, iw);
            let m = cr.bin("arith.muli", kh, kw);
            let count = cr.op1("arith.index_cast", &[m], Type::int(32));
            let mut pv = a[0];
            if matches!(acc, Type::Float(_)) {
                let cf = cr.op1("arith.sitofp", &[count], acc.clone());
                pv = cr.bin("arith.divf", pv, cf);
                if crate::bit_width(&acc) > crate::bit_width(&re) {
                    pv = cr.op1("arith.truncf", &[pv], re.clone());
                }
                return vec![pv];
            }
            if izp != 0 {
                let z = cr.constant(int_attr(i128::from(izp), &acc), acc.clone());
                let off = cr.op1("arith.muli", &[count, z], acc.clone());
                pv = cr.op1("arith.subi", &[pv, off], acc.clone());
            }
            let i32t = Type::int(32);
            let one32 = cr.constant(int_attr(1, &i32t), i32t.clone());
            let t32 = cr.constant(int_attr(32, &i32t), i32t.clone());
            let csub = cr.bin("arith.subi", count, one32);
            let lz = cr.op1("math.ctlz", &[csub], i32t.clone());
            let k = cr.bin("arith.subi", t32, lz);
            let k64 = cr.op1("arith.extui", &[k], Type::int(64));
            let tsp = cr.constant(int_attr((1 << 30) + 1, &Type::int(64)), Type::int(64));
            let num = cr.bin("arith.shli", tsp, k64);
            let c64 = cr.op1("arith.extui", &[count], Type::int(64));
            let mult = cr.bin("arith.divui", num, c64);
            let mult = cr.op1("arith.trunci", &[mult], i32t.clone());
            let k8 = cr.op1("arith.trunci", &[k], Type::int(8));
            let t8 = cr.constant(int_attr(30, &Type::int(8)), Type::int(8));
            let shift = cr.bin("arith.addi", k8, t8);
            let rounding = Attribute::dialect("tosa.rounding_mode", "<SINGLE_ROUND>");
            let tys = cr.rw.body.types(&[pv, mult, shift]);
            let mut scaled = cr.emit(&tosa::ApplyScaleOp::new(pv.into(), mult.into(), shift.into(), rounding, tys[0].clone(), tys[1].clone(), tys[2].clone(), i32t.clone()));
            if ozp != 0 {
                let st = Self::ty(cr, scaled);
                let z = cr.constant(int_attr(i128::from(ozp), &st), st);
                scaled = cr.bin("arith.addi", scaled, z);
            }
            let w = crate::bit_width(&re).unwrap_or(32);
            let mn = cr.constant(int_attr(-(1i128 << (w - 1)), &acc), acc.clone());
            let mx = cr.constant(int_attr((1i128 << (w - 1)) - 1, &acc), acc.clone());
            let lo = cr.bin("arith.maxsi", mn, scaled);
            let mut c = cr.bin("arith.minsi", mx, lo);
            if re != Self::ty(cr, c) {
                c = cr.op1("arith.trunci", &[c], re.clone());
            }
            vec![c]
        });
        let gv = cr.rw.body[g].results[0];
        cr.replace_values(op, &[gv]);
        true
    }

    /// `TransposeConverter`.
    #[lowering("tosa.transpose", untyped)]
    fn transpose(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let input = cr.rw.body[op].operands[0];
        let perms: Vec<i64> = match cr.rw.body[op].get("perms") {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => return false,
        };
        let sizes = cr.mixed_sizes(input);
        let permuted: Vec<Ofr> = perms.iter().map(|p| sizes[*p as usize]).collect();
        let e = Self::elem(&Self::ty(cr, input));
        let init = cr.empty_mixed(&permuted, e);
        let it = Self::ty(cr, init);
        let t = cr.named("linalg.transpose", Named::Copy, &[input], &[init], &[it], vec![("permutation", dense_i64(&perms))]);
        let v = cr.rw.body[t].results[0];
        cr.replace_values(op, &[v]);
        true
    }

}

/// An integer attribute re-typed.
trait WithTy<'a> {
    fn with_ty(self, ty: &Type<'a>) -> Self;
}

impl<'a> WithTy<'a> for Attribute<'a> {
    fn with_ty(self, ty: &Type<'a>) -> Self {
        match self {
            Attribute::Int { lit, .. } => Attribute::Int { lit, ty: Some(ty.clone()) },
            a => a,
        }
    }
}
