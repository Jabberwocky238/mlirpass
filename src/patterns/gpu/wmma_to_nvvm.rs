use alloc::format;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, FloatKind, Signedness, Type};

use super::wmma_nvvm_gen as tables;
use crate::patterns;
use crate::{ConversionRewriter, LlvmOptions, MemrefToLlvm, OpData, OpId, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MmaLayout {
    Row,
    Col,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MmaType {
    F16,
    F32,
    Tf32,
    F64,
    S8,
    U8,
    S32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum MmaFrag {
    A,
    B,
    C,
}

impl MmaLayout {
    const fn name(self) -> &'static str {
        match self {
            MmaLayout::Row => "row",
            MmaLayout::Col => "col",
        }
    }

    fn of(transpose: bool) -> Self {
        if transpose { MmaLayout::Col } else { MmaLayout::Row }
    }
}

impl MmaType {
    const fn name(self) -> &'static str {
        match self {
            MmaType::F16 => "f16",
            MmaType::F32 => "f32",
            MmaType::Tf32 => "tf32",
            MmaType::F64 => "f64",
            MmaType::S8 => "s8",
            MmaType::U8 => "u8",
            MmaType::S32 => "s32",
        }
    }
}

impl MmaFrag {
    const fn name(self) -> &'static str {
        match self {
            MmaFrag::A => "a",
            MmaFrag::B => "b",
            MmaFrag::C => "c",
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum Elementwise {
    AddF,
    MulF,
    DivF,
    MaxF,
    MinF,
}

impl Elementwise {
    const NAMES: [(&'static str, Self); 5] = [("addf", Self::AddF), ("mulf", Self::MulF), ("divf", Self::DivF), ("maxf", Self::MaxF), ("minf", Self::MinF)];
}

impl TryFrom<&Attribute<'_>> for Elementwise {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        let Attribute::Extended { ext, .. } = a else { return Err(()) };
        let case = ext.body.as_deref().and_then(|b| b.strip_prefix('<')?.strip_suffix('>')?.trim().strip_prefix("mma_element_wise")).ok_or(())?.trim();
        Self::NAMES.iter().find(|(n, _)| *n == case).map(|(_, v)| *v).ok_or(())
    }
}

#[derive(Debug, Clone)]
pub struct MmaMatrix {
    pub rows: i64,
    pub cols: i64,
    pub elem: Type<'static>,
    pub frag: MmaFrag,
}

impl TryFrom<&Type<'_>> for MmaMatrix {
    type Error = ();
    fn try_from(t: &Type<'_>) -> Result<Self, ()> {
        let Type::Extended(e) = t else { return Err(()) };
        if e.name != "gpu.mma_matrix" {
            return Err(());
        }
        let body = e.body.as_deref().ok_or(())?.trim().strip_prefix('<').and_then(|b| b.strip_suffix('>')).ok_or(())?;
        let (shape, operand) = body.rsplit_once(',').ok_or(())?;
        let frag = match operand.trim().trim_matches('"') {
            "AOp" => MmaFrag::A,
            "BOp" => MmaFrag::B,
            "COp" => MmaFrag::C,
            _ => return Err(()),
        };
        let text = format!("vector<{}>", shape.trim());
        let Ok(Type::Shaped(s)) = mlirformat::Parser::read(&text, |p| p.ty()) else { return Err(()) };
        let dims = s.dims().ok_or(())?;
        let [rows, cols] = dims[..] else { return Err(()) };
        Ok(Self { rows, cols, elem: (*s.elem).owned(), frag })
    }
}

impl MmaMatrix {
    fn mma_type(&self) -> Option<MmaType> {
        Some(match &self.elem {
            Type::Float(FloatKind::F16) => MmaType::F16,
            Type::Float(FloatKind::F32) if self.frag == MmaFrag::C => MmaType::F32,
            Type::Float(FloatKind::F32) => MmaType::Tf32,
            Type::Float(FloatKind::F64) => MmaType::F64,
            Type::Integer { width: 8, signedness: Signedness::Signed } => MmaType::S8,
            Type::Integer { width: 8, signedness: Signedness::Unsigned } => MmaType::U8,
            Type::Integer { width: 32, .. } => MmaType::S32,
            _ => return None,
        })
    }

    fn registers(&self) -> Option<(Type<'static>, usize)> {
        let ab = matches!(self.frag, MmaFrag::A | MmaFrag::B);
        let f16x2 = Type::vector(&[2], &[false], Type::Float(FloatKind::F16));
        Some(match self.mma_type()? {
            MmaType::F16 => (f16x2, if ab { 8 } else { 4 }),
            MmaType::F32 => (Type::Float(FloatKind::F32), 8),
            MmaType::F64 => (Type::Float(FloatKind::F64), if ab { 1 } else { 2 }),
            MmaType::Tf32 => (Type::int(32), 4),
            MmaType::S8 | MmaType::U8 => {
                let parallel = match self.frag {
                    MmaFrag::A => self.rows,
                    MmaFrag::B => self.cols,
                    MmaFrag::C => 0,
                };
                let n = match parallel {
                    16 => 2,
                    8 => 1,
                    32 => 4,
                    _ => return None,
                };
                (Type::int(32), n)
            }
            MmaType::S32 => (Type::int(32), 8),
        })
    }

    pub fn llvm(&self) -> Option<Type<'static>> {
        let (t, n) = self.registers()?;
        if t == Type::Float(FloatKind::F64) && n == 1 {
            return Some(t);
        }
        Some(LlvmType::literal(vec![t; n]))
    }
}

pub fn convert_mma_types(tc: &mut TypeConverter<'_>) {
    tc.conversion(|t| {
        let m = MmaMatrix::try_from(t).ok()?;
        Some(m.llvm().map(|t| vec![t]))
    });
}

fn infer(table: &[(i64, i64, MmaType, i64)], a: i64, b: i64, t: MmaType) -> i64 {
    table.iter().find(|(x, y, e, _)| *x == a && *y == b && *e == t).map_or(0, |r| r.3)
}

pub struct WmmaToNvvm;

#[patterns(converter, options = LlvmOptions)]
impl WmmaToNvvm {
    fn llvm_operands(cr: &Cr<'_, '_, '_>, operands: &[Vec<ValueId>]) -> bool {
        operands.iter().flatten().all(|v| LlvmType::compatible(&cr.rw.body[*v].ty))
    }

    fn matrix(cr: &Cr<'_, '_, '_>, v: ValueId) -> Option<MmaMatrix> {
        MmaMatrix::try_from(&cr.rw.body[v].ty).ok()
    }

    fn attrs<'a>(mut d: OpData<'a>, m: i64, n: i64, k: i64) -> OpData<'a> {
        for (name, v) in [("m", m), ("n", n), ("k", k)] {
            d.set(name, Attribute::of_int(v.into(), Type::int(32)));
        }
        d
    }

    fn layout<'a>(l: MmaLayout) -> Attribute<'a> {
        Attribute::dialect("nvvm.mma_layout", &format!("<{}>", l.name()))
    }

    fn mma_type<'a>(t: MmaType) -> Attribute<'a> {
        Attribute::dialect("nvvm.mma_type", &format!("<{}>", t.name()))
    }

    fn ptr_and_stride(cr: &mut Cr<'_, '_, '_>, op: OpId, memref: usize, desc: ValueId, indices: &[ValueId], o: LlvmOptions) -> Option<(ValueId, ValueId)> {
        let mt = cr.rw.body[cr.rw.body[op].operands[memref]].ty.clone();
        let mlirformat::Type::Shaped(s) = &mt else { return None };
        let s = s.clone();
        let lead = cr.rw.body[op].get("leadDimension")?.clone();
        cr.rw.set_before(op);
        let ptr = MemrefToLlvm::strided_ptr(cr, o, &s, desc, indices, 0)?;
        let stride = cr.llvm_constant(lead, Type::int(32));
        Some((ptr, stride))
    }

    #[convert("gpu.subgroup_mma_load_matrix")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        if !Self::llvm_operands(cr, operands) {
            return false;
        }
        let layout = MmaLayout::of(cr.rw.body[op].get("transpose").is_some());
        let Some(ret) = Self::matrix(cr, cr.rw.body[op].results[0]) else { return false };
        let Some(el) = ret.mma_type() else { return false };
        let (m, n, k) = match ret.frag {
            MmaFrag::A => (ret.rows, infer(&tables::LOAD_INFER_N, ret.rows, ret.cols, el), ret.cols),
            MmaFrag::B => (infer(&tables::LOAD_INFER_M, ret.cols, ret.rows, el), ret.cols, ret.rows),
            MmaFrag::C => (ret.rows, ret.cols, infer(&tables::LOAD_INFER_K, ret.rows, ret.cols, el)),
        };
        if !tables::LOAD.contains(&(layout, m, n, k, el, ret.frag)) {
            return false;
        }
        let Some(res) = ret.llvm() else { return false };
        let indices: Vec<ValueId> = operands[1..].iter().flatten().copied().collect();
        let Some((ptr, stride)) = Self::ptr_and_stride(cr, op, 0, operands[0][0], &indices, o) else { return false };
        let data = Self::attrs(OpData::build("nvvm.wmma.load").operands(&[ptr, stride]), m, n, k).with("layout", Self::layout(layout)).with("eltype", Self::mma_type(el)).with("frag", Attribute::dialect("nvvm.mma_frag", &format!("<{}>", ret.frag.name())));
        cr.replace_new(op, data, &[res]);
        true
    }

    #[convert("gpu.subgroup_mma_store_matrix")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], o: LlvmOptions) -> bool {
        if !Self::llvm_operands(cr, operands) {
            return false;
        }
        let Some(src) = Self::matrix(cr, cr.rw.body[op].operands[0]) else { return false };
        let layout = MmaLayout::of(cr.rw.body[op].get("transpose").is_some());
        let Some(el) = src.mma_type() else { return false };
        let (m, n) = (src.rows, src.cols);
        let k = infer(&tables::STORE_INFER_K, m, n, el);
        if !tables::STORE.contains(&(layout, m, n, k, el)) {
            return false;
        }
        let value = operands[0][0];
        let Ok(LlvmType::Struct { body: Some(fields), .. }) = LlvmType::try_from(&cr.rw.body[value].ty) else { return false };
        cr.rw.set_before(op);
        let mut args: Vec<ValueId> = (0..fields.len()).map(|i| cr.extract(value, &[i as i64])).collect();
        let indices: Vec<ValueId> = operands[2..].iter().flatten().copied().collect();
        let Some((ptr, stride)) = Self::ptr_and_stride(cr, op, 1, operands[1][0], &indices, o) else { return false };
        args.insert(0, ptr);
        args.push(stride);
        let data = Self::attrs(OpData::build("nvvm.wmma.store").operands(&args), m, n, k).with("layout", Self::layout(layout)).with("eltype", Self::mma_type(el));
        cr.replace_new(op, data, &[]);
        true
    }

    #[convert("gpu.subgroup_mma_compute")]
    fn compute(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        if !Self::llvm_operands(cr, operands) {
            return false;
        }
        let ops = cr.rw.body[op].operands.clone();
        let (Some(a), Some(b), Some(c)) = (Self::matrix(cr, ops[0]), Self::matrix(cr, ops[1]), Self::matrix(cr, ops[2])) else { return false };
        let (m, n, k) = (c.rows, c.cols, a.cols);
        let la = MmaLayout::of(cr.rw.body[op].get("a_transpose").is_some());
        let lb = MmaLayout::of(cr.rw.body[op].get("b_transpose").is_some());
        let (Some(src), Some(dst)) = (a.mma_type(), c.mma_type()) else { return false };
        if !tables::MMA.contains(&(la, lb, m, n, k, src, dst)) || b.mma_type() != Some(src) {
            return false;
        }
        cr.rw.set_before(op);
        let mut unpacked = Vec::new();
        for v in [operands[0][0], operands[1][0], operands[2][0]] {
            match LlvmType::try_from(&cr.rw.body[v].ty) {
                Ok(LlvmType::Struct { body: Some(fields), .. }) => unpacked.extend((0..fields.len()).map(|i| cr.extract(v, &[i as i64]))),
                _ => unpacked.push(v),
            }
        }
        let rt = cr.rw.body[operands[2][0]].ty.clone();
        let data = Self::attrs(OpData::build("nvvm.wmma.mma").operands(&unpacked), m, n, k).with("layoutA", Self::layout(la)).with("layoutB", Self::layout(lb)).with("eltypeA", Self::mma_type(src)).with("eltypeB", Self::mma_type(dst));
        cr.replace_new(op, data, &[rt]);
        true
    }

    #[convert("gpu.subgroup_mma_constant_matrix")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        if !Self::llvm_operands(cr, operands) {
            return false;
        }
        let Some(ty) = Self::matrix(cr, cr.rw.body[op].results[0]).and_then(|m| m.llvm()) else { return false };
        let mut cst = operands[0][0];
        let Ok(LlvmType::Struct { body: Some(fields), .. }) = LlvmType::try_from(&ty) else {
            cr.replace(op, vec![vec![cst]]);
            return true;
        };
        cr.rw.set_before(op);
        if let Type::Shaped(v) = &fields[0] {
            let lanes: i64 = v.dims().unwrap_or_default().iter().product();
            let vt = fields[0].clone();
            let mut vec_cst = cr.poison(vt.clone());
            for i in 0..lanes {
                let idx = cr.llvm_constant(Attribute::of_int(i.into(), Type::int(32)), Type::int(32));
                vec_cst = cr.build(OpData::build("llvm.insertelement").operands(&[vec_cst, cst, idx]), vt.clone());
            }
            cst = vec_cst;
        }
        let mut s = cr.poison(ty.clone());
        for i in 0..fields.len() {
            s = cr.insert_value(s, cst, &[i as i64]);
        }
        cr.replace(op, vec![vec![s]]);
        true
    }

    fn min_max(cr: &mut Cr<'_, '_, '_>, a: ValueId, b: ValueId, min: bool) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        let i1 = match &ty {
            Type::Shaped(s) => Type::vector(&s.dims().unwrap_or_default(), &[], Type::int(1)).owned(),
            _ => Type::int(1),
        };
        let fcmp = |cr: &mut Cr<'_, '_, '_>, pred: i64, i1: &Type<'_>| cr.build(OpData::build("llvm.fcmp").operands(&[a, b]).with("predicate", Attribute::i64(pred)).with("fastmathFlags", Attribute::dialect("llvm.fastmath", "<none>")), i1.clone().owned());
        let cmp = fcmp(cr, if min { 4 } else { 2 }, &i1);
        let sel = cr.build(OpData::build("llvm.select").operands(&[cmp, a, b]), ty.clone());
        let nan_c = fcmp(cr, 14, &i1);
        let elem = ty.element_type().clone();
        let Type::Float(k) = elem else { return sel };
        let nan = mlirformat::ApFloat::nan(k);
        let value: Attribute<'_> = mlirformat::Const::scalar(mlirformat::Scalar::Float(nan), Type::Float(k)).into();
        let n = cr.llvm_constant(value, ty.clone());
        cr.build(OpData::build("llvm.select").operands(&[nan_c, n, sel]), ty)
    }

    fn scalar<'a>(cr: &mut Cr<'_, 'a, '_>, kind: Elementwise, ops: &[ValueId]) -> ValueId {
        let ty = cr.rw.body[ops[0]].ty.clone();
        let bin = |cr: &mut Cr<'_, 'a, '_>, name: &str| cr.build(OpData::build(name).operands(ops).with("fastmathFlags", Attribute::dialect("llvm.fastmath", "<none>")), ty.clone());
        match kind {
            Elementwise::AddF => bin(cr, "llvm.fadd"),
            Elementwise::MulF => bin(cr, "llvm.fmul"),
            Elementwise::DivF => bin(cr, "llvm.fdiv"),
            Elementwise::MaxF => Self::min_max(cr, ops[0], ops[1], false),
            Elementwise::MinF => Self::min_max(cr, ops[0], ops[1], true),
        }
    }

    #[convert("gpu.subgroup_mma_elementwise")]
    fn elementwise(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], _: LlvmOptions) -> bool {
        if !Self::llvm_operands(cr, operands) {
            return false;
        }
        let Some(kind) = cr.rw.body[op].get("opType").and_then(|a| Elementwise::try_from(a).ok()) else { return false };
        let Some(dest) = Self::matrix(cr, cr.rw.body[op].results[0]).and_then(|m| m.llvm()) else { return false };
        let ops: Vec<ValueId> = operands.iter().flatten().copied().collect();
        cr.rw.set_before(op);
        let Ok(LlvmType::Struct { body: Some(fields), .. }) = LlvmType::try_from(&dest) else {
            let e = Self::scalar(cr, kind, &ops);
            cr.replace(op, vec![vec![e]]);
            return true;
        };
        let mut s = cr.poison(dest.clone());
        for i in 0..fields.len() {
            let parts: Vec<ValueId> = ops.iter().map(|v| cr.extract(*v, &[i as i64])).collect();
            let e = Self::scalar(cr, kind, &parts);
            s = cr.insert_value(s, e, &[i as i64]);
        }
        cr.replace(op, vec![vec![s]]);
        true
    }
}
