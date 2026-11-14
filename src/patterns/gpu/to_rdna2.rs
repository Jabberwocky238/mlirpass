use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpF, CmpFPredicate, CmpI, CmpIPredicate};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use super::Dimension;
use crate::{ConversionRewriter, Heads, OpData, OpHead, OpId, Rdna2Build as Build, Rdna2Flag as Flag, Rdna2Flat as Flat, Rdna2Input, Rdna2Kernel, Rdna2Opcode as Opcode, Rdna2Operand as Operand, Rdna2Salu as Salu, Rdna2Slot as Slot, Rdna2Type, Rdna2Valu as Valu, ShaderStage, SignatureConversion, TypeConverter, ValueId, patterns};
use Slot::{Addr, Data, Src0, Src1, Src2};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub const RDNA2_PARAMS: usize = 8;

pub const RDNA2_TGID_SGPR: u32 = RDNA2_PARAMS as u32;

pub const RDNA2_WORKGROUP: u32 = 16;

pub const RDNA2_KERNEL_PAD: u64 = 256;

pub const RDNA2_KERNEL_ALIGN: u64 = 256;

pub struct Rdna2Types;

impl Rdna2Types {
    fn elem(t: &Type<'_>) -> Option<Type<'static>> {
        match t {
            Type::Float(FloatKind::F32) => Some(Type::from(Rdna2Type::V("f32"))),
            Type::Integer { width: 8 | 16 | 32, .. } | Type::Index => Some(Type::from(Rdna2Type::V("i32"))),
            Type::Integer { width: 1, .. } => Some(Type::from(Rdna2Type::S("i1"))),
            _ => match LlvmType::try_from(t) {
                Ok(LlvmType::Ptr(1)) => Some(Type::from(Rdna2Type::V("i32"))),
                _ => None,
            },
        }
    }

    pub fn of(t: &Type<'_>) -> Option<Vec<Type<'static>>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => match t.dims()?[..] {
                [n] if n > 0 => Some(vec![Self::elem(&s.elem)?; n as usize]),
                _ => None,
            },
            _ => Some(vec![Self::elem(t)?]),
        }
    }

    pub fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Self::of(t).map(Some));
        tc.conversion(|t| Rdna2Type::try_from(t).is_ok().then(|| Some(vec![t.clone()])));
        tc
    }

    fn scalar<'t, 'a>(t: &'t Type<'a>) -> &'t Type<'a> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => &s.elem,
            t => t,
        }
    }

    fn access(t: &Type<'_>) -> Option<(u32, usize)> {
        let (elem, n) = match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => match t.dims()?[..] {
                [n] if n > 0 => (&*s.elem, n as usize),
                _ => return None,
            },
            t => (t, 1),
        };
        let size = match elem {
            Type::Float(FloatKind::F32) | Type::Integer { width: 32, .. } => 4,
            Type::Integer { width: 16, .. } => 2,
            Type::Integer { width: 8, .. } => 1,
            _ => return None,
        };
        Some((size, n))
    }
}

pub struct GpuToRdna2;

impl GpuToRdna2 {
    fn put<'a>(cr: &mut Cr<'_, 'a, '_>, before: OpId, inst: Build<'a>) -> OpId {
        cr.rw.set_before(before);
        let (data, types) = inst.split();
        cr.rw.create(data, &types)
    }

    fn valu(cr: &mut Cr<'_, '_, '_>, before: OpId, op: Opcode, (operands, slots): (&[ValueId], &[Slot]), consts: &[(Slot, Operand)], vop3: bool, ty: Type<'static>) -> ValueId {
        let mut v = Build::new::<Valu>(op, operands, slots, vec![ty]);
        for (slot, c) in consts {
            v = v.source(*slot, *c);
        }
        if vop3 {
            v = v.flag(Flag::Vop3);
        }
        let i = Self::put(cr, before, v);
        cr.rw.body[i].results[0]
    }

    fn lanes(cr: &mut Cr<'_, '_, '_>, root: OpId, o: &[Vec<ValueId>], _: &str, op: Opcode, slots: &[Slot], consts: &[(Slot, Operand)]) -> bool {
        let Some(ty) = Self::result_type(cr, root) else { return false };
        Self::each(cr, root, o, |cr, x| Self::valu(cr, root, op, (x, slots), consts, false, ty.clone()))
    }

    fn result_type(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<Type<'static>> {
        let r = *cr.rw.body[op].results.first()?;
        Rdna2Types::of(&cr.rw.body[r].ty).and_then(|t| t.into_iter().next())
    }

    fn each(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], mut f: impl FnMut(&mut Cr<'_, '_, '_>, &[ValueId]) -> ValueId) -> bool {
        let n = o[0].len();
        if o.iter().any(|v| v.len() != n) {
            return false;
        }
        let values: Vec<ValueId> = (0..n).map(|i| f(cr, &o.iter().map(|v| v[i]).collect::<Vec<_>>())).collect();
        cr.replace(op, vec![values]);
        true
    }

    fn constant_bits(value: &Attribute<'_>, n: usize) -> Option<Vec<u32>> {
        let c = Const::try_from(value).ok()?;
        let bits = |s: Scalar| match s {
            Scalar::Float(f) => (f.kind == FloatKind::F32).then_some(f.bits as u32),
            Scalar::Int(i) => (i.width == 32).then_some(i.bits() as u32),
            Scalar::Complex(..) | Scalar::ComplexFloat(..) | Scalar::Wide(_) => None,
        };
        (0..n).map(|i| bits(c.at(i))).collect()
    }

    fn positions(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<Vec<usize>> {
        cr.rw.body[op].get(name)?.dense_values().map(|v| v.into_iter().map(|i| i as usize).collect())
    }

    fn position(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<usize> {
        match Self::positions(cr, op, "static_position")?[..] {
            [at] => Some(at),
            _ => None,
        }
    }

    fn cmp(cr: &mut Cr<'_, '_, '_>, root: OpId, o: &[Vec<ValueId>], op: Opcode) -> bool {
        Self::each(cr, root, o, |cr, x| Self::valu(cr, root, op, (x, &[Src0, Src1]), &[], true, Rdna2Type::S("i1").into()))
    }

    fn cndmask(cr: &mut Cr<'_, '_, '_>, root: OpId, operands: (&[ValueId], &[Slot]), consts: &[(Slot, Operand)]) -> Option<ValueId> {
        let ty = Self::result_type(cr, root)?;
        Some(Self::valu(cr, root, Opcode::VCndmaskB32, operands, consts, true, ty))
    }

    fn memory(access: Access, size: u32, n: usize) -> Option<Opcode> {
        use Opcode::*;
        Some(match (access, size, n) {
            (Access::Load, 4, 1) => GlobalLoadDword,
            (Access::Load, 4, 2) => GlobalLoadDwordx2,
            (Access::Load, 4, 3) => GlobalLoadDwordx3,
            (Access::Load, 4, 4) => GlobalLoadDwordx4,
            (Access::Load, 2, 1) => GlobalLoadUshort,
            (Access::Load, 1, 1) => GlobalLoadUbyte,
            (Access::Store, 4, 1) => GlobalStoreDword,
            (Access::Store, 4, 2) => GlobalStoreDwordx2,
            (Access::Store, 4, 3) => GlobalStoreDwordx3,
            (Access::Store, 4, 4) => GlobalStoreDwordx4,
            (Access::Store, 2, 1) => GlobalStoreShort,
            (Access::Store, 1, 1) => GlobalStoreByte,
            _ => return None,
        })
    }
}

#[patterns(converter)]
#[map("arith.addi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VAddU32, &[Src0, Src1], &[]))]
#[map("arith.subi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VSubU32, &[Src0, Src1], &[]))]
#[map("arith.muli" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMulLoU32, &[Src0, Src1], &[]))]
#[map("arith.andi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VAndB32, &[Src0, Src1], &[]))]
#[map("arith.ori" => "rdna2.isa.valu", via = Self::lanes(Opcode::VOrB32, &[Src0, Src1], &[]))]
#[map("arith.xori" => "rdna2.isa.valu", via = Self::lanes(Opcode::VXorB32, &[Src0, Src1], &[]))]

#[map("arith.shli" => "rdna2.isa.valu", via = Self::lanes(Opcode::VLshlrevB32, &[Src1, Src0], &[]))]
#[map("arith.shrui" => "rdna2.isa.valu", via = Self::lanes(Opcode::VLshrrevB32, &[Src1, Src0], &[]))]
#[map("arith.shrsi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VAshrrevI32, &[Src1, Src0], &[]))]
#[map("arith.minsi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMinI32, &[Src0, Src1], &[]))]
#[map("arith.maxsi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMaxI32, &[Src0, Src1], &[]))]
#[map("arith.minui" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMinU32, &[Src0, Src1], &[]))]
#[map("arith.maxui" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMaxU32, &[Src0, Src1], &[]))]
#[map("arith.addf" => "rdna2.isa.valu", via = Self::lanes(Opcode::VAddF32, &[Src0, Src1], &[]))]
#[map("arith.subf" => "rdna2.isa.valu", via = Self::lanes(Opcode::VSubF32, &[Src0, Src1], &[]))]
#[map("arith.mulf" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMulF32, &[Src0, Src1], &[]))]
#[map("math.fma" => "rdna2.isa.valu", via = Self::lanes(Opcode::VFmaF32, &[Src0, Src1, Src2], &[]))]

#[map("arith.negf" => "rdna2.isa.valu", via = Self::lanes(Opcode::VXorB32, &[Src1], &[(Src0, Operand::from(0x80000000))]))]
#[map("math.absf" => "rdna2.isa.valu", via = Self::lanes(Opcode::VAndB32, &[Src1], &[(Src0, Operand::from(0x7fffffff))]))]
#[map("arith.sitofp" => "rdna2.isa.valu", via = Self::lanes(Opcode::VCvtF32I32, &[Src0], &[]))]
#[map("arith.uitofp" => "rdna2.isa.valu", via = Self::lanes(Opcode::VCvtF32U32, &[Src0], &[]))]
#[map("arith.fptosi" => "rdna2.isa.valu", via = Self::lanes(Opcode::VCvtI32F32, &[Src0], &[]))]
#[map("arith.fptoui" => "rdna2.isa.valu", via = Self::lanes(Opcode::VCvtU32F32, &[Src0], &[]))]
#[map("arith.bitcast" => "rdna2.isa.valu", via = Self::lanes(Opcode::VMovB32, &[Src0], &[]))]
impl GpuToRdna2 {
    #[convert("gpu.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !cr.rw.body[op].gpu_kernel() {
            return false;
        }
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(name) = cr.rw.body[op].get("sym_name").cloned() else { return false };
        if fty.inputs.len() > RDNA2_PARAMS || !fty.results.is_empty() {
            return false;
        }
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            if !matches!(t, Type::Integer { width: 32, .. }) {
                return false;
            }
            sig.add_inputs(i, vec![Type::from(Rdna2Type::V("i32"))]);
        }
        let kernel = Rdna2Kernel::new(name, Some(ShaderStage::Compute), Some(fty.inputs.len() as u32), None, None, None, None, mlirformat::Region { blocks: Vec::new() });
        let Ok(data) = OpData::head(&kernel) else { return false };
        let region = cr.rw.body[op].regions[0];
        cr.rw.set_before(op);
        let new = cr.rw.create_with(data, &[], |b, k| {
            b.add_region(k);
        });
        let into = cr.rw.body[new].regions[0];
        cr.inline_region(region, into, None);
        let Some(current) = cr.current else { return false };
        if cr.convert_region_types(into, current, Some(&sig)).is_none() {
            return false;
        }
        cr.erase(op);
        true
    }

    #[convert("gpu.return")]
    fn ret(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::put(cr, op, Build::new::<Salu>(Opcode::SEndpgm, &[], &[], Vec::new()));
        cr.erase(op);
        true
    }

    #[convert("arith.index_cast", "arith.index_castui", "llvm.inttoptr")]
    fn same(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if Rdna2Types::of(&cr.rw.body[r].ty).is_none_or(|t| t.len() != o[0].len()) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    #[convert("arith.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let Some(types) = Rdna2Types::of(&cr.rw.body[r].ty) else { return false };
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        let Some(bits) = Self::constant_bits(&value, types.len()) else { return false };
        let values = bits
            .iter()
            .zip(types)
            .map(|(b, t)| {
                Self::valu(cr, op, Opcode::VMovB32, (&[], &[]), &[(Src0, Operand::from(i64::from(*b)))], false, t)
            })
            .collect();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("arith.cmpi")]
    fn cmpi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use CmpIPredicate::*;
        let Ok(c) = cr.rw.body.head::<CmpI>(op) else { return false };
        let inst = match c.predicate {
            eq => Opcode::VCmpEqI32,
            ne => Opcode::VCmpLgI32,
            slt => Opcode::VCmpLtI32,
            sle => Opcode::VCmpLeI32,
            sgt => Opcode::VCmpGtI32,
            sge => Opcode::VCmpGeI32,
            ult => Opcode::VCmpLtU32,
            ule => Opcode::VCmpLeU32,
            ugt => Opcode::VCmpGtU32,
            uge => Opcode::VCmpGeU32,
        };
        Self::cmp(cr, op, o, inst)
    }

    #[convert("arith.cmpf")]
    fn cmpf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use CmpFPredicate::*;
        let Ok(c) = cr.rw.body.head::<CmpF>(op) else { return false };
        let inst = match c.predicate {
            oeq => Opcode::VCmpEqF32,
            ogt => Opcode::VCmpGtF32,
            oge => Opcode::VCmpGeF32,
            olt => Opcode::VCmpLtF32,
            ole => Opcode::VCmpLeF32,
            one => Opcode::VCmpLgF32,
            ord => Opcode::VCmpOF32,
            ueq => Opcode::VCmpNlgF32,
            ugt => Opcode::VCmpNleF32,
            uge => Opcode::VCmpNltF32,
            ult => Opcode::VCmpNgeF32,
            ule => Opcode::VCmpNgtF32,
            une => Opcode::VCmpNeqF32,
            uno => Opcode::VCmpUF32,
            AlwaysFalse | AlwaysTrue => return false,
        };
        Self::cmp(cr, op, o, inst)
    }

    #[convert("arith.select")]
    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [c, t, f] = o else { return false };
        let ([c], n) = (&c[..], t.len()) else { return false };
        if f.len() != n {
            return false;
        }
        let Some(values) = (0..n).map(|i| Self::cndmask(cr, op, (&[f[i], t[i], *c], &[Src0, Src1, Src2]), &[])).collect() else { return false };
        cr.replace(op, vec![values]);
        true
    }

    #[convert("arith.trunci")]
    fn trunci(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if !cr.rw.body[r].uses.iter().all(|u| cr.rw.body[u.op].name == "llvm.store" && u.index == 0) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    #[convert("arith.extui")]
    fn extui(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let from = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if matches!(Rdna2Types::scalar(&from), Type::Integer { width: 8 | 16, .. }) {
            cr.replace(op, vec![o[0].clone()]);
            return true;
        }
        Self::each(cr, op, o, |cr, x| Self::cndmask(cr, op, (x, &[Src2]), &[(Src0, 0.into()), (Src1, 1.into())]).expect("an i32 result"))
    }

    #[convert("arith.extsi")]
    fn extsi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let from = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !matches!(Rdna2Types::scalar(&from), Type::Integer { width: 1, .. }) {
            return false;
        }
        Self::each(cr, op, o, |cr, x| Self::cndmask(cr, op, (x, &[Src2]), &[(Src0, 0.into()), (Src1, (-1).into())]).expect("an i32 result"))
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        cr.rw.set_before(op);
        let s = cr.emit(&Rdna2Input::new(i64::from(RDNA2_TGID_SGPR) + d as i64, Rdna2Type::S("i32").into()));
        let v = Self::valu(cr, op, Opcode::VMovB32, (&[s], &[Src0]), &[], false, Rdna2Type::V("i32").into());
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) != Some(Dimension::X) {
            return false;
        }
        cr.rw.set_before(op);
        let v = cr.emit(&Rdna2Input::new(0, Rdna2Type::V("i32").into()));
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("llvm.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr] = o else { return false };
        let r = cr.rw.body[op].results[0];
        let ty = cr.rw.body[r].ty.clone();
        let (Some(types), Some((size, n))) = (Rdna2Types::of(&ty), Rdna2Types::access(&ty)) else { return false };
        let Some(inst) = Self::memory(Access::Load, size, n) else { return false };
        let load = Self::put(cr, op, Build::new::<Flat>(inst, addr, &[Addr], types));
        let values = cr.rw.body[load].results.to_vec();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("llvm.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [value, addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let Some((size, n)) = Rdna2Types::access(&ty) else { return false };
        let Some(inst) = Self::memory(Access::Store, size, n) else { return false };
        let mut operands = addr.clone();
        operands.extend(value);
        let mut slots = vec![Addr];
        slots.extend(core::iter::repeat_n(Data, value.len()));
        Self::put(cr, op, Build::new::<Flat>(inst, &operands, &slots, Vec::new()));
        cr.erase(op);
        true
    }

    #[convert("vector.extract")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(v) = Self::position(cr, op).and_then(|at| o[0].get(at)).copied() else { return false };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("vector.insert")]
    fn insert(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(at) = Self::position(cr, op) else { return false };
        let ([v], Some(dest)) = (&o[0][..], o.get(1)) else { return false };
        let mut dest = dest.clone();
        if at >= dest.len() {
            return false;
        }
        dest[at] = *v;
        cr.replace(op, vec![dest]);
        true
    }

    #[convert("vector.from_elements")]
    fn from_elements(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        cr.replace(op, vec![o.concat()]);
        true
    }

    #[convert("vector.broadcast")]
    fn broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let (Some(types), [v]) = (Rdna2Types::of(&ty), &o[0][..]) else { return false };
        cr.replace(op, vec![vec![*v; types.len()]]);
        true
    }

    #[convert("vector.shuffle")]
    fn shuffle(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(mask) = Self::positions(cr, op, "mask") else { return false };
        let all = o.concat();
        let Some(values) = mask.iter().map(|i| all.get(*i).copied()).collect::<Option<Vec<_>>>() else { return false };
        cr.replace(op, vec![values]);
        true
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Access {
    Load,
    Store,
}
