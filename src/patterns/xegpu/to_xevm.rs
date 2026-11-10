//! `xegpu` ⇒ `xevm` (+ `llvm`, `vector`, `arith`, `scf`), as `XeGPUToXeVM.cpp`: tensor
//! descriptors as an `8 x i32` payload (or an `i64` address in 1-D), memory descriptors and
//! memrefs as integer addresses, block loads / stores / prefetches as the xevm block ops,
//! gathers and scatters as guarded `llvm` loads and stores.

use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{ApFloat, ApInt, Attribute, Const, Dim, FloatKind, Scalar, Shaped, ShapedKind, Signedness, Type};

use super::types::{CachePolicy, Chip, FenceScope, MemDesc, MemorySpace, TensorDesc};
use crate::patterns;
use crate::{ConversionRewriter, GpuAddressSpace, LlvmConverter, LlvmOptions, LoadCacheControl, MemrefLayout, MemrefOfr as Ofr, OpData, OpId, Rewriter, StoreCacheControl, TypeConverter, ValueId};

type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

/// `systolicDepth`, `executionSize`.
const SYSTOLIC_DEPTH: i64 = 8;
const EXECUTION_SIZE: i64 = 16;

/// `NdTdescOffset`: the payload's base pointer (as `i64` 0), width, height and pitch.
const BASE_PTR: i64 = 0;
const BASE_SHAPE_W: i64 = 2;
const BASE_SHAPE_H: i64 = 3;
const BASE_PITCH: i64 = 4;

fn vector<'a>(n: i64, elem: Type<'a>) -> Type<'a> {
    Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![Dim::Static(n)]), elem: elem.into(), extras: Vec::new() })
}

/// A vector type's static shape and element.
fn vector_of<'t, 'a>(t: &'t Type<'a>) -> Option<(Vec<i64>, &'t Type<'a>)> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::Vector => Some((s.dims()?, &s.elem)),
        _ => None,
    }
}

fn memref_of<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
    match t {
        Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => Some(s),
        _ => None,
    }
}

/// `encodeVectorTypeTo`: the flat vector of `to` with the same bits.
fn encode<'a>(t: &Type<'a>, to: Type<'a>) -> Type<'a> {
    let (shape, elem) = vector_of(t).map_or((vec![1], t), |(s, e)| (s, e));
    let n: i64 = shape.iter().product();
    let size = n * i64::from(elem.bit_width().unwrap_or(0)) / i64::from(to.bit_width().unwrap_or(1));
    vector(size, to)
}

/// `isSharedMemRef`.
fn shared(s: &Shaped<'_>) -> bool {
    match s.memory_space() {
        None => false,
        Some(Attribute::Int { lit, .. }) => lit.parse::<i64>().ok() == Some(3),
        Some(a @ Attribute::Extended { ext, .. }) => {
            (ext.name == "xevm.addr_space" && ext.body.as_deref().map(str::trim) == Some("<shared>")) || GpuAddressSpace::try_from(a) == Ok(GpuAddressSpace::Workgroup)
        }
        Some(_) => false,
    }
}

/// `memRefType.getMemorySpaceAsInt()`.
fn space_int(s: &Shaped<'_>) -> u32 {
    match s.memory_space() {
        Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(0),
        _ => 0,
    }
}

/// `translateLoadXeGPUCacheHint`: no hints, the default; a missing one cached.
fn load_cache(l1: Option<CachePolicy>, l3: Option<CachePolicy>) -> Option<LoadCacheControl> {
    use CachePolicy::*;
    if l1.is_none() && l3.is_none() {
        return Some(LoadCacheControl::UseDefault);
    }
    let (l1, l3) = (l1.unwrap_or(Cached), l3.unwrap_or(Cached));
    Some(match (l1, l3) {
        (Cached, Cached) => LoadCacheControl::L1cL2ucL3c,
        (Cached, Uncached) => LoadCacheControl::L1cL2ucL3uc,
        (Uncached, Cached) => LoadCacheControl::L1ucL2ucL3c,
        (Uncached, Uncached) => LoadCacheControl::L1ucL2ucL3uc,
        (Streaming, Cached) => LoadCacheControl::L1sL2ucL3c,
        (Streaming, Uncached) => LoadCacheControl::L1sL2ucL3uc,
        (ReadInvalidate, _) => LoadCacheControl::InvalidateRead,
        _ => return None,
    })
}

/// `translateStoreXeGPUCacheHint`: no hints, the default; a missing L1 uncached, L3 write-back.
fn store_cache(l1: Option<CachePolicy>, l3: Option<CachePolicy>) -> Option<StoreCacheControl> {
    use CachePolicy::*;
    if l1.is_none() && l3.is_none() {
        return Some(StoreCacheControl::UseDefault);
    }
    let (l1, l3) = (l1.unwrap_or(Uncached), l3.unwrap_or(WriteBack));
    Some(match (l1, l3) {
        (Uncached, Uncached) => StoreCacheControl::L1ucL2ucL3uc,
        (Uncached, WriteBack) => StoreCacheControl::L1ucL2ucL3wb,
        (Streaming, Uncached) => StoreCacheControl::L1sL2ucL3uc,
        (Streaming, WriteBack) => StoreCacheControl::L1sL2ucL3wb,
        (WriteBack, Uncached) => StoreCacheControl::L1wbL2ucL3uc,
        (WriteBack, WriteBack) => StoreCacheControl::L1wbL2ucL3wb,
        (WriteThrough, Uncached) => StoreCacheControl::L1wtL2ucL3uc,
        (WriteThrough, WriteBack) => StoreCacheControl::L1wtL2ucL3wb,
        _ => return None,
    })
}

/// An xevm op on `operands` with attributes `attrs`.
fn xevm<'a>(name: &str, operands: &[ValueId], attrs: Vec<(&str, Attribute<'a>)>) -> OpData<'a> {
    let mut d = OpData::build(name).operands(operands);
    for (n, v) in attrs {
        d.set(n, v);
    }
    d
}

/// Builders the materializations share with the patterns.
trait Build<'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId;

    fn int(&mut self, v: i64, ty: Type<'a>) -> ValueId {
        let w = ty.bit_width().unwrap_or(64);
        let value = if matches!(ty, Type::Index) { Attribute::index(v) } else { Const::int(ApInt::new(w, v.into()), ty.clone()).into() };
        self.mk(OpData::build("arith.constant").with("value", value), ty)
    }

    fn unary(&mut self, name: &str, v: ValueId, ty: Type<'a>) -> ValueId {
        self.mk(OpData::build(name).operands(&[v]), ty)
    }

    fn vextract(&mut self, v: ValueId, at: i64, ty: Type<'a>) -> ValueId {
        self.mk(OpData::build("vector.extract").operands(&[v]).with("static_position", Attribute::dense_i64(&[at])), ty)
    }
}

impl<'a> Build<'a> for Rewriter<'_, 'a> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        let o = self.create(data, &[ty]);
        self.body[o].results[0]
    }
}

impl<'a> Build<'a> for Cr<'_, 'a, '_> {
    fn mk(&mut self, data: OpData<'a>, ty: Type<'a>) -> ValueId {
        self.build(data, ty)
    }
}

/// The xegpu ⇒ xevm patterns (`populateXeGPUToXeVMConversionPatterns`).
pub struct XegpuToXevm;

impl XegpuToXevm {
    /// `ConvertXeGPUToXeVMPass`'s type converter: LLVM's, vectors flattened (a single element
    /// as the scalar), descriptors and memrefs as integer addresses; and its materializations.
    pub fn converter<'c>() -> TypeConverter<'c> {
        let mut tc = LlvmConverter::build(LlvmOptions::default());
        tc.conversion(|t| {
            let (shape, elem) = vector_of(t)?;
            let elem = if matches!(elem, Type::Index) { Type::int(64) } else { elem.clone() };
            let n: i64 = shape.iter().product();
            Some(Some(vec![if shape.is_empty() || n == 1 { elem } else { vector(n, elem) }]))
        });
        tc.conversion(|t| {
            let d = TensorDesc::try_from(t).ok()?;
            Some((!d.scattered).then(|| vec![if d.shape.len() == 1 { Type::int(64) } else { vector(8, Type::int(32)) }]))
        });
        tc.conversion(|t| MemDesc::try_from(t).ok().map(|_| Some(vec![Type::int(32)])));
        tc.conversion(|t| memref_of(t).map(|s| Some(vec![Type::int(if shared(s) { 32 } else { 64 })])));
        tc.source(Self::single_element_vector);
        tc.source(|rw, ty, inputs| Self::vector_cast(rw, ty, inputs));
        tc.target(|rw, tys, inputs, _| Some(vec![Self::memref_address(rw, tys.first()?, inputs)?]));
        tc.target(|rw, tys, inputs, _| Some(vec![Self::unsigned(rw, tys.first()?, inputs, 32)?]));
        tc.target(|rw, tys, inputs, _| Some(vec![Self::unsigned(rw, tys.first()?, inputs, 64)?]));
        tc.target(|rw, tys, inputs, _| Some(vec![Self::vector_cast(rw, tys.first()?, inputs)?]));
        tc
    }

    /// `memrefMaterializationCast`: the aligned pointer plus the offset in bytes.
    fn memref_address<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        let [input] = inputs else { return None };
        let s = memref_of(&rw.body[*input].ty)?.clone();
        let (addr, offset) = match s.strides_and_offset() {
            Some((_, off)) if off != Dim::DYNAMIC => {
                let a = rw.mk(OpData::build("memref.extract_aligned_pointer_as_index").operands(&[*input]), Type::Index);
                (a, rw.int(off, Type::Index))
            }
            _ => {
                let rank = s.shape.as_ref().map_or(0, Vec::len);
                let base = Type::Shaped(Shaped { shape: Some(Vec::new()), extras: s.memory_space().cloned().into_iter().collect(), ..s.clone() });
                let types: Vec<Type<'a>> = [base, Type::Index].into_iter().chain(core::iter::repeat_n(Type::Index, 2 * rank)).collect();
                let meta = rw.create(OpData::build("memref.extract_strided_metadata").operands(&[*input]), &types);
                let r = rw.body[meta].results.clone();
                (rw.mk(OpData::build("memref.extract_aligned_pointer_as_index").operands(&[r[0]]), Type::Index), r[1])
            }
        };
        let addr = rw.unary("arith.index_castui", addr, ty.clone());
        let offset = rw.unary("arith.index_castui", offset, ty.clone());
        let size = rw.int(i64::from(s.elem.bit_width()? / 8), ty.clone());
        let bytes = rw.mk(OpData::build("arith.muli").operands(&[offset, size]), ty.clone());
        Some(rw.mk(OpData::build("arith.addi").operands(&[addr, bytes]), ty.clone()))
    }

    /// `ui64MaterializationCast` / `ui32MaterializationCast`: through `index`.
    fn unsigned<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId], width: u32) -> Option<ValueId> {
        let [input] = inputs else { return None };
        if rw.body[*input].ty != (Type::Integer { signedness: Signedness::Unsigned, width }) {
            return None;
        }
        let i = rw.unary("index.castu", *input, Type::Index);
        Some(rw.unary("arith.index_castui", i, ty.clone()))
    }

    /// `vectorMaterializationCast`: a single element extracted, else a bitcast (same rank) or
    /// a shape cast (same element).
    fn vector_cast<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        let [input] = inputs else { return None };
        let in_ty = rw.body[*input].ty.clone();
        let (shape, elem) = vector_of(&in_ty)?;
        let elem = elem.clone();
        if shape.iter().product::<i64>() == 1 {
            let mut v = rw.vextract(*input, 0, elem.clone());
            if matches!(elem, Type::Index) {
                v = rw.unary("arith.index_castui", v, ty.clone());
            }
            return Some(v);
        }
        let (to_shape, to_elem) = vector_of(ty)?;
        if to_shape.len() == shape.len() {
            return Some(rw.unary("vector.bitcast", *input, ty.clone()));
        }
        (*to_elem == elem).then(|| rw.unary("vector.shape_cast", *input, ty.clone()))
    }

    /// `singleElementVectorMaterializationCast`: a scalar broadcast to one element.
    fn single_element_vector<'a>(rw: &mut Rewriter<'_, 'a>, ty: &Type<'a>, inputs: &[ValueId]) -> Option<ValueId> {
        let [input] = inputs else { return None };
        if !matches!(rw.body[*input].ty, Type::Integer { .. } | Type::Index | Type::Float(_)) {
            return None;
        }
        let (shape, _) = vector_of(ty)?;
        (shape.iter().product::<i64>() == 1).then(|| rw.unary("vector.broadcast", *input, ty.clone()))
    }
}

#[patterns(converter)]
impl XegpuToXevm {
    /// `getMixedValues` of `statics` (the dynamic sentinel taking the next of `dynamics`).
    fn mixed(statics: &[i64], dynamics: &[ValueId]) -> Vec<Ofr> {
        let mut d = dynamics.iter();
        statics.iter().map(|&s| if s == Dim::DYNAMIC { d.next().map_or(Ofr::C(s), |v| Ofr::V(*v)) } else { Ofr::C(s) }).collect()
    }

    /// `getValueOrCreateConstantIntOp`: an `i64` constant for a static.
    fn int_value<'a>(cr: &mut Cr<'_, 'a, '_>, o: &Ofr) -> ValueId {
        match o {
            Ofr::V(v) => *v,
            Ofr::C(c) => cr.int(*c, Type::int(64)),
        }
    }

    /// `getValueOrCreateConstantIndexOp`.
    fn index_value(cr: &mut Cr<'_, '_, '_>, o: &Ofr) -> ValueId {
        match o {
            Ofr::V(v) => *v,
            Ofr::C(c) => cr.int(*c, Type::Index),
        }
    }

    /// `getValueOrCreateCastToIndexLike`.
    fn cast_index_like<'a>(cr: &mut Cr<'_, 'a, '_>, to: Type<'a>, v: ValueId) -> ValueId {
        let from = cr.rw.body[v].ty.clone();
        if from == to {
            return v;
        }
        if matches!(to, Type::Index) != matches!(from, Type::Index) {
            return cr.unary("arith.index_cast", v, to);
        }
        let name = if to.bit_width() > from.bit_width() { "arith.extsi" } else { "arith.trunci" };
        cr.unary(name, v, to)
    }

    /// The op's offsets (`getMixedOffsets`): `const_offsets` with the dynamic ones.
    fn offsets(cr: &Cr<'_, '_, '_>, op: OpId, dynamics: &[ValueId]) -> Vec<Ofr> {
        let statics = cr.rw.body.dense_i64(op, "const_offsets");
        if statics.is_empty() && dynamics.is_empty() {
            return Vec::new();
        }
        Self::mixed(&statics, dynamics)
    }

    fn hint(cr: &Cr<'_, '_, '_>, op: OpId, name: &str) -> Option<CachePolicy> {
        cr.rw.body[op].get(name).and_then(|a| CachePolicy::try_from(a).ok())
    }

    fn ptr<'a>(space: u32) -> Type<'a> {
        LlvmType::Ptr(space).into()
    }

    /// `CreateNdDescToXeVMPattern`.
    #[convert("xegpu.create_nd_tdesc")]
    fn create_nd_tdesc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let ops = b[op].operands.clone();
        let seg = b.dense_i64(op, "operandSegmentSizes");
        // source, shape, strides (MLIR 23 dropped the offsets).
        let seg: Vec<usize> = if seg.len() == 3 { seg.iter().map(|&n| n as usize).collect() } else { vec![1, 0, 0] };
        let shape_ops = &ops[1..1 + seg[1]];
        let stride_ops = &ops[1 + seg[1]..];
        let src_ty = b[ops[0]].ty.clone();
        let mut sizes: Vec<i64> = Vec::new();
        let mut strides: Vec<i64> = Vec::new();
        if let Some(s) = memref_of(&src_ty) {
            sizes = s.dims().unwrap_or_default();
            strides = s.strides_and_offset().map(|(st, _)| st).unwrap_or_default();
        } else if matches!(&src_ty, Type::Shaped(s) if s.kind == ShapedKind::MemRef) {
            return false;
        }
        if b[op].get("const_shape").is_some() {
            sizes = b.dense_i64(op, "const_shape");
        }
        if b[op].get("const_strides").is_some() {
            strides = b.dense_i64(op, "const_strides");
        }
        let (sizes, strides) = (Self::mixed(&sizes, shape_ops), Self::mixed(&strides, stride_ops));
        let i32t = Type::int(32);
        let i64t = Type::int(64);
        cr.rw.set_before(op);
        let zero: Attribute<'a> = Const::splat(Scalar::Int(ApInt::new(32, 0)), vector(8, i32t.clone())).into();
        let mut payload = cr.mk(OpData::build("arith.constant").with("value", zero), vector(8, i32t.clone()));
        let mut base = operands[0][0];
        if memref_of(&src_ty).is_none() && cr.rw.body[base].ty != i64t {
            base = cr.unary("arith.extui", base, i64t.clone());
        }
        if sizes.len() == 1 {
            cr.replace(op, vec![vec![base]]);
            return true;
        }
        let field = |cr: &mut Cr<'_, 'a, '_>, o: &Ofr| {
            let v = Self::int_value(cr, o);
            Self::cast_index_like(cr, i32t.clone(), v)
        };
        let w = field(cr, &sizes[1]);
        let h = field(cr, &sizes[0]);
        let pitch = field(cr, &strides[0]);
        let as_i64 = cr.unary("vector.bitcast", payload, vector(4, i64t.clone()));
        let as_i64 = cr.mk(OpData::build("vector.insert").operands(&[base, as_i64]).with("static_position", Attribute::dense_i64(&[BASE_PTR])), vector(4, i64t));
        payload = cr.unary("vector.bitcast", as_i64, vector(8, i32t.clone()));
        for (v, at) in [(w, BASE_SHAPE_W), (h, BASE_SHAPE_H), (pitch, BASE_PITCH)] {
            payload = cr.mk(OpData::build("vector.insert").operands(&[v, payload]).with("static_position", Attribute::dense_i64(&[at])), vector(8, i32t.clone()));
        }
        cr.replace(op, vec![vec![payload]]);
        true
    }

    /// `LoadStorePrefetchNdToXeVMPattern`.
    #[convert("xegpu.load_nd", "xegpu.store_nd", "xegpu.prefetch_nd")]
    fn nd<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let name = cr.rw.body[op].name.clone();
        let (store, prefetch) = (name == "xegpu.store_nd", name == "xegpu.prefetch_nd");
        let td_at = usize::from(store);
        let ops = cr.rw.body[op].operands.clone();
        let Ok(td) = TensorDesc::try_from(&cr.rw.body[ops[td_at]].ty) else { return false };
        let offsets = Self::offsets(cr, op, &ops[td_at + 1..]);
        let rank = td.shape.len();
        if offsets.len() != rank {
            return false;
        }
        let mut elem = td.elem.clone();
        let mut bits = i64::from(elem.bit_width().unwrap_or(0));
        let mut tile_w = td.shape[rank - 1];
        let mut w_scale = 1i64;
        if bits < 8 {
            if bits != 4 || rank != 2 {
                return false;
            }
            let sub = 8 / bits;
            let tile_h = td.shape[0];
            if !store && !prefetch && cr.rw.body[op].get("packed").is_some() && tile_h == SYSTOLIC_DEPTH * 4 && tile_w == EXECUTION_SIZE * sub {
                elem = Type::int(8);
                tile_w = EXECUTION_SIZE;
                w_scale = sub;
            }
            if w_scale == 1 {
                if tile_w != EXECUTION_SIZE * sub * 2 {
                    return false;
                }
                elem = Type::int(16);
                tile_w = EXECUTION_SIZE;
                w_scale = sub * 2;
            }
            bits = i64::from(elem.bit_width().unwrap_or(0));
        } else if bits % 8 != 0 {
            return false;
        }
        let (l1, l3) = (Self::hint(cr, op, "l1_hint"), Self::hint(cr, op, "l3_hint"));
        let ptr_ty = Self::ptr(td.space.xevm());
        let tdesc = operands[td_at][0];
        let (i32t, i64t) = (Type::int(32), Type::int(64));
        cr.rw.set_before(op);
        // A store's value: the op's own when the adaptor's became a scalar.
        let store_src = |cr: &mut Cr<'_, 'a, '_>| -> Option<ValueId> {
            let mut src = operands[0][0];
            if matches!(cr.rw.body[src].ty, Type::Integer { .. } | Type::Float(_)) {
                src = ops[0];
            }
            let ty = cr.rw.body[src].ty.clone();
            vector_of(&ty)?;
            let flat = encode(&ty, Type::int(bits as u32));
            Some(if flat != ty { cr.unary("vector.bitcast", src, flat) } else { src })
        };
        if rank == 2 {
            let size = cr.int(bits / 8, i32t.clone());
            let as_i64 = cr.unary("vector.bitcast", tdesc, vector(4, i64t.clone()));
            let base = cr.vextract(as_i64, BASE_PTR, i64t.clone());
            let w = cr.vextract(tdesc, BASE_SHAPE_W, i32t.clone());
            let h = cr.vextract(tdesc, BASE_SHAPE_H, i32t.clone());
            let pitch = cr.vextract(tdesc, BASE_PITCH, i32t.clone());
            let ow = Self::int_value(cr, &offsets[1]);
            let mut ow = Self::cast_index_like(cr, i32t.clone(), ow);
            let oh = Self::int_value(cr, &offsets[0]);
            let oh = Self::cast_index_like(cr, i32t.clone(), oh);
            let base = cr.unary("llvm.inttoptr", base, ptr_ty);
            let mul = |cr: &mut Cr<'_, 'a, '_>, a: ValueId, b: ValueId| cr.mk(OpData::build("arith.muli").operands(&[a, b]), Type::int(32));
            let mut w_bytes = mul(cr, w, size);
            let mut pitch_bytes = mul(cr, pitch, size);
            if w_scale > 1 {
                let log2 = cr.int(i64::from(w_scale.trailing_zeros()), i32t.clone());
                let shr = |cr: &mut Cr<'_, 'a, '_>, a: ValueId| cr.mk(OpData::build("arith.shrsi").operands(&[a, log2]), Type::int(32));
                w_bytes = shr(cr, w_bytes);
                pitch_bytes = shr(cr, pitch_bytes);
                ow = shr(cr, ow);
            }
            let tile_h = td.shape[0];
            let i32a = |v: i64| Attribute::of_int(v.into(), Type::int(32));
            let args = [base, w_bytes, h, pitch_bytes, ow, oh];
            if store {
                let Some(src) = store_src(cr) else { return false };
                let Some(cc) = store_cache(l1, l3) else { return false };
                let mut a = args.to_vec();
                a.push(src);
                cr.rw.create(xevm("xevm.blockstore2d", &a, vec![("elem_size_in_bits", i32a(bits)), ("tile_width", i32a(tile_w)), ("tile_height", i32a(tile_h)), ("cache_control", cc.into())]), &[]);
                cr.erase(op);
                return true;
            }
            let Some(cc) = load_cache(l1, l3) else { return false };
            if prefetch {
                cr.rw.create(xevm("xevm.blockprefetch2d", &args, vec![("elem_size_in_bits", i32a(bits)), ("tile_width", i32a(tile_w)), ("tile_height", i32a(tile_h)), ("v_blocks", i32a(td.array_length)), ("cache_control", cc.into())]), &[]);
                cr.erase(op);
                return true;
            }
            let dst = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
            let Some((_, dst_elem)) = vector_of(&dst) else { return false };
            let dst_elem = dst_elem.clone();
            let vnni = cr.rw.body[op].get("packed").is_some();
            let transpose = cr.rw.body.dense_i64(op, "transpose").first() == Some(&1);
            let loaded = encode(&dst, if vnni { i32t.clone() } else { Type::int(bits as u32) });
            let data = xevm("xevm.blockload2d", &args, vec![("elem_size_in_bits", i32a(bits)), ("tile_width", i32a(tile_w)), ("tile_height", i32a(tile_h)), ("v_blocks", i32a(td.array_length)), ("transpose", Attribute::Bool(transpose)), ("pack_register", Attribute::Bool(vnni)), ("cache_control", cc.into())]);
            let r = cr.mk(data, loaded.clone());
            let r = cr.unary("vector.bitcast", r, encode(&loaded, dst_elem));
            cr.replace(op, vec![vec![r]]);
            return true;
        }
        let offset = Self::int_value(cr, &offsets[0]);
        let offset = Self::cast_index_like(cr, i64t.clone(), offset);
        let size = cr.int(bits / 8, i64t.clone());
        let byte_offset = cr.rw.create_or_fold(OpData::build("arith.muli").operands(&[offset, size]), &[i64t.clone()])[0];
        let byte_offset = Self::cast_index_like(cr, i64t.clone(), byte_offset);
        let addr = cr.rw.create_or_fold(OpData::build("arith.addi").operands(&[tdesc, byte_offset]), &[i64t])[0];
        let ptr = cr.unary("llvm.inttoptr", addr, ptr_ty);
        if store {
            let Some(src) = store_src(cr) else { return false };
            let Some(cc) = store_cache(l1, l3) else { return false };
            cr.rw.create(xevm("xevm.blockstore", &[ptr, src], vec![("cache_control", cc.into())]), &[]);
            cr.erase(op);
            return true;
        }
        if prefetch {
            return false;
        }
        let Some(cc) = load_cache(l1, l3) else { return false };
        let res = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let loaded = encode(&res, Type::int(bits as u32));
        let mut r = cr.mk(xevm("xevm.blockload", &[ptr], vec![("cache_control", cc.into())]), loaded.clone());
        if loaded != res {
            r = cr.unary("vector.bitcast", r, res);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `addOffsetToBaseAddr`: `base + offset * size`.
    fn add_offset(cr: &mut Cr<'_, '_, '_>, base: ValueId, offset: ValueId, size: i64) -> ValueId {
        let ty = cr.rw.body[base].ty.clone();
        let s = cr.int(size, ty.clone());
        let bytes = cr.mk(OpData::build("arith.muli").operands(&[offset, s]), ty.clone());
        cr.mk(OpData::build("arith.addi").operands(&[base, bytes]), ty)
    }

    /// The `scf.if` on `cond` with a then block (and an else block), its results `types`.
    fn scf_if<'a>(cr: &mut Cr<'_, 'a, '_>, cond: ValueId, types: &[Type<'a>], with_else: bool) -> (OpId, crate::BlockId, Option<crate::BlockId>) {
        let mut blocks = (None, None);
        let op = cr.rw.create_with(OpData::build("scf.if").operands(&[cond]), types, |b, o| {
            let then = b.add_region(o);
            let els = b.add_region(o);
            blocks.0 = Some(b.add_block(then, &[]));
            if with_else {
                blocks.1 = Some(b.add_block(els, &[]));
            }
        });
        (op, blocks.0.expect("then block"), blocks.1)
    }

    /// `LoadStoreToXeVMPattern`: a guarded `llvm.load` / `llvm.store`.
    #[convert("xegpu.load", "xegpu.store")]
    fn gather_scatter<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let store = cr.rw.body[op].name == "xegpu.store";
        let ops = cr.rw.body[op].operands.clone();
        // load: source, offsets?, mask; store: value, dest, offsets?, mask.
        let (src_at, n) = (usize::from(store), ops.len());
        if n != src_at + 3 {
            return false;
        }
        let (offset, mask) = (operands[src_at + 1][0], operands[src_at + 2][0]);
        let val_ty = if store {
            cr.rw.body[operands[0][0]].ty.clone()
        } else {
            let r = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
            let Some(t) = cr.converted(&r) else { return false };
            t
        };
        let vec = vector_of(&val_ty).map(|(s, e)| (s, e.clone()));
        let Some(bits) = vec.as_ref().map_or(val_ty.bit_width(), |(_, e)| e.bit_width()) else { return false };
        if bits % 8 != 0 {
            return false;
        }
        let src_ty = cr.rw.body[ops[src_at]].ty.clone();
        let mut space = MemorySpace::Global.xevm();
        if let Some(s) = memref_of(&src_ty)
            && space_int(s) != 0
        {
            space = space_int(s);
        }
        let mut base = operands[src_at][0];
        cr.rw.set_before(op);
        if cr.rw.body[base].ty != Type::int(64) {
            base = cr.unary("arith.extui", base, Type::int(64));
        }
        if vector_of(&cr.rw.body[offset].ty).is_some() || vector_of(&cr.rw.body[mask].ty).is_some() {
            return false;
        }
        let base = Self::add_offset(cr, base, offset, i64::from(bits / 8));
        let ptr = cr.unary("llvm.inttoptr", base, Self::ptr(space));
        let (l1, l3) = (Self::hint(cr, op, "l1_hint"), Self::hint(cr, op, "l3_hint"));
        if store {
            let Some(cc) = store_cache(l1, l3) else { return false };
            let (_, then, _) = Self::scf_if(cr, mask, &[], false);
            let saved = cr.rw.ip;
            cr.rw.set_end(then);
            cr.rw.create(OpData::build("llvm.store").operands(&[operands[0][0], ptr]).with("ordering", Attribute::i64(0)).with("cache_control", cc.into()), &[]);
            cr.rw.create(OpData::build("scf.yield"), &[]);
            cr.rw.ip = saved;
            cr.erase(op);
            return true;
        }
        let Some(cc) = load_cache(l1, l3) else { return false };
        let (iff, then, els) = Self::scf_if(cr, mask, core::slice::from_ref(&val_ty), true);
        let saved = cr.rw.ip;
        cr.rw.set_end(then);
        let load_ty = vec.as_ref().map_or(val_ty.clone(), |(s, e)| vector(s.iter().product(), e.clone()));
        let loaded = cr.mk(OpData::build("llvm.load").operands(&[ptr]).with("ordering", Attribute::i64(0)).with("cache_control", cc.into()), load_ty);
        cr.rw.create(OpData::build("scf.yield").operands(&[loaded]), &[]);
        cr.rw.set_end(els.expect("else block"));
        let e = vec.as_ref().map_or(val_ty.clone(), |(_, e)| e.clone());
        let zero = match &e {
            Type::Float(k) => Scalar::Float(ApFloat::from_f64(*k, 0.0).unwrap_or_else(|| ApFloat::from_f64(FloatKind::F32, 0.0).expect("f32"))),
            t => Scalar::Int(ApInt::new(t.bit_width().unwrap_or(64), 0)),
        };
        let value: Attribute<'a> = if vec.is_some() { Const::splat(zero, val_ty.clone()).into() } else { Const::scalar(zero, val_ty.clone()).into() };
        let z = cr.mk(OpData::build("arith.constant").with("value", value), val_ty);
        cr.rw.create(OpData::build("scf.yield").operands(&[z]), &[]);
        cr.rw.ip = saved;
        let r = cr.rw.body[iff].results[0];
        cr.replace(op, vec![vec![r]]);
        true
    }

    /// `CreateMemDescOpPattern`: the source address itself.
    #[convert("xegpu.create_mem_desc")]
    fn create_mem_desc(cr: &mut Cr<'_, '_, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        cr.replace(op, vec![operands[0].clone()]);
        true
    }

    /// `MemDescType::getLinearOffsets`.
    fn linear_offset(cr: &mut Cr<'_, '_, '_>, md: &MemDesc, offsets: &[Ofr]) -> ValueId {
        let shape = md.shape.clone();
        let block = md.block_shape();
        let mut strides = md.stride_shape();
        let mut offs: Vec<Ofr> = offsets.to_vec();
        let bin = |cr: &mut Cr<'_, '_, '_>, name: &str, a: &Ofr, b: i64| {
            let a = Self::index_value(cr, a);
            let b = cr.int(b, Type::Index);
            Ofr::V(cr.mk(OpData::build(name).operands(&[a, b]), Type::Index))
        };
        if block == shape {
            strides.drain(..shape.len());
        } else {
            let mut divs = Vec::new();
            let mut rems = Vec::new();
            for (o, b) in offsets.iter().zip(&block) {
                divs.push(bin(cr, "arith.divsi", o, *b));
                rems.push(bin(cr, "arith.remsi", o, *b));
            }
            offs = divs.into_iter().chain(rems).collect();
        }
        let mut linear = cr.int(0, Type::Index);
        for (o, s) in offs.iter().zip(strides) {
            let m = bin(cr, "arith.muli", o, s);
            let m = Self::index_value(cr, &m);
            linear = cr.mk(OpData::build("arith.addi").operands(&[m, linear]), Type::Index);
        }
        linear
    }

    /// `xegpu::getChipStr`: the `#xevm.target` of the enclosing `gpu.module`.
    fn chip(cr: &Cr<'_, '_, '_>, op: OpId) -> Option<Chip> {
        let b = &*cr.rw.body;
        let mut at = b.parent_op(op);
        while let Some(o) = at.filter(|o| b[*o].name != "gpu.module") {
            at = b.parent_op(o);
        }
        let Attribute::Array(ts) = b[at?].get("targets")? else { return None };
        ts.iter().find_map(Chip::of_target)
    }

    /// `LoadStoreMatrixToXeVMPattern`.
    #[convert("xegpu.load_matrix", "xegpu.store_matrix")]
    fn matrix<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let load = cr.rw.body[op].name == "xegpu.load_matrix";
        let ops = cr.rw.body[op].operands.clone();
        let md_at = usize::from(!load);
        let offsets = Self::offsets(cr, op, &ops[md_at + 1..]);
        if offsets.is_empty() {
            return false;
        }
        let Ok(md) = MemDesc::try_from(&cr.rw.body[ops[md_at]].ty) else { return false };
        let base = operands[md_at][0];
        let data_ty = if load {
            let r = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
            match vector_of(&r) {
                Some((s, e)) => vector(s.iter().product(), e.clone()),
                None => r,
            }
        } else {
            cr.rw.body[operands[0][0]].ty.clone()
        };
        let (shape, elem) = vector_of(&data_ty).map_or((vec![1], data_ty.clone()), |(s, e)| (s, e.clone()));
        let vec_ty = vector(shape.iter().product(), elem.clone());
        let Some(bits) = elem.bit_width() else { return false };
        if bits % 8 != 0 {
            return false;
        }
        let ptr_ty = Self::ptr(MemorySpace::Slm.xevm());
        cr.rw.set_before(op);
        let linear = Self::linear_offset(cr, &md, &offsets);
        let linear = cr.unary("arith.index_castui", linear, Type::int(32));
        let addr = Self::add_offset(cr, base, linear, i64::from(bits / 8));
        let ptr = cr.unary("llvm.inttoptr", addr, ptr_ty);
        if cr.rw.body[op].get("subgroup_block_io").is_some() {
            let int_ty = Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(shape.iter().map(|&n| Dim::Static(n)).collect()), elem: Type::int(bits).into(), extras: Vec::new() });
            if load {
                let mut r = cr.mk(xevm("xevm.blockload", &[ptr], vec![]), int_ty.clone());
                if int_ty != vec_ty {
                    r = cr.unary("vector.bitcast", r, vec_ty);
                }
                cr.replace(op, vec![vec![r]]);
            } else {
                let mut d = operands[0][0];
                if vec_ty != int_ty {
                    d = cr.unary("vector.bitcast", d, int_ty);
                }
                cr.rw.create(xevm("xevm.blockstore", &[ptr, d], vec![]), &[]);
                cr.erase(op);
            }
            return true;
        }
        if !matches!(Self::chip(cr, op), Some(Chip::Pvc | Chip::Bmg)) {
            return false;
        }
        if load {
            let ty = if shape.iter().product::<i64>() == 1 { elem } else { vec_ty };
            let r = cr.mk(OpData::build("llvm.load").operands(&[ptr]).with("ordering", Attribute::i64(0)), ty);
            cr.replace(op, vec![vec![r]]);
        } else {
            cr.rw.create(OpData::build("llvm.store").operands(&[operands[0][0], ptr]).with("ordering", Attribute::i64(0)), &[]);
            cr.erase(op);
        }
        true
    }

    /// `PrefetchToXeVMPattern`.
    #[convert("xegpu.prefetch")]
    fn prefetch<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>]) -> bool {
        let ops = cr.rw.body[op].operands.clone();
        let src_ty = cr.rw.body[ops[0]].ty.clone();
        let td = TensorDesc::try_from(&src_ty).ok();
        let mut base = operands[0][0];
        cr.rw.set_before(op);
        if cr.rw.body[base].ty != Type::int(64) {
            base = cr.unary("arith.extui", base, Type::int(64));
        }
        if let Some(offset) = operands.get(1).map(|o| o[0]) {
            if vector_of(&cr.rw.body[offset].ty).is_some() {
                return false;
            }
            let bits = match (&td, memref_of(&src_ty)) {
                (Some(t), _) => t.elem.bit_width(),
                (None, Some(s)) => s.elem.bit_width(),
                _ => None,
            };
            let size = match bits {
                Some(b) if b % 8 != 0 => return false,
                Some(b) => i64::from(b / 8),
                None => match cr.rw.body[op].get("offset_align_byte") {
                    Some(Attribute::Int { lit, .. }) => lit.parse().unwrap_or(1),
                    _ => return false,
                },
            };
            base = Self::add_offset(cr, base, offset, size);
        }
        let mut space = td.as_ref().map_or(MemorySpace::Global, |t| t.space).xevm();
        if let Some(s) = memref_of(&src_ty)
            && space_int(s) != 0
        {
            space = space_int(s);
        }
        let ptr = cr.unary("llvm.inttoptr", base, Self::ptr(space));
        let Some(cc) = load_cache(Self::hint(cr, op, "l1_hint"), Self::hint(cr, op, "l3_hint")) else { return false };
        cr.rw.create(xevm("xevm.prefetch", &[ptr], vec![("cache_control", cc.into())]), &[]);
        cr.erase(op);
        true
    }

    /// `FenceToXeVMPattern`.
    #[convert("xegpu.fence")]
    fn fence(cr: &mut Cr<'_, '_, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let Some(scope) = b[op].get("fence_scope").and_then(|a| FenceScope::try_from(a).ok()) else { return false };
        let Some(kind) = b[op].get("memory_kind").and_then(MemorySpace::kind) else { return false };
        let scope = match scope {
            FenceScope::Workgroup => "<workgroup>",
            FenceScope::Gpu => "<device>",
        };
        let space = match kind {
            MemorySpace::Global => "<global>",
            MemorySpace::Slm => "<shared>",
        };
        cr.rw.set_before(op);
        cr.rw.create(xevm("xevm.memfence", &[], vec![("addrspace", Attribute::dialect("xevm.addr_space", space)), ("scope", Attribute::dialect("xevm.mem_scope", scope))]), &[]);
        cr.erase(op);
        true
    }

    /// `encodePrecision` and the operands per dword of each.
    fn precision(t: &Type<'_>) -> Option<(&'static str, i64)> {
        Some(match t {
            Type::Float(FloatKind::BF16) => ("bf16", 2),
            Type::Float(FloatKind::F16) => ("f16", 2),
            Type::Float(FloatKind::TF32) => ("tf32", 1),
            Type::Integer { width: 8, signedness: Signedness::Unsigned } => ("u8", 4),
            Type::Integer { width: 8, .. } => ("s8", 4),
            Type::Float(FloatKind::F32) => ("f32", 0),
            Type::Integer { width: 32, .. } => ("s32", 0),
            _ => return None,
        })
    }

    /// `DpasToXeVMPattern`.
    #[convert("xegpu.dpas")]
    fn dpas<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>]) -> bool {
        let b = &*cr.rw.body;
        let ops = b[op].operands.clone();
        let res = b[b[op].results[0]].ty.clone();
        let (Some((_, ae)), Some((_, be)), Some((_, re))) = (vector_of(&b[ops[0]].ty), vector_of(&b[ops[1]].ty), vector_of(&res)) else { return false };
        let (Some(pa), Some(pb), Some(pd)) = (Self::precision(ae), Self::precision(be), Self::precision(re)) else { return false };
        let re = re.clone();
        cr.rw.set_before(op);
        let c = match ops.get(2) {
            Some(c) => *c,
            None => {
                let zero = match &re {
                    Type::Float(k) => Scalar::Float(ApFloat::from_f64(*k, 0.0).expect("a float")),
                    t => Scalar::Int(ApInt::new(t.bit_width().unwrap_or(32), 0)),
                };
                cr.mk(OpData::build("arith.constant").with("value", Const::splat(zero, res.clone()).into()), res.clone())
            }
        };
        let c_ty = cr.rw.body[c].ty.clone();
        let Some((cs, ce)) = vector_of(&c_ty) else { return false };
        let ce = ce.clone();
        let Some(pc) = Self::precision(&ce) else { return false };
        let n: i64 = cs.iter().product();
        let flat = vector(n, ce);
        let c = if flat != c_ty { cr.unary("vector.shape_cast", c, flat.clone()) } else { c };
        let shape = Attribute::dialect("xevm.mma_shape", &alloc::format!("<m = {n}, n = {EXECUTION_SIZE}, k = {}>", SYSTOLIC_DEPTH * pa.1));
        let types = Attribute::dialect("xevm.mma_types", &alloc::format!("<d = {}, a = {}, b = {}, c = {}>", pd.0, pa.0, pb.0, pc.0));
        let mut r = cr.mk(xevm("xevm.mma", &[ops[0], ops[1], c], vec![("shape", shape), ("types", types)]), flat.clone());
        if flat != c_ty {
            r = cr.unary("vector.shape_cast", r, res);
        }
        cr.replace(op, vec![vec![r]]);
        true
    }
}
