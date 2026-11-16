use alloc::vec;
use alloc::vec::Vec;

use mlirformat::spirv_types::SpirvType;
use mlirformat::{ApFloat, Attribute, Const, FloatKind, Scalar, Type};

use crate::{ArithToSpirv, Builtin, ConversionRewriter, GlslToSpirv, OpData, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

type Elt = (u32, u32);

struct Cofactor {
    negated: bool,
    terms: [(Elt, usize); 3],
}

struct Minor([Elt; 4]);

impl Minor {
    const MAT4: [Minor; 19] = [
        Minor([(2, 2), (3, 3), (3, 2), (2, 3)]),
        Minor([(2, 1), (3, 3), (3, 1), (2, 3)]),
        Minor([(2, 1), (3, 2), (3, 1), (2, 2)]),
        Minor([(2, 0), (3, 3), (3, 0), (2, 3)]),
        Minor([(2, 0), (3, 2), (3, 0), (2, 2)]),
        Minor([(2, 0), (3, 1), (3, 0), (2, 1)]),
        Minor([(1, 2), (3, 3), (3, 2), (1, 3)]),
        Minor([(1, 1), (3, 3), (3, 1), (1, 3)]),
        Minor([(1, 1), (3, 2), (3, 1), (1, 2)]),
        Minor([(1, 0), (3, 3), (3, 0), (1, 3)]),
        Minor([(1, 0), (3, 2), (3, 0), (1, 2)]),
        Minor([(1, 1), (3, 3), (3, 1), (1, 3)]),
        Minor([(1, 0), (3, 1), (3, 0), (1, 1)]),
        Minor([(1, 2), (2, 3), (2, 2), (1, 3)]),
        Minor([(1, 1), (2, 3), (2, 1), (1, 3)]),
        Minor([(1, 1), (2, 2), (2, 1), (1, 2)]),
        Minor([(1, 0), (2, 3), (2, 0), (1, 3)]),
        Minor([(1, 0), (2, 2), (2, 0), (1, 2)]),
        Minor([(1, 0), (2, 1), (2, 0), (1, 1)]),
    ];

    const MAT3: [[Minor; 3]; 3] = [
        [Minor([(1, 1), (2, 2), (2, 1), (1, 2)]), Minor([(0, 1), (2, 2), (2, 1), (0, 2)]), Minor([(0, 1), (1, 2), (1, 1), (0, 2)])],
        [Minor([(1, 0), (2, 2), (2, 0), (1, 2)]), Minor([(0, 0), (2, 2), (2, 0), (0, 2)]), Minor([(0, 0), (1, 2), (1, 0), (0, 2)])],
        [Minor([(1, 0), (2, 1), (2, 0), (1, 1)]), Minor([(0, 0), (2, 1), (2, 0), (0, 1)]), Minor([(0, 0), (1, 1), (1, 0), (0, 1)])],
    ];
}

impl Cofactor {
    const fn plus(terms: [(Elt, usize); 3]) -> Cofactor {
        Cofactor { negated: false, terms }
    }

    const fn minus(terms: [(Elt, usize); 3]) -> Cofactor {
        Cofactor { negated: true, terms }
    }

    const MAT4: [[Cofactor; 4]; 4] = [
        [
            Cofactor::plus([((1, 1), 0), ((1, 2), 1), ((1, 3), 2)]),
            Cofactor::minus([((0, 1), 0), ((0, 2), 1), ((0, 3), 2)]),
            Cofactor::plus([((0, 1), 6), ((0, 2), 7), ((0, 3), 8)]),
            Cofactor::minus([((0, 1), 13), ((0, 2), 14), ((0, 3), 15)]),
        ],
        [
            Cofactor::minus([((1, 0), 0), ((1, 2), 3), ((1, 3), 4)]),
            Cofactor::plus([((0, 0), 0), ((0, 2), 3), ((0, 3), 4)]),
            Cofactor::minus([((0, 0), 6), ((0, 2), 9), ((0, 3), 10)]),
            Cofactor::plus([((0, 0), 13), ((0, 2), 16), ((0, 3), 17)]),
        ],
        [
            Cofactor::plus([((1, 0), 1), ((1, 1), 3), ((1, 3), 5)]),
            Cofactor::minus([((0, 0), 1), ((0, 1), 3), ((0, 3), 5)]),
            Cofactor::plus([((0, 0), 11), ((0, 1), 9), ((0, 3), 12)]),
            Cofactor::minus([((0, 0), 14), ((0, 1), 16), ((0, 3), 18)]),
        ],
        [
            Cofactor::minus([((1, 0), 2), ((1, 1), 4), ((1, 2), 5)]),
            Cofactor::plus([((0, 0), 2), ((0, 1), 4), ((0, 2), 5)]),
            Cofactor::minus([((0, 0), 8), ((0, 1), 10), ((0, 2), 12)]),
            Cofactor::plus([((0, 0), 15), ((0, 1), 17), ((0, 2), 18)]),
        ],
    ];

    const MAT3_SIGN: [[bool; 3]; 3] = [[false, true, false], [true, false, true], [false, true, false]];
}

struct Asin;

impl Asin {
    const P0: f32 = 0.086_566_724;
    const P1: f32 = -0.031_029_55;
    const HALF_PI: f32 = core::f32::consts::FRAC_PI_2;
    const QUARTER_PI_MINUS_ONE: f32 = core::f32::consts::FRAC_PI_4 - 1.0;
}

struct Ops<'c, 'r, 'a, 'p> {
    cr: &'c mut Cr<'r, 'a, 'p>,
    float: Type<'a>,
}

impl<'a> Ops<'_, '_, 'a, '_> {
    const WORD: u32 = 32;
    const CONSTANT: &'static str = "spirv.Constant";
    const ARITH_CONSTANT: &'static str = "arith.constant";
    const CONSTRUCT: &'static str = "spirv.CompositeConstruct";

    fn shape(t: &Type<'a>) -> Option<(usize, Type<'a>)> {
        match SpirvType::try_from(t) {
            Ok(SpirvType::Matrix { cols, column }) => Some((cols as usize, *column)),
            _ => None,
        }
    }

    fn lanes(t: &Type<'a>) -> Option<u32> {
        match t {
            Type::Shaped(s) => match s.shape.as_deref() {
                Some([mlirformat::Dim::Static(n)]) => u32::try_from(*n).ok(),
                _ => None,
            },
            _ => Some(1),
        }
    }

    fn op(&mut self, name: &'static str, args: &[ValueId], ty: &Type<'a>) -> ValueId {
        self.cr.build(OpData::build(name).operands(args), ty.clone())
    }

    fn k(&mut self, v: f32, ty: &Type<'a>) -> ValueId {
        let attr = ArithToSpirv::splat(ty, |_| Scalar::Float(ApFloat { kind: FloatKind::F32, bits: u64::from(v.to_bits()) }));
        self.cr.spirv_const(ty.clone(), attr)
    }

    fn mul(&mut self, a: ValueId, b: ValueId, ty: &Type<'a>) -> ValueId {
        self.op("spirv.FMul", &[a, b], ty)
    }

    fn add(&mut self, a: ValueId, b: ValueId, ty: &Type<'a>) -> ValueId {
        self.op("spirv.FAdd", &[a, b], ty)
    }

    fn sub(&mut self, a: ValueId, b: ValueId, ty: &Type<'a>) -> ValueId {
        self.op("spirv.FSub", &[a, b], ty)
    }

    fn neg(&mut self, a: ValueId, ty: &Type<'a>) -> ValueId {
        self.op("spirv.FNegate", &[a], ty)
    }

    fn extract(&mut self, m: ValueId, at: &[u32], ty: &Type<'a>) -> ValueId {
        let indices = Attribute::Array(at.iter().map(|&i| Attribute::of_int(i128::from(i), Type::int(Ops::WORD))).collect());
        self.cr.build(OpData::build("spirv.CompositeExtract").operands(&[m]).with("indices", indices), ty.clone())
    }

    fn elt(&mut self, m: ValueId, (c, r): Elt) -> ValueId {
        let f = self.float.clone();
        self.extract(m, &[c, r], &f)
    }

    fn splat(&mut self, v: ValueId, n: u32, ty: &Type<'a>) -> ValueId {
        self.op("spirv.CompositeConstruct", &Vec::from_iter((0..n).map(|_| v)), ty)
    }

    fn vector(&mut self, lanes: &[ValueId], ty: &Type<'a>) -> ValueId {
        self.op("spirv.CompositeConstruct", lanes, ty)
    }

    fn product_difference(&mut self, m: ValueId, Minor([a, b, c, d]): &Minor) -> ValueId {
        let f = self.float.clone();
        let (a, b, c, d) = (self.elt(m, *a), self.elt(m, *b), self.elt(m, *c), self.elt(m, *d));
        let ab = self.mul(a, b, &f);
        let cd = self.mul(c, d, &f);
        self.sub(ab, cd, &f)
    }

    fn cofactor(&mut self, m: ValueId, minors: &[ValueId], c: &Cofactor) -> ValueId {
        let f = self.float.clone();
        let [(e0, s0), (e1, s1), (e2, s2)] = c.terms;
        let (x0, x1, x2) = (self.elt(m, e0), self.elt(m, e1), self.elt(m, e2));
        let p0 = self.mul(x0, minors[s0], &f);
        let p1 = self.mul(x1, minors[s1], &f);
        let d = self.sub(p0, p1, &f);
        let p2 = self.mul(x2, minors[s2], &f);
        let v = self.add(d, p2, &f);
        if c.negated { self.neg(v, &f) } else { v }
    }

    fn asin(&mut self, x: ValueId, ty: &Type<'a>) -> ValueId {
        let a = self.op("spirv.GL.FAbs", &[x], ty);
        let p1 = self.k(Asin::P1, ty);
        let t = self.mul(a, p1, ty);
        let p0 = self.k(Asin::P0, ty);
        let t = self.add(p0, t, ty);
        let t = self.mul(a, t, ty);
        let c = self.k(Asin::QUARTER_PI_MINUS_ONE, ty);
        let t = self.add(c, t, ty);
        let t = self.mul(a, t, ty);
        let half_pi = self.k(Asin::HALF_PI, ty);
        let t = self.add(half_pi, t, ty);
        let one = self.k(1.0, ty);
        let s = self.sub(one, a, ty);
        let s = self.op("spirv.GL.Sqrt", &[s], ty);
        let t = self.mul(s, t, ty);
        let half_pi = self.k(Asin::HALF_PI, ty);
        let t = self.sub(half_pi, t, ty);
        let sign = self.op("spirv.GL.FSign", &[x], ty);
        self.mul(sign, t, ty)
    }

    fn floats(&self, v: ValueId) -> Option<Vec<f32>> {
        let body = &self.cr.rw.body;
        let d = body.def_op(v)?;
        match &*body[d].name {
            Ops::CONSTANT | Ops::ARITH_CONSTANT => {
                let c = Const::try_from(body[d].get("value")?).ok()?;
                let n = Ops::lanes(&body[v].ty)? as usize;
                let one = |s: &Scalar| match s {
                    Scalar::Float(f) if f.kind == FloatKind::F32 => u32::try_from(f.bits).ok().map(f32::from_bits),
                    _ => None,
                };
                match &c.values[..] {
                    [s] => Some(vec![one(s)?; n]),
                    many => many.iter().map(one).collect(),
                }
            }
            Ops::CONSTRUCT => {
                let mut out = Vec::new();
                for &o in &body[d].operands {
                    out.extend(self.floats(o)?);
                }
                Some(out)
            }
            _ => None,
        }
    }

    fn folded(&mut self, values: &[f32], ty: &Type<'a>) -> ValueId {
        let scalar = |f: f32| Scalar::Float(ApFloat { kind: FloatKind::F32, bits: u64::from(f.to_bits()) });
        let attr: Attribute<'a> = match values {
            [one] => Const::scalar(scalar(*one), ty.clone()).into(),
            many => Const { ty: ty.clone(), values: many.iter().map(|&f| scalar(f)).collect(), elements: true }.into(),
        };
        self.cr.spirv_const(ty.clone(), attr)
    }

    fn dot_f(a: &[f32], b: &[f32]) -> f32 {
        a.iter().zip(b).fold(0.0, |acc, (x, y)| acc + x * y)
    }

    fn fold(&mut self, func: Builtin, args: &[ValueId], ty: &Type<'a>) -> Option<ValueId> {
        let vals = args.iter().map(|&a| self.floats(a)).collect::<Option<Vec<_>>>()?;
        let out = match (func, &vals[..]) {
            (Builtin::Dot, [a, b]) => vec![Ops::dot_f(a, b)],
            (Builtin::Length, [a]) => vec![libm::sqrtf(Ops::dot_f(a, a))],
            (Builtin::Distance, [a, b]) => {
                let p: Vec<f32> = a.iter().zip(b).map(|(x, y)| x - y).collect();
                vec![libm::sqrtf(Ops::dot_f(&p, &p))]
            }
            (Builtin::Normalize, [a]) => {
                let r = 1.0 / libm::sqrtf(Ops::dot_f(a, a));
                a.iter().map(|x| x * r).collect()
            }
            _ => return None,
        };
        Some(self.folded(&out, ty))
    }

    fn refract(&mut self, i: ValueId, n: ValueId, eta: ValueId, (lanes, ty): (u32, &Type<'a>)) -> ValueId {
        let f = self.float.clone();
        let ndi = self.op("spirv.Dot", &[n, i], &f);
        let one = self.k(1.0, &f);
        let sq = self.mul(ndi, ndi, &f);
        let k = self.sub(one, sq, &f);
        let k = self.mul(eta, k, &f);
        let k = self.mul(eta, k, &f);
        let one = self.k(1.0, &f);
        let k = self.sub(one, k, &f);
        let zero = self.k(0.0, &f);
        let negative = self.op("spirv.FOrdLessThan", &[k, zero], &Type::I1);
        let etas = self.splat(eta, lanes, ty);
        let ei = self.mul(etas, i, ty);
        let en = self.mul(eta, ndi, &f);
        let root = self.op("spirv.GL.Sqrt", &[k], &f);
        let scale = self.add(en, root, &f);
        let scales = self.splat(scale, lanes, ty);
        let sn = self.mul(scales, n, ty);
        let r = self.sub(ei, sn, ty);
        let zeros = self.k(0.0, ty);
        let mask_ty = Type::vector(&[i64::from(lanes)], &[], Type::I1);
        let mask = if lanes == 1 { negative } else { self.splat(negative, lanes, &mask_ty) };
        self.op("spirv.Select", &[mask, zeros, r], ty)
    }

    fn det4(&mut self, m: ValueId, column: &Type<'a>) -> ValueId {
        let minors: Vec<ValueId> = Minor::MAT4.iter().map(|x| self.product_difference(m, x)).collect();
        let adj0: Vec<ValueId> = Cofactor::MAT4.iter().map(|col| self.cofactor(m, &minors, &col[0])).collect();
        let adj0 = self.vector(&adj0, column);
        let col0 = self.extract(m, &[0], column);
        let f = self.float.clone();
        self.op("spirv.Dot", &[col0, adj0], &f)
    }

    fn inverse(&mut self, m: ValueId, n: u32, (column, ty): (&Type<'a>, &Type<'a>)) -> ValueId {
        let f = self.float.clone();
        let (adj, det) = if n == 4 {
            let minors: Vec<ValueId> = Minor::MAT4.iter().map(|x| self.product_difference(m, x)).collect();
            let adj: Vec<Vec<ValueId>> = Cofactor::MAT4.iter().map(|col| col.iter().map(|c| self.cofactor(m, &minors, c)).collect()).collect();
            let mut det = None;
            for j in (0..4).rev() {
                let x = self.elt(m, (0, j));
                let p = self.mul(x, adj[j as usize][0], &f);
                det = Some(match det {
                    None => p,
                    Some(rest) => self.add(p, rest, &f),
                });
            }
            (adj, det.unwrap_or_else(|| unreachable!()))
        } else {
            let mut adj = Vec::new();
            for (j, col) in Minor::MAT3.iter().enumerate() {
                let mut lanes = Vec::new();
                for (r, minor) in col.iter().enumerate() {
                    let v = self.product_difference(m, minor);
                    lanes.push(if Cofactor::MAT3_SIGN[j][r] { self.neg(v, &f) } else { v });
                }
                adj.push(lanes);
            }
            let f11 = self.product_difference(m, &Minor::MAT3[0][0]);
            let f10 = self.product_difference(m, &Minor::MAT3[1][0]);
            let f1011 = self.product_difference(m, &Minor::MAT3[2][0]);
            let (m00, m01, m02) = (self.elt(m, (0, 0)), self.elt(m, (0, 1)), self.elt(m, (0, 2)));
            let a = self.mul(m00, f11, &f);
            let b = self.mul(m01, f10, &f);
            let d = self.sub(a, b, &f);
            let c = self.mul(m02, f1011, &f);
            (adj, self.add(d, c, &f))
        };
        let dets = self.splat(det, n, column);
        let cols: Vec<ValueId> = adj
            .iter()
            .map(|lanes| {
                let v = self.vector(lanes, column);
                self.op("spirv.FDiv", &[v, dets], column)
            })
            .collect();
        self.vector(&cols, ty)
    }
}

impl GlslToSpirv {
    pub(crate) fn as_glsl_compiler<'a>(cr: &mut Cr<'_, 'a, '_>, func: Builtin, args: &[ValueId], ty: &Type<'a>) -> Option<ValueId> {
        let float = Type::Float(FloatKind::F32);
        let arg_ty = |cr: &Cr<'_, 'a, '_>, i: usize| args.get(i).map(|&v| cr.rw.body[v].ty.clone());
        let shape = arg_ty(cr, 0).and_then(|t| Ops::shape(&t));
        let mut o = Ops { cr, float };
        let scalar = Ops::lanes(ty) == Some(1) && arg_ty(o.cr, 0).as_ref().and_then(Ops::lanes) == Some(1);
        if matches!(func, Builtin::Dot | Builtin::Length | Builtin::Distance | Builtin::Normalize)
            && !scalar
            && let Some(v) = o.fold(func, args, ty)
        {
            return Some(v);
        }
        match (func, args, shape) {
            (Builtin::Normalize, [x], _) if scalar => Some(o.op("spirv.GL.FSign", &[*x], ty)),
            (Builtin::Length, [x], _) if scalar => {
                let sq = o.mul(*x, *x, ty);
                Some(o.op("spirv.GL.Sqrt", &[sq], ty))
            }
            (Builtin::Distance, [a, b], _) if scalar => {
                let d = o.sub(*a, *b, ty);
                Some(o.op("spirv.GL.FAbs", &[d], ty))
            }
            (Builtin::Asin, [x], _) => Some(o.asin(*x, ty)),
            (Builtin::Refract, [i, n, eta], _) => Some(o.refract(*i, *n, *eta, (Ops::lanes(ty)?, ty))),
            (Builtin::Determinant, [m], Some((4, column))) => Some(o.det4(*m, &column)),
            (Builtin::Inverse, [m], Some((n @ (3 | 4), column))) => Some(o.inverse(*m, n as u32, (&column, ty))),
            _ => None,
        }
    }
}
