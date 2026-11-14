use alloc::string::ToString;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::arith::{CmpF, CmpFPredicate, CmpI, CmpIPredicate};
use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, FloatKind, Scalar, ShapedKind, Type};

use super::Dimension;
use crate::{A, Apple9Kernel, Apple9Op, Apple9Type, Body, ConversionRewriter, Heads, OpData, OpHead, OpId, ShaderStage, SignatureConversion, TypeConverter, ValueId, WithAttrs, patterns};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub const APPLE9_PARAMS: usize = 8;

pub const APPLE9_WORKGROUP: u32 = 32;

pub const APPLE9_MEMORY: u32 = 0;
pub const APPLE9_PARAMETERS: u32 = 1;

pub const APPLE9_SHARED: u32 = 16384;

const SR_THREADGROUP_X: u32 = 0x9c;
const SR_THREAD_IN_GROUP_X: u32 = 0xa4;

pub struct Apple9Types;

impl Apple9Types {
    fn elem(t: &Type<'_>) -> Option<Type<'static>> {
        match t {
            Type::Float(FloatKind::F32) => Some(Type::from(Apple9Type("f32"))),
            Type::Integer { width: 32 | 1, .. } | Type::Index => Some(Type::from(Apple9Type("i32"))),
            _ => match LlvmType::try_from(t) {
                Ok(LlvmType::Ptr(1 | 3)) => Some(Type::from(Apple9Type("i32"))),
                _ => None,
            },
        }
    }

    pub fn of(t: &Type<'_>) -> Option<Vec<Type<'static>>> {
        if let Ok(LlvmType::Struct { body: Some(fields), .. }) = LlvmType::try_from(t) {
            return fields.iter().map(Self::elem).collect();
        }
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
        tc.conversion(|t| Apple9Type::try_from(t).is_ok().then(|| Some(vec![t.clone()])));
        tc
    }
}

pub struct GpuToApple9;

impl GpuToApple9 {
    fn instruction<'a>(cr: &mut Cr<'_, 'a, '_>, before: OpId, op: Apple9Op, operands: &[ValueId], attrs: Vec<(&str, A)>, types: Vec<Type<'a>>) -> Vec<ValueId> {
        let data = OpData::build(op.name()).operands(operands).with_attrs(attrs);
        cr.rw.set_before(before);
        let i = cr.rw.create(data, &types);
        cr.rw.body[i].results.to_vec()
    }

    fn one(cr: &mut Cr<'_, '_, '_>, before: OpId, op: Apple9Op, operands: &[ValueId], attrs: Vec<(&str, A)>, ty: Type<'static>) -> ValueId {
        Self::instruction(cr, before, op, operands, attrs, vec![ty])[0]
    }

    fn i32() -> Type<'static> {
        Type::from(Apple9Type("i32"))
    }

    fn f32() -> Type<'static> {
        Type::from(Apple9Type("f32"))
    }

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

    fn lanes(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: Apple9Op) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, inst, x, Vec::new(), ty.clone()))
    }

    fn convert(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], _: &str, inst: Apple9Op, signed: bool) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, inst, x, if signed { vec![("signed", A::Bool(true))] } else { Vec::new() }, ty.clone()))
    }

    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, cond: &str, ab: [ValueId; 2], tf: [ValueId; 2], ty: Type<'static>) -> ValueId {
        Self::one(cr, op, Apple9Op::Select, &[ab[0], ab[1], tf[0], tf[1]], vec![("cond", A::str(cond))], ty)
    }

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
            eq | ne => {
                let (yes, no) = if pred == eq { (one, zero) } else { (zero, one) };
                let not_less = Self::select(cr, op, "ult", [a, b], [no, yes], Self::i32());
                Self::select(cr, op, "ugt", [a, b], [no, not_less], Self::i32())
            }
        }
    }

    fn fcompare(cr: &mut Cr<'_, '_, '_>, op: OpId, pred: CmpFPredicate, a: ValueId, b: ValueId) -> ValueId {
        use CmpFPredicate as P;
        let one = Self::imm(cr, op, 1, Self::i32());
        let zero = Self::imm(cr, op, 0, Self::i32());
        let sel = |cr: &mut Cr<'_, '_, '_>, cond: &str, x: ValueId, y: ValueId, t: ValueId, f: ValueId| Self::select(cr, op, cond, [x, y], [t, f], Self::i32());
        let or_eq = |cr: &mut Cr<'_, '_, '_>, cond: &str, yes: ValueId, no: ValueId| {
            let eq = sel(cr, "feq", a, b, yes, no);
            sel(cr, cond, a, b, yes, eq)
        };
        match pred {
            P::AlwaysFalse => zero,
            P::AlwaysTrue => one,
            P::oeq => sel(cr, "feq", a, b, one, zero),
            P::une => sel(cr, "feq", a, b, zero, one),
            P::ogt => sel(cr, "fgt", a, b, one, zero),
            P::ule => sel(cr, "fgt", a, b, zero, one),
            P::olt => sel(cr, "flt", a, b, one, zero),
            P::uge => sel(cr, "flt", a, b, zero, one),
            P::oge => or_eq(cr, "fgt", one, zero),
            P::ult => or_eq(cr, "fgt", zero, one),
            P::ole => or_eq(cr, "flt", one, zero),
            P::ugt => or_eq(cr, "flt", zero, one),
            P::one | P::ueq => {
                let (yes, no) = if pred == P::one { (one, zero) } else { (zero, one) };
                let gt = sel(cr, "fgt", a, b, yes, no);
                sel(cr, "flt", a, b, yes, gt)
            }
            P::ord | P::uno => {
                let (yes, no) = if pred == P::ord { (one, zero) } else { (zero, one) };
                let bb = sel(cr, "feq", b, b, yes, no);
                sel(cr, "feq", a, a, bb, no)
            }
        }
    }

    fn constant_bits(value: &Attribute<'_>, n: usize) -> Option<Vec<u32>> {
        let c = Const::try_from(value).ok()?;
        let bits = |s: Scalar| match s {
            Scalar::Float(f) => (f.kind == FloatKind::F32).then_some(f.bits as u32),
            Scalar::Int(i) => (i.width == 32 || i.width == 1 || i.width == 64).then_some(i.bits() as u32),
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

    fn structured(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let name = cr.rw.body[op].name.to_string();
        let types: Vec<Type<'_>> = cr.rw.body[op].results.iter().map(|r| cr.rw.body[*r].ty.clone()).collect();
        let Some(results) = types.iter().map(Apple9Types::of).collect::<Option<Vec<_>>>() else { return false };
        let regions = cr.rw.body[op].regions.to_vec();
        let mut sigs = Vec::new();
        for r in &regions {
            let Some(&entry) = cr.rw.body[*r].blocks.first() else {
                sigs.push(None);
                continue;
            };
            let args: Vec<Type<'_>> = cr.rw.body[entry].args.iter().map(|a| cr.rw.body[*a].ty.clone()).collect();
            let mut sig = SignatureConversion::new(args.len());
            for (i, t) in args.iter().enumerate() {
                let Some(g) = Apple9Types::of(t) else { return false };
                sig.add_inputs(i, g);
            }
            sigs.push(Some(sig));
        }
        let mut data = OpData::build(&name).operands(&o.concat());
        for a in cr.rw.body[op].attributes.clone() {
            data.set(&a.name, a.value.unwrap_or(Attribute::Unit));
        }
        cr.rw.set_before(op);
        let flat: Vec<Type<'_>> = results.concat();
        let n = regions.len();
        let new = cr.rw.create_with(data, &flat, |b, k| {
            for _ in 0..n {
                b.add_region(k);
            }
        });
        let Some(current) = cr.current else { return false };
        for (i, (r, sig)) in regions.iter().zip(&sigs).enumerate() {
            let into = cr.rw.body[new].regions[i];
            cr.inline_region(*r, into, None);
            if cr.convert_region_types(into, current, sig.as_ref()).is_none() {
                return false;
            }
        }
        let mut values = cr.rw.body[new].results.iter().copied();
        let grouped = results.iter().map(|g| values.by_ref().take(g.len()).collect()).collect();
        cr.replace(op, grouped);
        true
    }

    fn predicate(cr: &mut Cr<'_, '_, '_>, before: OpId, c: ValueId, looped: bool) {
        let zero = Self::imm(cr, before, 0, Self::i32());
        let mut attrs = vec![("cond", A::str("ieq"))];
        if looped {
            attrs.push(("loop", A::Bool(true)));
        }
        Self::instruction(cr, before, Apple9Op::Pred, &[c, zero], attrs, Vec::new());
    }

    pub fn structured_legal(body: &Body<'_>, op: OpId) -> bool {
        let reg = |v: &ValueId| Apple9Type::try_from(&body[*v].ty).is_ok();
        let args = body[op].regions.iter().flat_map(|r| body[*r].blocks.iter().flat_map(|b| body[*b].args.iter()));
        body[op].operands.iter().all(reg) && body[op].results.iter().all(reg) && args.into_iter().all(reg)
    }

    pub fn workgroup(body: &Body<'_>, f: OpId) -> Result<u32, mlirformat::Error> {
        match body[f].get("known_block_size").map(|a| a.dense_values()) {
            None => Ok(APPLE9_WORKGROUP),
            Some(Some(v)) if matches!(v[..], [16 | 32, 1, 1]) => Ok(v[0] as u32),
            Some(v) => Err(mlirformat::Error(alloc::format!("apple9: a workgroup of {v:?} (16 x 1 x 1 or 32 x 1 x 1)"))),
        }
    }

    pub fn half_workgroups(body: &mut Body<'_>, kernels: &[OpId]) -> Result<(), mlirformat::Error> {
        let mut quiet = crate::Quiet;
        let mut rw = crate::Rewriter::new(body, &mut quiet);
        for &f in kernels {
            if Self::workgroup(rw.body, f)? != 16 {
                continue;
            }
            let attributions = rw.body[f].get("workgroup_attributions").map(crate::Attrs::as_int).transpose()?.unwrap_or(0);
            let mut ids = Vec::new();
            let mut barrier = false;
            rw.body.walk(f, &mut |o| match &*rw.body[o].name {
                "gpu.block_id" | "gpu.thread_id" | "gpu.block_dim" => ids.push(o),
                "gpu.barrier" => barrier = true,
                _ => {}
            });
            if barrier || attributions > 0 {
                return Err(mlirformat::Error("apple9: a workgroup of 16 with a barrier or workgroup memory (two share a hardware workgroup of 32)".into()));
            }
            let index = |rw: &mut crate::Rewriter<'_, '_>, v: i64| {
                let c = rw.create(OpData::build("arith.constant").with("value", Attribute::index(v)), &[Type::Index]);
                rw.body[c].results[0]
            };
            let x = |rw: &crate::Rewriter<'_, '_>, o: OpId| rw.body[o].get("dimension").and_then(|a| super::Dimension::try_from(a).ok()) == Some(super::Dimension::X);
            for o in ids {
                if !x(&rw, o) {
                    continue;
                }
                let r = rw.body[o].results[0];
                let uses: Vec<crate::Use> = rw.body[r].uses.to_vec();
                rw.set_after(o);
                let v = match &*rw.body[o].name {
                    "gpu.block_id" => {
                        let t = rw.create(OpData::build("gpu.thread_id").with("dimension", rw.body[o].get("dimension").cloned().unwrap_or(Attribute::Unit)), &[Type::Index]);
                        let t = rw.body[t].results[0];
                        let (four, two) = (index(&mut rw, 4), index(&mut rw, 2));
                        let half = rw.create(OpData::build("arith.shrui").operands(&[t, four]), &[Type::Index]);
                        let twice = rw.create(OpData::build("arith.muli").operands(&[r, two]), &[Type::Index]);
                        let (half, twice) = (rw.body[half].results[0], rw.body[twice].results[0]);
                        let sum = rw.create(OpData::build("arith.addi").operands(&[twice, half]), &[Type::Index]);
                        rw.body[sum].results[0]
                    }
                    "gpu.thread_id" => {
                        let fifteen = index(&mut rw, 15);
                        let low = rw.create(OpData::build("arith.andi").operands(&[r, fifteen]), &[Type::Index]);
                        rw.body[low].results[0]
                    }
                    _ => index(&mut rw, 16),
                };
                for u in uses {
                    rw.modify(u.op, |b| b.set_operand(u.op, u.index as usize, v));
                }
                if rw.body[o].name == "gpu.block_dim" {
                    rw.erase_op(o);
                }
            }
        }
        Ok(())
    }

    pub fn for_to_while(body: &mut Body<'_>, ops: &[OpId]) {
        let mut fors = Vec::new();
        for &op in ops {
            body.walk(op, &mut |o| {
                if body[o].name == "scf.for" {
                    fors.push(o);
                }
            });
        }
        let mut quiet = crate::Quiet;
        let mut rw = crate::Rewriter::new(body, &mut quiet);
        for f in fors {
            let operands = rw.body[f].operands.to_vec();
            let (lb, ub, step) = (operands[0], operands[1], operands[2]);
            let mut inits = vec![lb];
            inits.extend(&operands[3..]);
            let types = rw.body.types(&inits);
            let old = rw.body.top_block(f);
            rw.set_before(f);
            let w = rw.with_body(OpData::build("scf.while").operands(&inits), &types, &[types.clone(), types.clone()], &mut |rw, k, args| {
                if k == 0 {
                    let c = rw.create(OpData::build("arith.cmpi").operands(&[args[0], ub]).with("predicate", Attribute::i64(2)), &[Type::int(1)]);
                    let c = rw.body[c].results[0];
                    let mut forwarded = vec![c];
                    forwarded.extend(args);
                    rw.create(OpData::build("scf.condition").operands(&forwarded), &[]);
                }
            });
            let after = rw.body[rw.body[w].regions[1]].blocks[0];
            let args = rw.body[after].args.to_vec();
            rw.inline_block_before(old, after, None, &args);
            if let Some(y) = rw.body.last_op(after).filter(|y| rw.body[*y].name == "scf.yield") {
                rw.set_before(y);
                let next = rw.create(OpData::build("arith.addi").operands(&[args[0], step]), &[types[0].clone()]);
                let mut yielded = vec![rw.body[next].results[0]];
                yielded.extend(rw.body[y].operands.to_vec());
                rw.create(OpData::build("scf.yield").operands(&yielded), &[]);
                rw.erase_op(y);
            }
            let results = rw.body[w].results[1..].to_vec();
            rw.replace_op(f, &results);
        }
    }

    fn bytes(t: &Type<'_>) -> Option<u32> {
        let Type::Shaped(s) = t else { return None };
        let n: i64 = t.dims()?.iter().product();
        Some(n as u32 * (s.elem.bit_width()? as u32 / 8))
    }

    fn shared(t: &Type<'_>) -> Option<bool> {
        match LlvmType::try_from(t) {
            Ok(LlvmType::Ptr(3)) => Some(true),
            Ok(LlvmType::Ptr(1)) => Some(false),
            _ => None,
        }
    }

    fn word(cr: &mut Cr<'_, '_, '_>, before: OpId, addr: ValueId) -> ValueId {
        let two = Self::imm(cr, before, 2, Self::i32());
        Self::one(cr, before, Apple9Op::Shr, &[addr, two], Vec::new(), Self::i32())
    }

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
#[map("arith.subf" => "apple9.fsub", via = Self::lanes(Apple9Op::Fsub))]
#[map("math.fma" => "apple9.fma", via = Self::lanes(Apple9Op::Fma))]
#[map("arith.minnumf" => "apple9.fmin", via = Self::lanes(Apple9Op::Fmin))]
#[map("arith.maxnumf" => "apple9.fmax", via = Self::lanes(Apple9Op::Fmax))]
#[map("math.floor" => "apple9.floor", via = Self::lanes(Apple9Op::Floor))]
#[map("math.ceil" => "apple9.ceil", via = Self::lanes(Apple9Op::Ceil))]
#[map("math.trunc" => "apple9.trunc", via = Self::lanes(Apple9Op::Trunc))]
#[map("math.roundeven" => "apple9.roundeven", via = Self::lanes(Apple9Op::Roundeven))]
#[map("arith.sitofp" => "apple9.i2f", via = Self::convert(Apple9Op::I2f, true))]
#[map("arith.uitofp" => "apple9.i2f", via = Self::convert(Apple9Op::I2f, false))]
#[map("arith.fptosi" => "apple9.f2i", via = Self::convert(Apple9Op::F2i, true))]
#[map("arith.fptoui" => "apple9.f2i", via = Self::convert(Apple9Op::F2i, false))]
impl GpuToApple9 {
    #[convert("gpu.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if !cr.rw.body[op].gpu_kernel() {
            return false;
        }
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(name) = cr.rw.body[op].get("sym_name").cloned() else { return false };
        if fty.inputs.len() > APPLE9_PARAMS || !fty.results.is_empty() {
            return false;
        }
        let entry = cr.rw.body[cr.rw.body[op].regions[0]].blocks[0];
        let attributions: Vec<ValueId> = cr.rw.body[entry].args[fty.inputs.len()..].to_vec();
        let mut shared = 0;
        for a in &attributions {
            if !cr.rw.body[*a].uses.is_empty() {
                return false;
            }
            let Some(n) = Self::bytes(&cr.rw.body[*a].ty) else { return false };
            shared += n;
        }
        if shared > APPLE9_SHARED {
            return false;
        }
        let mut sig = SignatureConversion::new(fty.inputs.len() + attributions.len());
        for (i, t) in fty.inputs.iter().enumerate() {
            if !matches!(t, Type::Integer { width: 32, .. }) {
                return false;
            }
            sig.add_inputs(i, vec![Self::i32()]);
        }
        for i in 0..attributions.len() {
            sig.add_inputs(fty.inputs.len() + i, Vec::new());
        }
        let Ok(workgroup) = Self::workgroup(cr.rw.body, op) else { return false };
        let kernel = Apple9Kernel::new(name, Some(ShaderStage::Compute), Some(fty.inputs.len() as u32), None, (shared > 0).then_some(shared), Some(workgroup), mlirformat::Region { blocks: Vec::new() });
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

    #[convert("scf.if")]
    fn scf_if(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(&[c]) = o.first().map(Vec::as_slice) else { return false };
        Self::predicate(cr, op, c, false);
        Self::structured(cr, op, o)
    }

    #[convert("scf.while")]
    fn scf_while(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::structured(cr, op, o)
    }

    #[convert("scf.condition")]
    fn scf_condition(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(&[c]) = o.first().map(Vec::as_slice) else { return false };
        Self::predicate(cr, op, c, true);
        cr.rw.set_before(op);
        cr.rw.create(OpData::build("scf.condition").operands(&o.concat()), &[]);
        cr.erase(op);
        true
    }

    #[convert("scf.yield")]
    fn scf_yield(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        cr.rw.set_before(op);
        cr.rw.create(OpData::build("scf.yield").operands(&o.concat()), &[]);
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

    #[convert("arith.extui")]
    fn extui(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let from = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        if !matches!(from, Type::Integer { width: 1, .. }) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

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

    #[convert("math.absf")]
    fn absf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let m = Self::imm(cr, op, 0x7fff_ffff, Self::i32());
            Self::one(cr, op, Apple9Op::And, &[x[0], m], Vec::new(), Self::f32())
        })
    }

    #[convert("arith.negf")]
    fn negf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let m = Self::imm(cr, op, 0x8000_0000, Self::i32());
            Self::one(cr, op, Apple9Op::Xor, &[x[0], m], Vec::new(), Self::f32())
        })
    }

    #[convert("arith.cmpf")]
    fn cmpf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Ok(c) = cr.rw.body.head::<CmpF>(op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::fcompare(cr, op, c.predicate, x[0], x[1]))
    }

    #[convert("arith.divf")]
    fn divf(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| Exact { cr, at: op }.div(x[0], x[1]))
    }

    #[convert("math.sqrt")]
    fn sqrt(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| Exact { cr, at: op }.sqrt(x[0]))
    }

    #[convert("arith.bitcast")]
    fn bitcast(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(ty) = Self::result_type(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::one(cr, op, Apple9Op::Or, &[x[0], x[0]], Vec::new(), ty.clone()))
    }

    #[convert("arith.index_cast", "arith.index_castui", "llvm.inttoptr")]
    fn same(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        if Apple9Types::of(&cr.rw.body[r].ty).is_none_or(|t| t.len() != o[0].len()) {
            return false;
        }
        cr.replace(op, vec![o[0].clone()]);
        true
    }

    fn dimension(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<u32> {
        match cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok())? {
            Dimension::X => Some(0),
            Dimension::Y => Some(1),
            Dimension::Z => Some(2),
        }
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = Self::dimension(cr, op) else { return false };
        let v = Self::one(cr, op, Apple9Op::GetSr, &[], vec![("selector", A::from(SR_THREADGROUP_X + d))], Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = Self::dimension(cr, op) else { return false };
        let v = if d == 0 { Self::one(cr, op, Apple9Op::GetSr16, &[], vec![("selector", A::from(SR_THREAD_IN_GROUP_X))], Self::i32()) } else { Self::imm(cr, op, 0, Self::i32()) };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.grid_dim")]
    fn grid_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = Self::dimension(cr, op) else { return false };
        let zero = Self::imm(cr, op, 0, Self::i32());
        let attrs = vec![("binding", A::from(APPLE9_PARAMETERS)), ("shift", A::from(0u32)), ("grid", A::from(d))];
        let v = Self::one(cr, op, Apple9Op::Load, &[zero], attrs, Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.block_dim")]
    fn block_dim(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = Self::dimension(cr, op) else { return false };
        let v = Self::imm(cr, op, if d == 0 { APPLE9_WORKGROUP } else { 1 }, Self::i32());
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("llvm.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(types) = Apple9Types::of(&ty) else { return false };
        if !Apple9Types::dwords(&ty) || types.len() > 4 {
            return false;
        }
        let n = types.len();
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[0]].ty) else { return false };
        let values = if shared {
            let index = Self::word(cr, op, addr[0]);
            types.into_iter().enumerate().map(|(k, t)| Self::one(cr, op, Apple9Op::SharedLoad, &[index], vec![("offset", A::from(k as u32))], t)).collect()
        } else {
            Self::instruction(cr, op, Apple9Op::Load, &addr[..], Self::memory(n), types)
        };
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
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[1]].ty) else { return false };
        if shared {
            let index = Self::word(cr, op, addr[0]);
            for (k, v) in value.iter().enumerate() {
                Self::instruction(cr, op, Apple9Op::SharedStore, &[*v, index], vec![("offset", A::from(k as u32))], Vec::new());
            }
        } else {
            let mut operands = value.clone();
            operands.extend(addr);
            Self::instruction(cr, op, Apple9Op::Store, &operands, Self::memory(value.len()), Vec::new());
        }
        cr.erase(op);
        true
    }

    #[convert("llvm.atomicrmw")]
    fn atomic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use mlirformat::llvm::AtomicBinOp as B;
        let [addr, value] = o else { return false };
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[0]].ty) else { return false };
        if value.len() != 1 {
            return false;
        }
        let Some(ty) = Self::result_type(cr, op) else { return false };
        if ty != Self::i32() {
            return false;
        }
        let Ok(rmw) = cr.rw.body.head::<mlirformat::llvm::AtomicRMWOp>(op) else { return false };
        let name = match rmw.bin_op {
            B::Add => "add",
            B::Sub => "sub",
            B::And => "and",
            B::Or => "or",
            B::Xor => "xor",
            B::Min => "smin",
            B::Max => "smax",
            B::Umin => "umin",
            B::Umax => "umax",
            B::Xchg => "xchg",
            _ => return false,
        };
        let index = Self::word(cr, op, addr[0]);
        let old = if shared {
            Self::one(cr, op, Apple9Op::SharedAtomic, &[value[0], index], vec![("op", A::str(name))], ty)
        } else {
            Self::one(cr, op, Apple9Op::Atomic, &[value[0], index], vec![("op", A::str(name)), ("binding", A::from(APPLE9_MEMORY))], ty)
        };
        cr.replace(op, vec![vec![old]]);
        true
    }

    #[convert("llvm.cmpxchg")]
    fn cmpxchg(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr, cmp, value] = o else { return false };
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[0]].ty) else { return false };
        if cmp.len() != 1 || value.len() != 1 {
            return false;
        }
        let r = cr.rw.body[op].results[0];
        if Apple9Types::of(&cr.rw.body[r].ty) != Some(vec![Self::i32(), Self::i32()]) {
            return false;
        }
        let index = Self::word(cr, op, addr[0]);
        let old = if shared {
            Self::one(cr, op, Apple9Op::SharedAtomic, &[value[0], cmp[0], index], vec![("op", A::str("cmpxchg")), ("components", A::from(2u32))], Self::i32())
        } else {
            let attrs = vec![("binding", A::from(APPLE9_MEMORY)), ("components", A::from(2u32))];
            Self::one(cr, op, Apple9Op::Cmpxchg, &[value[0], cmp[0], index], attrs, Self::i32())
        };
        let swapped = Self::compare(cr, op, CmpIPredicate::eq, old, cmp[0]);
        cr.replace(op, vec![vec![old, swapped]]);
        true
    }

    #[convert("llvm.extractvalue")]
    fn extractvalue(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(at) = Self::positions(cr, op, "position").and_then(|p| (p.len() == 1).then(|| p[0])) else { return false };
        let Some(v) = o[0].get(at).copied() else { return false };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.barrier")]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        Self::instruction(cr, op, Apple9Op::Barrier, &[], Vec::new(), Vec::new());
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

struct Exact<'c, 'r, 'a, 'p> {
    cr: &'c mut Cr<'r, 'a, 'p>,
    at: OpId,
}

impl Exact<'_, '_, '_, '_> {
    fn f32(&mut self, v: f32) -> ValueId {
        GpuToApple9::imm(self.cr, self.at, v.to_bits(), GpuToApple9::f32())
    }

    fn i32(&mut self, v: u32) -> ValueId {
        GpuToApple9::imm(self.cr, self.at, v, GpuToApple9::i32())
    }

    fn op(&mut self, inst: Apple9Op, x: &[ValueId], attrs: Vec<(&str, A)>) -> ValueId {
        GpuToApple9::one(self.cr, self.at, inst, x, attrs, GpuToApple9::f32())
    }

    fn mad(&mut self, a: ValueId, b: ValueId, c: ValueId, neg: bool) -> ValueId {
        self.op(Apple9Op::Fma, &[b, c, a], if neg { vec![("neg_product", A::Bool(true))] } else { Vec::new() })
    }

    fn mul(&mut self, a: ValueId, b: ValueId) -> ValueId {
        self.op(Apple9Op::Fmul, &[a, b], Vec::new())
    }

    fn sel(&mut self, cond: &str, x: ValueId, y: ValueId, t: ValueId, f: ValueId) -> ValueId {
        GpuToApple9::select(self.cr, self.at, cond, [x, y], [t, f], GpuToApple9::f32())
    }

    fn finite_or(&mut self, v: ValueId, fallback: ValueId) -> ValueId {
        let d = self.op(Apple9Op::Fsub, &[v, v], Vec::new());
        let z = self.f32(0.0);
        self.sel("feq", d, z, v, fallback)
    }

    fn below(&mut self, x: ValueId, bound: f32, then: ValueId, other: ValueId) -> ValueId {
        let m = self.i32(0x7fff_ffff);
        let ax = self.op(Apple9Op::And, &[x, m], Vec::new());
        let b = self.f32(bound);
        self.sel("flt", ax, b, then, other)
    }

    fn pow2(e: i32) -> f32 {
        f32::from_bits(((127 + e) as u32) << 23)
    }

    fn div(&mut self, a: ValueId, b: ValueId) -> ValueId {
        let one = self.f32(1.0);
        let up = self.f32(Self::pow2(64));
        let small = self.below(a, Self::pow2(-100), up, one);
        let s = self.below(b, Self::pow2(-100), up, small);
        let a = self.mul(a, s);
        let b = self.mul(b, s);
        let y0 = self.op(Apple9Op::Rcp, &[b], Vec::new());
        let e = self.mad(one, b, y0, true);
        let y1 = self.mad(y0, e, y0, false);
        let q0 = self.mul(a, y1);
        let r = self.mad(a, b, q0, true);
        let q1 = self.mad(q0, r, y1, false);
        let rough = self.mul(a, y0);
        let q = self.finite_or(q1, rough);
        let z = self.f32(0.0);
        self.sel("feq", a, z, rough, q)
    }

    fn sqrt(&mut self, a: ValueId) -> ValueId {
        let one = self.f32(1.0);
        let up = self.f32(Self::pow2(64));
        let down = self.f32(Self::pow2(-32));
        let s = self.below(a, Self::pow2(-100), up, one);
        let back = self.below(a, Self::pow2(-100), down, one);
        let a = self.mul(a, s);
        let half = self.f32(0.5);
        let y0 = self.op(Apple9Op::Rsq, &[a], Vec::new());
        let g0 = self.mul(a, y0);
        let h0 = self.mul(half, y0);
        let d = self.mad(half, g0, h0, true);
        let g1 = self.mad(g0, g0, d, false);
        let h1 = self.mad(h0, h0, d, false);
        let r = self.mad(a, g1, g1, true);
        let g2 = self.mad(g1, r, h1, false);
        let rough = self.mul(a, y0);
        let root = self.finite_or(g2, rough);
        let z = self.f32(0.0);
        let root = self.sel("feq", a, z, a, root);
        let inf = self.f32(f32::INFINITY);
        let root = self.sel("feq", a, inf, a, root);
        self.mul(root, back)
    }
}
