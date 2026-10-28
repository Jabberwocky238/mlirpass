//! The x86 CPU dialects ⇒ `llvm` intrinsic calls, as `X86Vector` / `AMX`
//! `LegalizeForLLVMExport.cpp`: each op is `llvm.call_intrinsic` of the intrinsic its ODS names
//! (`X86IntrinsicOpInterface` / `AMXIntrinsicOpInterface`), with the operands its
//! `getIntrinsicOperands` builds. `!amx.tile<..>` is `!llvm.x86_amx`.

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Const, Scalar, Shaped, Type};

use crate::patterns;

use crate::{ConversionRewriter, LlvmOptions, MemrefLayout, MemrefToLlvm, OpData, OpId, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// The x86vector and amx ⇒ llvm patterns (`populateX86VectorLegalizeForLLVMExportPatterns`,
/// `populateAMXLegalizeForLLVMExportPatterns`).
pub struct X86ToLlvm;

impl X86ToLlvm {
    /// `!amx.tile<..>` as `!llvm.x86_amx`.
    pub fn convert_tiles(tc: &mut TypeConverter<'_>) {
        tc.conversion(|t| match t {
            Type::Extended(e) if e.name == "amx.tile" => Some(Some(vec![LlvmType::X86Amx.into()])),
            _ => None,
        });
    }

    /// The bits of a vector type (`count * element width`).
    fn bits(t: &Type<'_>) -> Option<u64> {
        Some(t.element_count()? as u64 * u64::from(t.element_type().bit_width()?))
    }

    fn ty<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Type<'a> {
        cr.rw.body[v].ty.clone()
    }

    /// `getIntrinsicName`.
    fn intrinsic(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<String> {
        let b = &cr.rw.body;
        let operand = |i: usize| b[b[op].operands[i]].ty.clone();
        let result = || b[b[op].results[0]].ty.clone();
        let suffix = |t: &Type<'_>| Some(format!(".{}", Self::bits(t)?));
        let pspd = |t: &Type<'_>| if *t.element_type() == Type::Float(mlirformat::FloatKind::F32) { "ps" } else { "pd" };
        let half = |t: &Type<'_>, bf: &str, f: &str| match t.element_type() {
            Type::Float(mlirformat::FloatKind::BF16) => String::from(bf),
            Type::Float(mlirformat::FloatKind::F16) => String::from(f),
            _ => String::new(),
        };
        Some(match &*b[op].name {
            "x86vector.avx512.mask.compress" => String::from("llvm.x86.avx512.mask.compress"),
            "x86vector.avx512.mask.rndscale" => format!("llvm.x86.avx512.mask.rndscale.{}{}", pspd(&operand(0)), suffix(&operand(0))?),
            "x86vector.avx512.mask.scalef" => format!("llvm.x86.avx512.mask.scalef.{}{}", pspd(&operand(0)), suffix(&operand(0))?),
            "x86vector.avx512.vp2intersect" => format!("llvm.x86.avx512.vp2intersect.{}{}", if *operand(0).element_type() == Type::int(32) { "d" } else { "q" }, suffix(&operand(0))?),
            "x86vector.avx512.dot" => format!("llvm.x86.avx512bf16.dpbf16ps{}", suffix(&operand(0))?),
            "x86vector.avx512.cvt.packed.f32_to_bf16" => format!("llvm.x86.avx512bf16.cvtneps2bf16{}", suffix(&operand(0))?),
            "x86vector.avx.rsqrt" => String::from("llvm.x86.avx.rsqrt.ps.256"),
            "x86vector.avx.intr.dot" => String::from("llvm.x86.avx.dp.ps.256"),
            "x86vector.avx.dot.i8" => format!("llvm.x86.avx2.vpdpbssd{}", suffix(&operand(0))?),
            "x86vector.avx.bcst_to_f32.packed" => format!("llvm.x86.{}{}", half(&operand(0), "vbcstnebf162ps", "vbcstnesh2ps"), Self::bits(&result())?),
            "x86vector.avx.cvt.packed.even.indexed_to_f32" => format!("llvm.x86.{}{}", half(&operand(0), "vcvtneebf162ps", "vcvtneeph2ps"), Self::bits(&result())?),
            "x86vector.avx.cvt.packed.odd.indexed_to_f32" => format!("llvm.x86.{}{}", half(&operand(0), "vcvtneobf162ps", "vcvtneoph2ps"), Self::bits(&result())?),
            "amx.tile_zero" => String::from("llvm.x86.tilezero.internal"),
            "amx.tile_load" => String::from("llvm.x86.tileloadd64.internal"),
            "amx.tile_store" => String::from("llvm.x86.tilestored64.internal"),
            "amx.tile_mulf" => format!("llvm.x86.tdp{}ps.internal", if Self::with_tile(&operand(0), |t| Some(*t.element_type() == Type::Float(mlirformat::FloatKind::F16)))? { "fp16" } else { "bf16" }),
            "amx.tile_muli" => format!("llvm.x86.tdpb{}{}d.internal", if b[op].get("isZextLhs").is_some() { "u" } else { "s" }, if b[op].get("isZextRhs").is_some() { "u" } else { "s" }),
            _ => return None,
        })
    }

    fn int<'a>(cr: &mut Cr<'_, 'a, '_>, width: u32, v: i128) -> ValueId {
        cr.llvm_constant(Attribute::integer(v, Type::int(width)), Type::int(width))
    }

    /// The `[rows, columns in bytes]` of an `!amx.tile<RxCxT>`, as `i16` constants
    /// (`getTileSizes`).
    /// `!amx.tile<RxCxT>` read as `vector<RxCxT>`, handed to `f`.
    fn with_tile<R>(tile: &Type<'_>, f: impl FnOnce(&Type<'_>) -> Option<R>) -> Option<R> {
        let Type::Extended(e) = tile else { return None };
        let vector = format!("vector<{}>", e.body.as_deref()?.trim_matches(['<', '>']));
        mlirformat::Parser::read(&vector, |p| p.ty()).ok().and_then(|t| f(&t))
    }

    fn tile_sizes(cr: &mut Cr<'_, '_, '_>, tile: &Type<'_>) -> Option<[ValueId; 2]> {
        let (rows, cols) = Self::with_tile(tile, |t| Some((t.dims()?[0], t.dims()?[1] * i64::from(t.element_type().bit_width()? / 8))))?;
        Some([Self::int(cr, 16, i128::from(rows)), Self::int(cr, 16, i128::from(cols))])
    }

    /// `computeStrideInBytes`.
    fn stride_bytes(cr: &mut Cr<'_, '_, '_>, s: &Shaped<'_>, stride: ValueId) -> Option<ValueId> {
        let scale = Self::int(cr, 64, i128::from(s.elem.bit_width()? / 8));
        Some(cr.build(OpData::build("llvm.mul").operands(&[scale, stride]), Type::int(64)))
    }

    /// `inferStride`: the second innermost stride, in bytes.
    fn infer_stride(cr: &mut Cr<'_, '_, '_>, s: &Shaped<'_>, desc: ValueId) -> Option<ValueId> {
        let rank = s.shape.as_ref()?.len();
        let (strides, _) = s.strides_and_offset()?;
        let pre = rank.checked_sub(2)?;
        if strides[pre] == mlirformat::Dim::DYNAMIC {
            let st = cr.extract(desc, &[4, pre as i64]);
            return Self::stride_bytes(cr, s, st);
        }
        let bytes = i128::from(s.elem.bit_width()? / 8);
        Some(Self::int(cr, 64, i128::from(strides[pre]) * bytes))
    }

    /// An AMX transfer's pointer and stride (`tile_load` / `tile_store`).
    fn transfer(cr: &mut Cr<'_, '_, '_>, op: OpId, ops: &[ValueId], opts: LlvmOptions) -> Option<Vec<ValueId>> {
        let b = &cr.rw.body;
        let segs = b.segments(op, "operandSegmentSizes")?;
        let store = b[op].name == "amx.tile_store";
        let mem = b[b[op].operands[0]].ty.clone();
        let tile = if store { b[b[op].operands[1 + segs[1]]].ty.clone() } else { b[b[op].results[0]].ty.clone() };
        let Type::Shaped(s) = mem else { return None };
        let indices = ops[1..1 + segs[1]].to_vec();
        let stride = ops.get(1 + segs[1] + usize::from(store)).copied().filter(|_| segs.last().is_some_and(|n| *n == 1));
        let mut out = Vec::from(Self::tile_sizes(cr, &tile)?);
        out.push(MemrefToLlvm::strided_ptr(cr, opts, &s, ops[0], &indices, 0)?);
        out.push(match stride {
            Some(st) => Self::stride_bytes(cr, &s, st)?,
            None => Self::infer_stride(cr, &s, ops[0])?,
        });
        if store {
            out.push(ops[1 + segs[1]]);
        }
        Some(out)
    }

    /// `getIntrinsicOperands`.
    fn operands(cr: &mut Cr<'_, '_, '_>, op: OpId, ops: Vec<ValueId>, opts: LlvmOptions) -> Option<Vec<ValueId>> {
        let name = cr.rw.body[op].name.clone();
        Some(match &*name {
            "x86vector.avx512.mask.compress" => {
                let ty = Self::ty(cr, ops[1]);
                let src = match ops.get(2) {
                    Some(s) => *s,
                    None => {
                        let value = cr.rw.body[op].get("constant_src").cloned().unwrap_or_else(|| {
                            let zero = match ty.element_type() {
                                Type::Float(k) => Scalar::Float(mlirformat::ApFloat::from_f64(*k, 0.0).expect("a float")),
                                e => Scalar::Int(mlirformat::ApInt::zero(e.bit_width().unwrap_or(32))),
                            };
                            Const::splat(zero, ty.clone()).into()
                        });
                        cr.llvm_constant(value, ty)
                    }
                };
                vec![ops[1], src, ops[0]]
            }
            "x86vector.avx.intr.dot" => {
                let scale = Self::int(cr, 8, -1);
                vec![ops[0], ops[1], scale]
            }
            "x86vector.avx.bcst_to_f32.packed" | "x86vector.avx.cvt.packed.even.indexed_to_f32" | "x86vector.avx.cvt.packed.odd.indexed_to_f32" => {
                let Type::Shaped(s) = cr.rw.body[cr.rw.body[op].operands[0]].ty.clone() else { return None };
                vec![MemrefToLlvm::buffer_ptr(cr, opts, &s, ops[0])?]
            }
            "amx.tile_zero" => {
                let t = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
                Vec::from(Self::tile_sizes(cr, &t)?)
            }
            "amx.tile_load" | "amx.tile_store" => Self::transfer(cr, op, &ops, opts)?,
            "amx.tile_mulf" | "amx.tile_muli" => {
                let (lt, rt) = (cr.rw.body[cr.rw.body[op].operands[0]].ty.clone(), cr.rw.body[cr.rw.body[op].operands[1]].ty.clone());
                let a = Self::tile_sizes(cr, &lt)?;
                let b = Self::tile_sizes(cr, &rt)?;
                vec![a[0], b[1], a[1], ops[2], ops[0], ops[1]]
            }
            _ => ops,
        })
    }
}

#[patterns(converter, options = LlvmOptions, x86vector: bool, amx: bool)]
impl X86ToLlvm {
    /// `X86IntrinsicOpConversion` (`enable-x86vector`).
    #[lowering(
        "x86vector.avx512.mask.compress", "x86vector.avx512.mask.rndscale", "x86vector.avx512.mask.scalef", "x86vector.avx512.vp2intersect",
        "x86vector.avx512.dot", "x86vector.avx512.cvt.packed.f32_to_bf16", "x86vector.avx.rsqrt", "x86vector.avx.intr.dot", "x86vector.avx.dot.i8",
        "x86vector.avx.bcst_to_f32.packed", "x86vector.avx.cvt.packed.even.indexed_to_f32", "x86vector.avx.cvt.packed.odd.indexed_to_f32",
        when = x86vector
    )]
    fn x86vector_call(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        Self::intrinsic_call(cr, op, operands, opts)
    }

    /// `AMXIntrinsicOpConversion` (`enable-amx`).
    #[lowering("amx.tile_zero", "amx.tile_load", "amx.tile_store", "amx.tile_mulf", "amx.tile_muli", when = amx)]
    fn amx_call(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions) -> bool {
        Self::intrinsic_call(cr, op, operands, opts)
    }
}

impl X86ToLlvm {
    /// `LLVM::detail::intrinsicRewrite`: the call, the op's attributes carried over, several
    /// results packed in a struct and extracted.
    fn intrinsic_call(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>], opts: LlvmOptions) -> bool {        let Some(ops) = Cr::one_to_one(operands) else { return false };
        let Some(name) = Self::intrinsic(cr, op) else { return false };
        let Some(args) = Self::operands(cr, op, ops, opts) else { return false };
        if !args.iter().all(|v| LlvmType::compatible(&cr.rw.body[*v].ty)) {
            return false;
        }
        let results = cr.rw.body[op].results.clone();
        let Some(tc) = cr.type_converter() else { return false };
        let Some(types) = results.iter().map(|r| tc.convert(&cr.rw.body[*r].ty)).collect::<Option<Vec<_>>>() else { return false };
        let packed = match &types[..] {
            [] => None,
            [t] => Some(t.clone()),
            ts => Some(LlvmType::literal(ts.to_vec())),
        };
        let attrs = cr.rw.body[op].all_attrs();
        let mut data = OpData::build("llvm.call_intrinsic").operands(&args).with("intrin", Attribute::str(&name)).segments(&[args.len(), 0]);
        for a in attrs.into_iter().filter(|a| a.name != "operandSegmentSizes") {
            data.attributes.push(a);
        }
        let call = cr.rw.create(data, packed.as_slice());
        if results.len() <= 1 {
            let rs = cr.rw.body[call].results.clone();
            cr.replace_values(op, &rs);
            return true;
        }
        let packed = cr.rw.body[call].results[0];
        let parts: Vec<ValueId> = (0..results.len()).map(|i| cr.extract(packed, &[i as i64])).collect();
        cr.replace_values(op, &parts);
        true
    }
}
