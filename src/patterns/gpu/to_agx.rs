use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpF, CmpFPredicate, CmpI, CmpIPredicate};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use super::Dimension;
use crate::{AddOperand, AgxKernel, AgxSlot as Slot, AgxType, AluOperand, CmpselOperand, ConversionRewriter, Heads, OpData, OpHead, OpId, ShaderStage, SignatureConversion, TypeConverter, UscBuild, UscInput, UscMod, UscOp, ValueId, patterns};
use Slot::{S0, S1, S2, S3};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub const AGX_PARAMS: usize = 8;

pub const AGX_PARAM_UNIFORM: u32 = 4;

pub const AGX_WORKGROUP: u32 = 16;

pub const AGX_KERNEL_ALIGN: u64 = 0x80;

const SR_THREADGROUP: u32 = 0;
const SR_THREAD_IN_GROUP_X: u32 = 48;

pub struct AgxTypes;

impl AgxTypes {
    fn elem(t: &Type<'_>) -> Option<Type<'static>> {
        match t {
            Type::Float(FloatKind::F32) => Some(Type::from(AgxType::R("f32"))),
            Type::Integer { width: 32 | 1, .. } | Type::Index => Some(Type::from(AgxType::R("i32"))),
            _ => match LlvmType::try_from(t) {
                Ok(LlvmType::Ptr(1)) => Some(Type::from(AgxType::R("i32"))),
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

    fn dwords(t: &Type<'_>) -> bool {
        let e = match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => &*s.elem,
            t => t,
        };
        matches!(e, Type::Float(FloatKind::F32) | Type::Integer { width: 32, .. })
    }

    pub fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Self::of(t).map(Some));
        tc.conversion(|t| AgxType::try_from(t).is_ok().then(|| Some(vec![t.clone()])));
        tc
    }
}

#[derive(Clone, Copy)]
enum Pick {
    Value(ValueId),
    Imm(u32),
}

pub struct GpuToAgx;

impl GpuToAgx {
    fn instruction<'a>(cr: &mut Cr<'_, 'a, '_>, before: OpId, op: UscOp, operands: &[ValueId], slots: &[Slot], with: impl FnOnce(UscBuild<'a>) -> UscBuild<'a>, results: Vec<Type<'a>>) -> OpId {
        let (data, types) = with(UscBuild::new(op, operands, slots, results)).split();
        cr.rw.set_before(before);
        cr.rw.create(data, &types)
    }

    fn usc(cr: &mut Cr<'_, '_, '_>, before: OpId, op: UscOp, operands: &[ValueId], slots: &[Slot], with: impl FnOnce(UscBuild<'_>) -> UscBuild<'_>, ty: Type<'static>) -> ValueId {
        let i = Self::instruction(cr, before, op, operands, slots, with, vec![ty]);
        cr.rw.body[i].results[0]
    }

    fn i32() -> Type<'static> {
        Type::from(AgxType::R("i32"))
    }

    fn mfsr(cr: &mut Cr<'_, '_, '_>, op: OpId, sr: u32) -> bool {
        let v = Self::usc(cr, op, UscOp::Mfsr, &[], &[], |b| b.modifier(UscMod::Sr, sr.into()), Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    fn result_type(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<Type<'static>> {
        let r = *cr.rw.body[op].results.first()?;
        AgxTypes::of(&cr.rw.body[r].ty).and_then(|t| t.into_iter().next())
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

    fn lanes(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: UscOp, slots: &[Slot], with: fn(UscBuild<'_>) -> UscBuild<'_>) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::usc(cr, op, inst, x, slots, with, ty.clone()))
    }

    fn minmax(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, cond: i64) -> bool {
        Self::each(cr, op, o, |cr, x| Self::icsel(cr, op, x[0], x[1], [Pick::Value(x[0]), Pick::Value(x[1])], cond, UscOp::Icsel))
    }

    fn bits(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: UscOp, mask: u32) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let m = Self::imm32(cr, op, mask, Self::i32());
            Self::usc(cr, op, inst, &[x[0], m], &[S0, S1], |b| b, Type::from(AgxType::R("f32")))
        })
    }

    fn imm32(cr: &mut Cr<'_, '_, '_>, before: OpId, bits: u32, ty: Type<'static>) -> ValueId {
        Self::usc(cr, before, UscOp::Ldimm32, &[], &[], |b| b.modifier(UscMod::Imm, bits.into()), ty)
    }

    fn icsel(cr: &mut Cr<'_, '_, '_>, op: OpId, a: ValueId, b: ValueId, [x, y]: [Pick; 2], cond: i64, inst: UscOp) -> ValueId {
        let mut operands = vec![a, b];
        let mut slots = vec![S0, S1];
        let mut consts = Vec::new();
        for (pick, k) in [(x, S2), (y, S3)] {
            match pick {
                Pick::Value(v) => {
                    operands.push(v);
                    slots.push(k);
                }
                Pick::Imm(imm) => consts.push((k, CmpselOperand::Imm { imm })),
            }
        }
        Self::usc(
            cr,
            op,
            inst,
            &operands,
            &slots,
            |b| consts.iter().fold(b.modifier(UscMod::Condition, cond), |b, (k, c)| b.operand(*k, c)),
            Self::i32(),
        )
    }

    fn compare(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], inst: UscOp, cond: i64, invert: bool) -> bool {
        let picks = if invert { [Pick::Imm(0), Pick::Imm(1)] } else { [Pick::Imm(1), Pick::Imm(0)] };
        Self::each(cr, op, o, |cr, x| Self::icsel(cr, op, x[0], x[1], picks, cond, inst))
    }

    fn constant_bits(value: &Attribute<'_>, n: usize) -> Option<Vec<u32>> {
        let c = Const::try_from(value).ok()?;
        let bits = |s: Scalar| match s {
            Scalar::Float(f) => (f.kind == FloatKind::F32).then_some(f.bits as u32),
            Scalar::Int(i) => (i.width == 32 || i.width == 1).then_some(i.bits() as u32),
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

    fn index(cr: &mut Cr<'_, '_, '_>, op: OpId, addr: ValueId) -> ValueId {
        Self::usc(cr, op, UscOp::Shr, &[addr], &[S0], |b| b.operand(S1, &AluOperand::Imm { imm: 2 }), Self::i32())
    }

    fn base(cr: &mut Cr<'_, '_, '_>, op: OpId) -> ValueId {
        cr.rw.set_before(op);
        cr.emit(&UscInput::new(0, AgxType::U("i64").into()))
    }

    fn mask(n: usize) -> i64 {
        (1 << n) - 1
    }
}

#[patterns(converter)]

#[map("arith.minsi" => "agx.usc.icsel", via = Self::minmax(5))]
#[map("arith.maxsi" => "agx.usc.icsel", via = Self::minmax(6))]
#[map("arith.minui" => "agx.usc.icsel", via = Self::minmax(1))]
#[map("arith.maxui" => "agx.usc.icsel", via = Self::minmax(2))]

#[map("arith.negf" => "agx.usc.xor", via = Self::bits(UscOp::Xor, 0x8000_0000))]
#[map("math.absf" => "agx.usc.and", via = Self::bits(UscOp::And, 0x7fff_ffff))]
#[map("arith.addi" => "agx.usc.iadd", via = Self::lanes(UscOp::Iadd, &[S0, S1], |b| b))]
#[map("arith.subi" => "agx.usc.isub", via = Self::lanes(UscOp::Isub, &[S0, S1], |b| b))]
#[map("arith.muli" => "agx.usc.imul", via = Self::lanes(UscOp::Imul, &[S0, S1], |b| b))]
#[map("arith.andi" => "agx.usc.and", via = Self::lanes(UscOp::And, &[S0, S1], |b| b))]
#[map("arith.ori" => "agx.usc.or", via = Self::lanes(UscOp::Or, &[S0, S1], |b| b))]
#[map("arith.xori" => "agx.usc.xor", via = Self::lanes(UscOp::Xor, &[S0, S1], |b| b))]
#[map("arith.shli" => "agx.usc.shl", via = Self::lanes(UscOp::Shl, &[S0, S1], |b| b))]
#[map("arith.shrui" => "agx.usc.shr", via = Self::lanes(UscOp::Shr, &[S0, S1], |b| b))]

#[map("arith.shrsi" => "agx.usc.asr", via = Self::lanes(UscOp::Asr, &[S0, S1], |b| b.operand(S2, &AluOperand::Imm { imm: 0 })))]
#[map("arith.extui" => "agx.usc.mov", via = Self::lanes(UscOp::Mov, &[S0], |b| b))]

#[map("arith.extsi" => "agx.usc.isub", via = Self::lanes(UscOp::Isub, &[S1], |b| b.operand(S0, &AddOperand::Imm { imm: 0, sx: 0 })))]
#[map("arith.addf" => "agx.usc.fadd", via = Self::lanes(UscOp::Fadd, &[S0, S1], |b| b))]

#[map("arith.subf" => "agx.usc.fadd", via = Self::lanes(UscOp::Fadd, &[S0, S1], |b| b.neg(S1)))]
#[map("arith.mulf" => "agx.usc.fmul", via = Self::lanes(UscOp::Fmul, &[S0, S1], |b| b))]
#[map("math.fma" => "agx.usc.ffma", via = Self::lanes(UscOp::Ffma, &[S0, S1, S2], |b| b))]
#[map("arith.sitofp" => "agx.usc.s32_to_f", via = Self::lanes(UscOp::S32ToF, &[S0], |b| b.modifier(UscMod::Round, 1)))]
#[map("arith.uitofp" => "agx.usc.u32_to_f", via = Self::lanes(UscOp::U32ToF, &[S0], |b| b.modifier(UscMod::Round, 1)))]
#[map("arith.fptosi" => "agx.usc.f_to_s32", via = Self::lanes(UscOp::FToS32, &[S0], |b| b))]
#[map("arith.fptoui" => "agx.usc.f_to_u32", via = Self::lanes(UscOp::FToU32, &[S0], |b| b))]
#[map("arith.bitcast" => "agx.usc.mov", via = Self::lanes(UscOp::Mov, &[S0], |b| b))]
impl GpuToAgx {
    #[convert("gpu.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !cr.rw.body[op].gpu_kernel() {
            return false;
        }
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(name) = cr.rw.body[op].get("sym_name").cloned() else { return false };
        if fty.inputs.len() > AGX_PARAMS || !fty.results.is_empty() {
            return false;
        }
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            if !matches!(t, Type::Integer { width: 32, .. }) {
                return false;
            }
            sig.add_inputs(i, vec![Self::i32()]);
        }
        let kernel = AgxKernel::new(name, Some(ShaderStage::Compute), Some(fty.inputs.len() as u32), None, None, mlirformat::Region { blocks: Vec::new() });
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
        Self::instruction(cr, op, UscOp::Stop, &[], &[], |b| b, Vec::new());
        cr.erase(op);
        true
    }

    #[convert("arith.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let Some(types) = AgxTypes::of(&cr.rw.body[r].ty) else { return false };
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        let Some(bits) = Self::constant_bits(&value, types.len()) else { return false };
        let values = bits.iter().zip(types).map(|(b, t)| Self::imm32(cr, op, *b, t)).collect();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("arith.cmpi")]
    fn cmpi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use CmpIPredicate::*;
        let Ok(c) = cr.rw.body.head::<CmpI>(op) else { return false };
        let (cond, invert) = match c.predicate {
            eq => (0, false),
            ne => (0, true),
            slt => (5, false),
            sle => (6, true),
            sgt => (6, false),
            sge => (5, true),
            ult => (1, false),
            ule => (2, true),
            ugt => (2, false),
            uge => (1, true),
        };
        Self::compare(cr, op, o, UscOp::Icsel, cond, invert)
    }

    #[convert("arith.cmpf")]
    fn cmpf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use CmpFPredicate::*;
        let Ok(c) = cr.rw.body.head::<CmpF>(op) else { return false };
        let cond = match c.predicate {
            oeq => 0,
            ogt => 2,
            oge => 5,
            olt => 1,
            ole => 6,
            ugt => 14,
            uge => 9,
            ult => 13,
            ule => 10,
            une => 8,
            _ => return false,
        };
        Self::compare(cr, op, o, UscOp::Fcsel, cond, false)
    }

    #[convert("arith.select")]
    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [c, t, f] = o else { return false };
        let ([c], n) = (&c[..], t.len()) else { return false };
        let Some(ty) = Self::result_type(cr, op) else { return false };
        if f.len() != n {
            return false;
        }
        let values = (0..n)
            .map(|i| {
                let operands = [*c, f[i], t[i]];
                Self::usc(cr, op, UscOp::Icsel, &operands, &[S0, S2, S3], |b| b.operand(S1, &AluOperand::Imm { imm: 0 }).modifier(UscMod::Condition, 0), ty.clone())
            })
            .collect();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("arith.index_cast", "arith.index_castui", "llvm.inttoptr")]
    fn same(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if AgxTypes::of(&cr.rw.body[r].ty).is_none_or(|t| t.len() != o[0].len()) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        Self::mfsr(cr, op, SR_THREADGROUP + d as u32)
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) != Some(Dimension::X) {
            return false;
        }
        Self::mfsr(cr, op, SR_THREAD_IN_GROUP_X)
    }

    #[convert("llvm.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr] = o else { return false };
        let r = cr.rw.body[op].results[0];
        let ty = cr.rw.body[r].ty.clone();
        let Some(types) = AgxTypes::of(&ty) else { return false };
        if !AgxTypes::dwords(&ty) || types.len() > 4 {
            return false;
        }
        let index = Self::index(cr, op, addr[0]);
        let base = Self::base(cr, op);
        let mask = Self::mask(types.len());
        let load = Self::instruction(cr, op, UscOp::Load, &[base, index], &[S0, S1], |b| b.modifier(UscMod::Format, 2).modifier(UscMod::Mask, mask), types);
        let values = cr.rw.body[load].results.to_vec();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("llvm.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [value, addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !AgxTypes::dwords(&ty) || value.len() > 4 {
            return false;
        }
        let index = Self::index(cr, op, addr[0]);
        let base = Self::base(cr, op);
        let mut operands = value.clone();
        operands.extend([base, index]);
        let mut slots = vec![S0; value.len()];
        slots.extend([S1, S2]);
        let mask = Self::mask(value.len());
        Self::instruction(cr, op, UscOp::Store, &operands, &slots, |b| b.modifier(UscMod::Format, 2).modifier(UscMod::Mask, mask), Vec::new());
        cr.erase(op);
        true
    }

    #[convert("vector.extract")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(at) = Self::position(cr, op) else { return false };
        let Some(v) = o[0].get(at).copied() else { return false };
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
        let values = o.concat();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("vector.broadcast")]
    fn broadcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let (Some(types), [v]) = (AgxTypes::of(&ty), &o[0][..]) else { return false };
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
