#[allow(unused_imports, reason = "the alloc prelude")]
use alloc::{borrow::ToOwned, format, string::{String, ToString}, vec, vec::Vec};

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, Error, FloatKind, Op, Scalar, ShapedKind, Type};

use super::Dimension;
use mlirformat::spirv_types::SpirvType;

use crate::{A, AddrSize, AddrSurface, Attrs, Body, Xe3Sampler as Sampler, CacheStore, ConversionRewriter, DataSize, EuPayload, Grf, Heads, Lsc, LscOp, OpData, OpHead, OpId, Quiet, Render, Rewriter, SendInfo, ShaderStage as Stage, SignatureConversion, Sfid, TypeConverter, Updates, ValueId, VectSize, WithAttrs, Xe3Kernel as Kernel, patterns};

const GATEWAY_BARRIER: u32 = 4;

const LSC_SLM_FENCE: u32 = 31 | 2 << 7;

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

pub const XE3_COMPUTE_PARAMS: usize = 8;

pub const XE3_COMPUTE_INLINE_GRF: u8 = 2;

pub const XE3_BUFFER_BTI: u8 = 32;

pub const XE3_PUSH_BTI: u8 = XE3_BUFFER_BTI - 1;

pub const XE3_SIMD: u8 = 16;

pub const XE3_VS_ATTR_GRF: u8 = 2;

pub const XE3_MAX_VARYINGS: usize = 2;

pub const XE3_MAX_TARGETS: usize = 8;

pub struct Interpolate;

impl Interpolate {
    pub const BX: u8 = 1;
    pub const BY: u8 = 2;
    pub const fn setup(imask: bool) -> u8 {
        3 + imask as u8
    }

    pub const fn coverage(varyings: bool) -> u8 {
        if varyings { 3 } else { 1 }
    }

    pub fn plane(setup: u8, k: usize, p: usize) -> String {
        let reg = setup as usize + k / 5;
        let byte = (k % 5) * 12 + 4 * p;
        format!("r{reg}.{byte}<0;1,0>:f")
    }

    pub fn end(setup: u8, components: usize) -> u8 {
        setup + components.div_ceil(5) as u8
    }
}

pub struct Xe3Types;

impl Xe3Types {
    fn elem(t: &Type<'_>) -> Option<&'static str> {
        match t {
            Type::Float(FloatKind::F32) | Type::Integer { width: 1, .. } => Some("f32"),
            Type::Integer { width: 8 | 16 | 32, .. } | Type::Index => Some("i32"),
            Type::Float(FloatKind::F64) => Some("f64"),
            Type::Integer { width: 64, .. } => Some("i64"),
            _ => match LlvmType::try_from(t) {
                Ok(LlvmType::Ptr(1 | 3)) => Some("i32"),
                _ => None,
            },
        }
    }

    pub fn of(t: &Type<'_>) -> Option<(usize, &'static str)> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => match t.dims()?[..] {
                [n] if n > 0 => Some((n as usize, Self::elem(&s.elem)?)),
                _ => None,
            },
            _ => Some((1, Self::elem(t)?)),
        }
    }

    pub fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(|t| Self::of(t).map(|(n, e)| Some(vec![Type::from(Grf(e)); n])));
        tc.conversion(|t| matches!(SpirvType::try_from(t), Ok(SpirvType::Ptr { .. } | SpirvType::Image { .. } | SpirvType::SampledImage(_))).then(|| Some(Vec::new())));
        tc.conversion(|t| Grf::try_from(t).is_ok().then(|| Some(vec![t.clone()])));
        tc
    }
}

pub struct GpuToXe3;

impl GpuToXe3 {
    pub const STAGE: &str = "spirv.execution_model";
    const SAMPLE_MASK: &str = "xe3.sample_mask";
    const BINDINGS: &str = "xe3.bindings";
    const BUFFERS: &str = "xe3.buffers";
    const PUSH: &str = "xe3.push";
    const BINDING: &str = "xe3.binding";
    const OFFSET: &str = "xe3.offset";
    const PUSH_AT: &str = "xe3.push_offset";
    const DUAL_SOURCE: &str = "xe3.dual_source";

    fn ieee_prologue<'a>() -> [OpData<'a>; 2] {
        let or = vec![("exec", A::from(1u8)), ("dst", A::str("arf128<1>:ud")), ("src0", A::str("arf128<0;1,0>:ud")), ("src1", A::str("0xc0:ud")), ("w", A::Bool(true))];
        let sync = vec![("exec", A::from(1u8)), ("fn", A::str("nop")), ("swsb", A::str("A@1"))];
        [OpData::build("xe3.eu.or").with_attrs(or), OpData::build("xe3.eu.sync").with_attrs(sync)]
    }

    pub fn resources(body: &mut Body<'_>, shaders: &[OpId]) -> Result<(), Error> {
        for &f in shaders {
            let Some(Attribute::Array(attrs)) = body[f].get("arg_attrs").cloned() else { continue };
            let block = body.top_block(f);
            let args = body[block].args.clone();
            let mut res: alloc::collections::BTreeMap<ValueId, (String, i64)> = alloc::collections::BTreeMap::new();
            for (a, d) in args.iter().zip(&attrs) {
                let Attribute::Dict(d) = d else { continue };
                let Some(abi) = d.iter().find(|n| n.name == "spirv.interface_var_abi").and_then(|n| n.value.as_ref()) else { continue };
                let text = abi.to_string();
                let inner = text.split_once("<(").and_then(|(_, r)| r.split_once(')')).ok_or_else(|| Error(format!("{text}: not an interface ABI")))?;
                let binding = inner.0.split(',').nth(1).and_then(|b| b.trim().parse().ok()).ok_or_else(|| Error(format!("{text}: no binding")))?;
                let class = inner.1.trim_start_matches(',').trim().trim_end_matches('>').to_owned();
                res.insert(*a, (class, binding));
            }
            let mut ops = Vec::new();
            body.walk(f, &mut |o| ops.push(o));
            let (mut textures, mut buffers, mut push) = (0i64, 0i64, 0i64);
            let root = |body: &Body<'_>, mut v: ValueId| -> Option<ValueId> {
                for _ in 0..4 {
                    if res.contains_key(&v) {
                        return Some(v);
                    }
                    let crate::Def::Result(d, _) = body[v].def else { return None };
                    v = *body[d].operands.first()?;
                }
                None
            };
            for o in ops {
                let name = body[o].name.to_string();
                if name.starts_with("spirv.Image") {
                    let Some(r) = body[o].operands.first().and_then(|v| root(body, *v)) else { continue };
                    let b = res[&r].1;
                    textures = textures.max(b + 1);
                    body[o].set(Self::BINDING, A::from(b).into());
                } else if name == "spirv.Load" {
                    let p = body[o].operands[0];
                    let crate::Def::Result(chain, _) = body[p].def else { continue };
                    if body[chain].name != "spirv.AccessChain" {
                        continue;
                    }
                    let base = body[chain].operands[0];
                    let Some((class, b)) = res.get(&base).cloned() else { continue };
                    let offset = Self::member_offset(body, base, &body[chain].operands[1..]).ok_or_else(|| Error("a resource access chain: not constant struct members".into()))?;
                    let ty = body[body[o].results[0]].ty.clone();
                    let bytes = Xe3Types::of(&ty).map_or(4, |(n, _)| 4 * n as i64);
                    if class == "PushConstant" {
                        push = push.max(offset + bytes);
                        body[o].set(Self::PUSH_AT, A::from(offset).into());
                    } else {
                        buffers = buffers.max(b + 1);
                        body[o].set(Self::BINDING, A::from(b).into());
                        body[o].set(Self::OFFSET, A::from(offset).into());
                    }
                    body.set_operand(o, 0, base);
                    if body[p].uses.is_empty() {
                        let indices: Vec<ValueId> = body[chain].operands[1..].to_vec();
                        body.erase(chain);
                        for i in indices {
                            if let crate::Def::Result(c, _) = body[i].def
                                && body[i].uses.is_empty()
                            {
                                body.erase(c);
                            }
                        }
                    }
                }
            }
            body[f].set(Self::BINDINGS, A::from(textures).into());
            body[f].set(Self::BUFFERS, A::from(buffers).into());
            body[f].set(Self::PUSH, A::from(push).into());
        }
        Ok(())
    }

    fn member_offset(body: &Body<'_>, base: ValueId, indices: &[ValueId]) -> Option<i64> {
        let Ok(SpirvType::Ptr { pointee, .. }) = SpirvType::try_from(&body[base].ty) else { return None };
        let mut ty = (*pointee).clone();
        let mut at = 0i64;
        for i in indices {
            let crate::Def::Result(c, _) = body[*i].def else { return None };
            let k = Attrs::as_int(body[c].get("value")?).ok()? as usize;
            match SpirvType::try_from(&ty).ok()? {
                SpirvType::Struct { members: Some(m), .. } => {
                    at += i64::from(m.get(k)?.offset?);
                    ty = m[k].ty.clone();
                }
                _ => return None,
            }
        }
        Some(at)
    }

    pub fn place_arguments<'a>(body: &mut Body<'a>, module: OpId) -> Result<(), Error> {
        let mut quiet = Quiet;
        let mut rw = Rewriter::new(body, &mut quiet);
        let f32 = Type::from(Grf("f32"));
        let put = |rw: &mut Rewriter<'_, 'a>, data: OpData<'a>, ty: Type<'a>| {
            let p = rw.create(data.with_attrs(vec![("exec", A::from(XE3_SIMD))]), &[ty]);
            rw.body[p].results[0]
        };
        for k in crate::Kernels::all(rw.body, module, Kernel::NAME) {
            let head = rw.body.head::<Kernel>(k)?;
            let regs = head.payload.unwrap_or_default();
            let (fragment, compute) = (head.stage == Some(Stage::Fragment), head.stage == Some(Stage::Compute));
            let setup = Interpolate::setup(head.imask == Some(true));
            let block = rw.body.top_block(k);
            let args = rw.body[block].args.clone();
            rw.set_start(block);
            let bary = if fragment && !args.is_empty() {
                let [bx, by] = [Interpolate::BX, Interpolate::BY].map(|g| OpData::of(&EuPayload::new(g.into(), Grf("f32").into())).map(|(data, _)| data));
                Some((put(&mut rw, bx?, f32.clone()), put(&mut rw, by?, f32.clone())))
            } else {
                None
            };
            for (n, arg) in args.into_iter().enumerate() {
                let g = *regs.get(n).ok_or_else(|| Error("kernel: more arguments than payload entries".into()))?;
                let ty = rw.body[arg].ty.clone();
                let v = match bary {
                    Some((bx, by)) => {
                        let k = g as usize;
                        let a = OpData::build("xe3.eu.mad").operands(&[bx]).with_attrs(vec![("src0", A::str(Interpolate::plane(setup, k, 0))), ("src2", A::str(Interpolate::plane(setup, k, 1)))]);
                        let v = put(&mut rw, a, f32.clone());
                        put(&mut rw, OpData::build("xe3.eu.mad").operands(&[v, by]).with_attrs(vec![("src2", A::str(Interpolate::plane(setup, k, 2)))]), f32.clone())
                    }
                    None if compute => put(&mut rw, OpData::build("xe3.eu.mov").with_attrs(vec![("src0", A::str(format!("r{XE3_COMPUTE_INLINE_GRF}.{}<0;1,0>:ud", 4 * g)))]), ty),
                    None => put(&mut rw, OpData::of(&EuPayload::new(g, ty.clone()))?.0, ty),
                };
                rw.replace_all_uses(arg, v);
            }
            rw.body[block].args.clear();
            rw.set_start(block);
            for data in Self::ieee_prologue() {
                rw.create(data, &[]);
            }
            let reserve = match (fragment, compute) {
                (true, _) => Interpolate::end(setup, regs.iter().map(|k| *k as usize + 1).max().unwrap_or(0)),
                (_, true) => XE3_COMPUTE_INLINE_GRF + 1,
                _ => regs.iter().map(|g| *g as u8 + 1).max().unwrap_or(0),
            };
            rw.update::<Kernel>(k, |k| k.reserve = Some(u32::from(reserve)))?;
        }
        Ok(())
    }

    const URB: Lsc = Lsc {
        op: LscOp::Store,
        surface: AddrSurface::Flat,
        addr_size: AddrSize::A32,
        data_size: DataSize::D32,
        cache: CacheStore::L1UC_L3UC,
        vect_size: VectSize::V4,
        transpose: false,
        cmask: 0,
    };

    fn create<'a>(cr: &mut Cr<'_, 'a, '_>, before: OpId, name: &str, operands: &[ValueId], attrs: Vec<(&str, A)>, types: &[Type<'a>]) -> Vec<ValueId> {
        let mut data = OpData::build(name).operands(operands);
        data.set("exec", A::from(XE3_SIMD).into());
        data = data.with_attrs(attrs);
        cr.rw.set_before(before);
        let op = cr.rw.create(data, types);
        cr.rw.body[op].results.to_vec()
    }

    pub fn eu(cr: &mut Cr<'_, '_, '_>, before: OpId, name: &str, operands: &[ValueId], attrs: Vec<(&str, A)>, elem: &str) -> ValueId {
        Self::create(cr, before, name, operands, attrs, &[Type::from(Grf(elem))])[0]
    }

    fn send(cr: &mut Cr<'_, '_, '_>, before: OpId, name: &str, payload: &[ValueId], attrs: Vec<(&str, A)>) {
        Self::create(cr, before, name, payload, attrs, &[]);
    }

    fn payload(cr: &mut Cr<'_, '_, '_>, before: OpId, grf: i64, elem: &str) -> ValueId {
        let (mut data, types) = OpData::of(&EuPayload::new(grf, Grf(elem).into())).expect("a typed op");
        data.set("exec", A::from(XE3_SIMD).into());
        cr.rw.set_before(before);
        let op = cr.rw.create(data, &types);
        cr.rw.body[op].results[0]
    }

    fn imm(cr: &mut Cr<'_, '_, '_>, before: OpId, bits: u32, elem: &str) -> ValueId {
        Self::imm64(cr, before, bits.into(), elem)
    }

    fn imm64(cr: &mut Cr<'_, '_, '_>, before: OpId, bits: u64, elem: &str) -> ValueId {
        let ty = match elem {
            "f32" => "f",
            "i32" => "d",
            "f64" => "df",
            "i64" => "q",
            _ => "ud",
        };
        Self::eu(cr, before, "xe3.eu.mov", &[], vec![("src0", A::str(format!("{bits:#x}:{ty}")))], elem)
    }

    fn wide(elem: &str, size: Option<u32>) -> (Option<u32>, u32) {
        match elem {
            "f64" | "i64" => (Some(8), 2),
            _ => (size, 1),
        }
    }

    fn vect_size(n: usize) -> Option<VectSize> {
        [VectSize::V1, VectSize::V2, VectSize::V3, VectSize::V4].get(n.wrapping_sub(1)).copied()
    }

    fn constant_bits(value: &Attribute<'_>, n: usize) -> Option<Vec<u64>> {
        let c = Const::try_from(value).ok()?;
        let bits = |s: Scalar| match s {
            Scalar::Float(f) => matches!(f.kind, FloatKind::F32 | FloatKind::F64).then_some(f.bits),
            Scalar::Int(i) if i.width == 1 => Some(if i.bits() != 0 { 0xffff_ffff } else { 0 }),
            Scalar::Int(i) => (i.width <= 64).then_some(i.bits() as u64),
            Scalar::Complex(..) | Scalar::ComplexFloat(..) | Scalar::Wide(_) => None,
        };
        (0..n).map(|i| bits(c.at(i))).collect()
    }

    fn positions(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<Vec<usize>> {
        cr.rw.body[op].get(name)?.dense_values().map(|v| v.into_iter().map(|i| i as usize).collect())
    }

    fn targets(body: &Body<'_>, op: OpId) -> Option<u8> {
        let mut at = body.parent_op(op);
        while let Some(p) = at {
            if body[p].name == Kernel::NAME {
                return body.head::<Kernel>(p).ok()?.targets.and_then(|n| u8::try_from(n).ok());
            }
            if let Some(Attribute::Type(Type::Function(fty))) = body[p].get("function_type") {
                return u8::try_from(fty.results.len()).ok();
            }
            at = body.parent_op(p);
        }
        None
    }

    pub fn stage_of(body: &Body<'_>, f: OpId) -> Option<Stage> {
        match &*body[f].name {
            "gpu.func" => body[f].gpu_kernel().then_some(Stage::Compute),
            "func.func" => match body[f].get(Self::STAGE)? {
                Attribute::Extended { ext, .. } => match ext.body.as_deref()? {
                    "<Vertex>" => Some(Stage::Vertex),
                    "<Fragment>" => Some(Stage::Fragment),
                    "<GLCompute>" => Some(Stage::Compute),
                    _ => None,
                },
                _ => None,
            },
            _ => None,
        }
    }

    fn interface_inputs(body: &Body<'_>, f: OpId, inputs: &[Type<'_>]) -> usize {
        let Some(Attribute::Array(attrs)) = body[f].get("arg_attrs") else { return inputs.len() };
        attrs.iter().position(|a| matches!(a, Attribute::Dict(d) if d.iter().any(|n| n.name == "spirv.interface_var_abi"))).unwrap_or(inputs.len())
    }

    fn stage(body: &Body<'_>, op: OpId) -> Option<Stage> {
        let mut at = body.parent_op(op);
        while let Some(p) = at {
            if body[p].name == Kernel::NAME {
                return body.head::<Kernel>(p).ok()?.stage;
            }
            if let Some(s) = Self::stage_of(body, p) {
                return Some(s);
            }
            at = body.parent_op(p);
        }
        None
    }

    fn lsc(lsc_op: LscOp, n: usize, binding: Option<u32>, size: Option<u32>) -> Option<(Lsc, u32)> {
        let size = size.unwrap_or(4);
        let data_size = match (size, n) {
            (8, _) => DataSize::D64,
            (4, _) => DataSize::D32,
            (2, 1) => DataSize::D16U32,
            (1, 1) => DataSize::D8U32,
            _ => return None,
        };
        let vect_size = Self::vect_size(n)?;
        let (surface, ex_desc) = match binding {
            None => (AddrSurface::Flat, 0),
            Some(k) => (AddrSurface::Bti, (k + u32::from(XE3_BUFFER_BTI)) << 24),
        };
        Some((Lsc { op: lsc_op, surface, addr_size: AddrSize::A32, data_size, cache: 0, vect_size, transpose: false, cmask: 0 }, ex_desc))
    }

    fn lanes(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], to: &str, attrs: &[(&str, A)]) -> bool {
        let Some(elem) = Self::result_elem(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::eu(cr, op, to, x, attrs.to_vec(), elem))
    }

    fn convert(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], to: &str, attrs: &[(&str, A)]) -> bool {
        let Some(re) = Self::result_elem(cr, op) else { return false };
        let Some(oe) = o.first().and_then(|v| v.first()).and_then(|v| Grf::try_from(&cr.rw.body[*v].ty).ok()).map(|g| g.0) else { return false };
        let wide = |e: &str| matches!(e, "f64" | "i64");
        let unsigned = attrs.iter().any(|(k, _)| *k == "unsigned");
        let narrow = |e: &str| match e {
            "f32" => "f",
            _ if unsigned => "ud",
            _ => "d",
        };
        match (wide(re), wide(oe)) {
            (true, false) => {
                let t = narrow(oe);
                Self::each(cr, op, o, |cr, x| {
                    let spread = Self::eu(cr, op, "xe3.eu.mov", x, vec![("as", A::str("ud")), ("dst_wide", A::str("ud"))], "i64");
                    let mut a = attrs.to_vec();
                    a.push(("wide0", A::str(t)));
                    Self::eu(cr, op, to, &[spread], a, re)
                })
            }
            (false, true) => {
                let t = narrow(re);
                Self::each(cr, op, o, |cr, x| {
                    let mut a = attrs.to_vec();
                    a.push(("dst_wide", A::str(t)));
                    let spread = Self::eu(cr, op, to, x, a, "i64");
                    Self::eu(cr, op, "xe3.eu.mov", &[spread], vec![("wide0", A::str("ud")), ("as", A::str("ud"))], re)
                })
            }
            _ => Self::lanes(cr, op, o, to, attrs),
        }
    }

    fn rounding(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>], to: &str, attrs: &[(&str, A)]) -> bool {
        if Self::result_elem(cr, op) != Some("f64") {
            return Self::lanes(cr, op, o, to, attrs);
        }
        let kind = match to {
            "xe3.eu.rndd" => Rounding::Down,
            "xe3.eu.rndz" => Rounding::Zero,
            _ => Rounding::Even,
        };
        Self::each(cr, op, o, |cr, x| Exact64::round(cr, op, x[0], kind))
    }

    fn result_elem(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<&'static str> {
        let r = *cr.rw.body[op].results.first()?;
        Xe3Types::of(&cr.rw.body[r].ty).map(|(_, e)| e)
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
}

#[patterns(converter)]
#[map("arith.addf" => "xe3.eu.add", via = Self::lanes(&[]))]
#[map("arith.subf" => "xe3.eu.add", via = Self::lanes(&[("neg1", A::Bool(true))]))]
#[map("arith.mulf" => "xe3.eu.mul", via = Self::lanes(&[]))]

#[map("arith.negf" => "xe3.eu.mov", via = Self::lanes(&[("neg0", A::Bool(true))]))]

#[map("math.absf" => "xe3.eu.mov", via = Self::lanes(&[("abs0", A::Bool(true))]))]
#[map("math.floor" => "xe3.eu.rndd", via = Self::rounding(&[]))]
#[map("math.trunc" => "xe3.eu.rndz", via = Self::rounding(&[]))]

#[map("math.roundeven" => "xe3.eu.rnde", via = Self::rounding(&[]))]
#[map("arith.minnumf" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("lt"))]))]
#[map("arith.maxnumf" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("ge"))]))]
#[map("arith.addi" => "xe3.eu.add", via = Self::lanes(&[]))]
#[map("arith.subi" => "xe3.eu.add", via = Self::lanes(&[("neg1", A::Bool(true))]))]
#[map("arith.shli" => "xe3.eu.shl", via = Self::lanes(&[("unsigned", A::Bool(true))]))]
#[map("arith.shrui" => "xe3.eu.shr", via = Self::lanes(&[("unsigned", A::Bool(true))]))]
#[map("arith.shrsi" => "xe3.eu.asr", via = Self::lanes(&[]))]
#[map("arith.andi" => "xe3.eu.and", via = Self::lanes(&[("as", A::str("ud"))]))]
#[map("arith.ori" => "xe3.eu.or", via = Self::lanes(&[("as", A::str("ud"))]))]
#[map("arith.xori" => "xe3.eu.xor", via = Self::lanes(&[("as", A::str("ud"))]))]
#[map("arith.minsi" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("lt"))]))]
#[map("arith.maxsi" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("ge"))]))]
#[map("arith.minui" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("lt")), ("unsigned", A::Bool(true))]))]
#[map("arith.maxui" => "xe3.eu.sel", via = Self::lanes(&[("cond", A::str("ge")), ("unsigned", A::Bool(true))]))]

#[map("arith.extsi" => "xe3.eu.mov", via = Self::lanes(&[("as", A::str("ud"))]))]
#[map("arith.sitofp" => "xe3.eu.mov", via = Self::convert(&[]))]
#[map("arith.uitofp" => "xe3.eu.mov", via = Self::convert(&[("unsigned", A::Bool(true))]))]
#[map("arith.fptosi" => "xe3.eu.mov", via = Self::convert(&[]))]
#[map("arith.fptoui" => "xe3.eu.mov", via = Self::convert(&[("unsigned", A::Bool(true))]))]

#[map("arith.extf" => "xe3.eu.mov", via = Self::convert(&[]))]
#[map("arith.truncf" => "xe3.eu.mov", via = Self::convert(&[]))]

#[map("arith.bitcast" => "xe3.eu.mov", via = Self::lanes(&[("as", A::str("ud"))]))]
impl GpuToXe3 {
    #[convert("func.func", "gpu.func")]
    fn func(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(stage) = Self::stage_of(cr.rw.body, op) else { return false };
        let Some(Attribute::Type(Type::Function(fty))) = cr.rw.body[op].get("function_type").cloned() else { return false };
        let Some(name) = cr.rw.body[op].get("sym_name").cloned() else { return false };
        let region = cr.rw.body[op].regions[0];
        let entry = cr.rw.body[region].blocks[0];
        let attributions: Vec<ValueId> = cr.rw.body[entry].args[fty.inputs.len()..].to_vec();
        let mut sig = SignatureConversion::new(fty.inputs.len() + attributions.len());
        let mut payload = Vec::new();
        let inputs = Self::interface_inputs(cr.rw.body, op, &fty.inputs);
        for (i, t) in fty.inputs.iter().enumerate() {
            if i >= inputs {
                sig.add_inputs(i, Vec::new());
                continue;
            }
            let Some((n, elem)) = Xe3Types::of(t) else { return false };
            if stage == Stage::Compute {
                if n != 1 || i >= XE3_COMPUTE_PARAMS {
                    return false;
                }
                payload.push(i as i64);
            } else {
                let base = if stage == Stage::Vertex { XE3_VS_ATTR_GRF as usize } else { 0 };
                payload.extend((0..n).map(|c| (base + 4 * i + c) as i64));
            }
            sig.add_inputs(i, vec![Type::from(Grf(elem)); n]);
        }
        let varyings = if stage == Stage::Vertex { fty.results.len().saturating_sub(1) } else { 0 };
        if varyings > XE3_MAX_VARYINGS || (stage == Stage::Fragment && inputs > XE3_MAX_VARYINGS) || (stage == Stage::Compute && !fty.results.is_empty()) {
            return false;
        }
        let flag = |attr: &str| matches!(cr.rw.body[op].get(attr), Some(Attribute::Bool(true) | Attribute::Unit));
        let omask = stage == Stage::Fragment && flag(Self::SAMPLE_MASK) && !fty.results.is_empty();
        let dual = stage == Stage::Fragment && flag(Self::DUAL_SOURCE) && fty.results.len() == 2;
        let count = |attr: &str| cr.rw.body[op].get(attr).map(Attrs::as_int).transpose().map(|n| n.unwrap_or(0) as u32);
        let (Ok(bindings), Ok(buffers), Ok(push)) = (count(Self::BINDINGS), count(Self::BUFFERS), count(Self::PUSH)) else { return false };
        let imask = 0u32;
        let threads = match cr.rw.body[op].get("known_block_size").and_then(|a| a.dense_values()).as_deref() {
            Some([x, ..]) => (*x as u32).div_ceil(u32::from(XE3_SIMD)),
            _ => 1,
        };
        let mut shared = 0u32;
        for (i, a) in attributions.iter().enumerate() {
            let Some(n) = Self::bytes(&cr.rw.body[*a].ty) else { return false };
            shared += n;
            sig.add_inputs(fty.inputs.len() + i, Vec::new());
        }
        if stage == Stage::Compute && (threads > 64 || shared > 64 * 1024) {
            return false;
        }
        let kernel = Kernel {
            simd: Some(u32::from(XE3_SIMD)),
            payload: Some(payload),
            inputs: Some(inputs as u32),
            varyings: Some(varyings as u32),
            targets: (stage == Stage::Fragment).then_some(fty.results.len() as u32 - u32::from(omask) - u32::from(dual)),
            omask: omask.then_some(true),
            imask: (stage == Stage::Fragment && imask > 0).then_some(true),
            bindings: Some(bindings),
            buffers: Some(buffers),
            push: Some(push),
            threads: (stage == Stage::Compute && threads > 1).then_some(threads),
            shared: (stage == Stage::Compute && shared > 0).then_some(shared),
            ..Kernel::new(name, Some(stage), None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, None, mlirformat::Region { blocks: Vec::new() })
        };
        let Ok(data) = OpData::head(&kernel) else { return false };
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

    fn grfs<'a>(t: &Type<'a>) -> Option<Vec<Type<'a>>> {
        Xe3Types::of(t).map(|(n, e)| vec![Type::from(Grf(e)); n])
    }

    fn structured(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let name = cr.rw.body[op].name.to_string();
        let types: Vec<Type<'_>> = cr.rw.body[op].results.iter().map(|r| cr.rw.body[*r].ty.clone()).collect();
        let Some(results) = types.iter().map(Self::grfs).collect::<Option<Vec<_>>>() else { return false };
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
                let Some(g) = Self::grfs(t) else { return false };
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

    #[convert("scf.for")]
    fn scf_for(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::structured(cr, op, o)
    }

    #[convert("scf.if")]
    fn scf_if(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::structured(cr, op, o)
    }

    #[convert("scf.while")]
    fn scf_while(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::structured(cr, op, o)
    }

    #[convert("scf.condition")]
    fn scf_condition(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
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

    pub fn structured_legal(body: &Body<'_>, op: OpId) -> bool {
        let grf = |v: &ValueId| Grf::try_from(&body[*v].ty).is_ok();
        let args = body[op].regions.iter().flat_map(|r| body[*r].blocks.iter().flat_map(|b| body[*b].args.iter()));
        body[op].operands.iter().all(grf) && body[op].results.iter().all(grf) && args.into_iter().all(grf)
    }

    #[convert("func.return", "gpu.return")]
    fn ret(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if Self::stage(cr.rw.body, op) == Some(Stage::Compute) {
            let r0 = Self::payload(cr, op, 0, "ui32");
            let attrs = vec![("sfid", A::str(<&str>::from(Sfid::Gateway))), ("desc", A::from(SendInfo::lengths(0, 1, 0))), ("src0_len", A::from(1u8)), ("eot", A::Bool(true))];
            Self::send(cr, op, "xe3.eu.send", &[r0], attrs);
            cr.erase(op);
            return true;
        }
        let Some(values) = o.first() else { return false };
        let Ok(values): Result<[ValueId; 4], _> = values.clone().try_into() else { return false };
        match Self::stage(cr.rw.body, op) {
            Some(Stage::Fragment) => {
                let targets = Self::targets(cr.rw.body, op).map_or(o.len(), usize::from);
                if targets == 1 && o.len() == 2 && o[1].len() == 4 && o[0].len() == 4 {
                    let write = Render { bti: 0, msg_ctrl: 2 | 0x10, msg_type: 12, coarse_write: false };
                    let attrs = vec![
                        ("sfid", A::str(<&str>::from(Sfid::Render))),
                        ("desc", A::from(SendInfo::lengths(write.desc(), 8, 0))),
                        ("src0_len", A::from(8u8)),
                        ("eot", A::Bool(true)),
                    ];
                    Self::send(cr, op, "xe3.eu.sendc", &o.concat(), attrs);
                    cr.erase(op);
                    return true;
                }
                let (o, mask) = match o.len() - targets {
                    0 => (o, None),
                    1 => match &o[targets][..] {
                        [m] => (&o[..targets], Some(*m)),
                        _ => return false,
                    },
                    _ => return false,
                };
                if o.len() > XE3_MAX_TARGETS || o.iter().any(|v| v.len() != 4) {
                    return false;
                }
                let mask = mask.map(|m| Self::eu(cr, op, "xe3.eu.mov", &[m], vec![("dst_as", A::str("uw")), ("low0", A::Bool(true))], "i32"));
                let n = 4 + u32::from(mask.is_some());
                for (k, values) in o.iter().enumerate() {
                    let last = k + 1 == o.len();
                    let write = Render { bti: k as u8, msg_ctrl: if last { 0x10 } else { 0 }, msg_type: 12, coarse_write: false };
                    let mut attrs = vec![
                        ("sfid", A::str(<&str>::from(Sfid::Render))),
                        ("desc", A::from(SendInfo::lengths(write.desc(), n, 0))),
                        ("ex_desc", A::from((k as u32) << 21 | u32::from(mask.is_some()) << 12)),
                        ("src0_len", A::from(n as u8)),
                    ];
                    if last {
                        attrs.push(("eot", A::Bool(true)));
                    }
                    let payload: Vec<ValueId> = mask.into_iter().chain(values.iter().copied()).collect();
                    Self::send(cr, op, "xe3.eu.sendc", &payload, attrs);
                }
            }
            Some(Stage::Vertex) => {
                let handle = Self::payload(cr, op, 1, "ui32");
                for (k, varying) in o[1..].iter().enumerate() {
                    let Some(vect_size) = Self::vect_size(varying.len()) else { return false };
                    let store = Lsc { vect_size, ..Self::URB };
                    let mut payload = vec![handle];
                    payload.extend(varying);
                    let attrs = vec![
                        ("sfid", A::str(<&str>::from(Sfid::Urb))),
                        ("desc", A::from(SendInfo::lengths(store.desc(), 1, 0))),
                        ("ex_desc", A::from(((32 + 16 * k) as u32) << 12)),
                        ("src0_len", A::from(1u8)),
                        ("src1_len", A::from(varying.len() as u8)),
                    ];
                    Self::send(cr, op, "xe3.eu.send", &payload, attrs);
                }
                let mut payload = vec![handle, Self::imm(cr, op, 0x3c00_3c00, "ui32")];
                payload.extend((0..3).map(|_| Self::imm(cr, op, 0, "ui32")));
                payload.extend(values);
                let urb = Lsc { vect_size: VectSize::V8, ..Self::URB };
                let attrs = vec![
                    ("sfid", A::str(<&str>::from(Sfid::Urb))),
                    ("desc", A::from(SendInfo::lengths(urb.desc(), 1, 0))),
                    ("src0_len", A::from(1u8)),
                    ("src1_len", A::from(8u8)),
                    ("eot", A::Bool(true)),
                ];
                Self::send(cr, op, "xe3.eu.send", &payload, attrs);
            }
            _ => return false,
        }
        cr.erase(op);
        true
    }

    #[convert("spirv.Load")]
    fn resource_load(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let r = cr.rw.body[op].results[0];
        let int = |cr: &Cr<'_, '_, '_>, n: &str| cr.rw.body[op].get(n).and_then(|a| Attrs::as_int(a).ok());
        let (push, binding, offset) = (int(cr, Self::PUSH_AT), int(cr, Self::BINDING), int(cr, Self::OFFSET));
        let Some((n, elem)) = Xe3Types::of(&cr.rw.body[r].ty) else {
            cr.replace(op, vec![Vec::new()]);
            return true;
        };
        let (offset, bti) = match (push, binding, offset) {
            (Some(p), _, _) => (p, XE3_PUSH_BTI),
            (None, Some(b), Some(o)) => (o, XE3_BUFFER_BTI + b as u8),
            _ => return false,
        };
        let Some(vect_size) = Self::vect_size(n).filter(|_| offset % 4 == 0) else { return false };
        let addr = Self::imm(cr, op, offset as u32, "i32");
        let lsc = Lsc { op: LscOp::Load, surface: AddrSurface::Bti, addr_size: AddrSize::A32, data_size: DataSize::D32, cache: 0, vect_size, transpose: false, cmask: 0 };
        let attrs = vec![
            ("sfid", A::str(<&str>::from(Sfid::Ugm))),
            ("desc", A::from(SendInfo::lengths(lsc.desc(), 1, n as u32))),
            ("ex_desc", A::from(u32::from(bti) << 24)),
            ("src0_len", A::from(1u8)),
        ];
        let values = Self::create(cr, op, "xe3.eu.send", &[addr], attrs, &vec![Type::from(Grf(elem)); n]);
        cr.replace(op, vec![values]);
        true
    }

    #[convert("spirv.AccessChain", "spirv.SampledImage")]
    fn handle(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        cr.replace(op, vec![Vec::new()]);
        true
    }

    fn binding(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<u8> {
        cr.rw.body[op].get(Self::BINDING).and_then(|a| Attrs::as_int(a).ok()).and_then(|b| u8::try_from(b).ok())
    }

    #[convert("spirv.ImageSampleImplicitLod")]
    fn sample(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(uv) = o.get(1) else { return false };
        if !matches!(uv.len(), 2..=4) {
            return false;
        }
        let (Some(b), Some(targets)) = (Self::binding(cr, op), Self::targets(cr.rw.body, op)) else { return false };
        let msg = Sampler { msg_type: 0, simd_mode: 1, bti: targets + b, sampler: b, return_hp: false };
        let n = uv.len() as u32;
        let attrs = vec![("sfid", A::str(<&str>::from(Sfid::Sampler))), ("desc", A::from(SendInfo::lengths(msg.desc(), n, 4))), ("src0_len", A::from(n as u8))];
        let values = Self::create(cr, op, "xe3.eu.send", uv, attrs, &vec![Type::from(Grf("f32")); 4]);
        cr.replace(op, vec![values]);
        true
    }

    #[convert("spirv.ImageFetch")]
    fn load_sample(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let (Some(xy), Some(s)) = (o.get(1), o.get(2)) else { return false };
        let ([x, y], [s]) = (&xy[..], &s[..]) else { return false };
        let (Some(b), Some(targets)) = (Self::binding(cr, op), Self::targets(cr.rw.body, op)) else { return false };
        let zero = Self::imm(cr, op, 0, "i32");
        let mut words = |v: ValueId| Self::eu(cr, op, "xe3.eu.mov", &[v], vec![("dst_as", A::str("uw")), ("low0", A::Bool(true))], "i32");
        let (s, zero, x, y) = (words(*s), words(zero), words(*x), words(*y));
        let params = [s, zero, zero, zero, zero, x, y];
        let msg = Sampler { msg_type: 28, simd_mode: 5, bti: targets + b, sampler: b, return_hp: false };
        let attrs = vec![("sfid", A::str(<&str>::from(Sfid::Sampler))), ("desc", A::from(SendInfo::lengths(msg.desc(), params.len() as u32, 4))), ("src0_len", A::from(params.len() as u8))];
        let values = Self::create(cr, op, "xe3.eu.send", &params, attrs, &vec![Type::from(Grf("f32")); 4]);
        cr.replace(op, vec![values]);
        true
    }

    #[convert("arith.constant")]
    fn constant(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let (Some((n, elem)), Some(value)) = (Xe3Types::of(&ty), cr.rw.body[op].get("value").cloned()) else { return false };
        let Some(bits) = Self::constant_bits(&value, n) else { return false };
        let values = bits.into_iter().map(|b| Self::imm64(cr, op, b, elem)).collect();
        cr.replace(op, vec![values]);
        true
    }

    #[convert("math.fma")]
    fn fma(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(elem) = Self::result_elem(cr, op) else { return false };
        Self::each(cr, op, o, |cr, x| Self::eu(cr, op, "xe3.eu.mad", &[x[2], x[0], x[1]], vec![], elem))
    }

    #[convert("arith.cmpf")]
    fn cmp(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(p) = cr.rw.body[op].get("predicate").map(Attrs::as_int).and_then(Result::ok) else { return false };
        let cond = match p {
            1 => "z",
            2 => "gt",
            3 => "ge",
            4 => "lt",
            5 => "le",
            13 => "nz",
            _ => return false,
        };
        let f64s = o.first().and_then(|v| v.first()).and_then(|v| Grf::try_from(&cr.rw.body[*v].ty).ok()).is_some_and(|g| g.0 == "f64");
        if !f64s {
            return Self::lanes(cr, op, o, "xe3.eu.cmp", &[("cond", A::str(cond))]);
        }
        Self::each(cr, op, o, |cr, x| {
            let wide = Self::eu(cr, op, "xe3.eu.cmp", x, vec![("cond", A::str(cond))], "f64");
            Self::eu(cr, op, "xe3.eu.mov", &[wide], vec![("wide0", A::str("ud")), ("as", A::str("ud"))], "f32")
        })
    }

    #[convert("arith.select")]
    fn select(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [c, x, y] = o else { return false };
        let Some(elem) = Self::result_elem(cr, op) else { return false };
        let c = if c.len() == 1 { vec![c[0]; x.len()] } else { c.clone() };
        Self::each(cr, op, &[c, x.clone(), y.clone()], |cr, v| {
            if elem == "f32" {
                return Self::eu(cr, op, "xe3.eu.csel", &[v[2], v[1], v[0]], vec![("cond", A::str("z"))], "f32");
            }
            if matches!(elem, "f64" | "i64") {
                Self::create(cr, op, "xe3.eu.cmp", &[v[0]], vec![("cond", A::str("nz")), ("dst", A::str("null<1;1,0>:d")), ("src1", A::str("0x0:d")), ("flag", A::str("f0.0")), ("as", A::str("ud"))], &[]);
                Self::create(cr, op, "xe3.eu.sync", &[], vec![("exec", A::from(1u8)), ("fn", A::str("nop")), ("swsb", A::str("A@1"))], &[]);
                return Self::eu(cr, op, "xe3.eu.sel", &[v[1], v[2]], vec![("pred", A::str("normal")), ("flag", A::str("f0.0"))], elem);
            }
            let bits = || vec![("as", A::str("ud"))];
            let t = Self::eu(cr, op, "xe3.eu.and", &[v[1], v[0]], bits(), "i32");
            let not = Self::eu(cr, op, "xe3.eu.not", &[v[0]], bits(), "i32");
            let f = Self::eu(cr, op, "xe3.eu.and", &[v[2], not], bits(), "i32");
            Self::eu(cr, op, "xe3.eu.or", &[t, f], bits(), "i32")
        })
    }

    #[convert("arith.muli")]
    fn muli(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let lo = Self::eu(cr, op, "xe3.eu.mul", &[x[0], x[1]], vec![("half1", A::str("lo"))], "i32");
            let hi = Self::eu(cr, op, "xe3.eu.mul", &[x[0], x[1]], vec![("half1", A::str("hi"))], "i32");
            let sixteen = Self::imm(cr, op, 16, "i32");
            let up = Self::eu(cr, op, "xe3.eu.shl", &[hi, sixteen], vec![("unsigned", A::Bool(true))], "i32");
            Self::eu(cr, op, "xe3.eu.add", &[lo, up], vec![], "i32")
        })
    }

    #[convert("arith.cmpi")]
    fn cmpi(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(p) = cr.rw.body[op].get("predicate").map(Attrs::as_int).and_then(Result::ok) else { return false };
        let Some(cond) = ["z", "nz", "lt", "le", "gt", "ge", "lt", "le", "gt", "ge"].get(p as usize) else { return false };
        let mut attrs = vec![("cond", A::str(*cond)), ("dst_as", A::str(if p >= 6 { "ud" } else { "d" }))];
        if p >= 6 {
            attrs.push(("unsigned", A::Bool(true)));
        }
        let masks = o.first().and_then(|v| v.first()).and_then(|v| Grf::try_from(&cr.rw.body[*v].ty).ok()).is_some_and(|g| g.0 == "f32");
        if masks {
            attrs.push(("as", A::str("ud")));
        }
        Self::lanes(cr, op, o, "xe3.eu.cmp", &attrs)
    }

    #[convert("arith.extui")]
    fn extui(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        Self::each(cr, op, o, |cr, x| {
            let one = Self::imm(cr, op, 1, "i32");
            Self::eu(cr, op, "xe3.eu.and", &[x[0], one], vec![("as", A::str("ud"))], "i32")
        })
    }

    #[convert("gpu.block_id")]
    fn block_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let Some(d) = cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) else { return false };
        let dword = [1, 6, 7][d as usize];
        let v = Self::eu(cr, op, "xe3.eu.mov", &[], vec![("src0", A::str(format!("r0.{}<0;1,0>:ud", 4 * dword)))], "i32");
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("gpu.thread_id")]
    fn thread_id(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        if cr.rw.body[op].get("dimension").and_then(|a| Dimension::try_from(a).ok()) != Some(Dimension::X) {
            return false;
        }
        let v = Self::eu(cr, op, "xe3.eu.mov", &[], vec![("src0", A::str("r1<1;1,0>:uw"))], "i32");
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("arith.index_cast", "arith.index_castui", "llvm.inttoptr")]
    fn same(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        cr.replace(op, vec![o[0].clone()]);
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

    fn size(t: &Type<'_>) -> Option<u32> {
        let e = match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => &*s.elem,
            t => t,
        };
        match e {
            Type::Integer { width: 8, .. } => Some(1),
            Type::Integer { width: 16, .. } => Some(2),
            _ => None,
        }
    }

    #[convert("llvm.load")]
    fn load(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [addr] = o else { return false };
        let r = cr.rw.body[op].results[0];
        let ty = cr.rw.body[r].ty.clone();
        let Some((n, elem)) = Xe3Types::of(&ty) else { return false };
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[0]].ty) else { return false };
        let (size, regs) = Self::wide(elem, Self::size(&ty));
        let Some((lsc, ex_desc)) = Self::lsc(LscOp::Load, n, None, size) else { return false };
        let mut attrs = vec![("sfid", A::str(<&str>::from(Sfid::of(Some(shared))))), ("desc", A::from(SendInfo::lengths(lsc.desc(), 1, n as u32 * regs))), ("src0_len", A::from(1u8))];
        if ex_desc != 0 {
            attrs.push(("ex_desc", A::from(ex_desc)));
        }
        let values = Self::create(cr, op, "xe3.eu.send", addr, attrs, &vec![Type::from(Grf(elem)); n]);
        cr.replace(op, vec![values]);
        true
    }

    #[convert("llvm.store")]
    fn store(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let [value, addr] = o else { return false };
        let ty = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone();
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[1]].ty) else { return false };
        let elem = value.first().and_then(|v| Grf::try_from(&cr.rw.body[*v].ty).ok()).map_or("i32", |g| g.0);
        let (size, regs) = Self::wide(elem, Self::size(&ty));
        let Some((lsc, ex_desc)) = Self::lsc(LscOp::Store, value.len(), None, size) else { return false };
        let mut payload = addr.clone();
        payload.extend(value);
        let mut attrs = vec![("sfid", A::str(<&str>::from(Sfid::of(Some(shared))))), ("desc", A::from(SendInfo::lengths(lsc.desc(), 1, 0))), ("src0_len", A::from(1u8)), ("src1_len", A::from(value.len() as u8 * regs as u8))];
        if ex_desc != 0 {
            attrs.push(("ex_desc", A::from(ex_desc)));
        }
        Self::send(cr, op, "xe3.eu.send", &payload, attrs);
        cr.erase(op);
        true
    }

    #[convert("llvm.atomicrmw")]
    fn atomic(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        use mlirformat::llvm::AtomicBinOp as B;
        let [addr, value] = o else { return false };
        let Some(shared) = Self::shared(&cr.rw.body[cr.rw.body[op].operands[0]].ty) else { return false };
        let Ok(rmw) = cr.rw.body.head::<mlirformat::llvm::AtomicRMWOp>(op) else { return false };
        let lsc_op = match rmw.bin_op {
            B::Add => LscOp::AtomicAdd,
            B::Sub => LscOp::AtomicSub,
            B::Min => LscOp::AtomicMin,
            B::Max => LscOp::AtomicMax,
            B::Umin => LscOp::AtomicUmin,
            B::Umax => LscOp::AtomicUmax,
            B::And => LscOp::AtomicAnd,
            B::Or => LscOp::AtomicOr,
            B::Xor => LscOp::AtomicXor,
            B::Xchg => LscOp::AtomicStore,
            _ => return false,
        };
        let Some((lsc, _)) = Self::lsc(lsc_op, 1, None, None) else { return false };
        let mut payload = addr.clone();
        payload.extend(value);
        let attrs = vec![("sfid", A::str(<&str>::from(Sfid::of(Some(shared))))), ("desc", A::from(SendInfo::lengths(lsc.desc(), 1, 1))), ("src0_len", A::from(1u8)), ("src1_len", A::from(1u8))];
        let old = Self::create(cr, op, "xe3.eu.send", &payload, attrs, &[Type::from(Grf("i32"))]);
        cr.replace(op, vec![old]);
        true
    }

    #[convert("gpu.barrier")]
    fn barrier(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let all = || vec![("w", A::Bool(true)), ("as", A::str("ud"))];
        Self::create(cr, op, "xe3.eu.sync", &[], vec![("exec", A::from(1u8)), ("fn", A::str("allwr"))], &[]);
        let r0 = Self::payload(cr, op, 0, "i32");
        let fence_attrs = vec![("exec", A::from(1u8)), ("w", A::Bool(true)), ("sfid", A::str(<&str>::from(Sfid::Slm))), ("desc", A::from(SendInfo::lengths(LSC_SLM_FENCE, 1, 1))), ("src0_len", A::from(1u8))];
        let fence = Self::create(cr, op, "xe3.eu.send", &[r0], fence_attrs, &[Type::from(Grf("i32"))])[0];
        let with = |extra: (&'static str, A)| {
            let mut a = all();
            a.push(extra);
            a
        };
        let r02 = Self::eu(cr, op, "xe3.eu.mov", &[], with(("src0", A::str("r0.8<0;1,0>:ud"))), "i32");
        let top = Self::imm(cr, op, 0xff00_0000, "i32");
        let id = Self::eu(cr, op, "xe3.eu.and", &[r02, top], all(), "i32");
        let eight = Self::imm(cr, op, 8, "i32");
        let below = Self::eu(cr, op, "xe3.eu.shr", &[id, eight], all(), "i32");
        let both = Self::eu(cr, op, "xe3.eu.or", &[id, below], all(), "i32");
        let active = Self::imm(cr, op, 0x100, "i32");
        let dword2 = Self::eu(cr, op, "xe3.eu.or", &[both, active], all(), "i32");
        let local = Self::eu(cr, op, "xe3.eu.mov", &[], vec![("w", A::Bool(true)), ("src0", A::str("r1<1;1,0>:uw"))], "i32");
        let fifteen = Self::imm(cr, op, 15, "i32");
        let channel = Self::eu(cr, op, "xe3.eu.and", &[local, fifteen], all(), "i32");
        let two = Self::imm(cr, op, 2, "i32");
        let is2 = Self::eu(cr, op, "xe3.eu.cmp", &[channel, two], vec![("w", A::Bool(true)), ("cond", A::str("z")), ("dst_as", A::str("d"))], "f32");
        let only2 = Self::eu(cr, op, "xe3.eu.and", &[dword2, is2], all(), "i32");
        let zero = Self::imm(cr, op, 0, "i32");
        let none = Self::eu(cr, op, "xe3.eu.and", &[fence, zero], all(), "i32");
        let payload = Self::eu(cr, op, "xe3.eu.or", &[only2, none], all(), "i32");
        let desc = SendInfo::lengths(GATEWAY_BARRIER, 1, 0);
        Self::send(cr, op, "xe3.eu.send", &[payload], vec![("sfid", A::str(<&str>::from(Sfid::Gateway))), ("desc", A::from(desc)), ("src0_len", A::from(1u8)), ("w", A::Bool(true))]);
        Self::create(cr, op, "xe3.eu.sync", &[], vec![("exec", A::from(1u8)), ("fn", A::str("bar"))], &[]);
        cr.erase(op);
        true
    }

    #[convert("math.ceil")]
    fn ceil(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some(elem) = Self::result_elem(cr, op) else { return false };
        if elem == "f64" {
            return Self::each(cr, op, o, |cr, x| Exact64::round(cr, op, x[0], Rounding::Up));
        }
        Self::each(cr, op, o, |cr, x| {
            let down = Self::eu(cr, op, "xe3.eu.rndd", x, vec![("neg0", A::Bool(true))], elem);
            Self::eu(cr, op, "xe3.eu.mov", &[down], vec![("neg0", A::Bool(true))], elem)
        })
    }

    #[convert("arith.divf")]
    fn div(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if Self::result_elem(cr, op) == Some("f64") {
            return Self::each(cr, op, o, |cr, x| Exact64::div(cr, op, x[0], x[1]));
        }
        Self::each(cr, op, o, |cr, x| Exact::div(cr, op, x[0], x[1]))
    }

    #[convert("math.sqrt")]
    fn sqrt(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        if Self::result_elem(cr, op) == Some("f64") {
            return Self::each(cr, op, o, |cr, x| Exact64::sqrt(cr, op, x[0]));
        }
        Self::each(cr, op, o, |cr, x| Exact::sqrt(cr, op, x[0]))
    }

    #[convert("vector.extract")]
    fn extract(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some([at]) = Self::positions(cr, op, "static_position").and_then(|p| <[usize; 1]>::try_from(p).ok()) else { return false };
        let Some(v) = o[0].get(at).copied() else { return false };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[convert("vector.insert")]
    fn insert(cr: &mut Cr<'_, '_, '_>, op: OpId, o: &[Vec<ValueId>]) -> bool {
        let Some([at]) = Self::positions(cr, op, "static_position").and_then(|p| <[usize; 1]>::try_from(p).ok()) else { return false };
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
        let (Some((n, _)), [v]) = (Xe3Types::of(&ty), &o[0][..]) else { return false };
        cr.replace(op, vec![vec![*v; n]]);
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

struct Exact;

impl Exact {
    fn op(cr: &mut Cr<'_, '_, '_>, at: OpId, name: &str, x: &[ValueId], attrs: Vec<(&str, A)>) -> ValueId {
        GpuToXe3::eu(cr, at, name, x, attrs, "f32")
    }

    fn mad(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId, c: ValueId, neg: bool) -> ValueId {
        Self::op(cr, at, "xe3.eu.mad", &[a, b, c], if neg { vec![("neg1", A::Bool(true))] } else { vec![] })
    }

    fn math(cr: &mut Cr<'_, '_, '_>, at: OpId, f: &str, x: ValueId) -> ValueId {
        Self::op(cr, at, "xe3.eu.math", &[x], vec![("fn", A::str(f))])
    }

    fn finite_or(cr: &mut Cr<'_, '_, '_>, at: OpId, refined: ValueId, fallback: ValueId) -> ValueId {
        let d = Self::op(cr, at, "xe3.eu.add", &[refined, refined], vec![("neg1", A::Bool(true))]);
        Self::op(cr, at, "xe3.eu.csel", &[refined, fallback, d], vec![("cond", A::str("z"))])
    }

    fn imm(cr: &mut Cr<'_, '_, '_>, at: OpId, v: f32) -> ValueId {
        GpuToXe3::imm(cr, at, v.to_bits(), "f32")
    }

    fn below(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId, bound: f32, then: ValueId, other: ValueId) -> ValueId {
        let minus = Self::imm(cr, at, -bound);
        let d = Self::op(cr, at, "xe3.eu.add", &[x, minus], vec![("abs0", A::Bool(true))]);
        Self::op(cr, at, "xe3.eu.csel", &[then, other, d], vec![("cond", A::str("lt"))])
    }

    fn div(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        let one = Self::imm(cr, at, 1.0);
        let up = Self::imm(cr, at, pow2f(64));
        let small = Self::below(cr, at, a, pow2f(-100), up, one);
        let s = Self::below(cr, at, b, pow2f(-100), up, small);
        let a = Self::op(cr, at, "xe3.eu.mul", &[a, s], vec![]);
        let b = Self::op(cr, at, "xe3.eu.mul", &[b, s], vec![]);
        let y0 = Self::math(cr, at, "inv", b);
        let e = Self::mad(cr, at, one, b, y0, true);
        let y1 = Self::mad(cr, at, y0, e, y0, false);
        let q0 = Self::op(cr, at, "xe3.eu.mul", &[a, y1], vec![]);
        let r = Self::mad(cr, at, a, b, q0, true);
        let q1 = Self::mad(cr, at, q0, r, y1, false);
        let rough = Self::op(cr, at, "xe3.eu.mul", &[a, y0], vec![]);
        let q = Self::finite_or(cr, at, q1, rough);
        Self::op(cr, at, "xe3.eu.csel", &[rough, q, a], vec![("cond", A::str("z"))])
    }

    fn sqrt(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId) -> ValueId {
        let one = Self::imm(cr, at, 1.0);
        let (up, down) = (Self::imm(cr, at, pow2f(64)), Self::imm(cr, at, pow2f(-32)));
        let s = Self::below(cr, at, a, pow2f(-100), up, one);
        let back = Self::below(cr, at, a, pow2f(-100), down, one);
        let a = Self::op(cr, at, "xe3.eu.mul", &[a, s], vec![]);
        let half = Self::imm(cr, at, 0.5);
        let y0 = Self::math(cr, at, "rsq", a);
        let g0 = Self::op(cr, at, "xe3.eu.mul", &[a, y0], vec![]);
        let h0 = Self::op(cr, at, "xe3.eu.mul", &[half, y0], vec![]);
        let d = Self::mad(cr, at, half, g0, h0, true);
        let g1 = Self::mad(cr, at, g0, g0, d, false);
        let h1 = Self::mad(cr, at, h0, h0, d, false);
        let r = Self::mad(cr, at, a, g1, g1, true);
        let g2 = Self::mad(cr, at, g1, r, h1, false);
        let rough = Self::math(cr, at, "sqrt", a);
        let root = Self::finite_or(cr, at, g2, rough);
        Self::op(cr, at, "xe3.eu.mul", &[root, back], vec![])
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Rounding {
    Down,
    Up,
    Zero,
    Even,
}

struct Exact64;

impl Exact64 {
    fn f(cr: &mut Cr<'_, '_, '_>, at: OpId, name: &str, x: &[ValueId], attrs: Vec<(&str, A)>) -> ValueId {
        GpuToXe3::eu(cr, at, name, x, attrs, "f64")
    }

    fn i(cr: &mut Cr<'_, '_, '_>, at: OpId, name: &str, x: &[ValueId], attrs: Vec<(&str, A)>) -> ValueId {
        GpuToXe3::eu(cr, at, name, x, attrs, "i32")
    }

    fn fimm(cr: &mut Cr<'_, '_, '_>, at: OpId, v: f64) -> ValueId {
        GpuToXe3::imm64(cr, at, v.to_bits(), "f64")
    }

    fn iimm(cr: &mut Cr<'_, '_, '_>, at: OpId, v: u32) -> ValueId {
        GpuToXe3::imm(cr, at, v, "i32")
    }

    fn mad(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId, c: ValueId, neg: bool) -> ValueId {
        Self::f(cr, at, "xe3.eu.mad", &[a, b, c], if neg { vec![("neg1", A::Bool(true))] } else { vec![] })
    }

    fn mul(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        Self::f(cr, at, "xe3.eu.mul", &[a, b], vec![])
    }

    fn hi(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> ValueId {
        Self::i(cr, at, "xe3.eu.mov", &[x], vec![("hi0", A::Bool(true)), ("as", A::str("ud"))])
    }

    fn lo(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> ValueId {
        Self::i(cr, at, "xe3.eu.mov", &[x], vec![("wide0", A::str("ud")), ("as", A::str("ud"))])
    }

    fn pack(cr: &mut Cr<'_, '_, '_>, at: OpId, lo: ValueId, hi: ValueId) -> ValueId {
        GpuToXe3::create(cr, at, crate::PACK64, &[lo, hi], vec![], &[Type::from(Grf("f64"))])[0]
    }

    fn pow2(cr: &mut Cr<'_, '_, '_>, at: OpId, e: ValueId) -> ValueId {
        let twenty = Self::iimm(cr, at, 20);
        let hi = Self::i(cr, at, "xe3.eu.shl", &[e, twenty], vec![("unsigned", A::Bool(true))]);
        let zero = Self::iimm(cr, at, 0);
        Self::pack(cr, at, zero, hi)
    }

    fn and(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        Self::i(cr, at, "xe3.eu.and", &[a, b], vec![("as", A::str("ud"))])
    }

    fn andn(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        let not = Self::i(cr, at, "xe3.eu.not", &[b], vec![("as", A::str("ud"))]);
        Self::and(cr, at, a, not)
    }

    fn or(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        Self::i(cr, at, "xe3.eu.or", &[a, b], vec![("as", A::str("ud"))])
    }

    fn add(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId, neg: bool) -> ValueId {
        Self::i(cr, at, "xe3.eu.add", &[a, b], if neg { vec![("neg1", A::Bool(true))] } else { vec![] })
    }

    fn exponent(cr: &mut Cr<'_, '_, '_>, at: OpId, hi: ValueId) -> ValueId {
        let twenty = Self::iimm(cr, at, 20);
        let e = Self::i(cr, at, "xe3.eu.shr", &[hi, twenty], vec![("unsigned", A::Bool(true))]);
        let m = Self::iimm(cr, at, 0x7ff);
        Self::and(cr, at, e, m)
    }

    fn cmpi(cr: &mut Cr<'_, '_, '_>, at: OpId, cond: &str, a: ValueId, b: ValueId) -> ValueId {
        GpuToXe3::eu(cr, at, "xe3.eu.cmp", &[a, b], vec![("cond", A::str(cond)), ("dst_as", A::str("d"))], "f32")
    }

    fn cmpf(cr: &mut Cr<'_, '_, '_>, at: OpId, cond: &str, a: ValueId, b: ValueId) -> ValueId {
        let wide = Self::f(cr, at, "xe3.eu.cmp", &[a, b], vec![("cond", A::str(cond))]);
        GpuToXe3::eu(cr, at, "xe3.eu.mov", &[wide], vec![("wide0", A::str("ud")), ("as", A::str("ud"))], "f32")
    }

    fn sel(cr: &mut Cr<'_, '_, '_>, at: OpId, m: ValueId, x: ValueId, y: ValueId) -> ValueId {
        GpuToXe3::create(cr, at, "xe3.eu.cmp", &[m], vec![("cond", A::str("nz")), ("dst", A::str("null<1;1,0>:d")), ("src1", A::str("0x0:d")), ("flag", A::str("f0.0")), ("as", A::str("ud"))], &[]);
        GpuToXe3::create(cr, at, "xe3.eu.sync", &[], vec![("exec", A::from(1u8)), ("fn", A::str("nop")), ("swsb", A::str("A@1"))], &[]);
        Self::f(cr, at, "xe3.eu.sel", &[x, y], vec![("pred", A::str("normal")), ("flag", A::str("f0.0"))])
    }

    fn to_f32(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> ValueId {
        let spread = GpuToXe3::eu(cr, at, "xe3.eu.mov", &[x], vec![("dst_wide", A::str("f"))], "i64");
        GpuToXe3::eu(cr, at, "xe3.eu.mov", &[spread], vec![("wide0", A::str("ud")), ("as", A::str("ud"))], "f32")
    }

    fn to_f64(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> ValueId {
        let spread = GpuToXe3::eu(cr, at, "xe3.eu.mov", &[x], vec![("as", A::str("ud")), ("dst_wide", A::str("ud"))], "i64");
        Self::f(cr, at, "xe3.eu.mov", &[spread], vec![("wide0", A::str("f"))])
    }

    fn split(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> (ValueId, ValueId) {
        let e0 = {
            let h = Self::hi(cr, at, x);
            Self::exponent(cr, at, h)
        };
        let zero = Self::iimm(cr, at, 0);
        let sub = Self::cmpi(cr, at, "z", e0, zero);
        let up = Self::fimm(cr, at, pow2d(54));
        let scaled = Self::mul(cr, at, x, up);
        let x2 = Self::sel(cr, at, sub, scaled, x);
        let h = Self::hi(cr, at, x2);
        let e = Self::exponent(cr, at, h);
        let bias = Self::iimm(cr, at, 1023);
        let e = Self::add(cr, at, e, bias, true);
        let fifty4 = Self::iimm(cr, at, 54);
        let adj = Self::and(cr, at, fifty4, sub);
        let e = Self::add(cr, at, e, adj, true);
        let keep = Self::iimm(cr, at, 0x800f_ffff);
        let one = Self::iimm(cr, at, 0x3ff0_0000);
        let m = Self::and(cr, at, h, keep);
        let m = Self::or(cr, at, m, one);
        let l = Self::lo(cr, at, x2);
        (Self::pack(cr, at, l, m), e)
    }

    fn pow2k(cr: &mut Cr<'_, '_, '_>, at: OpId, k: ValueId) -> ValueId {
        let bias = Self::iimm(cr, at, 1023);
        let e = Self::add(cr, at, k, bias, false);
        Self::pow2(cr, at, e)
    }

    fn div(cr: &mut Cr<'_, '_, '_>, at: OpId, a: ValueId, b: ValueId) -> ValueId {
        let inf = Self::fimm(cr, at, f64::INFINITY);
        let zero = Self::fimm(cr, at, 0.0);
        let general = {
            let aa = Self::f(cr, at, "xe3.eu.mov", &[a], vec![("abs0", A::Bool(true))]);
            let ab = Self::f(cr, at, "xe3.eu.mov", &[b], vec![("abs0", A::Bool(true))]);
            let fa = Self::cmpf(cr, at, "lt", aa, inf);
            let fb = Self::cmpf(cr, at, "lt", ab, inf);
            let na = Self::cmpf(cr, at, "nz", a, zero);
            let nb = Self::cmpf(cr, at, "nz", b, zero);
            let m = Self::and(cr, at, fa, fb);
            let m = Self::and(cr, at, m, na);
            Self::and(cr, at, m, nb)
        };
        let special = {
            let hb = Self::hi(cr, at, b);
            let sign = Self::iimm(cr, at, 0x8000_0000);
            let s = Self::and(cr, at, hb, sign);
            let one = Self::iimm(cr, at, 0x3ff0_0000);
            let shi = Self::or(cr, at, s, one);
            let z = Self::iimm(cr, at, 0);
            let unit = Self::pack(cr, at, z, shi);
            let ab = Self::f(cr, at, "xe3.eu.mov", &[b], vec![("abs0", A::Bool(true))]);
            let fb = Self::cmpf(cr, at, "lt", ab, inf);
            let nb = Self::cmpf(cr, at, "nz", b, zero);
            let finite = Self::and(cr, at, fb, nb);
            let bb = Self::sel(cr, at, finite, unit, b);
            let b32 = Self::to_f32(cr, at, bb);
            let r32 = GpuToXe3::eu(cr, at, "xe3.eu.math", &[b32], vec![("fn", A::str("inv"))], "f32");
            let r = Self::to_f64(cr, at, r32);
            Self::mul(cr, at, a, r)
        };
        let (am, ea) = Self::split(cr, at, a);
        let (bm, eb) = Self::split(cr, at, b);
        let one = Self::fimm(cr, at, 1.0);
        let b32 = Self::to_f32(cr, at, bm);
        let y32 = GpuToXe3::eu(cr, at, "xe3.eu.math", &[b32], vec![("fn", A::str("inv"))], "f32");
        let mut y = Self::to_f64(cr, at, y32);
        for _ in 0..3 {
            let e = Self::mad(cr, at, one, bm, y, true);
            y = Self::mad(cr, at, y, y, e, false);
        }
        let q0 = Self::mul(cr, at, am, y);
        let r = Self::mad(cr, at, am, bm, q0, true);
        let q1 = Self::mad(cr, at, q0, r, y, false);
        let r1 = Self::mad(cr, at, am, bm, q1, true);
        let k = Self::add(cr, at, ea, eb, true);
        let hq = Self::hi(cr, at, q1);
        let eq = Self::exponent(cr, at, hq);
        let big = Self::add(cr, at, eq, k, false);
        let normal = {
            let twenty = Self::iimm(cr, at, 20);
            let ks = Self::i(cr, at, "xe3.eu.shl", &[k, twenty], vec![]);
            let h = Self::add(cr, at, hq, ks, false);
            let l = Self::lo(cr, at, q1);
            Self::pack(cr, at, l, h)
        };
        let over = {
            let sign = Self::iimm(cr, at, 0x8000_0000);
            let s = Self::and(cr, at, hq, sign);
            let e = Self::iimm(cr, at, 0x7ff0_0000);
            let h = Self::or(cr, at, s, e);
            let z = Self::iimm(cr, at, 0);
            Self::pack(cr, at, z, h)
        };
        let under = {
            let lowest = Self::iimm(cr, at, (-1300i32) as u32);
            let kc = Self::i(cr, at, "xe3.eu.sel", &[k, lowest], vec![("cond", A::str("ge"))]);
            let six = Self::iimm(cr, at, 600);
            let k6 = Self::add(cr, at, kc, six, false);
            let p = Self::pow2k(cr, at, k6);
            let m6 = Self::iimm(cr, at, (-600i32) as u32);
            let p6 = Self::pow2k(cr, at, m6);
            let u = Self::mul(cr, at, q1, p);
            let res = Self::mul(cr, at, u, p6);
            let back = {
                let p600 = Self::iimm(cr, at, 600);
                let up = Self::pow2k(cr, at, p600);
                let r600 = Self::mul(cr, at, res, up);
                let zero32 = Self::iimm(cr, at, 0);
                let nk6 = Self::add(cr, at, zero32, k6, true);
                let down = Self::pow2k(cr, at, nk6);
                Self::mul(cr, at, r600, down)
            };
            let d = Self::f(cr, at, "xe3.eu.add", &[q1, back], vec![("neg1", A::Bool(true))]);
            let ad = Self::f(cr, at, "xe3.eu.mov", &[d], vec![("abs0", A::Bool(true))]);
            let h = {
                let c = Self::iimm(cr, at, (-1075i32) as u32);
                let e = Self::add(cr, at, c, kc, true);
                Self::pow2k(cr, at, e)
            };
            let tie = Self::cmpf(cr, at, "z", ad, h);
            let exact = Self::cmpf(cr, at, "z", r1, zero);
            let fix = Self::andn(cr, at, tie, exact);
            let dir = Self::mul(cr, at, r1, y);
            let pos = Self::cmpf(cr, at, "gt", dir, zero);
            let hn = Self::f(cr, at, "xe3.eu.mov", &[h], vec![("neg0", A::Bool(true))]);
            let step = Self::sel(cr, at, pos, h, hn);
            let q1c = Self::f(cr, at, "xe3.eu.add", &[q1, step], vec![]);
            let uc = Self::mul(cr, at, q1c, p);
            let resc = Self::mul(cr, at, uc, p6);
            Self::sel(cr, at, fix, resc, res)
        };
        let lo1 = Self::iimm(cr, at, 1);
        let hi2046 = Self::iimm(cr, at, 2046);
        let is_over = Self::cmpi(cr, at, "gt", big, hi2046);
        let is_under = Self::cmpi(cr, at, "lt", big, lo1);
        let q = Self::sel(cr, at, is_over, over, normal);
        let q = Self::sel(cr, at, is_under, under, q);
        Self::sel(cr, at, general, q, special)
    }

    fn sqrt(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId) -> ValueId {
        let inf = Self::fimm(cr, at, f64::INFINITY);
        let zero = Self::fimm(cr, at, 0.0);
        let general = {
            let pos = Self::cmpf(cr, at, "gt", x, zero);
            let fin = Self::cmpf(cr, at, "lt", x, inf);
            Self::and(cr, at, pos, fin)
        };
        let special = {
            let neg = Self::cmpf(cr, at, "lt", x, zero);
            let nan = Self::fimm(cr, at, f64::NAN);
            Self::sel(cr, at, neg, nan, x)
        };
        let (m, e) = Self::split(cr, at, x);
        let one = Self::iimm(cr, at, 1);
        let odd = Self::and(cr, at, e, one);
        let z = Self::iimm(cr, at, 0);
        let is_odd = Self::cmpi(cr, at, "nz", odd, z);
        let two = Self::fimm(cr, at, 2.0);
        let m2 = Self::mul(cr, at, m, two);
        let m = Self::sel(cr, at, is_odd, m2, m);
        let e = Self::add(cr, at, e, odd, true);
        let half_e = Self::i(cr, at, "xe3.eu.asr", &[e, one], vec![]);
        let m32 = Self::to_f32(cr, at, m);
        let y32 = GpuToXe3::eu(cr, at, "xe3.eu.math", &[m32], vec![("fn", A::str("rsq"))], "f32");
        let y = Self::to_f64(cr, at, y32);
        let half = Self::fimm(cr, at, 0.5);
        let mut g = Self::mul(cr, at, m, y);
        let mut h = Self::mul(cr, at, half, y);
        for _ in 0..3 {
            let r = Self::mad(cr, at, half, g, h, true);
            g = Self::mad(cr, at, g, g, r, false);
            h = Self::mad(cr, at, h, h, r, false);
        }
        let d = Self::mad(cr, at, m, g, g, true);
        let s = Self::mad(cr, at, g, d, h, false);
        let p = Self::pow2k(cr, at, half_e);
        let root = Self::mul(cr, at, s, p);
        Self::sel(cr, at, general, root, special)
    }

    fn round(cr: &mut Cr<'_, '_, '_>, at: OpId, x: ValueId, kind: Rounding) -> ValueId {
        let sign = Self::iimm(cr, at, 0x8000_0000);
        let hx = Self::hi(cr, at, x);
        let sx = Self::and(cr, at, hx, sign);
        let signed = |cr: &mut Cr<'_, '_, '_>, v: ValueId| {
            let h = Self::hi(cr, at, v);
            let m = Self::andn(cr, at, h, sign);
            let h = Self::or(cr, at, m, sx);
            let l = Self::lo(cr, at, v);
            Self::pack(cr, at, l, h)
        };
        let big = Self::fimm(cr, at, pow2d(52));
        let s = signed(cr, big);
        let up = Self::f(cr, at, "xe3.eu.add", &[x, s], vec![]);
        let even = Self::f(cr, at, "xe3.eu.add", &[up, s], vec![("neg1", A::Bool(true))]);
        let one = Self::fimm(cr, at, 1.0);
        let r = match kind {
            Rounding::Even => even,
            Rounding::Down => {
                let past = Self::cmpf(cr, at, "gt", even, x);
                let back = Self::f(cr, at, "xe3.eu.add", &[even, one], vec![("neg1", A::Bool(true))]);
                Self::sel(cr, at, past, back, even)
            }
            Rounding::Up => {
                let past = Self::cmpf(cr, at, "lt", even, x);
                let back = Self::f(cr, at, "xe3.eu.add", &[even, one], vec![]);
                Self::sel(cr, at, past, back, even)
            }
            Rounding::Zero => {
                let ae = Self::f(cr, at, "xe3.eu.mov", &[even], vec![("abs0", A::Bool(true))]);
                let ax = Self::f(cr, at, "xe3.eu.mov", &[x], vec![("abs0", A::Bool(true))]);
                let past = Self::cmpf(cr, at, "gt", ae, ax);
                let unit = signed(cr, one);
                let back = Self::f(cr, at, "xe3.eu.add", &[even, unit], vec![("neg1", A::Bool(true))]);
                Self::sel(cr, at, past, back, even)
            }
        };
        let r = signed(cr, r);
        let ax = Self::f(cr, at, "xe3.eu.mov", &[x], vec![("abs0", A::Bool(true))]);
        let small = Self::cmpf(cr, at, "lt", ax, big);
        Self::sel(cr, at, small, r, x)
    }
}

const fn pow2f(e: i32) -> f32 {
    f32::from_bits(((127 + e) as u32) << 23)
}

const fn pow2d(e: i32) -> f64 {
    f64::from_bits(((1023 + e) as u64) << 52)
}
