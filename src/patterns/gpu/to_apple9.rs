//! ⭐ Compute shaders ⇒ `apple9.kernel`s of virtual Apple9 instructions (dialect conversion).
//!
//! ```text
//!   gpu.func {gpu.kernel}           ⇒ apple9.kernel {stage = "compute", params}: a workgroup of 16 threads
//!   i32, i1, index, !llvm.ptr<1>, f32, vector<N x ...> ⇒ 1, N × !apple9.r<i32 | f32>: a 32-bit GPR a component, a
//!                                     thread each (an i1: 0 or 1; an index and a global pointer: 32 bits, a byte
//!                                     address in the memory, binding 0)
//!   arith.constant                  ⇒ mov_imm, per component
//!   arith.addi / subi / muli        ⇒ iadd / isub / imad (+ 0)
//!   arith.andi / ori / xori, shli / shrui / shrsi, min* / max* ⇒ and / or / xor, shl / shr / asr, smin ... umax
//!   arith.cmpi                      ⇒ 1 or 0 by select (the less / greater relations; eq, ne, le, ge of two)
//!   arith.select, extui / extsi (of i1) ⇒ select of the condition against 0, the value itself / 0 - it
//!   arith.addf / mulf, math.absf    ⇒ fadd / fmul, fmul |x| * 1.0
//!   arith.sitofp / uitofp / fptosi / fptoui ⇒ i2f / f2i (toward zero)
//!   arith.bitcast                   ⇒ or of the value with itself (the same bits, the other type)
//!   arith.index_cast(ui), llvm.inttoptr ⇒ the value itself
//!   llvm.load / llvm.store (!llvm.ptr<1>) ⇒ load / store of 1 ..= 4 dwords at binding 0 [the address] (bytes)
//!   gpu.block_id x, gpu.thread_id x ⇒ get_sr threadgroup_position_in_grid.x (0x9c), get_sr16
//!                                     thread_position_in_threadgroup.x (0xa4)
//!   gpu.return                      ⇒ halt
//!   vector.extract / insert / from_elements / broadcast / shuffle ⇒ the components themselves
//! ```
//!
//! The parameters (32-bit words) are read from the parameter buffer (binding 1) at the kernel's start
//! (`convert-gpu-to-apple9`). Refused: f32 division, square root, min / max, fma, subtraction, comparisons; loads and
//! stores of other than whole dwords.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpI, CmpIPredicate};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use super::Dimension;
use crate::{A, Apple9Kernel, Apple9Op, Apple9Type, ConversionRewriter, Heads, OpData, OpHead, OpId, ShaderStage, SignatureConversion, TypeConverter, ValueId, WithAttrs, patterns};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// Parameters of a compute shader (32-bit words).
pub const APPLE9_PARAMS: usize = 8;
/// Threads of a workgroup.
pub const APPLE9_WORKGROUP: u32 = 16;
/// The bindings: the memory (byte addresses), the parameter buffer.
pub const APPLE9_MEMORY: u32 = 0;
pub const APPLE9_PARAMETERS: u32 = 1;
/// The special registers: threadgroup_position_in_grid.x, thread_position_in_threadgroup.x (16-bit).
const SR_THREADGROUP_X: u32 = 0x9c;
const SR_THREAD_IN_GROUP_X: u32 = 0xa4;

/// ⭐ The shader types ⇒ Apple9 registers.
pub struct Apple9Types;

impl Apple9Types {
    fn elem(t: &Type<'_>) -> Option<Type<'static>> {
        match t {
            Type::Float(FloatKind::F32) => Some(Type::from(Apple9Type("f32"))),
            Type::Integer { width: 32 | 1, .. } | Type::Index => Some(Type::from(Apple9Type("i32"))),
            _ => match LlvmType::try_from(t) {
                Ok(LlvmType::Ptr(1)) => Some(Type::from(Apple9Type("i32"))),
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

    /// Whether `t` is dwords (i32 / f32 and their vectors): what a load / store moves.
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
        tc.conversion(|t| Apple9Type::try_from(t).is_ok().then(|| Some(vec![t.clone()])));
        tc
    }
}

/// ⭐ The compute shader ⇒ virtual Apple9 instruction patterns.
pub struct GpuToApple9;

impl GpuToApple9 {
    /// Virtual instruction `op` of `operands` with `attrs`, its results of `types`, before `before`.
    fn instruction<'a>(cr: &mut Cr<'_, 'a, '_>, before: OpId, op: Apple9Op, operands: &[ValueId], attrs: Vec<(&str, A)>, types: Vec<Type<'a>>) -> Vec<ValueId> {
        let data = OpData::build(op.name()).operands(operands).with_attrs(attrs);
        cr.rw.set_before(before);
        let i = cr.rw.create(data, &types);
        cr.rw.body[i].results.to_vec()
    }

    /// [`Self::instruction`] with one result, of type `ty`.
    fn one(cr: &mut Cr<'_, '_, '_>, before: OpId, op: Apple9Op, operands: &[ValueId], attrs: Vec<(&str, A)>, ty: Type<'static>) -> ValueId {
        Self::instruction(cr, before, op, operands, attrs, vec![ty])[0]
    }

    fn i32() -> Type<'static> {
        Type::from(Apple9Type("i32"))
    }

    fn f32() -> Type<'static> {
        Type::from(Apple9Type("f32"))
    }

    /// `mov_imm` of `bits`.
    fn imm(cr: &mut Cr<'_, '_, '_>, before: OpId, bits: u32, ty: Type<'static>) -> ValueId {
        Self::one(cr, before, Apple9Op::MovImm, &[], vec![("value", A::from(bits))], ty)
    }

    fn result_type(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<Type<'static>> {
        let r = *cr.rw.body[op].results.first()?;
        Apple9Types::of(&cr.rw.body[r].ty).and_then(|t| t.into_iter().next())
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

    /// The `#[map]` rows' template: instruction `inst` per component of the operands.
    fn lanes(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: Apple9Op) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, inst, x, Vec::new(), ty.clone()))
    }

    /// The `#[map]` rows' conversions: `inst` with `signed`.
    fn convert(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: Apple9Op, signed: bool) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, inst, x, if signed { vec![("signed", A::Bool(true))] } else { Vec::new() }, ty.clone()))
    }

    /// `cond(a, b) ? t : f`.
    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, cond: &str, ab: [ValueId; 2], tf: [ValueId; 2], ty: Type<'static>) -> ValueId {
        Self::one(cr, op, Apple9Op::Select, &[ab[0], ab[1], tf[0], tf[1]], vec![("cond", A::str(cond))], ty)
    }

    /// An integer comparison as 1 / 0. The select compares by ilt / igt / ult / ugt; the rest are two of them.
    fn compare(cr: &mut Cr<'_, '_, '_>, op: OpId, pred: CmpIPredicate, a: ValueId, b: ValueId) -> ValueId {
        use CmpIPredicate::*;
        let one = Self::imm(cr, op, 1, Self::i32());
        let zero = Self::imm(cr, op, 0, Self::i32());
        let (lt, gt) = match pred {
            slt | sle | sgt | sge => ("ilt", "igt"),
            _ => ("ult", "ugt"),
        };
        match pred {
            slt | ult => Self::select(cr, op, lt, [a, b], [one, zero], Self::i32()),
            sgt | ugt => Self::select(cr, op, gt, [a, b], [one, zero], Self::i32()),
            sle | ule => Self::select(cr, op, gt, [a, b], [zero, one], Self::i32()),
            sge | uge => Self::select(cr, op, lt, [a, b], [zero, one], Self::i32()),
            // equal: neither less nor greater
            eq | ne => {
                let (yes, no) = if pred == eq { (one, zero) } else { (zero, one) };
                let not_less = Self::select(cr, op, "ult", [a, b], [no, yes], Self::i32());
                Self::select(cr, op, "ugt", [a, b], [no, not_less], Self::i32())
            }
        }
    }

    fn constant_bits(value: &Attribute<'_>, n: usize) -> Option<Vec<u32>> {
        let c = Const::try_from(value).ok()?;
        let bits = |s: Scalar| match s {
            Scalar::Float(f) => (f.kind == FloatKind::F32).then_some(f.bits as u32),
            Scalar::Int(i) => (i.width == 32 || i.width == 1).then_some(i.bits() as u32),
        };
        (0..n).map(|i| bits(c.at(i))).collect()
    }

    fn positions(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<Vec<usize>> {
        cr.rw.body[op].get(name)?.dense_values().map(|v| v.into_iter().map(|i| i as usize).collect())
    }

    /// A `vector.extract` / `insert`'s one static position.
    fn position(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<usize> {
        match Self::positions(cr, op, "static_position")?[..] {
            [at] => Some(at),
            _ => None,
        }
    }

    /// The memory's dwords at a byte address: binding 0, the address unscaled.
    fn memory(n: usize) -> Vec<(&'static str, A)> {
        vec![("binding", A::from(APPLE9_MEMORY)), ("components", A::from(n as u32)), ("shift", A::from(0u32))]
    }
}

#[patterns(converter)]
#[map("arith.addi" => "apple9.iadd", via = Self::lanes(Apple9Op::Iadd))]
#[map("arith.subi" => "apple9.isub", via = Self::lanes(Apple9Op::Isub))]
#[map("arith.andi" => "apple9.and", via = Self::lanes(Apple9Op::And))]
#[map("arith.ori" => "apple9.or", via = Self::lanes(Apple9Op::Or))]
#[map("arith.xori" => "apple9.xor", via = Self::lanes(Apple9Op::Xor))]
#[map("arith.shli" => "apple9.shl", via = Self::lanes(Apple9Op::Shl))]
#[map("arith.shrui" => "apple9.shr", via = Self::lanes(Apple9Op::Shr))]
#[map("arith.shrsi" => "apple9.asr", via = Self::lanes(Apple9Op::Asr))]
#[map("arith.minsi" => "apple9.smin", via = Self::lanes(Apple9Op::Smin))]
#[map("arith.maxsi" => "apple9.smax", via = Self::lanes(Apple9Op::Smax))]
#[map("arith.minui" => "apple9.umin", via = Self::lanes(Apple9Op::Umin))]
#[map("arith.maxui" => "apple9.umax", via = Self::lanes(Apple9Op::Umax))]
#[map("arith.addf" => "apple9.fadd", via = Self::lanes(Apple9Op::Fadd))]
#[map("arith.mulf" => "apple9.fmul", via = Self::lanes(Apple9Op::Fmul))]
#[map("arith.sitofp" => "apple9.i2f", via = Self::convert(Apple9Op::I2f, true))]
#[map("arith.uitofp" => "apple9.i2f", via = Self::convert(Apple9Op::I2f, false))]
#[map("arith.fptosi" => "apple9.f2i", via = Self::convert(Apple9Op::F2i, true))]
#[map("arith.fptoui" => "apple9.f2i", via = Self::convert(Apple9Op::F2i, false))]
impl GpuToApple9 {
    #[convert("gpu.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        // no workgroup memory (yet)
        let attributions = cr.rw.body[op].get("workgroup_attributions").map(crate::Attrs::as_int).transpose();
        if cr.rw.body[op].get("gpu.kernel").is_none() || !matches!(attributions, Ok(None | Some(0))) {
            return false;
        }
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(name) = cr.rw.body[op].get("sym_name").cloned() else { return false };
        if fty.inputs.len() > APPLE9_PARAMS || !fty.results.is_empty() {
            return false;
        }
        let mut sig = SignatureConversion::new(fty.inputs.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            if !matches!(t, Type::Integer { width: 32, .. }) {
                return false;
            }
            sig.add_inputs(i, vec![Self::i32()]);
        }
        let kernel = Apple9Kernel::new(name, Some(ShaderStage::Compute), Some(fty.inputs.len() as u32), None, mlirformat::Region { blocks: Vec::new() });
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
        Self::instruction(cr, op, Apple9Op::Halt, &[], Vec::new(), Vec::new());
        cr.erase(op);
        true
    }

    #[convert("arith.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let Some(types) = Apple9Types::of(&cr.rw.body[r].ty) else { return false };
        let Some(value) = cr.rw.body[op].get("value").cloned() else { return false };
        let Some(bits) = Self::constant_bits(&value, types.len()) else { return false };
        let values = bits.iter().zip(types).map(|(b, t)| Self::imm(cr, op, *b, t)).collect();
        cr.replace(op, vec![values]);
        true
    }

    /// The low 32 bits: a * b + 0.
    #[convert("arith.muli")]
    fn muli(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let zero = Self::imm(cr, op, 0, Self::i32());
            Self::one(cr, op, Apple9Op::Imad, &[x[0], x[1], zero], Vec::new(), Self::i32())
        })
    }

    #[convert("arith.cmpi")]
    fn cmpi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Ok(c) = cr.rw.body.head::<CmpI>(op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::compare(cr, op, c.predicate, x[0], x[1]))
    }

    /// The condition (0 or 1) compared above 0.
    #[convert("arith.select")]
    fn select_op(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [c, x, y] = o else { return false };
        let Some(ty) = Self::result_type(cr, op) else { return false };
        let c = if c.len() == 1 { vec![c[0]; x.len()] } else { c.clone() };
        Self::each(cr, op, &[c, x.clone(), y.clone()], |cr, v| {
            let zero = Self::imm(cr, op, 0, Self::i32());
            Self::select(cr, op, "ugt", [v[0], zero], [v[1], v[2]], ty.clone())
        })
    }

    /// i1 ⇒ i32: 0 / 1 itself.
    #[convert("arith.extui")]
    fn extui(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let from = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !matches!(from, Type::Integer { width: 1, .. }) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    /// i1 ⇒ i32: 0 - it (0 / -1).
    #[convert("arith.extsi")]
    fn extsi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let from = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !matches!(from, Type::Integer { width: 1, .. }) {
            return false;
        }
        Self::each(cr, op, o, |cr, x| {
            let zero = Self::imm(cr, op, 0, Self::i32());
            Self::one(cr, op, Apple9Op::Isub, &[zero, x[0]], Vec::new(), Self::i32())
        })
    }

    /// `|x|`: |x| * 1.0.
    #[convert("math.absf")]
    fn absf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let one = Self::imm(cr, op, 1f32.to_bits(), Self::f32());
            Self::one(cr, op, Apple9Op::Fmul, &[x[0], one], vec![("abs", A::from(1u32))], Self::f32())
        })
    }

    /// The same bits as the other type.
    #[convert("arith.bitcast")]
    fn bitcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, Apple9Op::Or, &[x[0], x[0]], Vec::new(), ty.clone()))
    }

    /// Already 32 bits in a GPR: an index, a global pointer.
    #[convert("arith.index_cast", "arith.index_castui", "llvm.inttoptr")]
    fn same(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if Apple9Types::of(&cr.rw.body[r].ty).is_none_or(|t| t.len() != o[0].len()) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) != Some(Dimension::X) {
            return false;
        }
        let v = Self::one(cr, op, Apple9Op::GetSr, &[], vec![("selector", A::from(SR_THREADGROUP_X))], Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) != Some(Dimension::X) {
            return false;
        }
        let v = Self::one(cr, op, Apple9Op::GetSr16, &[], vec![("selector", A::from(SR_THREAD_IN_GROUP_X))], Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    /// `n` dwords at a byte address of the memory.
    #[convert("llvm.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(types) = Apple9Types::of(&ty) else { return false };
        if !Apple9Types::dwords(&ty) || types.len() > 4 {
            return false;
        }
        let n = types.len();
        let values = Self::instruction(cr, op, Apple9Op::Load, &addr[..], Self::memory(n), types);
        cr.replace(op, vec![values]);
        true
    }

    #[convert("llvm.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [value, addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !Apple9Types::dwords(&ty) || value.len() > 4 {
            return false;
        }
        let mut operands = value.clone();
        operands.extend(addr);
        Self::instruction(cr, op, Apple9Op::Store, &operands, Self::memory(value.len()), Vec::new());
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
        let (Some(types), [v]) = (Apple9Types::of(&ty), &o[0][..]) else { return false };
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
