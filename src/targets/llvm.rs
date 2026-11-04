//! The `LLVMTypeConverter` and its options; the LLVM types themselves are mlirformat's
//! [`LlvmType`].

mod interfaces;
mod libcall;
mod memref_desc;
mod pattern;
mod signature;

pub use interfaces::{LlvmEnv, ToLlvmInterfaces};
pub use libcall::{file_line_col, LibFns};
pub use signature::LlvmSignature;

use alloc::borrow::Cow;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::llvm_types::LlvmType;
use mlirformat::{Attribute, Dim, FloatKind, NamedAttr, Shaped, ShapedKind, Signedness, Type};

use crate::{Action, ConversionRewriter, ConversionTarget, MemrefLayout, OpData, OpId, TypeConverter, ValueId};

/// `LowerToLLVMOptions`.
#[derive(Debug, Clone, Copy)]
pub struct LlvmOptions {
    pub index_bitwidth: u32,
    pub bare_ptr: bool,
    /// `populateGpuMemorySpaceAttributeConversions`: `#gpu.address_space`s as these.
    pub gpu_spaces: Option<GpuSpaces>,
}

impl Default for LlvmOptions {
    fn default() -> Self {
        Self { index_bitwidth: 64, bare_ptr: false, gpu_spaces: None }
    }
}

/// `gpu::AddressSpace` (`#gpu.address_space<..>`).
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum GpuAddressSpace {
    Global,
    Workgroup,
    Private,
}

impl GpuAddressSpace {
    const NAMES: [(&'static str, Self); 3] = [("global", Self::Global), ("workgroup", Self::Workgroup), ("private", Self::Private)];
}

impl TryFrom<&Attribute<'_>> for GpuAddressSpace {
    type Error = ();
    fn try_from(a: &Attribute<'_>) -> Result<Self, ()> {
        let Attribute::Extended { ext, .. } = a else { return Err(()) };
        let body = ext.body.as_deref().filter(|_| ext.name == "gpu.address_space").ok_or(())?;
        let body = body.strip_prefix('<').and_then(|b| b.strip_suffix('>')).ok_or(())?.trim();
        Self::NAMES.iter().find(|(n, _)| *n == body).map(|(_, v)| *v).ok_or(())
    }
}

/// `LLVM::cconv::CConv`, the calling conventions lowerings pick.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum CConv {
    C,
    SpirFunc,
    SpirKernel,
    AmdgpuKernel,
    PtxKernel,
}

impl CConv {
    pub const fn name(self) -> &'static str {
        match self {
            CConv::C => "ccc",
            CConv::SpirFunc => "spir_funccc",
            CConv::SpirKernel => "spir_kernelcc",
            CConv::AmdgpuKernel => "amdgpu_kernelcc",
            CConv::PtxKernel => "ptx_kernelcc",
        }
    }
}

impl From<CConv> for Attribute<'static> {
    fn from(c: CConv) -> Self {
        Attribute::dialect("llvm.cconv", &format!("<{}>", c.name()))
    }
}

/// The LLVM address space of each `gpu::AddressSpace`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct GpuSpaces {
    pub global: u32,
    pub workgroup: u32,
    pub private: u32,
}

impl GpuSpaces {
    /// `gpuAddressSpaceToOCLAddressSpace`: CrossWorkgroup, Workgroup, Function in OpenCL.
    pub const OPENCL: Self = Self { global: 1, workgroup: 3, private: 0 };

    pub fn of(self, s: GpuAddressSpace) -> u32 {
        match s {
            GpuAddressSpace::Global => self.global,
            GpuAddressSpace::Workgroup => self.workgroup,
            GpuAddressSpace::Private => self.private,
        }
    }
}

impl LlvmOptions {
    /// The `index-bitwidth` pass option alone (0: from the data layout).
    pub fn bitwidth(index_bitwidth: u32) -> Self {
        Self { index_bitwidth, ..Self::default() }
    }

    /// Index bitwidth 0: taken from the data layout (`kDeriveIndexBitwidthFromDataLayout`).
    pub fn derived() -> Self {
        Self { index_bitwidth: 0, ..Self::default() }
    }

    /// Resolves a derived index bitwidth from the `dlti.dl_spec` at or above `op`
    /// (`DataLayoutAnalysis::getAtOrAbove`); 64 without one.
    pub fn at(self, body: &crate::Body<'_>, op: crate::OpId) -> Self {
        if self.index_bitwidth != 0 {
            return self;
        }
        Self { index_bitwidth: crate::DataLayout::index_bitwidth(body, op), ..self }
    }

    pub fn index(&self) -> Type<'static> {
        Type::int(self.index_bitwidth)
    }

    /// The address space of a memref (`None` when it cannot be expressed).
    pub fn address_space(&self, s: &Shaped<'_>) -> Option<u32> {
        // The memory space is the last extra that is not a layout.
        let space = s.extras.iter().find(|a| !a.is_layout());
        match space {
            None => Some(0),
            // `getMemRefAddressSpace`: a signless or index integer.
            Some(Attribute::Int { lit, ty: None | Some(Type::Index | Type::Integer { signedness: Signedness::Signless, .. }) }) => lit.parse().ok(),
            Some(a) => Some(self.gpu_spaces?.of(GpuAddressSpace::try_from(a).ok()?)),
        }
    }

    /// `isStrided`: an identity, `strided<...>` or linear `affine_map` layout.
    pub fn strided(&self, s: &Shaped<'_>) -> bool {
        s.extras.iter().all(|a| !matches!(a, Attribute::Builtin { name, .. } if name == "affine_map")) || s.strides_and_offset().is_some()
    }

    /// `getMemRefDescriptorFields`.
    pub fn descriptor_fields<'a>(&self, s: &Shaped<'a>, elem_ok: bool, unpack: bool) -> Option<Vec<Type<'a>>> {
        if !self.strided(s) || !elem_ok {
            return None;
        }
        let ptr: Type<'a> = LlvmType::Ptr(self.address_space(s)?).into();
        let idx = self.index();
        let mut out = vec![ptr.clone(), ptr, idx.clone()];
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        if rank > 0 {
            if unpack {
                out.extend(core::iter::repeat_n(idx, 2 * rank));
            } else {
                out.extend(core::iter::repeat_n(LlvmType::array(rank as u64, idx), 2));
            }
        }
        Some(out)
    }
}

/// The `LLVMTypeConverter`'s rules, registered in the same order.
pub struct LlvmConverter;

impl LlvmConverter {
    /// The type converter for `options`, with the unrealized-cast materializations.
    pub fn build<'c>(options: LlvmOptions) -> TypeConverter<'c> {
        let mut tc = TypeConverter::default();
        tc.conversion(move |t| match t {
            Type::Complex(e) => {
                let e = Self::scalar(e, options)?;
                Some(Some(vec![LlvmType::literal(vec![e.clone(), e])]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Float(k) => Some(Self::float(*k).map(|t| vec![t])),
            _ => None,
        });
        tc.conversion(|t| matches!(t, Type::Function(_)).then(|| Some(vec![LlvmType::ptr()])));
        tc.conversion(move |t| matches!(t, Type::Index).then(|| Some(vec![options.index()])));
        tc.conversion(|t| match t {
            Type::Integer { width, .. } => Some(Some(vec![Type::int(*width)])),
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => {
                let ok = Self::scalar(&s.elem, options).is_some();
                Some(options.descriptor_fields(s, ok, false).map(|f| vec![LlvmType::literal(f)]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_none() => {
                Some(Self::scalar(&s.elem, options).map(|_| vec![LlvmType::literal(vec![options.index(), LlvmType::ptr()])]))
            }
            _ => None,
        });
        tc.conversion(move |t| match t {
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Some(Self::vector(s, options).map(|t| vec![t])),
            _ => None,
        });
        tc.conversion(|t| LlvmType::compatible(t).then(|| Some(vec![t.clone()])));
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Struct { name: None, packed, body: Some(b), .. } if !LlvmType::compatible(t) => {
                let body = b.iter().map(|e| Self::scalar(e, options)).collect::<Option<Vec<_>>>();
                Some(body.map(|b| vec![LlvmType::Struct { name: None, packed, body: Some(b), opaque: false }.into()]))
            }
            _ => None,
        });
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Array(n, e) => Some(Self::scalar(&e, options).map(|e| vec![LlvmType::array(n, e)])),
            _ => None,
        });
        tc.conversion(move |t| match LlvmType::try_from(t).ok()? {
            LlvmType::Func { ret, params, vararg } => {
                let r = Self::scalar(&ret, options);
                let ps = params.iter().map(|p| Self::scalar(p, options)).collect::<Option<Vec<_>>>();
                Some(r.zip(ps).map(|(r, ps)| vec![LlvmType::Func { ret: r.into(), params: ps, vararg }.into()]))
            }
            _ => None,
        });
        tc.source(|rw, ty, inputs| Some(Self::cast(rw, ty, inputs)));
        tc.target(|rw, tys, inputs, _| (tys.len() == 1).then(|| vec![Self::cast(rw, &tys[0], inputs)]));
        // Memrefs from their unpacked fields (or a bare pointer): the descriptor, then a cast.
        tc.source(move |rw, ty, inputs| match ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_none() => {
                let packed = Self::pack_unranked(rw, options, inputs)?;
                Some(Self::cast(rw, ty, &[packed]))
            }
            _ => None,
        });
        tc.source(move |rw, ty, inputs| match ty {
            Type::Shaped(s) if s.kind == ShapedKind::MemRef && s.shape.is_some() => {
                let packed = Self::pack_ranked(rw, options, s, inputs)?;
                Some(Self::cast(rw, ty, &[packed]))
            }
            _ => None,
        });
        tc.target(move |rw, tys, inputs, original| {
            let original = original?;
            let [ty] = tys else { return None };
            let Type::Shaped(s) = original else { return None };
            if s.kind != ShapedKind::MemRef || Self::convert_memref(options, s).as_ref() != Some(ty) {
                return None;
            }
            let packed = if s.shape.is_some() { Self::pack_ranked(rw, options, s, inputs)? } else { Self::pack_unranked(rw, options, inputs)? };
            Some(vec![packed])
        });
        tc
    }

    /// The descriptor struct a memref type converts to.
    pub fn convert_memref<'a>(options: LlvmOptions, s: &Shaped<'a>) -> Option<Type<'a>> {
        if s.shape.is_none() {
            return Self::scalar(&s.elem, options).map(|_| LlvmType::literal(vec![options.index(), LlvmType::ptr()]));
        }
        let ok = Self::scalar(&s.elem, options).is_some();
        options.descriptor_fields(s, ok, false).map(LlvmType::literal)
    }

    /// `packRankedMemRefDesc`: from a bare pointer (static shape) or the unpacked fields.
    fn pack_ranked<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, options: LlvmOptions, s: &Shaped<'a>, inputs: &[crate::ValueId]) -> Option<crate::ValueId> {
        let desc = Self::convert_memref(options, s)?;
        let input_types = rw.body.types(inputs);
        if let [p] = inputs
            && matches!(LlvmType::try_from(&rw.body[*p].ty), Ok(LlvmType::Ptr(_)))
        {
            return rw.desc_from_static(options, s, desc, *p, *p);
        }
        let ok = Self::scalar(&s.elem, options).is_some();
        if Some(input_types) != options.descriptor_fields(s, ok, true) {
            return None;
        }
        let rank = s.shape.as_ref().map_or(0, Vec::len);
        Some(rw.pack_desc(desc, rank, inputs))
    }

    /// `packUnrankedMemRefDesc`.
    fn pack_unranked<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, options: LlvmOptions, inputs: &[crate::ValueId]) -> Option<crate::ValueId> {
        if rw.body.types(inputs) != vec![options.index(), LlvmType::ptr()] {
            return None;
        }
        Some(rw.pack_unranked(LlvmType::literal(vec![options.index(), LlvmType::ptr()]), inputs))
    }

    fn cast<'a, L: crate::Listener<'a> + ?Sized>(rw: &mut crate::Rewriter<'_, 'a, L>, ty: &Type<'a>, inputs: &[crate::ValueId]) -> crate::ValueId {
        let c = rw.create(crate::OpData::named("builtin.unrealized_conversion_cast").operands(inputs), core::slice::from_ref(ty));
        rw.body[c].results[0]
    }

    /// The converted type of a scalar the rules nest (element types and the like).
    fn scalar<'a>(t: &Type<'a>, options: LlvmOptions) -> Option<Type<'a>> {
        match t {
            Type::Index => Some(options.index()),
            Type::Integer { width, .. } => Some(Type::int(*width)),
            Type::Float(k) => Self::float(*k),
            t if LlvmType::compatible(t) => Some(t.clone()),
            Type::Shaped(s) if s.kind == ShapedKind::Vector => Self::vector(s, options),
            Type::Shaped(s) if s.kind == ShapedKind::MemRef => Self::convert_memref(options, s),
            _ => None,
        }
    }

    /// `convertFloatType`: compatible floats stay; 8-, 6- and 4-bit ones become integers.
    fn float<'a>(k: FloatKind) -> Option<Type<'a>> {
        match k {
            FloatKind::BF16 | FloatKind::F16 | FloatKind::F32 | FloatKind::F64 | FloatKind::F80 | FloatKind::F128 => Some(Type::Float(k)),
            FloatKind::TF32 => None,
            k => Type::Float(k).bit_width().map(Type::int),
        }
    }

    /// `convertVectorType`: 0-d to 1-element, n-d to nested arrays of 1-d vectors.
    fn vector<'a>(s: &Shaped<'a>, options: LlvmOptions) -> Option<Type<'a>> {
        let elem = Self::scalar(&s.elem, options)?;
        let shape = s.shape.as_ref()?;
        let vec1 = |d: Dim| Type::Shaped(Shaped { kind: ShapedKind::Vector, shape: Some(vec![d]), elem: elem.clone().into(), extras: Vec::new() });
        let Some(last) = shape.last() else { return Some(vec1(Dim::Static(1))) };
        if shape[..shape.len() - 1].iter().any(|d| matches!(d, Dim::Scalable(_))) {
            return None;
        }
        let mut t = vec1(last.clone());
        for d in shape[..shape.len() - 1].iter().rev() {
            let Dim::Static(n) = d else { return None };
            t = LlvmType::array(*n as u64, t);
        }
        Some(t)
    }
}

// ---- what lowering to the llvm dialect shares ----------------------------------------------

/// Fast-math flags, by name, in LLVM's bit order.
const LLVM_FASTMATH: [&str; 7] = ["nnan", "ninf", "nsz", "arcp", "contract", "afn", "reassoc"];

/// `#arith.fastmath<...>` ⇒ `#llvm.fastmath<...>` (`convertArithFastMathAttrToLLVM`).
pub fn llvm_fastmath<'a>(arith: Option<&Attribute<'_>>) -> Attribute<'a> {
    let names: Vec<&str> = match arith {
        Some(Attribute::Extended { ext, .. }) => {
            let body = ext.body.as_deref().unwrap_or("<none>");
            body.trim_start_matches('<').trim_end_matches('>').split(',').map(str::trim).collect()
        }
        _ => Vec::new(),
    };
    let all = names.contains(&"fast");
    let set: Vec<&str> = LLVM_FASTMATH.iter().copied().filter(|f| all || names.contains(f)).collect();
    let body = match set.len() {
        0 => String::from("<none>"),
        7 => String::from("<fast>"),
        _ => format!("<{}>", set.join(", ")),
    };
    Attribute::dialect("llvm.fastmath", &body)
}

/// `#arith.overflow<...>` ⇒ the LLVM `overflowFlags` property (`nsw` = 1, `nuw` = 2).
pub fn llvm_overflow<'a>(arith: Option<&Attribute<'_>>) -> Attribute<'a> {
    let body = match arith {
        Some(Attribute::Extended { ext, .. }) => ext.body.as_deref().unwrap_or(""),
        _ => "",
    };
    let v = i64::from(body.contains("nsw")) | (i64::from(body.contains("nuw")) << 1);
    Attribute::Int { lit: Cow::Owned(format!("{v}")), ty: Some(Type::int(32)) }
}

/// `LLVMConversionTarget`: the llvm dialect and unrealized casts are legal.
pub fn llvm_target<'c>() -> ConversionTarget<'c> {
    let mut t = ConversionTarget::default();
    t.legal_dialect("llvm").op("builtin.unrealized_conversion_cast", Action::Legal);
    t
}


impl<'a> crate::ConversionRewriter<'_, 'a, '_> {
    /// `llvm.extractvalue` of `agg` at `pos`.
    pub fn extract(&mut self, agg: ValueId, pos: &[i64]) -> ValueId {
        let mut ty = self.rw.body[agg].ty.clone();
        for p in pos {
            ty = match LlvmType::try_from(&ty) {
                Ok(LlvmType::Array(_, e)) => *e,
                Ok(LlvmType::Struct { body: Some(b), .. }) => b[*p as usize].clone(),
                _ => ty,
            };
        }
        self.build(OpData::build("llvm.extractvalue").operands(&[agg]).with("position", Attribute::dense_i64(pos)), ty)
    }

    /// `llvm.insertvalue` of `v` into `agg` at `pos`.
    pub fn insert_value(&mut self, agg: ValueId, v: ValueId, pos: &[i64]) -> ValueId {
        let ty = self.rw.body[agg].ty.clone();
        self.build(OpData::build("llvm.insertvalue").operands(&[agg, v]).with("position", Attribute::dense_i64(pos)), ty)
    }

    /// `llvm.mlir.poison : ty`.
    pub fn poison(&mut self, ty: Type<'a>) -> ValueId {
        self.build(OpData::build("llvm.mlir.poison"), ty)
    }

    /// `llvm.mlir.constant`.
    pub fn llvm_constant(&mut self, value: Attribute<'a>, ty: Type<'a>) -> ValueId {
        self.build(OpData::build("llvm.mlir.constant").with("value", value), ty)
    }

    /// `isUnsupportedFloatingPointType`: a float (element) type the converter does not keep a float.
    pub fn unsupported_float(&self, t: &Type<'a>) -> bool {
        let e = t.element_type();
        if !matches!(e, Type::Float(_)) {
            return false;
        }
        self.type_converter().and_then(|tc| tc.convert(e)).is_none_or(|c| !matches!(c, Type::Float(_)))
    }

    /// `FailOnUnsupportedFP`: whether an operand or result has an unsupported float type.
    pub fn unsupported_fp_op(&self, op: OpId) -> bool {
        let b = &*self.rw.body;
        b[op].operands.iter().chain(&b[op].results).any(|v| self.unsupported_float(&b[*v].ty))
    }

    /// `AttrConvertFastMathToLLVM`: `fastmath` becomes `fastmathFlags`.
    pub fn fastmath_to_llvm(attrs: &mut Vec<NamedAttr<'a>>) {
        if let Some(i) = attrs.iter().position(|a| a.name == "fastmath") {
            let a = attrs.remove(i);
            attrs.push(NamedAttr { name: "fastmathFlags".into(), value: Some(llvm_fastmath(a.value.as_ref())) });
        }
    }

    /// `AttrConvertOverflowToLLVM`: `overflowFlags` as the LLVM property.
    pub fn overflow_to_llvm(attrs: &mut Vec<NamedAttr<'a>>) {
        if let Some(i) = attrs.iter().position(|a| a.name == "overflowFlags") {
            let a = attrs.remove(i);
            attrs.push(NamedAttr { name: "overflowFlags".into(), value: Some(llvm_overflow(a.value.as_ref())) });
        }
    }

}

// ---- the passes ---------------------------------------------------------------------------












// ---- LLVM functions, globals and calls ----------------------------------------------------

impl<'a> ConversionRewriter<'_, 'a, '_> {
    /// The symbol table around `op` (`getParentWithTrait<SymbolTable>`): runtime functions
    /// are declared there.
    pub fn module_of(&self, op: OpId) -> Option<OpId> {
        let mut at = self.rw.body.parent_op(op);
        while let Some(o) = at {
            if self.rw.body.is_symbol_table(o) {
                return Some(o);
            }
            at = self.rw.body.parent_op(o);
        }
        None
    }

    /// `lookupOrCreateFn`: the `llvm.func` `name` of `module`, declared at its start if missing.
    pub fn llvm_func(&mut self, module: OpId, name: &str, params: Vec<Type<'a>>, ret: Type<'a>, vararg: bool) -> Option<OpId> {
        let fty: Type<'a> = LlvmType::Func { ret: ret.into(), params, vararg }.into();
        if let Some(f) = self.rw.body.lookup(module, name).filter(|f| self.rw.body[*f].name == "llvm.func") {
            return (self.rw.body[f].get("function_type") == Some(&Attribute::Type(fty))).then_some(f);
        }
        let saved = self.rw.ip;
        let block = self.rw.body.top_block(module);
        self.rw.set_start(block);
        let loc = self.rw.body[module].loc.clone();
        let data = OpData { loc, ..OpData::build("llvm.func").with("function_type", Attribute::Type(fty)).with("sym_name", Attribute::str(name)) };
        let f = self.rw.create_with(data, &[], |b, f| {
            b.add_region(f);
        });
        self.rw.ip = saved;
        Some(f)
    }

    /// `llvm.call @callee(args)`.
    pub fn llvm_call(&mut self, callee: &str, args: &[ValueId], results: &[Type<'a>]) -> OpId {
        let data = OpData::build("llvm.call").operands(args).with("callee", Attribute::SymbolRef(vec![Cow::Owned(String::from(callee))])).segments(&[args.len(), 0]);
        self.rw.create(data, results)
    }

    /// `ensureSymbolNameIsUnique` with the process-wide counter it keeps.
    fn unique_symbol(&self, module: OpId, base: &str, counter: &core::sync::atomic::AtomicU32) -> String {
        let mut name = String::from(base);
        while self.rw.body.lookup(module, &name).is_some() {
            name = format!("{base}_{}", counter.fetch_add(1, core::sync::atomic::Ordering::Relaxed));
        }
        name
    }

    /// `createPrintStrCall`: a private constant global holding `bytes` (NUL-terminated here),
    /// and a call of `runtime` (`printString` by default) on its address.
    pub fn print_str_call(&mut self, module: OpId, symbol: &str, bytes: &[u8], runtime: &str, counter: &core::sync::atomic::AtomicU32) -> Option<()> {
        let mut data: Vec<u8> = bytes.to_vec();
        data.push(0);
        let n = data.len();
        let arr = LlvmType::array(n as u64, Type::int(8));
        let tensor = Type::Shaped(Shaped { kind: ShapedKind::Tensor, shape: Some(vec![Dim::Static(n as i64)]), elem: Type::int(8).into(), extras: Vec::new() });
        let value = crate::Const { ty: tensor, values: data.iter().map(|b| crate::Scalar::Int(crate::ApInt::new(8, *b as i8 as i128))).collect(), elements: true };
        let name = self.unique_symbol(module, symbol, counter);
        let saved = self.rw.ip;
        let block = self.rw.body.top_block(module);
        self.rw.set_start(block);
        let loc = saved.and_then(|ip| ip.before).and_then(|o| self.rw.body[o].loc.clone());
        let g = OpData { loc, ..OpData::build("llvm.mlir.global").flag("constant").with("global_type", Attribute::Type(arr.clone())).with("linkage", Attribute::dialect("llvm.linkage", "<private>")).with("sym_name", Attribute::str(&name)).with("value", value.into()) };
        self.rw.create_with(g, &[], |b, g| {
            b.add_region(g);
        });
        self.rw.ip = saved;
        let addr = self.build(OpData::build("llvm.mlir.addressof").with("global_name", Attribute::SymbolRef(vec![Cow::Owned(name)])), LlvmType::ptr());
        let gep = self.build(OpData::build("llvm.getelementptr").operands(&[addr]).with("elem_type", Attribute::Type(arr)).with("rawConstantIndices", Attribute::DenseArray { ty: Type::int(32), values: vec![Cow::Borrowed("0")] }), LlvmType::ptr());
        self.llvm_func(module, runtime, vec![LlvmType::ptr()], LlvmType::void(), false)?;
        self.llvm_call(runtime, &[gep], &[]);
        Some(())
    }
}
