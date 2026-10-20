//! `memref` ⇒ `llvm`, as `MemRefToLLVM.cpp` (and the `ConvertToLLVMPattern` helpers of
//! `LLVMCommon/Pattern.cpp` it leans on).

use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirpass_macros::patterns;
use mlirformat::{Attribute, Dim, Shaped, ShapedKind, StridedLayout, Type};

use crate::{BlockId, ConversionRewriter, LlvmConverter, LlvmOptions, OpData, OpId, ValueId, Visibility};
use mlirformat::llvm_types::LlvmType;

/// The memref ⇒ llvm patterns.
pub struct MemrefToLlvm;

/// `LowerToLLVMOptions` as far as memrefs care.
#[derive(Debug, Clone, Copy)]
pub struct MemrefOptions {
    pub llvm: LlvmOptions,
    /// `use-aligned-alloc`: `aligned_alloc` instead of `malloc`.
    pub aligned_alloc: bool,
    /// `use-generic-functions`: `_mlir_memref_to_llvm_*` instead of the libc names.
    pub generic: bool,
}

/// `kNoWrapFlags`: `inbounds | nuw`.
const NO_WRAP: i64 = 7;
/// `GEPOp::kDynamicIndex`.
const GEP_DYNAMIC: i64 = i32::MIN as i64;

/// One `llvm.getelementptr` index.
#[derive(Clone, Copy)]
pub enum Gep {
    C(i64),
    V(ValueId),
}

pub type Cr<'r, 'a, 'p> = ConversionRewriter<'r, 'a, 'p>;

#[patterns(converter, options = MemrefOptions)]
impl MemrefToLlvm {
    pub fn memref<'t, 'a>(t: &'t Type<'a>) -> Option<&'t Shaped<'a>> {
        match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Some(s),
            _ => None,
        }
    }

    pub fn operand_memref<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, i: usize) -> Option<Shaped<'a>> {
        let v = *cr.rw.body[op].operands.get(i)?;
        Self::memref(&cr.rw.body[v].ty).cloned()
    }

    pub fn result_memref<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<Shaped<'a>> {
        let v = *cr.rw.body[op].results.first()?;
        Self::memref(&cr.rw.body[v].ty).cloned()
    }

    pub fn rank(s: &Shaped<'_>) -> usize {
        s.shape.as_ref().map_or(0, Vec::len)
    }

    /// `MemRefLayoutAttrInterface::isIdentity`: no layout, `strided<[1]>`, or `(d0, ...) -> (d0, ...)`.
    pub fn identity_layout(s: &Shaped<'_>) -> bool {
        s.extras.iter().all(|a| match a {
            Attribute::Builtin { name, .. } if name == "strided" => StridedLayout::try_from(a).is_ok_and(|l| l.is_identity()),
            Attribute::Builtin { name, body, .. } if name == "affine_map" => {
                let Some((dims, results)) = body.trim_start_matches('<').trim_end_matches('>').split_once("->") else { return false };
                let squash = |t: &str| t.chars().filter(|c| !c.is_whitespace()).collect::<String>();
                let dims = squash(dims);
                !dims.contains('[') && dims == squash(results)
            }
            _ => true,
        })
    }

    /// `isConvertibleAndHasIdentityMaps`.
    fn convertible_identity<'a>(cr: &Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>) -> bool {
        Self::identity_layout(s) && cr.type_converter().is_some_and(|tc| tc.convert(&Type::Shaped(s.clone())).is_some()) && opts.address_space(s).is_some()
    }

    pub fn elem<'a>(cr: &Cr<'_, 'a, '_>, t: &Type<'a>) -> Option<Type<'a>> {
        cr.type_converter()?.convert(t)
    }

    fn ptr_in<'a>(opts: LlvmOptions, s: &Shaped<'_>) -> Type<'a> {
        LlvmType::Ptr(opts.address_space(s).unwrap_or(0)).into()
    }

    pub fn const_index<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, v: i64) -> ValueId {
        cr.index_const(&opts.index(), v)
    }

    pub fn arith<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, a: ValueId, b: ValueId) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]), ty)
    }

    fn arith_flags<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, a: ValueId, b: ValueId, flags: i64) -> ValueId {
        let ty = cr.rw.body[a].ty.clone();
        cr.build(OpData::build(name).operands(&[a, b]).with("overflowFlags", Attribute::Int { lit: format!("{flags}").into(), ty: Some(Type::int(32)) }), ty)
    }

    pub fn gep<'a>(cr: &mut Cr<'_, 'a, '_>, res: Type<'a>, elem: Type<'a>, base: ValueId, idx: &[Gep], flags: i64) -> ValueId {
        let mut operands = vec![base];
        let mut raw = Vec::new();
        for i in idx {
            match *i {
                Gep::C(c) => raw.push(c),
                Gep::V(v) => {
                    operands.push(v);
                    raw.push(GEP_DYNAMIC);
                }
            }
        }
        let raw = Attribute::DenseArray { ty: Type::int(32), values: raw.into_iter().map(|r| format!("{r}").into()).collect() };
        let data = OpData::build("llvm.getelementptr").operands(&operands).with("elem_type", Attribute::Type(elem)).with("rawConstantIndices", raw).with("noWrapFlags", Attribute::Int { lit: format!("{flags}").into(), ty: Some(Type::int(32)) });
        cr.build(data, res)
    }

    pub fn load<'a>(cr: &mut Cr<'_, 'a, '_>, ty: Type<'a>, ptr: ValueId) -> ValueId {
        cr.build(OpData::build("llvm.load").operands(&[ptr]), ty)
    }

    pub fn store<'a>(cr: &mut Cr<'_, 'a, '_>, v: ValueId, ptr: ValueId) {
        cr.rw.create(OpData::build("llvm.store").operands(&[v, ptr]), &[]);
    }

    pub fn alloca<'a>(cr: &mut Cr<'_, 'a, '_>, res: Type<'a>, elem: Type<'a>, n: ValueId, align: i64) -> ValueId {
        let mut d = OpData::build("llvm.alloca").operands(&[n]).with("elem_type", Attribute::Type(elem));
        if align != 0 {
            d.set("alignment", Attribute::i64(align));
        }
        cr.build(d, res)
    }

    fn cast<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, v: ValueId, ty: Type<'a>) -> ValueId {
        cr.build(OpData::build(name).operands(&[v]), ty)
    }

    fn memcpy<'a>(cr: &mut Cr<'_, 'a, '_>, dst: ValueId, src: ValueId, len: ValueId) {
        cr.rw.create(OpData::build("llvm.intr.memcpy").operands(&[dst, src, len]).with("isVolatile", Attribute::Bool(false)), &[]);
    }

    /// `getSizeInBytes`: `ptrtoint (gep null[1])`.
    fn size_in_bytes<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, llvm: Type<'a>) -> ValueId {
        let null = cr.build(OpData::build("llvm.mlir.zero"), LlvmType::ptr());
        let g = Self::gep(cr, LlvmType::ptr(), llvm, null, &[Gep::C(1)], 0);
        Self::cast(cr, "llvm.ptrtoint", g, opts.index())
    }

    /// `getMemRefDescriptorSizes`: sizes, row-major strides, and the element count (or byte
    /// size).
    fn desc_sizes<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, dynamic: &[ValueId], bytes: bool) -> Option<(Vec<ValueId>, Vec<ValueId>, ValueId)> {
        let shape = s.dims().unwrap_or_default();
        let mut dynamic = dynamic.iter();
        let mut sizes = Vec::new();
        for &d in &shape {
            sizes.push(if d == Dim::DYNAMIC { *dynamic.next()? } else { Self::const_index(cr, opts, d) });
        }
        let mut stride = 1i64;
        let mut running = Self::const_index(cr, opts, 1);
        let mut strides = vec![running; shape.len()];
        for i in (0..shape.len()).rev() {
            strides[i] = running;
            let use_size = stride == 1;
            if shape[i] == Dim::DYNAMIC {
                stride = Dim::DYNAMIC;
            }
            if stride != Dim::DYNAMIC {
                stride *= shape[i];
            }
            running = if use_size {
                sizes[i]
            } else if stride == Dim::DYNAMIC {
                Self::arith(cr, "llvm.mul", running, sizes[i])
            } else {
                Self::const_index(cr, opts, stride)
            };
        }
        let size = if bytes {
            let elem = Self::elem(cr, &s.elem)?;
            let null = cr.build(OpData::build("llvm.mlir.zero"), LlvmType::ptr());
            let g = Self::gep(cr, LlvmType::ptr(), elem, null, &[Gep::V(running)], 0);
            Self::cast(cr, "llvm.ptrtoint", g, opts.index())
        } else {
            running
        };
        Some((sizes, strides, size))
    }

    /// `createMemRefDescriptor`.
    fn create_desc<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, allocated: ValueId, aligned: ValueId, sizes: &[ValueId], strides: &[ValueId]) -> Option<ValueId> {
        let ty = LlvmConverter::convert_memref(opts, &s.clone())?;
        let mut d = cr.poison(ty);
        d = cr.insert_value(d, allocated, &[0]);
        d = cr.insert_value(d, aligned, &[1]);
        let zero = Self::const_index(cr, opts, 0);
        d = cr.insert_value(d, zero, &[2]);
        for (i, v) in sizes.iter().enumerate() {
            d = cr.insert_value(d, *v, &[3, i as i64]);
        }
        for (i, v) in strides.iter().enumerate() {
            d = cr.insert_value(d, *v, &[4, i as i64]);
        }
        Some(d)
    }

    /// `MemRefDescriptor::bufferPtr`: the aligned pointer moved by the offset.
    pub fn buffer_ptr<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, desc: ValueId) -> Option<ValueId> {
        let (_, offset) = opts.strides_and_offset(s)?;
        let ptr = cr.extract(desc, &[1]);
        if offset == 0 {
            return Some(ptr);
        }
        let off = if offset == Dim::DYNAMIC { cr.extract(desc, &[2]) } else { Self::const_index(cr, opts, offset) };
        let elem = Self::elem(cr, &s.elem)?;
        let ty = cr.rw.body[ptr].ty.clone();
        Some(Self::gep(cr, ty, elem, ptr, &[Gep::V(off)], 0))
    }

    /// `getStridedElementPtr`.
    pub fn strided_ptr<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, desc: ValueId, indices: &[ValueId], flags: i64) -> Option<ValueId> {
        let (strides, _) = opts.strides_and_offset(s)?;
        let base = Self::buffer_ptr(cr, opts, s, desc)?;
        let overflow = i64::from(flags & 2 != 0) | (i64::from(flags & 4 != 0) << 1);
        let mut index: Option<ValueId> = None;
        for (i, &idx) in indices.iter().enumerate() {
            let mut inc = idx;
            if strides[i] != 1 {
                let st = if strides[i] == Dim::DYNAMIC { cr.extract(desc, &[4, i as i64]) } else { Self::const_index(cr, opts, strides[i]) };
                inc = Self::arith_flags(cr, "llvm.mul", inc, st, overflow);
            }
            index = Some(match index {
                Some(acc) => Self::arith_flags(cr, "llvm.add", acc, inc, overflow),
                None => inc,
            });
        }
        let Some(index) = index else { return Some(base) };
        let elem = Self::elem(cr, &s.elem)?;
        let ptr_ty = Self::ptr_in(opts, s);
        Some(Self::gep(cr, ptr_ty, elem, base, &[Gep::V(index)], flags))
    }

    /// `computeSize` of an unranked descriptor `desc`.
    fn unranked_size<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, desc: ValueId) -> ValueId {
        let one = Self::const_index(cr, opts, 1);
        let two = Self::const_index(cr, opts, 2);
        let index_size = Self::const_index(cr, opts, i64::from(opts.index_bitwidth.div_ceil(8)));
        let ptr_size = Self::const_index(cr, opts, 8);
        let double_ptr = Self::arith(cr, "llvm.mul", two, ptr_size);
        let rank = cr.extract(desc, &[0]);
        let double_rank = Self::arith(cr, "llvm.mul", two, rank);
        let inc = Self::arith(cr, "llvm.add", double_rank, one);
        let rank_size = Self::arith(cr, "llvm.mul", inc, index_size);
        Self::arith(cr, "llvm.add", double_ptr, rank_size)
    }

    /// `UnrankedMemRefDescriptor::alignedPtr` / `offsetBasePtr` / `offset`: fields of the
    /// ranked descriptor behind `ptr`.
    fn unranked_field<'a>(cr: &mut Cr<'_, 'a, '_>, elem_ptr: Type<'a>, ptr: ValueId, field: i64) -> ValueId {
        Self::gep(cr, LlvmType::ptr(), elem_ptr, ptr, &[Gep::C(field)], 0)
    }

    /// `UnrankedMemRefDescriptor::sizeBasePtr`.
    fn size_base<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, elem_ptr: Type<'a>, ptr: ValueId) -> ValueId {
        let st = LlvmType::literal(vec![elem_ptr.clone(), elem_ptr, opts.index(), opts.index()]);
        Self::gep(cr, LlvmType::ptr(), st, ptr, &[Gep::C(0), Gep::C(3)], 0)
    }

    /// `promoteOneMemRefDescriptor`.
    fn promote<'a>(cr: &mut Cr<'_, 'a, '_>, desc: ValueId) -> ValueId {
        let one = cr.index_const(&Type::int(64), 1);
        let ty = cr.rw.body[desc].ty.clone();
        let p = Self::alloca(cr, LlvmType::ptr(), ty, one, 0);
        Self::store(cr, desc, p);
        p
    }

    fn stack_save<'a>(cr: &mut Cr<'_, 'a, '_>) -> ValueId {
        cr.build(OpData::build("llvm.intr.stacksave"), LlvmType::ptr())
    }

    fn stack_restore<'a>(cr: &mut Cr<'_, 'a, '_>, p: ValueId) {
        cr.rw.create(OpData::build("llvm.intr.stackrestore").operands(&[p]), &[]);
    }

    /// The `llvm.func` of a runtime function, declared in the enclosing module when missing.
    fn runtime<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, name: &str, params: Vec<Type<'a>>, ret: Type<'a>) -> Option<()> {
        let m = cr.module_of(op)?;
        cr.llvm_func(m, name, params, ret, false).map(|_| ())
    }

    fn call1<'a>(cr: &mut Cr<'_, 'a, '_>, name: &str, args: &[ValueId], ret: Type<'a>) -> ValueId {
        let c = cr.llvm_call(name, args, &[ret]);
        cr.rw.body[c].results[0]
    }

    /// The integer an operand is known to be: an `arith.constant` or `llvm.mlir.constant`.
    fn known_int<'a>(cr: &Cr<'_, 'a, '_>, v: ValueId) -> Option<i64> {
        let d = cr.rw.body.def_op(v)?;
        if !matches!(&*cr.rw.body[d].name, "arith.constant" | "llvm.mlir.constant") {
            return None;
        }
        Self::int(cr.rw.body[d].get("value")?)
    }

    pub fn int(a: &Attribute<'_>) -> Option<i64> {
        match a {
            Attribute::Int { lit, .. } => lit.parse().ok(),
            Attribute::Bool(b) => Some(i64::from(*b)),
            _ => None,
        }
    }

    // ---- patterns ----------------------------------------------------------------------

    /// `createAligned`: `bumped - bumped % alignment` with `bumped = input + alignment - 1`.
    fn aligned<'a>(cr: &mut Cr<'_, 'a, '_>, input: ValueId, alignment: ValueId) -> ValueId {
        let ty = cr.rw.body[alignment].ty.clone();
        let one = cr.llvm_constant(Attribute::Int { lit: "1".into(), ty: Some(Type::Index) }, ty);
        let bump = Self::arith(cr, "llvm.sub", alignment, one);
        let bumped = Self::arith(cr, "llvm.add", input, bump);
        let m = Self::arith(cr, "llvm.urem", bumped, alignment);
        Self::arith(cr, "llvm.sub", bumped, m)
    }

    /// `castAllocFuncResult`.
    fn cast_alloc<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, p: ValueId) -> ValueId {
        match opts.address_space(s) {
            Some(0) | None => p,
            Some(n) => Self::cast(cr, "llvm.addrspacecast", p, LlvmType::Ptr(n).into()),
        }
    }

    /// `getMemRefEltSizeInBytes` under the default data layout.
    fn type_size(opts: LlvmOptions, t: &Type<'_>) -> Option<u64> {
        Some(match t {
            Type::Index => u64::from(opts.index_bitwidth.div_ceil(8)),
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => match &s.shape {
                Some(sh) => 16 + u64::from(opts.index_bitwidth.div_ceil(8)) * (1 + 2 * sh.len() as u64),
                None => 8 + u64::from(opts.index_bitwidth.div_ceil(8)),
            },
            Type::Shaped(s) if s.kind == ShapedKind::Vector => {
                let n: i64 = s.shape.iter().flatten().map(|d| if let Dim::Static(n) | Dim::Scalable(n) = d { *n } else { 1 }).product();
                (n as u64 * Self::type_size(opts, &s.elem)? * 8).next_power_of_two() / 8
            }
            t => u64::from(t.bit_width()?.div_ceil(8)),
        })
    }

    #[lowering("memref.alloc")]
    fn alloc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(s) = Self::result_memref(cr, op) else { return false };
        if !Self::convertible_identity(cr, opts, &s) {
            return false;
        }
        let idx = opts.index();
        let dynamic: Vec<ValueId> = operands.iter().flatten().copied().collect();
        let ptr = LlvmType::ptr();
        if o.aligned_alloc {
            let name = if o.generic { "_mlir_memref_to_llvm_aligned_alloc" } else { "aligned_alloc" };
            if Self::runtime(cr, op, name, vec![idx.clone(), idx.clone()], ptr.clone()).is_none() {
                return false;
            }
            let Some((sizes, strides, mut bytes)) = Self::desc_sizes(cr, opts, &s, &dynamic, true) else { return false };
            let elt = match Self::type_size(opts, &s.elem) {
                Some(e) => e,
                None => return false,
            };
            let alignment = match cr.rw.body[op].get("alignment").and_then(Self::int) {
                Some(a) => a,
                None => 16.max(elt.next_power_of_two() as i64),
            };
            let align = Self::const_index(cr, opts, alignment);
            let divisor: u64 = s.dims().unwrap_or_default().iter().filter(|d| **d != Dim::DYNAMIC).fold(elt, |a, d| a * *d as u64);
            if divisor % alignment as u64 != 0 {
                bytes = Self::aligned(cr, bytes, align);
            }
            let p = Self::call1(cr, name, &[align, bytes], ptr);
            let p = Self::cast_alloc(cr, opts, &s, p);
            let Some(d) = Self::create_desc(cr, opts, &s, p, p, &sizes, &strides) else { return false };
            cr.replace(op, vec![vec![d]]);
            return true;
        }
        let name = if o.generic { "_mlir_memref_to_llvm_alloc" } else { "malloc" };
        if Self::runtime(cr, op, name, vec![idx.clone()], ptr.clone()).is_none() {
            return false;
        }
        let Some((sizes, strides, mut bytes)) = Self::desc_sizes(cr, opts, &s, &dynamic, true) else { return false };
        let scalar = matches!(&*s.elem, Type::Index | Type::Float(_)) || s.elem.int_width().is_some_and(|(_, sg)| sg == mlirformat::Signedness::Signless);
        let alignment = match cr.rw.body[op].get("alignment").and_then(Self::int) {
            Some(a) => Some(Self::const_index(cr, opts, a)),
            None if !scalar => {
                let Some(e) = Self::elem(cr, &s.elem) else { return false };
                Some(Self::size_in_bytes(cr, opts, e))
            }
            None => None,
        };
        if let Some(a) = alignment {
            bytes = Self::arith(cr, "llvm.add", bytes, a);
        }
        let p = Self::call1(cr, name, &[bytes], ptr);
        let allocated = Self::cast_alloc(cr, opts, &s, p);
        let mut aligned = allocated;
        if let Some(a) = alignment {
            let int = Self::cast(cr, "llvm.ptrtoint", allocated, idx);
            let al = Self::aligned(cr, int, a);
            aligned = Self::cast(cr, "llvm.inttoptr", al, Self::ptr_in(opts, &s));
        }
        let Some(d) = Self::create_desc(cr, opts, &s, allocated, aligned, &sizes, &strides) else { return false };
        cr.replace(op, vec![vec![d]]);
        true
    }

    #[lowering("memref.alloca")]
    fn alloca_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(s) = Self::result_memref(cr, op) else { return false };
        if !Self::convertible_identity(cr, opts, &s) {
            return false;
        }
        let dynamic: Vec<ValueId> = operands.iter().flatten().copied().collect();
        let Some((sizes, strides, size)) = Self::desc_sizes(cr, opts, &s, &dynamic, false) else { return false };
        let Some(elem) = Self::elem(cr, &s.elem) else { return false };
        let align = cr.rw.body[op].get("alignment").and_then(Self::int).unwrap_or(0);
        let p = Self::alloca(cr, Self::ptr_in(opts, &s), elem, size, align);
        let Some(d) = Self::create_desc(cr, opts, &s, p, p, &sizes, &strides) else { return false };
        cr.replace(op, vec![vec![d]]);
        true
    }

    /// A block with arguments of `types` placed right before `before`.
    fn block_before<'a>(cr: &mut Cr<'_, 'a, '_>, before: BlockId, types: &[Type<'a>], loc: Option<mlirformat::Str<'a>>) -> BlockId {
        let region = cr.rw.body[before].parent.expect("in region");
        let args: Vec<_> = types.iter().map(|t| (t.clone(), loc.clone())).collect();
        let b = cr.rw.body.add_block(region, &args);
        cr.rw.body.remove_block(b);
        let pos = cr.rw.body[region].blocks.iter().position(|x| *x == before).expect("in region");
        cr.rw.body.region_insert(region, pos, b);
        cr.rw.set_end(b);
        b
    }

    #[lowering("memref.alloca_scope")]
    fn alloca_scope<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], _: MemrefOptions) -> bool {
        let loc = cr.rw.body[op].loc.clone();
        let current = cr.rw.body[op].parent.expect("placed");
        let at = cr.rw.ip.and_then(|ip| ip.before).unwrap_or(op);
        let remaining = cr.rw.split_block(current, at);
        let types = cr.rw.body.types(&cr.rw.body[op].results.clone());
        let cont = if types.is_empty() {
            remaining
        } else {
            let b = Self::block_before(cr, remaining, &types, loc.clone());
            cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.br").successors(&[remaining]) }, &[]);
            b
        };
        let body = cr.rw.body[op].regions[0];
        let (Some(&first), Some(&last)) = (cr.rw.body[body].blocks.first(), cr.rw.body[body].blocks.last()) else { return false };
        let region = cr.rw.body[current].parent.expect("in region");
        cr.inline_region(body, region, Some(cont));
        cr.rw.set_end(current);
        let saved = Self::stack_save(cr);
        cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.br").successors(&[first]) }, &[]);
        let Some(&ret) = cr.rw.body[last].ops.last() else { return false };
        let values = cr.rw.body[ret].operands.clone();
        let br = cr.replace_new(ret, OpData { loc, ..OpData::build("llvm.br").operands(&values).successors(&[cont]) }, &[]);
        cr.rw.set_before(br);
        Self::stack_restore(cr, saved);
        let args = cr.rw.body[cont].args.clone();
        cr.replace_values(op, &args);
        true
    }

    #[lowering("memref.assume_alignment")]
    fn assume_alignment<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let desc = operands[0][0];
        let align = cr.rw.body[op].get("alignment").and_then(Self::int).unwrap_or(0);
        let Some(ptr) = Self::strided_ptr(cr, opts, &s, desc, &[], 0) else { return false };
        let t = cr.llvm_constant(Attribute::Bool(true), Type::int(1));
        let a = Self::const_index(cr, opts, align);
        Self::assume(cr, &[t, ptr, a], "align");
        cr.replace(op, vec![vec![desc]]);
        true
    }

    fn assume<'a>(cr: &mut Cr<'_, 'a, '_>, operands: &[ValueId], tag: &str) {
        let tags = Attribute::Array(vec![Attribute::str(tag)]);
        let sizes = Attribute::DenseArray { ty: Type::int(32), values: vec!["2".into()] };
        cr.rw.create(OpData::build("llvm.intr.assume").operands(operands).with("op_bundle_sizes", sizes).with("op_bundle_tags", tags), &[]);
    }

    #[lowering("memref.distinct_objects")]
    fn distinct_objects<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let flat: Vec<ValueId> = operands.iter().flatten().copied().collect();
        if flat.len() > 1 {
            let mut ptrs = Vec::new();
            for (i, d) in flat.iter().enumerate() {
                let Some(s) = Self::operand_memref(cr, op, i) else { return false };
                let Some(p) = Self::buffer_ptr(cr, o.llvm, &s, *d) else { return false };
                ptrs.push(p);
            }
            let cond = cr.llvm_constant(Attribute::Bool(true), Type::int(1));
            for i in 0..ptrs.len() - 1 {
                for j in i + 1..ptrs.len() {
                    Self::assume(cr, &[cond, ptrs[i], ptrs[j]], "separate_storage");
                }
            }
        }
        cr.replace(op, flat.into_iter().map(|v| vec![v]).collect());
        true
    }

    #[lowering("memref.dealloc")]
    fn dealloc<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let name = if o.generic { "_mlir_memref_to_llvm_free" } else { "free" };
        if Self::runtime(cr, op, name, vec![LlvmType::ptr()], LlvmType::void()).is_none() {
            return false;
        }
        let v = cr.rw.body[op].operands[0];
        let ty = cr.rw.body[v].ty.clone();
        let Some(s) = Self::memref(&ty) else { return false };
        let allocated = if s.shape.is_none() {
            let p = cr.extract(operands[0][0], &[1]);
            Self::load(cr, Self::ptr_in(o.llvm, s), p)
        } else {
            cr.extract(operands[0][0], &[0])
        };
        let call = OpData::build("llvm.call").operands(&[allocated]).with("callee", Attribute::SymbolRef(vec![String::from(name).into()])).segments(&[1, 0]);
        cr.replace_new(op, call, &[]);
        true
    }

    #[lowering("memref.dim")]
    fn dim<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let (desc, index) = (operands[0][0], operands[1][0]);
        let idx = opts.index();
        if s.shape.is_none() {
            let Some(space) = opts.address_space(&s) else { return false };
            let scalar = Type::Shaped(Shaped { kind: ShapedKind::MemRef, shape: Some(Vec::new()), elem: s.elem.clone(), extras: Vec::new() });
            let Some(elem) = Self::elem(cr, &scalar) else { return false };
            let ranked = cr.extract(desc, &[1]);
            let ptr: Type = LlvmType::Ptr(space).into();
            let offset = Self::gep(cr, ptr.clone(), elem, ranked, &[Gep::C(0), Gep::C(2)], 0);
            let one = Self::const_index(cr, opts, 1);
            let plus = Self::arith(cr, "llvm.add", one, index);
            let size = Self::gep(cr, ptr, idx.clone(), offset, &[Gep::V(plus)], 0);
            let v = Self::load(cr, idx, size);
            cr.replace(op, vec![vec![v]]);
            return true;
        }
        let dims = s.dims().unwrap_or_default();
        let original = cr.rw.body[op].operands[1];
        let known = Self::known_int(cr, original).or_else(|| Self::known_int(cr, index));
        let v = match known {
            Some(i) if i >= 0 && (i as usize) < dims.len() => {
                if dims[i as usize] == Dim::DYNAMIC {
                    cr.extract(desc, &[3, i])
                } else {
                    Self::const_index(cr, opts, dims[i as usize])
                }
            }
            _ => {
                let arr = LlvmType::array(dims.len() as u64, idx.clone());
                let one = Self::const_index(cr, opts, 1);
                let sizes = cr.extract(desc, &[3]);
                let p = Self::alloca(cr, LlvmType::ptr(), arr.clone(), one, 0);
                Self::store(cr, sizes, p);
                let g = Self::gep(cr, LlvmType::ptr(), arr, p, &[Gep::C(0), Gep::V(index)], 0);
                Self::load(cr, idx, g)
            }
        };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[lowering("memref.generic_atomic_rmw")]
    fn generic_atomic_rmw<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let loc = cr.rw.body[op].loc.clone();
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let res_ty = cr.rw.body[cr.rw.body[op].results[0]].ty.clone();
        let Some(value_ty) = Self::elem(cr, &res_ty) else { return false };
        // The yielded value must come from the region.
        let body = cr.rw.body[op].regions[0];
        let entry = cr.rw.body[body].blocks[0];
        let Some(&term) = cr.rw.body[entry].ops.last() else { return false };
        let yielded = cr.rw.body[term].operands[0];
        let inside = match cr.rw.body[yielded].def {
            crate::Def::Arg(b, _) => b == entry,
            crate::Def::Result(o, _) => cr.rw.body[o].parent == Some(entry),
        };
        if !inside {
            return false;
        }
        let init_block = cr.rw.body[op].parent.expect("placed");
        let loop_block = cr.rw.split_block(init_block, op);
        let arg = cr.rw.body.add_arg(loop_block, value_ty.clone());
        cr.rw.body[arg].loc = loc.clone();
        let next = Self::next_op(cr, op);
        let end = match next {
            Some(n) => cr.rw.split_block(loop_block, n),
            None => return false,
        };
        cr.rw.set_end(init_block);
        let indices: Vec<ValueId> = operands[1..].iter().flatten().copied().collect();
        let Some(ptr) = Self::strided_ptr(cr, opts, &s, operands[0][0], &indices, 0) else { return false };
        let Some(elem) = Self::elem(cr, &s.elem) else { return false };
        let init = Self::load(cr, elem, ptr);
        cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.br").operands(&[init]).successors(&[loop_block]) }, &[]);
        cr.rw.set_start(loop_block);
        let mut map = crate::Mapping::default();
        map.map(cr.rw.body[entry].args[0], arg);
        let ops = cr.rw.body[entry].ops.clone();
        let Some((&term, inner)) = ops.split_last() else { return false };
        for &o in inner {
            cr.rw.clone(o, &mut map);
        }
        let result = map.get(cr.rw.body[term].operands[0]);
        let pair = LlvmType::literal(vec![value_ty.clone(), Type::int(1)]);
        let cmpxchg = cr.build(OpData::build("llvm.cmpxchg").operands(&[ptr, arg, result]).with("success_ordering", Attribute::i64(6)).with("failure_ordering", Attribute::i64(2)), pair);
        let new_loaded = cr.extract(cmpxchg, &[0]);
        let ok = cr.extract(cmpxchg, &[1]);
        cr.rw.create(OpData { loc, ..OpData::build("llvm.cond_br").operands(&[ok, new_loaded]).successors(&[end, loop_block]).segments(&[1, 0, 1]) }, &[]);
        cr.rw.set_start(end);
        cr.replace(op, vec![vec![new_loaded]]);
        true
    }

    /// `convertGlobalMemrefTypeToLLVM`: nested arrays, outermost dimension first.
    fn global_type<'a>(cr: &Cr<'_, 'a, '_>, s: &Shaped<'a>) -> Option<Type<'a>> {
        let mut t = Self::elem(cr, &s.elem)?;
        for d in s.dims().unwrap_or_default().iter().rev() {
            t = LlvmType::array(*d as u64, t);
        }
        Some(t)
    }

    #[lowering("memref.global")]
    fn global<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(Attribute::Type(Type::Shaped(s))) = cr.rw.body[op].get("type").cloned() else { return false };
        if !Self::convertible_identity(cr, opts, &s) {
            return false;
        }
        let Some(arr) = Self::global_type(cr, &s) else { return false };
        let Some(space) = opts.address_space(&s) else { return false };
        let b = &cr.rw.body;
        let public = b.visibility(op) == Visibility::Public;
        let init = b[op].get("initial_value").cloned();
        let uninitialized = init == Some(Attribute::Unit);
        let mut data = OpData::build("llvm.mlir.global").with("global_type", Attribute::Type(arr.clone())).with("linkage", Attribute::dialect("llvm.linkage", if public { "<external>" } else { "<private>" })).with("sym_name", b[op].get("sym_name").cloned().unwrap_or(Attribute::Unit)).with("addr_space", Attribute::Int { lit: format!("{space}").into(), ty: Some(Type::int(32)) });
        if b[op].get("constant").is_some() {
            data.set("constant", Attribute::Unit);
        }
        if let Some(a) = b[op].get("alignment").and_then(Self::int).filter(|a| *a != 0) {
            data.set("alignment", Attribute::i64(a));
        }
        if let Some(v) = init.filter(|_| !uninitialized) {
            let v = match crate::Const::try_from(&v).ok().and_then(|c| c.splat_value()) {
                Some(x) if Self::rank(&s) == 0 => Attribute::from(crate::Const::scalar(x, (*s.elem).clone())),
                _ => v,
            };
            data.set("value", v);
        }
        data.loc = b[op].loc.clone();
        let loc = data.loc.clone();
        cr.rw.set_before(op);
        let g = cr.rw.create_with(data, &[], |b, g| {
            b.add_region(g);
        });
        if uninitialized {
            let r = cr.rw.body[g].regions[0];
            cr.rw.create_block(r, &[]);
            let u = cr.build(OpData { loc: loc.clone(), ..OpData::build("llvm.mlir.undef") }, arr);
            cr.rw.create(OpData { loc, ..OpData::build("llvm.return").operands(&[u]) }, &[]);
        }
        cr.erase(op);
        true
    }

    #[lowering("memref.get_global")]
    fn get_global<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, _: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(s) = Self::result_memref(cr, op) else { return false };
        if !Self::convertible_identity(cr, opts, &s) {
            return false;
        }
        let Some((sizes, strides, _)) = Self::desc_sizes(cr, opts, &s, &[], true) else { return false };
        let Some(space) = opts.address_space(&s) else { return false };
        let Some(arr) = Self::global_type(cr, &s) else { return false };
        let ptr: Type = LlvmType::Ptr(space).into();
        let Some(name) = cr.rw.body[op].get("name").cloned() else { return false };
        let addr = cr.build(OpData::build("llvm.mlir.addressof").with("global_name", name), ptr.clone());
        let zeros = vec![Gep::C(0); Self::rank(&s) + 1];
        let gep = Self::gep(cr, ptr.clone(), arr, addr, &zeros, 0);
        let int_ptr = Type::int(64);
        let beef = cr.index_const(&int_ptr, 0xdeadbeef);
        let dead = Self::cast(cr, "llvm.inttoptr", beef, ptr);
        let Some(d) = Self::create_desc(cr, opts, &s, dead, gep, &sizes, &strides) else { return false };
        cr.replace(op, vec![vec![d]]);
        true
    }

    #[lowering("memref.load")]
    fn load_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let indices: Vec<ValueId> = operands[1..].iter().flatten().copied().collect();
        let Some(ptr) = Self::strided_ptr(cr, o.llvm, &s, operands[0][0], &indices, NO_WRAP) else { return false };
        let Some(elem) = Self::elem(cr, &s.elem) else { return false };
        let data = Self::access(cr, op, OpData::build("llvm.load").operands(&[ptr]));
        cr.replace_new(op, data, &[elem]);
        true
    }

    #[lowering("memref.store")]
    fn store_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(s) = Self::operand_memref(cr, op, 1) else { return false };
        let indices: Vec<ValueId> = operands[2..].iter().flatten().copied().collect();
        let Some(ptr) = Self::strided_ptr(cr, o.llvm, &s, operands[1][0], &indices, NO_WRAP) else { return false };
        let data = Self::access(cr, op, OpData::build("llvm.store").operands(&[operands[0][0], ptr]));
        cr.replace_new(op, data, &[]);
        true
    }

    /// The `alignment` and `nontemporal` of a memref access, for its llvm counterpart.
    fn access<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, mut d: OpData<'a>) -> OpData<'a> {
        if let Some(a) = cr.rw.body[op].get("alignment").and_then(Self::int).filter(|a| *a != 0) {
            d.set("alignment", Attribute::i64(a));
        }
        if matches!(cr.rw.body[op].get("nontemporal"), Some(Attribute::Bool(true))) {
            d.set("nontemporal", Attribute::Unit);
        }
        d
    }

    #[lowering("memref.prefetch")]
    fn prefetch<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let indices: Vec<ValueId> = operands[1..].iter().flatten().copied().collect();
        let Some(ptr) = Self::strided_ptr(cr, o.llvm, &s, operands[0][0], &indices, 0) else { return false };
        let b = &cr.rw.body[op];
        let flag = |n: &str| Attribute::Int { lit: if matches!(b.get(n), Some(Attribute::Bool(true))) { "1" } else { "0" }.into(), ty: Some(Type::int(32)) };
        let (rw, cache) = (flag("isWrite"), flag("isDataCache"));
        let hint = b.get("localityHint").cloned().unwrap_or(Attribute::Unit);
        let data = OpData::build("llvm.intr.prefetch").operands(&[ptr]).with("rw", rw).with("hint", hint).with("cache", cache);
        cr.replace_new(op, data, &[]);
        true
    }

    #[lowering("memref.rank")]
    fn rank_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let v = match s.shape {
            None => cr.extract(operands[0][0], &[0]),
            Some(sh) => Self::const_index(cr, o.llvm, sh.len() as i64),
        };
        cr.replace(op, vec![vec![v]]);
        true
    }

    #[lowering("memref.cast")]
    fn cast_op<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::result_memref(cr, op)) else { return false };
        let conv = |s: &Shaped<'a>| LlvmConverter::convert_memref(opts, s);
        let desc = operands[0][0];
        match (src.shape.is_some(), dst.shape.is_some()) {
            (true, true) => {
                if conv(&src) != conv(&dst) {
                    return false;
                }
                cr.replace(op, vec![vec![desc]]);
            }
            (false, false) => return false,
            (true, false) => {
                let Some(target) = conv(&dst) else { return false };
                let ptr = Self::promote(cr, desc);
                let rank = Self::const_index(cr, opts, Self::rank(&src) as i64);
                let mut d = cr.poison(target);
                d = cr.insert_value(d, rank, &[0]);
                d = cr.insert_value(d, ptr, &[1]);
                cr.replace(op, vec![vec![d]]);
            }
            (false, true) => {
                let Some(target) = conv(&dst) else { return false };
                let ptr = cr.extract(desc, &[1]);
                let l = Self::load(cr, target, ptr);
                cr.replace(op, vec![vec![l]]);
            }
        }
        true
    }

    /// `isStaticShapeAndContiguousRowMajor`.
    pub fn contiguous(opts: LlvmOptions, s: &Shaped<'_>) -> bool {
        let dims = s.dims().unwrap_or_default();
        if s.shape.is_none() || dims.contains(&Dim::DYNAMIC) {
            return false;
        }
        let Some((strides, _)) = opts.strides_and_offset(s) else { return false };
        let mut running = 1;
        let mut cur = dims.len() as i64 - 1;
        while cur >= 0 && strides[cur as usize] == running {
            running *= dims[cur as usize];
            cur -= 1;
        }
        while cur >= 0 && dims[cur as usize] == 1 {
            cur -= 1;
        }
        cur < 0
    }

    #[lowering("memref.copy")]
    fn copy<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::operand_memref(cr, op, 1)) else { return false };
        let contiguous = |s: &Shaped<'a>| s.shape.is_some() && (Self::identity_layout(s) || (!s.dims().unwrap_or_default().contains(&Dim::DYNAMIC) && s.dims().unwrap_or_default().iter().product::<i64>() > 0 && Self::contiguous(opts, s)));
        let (sd, td) = (operands[0][0], operands[1][0]);
        if contiguous(&src) && contiguous(&dst) {
            let mut n = Self::const_index(cr, opts, 1);
            for i in 0..Self::rank(&src) {
                let size = cr.extract(sd, &[3, i as i64]);
                n = Self::arith(cr, "llvm.mul", n, size);
            }
            let Some(elem) = Self::elem(cr, &src.elem) else { return false };
            let bytes = Self::size_in_bytes(cr, opts, elem.clone());
            let total = Self::arith(cr, "llvm.mul", n, bytes);
            let ptr_of = |cr: &mut Cr<'_, 'a, '_>, d: ValueId| {
                let base = cr.extract(d, &[1]);
                let off = cr.extract(d, &[2]);
                let ty = cr.rw.body[base].ty.clone();
                Self::gep(cr, ty, elem.clone(), base, &[Gep::V(off)], 0)
            };
            let sp = ptr_of(cr, sd);
            let tp = ptr_of(cr, td);
            Self::memcpy(cr, tp, sp, total);
            cr.erase(op);
            return true;
        }
        let saved = Self::stack_save(cr);
        let unranked = |cr: &mut Cr<'_, 'a, '_>, s: &Shaped<'a>, d: ValueId| -> Option<ValueId> {
            if s.shape.is_none() {
                return Some(d);
            }
            let rank = cr.llvm_constant(Attribute::Int { lit: format!("{}", Self::rank(s)).into(), ty: Some(opts.index()) }, opts.index());
            let p = Self::promote(cr, d);
            let ty = LlvmConverter::convert_memref(opts, &Shaped { shape: None, extras: s.extras.iter().filter(|a| !a.is_layout()).cloned().collect(), ..s.clone() })?;
            Some(cr.rw.pack_unranked(ty, &[rank, p]))
        };
        let (Some(us), Some(ut)) = (unranked(cr, &src, sd), unranked(cr, &dst, td)) else { return false };
        let one = Self::const_index(cr, opts, 1);
        let promote = |cr: &mut Cr<'_, 'a, '_>, d: ValueId| {
            let ty = cr.rw.body[d].ty.clone();
            let p = Self::alloca(cr, LlvmType::ptr(), ty, one, 0);
            Self::store(cr, d, p);
            p
        };
        let sp = promote(cr, us);
        let tp = promote(cr, ut);
        let Some(elem) = Self::elem(cr, &src.elem) else { return false };
        let size = Self::size_in_bytes(cr, opts, elem);
        if Self::runtime(cr, op, "memrefCopy", vec![opts.index(), LlvmType::ptr(), LlvmType::ptr()], LlvmType::void()).is_none() {
            return false;
        }
        cr.llvm_call("memrefCopy", &[size, sp, tp], &[]);
        Self::stack_restore(cr, saved);
        cr.erase(op);
        true
    }

    #[lowering("memref.memory_space_cast")]
    fn memory_space_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::result_memref(cr, op)) else { return false };
        let desc = operands[0][0];
        if dst.shape.is_some() {
            let Some(ty) = LlvmConverter::convert_memref(opts, &dst) else { return false };
            let new_ptr = Self::ptr_in(opts, &dst);
            let rank = Self::rank(&dst);
            let mut vals = cr.unpack_desc(desc, rank);
            vals[0] = Self::cast(cr, "llvm.addrspacecast", vals[0], new_ptr.clone());
            vals[1] = Self::cast(cr, "llvm.addrspacecast", vals[1], new_ptr);
            let d = cr.pack_desc(ty, rank, &vals);
            cr.replace(op, vec![vec![d]]);
            return true;
        }
        let (Some(_), Some(_)) = (opts.address_space(&src), opts.address_space(&dst)) else { return false };
        let Some(ty) = LlvmConverter::convert_memref(opts, &dst) else { return false };
        let rank = cr.extract(desc, &[0]);
        let src_desc = cr.extract(desc, &[1]);
        let mut result = cr.poison(ty);
        result = cr.insert_value(result, rank, &[0]);
        let size = Self::unranked_size(cr, opts, result);
        let mem = Self::alloca(cr, LlvmType::ptr(), Type::int(8), size, 0);
        result = cr.insert_value(result, mem, &[1]);
        let (sp, dp) = (Self::ptr_in(opts, &src), Self::ptr_in(opts, &dst));
        let allocated = Self::load(cr, sp.clone(), src_desc);
        let aligned_at = Self::unranked_field(cr, sp.clone(), src_desc, 1);
        let aligned = Self::load(cr, sp.clone(), aligned_at);
        let allocated = Self::cast(cr, "llvm.addrspacecast", allocated, dp.clone());
        let aligned = Self::cast(cr, "llvm.addrspacecast", aligned, dp.clone());
        Self::store(cr, allocated, mem);
        let at = Self::unranked_field(cr, dp.clone(), mem, 1);
        Self::store(cr, aligned, at);
        let src_idx = Self::unranked_field(cr, sp, src_desc, 2);
        let dst_idx = Self::unranked_field(cr, dp, mem, 2);
        let skip = Self::const_index(cr, opts, 16);
        let len = Self::arith(cr, "llvm.sub", size, skip);
        Self::memcpy(cr, dst_idx, src_idx, len);
        cr.replace(op, vec![vec![result]]);
        true
    }

    /// `extractPointersAndOffset`.
    fn pointers<'a>(cr: &mut Cr<'_, 'a, '_>, opts: LlvmOptions, s: &Shaped<'a>, desc: ValueId, offset: bool) -> (ValueId, ValueId, Option<ValueId>) {
        if s.shape.is_some() {
            let a = cr.extract(desc, &[0]);
            let b = cr.extract(desc, &[1]);
            let o = offset.then(|| cr.extract(desc, &[2]));
            return (a, b, o);
        }
        let ep = Self::ptr_in(opts, s);
        let p = cr.extract(desc, &[1]);
        let a = Self::load(cr, ep.clone(), p);
        let g = Self::unranked_field(cr, ep.clone(), p, 1);
        let b = Self::load(cr, ep.clone(), g);
        let o = offset.then(|| {
            let g = Self::unranked_field(cr, ep, p, 2);
            Self::load(cr, opts.index(), g)
        });
        (a, b, o)
    }

    fn static_list<'a>(cr: &Cr<'_, 'a, '_>, op: OpId, name: &str) -> Vec<i64> {
        match cr.rw.body[op].get(name) {
            Some(Attribute::DenseArray { values, .. }) => values.iter().map(|v| v.parse().unwrap_or(0)).collect(),
            _ => Vec::new(),
        }
    }

    #[lowering("memref.reinterpret_cast")]
    fn reinterpret_cast<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::result_memref(cr, op)) else { return false };
        let Some(ty) = LlvmConverter::convert_memref(opts, &dst) else { return false };
        let segs = cr.rw.body.segments(op, "operandSegmentSizes").unwrap_or_default();
        let group = |k: usize| -> Vec<ValueId> {
            let start: usize = segs[..k].iter().sum();
            operands[start..start + segs[k]].iter().flatten().copied().collect()
        };
        let (offs, sizes, strides) = (group(1), group(2), group(3));
        let mut d = cr.poison(ty);
        let (a, b, _) = Self::pointers(cr, opts, &src, operands[0][0], false);
        d = cr.insert_value(d, a, &[0]);
        d = cr.insert_value(d, b, &[1]);
        let so = Self::static_list(cr, op, "static_offsets");
        let off = if so.first() == Some(&Dim::DYNAMIC) { offs[0] } else { Self::const_index(cr, opts, so.first().copied().unwrap_or(0)) };
        d = cr.insert_value(d, off, &[2]);
        let (ss, st) = (Self::static_list(cr, op, "static_sizes"), Self::static_list(cr, op, "static_strides"));
        let (mut ds, mut dt) = (sizes.into_iter(), strides.into_iter());
        for i in 0..Self::rank(&dst) {
            let v = if ss[i] == Dim::DYNAMIC { ds.next().unwrap_or(off) } else { Self::const_index(cr, opts, ss[i]) };
            d = cr.insert_value(d, v, &[3, i as i64]);
            let v = if st[i] == Dim::DYNAMIC { dt.next().unwrap_or(off) } else { Self::const_index(cr, opts, st[i]) };
            d = cr.insert_value(d, v, &[4, i as i64]);
        }
        cr.replace(op, vec![vec![d]]);
        true
    }

    #[lowering("memref.reshape")]
    fn reshape<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(shape), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::operand_memref(cr, op, 1), Self::result_memref(cr, op)) else { return false };
        let (sd, shd) = (operands[0][0], operands[1][0]);
        let idx = opts.index();
        if !shape.dims().unwrap_or_default().contains(&Dim::DYNAMIC) && shape.shape.is_some() {
            let Some(ty) = LlvmConverter::convert_memref(opts, &dst) else { return false };
            let mut d = cr.poison(ty);
            let (a, b, _) = Self::pointers(cr, opts, &src, sd, false);
            d = cr.insert_value(d, a, &[0]);
            d = cr.insert_value(d, b, &[1]);
            let Some((strides, offset)) = opts.strides_and_offset(&dst) else { return false };
            if offset == Dim::DYNAMIC {
                return false;
            }
            let off = Self::const_index(cr, opts, offset);
            d = cr.insert_value(d, off, &[2]);
            let dims = dst.dims().unwrap_or_default();
            let mut stride: Option<ValueId> = None;
            for i in (0..dims.len()).rev() {
                if strides[i] != Dim::DYNAMIC {
                    stride = Some(Self::const_index(cr, opts, strides[i]));
                } else if stride.is_none() {
                    stride = Some(Self::const_index(cr, opts, 1));
                }
                let size = if dims[i] != Dim::DYNAMIC {
                    Self::const_index(cr, opts, dims[i])
                } else {
                    // A `memref.load %shape[i]`, legalized in turn, cast to the index type.
                    let index = Self::const_index(cr, opts, i as i64);
                    let original = cr.rw.body[op].operands[1];
                    let elem = (*shape.elem).clone();
                    let l = cr.build(OpData::build("memref.load").operands(&[original, index]), elem.clone());
                    if elem == idx { l } else { Self::cast(cr, "builtin.unrealized_conversion_cast", l, idx.clone()) }
                };
                let st = stride.expect("set above");
                d = cr.insert_value(d, size, &[3, i as i64]);
                d = cr.insert_value(d, st, &[4, i as i64]);
                stride = Some(Self::arith(cr, "llvm.mul", st, size));
            }
            cr.replace(op, vec![vec![d]]);
            return true;
        }
        // A shape of unknown length: the strides are computed in a loop.
        let loc = cr.rw.body[op].loc.clone();
        let rank = cr.extract(shd, &[3, 0]);
        let Some(ty) = LlvmConverter::convert_memref(opts, &dst) else { return false };
        let mut target = cr.poison(ty);
        target = cr.insert_value(target, rank, &[0]);
        let size = Self::unranked_size(cr, opts, target);
        let under = Self::alloca(cr, LlvmType::ptr(), Type::int(8), size, 0);
        target = cr.insert_value(target, under, &[1]);
        let (a, b, off) = Self::pointers(cr, opts, &src, sd, true);
        let ep = Self::ptr_in(opts, &dst);
        Self::store(cr, a, under);
        let g = Self::unranked_field(cr, ep.clone(), under, 1);
        Self::store(cr, b, g);
        let g = Self::unranked_field(cr, ep.clone(), under, 2);
        Self::store(cr, off.expect("asked for"), g);
        let sizes_base = Self::size_base(cr, opts, ep, under);
        let strides_base = Self::gep(cr, LlvmType::ptr(), idx.clone(), sizes_base, &[Gep::V(rank)], 0);
        let shape_ptr = cr.extract(shd, &[1]);
        let one = Self::const_index(cr, opts, 1);
        let rank_m1 = Self::arith(cr, "llvm.sub", rank, one);
        let init = cr.rw.ip.map(|ip| ip.block).expect("insertion point");
        let rest_at = cr.rw.ip.and_then(|ip| ip.before);
        let region = cr.rw.body[init].parent.expect("in region");
        let cond = cr.rw.create_block(region, &[idx.clone(), idx.clone()]);
        for a in cr.rw.body[cond].args.clone() {
            cr.rw.body[a].loc = loc.clone();
        }
        if let Some(at) = rest_at {
            let remaining = cr.rw.split_block(init, at);
            cr.rw.merge_blocks(remaining, cond, &[]);
        }
        cr.rw.set_end(init);
        cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.br").operands(&[rank_m1, one]).successors(&[cond]) }, &[]);
        cr.rw.set_start(cond);
        let (index_arg, stride_arg) = (cr.rw.body[cond].args[0], cr.rw.body[cond].args[1]);
        let zero = Self::const_index(cr, opts, 0);
        let pred = cr.build(OpData::build("llvm.icmp").operands(&[index_arg, zero]).with("predicate", Attribute::i64(5)), Type::int(1));
        let Some(after_pred) = cr.rw.ip.and_then(|ip| ip.before) else { return false };
        let body = cr.rw.split_block(cond, after_pred);
        cr.rw.set_start(body);
        let Some(shape_elem) = Self::elem(cr, &shape.elem) else { return false };
        let g = Self::gep(cr, LlvmType::ptr(), shape_elem, shape_ptr, &[Gep::V(index_arg)], 0);
        let sz = Self::load(cr, idx.clone(), g);
        let g = Self::gep(cr, LlvmType::ptr(), idx.clone(), sizes_base, &[Gep::V(index_arg)], 0);
        Self::store(cr, sz, g);
        let g = Self::gep(cr, LlvmType::ptr(), idx.clone(), strides_base, &[Gep::V(index_arg)], 0);
        Self::store(cr, stride_arg, g);
        let next = Self::arith(cr, "llvm.mul", stride_arg, sz);
        let dec = Self::arith(cr, "llvm.sub", index_arg, one);
        let br = cr.rw.create(OpData { loc: loc.clone(), ..OpData::build("llvm.br").operands(&[dec, next]).successors(&[cond]) }, &[]);
        let remainder = match Self::next_op(cr, br) {
            Some(n) => cr.rw.split_block(body, n),
            None => {
                let r = Self::block_after(cr, body);
                r
            }
        };
        cr.rw.set_end(cond);
        cr.rw.create(OpData { loc, ..OpData::build("llvm.cond_br").operands(&[pred]).successors(&[body, remainder]).segments(&[1, 0, 0]) }, &[]);
        cr.rw.set_start(remainder);
        cr.replace(op, vec![vec![target]]);
        true
    }

    /// The op after `op` in its block.
    fn next_op<'a>(cr: &Cr<'_, 'a, '_>, op: OpId) -> Option<OpId> {
        let b = cr.rw.body[op].parent?;
        cr.rw.body[b].ops.get(cr.rw.body.position(op) + 1).copied()
    }

    /// An empty block right after `block`.
    fn block_after<'a>(cr: &mut Cr<'_, 'a, '_>, block: BlockId) -> BlockId {
        let region = cr.rw.body[block].parent.expect("in region");
        let b = cr.rw.body.add_block(region, &[]);
        cr.rw.body.remove_block(b);
        let pos = cr.rw.body[region].blocks.iter().position(|x| *x == block).expect("in region");
        cr.rw.body.region_insert(region, pos + 1, b);
        b
    }

    #[lowering("memref.transpose")]
    fn transpose<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let Some(src) = Self::operand_memref(cr, op, 0) else { return false };
        let Some(Attribute::Builtin { body: perm, .. }) = cr.rw.body[op].get("permutation").cloned() else { return false };
        let Some((_, results)) = perm.split_once("->") else { return false };
        let results: Vec<usize> = results.trim().trim_end_matches('>').trim().trim_matches(|c| c == '(' || c == ')').split(',').filter_map(|d| d.trim().strip_prefix('d')?.parse().ok()).collect();
        let desc = operands[0][0];
        if results.iter().enumerate().all(|(i, d)| i == *d) {
            cr.replace(op, vec![vec![desc]]);
            return true;
        }
        let Some(ty) = LlvmConverter::convert_memref(opts, &src) else { return false };
        let mut t = cr.poison(ty);
        let a = cr.extract(desc, &[0]);
        t = cr.insert_value(t, a, &[0]);
        let b = cr.extract(desc, &[1]);
        t = cr.insert_value(t, b, &[1]);
        let off = cr.extract(desc, &[2]);
        t = cr.insert_value(t, off, &[2]);
        for (target, source) in results.into_iter().enumerate() {
            let s = cr.extract(desc, &[3, source as i64]);
            t = cr.insert_value(t, s, &[3, target as i64]);
            let s = cr.extract(desc, &[4, source as i64]);
            t = cr.insert_value(t, s, &[4, target as i64]);
        }
        cr.replace(op, vec![vec![t]]);
        true
    }

    #[lowering("memref.view")]
    fn view<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let (Some(src), Some(dst)) = (Self::operand_memref(cr, op, 0), Self::result_memref(cr, op)) else { return false };
        let (Some(_), Some(ty)) = (Self::elem(cr, &dst.elem), LlvmConverter::convert_memref(opts, &dst)) else { return false };
        let Some((strides, offset)) = opts.strides_and_offset(&dst) else { return false };
        if strides.last().is_some_and(|s| *s != 1 && *s != 0) {
            return false;
        }
        let desc = operands[0][0];
        let shift = operands[1][0];
        let dynamic: Vec<ValueId> = operands[2..].iter().flatten().copied().collect();
        let mut t = cr.poison(ty);
        let a = cr.extract(desc, &[0]);
        t = cr.insert_value(t, a, &[0]);
        let b = cr.extract(desc, &[1]);
        let Some(src_elem) = Self::elem(cr, &src.elem) else { return false };
        let bty = cr.rw.body[b].ty.clone();
        let b = Self::gep(cr, bty, src_elem, b, &[Gep::V(shift)], 0);
        t = cr.insert_value(t, b, &[1]);
        let off = Self::const_index(cr, opts, offset);
        t = cr.insert_value(t, off, &[2]);
        let dims = dst.dims().unwrap_or_default();
        let (mut stride, mut next): (Option<ValueId>, Option<ValueId>) = (None, None);
        for i in (0..dims.len()).rev() {
            let size = if dims[i] != Dim::DYNAMIC { Self::const_index(cr, opts, dims[i]) } else { dynamic[dims[..i].iter().filter(|d| **d == Dim::DYNAMIC).count()] };
            t = cr.insert_value(t, size, &[3, i as i64]);
            let st = if strides[i] != Dim::DYNAMIC {
                Self::const_index(cr, opts, strides[i])
            } else if let Some(n) = next {
                match stride {
                    Some(r) => Self::arith(cr, "llvm.mul", r, n),
                    None => n,
                }
            } else {
                Self::const_index(cr, opts, 1)
            };
            stride = Some(st);
            t = cr.insert_value(t, st, &[4, i as i64]);
            next = Some(size);
        }
        cr.replace(op, vec![vec![t]]);
        true
    }

    /// `matchSimpleAtomicOp`: `arith::AtomicRMWKind` ⇒ `LLVM::AtomicBinOp`.
    fn atomic_bin_op(kind: i64) -> Option<i64> {
        Some(match kind {
            0 => 11,  // addf ⇒ fadd
            1 => 1,   // addi ⇒ add
            2 => 3,   // andi ⇒ _and
            3 => 0,   // assign ⇒ xchg
            4 => 19,  // maximumf ⇒ fmaximum
            5 => 13,  // maxnumf ⇒ fmax
            6 => 7,   // maxs ⇒ max
            7 => 9,   // maxu ⇒ umax
            8 => 20,  // minimumf ⇒ fminimum
            9 => 14,  // minnumf ⇒ fmin
            10 => 8,  // mins ⇒ min
            11 => 10, // minu ⇒ umin
            14 => 5,  // ori ⇒ _or
            15 => 6,  // xori ⇒ _xor
            _ => return None,
        })
    }

    #[lowering("memref.atomic_rmw")]
    fn atomic_rmw<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(kind) = cr.rw.body[op].get("kind").and_then(Self::int).and_then(Self::atomic_bin_op) else { return false };
        let Some(s) = Self::operand_memref(cr, op, 1) else { return false };
        if o.llvm.strides_and_offset(&s).is_none() {
            return false;
        }
        let indices: Vec<ValueId> = operands[2..].iter().flatten().copied().collect();
        let Some(ptr) = Self::strided_ptr(cr, o.llvm, &s, operands[1][0], &indices, 0) else { return false };
        let ty = cr.rw.body[operands[0][0]].ty.clone();
        let data = OpData::build("llvm.atomicrmw").operands(&[ptr, operands[0][0]]).with("bin_op", Attribute::i64(kind)).with("ordering", Attribute::i64(6));
        cr.replace_new(op, data, &[ty]);
        true
    }

    #[lowering("memref.extract_aligned_pointer_as_index")]
    fn extract_aligned_pointer<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let Some(s) = Self::operand_memref(cr, op, 0) else { return false };
        let desc = operands[0][0];
        let aligned = if s.shape.is_some() {
            cr.extract(desc, &[1])
        } else {
            let ep = Self::ptr_in(o.llvm, &s);
            let p = cr.extract(desc, &[1]);
            let g = Self::unranked_field(cr, ep.clone(), p, 1);
            Self::load(cr, ep, g)
        };
        cr.replace_new(op, OpData::build("llvm.ptrtoint").operands(&[aligned]), &[o.llvm.index()]);
        true
    }

    #[lowering("memref.extract_strided_metadata")]
    fn extract_strided_metadata<'a>(cr: &mut Cr<'_, 'a, '_>, op: OpId, operands: &[Vec<ValueId>], o: MemrefOptions) -> bool {
        let opts = o.llvm;
        let desc = operands[0][0];
        if !LlvmType::compatible(&cr.rw.body[desc].ty) {
            return false;
        }
        let Some(src) = Self::operand_memref(cr, op, 0) else { return false };
        let base_v = cr.rw.body[op].results[0];
        let Some(base) = Self::memref(&cr.rw.body[base_v].ty).cloned() else { return false };
        let rank = Self::rank(&src);
        let allocated = cr.extract(desc, &[0]);
        let aligned = cr.extract(desc, &[1]);
        let Some(bty) = LlvmConverter::convert_memref(opts, &base) else { return false };
        let Some(d) = cr.rw.desc_from_static(opts, &base, bty, allocated, aligned) else { return false };
        let mut results = vec![vec![d]];
        results.push(vec![cr.extract(desc, &[2])]);
        for i in 0..rank as i64 {
            results.push(vec![cr.extract(desc, &[3, i])]);
        }
        for i in 0..rank as i64 {
            results.push(vec![cr.extract(desc, &[4, i])]);
        }
        cr.replace(op, results);
        true
    }

    #[lowering("memref.collapse_shape", "memref.expand_shape", "memref.subview")]
    fn fail<'a>(_: &mut Cr<'_, 'a, '_>, _: OpId, _: &[Vec<ValueId>], _: MemrefOptions) -> bool {
        false
    }

}
